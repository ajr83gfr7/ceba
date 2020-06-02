unit ExcelEditors;
{
ИГД им. Д.А.Кунаева
Елубаев Сулеймен Актлеуович
Алматы, 2004
Редактор Excel позволяет работать с рабочей книгой Microsoft Excel
Функциональные возможности:
1.Работа с рабочей книгой
- создать новую, открыть существующую рабочую книгу, сохранить под заданным именем
2.Работа с рабочими листами
- добавить, удалить, переименовать, сделать текущим рабочий лист
- установить поля, книжный/альбомный формат страницы 
}

interface
uses Graphics, Types, Printers;
const
  //Шаблоны для функции Format
  EInvalidIndex   = 'Неверное значение индекса %d. Допустимый диапазон: [0..%d].';
type
  //Стиль шрифта
  TXLFontStyle = (xlfsBold,xlfsItalic);
  TXLFontStyles = set of TXLFontStyle;
  //Регистр шрифта
  TXLFontScript=(fpNone,fpSuperScript,fpSubScript);
  //Подчеркивание
  TXLFontUnderLine=(fuNone,             //Нет
                    fuSingle,           //Одинарное, по значению
                    fuDouble,           //Двойное, по значению
                    fuSingleAccounting, //Одинарное, по ячейке
                    fuDoubleAccounting);//Двойное, по ячейке
  //Выравнивание горизонтальное
  TXLHorizontalAlignment=(haGeneral,               //По значению
                          haLeft,                  //По левому краю (отступ)
                          haCenter,                //По центру
                          haRight,                 //По правому краю
                          haFill,                  //С заполнением
                          haJustify,               //По ширине
                          haCenterAcrossSelection);//По центру выделения
  //Выравнивание вертикальное
  TXLVerticalAlignment  =(vaTop,                   //По верхнему краю
                          vaCenter,                //По центру
                          vaBottom,                //По нижнему краю
                          vaJustify);              //По высоте


  //Рамка
  TXLFrameEdge=(feLeft,feTop,feRight,feBottom,                //лев|верх|прав|ниж.ребра
                feInsideVertical,feInsideHorizontal,          //внутренние верт.|гориз.ребра
                feLeftBold,feTopBold,feRightBold,feBottomBold,//лев|верх|прав|ниж.ребра(Bold)
                feInsideVerticalBold,feInsideHorizontalBold,  //внутр. верт|гориз.ребра(Bold)
                feTotal,                                      //все ребра
                feTotalBold);                                 //все ребра(Bold)
  TXLFrameEdges=Set of TXLFrameEdge;
  //Числовой формат
  TXLNumberFormat=(nfInt000,nfInt00,nfInt0,nfFloat0,nfFloat00,nfFloat000,nfFloat0000);
  //Характеристика диаграммы
  RChartInfo=record
    SheetNo              : Integer;//Порядковый номер листа с данными
    RecCount             : Integer;//Количество записей данных
    PosDataOX            : TPoint; //(Col,Row) диапазона данных ОХ
    PosDataOY            : TPoint; //(Col,Row) диапазона данных ОХ
    Title,TitleOX,TitleOY: String; //Заголовки диаграммы, оси ОХ, оси ОY
  end;
  TXLCells=class;
  TXLCellsFont=class;
  //TExcelEditor - класс "Редактор Excel" -----------------------------------------------------
  TExcelEditor = class
  private
    FXL   : Variant;           //Excel
    FBook : Variant;           //Текущая Рабочая книга Excel
    FSheet: Variant;           //Текущий Рабочий лист Excel

    FActiveSheetIndex: Byte;   //Индекс текущего рабочего листа Excel
    FSheetCells: TXLCells;     //Диапазон ячеек рабочего листа Excel
    FSheetFont : TXLCellsFont; //Шрифт рабочего листа
    procedure SetVisible(const Value: Boolean);
    function  GetVisible: Boolean;
    procedure SetActiveSheetIndex(const Value: Byte);
    procedure SetZoom(const Value: Word);
    function  GetZoom: Word;
    procedure SetColumnWidth(ACol,AWidth: Integer; Value: Single);
    procedure SetRowHeight(ARow,AHeight: Integer; Value: Single);
    procedure SetSheetName(const Value: String);
    procedure SetStringCell(const ARow,ACol: Integer; Value: String);
    procedure SetFloatCell(const ARow,ACol: Integer; Value: Single);
    procedure SetIntegerCell(const ARow,ACol: Integer; Value: Integer);
    procedure SetTitleCell(const ARow,ACol,AWidth,AHeight: Integer; Value: String);
    procedure SetSheetCount(const Value: Integer);
    function GetSheetCount: Integer;
    procedure SetCells(const ARow, ACol, AWidth, AHeight: Integer; Value: TXLCells);
    function GetCells(const ARow, ACol, AWidth, AHeight: Integer): TXLCells;
    function ColToStr(ACol: Integer): String;
    function GetSheetName: String;
  public
    property Visible: Boolean read GetVisible write SetVisible;
    property ActiveSheetIndex: Byte read FActiveSheetIndex write SetActiveSheetIndex;
    property Zoom: Word read GetZoom write SetZoom;
    property ColumnWidths[Col,Width: Integer]: Single write SetColumnWidth;
    property RowHeights[Row,Height: Integer]: Single write SetRowHeight;
    property SheetName: String read GetSheetName write SetSheetName;
    property SheetCount: Integer read GetSheetCount write SetSheetCount;
    property Font: TXLCellsFont read FSheetFont;
    property StringCells[const ARow,ACol: Integer]: String write SetStringCell;
    property IntegerCells[const ARow,ACol: Integer]: Integer write SetIntegerCell;
    property FloatCells[const ARow,ACol: Integer]: Single write SetFloatCell;
    property TitleCell[const ARow,ACol,AWidth,AHeight: Integer]: String write SetTitleCell;
    property Cells[const ARow, ACol, AWidth, AHeight: Integer]: TXLCells read GetCells write SetCells;
    procedure RangeTitleOn(ARow,ACol: Integer; AColCaptions: array of String);
    procedure DrawChart(const AChartInfo: RChartInfo);
    function DeleteCols(const ACol,AWidth: Integer): Boolean;
    constructor Create;
    destructor Destroy; override;
    //Установка параметров страницы
    procedure ActiveSheetPageSetup(const ALeftMargin,ATopMargin,ARightMargin,ABottomMargin,AHeaderMargin,AFooterMargin: Word; const AOrientation: TPrinterOrientation = poPortrait);
    //Установка верхнего колонтитула
    procedure ActiveSheetHeader(const ALeftHeader,ACenterHeader,ARightHeader: String);
    //Установка нижнего колонтитула
    procedure ActiveSheetFooter(const ALeftFooter,ACenterFooter,ARightFooter: String);
    //Вставка рисунка из файла
    function LoadPictureFromFile(const AFileName: String; const ALeft,ATop: Single): Variant;
  end;{TExcelEditor}

  //Диапазон ячеек рабочего листа Excel--------------------------------------------------------
  TXLCustomCells=class
  private
    FOwner: TExcelEditor;
    FBound: TRect;
    function GetWidth: Integer;
    function GetHeight: Integer;
  protected
    procedure SetBound(const Value: TRect);virtual;
    property Bound: TRect read FBound write SetBound;
    function GetRange(var ACell: String): Variant;
    function ColToStr(ACol: Integer): String;
  public
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    constructor Create(Owner: TExcelEditor);
    destructor Destroy;override;
  end;{TXLCustomCells}

  //Шрифт диапазона ячеек рабочего листа Excel-------------------------------------------------
  TXLCellsFont=class(TXLCustomCells)
  private
    function GetName: String;
    function GetSize: Integer;
    function GetStrikeThrough: Boolean;
    function GetStyle: TXLFontStyles;
    function GetScript: TXLFontScript;
    function GetUnderline: TXLFontUnderLine;
    procedure SetName(const Value: String);
    procedure SetSize(const Value: Integer);
    procedure SetStrikeThrough(const Value: Boolean);
    procedure SetStyle(const Value: TXLFontStyles);
    procedure SetScript(const Value: TXLFontScript);
    procedure SetUnderline(const Value: TXLFontUnderLine);
  public                 
    property Name: String read GetName write SetName;                          //Наименование
    property Size: Integer read GetSize write SetSize;                         //Размер
    property StrikeThrough: Boolean read GetStrikeThrough write SetStrikeThrough;//Зачеркивание
    property Style: TXLFontStyles read GetStyle write SetStyle;                //Стиль шрифта
    property Script: TXLFontScript read GetScript write SetScript;             //Регистр шрифта
    property Underline: TXLFontUnderLine read GetUnderline write SetUnderline; //Подчеркивание
  end;{TXLCellsFont}

  //Диапазон ячеек рабочего листа Excel--------------------------------------------------------
  TXLCells = class(TXLCustomCells)
  private
    FFont: TXLCellsFont;
    function GetFrame: TXLFrameEdges;
    function GetHorizontalAlignment: TXLHorizontalAlignment;
    function GetMergeCells: Boolean;
    function GetOrientation: Integer;
    function GetVerticalAlignment: TXLVerticalAlignment;
    function GetWrapText: Boolean;
    procedure SetFrame(const Value: TXLFrameEdges);
    procedure SetHorizontalAlignment(const Value: TXLHorizontalAlignment);
    procedure SetMergeCells(const Value: Boolean);
    procedure SetNumberFormat(const Value: TXLNumberFormat);
    procedure SetCustomNumberFormat(Value: String);
    procedure SetOrientation(const Value: Integer);
    procedure SetVerticalAlignment(const Value: TXLVerticalAlignment);
    procedure SetWrapText(const Value: Boolean);
  protected
    procedure SetBound(const Value: TRect);override;
  public
    property Font: TXLCellsFont read FFont;
    property Frame: TXLFrameEdges read GetFrame write SetFrame;
    property HorizontalAlignment: TXLHorizontalAlignment
      read GetHorizontalAlignment write SetHorizontalAlignment;
    property MergeCells: Boolean read GetMergeCells write SetMergeCells;
    property NumberFormat: TXLNumberFormat write SetNumberFormat;
    property CustomNumberFormat: String write SetCustomNumberFormat;
    property Orientation: Integer read GetOrientation write SetOrientation;
    property VerticalAlignment: TXLVerticalAlignment
      read GetVerticalAlignment write SetVerticalAlignment;
    property WrapText: Boolean read GetWrapText write SetWrapText;
    constructor Create(Owner: TExcelEditor);
    destructor Destroy;override;
    //Установка цвета
    procedure SetColor(const AColorIndex: Byte; const APattern: Integer = 0);
    //Закрепить область
    procedure SetFreezePanes(const AFreezePanes: Boolean = True);
    //Выделить
    procedure Select;
    //Выделить и скопировать в буфер обмена
    procedure SelectAndCopyToClipBoard;
  end;{TXLCells}
  
//Сообщение об ошибке
procedure esaMsgError(Msg: string);
implementation

uses
  ComObj, Excel2000, Math, SysUtils, Forms, Windows, Variants;
//Сообщение об ошибке
procedure esaMsgError(Msg: string);
begin
  SysUtils.Beep;
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'.')then Msg := Msg+'.';
  Application.MessageBox(PChar(Msg),'Ошибка',MB_ICONERROR);
end;{esaMsgError}

//TExcelEditor - класс "Редактор Excel" -------------------------------------------------------
procedure TExcelEditor.SetVisible(const Value: Boolean);
begin
  if Visible<>Value then FXL.Visible := Value;
end;{SetVisible}
function TExcelEditor.GetVisible: Boolean;
begin
  Result := FXL.Visible;
end;{GetVisible}
procedure TExcelEditor.SetZoom(const Value: Word);
begin
  if InRange(Value,10,400)and(Zoom<>Value) then FXL.ActiveWindow.Zoom := Value;
end;{SetZoom}
function TExcelEditor.GetZoom: Word;
begin
  Result := FXL.ActiveWindow.Zoom;
end;{GetZoom}
procedure TExcelEditor.SetColumnWidth(ACol,AWidth: Integer; Value: Single);
begin
  if ACol<1 then ACol := 1;
  if ACol>256 then ACol := 256;
  if AWidth<1 then AWidth := 1;
  if ACol+AWidth-1>256 then AWidth := 256-ACol+1;
  FSheet.Columns[ColToStr(ACol)+':'+ColToStr(ACol+AWidth-1)].ColumnWidth := Value;
end;{SetColumnWidth}
procedure TExcelEditor.SetRowHeight(ARow,AHeight: Integer; Value: Single);
begin
  if ARow<1 then ARow := 1;
  if ARow>65536 then ARow := 65536;
  if AHeight<1 then AHeight := 1;
  if ARow+AHeight-1>65536 then AHeight := 65536-ARow+1;
  FSheet.Rows[IntToStr(ARow)+':'+IntToStr(ARow+AHeight-1)].RowHeight := Value;
end;{SetRowHeight}
procedure TExcelEditor.SetSheetName(const Value: String);
begin
  if SheetCount>0 then
  try
    FSheet.Name := Value;
  finally
  end;{try}
end;{SetSheetName}
function TExcelEditor.GetSheetName: String;
begin
  if SheetCount>0 then
  try
    Result := FSheet.Name;
  except
    Result := '';
  end;{try}
end;{GetSheetName}
procedure TExcelEditor.SetStringCell(const ARow,ACol: Integer; Value: String);
begin
  if InRange(ARow,1,65536)and InRange(ACol,1,256)
  then FSheet.Cells[ARow,ACol].Value := Value;
end;{SetStringCell}
procedure TExcelEditor.SetIntegerCell(const ARow,ACol: Integer; Value: Integer);
begin
  if InRange(ARow,1,65536)and InRange(ACol,1,256)
  then FSheet.Cells[ARow,ACol].Value := Value;
end;{SetIntegerCell}
procedure TExcelEditor.SetTitleCell(const ARow,ACol,AWidth,AHeight: Integer; Value: String);
begin
  FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow+AHeight-1);
  FSheetCells.HorizontalAlignment := haCenter;
  FSheetCells.VerticalAlignment := vaCenter;
  FSheetCells.WrapText := true;
  FSheet.Cells[FSheetCells.Bound.Top,FSheetCells.Bound.Left].Value := Value;
  if (FSheetCells.Width>1)OR(FSheetCells.Height>1) then FSheetCells.MergeCells := true;
  FSheet.Cells[FSheetCells.Bound.Top,FSheetCells.Bound.Left].Value := Value;
end;{SetTitleCell}
procedure TExcelEditor.SetSheetCount(const Value: Integer);
begin
  if (Value>0)and(SheetCount<>Value) then
  begin
    while SheetCount<Value do
    begin
      FSheet := FBook.Sheets.Add;
      FSheet.Move(After:=FBook.Sheets[SheetCount]);
    end;{while}
    while SheetCount>Value do
    begin
      FBook.Sheets[SheetCount].Delete;
    end;{while}
    ActiveSheetIndex := 0;
  end;{if}
end;{SetSheetCount}
function TExcelEditor.GetSheetCount: Integer;
begin
  Result := FBook.Sheets.Count;
end;{GetSheetCount}
function TExcelEditor.GetCells(const ARow, ACol, AWidth,AHeight: Integer): TXLCells;
begin
  if FSheetCells<>nil then
  begin
    FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow+AHeight-1);
    Result := FSheetCells;
  end{if}
  else Result := nil;
end;{GetCells}
function TExcelEditor.ColToStr(ACol: Integer): String;
begin
  if ACol<1 then ACol := 1;
  if ACol>256 then ACol := 256;
  if ACol<=26
  then Result := Chr(ACol+Ord('A')-1)
  else Result := Chr((ACol div 26)+Ord('A')-1)+Chr((ACol mod 26)+Ord('A')-1);
end;{ColToStr}
procedure TExcelEditor.SetCells(const ARow, ACol, AWidth, AHeight: Integer; Value: TXLCells);
begin
  if FSheetCells<>nil then
  begin
    FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow+AHeight-1);
    FSheetCells := Value;
  end;{if}
end;{SetCells}
procedure TExcelEditor.SetFloatCell(const ARow,ACol: Integer; Value: Single);
begin
  if InRange(ARow,1,65536)and InRange(ACol,1,256)
  then FSheet.Cells[ARow,ACol].Value := Value;
end;{SetFloatCell}
procedure TExcelEditor.SetActiveSheetIndex(const Value: Byte);
begin
  if InRange(FActiveSheetIndex,0,SheetCount-1)then
  begin
    FActiveSheetIndex := Value;
    FSheet := FBook.Sheets[FActiveSheetIndex+1];
    FSheet.Select;
    FSheetFont.Size := 8;
  end{if}
  else esaMsgError(Format(EInvalidIndex,[Value,SheetCount-1]));
end;{SetActiveSheetIndex}
constructor TExcelEditor.Create;
begin
  FSheetCells := nil;
  FSheetFont := nil;
  inherited;
  //
  FXL := CreateOleObject('Excel.Application');
  FBook := FXL.WorkBooks.Add;
  SheetCount := 3;
  FSheetCells := TXLCells.Create(Self);
  FSheetFont := TXLCellsFont.Create(Self);
  FSheetFont.Bound := Rect(1,1,256,256*256);
  ActiveSheetIndex := 0;
  FSheet.Cells[1,1].Value := 1;
  Visible := true;
  Zoom := 50;
end;{Create}
destructor TExcelEditor.Destroy;
begin
  FSheetCells.Free;
  FSheetCells := nil;
  FSheetFont.Free;
  FSheetFont := nil;
  FXL.Quit;
  inherited;
end;{Destroy}
//Установка параметров страницы
procedure TExcelEditor.ActiveSheetPageSetup(const ALeftMargin,ATopMargin,ARightMargin,ABottomMargin,AHeaderMargin,AFooterMargin: Word; const AOrientation: TPrinterOrientation = poPortrait);
const
  InchPerMillimetr = 2.54*10;
begin
  if SheetCount>0 then
  try
    case AOrientation of
      poPortrait : FSheet.PageSetup.Orientation := xlPortrait;
      poLandscape: FSheet.PageSetup.Orientation := xlLandscape;
    end;{case}
    FSheet.PageSetup.LeftMargin   := FXL.InchesToPoints(ALeftMargin/InchPerMillimetr);
    FSheet.PageSetup.RightMargin  := FXL.InchesToPoints(ARightMargin/InchPerMillimetr);
    FSheet.PageSetup.TopMargin    := FXL.InchesToPoints(ATopMargin/InchPerMillimetr);
    FSheet.PageSetup.BottomMargin := FXL.InchesToPoints(ABottomMargin/InchPerMillimetr);
    FSheet.PageSetup.HeaderMargin := FXL.InchesToPoints(AHeaderMargin/InchPerMillimetr);
    FSheet.PageSetup.FooterMargin := FXL.InchesToPoints(AFooterMargin/InchPerMillimetr);
  finally
  end;{try}
end;{ActiveSheetPageSetup}
//Установка верхнего колонтитула
procedure TExcelEditor.ActiveSheetHeader(const ALeftHeader,ACenterHeader,ARightHeader: String);
begin
  if SheetCount>0 then
  try
    FSheet.PageSetup.LeftHeader   := ALeftHeader;
    FSheet.PageSetup.CenterHeader := ACenterHeader;
    FSheet.PageSetup.RightHeader  := ARightHeader;
  finally
  end;{try}
end;{ActiveSheetHeader}
//Установка нижнего колонтитула
procedure TExcelEditor.ActiveSheetFooter(const ALeftFooter,ACenterFooter,ARightFooter: String);
begin
  if SheetCount>0 then
  try
    FSheet.PageSetup.LeftFooter   := ALeftFooter;
    FSheet.PageSetup.CenterFooter := ACenterFooter;
    FSheet.PageSetup.RightFooter  := ARightFooter;
  finally
  end;{try}
end;{ActiveSheetFooter}
//Вставка рисунка из файла
function TExcelEditor.LoadPictureFromFile(const AFileName: String; const ALeft,ATop: Single): Variant;
begin
  Result := unAssigned;
  try
    Result := FSheet.Pictures.Insert(AFileName);
    Result.ShapeRange.Top  := ATop;
    Result.ShapeRange.Left := ALeft;
//    ActiveSheet.Pictures.Insert( _
//        "G:\esaIGD2007_09_01\esaИГД Договор 2007_09_13\esaИГД Отчет 2007_10_13\asd.bmp" _
//        ).Select
//    ActiveWindow.SmallScroll Down:=15
//    Selection.ShapeRange.IncrementTop -50.25
  except
    on E: Exception do esaMsgError(E.Message);
  end;{try}
end;{LoadPictureFromFile}
procedure TExcelEditor.RangeTitleOn(ARow,ACol: Integer; AColCaptions: array of String);
var
  Range: Variant;
  Cell0,Cell1: String;
  AWidth: Integer;
  I: Integer;
begin
  AWidth := High(AColCaptions)-Low(AColCaptions)+1;
  if AWidth<1 then Exit;
  if ARow<1 then ARow := 1;
  if ACol<1 then ACol := 1;
  Cell0 := ColToStr(ACol)+IntToStr(ARow);
  Cell1 := ColToStr(ACol+AWidth-1)+IntToStr(ARow+2-1);
  Range := FSheet.Range[Cell0,Cell1];
  for I := Low(AColCaptions) to High(AColCaptions) do
  begin
    FSheet.Cells[ARow,I+1].Value := AColCaptions[I];
    FSheet.Cells[ARow+1,I+1].Value := I-Low(AColCaptions)+1;
  end;{for}
  FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow);
  FSheetCells.HorizontalAlignment := haCenter;
  FSheetCells.VerticalAlignment := vaCenter;
  FSheetCells.NumberFormat := nfFloat00;
  FSheetCells.WrapText := true;
  Cells[ARow+1,ACol,AWidth,1].HorizontalAlignment := haCenter;
end;{RangeTitleOn}
procedure TExcelEditor.DrawChart(const AChartInfo: RChartInfo);
var
  Chart: Variant;
  APosOY0,APosOY1: String;
begin
  Chart := FXl.Charts.Add;
  Chart.ChartType := xlLine;
  with AChartInfo do
  begin
    APosOY0 := ColToStr(PosDataOY.X)+IntToStr(PosDataOY.Y);
    APosOY1 := ColToStr(PosDataOY.X)+IntToStr(PosDataOY.Y+RecCount-1);
    Chart.SetSourceData(Source:=FSheet.Range[APosOY0,APosOY1], PlotBy:= xlColumns);
    with PosDataOX do                                    
      Chart.SeriesCollection(1).XValues := Format('=%s!R%dC%d:R%dC%d',[SheetName,Y,X,Y+RecCount-1,X]);
    with PosDataOY do
      Chart.SeriesCollection(1).Values := Format('=%s!R%dC%d:R%dC%d',[SheetName,Y,X,Y+RecCount-1,X]);
  end;{with}
  Chart.HasTitle := True;
  Chart.ChartTitle.Characters.Text := AChartInfo.Title;
  Chart.Axes(xlCategory, xlPrimary).HasTitle := True;
  Chart.Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text := AChartInfo.TitleOX;
  Chart.Axes(xlValue, xlPrimary).HasTitle := True;
  Chart.Axes(xlValue, xlPrimary).AxisTitle.Characters.Text := AChartInfo.TitleOY;
  Chart.Axes(xlCategory).HasMajorGridlines := True;
  Chart.Axes(xlValue).HasMajorGridlines := True;
  Chart.SeriesCollection(1).Border.ColorIndex := 3;
  Chart.SeriesCollection(1).Border.Weight := xlThick;
  Chart.HasLegend := False;
  Chart.SeriesCollection(1).MarkerSize := 3;
//  Chart.Location(Where:=xlLocationAsObject, Name:='Лист1');
end;{DrawChart}
//Удалить столбцы
function TExcelEditor.DeleteCols(const ACol,AWidth: Integer): Boolean;
begin
  Result := false;
  if (ACol>0)and(AWidth>0)and InRange(ACol+AWidth-1,1,256) then
  begin
    FSheet.Columns[ColToStr(ACol)+':'+ColToStr(ACol+AWidth-1)].Delete(Shift:=xlToLeft);
    Result := true;
  end;{if}
end;{DeleteCols}


//Диапазон ячеек рабочего листа Excel----------------------------------------------------------
constructor TXLCustomCells.Create(Owner: TExcelEditor);
begin
  inherited Create;
  FOwner := Owner;
  FBound := Rect(1,1,1,1);
end;{Create}
destructor TXLCustomCells.Destroy;
begin
  FOwner := nil;
  inherited;
end;{Destroy}
procedure TXLCustomCells.SetBound(const Value: TRect);
var ARow,ACol,AWidth,AHeight: Integer;
begin
  ACol := Min(Value.Left,Value.Right);
  AWidth := Max(Value.Left,Value.Right)-ACol+1;
  ARow := Min(Value.Top,Value.Bottom);
  AHeight := Max(Value.Top,Value.Bottom)-ARow+1;
  if ARow<1 then ARow := 1;
  if ACol<1 then ACol := 1;
  if AWidth<1 then AWidth := 1;
  if AHeight<1 then AHeight := 1;
  if ARow>65536 then ARow := 65536;//=2^16
  if ACol>256 then ACol := 256;//=2^8
  if ARow+AHeight-1>65536 then AHeight := 65536-ARow+1;
  if ACol+AWidth-1>256 then AWidth := 256-ACol+1;
  FBound := Rect(ACol,ARow,ACol+AWidth-1,ARow+AHeight-1);
end;{SetBound}
function TXLCustomCells.GetWidth: Integer;
begin
  Result := FBound.Right-FBound.Left+1;
end;{GetWidth}
function TXLCustomCells.GetHeight: Integer;
begin
  Result := FBound.Bottom-FBound.Top+1;
end;{GetHeight}
function TXLCustomCells.ColToStr(ACol: Integer): String;
begin
  if ACol<1 then ACol := 1;
  if ACol>256 then ACol := 256;
  if ACol<=26
  then Result := Chr(ACol+Ord('A')-1)
  else Result := Chr((ACol div 26)+Ord('A')-1)+Chr((ACol mod 26)+Ord('A')-1);
end;{ColToStr}
function TXLCustomCells.GetRange(var ACell: String): Variant;
var
  Cell0,Cell1: String;
  ARow,ACol,AWidth,AHeight: Integer;
begin
  ACol := Min(FBound.Left,FBound.Right);
  AWidth := Max(FBound.Left,FBound.Right)-ACol+1;
  ARow := Min(FBound.Top,FBound.Bottom);
  AHeight := Max(FBound.Top,FBound.Bottom)-ARow+1;

  Cell0 := ColToStr(ACol)+IntToStr(ARow);
  Cell1 := ColToStr(ACol+AWidth-1)+IntToStr(ARow+AHeight-1);
  if Cell0<>Cell1
  then ACell := Cell0+':'+Cell1
  else ACell := Cell0;
  Result := FOwner.FBook.Sheets[FOwner.FActiveSheetIndex+1].Range[Cell0,Cell1];
end;{GetRange}

//Шрифт диапазона ячеек рабочего листа Excel---------------------------------------------------
function TXLCellsFont.GetName: String;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := ARange.Font.Name;
  except
    Result := '';
    esaMsgError('Не могу определить Наименование шрифта для диапазона '+ACell);
  end;{try}
end;{GetName}
function TXLCellsFont.GetSize: Integer;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := ARange.Font.Size;
  except
    Result := 0;
    esaMsgError('Не могу определить Размер шрифта для диапазона '+ACell);
  end;{try}
end;{GetSize}
function TXLCellsFont.GetStrikeThrough: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := ARange.Font.StrikeThrough;
  except
    Result := false;
    esaMsgError('Не могу определить Зачеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{GetStrikeThrough}
function TXLCellsFont.GetStyle: TXLFontStyles;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := [];
    if ARange.Font.Bold then Include(Result,xlfsBold);
    if ARange.Font.Italic then Include(Result,xlfsItalic);
  except
    Result := [];
    esaMsgError('Не могу определить Стиль шрифта для диапазона '+ACell);
  end;{try}
end;{GetStyle}
function TXLCellsFont.GetScript: TXLFontScript;
var
  ARange: Variant;
  ACell: String;
begin
  Result := fpNone;
  try
    ARange := GetRange(ACell);
    if ARange.Font.SubScript then Result := fpSubScript;
    if ARange.Font.SuperScript then Result := fpSuperScript;
  except
    esaMsgError('Не могу определить Регистр шрифта для диапазона '+ACell);
  end;{try}
end;{GetScript}
function TXLCellsFont.GetUnderline: TXLFontUnderLine;
var
  ARange: Variant;
  ACell: String;
begin
  Result := fuNone;
  try
    ARange := GetRange(ACell);
    if ARange.Font.Underline=xlUnderlineStyleNone then Result := fuNone;
    if ARange.Font.Underline=xlUnderlineStyleSingle then Result := fuSingle;
    if ARange.Font.Underline=xlUnderlineStyleDouble then Result := fuDouble;
    if ARange.Font.Underline=xlUnderlineStyleSingleAccounting then Result := fuSingleAccounting;
    if ARange.Font.Underline=xlUnderlineStyleDoubleAccounting then Result := fuDoubleAccounting;
  except
    esaMsgError('Не могу определить Подчеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{GetUnderline}
procedure TXLCellsFont.SetName(const Value: String);
var
  ARange: Variant;
  ACell: String;
begin
  if Trim(Value)<>'' then
  try
    ARange := GetRange(ACell);
    ARange.Font.Name := Trim(Value);
  except
    esaMsgError('Не могу установить Наименование шрифта для диапазона '+ACell);
  end;{try}
end;{SetName}
procedure TXLCellsFont.SetSize(const Value: Integer);
var
  ARange: Variant;
  ACell: String;
begin
  if Value>0 then
  try
    ARange := GetRange(ACell);
    ARange.Font.Size := Value;
  except
    esaMsgError('Не могу установить Размер шрифта для диапазона '+ACell);
  end;{try}
end;{SetSize}
procedure TXLCellsFont.SetStrikeThrough(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.Font.StrikeThrough := Value;
  except
    esaMsgError('Не могу установить Зачеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{SetStrikeThrough}
procedure TXLCellsFont.SetStyle(const Value: TXLFontStyles);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.Font.Bold := xlfsBold in Value; 
    ARange.Font.Italic := xlfsItalic in Value; 
  except
    esaMsgError('Не могу установить Стиль шрифта для диапазона '+ACell);
  end;{try}
end;{SetStyle}
procedure TXLCellsFont.SetScript(const Value: TXLFontScript);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.Font.SubScript := Value=fpSubScript;
    ARange.Font.SuperScript := Value=fpSuperScript;
  except
    esaMsgError('Не могу установить Регистр шрифта для диапазона '+ACell);
  end;{try}
end;{SetSubScript}
procedure TXLCellsFont.SetUnderline(const Value: TXLFontUnderLine);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    case Value of
      fuNone            : ARange.Font.Underline := xlUnderlineStyleNone;
      fuSingle          : ARange.Font.Underline := xlUnderlineStyleSingle;
      fuDouble          : ARange.Font.Underline := xlUnderlineStyleDouble;
      fuSingleAccounting: ARange.Font.Underline := xlUnderlineStyleSingleAccounting;
      fuDoubleAccounting: ARange.Font.Underline := xlUnderlineStyleDoubleAccounting;
    end;{case}
  except
    esaMsgError('Не могу установить Подчеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{SetUnderline}

//Диапазон ячеек рабочего листа Excel----------------------------------------------------------
constructor TXLCells.Create(Owner: TExcelEditor);
begin
  inherited;
  FFont := TXLCellsFont.Create(Owner);
end;{Create}

destructor TXLCells.Destroy;
begin
  FFont.Free;
  FFont := nil;
  inherited;
end;{Destroy}
//Установка цвета
procedure TXLCells.SetColor(const AColorIndex: Byte; const APattern: Integer = 0);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.Interior.ColorIndex := AColorIndex;
    ARange.Interior.Pattern    := xlSolid;
  except
    esaMsgError('Не могу установить цвет ячеек диапазона '+ACell);
  end;{try}
end;{SetColor}
//Закрепить область
procedure TXLCells.SetFreezePanes(const AFreezePanes: Boolean = True);
//var
//  ARange: Variant;
//  ACell: String;
begin
//  try
//    ARange := GetRange(ACell);
//    ARange.Select;
//    FOwner.FXL.FreezePanes := True;
//  except
//    esaMsgError('Не могу установить закрепление области ячеек диапазона '+ACell);
//  end;{try}
end;{SetFreezePanes}
//Выделить
procedure TXLCells.Select;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.Select;
  except
    esaMsgError('Не могу выделить диапазон '+ACell);
  end;{try}
end;{Select}
//Выделить и скопировать в буфер обмена
procedure TXLCells.SelectAndCopyToClipBoard;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.Select;
    FOwner.FXL.Selection.Copy;
  except
    esaMsgError('Не могу выделить и скопировать в буфер обмена диапазон '+ACell);
  end;{try}
end;{SelectAndCopyToClipBoard}

procedure TXLCells.SetBound(const Value: TRect);
begin
  inherited;
  FFont.Bound := Bound;
end;{SetBound}

function TXLCells.GetFrame: TXLFrameEdges;
var
  ARange: Variant;
  ACell: String;
  ALeft,ARight,ATop,ABottom,AInsideVertical,AInsideHorizontal: Boolean;
begin
  Result := [];
  try
    ARange := GetRange(ACell);
    ALeft := ARange.Borders[xlEdgeLeft].LineStyle = xlContinuous;
    ATop := ARange.Borders[xlEdgeTop].LineStyle = xlContinuous;
    ARight := ARange.Borders[xlEdgeRight].LineStyle = xlContinuous;
    ABottom := ARange.Borders[xlEdgeBottom].LineStyle = xlContinuous;
    AInsideHorizontal := ARange.Borders[xlInsideHorizontal].LineStyle = xlContinuous;
    AInsideVertical := ARange.Borders[xlInsideVertical].LineStyle = xlContinuous;
    if ALeft and ATop and ARight and ABottom and AInsideHorizontal and AInsideVertical then
    begin
      Result := [feTotal];
      if (ARange.Borders[xlEdgeLeft].Weight<>xlThin)and
         (ARange.Borders[xlEdgeTop].Weight<>xlThin)and
         (ARange.Borders[xlEdgeRight].Weight<>xlThin)and
         (ARange.Borders[xlEdgeBottom].Weight<>xlThin)and
         (ARange.Borders[xlInsideVertical].Weight<>xlThin)and
         (ARange.Borders[xlInsideHorizontal].Weight<>xlThin)
      then Include(Result,feTotalBold);
    end{if}
    else
      if ALeft or ATop or ARight or ABottom or AInsideHorizontal or AInsideVertical then
      begin
        if ALeft then Include(Result,feLeft);
        if ATop then Include(Result,feTop);
        if ARight then Include(Result,feRight);
        if ABottom then Include(Result,feBottom);
        if AInsideVertical then Include(Result,feInsideVertical);
        if AInsideHorizontal then Include(Result,feInsideHorizontal);
        if ARange.Borders[xlEdgeLeft].Weight<>xlThin then Include(Result,feLeftBold);
        if ARange.Borders[xlEdgeTop].Weight<>xlThin then Include(Result,feTopBold);
        if ARange.Borders[xlEdgeRight].Weight<>xlThin then Include(Result,feRightBold);
        if ARange.Borders[xlEdgeBottom].Weight<>xlThin then Include(Result,feBottomBold);
        if ARange.Borders[xlInsideVertical].Weight<>xlThin
        then Include(Result,feInsideVerticalBold);
        if ARange.Borders[xlInsideHorizontal].Weight<>xlThin
        then Include(Result,feInsideHorizontalBold);
      end;{if}
  except
    esaMsgError('Не могу определить Рамку диапазона '+ACell);
  end;{try}
end;{GetFrame}
function TXLCells.GetHorizontalAlignment: TXLHorizontalAlignment;
var
  ARange: Variant;
  ACell: String;
begin
  Result := haLeft;
  try
    ARange := GetRange(ACell);
    if ARange.HorizontalAlignment=xlGeneral then Result := haGeneral;
    if ARange.HorizontalAlignment=xlLeft then Result := haLeft;
    if ARange.HorizontalAlignment=xlCenter then Result := haCenter;
    if ARange.HorizontalAlignment=xlRight then Result := haRight;
    if ARange.HorizontalAlignment=xlFill then Result := haFill;
    if ARange.HorizontalAlignment=xlJustify then Result := haJustify;
    if ARange.HorizontalAlignment=xlCenterAcrossSelection then Result := haCenterAcrossSelection;
  except
    esaMsgError('Не могу определить Горизонтальное Выравнивание диапазона '+ACell);
  end;{try}
end;{GetHorizontalAlignment}
function TXLCells.GetMergeCells: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := ARange.MergeCells;
  except
    Result := false;
    esaMsgError('Не могу определить Объединение Ячеек диапазона '+ACell);
  end;{try}
end;{GetMergeCells}
function TXLCells.GetOrientation: Integer;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := ARange.Orientation;
  except
    Result := 0;
    esaMsgError('Не могу определить Ориентацию Текста диапазона '+ACell);
  end;{try}
end;{GetOrientation}
function TXLCells.GetVerticalAlignment: TXLVerticalAlignment;
var
  ARange: Variant;
  ACell: String;
begin
  Result := vaCenter;
  try
    ARange := GetRange(ACell);
    if ARange.VerticalAlignment=xlTop then Result := vaTop;
    if ARange.VerticalAlignment=xlCenter then Result := vaCenter;
    if ARange.VerticalAlignment=xlBottom then Result := vaBottom;
    if ARange.VerticalAlignment=xlJustify then Result := vaJustify;
  except
    esaMsgError('Не могу определить Вертикальное Выравнивание диапазона '+ACell);
  end;{try}
end;{GetVerticalAlignment}
function TXLCells.GetWrapText: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    Result := ARange.WrapText;
  except
    Result := false;
    esaMsgError('Не могу определить Перенос По Словам диапазона '+ACell);
  end;{try}
end;{GetWrapText}
procedure TXLCells.SetFrame(const Value: TXLFrameEdges);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    if (feLeft in Value)or(feTotal in Value)then
    begin
      ARange.Borders[xlEdgeLeft].LineStyle := xlContinuous;
      if (feTotalBold in Value)OR(feLeftBold in Value)
      then ARange.Borders[xlEdgeLeft].Weight := xlMedium;
    end{if}
    else ARange.Borders[xlEdgeLeft].LineStyle := xlNone;
    if (feTop in Value)or(feTotal in Value)then
    begin
      ARange.Borders[xlEdgeTop].LineStyle := xlContinuous;
      if (feTotalBold in Value)OR(feTopBold in Value)
      then ARange.Borders[xlEdgeTop].Weight := xlMedium;
    end{if}
    else ARange.Borders[xlEdgeTop].LineStyle := xlNone;
    if (feRight in Value)or(feTotal in Value)then
    begin
      ARange.Borders[xlEdgeRight].LineStyle := xlContinuous;
      if (feTotalBold in Value)OR(feRightBold in Value)
      then ARange.Borders[xlEdgeRight].Weight := xlMedium;
    end{if}
    else ARange.Borders[xlEdgeRight].LineStyle := xlNone;
    if (feBottom in Value)or(feTotal in Value)then
    begin
      ARange.Borders[xlEdgeBottom].LineStyle := xlContinuous;
      if (feTotalBold in Value)OR(feBottomBold in Value)
      then ARange.Borders[xlEdgeBottom].Weight := xlMedium;
    end{if}
    else ARange.Borders[xlEdgeBottom].LineStyle := xlNone;
    if Height>1 then
    begin
      if (feInsideHorizontal in Value)or(feTotal in Value)then
      begin
        if (feTotalBold in Value)OR(feInsideHorizontalBold in Value)
        then ARange.Borders[xlInsideHorizontal].Weight := xlMedium;
        ARange.Borders[xlInsideHorizontal].LineStyle := xlContinuous;
      end{if}
      else ARange.Borders[xlInsideHorizontal].LineStyle := xlNone;
    end;{if}
    if Width>1 then
    begin
      if (feInsideVertical in Value)or(feTotal in Value)then
      begin
        if (feTotalBold in Value)OR(feInsideVerticalBold in Value)
        then ARange.Borders[xlInsideVertical].Weight := xlMedium;
        ARange.Borders[xlInsideVertical].LineStyle := xlContinuous;
      end{if}
      else ARange.Borders[xlInsideVertical].LineStyle := xlNone;
    end;{if}
  except
    esaMsgError('Не могу установить Рамку диапазона '+ACell);
  end;{try}
end;{SetFrame}
procedure TXLCells.SetHorizontalAlignment(const Value: TXLHorizontalAlignment);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    case Value of
      haGeneral              : ARange.HorizontalAlignment := xlGeneral;
      haLeft                 : ARange.HorizontalAlignment := xlLeft;
      haCenter               : ARange.HorizontalAlignment := xlCenter;
      haRight                : ARange.HorizontalAlignment := xlRight;
      haFill                 : ARange.HorizontalAlignment := xlFill;
      haJustify              : ARange.HorizontalAlignment := xlJustify;
      haCenterAcrossSelection: ARange.HorizontalAlignment := xlCenterAcrossSelection;
    end;{case}
  except
    esaMsgError('Не могу установить Горизонтальное Выравнивание диапазона '+ACell);
  end;{try}
end;{SetHorizontalAlignment}
procedure TXLCells.SetMergeCells(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.MergeCells := Value;
  except
    esaMsgError('Не могу установить Объединение Ячеек диапазона '+ACell);
  end;{try}
end;{SetMergeCells}
procedure TXLCells.SetNumberFormat(const Value: TXLNumberFormat);
var
  ARange: Variant;
  I: Integer;
  AFormula,ACell,DS: String;
begin
  DS := DecimalSeparator;
  try
    ARange := GetRange(ACell);
    case Value of
      nfInt000   : AFormula := '* # 000;* # 000;"-"';
      nfInt00    : AFormula := '* # #00;* # 00;"-"';
      nfInt0     : AFormula := '* # ##0;* # ##0;"-"';
      nfFloat0   : AFormula := '* # ##0.0;* # ##0.0;"-"';
      nfFloat00  : AFormula := '* # ##0.00;* # ##0.00;"-"';
      nfFloat000 : AFormula := '* # ##0.000;* # ##0.000;"-"';
      nfFloat0000: AFormula := '* # ##0.0000;* # ##0.0000;"-"';
    end;{case}
    for I := 0 to Length(AFormula) do
      if AFormula[I]='.' then AFormula[I] := DecimalSeparator;
    ARange.NumberFormat := AFormula;
  except
    esaMsgError('Не могу установить Числовой Формат диапазона '+ACell);
  end;{try}
end;{SetNumberFormat}
procedure TXLCells.SetCustomNumberFormat(Value: String);
var
  ARange: Variant;
  ACell: String;
  I: Integer;
begin
  Value := Trim(Value);
  if Value<>'' then
  try
    ARange := GetRange(ACell);
    for I := 1 to Length(Value) do
      if Value[I] in ['.',','] then Value[I] := DecimalSeparator;
    ARange.NumberFormat := Value;
  except
    esaMsgError('Не могу установить Числовой Формат диапазона '+ACell);
  end;{try}
end;{SetCustomNumberFormat}
procedure TXLCells.SetOrientation(const Value: Integer);
var
  ARange: Variant;
  ACell: String;
begin
  if InRange(Value,-90,90)then
  try
    ARange := GetRange(ACell);
    ARange.Orientation := Value;
  except
    esaMsgError('Не могу установить Ориентацию Текста диапазона '+ACell);
  end;{try}
end;{SetOrientation}
procedure TXLCells.SetVerticalAlignment(const Value: TXLVerticalAlignment);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    case Value of
      vaTop    : ARange.VerticalAlignment := xlTop;
      vaCenter : ARange.VerticalAlignment := xlCenter;
      vaBottom : ARange.VerticalAlignment := xlBottom;
      vaJustify: ARange.VerticalAlignment := xlJustify;
    end;{case}
  except
    esaMsgError('Не могу установить Вертикальное Выравнивание диапазона '+ACell);
  end;{try}
end;{SetVerticalAlignment}
procedure TXLCells.SetWrapText(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(ACell);
    ARange.WrapText := Value;
  except
    esaMsgError('Не могу установить Перенос По Словам диапазона '+ACell);
  end;{try}
end;{SetWrapText}


end.

