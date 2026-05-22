unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ImgList;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonOpen: TButton;
    ImageLoot: TImage;
    ImageList1: TImageList;
    LabelRarity: TLabel;
    LabelTitle: TLabel;
    MemoHistory: TMemo;

    procedure FormCreate(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);

  private
    procedure OpenLoot;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := 'Рідкісний лут';

  LabelTitle.Caption := 'Система випадання лута';
  LabelTitle.Font.Size := 18;
  LabelTitle.Font.Style := [fsBold];

  ButtonOpen.Caption := 'Відкрити лут';
  ButtonOpen.Font.Size := 14;
  ButtonOpen.Height := 60;

  LabelRarity.Font.Size := 32;
  LabelRarity.Font.Style := [fsBold];
  LabelRarity.Alignment := taCenter;

  ImageLoot.Stretch := True;
  ImageLoot.Proportional := True;
  ImageLoot.Center := True;

  MemoHistory.ScrollBars := ssVertical;
  MemoHistory.ReadOnly := True;
  MemoHistory.Lines.Clear;
  MemoHistory.Lines.Add('=== Історія лута ===');

  ImageList1.GetBitmap(0, ImageLoot.Picture.Bitmap);
  LabelRarity.Caption := 'Чекаємо на лут...';
  LabelRarity.Font.Color := clGray;
end;

procedure TForm1.OpenLoot;
var
  Rand: Integer;
  Rarity: string;
  Index: Integer;
begin
  Randomize;
  Rand := Random(100);

  if Rand < 50 then
  begin
    Rarity := 'Звичайний';
    Index := 0;
    LabelRarity.Font.Color := clWhite;
  end
  else if Rand < 80 then
  begin
    Rarity := 'Рідкісний';
    Index := 1;
    LabelRarity.Font.Color := clAqua;
  end
  else
  begin
    Rarity := 'ЛЕГЕНДАРНИЙ!';
    Index := 2;
    LabelRarity.Font.Color := clLime;
  end;

  LabelRarity.Caption := Rarity;

  ImageList1.GetBitmap(Index, ImageLoot.Picture.Bitmap);

  MemoHistory.Lines.Add(FormatDateTime('hh:nn:ss', Now) + ' \u2192 ' + Rarity);

  if MemoHistory.Lines.Count > 11 then
    MemoHistory.Lines.Delete(1);
end;

procedure TForm1.ButtonOpenClick(Sender: TObject);
begin
  OpenLoot;
end;

end.

