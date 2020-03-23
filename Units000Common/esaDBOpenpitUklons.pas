unit esaDBOpenpitUklons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Globals, Menus;

type
  ResaBlockUklon=record
    p0       : RPoint3D;
    p1       : RPoint3D;
    Lm       : Single;  //Длина, м
    Hm       : Single;  //Высота, м
    Lx       : Single;  //Длина проекции, м
    Uprommile: Single;  //Уклон
  end;{ResaBlockUklon}
  TesaBlockUklons = array of ResaBlockUklon;
  TfmOpenpitUklons = class(TForm)
    StringGrid: TStringGrid;
    pmUklons: TPopupMenu;
    pmiUklonsExcel: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pmUklonsPopup(Sender: TObject);
    procedure pmiUklonsExcelClick(Sender: TObject);
  private
    FUklons: TesaBlockUklons;
    FCount : Integer;
  public
    property Count: Integer read FCount;
  end;{TfmOpenpitUklons}

var
  fmOpenpitUklons: TfmOpenpitUklons;

//Диалоговое окно уклонов
procedure esaShowOpenpitUklonsDlg(const AUklons: TesaBlockUklons);
implementation

{$R *.dfm}
uses Math, esaExcelEditors;

//Диалоговое окно уклонов
procedure esaShowOpenpitUklonsDlg(const AUklons: TesaBlockUklons);
var I: Integer;
begin
  fmOpenpitUklons := TfmOpenpitUklons.Create(nil);
  try
    fmOpenpitUklons.FCount := Length(AUklons);
    fmOpenpitUklons.StringGrid.RowCount := 1+Max(0,fmOpenpitUklons.Count);
    fmOpenpitUklons.FUklons := Copy(AUklons);
    for I := 0 to fmOpenpitUklons.Count-1 do
    begin
      fmOpenpitUklons.StringGrid.Cells[ 0,I+1] := IntToStr(I+1);
      fmOpenpitUklons.StringGrid.Cells[ 1,I+1] := FormatFloat('0.0',AUklons[I].Lm);
      fmOpenpitUklons.StringGrid.Cells[ 2,I+1] := FormatFloat('0.0',AUklons[I].Lx);
      fmOpenpitUklons.StringGrid.Cells[ 3,I+1] := FormatFloat('0.0',AUklons[I].Hm);
      fmOpenpitUklons.StringGrid.Cells[ 4,I+1] := FormatFloat('0.0',AUklons[I].Uprommile);
      fmOpenpitUklons.StringGrid.Cells[ 5,I+1] := FormatFloat('0.0',AUklons[I].p0.X);
      fmOpenpitUklons.StringGrid.Cells[ 6,I+1] := FormatFloat('0.0',AUklons[I].p0.Y);
      fmOpenpitUklons.StringGrid.Cells[ 7,I+1] := FormatFloat('0.0',AUklons[I].p0.Z);
      fmOpenpitUklons.StringGrid.Cells[ 8,I+1] := FormatFloat('0.0',AUklons[I].p1.X);
      fmOpenpitUklons.StringGrid.Cells[ 9,I+1] := FormatFloat('0.0',AUklons[I].p1.Y);
      fmOpenpitUklons.StringGrid.Cells[10,I+1] := FormatFloat('0.0',AUklons[I].p1.Z);
    end;{for}
    fmOpenpitUklons.ShowModal;
  finally
    fmOpenpitUklons.Free;
  end;{try}
end;{esaShowOpenpitUklonsDlg}

procedure TfmOpenpitUklons.FormCreate(Sender: TObject);
begin
  FUklons := nil;
  FCount  := 0;
  StringGrid.ColWidths[0]:= 30;
  StringGrid.Cells[ 0,0] := '№';
  StringGrid.Cells[ 1,0] := 'L, м';
  StringGrid.Cells[ 2,0] := 'Lx, м';
  StringGrid.Cells[ 3,0] := 'H, м';
  StringGrid.Cells[ 4,0] := 'i, o/oo';
  StringGrid.Cells[ 5,0] := 'x0';
  StringGrid.Cells[ 6,0] := 'y0';
  StringGrid.Cells[ 7,0] := 'z0';
  StringGrid.Cells[ 8,0] := 'x1';
  StringGrid.Cells[ 9,0] := 'y1';
  StringGrid.Cells[10,0] := 'z1';
end;{FormCreate}
procedure TfmOpenpitUklons.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FUklons := nil;
  FCount  := 0;
end;{FormClose}

procedure TfmOpenpitUklons.pmUklonsPopup(Sender: TObject);
begin
  pmiUklonsExcel.Enabled := Count>0;
end;{pmUklonsPopup}
procedure TfmOpenpitUklons.pmiUklonsExcelClick(Sender: TObject);
var
  XL: TesaExcelEditor;
  I : Integer;
begin
  XL := TesaExcelEditor.Create();
  try
    //Sheet
    XL.Visible := True;
    XL.SheetCount := 1;
    XL.ActiveSheetIndex := 0;
    XL.SheetName := 'Уклоны';
    //Заголовок
    XL.Cell[1, 1].AsString        := 'Уклоны съездов автотрассы';
    XL.Cells[1,1,11,1].MergeCells := True;
    XL.Cells[1,1,11,1].Font.Style := [xlfsBold];
    XL.Cell[2, 1].AsString := '№';
    XL.Cell[2, 2].AsString := 'x0';
    XL.Cell[2, 3].AsString := 'y0';
    XL.Cell[2, 4].AsString := 'z0';
    XL.Cell[2, 5].AsString := 'x1';
    XL.Cell[2, 6].AsString := 'y1';
    XL.Cell[2, 7].AsString := 'z1';
    XL.Cell[2, 8].AsString := 'Длина, м';
    XL.Cell[2, 9].AsString := 'Длина проекции, м';
    XL.Cell[2,10].AsString := 'Высота, м';
    XL.Cell[2,11].AsString := 'Уклон, о/оо';
    for I := 1 to 11 do
      XL.Cell[3,I].AsInteger := I;
    XL.Cells[2,1,11,2].VerticalAlignment   := vaCenter;
    XL.Cells[2,1,11,2].HorizontalAlignment := haCenter;
    XL.Cells[2,1,11,2].WrapText            := True;
    //Данные
    XL.Cell[4,2].FreezePanes := True;
    for I := 0 to Count-1 do
    begin
      XL.Cell[4+I, 1].AsInteger := I+1;
      XL.Cell[4+I, 2].AsFloat   := FUklons[I].p0.X;
      XL.Cell[4+I, 3].AsFloat   := FUklons[I].p0.Y;
      XL.Cell[4+I, 4].AsFloat   := FUklons[I].p0.Z;
      XL.Cell[4+I, 5].AsFloat   := FUklons[I].p1.X;
      XL.Cell[4+I, 6].AsFloat   := FUklons[I].p1.Y;
      XL.Cell[4+I, 7].AsFloat   := FUklons[I].p1.Z;
      XL.Cell[4+I, 8].AsFloat   := FUklons[I].Lm;
      XL.Cell[4+I, 9].AsFloat   := FUklons[I].Lx;
      XL.Cell[4+I,10].AsFloat   := FUklons[I].Hm;
      XL.Cell[4+I,11].AsFloat   := FUklons[I].Uprommile;
      if FUklons[I].Uprommile>80.0
      then XL.Cell[4+I,11].SetColor(6);
    end;{for}
    //Ширина столбцов
    XL.ColumnWidths[1,11] := 12.0;
    //Frame
    XL.Cells[2,1,11,2+Max(1,Count)+2].Frame := [feTotal];
    //NumberFormat
    XL.Cells[4,2,10,Max(1,Count)].NumberFormat := nfFloat00;
    //Footer
    XL.Cell[3+Max(1,Count)+1, 1].AsString := 'Min';
    XL.Cell[3+Max(1,Count)+2, 1].AsString := 'Max';
    XL.Cells[3+Max(1,Count)+1, 1,7,1].MergeCells := True;
    XL.Cells[3+Max(1,Count)+2, 1,7,1].MergeCells := True;
    XL.Cell[3+Max(1,Count)+1, 8].AsFormulaR1C1 := '=MIN(R[-1]C:R[-'+IntToStr(Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+2, 8].AsFormulaR1C1 := '=MAX(R[-2]C:R[-'+IntToStr(1+Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+1, 9].AsFormulaR1C1 := '=MIN(R[-1]C:R[-'+IntToStr(Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+2, 9].AsFormulaR1C1 := '=MAX(R[-2]C:R[-'+IntToStr(1+Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+1,10].AsFormulaR1C1 := '=MIN(R[-1]C:R[-'+IntToStr(Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+2,10].AsFormulaR1C1 := '=MAX(R[-2]C:R[-'+IntToStr(1+Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+1,11].AsFormulaR1C1 := '=MIN(R[-1]C:R[-'+IntToStr(Max(1,Count))+']C)';
    XL.Cell[3+Max(1,Count)+2,11].AsFormulaR1C1 := '=MAX(R[-2]C:R[-'+IntToStr(1+Max(1,Count))+']C)';
    //Final
    XL.SetPageSetupMargines(Rect(10,10,10,10));
    XL.SetPageSetupOrientation(xlpoLandscape);
    XL.SetPageSetupPrintTitleRows(3,1);
    XL.SetPageSetupHeader('&8CEBADAN-AUTO, III','&8Уклоны съездов автотрассы','&8&d',5);
    XL.SetPageSetupFooter('','&8&p из &n','',5);
    XL.Zoom := 100;
  finally
    Xl.Free;
  end;{try}
end;{pmiUklonsExcelClick}

end.
