unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  // Ініціалізація елементів форми

  TForm1 = class(TForm)
    ButtonCalculate: TButton;
    EditNumber: TEdit;
    LabelTitle: TLabel;
    LabelInput: TLabel;
    LabelResult: TLabel;
    LabelDigits: TLabel;
    PanelResult: TPanel;

    // Оголошення процедур

    procedure EditNumberChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCalculateClick(Sender: TObject);
    procedure EditNumberKeyPress(Sender: TObject; var Key: char);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.EditNumberChange(Sender: TObject);
begin

end;

// Процедура створення форми та надання основних властивостей елементів за замовчуванням

procedure TForm1.FormCreate(Sender: TObject);
begin

  Caption := 'Лабораторна робота №2 - Варіант 10';

  LabelTitle.Caption := 'Обчислення середніх арифметичних цифр чотирьохзначного числа';
  LabelTitle.Font.Size := 14;
  LabelTitle.Font.Style := [fsBold];
  LabelTitle.Alignment := taCenter;

  LabelInput.Caption := 'Введіть натуральне чотирьохзначне число (1000-9999): ';
  LabelInput.Font.Size := 12;

  EditNumber.Font.Size := 16;
  EditNumber.Text := '';
  EditNumber.MaxLength := 4;

  ButtonCalculate.Caption := 'Обчислити';
  ButtonCalculate.Font.Size := 12;
  ButtonCalculate.Height := 50;

  LabelResult.Font.Size := 16;
  LabelResult.Font.Style := [fsBold];
  LabelResult.Alignment := taCenter;

  LabelDigits.Font.Size := 16;
  LabelDigits.Alignment := taCenter;

  PanelResult.Caption := '';
  PanelResult.BevelOuter := bvRaised;
  PanelResult.Color := clInfoBk;

end;

// Процедура перевірки вводу елементів у поле. Ця процедура унеможливлює додання спец-символів чи тексту

procedure TForm1.EditNumberKeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

// Процедура розрахування обчислення введених чисел

procedure TForm1.ButtonCalculateClick(Sender: TObject);

var
  Number, a, b, c, d: Integer;
  Sum: Integer;
  Average: Real;

begin

  // Перевіряємо код на помилки за допомогою конструкції try except

  try
     //Конвертуємо ввід з EditLabel (який за замовчуванням string) у Integer
     Number := StrToInt(EditNumber.Text);

     // Перевірка вводу за допомогою умовного конструктора if then на відповідність умовам нашої задачі
     // Якщо число менше за 1000 чи більше за 9999, то код видасть помилку невиконанння
     if (Number < 1000) or (Number > 9999) then
     begin
       ShowMessage('Помилка! Число має бути чотирьохзначним (1000-9999)');
     end;

     // Переробляємо введені числа на окремі незалежні цифри
     // div - це ділення, mod - це ділення з прибиранням залишку (щоб залишити цілий integer без дробової частки)
     a := Number div 1000;
     b := (Number div 100) mod 10;
     c := (Number div 10) mod 10;
     d := Number mod 10;

     // Результат суми і розрахунок середнього арифметичного
     Sum := a + b + c + d;
     Average := Sum / 4;

     // Вивід результатів у лейбли
     LabelDigits.Caption := Format('Цифри числа: %d, %d, %d, %d', [a, b, c, d]);
     LabelResult.Caption := Format('Середнє арифметичне = %.3f', [Average]);

     PanelResult.Caption := 'Результат обчислення';


  // Відображення віконця, що виводе помилку введення числа від користувача
  except
        ShowMessage('Помилка введення! Введіть коректне чотирьохзначне число.');
        EditNumber.SetFocus;
  end;
end;

end.

