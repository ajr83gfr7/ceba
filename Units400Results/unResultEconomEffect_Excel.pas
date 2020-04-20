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
  _sg.RowCount:= 42;
  _sg.ColCount:= 1;

  _sg.Cells[0, 0]:= WORKFLOW_OF_SHIHT;
  _sg.Cells[0, 1]:= WORKFLOW_OF_YEAR;
  _sg.Cells[0, 2]:= WEIGHT_OF_ORE;
  _sg.Cells[0, 3]:= TIMEFLOW_OF_SHIHT;
  _sg.Cells[0, 4]:= COST_OF_GTK;
  _sg.Cells[0, 5]:= COST_OF_M3;
  _sg.Cells[0, 6]:= CASH_EMPLOEE;
  _sg.Cells[0, 7]:= KOEF_OF_ROCK;
  _sg.Cells[0, 8]:= KOEF_SHIHTCHANGE;
  _sg.Cells[0, 9]:= KOEF_PUNKT_BUZY;
  _sg.Cells[0, 10]:= KOEF_AUTOUSE;
  _sg.Cells[0, 11]:= COUNT_EXCV_ON_LOAD;
  _sg.Cells[0, 12]:= RASHOD_OF_ELECTRIC;
  _sg.Cells[0, 13]:= COST_OF_ELECTRIC_1KV;
  _sg.Cells[0, 14]:= SUMCOST_OF_EXCV;
  _sg.Cells[0, 15]:= COUNT_OF_UNLOAD_PUNKT;
  _sg.Cells[0, 16]:= SUMCOST_OF_ROAD;
  _sg.Cells[0, 17]:= LENGTH_OF_ROAD;
  _sg.Cells[0, 18]:= COST_OF_ROAD_SUPPORT;
  _sg.Cells[0, 19]:= COUNT_OF_AUTOS;
  _sg.Cells[0, 20]:= KPD_AUTO_TRANSMISSION;
  _sg.Cells[0, 21]:= RASHOD_TYRES;
  _sg.Cells[0, 22]:= COST_OF_1TYRE;
  _sg.Cells[0, 23]:= COST_ON_TYRES;
  _sg.Cells[0, 24]:= COST_ON_1GSM;
  _sg.Cells[0, 25]:= RASHOD_GSM;
  _sg.Cells[0, 26]:= RASHOD_GSM_FOR_LITER;
  _sg.Cells[0, 27]:= SUMCOST_OF_AUTOS;
  _sg.Cells[0, 28]:= OSTAT_COST;
  //--------------------------------------
  _sg.Cells[0, 29]:= PRODUCT_FROM_1TONNA;
  _sg.Cells[0, 30]:= PRICE_FOR_1TONNA;
  _sg.Cells[0, 31]:= COST_GTR;
  _sg.Cells[0, 32]:= COST_FOR_AUTO;
  _sg.Cells[0, 33]:= COST_FOR_SERVICE;
  _sg.Cells[0, 34]:= COST_FOR_BASE_VARIANT;
  _sg.Cells[0, 35]:= PLANNED_VALUE;
  //--------------------------------------
  _sg.Cells[0, 36]:= PROFIT;
  _sg.Cells[0, 37]:= COSTS;
  _sg.Cells[0, 38]:= USLOVN_ECONOMIC_EFFECT;
  _sg.Cells[0, 39]:= BASE_VARIANT;
  _sg.Cells[0, 40]:= OTNOSIT_ECONOMIC_EFFECT;
  _sg.Cells[0, 41]:= VALUED_ECONOMIC_EFFECT;

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
