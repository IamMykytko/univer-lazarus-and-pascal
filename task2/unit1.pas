unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnD4: TButton;
    BtnD6: TButton;
    BtnD8: TButton;
    BtnD10: TButton;
    BtnD12: TButton;
    BtnD20: TButton;
    ImageList1: TImageList;
    ImgDice: TImage;
    LabelTitle: TLabel;
    LabelResult: TLabel;
    LabelDiceType: TLabel;
    LabelHistory: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure BtnD4Click(Sender: TObject);
    procedure BtnD6Click(Sender: TObject);
    procedure BtnD8Click(Sender: TObject);
    procedure BtnD10Click(Sender: TObject);
    procedure BtnD12Click(Sender: TObject);
    procedure BtnD20Click(Sender: TObject);
  private
    procedure RollDice(Sides: Integer; DiceName: string; ImageIndex: Integer);

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'D&D Dice Roller';
  LabelTitle.Caption := 'Dungeons & Dragons Dice Roller';
  LabelTitle.Font.Size := 18;
  LabelTitle.Font.Style := [fsBold];

  LabelResult.Font.Size := 80;
  LabelResult.Font.Color := clYellow;
  LabelResult.Alignment := taCenter;
  LabelResult.Caption := '\E2\88\92';

  LabelDiceType.Font.Size := 28;
  LabelDiceType.Alignment := taCenter;
  LabelDiceType.Caption := '';

  LabelHistory.Caption := 'Історія кидків: ';
  LabelHistory.Font.Style := [fsBold];

  ImgDice.Stretch := True;
  ImgDice.Proportional := True;
  ImgDice.Center := True;

  ImageList1.GetBitmap(5, ImgDice.Picture.Bitmap);
end;

procedure TForm1.RollDice(Sides: Integer; DiceName: string; ImageIndex: Integer);
var
  ResultNum: Integer;
begin
  Randomize;
  ResultNum := Random(Sides) + 1;

  LabelResult.Caption := IntToStr(ResultNum);
  LabelDiceType.Caption := DiceName;

  if ResultNum = Sides then
    LabelResult.Font.Color := clLime
  else if ResultNum = 1 then
    LabelResult.Font.Color := clRed
  else
    LabelResult.Font.Color := clYellow;

  ImageList1.GetBitmap(ImageIndex, ImgDice.Picture.Bitmap);

  LabelHistory.Caption := LabelHistory.Caption + #13#10 +
                          DiceName + ' \u2192 ' + IntToStr(ResultNum);

end;

procedure TForm1.BtnD4Click (Sender: TObject); begin RollDice(4,  'd4',  1); end;
procedure TForm1.BtnD6Click (Sender: TObject); begin RollDice(6,  'd6',  2); end;
procedure TForm1.BtnD8Click (Sender: TObject); begin RollDice(8,  'd8',  3); end;
procedure TForm1.BtnD10Click(Sender: TObject); begin RollDice(10, 'd10', 4); end;
procedure TForm1.BtnD12Click(Sender: TObject); begin RollDice(12, 'd12', 5); end;
procedure TForm1.BtnD20Click(Sender: TObject); begin RollDice(20, 'd20', 6); end;

end.

