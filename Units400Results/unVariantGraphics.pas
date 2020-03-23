unit unVariantGraphics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, TeeProcs, TeEngine, Chart, DbChart,
  Series, DB, ADODB, Grids, DBGrids;

type
  TfmVariantGraphics = class(TForm)
    pnBtns: TPanel;
    btPrint: TButton;
    btSaveAs: TButton;
    btClose: TButton;
    dsVaraints: TDataSource;
    PageControl: TPageControl;
    tsUdCtg: TTabSheet;
    DBChart0: TDBChart;
    tsRockRatio: TTabSheet;
    tsCtg: TTabSheet;
    tsUsingCoef: TTabSheet;
    DBChart1: TDBChart;
    LineSeries1: TLineSeries;
    DBChart2: TDBChart;
    LineSeries2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    DBChart3: TDBChart;
    LineSeries3: TLineSeries;
    LineSeries4: TLineSeries;
    tsNEE: TTabSheet;
    DBChart4: TDBChart;
    Series1: TBarSeries;
    Series6: TLineSeries;
    quVariants: TADOQuery;
    quVariantsId_ResultVariant: TAutoIncField;
    quVariantsSortIndex: TIntegerField;
    quVariantsIsPrint: TBooleanField;
    quVariantsVariant: TWideStringField;
    quVariantsVariantDate: TDateTimeField;
    quVariantsPeriodTday: TFloatField;
    quVariantsPeriodKshift: TFloatField;
    quVariantsShiftTmin: TFloatField;
    quVariantsShiftTurnoverTmin: TFloatField;
    quVariantsShiftNaryadTmin: TFloatField;
    quVariantsShiftNaryadFactTmin: TFloatField;
    quVariantsShiftKweek: TFloatField;
    quVariantsDollarCtg: TFloatField;
    quVariantsAutos: TWideStringField;
    quVariantsAutosAutosCount0: TFloatField;
    quVariantsAutosAutosCount1: TFloatField;
    quVariantsAutosAutosCount: TStringField;
    quVariantsAutosTripsCountNulled: TFloatField;
    quVariantsAutosTripsCountLoading: TFloatField;
    quVariantsAutosTripsCountUnLoading: TFloatField;
    quVariantsAutosRockVm3: TFloatField;
    quVariantsAutosRockQtn: TFloatField;
    quVariantsAutosSkm: TFloatField;
    quVariantsAutosSkmNulled: TFloatField;
    quVariantsAutosSkmLoading: TFloatField;
    quVariantsAutosSkmUnLoading: TFloatField;
    quVariantsAutosLoadingWAvgSkm: TFloatField;
    quVariantsAutosLoadingAvgSkm: TFloatField;
    quVariantsAutosWAvgHm: TFloatField;
    quVariantsAutosShiftAvgSkm: TFloatField;
    quVariantsAutosShiftAvgSkm_reis: TFloatField;
    quVariantsAutosAvgVkmhNulled: TFloatField;
    quVariantsAutosAvgVkmhLoading: TFloatField;
    quVariantsAutosAvgVkmhUnLoading: TFloatField;
    quVariantsAutosAvgTechVkmh: TFloatField;
    quVariantsAutosGx: TFloatField;
    quVariantsAutosGxWork: TFloatField;
    quVariantsAutosGxWaiting: TFloatField;
    quVariantsAutosDirGx: TFloatField;
    quVariantsAutosGxNulled: TFloatField;
    quVariantsAutosGxLoading: TFloatField;
    quVariantsAutosGxUnLoading: TFloatField;
    quVariantsAutosUdGx_gr_tkm: TFloatField;
    quVariantsAutosGxCtg: TFloatField;
    quVariantsAutosTmin: TFloatField;
    quVariantsAutosTminMoving: TFloatField;
    quVariantsAutosTminWaiting: TFloatField;
    quVariantsAutosTminManevr: TFloatField;
    quVariantsAutosTminOnLoading: TFloatField;
    quVariantsAutosTminOnUnLoading: TFloatField;
    quVariantsAutosDirTmin: TFloatField;
    quVariantsAutosTminNulled: TFloatField;
    quVariantsAutosTminLoading: TFloatField;
    quVariantsAutosTminUnLoading: TFloatField;
    quVariantsAutosReysAvgTminNulled: TFloatField;
    quVariantsAutosReysAvgTminLoading: TFloatField;
    quVariantsAutosReysAvgTminUnLoading: TFloatField;
    quVariantsAutosAvgTimeUsingCoef: TFloatField;
    quVariantsAutosTyresCount: TFloatField;
    quVariantsAutosTyresSkm: TFloatField;
    quVariantsAutosUsedTyresCount: TFloatField;
    quVariantsAutosTyresCtg: TFloatField;
    quVariantsAutosWorkCtg: TFloatField;
    quVariantsAutosWorkSumGxCtg: TFloatField;
    quVariantsAutosWorkSumTyresCtg: TFloatField;
    quVariantsAutosWorkSparesCtg: TFloatField;
    quVariantsAutosWorkMaterialsCtg: TFloatField;
    quVariantsAutosWorkMaintenancesCtg: TFloatField;
    quVariantsAutosWorkSalariesCtg: TFloatField;
    quVariantsAutosWaitingCtg: TFloatField;
    quVariantsAutosWaitingSumGxCtg: TFloatField;
    quVariantsAutosWaitingSparesCtg: TFloatField;
    quVariantsAutosWaitingMaterialsCtg: TFloatField;
    quVariantsAutosWaitingMaintenancesCtg: TFloatField;
    quVariantsAutosWaitingSalariesCtg: TFloatField;
    quVariantsAutosAmortizationCtg: TFloatField;
    quVariantsAutosCtg: TFloatField;
    quVariantsBlocksBlocksCount: TFloatField;
    quVariantsBlocksLm: TFloatField;
    quVariantsBlocksRockVm3: TFloatField;
    quVariantsBlocksRockQtn: TFloatField;
    quVariantsBlocksAutosCount: TFloatField;
    quVariantsBlocksAutosCountNulled: TFloatField;
    quVariantsBlocksAutosCountLoading: TFloatField;
    quVariantsBlocksAutosCountUnLoading: TFloatField;
    quVariantsBlocksWaitingsCount: TFloatField;
    quVariantsBlocksWaitingsCountNulled: TFloatField;
    quVariantsBlocksWaitingsCountLoading: TFloatField;
    quVariantsBlocksWaitingsCountUnLoading: TFloatField;
    quVariantsBlocksAvgVkmh: TFloatField;
    quVariantsBlocksAvgVkmhNulled: TFloatField;
    quVariantsBlocksAvgVkmhLoading: TFloatField;
    quVariantsBlocksAvgVkmhUnLoading: TFloatField;
    quVariantsBlocksMovingAvgTmin: TFloatField;
    quVariantsBlocksMovingAvgTminNulled: TFloatField;
    quVariantsBlocksMovingAvgTminLoading: TFloatField;
    quVariantsBlocksMovingAvgTminUnLoading: TFloatField;
    quVariantsBlocksWaitingAvgTmin: TFloatField;
    quVariantsBlocksWaitingAvgTminNulled: TFloatField;
    quVariantsBlocksWaitingAvgTminLoading: TFloatField;
    quVariantsBlocksWaitingAvgTminUnLoading: TFloatField;
    quVariantsBlocksEmploymentCoef: TFloatField;
    quVariantsBlocksGx: TFloatField;
    quVariantsBlocksGxNulled: TFloatField;
    quVariantsBlocksGxLoading: TFloatField;
    quVariantsBlocksGxUnLoading: TFloatField;
    quVariantsBlocksUdGx_l_m: TFloatField;
    quVariantsBlocksRepairCtg: TFloatField;
    quVariantsBlocksAmortizationCtg: TFloatField;
    quVariantsBlocksCtg: TFloatField;
    quVariantsExcavators: TWideStringField;
    quVariantsExcavatorsExcavatorsCount0: TFloatField;
    quVariantsExcavatorsExcavatorsCount1: TFloatField;
    quVariantsExcavatorsExcavatorsCount: TStringField;
    quVariantsExcavatorsAutosCount: TFloatField;
    quVariantsExcavatorsRockVm3: TFloatField;
    quVariantsExcavatorsRockQtn: TFloatField;
    quVariantsExcavatorsPlanRockVm3: TFloatField;
    quVariantsExcavatorsPlanRockQtn: TFloatField;
    quVariantsExcavatorsRockRatio: TFloatField;
    quVariantsExcavatorsGx: TFloatField;
    quVariantsExcavatorsGxWork: TFloatField;
    quVariantsExcavatorsGxWaiting: TFloatField;
    quVariantsExcavatorsTmin: TFloatField;
    quVariantsExcavatorsTminWork: TFloatField;
    quVariantsExcavatorsTminWaiting: TFloatField;
    quVariantsExcavatorsTminManevr: TFloatField;
    quVariantsExcavatorsUsingPunktCoef: TFloatField;
    quVariantsExcavatorsUsingTimeCoef: TFloatField;
    quVariantsExcavatorsWorkCtg: TFloatField;
    quVariantsExcavatorsWorkSumGxCtg: TFloatField;
    quVariantsExcavatorsWorkMaterialsCtg: TFloatField;
    quVariantsExcavatorsWorkUnAccountedCtg: TFloatField;
    quVariantsExcavatorsWorkSalariesCtg: TFloatField;
    quVariantsExcavatorsWaitingCtg: TFloatField;
    quVariantsExcavatorsWaitingSumGxCtg: TFloatField;
    quVariantsExcavatorsWaitingMaterialsCtg: TFloatField;
    quVariantsExcavatorsWaitingUnAccountedCtg: TFloatField;
    quVariantsExcavatorsWaitingSalariesCtg: TFloatField;
    quVariantsExcavatorsAmortizationCtg: TFloatField;
    quVariantsExcavatorsCtg: TFloatField;
    quVariantsEconomExpensesCtg: TFloatField;
    quVariantsEconomExploatationCtg: TFloatField;
    quVariantsEconomAmortizationCtg: TFloatField;
    quVariantsEconomCtg: TFloatField;
    quVariantsEconomUdExploatationCtg_m3: TFloatField;
    quVariantsEconomUdAmortizationCtg_m3: TFloatField;
    quVariantsEconomUdExploatationCtg_tn: TFloatField;
    quVariantsEconomUdAmortizationCtg_tn: TFloatField;
    quVariantsEconomUdCtg_m3: TFloatField;
    quVariantsEconomUdCtg_tn: TFloatField;
    quVariantsIsBaseVariant: TBooleanField;
    quVariantsProductOutPutPercent: TFloatField;
    quVariantsProductPriceCtg: TFloatField;
    quVariantsMTWorkByScheduleCtg: TFloatField;
    quVariantsServiceExpensesCtg: TFloatField;
    quVariantsTruckCostCtg: TFloatField;
    quVariantsBaseVariantExpenesCtg: TFloatField;
    quVariantsPlannedRockVolumeCm: TFloatField;
    quVariantsProfit: TFloatField;
    quVariantsExpenses: TFloatField;
    quVariantsCurrOreVm3: TFloatField;
    quVariantsCurrOreQtn: TFloatField;
    quVariantsCurrStrippingQtn: TFloatField;
    quVariantsCurrStrippingVm3: TFloatField;
    quVariantsVgm: TFloatField;
    quVariantsSelicTM3: TFloatField;
    quVariantsNomEconomicEffectCtg: TFloatField;
    quVariantsBaseVariantCtg: TFloatField;
    quVariantsRelativeEconomicEffectCtg: TFloatField;
    quVariantsVOEconomicEffectCtg: TFloatField;
    quVariantsPeriodTdayL: TStringField;
    quVariantsKs: TFloatField;
    quVariantsCAutosTyresCtg: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;{TfmVariantGraphics}

var
  fmVariantGraphics: TfmVariantGraphics;

//Просмотр графиков вариантов моделирования
procedure esaShowVariantGraphicsDlg(const DoVariantsCalcFields: TDataSetNotifyEvent);
implementation

uses esaGlobals;

{$R *.dfm}

//Просмотр графиков вариантов моделирования
procedure esaShowVariantGraphicsDlg(const DoVariantsCalcFields: TDataSetNotifyEvent);
begin
  fmVariantGraphics := TfmVariantGraphics.Create(nil);
  try
    fmVariantGraphics.quVariants.OnCalcFields := DoVariantsCalcFields;
    fmVariantGraphics.quVariants.Open;
    fmVariantGraphics.ShowModal;
    fmVariantGraphics.quVariants.Close;
  finally
    fmVariantGraphics.Free;
  end;{try}
end;{esaShowVariantGraphicsDlg}

procedure TfmVariantGraphics.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  //DBChart4.MaxXValue;
end;{FormCreate}
end.
