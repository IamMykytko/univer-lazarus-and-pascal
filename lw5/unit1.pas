unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonDetermine: TButton;
    EditSymbol: TEdit;
    ImageList1: TImageList;
    ImageMoon: TImage;
    LabelTitle: TLabel;
    LabelInput: TLabel;
    LabelResult: TLabel;
    LabelDescription: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure ButtonDetermineClick(Sender: TObject);
    procedure EditSymbolKeyPress(Sender: TObject; var Key: char);

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
     Caption := 'Лабораторна робота №5 - Варіант №10';

     LabelTitle.Caption := 'Визначення фази Місяця';
     LabelTitle.Font.Size := 18;
     LabelTitle.Font.Style := [fsBold];
     LabelTitle.Alignment := taCenter;

     LabelInput.Caption := 'Введіть символ фази Місяця: ';
     LabelInput.Font.Size := 12;

     EditSymbol.Font.Size := 24;
     EditSymbol.MaxLength := 1;
     EditSymbol.Text := '';
     EditSymbol.Alignment := taCenter;

     ButtonDetermine.Caption := 'Визначити фазу';
     ButtonDetermine.Font.Size := 14;
     ButtonDetermine.Height := 50;

     LabelResult.Font.Size := 28;
     LabelResult.Font.Style := [fsBold];
     LabelResult.Alignment := taCenter;
     LabelResult.Caption := '';

     LabelDescription.Font.Size := 14;
     LabelDescription.Alignment := taCenter;
     LabelDescription.WordWrap := True;

     if Assigned(ImageMoon) then
     begin
       ImageMoon.Stretch := True;
       ImageMoon.Proportional := True;
       ImageMoon.Center := True;
       ImageMoon.Visible := False;
     end;
end;

procedure TForm1.ButtonDetermineClick(Sender: TObject);

var
  Symbol: Char;
  InputStr: string;
  ImageIndex: Integer;

begin
  if Trim(EditSymbol.Text) = '' then
  begin
    ShowMessage('Введіть символ фази Місяця!');
    EditSymbol.SetFocus;
    Exit;
  end;

  InputStr := Trim(UpperCase(EditSymbol.Text));
  if Length(InputStr) = 0 then Exit;

  Symbol := InputStr[1];
  ImageIndex := -1;

  case Symbol of
    ')': begin
           LabelResult.Caption := 'Зростаючий Місяць';
           LabelResult.Font.Color := clLime;
           LabelDescription.Caption := 'Місяць знаходиться у фазі зростання';
           ImageIndex := 0;
         end;

    '(': begin
           LabelResult.Caption := 'Старіючий Місяць';
           LabelResult.Font.Color := clSkyBlue;
           LabelDescription.Caption := 'Місяць знаходиться у фазі старіння';
           ImageIndex := 1;
         end;

    'O': begin
           LabelResult.Caption := 'Повня';
           LabelResult.Font.Color := clYellow;
           LabelDescription.Caption := 'Повний Місяць (повня)';
           ImageIndex := 2;
         end;

    'H': begin
           LabelResult.Caption := 'Молодик';
           LabelResult.Font.Color := clGray;
           LabelDescription.Caption := 'Новий Місяць (молодик)';
           ImageIndex := 3;
         end;

  else
    LabelResult.Caption := 'Невідома фаза';
    LabelResult.Font.Color := clRed;
    LabelDescription.Caption := 'Введений символ не відповідає жодній фазі Місяця';
    ImageIndex := -1;
  end;

  if (ImageIndex >= 0) and Assigned(ImageMoon) and Assigned(ImageList1) then
  begin
    ImageList1.GetBitmap(ImageIndex, ImageMoon.Picture.Bitmap);
    ImageMoon.Visible := True;
  end
  else if Assigned(ImageMoon) then
    ImageMoon.Visible := False;

end;

procedure TForm1.EditSymbolKeyPress(Sender: TObject; var Key: char);
begin
     if Key in ['a'..'z'] then
     Key := UpCase(Key);
end;

end.

