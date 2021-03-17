unit unResultEconomParams_Excel;

interface
uses
  SysUtils, OleServer, ExcelXP, unExcel, Variants;

const
  SAVE_IS_SUCCESS = 'Отчет успешно сохранен.';
  SAVE_IS_WARNING = 'Сохранение отчета не выполненно.';
  APP_NAME = 'CEBADAN';
  //
  GRID_TITLE = 'Экономические показатели';
  GRID_DATE = 'Дата создания: %s';

type
  TExcelDocEconomParams = class(TExcelDoc)
  private
  protected
  public
    procedure SetData(sg: Variant; colcount, rowcount: integer); override;
  end;

implementation
uses
  Grids;

{ TExcelDocEconomParams }

//Основные показатели эффективности
//Дата формирования:date
//--------------------------------------------------------
//| №   | Параметры | За смену | За ср.смену | За период |
//--------------------------------------------------------
//| I   | Затраты по автосамосвалам                      |
//--------------------------------------------------------
//|     |           |          |             |           |
//--------------------------------------------------------
//| II  | Затраты по экскаваторами                       |
//--------------------------------------------------------
//|     |           |          |             |           |
//--------------------------------------------------------
//| III | Затраты по блок-участкам                       |
//--------------------------------------------------------
//|     |           |          |             |           |
//--------------------------------------------------------
//| IV  | Суммарные показатели                           |
//--------------------------------------------------------
//|     |           |          |             |           |
//--------------------------------------------------------

procedure TExcelDocEconomParams.SetData(sg: Variant; colcount,
  rowcount: integer);
var
  cell_range: OLEVariant;
  cell_1, cell_2: OLEVariant;
begin
  inherited;

  //title of document
  cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[1, 1];
  cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[1, colcount];
  cell_range:= document.ActiveWorkBook.ActiveSheet.Range[cell_1, cell_2];
  cell_range.Merge;
  cell_range.Value:= GRID_TITLE;
  cell_range.HorizontalAlignment:= xlCenter;
  cell_range.VerticalAlignment:= xlCenter;
  cell_range.Font.Size:= 14;
  cell_range.Font.Bold:= 4;
  cell_range.RowHeight:= 30;

  //time of document
  cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[2, colcount - 1];
  cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[2, colcount];
  cell_range:= document.ActiveWorkBook.ActiveSheet.Range[cell_1, cell_2];
  cell_range.Merge;
  cell_range.Value:= Format(GRID_DATE,[FormatDateTime('dd/mm/yy', Now)]);
  cell_range.HorizontalAlignment:= xlRight;
  cell_range.Font.Size:= 9;

  //cebadan data
  cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 1];
  cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[3 + rowcount-1, colcount];
  cell_range:= document.ActiveWorkBook.ActiveSheet.Range[cell_1, cell_2];
  cell_range.Value:= sg;

  //title of table
  cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 1];
  cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[3, colcount];
  cell_range:= document.ActiveWorkBook.ActiveSheet.Range[cell_1, cell_2];
  cell_range.HorizontalAlignment:= xlCenter;
  cell_range.VerticalAlignment:= xlCenter;
  cell_range.Font.Size:= 12;
  cell_range.RowHeight:= 30;

  //border
  cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 1];
  cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[3 + rowcount-1, colcount];
  cell_range:= document.ActiveWorkBook.ActiveSheet.Range[cell_1, cell_2];

  cell_range.Borders[xlEdgeBottom].LineStyle:= xlDouble;
  cell_range.Borders[xlEdgeTop].LineStyle:= xlDouble;
  cell_range.Borders[xlEdgeLeft].LineStyle:= xlDouble;
  cell_range.Borders[xlEdgeRight].LineStyle:= xlDouble;
  cell_range.Borders[xlInsideHorizontal].LineStyle:= xlSolid;
  cell_range.Borders[xlInsideVertical].LineStyle:= xlSolid;
  //autofit
  document.ActiveWorkBook.ActiveSheet.Columns.ColumnWidth:= 18;
  document.ActiveWorkBook.ActiveSheet.Columns[1].Autofit;
  document.ActiveWorkBook.ActiveSheet.Columns[2].Autofit;
  document.ActiveWorkBook.ActiveSheet.Columns.HorizontalAlignment:= xlCenter;
  document.ActiveWorkBook.ActiveSheet.Columns.VerticalAlignment:= xlCenter;
  document.ActiveWorkBook.ActiveSheet.Columns[2].HorizontalAlignment:= xlLeft;
  document.ActiveWorkBook.ActiveSheet.Cells[3, 2].HorizontalAlignment:= xlCenter;
end;

end.
