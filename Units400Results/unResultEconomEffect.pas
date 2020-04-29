unit unResultEconomEffect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, ActnList,
  DB, ADODB,
  TXTWriter,
  unResultEconomEffect_Excel, unResultEconomEffect_Data;

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
    _currentVariant: integer;
    _variants: TList;
    _baseVariant: integer;
    procedure SelectBaseVariant;
    procedure OpenVariants();
    function GetVariants: TList;
    procedure GetData();
    procedure SetView();
    function ToExcel(sg: Variant; colcount, rowcount: integer): boolean;
    procedure Calc(_cp: TEffectParams);
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
  _variants:= GetVariants;
  OpenVariants();
  //
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
  for i:= 0 to _variants.Count - 1 do
  begin
    TEffectParams(_variants[i]).Destroy;
    _variants[i]:= nil;
  end;
end;

procedure TfmResultEconomEffect.dbgVariantCellClick(Column: TColumn);
begin
  GetData();
end;

procedure TfmResultEconomEffect.GetData;
var
  _currentParams: TEffectParams;
  i: integer;

  procedure SetBaseVariantExpenesCtg(currentVariant: integer);
  var
    _qry:TADOQuery;
    _cost_GTR_of_base: double;
  begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
    try
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_COST_GTR_OF_BASE;
      Parameters.ParamByName('Id_ResultVariant').Value:= _baseVariant;
      Open;
      _cost_GTR_of_base:= FieldValues['ServiceExpensesCtg'];
      Close;
      SQL.Clear;
      SQL.Text:= UPDATE_COST_GTR_OF_BASE;
      Parameters.ParamByName('BaseVariantExpenesCtg').Value:= _cost_GTR_of_base;
      Parameters.ParamByName('Id_ResultVariant').Value:= currentVariant;
      ExecSQL;
    finally
      Close;
      Free;
    end;
  end;
begin
  _currentParams:= nil;
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  for i:= 0 to _variants.Count - 1 do
    if TEffectParams(_variants[i]).Id = _currentVariant then
      _currentParams:= TEffectParams(_variants[i]);

  SetBaseVariantExpenesCtg(_currentVariant);

  if _currentParams <> nil then
  begin
    //-----------------------------------------------------
    edRocksVm3.Text:= _currentParams.ValueOf['RocksVm3'];
    edProizPeriod.Text:= _currentParams.ValueOf['ProizPeriod'];
    edSelic.Text:= _currentParams.ValueOf['Selic'];
    edParamsShiftDuration.Text:= _currentParams.ValueOf['ParamsShiftDuration'];
    edTotalCostsSummary.Text:= _currentParams.ValueOf['TotalCostsSummary'];
    edUdelQtn.Text:= _currentParams.ValueOf['UdelQtn'];
    edSalary.Text:= _currentParams.ValueOf['Salary'];
    edKVsry.Text:= _currentParams.ValueOf['KVsry'];
    edResultPeriodCoef.Text:= _currentParams.ValueOf['ResultPeriodCoef'];
    //edEmploymentRatio.Text:= _currentParams.ValueOf['EmploymentRatio'];
    edWorkTimeUsingRatio.Text:= _currentParams.ValueOf['WorkTimeUsingRatio'];
    edShiftExcavators.Text:= _currentParams.ValueOf['ShiftExcavators'];
    edElec.Text:= _currentParams.ValueOf['Elec'];
    edElectr.Text:= _currentParams.ValueOf['Electr'];
    edExcavsCostsSummary.Text:= _currentParams.ValueOf['ExcavsCostsSummary'];
    //
    edCountUnLodingPunkts.Text:= _currentParams.ValueOf['CountUnLodingPunkts'];
    edBlocksCostsSummary.Text:= _currentParams.ValueOf['BlocksCostsSummary'];
    edBLength.Text:= _currentParams.ValueOf['BLength'];
    edZatrat.Text:= _currentParams.ValueOf['Zatrat'];
    edShiftAutos.Text:= _currentParams.ValueOf['ShiftAutos'];
//    edAVGTransKPD.Text:= _currentParams.ValueOf['AVGTransKPD'];
    edUdelTyres.Text:= _currentParams.ValueOf['UdelTyres'];
    edStoiTyre.Text:= _currentParams.ValueOf['StoiTyre'];
    edSTyres.Text:= _currentParams.ValueOf['STyres'];
    edStoiGx.Text:= _currentParams.ValueOf['StoiGx'];
    edUdelGx.Text:= _currentParams.ValueOf['UdelGx'];
    edGx.Text:= _currentParams.ValueOf['Gx'];
    edAutosCostsSummary.Text:= _currentParams.ValueOf['AutosCostsSummary'];
//    edOstat.Text := _currentParams.ValueOf['Ostat'];
    //--------------------------------------------------------------------------
    edProduk.Text:= _currentParams.ValueOf['Produk'];
    edSenaProd.Text:= _currentParams.ValueOf['SenaProd'];
    edStoiGTR.Text:= _currentParams.ValueOf['StoiGTR'];
    edStoiPrib.Text:= _currentParams.ValueOf['StoiPrib'];
    edZatSer.Text:= _currentParams.ValueOf['ZatSer'];
    edBaseVar.Text:= _currentParams.ValueOf['BaseVar'];
    edQtnGM.Text:= _currentParams.ValueOf['QtnGM'];
    //--------------------------------------------------------------------------
    edPribil.Text := _currentParams.ValueOf['Pribil'];
    edRashot.Text := _currentParams.ValueOf['Rashot'];
    edUsEcom.Text := _currentParams.ValueOf['UsEcom'];
    edBaseVari.Text:= _currentParams.ValueOf['BaseVari'];
    edOtnoEcom.Text := _currentParams.ValueOf['OtnoEcom'];
    edOriUsEcom.Text := _currentParams.ValueOf['OriUsEcom'];
  end;
end;

procedure TfmResultEconomEffect.SelectBaseVariant;
var
  _qry: TADOQuery;
begin
  _baseVariant:= _currentVariant;
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= SELECT_ID_OF_BASE_VARIANT;
    Open;
    if FieldValues['Id_ResultVariant'] <> Null then
      _baseVariant:= FieldValues['Id_ResultVariant']
    else
    begin
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_ID_OF_EARLEST_VARIANT;
      Open;
      _baseVariant:= FieldValues['Id_ResultVariant'];
    end;
    //
    Close;
    Free;
  end;
end;

procedure TfmResultEconomEffect.OpenVariants;
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
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  //
  SelectBaseVariant;
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
  _qry: TADOQuery;
begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= UPDATE_CURRENT_INPUT_VALUES;
    Parameters.ParamByName('ProductOutPutPercent').Value:= strtofloat(edProduk.Text);
    Parameters.ParamByName('ProductPriceCtg').Value:= strtofloat(edSenaProd.Text);
    Parameters.ParamByName('MTWorkByScheduleCtg').Value:= strtofloat(edStoiGTR.Text);
    Parameters.ParamByName('TruckCostCtg').Value:= strtofloat(edStoiPrib.Text);
    Parameters.ParamByName('ServiceExpensesCtg').Value:= strtofloat(edZatSer.Text);
    Parameters.ParamByName('BaseVariantExpenesCtg').Value:= strtofloat(edBaseVar.Text);
    Parameters.ParamByName('PlannedRockVolumeCm').Value:= strtofloat(edQtnGM.Text);

    Parameters.ParamByName('Id_ResultVariant').Value:= _currentVariant;
    ExecSQL;
    Close;
    Free;
  end;
  if not btnCalc.Enabled then
    btnCalc.Enabled:= True;
end;

procedure TfmResultEconomEffect.btnCalcClick(Sender: TObject);
var
  i: integer;
  _currentParams: TEffectParams;
begin
  _currentParams:= nil;
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  for i:= 0 to _variants.Count - 1 do
    if TEffectParams(_variants[i]).Id = _currentVariant then
      _currentParams:= TEffectParams(_variants[i]);

  if _currentParams <> nil then
    try
      Calc(_currentParams);
      edPribil.Text := _currentParams.ValueOf['Pribil'];
      edRashot.Text := _currentParams.ValueOf['Rashot'];
      edUsEcom.Text := _currentParams.ValueOf['UsEcom'];
      edBaseVari.Text:= _currentParams.ValueOf['BaseVari'];
      edOtnoEcom.Text := _currentParams.ValueOf['OtnoEcom'];
      edOriUsEcom.Text := _currentParams.ValueOf['OriUsEcom'];
    except
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
        Parameters.ParamByName('Id_ResultVariant').Value:= _currentVariant;
        ExecSQL;
        MessageBox(0, PAnsiChar(DELL_VARIANT_IS_SUCCESS), PAnsiChar(APP_NAME), MB_OK);
      finally
        Close;
        Free;
      end;
  end;
  OpenVariants;
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
          Parameters.ParamByName('NewId_ResultVariant').Value:= _currentVariant;
          ExecSQL;
          MessageBox(0, PAnsiChar(SET_BASE_VARIANT), PAnsiChar(APP_NAME), MB_OK)
        except
          MessageBox(0, PAnsiChar(SQL_ERROR_UPDATE), PAnsiChar(APP_NAME), MB_OK);
        end;
      finally
        Close;
        Free;
      end;
    OpenVariants;
  end;
end;

procedure TfmResultEconomEffect.dbgVariantDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if dbgVariant.DataSource.DataSet['Id_ResultVariant'] = _baseVariant then
    dbgVariant.Canvas.Brush.Color:= clBlue;
  dbgVariant.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmResultEconomEffect.btnPrintToExcelClick(Sender: TObject);
var
  _sg: TStringGrid;
  i, j: integer;
  _colcount: integer;
  _rowcount: integer;
  _nameVariant: string;
  _currentDate: string;
  //
  _isSaved: boolean;
  data_to_excel: Variant;
  //
  _currentParams: TEffectParams;
begin
  _sg:= TStringGrid.Create(nil);
  _colcount:= _variants.Count;
  _rowcount:= 0;
  with _sg do
    try
      RowCount:= _rowcount;
      ColCount:= _colcount;
      for i:= 0 to _colcount - 1 do
      begin
        _currentParams:= TEffectParams(_variants[i]);
        _rowcount:= _currentParams.Count+1;
        _nameVariant:= _currentParams.Name;
        _currentDate:= _currentParams.Date;
        j:= 0;

        Cells[i, j]:= format('%s'+#13#10+'%s', [_nameVariant, _currentDate]);inc(j);
        Cells[i, j]:= _currentParams.ValueOf['RocksVm3'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ProizPeriod'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Selic'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ParamsShiftDuration'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['TotalCostsSummary'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['UdelQtn'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Salary'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['KVsry'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ResultPeriodCoef'];inc(j);
//        Cells[i, j]:= _currentParams.ValueOf['EmploymentRatio'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['WorkTimeUsingRatio'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ShiftExcavators'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Elec'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Electr'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ExcavsCostsSummary'];inc(j);
        //
        Cells[i, j]:= _currentParams.ValueOf['CountUnLodingPunkts'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['BlocksCostsSummary'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['BLength'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Zatrat'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ShiftAutos'];inc(j);
//        Cells[i, j]:= _currentParams.ValueOf['AVGTransKPD'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['UdelTyres'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['StoiTyre'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['STyres'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['StoiGx'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['UdelGx'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Gx'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['AutosCostsSummary'];inc(j);
//        Cells[i, j]:= _currentParams.ValueOf['Ostat'];inc(j);
        //
        Cells[i, j]:= _currentParams.ValueOf['Produk'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['SenaProd'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['StoiGTR'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['StoiPrib'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['ZatSer'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['BaseVar'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['QtnGM'];inc(j);
        //
        Cells[i, j]:= _currentParams.ValueOf['Pribil'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['Rashot'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['UsEcom'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['BaseVari'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['OtnoEcom'];inc(j);
        Cells[i, j]:= _currentParams.ValueOf['OriUsEcom'];inc(j);
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
  _qry: TADOQuery;
begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= SELECT_BASE_VARIANT;
    Parameters.ParamByName('Id_ResultVariant').Value:= _baseVariant;
    Open;

    edProduk.Text:= Format('%.3f',[Double(FieldValues['ProductOutPutPercent'])]);
    edSenaProd.Text:= Format('%.3f',[Double(FieldValues['ProductPriceCtg'])]);
    edStoiGTR.Text:= Format('%.3f',[Double(FieldValues['MTWorkByScheduleCtg'])]);
    edStoiPrib.Text:= Format('%.3f',[Double(FieldValues['TruckCostCtg'])]);
    edZatSer.Text:= Format('%.3f',[Double(FieldValues['ServiceExpensesCtg'])]);
    edBaseVar.Text:= Format('%.3f',[Double(FieldValues['BaseVariantExpenesCtg'])]);
    edQtnGM.Text:= Format('%.3f',[Double(FieldValues['PlannedRockVolumeCm'])]);

    Close;
    Free;
  end;
end;

function TfmResultEconomEffect.GetVariants: TList;
var
  _qry: TADOQuery;
  _params: TEffectParams;
  //
  dbl: double;
  int: integer;
  str: string;
  //
  d0, d1, d2: double;
  //----------------------------------------------------------------------------
  function getOpenpitId(openpitName: string): integer;
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
  function getDataByOpenpit(_sql:string; idOpenpit: integer): double;
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
      SQL.Text:= _sql;
      Parameters.ParamByName('Id_Openpit').Value:= idOpenpit;
      Open;
      Result:= FieldValues['result'];
      Close;
      Free;
    end;
  end;
  function getKPDs(idOpenpit: integer): double;
  begin
    Result:= getDataByOpenpit(SELECT_TRANSMISSION_KPD, idOpenpit);
  end;
  function getCostEquipmqnt(idOpenpit: integer): double;
  begin
    Result:= getDataByOpenpit(SELECT_COST_OF_EQUIPMENT, idOpenpit);
  end;
  function getCountOfUnloadingPunkts(idOpenpit:integer): integer;
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
      SQL.Text:= SELECT_COUNT_OF_UNLOADING_PUNKTS;
      Parameters.ParamByName('Id_Openpit').Value:= idOpenpit;
      Open;
      Result:= FieldValues['result'];
      Close;
      Free;
    end;
  end;
  function getResultByTonneOfOre(Selic, RocksVm3: double): double;
  var
    _qry: TADOQuery;
  begin
    Result:= (Selic * 100) / RocksVm3;
    _qry:= TADOQuery.Create(nil);
    _qry.Connection:= fmDM.ADOConnection;
    with _qry do
      try
        Close;
        SQL.Clear;
        SQL.Text:= UPDATE_RESULT_BY_TONNE_OF_ORE;
        Parameters.ParamByName('ProductOutPutPercent').Value:= Result;
        Parameters.ParamByName('Id_ResultVariant').Value:= _currentVariant;
        ExecSQL;
      finally
        Close;
        Free;
      end;
  end;
  function getPlanRocks(idOpenpit:integer): double;
  var
    _qry: TADOQuery;
  begin
    Result:= 0;
    _qry:= TADOQuery.Create(nil);
    _qry.Connection:= fmDM.ADOConnection;
    with _qry do
      try
        Close;
        SQL.Clear;
        SQL.Text:= SELECT_PLAN_ROCKS;
        Parameters.ParamByName('Id_Openpit').Value:= idOpenpit;
        Open;
        Result:= FieldValues['result'];
        Close;
        SQL.Clear;
        SQL.Text:= UPDATE_PLAN_ROCKS;
        Parameters.ParamByName('PlannedRockVolumeCm').Value:= Result;
        Parameters.ParamByName('Id_ResultVariant').Value:= _currentVariant;
        ExecSQL;
      finally
        Close;
        Free;
      end;
  end;
  function getBalanceAutos(): double;
  var
    _qry: TADOQuery;
  begin
    Result:= 0;
    _qry:= TADOQuery.Create(nil);
    _qry.Connection:= fmDM.ADOConnection;
    with _qry do
      try
        Close;
        SQL.Clear;
        SQL.Text:= SELECT_BALANCE_AUTOS;
        Open;
        if FieldValues['result'] <> Null then
          Result:= FieldValues['result'];
        Close;
        SQL.Clear;
        SQL.Text:= UPDATE_BALANCE_AUTOS;
        Parameters.ParamByName('TruckCostCtg').Value:= Result;
        Parameters.ParamByName('Id_ResultVariant').Value:= _currentVariant;
        ExecSQL;
      finally
        Close;
        Free;
      end;
  end;
begin
  Result:= TList.Create;
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
    try
      try
        Close;
        SQL.Clear;
        SQL.Text:= SELECT_ALL_FROM_RESULT_VARIANT;
        Open;

        while not Eof do
        begin
          int:= getOpenpitId(FieldValues['Variant']);
          str:= FormatDateTime('MM/DD/YYYY', FieldValues['VariantDate']);
          _params:= TEffectParams.Create(FieldValues['Variant'], FieldValues['Id_ResultVariant'], int, str);
          _params.Clear;

          //--------------------------------------------------------------------------
          dbl:= FieldValues['CurrOreVm3'];
          _params.Add(TFloatParam.Create('Selic', dbl, CatSebadan));
          dbl:= FieldValues['CurrStrippingVm3'];
          dbl:= (TFloatParam(_params.Names['Selic']).Value +
                FieldValues['CurrStrippingVm3'] +
                FieldValues['ExcavatorsRockVm3']) / 2;
          _params.Add(TFloatParam.Create('RocksVm3', dbl, CatSebadan));
          dbl:= FieldValues['ShiftKweek'];
          _params.Add(TFloatParam.Create('ResultPeriodCoef', dbl, CatSebadan));
          dbl:= TFloatParam(_params.Names['RocksVm3']).Value * 2 * 365 * TFloatParam(_params.Names['ResultPeriodCoef']).Value;
          _params.Add(TFloatParam.Create('ProizPeriod', dbl, CatSebadan));
          dbl:= FieldValues['ShiftTmin'];
          _params.Add(TFloatParam.Create('ParamsShiftDuration', dbl, CatSebadan));
          //TotalCostsSummary
          dbl:= FieldValues['BaseVariantExpenesCtg'] +
                FieldValues['ServiceExpensesCtg'] +
                FieldValues['EconomExpensesCtg'];
          _params.Add(TFloatParam.Create('TotalCostsSummary', dbl, CatSebadan));
          //Удельные текущие затраты по горной массе, тенге
          dbl:= (FieldValues['AutosWorkSumGxCtg'] + FieldValues['AutosWorkSumTyresCtg'] +
                    FieldValues['AutosWorkSparesCtg'] + FieldValues['AutosWorkMaterialsCtg'] +
                    FieldValues['AutosWorkMaintenancesCtg'] + FieldValues['AutosWorkSalariesCtg'] +
                    FieldValues['AutosWaitingSumGxCtg'] + FieldValues['AutosWaitingSparesCtg'] +
                    FieldValues['AutosWaitingMaterialsCtg'] + FieldValues['AutosWaitingMaintenancesCtg'] +
                    FieldValues['AutosWaitingSalariesCtg'] + FieldValues['AutosAmortizationCtg'] +
                    FieldValues['BlocksRepairCtg'] + FieldValues['BlocksAmortizationCtg'] +
                    FieldValues['ExcavatorsWorkSumGxCtg'] + FieldValues['ExcavatorsWorkMaterialsCtg'] +
                    FieldValues['ExcavatorsWorkUnAccountedCtg'] + FieldValues['ExcavatorsWorkSalariesCtg'] +
                    FieldValues['ExcavatorsWaitingSumGxCtg'] + FieldValues['ExcavatorsWaitingMaterialsCtg'] +
                    FieldValues['ExcavatorsWaitingUnAccountedCtg'] + FieldValues['ExcavatorsWaitingSalariesCtg'] +
                    FieldValues['ExcavatorsAmortizationCtg'])
                    /TFloatParam(_params.Names['RocksVm3']).Value;
          _params.Add(TFloatParam.Create('UdelQtn', dbl, CatSebadan));
          dbl:= FieldValues['AutosWorkSalariesCtg'] +
                FieldValues['AutosWaitingSalariesCtg'] +
                FieldValues['ExcavatorsWorkSalariesCtg'] +
                FieldValues['ExcavatorsWaitingSalariesCtg'];
          _params.Add(TFloatParam.Create('Salary', dbl, CatSebadan));
          // коэффициент вскрыши
          dbl:= FieldValues['Ks'];
          _params.Add(TFloatParam.Create('KVsry', dbl, CatSebadan));
          //Коэффициент занятости пункта
          //dbl:= FieldValues['BlocksEmploymentCoef'];
          //_params.Add(TFloatParam.Create('EmploymentRatio', dbl, CatSebadan));
          //
          dbl:= FieldValues['AutosAvgTimeUsingCoef'];
          _params.Add(TFloatParam.Create('WorkTimeUsingRatio', dbl, CatSebadan));
          int:= FieldValues['ExcavatorsExcavatorsCount0'];
          _params.Add(TFloatParam.Create('ShiftExcavators', int, CatSebadan));
          dbl:= FieldValues['ExcavatorsGxWork'] +
                FieldValues['ExcavatorsGxWaiting'];
          _params.Add(TFloatParam.Create('Elec', dbl, CatSebadan));
          dbl:= FieldValues['ExcavatorsGxWork'];
          _params.Add(TFloatParam.Create('Electr', dbl, CatSebadan));
          dbl:= FieldValues['ExcavatorsAmortizationCtg'];
          _params.Add(TFloatParam.Create('ExcavsCostsSummary', dbl, CatSebadan));
          int:= getCountOfUnloadingPunkts(_params.OpenpitId);
          _params.Add(TFloatParam.Create('CountUnLodingPunkts', int, CatSebadan));
          dbl:= FieldValues['BlocksAmortizationCtg'];
          _params.Add(TFloatParam.Create('BlocksCostsSummary', dbl, CatSebadan));
          int:= FieldValues['BlocksLm'];
          _params.Add(TFloatParam.Create('BLength', int, CatSebadan));
          dbl:= FieldValues['BlocksRepairCtg'];
          _params.Add(TFloatParam.Create('Zatrat', dbl, CatSebadan));
          int:= FieldValues['AutosAutosCount0'];
          _params.Add(TFloatParam.Create('ShiftAutos', int, CatSebadan));
//          dbl:= getKPDs(_params.OpenpitId);
//          _params.Add(TFloatParam.Create('AVGTransKPD', dbl, CatSebadan));
          dbl:= FieldValues['AutosUsedTyresCount'] /
                TFloatParam(_params.Names['RocksVm3']).Value;
          _params.Add(TFloatParam.Create('UdelTyres', dbl, CatSebadan));
          dbl:= 0.0;
          _params.Add(TFloatParam.Create('StoiTyre', dbl, CatSebadan));
          dbl:= FieldValues['AutosTyresCtg'];
          _params.Add(TFloatParam.Create('STyres', dbl, CatSebadan));
          dbl:= FieldValues['AutosGxCtg'];
          _params.Add(TFloatParam.Create('StoiGx', dbl, CatSebadan));
          dbl:= FieldValues['AutosUdGx_gr_tkm'];
          _params.Add(TFloatParam.Create('UdelGx', dbl, CatSebadan));
          dbl:= FieldValues['AutosGxWaiting'] +
                FieldValues['AutosGxWork'];
          _params.Add(TFloatParam.Create('Gx', dbl, CatSebadan));
          dbl:= FieldValues['AutosAmortizationCtg'];
          _params.Add(TFloatParam.Create('AutosCostsSummary', dbl, CatSebadan));
//          dbl:= getCostEquipmqnt(_params.OpenpitId);
//          _params.Add(TFloatParam.Create('Ostat', dbl, CatSebadan));
          //---------------------------------------------

          dbl:= FieldValues['ProductOutPutPercent'];
          if dbl = 0 then
            dbl:= getResultByTonneOfOre(TFloatParam(_params.Names['Selic']).Value,
                                        TFloatParam(_params.Names['RocksVm3']).Value);
          _params.Add(TFloatParam.Create('Produk', dbl, CatInput));
          dbl:= FieldValues['ProductPriceCtg'];
          _params.Add(TFloatParam.Create('SenaProd', dbl, CatInput));
          dbl:= FieldValues['MTWorkByScheduleCtg'];
          _params.Add(TFloatParam.Create('StoiGTR', dbl, CatInput));
          dbl:= FieldValues['TruckCostCtg'];
          if dbl = 0 then
            dbl:= getBalanceAutos();
          _params.Add(TFloatParam.Create('StoiPrib', dbl, CatInput));
          //
          dbl:= FieldValues['ServiceExpensesCtg'];
          _params.Add(TFloatParam.Create('ZatSer', dbl, CatInput));
          //
          dbl:= FieldValues['BaseVariantExpenesCtg'];
          _params.Add(TFloatParam.Create('BaseVar', dbl, CatInput));
          //
          dbl:= FieldValues['PlannedRockVolumeCm'];
          if dbl = 0 then
            dbl:= getPlanRocks(_params.OpenpitId);
          _params.Add(TFloatParam.Create('QtnGM', dbl, CatInput));
          //--------------------------------------------------------------------------

          Calc(_params);

          Result.Add(_params);
          Next;
        end;

      except
        MessageBox(0, PAnsiChar(IS_ERROR), PAnsiChar(APP_NAME), MB_OK);
      end;
    finally
      Close;
      Free;
    end;
end;

procedure TfmResultEconomEffect.Calc(_cp: TEffectParams);
var
  Vgm, Cstro, Crem, Pribil, Rashot, UsEcom, OtnoEcom, Vn, OriUsEcom: double;
  ParamsShiftDuration, ResultPeriodCoef, RocksVm3, StoiPrib, ZatSer,
  Selic, Produk, SenaProd, KVsry, UdelQtn, STyres, QtnGM: double;
begin
  ParamsShiftDuration:= _cp.Value['ParamsShiftDuration'];
  ResultPeriodCoef:= _cp.Value['ResultPeriodCoef'];
  Selic:= _cp.Value['Selic'];
  RocksVm3:= _cp.Value['RocksVm3'];
  StoiPrib:= _cp.Value['StoiPrib'];
  ZatSer:= _cp.Value['ZatSer'];
  Produk:= _cp.Value['Produk'];
  SenaProd:= _cp.Value['SenaProd'];
  KVsry:= _cp.Value['KVsry'];
  UdelQtn:= _cp.Value['UdelQtn'];
  STyres:= _cp.Value['STyres'];
  QtnGM:= _cp.Value['QtnGM'];

  //Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, тыс.м3
  Vgm:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef) * RocksVm3 * 1000;
  //Прочие дополнительные единовременные расходы на строительство автодорог и железнодорожных
  //путей, приобретение нового оборудования, строительство дополнительных съездов и т.д., млн.тенге
  Cstro:= StoiPrib * 1000;
  //Сумма затрат связанная с текущими ремонтами автосамосвалов
  Crem := ZatSer * 1000;
  //Прибыль, млн.тг
  Pribil:= ((Vgm * Selic * Produk * SenaProd)/(( 1 + KVsry) * 100)) / 1000000;
  _cp.Add(TFloatParam.Create('Pribil', Pribil, CatOutput));
  //Затраты, млн.тг
  Rashot:= (Vgm * UdelQtn + STyres + Cstro + Crem) / 1000000;
  _cp.Add(TFloatParam.Create('Rashot', Rashot, CatOutput));
  //Условный экономический эффект, млн.тг
  UsEcom:= ((Vgm * Selic * Produk * SenaProd)/((1 + KVsry) * 100)-(Vgm * UdelQtn + STyres + Cstro + Crem))  / 1000000;
  _cp.Add(TFloatParam.Create('UsEcom', UsEcom, CatOutput));
  //BaseVari
  _cp.Add(TFloatParam.Create('BaseVari', 0, CatOutput));
  //Относительный экономический эффект, млн.тг
  OtnoEcom:= 0;
  _cp.Add(TFloatParam.Create('OtnoEcom', OtnoEcom, CatOutput));
  //Объем горной массы запланированный к извлечению в рассматриваемом периоде, тыс.м3
  Vn:= QtnGM * 1000;
  //Объемно ориентированный условный экономический эффект, млн.тг
  OriUsEcom:= (Vn * UdelQtn + Vn * (STyres / Vgm) + Cstro + Crem) / 1000000;
  _cp.Add(TFloatParam.Create('OriUsEcom', OriUsEcom, CatOutput));
end;

end.


