unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonCalculate: TButton;
    EditX: TEdit;
    EditE: TEdit;
    LabelTitle: TLabel;
    LabelX: TLabel;
    LabelE: TLabel;
    MemoResult: TMemo;

    procedure FormCreate(Sender: TObject);
    procedure ButtonCalculateClick(Sender: TObject);
  private
    function Factorial(n: Integer): Real;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function TForm1.Factorial(n: Integer): Real;
var
  i: Integer;
  res: Real;
begin
  res := 1.0;
  for i := 2 to n do
    res := res * i;
  Result := res;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Лабораторна робота №7 - Варіант №10';

  LabelTitle.Caption := 'Обчислення суми знакопереміжного ряду з заданою точністю E';
  LabelTitle.Font.Size := 14;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Alignment := taCenter;

  LabelX.Caption := 'Введіть значення X:';
  LabelE.Caption := 'Введіть точність E (наприклад, 0.0005)';

  EditX.Font.Size := 14;
  EditE.Font.Size := 14;
  EditX.Text := '1.0';
  EditE.Text := '0.0005';

  ButtonCalculate.Caption := 'Обчислити суму ряду';
  ButtonCalculate.Font.Size := 13;

  MemoResult.Font.Size := 11;
  MemoResult.ScrollBars := ssVertical;
  MemoResult.ReadOnly := True;
end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  X, E, Sum, Term, PrevTerm, Diff: Real;
  n: Integer;
  Sign: Integer;
begin
  try
    X := StrToFloat(EditX.Text);
    E := StrToFloat(EditE.Text);

    if E <= 0 then
    begin
      ShowMessage('Точність E повинна бути додатньою!');
      Exit;
    end;

    MemoResult.Lines.Clear;
    MemoResult.Lines.Add('X = ' + FloatToStr(X));
    MemoResult.Lines.Add('E = ' + FloatToStr(E));
    MemoResult.Lines.Add('-----------------------------------');

    Sum := 0.0;
    Term := X; // перший член - X
    n := 1;
    Sign := 1; // знак для першого члена "+"

    MemoResult.Lines.Add(Format('n=%d | Член = %.10f | Сума = %.10f', [n, Term, Sum + Term]));

    Sum := Sum + Term;
    PrevTerm := Term;

    while True do
    begin
      n := n + 1;
      Sign := -Sign; // зміна знаку
      Term := Sign * (Power(X, n) / Factorial(n));

      Diff := Abs(Term - PrevTerm);

      MemoResult.Lines.Add(Format('n=%d | Член = %.10f | Різниця = %.10f | Сума = %.10f', [n, Term, Diff, Sum + Term]));

      Sum := Sum + Term;

      if Diff < E then
        Break;

      PrevTerm := Term;

      // Обмеження від надто великої кількості ітерацій (захист)
      if n > 100 then
      begin
        MemoResult.Lines.Add('Досягнуто максимум кількості ітерацій (100)');
        Break;
      end;
    end;

    MemoResult.Lines.Add('-----------------------------------');
    MemoResult.Lines.Add(Format('Сума ряду (приблизно) = %.10f', [Sum]));
    MemoResult.Lines.Add(Format('Кількість членів ряду: %d', [n]));

  except
    ShowMessage('Помилка введення! Перевірте значення X та E.');
  end;
end;

end.

