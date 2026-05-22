unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;

    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);

    procedure Button1Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  S_hex, R, S_circle: Real;
begin
  try
    S_hex := StrToFloat(Edit1.Text);

    if S_hex <= 0 then
    begin
      ShowMessage('Помилка: площа шестикутника повинна бути більше 0!');
      Exit;
    end;

    R := Sqrt(S_hex / (2 * Sqrt(3)));
    S_circle := Pi * R * R;

    Edit2.Text := Format('%.4f', [S_circle]);
    Label3.Caption := 'Радіус вписаного кола R = ' + Format('%.6f', [R]);

    Edit1.SetFocus;
    ShowMessage('Обчислення виконано успішко!');

  except
    ShowMessage('Помилка! Введіть правильне значення.');
  end;
end;

{ TForm1 }

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Image1Click(Sender: TObject);
begin

    Image1.Picture.LoadFromFile('./arch-user-btw.png');
end;

end.

