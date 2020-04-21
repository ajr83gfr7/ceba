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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgVariantCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure dbgVariantDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
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
    _baseVariant: integer;
    _currentParams: TEffectParams;
    procedure SelectBaseVariant;
    procedure OpenVariants();
    procedure GetData();
    procedure GetInputData();
    procedure SetView();
    procedure ToExcel(sg: Variant; colcount, rowcount: integer);
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
  OpenVariants();
  _currentParams:= TEffectParams.Create;
  //
  GetData();
  SetView();
end;

procedure TfmResultEconomEffect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryVariants.Close;
  qryResultVariants.Close;
  _currentParams.Destroy;
end;

procedure TfmResultEconomEffect.dbgVariantCellClick(Column: TColumn);
begin
  GetData();
end;

procedure TfmResultEconomEffect.dbgVariantDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
//  GetData();
end;

procedure TfmResultEconomEffect.GetData;
var
  STyres, UdelQtn, KVsry, Selic, RocksVm3,
  ResultPeriodCoef, ParamsShiftDuration, Vgm,
  Produk, Cstro, StoiPrib, Crem, Pribil,
  SenaProd, ZatSer, Rashot, UsEco, OtnoEcom,
  Vn, QtnGM, OriUsEco, ProizPeriod, Salary,
  UdelTyres, Stripping, KPDs, ostat: Double;
  CountUnloadingPunkt: integer;
  //
  dbl: double;
  int: integer;
  str: string;
  //
  _openpitId: integer;
  _nameVariant: string;

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
begin
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  _currentParams.Clear;

  SetBaseVariantExpenesCtg(_currentVariant);
  with qryResultVariants do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= SELECT_FROM_RESULT_VARIANT;
    Parameters.ParamByName('IdVariant').Value:= _currentVariant;
    Open;

    _nameVariant:= FieldValues['Variant'];
    _openpitId:= getOpenpitId(_nameVariant);

    //--------------------------------------------------------------------------
    Selic:= FieldValues['CurrOreVm3'];
    _currentParams.Add(TFloatParam.Create('Selic', Selic, CatSebadan));
    Stripping:= FieldValues['CurrStrippingVm3'];
    RocksVm3:= Selic + Stripping;
    _currentParams.Add(TFloatParam.Create('RocksVm3', RocksVm3, CatSebadan));
    ProizPeriod:= RocksVm3 * 2 * 365;
    _currentParams.Add(TFloatParam.Create('ProizPeriod', ProizPeriod, CatSebadan));
    ParamsShiftDuration:= FieldValues['ShiftTmin'];
    _currentParams.Add(TFloatParam.Create('ParamsShiftDuration', ParamsShiftDuration, CatSebadan));
    //TotalCostsSummary
    dbl:= FieldValues['BaseVariantExpenesCtg'] +
          FieldValues['ServiceExpensesCtg'] +
          FieldValues['EconomExpensesCtg'];
    _currentParams.Add(TFloatParam.Create('TotalCostsSummary', dbl, CatSebadan));
    //Удельные текущие затраты по горной массе, тенге
    UdelQtn:= (FieldValues['AutosWorkSumGxCtg'] + FieldValues['AutosWorkSumTyresCtg'] +
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
              /RocksVm3;
    _currentParams.Add(TFloatParam.Create('UdelQtn', UdelQtn, CatSebadan));
    Salary:= FieldValues['AutosWorkSalariesCtg'] + FieldValues['AutosWaitingSalariesCtg'] +
             FieldValues['ExcavatorsWorkSalariesCtg'] + FieldValues['ExcavatorsWaitingSalariesCtg'];
    _currentParams.Add(TFloatParam.Create('Salary', Salary, CatSebadan));
    KVsry:= FieldValues['Ks'];
    _currentParams.Add(TFloatParam.Create('KVsry', KVsry, CatSebadan));
    ResultPeriodCoef:= FieldValues['PeriodKshift'];
    _currentParams.Add(TFloatParam.Create('ResultPeriodCoef', ResultPeriodCoef, CatSebadan));
    dbl:= FieldValues['BlocksEmploymentCoef'];
    _currentParams.Add(TFloatParam.Create('EmploymentRatio', dbl, CatSebadan));
    dbl:= FieldValues['AutosAvgTimeUsingCoef'];
    _currentParams.Add(TFloatParam.Create('WorkTimeUsingRatio', dbl, CatSebadan));
    int:= FieldValues['ExcavatorsExcavatorsCount0'];
    _currentParams.Add(TIntParam.Create('ShiftExcavators', int, CatSebadan));
    dbl:= FieldValues['ExcavatorsGxWork'] +
          FieldValues['ExcavatorsGxWaiting'];
    _currentParams.Add(TFloatParam.Create('Elec', dbl, CatSebadan));
    dbl:= FieldValues['ExcavatorsGxWork'];
    _currentParams.Add(TFloatParam.Create('Electr', dbl, CatSebadan));
    dbl:= FieldValues['ExcavatorsAmortizationCtg'];
    _currentParams.Add(TFloatParam.Create('ExcavsCostsSummary', dbl, CatSebadan));
    CountUnloadingPunkt:= getCountOfUnloadingPunkts(_openpitId);
    _currentParams.Add(TIntParam.Create('CountUnLodingPunkts', CountUnloadingPunkt, CatSebadan));
    dbl:= FieldValues['BlocksAmortizationCtg'];
    _currentParams.Add(TFloatParam.Create('BlocksCostsSummary', dbl, CatSebadan));
    int:= FieldValues['BlocksLm'];
    _currentParams.Add(TIntParam.Create('BLength', int, CatSebadan));
    dbl:= FieldValues['BlocksRepairCtg'];
    _currentParams.Add(TFloatParam.Create('Zatrat', dbl, CatSebadan));
    int:= FieldValues['AutosAutosCount0'];
    _currentParams.Add(TIntParam.Create('ShiftAutos', int, CatSebadan));
    KPDs:= getKPDs(_openpitId);
    _currentParams.Add(TFloatParam.Create('AVGTransKPD', KPDs, CatSebadan));
    UdelTyres:= FieldValues['AutosUsedTyresCount'] / RocksVm3;
    _currentParams.Add(TFloatParam.Create('UdelTyres', UdelTyres, CatSebadan));
    dbl:= 0.0;
    _currentParams.Add(TFloatParam.Create('StoiTyre', dbl, CatSebadan));
    STyres:= FieldValues['AutosTyresCtg'];
    _currentParams.Add(TFloatParam.Create('STyres', STyres, CatSebadan));
    dbl:= FieldValues['AutosGxCtg'];
    _currentParams.Add(TFloatParam.Create('StoiGx', dbl, CatSebadan));
    dbl:= FieldValues['AutosUdGx_gr_tkm'];
    _currentParams.Add(TFloatParam.Create('UdelGx', dbl, CatSebadan));
    dbl:= FieldValues['AutosGxWaiting'] +
          FieldValues['AutosGxWork'];
    _currentParams.Add(TFloatParam.Create('Gx', dbl, CatSebadan));
    dbl:= FieldValues['AutosAmortizationCtg'];
    _currentParams.Add(TFloatParam.Create('AutosCostsSummary', dbl, CatSebadan));
    ostat:= getCostEquipmqnt(_openpitId);
    _currentParams.Add(TFloatParam.Create('Ostat', ostat, CatSebadan));

    //----------------------------------------------*****************-----------
    edRocksVm3.Text:= _currentParams.ValueOf['RocksVm3'];
    edProizPeriod.Text:= _currentParams.ValueOf['ProizPeriod'];
    edSelic.Text:= _currentParams.ValueOf['Selic'];
    edParamsShiftDuration.Text:= _currentParams.ValueOf['ParamsShiftDuration'];
    edTotalCostsSummary.Text:= _currentParams.ValueOf['TotalCostsSummary'];
    edUdelQtn.Text:= _currentParams.ValueOf['UdelQtn'];
    edSalary.Text:= _currentParams.ValueOf['Salary'];
    edKVsry.Text:= _currentParams.ValueOf['KVsry'];
    edResultPeriodCoef.Text:= _currentParams.ValueOf['ResultPeriodCoef'];
    edEmploymentRatio.Text:= _currentParams.ValueOf['EmploymentRatio'];
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
    edAVGTransKPD.Text:= _currentParams.ValueOf['AVGTransKPD'];
    edUdelTyres.Text:= Format('%.6f',[TFloatParam(_currentParams.Names['UdelTyres']).Value]);
    edStoiTyre.Text:= _currentParams.ValueOf['StoiTyre'];
    edSTyres.Text:= _currentParams.ValueOf['STyres'];
    edStoiGx.Text:= _currentParams.ValueOf['StoiGx'];
    edUdelGx.Text:= _currentParams.ValueOf['UdelGx'];
    edGx.Text:= _currentParams.ValueOf['Gx'];
    edAutosCostsSummary.Text:= _currentParams.ValueOf['AutosCostsSummary'];
    edOstat.Text := _currentParams.ValueOf['Ostat'];

    //--------------------------------------------------------------------------
    Produk:= FieldValues['ProductOutPutPercent'];
    if Produk = 0 then
      Produk:= getResultByTonneOfOre(Selic, RocksVm3);
    edProduk.Text:= Format('%.3f',[Produk]);
    //Oaia iaiie oiiiu i?iaoeoa, oun.oa.
    SenaProd:= FieldValues['ProductPriceCtg'];
    edSenaProd.Text:= Format('%.3f',[SenaProd]);
    edStoiGTR.Text := Format('%.3f',[Double(FieldValues['MTWorkByScheduleCtg'])]);
    //Noieiinou i?eia?aoaaiiai aaoinaiinaaea, oun.oa.
    StoiPrib:= FieldValues['TruckCostCtg'];
    if StoiPrib = 0 then
      StoiPrib:= getBalanceAutos();
    edStoiPrib.Text := Format('%.3f',[StoiPrib]);
    //Cao?aou ia na?aeniia ianeo?eaaiea, oun.oa
    ZatSer:= FieldValues['ServiceExpensesCtg'];
    edZatSer.Text := Format('%.3f',[ZatSer]);
    edBaseVar.Text := Format('%.3f',[Double(FieldValues['BaseVariantExpenesCtg'])]);
    //Caieaie?iaaiiue iauai AI ca ia?eia, oun.i3
    QtnGM:= FieldValues['PlannedRockVolumeCm'];
    if QtnGM = 0 then
      QtnGM:= getPlanRocks(_openpitId);
    edQtnGM.Text := Format('%.3f',[QtnGM]);
    //--------------------------------------------------------------------------
    Vgm:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef) * RocksVm3 * 1000;
    {Прочие дополнительные единовременные расходы на строительство автодорог и железнодорожных
    путей, приобретение нового оборудования, строительство дополнительных съездов и т.д., млн.тенге}
    Cstro:= StoiPrib * 1000;
    {Сумма затрат связанная с текущими ремонтами автосамосвалов}
    Crem := ZatSer * 1000;
    Pribil:= ((Vgm * Selic * Produk * SenaProd)/(( 1 + KVsry) * 100)) / 1000000;
    edPribil.Text := Format('%.6f',[Pribil]);
    Rashot:= (Vgm * UdelQtn + STyres + Cstro + Crem) / 1000000;
    edRashot.Text := Format('%.6f',[Rashot]);
    UsEco:= ((Vgm * Selic * Produk * SenaProd)/((1 + KVsry) * 100)-(Vgm * UdelQtn + STyres + Cstro + Crem))  / 1000000;
    edUsEcom.Text := Format('%.6f',[UsEco]);
    edBaseVari.Text:= Format('%.6f',[0.0]);
    OtnoEcom:= 0;
    edOtnoEcom.Text := Format('%.6f',[OtnoEcom]);
    Vn:= QtnGM * 1000;
    OriUsEco:= (Vn * UdelQtn + Vn * (STyres / Vgm) + Cstro + Crem) / 1000000;
    edOriUsEcom.Text := Format('%.6f',[OriUsEco]);
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
//  DBGrid1.Canvas.Brush.Color
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
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
  Label21.Caption:= KPD_AUTO_TRANSMISSION;
  Label22.Caption:= RASHOD_TYRES;
  Label23.Caption:= COST_OF_1TYRE;
  Label24.Caption:= COST_ON_TYRES;
  Label25.Caption:= COST_ON_1GSM;
  Label26.Caption:= RASHOD_GSM;
  Label27.Caption:= RASHOD_GSM_FOR_LITER;
  Label28.Caption:= SUMCOST_OF_AUTOS;
  Label29.Caption:= OSTAT_COST;

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
  Vgm, Cstro, Crem, Pribil, Rashot, UsEco, OtnoEcom, Vn, OriUsEco: double;
  ParamsShiftDuration, ResultPeriodCoef, RocksVm3, StoiPrib, ZatSer, Stripping,
  Selic, Produk, SenaProd, KVsry, UdelQtn, STyres, QtnGM: double;
begin
  with qryResultVariants do
  begin
    ParamsShiftDuration:= FieldValues['ShiftTmin'];
    ResultPeriodCoef:= FieldValues['PeriodKshift'];
    Stripping:= FieldValues['CurrStrippingVm3'];
    Selic:= FieldValues['CurrOreVm3'];
    RocksVm3:= Selic + Stripping;
    StoiPrib:= FieldValues['TruckCostCtg'];
    ZatSer:= FieldValues['ServiceExpensesCtg'];
    Produk:= FieldValues['ProductOutPutPercent'];
    SenaProd:= FieldValues['ProductPriceCtg'];
    KVsry:= FieldValues['Ks'];
    UdelQtn:= (FieldValues['AutosWorkSumGxCtg'] + FieldValues['AutosWorkSumTyresCtg'] +
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
              /RocksVm3;
    STyres:= FieldValues['AutosTyresCtg'];
    QtnGM:= FieldValues['PlannedRockVolumeCm'];
  end;

  //Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, тыс.м3
  Vgm:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef) * RocksVm3 * 1000;
  //Прочие дополнительные единовременные расходы на строительство автодорог и железнодорожных
  //путей, приобретение нового оборудования, строительство дополнительных съездов и т.д., млн.тенге
  Cstro:= StoiPrib * 1000;
  //Сумма затрат связанная с текущими ремонтами автосамосвалов
  Crem := ZatSer * 1000;
  //Прибыль, млн.тг
  Pribil:= ((Vgm * Selic * Produk * SenaProd)/(( 1 + KVsry) * 100)) / 1000000;
  //Затраты, млн.тг
  Rashot:= (Vgm * UdelQtn + STyres + Cstro + Crem) / 1000000;
  //Условный экономический эффект, млн.тг
  UsEco:= ((Vgm * Selic * Produk * SenaProd)/((1 + KVsry) * 100)-(Vgm * UdelQtn + STyres + Cstro + Crem))  / 1000000;
  //Относительный экономический эффект, млн.тг
  OtnoEcom:= 0;
  //Объем горной массы запланированный к извлечению в рассматриваемом периоде, тыс.м3
  Vn:= QtnGM * 1000;
  //Объемно ориентированный условный экономический эффект, млн.тг
  OriUsEco:= (Vn * UdelQtn + Vn * (STyres / Vgm) + Cstro + Crem) / 1000000;

  edPribil.Text := Format('%.6f',[Pribil]);
  edRashot.Text := Format('%.6f',[Rashot]);
  edUsEcom.Text := Format('%.6f',[UsEco]);
  edBaseVari.Text:= Format('%.6f',[0.0]);
  edOtnoEcom.Text := Format('%.6f',[OtnoEcom]);
  edOriUsEcom.Text := Format('%.6f',[OriUsEco]);
end;

procedure TfmResultEconomEffect.GetInputData;
begin
  //
end;

procedure TfmResultEconomEffect.ToExcel(sg: Variant; colcount, rowcount: integer);
var
  doc: TExcelDocEconomEffect;
  filename: string;
  isSaved: boolean;
begin
  doc:= TExcelDocEconomEffect.Create();
  with doc do
    try
      //
      SetData(sg, colcount, rowcount);
      //
      saveas.InitialDir := GetCurrentDir;
      saveas.Filter := '*.xls|*.xlsx';
      saveas.DefaultExt := 'xls';
      saveas.FilterIndex := 1;
      if saveas.Execute then
        filename:= saveas.FileName;
      SaveWorkBook(filename, 1)
    finally
      Destroy;
    end;
end;

procedure TfmResultEconomEffect.btnDelVariantClick(Sender: TObject);
var
  _qry: TADOQuery;
begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= DELETE_VARIANT_BY_ID;
    Parameters.ParamByName('Id_ResultVariant').Value:= _currentVariant;
    ExecSQL;
    Close;
    Free;
  end;
  OpenVariants;
end;

procedure TfmResultEconomEffect.actSetBaseVariantExecute(Sender: TObject);
var
  _qry: TADOQuery;
begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= UPDATE_VARIANTS_TO_OFF;
    ExecSQL;
    Close;
    SQL.Clear;
    SQL.Text:= UPDATE_NEW_BASE_VARIANT;
    Parameters.ParamByName('NewId_ResultVariant').Value:= _currentVariant;
    ExecSQL;
    Close;
    Free;
  end;
  OpenVariants;
end;

procedure TfmResultEconomEffect.dbgVariantDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if dbgVariant.DataSource.DataSet['Id_ResultVariant'] = _baseVariant then
    dbgVariant.Canvas.Brush.Color:= clGreen;
  dbgVariant.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmResultEconomEffect.btnPrintToExcelClick(Sender: TObject);
var
  _sg: TStringGrid;
  _sg_input: TStringGrid;
  _sg_output: TStringGrid;
  _qry: TADOQuery;
  i, j: integer;
  VIndex: integer;
  colcount: integer;
  rowcount: integer;
  data_to_excel: Variant;
  _openpitId: integer;
  _nameVariant: string;
  //
  tmp:string;
  Vgm,Cstro,Crem,Pribil,UdelQtn,Rashot,UsEco,OriUsEco: double;
  _currentDate: string;
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
  //----------------------------------------------------------------------------

  function _str(dbl: double): string; overload;
  var
    d: string;
    i: integer;
  begin
    d:= Format('%.3f',[dbl]);
    for i:= 0 to length(d) do
      if d[i] = ',' then
        d[i]:= '.';

    Result:= d;
  end;

begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  _sg:= TStringGrid.Create(nil);
  _sg_input:= TStringGrid.Create(nil);
  colcount:= 0;
  rowcount:= 43;

  with _qry do
    try
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_ALL_FROM_RESULT_VARIANT;
      Open;

      _nameVariant:= FieldValues['Variant'];
      _openpitId:= getOpenpitId(_nameVariant);

      VIndex:= 0;
      colcount:= RecordCount;
      _sg.RowCount:= rowcount;
      _sg.ColCount:= colcount;
      while not Eof do
      begin
        _currentDate:= FormatDateTime('MM/DD/YYYY', FieldValues['VariantDate']);
        _sg.Cells[VIndex, 0]:= format('%s'+#13#10+'%s', [_nameVariant, _currentDate]);
        _sg.Cells[VIndex, 1]:= _str(FieldValues['CurrOreVm3'] + FieldValues['CurrStrippingVm3']);
        _sg.Cells[VIndex, 2]:= _str((FieldValues['CurrOreVm3'] + FieldValues['CurrStrippingVm3']) * 2 * 365);
        _sg.Cells[VIndex, 3]:= _str(FieldValues['CurrOreVm3']);
        _sg.Cells[VIndex, 4]:= _str(FieldValues['ShiftTmin']);
        _sg.Cells[VIndex, 5]:= _str(FieldValues['BaseVariantExpenesCtg'] +
                                    FieldValues['ServiceExpensesCtg'] +
                                    FieldValues['EconomExpensesCtg']);
        _sg.Cells[VIndex, 6]:= _str((FieldValues['AutosWorkSumGxCtg'] + FieldValues['AutosWorkSumTyresCtg'] +
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
                                    /(FieldValues['CurrOreVm3'] + FieldValues['CurrStrippingVm3']));
        _sg.Cells[VIndex, 7]:= _str(FieldValues['AutosWorkSalariesCtg'] +
                                    FieldValues['AutosWaitingSalariesCtg'] +
                                    FieldValues['ExcavatorsWorkSalariesCtg'] +
                                    FieldValues['ExcavatorsWaitingSalariesCtg']);
        _sg.Cells[VIndex, 8]:= _str(FieldValues['Ks']);
        _sg.Cells[VIndex, 9]:= _str(FieldValues['PeriodKshift']);
        _sg.Cells[VIndex, 10]:= _str(FieldValues['BlocksEmploymentCoef']);
        _sg.Cells[VIndex, 11]:= _str(FieldValues['AutosAvgTimeUsingCoef']);
        _sg.Cells[VIndex, 12]:= _str(FieldValues['ExcavatorsExcavatorsCount0']);
        _sg.Cells[VIndex, 13]:= _str(FieldValues['ExcavatorsGxWork'] +
                                     FieldValues['ExcavatorsGxWaiting']);
        _sg.Cells[VIndex, 14]:= _str(FieldValues['ExcavatorsGxWork']);
        _sg.Cells[VIndex, 15]:= _str(FieldValues['ExcavatorsAmortizationCtg']);
        _sg.Cells[VIndex, 16]:= _str(getCountOfUnloadingPunkts(_openpitId));
        _sg.Cells[VIndex, 17]:= _str(FieldValues['BlocksAmortizationCtg']);
        _sg.Cells[VIndex, 18]:= _str(FieldValues['BlocksLm']);
        _sg.Cells[VIndex, 19]:= _str(FieldValues['BlocksRepairCtg']);
        _sg.Cells[VIndex, 20]:= _str(FieldValues['AutosAutosCount0']);
        _sg.Cells[VIndex, 21]:= _str(getKPDs(_openpitId));
        _sg.Cells[VIndex, 22]:= _str(FieldValues['AutosUsedTyresCount'] /
                                     (FieldValues['CurrOreVm3'] +
                                      FieldValues['CurrStrippingVm3']));
        _sg.Cells[VIndex, 23]:= _str(0.0);
        _sg.Cells[VIndex, 24]:= _str(FieldValues['AutosTyresCtg']);
        _sg.Cells[VIndex, 25]:= _str(FieldValues['AutosGxCtg']);
        _sg.Cells[VIndex, 26]:= _str(FieldValues['AutosUdGx_gr_tkm']);
        _sg.Cells[VIndex, 27]:= _str(FieldValues['AutosGxWaiting'] +
                                     FieldValues['AutosGxWork']);
        _sg.Cells[VIndex, 28]:= _str(FieldValues['AutosAmortizationCtg']);
        _sg.Cells[VIndex, 29]:= _str(getCostEquipmqnt(_openpitId));
        //
        _sg.Cells[VIndex, 30]:= _str(FieldValues['ProductOutPutPercent']);
        _sg.Cells[VIndex, 31]:= _str(FieldValues['ProductPriceCtg']);
        _sg.Cells[VIndex, 32]:= _str(FieldValues['MTWorkByScheduleCtg']);
        _sg.Cells[VIndex, 33]:= _str(FieldValues['TruckCostCtg']);
        _sg.Cells[VIndex, 34]:= _str(FieldValues['ServiceExpensesCtg']);
        _sg.Cells[VIndex, 35]:= _str(FieldValues['BaseVariantExpenesCtg']);
        _sg.Cells[VIndex, 36]:= _str(FieldValues['PlannedRockVolumeCm']);
        //
        Vgm:= ((1440 / FieldValues['ShiftTmin']) * 365 * FieldValues['PeriodKshift']) * (FieldValues['CurrOreVm3'] + FieldValues['CurrStrippingVm3']) * 1000;
        Cstro:= FieldValues['TruckCostCtg'] * 1000;
        Crem:= FieldValues['ServiceExpensesCtg'] * 1000;
        Pribil:= ((Vgm * FieldValues['CurrOreVm3'] * FieldValues['ProductOutPutPercent'] * FieldValues['ProductPriceCtg'])/(( 1 + FieldValues['Ks']) * 100)) / 1000000;

        UdelQtn:= (FieldValues['AutosWorkSumGxCtg'] + FieldValues['AutosWorkSumTyresCtg'] +
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
              /(FieldValues['CurrOreVm3'] + FieldValues['CurrStrippingVm3']);
        Rashot:= (Vgm * UdelQtn + FieldValues['AutosTyresCtg'] + FieldValues['TruckCostCtg']*1000 + FieldValues['ServiceExpensesCtg']*1000) / 1000000;

        UsEco:= ((Vgm * FieldValues['CurrOreVm3'] * FieldValues['ProductOutPutPercent'] * FieldValues['ProductPriceCtg'])/((1 + FieldValues['Ks']) * 100)-(Vgm * UdelQtn + FieldValues['AutosTyresCtg'] + FieldValues['TruckCostCtg']*1000 + FieldValues['ServiceExpensesCtg']*1000))  / 1000000;

        OriUsEco:= (FieldValues['PlannedRockVolumeCm']*1000 * UdelQtn + FieldValues['PlannedRockVolumeCm']*1000 * (FieldValues['AutosTyresCtg'] / Vgm) + FieldValues['TruckCostCtg']*1000 + FieldValues['ServiceExpensesCtg']*1000) / 1000000;

        _sg.Cells[VIndex, 37]:= _str(Pribil);
        _sg.Cells[VIndex, 38]:= _str(Rashot);
        _sg.Cells[VIndex, 39]:= _str(UsEco);
        _sg.Cells[VIndex, 40]:= _str(0.0);
        _sg.Cells[VIndex, 41]:= _str(0.0);
        _sg.Cells[VIndex, 42]:= _str(OriUsEco);

        inc(VIndex);
        Next;
      end;

    finally
      Close;
      Free;
    end;

  data_to_excel:= VarArrayCreate([1, rowcount, 1, colcount],varVariant);
  for i:= 1 to VarArrayHighBound(data_to_excel, 1) do
    for j:= 1 to VarArrayHighBound(data_to_excel, 2) do
      data_to_excel[i, j]:=_sg.Cells[j-1, i-1];

  ToExcel(data_to_excel, colcount, rowcount);
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

end.


