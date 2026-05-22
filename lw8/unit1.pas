unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonClear: TButton;
    ButtonGenerate: TButton;
    ButtonCalculate: TButton;
    EditN: TEdit;
    LabelN: TLabel;
    LabelTitle: TLabel;
    MemoResult: TMemo;
    StringGrid1: TStringGrid;

    procedure FormCreate(Sender: TObject);
    procedure ButtonGenerateClick(Sender: TObject);
    procedure ButtonCalculateClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
  private
    procedure ShowArray;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Лабораторна робота №8 - Варіант №10';

  LabelTitle.Caption := 'Обробка послідовності: множення парних елементів перед першим максимумом';
  LabelTitle.Font.Size := 13;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.WordWrap := True;

  LabelN.Caption := 'Кількість елементів N:';
  EditN.Text := '10';

  ButtonGenerate.Caption := 'Згенерувати випадкові числа';
  ButtonCalculate.Caption := 'Виконати обробку';
  ButtonClear.Caption := 'Очистити';

  StringGrid1.ColCount := 2;
  StringGrid1.Cells[0,0] := 'Індекс';
  StringGrid1.Cells[1,0] := 'Значення';
  StringGrid1.ColWidths[0] := 60;
  StringGrid1.ColWidths[1] := 120;

  MemoResult.ScrollBars := ssVertical;
  MemoResult.ReadOnly := True;
end;

procedure TForm1.ShowArray;
var
  i: Integer;
begin
  for i := 1 to StringGrid1.RowCount-1 do
  begin
    StringGrid1.Cells[0,i] := IntToStr(i);
  end;
end;

procedure TForm1.ButtonGenerateClick(Sender: TObject);
var
  n, i: Integer;
begin
  try
    n := StrToInt(EditN.Text);
    if n < 1 then
    begin
      ShowMessage('N має бути > 0');
      Exit;
    end;

    StringGrid1.RowCount := n + 1;

    Randomize;
    for i := 1 to n do
      StringGrid1.Cells[1, i] := FormatFloat('0.00', -50 + Random(101)); // діапазон від -50 до +50

    ShowArray;
    MemoResult.Lines.Clear;

  except
    ShowMessage('Введіть коректне число N');
  end;
end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  n, i, MaxIndex: Integer;
  MaxValue: Real;
  Arr: array of Real;
begin
  try
    n := StringGrid1.RowCount - 1;
    if n < 2 then
    begin
      ShowMessage('Масив повинен мати хоча б 2 елементи!');
      Exit;
    end;

    SetLength(Arr, n+1);

    // Зчитуємо масив
    for i := 1 to n do
      Arr[i] := StrToFloat(StringGrid1.Cells[1, i]);

    // Знаходимо перший максимальний елемент
    MaxValue := Arr[1];
    MaxIndex := 1;

    for i := 2 to n do
    begin
      if Arr[i] > MaxValue then
      begin
        MaxValue := Arr[i];
        MaxIndex := i;
      end;
    end;

    // Множимо елементи з парними індексами, що передують MaxIndex
    i := 2;
    while i < MaxIndex do
    begin
      Arr[i] := Arr[i] * MaxValue;
      i := i + 2;
    end;

    // Виводимо результат назад у таблицю
    for i := 1 to n do
      StringGrid1.Cells[1, i] := FormatFloat('0.00', Arr[i]);

    // Вивід у Memo
    MemoResult.Lines.Clear;
    MemoResult.Lines.Add('=== РЕЗУЛЬТАТ ОБРОБКИ ===');
    MemoResult.Lines.Add(Format('Перший максимальний елемент: %.2f (індекс %d)', [MaxValue, MaxIndex]));
    MemoResult.Lines.Add('Парні індекси перед максимумом були помножені на цей максимум.');
    MemoResult.Lines.Add('');
    MemoResult.Lines.Add('Оновлений масив:');

    for i := 1 to n do
      MemoResult.Lines.Add(Format('  %2d:  %10.4f', [i, Arr[i]]));

  except
    ShowMessage('Помилка при обробці даних. Перевірте введені значення');
  end;
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  MemoResult.Lines.Clear;
  StringGrid1.RowCount := 1;
end;

end.

