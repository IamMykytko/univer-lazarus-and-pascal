unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonCalculate: TButton;
    EditAX: TEdit;
    EditAY: TEdit;
    EditBX: TEdit;
    EditBY: TEdit;
    GroupBoxA: TGroupBox;
    GroupBoxB: TGroupBox;
    LabelTitle: TLabel;
    LabelResult: TLabel;
    LabelDistanceA: TLabel;
    LabelDistanceB: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure ButtonCalculateClick(Sender: TObject);

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
     Caption := 'Лабораторна робота №3 - Варіант №10';

     LabelTitle.Caption := 'Визначення точки ближчої до початку координат';
     LabelTitle.Font.Size := 14;
     LabelTitle.Font.Style := [fsBold];
     LabelTitle.Alignment := taCenter;

     GroupBoxA.Caption := 'Точка A';
     EditAX.Text := 'X:';
     EditAY.Text := 'Y:';

     GroupBoxB.Caption := 'Точка B';
     EditBX.Text := 'X:';
     EditBY.Text := 'Y:';

     ButtonCalculate.Caption := 'Визначити ближчу точку';
     ButtonCalculate.Font.Size := 12;

     LabelResult.Font.Size := 16;
     LabelResult.Font.Style := [fsBold];
     LabelResult.Alignment := taCenter;
     LabelResult.Caption := '';

     LabelDistanceA.Font.Size := 12;
     LabelDistanceB.Font.Size := 12;
end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);

var
  AX, AY, BX, BY: Real;
  DistA, DistB: Real;
  CloserPoint: string;

begin
  try
    AX := StrToFloat(EditAX.Text);
    AY := StrToFloat(EditAY.Text);
    BX := StrToFloat(EditBX.Text);
    BY := StrToFloat(EditBY.Text);

    DistA := Sqrt(AX*AX + AY*AY);
    DistB := Sqrt(BX*BX + BY*BY);

    if DistA < DistB then
      CloserPoint := 'Точка A'
    else if DistB < DistA then
      CloserPoint := 'Точка B'
    else
      CloserPoint := 'Точка A і B знаходяться на однаковій відстані';

    LabelResult.Caption := CloserPoint;

    LabelDistanceA.Caption := Format('Відстань від точки A до (0,0): %.4f', [DistA]);
    LabelDistanceB.Caption := Format('Відстань від точки B до (0,0): %.4f', [DistB]);

    if DistA = DistB then
      LabelResult.Font.Color := clBlue
    else if CloserPoint = 'Точка A' then
      LabelResult.Font.Color := clGreen
    else
      LabelResult.Font.Color := clRed;

  except
    ShowMessage('Помилка введення! Введіть числові значення координат');
  end;
end;

end.

