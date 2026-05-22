unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    LabelTitle: TLabel;
    LabelK: TLabel;
    EditK: TEdit;
    ButtonGenerate: TButton;
    ButtonCalculate: TButton;
    ButtonClear: TButton;
    StringGrid1: TStringGrid;
    MemoResult: TMemo;

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
  Caption := 'Лабораторна №9 - Варіант №10';

  LabelTitle.Caption := 'Підрахунок пар сусідніх елементів з різними знаками';
  LabelTitle.Font.Size := 14;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.WordWrap := True;

  LabelK.Caption := 'Кількість елементів К:';
  EditK.Text := '15';
  EditK.Font.Size := 14;

  ButtonGenerate.Caption := 'Згенерувати випадковий масив';
  ButtonCalculate.Caption := 'Підрахувати пари з різними знаками';
  ButtonClear.Caption := 'Очистити';

  StringGrid1.ColCount := 2;
  StringGrid1.Cells[0,0] := 'Індекс';
  StringGrid1.Cells[1,0] := 'Значення';
  StringGrid1.ColWidths[0] := 70;
  StringGrid1.ColWidths[1] := 140;

  MemoResult.ScrollBars := ssVertical;
  MemoResult.ReadOnly := True;
  MemoResult.Font.Size := 11;
end;

procedure TForm1.ShowArray;
var
  i: Integer;
begin
  for i := 1 to StringGrid1.RowCount-1 do
    StringGrid1.Cells[0,i] := IntToStr(i);
end;

procedure TForm1.ButtonGenerateClick(Sender: TObject);
var
  k, i: Integer;
begin
  try
    k := StrToInt(EditK.Text);
    if k < 2 then
    begin
      ShowMessage('Кількість елементів повинна бути не менше 2');
      Exit;
    end;

    StringGrid1.RowCount := k + 1;
    Randomize;

    for i := 1 to k do
      StringGrid1.Cells[1, i] := FormatFloat('0.00', -50 + Random(101));

    ShowArray;
    MemoResult.Lines.Clear;
    MemoResult.Lines.Add('Масив згенеровано успішно.');

  except
    ShowMessage('Введіть коректне число К');
  end;
end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  k, i, Count: Integer;
  Arr: array of Real;
begin
  try
    k := StringGrid1.RowCount - 1;
    if k < 2 then
    begin
      ShowMessage('Спочатку згенеруйте масив з хоча б 2 елементами!');
      Exit;
    end;

    SetLength(Arr, k+1);
    for i := 1 to k do
      Arr[i] := StrToFloat(StringGrid1.Cells[1, i]);

    Count := 0;

    for i := 1 to k-1 do
    begin
      if (Arr[i] * Arr[i+1] < 0) then
        Inc(Count);
    end;

    MemoResult.Lines.Clear;
    MemoResult.Lines.Add('=== РЕЗУЛЬТАТ ===');
    MemoResult.Lines.Add(Format('Кількість елементів: %d', [k]));
    MemoResult.Lines.Add(Format('Знайдено пар з різними знаками: %d', [Count]));

    if Count > 0 then
    begin
      MemoResult.Lines.Add('');
      MemoResult.Lines.Add('Пари з різними знаками:');
      for i := 1 to k-1 do
        if (Arr[i] * Arr[i+1] < 0) then
          MemoResult.Lines.Add(Format('  Позиції %d і %d -> %.2f і %.2f',
            [i, i+1, Arr[i], Arr[i+1]]));
    end
    else
      MemoResult.Lines.Add('  Пар з різними знаками не знайдено.');

  except
    ShowMessage('Помилка при обробці даних.');
  end;
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  MemoResult.Lines.Clear;
  StringGrid1.RowCount := 1;
end;

end.
