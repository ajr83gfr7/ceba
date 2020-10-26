unit unResultEconomEffect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, ActnList,
  DB, ADODB,
  TXTWriter,
  unResultEconomEffect_Excel, unResultEconomEffect_Data,
  EconomicModule;

type
//TAction with TDataSet
//http://roman.yankovsky.me/?p=896
//excel
//https://yandex.kz/turbo?text=https%3A%2F%2Fwebdelphi.ru%2F2009%2F08%2Frabota-s-excel-v-delphi-osnovy-osnov%2F
  TfmResultEconomEffect = class(TForm)
    gbxVariant: TGroupBox;
    Splitter1: TSplitter;
    gbxValue: TGroupBox;
    dbgVariant: TDBGrid;
    qryVariants: TADOQuery;
    dsVariants: TDataSource;
    qryResultVariants: TADOQuery;
    gbxCebadan: TGroupBox;
    edEmploymentRatio: TEdit;
    edResultPeriodCoef: TEdit;
    edKVsry: TEdit;
    edSalary: TEdit;
    edUdelQtn: TEdit;
    edTotalCostsSummary: TEdit;
    edParamsShiftDuration: TEdit;
    edSelic: TEdit;
    edProizPeriod: TEdit;
    edRocksVm3: TEdit;
    edWorkTimeUsingRatio: TEdit;
    edShiftExcavators: TEdit;
    edElec: TEdit;
    edElectr: TEdit;
    edExcavsCostsSummary: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    gbxInput: TGroupBox;
    gbxOutput: TGroupBox;
    edCountUnLodingPunkts: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    edBlocksCostsSummary: TEdit;
    Label18: TLabel;
    edBLength: TEdit;
    Label19: TLabel;
    edZatrat: TEdit;
    Label20: TLabel;
    edShiftAutos: TEdit;
    Label21: TLabel;
    edStoiGx: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edAVGTransKPD: TEdit;
    edUdelTyres: TEdit;
    edStoiTyre: TEdit;
    edSTyres: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label26: TLabel;
    edUdelGx: TEdit;
    edGx: TEdit;
    edAutosCostsSummary: TEdit;
    edOstat: TEdit;
    edProduk: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    edQtnGM: TEdit;
    edBaseVar: TEdit;
    edZatSer: TEdit;
    edStoiPrib: TEdit;
    edStoiGTR: TEdit;
    edSenaProd: TEdit;
    edPribil: TEdit;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    edOriUsEcom: TEdit;
    edOtnoEcom: TEdit;
    edBaseVari: TEdit;
    edUsEcom: TEdit;
    edRashot: TEdit;
    btnEnter: TButton;
    btnCalc: TButton;
    Label45: TLabel;
    Label46: TLabel;
    saveas: TSaveDialog;
    pnlVariant: TPanel;
    btnDelVariant: TButton;
    btnSetBase: TButton;
    ActionList1: TActionList;
    actSetBaseVariant: TAction;
    actGetBaseVariant: TAction;
    Label47: TLabel;
    Label48: TLabel;
    btnPrintToExcel: TButton;
    Label49: TLabel;
    btnSetLikeBase: TButton;
    Label43: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label44: TLabel;
    Label50: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgVariantCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure btnDelVariantClick(Sender: TObject);
    procedure actSetBaseVariantExecute(Sender: TObject);
    procedure dbgVariantDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnPrintToExcelClick(Sender: TObject);
    procedure btnSetLikeBaseClick(Sender: TObject);
  private
    _economics: TResultVariants;
    function getCountOfUnloadingPunkts(openpitName: string): integer;
    function getOpenpitId(openpitName: string): integer;

    procedure GridOpenVariants();

    procedure GetData();
    procedure SetView();
    function ToExcel(sg: Variant; colcount, rowcount: integer): boolean;
  public
    { Public declarations }
  end;

var
  fmResultEconomEffect: TfmResultEconomEffect;

procedure esaShowResultEconomEffect();
implementation

uses
  unResultEconomEffect_Const, unDM, unExcel;

{$R *.dfm}
procedure esaShowResultEconomEffect();
begin
  fmResultEconomEffect := TfmResultEconomEffect.Create(nil);
  try
    fmResultEconomEffect.ShowModal;
  finally
    fmResultEconomEffect.Free;
  end;
end;

procedure TfmResultEconomEffect.FormShow(Sender: TObject);
begin
  _economics:= TResultVariants.Create();
  GridOpenVariants();
  GetData();
  SetView();
end;

procedure TfmResultEconomEffect.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: integer;
begin
  qryVariants.Close;
  qryResultVariants.Close;
  _economics.Destroy;
end;

procedure TfmResultEconomEffect.dbgVariantCellClick(Column: TColumn);
begin
  _economics.CurrentVariantId:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  GetData();
end;

procedure TfmResultEconomEffect.GetData;
var
  _economic: TEconomicResult;

  function str(dbl: double): string;
  begin
    Result:= Format('%n', [dbl]);
  end;
begin
  _economic:= _economics.CurrentVariant;
  with _economic do
  begin
    edRocksVm3.Text:= str(VolumeOfGM_m3_avg);
    edProizPeriod.Text:= str(VolumeOfGM_m3_byYear);
    edSelic.Text:= str(VolumeOfOre);

    edParamsShiftDuration.Text:= str(ShiftTimelap);
    edTotalCostsSummary.Text:= str(TotalCost / 1e6);
    edUdelQtn.Text:= str(UdelCost);
    edSalary.Text:= str(Salary);
    edKVsry.Text:= str(CoefOfVsry);
    edResultPeriodCoef.Text:= str(CoefOfPeriodShift);

    edWorkTimeUsingRatio.Text:= str(CoefOfUseAutos);
    edShiftExcavators.Text:= str(ExcavatorsCount);
    edElec.Text:= str(ElectricityCost);
    edElectr.Text:= str(ElectricityCostByShift);
    edExcavsCostsSummary.Text:= str(TotalExcavatorsCost);
    //
    edCountUnLodingPunkts.Text:= str(getCountOfUnloadingPunkts(NameOfVariant));
    edBlocksCostsSummary.Text:= str(TotalRoadsCost);
    edBLength.Text:= str(TotalRoadsLength);
    edZatrat.Text:= str(RoadCostByYear);
    edShiftAutos.Text:= str(AutosCount);

    edUdelTyres.Text:= str(TyreUdelCost);
    edStoiTyre.Text:= str(TyrePrice);
    edSTyres.Text:= str(TytesCostByShift);
    edStoiGx.Text:= str(GSMPrice);
    edUdelGx.Text:= str(GSMUdelCost);
    edGx.Text:= str(GSMCost);
    edAutosCostsSummary.Text:= str(TotalAutosCost);

  //--------------------------------------------------------------------------
    edProduk.Text:= str(ResultBy1Tonna);
    edSenaProd.Text:= str(PriceBy1Tonna);
    edStoiGTR.Text:= str(GTRCost);
    edStoiPrib.Text:= str(TruckCost);
    edZatSer.Text:= str(ServiceTruckCost / 1e3);
    edBaseVar.Text:= str(0.0);
    edQtnGM.Text:= str(PlanVolume_m3);// / 1e3);
  //--------------------------------------------------------------------------
    edPribil.Text:= str(Profit / 1e6);
    edRashot.Text:= str(TotalShiftCost / 1e6);
    edUsEcom.Text:= str(UEconomicEffect / 1e6);
    edBaseVari.Text:= str(0.0);
    edOtnoEcom.Text:= str(OEconomicEffect / 1e6);
    edOriUsEcom.Text:= str(OOUEconomicEffect / 1e6);
  end;
  _economic:= nil;
  _economic:= _economics.BaseVariant;
  edBaseVar.Text:= str(_economic.TotalCost / 1e6);
end;

procedure TfmResultEconomEffect.GridOpenVariants;
begin
  with qryVariants do
  begin
    SQL.Text:= SELECT_ALL_VARIANTS;
    Open;
  end;
  dbgVariant.DataSource.DataSet.Last;
  //width
  dbgVariant.Columns[0].Visible:= false;
  dbgVariant.Columns[1].Width:= WIDTH_VARIANT_NAME;
  dbgVariant.Columns[2].Width:= WIDTH_DATE;
  //titles
  dbgVariant.Columns[1].Title.Caption:= NAME_OF_VARIANT;
  dbgVariant.Columns[2].Title.Caption:= DATE_OF_VARIANT;
  //scrol bars
  TDrawGrid(dbgVariant).ScrollBars := ssNone;//ssVertical; //ssHorizontal, ssBoth, ssNone.
  //
  //DBGrid1.Canvas.Brush.Color
  _economics.CurrentVariantId:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
end;

procedure TfmResultEconomEffect.SetView;
begin
  Label1.Caption:= WORKFLOW_OF_SHIHT;
  Label2.Caption:= WORKFLOW_OF_YEAR;
  Label3.Caption:= WEIGHT_OF_ORE;
  Label4.Caption:= TIMEFLOW_OF_SHIHT;
  Label5.Caption:= COST_OF_GTK;
  Label6.Caption:= COST_OF_M3;
  Label7.Caption:= CASH_EMPLOEE;
  Label8.Caption:= KOEF_OF_ROCK;
  Label9.Caption:= KOEF_SHIHTCHANGE;
  Label10.Caption:= KOEF_PUNKT_BUZY;
  Label11.Caption:= KOEF_AUTOUSE;
  Label12.Caption:= COUNT_EXCV_ON_LOAD;
  Label13.Caption:= RASHOD_OF_ELECTRIC;
  Label14.Caption:= COST_OF_ELECTRIC_1KV;
  Label15.Caption:= SUMCOST_OF_EXCV;

  Label16.Caption:= COUNT_OF_UNLOAD_PUNKT;
  Label17.Caption:= SUMCOST_OF_ROAD;
  Label18.Caption:= LENGTH_OF_ROAD;
  Label19.Caption:= COST_OF_ROAD_SUPPORT;
  Label20.Caption:= COUNT_OF_AUTOS;
//  Label21.Caption:= KPD_AUTO_TRANSMISSION;
  Label22.Caption:= RASHOD_TYRES;
  Label23.Caption:= COST_OF_1TYRE;
  Label24.Caption:= COST_ON_TYRES;
  Label25.Caption:= COST_ON_1GSM;
  Label26.Caption:= RASHOD_GSM;
  Label27.Caption:= RASHOD_GSM_FOR_LITER;
  Label28.Caption:= SUMCOST_OF_AUTOS;
//  Label29.Caption:= OSTAT_COST;

  Label30.Caption:= PRODUCT_FROM_1TONNA;
  Label31.Caption:= PRICE_FOR_1TONNA;
  Label32.Caption:= COST_GTR;
  Label33.Caption:= COST_FOR_AUTO;
  Label34.Caption:= COST_FOR_SERVICE;
  Label35.Caption:= COST_FOR_BASE_VARIANT;
  Label36.Caption:= PLANNED_VALUE;
  Label37.Caption:= PROFIT;
  Label38.Caption:= COSTS;
  Label39.Caption:= USLOVN_ECONOMIC_EFFECT;
  Label40.Caption:= BASE_VARIANT;
  Label41.Caption:= OTNOSIT_ECONOMIC_EFFECT;
  Label42.Caption:= VALUED_ECONOMIC_EFFECT;

  Caption:= FORM_VARIABLES;
  gbxVariant.Caption:= VARIANTS_TITLE;
  gbxValue.Caption:= VARIANT_VARIABLES;
  gbxCebadan.Caption:= CEBADAN_VARIABLES;
  gbxInput.Caption:= INPUT_VARIABLES;
  gbxOutput.Caption:= OUTPUT_VARIABLES;
  //btnOutput.Caption:= _OUTPUT;

  Label45.Caption:= ENTER_DATA;
  btnEnter.Caption:= TO_ENTER;
  Label46.Caption:= CALC_DATA;
  btnCalc.Caption:= TO_CALC;
  btnCalc.Enabled:= False;

  Label47.Caption:= SET_AS_BASE;
  btnSetBase.Caption:= TO_SET;
  Label48.Caption:= DELL_VARIANT;
  btnDelVariant.Caption:= TO_DELL;
  Label49.Caption:= PRINT_TO_EXCEL;
  btnPrintToExcel.Caption:= TO_PRINT;
  Label43.Caption:= GET_BASE_DATA;
  btnSetLikeBase.Caption:= TO_GET;

  saveas.Title:= SAVE_REPORT;

  Label44.Caption:= COLOR_OF_BASE_VARIANT;
  Label50.Caption:= COLOR_OF_CURRENT_VARIANT;
end;

procedure TfmResultEconomEffect.btnEnterClick(Sender: TObject);
var
  _isEntered: boolean;
  current_variant: TEconomicResult;
  _productOutPutPercent, _productPriceCtg, _MTWorkByScheduleCtg,
  _truckCostCtg, _serviceExpensesCtg, _baseVariantExpenesCtg,
  _plannedRockVolumeCm: double;

  function fromstr(str: string): double;
  var
    i: integer;
  begin
    Result:= 0;
    if DecimalSeparator = ',' then
      str:= StringReplace(str, '.', ',', [rfReplaceAll, rfIgnoreCase])
    else
      str:= StringReplace(str, ',', '.', [rfReplaceAll, rfIgnoreCase]);

    for i:= 0 to length(str)-1 do
    begin
      if (str[i] = '') or (str[i] = ' ') then
        Delete(str, i, 1);
      if (str[i] = ' ') then
        Delete(str, i, 5);
    end;
    Result:= strtofloat(str);
  end;
begin
  _productOutPutPercent:= fromstr(edProduk.Text);
  _productPriceCtg:= fromstr(edSenaProd.Text) / 1000;
  _MTWorkByScheduleCtg:= fromstr(edStoiGTR.Text);
  _truckCostCtg:= fromstr(edStoiPrib.Text) / 1000    ;
  _serviceExpensesCtg:= fromstr(edZatSer.Text);
  _baseVariantExpenesCtg:= fromstr(edBaseVar.Text);
  _plannedRockVolumeCm:= fromstr(edQtnGM.Text);

  current_variant:= _economics.CurrentVariant;

  _isEntered:= current_variant.SaveInputValues(_productOutPutPercent,
  _productPriceCtg, _MTWorkByScheduleCtg, _truckCostCtg,
  _serviceExpensesCtg, _baseVariantExpenesCtg, _plannedRockVolumeCm);

  if _isEntered then
  begin
    btnCalc.Enabled:= True;
    MessageBox(0, PAnsiChar(ENTERED_DONE), PAnsiChar(APP_NAME), MB_OK);
  end
  else
    MessageBox(0, PAnsiChar(ENTERED_WRONG), PAnsiChar(APP_NAME), MB_OK);

  current_variant.ToUpdate;
end;

procedure TfmResultEconomEffect.btnCalcClick(Sender: TObject);
var
  _economic: TEconomicResult;
  function str(dbl: double): string;
  begin
    Result:= Format('%n', [dbl]);
  end;
begin
  _economic:= _economics.CurrentVariant;
  with _economic do
    try
      edPribil.Text:= str(Profit / 1e6);
      edRashot.Text:= str(TotalCost / 1e6);
      edUsEcom.Text:= str(UEconomicEffect / 1e6);
      edBaseVari.Text:= str(0.0);
      edOtnoEcom.Text:= str(OEconomicEffect / 1e6);
      edOriUsEcom.Text:= str(OOUEconomicEffect / 1e6);
    except
      // todo: Создать новые Exceptions
      MessageBox(0, PAnsiChar(IS_ERROR), PAnsiChar(APP_NAME), MB_OK);
    end;
end;

function TfmResultEconomEffect.ToExcel(sg: Variant; colcount, rowcount: integer): boolean;
var
  doc: TExcelDocEconomEffect;
  _filename: string;
  saver: TSaveDialog;
begin
  Result:= false;

  saver:= TSaveDialog.Create(nil);
  with saver do
    try
      InitialDir := GetCurrentDir;
      Filter := '*.xls|*.xlsx';
      DefaultExt := 'xls';
      FilterIndex := 1;
      if Execute then
        _filename:= FileName;
    finally
      Destroy;
    end;

  doc:= TExcelDocEconomEffect.Create();
  with doc do
    try
      SetData(sg, colcount, rowcount);
      Result:= SaveWorkBook(_filename, 1);
    finally
      Destroy;
    end;
end;

procedure TfmResultEconomEffect.btnDelVariantClick(Sender: TObject);
var
  _qry: TADOQuery;
  _question: integer;
begin
  _question:= MessageDlg(DO_YOU_SURE_TO_DELL, mtConfirmation, mbOKCancel, 0);
  if _question = mrOK then
  begin
    _qry:= TADOQuery.Create(nil);
    _qry.Connection:= fmDM.ADOConnection;
    with _qry do
      try
        Close;
        SQL.Clear;
        SQL.Text:= DELETE_VARIANT_BY_ID;
        Parameters.ParamByName('Id_ResultVariant').Value:= _economics.CurrentVariantId;
        ExecSQL;
        MessageBox(0, PAnsiChar(DELL_VARIANT_IS_SUCCESS), PAnsiChar(APP_NAME), MB_OK);
      finally
        Close;
        Free;
      end;
    _economics.DeleteItem(_economics.CurrentVariantId);
    _economics.CurrentVariantId:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  end;
  GridOpenVariants;
  GetData;
end;

procedure TfmResultEconomEffect.actSetBaseVariantExecute(Sender: TObject);
var
  _qry: TADOQuery;
  _question: integer;
begin
  _question:= MessageDlg(DO_YOU_SURE_TO_SET_BASE_VARIANT, mtConfirmation, mbOKCancel, 0);
  if _question = mrOk then
  begin
    _qry:= TADOQuery.Create(nil);
    _qry.Connection:= fmDM.ADOConnection;
    with _qry do
      try
        try
          Close;
          SQL.Clear;
          SQL.Text:= UPDATE_VARIANTS_TO_OFF;
          ExecSQL;
        except
          MessageBox(0, PAnsiChar(SQL_ERROR_UPDATE), PAnsiChar(APP_NAME), MB_OK);
        end;
        try
          Close;
          SQL.Clear;
          SQL.Text:= UPDATE_NEW_BASE_VARIANT;
          Parameters.ParamByName('NewId_ResultVariant').Value:= _economics.CurrentVariantId;
          ExecSQL;
          MessageBox(0, PAnsiChar(SET_BASE_VARIANT), PAnsiChar(APP_NAME), MB_OK)
        except
          MessageBox(0, PAnsiChar(SQL_ERROR_UPDATE), PAnsiChar(APP_NAME), MB_OK);
        end;
      finally
        Close;
        Free;
      end;
    _economics.BaseVariant:= _economics.CurrentVariant;
    GridOpenVariants;
  end;
end;

procedure TfmResultEconomEffect.dbgVariantDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if dbgVariant.DataSource.DataSet['Id_ResultVariant'] = _economics.BaseVariantId then
    dbgVariant.Canvas.Brush.Color:= clBlue;
  dbgVariant.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmResultEconomEffect.btnPrintToExcelClick(Sender: TObject);
var
  _sg: TStringGrid;
  i, j: integer;
  _colcount: integer;
  _rowcount: integer;
  //
  _isSaved: boolean;
  data_to_excel: Variant;
  //
  _economic: TEconomicResult;

  function str(dbl: double): string;
  begin
    Result:= Format('%n', [dbl]);
  end;
begin
  _sg:= TStringGrid.Create(nil);
  _colcount:= _economics._items.Count;
  _rowcount:= 0;
  with _sg do
    try
      RowCount:= _rowcount;
      ColCount:= _colcount;
      for i:= 0 to _colcount - 1 do
      begin
        _economic:= _economics.Items[i];
        with _economic do
        begin
          _rowcount:= 39 + 1;
          j:= 0;

          Cells[i, j]:= format('%s'+#13#10+'%s', [NameOfVariant, DataOfVariant]);inc(j);
          Cells[i, j]:= str(VolumeOfGM_m3_avg);inc(j);
          Cells[i, j]:= str(VolumeOfGM_m3_byYear);inc(j);
          Cells[i, j]:= str(VolumeOfOre);inc(j);
          Cells[i, j]:= str(ShiftTimelap);inc(j);
          Cells[i, j]:= str(TotalCost / 1e6);inc(j);
          Cells[i, j]:= str(UdelCost);inc(j);
          Cells[i, j]:= str(Salary);inc(j);
          Cells[i, j]:= str(CoefOfVsry);inc(j);
          Cells[i, j]:= str(CoefOfPeriodShift);inc(j);
          Cells[i, j]:= str(CoefOfUseAutos);inc(j);
          Cells[i, j]:= str(ExcavatorsCount);inc(j);
          Cells[i, j]:= str(ElectricityCost);inc(j);
          Cells[i, j]:= str(ElectricityCostByShift);inc(j);
          Cells[i, j]:= str(TotalExcavatorsCost);inc(j);
          //
          Cells[i, j]:= str(getCountOfUnloadingPunkts(NameOfVariant));inc(j);
          Cells[i, j]:= str(TotalRoadsCost);inc(j);
          Cells[i, j]:= str(TotalRoadsLength);inc(j);
          Cells[i, j]:= str(RoadCostByYear);inc(j);
          Cells[i, j]:= str(AutosCount);inc(j);
          Cells[i, j]:= str(TyreUdelCost);inc(j);
          Cells[i, j]:= str(TyrePrice);inc(j);
          Cells[i, j]:= str(TytesCostByShift);inc(j);
          Cells[i, j]:= str(GSMPrice);inc(j);
          Cells[i, j]:= str(GSMUdelCost);inc(j);
          Cells[i, j]:= str(GSMCost);inc(j);
          Cells[i, j]:= str(TotalAutosCost);inc(j);
          //
          Cells[i, j]:= str(ResultBy1Tonna);inc(j);
          Cells[i, j]:= str(PriceBy1Tonna);inc(j);
          Cells[i, j]:= str(GTRCost);inc(j);
          Cells[i, j]:= str(TruckCost);inc(j);
          Cells[i, j]:= str(ServiceTruckCost / 1e3);inc(j);
          Cells[i, j]:= str(0.0);inc(j);
          Cells[i, j]:= str(PlanVolume_m3 / 1e3);inc(j);
          //
          Cells[i, j]:= str(Profit / 1e6);inc(j);
          Cells[i, j]:= str(TotalCost / 1e6);inc(j);
          Cells[i, j]:= str(UEconomicEffect / 1e6);inc(j);
          Cells[i, j]:= str(0.0);inc(j);
          Cells[i, j]:= str(OEconomicEffect / 1e6);inc(j);
          Cells[i, j]:= str(OOUEconomicEffect / 1e6);inc(j);
        end;
      end;

      data_to_excel:= VarArrayCreate([1, _rowcount, 1, _colcount],varVariant);
      for i:= 1 to VarArrayHighBound(data_to_excel, 1) do
        for j:= 1 to VarArrayHighBound(data_to_excel, 2) do
          data_to_excel[i, j]:= Cells[j-1, i-1];

      _isSaved:= ToExcel(data_to_excel, _colcount, _rowcount);
      if _isSaved then
        MessageBox(0, PAnsiChar(SAVE_IS_SUCCESS), PAnsiChar(APP_NAME), MB_OK)
      else
        MessageBox(0, PAnsiChar(SAVE_IS_WARNING), PAnsiChar(APP_NAME), MB_OK);

    finally
      Destroy;
    end;
end;

procedure TfmResultEconomEffect.btnSetLikeBaseClick(Sender: TObject);
var
  _economic: TEconomicResult;
  function str(dbl: double): string;
  begin
    Result:= Format('%n', [dbl]);
  end;
begin
  _economic:= _economics.BaseVariant;
  with _economic do
    try
      edProduk.Text:= str(ResultBy1Tonna);
      edSenaProd.Text:= str(PriceBy1Tonna);
      edStoiGTR.Text:= str(GTRCost);
      edStoiPrib.Text:= str(TruckCost);
      edZatSer.Text:= str(ServiceTruckCost / 1e3);
      edBaseVar.Text:= str(0.0);
      edQtnGM.Text:= str(PlanVolume_m3 / 1e3);
    except
      MessageBox(0, PAnsiChar(IS_ERROR), PAnsiChar(APP_NAME), MB_OK);
    end;
end;

function TfmResultEconomEffect.getCountOfUnloadingPunkts(
  openpitName: string): integer;
var
  _qry: TADOQuery;
  idOpenpit: integer;
begin
  Result:= 0;

  idOpenpit:= getOpenpitId(openpitName);

  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= SELECT_COUNT_OF_UNLOADING_PUNKTS;
    Parameters.ParamByName('Id_Openpit').Value:= idOpenpit;
    Open;
    Result:= FieldValues['result'];
    Close;
    Free;
  end;
end;

function TfmResultEconomEffect.getOpenpitId(openpitName: string): integer;
var
  _qry: TADOQuery;
begin
  Result:= 0;
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= SELECT_OPENPIT_BY_NAME;
    Parameters.ParamByName('OpenpitName').Value:= openpitName;
    Open;
    Result:= FieldValues['Id_Openpit'];
    Close;
    Free;
  end;
end;

end.



