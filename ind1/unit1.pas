unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls;

type

  { TFormGame }

  TFormGame = class(TForm)
    ButtonFix: TButton;
    ButtonRoll: TButton;
    ImageDice1: TImage;
    ImageDice2: TImage;
    ImageDice3: TImage;
    ImageDice4: TImage;
    ImageDice5: TImage;
    ButtonNextPlayer: TButton;
    ComboBoxCombo: TComboBox;
    ImageListDice: TImageList;
    LabelTurn: TLabel;
    LabelTitle: TLabel;
    StringGridScore: TStringGrid;

    procedure FormCreate(Sender: TObject);
    procedure ButtonRollClick(Sender: TObject);
    procedure ButtonFixClick(Sender: TObject);
    procedure ButtonNextPlayerClick(Sender: TObject);
  private
    CurrentPlayer: Integer;
    Dice: array[1..5] of Integer;
    ScoreTable: array[1..4, 0..13] of Integer;
    Used: array[1..4, 0..13] of Boolean;

    procedure UpdateTurnLabel;
    procedure RollDice;
    procedure ShowDice;
    procedure InitScoreTable;
    procedure FillComboBox;
    procedure UpdateScoreTable;
  public
    PlayersCount: Integer;

  end;

var
  FormGame: TFormGame;

implementation

{$R *.lfm}

procedure TFormGame.FormCreate(Sender: TObject);
begin
  Caption := 'Яхта';

  LabelTitle.Caption := 'ЯХТА';
  LabelTitle.Font.Size := 28;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Alignment := taCenter;

  LabelTurn.Font.Size := 16;
  LabelTurn.Font.Style := [fsBold];

  ButtonRoll.Caption := 'Кинути кості';
  ButtonFix.Caption := 'Зафіксувати результат';
  ButtonNextPlayer.Caption := 'Наступний гравець';

  ButtonFix.Enabled := False;
  ButtonNextPlayer.Enabled := False;

  StringGridScore.ColCount := 5;
  StringGridScore.RowCount := 15;

  InitScoreTable;
  FillComboBox;

  PlayersCount := 2;
  CurrentPlayer := 1;
  UpdateTurnLabel;

  ImageListDice.Width := 80;
  ImageListDice.Height := 80;
end;

procedure TFormGame.InitScoreTable;
var
  i, j: Integer;
  Combos: array[0..13] of string = (
    'Одиниці', 'Двійки', 'Трійки', 'Четвірки', 'П''ятірки', 'Шістки',
    'Сет', 'Каре', 'Малий стріт', 'Великий стріт', 'Фул-Хаус',
    'Яхта', 'Шанс', 'Бонус'
  );
begin
  StringGridScore.Cells[0,0] := 'Комбінація';
  for j := 1 to 4 do
    StringGridScore.Cells[j,0] := 'Гравець ' + IntToStr(j);

  for i := 0 to 13 do
    StringGridScore.Cells[0, i+1] := Combos[i];

  for i := 1 to 4 do
    for j := 0 to 13 do
    begin
      ScoreTable[i,j] := 0;
      Used[i,j] := False;
    end;
end;

procedure TFormGame.FillComboBox;
begin
  ComboBoxCombo.Items.Clear;
  ComboBoxCombo.Items.Add('Одиниці');
  ComboBoxCombo.Items.Add('Двійки');
  ComboBoxCombo.Items.Add('Трійки');
  ComboBoxCombo.Items.Add('Четвірки');
  ComboBoxCombo.Items.Add('П''ятірки');
  ComboBoxCombo.Items.Add('Шістки');
  ComboBoxCombo.Items.Add('Сет');
  ComboBoxCombo.Items.Add('Каре');
  ComboBoxCombo.Items.Add('Малий стріт');
  ComboBoxCombo.Items.Add('Великий стріт');
  ComboBoxCombo.Items.Add('Фул-Хаус');
  ComboBoxCombo.Items.Add('Яхта');
  ComboBoxCombo.Items.Add('Шанс');
  ComboBoxCombo.ItemIndex := 0;
end;

procedure TFormGame.UpdateTurnLabel;
begin
  LabelTurn.Caption := 'Хід гравця: ' + IntToStr(CurrentPlayer);
end;

procedure TFormGame.RollDice;
var
  i: Integer;
begin
  Randomize;
  for i := 1 to 5 do
    Dice[i] := Random(6) + 1;

  ShowDice;
  Application.ProcessMessages;
end;

procedure TFormGame.ShowDice;
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    ImageDice1.Picture.Clear;
    ImageDice2.Picture.Clear;
    ImageDice3.Picture.Clear;
    ImageDice4.Picture.Clear;
    ImageDice5.Picture.Clear;

    if (Dice[1] >= 1) and (Dice[1] <= 6) then
    begin
      ImageListDice.GetBitmap(Dice[1]-1, Bmp);
      ImageDice1.Picture.Assign(Bmp);
    end;

    if (Dice[2] >= 1) and (Dice[2] <= 6) then
    begin
      ImageListDice.GetBitmap(Dice[2]-1, Bmp);
      ImageDice2.Picture.Assign(Bmp);
    end;

    if (Dice[3] >= 1) and (Dice[3] <= 6) then
    begin
      ImageListDice.GetBitmap(Dice[3]-1, Bmp);
      ImageDice3.Picture.Assign(Bmp);
    end;

    if (Dice[4] >= 1) and (Dice[4] <= 6) then
    begin
      ImageListDice.GetBitmap(Dice[4]-1, Bmp);
      ImageDice4.Picture.Assign(Bmp);
    end;

    if (Dice[5] >= 1) and (Dice[5] <= 6) then
    begin
      ImageListDice.GetBitmap(Dice[5]-1, Bmp);
      ImageDice5.Picture.Assign(Bmp);
    end;

  finally
    Bmp.Free;
  end;

  Application.ProcessMessages;
end;

procedure TFormGame.ButtonRollClick(Sender: TObject);
begin
  RollDice;
  ButtonFix.Enabled := True;
end;

procedure TFormGame.ButtonFixClick(Sender: TObject);
var
  ComboIdx: Integer;
begin
  ComboIdx := ComboBoxCombo.ItemIndex;

  if Used[CurrentPlayer, ComboIdx] then
  begin
    ShowMessage('Ця комбінація вже використана!');
    Exit;
  end;

  ScoreTable[CurrentPlayer, ComboIdx] := Dice[1] + Dice[2] + Dice[3] + Dice[4] + Dice[5];
  Used[CurrentPlayer, ComboIdx] := True;

  UpdateScoreTable();

  ButtonFix.Enabled := False;
  ButtonNextPlayer.Enabled := True;

  ShowMessage('Результат зафіксовано для гравця ' + IntToStr(CurrentPlayer));
end;

procedure TFormGame.UpdateScoreTable;
var
  i, j: Integer;
begin
  for i := 1 to 4 do
    for j := 0 to 13 do
      if Used[i,j] then
        StringGridScore.Cells[i, j+1] := IntToStr(ScoreTable[i,j])
      else
        StringGridScore.Cells[i, j+1] := '-';
end;

procedure TFormGame.ButtonNextPlayerClick(Sender: TObject);
begin
  CurrentPlayer := CurrentPlayer + 1;
  if CurrentPlayer > PlayersCount then
    CurrentPlayer := 1;

  UpdateTurnLabel;
  ButtonNextPlayer.Enabled := False;
  ButtonFix.Enabled := False;
  ComboBoxCombo.ItemIndex := 0;
end;

end.
