unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls;

type
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
    CheckDice1: TCheckBox;
    CheckDice2: TCheckBox;
    CheckDice3: TCheckBox;
    CheckDice4: TCheckBox;
    CheckDice5: TCheckBox;
    LabelRolls: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure ButtonRollClick(Sender: TObject);
    procedure ButtonFixClick(Sender: TObject);
    procedure ButtonNextPlayerClick(Sender: TObject);
  private
    CurrentPlayer: Integer;
    RollsLeft: Integer;
    Dice: array[1..5] of Integer;
    ScoreTable: array[1..4, 0..13] of Integer;
    Used: array[1..4, 0..13] of Boolean;

    procedure UpdateTurnLabel;
    procedure RollSelectedDice;
    procedure ShowDice;
    procedure InitScoreTable;
    procedure FillComboBox;
    procedure UpdateScoreTable;
    procedure ResetRollState;
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
  ResetRollState;
  UpdateTurnLabel;

  ImageListDice.Width := 80;
  ImageListDice.Height := 80;
end;

procedure TFormGame.ResetRollState;
begin
  RollsLeft := 3;
  LabelRolls.Caption := 'Кидків залишилось: 3';
  CheckDice1.Checked := False;
  CheckDice2.Checked := False;
  CheckDice3.Checked := False;
  CheckDice4.Checked := False;
  CheckDice5.Checked := False;
  ButtonRoll.Enabled := True;
end;

procedure TFormGame.RollSelectedDice;
var
  i: Integer;
begin
  Randomize;
  for i := 1 to 5 do
    if (RollsLeft = 3) or TCheckBox(FindComponent('CheckDice'+IntToStr(i))).Checked then
      Dice[i] := Random(6) + 1;

  ShowDice;
  Dec(RollsLeft);
  LabelRolls.Caption := 'Кидків залишилось: ' + IntToStr(RollsLeft);

  if RollsLeft = 0 then
    ButtonRoll.Enabled := False;
end;

procedure TFormGame.ShowDice;
begin
  ImageListDice.GetBitmap(Dice[1]-1, ImageDice1.Picture.Bitmap);
  ImageListDice.GetBitmap(Dice[2]-1, ImageDice2.Picture.Bitmap);
  ImageListDice.GetBitmap(Dice[3]-1, ImageDice3.Picture.Bitmap);
  ImageListDice.GetBitmap(Dice[4]-1, ImageDice4.Picture.Bitmap);
  ImageListDice.GetBitmap(Dice[5]-1, ImageDice5.Picture.Bitmap);
end;

procedure TFormGame.ButtonRollClick(Sender: TObject);
begin
  RollSelectedDice;
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
  ButtonRoll.Enabled := False;

  ShowMessage('Результат зафіксована для гравця ' + IntToStr(CurrentPlayer));
end;

procedure TFormGame.ButtonNextPlayerClick(Sender: TObject);
begin
  CurrentPlayer := CurrentPlayer + 1;
  if CurrentPlayer > PlayersCount then
    CurrentPlayer := 1;

  UpdateTurnLabel;
  ResetRollState;
  ButtonNextPlayer.Enabled := False;
  ButtonFix.Enabled := False;
  ComboBoxCombo.ItemIndex := 0;
end;

procedure TFormGame.InitScoreTable;
var
  i, j: Integer;
  Combos: array[0..13] of string = (
    'Одиниці', 'Двійки', 'Трійки', 'Четвірки', 'П''ятірки', 'Шістки',
    'Сет', 'Каре', 'Малий стріт', 'Великий стріт', 'Фул-хаус',
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

end.
