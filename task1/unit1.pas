unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    SpeedButton1: TSpeedButton;

    procedure BitBtn1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin

end;

procedure TForm1.FormClick(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  Caption := 'Самостійна робота №1 - Випадкове число';
  Label1.Caption := '???';
  Label1.Font.Size := 48;
  Label1.Font.Color := clBlue;
  Label1.Alignment := taCenter;
  Label1.AutoSize := False;
  Label1.Width := 200;
  Label1.Height := 80;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  RandomNum: Integer;
begin
  Randomize;
  RandomNum := Random(10) + 1;

  Label1.Caption := IntToStr(RandomNum);

  if RandomNum <= 3 then
    Label1.Font.Color := clRed
  else if RandomNum <= 7 then
    Label1.Font.Color := clGreen
  else
    Label1.Font.Color := clBlue;
end;

end.

