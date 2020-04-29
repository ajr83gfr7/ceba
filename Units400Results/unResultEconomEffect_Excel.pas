unit unResultEconomEffect_Excel;

interface
uses
  SysUtils, OleServer, ExcelXP, unExcel, Variants;
//  Windows, Messages, , Classes, Graphics, Controls, Forms,
//  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, ActnList,

type
  TExcelDocEconomEffect = class(TExcelDoc)
  private
  protected
  public
    procedure SetData(sg: Variant; colcount, rowcount: integer); override;
  end;

implementation
uses
  unResultEconomEffect_Const, Grids;

{ TExcelDocEconomEffect }

//Основные показатели эффективности
//Дата формирования:date
//-------------------------------------
//| Параметр | Варианты моделирования |
//-------------------------------------
//|          | 0 to countOfVariants   |
//-------------------------------------
//| Данные с CEBEDAN                  |
//-------------------------------------
//|          |                        |
//-------------------------------------
//| Входные данные                    |
//-------------------------------------
//|          |                        |
//-------------------------------------
//| Выходные данные                   |
//-------------------------------------
//|          |                        |
//-------------------------------------

procedure TExcelDocEconomEffect.SetData(sg: Variant; colcount, rowcount: integer);
var
  title_range: OLEVariant;
  date_range: OLEVariant;
  Cell_1, Cell_2: OLEVariant;
  maxcol: integer;
  //
  _sg: TStringGrid;
  data_to_excel: Variant;
  i, j: integer;
begin
  inherited;

  maxcol:= colcount + 1;
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[1, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[1, maxcol];
  title_range:= document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  title_range.Merge;
  title_range.Value:= GRID_TITLE;

  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[2, maxcol - 2];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[2, maxcol];
  date_range:= document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.Merge;
  date_range.Value:= Format(GRID_DATE,[FormatDateTime('dd/mm/yy', Now)]);

  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[4, 1];
  date_range:= document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.Merge;
  date_range.Value:= GRID_PARAM;

  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 2];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[3, maxcol];
  date_range:= document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.Merge;
  date_range.Value:= GRID_VARIANTS;

  //sebadan data
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[4, 2];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[4 + rowcount-1, maxcol];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.Value:=sg;

  //params name
  _sg:= TStringGrid.Create(nil);
  _sg.RowCount:= 42-1-1-1;
  _sg.ColCount:= 1;

  j:= 0;
  _sg.Cells[0, j]:= WORKFLOW_OF_SHIHT; inc(j);
  _sg.Cells[0, j]:= WORKFLOW_OF_YEAR; inc(j);
  _sg.Cells[0, j]:= WEIGHT_OF_ORE; inc(j);
  _sg.Cells[0, j]:= TIMEFLOW_OF_SHIHT; inc(j);
  _sg.Cells[0, j]:= COST_OF_GTK; inc(j);
  _sg.Cells[0, j]:= COST_OF_M3; inc(j);
  _sg.Cells[0, j]:= CASH_EMPLOEE; inc(j);
  _sg.Cells[0, j]:= KOEF_OF_ROCK; inc(j);
  _sg.Cells[0, j]:= KOEF_SHIHTCHANGE; inc(j);
//  _sg.Cells[0, j]:= KOEF_PUNKT_BUZY; inc(j);
  _sg.Cells[0, j]:= KOEF_AUTOUSE; inc(j);
  _sg.Cells[0, j]:= COUNT_EXCV_ON_LOAD; inc(j);
  _sg.Cells[0, j]:= RASHOD_OF_ELECTRIC; inc(j);
  _sg.Cells[0, j]:= COST_OF_ELECTRIC_1KV; inc(j);
  _sg.Cells[0, j]:= SUMCOST_OF_EXCV; inc(j);
  _sg.Cells[0, j]:= COUNT_OF_UNLOAD_PUNKT; inc(j);
  _sg.Cells[0, j]:= SUMCOST_OF_ROAD; inc(j);
  _sg.Cells[0, j]:= LENGTH_OF_ROAD; inc(j);
  _sg.Cells[0, j]:= COST_OF_ROAD_SUPPORT; inc(j);
  _sg.Cells[0, j]:= COUNT_OF_AUTOS; inc(j);
//  _sg.Cells[0, j]:= KPD_AUTO_TRANSMISSION; inc(j);
  _sg.Cells[0, j]:= RASHOD_TYRES; inc(j);
  _sg.Cells[0, j]:= COST_OF_1TYRE; inc(j);
  _sg.Cells[0, j]:= COST_ON_TYRES; inc(j);
  _sg.Cells[0, j]:= COST_ON_1GSM; inc(j);
  _sg.Cells[0, j]:= RASHOD_GSM; inc(j);
  _sg.Cells[0, j]:= RASHOD_GSM_FOR_LITER; inc(j);
  _sg.Cells[0, j]:= SUMCOST_OF_AUTOS; inc(j);
//  _sg.Cells[0, j]:= OSTAT_COST; inc(j);
  //--------------------------------------
  _sg.Cells[0, j]:= PRODUCT_FROM_1TONNA; inc(j);
  _sg.Cells[0, j]:= PRICE_FOR_1TONNA; inc(j);
  _sg.Cells[0, j]:= COST_GTR; inc(j);
  _sg.Cells[0, j]:= COST_FOR_AUTO; inc(j);
  _sg.Cells[0, j]:= COST_FOR_SERVICE; inc(j);
  _sg.Cells[0, j]:= COST_FOR_BASE_VARIANT; inc(j);
  _sg.Cells[0, j]:= PLANNED_VALUE; inc(j);
  //--------------------------------------
  _sg.Cells[0, j]:= PROFIT; inc(j);
  _sg.Cells[0, j]:= COSTS; inc(j);
  _sg.Cells[0, j]:= USLOVN_ECONOMIC_EFFECT; inc(j);
  _sg.Cells[0, j]:= BASE_VARIANT; inc(j);
  _sg.Cells[0, j]:= OTNOSIT_ECONOMIC_EFFECT; inc(j);
  _sg.Cells[0, j]:= VALUED_ECONOMIC_EFFECT; inc(j);

  data_to_excel:= VarArrayCreate([1, _sg.RowCount, 1, _sg.ColCount],varVariant);
  for i:= 1 to VarArrayHighBound(data_to_excel, 1) do
    for j:= 1 to VarArrayHighBound(data_to_excel, 2) do
      data_to_excel[i, j]:=_sg.Cells[j-1, i-1];

  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[5, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[5 + _sg.RowCount-1, 1];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.Value:=data_to_excel;

  //input data
  (*
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[34, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[34, maxcol];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.Merge;
  date_range.Value:= GRID_INPUT;
  *)
  //border
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[4 + _sg.RowCount, maxcol];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];

  date_range.Borders[xlEdgeBottom].LineStyle:=xlDouble;
  date_range.Borders[xlEdgeTop].LineStyle:=xlDouble;
  date_range.Borders[xlEdgeLeft].LineStyle:=xlDouble;
  date_range.Borders[xlEdgeRight].LineStyle:=xlDouble;
  date_range.Borders[xlInsideHorizontal].LineStyle:=xlSolid;
  date_range.Borders[xlInsideVertical].LineStyle:=xlSolid;
  //autofit
  document.ActiveWorkBook.ActiveSheet.Columns.ColumnWidth:= 13;
  document.ActiveWorkBook.ActiveSheet.Columns[1].Autofit;

  //Title of Document
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[1, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[1, maxcol];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.HorizontalAlignment:= xlCenter;
  date_range.VerticalAlignment:= xlCenter;
  date_range.Font.Size:= 14;
  date_range.Font.Bold:= 4;
  date_range.RowHeight:= 30;
  //
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[2, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[2, maxcol];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.HorizontalAlignment:= xlRight;
  date_range.Font.Size:= 9;

  //Title of Table
  Cell_1:= document.ActiveWorkBook.ActiveSheet.Cells[3, 1];
  Cell_2:= document.ActiveWorkBook.ActiveSheet.Cells[4, maxcol];
  date_range:=document.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2];
  date_range.HorizontalAlignment := xlCenter;
  date_range.VerticalAlignment := xlCenter;
  date_range.Font.Size:= 12;
  date_range.Font.Bold:= 4;
  date_range.RowHeight:= 30;
end;

end.
