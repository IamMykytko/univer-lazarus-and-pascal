unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonCalculate: TButton;
    ButtonClear: TButton;
    EditN: TEdit;
    LabelTitle: TLabel;
    LabelN: TLabel;
    MemoResult: TMemo;
    RadioGroupCycle: TRadioGroup;

    procedure FormCreate(Sender: TObject);
    procedure ButtonCalculateClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
  private
    procedure FibonacciFor(n: Integer);
    procedure FibonacciWhile(n: Integer);
    procedure FibonacciRepeat(n: Integer);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Лабораторна №6 - Варіант №10';

  LabelTitle.Caption := 'Ряд Фібоначчі (N перших членів)';
  LabelTitle.Font.Size := 16;
  LabelTitle.Font.Style := [fsBold];

  LabelN.Caption := 'Введіть кількість членів ряду N: ';
  EditN.Font.Size := 14;

  RadioGroupCycle.Caption := 'Виберіть тип циклу:';
  RadioGroupCycle.Items.Add('for');
  RadioGroupCycle.Items.Add('while');
  RadioGroupCycle.Items.Add('repeat ... until');
  RadioGroupCycle.ItemIndex := 0;   // за замовчуванням for

  ButtonCalculate.Caption := 'Обчислити ряд Фібоначчі';
  ButtonCalculate.Font.Size := 13;

  ButtonClear.Caption := 'Очистити';

  MemoResult.Font.Size := 12;
  MemoResult.ScrollBars := ssVertical;
  MemoResult.ReadOnly := True;
end;

procedure TForm1.FibonacciFor(n: Integer);
var
  i, prev, curr, term: Integer;
  s: string;
begin
  MemoResult.Lines.Clear;
  MemoResult.Lines.Add('Ряд Фібоначчі (' + IntToStr(n) + '  членів) - цикл for:');

  if n < 1 then Exit;

  prev := 1;
  curr := 1;

  s := '1';
  if n >= 2 then s := s + ', 1';

  MemoResult.Lines.Add(s);

  for i := 3 to n do
  begin
    term := prev + curr;
    prev := curr;
    curr := term;
    MemoResult.Lines[MemoResult.Lines.Count-1] :=
      MemoResult.Lines[MemoResult.Lines.Count-1] + ', ' + IntToStr(term);
  end;
end;

procedure TForm1.FibonacciWhile(n: Integer);
var
  i, prev, curr, term: Integer;
  s: string;
begin
  MemoResult.Lines.Clear;
  MemoResult.Lines.Add('Ряд Фібоначчі (' + IntToStr(n) + ' членів) - цикл while:');

  if n < 1 then Exit;

  prev := 1;
  curr := 1;

  i := 1;
  s := '';

  while i <= n do
  begin
    if i = 1 then s := '1'
    else if i = 2 then s := s + ', 1'
    else
    begin
      term := prev + curr;
      prev := curr;
      curr := term;
      s := s + ', ' + IntToStr(term);
    end;
    Inc(i);
  end;

  MemoResult.Lines.Add(s);
end;

procedure TForm1.FibonacciRepeat(n: Integer);
var
  i, prev, curr, term: Integer;
  s: string;
begin
  MemoResult.Lines.Clear;
  MemoResult.Lines.Add('Ряд Фібоначчі (' + IntToStr(n) + ' членів) - цикл repeat...until:');

  if n < 1 then Exit;

  prev := 1;
  curr := 1;

  i := 1;
  s := '';

  repeat
    if i = 1 then s := '1'
    else if i = 2 then s := s + ', 1'
    else
    begin
      term := prev + curr;
      prev := curr;
      curr := term;
      s := s + ', ' + IntToStr(term);
    end;
    Inc(i);
  until i > n;

  MemoResult.Lines.Add(s);
end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  n: Integer;
begin
  try
    n := StrToInt(EditN.Text);

    if n < 1 then
    begin
      ShowMessage('N має бути натуральним числом (>=1)');
      Exit;
    end;

    case RadioGroupCycle.ItemIndex of
      0: FibonacciFor(n);
      1: FibonacciWhile(n);
      2: FibonacciRepeat(n);
    end;

  except
    ShowMessage('Введіть конкретне число!');
  end;
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  MemoResult.Lines.Clear;
end;

end.

