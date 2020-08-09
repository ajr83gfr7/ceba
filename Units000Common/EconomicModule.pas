unit EconomicModule;

interface

uses
  DB, ADODB, Classes, SysUtils,
  unDM, EconomicResultVariant;

const
  SELECT_RESULT_VARIANT = 'SELECT * FROM _ResultVariants';
  SELECT_RESULT_VARIANT_BY_ID = 'SELECT * FROM _ResultVariants ' +
                                'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  UPDATE_CURRENT_INPUT_VALUES = 'UPDATE _ResultVariants ' +
                                'SET ProductOutPutPercent=:ProductOutPutPercent, ' +
                                'ProductPriceCtg=:ProductPriceCtg, ' +
                                'MTWorkByScheduleCtg=:MTWorkByScheduleCtg, ' +
                                'TruckCostCtg=:TruckCostCtg, ' +
                                'ServiceExpensesCtg=:ServiceExpensesCtg, ' +
                                'BaseVariantExpenesCtg=:BaseVariantExpenesCtg, ' +
                                'PlannedRockVolumeCm=:PlannedRockVolumeCm ' +
                                'WHERE (Id_ResultVariant=:Id_ResultVariant)';

type

  TEconomicResult = class(TEconomicDump)
  published
  private
    _BaseUEconomicEffect: double;
    GMisAvg: boolean;
    function CalcPeriodKshift: double;
    function CalcKs: double;
    function CalcCoefOfUseAutos: double;
    function CalcSelic: double;
    function CalcTruckCost: double;
    function CalcServiceTruckCost: double;
    function CalcNameOfVariant: string;
    function CalcDataOfVariant: string;
    function CalcShiftNaryad: double;
    function CalcShiftTimelap: double;
    function CalcAutosKm: double;
    function CalcAutosGx: double;
    function CalcAutosDirGx: double;
    function CalcAutosTmin: double;
    function CalcAutosDirTmin: double;
    function CalcAutosWorkCost: double;
    function CalcAutosWaitingCost: double;
    function CalcAutosCost: double;
    function CalcAutosCount: double;
    function CalcExcavatorsGx: double;
    function CalcExcavatorsTmin: double;
    function CalcExcavatorsRockRatio: double;
    function CalcExcavatorsWorkCost: double;
    function CalcExcavatorsWaitingCost: double;
    function CalcExcavatorsCost: double;
    function CalcExcavatorsCount: double;
    function CalcSalary: double;
    function CalcElectricityCost: double;
    function CalcElectricityCostByShift: double;
    function CalcTotalExcavatorsCost: double;
    function CalcTotalRoadsCost: double;
    function CalcTotalRoadsLength: double;
    function CalcRoadCostByYear: double;
    function CalcTyreUdelCost: double;
    function CalcTyrePrice: double;
    function CalcTytesCostByShift: double;
    function CalcGSMPrice: double;
    function CalcGSMUdelCost: double;
    function CalcGSMCost: double;
    function CalcTotalAutosCost: double;

    function CalcTotalCosts:double;
    function CalcTotalShiftCosts:double;
    function CalcTyresCost: double;
    function CalcTyresShiftCost: double;
    function CalcCurrentCost: double;
    function CalcUdelnCurrentCost: double;
    function CalcVolumeOfGM_tn: double;
    function CalcVolumeOfGM_tn_avg: double;
    function CalcVolumeOfGM_m3: double;
    function CalcVolumeOfGM_m3_avg: double;
    function CalcVolumeOfGM_m3_byYear: double;
    function CalcPlanVolume_m3: double;
    function CalcVolumeOfOre: double;
    function CalcProfit: double;
    function CalcUEconomicEffect: double;
    function CalcOEconomicEffect: double;
    function CalcOOUEconomicEffect: double;
    function CalcResultBy1Tonna: double;
    function CalcPriceBy1Tonna: double;
    function CalcGTRCost: double;
  public
    constructor Create(Fields: TFields; isAvg: boolean = true);
    function PtintVar: string;
    function SaveInputValues(AProductOutPutPercent,
                             AProductPriceCtg,
                             AMTWorkByScheduleCtg,
                             ATruckCostCtg,
                             AServiceExpensesCtg,
                             ABaseVariantExpenesCtg,
                             APlannedRockVolumeCm: double): boolean;
    procedure ToUpdate();
    //----------------------------
    // Коэффциенты
    //----------------------------
    // Коэффциент первода сменных показателей, тг / 620.50
    property CoefOfPeriodShift: double read CalcPeriodKshift;
    // Коэффициент вскрыши, т/т
    property CoefOfVsry: double read CalcKs;
    // Коэффициент использования автосамосвалов
    property CoefOfUseAutos: double read CalcCoefOfUseAutos;
    //----------------------------
    // Показатели / Стоимостные показатели
    //----------------------------
    // Показатель плотности руды, т/м3
    property Selic: double read CalcSelic;
    // Стоимость приобретаемого автосамосвала, тг
    property TruckCost: double read CalcTruckCost;
    // Сумма затрат связанная с текущими ремонтами автосамосвалов
    property ServiceTruckCost: double read CalcServiceTruckCost;
    // Показатель выхода продукта с 1 тонны руды, % //Bn
    property ResultBy1Tonna: double read CalcResultBy1Tonna;
    // Показатель цены на 1 тонну продукта на рынке сбыта, тг. //Cn
    property PriceBy1Tonna: double read CalcPriceBy1Tonna;
    // Стоимость ГТР по вариант, млн.тг
    property GTRCost: double read CalcGTRCost;
    //----------------------------
    // Параметры модели
    //----------------------------
    // Название варианта результатов
    property NameOfVariant: string read CalcNameOfVariant;
    // Дата варианта результата
    property DataOfVariant: string read CalcDataOfVariant;
    // Рабочее время смены, мин
    property ShiftNaryad: double read CalcShiftNaryad;
    // Продолжительность смены, мин
    property ShiftTimelap: double read CalcShiftTimelap;
    // Пробег автосамосвлов, м
    property AutosKm: double read CalcAutosKm;
    // Общий расход топлива, л
    property AutosGx: double read CalcAutosGx;
    // Расход топлива в движении, л
    property AutosDirGx: double read CalcAutosDirGx;
    // Время работы автосамосвалов, мин
    property AutosTmin: double read CalcAutosTmin;
    // Время работы автосамосвалов в движении, мин
    property AutosDirTmin: double read CalcAutosDirTmin;
    // Затраты автосамосвалов во время работы, тг
    property AutosWorkCost: double read CalcAutosWorkCost;
    // Затраты автосамосвалов во время простоя, тг
    property AutosWaitingCost: double read CalcAutosWaitingCost;
    // Затраты атосамосвалов, тг
    property AutosCost: double read CalcAutosCost;
    // Рабочий парк автосамосвалов, шт
    property AutosCount: double read CalcAutosCount;
    // Расход топлива экскаваторами, л
    property ExcavatorsGx: double read CalcExcavatorsGx;
    // Время работы экскаваторов, мин
    property ExcavatorsTmin: double read CalcExcavatorsTmin;
    // Процент выполненной работы экскаваторов, %
    property ExcavatorsRockRatio: double read CalcExcavatorsRockRatio;
    // Затраты экскаваторов во время работы, тг
    property ExcavatorsWorkCost: double read CalcExcavatorsWorkCost;
    // Затраты экскаваторов во время простоя, тг
    property ExcavatorsWaitingCost: double read CalcExcavatorsWaitingCost;
    // Затраты экскаваторов
    property ExcavatorsCost: double read CalcExcavatorsCost;
    // Число экскаваторов на погрузке, шт.
    property ExcavatorsCount: double read CalcExcavatorsCount;
    //Затраты на заработную плату
    property Salary: double read CalcSalary;
    // Расход электроэнергии, кВт*ч
    property ElectricityCost: double read CalcElectricityCost;
    // Затраты на электроэнергию, тг/смена
    property ElectricityCostByShift: double read CalcElectricityCostByShift;
    // Суммарные затраты по экскаваторам, тг
    property TotalExcavatorsCost: double read CalcTotalExcavatorsCost;
    // Суммарные затраты по автотрассе, тг
    property TotalRoadsCost: double read CalcTotalRoadsCost;
    // Общая протяженность автотрассы, км
    property TotalRoadsLength: double read CalcTotalRoadsLength;
    // Затраты на поддержание 1 км.дорог/год, тыс.тг'
    property RoadCostByYear: double read CalcRoadCostByYear;
    // Удельный расход шин, шт/м3
    property TyreUdelCost: double read CalcTyreUdelCost;
    // Стоимость одной шины, тыс.тг
    property TyrePrice: double read CalcTyrePrice;
    // Затраты на шины, тг./смена
    property TytesCostByShift: double read CalcTytesCostByShift;
    // Стоимость 1 литра топлива, тг
    property GSMPrice: double read CalcGSMPrice;
    // Удельный расход топлива, г/ткм
    property GSMUdelCost: double read CalcGSMUdelCost;
    // Расход топлива, л
    property GSMCost: double read CalcGSMCost;
    // Суммарные затраты по автосамосвалам, тг
    property TotalAutosCost: double read CalcTotalAutosCost;
    //----------------------------
    // Затраты
    //----------------------------
    // Общие затраты ГТК, тг
    property TotalCost: double read CalcTotalCosts;
    // Общие затраты ГТК за смену, тг
    property TotalShiftCost: double read CalcTotalShiftCosts;
    // Затраты на шины (год), тг
    property TyresCost: double read CalcTyresCost;
    // Затраты на шины (смена), тг
    property TyresShiftCost: double read CalcTyresShiftCost;
    // Текущие затраты по горной массе, тенге
    property CurrentCost: double read CalcCurrentCost;
    // Удельные текущие затраты по горной массе, тенге  - на m3??
    property UdelCost: double read CalcUdelnCurrentCost;
    // Удельные эксплутационные затраты на единицу горной массы (на 1 м3)
    //property UdelExpuatacCost: double read CalcUdelnCurrentCost;
    //----------------------------
    // Объем ГМ
    //----------------------------
    // Объем извлекаемой горной массы, получаемый по результатам моделирования, tn
    property VolumeOfGM_tn: double read CalcVolumeOfGM_tn;
    // Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, tn
    property VolumeOfGM_tn_avg: double read CalcVolumeOfGM_tn_avg;
    // Объем извлекаемой горной массы, получаемый по результатам моделирования, м3
    property VolumeOfGM_m3: double read CalcVolumeOfGM_m3;
    // Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, м3
    property VolumeOfGM_m3_avg: double read CalcVolumeOfGM_m3_avg;
    // Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, м3
    property VolumeOfGM_m3_byYear: double read CalcVolumeOfGM_m3_byYear;
    // Объем горной массы запланированный к извлечению в рассматриваемом периоде, Vn в м3}
    property PlanVolume_m3: double read CalcPlanVolume_m3;
    // done: добавть объем добытой руды
    // Объем добытой руды, м3
    property VolumeOfOre: double read CalcVolumeOfOre;
    //----------------------------
    // Результат
    //----------------------------
    // Прибыль, тг
    property Profit: double read CalcProfit;
    // Базовый условный экономический эффект, тг
    property BaseUEconomicEffect: double read _BaseUEconomicEffect write _BaseUEconomicEffect;
    // Условный экономический эффект, тг
    property UEconomicEffect: double read CalcUEconomicEffect;
    // Относительный экономический эффект, тг
    property OEconomicEffect: double read CalcOEconomicEffect;
    // Объемно ориентированный условный экономический эффект, млн.тг
    property OOUEconomicEffect: double read CalcOOUEconomicEffect;
  end;

  TResultVariants = class
  published
    _items: TList;
    function _getItem(index: integer): TEconomicResult;
  private
    _currentVariantId: integer;
    _baseVariantId: integer;
    function _getBaseVariantId: integer;
    function _getCurrentVariant: TEconomicResult;
    function _getBaseVariant: TEconomicResult;
    procedure _setBaseVariant(newBaseVariant: TEconomicResult);
  public
    constructor Create;
    destructor Destroy; override;
    function FindResultById(idVariant: integer): TEconomicResult;
    procedure DeleteItem(_idResultVariant: integer);
    property Items[index: integer]: TEconomicResult read _getItem;
    property CurrentVariantId: integer read _currentVariantId write _currentVariantId;
    property BaseVariantId: integer read _getBaseVariantId write _baseVariantId;
    property CurrentVariant: TEconomicResult read _getCurrentVariant;
    property BaseVariant: TEconomicResult read _getBaseVariant write _setBaseVariant;
  end;

// Общие затраты ГТК, млн.тг
function CalcTotalCosts(Vgm: double; UdelQtn: double; STyres: double; Cstro: double; Crem: double):double;
// Объем извлекаемой горной массы, получаемый по результатам моделирования, м3
function CalcVolumeOfGM_m3(ExcavatorsRockV_m3: double): double;
// Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, м3
function CalcVolumeOfGM_avg_m3(Selic_m3: double; CurrStrippingVm3_m3: double; ExcavatorsRockV_m3: double): double;
// Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, м3
function CalcVolumeOfGM_byYear_m3(RocksVm3: double; PeriodCoef: double):double;
// Затраты на шины, тг
function CalcTyresCost(AutosTyresCtg: double; PeriodCoef: double): double;

implementation

// Общие затраты ГТК, млн.тг
function CalcTotalCosts(
                        //объем за период
                        Vgm: double;
                        //Удельные текущие затраты по горной массе, тенге  - на m3
                        UdelQtn: double;
                        //Прочие текущие расходы связанные с приобретением шин и т.д., млн.тенге
                        STyres: double;
                        {Прочие дополнительные единовременные расходы на строительство
                        автодорог и железнодорожных путей, приобретение нового оборудования,
                        строительство дополнительных съездов и т.д., млн.тенге}
                        Cstro: double;
                        {Сумма затрат связанная с текущими ремонтами автосамосвалов}
                        Crem: double
                        ):double;
begin
  Result:= (Vgm * UdelQtn + STyres + Cstro + Crem);
end;

// Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, м3
function CalcVolumeOfGM_byYear_m3(
                        // Объем горной массы, м3
                        RocksVm3: double;
                        // Коэффициент перевода сменных параметров на период
                        PeriodCoef: double
                        ):double;
begin
//  PeriodCoef:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef)
  Result:= RocksVm3 * PeriodCoef;
end;

// Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, м3
function CalcVolumeOfGM_avg_m3(
                           // Объем добытой руды, м3
                           Selic_m3: double;
                           // Объем добытой вскрыши, м3
                           CurrStrippingVm3_m3: double;
                           // Погруженная горная масса, м3
                           ExcavatorsRockV_m3: double
                           ): double;
begin
  Result:= (Selic_m3 + CurrStrippingVm3_m3 + ExcavatorsRockV_m3) / 2;
end;

// Объем извлекаемой горной массы, получаемый по результатам моделирования, м3
function CalcVolumeOfGM_m3(
                           // Погруженная горная масса, м3
                           ExcavatorsRockV_m3: double
                           ): double;
begin
  Result:= ExcavatorsRockV_m3;
end;

// Затраты на шины, тг
function CalcTyresCost(
                      //Затраты на шины, тг
                      AutosTyresCtg: double;
                      // Коэффициент перевода сменных параметров на период
                      PeriodCoef: double
                      ): double;
begin
  Result:= AutosTyresCtg * PeriodCoef;
end;

{ TEconomicResult }

function TEconomicResult.CalcAutosCost: double;
// Затраты атосамосвалов, тг
begin
  Result:= AutosWorkCost + AutosWaitingCost + AutosAmortizationCtg;
end;

function TEconomicResult.CalcAutosCount: double;
// Рабочий парк автосамосвалов, шт
begin
  Result:= AutosAutosCount0;
end;

function TEconomicResult.CalcAutosDirGx: double;
// Расход топлива в движении, л
begin
  Result:= AutosGxNulled + AutosGxLoading + AutosGxUnLoading;
end;

function TEconomicResult.CalcAutosDirTmin: double;
// Время работы автосамосвалов в движении, мин
begin
  Result:= AutosTminNulled + AutosTminLoading + AutosTminUnLoading;
end;

function TEconomicResult.CalcAutosGx: double;
// Общий расход топлива, л
begin
  Result:= AutosGxWork + AutosGxWaiting;
end;

function TEconomicResult.CalcAutosKm: double;
// Пробег автосамосвлов, м
begin
  Result:= AutosSkmNulled + AutosSkmLoading + AutosSkmUnLoading;
end;

function TEconomicResult.CalcAutosTmin: double;
// Время работы автосамосвалов, мин
begin
  Result:= AutosTminMoving + AutosTminWaiting +
           AutosTminManevr + AutosTminOnLoading +
           AutosTminOnUnLoading;
end;

function TEconomicResult.CalcAutosWaitingCost: double;
// Затраты автосамосвалов во время простоя, тг
begin
  Result:= AutosWaitingSumGxCtg + AutosWaitingSparesCtg +
           AutosWaitingMaterialsCtg + AutosWaitingMaintenancesCtg +
           AutosWaitingSalariesCtg;
end;

function TEconomicResult.CalcAutosWorkCost: double;
// Затраты автосамосвалов во время работы, тг
begin
  Result:= AutosWorkSumGxCtg + AutosWorkSumTyresCtg +
           AutosWorkSparesCtg + AutosWorkMaterialsCtg +
           AutosWorkMaintenancesCtg + AutosWorkSalariesCtg;
end;

function TEconomicResult.CalcCoefOfUseAutos: double;
// Коэффициент использования автосамосвалов
begin
  Result:= AutosAvgTimeUsingCoef;
end;

function TEconomicResult.CalcCurrentCost: double;
// Текущие затраты по горной массе, тенге
begin
  Result:= AutosCost + ExcavatorsCost +
           BlocksRepairCtg +
           EconomExpensesCtg +
           BlocksAmortizationCtg;
end;

function TEconomicResult.CalcElectricityCost: double;
//Расход электроэнергии, кВт*ч
begin
  Result:= ExcavatorsGxWork + ExcavatorsGxWaiting;
end;

function TEconomicResult.CalcElectricityCostByShift: double;
//Затраты на электроэнергию, тг/смена
begin
  Result:= ExcavatorsWorkSumGxCtg + ExcavatorsWaitingSumGxCtg;
end;

function TEconomicResult.CalcExcavatorsCost: double;
//Затраты экскаваторов
begin
  Result:= ExcavatorsWorkCost + ExcavatorsWaitingCost + ExcavatorsAmortizationCtg;
end;

function TEconomicResult.CalcExcavatorsCount: double;
// Число экскаваторов на погрузке, шт.
begin
  Result:= ExcavatorsExcavatorsCount0;
end;

function TEconomicResult.CalcExcavatorsGx: double;
// Расход топлива экскаваторами, л
begin
  Result:= ExcavatorsGxWork + ExcavatorsGxWaiting;
end;

function TEconomicResult.CalcExcavatorsRockRatio: double;
// Процент выполненной работы экскаваторов, %
begin
  Result:= 0;
  if ExcavatorsPlanRockQtn <> 0 then
    Result:= ExcavatorsRockQtn * 100 / ExcavatorsPlanRockQtn;
end;

function TEconomicResult.CalcExcavatorsTmin: double;
// Время работы экскаваторов, мин
begin
  Result:= ExcavatorsTminWork + ExcavatorsTminWaiting + ExcavatorsTminManevr;
end;

function TEconomicResult.CalcExcavatorsWaitingCost: double;
// Затраты экскаваторов во время простоя, тг
begin
  Result:= ExcavatorsWaitingSumGxCtg + ExcavatorsWaitingMaterialsCtg +
           ExcavatorsWaitingUnAccountedCtg + ExcavatorsWaitingSalariesCtg;
end;

function TEconomicResult.CalcExcavatorsWorkCost: double;
// Затраты экскаваторов во время работы, тг
begin
  Result:= ExcavatorsWorkSumGxCtg + ExcavatorsWorkMaterialsCtg +
           ExcavatorsWorkUnAccountedCtg + ExcavatorsWorkSalariesCtg;
end;

function TEconomicResult.CalcGSMCost: double;
// Расход топлива, л
begin
  Result:= AutosGxWaiting + AutosGxWork;
end;

function TEconomicResult.CalcGSMPrice: double;
// Стоимость 1 литра топлива, тг
begin
  Result:= AutosGxCtg;
end;

function TEconomicResult.CalcGSMUdelCost: double;
// Удельный расход топлива, г/ткм
begin
  Result:= AutosUdGx_gr_tkm;
end;

function TEconomicResult.CalcGTRCost: double;
// Стоимость ГТР по вариант, млн.тг
begin
  Result:= MTWorkByScheduleCtg;
end;

function TEconomicResult.CalcNameOfVariant: string;
// Название варианта результатов
begin
  Result:= Variant;
end;

function TEconomicResult.CalcOEconomicEffect: double;
// Относительный экономический эффект, тг
// BaseUEconomicEffect - Базовый условный экономический эффект, тг
// UEconomicEffect - Условный экономический эффект, тг
begin
  Result:= BaseUEconomicEffect - UEconomicEffect;
end;

function TEconomicResult.CalcOOUEconomicEffect: double;
// Объемно ориентированный условный экономический эффект, млн.тг
// PlanVolume_m3 - Объем горной массы запланированный к извлечению в рассматриваемом периоде, Vn в м3
// UdelCost - Удельные текущие затраты по горной массе, тенге  - на m3??
// TyresCost - Затраты на шины, тг
// VolumeOfGM_m3_byYear - Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// TruckCost - Стоимость приобретаемого автосамосвала, тыс.тг
// ServiceTruckCost - Сумма затрат связанная с текущими ремонтами автосамосвалов
begin
  Result:= PlanVolume_m3 * UdelCost +
           PlanVolume_m3 * (TyresCost / VolumeOfGM_m3_byYear) +
           TruckCost + ServiceTruckCost;
end;

function TEconomicResult.CalcPlanVolume_m3: double;
// Объем горной массы запланированный к извлечению в рассматриваемом периоде, Vn в м3}
// VolumeOfGM_m3 - Объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// VolumeOfGM_m3_avg - Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// CoefOfPeriodShift - Коэффциент перхода сменных показателей, тг
var
  VolumeOfGM: double;
begin
  if GMisAvg then
    VolumeOfGM:= VolumeOfGM_m3_avg
  else
    VolumeOfGM:= VolumeOfGM_m3;

//  Result:= VolumeOfGM * CoefOfPeriodShift;
  Result:= PlannedRockVolumeCm;
//  Result:= VolumeOfGM_m3 * CoefOfPeriodShift;
end;

function TEconomicResult.CalcPriceBy1Tonna: double;
// Показатель цены на 1 тонну продукта на рынке сбыта, тг. //Cn
// ProductPriceCtg - Цена одной тонны продукта, тыс.тг
begin
  Result:= ProductPriceCtg * 1E3;
end;

function TEconomicResult.CalcProfit: double;
// Прибыль, тг
// VolumeOfGM_m3_byYear - Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// Selic - Показатель плотности руды, т/м3
// ResultBy1Tonna - Показатель выхода продукта с 1 тонны руды, %
// PriceBy1Tonna - Показатель цены на 1 тонну продукта на рынке сбыта, тг.
// CoefOfVsry - Коэффициент вскрыши, т/т
begin
  Result:= ((VolumeOfGM_m3_byYear * Selic * ResultBy1Tonna * PriceBy1Tonna) /
           ((1 + CoefOfVsry) * 100));
end;

function TEconomicResult.CalcResultBy1Tonna: double;
// Показатель выхода продукта с 1 тонны руды, % //Bn
// ProductOutPutPercent - Выход продукта из одной тонны руды, %
begin
  Result:= ProductOutPutPercent;
end;

function TEconomicResult.CalcRoadCostByYear: double;
// Затраты на поддержание 1 км.дорог/год, тыс.тг'
begin
  Result:= BlocksRepairCtg;
end;

function TEconomicResult.CalcSalary: double;
//Затраты на заработную плату
begin
  Result:= AutosWorkSalariesCtg +
           AutosWaitingSalariesCtg +
           ExcavatorsWorkSalariesCtg +
           ExcavatorsWaitingSalariesCtg;
end;

function TEconomicResult.CalcSelic: double;
// Показатель плотности руды, т/м3
// CurrOreVm3 - Объем добытой руды, м3
// CurrOreQtn - Масса добытой руды, т
// CurrStrippingVm3 - Объем добытой вскрыши, м3
begin
  Result:= 0;
  if CurrOreVm3 > 0 then
    Result:= CurrOreQtn / CurrStrippingVm3;
end;

function TEconomicResult.CalcServiceTruckCost: double;
// Сумма затрат связанная с текущими ремонтами автосамосвалов
// ServiceExpensesCtg - Затраты на сервисное обслуживание, тыс.тг
begin
  Result:= ServiceExpensesCtg * 1E3; // ??? 1e6
end;

function TEconomicResult.CalcShiftNaryad: double;
// Рабочее время смены, мин
begin
  Result:= ShiftTmin - ShiftTurnoverTmin;
end;

function TEconomicResult.CalcShiftTimelap: double;
// Продолжительность смены, мин
begin
  Result:= ShiftTmin;
end;

function TEconomicResult.CalcTotalAutosCost: double;
// Суммарные затраты по автосамосвалам, тг
begin
  Result:= AutosAmortizationCtg;
end;

function TEconomicResult.CalcTotalCosts: double;
// Общие затраты ГТК, тг
// VolumeOfGM_m3_byYear - объем за год
// UdelCost - Удельные текущие затраты по горной массе, тенге  - на m3
// TyresCost - Затраты на шины, тг
// TruckCost - Стоимость приобретаемого автосамосвала, тыс.тг
// ServiceTruckCost - Сумма затрат связанная с текущими ремонтами автосамосвалов
begin
  Result:= (VolumeOfGM_m3_byYear * UdelCost + TyresCost + TruckCost + ServiceTruckCost);
end;

function TEconomicResult.CalcTotalShiftCosts: double;
// Общие затраты ГТК за смену, тг
// VolumeOfGM_m3_byYear - объем за год
// UdelCost - Удельные текущие затраты по горной массе, тенге  - на m3
// TyresShiftCost - Затраты на шины, тг (смена)
// TruckCost - Стоимость приобретаемого автосамосвала, тыс.тг
// ServiceTruckCost - Сумма затрат связанная с текущими ремонтами автосамосвалов
var
  VolumeOfGM: double;
begin
  if GMisAvg then
    VolumeOfGM:= VolumeOfGM_m3_avg
  else
    VolumeOfGM:= VolumeOfGM_m3;

//  Result:= ((VolumeOfGM_m3_byYear / 620.5) * UdelCost + TyresCost + ServiceTruckCost);
//  Result:= ((VolumeOfGM * UdelCost) + TyresShiftCost + ServiceTruckCost);
  Result:= (VolumeOfGM * UdelCost)
end;

function TEconomicResult.CalcTotalExcavatorsCost: double;
// Суммарные затраты по экскаваторам, тг
begin
  Result:= ExcavatorsAmortizationCtg;
end;

function TEconomicResult.CalcTotalRoadsCost: double;
// Суммарные затраты по автотрассе, тг
begin
  Result:= BlocksAmortizationCtg;
end;

function TEconomicResult.CalcTotalRoadsLength: double;
// Общая протяженность автотрассы, км
begin
  Result:= BlocksLm;
end;

function TEconomicResult.CalcTruckCost: double;
// Стоимость приобретаемого автосамосвала, тг
// TruckCostCtg - Стоимость приобретаемого автосамосвала, тыс.тг
begin
  Result:= TruckCostCtg * 1E3; // ??? 1e6
end;

function TEconomicResult.CalcTyrePrice: double;
// Стоимость одной шины, тыс.тг
begin
  Result:= 0.0;
end;

function TEconomicResult.CalcTyresCost: double;
// Затраты на шины, тг (год)
// CoefOfPeriodShift - Коэффициент перевода сменных параметров на период
// AutosTyresCtg - Затраты на шины, тг
begin
  Result:= AutosTyresCtg * CoefOfPeriodShift;
end;

function TEconomicResult.CalcTyreUdelCost: double;
// Удельный расход шин, шт/м3
var
  VolumeOfGM: double;
begin
  if GMisAvg then
    VolumeOfGM:= VolumeOfGM_m3_avg
  else
    VolumeOfGM:= VolumeOfGM_m3;

  Result:= AutosUsedTyresCount / VolumeOfGM;
end;

function TEconomicResult.CalcTytesCostByShift: double;
// Затраты на шины, тг./смена
begin
  Result:= AutosTyresCtg
end;

function TEconomicResult.CalcUdelnCurrentCost: double;
// Удельные текущие затраты по горной массе, тенге  - на m3??
var
  VolumeOfGM: double;
begin
  if GMisAvg then
    VolumeOfGM:= VolumeOfGM_m3_avg
  else
    VolumeOfGM:= VolumeOfGM_m3;

  Result:= CurrentCost / VolumeOfGM;
end;

function TEconomicResult.CalcUEconomicEffect: double;
// Условный экономический эффект, тг
// Profit - Прибыль, тг
// TotalCost - Общие затраты ГТК, тг
begin
  Result:= Profit - TotalCost;
end;

function TEconomicResult.CalcVolumeOfGM_m3: double;
// Объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// ExcavatorsRockVm3 - Погруженная Горная масса
begin
//  if GMisAvg then
//    Result:= VolumeOfGM_m3_avg
//  else
//    Result:= ExcavatorsRockVm3;

  Result:= ExcavatorsRockVm3;
end;

function TEconomicResult.CalcVolumeOfGM_m3_avg: double;
// Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// CurrOreVm3 - Объем добытой руды, м3
// CurrStrippingVm3 - Объем добытой вскрыши, м3
// ExcavatorsRockVm3 - Погруженная Горная масса
begin
  Result:= (CurrOreVm3 + CurrStrippingVm3 + ExcavatorsRockVm3) / 2;
end;

function TEconomicResult.CalcVolumeOfGM_m3_byYear: double;
// Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, м3
// VolumeOfGM - Объем горной массы, м3
// CoefOfPeriodShift - Коэффициент перевода сменных параметров на период
var
  VolumeOfGM: double;
begin
  if GMisAvg then
    VolumeOfGM:= VolumeOfGM_m3_avg
  else
    VolumeOfGM:= VolumeOfGM_m3;

//  PeriodCoef:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef)
  Result:= VolumeOfGM * CoefOfPeriodShift;
end;

constructor TEconomicResult.Create(Fields: TFields; isAvg: boolean = true);
begin
  inherited Create(Fields);

  GMisAvg:= isAvg;
end;

function TEconomicResult.CalcKs: double;
// Коэффициент вскрыши, т/т ???
// Ks - Коэффциент вскрыши, м3/м3 ???
begin
  Result:= Ks;
end;

function TEconomicResult.CalcPeriodKshift: double;
// Коэффциент перхода сменных показателей, тг
// PeriodKshift - Коэффициент перевода сменных параметров на период(620.20)
begin
//  Result:= PeriodKshift;
  Result:= ShiftKweek;
end;

function TEconomicResult.PtintVar: string;
begin
  Result:= Variant;
end;

function TEconomicResult.SaveInputValues(AProductOutPutPercent,
  AProductPriceCtg, AMTWorkByScheduleCtg, ATruckCostCtg, AServiceExpensesCtg,
  ABaseVariantExpenesCtg, APlannedRockVolumeCm: double): boolean;
var
  _qry: TADOQuery;
begin
  // todo: создать exception
  Result:= false;
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
    try
      Close;
      SQL.Clear;
      SQL.Text:= UPDATE_CURRENT_INPUT_VALUES;
      Parameters.ParamByName('ProductOutPutPercent').Value:= AProductOutPutPercent;
      Parameters.ParamByName('ProductPriceCtg').Value:= AProductPriceCtg;
      Parameters.ParamByName('MTWorkByScheduleCtg').Value:= AMTWorkByScheduleCtg;
      Parameters.ParamByName('TruckCostCtg').Value:= ATruckCostCtg;
      Parameters.ParamByName('ServiceExpensesCtg').Value:= AServiceExpensesCtg;
      Parameters.ParamByName('BaseVariantExpenesCtg').Value:= ABaseVariantExpenesCtg;
      Parameters.ParamByName('PlannedRockVolumeCm').Value:= APlannedRockVolumeCm;

      Parameters.ParamByName('Id_ResultVariant').Value:= Id_ResultVariant;
      ExecSQL;
      Result:= true;
    finally
      Close;
      Free;
    end;
end;

procedure TEconomicResult.ToUpdate;
var
  _qry: TADOQuery;
begin
  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
    try
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_RESULT_VARIANT_BY_ID;
      Parameters.ParamByName('Id_ResultVariant').Value:= Id_ResultVariant;
      Open;
      UpdateData(Fields);
    finally
      Close;
      Free;
    end;
end;

function TEconomicResult.CalcDataOfVariant: string;
begin
  Result:= DateTimeToStr(VariantDate);
end;

function TEconomicResult.CalcVolumeOfOre: double;
// Объем добытой руды, м3
begin
  Result:= CurrOreVm3;
end;

function TEconomicResult.CalcVolumeOfGM_tn: double;
// Объем извлекаемой горной массы, получаемый по результатам моделирования, тонн
// ExcavatorsRockQtn - Погруженная Горная масса, тонн
begin
  Result:= ExcavatorsRockQtn;
end;

function TEconomicResult.CalcVolumeOfGM_tn_avg: double;
// Усредненный объем извлекаемой горной массы, получаемый по результатам моделирования, тонн
// CurrOreQtn - Объем добытой руды, тонн
// CurrStrippingQtn - Объем добытой вскрыши, тонн
// ExcavatorsRockQtn - Погруженная Горная масса, тонн
begin
  Result:= (CurrOreQtn + CurrStrippingQtn + ExcavatorsRockQtn) / 2;
end;

function TEconomicResult.CalcTyresShiftCost: double;
// Затраты на шины, тг (смена)
// AutosTyresCtg - Затраты на шины, тг
begin
  Result:= AutosTyresCtg;
end;

{ TResultVariants }

constructor TResultVariants.Create;
var
  _qry: TADOQuery;
  _eco: TEconomicResult;
begin
  _items:= TList.Create;

  _qry:= TADOQuery.Create(nil);
  _qry.Connection:= fmDM.ADOConnection;
  with _qry do
    try
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_RESULT_VARIANT;
      Open;

      while not Eof do
      begin
        _eco:= TEconomicResult.Create(Fields);
        _items.Add(_eco);
        Next;
      end;

    finally
      Close;
      Free;
    end;
end;

procedure TResultVariants.DeleteItem(_idResultVariant: integer);
var
  i: integer;
begin
  for i:= 0 to _items.Count-1 do
    if Items[i].Id_ResultVariant = _idResultVariant then
    begin
      _items.Delete(i);
      Break;
    end;
end;

destructor TResultVariants.Destroy;
var
  i: integer;
begin
  for i:= 0 to _items.Count-1 do
  begin
    TEconomicResult(_items[i]).Destroy;
    _items[i]:= nil;
  end;

  inherited;
end;

function TResultVariants.FindResultById(
  idVariant: integer): TEconomicResult;
var
  i: integer;
begin
  Result:= nil;
  for i:= 0 to _items.Count-1 do
    if Items[i].Id_ResultVariant = idVariant then
      Result:= Items[i];
end;

function TResultVariants._getBaseVariant: TEconomicResult;
var
  i: integer;
begin
  Result:= nil;
  for i:= 0 to _items.Count-1 do
    if Items[i].Id_ResultVariant = BaseVariantId then
      Result:= Items[i];
end;

function TResultVariants._getBaseVariantId: integer;
var
  i: integer;
begin
  Result:= Items[0].Id_ResultVariant;
  for i:= 0 to _items.Count-1 do
    if Items[i].IsBaseVariant = True then
      Result:= Items[i].Id_ResultVariant;
end;

function TResultVariants._getCurrentVariant: TEconomicResult;
var
  i: integer;
begin
  // todo: создать exception
  Result:= nil;
  for i:= 0 to _items.Count-1 do
    if Items[i].Id_ResultVariant = CurrentVariantId then
      Result:= Items[i];
end;

function TResultVariants._getItem(index: integer): TEconomicResult;
begin
  Result:= Nil;
  if (index > -1) and (index < _items.Count) then
    Result:= TEconomicResult(_items[index]);
end;

procedure TResultVariants._setBaseVariant(newBaseVariant: TEconomicResult);
var
  i: integer;
  item: TEconomicResult;
begin
  for i:= 0 to _items.Count-1 do
  begin
    Items[i].IsBaseVariant:= false;
    if Items[i] = newBaseVariant then
      Items[i].IsBaseVariant:= True;
  end;
end;

end.
