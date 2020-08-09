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
    // �����������
    //----------------------------
    // ���������� ������� ������� �����������, �� / 620.50
    property CoefOfPeriodShift: double read CalcPeriodKshift;
    // ����������� �������, �/�
    property CoefOfVsry: double read CalcKs;
    // ����������� ������������� ��������������
    property CoefOfUseAutos: double read CalcCoefOfUseAutos;
    //----------------------------
    // ���������� / ����������� ����������
    //----------------------------
    // ���������� ��������� ����, �/�3
    property Selic: double read CalcSelic;
    // ��������� �������������� �������������, ��
    property TruckCost: double read CalcTruckCost;
    // ����� ������ ��������� � �������� ��������� ��������������
    property ServiceTruckCost: double read CalcServiceTruckCost;
    // ���������� ������ �������� � 1 ����� ����, % //Bn
    property ResultBy1Tonna: double read CalcResultBy1Tonna;
    // ���������� ���� �� 1 ����� �������� �� ����� �����, ��. //Cn
    property PriceBy1Tonna: double read CalcPriceBy1Tonna;
    // ��������� ��� �� �������, ���.��
    property GTRCost: double read CalcGTRCost;
    //----------------------------
    // ��������� ������
    //----------------------------
    // �������� �������� �����������
    property NameOfVariant: string read CalcNameOfVariant;
    // ���� �������� ����������
    property DataOfVariant: string read CalcDataOfVariant;
    // ������� ����� �����, ���
    property ShiftNaryad: double read CalcShiftNaryad;
    // ����������������� �����, ���
    property ShiftTimelap: double read CalcShiftTimelap;
    // ������ �������������, �
    property AutosKm: double read CalcAutosKm;
    // ����� ������ �������, �
    property AutosGx: double read CalcAutosGx;
    // ������ ������� � ��������, �
    property AutosDirGx: double read CalcAutosDirGx;
    // ����� ������ ��������������, ���
    property AutosTmin: double read CalcAutosTmin;
    // ����� ������ �������������� � ��������, ���
    property AutosDirTmin: double read CalcAutosDirTmin;
    // ������� �������������� �� ����� ������, ��
    property AutosWorkCost: double read CalcAutosWorkCost;
    // ������� �������������� �� ����� �������, ��
    property AutosWaitingCost: double read CalcAutosWaitingCost;
    // ������� �������������, ��
    property AutosCost: double read CalcAutosCost;
    // ������� ���� ��������������, ��
    property AutosCount: double read CalcAutosCount;
    // ������ ������� �������������, �
    property ExcavatorsGx: double read CalcExcavatorsGx;
    // ����� ������ ������������, ���
    property ExcavatorsTmin: double read CalcExcavatorsTmin;
    // ������� ����������� ������ ������������, %
    property ExcavatorsRockRatio: double read CalcExcavatorsRockRatio;
    // ������� ������������ �� ����� ������, ��
    property ExcavatorsWorkCost: double read CalcExcavatorsWorkCost;
    // ������� ������������ �� ����� �������, ��
    property ExcavatorsWaitingCost: double read CalcExcavatorsWaitingCost;
    // ������� ������������
    property ExcavatorsCost: double read CalcExcavatorsCost;
    // ����� ������������ �� ��������, ��.
    property ExcavatorsCount: double read CalcExcavatorsCount;
    //������� �� ���������� �����
    property Salary: double read CalcSalary;
    // ������ ��������������, ���*�
    property ElectricityCost: double read CalcElectricityCost;
    // ������� �� ��������������, ��/�����
    property ElectricityCostByShift: double read CalcElectricityCostByShift;
    // ��������� ������� �� ������������, ��
    property TotalExcavatorsCost: double read CalcTotalExcavatorsCost;
    // ��������� ������� �� ����������, ��
    property TotalRoadsCost: double read CalcTotalRoadsCost;
    // ����� ������������� ����������, ��
    property TotalRoadsLength: double read CalcTotalRoadsLength;
    // ������� �� ����������� 1 ��.�����/���, ���.��'
    property RoadCostByYear: double read CalcRoadCostByYear;
    // �������� ������ ���, ��/�3
    property TyreUdelCost: double read CalcTyreUdelCost;
    // ��������� ����� ����, ���.��
    property TyrePrice: double read CalcTyrePrice;
    // ������� �� ����, ��./�����
    property TytesCostByShift: double read CalcTytesCostByShift;
    // ��������� 1 ����� �������, ��
    property GSMPrice: double read CalcGSMPrice;
    // �������� ������ �������, �/���
    property GSMUdelCost: double read CalcGSMUdelCost;
    // ������ �������, �
    property GSMCost: double read CalcGSMCost;
    // ��������� ������� �� ��������������, ��
    property TotalAutosCost: double read CalcTotalAutosCost;
    //----------------------------
    // �������
    //----------------------------
    // ����� ������� ���, ��
    property TotalCost: double read CalcTotalCosts;
    // ����� ������� ��� �� �����, ��
    property TotalShiftCost: double read CalcTotalShiftCosts;
    // ������� �� ���� (���), ��
    property TyresCost: double read CalcTyresCost;
    // ������� �� ���� (�����), ��
    property TyresShiftCost: double read CalcTyresShiftCost;
    // ������� ������� �� ������ �����, �����
    property CurrentCost: double read CalcCurrentCost;
    // �������� ������� ������� �� ������ �����, �����  - �� m3??
    property UdelCost: double read CalcUdelnCurrentCost;
    // �������� ��������������� ������� �� ������� ������ ����� (�� 1 �3)
    //property UdelExpuatacCost: double read CalcUdelnCurrentCost;
    //----------------------------
    // ����� ��
    //----------------------------
    // ����� ����������� ������ �����, ���������� �� ����������� �������������, tn
    property VolumeOfGM_tn: double read CalcVolumeOfGM_tn;
    // ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, tn
    property VolumeOfGM_tn_avg: double read CalcVolumeOfGM_tn_avg;
    // ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
    property VolumeOfGM_m3: double read CalcVolumeOfGM_m3;
    // ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
    property VolumeOfGM_m3_avg: double read CalcVolumeOfGM_m3_avg;
    // ������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
    property VolumeOfGM_m3_byYear: double read CalcVolumeOfGM_m3_byYear;
    // ����� ������ ����� ��������������� � ���������� � ��������������� �������, Vn � �3}
    property PlanVolume_m3: double read CalcPlanVolume_m3;
    // done: ������� ����� ������� ����
    // ����� ������� ����, �3
    property VolumeOfOre: double read CalcVolumeOfOre;
    //----------------------------
    // ���������
    //----------------------------
    // �������, ��
    property Profit: double read CalcProfit;
    // ������� �������� ������������� ������, ��
    property BaseUEconomicEffect: double read _BaseUEconomicEffect write _BaseUEconomicEffect;
    // �������� ������������� ������, ��
    property UEconomicEffect: double read CalcUEconomicEffect;
    // ������������� ������������� ������, ��
    property OEconomicEffect: double read CalcOEconomicEffect;
    // ������� ��������������� �������� ������������� ������, ���.��
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

// ����� ������� ���, ���.��
function CalcTotalCosts(Vgm: double; UdelQtn: double; STyres: double; Cstro: double; Crem: double):double;
// ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
function CalcVolumeOfGM_m3(ExcavatorsRockV_m3: double): double;
// ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
function CalcVolumeOfGM_avg_m3(Selic_m3: double; CurrStrippingVm3_m3: double; ExcavatorsRockV_m3: double): double;
// ������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
function CalcVolumeOfGM_byYear_m3(RocksVm3: double; PeriodCoef: double):double;
// ������� �� ����, ��
function CalcTyresCost(AutosTyresCtg: double; PeriodCoef: double): double;

implementation

// ����� ������� ���, ���.��
function CalcTotalCosts(
                        //����� �� ������
                        Vgm: double;
                        //�������� ������� ������� �� ������ �����, �����  - �� m3
                        UdelQtn: double;
                        //������ ������� ������� ��������� � ������������� ��� � �.�., ���.�����
                        STyres: double;
                        {������ �������������� �������������� ������� �� �������������
                        ��������� � ��������������� �����, ������������ ������ ������������,
                        ������������� �������������� ������� � �.�., ���.�����}
                        Cstro: double;
                        {����� ������ ��������� � �������� ��������� ��������������}
                        Crem: double
                        ):double;
begin
  Result:= (Vgm * UdelQtn + STyres + Cstro + Crem);
end;

// ������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
function CalcVolumeOfGM_byYear_m3(
                        // ����� ������ �����, �3
                        RocksVm3: double;
                        // ����������� �������� ������� ���������� �� ������
                        PeriodCoef: double
                        ):double;
begin
//  PeriodCoef:= ((1440 / ParamsShiftDuration) * 365 * ResultPeriodCoef)
  Result:= RocksVm3 * PeriodCoef;
end;

// ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
function CalcVolumeOfGM_avg_m3(
                           // ����� ������� ����, �3
                           Selic_m3: double;
                           // ����� ������� �������, �3
                           CurrStrippingVm3_m3: double;
                           // ����������� ������ �����, �3
                           ExcavatorsRockV_m3: double
                           ): double;
begin
  Result:= (Selic_m3 + CurrStrippingVm3_m3 + ExcavatorsRockV_m3) / 2;
end;

// ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
function CalcVolumeOfGM_m3(
                           // ����������� ������ �����, �3
                           ExcavatorsRockV_m3: double
                           ): double;
begin
  Result:= ExcavatorsRockV_m3;
end;

// ������� �� ����, ��
function CalcTyresCost(
                      //������� �� ����, ��
                      AutosTyresCtg: double;
                      // ����������� �������� ������� ���������� �� ������
                      PeriodCoef: double
                      ): double;
begin
  Result:= AutosTyresCtg * PeriodCoef;
end;

{ TEconomicResult }

function TEconomicResult.CalcAutosCost: double;
// ������� �������������, ��
begin
  Result:= AutosWorkCost + AutosWaitingCost + AutosAmortizationCtg;
end;

function TEconomicResult.CalcAutosCount: double;
// ������� ���� ��������������, ��
begin
  Result:= AutosAutosCount0;
end;

function TEconomicResult.CalcAutosDirGx: double;
// ������ ������� � ��������, �
begin
  Result:= AutosGxNulled + AutosGxLoading + AutosGxUnLoading;
end;

function TEconomicResult.CalcAutosDirTmin: double;
// ����� ������ �������������� � ��������, ���
begin
  Result:= AutosTminNulled + AutosTminLoading + AutosTminUnLoading;
end;

function TEconomicResult.CalcAutosGx: double;
// ����� ������ �������, �
begin
  Result:= AutosGxWork + AutosGxWaiting;
end;

function TEconomicResult.CalcAutosKm: double;
// ������ �������������, �
begin
  Result:= AutosSkmNulled + AutosSkmLoading + AutosSkmUnLoading;
end;

function TEconomicResult.CalcAutosTmin: double;
// ����� ������ ��������������, ���
begin
  Result:= AutosTminMoving + AutosTminWaiting +
           AutosTminManevr + AutosTminOnLoading +
           AutosTminOnUnLoading;
end;

function TEconomicResult.CalcAutosWaitingCost: double;
// ������� �������������� �� ����� �������, ��
begin
  Result:= AutosWaitingSumGxCtg + AutosWaitingSparesCtg +
           AutosWaitingMaterialsCtg + AutosWaitingMaintenancesCtg +
           AutosWaitingSalariesCtg;
end;

function TEconomicResult.CalcAutosWorkCost: double;
// ������� �������������� �� ����� ������, ��
begin
  Result:= AutosWorkSumGxCtg + AutosWorkSumTyresCtg +
           AutosWorkSparesCtg + AutosWorkMaterialsCtg +
           AutosWorkMaintenancesCtg + AutosWorkSalariesCtg;
end;

function TEconomicResult.CalcCoefOfUseAutos: double;
// ����������� ������������� ��������������
begin
  Result:= AutosAvgTimeUsingCoef;
end;

function TEconomicResult.CalcCurrentCost: double;
// ������� ������� �� ������ �����, �����
begin
  Result:= AutosCost + ExcavatorsCost +
           BlocksRepairCtg +
           EconomExpensesCtg +
           BlocksAmortizationCtg;
end;

function TEconomicResult.CalcElectricityCost: double;
//������ ��������������, ���*�
begin
  Result:= ExcavatorsGxWork + ExcavatorsGxWaiting;
end;

function TEconomicResult.CalcElectricityCostByShift: double;
//������� �� ��������������, ��/�����
begin
  Result:= ExcavatorsWorkSumGxCtg + ExcavatorsWaitingSumGxCtg;
end;

function TEconomicResult.CalcExcavatorsCost: double;
//������� ������������
begin
  Result:= ExcavatorsWorkCost + ExcavatorsWaitingCost + ExcavatorsAmortizationCtg;
end;

function TEconomicResult.CalcExcavatorsCount: double;
// ����� ������������ �� ��������, ��.
begin
  Result:= ExcavatorsExcavatorsCount0;
end;

function TEconomicResult.CalcExcavatorsGx: double;
// ������ ������� �������������, �
begin
  Result:= ExcavatorsGxWork + ExcavatorsGxWaiting;
end;

function TEconomicResult.CalcExcavatorsRockRatio: double;
// ������� ����������� ������ ������������, %
begin
  Result:= 0;
  if ExcavatorsPlanRockQtn <> 0 then
    Result:= ExcavatorsRockQtn * 100 / ExcavatorsPlanRockQtn;
end;

function TEconomicResult.CalcExcavatorsTmin: double;
// ����� ������ ������������, ���
begin
  Result:= ExcavatorsTminWork + ExcavatorsTminWaiting + ExcavatorsTminManevr;
end;

function TEconomicResult.CalcExcavatorsWaitingCost: double;
// ������� ������������ �� ����� �������, ��
begin
  Result:= ExcavatorsWaitingSumGxCtg + ExcavatorsWaitingMaterialsCtg +
           ExcavatorsWaitingUnAccountedCtg + ExcavatorsWaitingSalariesCtg;
end;

function TEconomicResult.CalcExcavatorsWorkCost: double;
// ������� ������������ �� ����� ������, ��
begin
  Result:= ExcavatorsWorkSumGxCtg + ExcavatorsWorkMaterialsCtg +
           ExcavatorsWorkUnAccountedCtg + ExcavatorsWorkSalariesCtg;
end;

function TEconomicResult.CalcGSMCost: double;
// ������ �������, �
begin
  Result:= AutosGxWaiting + AutosGxWork;
end;

function TEconomicResult.CalcGSMPrice: double;
// ��������� 1 ����� �������, ��
begin
  Result:= AutosGxCtg;
end;

function TEconomicResult.CalcGSMUdelCost: double;
// �������� ������ �������, �/���
begin
  Result:= AutosUdGx_gr_tkm;
end;

function TEconomicResult.CalcGTRCost: double;
// ��������� ��� �� �������, ���.��
begin
  Result:= MTWorkByScheduleCtg;
end;

function TEconomicResult.CalcNameOfVariant: string;
// �������� �������� �����������
begin
  Result:= Variant;
end;

function TEconomicResult.CalcOEconomicEffect: double;
// ������������� ������������� ������, ��
// BaseUEconomicEffect - ������� �������� ������������� ������, ��
// UEconomicEffect - �������� ������������� ������, ��
begin
  Result:= BaseUEconomicEffect - UEconomicEffect;
end;

function TEconomicResult.CalcOOUEconomicEffect: double;
// ������� ��������������� �������� ������������� ������, ���.��
// PlanVolume_m3 - ����� ������ ����� ��������������� � ���������� � ��������������� �������, Vn � �3
// UdelCost - �������� ������� ������� �� ������ �����, �����  - �� m3??
// TyresCost - ������� �� ����, ��
// VolumeOfGM_m3_byYear - ������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// TruckCost - ��������� �������������� �������������, ���.��
// ServiceTruckCost - ����� ������ ��������� � �������� ��������� ��������������
begin
  Result:= PlanVolume_m3 * UdelCost +
           PlanVolume_m3 * (TyresCost / VolumeOfGM_m3_byYear) +
           TruckCost + ServiceTruckCost;
end;

function TEconomicResult.CalcPlanVolume_m3: double;
// ����� ������ ����� ��������������� � ���������� � ��������������� �������, Vn � �3}
// VolumeOfGM_m3 - ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// VolumeOfGM_m3_avg - ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// CoefOfPeriodShift - ���������� ������� ������� �����������, ��
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
// ���������� ���� �� 1 ����� �������� �� ����� �����, ��. //Cn
// ProductPriceCtg - ���� ����� ����� ��������, ���.��
begin
  Result:= ProductPriceCtg * 1E3;
end;

function TEconomicResult.CalcProfit: double;
// �������, ��
// VolumeOfGM_m3_byYear - ������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// Selic - ���������� ��������� ����, �/�3
// ResultBy1Tonna - ���������� ������ �������� � 1 ����� ����, %
// PriceBy1Tonna - ���������� ���� �� 1 ����� �������� �� ����� �����, ��.
// CoefOfVsry - ����������� �������, �/�
begin
  Result:= ((VolumeOfGM_m3_byYear * Selic * ResultBy1Tonna * PriceBy1Tonna) /
           ((1 + CoefOfVsry) * 100));
end;

function TEconomicResult.CalcResultBy1Tonna: double;
// ���������� ������ �������� � 1 ����� ����, % //Bn
// ProductOutPutPercent - ����� �������� �� ����� ����� ����, %
begin
  Result:= ProductOutPutPercent;
end;

function TEconomicResult.CalcRoadCostByYear: double;
// ������� �� ����������� 1 ��.�����/���, ���.��'
begin
  Result:= BlocksRepairCtg;
end;

function TEconomicResult.CalcSalary: double;
//������� �� ���������� �����
begin
  Result:= AutosWorkSalariesCtg +
           AutosWaitingSalariesCtg +
           ExcavatorsWorkSalariesCtg +
           ExcavatorsWaitingSalariesCtg;
end;

function TEconomicResult.CalcSelic: double;
// ���������� ��������� ����, �/�3
// CurrOreVm3 - ����� ������� ����, �3
// CurrOreQtn - ����� ������� ����, �
// CurrStrippingVm3 - ����� ������� �������, �3
begin
  Result:= 0;
  if CurrOreVm3 > 0 then
    Result:= CurrOreQtn / CurrStrippingVm3;
end;

function TEconomicResult.CalcServiceTruckCost: double;
// ����� ������ ��������� � �������� ��������� ��������������
// ServiceExpensesCtg - ������� �� ��������� ������������, ���.��
begin
  Result:= ServiceExpensesCtg * 1E3; // ??? 1e6
end;

function TEconomicResult.CalcShiftNaryad: double;
// ������� ����� �����, ���
begin
  Result:= ShiftTmin - ShiftTurnoverTmin;
end;

function TEconomicResult.CalcShiftTimelap: double;
// ����������������� �����, ���
begin
  Result:= ShiftTmin;
end;

function TEconomicResult.CalcTotalAutosCost: double;
// ��������� ������� �� ��������������, ��
begin
  Result:= AutosAmortizationCtg;
end;

function TEconomicResult.CalcTotalCosts: double;
// ����� ������� ���, ��
// VolumeOfGM_m3_byYear - ����� �� ���
// UdelCost - �������� ������� ������� �� ������ �����, �����  - �� m3
// TyresCost - ������� �� ����, ��
// TruckCost - ��������� �������������� �������������, ���.��
// ServiceTruckCost - ����� ������ ��������� � �������� ��������� ��������������
begin
  Result:= (VolumeOfGM_m3_byYear * UdelCost + TyresCost + TruckCost + ServiceTruckCost);
end;

function TEconomicResult.CalcTotalShiftCosts: double;
// ����� ������� ��� �� �����, ��
// VolumeOfGM_m3_byYear - ����� �� ���
// UdelCost - �������� ������� ������� �� ������ �����, �����  - �� m3
// TyresShiftCost - ������� �� ����, �� (�����)
// TruckCost - ��������� �������������� �������������, ���.��
// ServiceTruckCost - ����� ������ ��������� � �������� ��������� ��������������
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
// ��������� ������� �� ������������, ��
begin
  Result:= ExcavatorsAmortizationCtg;
end;

function TEconomicResult.CalcTotalRoadsCost: double;
// ��������� ������� �� ����������, ��
begin
  Result:= BlocksAmortizationCtg;
end;

function TEconomicResult.CalcTotalRoadsLength: double;
// ����� ������������� ����������, ��
begin
  Result:= BlocksLm;
end;

function TEconomicResult.CalcTruckCost: double;
// ��������� �������������� �������������, ��
// TruckCostCtg - ��������� �������������� �������������, ���.��
begin
  Result:= TruckCostCtg * 1E3; // ??? 1e6
end;

function TEconomicResult.CalcTyrePrice: double;
// ��������� ����� ����, ���.��
begin
  Result:= 0.0;
end;

function TEconomicResult.CalcTyresCost: double;
// ������� �� ����, �� (���)
// CoefOfPeriodShift - ����������� �������� ������� ���������� �� ������
// AutosTyresCtg - ������� �� ����, ��
begin
  Result:= AutosTyresCtg * CoefOfPeriodShift;
end;

function TEconomicResult.CalcTyreUdelCost: double;
// �������� ������ ���, ��/�3
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
// ������� �� ����, ��./�����
begin
  Result:= AutosTyresCtg
end;

function TEconomicResult.CalcUdelnCurrentCost: double;
// �������� ������� ������� �� ������ �����, �����  - �� m3??
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
// �������� ������������� ������, ��
// Profit - �������, ��
// TotalCost - ����� ������� ���, ��
begin
  Result:= Profit - TotalCost;
end;

function TEconomicResult.CalcVolumeOfGM_m3: double;
// ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// ExcavatorsRockVm3 - ����������� ������ �����
begin
//  if GMisAvg then
//    Result:= VolumeOfGM_m3_avg
//  else
//    Result:= ExcavatorsRockVm3;

  Result:= ExcavatorsRockVm3;
end;

function TEconomicResult.CalcVolumeOfGM_m3_avg: double;
// ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// CurrOreVm3 - ����� ������� ����, �3
// CurrStrippingVm3 - ����� ������� �������, �3
// ExcavatorsRockVm3 - ����������� ������ �����
begin
  Result:= (CurrOreVm3 + CurrStrippingVm3 + ExcavatorsRockVm3) / 2;
end;

function TEconomicResult.CalcVolumeOfGM_m3_byYear: double;
// ������� ����� ����������� ������ �����, ���������� �� ����������� �������������, �3
// VolumeOfGM - ����� ������ �����, �3
// CoefOfPeriodShift - ����������� �������� ������� ���������� �� ������
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
// ����������� �������, �/� ???
// Ks - ���������� �������, �3/�3 ???
begin
  Result:= Ks;
end;

function TEconomicResult.CalcPeriodKshift: double;
// ���������� ������� ������� �����������, ��
// PeriodKshift - ����������� �������� ������� ���������� �� ������(620.20)
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
  // todo: ������� exception
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
// ����� ������� ����, �3
begin
  Result:= CurrOreVm3;
end;

function TEconomicResult.CalcVolumeOfGM_tn: double;
// ����� ����������� ������ �����, ���������� �� ����������� �������������, ����
// ExcavatorsRockQtn - ����������� ������ �����, ����
begin
  Result:= ExcavatorsRockQtn;
end;

function TEconomicResult.CalcVolumeOfGM_tn_avg: double;
// ����������� ����� ����������� ������ �����, ���������� �� ����������� �������������, ����
// CurrOreQtn - ����� ������� ����, ����
// CurrStrippingQtn - ����� ������� �������, ����
// ExcavatorsRockQtn - ����������� ������ �����, ����
begin
  Result:= (CurrOreQtn + CurrStrippingQtn + ExcavatorsRockQtn) / 2;
end;

function TEconomicResult.CalcTyresShiftCost: double;
// ������� �� ����, �� (�����)
// AutosTyresCtg - ������� �� ����, ��
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
  // todo: ������� exception
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
