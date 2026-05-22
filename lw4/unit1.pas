unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonDetermine: TButton;
    EditLength: TEdit;
    EditNorm1: TEdit;
    EditNorm2: TEdit;
    LabelLength: TLabel;
    LabelNorm1: TLabel;
    LabelNorm2: TLabel;
    LabelTitle: TLabel;
    LabelCategory: TLabel;
    LabelInfo: TLabel;
    PanelResult: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure ButtonDetermineClick(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Лабораторна робота №4 - Варіант №10';

  LabelTitle.Caption := 'Сортування листа листопрокатного стана';
  LabelTitle.Font.Size := 16;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Alignment := taCenter;

  LabelLength.Caption := 'Довжина листа (мм):';
  LabelNorm1.Caption := 'Перша норма (мм):';
  LabelNorm2.Caption := 'Друга норма (мм):';

  EditLength.Font.Size := 14;
  EditNorm1.Font.Size := 14;
  EditNorm2.Font.Size := 14;

  ButtonDetermine.Caption := 'Визначити категорію';
  ButtonDetermine.Font.Size := 13;
  ButtonDetermine.Height := 55;

  PanelResult.BevelOuter := bvRaised;
  PanelResult.Color := clInfoBk;

  LabelCategory.Font.Size := 24;
  LabelCategory.Font.Style := [fsBold];
  LabelCategory.Alignment := taCenter;

  LabelInfo.Font.Size := 12;
  LabelInfo.Alignment := taCenter;
  LabelInfo.Caption := '';
end;

procedure TForm1.ButtonDetermineClick(Sender: TObject);
var
  LengthSheet, Norm1, Norm2: Real;
  Category: Integer;
begin
  try
    LengthSheet := StrToFloat(EditLength.Text);
    Norm1 := StrToFloat(EditNorm1.Text);
    Norm2 := StrToFloat(EditNorm2.Text);

    if (Norm1 <= 0) or (Norm2 <= 0) or (Norm1 > Norm2) then
    begin
      ShowMessage('Помилка: Перша норма повинна бути меншою за другу норму, і обидва мають бути додатними.');
      Exit;
    end;

    if LengthSheet <= 0 then
    begin
      ShowMessage('Помилка: Довжина листа повинна бути додатною.');
      Exit;
    end;

    if LengthSheet < Norm1 then
      Category := 1
    else if (LengthSheet >= Norm1) and (LengthSheet <= Norm2) then
      Category := 2
    else
      Category := 3;

    case Category of
      1: begin
           LabelCategory.Caption := '1 КАТЕГОРІЯ';
           LabelCategory.Font.Color := clGreen;
           LabelInfo.Caption := 'Лист віднесено до першої категорії розміру';
         end;
      2: begin
           LabelCategory.Caption := '2 КАТЕГОРІЯ';
           LabelCategory.Font.Color := clBlue;
           LabelInfo.Caption := 'Лист віднесено до другої категорії розміру';
         end;
      3: begin
           LabelCategory.Caption := '3 КАТЕГОРІЯ';
           LabelCategory.Font.Color := clRed;
           LabelInfo.Caption := 'Лист віднесено до третьої категорії розміру';
         end;
    end;

  except
    ShowMessage('Помилкові введення! Введіть числові значення.');
  end;

end;

end.

