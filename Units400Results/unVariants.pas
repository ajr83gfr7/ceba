unit unVariants;
{
ИГД им. Д.А.Кунаева
Елубаев Сулеймен Актлеуович, аспирант
Алматы, 2007/10/19 01:54
Диалоговое окно вариантов моделирования
 - автоматическое сохранение выходных результатов вариантов моделирования
 - просмотр вариантов моделирования
 - сортировка вариантов моделирования
 - удаление помеченных вариантов моделирования
 - вывод в Microsoft Excel сводной таблицы помеченных вариантов моделирования
 - просмотр различных графиков помеченных вариантов моделирования
      а) график удельных текущих затрат помеченных вариантов моделирования
      б) график степени выполнения плана помеченных вариантов моделирования
      в) график суммарных затрат помеченных вариантов моделирования
      г) график степени загруженности горно-транспортного оборудования помеченных вариантов моделирования
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, ComCtrls, DB, ADODB, StdCtrls, Mask,
  DBCtrls, Menus, DBCtrlsEh, DBGrids, Buttons;//, GridsEh;

const
  TOEXCEL = 'Открыть в Excel';
  TOGRAPH = 'Графическое отображение';
  TOOPEN = 'Открыть';

type
  TfmVariants = class(TForm)
    PageControl: TPageControl;
    tsAutos: TTabSheet;
    tsExcavators: TTabSheet;
    tsBlocks: TTabSheet;
    tsEconoms: TTabSheet;
    Splitter1: TSplitter;
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
    quVariantsShiftNaryadFactTmin: TFloatField;
    quVariantsShiftKweek: TFloatField;
    quVariantsDollarCtg: TFloatField;
    quVariantsAutos: TWideStringField;
    quVariantsAutosAutosCount0: TFloatField;
    quVariantsAutosTripsCountNulled: TFloatField;
    quVariantsAutosTripsCountLoading: TFloatField;
    quVariantsAutosTripsCountUnLoading: TFloatField;
    quVariantsAutosRockVm3: TFloatField;
    quVariantsAutosRockQtn: TFloatField;
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
    quVariantsAutosGxWork: TFloatField;
    quVariantsAutosGxWaiting: TFloatField;
    quVariantsAutosGxNulled: TFloatField;
    quVariantsAutosGxLoading: TFloatField;
    quVariantsAutosGxUnLoading: TFloatField;
    quVariantsAutosUdGx_gr_tkm: TFloatField;
    quVariantsAutosGxCtg: TFloatField;
    quVariantsAutosTminMoving: TFloatField;
    quVariantsAutosTminWaiting: TFloatField;
    quVariantsAutosTminManevr: TFloatField;
    quVariantsAutosTminOnLoading: TFloatField;
    quVariantsAutosTminOnUnLoading: TFloatField;
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
    quVariantsAutosWorkSumGxCtg: TFloatField;
    quVariantsAutosWorkSumTyresCtg: TFloatField;
    quVariantsAutosWorkSparesCtg: TFloatField;
    quVariantsAutosWorkMaterialsCtg: TFloatField;
    quVariantsAutosWorkMaintenancesCtg: TFloatField;
    quVariantsAutosWorkSalariesCtg: TFloatField;
    quVariantsAutosWaitingSumGxCtg: TFloatField;
    quVariantsAutosWaitingSparesCtg: TFloatField;
    quVariantsAutosWaitingMaterialsCtg: TFloatField;
    quVariantsAutosWaitingMaintenancesCtg: TFloatField;
    quVariantsAutosWaitingSalariesCtg: TFloatField;
    quVariantsAutosAmortizationCtg: TFloatField;
    quVariantsBlocksBlocksCount: TFloatField;
    quVariantsBlocksLm: TFloatField;
    quVariantsBlocksRockVm3: TFloatField;
    quVariantsBlocksRockQtn: TFloatField;
    quVariantsBlocksAutosCountNulled: TFloatField;
    quVariantsBlocksAutosCountLoading: TFloatField;
    quVariantsBlocksAutosCountUnLoading: TFloatField;
    quVariantsBlocksWaitingsCountNulled: TFloatField;
    quVariantsBlocksWaitingsCountLoading: TFloatField;
    quVariantsBlocksWaitingsCountUnLoading: TFloatField;
    quVariantsBlocksAvgVkmhNulled: TFloatField;
    quVariantsBlocksAvgVkmhLoading: TFloatField;
    quVariantsBlocksAvgVkmhUnLoading: TFloatField;
    quVariantsBlocksMovingAvgTminNulled: TFloatField;
    quVariantsBlocksMovingAvgTminLoading: TFloatField;
    quVariantsBlocksMovingAvgTminUnLoading: TFloatField;
    quVariantsBlocksWaitingAvgTminNulled: TFloatField;
    quVariantsBlocksWaitingAvgTminLoading: TFloatField;
    quVariantsBlocksWaitingAvgTminUnLoading: TFloatField;
    quVariantsBlocksEmploymentCoef: TFloatField;
    quVariantsBlocksGxNulled: TFloatField;
    quVariantsBlocksGxLoading: TFloatField;
    quVariantsBlocksGxUnLoading: TFloatField;
    quVariantsBlocksUdGx_l_m: TFloatField;
    quVariantsBlocksRepairCtg: TFloatField;
    quVariantsBlocksAmortizationCtg: TFloatField;
    quVariantsExcavators: TWideStringField;
    quVariantsExcavatorsExcavatorsCount0: TFloatField;
    quVariantsExcavatorsAutosCount: TFloatField;
    quVariantsExcavatorsRockVm3: TFloatField;
    quVariantsExcavatorsRockQtn: TFloatField;
    quVariantsExcavatorsPlanRockVm3: TFloatField;
    quVariantsExcavatorsPlanRockQtn: TFloatField;
    quVariantsExcavatorsGxWork: TFloatField;
    quVariantsExcavatorsGxWaiting: TFloatField;
    quVariantsExcavatorsTminWork: TFloatField;
    quVariantsExcavatorsTminWaiting: TFloatField;
    quVariantsExcavatorsTminManevr: TFloatField;
    quVariantsExcavatorsUsingPunktCoef: TFloatField;
    quVariantsExcavatorsUsingTimeCoef: TFloatField;
    quVariantsExcavatorsWorkSumGxCtg: TFloatField;
    quVariantsExcavatorsWorkMaterialsCtg: TFloatField;
    quVariantsExcavatorsWorkUnAccountedCtg: TFloatField;
    quVariantsExcavatorsWorkSalariesCtg: TFloatField;
    quVariantsExcavatorsWaitingSumGxCtg: TFloatField;
    quVariantsExcavatorsWaitingMaterialsCtg: TFloatField;
    quVariantsExcavatorsWaitingUnAccountedCtg: TFloatField;
    quVariantsExcavatorsWaitingSalariesCtg: TFloatField;
    quVariantsExcavatorsAmortizationCtg: TFloatField;
    quVariantsEconomExpensesCtg: TFloatField;
    quVariantsShiftNaryadTmin: TFloatField;
    quVariantsAutosSkm: TFloatField;
    quVariantsAutosGx: TFloatField;
    quVariantsAutosTmin: TFloatField;
    quVariantsAutosCtg: TFloatField;
    quVariantsAutosWorkCtg: TFloatField;
    quVariantsAutosWaitingCtg: TFloatField;
    quVariantsExcavatorsGx: TFloatField;
    quVariantsExcavatorsTmin: TFloatField;
    quVariantsExcavatorsRockRatio: TFloatField;
    quVariantsExcavatorsWorkCtg: TFloatField;
    quVariantsExcavatorsWaitingCtg: TFloatField;
    quVariantsExcavatorsCtg: TFloatField;
    quVariantsAutosDirGx: TFloatField;
    quVariantsAutosDirTmin: TFloatField;
    dsVaraints: TDataSource;
    pcAutos: TPageControl;
    tsAutos0: TTabSheet;
    tsAutos1: TTabSheet;
    tsAutos2: TTabSheet;
    tsAutos3: TTabSheet;
    dbgAutos1: TDBGridEh;
    dbgAutos0: TDBGridEh;
    dbgAutos2: TDBGridEh;
    dbgAutos3: TDBGridEh;
    pcExcavators: TPageControl;
    tsExcavators0: TTabSheet;
    tsExcavators1: TTabSheet;
    tsExcavators2: TTabSheet;
    tsExcavators3: TTabSheet;
    dbgExcavators0: TDBGridEh;
    dbgExcavators1: TDBGridEh;
    dbgExcavators2: TDBGridEh;
    dbgExcavators3: TDBGridEh;
    pcBlocks: TPageControl;
    tsBlocks0: TTabSheet;
    tsBlocks1: TTabSheet;
    tsBlocks2: TTabSheet;
    dbgBlocks0: TDBGridEh;
    quVariantsBlocksAutosCount: TFloatField;
    quVariantsBlocksWaitingsCount: TFloatField;
    quVariantsBlocksAvgVkmh: TFloatField;
    dbgBlocks1: TDBGridEh;
    quVariantsBlocksMovingAvgTmin: TFloatField;
    quVariantsBlocksWaitingAvgTmin: TFloatField;
    quVariantsBlocksGx: TFloatField;
    quVariantsBlocksCtg: TFloatField;
    dbgBlocks2: TDBGridEh;
    dbgEconoms: TDBGridEh;
    quVariantsEconomExploatationCtg: TFloatField;
    quVariantsEconomAmortizationCtg: TFloatField;
    quVariantsEconomCtg: TFloatField;
    quVariantsEconomUdExploatationCtg_m3: TFloatField;
    quVariantsEconomUdExploatationCtg_tn: TFloatField;
    quVariantsEconomUdAmortizationCtg_m3: TFloatField;
    quVariantsEconomUdAmortizationCtg_tn: TFloatField;
    quVariantsEconomUdCtg_m3: TFloatField;
    quVariantsEconomUdCtg_tn: TFloatField;
    PopupMenu: TPopupMenu;
    pmiMark: TMenuItem;
    pmiUnMark: TMenuItem;
    pmiSep1: TMenuItem;
    pmiMarkAll: TMenuItem;
    pmiUnMarkAll: TMenuItem;
    pmiSep2: TMenuItem;
    pmiDelete: TMenuItem;
    pmiSep3: TMenuItem;
    pmiMoveUp: TMenuItem;
    pmiMoveDown: TMenuItem;
    pmiSep4: TMenuItem;
    pmiExcel: TMenuItem;
    StatusBar: TStatusBar;
    pmiUnSelectAll: TMenuItem;
    pmiSep5: TMenuItem;
    pmiSep6: TMenuItem;
    pmiGraphics: TMenuItem;
    pmiExcelParams: TMenuItem;
    pmiExcelParamsDollar: TMenuItem;
    pmiExcelParamsThousandSeparator: TMenuItem;
    TabControl: TTabControl;
    dbgVariants: TDBGridEh;
    pmiSelectAll: TMenuItem;
    quVariantsAutosAutosCount1: TFloatField;
    quVariantsExcavatorsExcavatorsCount1: TFloatField;
    quVariantsExcavatorsExcavatorsCount: TStringField;
    quVariantsAutosAutosCount: TStringField;
    TabSheet1: TTabSheet;
    quVariantsIsBaseVariant: TBooleanField;
    quVariantsProductOutPutPercent: TFloatField;
    quVariantsProductPriceCtg: TFloatField;
    quVariantsMTWorkByScheduleCtg: TFloatField;
    quVariantsTruckCostCtg: TFloatField;
    quVariantsServiceExpensesCtg: TFloatField;
    quVariantsBaseVariantExpenesCtg: TFloatField;
    quVariantsPlannedRockVolumeCm: TFloatField;
    gbResult: TGroupBox;
    lbUsEcom: TLabel;
    lbOtnoEconom: TLabel;
    lbOriUsEco: TLabel;
    lbPribil: TLabel;
    lbRashot: TLabel;
    lbBaseVari: TLabel;
    gbInput: TGroupBox;
    lbStoiPrib: TLabel;
    lbZatSer: TLabel;
    lbProductPriceCtg: TLabel;
    lbProductOutPutPercent: TLabel;
    dbeProductOutPutPercent: TDBEditEh;
    dbeProductPriceCtg: TDBEdit;
    dbeTruckCostCtg: TDBEdit;
    dbeServiceExpensesCtg: TDBEdit;
    quVariantsProfit: TFloatField;
    dbeProfit: TDBEditEh;
    dbeExpensesCtg: TDBEditEh;
    dbeNominalEconomicEffectCtg: TDBEditEh;
    dbeRelativeEconomicEffectCtg: TDBEditEh;
    dbeVOEconomicEffectCtg: TDBEditEh;
    quVariantsExpenses: TFloatField;
    quVariantsNomEconomicEffectCtg: TFloatField;
    quVariantsBaseVariantCtg: TFloatField;
    quVariantsRelativeEconomicEffectCtg: TFloatField;
    quVariantsVOEconomicEffectCtg: TFloatField;
    gbModelInput: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    dbeAutosTyresCtg: TDBEditEh;
    dbeEconomUdCtg_tn: TDBEdit;
    pmiMakeBase: TMenuItem;
    redNomBaseVariantCtg: TRichEdit;
    quVariantsCurrOreQtn: TFloatField;
    quVariantsCurrOreVm3: TFloatField;
    quVariantsCurrStrippingQtn: TFloatField;
    quVariantsCurrStrippingVm3: TFloatField;
    Label2: TLabel;
    dbeKs: TDBEdit;
    Label8: TLabel;
    dbeSelicTM3: TDBEdit;
    Label9: TLabel;
    dbeShiftTmin: TDBEdit;
    Label10: TLabel;
    dbePeriodKshift: TDBEdit;
    quVariantsSelicTM3: TFloatField;
    Label11: TLabel;
    DBEditEh1: TDBEditEh;
    quVariantsVgm: TFloatField;
    dbtResult: TDBText;
    quVariantsPeriodTdayL: TStringField;
    btnCopyfromBase: TButton;
    lbQtnGM: TLabel;
    dbePlannedRockVolumeCm: TDBEdit;
    quVariantsKs: TFloatField;
    quVariantsCAutosTyresCtg: TFloatField;
    sbShowHidden: TSpeedButton;
    gbAdditinal: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeCurrStrippingQtn: TDBEdit;
    dbeCurrStrippingVm3: TDBEdit;
    dbeCurrOreQtn: TDBEdit;
    dbeCurrOreVm3: TDBEdit;
    Panel1: TPanel;
    grbToExcel: TGroupBox;
    btnToExcel: TButton;
    grbToGraph: TGroupBox;
    btnToGraph: TButton;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pmiMarkClick(Sender: TObject);
    procedure pmiUnMarkClick(Sender: TObject);
    procedure pmiMarkAllClick(Sender: TObject);
    procedure pmiUnMarkAllClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiMoveUpClick(Sender: TObject);
    procedure pmiMoveDownClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure pmiUnSelectAllClick(Sender: TObject);
    procedure pmiGraphicsClick(Sender: TObject);
    procedure pmiExcelParamsDollarClick(Sender: TObject);
    procedure pmiExcelParamsThousandSeparatorClick(Sender: TObject);
    procedure dsVaraintsDataChange(Sender: TObject; Field: TField);
    procedure dbgVariantsDrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure pmiSelectAllClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure pmiMakeBaseClick(Sender: TObject);
    procedure dbgVariantsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnCopyfromBaseClick(Sender: TObject);

    procedure sbShowHiddenClick(Sender: TObject);
    procedure btnToExcelClick(Sender: TObject);
    procedure btnToGraphClick(Sender: TObject);
  private
    procedure FormToShow();
    procedure DoVariantsCalcFields(DataSet: TDataSet);
    //Формирование названия ini-файла
    function IniFileName: String;
    //Возвращает Список кодов выделенных записей
    function GetSelectedRecords(var AId_ResultVariant: Integer): String;
    //
    procedure RequeryVariants();
    //Условный экономический эффект
    procedure  NominalEffectCalculation (DataSet: TDataSet);
    procedure  NEESaveToLocal();
  public
  end;
  TNEEBaseInput=record
    ProductOutPutPercent :double;
    ProductPriceCtg      :double;
    MTWorkByScheduleCtg  :double;
    TruckCostCtg         :double;
    ServiceExpensesCtg  :double;
    BaseVariantExpenesCtg :double;
    PlannedRockVolumeCm  :double;
  end;
var
  fmVariants: TfmVariants;
  Base_Var_Id_ResultVariant:integer;
  BaseUsEco:double;
  NEEBaseInput:TNEEBaseInput;
  ShowHidden:boolean=False;

//Диалоговое окно вариантов моделирования
procedure esaShowVariantsDlg();
implementation

uses unDM, esaGlobals, ExcelEditors, Printers, Math, unVariantGraphics, IniFiles,
  ComObj, Office2000, Word2000;

{$R *.dfm}
//Диалоговое окно вариантов моделирования
procedure esaShowVariantsDlg();
begin
  fmVariants := TfmVariants.Create(nil);
  try
    fmVariants.ShowModal;
  finally
    fmVariants.Free;
  end;{try}
end;
procedure TfmVariants.NEESaveToLocal();
begin
  if   quVariants.Locate('IsBaseVariant',TRUE, []) then
  begin
    Base_Var_Id_ResultVariant:= quVariantsId_ResultVariant.AsInteger;
    BaseUsEco:= quVariantsNomEconomicEffectCtg.AsFloat;
    redNomBaseVariantCtg.Lines[0]  := Format('%4.3f', [BaseUsEco]);
    NEEBaseInput.ProductPriceCtg:=quVariantsProductPriceCtg.AsFloat;
    NEEBaseInput.ProductOutPutPercent:=quVariantsProductOutPutPercent.AsFloat;
    NEEBaseInput.MTWorkByScheduleCtg:=quVariantsMTWorkByScheduleCtg.AsFloat;
    NEEBaseInput.TruckCostCtg:=quVariantsTruckCostCtg.AsFloat;
    NEEBaseInput.ServiceExpensesCtg:=quVariantsServiceExpensesCtg.AsFloat;
    NEEBaseInput.BaseVariantExpenesCtg:=quVariantsBaseVariantExpenesCtg.AsFloat;
  end else
  begin
     Base_Var_Id_ResultVariant:=1;
  end;
end;

procedure TfmVariants.FormCreate(Sender: TObject);
begin
  TabControl.TabIndex          := 0;
  PageControl.ActivePageIndex  := 0;
  pcAutos.ActivePageIndex      := 0;
  pcExcavators.ActivePageIndex := 0;
  pcBlocks.ActivePageIndex     := 0;
  quVariants.OnCalcFields      := DoVariantsCalcFields;
  quVariants.Open;
  NEESaveToLocal();
  quVariants.Last;
  with TIniFile.Create(IniFileName) do
  try
    pmiExcelParamsDollar.Checked            := ReadBool('Отчеты','InDollar',pmiExcelParamsDollar.Checked);
    pmiExcelParamsThousandSeparator.Checked := ReadBool('Отчеты','ThousandSeparator',pmiExcelParamsThousandSeparator.Checked);
  finally
    Free;
  end;{try}
  FormToShow();
end;{FormCreate}
procedure TfmVariants.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quVariants.Close;
end;{FormClose}

procedure TfmVariants.DoVariantsCalcFields(DataSet: TDataSet);
begin
  //Shift
  DataSet.FieldByName('ShiftNaryadTmin').AsFloat := DataSet.FieldByName('ShiftTmin').AsFloat-DataSet.FieldByName('ShiftTurnoverTmin').AsFloat;
  //Auto S,km
  DataSet.FieldByName('AutosSkm').AsFloat := DataSet.FieldByName('AutosSkmNulled').AsFloat+DataSet.FieldByName('AutosSkmLoading').AsFloat+DataSet.FieldByName('AutosSkmUnLoading').AsFloat;
  //Auto Gx,l
  DataSet.FieldByName('AutosGx').AsFloat := DataSet.FieldByName('AutosGxWork').AsFloat+DataSet.FieldByName('AutosGxWaiting').AsFloat;
  DataSet.FieldByName('AutosDirGx').AsFloat := DataSet.FieldByName('AutosGxNulled').AsFloat+DataSet.FieldByName('AutosGxLoading').AsFloat+DataSet.FieldByName('AutosGxUnLoading').AsFloat;
  //Auto T,min
  DataSet.FieldByName('AutosTmin').AsFloat := DataSet.FieldByName('AutosTminMoving').AsFloat+DataSet.FieldByName('AutosTminWaiting').AsFloat+DataSet.FieldByName('AutosTminManevr').AsFloat+DataSet.FieldByName('AutosTminOnLoading').AsFloat+DataSet.FieldByName('AutosTminOnUnLoading').AsFloat;
  DataSet.FieldByName('AutosDirTmin').AsFloat := DataSet.FieldByName('AutosTminNulled').AsFloat+DataSet.FieldByName('AutosTminLoading').AsFloat+DataSet.FieldByName('AutosTminUnLoading').AsFloat;
  //Auto C,tg
  DataSet.FieldByName('AutosWorkCtg').AsFloat := DataSet.FieldByName('AutosWorkSumGxCtg').AsFloat+DataSet.FieldByName('AutosWorkSumTyresCtg').AsFloat+
    DataSet.FieldByName('AutosWorkSparesCtg').AsFloat+DataSet.FieldByName('AutosWorkMaterialsCtg').AsFloat+DataSet.FieldByName('AutosWorkMaintenancesCtg').AsFloat+
    DataSet.FieldByName('AutosWorkSalariesCtg').AsFloat;
  DataSet.FieldByName('AutosWaitingCtg').AsFloat := DataSet.FieldByName('AutosWaitingSumGxCtg').AsFloat+
    DataSet.FieldByName('AutosWaitingSparesCtg').AsFloat+DataSet.FieldByName('AutosWaitingMaterialsCtg').AsFloat+DataSet.FieldByName('AutosWaitingMaintenancesCtg').AsFloat+
    DataSet.FieldByName('AutosWaitingSalariesCtg').AsFloat;
  DataSet.FieldByName('AutosCtg').AsFloat := DataSet.FieldByName('AutosWorkCtg').AsFloat+DataSet.FieldByName('AutosWaitingCtg').AsFloat+
    DataSet.FieldByName('AutosAmortizationCtg').AsFloat;
  //Excavator Gx,l
  DataSet.FieldByName('ExcavatorsGx').AsFloat := DataSet.FieldByName('ExcavatorsGxWork').AsFloat+DataSet.FieldByName('ExcavatorsGxWaiting').AsFloat;
  //Excavator T,min
  DataSet.FieldByName('ExcavatorsTmin').AsFloat := DataSet.FieldByName('ExcavatorsTminWork').AsFloat+DataSet.FieldByName('ExcavatorsTminWaiting').AsFloat+DataSet.FieldByName('ExcavatorsTminManevr').AsFloat;
  //Excavator Rock,%
  DataSet.FieldByName('ExcavatorsRockRatio').AsFloat := esaDrob(100*DataSet.FieldByName('ExcavatorsRockQtn').AsFloat,DataSet.FieldByName('ExcavatorsPlanRockQtn').AsFloat);
  //Excavator C,tg
  DataSet.FieldByName('ExcavatorsWorkCtg').AsFloat := DataSet.FieldByName('ExcavatorsWorkSumGxCtg').AsFloat+DataSet.FieldByName('ExcavatorsWorkMaterialsCtg').AsFloat+
    DataSet.FieldByName('ExcavatorsWorkUnAccountedCtg').AsFloat+DataSet.FieldByName('ExcavatorsWorkSalariesCtg').AsFloat;
  DataSet.FieldByName('ExcavatorsWaitingCtg').AsFloat := DataSet.FieldByName('ExcavatorsWaitingSumGxCtg').AsFloat+DataSet.FieldByName('ExcavatorsWaitingMaterialsCtg').AsFloat+
    DataSet.FieldByName('ExcavatorsWaitingUnAccountedCtg').AsFloat+DataSet.FieldByName('ExcavatorsWaitingSalariesCtg').AsFloat;
  DataSet.FieldByName('ExcavatorsCtg').AsFloat := DataSet.FieldByName('ExcavatorsWorkCtg').AsFloat+DataSet.FieldByName('ExcavatorsWaitingCtg').AsFloat+
    DataSet.FieldByName('ExcavatorsAmortizationCtg').AsFloat;
  //Blocks,AutosCount
  DataSet.FieldByName('BlocksAutosCount').AsFloat := DataSet.FieldByName('BlocksAutosCountNulled').AsFloat+DataSet.FieldByName('BlocksAutosCountLoading').AsFloat+DataSet.FieldByName('BlocksAutosCountUnLoading').AsFloat;
  //Blocks,WaitingsCount
  DataSet.FieldByName('BlocksWaitingsCount').AsFloat := DataSet.FieldByName('BlocksWaitingsCountNulled').AsFloat+DataSet.FieldByName('BlocksWaitingsCountLoading').AsFloat+DataSet.FieldByName('BlocksWaitingsCountUnLoading').AsFloat;
  //Blocks V,kmh
  DataSet.FieldByName('BlocksAvgVkmh').AsFloat := (DataSet.FieldByName('BlocksAvgVkmhNulled').AsFloat+DataSet.FieldByName('BlocksAvgVkmhLoading').AsFloat+DataSet.FieldByName('BlocksAvgVkmhUnLoading').AsFloat)/3;
  //Blocks T,min
  DataSet.FieldByName('BlocksMovingAvgTmin').AsFloat := (DataSet.FieldByName('BlocksMovingAvgTminNulled').AsFloat+DataSet.FieldByName('BlocksMovingAvgTminLoading').AsFloat+DataSet.FieldByName('BlocksMovingAvgTminUnLoading').AsFloat)/3;
  DataSet.FieldByName('BlocksWaitingAvgTmin').AsFloat := (DataSet.FieldByName('BlocksWaitingAvgTminNulled').AsFloat+DataSet.FieldByName('BlocksWaitingAvgTminLoading').AsFloat+DataSet.FieldByName('BlocksWaitingAvgTminUnLoading').AsFloat)/3;
  //Blocks Gx,l
  DataSet.FieldByName('BlocksGx').AsFloat := DataSet.FieldByName('BlocksGxNulled').AsFloat+DataSet.FieldByName('BlocksGxLoading').AsFloat+DataSet.FieldByName('BlocksGxUnLoading').AsFloat;
  //Blocks C,tg
  DataSet.FieldByName('BlocksCtg').AsFloat := DataSet.FieldByName('BlocksRepairCtg').AsFloat+DataSet.FieldByName('BlocksAmortizationCtg').AsFloat;
  //Econom C,tg
  DataSet.FieldByName('EconomExploatationCtg').AsFloat      := DataSet.FieldByName('AutosWorkCtg').AsFloat+DataSet.FieldByName('ExcavatorsWorkCtg').AsFloat+DataSet.FieldByName('BlocksRepairCtg').AsFloat+
                                                               DataSet.FieldByName('AutosWaitingCtg').AsFloat+DataSet.FieldByName('ExcavatorsWaitingCtg').AsFloat;
  DataSet.FieldByName('EconomAmortizationCtg').AsFloat      := DataSet.FieldByName('AutosAmortizationCtg').AsFloat+DataSet.FieldByName('ExcavatorsAmortizationCtg').AsFloat+DataSet.FieldByName('BlocksAmortizationCtg').AsFloat;
  DataSet.FieldByName('EconomCtg').AsFloat                  := DataSet.FieldByName('EconomExploatationCtg').AsFloat+DataSet.FieldByName('EconomExpensesCtg').AsFloat+DataSet.FieldByName('EconomAmortizationCtg').AsFloat;
  DataSet.FieldByName('EconomUdExploatationCtg_m3').AsFloat := esaDrob(DataSet.FieldByName('EconomExploatationCtg').AsFloat,DataSet.FieldByName('ExcavatorsRockVm3').AsFloat);
  DataSet.FieldByName('EconomUdExploatationCtg_tn').AsFloat := esaDrob(DataSet.FieldByName('EconomExploatationCtg').AsFloat,DataSet.FieldByName('ExcavatorsRockQtn').AsFloat);
  DataSet.FieldByName('EconomUdAmortizationCtg_m3').AsFloat := esaDrob(DataSet.FieldByName('EconomAmortizationCtg').AsFloat,DataSet.FieldByName('ExcavatorsRockVm3').AsFloat);
  DataSet.FieldByName('EconomUdAmortizationCtg_tn').AsFloat := esaDrob(DataSet.FieldByName('EconomAmortizationCtg').AsFloat,DataSet.FieldByName('ExcavatorsRockQtn').AsFloat);
  DataSet.FieldByName('EconomUdCtg_m3').AsFloat             := esaDrob(DataSet.FieldByName('EconomCtg').AsFloat,DataSet.FieldByName('ExcavatorsRockVm3').AsFloat);
  DataSet.FieldByName('EconomUdCtg_tn').AsFloat             := esaDrob(DataSet.FieldByName('EconomCtg').AsFloat,DataSet.FieldByName('ExcavatorsRockQtn').AsFloat);
  DataSet.FieldByName('AutosAutosCount').AsString := Format('%d из %d',[DataSet.FieldByName('AutosAutosCount0').AsInteger,DataSet.FieldByName('AutosAutosCount0').AsInteger+DataSet.FieldByName('AutosAutosCount1').AsInteger]);
  DataSet.FieldByName('ExcavatorsExcavatorsCount').AsString := Format('%d из %d',[DataSet.FieldByName('ExcavatorsExcavatorsCount0').AsInteger,DataSet.FieldByName('ExcavatorsExcavatorsCount0').AsInteger+DataSet.FieldByName('ExcavatorsExcavatorsCount1').AsInteger]);

  //ShowMessage(FloatToStr(DataSet.FieldByName('SortIndex').AsFloat));
  //SEE 8/02/2018: Relative economical effect calculation added
   NominalEffectCalculation(DataSet);

end;{DoVariantsCalcFields}

procedure TfmVariants.NominalEffectCalculation(DataSet: TDataSet);
var RocksVm3,Orevm3,WastVm3,OreQtn,Selic,STyres,UdelQtn,KVsry,Vn,OriUsEco,PeriodCoef : Double;
    Vgm,Bn,Cn,Cstro,Crem,UsEco: Double;
begin

  DataSet.FieldByName('PeriodTdayL').AsString :=    'Выходные данные  за период -  '+    DataSet.FieldByName('PeriodTday').AsString +' дней';
  {Коэффциент перхода сменных показателей, млн.тг}
  PeriodCoef := DataSet.FieldByName('PeriodKshift').AsFloat;
  {Прочие текущие расходы связанные с приобретением шин и т.д., млн.тенге} { на надписи - идут как затраты??посмотреть в староой}
  { было просмотренно -  берется как сумма затрат на шины, тыс.тн/период каждого автосамосвала -текущие затраты}
  STyres :=DataSet.FieldByName('AutosTyresCtg').AsFloat*PeriodCoef;    ;// StrToFloat(edSTyres.Text);
  DataSet.FieldByName('CAutosTyresCtg').AsFloat :=   STyres/1000;
  {Удельные текущие затраты по горной массе, тенге  - на m3??}
  UdelQtn :=DataSet.FieldByName('EconomUdCtg_m3').AsFloat;// StrToFloat(edUdelQtn.Text);
  {Коэффициент вскрыши, т/т}  {т/т?}

  KVsry:=   DataSet.FieldByName('Ks').AsFloat;

  {Показатель плотности руды, т/м3}
  OreVm3  := DataSet.FieldByName('CurrOreVm3').AsFloat;
  WastVm3 := DataSet.FieldByName('CurrStrippingVm3').AsFloat;
  OreQtn:=DataSet.FieldByName('CurrOreQtn').AsFloat;
  if   OreVm3>0 then Selic := OreQtn/OreVm3;//StrToFloat(edSelic.Text);
   DataSet.FieldByName('SelicTM3').AsFloat :=   Selic;

  {Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, Vgm в м3}
  RocksVm3 :=DataSet.FieldByName('ExcavatorsRockVm3').AsFloat;// GetFloat(StrToFloat(edRocksVm3.Text)*1000,3);

  //Action from 10/02/18 GSJ    коэффициент вскрыши  - изменяемый (выполнено)
  //изначально  коэффициент вскрыши    берется из esaRunObjects/procedure TDispatcher.DefineCurrStrippingCoef_;
  //Vgm := ((1440/edParamsShiftDuration.Text))*365*StrToFloat(edResultPeriodCoef.Text))*RocksVm3;
  Vgm := RocksVm3*PeriodCoef;
  DataSet.FieldByName('Vgm').AsFloat :=   Vgm/1000;  //в тыс м3
  {Показатель выхода продукта с 1 тонны руды, %}
  Bn :=  DataSet.FieldByName('ProductOutPutPercent').AsFloat;  //GetFloat(StrToFloat(edProduk.Text),3);

  {Цена на 1 тонну продукта на рынке сбыта, тыс.тенге}
  Cn := DataSet.FieldByName('ProductPriceCtg').AsFloat*1000;
  {Прочие дополнительные единовременные расходы на строительство автодорог и железнодорожных
  путей, приобретение нового оборудования, строительство дополнительных съездов и т.д., млн.тенге}
  Cstro := DataSet.FieldByName('TruckCostCtg').AsFloat*1E6; //в тенге
  {Сумма затрат связанная с текущими ремонтами автосамосвалов}
  Crem := DataSet.FieldByName('ServiceExpensesCtg').AsFloat*1E6; //в тенге
  {Прибыль, млн.тг}
  DataSet.FieldByName('ProfitCtg').AsFloat :=     ((Vgm*Selic*Bn*Cn)/((1+KVsry)*100))/1E6;
  {Затраты, млн.тг}
  DataSet.FieldByName('ExpensesCtg').AsFloat := (Vgm*UdelQtn+STyres+Cstro+Crem)/1E6;
  {Условный экономический эффект, млн.тг}
  UsEco := ((Vgm*Selic*Bn*Cn)/((1+KVsry)*100)-(Vgm*UdelQtn+STyres+Cstro+Crem))/1E6;
  DataSet.FieldByName('NominalEconomicEffectCtg').AsFloat := UsEco;
  {Относительный экономический эффект, млн.тг}
  DataSet.FieldByName('RelativeEconomicEffectCtg').AsFloat := BaseUsEco-UsEco;
  {Объем горной массы запланированный к извлечению в рассматриваемом периоде, Vn в м3}
  Vn := DataSet.FieldByName('ExcavatorsPlanRockVm3').AsFloat*PeriodCoef;
  DataSet.FieldByName('PlannedRockVolumeCm').AsFloat:= Vn/1000;
  {Объемно ориентированный условный экономический эффект, млн.тг}
  OriUsEco := Vn*UdelQtn+Vn*(STyres/Vgm)+Cstro+Crem;
  DataSet.FieldByName('VOEconomicEffectCtg').AsFloat := OriUsEco/1E6;
end;  {NominalEffectCalculation}


//Формирование названия ini-файла
function TfmVariants.IniFileName: String;
begin
  Result := ChangeFileExt(Application.ExeName,'.ini');
end;{IniFileName}
//Возвращает Список кодов выделенных записей
function TfmVariants.GetSelectedRecords(var AId_ResultVariant: Integer): String;
var
  I: Integer;
  ADataset: TDataSet;
begin
  Result := '';
  AId_ResultVariant := 0;
  if quVariants.Active and(quVariants.RecordCount>0) then
  begin
    ADataset := dbgVariants.DataSource.DataSet;
    AId_ResultVariant := ADataset.FieldByName('Id_ResultVariant').AsInteger;
    Result := ',';
    //Нахожу список кодов выделенных записи
    if dbgVariants.SelectedRows.Count>0 then
      for I := 0 to dbgVariants.SelectedRows.Count-1 do
      begin
        ADataset.GotoBookmark(Pointer(dbgVariants.SelectedRows.Items[I]));
        Result := Result+ADataset.FieldByName('Id_ResultVariant').AsString+',';
      end;{for}
    //Если кода текущей записи нет в списке, то добавляю его
    if Pos(','+quVariantsId_ResultVariant.AsString+',',Result)=0
    then Result := Result+quVariantsId_ResultVariant.AsString+',';
    //Убираю начальную и конечную запятую
    Result := Copy(Result,2,Length(Result)-2);
  end;{if}
end;{GetSelectedRecords}
//
procedure TfmVariants.RequeryVariants();
var AId_ResultVariant: Integer;
begin
  AId_ResultVariant := quVariantsId_ResultVariant.AsInteger;
  quVariants.Requery();
  try
    quVariants.DisableControls;
    quVariants.Locate('Id_ResultVariant',AId_ResultVariant,[]);
  finally
    quVariants.EnableControls;
  end;{try}
end;{RequeryVariants}


procedure TfmVariants.pmiMarkClick(Sender: TObject);
var
  AId_ResultVariant: Integer;
  AId_ResultVariants: String;
begin
  AId_ResultVariants := GetSelectedRecords(AId_ResultVariant);
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET IsPrint=TRUE WHERE Id_ResultVariant in ('+AId_ResultVariants+')';
      ExecSQL;
    finally
      Free;
    end;{try}
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;{try}
end;{pmiSelectClick}

procedure TfmVariants.pmiUnMarkClick(Sender: TObject);
var
  AId_ResultVariant: Integer;
  AId_ResultVariants: String;
begin
  AId_ResultVariants := GetSelectedRecords(AId_ResultVariant);
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET IsPrint=FALSE WHERE Id_ResultVariant in ('+AId_ResultVariants+')';
      ExecSQL;
    finally
      Free;
    end;{try}
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;{try}
end;{pmiUnSelectClick}

procedure TfmVariants.pmiMarkAllClick(Sender: TObject);
begin
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET IsPrint=TRUE';
      ExecSQL;
    finally
      Free;
    end;{try}
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;{try}
end;{pmiSelectAllClick}

procedure TfmVariants.pmiUnMarkAllClick(Sender: TObject);
begin
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET IsPrint=FALSE';
      ExecSQL;
    finally
      Free;
    end;{try}
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;{try}
end;{pmiUnSelectAllClick}

procedure TfmVariants.pmiSelectAllClick(Sender: TObject);
begin
  dbgVariants.SelectedRows.Clear;
  dbgVariants.SelectedRows.SelectAll;
end;{pmiSelectAllClick}
procedure TfmVariants.pmiUnSelectAllClick(Sender: TObject);
begin
  dbgVariants.SelectedRows.Clear;
end;{pmiClearSelectionClick}

procedure TfmVariants.pmiMakeBaseClick(Sender: TObject);
var
  AId_ResultVariant: Integer;
  AId_ResultVariants: String;
begin
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET IsBaseVariant=FALSE';
      ExecSQL;
      SQL.Text := 'UPDATE _ResultVariants SET IsBaseVariant=TRUE WHERE Id_ResultVariant='+quVariantsId_ResultVariant.AsString;
      ExecSQL;
    finally
      Free;
    end;{try}
  finally
    RequeryVariants();
    NEESaveToLocal();
  end;{try}
end;{pmiMakeBaseClick}

procedure TfmVariants.pmiDeleteClick(Sender: TObject);
var ASortIndex: Integer;
begin
  if esaMsgQuestionYN('Удалить все помеченные варианты моделирования?') then
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'DELETE FROM _ResultVariants WHERE IsPrint=TRUE';
      ExecSQL;
      SQL.Text := 'SELECT * FROM _ResultVariants ORDER BY SortIndex';
      Open;
      First;
      ASortIndex := 0;
      while not EOF do
      begin
        Inc(ASortIndex);
        Edit;
        FieldByName('SortIndex').AsInteger := ASortIndex;
        Post;
        Next;
      end;{while}
      Close;
    finally
      Free;
    end;{try}
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;{try}
end;{pmiDeleteClick}

procedure TfmVariants.pmiMoveUpClick(Sender: TObject);
begin
  if quVariants.RecNo>1 then
  try
    quVariants.DisableControls;
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET SortIndex=SortIndex+1 WHERE SortIndex='+IntToStr(quVariantsSortIndex.AsInteger-1);
      ExecSQL;
      SQL.Text := 'UPDATE _ResultVariants SET SortIndex=SortIndex-1 WHERE Id_ResultVariant='+quVariantsId_ResultVariant.AsString;
      ExecSQL;
    finally
      Free;
    end;{try}
    RequeryVariants();
  finally
    quVariants.EnableControls;
  end;{try}
end;{pmiMoveUpClick}

procedure TfmVariants.pmiMoveDownClick(Sender: TObject);
begin
  if quVariants.RecNo<quVariants.RecordCount then
  try
    quVariants.DisableControls;
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE _ResultVariants SET SortIndex=SortIndex-1 WHERE SortIndex='+IntToStr(quVariantsSortIndex.AsInteger+1);
      ExecSQL;
      SQL.Text := 'UPDATE _ResultVariants SET SortIndex=SortIndex+1 WHERE Id_ResultVariant='+quVariantsId_ResultVariant.AsString;
      ExecSQL;
    finally
      Free;
    end;{try}
    RequeryVariants();
  finally
    quVariants.EnableControls;
  end;{try}
end;{pmiMoveDownClick}
procedure TfmVariants.pmiExcelParamsDollarClick(Sender: TObject);
begin
  pmiExcelParamsDollar.Checked := not pmiExcelParamsDollar.Checked;
  with TIniFile.Create(IniFileName) do
  try
    WriteBool('Отчеты','InDollar',pmiExcelParamsDollar.Checked);
  finally
    Free;
  end;{try}
end;{pmiExcelParamsDollarClick}
procedure TfmVariants.pmiExcelParamsThousandSeparatorClick(Sender: TObject);
begin
  pmiExcelParamsThousandSeparator.Checked := not pmiExcelParamsThousandSeparator.Checked;
  with TIniFile.Create(IniFileName) do
  try
    WriteBool('Отчеты','ThousandSeparator',pmiExcelParamsThousandSeparator.Checked);
  finally
    Free;
  end;{try}
end;{pmiExcelParamsThousandSeparatorClick}
procedure TfmVariants.pmiExcelClick(Sender: TObject);
const InchPerMillimetr = 0.1/2.54;
var
  XL                : TExcelEditor; //Приложение Microsoft Excel
  I                 : Integer;
  AId_ResultVariant : Integer;      //Код текущего варианта
  ltHeader          : TPoint;       //left,top шапки таблицы
  hHeader           : Integer;      //height шапки таблицы
  ltData            : TPoint;       //left,top данных таблицы
  whData            : TPoint;       //width,height данных таблицы
  ACostsSuffix      : String;       //Суффикс финансовых значений: ", тг"/", $"
  fFloat00          : String;       //Формат вещественных значений
  fFloat0000        : String;       //Формат вещественных значений
  fInt              : String;       //Формат целочисленных значений
  ACostsCoef        : Single;       //Коэффициент перевода финансовых значений
  AOptimalCol       : Integer;      //Столбец оптимального варианта
  AOptimalValue,AOptimalTemp: Single;       //Значение оптимального варианта
  APriorPlan        : Single;       //Предыдущий план выполнения
  AWord,ASheet      : Variant;
begin
  ltHeader := Point(1,2);
  hHeader  := 2;
  ltData   := Point(ltHeader.X+2,ltHeader.Y+hHeader);
  whData   := Point(1,141);
  if pmiExcelParamsDollar.Checked
  then ACostsSuffix := ', $'
  else ACostsSuffix := ', тг';
  if pmiExcelParamsThousandSeparator.Checked
  then fFloat00 := '# ### ### ### ##0.00'
  else fFloat00 := '0.00';
  if pmiExcelParamsThousandSeparator.Checked
  then fInt := '# ### ### ### ##0'
  else fInt := '0';
  if pmiExcelParamsDollar.Checked
  then fFloat0000 := '# ### ### ### ##0.0000'
  else fFloat0000 := fFloat00;
  if quVariants.Active and(quVariants.RecordCount>0) then
  begin
    AId_ResultVariant := quVariantsId_ResultVariant.AsInteger;
    XL := TExcelEditor.Create;
    try
     XL.SheetCount       := 5;
     XL.ActiveSheetIndex := 0;
     XL.SheetName        := 'Свод';
     //Заголовок
     XL.StringCells[ 1,1] := Caption;
     XL.Cells      [ 1,1,1,1].Font.Style := [xlfsBold];
     //OX шкала
     XL.StringCells [ltHeader.Y+0,ltHeader.X+0] := '№';
     XL.StringCells [ltHeader.Y+0,ltHeader.X+1] := 'Параметры';
     XL.StringCells [ltHeader.Y+0,ltHeader.X+2] := 'Варианты';
     //OY
     XL.StringCells[ltData.Y+  0,2] := 'Показатели варианта моделирования';
     XL.Cells      [ltData.Y+  0,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+  1,2] := 'Вариант моделирования';
     XL.StringCells[ltData.Y+  2,2] := 'Карьер';
     XL.StringCells[ltData.Y+  3,2] := 'Дата';
     XL.StringCells[ltData.Y+  4,2] := 'Общие показатели';
     XL.Cells      [ltData.Y+  4,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+  5,2] := 'Курс доллара, тг';
     XL.StringCells[ltData.Y+  6,2] := 'Показатели рабочей смены';
     XL.Cells      [ltData.Y+  6,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+  7,2] := 'Продолжительность, мин';
     XL.StringCells[ltData.Y+  8,2] := 'Время в наряде, мин';
     XL.StringCells[ltData.Y+  9,2] := 'Время пересменки, мин';
     XL.StringCells[ltData.Y+ 10,2] := 'Время в наряде (факт), мин';
     XL.StringCells[ltData.Y+ 11,2] := 'Коэффициент сменных параметров';
     XL.StringCells[ltData.Y+ 12,2] := 'Показатели периода моделирования';
     XL.Cells      [ltData.Y+ 12,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 13,2] := 'Продолжительность, дни';
     XL.StringCells[ltData.Y+ 14,2] := 'Коэффициент перевода сменных параметров на период';
     XL.StringCells[ltData.Y+ 15,2] := 'Количественные показатели автосамосвалов';
     XL.Cells      [ltData.Y+ 15,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 16,2] := 'Автосамосвалы';
     XL.StringCells[ltData.Y+ 17,2] := 'Количество автосамосвалов';
     XL.StringCells[ltData.Y+ 18,2] := 'Количество рейсов';
     XL.StringCells[ltData.Y+ 19,2] := ' - в нулевом направлении';
     XL.StringCells[ltData.Y+ 20,2] := ' - в грузовом направлении';
     XL.StringCells[ltData.Y+ 21,2] := ' - в порожняковом направлении';
     XL.StringCells[ltData.Y+ 22,2] := 'Объем перевезенной горной массы, м3';
     XL.StringCells[ltData.Y+ 23,2] := 'Вес перевезенной горной массы, т';
     XL.StringCells[ltData.Y+ 24,2] := 'Общий пробег, км';
     XL.StringCells[ltData.Y+ 25,2] := ' - в нулевом направлении';
     XL.StringCells[ltData.Y+ 26,2] := ' - в грузовом направлении';
     XL.StringCells[ltData.Y+ 27,2] := ' - в порожняковом направлении';
     XL.StringCells[ltData.Y+ 28,2] := 'Расстояние транспортирования, км';
     XL.StringCells[ltData.Y+ 29,2] := ' - средневзвешенное';
     XL.StringCells[ltData.Y+ 30,2] := ' - среднее';
     XL.StringCells[ltData.Y+ 31,2] := 'Среднесменный пробег одного автосамосвала, км/смена';
     XL.StringCells[ltData.Y+ 32,2] := 'Среднесменный пробег одного автосамосвала, км/рейс';
     XL.StringCells[ltData.Y+ 33,2] := 'Средневзвешенная высота подъема горной массы, м';
     XL.StringCells[ltData.Y+ 34,2] := 'Средняя скорость движения, км/ч';
     XL.StringCells[ltData.Y+ 35,2] := ' - в нулевом направлении';
     XL.StringCells[ltData.Y+ 36,2] := ' - в грузовом направлении';
     XL.StringCells[ltData.Y+ 37,2] := ' - в порожняковом направлении';
     XL.StringCells[ltData.Y+ 38,2] := 'Среднетехническая скорость движения, км/ч';
     XL.StringCells[ltData.Y+ 39,2] := 'Показатели расхода топлива автосамосвалов';
     XL.Cells      [ltData.Y+ 39,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 40,2] := 'Общий расход топлива, л';
     XL.StringCells[ltData.Y+ 41,2] := ' - в работе';
     XL.StringCells[ltData.Y+ 42,2] := ' - в простое';
     XL.StringCells[ltData.Y+ 43,2] := 'Общий расход топлива по направлениям, л';
     XL.StringCells[ltData.Y+ 44,2] := ' - в нулевом направлении';
     XL.StringCells[ltData.Y+ 45,2] := ' - в грузовом направлении';
     XL.StringCells[ltData.Y+ 46,2] := ' - в порожняковом направлении';
     XL.StringCells[ltData.Y+ 47,2] := 'Удельный расход топлива, г/ткм';
     XL.StringCells[ltData.Y+ 48,2] := 'Затраты на топливо'+ACostsSuffix;
     XL.StringCells[ltData.Y+ 49,2] := 'Показатели расхода шин автосамосвалов';
     XL.Cells      [ltData.Y+ 49,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 50,2] := 'Общее количество шин';
     XL.StringCells[ltData.Y+ 51,2] := 'Общий пробег шин, км';
     XL.StringCells[ltData.Y+ 52,2] := 'Количество израсходованных шин, шт';
     XL.StringCells[ltData.Y+ 53,2] := 'Затраты на шины'+ACostsSuffix;
     XL.StringCells[ltData.Y+ 54,2] := 'Показатели использования рабочего времени автосамосвалов';
     XL.Cells      [ltData.Y+ 54,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 55,2] := 'Общее время, мин';
     XL.StringCells[ltData.Y+ 56,2] := ' - в движении';
     XL.StringCells[ltData.Y+ 57,2] := ' - в простое';
     XL.StringCells[ltData.Y+ 58,2] := ' - при маневрах';
     XL.StringCells[ltData.Y+ 59,2] := ' - под погрузкой';
     XL.StringCells[ltData.Y+ 60,2] := ' - под разгрузкой';
     XL.StringCells[ltData.Y+ 61,2] := 'Общее время по направлениям, мин';
     XL.StringCells[ltData.Y+ 62,2] := ' - в нулевом направлении';
     XL.StringCells[ltData.Y+ 63,2] := ' - в грузовом направлении';
     XL.StringCells[ltData.Y+ 64,2] := ' - в порожняковом направлении';
     XL.StringCells[ltData.Y+ 65,2] := 'Среднее время рейса, мин';
     XL.StringCells[ltData.Y+ 66,2] := ' - в нулевом направлении';
     XL.StringCells[ltData.Y+ 67,2] := ' - в грузовом направлении';
     XL.StringCells[ltData.Y+ 68,2] := ' - в порожняковом направлении';
     XL.StringCells[ltData.Y+ 69,2] := 'Средний коэффициент использования рабочего времени';
     XL.StringCells[ltData.Y+ 70,2] := 'Стоимостные показатели автосамосвалов';
     XL.Cells      [ltData.Y+ 70,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 71,2] := 'Затраты в работе'+ACostsSuffix;
     XL.StringCells[ltData.Y+ 72,2] := ' - топливо';
     XL.StringCells[ltData.Y+ 73,2] := ' - шины';
     XL.StringCells[ltData.Y+ 74,2] := ' - запчасти и материалы';
     XL.StringCells[ltData.Y+ 75,2] := ' - смазочные материалы';
     XL.StringCells[ltData.Y+ 76,2] := ' - ремонтный персонал';
     XL.StringCells[ltData.Y+ 77,2] := ' - зарплата';
     XL.StringCells[ltData.Y+ 78,2] := 'Затраты в простое'+ACostsSuffix;
     XL.StringCells[ltData.Y+ 79,2] := ' - топливо';
     XL.StringCells[ltData.Y+ 80,2] := ' - запчасти и материалы';
     XL.StringCells[ltData.Y+ 81,2] := ' - смазочные материалы';
     XL.StringCells[ltData.Y+ 82,2] := ' - ремонтный персонал';
     XL.StringCells[ltData.Y+ 83,2] := ' - зарплата';
     XL.StringCells[ltData.Y+ 84,2] := 'Амортизационные отчисления'+ACostsSuffix;
     XL.StringCells[ltData.Y+ 85,2] := 'Суммарные затраты'+ACostsSuffix;
     XL.StringCells[ltData.Y+ 86,2] := 'Количественные показатели экскаваторов';
     XL.Cells      [ltData.Y+ 86,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 87,2] := 'Экскаваторы';
     XL.StringCells[ltData.Y+ 88,2] := 'Количество экскаваторов';
     XL.StringCells[ltData.Y+ 89,2] := 'Количество погруженных автосамосвалов';
     XL.StringCells[ltData.Y+ 90,2] := 'Объем погруженной горной массы, м3';
     XL.StringCells[ltData.Y+ 91,2] := 'Вес погруженной горной массы, т';
     XL.StringCells[ltData.Y+ 92,2] := 'Плановый объем горной массы, м3';
     XL.StringCells[ltData.Y+ 93,2] := 'Плановый вес горной массы, т';
     XL.StringCells[ltData.Y+ 94,2] := 'Степень выполнения плана, %';
     XL.StringCells[ltData.Y+ 95,2] := 'Показатели расхода электроэнергии экскаваторов';
     XL.Cells      [ltData.Y+ 95,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+ 96,2] := 'Расход электроэнергии, кВт*ч';
     XL.StringCells[ltData.Y+ 97,2] := ' - в работе';
     XL.StringCells[ltData.Y+ 98,2] := ' - в простое';
     XL.StringCells[ltData.Y+ 99,2] := 'Показатели использования рабочего времени экскаваторов';
     XL.Cells      [ltData.Y+ 99,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+100,2] := 'Общее время, мин';
     XL.StringCells[ltData.Y+101,2] := ' - в работе';
     XL.StringCells[ltData.Y+102,2] := ' - в простое';
     XL.StringCells[ltData.Y+103,2] := ' - при маневрах автосамосвалов';
     XL.StringCells[ltData.Y+104,2] := 'Коэффициент занятости пунктов погрузки';
     XL.StringCells[ltData.Y+105,2] := 'Коэффициент использования рабочего времени';
     XL.StringCells[ltData.Y+106,2] := 'Стоимостные показатели экскаваторов';
     XL.Cells      [ltData.Y+106,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+107,2] := 'Затраты в работе'+ACostsSuffix;
     XL.StringCells[ltData.Y+108,2] := ' - электроэнергия';
     XL.StringCells[ltData.Y+109,2] := ' - материалы';
     XL.StringCells[ltData.Y+110,2] := ' - неучтенные расходы';
     XL.StringCells[ltData.Y+111,2] := ' - зарплата';
     XL.StringCells[ltData.Y+112,2] := 'Затраты в простое'+ACostsSuffix;
     XL.StringCells[ltData.Y+113,2] := ' - электроэнергия';
     XL.StringCells[ltData.Y+114,2] := ' - материалы';
     XL.StringCells[ltData.Y+115,2] := ' - неучтенные расходы';
     XL.StringCells[ltData.Y+116,2] := ' - зарплата';
     XL.StringCells[ltData.Y+117,2] := 'Амортизационные отчисления'+ACostsSuffix;
     XL.StringCells[ltData.Y+118,2] := 'Суммарные затраты'+ACostsSuffix;
     XL.StringCells[ltData.Y+119,2] := 'Количественные показатели блок-участков автотрассы';
     XL.Cells      [ltData.Y+119,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+120,2] := 'Количество блок-участков';
     XL.StringCells[ltData.Y+121,2] := 'Длина блок-участков, м';
     XL.StringCells[ltData.Y+122,2] := 'Стоимостные показатели блок-участков';
     XL.Cells      [ltData.Y+122,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+123,2] := 'Затраты на содержание'+ACostsSuffix;
     XL.StringCells[ltData.Y+124,2] := 'Амортизационные отчисления'+ACostsSuffix;
     XL.StringCells[ltData.Y+125,2] := 'Суммарные затраты'+ACostsSuffix;
     XL.StringCells[ltData.Y+126,2] := 'Экономические показатели по горно-транспортному комплексу';
     XL.Cells      [ltData.Y+126,2,1,1].Font.Style := [xlfsBold];
     XL.StringCells[ltData.Y+127,2] := 'Затраты по горно-транспортному комплексу'+ACostsSuffix;
     XL.StringCells[ltData.Y+128,2] := ' - Эксплутационные затраты';
     XL.StringCells[ltData.Y+129,2] := ' - Амортизационные отчисления';
     XL.StringCells[ltData.Y+130,2] := ' - Постоянные и неучтенные расходы';
     XL.StringCells[ltData.Y+131,2] := 'Производительность комплекса по горной массе, м3';
     XL.StringCells[ltData.Y+132,2] := 'Производительность комплекса по горной массе, т';
     XL.StringCells[ltData.Y+133,2] := 'Производительность комплекса по горной массе (период), тыс.м3';
     XL.StringCells[ltData.Y+134,2] := 'Производительность комплекса по горной массе (период), тыс.т';
     XL.StringCells[ltData.Y+135,2] := 'Удельные эксплуатационные затраты'+ACostsSuffix+'/м3';
     XL.StringCells[ltData.Y+136,2] := 'Удельные эксплуатационные затраты'+ACostsSuffix+'/т';
     XL.StringCells[ltData.Y+137,2] := 'Удельные амортизационные затраты'+ACostsSuffix+'/м3';
     XL.StringCells[ltData.Y+138,2] := 'Удельные амортизационные затраты'+ACostsSuffix+'/т';
     XL.StringCells[ltData.Y+139,2] := 'Удельные текущие затраты'+ACostsSuffix+'/м3';
     XL.StringCells[ltData.Y+140,2] := 'Удельные текущие затраты'+ACostsSuffix+'/т';
     //OX
     whData.X := 0;
     AOptimalCol := 0;
     AOptimalValue := 0.0;
     APriorPlan := 0.0;
     quVariants.First;
     while not quVariants.Eof do
     begin
       if quVariantsIsPrint.AsBoolean then
       begin            
         Inc(whData.X);
         if pmiExcelParamsDollar.Checked and (quVariantsDollarCtg.AsFloat>0.0)
         then ACostsCoef := esaDrob(1.0,quVariantsDollarCtg.AsFloat)
         else ACostsCoef := 1.0;
         XL.IntegerCells[ltData.Y+  1,ltData.X-1+whData.X] := whData.X;
         XL.StringCells [ltData.Y+  2,ltData.X-1+whData.X] := quVariantsVariant.AsString;
         XL.StringCells [ltData.Y+  3,ltData.X-1+whData.X] := quVariantsVariantDate.AsString;

         XL.FloatCells  [ltData.Y+  5,ltData.X-1+whData.X] := quVariantsDollarCtg.AsFloat;

         XL.FloatCells  [ltData.Y+  7,ltData.X-1+whData.X] := quVariantsShiftTmin.AsFloat;
         XL.FloatCells  [ltData.Y+  8,ltData.X-1+whData.X] := quVariantsShiftNaryadTmin.AsFloat;
         XL.FloatCells  [ltData.Y+  9,ltData.X-1+whData.X] := quVariantsShiftTurnoverTmin.AsFloat;
         XL.FloatCells  [ltData.Y+ 10,ltData.X-1+whData.X] := quVariantsShiftNaryadFactTmin.AsFloat;
         XL.FloatCells  [ltData.Y+ 11,ltData.X-1+whData.X] := quVariantsShiftKweek.AsFloat;

         XL.FloatCells  [ltData.Y+ 13,ltData.X-1+whData.X] := quVariantsPeriodTday.AsFloat;
         XL.FloatCells  [ltData.Y+ 14,ltData.X-1+whData.X] := quVariantsPeriodKshift.AsFloat;

         XL.StringCells [ltData.Y+ 16,ltData.X-1+whData.X] := quVariantsAutos.AsString;
         XL.StringCells [ltData.Y+ 17,ltData.X-1+whData.X] := quVariantsAutosAutosCount.AsString;
         XL.FloatCells  [ltData.Y+ 18,ltData.X-1+whData.X] := quVariantsAutosTripsCountNulled.AsFloat+quVariantsAutosTripsCountLoading.AsFloat+quVariantsAutosTripsCountUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 19,ltData.X-1+whData.X] := quVariantsAutosTripsCountNulled.AsFloat;
         XL.FloatCells  [ltData.Y+ 20,ltData.X-1+whData.X] := quVariantsAutosTripsCountLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 21,ltData.X-1+whData.X] := quVariantsAutosTripsCountUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 22,ltData.X-1+whData.X] := quVariantsAutosRockVm3.AsFloat;
         XL.FloatCells  [ltData.Y+ 23,ltData.X-1+whData.X] := quVariantsAutosRockQtn.AsFloat;
         XL.FloatCells  [ltData.Y+ 24,ltData.X-1+whData.X] := quVariantsAutosSkm.AsFloat;
         XL.FloatCells  [ltData.Y+ 25,ltData.X-1+whData.X] := quVariantsAutosSkmNulled.AsFloat;
         XL.FloatCells  [ltData.Y+ 26,ltData.X-1+whData.X] := quVariantsAutosSkmLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 27,ltData.X-1+whData.X] := quVariantsAutosSkmUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 28,ltData.X-1+whData.X] := quVariantsAutosSkmLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 29,ltData.X-1+whData.X] := quVariantsAutosLoadingWAvgSkm.AsFloat;
         XL.FloatCells  [ltData.Y+ 30,ltData.X-1+whData.X] := quVariantsAutosLoadingAvgSkm.AsFloat;
         XL.FloatCells  [ltData.Y+ 31,ltData.X-1+whData.X] := quVariantsAutosShiftAvgSkm.AsFloat;
         XL.FloatCells  [ltData.Y+ 32,ltData.X-1+whData.X] := quVariantsAutosShiftAvgSkm_reis.AsFloat;
         XL.FloatCells  [ltData.Y+ 33,ltData.X-1+whData.X] := quVariantsAutosWAvgHm.AsFloat;
         XL.FloatCells  [ltData.Y+ 34,ltData.X-1+whData.X] := (quVariantsAutosAvgVkmhNulled.AsFloat+quVariantsAutosAvgVkmhLoading.AsFloat+quVariantsAutosAvgVkmhUnLoading.AsFloat)/3;
         XL.FloatCells  [ltData.Y+ 35,ltData.X-1+whData.X] := quVariantsAutosAvgVkmhNulled.AsFloat;
         XL.FloatCells  [ltData.Y+ 36,ltData.X-1+whData.X] := quVariantsAutosAvgVkmhLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 37,ltData.X-1+whData.X] := quVariantsAutosAvgVkmhUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 38,ltData.X-1+whData.X] := quVariantsAutosAvgTechVkmh.AsFloat;

         XL.FloatCells  [ltData.Y+ 40,ltData.X-1+whData.X] := quVariantsAutosGx.AsFloat;
         XL.FloatCells  [ltData.Y+ 41,ltData.X-1+whData.X] := quVariantsAutosGxWork.AsFloat;
         XL.FloatCells  [ltData.Y+ 42,ltData.X-1+whData.X] := quVariantsAutosGxWaiting.AsFloat;
         XL.FloatCells  [ltData.Y+ 43,ltData.X-1+whData.X] := quVariantsAutosDirGx.AsFloat;
         XL.FloatCells  [ltData.Y+ 44,ltData.X-1+whData.X] := quVariantsAutosGxNulled.AsFloat;
         XL.FloatCells  [ltData.Y+ 45,ltData.X-1+whData.X] := quVariantsAutosGxLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 46,ltData.X-1+whData.X] := quVariantsAutosGxUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 47,ltData.X-1+whData.X] := quVariantsAutosUdGx_gr_tkm.AsFloat;
         XL.FloatCells  [ltData.Y+ 48,ltData.X-1+whData.X] := quVariantsAutosGxCtg.AsFloat*ACostsCoef;

         XL.FloatCells  [ltData.Y+ 50,ltData.X-1+whData.X] := quVariantsAutosTyresCount.AsFloat;
         XL.FloatCells  [ltData.Y+ 51,ltData.X-1+whData.X] := quVariantsAutosTyresSkm.AsFloat;
         XL.FloatCells  [ltData.Y+ 52,ltData.X-1+whData.X] := quVariantsAutosUsedTyresCount.AsFloat;
         XL.FloatCells  [ltData.Y+ 53,ltData.X-1+whData.X] := quVariantsAutosTyresCtg.AsFloat*ACostsCoef;

         XL.FloatCells  [ltData.Y+ 55,ltData.X-1+whData.X] := quVariantsAutosTmin.AsFloat;
         XL.FloatCells  [ltData.Y+ 56,ltData.X-1+whData.X] := quVariantsAutosTminMoving.AsFloat;
         XL.FloatCells  [ltData.Y+ 57,ltData.X-1+whData.X] := quVariantsAutosTminWaiting.AsFloat;
         XL.FloatCells  [ltData.Y+ 58,ltData.X-1+whData.X] := quVariantsAutosTminManevr.AsFloat;
         XL.FloatCells  [ltData.Y+ 59,ltData.X-1+whData.X] := quVariantsAutosTminOnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 60,ltData.X-1+whData.X] := quVariantsAutosTminOnUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 61,ltData.X-1+whData.X] := quVariantsAutosDirTmin.AsFloat;
         XL.FloatCells  [ltData.Y+ 62,ltData.X-1+whData.X] := quVariantsAutosTminNulled.AsFloat;
         XL.FloatCells  [ltData.Y+ 63,ltData.X-1+whData.X] := quVariantsAutosTminLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 64,ltData.X-1+whData.X] := quVariantsAutosTminUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 65,ltData.X-1+whData.X] := (quVariantsAutosReysAvgTminNulled.AsFloat+quVariantsAutosReysAvgTminLoading.AsFloat+quVariantsAutosReysAvgTminUnLoading.AsFloat)/3;
         XL.FloatCells  [ltData.Y+ 66,ltData.X-1+whData.X] := quVariantsAutosReysAvgTminNulled.AsFloat;
         XL.FloatCells  [ltData.Y+ 67,ltData.X-1+whData.X] := quVariantsAutosReysAvgTminLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 68,ltData.X-1+whData.X] := quVariantsAutosReysAvgTminUnLoading.AsFloat;
         XL.FloatCells  [ltData.Y+ 69,ltData.X-1+whData.X] := quVariantsAutosAvgTimeUsingCoef.AsFloat;

         XL.FloatCells  [ltData.Y+ 71,ltData.X-1+whData.X] := quVariantsAutosWorkCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 72,ltData.X-1+whData.X] := quVariantsAutosWorkSumGxCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 73,ltData.X-1+whData.X] := quVariantsAutosWorkSumTyresCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 74,ltData.X-1+whData.X] := quVariantsAutosWorkSparesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 75,ltData.X-1+whData.X] := quVariantsAutosWorkMaterialsCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 76,ltData.X-1+whData.X] := quVariantsAutosWorkMaintenancesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 77,ltData.X-1+whData.X] := quVariantsAutosWorkSalariesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 78,ltData.X-1+whData.X] := quVariantsAutosWaitingCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 79,ltData.X-1+whData.X] := quVariantsAutosWaitingSumGxCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 80,ltData.X-1+whData.X] := quVariantsAutosWaitingSparesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 81,ltData.X-1+whData.X] := quVariantsAutosWaitingMaterialsCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 82,ltData.X-1+whData.X] := quVariantsAutosWaitingMaintenancesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 83,ltData.X-1+whData.X] := quVariantsAutosWaitingSalariesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 84,ltData.X-1+whData.X] := quVariantsAutosAmortizationCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+ 85,ltData.X-1+whData.X] := quVariantsAutosCtg.AsFloat*ACostsCoef;

         XL.StringCells [ltData.Y+ 87,ltData.X-1+whData.X] := quVariantsExcavators.AsString;
         XL.StringCells [ltData.Y+ 88,ltData.X-1+whData.X] := quVariantsExcavatorsExcavatorsCount.AsString;
         XL.FloatCells  [ltData.Y+ 89,ltData.X-1+whData.X] := quVariantsExcavatorsAutosCount.AsFloat;
         XL.FloatCells  [ltData.Y+ 90,ltData.X-1+whData.X] := quVariantsExcavatorsRockVm3.AsFloat;
         XL.FloatCells  [ltData.Y+ 91,ltData.X-1+whData.X] := quVariantsExcavatorsRockQtn.AsFloat;
         XL.FloatCells  [ltData.Y+ 92,ltData.X-1+whData.X] := quVariantsExcavatorsPlanRockVm3.AsFloat;
         XL.FloatCells  [ltData.Y+ 93,ltData.X-1+whData.X] := quVariantsExcavatorsPlanRockQtn.AsFloat;
         XL.FloatCells  [ltData.Y+ 94,ltData.X-1+whData.X] := quVariantsExcavatorsRockRatio.AsFloat;

         if (whData.X>0)and(APriorPlan<100.0)and(quVariantsExcavatorsRockRatio.AsFloat>=100.0)
         then XL.Cells  [ltData.Y+ 94,ltData.X-1+whData.X,1,1].SetColor(4);

         APriorPlan := quVariantsExcavatorsRockRatio.AsFloat;
         XL.FloatCells  [ltData.Y+ 96,ltData.X-1+whData.X] := quVariantsExcavatorsGx.AsFloat;
         XL.FloatCells  [ltData.Y+ 97,ltData.X-1+whData.X] := quVariantsExcavatorsGxWork.AsFloat;
         XL.FloatCells  [ltData.Y+ 98,ltData.X-1+whData.X] := quVariantsExcavatorsGxWaiting.AsFloat;

         XL.FloatCells  [ltData.Y+100,ltData.X-1+whData.X] := quVariantsExcavatorsTmin.AsFloat;
         XL.FloatCells  [ltData.Y+101,ltData.X-1+whData.X] := quVariantsExcavatorsTminWork.AsFloat;
         XL.FloatCells  [ltData.Y+102,ltData.X-1+whData.X] := quVariantsExcavatorsTminWaiting.AsFloat;
         XL.FloatCells  [ltData.Y+103,ltData.X-1+whData.X] := quVariantsExcavatorsTminManevr.AsFloat;
         XL.FloatCells  [ltData.Y+104,ltData.X-1+whData.X] := quVariantsExcavatorsUsingPunktCoef.AsFloat;
         XL.FloatCells  [ltData.Y+105,ltData.X-1+whData.X] := quVariantsExcavatorsUsingTimeCoef.AsFloat;

         XL.FloatCells  [ltData.Y+107,ltData.X-1+whData.X] := quVariantsExcavatorsWorkCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+108,ltData.X-1+whData.X] := quVariantsExcavatorsWorkSumGxCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+109,ltData.X-1+whData.X] := quVariantsExcavatorsWorkMaterialsCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+110,ltData.X-1+whData.X] := quVariantsExcavatorsWorkUnAccountedCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+111,ltData.X-1+whData.X] := quVariantsExcavatorsWorkSalariesCtg.AsFloat*ACostsCoef;

         XL.FloatCells  [ltData.Y+112,ltData.X-1+whData.X] := quVariantsExcavatorsWaitingCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+113,ltData.X-1+whData.X] := quVariantsExcavatorsWaitingSumGxCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+114,ltData.X-1+whData.X] := quVariantsExcavatorsWaitingMaterialsCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+115,ltData.X-1+whData.X] := quVariantsExcavatorsWaitingUnAccountedCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+116,ltData.X-1+whData.X] := quVariantsExcavatorsWaitingSalariesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+117,ltData.X-1+whData.X] := quVariantsExcavatorsAmortizationCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+118,ltData.X-1+whData.X] := quVariantsExcavatorsCtg.AsFloat*ACostsCoef;

         XL.FloatCells  [ltData.Y+120,ltData.X-1+whData.X] := quVariantsBlocksBlocksCount.AsFloat;
         XL.FloatCells  [ltData.Y+121,ltData.X-1+whData.X] := quVariantsBlocksLm.AsFloat;

         XL.FloatCells  [ltData.Y+123,ltData.X-1+whData.X] := quVariantsBlocksRepairCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+124,ltData.X-1+whData.X] := quVariantsBlocksAmortizationCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+125,ltData.X-1+whData.X] := quVariantsBlocksCtg.AsFloat*ACostsCoef;

         XL.FloatCells  [ltData.Y+127,ltData.X-1+whData.X] := quVariantsEconomCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+128,ltData.X-1+whData.X] := quVariantsEconomExploatationCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+129,ltData.X-1+whData.X] := quVariantsEconomAmortizationCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+130,ltData.X-1+whData.X] := quVariantsEconomExpensesCtg.AsFloat*ACostsCoef;
         XL.FloatCells  [ltData.Y+131,ltData.X-1+whData.X] := quVariantsExcavatorsRockVm3.AsFloat;
         XL.FloatCells  [ltData.Y+132,ltData.X-1+whData.X] := quVariantsExcavatorsRockQtn.AsFloat;
         XL.FloatCells  [ltData.Y+133,ltData.X-1+whData.X] := 0.001*quVariantsExcavatorsRockVm3.AsFloat*quVariantsPeriodKshift.AsFloat;
         XL.FloatCells  [ltData.Y+134,ltData.X-1+whData.X] := 0.001*quVariantsExcavatorsRockQtn.AsFloat*quVariantsPeriodKshift.AsFloat;
         XL.FloatCells  [ltData.Y+135,ltData.X-1+whData.X] := esaDrob(ACostsCoef*(quVariantsAutosWorkCtg.AsFloat+quVariantsAutosWaitingCtg.AsFloat+quVariantsExcavatorsWorkCtg.AsFloat+quVariantsExcavatorsWaitingCtg.AsFloat+quVariantsBlocksRepairCtg.AsFloat),quVariantsExcavatorsRockVm3.AsFloat);
         XL.FloatCells  [ltData.Y+136,ltData.X-1+whData.X] := esaDrob(ACostsCoef*(quVariantsAutosWorkCtg.AsFloat+quVariantsAutosWaitingCtg.AsFloat+quVariantsExcavatorsWorkCtg.AsFloat+quVariantsExcavatorsWaitingCtg.AsFloat+quVariantsBlocksRepairCtg.AsFloat),quVariantsExcavatorsRockQtn.AsFloat);
         XL.FloatCells  [ltData.Y+137,ltData.X-1+whData.X] := esaDrob(ACostsCoef*(quVariantsAutosAmortizationCtg.AsFloat+quVariantsExcavatorsAmortizationCtg.AsFloat+quVariantsBlocksAmortizationCtg.AsFloat),quVariantsExcavatorsRockVm3.AsFloat);
         XL.FloatCells  [ltData.Y+138,ltData.X-1+whData.X] := esaDrob(ACostsCoef*(quVariantsAutosAmortizationCtg.AsFloat+quVariantsExcavatorsAmortizationCtg.AsFloat+quVariantsBlocksAmortizationCtg.AsFloat),quVariantsExcavatorsRockQtn.AsFloat);
         XL.FloatCells  [ltData.Y+139,ltData.X-1+whData.X] := esaDrob(ACostsCoef*(quVariantsEconomExpensesCtg.AsFloat+quVariantsAutosWorkCtg.AsFloat+quVariantsAutosWaitingCtg.AsFloat+quVariantsExcavatorsWorkCtg.AsFloat+quVariantsExcavatorsWaitingCtg.AsFloat+quVariantsBlocksRepairCtg.AsFloat+quVariantsAutosAmortizationCtg.AsFloat+quVariantsExcavatorsAmortizationCtg.AsFloat+quVariantsBlocksAmortizationCtg.AsFloat),quVariantsExcavatorsRockVm3.AsFloat);
         AOptimalTemp := esaDrob(ACostsCoef*(quVariantsEconomExpensesCtg.AsFloat+quVariantsAutosWorkCtg.AsFloat+quVariantsAutosWaitingCtg.AsFloat+quVariantsExcavatorsWorkCtg.AsFloat+quVariantsExcavatorsWaitingCtg.AsFloat+quVariantsBlocksRepairCtg.AsFloat+quVariantsAutosAmortizationCtg.AsFloat+quVariantsExcavatorsAmortizationCtg.AsFloat+quVariantsBlocksAmortizationCtg.AsFloat),quVariantsExcavatorsRockQtn.AsFloat);
         XL.FloatCells  [ltData.Y+140,ltData.X-1+whData.X] := AOptimalTemp;
         if (AOptimalCol=0)OR((AOptimalCol>0)and(AOptimalTemp<AOptimalValue)) then
         begin
           AOptimalCol := ltData.X-1+whData.X;
           AOptimalValue := AOptimalTemp;
         end;{if}
       end;{if}
       quVariants.Next;
     end;{while}
     whData.X := Max(1,whData.X);
     //Optimal
     if AOptimalCol>0 then
     begin
       XL.Cells[ltData.Y+  1,AOptimalCol,1, 3].SetColor(6);
       XL.Cells[ltData.Y+  5,AOptimalCol,1, 1].SetColor(6);
       XL.Cells[ltData.Y+  7,AOptimalCol,1, 5].SetColor(6);
       XL.Cells[ltData.Y+ 13,AOptimalCol,1, 2].SetColor(6);
       XL.Cells[ltData.Y+ 16,AOptimalCol,1,23].SetColor(6);
       XL.Cells[ltData.Y+ 40,AOptimalCol,1, 9].SetColor(6);
       XL.Cells[ltData.Y+ 50,AOptimalCol,1, 4].SetColor(6);
       XL.Cells[ltData.Y+ 55,AOptimalCol,1,15].SetColor(6);
       XL.Cells[ltData.Y+ 71,AOptimalCol,1,15].SetColor(6);
       XL.Cells[ltData.Y+ 87,AOptimalCol,1, 8].SetColor(6);
       XL.Cells[ltData.Y+ 96,AOptimalCol,1, 3].SetColor(6);
       XL.Cells[ltData.Y+100,AOptimalCol,1, 6].SetColor(6);
       XL.Cells[ltData.Y+107,AOptimalCol,1, 5].SetColor(6);
       XL.Cells[ltData.Y+112,AOptimalCol,1, 7].SetColor(6);
       XL.Cells[ltData.Y+120,AOptimalCol,1, 2].SetColor(6);
       XL.Cells[ltData.Y+123,AOptimalCol,1, 3].SetColor(6);
       XL.Cells[ltData.Y+127,AOptimalCol,1,14].SetColor(6);
     end;{if}
     //OY шкала
     for I := 1 to whData.Y do
       XL.IntegerCells[ltData.Y-1+I,1] := I;
     //OX шкала
     for I := 1 to ltData.X-1+whData.X do
       XL.IntegerCells[ltData.Y-1,I] := I;
     //Ширина
     XL.ColumnWidths[1,1]               :=  4.0;
     XL.ColumnWidths[2,1]               := 50.0;
     XL.ColumnWidths[ltData.X,whData.X] := 10.0;
     //Number Format
     XL.Cells[ltData.Y+  0,ltData.X,whData.X, 2].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+  2,ltData.X,whData.X, whData.Y].CustomNumberFormat      := fFloat00;
     XL.Cells[ltData.Y+  7,ltData.X,whData.X, 3].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+ 13,ltData.X,whData.X, 1].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+ 17,ltData.X,whData.X, 5].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+ 50,ltData.X,whData.X, 1].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+ 88,ltData.X,whData.X, 2].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+120,ltData.X,whData.X, 1].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+123,ltData.X,whData.X, 2].CustomNumberFormat             := fInt;
     XL.Cells[ltData.Y+139,ltData.X,whData.X, 2].CustomNumberFormat             := fFloat0000;
     //Frame
     XL.Cells[ltHeader.Y,ltHeader.X,ltData.X-1+whData.X,hHeader+whData.Y].Frame := [feTotal];
     //FreezePanes
     XL.Cells[ltData.Y+ 17,ltData.X,1,1].SetFreezePanes();
     //Merge Cells
     XL.Cells[1,1,ltData.X-1+whData.X,1].MergeCells      := True;
     XL.Cells[ltHeader.Y,ltData.X,whData.X,1].MergeCells := True;
     XL.Cells[ltData.Y+  0,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+  4,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+  6,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 12,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 15,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 39,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 49,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 54,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 70,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 86,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 95,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+ 99,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+106,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+119,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+122,2,1+whData.X,1].MergeCells    := True;
     XL.Cells[ltData.Y+126,2,1+whData.X,1].MergeCells    := True;
     //WrapText
     XL.Cells[ltData.Y+ 2,ltData.X,whData.X,2].WrapText  := True;
     XL.Cells[ltData.Y+16,ltData.X,whData.X,1].WrapText  := True;
     XL.Cells[ltData.Y+87,ltData.X,whData.X,1].WrapText  := True;
     //Center
     XL.Cells[ltHeader.Y,ltHeader.X,2+whData.X,hHeader].HorizontalAlignment := haCenter;
     //Параметры страницы
     XL.ActiveSheetPageSetup(10,10,10,10,5,5,poLandscape);
     //Выделить
     XL.Cells[1,1,ltData.X-1+whData.X,hHeader+whData.Y+1].SelectAndCopyToClipBoard;
     //Final
     XL.Zoom := 100;
     AWord := CreateOleObject('Word.Application');
     try
       AWord.Visible := True;
       AWord.Documents.Add();
       ASheet := AWord.Selection;
       ASheet.Font.Size := 8;
       ASheet.Font.Name := 'Times New Roman';
       ASheet.Paste;
       ASheet.MoveLeft(Unit:=wdCharacter, Count:=1);
       ASheet.Tables.Item(1).Rows.Alignment := wdAlignRowCenter;
       ASheet.Tables.Item(1).PreferredWidthType := wdPreferredWidthPoints;
//       ASheet.Tables.Item(1).PreferredWidth := AWord.Application.InchesToPoints(InchPerMillimetr*165);
//       ASheet.Tables.Item(1).PreferredWidth := AWord.CentimetersToPoints(16.5);
       ASheet.WholeStory;
       ASheet.Font.Size := 8;
       ASheet.Font.Name := 'Times New Roman';
       AWord.ActiveDocument.PageSetup.Orientation := wdOrientPortrait;
//       AWord.ActiveDocument.PageSetup.TopMargin := AWord.CentimetersToPoints(2);
//       AWord.ActiveDocument.PageSetup.BottomMargin := AWord.CentimetersToPoints(2);
//       AWord.ActiveDocument.PageSetup.LeftMargin := AWord.CentimetersToPoints(3);
//       AWord.ActiveDocument.PageSetup.RightMargin := AWord.CentimetersToPoints(1.5);
//       AWord.ActiveDocument.PageSetup.Gutter := AWord.CentimetersToPoints(0);
//       AWord.ActiveDocument.PageSetup.HeaderDistance := AWord.CentimetersToPoints(1.25);
//       AWord.ActiveDocument.PageSetup.FooterDistance := AWord.CentimetersToPoints(1.25);
     finally
       AWord.Quit;
     end;{try}
    finally
      XL.Free;
    end;{try}
    quVariants.Locate('Id_ResultVariant',AId_ResultVariant,[]);
  end;{if}
end;{pmiExcelClick}
procedure TfmVariants.pmiGraphicsClick(Sender: TObject);
begin                            
  esaShowVariantGraphicsDlg(DoVariantsCalcFields)
end;{pmiGraphicsClick}

procedure TfmVariants.PopupMenuPopup(Sender: TObject);
begin
  pmiMark.Enabled         := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiUnMark.Enabled       := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiMarkAll.Enabled      := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiUnMarkAll.Enabled    := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiSelectAll.Enabled    := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiUnSelectAll.Enabled  := (quVariants.Active)and(quVariants.RecordCount>0)and
                               (dbgVariants.SelectedRows.Count>0);
  pmiDelete.Enabled         := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiMoveUp.Enabled         := (quVariants.Active)and(quVariants.RecordCount>0)and(quVariants.RecNo>1);
  pmiMoveDown.Enabled       := (quVariants.Active)and(quVariants.RecordCount>0)and(quVariants.RecNo<quVariants.RecordCount);
  pmiExcel.Enabled          := (quVariants.Active)and(quVariants.RecordCount>0);
  pmiGraphics.Enabled       := (quVariants.Active);
end;{PopupMenuPopup}




procedure TfmVariants.dsVaraintsDataChange(Sender: TObject; Field: TField);
begin
  if quVariants.Active
  then dbgVariants.Columns[0].Footers[0].Value := Format('%d/%d',[quVariants.RecNo,quVariants.RecordCount])
  else dbgVariants.Columns[0].Footers[0].Value := '';
end;{dsVaraintsDataChange}

procedure TfmVariants.dbgVariantsDrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
begin
  (Sender As TDBGridEh).DefaultDrawFooterCell(Rect, DataCol, Row, Column, State);
end;{dbgVariantsDrawFooterCell}


procedure TfmVariants.TabControlChange(Sender: TObject);
begin
  dbgVariants.SelectedRows.Clear;
  quVariants.Close;
  case TabControl.TabIndex of
    1:   quVariants.SQL.Text := 'SELECT * FROM _ResultVariants WHERE IsPrint=TRUE ORDER BY SortIndex';
    2:   quVariants.SQL.Text := 'SELECT * FROM _ResultVariants WHERE IsPrint=FALSE ORDER BY SortIndex';
    else quVariants.SQL.Text := 'SELECT * FROM _ResultVariants ORDER BY SortIndex';
  end;{case}
  quVariants.Open;
end;{TabControlChange}






procedure TfmVariants.dbgVariantsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  holdColor: TColor;
begin
  holdColor := dbgVariants.Canvas.Brush.Color; {сохраняем оригинальный цвет}
  if dbgVariants.DataSource.DataSet.FieldByName('IsBaseVariant').AsBoolean = TRUE then
    begin
      dbgVariants.Canvas.Font.Color := clBlack;
      dbgVariants.Canvas.Brush.Color := clYellow;
      dbgVariants.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      dbgVariants.Canvas.Brush.Color := holdColor;
    end;
end;

procedure TfmVariants.btnCopyfromBaseClick(Sender: TObject);
begin
    quVariants.Edit;
    quVariantsProductPriceCtg.AsFloat:= NEEBaseInput.ProductPriceCtg;
    quVariantsProductOutPutPercent.AsFloat:=NEEBaseInput.ProductOutPutPercent ;
    quVariantsMTWorkByScheduleCtg.AsFloat:=NEEBaseInput.MTWorkByScheduleCtg ;
    quVariantsTruckCostCtg.AsFloat:=NEEBaseInput.TruckCostCtg ;
    quVariantsServiceExpensesCtg.AsFloat:= NEEBaseInput.ServiceExpensesCtg;
    quVariantsBaseVariantExpenesCtg.AsFloat:=NEEBaseInput.BaseVariantExpenesCtg ; 
    quVariants.Post;
end;



procedure TfmVariants.sbShowHiddenClick(Sender: TObject);
begin
  ShowHidden:= not ShowHidden;

  if    ShowHidden then
  begin
     sbShowHidden.Caption:= '+' ;
     gbAdditinal.Visible:=True;
  end
  else
  begin
    sbShowHidden.Caption:= '-' ;
    gbAdditinal.Visible:=False;
  end
end;

procedure TfmVariants.FormToShow;
begin
  grbToExcel.Caption:= TOEXCEL;
  grbToGraph.Caption:= TOGRAPH;
  btnToExcel.Caption:= TOOPEN;
  btnToGraph.Caption:= TOOPEN;
end;

procedure TfmVariants.btnToExcelClick(Sender: TObject);
begin
  pmiExcelClick(Sender);
end;

procedure TfmVariants.btnToGraphClick(Sender: TObject);
begin
  pmiGraphicsClick(Sender);
end;

end.
