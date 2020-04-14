unit unResultEconomEffect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, ActnList,
  DB, ADODB,
  TXTWriter, OleServer, ExcelXP,
  unEconomEffect;

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
    edAVGTransKPD
    : TEdit;
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
    btnBase: TButton;
    btnCalc: TButton;
    btnMakeBase: TButton;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgVariantCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure dbgVariantDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure btnBaseClick(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure btnMakeBaseClick(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
  private
    eeffect: TEconomEffect;
    _currentVariant: integer;
    procedure OpenVariants();
    procedure GetData();
    procedure GetInputData();
    procedure SetView();
  public
    { Public declarations }
  end;

var
  fmResultEconomEffect: TfmResultEconomEffect;

procedure esaShowResultEconomEffect();
implementation

uses
  unDM;
const
  // Label
  WORKFLOW_OF_SHIHT = 'Производительность ГТСК по ГМ за смену, тыс.м3.';
  WORKFLOW_OF_YEAR = 'Производительность ГТСК по ГМ за год, тыс.м3.';
  WEIGHT_OF_ORE = 'Объемный вес руды, т/м3';
  TIMEFLOW_OF_SHIHT = 'Продолжительность смены, мин';
  COST_OF_GTK = 'Затраты по горно-транспортному комплексу, тг';
  COST_OF_M3 = 'Удельные текущие затраты на 1 м3 по ГМ, тг/м3';
  CASH_EMPLOEE = 'ЗП машинистов и водителей, тыс.тг/мес.';
  KOEF_OF_ROCK = 'Коэффициент вскрыши Кв, т/т, м3/м3';
  KOEF_SHIHTCHANGE = 'Коэф. перехода сменных показателей на период';
  KOEF_PUNKT_BUZY = 'Коэффициент занятости пункта';
  KOEF_AUTOUSE = 'Коэффициент использования автосамосвалов';
  COUNT_EXCV_ON_LOAD = 'Число экскаваторов на погрузке, шт.';
  RASHOD_OF_ELECTRIC = 'Расход электроэнергии, кВт';
  COST_OF_ELECTRIC_1KV = 'Стоимость 1 кВт электроэнергии, тг';
  SUMCOST_OF_EXCV = 'Суммарные затраты по экскаваторам, тг';

  COUNT_OF_UNLOAD_PUNKT = 'Число пунктов выгрузки, шт ';
  SUMCOST_OF_ROAD = 'Суммарные затраты по автотрассе, тг';
  LENGTH_OF_ROAD = 'Общая протяженность автотрассы, км';
  COST_OF_ROAD_SUPPORT = 'Затраты на поддержание 1 км. дорог за период, тыс.тг';
  COUNT_OF_AUTOS = 'Рабочий парк автосамосвалов, шт';
  KPD_AUTO_TRANSMISSION = 'КПД автосамосвалов трансмиссии, %';
  RASHOD_TYRES = 'Удельный расход шин, шт/м3';
  COST_OF_1TYRE = 'Стоимость одной шины, тыс.тг';
  COST_ON_TYRES = 'Затраты на шины, тыс.тн/период';
  COST_ON_1GSM = 'Стоимость 1 литра топлива, тг';
  RASHOD_GSM = 'Удельный расход топлива, г/ткм';
  RASHOD_GSM_FOR_LITER = 'Расход топлива, л';
  SUMCOST_OF_AUTOS = 'Суммарные затраты по автосамосвалам, тг';
  OSTAT_COST = 'Остаточная стоим. оборуд. (экс и а/с), тыс.тг';

  PRODUCT_FROM_1TONNA = 'Выход продукта из одной тонны руды, %';
  PRICE_FOR_1TONNA = 'Цена одной тонны продукта, тыс.тг';
  COST_GTR = 'Стоимость ГТР по плану, млн.тг';
  COST_FOR_AUTO = 'Стоимость приобретаемого автосамосвала, тыс.тг';
  COST_FOR_SERVICE = 'Затраты на сервисное обслуживание, тыс.тг';
  COST_FOR_BASE_VARIANT = 'Затраты по базовому варианту, млн.тг';
  PLANNED_VALUE = 'Запланированный объем ГМ за период, тыс.м3';

  PROFIT = 'Прибыль, млн.тг';
  COSTS = 'Затрать, млн.тг';
  USLOVN_ECONOMIC_EFFECT = 'Условный экономический эффект, млн.тг';
  BASE_VARIANT = 'Базовый вариант, млн.тг';
  OTNOSIT_ECONOMIC_EFFECT = 'Относительный экономический эффект, млн.тг';
  VALUED_ECONOMIC_EFFECT = 'Объемно ориентированный условный ЭЭ, млн.тг';

  FORM_VARIABLES = 'Показатели ЭАК';
  VARIANTS_TITLE = 'Варианты моделирования';
  VARIANT_VARIABLES = 'Основные показатели эффективности ЭАК';
  CEBADAN_VARIABLES = 'Данные с CEBADAN';
  INPUT_VARIABLES = 'Входные данные';
  OUTPUT_VARIABLES = 'Выходные данные';
  _OUTPUT = 'Вывод';
  SET_AS_BASE = 'Установить как'+#13#10+'базовый вариант';
  _SET = 'Установить';
  GET_BASE_DATA = 'Получить данные'+#13#10+'базового варианта';
  _GET = 'Получить';
  ENTER_DATA = 'Ввести'+#13#10+'данные';
  _ENTER = 'Ввести';
  TO_CALC = 'Расчитать'+#13#10+'данные';
  _CALC = 'Расчитать';

  // SQL
  SELECT_ALL_VARIANTS = 'SELECT Id_ResultVariant, Variant, VariantDate FROM _ResultVariants';
  SELECT_FROM_RESULT_VARIANT =
  'SELECT ' +
    'Variant, ' +
    'BlocksLm, ' +
    'BlocksRepairCtg, ' +
    'ExcavatorsGxWork, ' +
    'AutosUdGx_gr_tkm, ' +
    'AutosGxCtg, ' +
    'AutosTyresCtg, ' +
    'Ks, ' +
    'AutosAutosCount0, ' +
    'ExcavatorsExcavatorsCount0, ' +
    'CurrOreVm3, ' +
    'CurrStrippingVm3, ' +
    'ExcavatorsGxWork, ExcavatorsGxWaiting, ' +
    'PeriodKshift, ' +
    'ShiftTmin, ' +
    'BlocksEmploymentCoef, ' +
    'AutosAvgTimeUsingCoef, ' +
    'ExcavatorsAmortizationCtg, ' +
    'AutosAmortizationCtg, ' +
    'BlocksAmortizationCtg, ' +
    'BaseVariantExpenesCtg, ServiceExpensesCtg, EconomExpensesCtg, ' +
    'AutosGxWaiting, AutosGxWork, ' +
    'AutosUsedTyresCount, ' +
    //6
    'AutosWorkSumGxCtg, AutosWorkSumTyresCtg, AutosWorkSparesCtg, ' +
    'AutosWorkMaterialsCtg, AutosWorkMaintenancesCtg, AutosWorkSalariesCtg, ' +
    'AutosWaitingSumGxCtg, AutosWaitingSparesCtg, AutosWaitingMaterialsCtg, ' +
    'AutosWaitingMaintenancesCtg, AutosWaitingSalariesCtg, AutosAmortizationCtg, ' +
    'BlocksRepairCtg, BlocksAmortizationCtg, ' +
    'ExcavatorsWorkSumGxCtg, ExcavatorsWorkMaterialsCtg, ExcavatorsWorkUnAccountedCtg, ' +
    'ExcavatorsWorkSalariesCtg, ExcavatorsWaitingSumGxCtg, ExcavatorsWaitingMaterialsCtg, ' +
    'ExcavatorsWaitingUnAccountedCtg, ExcavatorsWaitingSalariesCtg, ExcavatorsAmortizationCtg, ' +
    //---------
    'ProductOutPutPercent, ' +
    'ProductPriceCtg, ' +
    'MTWorkByScheduleCtg, ' +
    'TruckCostCtg, ' +
    'ServiceExpensesCtg, ' +
    'BaseVariantExpenesCtg, ' +
    'PlannedRockVolumeCm ' +
  'FROM _ResultVariants ' +
  'WHERE (Id_ResultVariant = :IdVariant)';
  SELECT_OPENPIT_BY_NAME = 'SELECT Id_Openpit FROM Openpits WHERE (Name = :OpenpitName)';
  SELECT_TRANSMISSION_KPD = 'SELECT SUM(TransmissionKPD) AS result FROM OpenpitDeportAutos WHERE Id_Openpit=:Id_Openpit';
  SELECT_COST_OF_EQUIPMENT = 'SELECT SUM(qost) AS result FROM (' +
                             'SELECT SUM(cost) AS qost FROM OpenpitDeportAutos WHERE Id_Openpit=:Id_Openpit ' +
                             'UNION ' +
                             'SELECT SUM(cost) AS qost FROM OpenpitDeportExcavators WHERE Id_Openpit=:Id_Openpit)';
  SELECT_COUNT_OF_UNLOADING_PUNKTS = 'SELECT COUNT(*) AS result FROM OpenpitUnLoadingPunkts WHERE Id_Openpit=:Id_Openpit';
  SELECT_PLAN_ROCKS = 'SELECT SUM(PlannedV1000m3) AS result ' +
                      'FROM OpenpitLoadingPunktRocks ' +
                      'WHERE Id_LoadingPunkt in (SELECT Id_LoadingPunkt ' +
                                                'FROM OpenpitLoadingPunkts ' +
                                                'WHERE Id_Openpit=:Id_Openpit)';
  UPDATE_PLAN_ROCKS = 'UPDATE _ResultVariants ' +
                      'SET PlannedRockVolumeCm=:PlannedRockVolumeCm ' +
                      'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  SELECT_BALANCE_AUTOS = 'SELECT SUM(DumpC1000tg) as result ' +
                         'FROM _ResultShiftAutos';
  UPDATE_BALANCE_AUTOS = 'UPDATE _ResultVariants ' +
                         'SET TruckCostCtg=:TruckCostCtg ' +
                         'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  SELECT_BASE_VARIANT = 'SELECT ProductOutPutPercent, ProductPriceCtg, ' +
                               'MTWorkByScheduleCtg, TruckCostCtg, ' +
                               'ServiceExpensesCtg, BaseVariantExpenesCtg, ' +
                               'PlannedRockVolumeCm ' +
                               ',Id_ResultVariant ' +
                        'FROM _ResultVariants ' +
                        'WHERE IsBaseVariant=True';
  UPDATE_CURRENT_INPUT_VALUES = 'UPDATE _ResultVariants ' +
                                'SET ProductOutPutPercent=:ProductOutPutPercent, ' +
                                'ProductPriceCtg=:ProductPriceCtg, ' +
                                'MTWorkByScheduleCtg=:MTWorkByScheduleCtg, ' +
                                'TruckCostCtg=:TruckCostCtg, ' +
                                'ServiceExpensesCtg=:ServiceExpensesCtg, ' +
                                'BaseVariantExpenesCtg=:BaseVariantExpenesCtg, ' +
                                'PlannedRockVolumeCm=:PlannedRockVolumeCm ' +
                                'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  UPDATE_VARIANTS_TO_OFF = 'UPDATE _ResultVariants SET IsBaseVariant=False';
  UPDATE_NEW_BASE_VARIANT = 'UPDATE _ResultVariants SET IsBaseVariant=True WHERE Id_ResultVariant=:NewId_ResultVariant';
  SELECT_COST_GTR_OF_BASE = 'SELECT ServiceExpensesCtg ' +
                            'FROM _ResultVariants ' +
                            'WHERE Id_ResultVariant=(SELECT Id_ResultVariant ' +
                                                    'FROM _ResultVariants ' +
                                                    'WHERE IsBaseVariant=True)';
  UPDATE_COST_GTR_OF_BASE = 'UPDATE _ResultVariants ' +
                            'SET BaseVariantExpenesCtg=:BaseVariantExpenesCtg ' +
                            'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  UPDATE_RESULT_BY_TONNE_OF_ORE = 'UPDATE _ResultVariants ' +
                                  'SET ProductOutPutPercent=:ProductOutPutPercent ' +
                                  'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  // TEXT value
  NAME_OF_VARIANT = 'Iaeiaiiaaiea aa?eaioa';
  DATE_OF_VARIANT = 'Aaoa nicaaiey aa?eaioa';
  //
  WIDTH_VARIANT_NAME = 200;

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
  //
  GetData();
  SetView();
end;

procedure TfmResultEconomEffect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryVariants.Close;
  qryResultVariants.Close;
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
    //EIA aaoinaiinaaeia o?ainiennee, %
    KPDs:= getKPDs(_openpitId);
    edAVGTransKPD.Text := Format('%.3f',[KPDs]);
    //Inoaoi?iay noiei. iai?oa. (yen e a/n), oun.oa
    ostat:= getCostEquipmqnt(_openpitId);
    edOstat.Text := Format('%.3f',[ostat]);
    //Eiee?anoai ioieoia ?aca?ocee
    CountUnloadingPunkt:= getCountOfUnloadingPunkts(_openpitId);
    edCountUnLodingPunkts.Text := Format('%d',[CountUnloadingPunkt]);
    //Iieacaoaeu ieioiinoe ?oau, o/i3
    Selic:= FieldValues['CurrOreVm3'];
    edSelic.Text := Format('%.3f',[Selic]);
    //Iauai aiauoie ane?uoe ca niaio, i3
    Stripping:= FieldValues['CurrStrippingVm3'];
    RocksVm3:= Selic + Stripping;
    edBLength.Text := Format('%d',[Integer(FieldValues['BlocksLm'])]);
    edZatrat.Text := Format('%.3f',[Double(FieldValues['BlocksRepairCtg'])]);
    edElectr.Text := Format('%.3f',[Double(FieldValues['ExcavatorsGxWork'])]);
    edUdelGx.Text := Format('%.3f',[Double(FieldValues['AutosUdGx_gr_tkm'])]);
    edStoiGx.Text := Format('%.3f',[Double(FieldValues['AutosGxCtg'])]);
    //I?i?ea oaeouea ?anoiau, naycaiiua n i?eia?aoaieai oei e o.a., iei.oa.
    STyres:= FieldValues['AutosTyresCtg'];
    edSTyres.Text := Format('%.3f',[STyres]);
    //Oaaeuiua oaeouea cao?aou ii ai?iie ianna, oa.
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
    edUdelQtn.Text := Format('%.3f',[UdelQtn]);//quResultEconomParamsTotalUdCostsCurrent0.AsFloat
    //Eiyooeoeaio ane?uoe, o/o
    KVsry:= FieldValues['Ks'];
    edKVsry.Text := Format('%.3f',[KVsry]);
    edShiftAutos.Text := Format('%d',[Integer(FieldValues['AutosAutosCount0'])]);
    edShiftExcavators.Text := Format('%d',[Integer(FieldValues['ExcavatorsExcavatorsCount0'])]);
    edRocksVm3.Text := Format('%.3f',[RocksVm3]);
    edStoiTyre.Text := Format('%.3f',[0.0]);//quAddEconomyAVGTransKPD.AsFloat
    edElec.Text := Format('%.3f',[Double(FieldValues['ExcavatorsGxWork']) +
                                  Double(FieldValues['ExcavatorsGxWaiting'])]);
    UdelTyres:=FieldValues['AutosUsedTyresCount'] / RocksVm3;
    edUdelTyres.Text := Format('%.6f',[UdelTyres]);
    //Iauai aiauoie ane?uoe ca aia, i3
    ProizPeriod:= RocksVm3 * 2 * 365;
    edProizPeriod.Text := Format('%.3f',[ProizPeriod]);
    Salary:= FieldValues['AutosWorkSalariesCtg'] + FieldValues['AutosWaitingSalariesCtg'] +
             FieldValues['ExcavatorsWorkSalariesCtg'] + FieldValues['ExcavatorsWaitingSalariesCtg'];
    edSalary.Text := Format('%.3f',[Salary]);
    //Eiyooeoeaio ia?aaiaa niaiiuo ia?aiao?ia ia ia?eia
    ResultPeriodCoef:= FieldValues['PeriodKshift'];
    edResultPeriodCoef.Text := Format('%.3f',[ResultPeriodCoef]);
    //I?iaie?eoaeuiinou niaiu, iei
    ParamsShiftDuration:= FieldValues['ShiftTmin'];
    edParamsShiftDuration.Text := Format('%.3f',[ParamsShiftDuration]);
    //
    edEmploymentRatio.Text := Format('%.2f',[Double(FieldValues['BlocksEmploymentCoef'])]);
    edWorkTimeUsingRatio.Text := Format('%.3f',[Double(FieldValues['AutosAvgTimeUsingCoef'])]);
    edExcavsCostsSummary.Text := Format('%.2f',[Double(FieldValues['ExcavatorsAmortizationCtg'])]);
    edAutosCostsSummary.Text := Format('%.2f',[Double(FieldValues['AutosAmortizationCtg'])]);
    edBlocksCostsSummary.Text := Format('%.2f',[Double(FieldValues['BlocksAmortizationCtg'])]);
    edTotalCostsSummary.Text := Format('%.2f',[Double(FieldValues['BaseVariantExpenesCtg']) +
                                              Double(FieldValues['ServiceExpensesCtg']) +
                                              Double(FieldValues['EconomExpensesCtg'])]);
    edGx.Text := Format('%.2f',[Double(FieldValues['AutosGxWaiting']) +
                                Double(FieldValues['AutosGxWork'])]);
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
    Cstro:= StoiPrib * 1000;
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

procedure TfmResultEconomEffect.OpenVariants;
begin
  with qryVariants do
  begin
    SQL.Text:= SELECT_ALL_VARIANTS;
    Open;
  end;
  dbgVariant.DataSource.DataSet.Last;
  //
  dbgVariant.Columns[0].Visible:= false;
  dbgVariant.Columns[1].Width:= WIDTH_VARIANT_NAME;
  dbgVariant.Columns[2].Width:= dbgVariant.Width - (WIDTH_VARIANT_NAME*2);
  //
  dbgVariant.Columns[1].Title.Caption:= NAME_OF_VARIANT;
  dbgVariant.Columns[2].Title.Caption:= DATE_OF_VARIANT;
  //
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
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

  Label43.Caption:= SET_AS_BASE;
  btnMakeBase.Caption:= _SET;
  Label44.Caption:= GET_BASE_DATA;
  btnBase.Caption:= _GET;
  Label45.Caption:= ENTER_DATA;
  btnEnter.Caption:= _ENTER;
  Label46.Caption:= TO_CALC;
  btnCalc.Caption:= _CALC;
end;

procedure TfmResultEconomEffect.btnBaseClick(Sender: TObject);
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
end;

procedure TfmResultEconomEffect.btnMakeBaseClick(Sender: TObject);
var
  _qry: TADOQuery;
  baseVariant: integer;
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

  Vgm:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef) * RocksVm3 * 1000;
  Cstro:= StoiPrib * 1000;
  Crem := ZatSer * 1000;
  Pribil:= ((Vgm * Selic * Produk * SenaProd)/(( 1 + KVsry) * 100)) / 1000000;
  Rashot:= (Vgm * UdelQtn + STyres + Cstro + Crem) / 1000000;
  UsEco:= ((Vgm * Selic * Produk * SenaProd)/((1 + KVsry) * 100)-(Vgm * UdelQtn + STyres + Cstro + Crem))  / 1000000;
  OtnoEcom:= 0;
  Vn:= QtnGM * 1000;
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

end.
