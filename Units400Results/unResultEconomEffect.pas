unit unResultEconomEffect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, ActnList,
  DB, ADODB,
  TXTWriter, OleServer, ExcelXP;

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
    Panel1: TPanel;
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
    btnOutput: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgVariantCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure dbgVariantDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
  private
    _currentVariant: integer;
    procedure OpenVariants();
    procedure GetData();
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
  WORKFLOW_OF_SHIHT = 'Производительность ГТСК по ГМ за смену, м3.';
  WORKFLOW_OF_YEAR = 'Производительность ГТСК по ГМ за год, м3.';
  WEIGHT_OF_ORE = 'Объемный вес руды, т/м3';
  TIMEFLOW_OF_SHIHT = 'Продолжительность смены, мин';
  COST_OF_GTK = 'Затраты по горно-транспортному комплексу, тг';
  COST_OF_M3 = 'Удельные текущие затраты на 1 м3 по ГМ, тг/м3';
  CASH_EMPLOEE = 'ЗП машинистов и водителей, тг.';
  KOEF_OF_ROCK = 'Коэффициент вскрыши Кв, т/т, м3/м3';
  KOEF_SHIHTCHANGE = 'Коэф. перехода сменных показателей на период';
  KOEF_PUNKT_BUZY = 'Коэффициент занятости пункта';
  KOEF_AUTOUSE = 'Коэффициент использования автосамосвалов';
  COUNT_EXCV_ON_LOAD = 'Число экскаваторов на погрузке, шт.';
  RASHOD_OF_ELECTRIC = 'Расход электроэнергии, кВт';
  COST_OF_ELECTRIC_1KV = 'Стоимость 1 кВт электроэнергии, тг';
  SUMCOST_OF_EXCV = 'Суммарные затраты по экскаваторам, тг';

  COUNT_OF_UNLOAD_PUNKT = 'Число пунктов выгрузки, шт';
  SUMCOST_OF_ROAD = 'Суммарные затраты по автотрассе, тг';
  LENGTH_OF_ROAD = 'Общая протяженность автотрассы, км';
  COST_OF_ROAD_SUPPORT = 'Затраты на поддержание 1 км. дорог за период, тыс.тг ';
  COUNT_OF_AUTOS = 'Рабочий парк автосамосвалов, шт';
  KPD_AUTO_TRANSMISSION = 'КПД автосамосвалов трансмиссии, %';
  RASHOD_TYRES = 'Удельный расход шин, шт/м3';
  COST_OF_1TYRE = 'Стоимость одной шины, тыс.тг';
  COST_ON_TYRES = 'Затраты на шины, тыс.тн/период';
  COST_ON_1GSM = 'Стоимость 1 литра топлива, тг ';
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
  COSTS = 'Затраты, млн.тг';
  USLOVN_ECONOMIC_EFFECT = 'Условный экономический эффект, млн.тг';
  BASE_VARIANT = 'Базовый вариант, млн.тг';
  OTNOSIT_ECONOMIC_EFFECT = 'Относительный экономический эффект, млн.тг';
  VALUED_ECONOMIC_EFFECT = 'Объемно ориентированный условный ЭЭ, млн.тг';

  FORM_VARIABLES = 'Эффективность ЭАК';
  VARIANTS_TITLE = 'Список вариантов моделирования';
  VARIANT_VARIABLES = 'Основные показатели эффективности ЭАК';
  CEBADAN_VARIABLES = 'Данные с CEBADAN';
  INPUT_VARIABLES = 'Входные данные';
  OUTPUT_VARIABLES = 'Выходные данные';
  OUTPUT_DATA = 'Вывод';

  // SQL
  SELECT_ALL_VARIANTS = 'SELECT Id_ResultVariant, Variant, VariantDate FROM _ResultVariants';
  SELECT_FROM_RESULT_VARIANT =
  'SELECT ' +
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

  // TEXT value
  NAME_OF_VARIANT = 'Наименование варианта';
  DATE_OF_VARIANT = 'Дата создания варианта';
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
  UdelTyres, Stripping: Double;
begin
  _currentVariant:= dbgVariant.DataSource.DataSet.FieldValues['Id_ResultVariant'];
  with qryResultVariants do
  begin
    Close;
    SQL.Clear;
    SQL.Text:= SELECT_FROM_RESULT_VARIANT;
    Parameters.ParamByName('IdVariant').Value:= _currentVariant;
    Open;

    //Показатель плотности руды, т/м3
    Selic:= FieldValues['CurrOreVm3'];
    edSelic.Text := Format('%.3f',[Selic]);
    //Объем добытой вскрыши за смену, м3
    Stripping:= FieldValues['CurrStrippingVm3'];
    RocksVm3:= Selic + Stripping;
    edBLength.Text := Format('%d',[Integer(FieldValues['BlocksLm'])]);
    edZatrat.Text := Format('%.3f',[Double(FieldValues['BlocksRepairCtg'])]);
    edElectr.Text := Format('%.3f',[Double(FieldValues['ExcavatorsGxWork'])]);
    edUdelGx.Text := Format('%.3f',[Double(FieldValues['AutosUdGx_gr_tkm'])]);
    edStoiGx.Text := Format('%.3f',[Double(FieldValues['AutosGxCtg'])]);
    //Прочие текущие расходы, связанные с приобретением шин и т.д., млн.тг.
    STyres:= FieldValues['AutosTyresCtg'];
    edSTyres.Text := Format('%.3f',[STyres]);
    //Удельные текущие затраты по горной массе, тг.
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
    //Коэффициент вскрыши, т/т
    KVsry:= FieldValues['Ks'];
    edKVsry.Text := Format('%.3f',[KVsry]);
    edShiftAutos.Text := Format('%d',[Integer(FieldValues['AutosAutosCount0'])]);
    edAVGTransKPD.Text := Format('%.3f',[0.0]);//quAddEconomyAVGTransKPD.AsFloat
    edShiftExcavators.Text := Format('%d',[Integer(FieldValues['ExcavatorsExcavatorsCount0'])]);
    edRocksVm3.Text := Format('%.3f',[RocksVm3]);
    edCountUnLodingPunkts.Text := Format('%d',[0]);//quAddEconomySF.AsString;
    edStoiTyre.Text := Format('%.3f',[0.0]);//quAddEconomyAVGTransKPD.AsFloat
    edOstat.Text := Format('%.3f',[0.0]);//Cost+quAddEconomySF.AsFloat
    edElec.Text := Format('%.3f',[Double(FieldValues['ExcavatorsGxWork']) +
                                  Double(FieldValues['ExcavatorsGxWaiting'])]);
    UdelTyres:=FieldValues['AutosUsedTyresCount'] / RocksVm3;
    edUdelTyres.Text := Format('%.3f',[UdelTyres]);
    //Объем добытой вскрыши за год, м3
    ProizPeriod:= RocksVm3 * 2 * 365;
    edProizPeriod.Text := Format('%.3f',[ProizPeriod]);
    Salary:= FieldValues['AutosWorkSalariesCtg'] + FieldValues['AutosWaitingSalariesCtg'] +
             FieldValues['ExcavatorsWorkSalariesCtg'] + FieldValues['ExcavatorsWaitingSalariesCtg'];
    edSalary.Text := Format('%.3f',[Salary]);
    //Коэффициент перевода сменных параметров на период
    ResultPeriodCoef:= FieldValues['PeriodKshift'];
    edResultPeriodCoef.Text := Format('%.3f',[ResultPeriodCoef]);
    //Продолжительность смены, мин
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
    //Показатель выхода продукта с 1 тонны руды, %
    Produk:= FieldValues['ProductOutPutPercent'];
    edProduk.Text:= Format('%.3f',[Produk]);
    //Цена одной тонны продукта, тыс.тг.
    SenaProd:= FieldValues['ProductPriceCtg'];
    edSenaProd.Text:= Format('%.3f',[SenaProd]);
    edStoiGTR.Text := Format('%.3f',[Double(FieldValues['MTWorkByScheduleCtg'])]);
    //Стоимость приобретаемого автосамосвала, тыс.тг.
    StoiPrib:= FieldValues['TruckCostCtg'];
    edStoiPrib.Text := Format('%.3f',[StoiPrib]);
    //Затраты на сервисное обслуживание, тыс.тг
    ZatSer:= FieldValues['ServiceExpensesCtg'];
    edZatSer.Text := Format('%.3f',[ZatSer]);
    edBaseVar.Text := Format('%.3f',[Double(FieldValues['BaseVariantExpenesCtg'])]);
    //Запланированный объем ГМ за период, тыс.м3
    QtnGM:= FieldValues['PlannedRockVolumeCm'];
    edQtnGM.Text := Format('%.3f',[QtnGM]);
    //--------------------------------------------------------------------------
    //Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, тыс.м3
    Vgm:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef) * RocksVm3 * 1000;
    //Прочие дополнительные единовременные расходы на строительство автодорог и
    //железнодорожных путей, приобретение нового оборудования, строительство
    //дополнительных съездов и т.д., млн.тг.
    Cstro:= StoiPrib * 1000;
    //Сумма затрат, связанная с текущими ремонтами автосамосвалов
    Crem := ZatSer * 1000;
    //Прибыль, млн.тг.
    Pribil:= ((Vgm * Selic * Produk * SenaProd)/(( 1 + KVsry) * 100)) / 1000000;
    edPribil.Text := Format('%.6f',[Pribil]);
    //Затраты, млн.тг
    Rashot:= (Vgm * UdelQtn + STyres + Cstro + Crem) / 1000000;
    edRashot.Text := Format('%.6f',[Rashot]);
    //Условный экономический эффект, млн.тг.
    UsEco:= ((Vgm * Selic * Produk * SenaProd)/((1 + KVsry) * 100)-(Vgm * UdelQtn + STyres + Cstro + Crem))  / 1000000;
    edUsEcom.Text := Format('%.6f',[UsEco]);
    //Базовый вариант, млн.тг
    edBaseVari.Text:= Format('%.6f',[0.0]);
    //Относительный экономический эффект, млн.тг.
    OtnoEcom:= 0;//(quResultAddEconomParamsUsEcom.AsFloat - UsEco);
    edOtnoEcom.Text := Format('%.6f',[OtnoEcom]);
    //Объем горной массы запланированный к извлечению в расматриваемом периоде, тыс.м3
    Vn:= QtnGM * 1000;
    //Объемно ориентированный условный экономический эффект, млн.тг.
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
  btnOutput.Caption:= OUTPUT_DATA;
end;

end.
