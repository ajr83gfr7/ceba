unit esaExcelEditors;
{
ИГД им. Д.А.Кунаева
Елубаев Сулеймен Актлеуович, аспирант
Алматы, 2004
Редактор Excel позволяет работать с рабочей книгой Microsoft Excel
Функциональные возможности:
1.Работа с рабочей книгой
- создать новую, открыть существующую рабочую книгу, сохранить под заданным именем
2.Работа с рабочими листами
- добавить, удалить, переименовать, сделать текущим рабочий лист
- установить параметры печати странцы 
3.Работа с диапазоном ячеек текущего рабочего листа
- вносить значения целого, вещественного, строкового типов
- вносить формулы
- устанавливать обрамление
- устанавливать фонт
- изменять выравнивание, направление текста, устанавливать перенос текста
- объединять ячейки
- удалять/вставлять строки, столбцы
- изменять размеры столбцов
- закреплять статической области столбцов/строк шапки при прокрутке рабочего столбца
}
interface
uses Graphics, Types;
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
  TXLPrinterOrientation=(xlpoPortrait,xlpoLandscape);

  //Параметры печати страницы
  TXLCells=class;
  TXLCellsFont=class;
  //TExcelEditor - класс "Редактор Excel" -----------------------------------------------------
  TesaExcelEditor = class
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
    procedure SetSheetCount(const Value: Integer);
    function GetSheetCount: Integer;
    procedure SetCells(const ARow, ACol, AWidth, AHeight: Integer; Value: TXLCells);
    function GetCells(const ARow, ACol, AWidth, AHeight: Integer): TXLCells;
    procedure SetCell(const ARow, ACol: Integer; Value: TXLCells);
    function GetCell(const ARow, ACol: Integer): TXLCells;
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
    property Cells[const ARow, ACol, AWidth, AHeight: Integer]: TXLCells read GetCells write SetCells;
    property Cell[const ARow, ACol: Integer]: TXLCells read GetCell write SetCell;
    constructor Create;
    destructor Destroy; override;
    //Вывод диаграммы
    procedure DrawChart(const AChartInfo: RChartInfo);
    //Удаляю заданный диапазон столбцов текущего листа
    function DeleteCols(const ACol,AWidth: Integer): Boolean;
    //Открываю рабочую книгу
    function LoadFromFile(const AFileName: String): Boolean;
    //Сохраняю в файл под заданным именем
    function SaveToFile(const AFileName: String): Boolean;
    //Устанавливаю отступы полей текущего листа, мм
    procedure SetPageSetupMargines(const Margins: TRect);
    //Устанавливаю формат текущего листа при печати: книжный/альбомный
    procedure SetPageSetupOrientation(const Orientation: TXLPrinterOrientation);
    //Устанавливаю диапазон столбцов текущего листа, повторяющихся на каждой странице при печати
    procedure SetPageSetupPrintTitleColumns(const ACol, AWidth: Integer);
    //Устанавливаю диапазон строк текущего листа, повторяющихся на каждой странице при печати
    procedure SetPageSetupPrintTitleRows(const ARow, AHeight: Integer);
    //Устанавливаю верхние заголовки текущего листа при печати
    procedure SetPageSetupHeader(const LeftHeader,CenterHeader,RightHeader: String; const HeaderMargin: Integer);
    //Устанавливаю нижние заголовки текущего листа при печати
    procedure SetPageSetupFooter(const LeftFooter,CenterFooter,RightFooter: String; const FooterMargin: Integer);
    //Устанавливаю выравнивание текущего листа на странице при печати
    procedure SetPageSetupCentered(const CenterHorizontally,CenterVertically: Boolean);
    //Устанавливаю шапку с пронумерованными столбцами
    procedure SetColumnTitles(ARow,ACol       : Integer;
                              AColumnTitles   : array of String;
                              IsNumeredColumns: Boolean = True);
    //Устанавливаю пронумерованную строку
    procedure SetNumericRow(ARow,ACol,AWidth: Integer);
  end;{TesaExcelEditor}

  //Диапазон ячеек рабочего листа Excel--------------------------------------------------------
  TXLCustomCells=class
  private
    FOwner: TesaExcelEditor;
    FBound: TRect;
    function GetWidth: Integer;
    function GetHeight: Integer;
  protected
    procedure SetBound(const Value: TRect);virtual;
    property Bound: TRect read FBound write SetBound;
    function GetRange(const ABound: TRect; var ACell: String): Variant;
    function ColToStr(ACol: Integer): String;
    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
  public
    constructor Create(Owner: TesaExcelEditor);
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
    property Name: String read GetName write SetName;                            //Наименование
    property Size: Integer read GetSize write SetSize;                           //Размер
    property StrikeThrough: Boolean read GetStrikeThrough write SetStrikeThrough;//Зачеркивание
    property Style: TXLFontStyles read GetStyle write SetStyle;                  //Стиль шрифта
    property Script: TXLFontScript read GetScript write SetScript;               //Регистр шрифта
    property Underline: TXLFontUnderLine read GetUnderline write SetUnderline;   //Подчеркивание
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
    procedure SetAsInteger(const Value: Integer);
    procedure SetAsString(const Value: String);
    procedure SetAsText(const Value: String);
    procedure SetAsFloat(const Value: Single);
    procedure SetAsFormulaR1C1(const Value: String);
    function GetAsInteger: Integer;
    function GetAsString: String;
    function GetAsFloat: Single;
    function GetAsText: String;
    function GetFreezePanes: Boolean;
    procedure SetFreezePanes(const Value: Boolean);
    function GetAsFormaulaR1C1: String;
  protected
    procedure SetBound(const Value: TRect);override;
  public
    property Font: TXLCellsFont read FFont;                                //Фонт
    property Frame: TXLFrameEdges read GetFrame write SetFrame;            //Рамка
    property HorizontalAlignment: TXLHorizontalAlignment                   //Гориз.выравнивание
      read GetHorizontalAlignment write SetHorizontalAlignment;
    property MergeCells: Boolean read GetMergeCells write SetMergeCells;   //Объединение ячеек
    property NumberFormat: TXLNumberFormat write SetNumberFormat;          //Формат чисел
    property CustomNumberFormat: String write SetCustomNumberFormat;       //Пользов.формат чисел
    property Orientation: Integer read GetOrientation write SetOrientation;//Направление текста
    property VerticalAlignment: TXLVerticalAlignment                       //Гориз.выравнивание
      read GetVerticalAlignment write SetVerticalAlignment;
    property WrapText: Boolean read GetWrapText write SetWrapText;         //Перенос текста
    property AsString: String read GetAsString write SetAsString;          //Строковое значение
    property AsInteger: Integer read GetAsInteger write SetAsInteger;      //Целое значение
    property AsFloat: Single read GetAsFloat write SetAsFloat;             //Веществ.значение
    property AsText: String read GetAsText write SetAsText;                //Строк.значение объедин.группы ячеек
    property AsFormulaR1C1: String read GetAsFormaulaR1C1 write SetAsFormulaR1C1;//Формула
    property FreezePanes: Boolean read GetFreezePanes write SetFreezePanes;//Закрепление области при прокрутке листа
    procedure Select;//Выделение области ячеек
    constructor Create(Owner: TesaExcelEditor);
    destructor Destroy;override;
    //Установка цвета
    procedure SetColor(const AColorIndex: Byte; const APattern: Integer = 0);
  end;{TXLCells}
  
implementation

uses
  ComObj, Excel2000, Math, SysUtils, Forms, Windows;
//Сообщение об ошибке
procedure MsgError(Msg: string);
begin
  SysUtils.Beep;
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'.')then Msg := Msg+'.';
  Application.MessageBox(PChar(Msg),'Ошибка',MB_ICONERROR);
end;{MsgError}

//TesaExcelEditor - класс "Редактор Excel" -------------------------------------------------------
procedure TesaExcelEditor.SetVisible(const Value: Boolean);
begin
  if Visible<>Value then FXL.Visible := Value;
end;{SetVisible}
function TesaExcelEditor.GetVisible: Boolean;
begin
  Result := FXL.Visible;
end;{GetVisible}
procedure TesaExcelEditor.SetZoom(const Value: Word);
begin
  if InRange(Value,10,400)and(Zoom<>Value) then FXL.ActiveWindow.Zoom := Value;
end;{SetZoom}
function TesaExcelEditor.GetZoom: Word;
begin
  Result := FXL.ActiveWindow.Zoom;
end;{GetZoom}
procedure TesaExcelEditor.SetColumnWidth(ACol,AWidth: Integer; Value: Single);
begin
  if ACol<1 then ACol := 1;
  if ACol>256 then ACol := 256;
  if AWidth<1 then AWidth := 1;
  if ACol+AWidth-1>256 then AWidth := 256-ACol+1;
  FSheet.Columns[ColToStr(ACol)+':'+ColToStr(ACol+AWidth-1)].ColumnWidth := Value;
end;{SetColumnWidth}
procedure TesaExcelEditor.SetRowHeight(ARow,AHeight: Integer; Value: Single);
begin
  if ARow<1 then ARow := 1;
  if ARow>65536 then ARow := 65536;
  if AHeight<1 then AHeight := 1;
  if ARow+AHeight-1>65536 then AHeight := 65536-ARow+1;
  FSheet.Rows[IntToStr(ARow)+':'+IntToStr(ARow+AHeight-1)].RowHeight := Value;
end;{SetRowHeight}
procedure TesaExcelEditor.SetSheetName(const Value: String);
begin
  if SheetCount>0 then
  try
    FSheet.Name := Value;
  finally
  end;{try}
end;{SetSheetName}
function TesaExcelEditor.GetSheetName: String;
begin
  if SheetCount>0 then
  try
    Result := FSheet.Name;
  except
    Result := '';
  end;{try}
end;{GetSheetName}
procedure TesaExcelEditor.SetSheetCount(const Value: Integer);
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
function TesaExcelEditor.GetSheetCount: Integer;
begin
  Result := FBook.Sheets.Count;
end;{GetSheetCount}
function TesaExcelEditor.GetCells(const ARow, ACol, AWidth,AHeight: Integer): TXLCells;
begin
  if FSheetCells<>nil then
  begin
    FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow+AHeight-1);
    Result := FSheetCells;
  end{if}
  else Result := nil;
end;{GetCells}
function TesaExcelEditor.GetCell(const ARow, ACol: Integer): TXLCells;
begin
  if FSheetCells<>nil then
  begin
    FSheetCells.Bound := Rect(ACol,ARow,ACol,ARow);
    Result := FSheetCells;
  end{if}
  else Result := nil;
end;{GetCell}
function TesaExcelEditor.ColToStr(ACol: Integer): String;
begin
  if ACol<1 then ACol := 1;
  if ACol>256 then ACol := 256;
  if ACol<=26
  then Result := Chr(ACol+Ord('A')-1)
  else Result := Chr((ACol div 26)+Ord('A')-1)+Chr((ACol mod 26)+Ord('A')-1);
end;{ColToStr}
procedure TesaExcelEditor.SetCells(const ARow, ACol, AWidth, AHeight: Integer; Value: TXLCells);
begin
  if FSheetCells<>nil then
  begin
    FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow+AHeight-1);
    FSheetCells := Value;
  end;{if}
end;{SetCells}
procedure TesaExcelEditor.SetCell(const ARow, ACol: Integer; Value: TXLCells);
begin
  if FSheetCells<>nil then
  begin
    FSheetCells.Bound := Rect(ACol,ARow,ACol,ARow);
    FSheetCells := Value;
  end;{if}
end;{SetCell}
procedure TesaExcelEditor.SetActiveSheetIndex(const Value: Byte);
begin
  if InRange(FActiveSheetIndex,0,SheetCount-1)then
  begin
    FActiveSheetIndex := Value;
    FSheet := FBook.Sheets[FActiveSheetIndex+1];
    FSheet.Select;
    FSheetFont.Size := 8;
  end{if}
  else MsgError(Format(EInvalidIndex,[Value,SheetCount-1]));
end;{SetActiveSheetIndex}
constructor TesaExcelEditor.Create;
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
  //FSheet.Cells[1,1].Value := 1;
  Visible := True;
  Zoom := 50;
end;{Create}
destructor TesaExcelEditor.Destroy;
begin
  FSheetCells.Free;
  FSheetCells := nil;
  FSheetFont.Free;
  FSheetFont := nil;
  FXL.Quit;
  inherited;
end;{Destroy}
//Устанавливаю шапку с пронумерованными столбцами
procedure TesaExcelEditor.SetColumnTitles(ARow,ACol       : Integer;
                                       AColumnTitles   : array of String;
                                       IsNumeredColumns: Boolean = True);
var
  Range      : Variant;
  Cell0,Cell1: String;
  AWidth,I   : Integer;
begin
  AWidth := High(AColumnTitles)-Low(AColumnTitles)+1;
  if AWidth<1 then Exit;
  ARow := Max(1,ARow);
  ACol := Max(1,ACol);
  Cell0 := ColToStr(ACol)+IntToStr(ARow);
  Cell1 := ColToStr(ACol+AWidth-1)+IntToStr(ARow+2-1);
  Range := FSheet.Range[Cell0,Cell1];
  for I := Low(AColumnTitles) to High(AColumnTitles) do
  begin
    FSheet.Cells[ARow,I+1].Value := AColumnTitles[I];
    if IsNumeredColumns
    then FSheet.Cells[ARow+1,I+1].Value := I-Low(AColumnTitles)+1;
  end;{for}
  FSheetCells.Bound := Rect(ACol,ARow,ACol+AWidth-1,ARow);
  FSheetCells.HorizontalAlignment := haCenter;
  FSheetCells.VerticalAlignment := vaCenter;
  FSheetCells.NumberFormat := nfFloat00;
  FSheetCells.WrapText := True;
  Cells[ARow+1,ACol,AWidth,1].HorizontalAlignment := haCenter;
end;{SetColumnTitles}
//Устанавливаю пронумерованную строку
procedure TesaExcelEditor.SetNumericRow(ARow,ACol,AWidth: Integer);
var
  Cell0,Cell1: String;
  I          : Integer;
begin
  if AWidth<1 then Exit;
  ARow := Max(1,ARow);
  ACol := Max(1,ACol);
  Cell0 := ColToStr(ACol)+IntToStr(ARow);
  Cell1 := ColToStr(ACol+AWidth-1)+IntToStr(ARow+2-1);
  for I := ACol to ACol+AWidth-1 do
    FSheet.Cells[ARow,I].Value := I-ACol+1;
  Cells[ARow,ACol,AWidth,1].HorizontalAlignment := haCenter;
end;{SetNumericRow}
procedure TesaExcelEditor.DrawChart(const AChartInfo: RChartInfo);
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
function TesaExcelEditor.DeleteCols(const ACol,AWidth: Integer): Boolean;
begin
  Result := False;
  if (ACol>0)and(AWidth>0)and InRange(ACol+AWidth-1,1,256) then
  begin
    FSheet.Columns[ColToStr(ACol)+':'+ColToStr(ACol+AWidth-1)].Delete(Shift:=xlToLeft);
    Result := True;
  end;{if}
end;{DeleteCols}
//Открываю рабочую книгу
function TesaExcelEditor.LoadFromFile(const AFileName: String): Boolean;
begin
  Result := False;
  try
    FBook.Open(Filename:= AFileName);
    Result := True;
  except
    MsgError('Ошибка открытия файла "'+AFileName+'"');
  end;{try}
end;{LoadFromFile}
//Сохраняю в файл под заданным именем
function TesaExcelEditor.SaveToFile(const AFileName: String): Boolean;
begin
  Result := False;
  try
    if Trim(AFileName)<>'' then
    begin
      FBook.SaveAs(Filename:= AFileName,
                   FileFormat:=xlNormal,
                   Password:='',
                   WriteResPassword:='',
                   ReadOnlyRecommended:=False,
                   CreateBackup:=False);
      Result := True;
    end;{if}
  except
    MsgError('Ошибка записи в файл "'+AFileName+'"');
  end;{try}
end;{SaveToFile}
//Устанавливаю отступы полей текущего листа, мм
procedure TesaExcelEditor.SetPageSetupMargines(const Margins: TRect);
begin
  try
    FSheet.PageSetup.LeftMargin   := FXL.InchesToPoints(Margins.Left/25.4);
    FSheet.PageSetup.RightMargin  := FXL.InchesToPoints(Margins.Right/25.4);
    FSheet.PageSetup.TopMargin    := FXL.InchesToPoints(Margins.Top/25.4);
    FSheet.PageSetup.BottomMargin := FXL.InchesToPoints(Margins.Bottom/25.4);
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupMargines}
//Устанавливаю формат текущего листа при печати: книжный/альбомный
procedure TesaExcelEditor.SetPageSetupOrientation(const Orientation: TXLPrinterOrientation);
begin
  try
    if Orientation=xlpoPortrait
    then FSheet.PageSetup.Orientation := xlPortrait
    else FSheet.PageSetup.Orientation := xlLandscape;
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupMargines}
//Устанавливаю диапазон строк текущего листа, повторяющихся на каждой странице при печати
procedure TesaExcelEditor.SetPageSetupPrintTitleRows(const ARow,AHeight: Integer);
begin
  try
    FSheet.PageSetup.PrintTitleRows := Format('$%d:$%d',[ARow,ARow+AHeight-1]);
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupPrintTitleRows}
//Устанавливаю диапазон столбцов текущего листа, повторяющихся на каждой странице при печати
procedure TesaExcelEditor.SetPageSetupPrintTitleColumns(const ACol,AWidth: Integer);
begin
  try
    FSheet.PageSetup.PrintTitleColumns := Format('$%s:$%s',[ColToStr(ACol),ColToStr(ACol+AWidth-1)]);
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupPrintTitleColumns}
//Устанавливаю верхние заголовки текущего листа при печати
procedure TesaExcelEditor.SetPageSetupHeader(const LeftHeader,CenterHeader,RightHeader: String;
                                             const HeaderMargin: Integer);
begin
  try
    FSheet.PageSetup.LeftHeader   := LeftHeader;
    FSheet.PageSetup.CenterHeader := CenterHeader;
    FSheet.PageSetup.RightHeader  := RightHeader;
    FSheet.PageSetup.HeaderMargin := FXL.InchesToPoints(HeaderMargin/25.4);
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupHeader}
//Устанавливаю нижние заголовки текущего листа при печати
procedure TesaExcelEditor.SetPageSetupFooter(const LeftFooter,CenterFooter,RightFooter: String;
                                           const FooterMargin: Integer);
begin
  try
    FSheet.PageSetup.LeftFooter   := LeftFooter;
    FSheet.PageSetup.CenterFooter := CenterFooter;
    FSheet.PageSetup.RightFooter  := RightFooter;
    FSheet.PageSetup.FooterMargin   := FXL.InchesToPoints(FooterMargin/25.4);
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupFooter}
//Устанавливаю выравнивание текущего листа на странице при печати
procedure TesaExcelEditor.SetPageSetupCentered(const CenterHorizontally,CenterVertically: Boolean);
begin
  try
    FSheet.PageSetup.CenterHorizontally := CenterHorizontally;
    FSheet.PageSetup.CenterVertically := CenterVertically;
  except
    MsgError('Не могу установить параметры печати страницы "'+SheetName+'".');
  end;{try}
end;{SetPageSetupCentered}

//Диапазон ячеек рабочего листа Excel----------------------------------------------------------
constructor TXLCustomCells.Create(Owner: TesaExcelEditor);
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
function TXLCustomCells.GetRange(const ABound: TRect; var ACell: String): Variant;
var
  Cell0,Cell1: String;
  ARow,ACol,AWidth,AHeight: Integer;
begin
  ACol := Min(ABound.Left,ABound.Right);
  AWidth := Max(ABound.Left,ABound.Right)-ACol+1;
  ARow := Min(ABound.Top,ABound.Bottom);
  AHeight := Max(ABound.Top,ABound.Bottom)-ARow+1;

  Cell0 := ColToStr(ACol)+IntToStr(ARow);
  Cell1 := ColToStr(ACol+AWidth-1)+IntToStr(ARow+AHeight-1);
  ACell := Cell0+':'+Cell1;
  Result := FOwner.FBook.Sheets[FOwner.FActiveSheetIndex+1].Range[Cell0,Cell1];
end;{GetRange}

//Шрифт диапазона ячеек рабочего листа Excel---------------------------------------------------
function TXLCellsFont.GetName: String;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := ARange.Font.Name;
  except
    Result := '';
    MsgError('Не могу определить Наименование шрифта для диапазона '+ACell);
  end;{try}
end;{GetName}
function TXLCellsFont.GetSize: Integer;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := ARange.Font.Size;
  except
    Result := 0;
    MsgError('Не могу определить Размер шрифта для диапазона '+ACell);
  end;{try}
end;{GetSize}
function TXLCellsFont.GetStrikeThrough: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := ARange.Font.StrikeThrough;
  except
    Result := False;
    MsgError('Не могу определить Зачеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{GetStrikeThrough}
function TXLCellsFont.GetStyle: TXLFontStyles;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := [];
    if ARange.Font.Bold then Include(Result,xlfsBold);
    if ARange.Font.Italic then Include(Result,xlfsItalic);
  except
    Result := [];
    MsgError('Не могу определить Стиль шрифта для диапазона '+ACell);
  end;{try}
end;{GetStyle}
function TXLCellsFont.GetScript: TXLFontScript;
var
  ARange: Variant;
  ACell: String;
begin
  Result := fpNone;
  try
    ARange := GetRange(FBound,ACell);
    if ARange.Font.SubScript then Result := fpSubScript;
    if ARange.Font.SuperScript then Result := fpSuperScript;
  except
    MsgError('Не могу определить Регистр шрифта для диапазона '+ACell);
  end;{try}
end;{GetScript}
function TXLCellsFont.GetUnderline: TXLFontUnderLine;
var
  ARange: Variant;
  ACell: String;
begin
  Result := fuNone;
  try
    ARange := GetRange(FBound,ACell);
    if ARange.Font.Underline=xlUnderlineStyleNone then Result := fuNone;
    if ARange.Font.Underline=xlUnderlineStyleSingle then Result := fuSingle;
    if ARange.Font.Underline=xlUnderlineStyleDouble then Result := fuDouble;
    if ARange.Font.Underline=xlUnderlineStyleSingleAccounting then Result := fuSingleAccounting;
    if ARange.Font.Underline=xlUnderlineStyleDoubleAccounting then Result := fuDoubleAccounting;
  except
    MsgError('Не могу определить Подчеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{GetUnderline}
procedure TXLCellsFont.SetName(const Value: String);
var
  ARange: Variant;
  ACell: String;
begin
  if Trim(Value)<>'' then
  try
    ARange := GetRange(FBound,ACell);
    ARange.Font.Name := Trim(Value);
  except
    MsgError('Не могу установить Наименование шрифта для диапазона '+ACell);
  end;{try}
end;{SetName}
procedure TXLCellsFont.SetSize(const Value: Integer);
var
  ARange: Variant;
  ACell: String;
begin
  if Value>0 then
  try
    ARange := GetRange(FBound,ACell);
    ARange.Font.Size := Value;
  except
    MsgError('Не могу установить Размер шрифта для диапазона '+ACell);
  end;{try}
end;{SetSize}
procedure TXLCellsFont.SetStrikeThrough(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Font.StrikeThrough := Value;
  except
    MsgError('Не могу установить Зачеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{SetStrikeThrough}
procedure TXLCellsFont.SetStyle(const Value: TXLFontStyles);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Font.Bold := xlfsBold in Value; 
    ARange.Font.Italic := xlfsItalic in Value; 
  except
    MsgError('Не могу установить Стиль шрифта для диапазона '+ACell);
  end;{try}
end;{SetStyle}
procedure TXLCellsFont.SetScript(const Value: TXLFontScript);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Font.SubScript := Value=fpSubScript;
    ARange.Font.SuperScript := Value=fpSuperScript;
  except
    MsgError('Не могу установить Регистр шрифта для диапазона '+ACell);
  end;{try}
end;{SetSubScript}
procedure TXLCellsFont.SetUnderline(const Value: TXLFontUnderLine);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    case Value of
      fuNone            : ARange.Font.Underline := xlUnderlineStyleNone;
      fuSingle          : ARange.Font.Underline := xlUnderlineStyleSingle;
      fuDouble          : ARange.Font.Underline := xlUnderlineStyleDouble;
      fuSingleAccounting: ARange.Font.Underline := xlUnderlineStyleSingleAccounting;
      fuDoubleAccounting: ARange.Font.Underline := xlUnderlineStyleDoubleAccounting;
    end;{case}
  except
    MsgError('Не могу установить Подчеркивание шрифта для диапазона '+ACell);
  end;{try}
end;{SetUnderline}

//Диапазон ячеек рабочего листа Excel----------------------------------------------------------
constructor TXLCells.Create(Owner: TesaExcelEditor);
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
    ARange := GetRange(FBound,ACell);
    ARange.Interior.ColorIndex := AColorIndex;
    ARange.Interior.Pattern    := xlSolid;
  except
    MsgError('Не могу установить цвет ячеек диапазона '+ACell);
  end;{try}
end;{SetColor}

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
    ARange := GetRange(FBound,ACell);
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
    MsgError('Не могу определить Рамку диапазона '+ACell);
  end;{try}
end;{GetFrame}
function TXLCells.GetHorizontalAlignment: TXLHorizontalAlignment;
var
  ARange: Variant;
  ACell: String;
begin
  Result := haLeft;
  try
    ARange := GetRange(FBound,ACell);
    if ARange.HorizontalAlignment=xlGeneral then Result := haGeneral;
    if ARange.HorizontalAlignment=xlLeft then Result := haLeft;
    if ARange.HorizontalAlignment=xlCenter then Result := haCenter;
    if ARange.HorizontalAlignment=xlRight then Result := haRight;
    if ARange.HorizontalAlignment=xlFill then Result := haFill;
    if ARange.HorizontalAlignment=xlJustify then Result := haJustify;
    if ARange.HorizontalAlignment=xlCenterAcrossSelection then Result := haCenterAcrossSelection;
  except
    MsgError('Не могу определить Горизонтальное Выравнивание диапазона '+ACell);
  end;{try}
end;{GetHorizontalAlignment}
function TXLCells.GetMergeCells: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := ARange.MergeCells;
  except
    Result := False;
    MsgError('Не могу определить Объединение Ячеек диапазона '+ACell);
  end;{try}
end;{GetMergeCells}
function TXLCells.GetOrientation: Integer;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := ARange.Orientation;
  except
    Result := 0;
    MsgError('Не могу определить Ориентацию Текста диапазона '+ACell);
  end;{try}
end;{GetOrientation}
function TXLCells.GetVerticalAlignment: TXLVerticalAlignment;
var
  ARange: Variant;
  ACell: String;
begin
  Result := vaCenter;
  try
    ARange := GetRange(FBound,ACell);
    if ARange.VerticalAlignment=xlTop then Result := vaTop;
    if ARange.VerticalAlignment=xlCenter then Result := vaCenter;
    if ARange.VerticalAlignment=xlBottom then Result := vaBottom;
    if ARange.VerticalAlignment=xlJustify then Result := vaJustify;
  except
    MsgError('Не могу определить Вертикальное Выравнивание диапазона '+ACell);
  end;{try}
end;{GetVerticalAlignment}
function TXLCells.GetWrapText: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    Result := ARange.WrapText;
  except
    Result := False;
    MsgError('Не могу определить Перенос По Словам диапазона '+ACell);
  end;{try}
end;{GetWrapText}
procedure TXLCells.SetFrame(const Value: TXLFrameEdges);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
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
    MsgError('Не могу установить Рамку диапазона '+ACell);
  end;{try}
end;{SetFrame}
procedure TXLCells.SetHorizontalAlignment(const Value: TXLHorizontalAlignment);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
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
    MsgError('Не могу установить Горизонтальное Выравнивание диапазона '+ACell);
  end;{try}
end;{SetHorizontalAlignment}
procedure TXLCells.SetMergeCells(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.MergeCells := Value;
  except
    MsgError('Не могу установить Объединение Ячеек диапазона '+ACell);
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
    ARange := GetRange(FBound,ACell);
    case Value of
      nfInt000   : AFormula := '* # 000';
      nfInt00    : AFormula := '* # #00';
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
    MsgError('Не могу установить Числовой Формат диапазона '+ACell);
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
    ARange := GetRange(FBound,ACell);
    for I := 1 to Length(Value) do
      if Value[I] in ['.',','] then Value[I] := DecimalSeparator;
    ARange.NumberFormat := Value;
  except
    MsgError('Не могу установить Числовой Формат диапазона '+ACell);
  end;{try}
end;{SetCustomNumberFormat}
procedure TXLCells.SetOrientation(const Value: Integer);
var
  ARange: Variant;
  ACell: String;
begin
  if InRange(Value,-90,90)then
  try
    ARange := GetRange(FBound,ACell);
    ARange.Orientation := Value;
  except
    MsgError('Не могу установить Ориентацию Текста диапазона '+ACell);
  end;{try}
end;{SetOrientation}
procedure TXLCells.SetVerticalAlignment(const Value: TXLVerticalAlignment);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    case Value of
      vaTop    : ARange.VerticalAlignment := xlTop;
      vaCenter : ARange.VerticalAlignment := xlCenter;
      vaBottom : ARange.VerticalAlignment := xlBottom;
      vaJustify: ARange.VerticalAlignment := xlJustify;
    end;{case}
  except
    MsgError('Не могу установить Вертикальное Выравнивание диапазона '+ACell);
  end;{try}
end;{SetVerticalAlignment}
procedure TXLCells.SetWrapText(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.WrapText := Value;
  except
    MsgError('Не могу установить Перенос По Словам диапазона '+ACell);
  end;{try}
end;{SetWrapText}
procedure TXLCells.SetAsString(const Value: String);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Value := Value;
  except
    MsgError(Format('Не могу присвоить значение "%s" ячейке %s',[Value,ACell]));
  end;{try}
end;{SetAsString}
procedure TXLCells.SetAsFormulaR1C1(const Value: String);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.FormulaR1C1 := Value;
  except
    MsgError(Format('Не могу задать формулу "%s" ячейке %s',[Value,ACell]));
  end;{try}
end;{SetAsFormulaR1C1}
procedure TXLCells.SetAsInteger(const Value: Integer);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Value := Value;
  except
    MsgError(Format('Не могу присвоить значение "%d" ячейке %s',[Value,ACell]));
  end;{try}
end;{SetAsInteger}
procedure TXLCells.SetAsFloat(const Value: Single);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Value := Value;
  except
    MsgError(Format('Не могу присвоить значение "%f" ячейке %s',[Value,ACell]));
  end;{try}
end;{SetAsFloat}
procedure TXLCells.SetAsText(const Value: String);
var
  ARange: Variant;
  ACell: String;
begin
  try
    HorizontalAlignment := haCenter;
    VerticalAlignment := vaCenter;
    WrapText := True;
    if (Width>1)OR(Height>1) then MergeCells := True;
    ARange := GetRange(Rect(FBound.Left,FBound.Top,FBound.Left,FBound.Top),ACell);
    ARange.Value := Value;
  except
    MsgError(Format('Не могу присвоить значение "%s" диапазону ячеек %s',[Value,ACell]));
  end;{try}
end;{SetAsText}
function TXLCells.GetAsInteger: Integer;
var
  ARange: Variant;
  ACell: String;
begin
  Result := 0;
  try
    ARange := GetRange(Rect(FBound.Left,FBound.Top,FBound.Left,FBound.Top),ACell);
    Result := ARange.Value;
  except
    MsgError('Не могу считать значение ячейки '+ACell);
  end;{try}
end;{SetAsInteger}
function TXLCells.GetAsString: String;
var
  ARange: Variant;
  ACell: String;
begin
  Result := '';
  try
    ARange := GetRange(Rect(FBound.Left,FBound.Top,FBound.Left,FBound.Top),ACell);
    Result := ARange.Value;
  except
    MsgError('Не могу считать значение ячейки '+ACell);
  end;{try}
end;{SetAsString}
function TXLCells.GetAsFormaulaR1C1: String;
var
  ARange: Variant;
  ACell: String;
begin
  Result := '';
  try
    ARange := GetRange(Rect(FBound.Left,FBound.Top,FBound.Left,FBound.Top),ACell);
    Result := ARange.FormulaR1C1;
  except
    MsgError('Не могу считать формулу с ячейки '+ACell);
  end;{try}
end;{GetAsFormaulaR1C1}
function TXLCells.GetAsText: String;
var
  ARange: Variant;
  ACell: String;
begin
  Result := '';
  try
    ARange := GetRange(Rect(FBound.Left,FBound.Top,FBound.Left,FBound.Top),ACell);
    Result := ARange.Value;
  except
    MsgError('Не могу считать значение ячейки '+ACell);
  end;{try}
end;{SetAsText}
function TXLCells.GetAsFloat: Single;
var
  ARange: Variant;
  ACell: String;
begin
  Result := 0.0;
  try
    ARange := GetRange(Rect(FBound.Left,FBound.Top,FBound.Left,FBound.Top),ACell);
    Result := ARange.Value;
  except
    MsgError('Не могу считать значение ячейки '+ACell);
  end;{try}
end;{SetAsFloat}

function TXLCells.GetFreezePanes: Boolean;
var
  ARange: Variant;
  ACell: String;
begin
  Result := False;
  try
    ARange := GetRange(FBound,ACell);
    Select;
    Result := FOwner.FXL.ActiveWindow.FreezePanes;
  except
    MsgError('Не могу считать разбиение диапазон ячеек '+ACell);
  end;{try}
end;{GetFreezePanes}
procedure TXLCells.SetFreezePanes(const Value: Boolean);
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Select;
    FOwner.FXL.ActiveWindow.FreezePanes := Value;
  except
    MsgError('Не могу разбить диапазон ячеек '+ACell);
  end;{try}
end;{GetFreezePanes}

procedure TXLCells.Select;
var
  ARange: Variant;
  ACell: String;
begin
  try
    ARange := GetRange(FBound,ACell);
    ARange.Select;
  except
    MsgError('Не могу выделить диапазон ячеек '+ACell);
  end;{try}
end;{Select}

end.

