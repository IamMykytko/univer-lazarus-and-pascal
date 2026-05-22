unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    ButtonStart: TButton;
    ComboPlayers: TComboBox;
    LabelPlayers: TLabel;
    LabelTitle: TLabel;

    procedure ButtonStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonRollClick(Sender: TObject);
    procedure ButtonFixClick(Sender: TObject);
    procedure ButtonNextPlayerClick(Sender: TObject);
  private
    CurrentPlayer: Integer;
    Dice: array[1..5] of Integer;
  public
    PlayersCount: Integer;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

uses Unit1;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Caption := 'Яхта - Головне меню';
  LabelTitle.Caption := 'ЯХТА';
  LabelTitle.Font.Size := 28;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Alignment := taCenter;

  LabelPlayers.Caption := 'Оберіть кількість гравців:';
  LabelPlayers.Font.Size := 14;

  ComboPlayers.Items.Add('2 гравці');
  ComboPlayers.Items.Add('3 гравці');
  ComboPlayers.Items.Add('4 гравці');
  ComboPlayers.ItemIndex := 0;

  ButtonStart.Caption := 'Почати гру';
  ButtonStart.Font.Size := 14;
end;

procedure TFormMain.ButtonRollClick(Sender: TObject);
begin

end;

procedure TFormMain.ButtonFixClick(Sender: TObject);
begin

end;

procedure TFormMain.ButtonNextPlayerClick(Sender: TObject);
begin

end;

procedure TFormMain.ButtonStartClick(Sender: TObject);
var
  NumPlayers: Integer;
  GameForm: TFormGame;
begin
  case ComboPlayers.ItemIndex of
    0: NumPlayers := 2;
    1: NumPlayers := 3;
    2: NumPlayers := 4;
  else
    NumPlayers := 2;
  end;

  GameForm := TFormGame.Create(nil);
  try
    GameForm.PlayersCount := NumPlayers;
    GameForm.ShowModal;
  finally
    GameForm.Free;
  end;
end;

end.
