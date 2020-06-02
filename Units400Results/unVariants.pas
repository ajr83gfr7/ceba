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
  DBCtrls, Menus, DBCtrlsEh, DBGrids, Buttons,//, GridsEh;
  TXTWriter,
  EconomicModule;

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
    //quVariantsPlannedRockVolumeCm: TFloatField;
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
    quVariantsPlannedRockVolumeCm: TFloatField;
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
  private
    _economics: TResultVariants;
    // Результаты вариантов
//    _ResultVariants:
    // Открыть результаты вариантов
//    procedure OpenVariants();
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
    procedure SetView;
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

uses esaGlobals, ExcelEditors, Printers, Math, unVariantGraphics, IniFiles,
  ComObj, Office2000, Word2000, unDM,
  unResultEconomEffect_Const;

{$R *.dfm}
//Диалоговое окно вариантов моделирования
procedure esaShowVariantsDlg();
begin
  fmVariants := TfmVariants.Create(nil);
  try
    fmVariants.ShowModal;
  finally
    fmVariants.Free;
  end;
end;

procedure TfmVariants.NEESaveToLocal();
begin
  if   quVariants.Locate('IsBaseVariant',TRUE, []) then
  begin
    Base_Var_Id_ResultVariant:= quVariantsId_ResultVariant.AsInteger;
    BaseUsEco:= quVariantsNomEconomicEffectCtg.AsFloat;
    redNomBaseVariantCtg.Lines[0]:= Format('%4.3f', [BaseUsEco]);
    NEEBaseInput.ProductPriceCtg:= quVariantsProductPriceCtg.AsFloat;
    NEEBaseInput.ProductOutPutPercent:= quVariantsProductOutPutPercent.AsFloat;
    NEEBaseInput.MTWorkByScheduleCtg:= quVariantsMTWorkByScheduleCtg.AsFloat;
    NEEBaseInput.TruckCostCtg:= quVariantsTruckCostCtg.AsFloat;
    NEEBaseInput.ServiceExpensesCtg:= quVariantsServiceExpensesCtg.AsFloat;
    NEEBaseInput.BaseVariantExpenesCtg:=quVariantsBaseVariantExpenesCtg.AsFloat;
  end
  else
    Base_Var_Id_ResultVariant:= 1;
end;

procedure TfmVariants.FormCreate(Sender: TObject);
begin
  TabControl.TabIndex          := 0;
  PageControl.ActivePageIndex  := 0;
  pcAutos.ActivePageIndex      := 0;
  pcExcavators.ActivePageIndex := 0;
  pcBlocks.ActivePageIndex     := 0;
  quVariants.OnCalcFields      := DoVariantsCalcFields;
  quVariants.Close;
  quVariants.Open;

  // todo: vars | создание _economics
  //_economics:= TResultVariants.Create();
  //_economics.CurrentVariantId:= dbgVariants.DataSource.DataSet.FieldValues['Id_ResultVariant'];

  NEESaveToLocal();
  quVariants.Last;
  with TIniFile.Create(IniFileName) do
  try
    pmiExcelParamsDollar.Checked            := ReadBool('Отчеты','InDollar',pmiExcelParamsDollar.Checked);
    pmiExcelParamsThousandSeparator.Checked := ReadBool('Отчеты','ThousandSeparator',pmiExcelParamsThousandSeparator.Checked);
  finally
    Free;
  end;
end;

procedure TfmVariants.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quVariants.Close;
end;

procedure TfmVariants.DoVariantsCalcFields(DataSet: TDataSet);
var
  _idResultVariant: integer;
begin
  _economics:= TResultVariants.Create();
  _economics.CurrentVariantId:= dbgVariants.DataSource.DataSet.FieldValues['Id_ResultVariant'];

  //_idResultVariant:= dbgVariants.DataSource.DataSet.FieldValues['Id_ResultVariant'];

  with DataSet do
  begin
    //Shift
    FieldByName('ShiftNaryadTmin').AsFloat:= FieldByName('ShiftTmin').AsFloat -
                                             FieldByName('ShiftTurnoverTmin').AsFloat;
    //Auto S,km
    FieldByName('AutosSkm').AsFloat:= FieldByName('AutosSkmNulled').AsFloat +
                                      FieldByName('AutosSkmLoading').AsFloat +
                                      FieldByName('AutosSkmUnLoading').AsFloat;
    //Auto Gx,l
    FieldByName('AutosGx').AsFloat:= FieldByName('AutosGxWork').AsFloat +
                                     FieldByName('AutosGxWaiting').AsFloat;
    //
    FieldByName('AutosDirGx').AsFloat:= FieldByName('AutosGxNulled').AsFloat +
                                        FieldByName('AutosGxLoading').AsFloat +
                                        FieldByName('AutosGxUnLoading').AsFloat;
    //Auto T,min
    FieldByName('AutosTmin').AsFloat:= FieldByName('AutosTminMoving').AsFloat +
                                       FieldByName('AutosTminWaiting').AsFloat +
                                       FieldByName('AutosTminManevr').AsFloat +
                                       FieldByName('AutosTminOnLoading').AsFloat +
                                       FieldByName('AutosTminOnUnLoading').AsFloat;
    //
    FieldByName('AutosDirTmin').AsFloat:= FieldByName('AutosTminNulled').AsFloat +
                                          FieldByName('AutosTminLoading').AsFloat +
                                          FieldByName('AutosTminUnLoading').AsFloat;
    //Auto C,tg
    FieldByName('AutosWorkCtg').AsFloat:= FieldByName('AutosWorkSumGxCtg').AsFloat +
                                          FieldByName('AutosWorkSumTyresCtg').AsFloat +
                                          FieldByName('AutosWorkSparesCtg').AsFloat +
                                          FieldByName('AutosWorkMaterialsCtg').AsFloat +
                                          FieldByName('AutosWorkMaintenancesCtg').AsFloat +
                                          FieldByName('AutosWorkSalariesCtg').AsFloat;
    //
    FieldByName('AutosWaitingCtg').AsFloat:= FieldByName('AutosWaitingSumGxCtg').AsFloat +
                                             FieldByName('AutosWaitingSparesCtg').AsFloat +
                                             FieldByName('AutosWaitingMaterialsCtg').AsFloat +
                                             FieldByName('AutosWaitingMaintenancesCtg').AsFloat +
                                             FieldByName('AutosWaitingSalariesCtg').AsFloat;
    //
    FieldByName('AutosCtg').AsFloat:= FieldByName('AutosWorkCtg').AsFloat +
                                      FieldByName('AutosWaitingCtg').AsFloat +
                                      FieldByName('AutosAmortizationCtg').AsFloat;
    //-----------
    //Excavator Gx,l
    FieldByName('ExcavatorsGx').AsFloat:= FieldByName('ExcavatorsGxWork').AsFloat +
                                          FieldByName('ExcavatorsGxWaiting').AsFloat;
    //Excavator T,min
    FieldByName('ExcavatorsTmin').AsFloat:= FieldByName('ExcavatorsTminWork').AsFloat +
                                            FieldByName('ExcavatorsTminWaiting').AsFloat +
                                            FieldByName('ExcavatorsTminManevr').AsFloat;
    //Excavator Rock,%
    FieldByName('ExcavatorsRockRatio').AsFloat:= esaDrob(FieldByName('ExcavatorsRockQtn').AsFloat * 100,
                                                         FieldByName('ExcavatorsPlanRockQtn').AsFloat);
    //Excavator C,tg
    FieldByName('ExcavatorsWorkCtg').AsFloat:= FieldByName('ExcavatorsWorkSumGxCtg').AsFloat +
                                               FieldByName('ExcavatorsWorkMaterialsCtg').AsFloat +
                                               FieldByName('ExcavatorsWorkUnAccountedCtg').AsFloat +
                                               FieldByName('ExcavatorsWorkSalariesCtg').AsFloat;
    //
    FieldByName('ExcavatorsWaitingCtg').AsFloat:= FieldByName('ExcavatorsWaitingSumGxCtg').AsFloat +
                                                  FieldByName('ExcavatorsWaitingMaterialsCtg').AsFloat +
                                                  FieldByName('ExcavatorsWaitingUnAccountedCtg').AsFloat +
                                                  FieldByName('ExcavatorsWaitingSalariesCtg').AsFloat;
    //
    FieldByName('ExcavatorsCtg').AsFloat:= FieldByName('ExcavatorsWorkCtg').AsFloat +
                                           FieldByName('ExcavatorsWaitingCtg').AsFloat +
                                           FieldByName('ExcavatorsAmortizationCtg').AsFloat;
    //--------------
    //Blocks,AutosCount
    FieldByName('BlocksAutosCount').AsFloat:= FieldByName('BlocksAutosCountNulled').AsFloat +
                                              FieldByName('BlocksAutosCountLoading').AsFloat +
                                              FieldByName('BlocksAutosCountUnLoading').AsFloat;
    //Blocks,WaitingsCount
    FieldByName('BlocksWaitingsCount').AsFloat:= FieldByName('BlocksWaitingsCountNulled').AsFloat +
                                                 FieldByName('BlocksWaitingsCountLoading').AsFloat +
                                                 FieldByName('BlocksWaitingsCountUnLoading').AsFloat;
    //Blocks V,kmh
    FieldByName('BlocksAvgVkmh').AsFloat:= (FieldByName('BlocksAvgVkmhNulled').AsFloat +
                                            FieldByName('BlocksAvgVkmhLoading').AsFloat +
                                            FieldByName('BlocksAvgVkmhUnLoading').AsFloat
                                            ) / 3;
    //Blocks T,min
    FieldByName('BlocksMovingAvgTmin').AsFloat:= (FieldByName('BlocksMovingAvgTminNulled').AsFloat +
                                                  FieldByName('BlocksMovingAvgTminLoading').AsFloat +
                                                  FieldByName('BlocksMovingAvgTminUnLoading').AsFloat
                                                  ) / 3;
    //
    FieldByName('BlocksWaitingAvgTmin').AsFloat:= (FieldByName('BlocksWaitingAvgTminNulled').AsFloat +
                                                   FieldByName('BlocksWaitingAvgTminLoading').AsFloat +
                                                   FieldByName('BlocksWaitingAvgTminUnLoading').AsFloat
                                                   ) / 3;
    //Blocks Gx,l
    FieldByName('BlocksGx').AsFloat:= FieldByName('BlocksGxNulled').AsFloat +
                                      FieldByName('BlocksGxLoading').AsFloat +
                                      FieldByName('BlocksGxUnLoading').AsFloat;
    //Blocks C,tg
    FieldByName('BlocksCtg').AsFloat:= FieldByName('BlocksRepairCtg').AsFloat +
                                       FieldByName('BlocksAmortizationCtg').AsFloat;
    //Econom C,tg
    FieldByName('EconomExploatationCtg').AsFloat:= FieldByName('AutosWorkCtg').AsFloat +
                                                   FieldByName('ExcavatorsWorkCtg').AsFloat +
                                                   FieldByName('BlocksRepairCtg').AsFloat +
                                                   FieldByName('AutosWaitingCtg').AsFloat +
                                                   FieldByName('ExcavatorsWaitingCtg').AsFloat;
    //
    FieldByName('EconomAmortizationCtg').AsFloat:= FieldByName('AutosAmortizationCtg').AsFloat +
                                                   FieldByName('ExcavatorsAmortizationCtg').AsFloat +
                                                   FieldByName('BlocksAmortizationCtg').AsFloat;
    //
    FieldByName('EconomCtg').AsFloat:= FieldByName('EconomExploatationCtg').AsFloat +
                                       FieldByName('EconomExpensesCtg').AsFloat +
                                       FieldByName('EconomAmortizationCtg').AsFloat;
    //
    FieldByName('EconomUdExploatationCtg_m3').AsFloat:= esaDrob(FieldByName('EconomExploatationCtg').AsFloat,
                                                                FieldByName('ExcavatorsRockVm3').AsFloat);
    //
    FieldByName('EconomUdExploatationCtg_tn').AsFloat:= esaDrob(FieldByName('EconomExploatationCtg').AsFloat,
                                                                FieldByName('ExcavatorsRockQtn').AsFloat);
    //
    FieldByName('EconomUdAmortizationCtg_m3').AsFloat:= esaDrob(FieldByName('EconomAmortizationCtg').AsFloat,
                                                                FieldByName('ExcavatorsRockVm3').AsFloat);
    //
    FieldByName('EconomUdAmortizationCtg_tn').AsFloat:= esaDrob(FieldByName('EconomAmortizationCtg').AsFloat,
                                                                FieldByName('ExcavatorsRockQtn').AsFloat);
    //
    FieldByName('EconomUdCtg_m3').AsFloat:= esaDrob(FieldByName('EconomCtg').AsFloat,
                                                    CalcVolumeOfGM_avg_m3(FieldByName('CurrOreVm3').AsFloat,
                                                                          FieldByName('CurrStrippingVm3').AsFloat,
                                                                          FieldByName('ExcavatorsRockVm3').AsFloat));
    //
    FieldByName('EconomUdCtg_tn').AsFloat:= esaDrob(FieldByName('EconomCtg').AsFloat,
                                                    FieldByName('ExcavatorsRockQtn').AsFloat);
    //
    FieldByName('AutosAutosCount').AsString:= Format('%d из %d',
                                                     [FieldByName('AutosAutosCount0').AsInteger,
                                                      FieldByName('AutosAutosCount0').AsInteger +
                                                      FieldByName('AutosAutosCount1').AsInteger
                                                      ]);
    //
    FieldByName('ExcavatorsExcavatorsCount').AsString:= Format('%d из %d',
                                                              [FieldByName('ExcavatorsExcavatorsCount0').AsInteger,
                                                               FieldByName('ExcavatorsExcavatorsCount0').AsInteger +
                                                               FieldByName('ExcavatorsExcavatorsCount1').AsInteger
                                                               ]);
  end;

  //SEE 8/02/2018: Relative economical effect calculation added
  NominalEffectCalculation(DataSet);
end;

procedure TfmVariants.NominalEffectCalculation(DataSet: TDataSet);
var
  _economic: TEconomicResult;

  function str(dbl: double): string;
  begin
    Result:= Format('%n', [dbl]);
  end;
begin
  // todo: vars | calculate
  _economic:= _economics.CurrentVariant;
  with DataSet do
  begin
    FieldByName('PeriodTdayL').AsString:= Format('Выходные данные  за период - %s дней',
                                                 [FieldByName('PeriodTday').AsString]);

    {Прочие текущие расходы связанные с приобретением шин и т.д., млн.тенге}
    FieldByName('CAutosTyresCtg').AsFloat:= _economic.TyresCost / 1e3;

    {Показатель плотности руды, т/м3}
    FieldByName('SelicTM3').AsFloat:= _economic.Selic;

    {Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, Vgm в м3}
    FieldByName('Vgm').AsFloat:= _economic.VolumeOfGM_m3_byYear / 1e3;

    {Прибыль, млн.тг}
    FieldByName('ProfitCtg').AsFloat:= _economic.Profit / 1E6;

    {Затраты, млн.тг}
    FieldByName('ExpensesCtg').AsFloat:= _economic.TotalCost / 1E6;

    {Условный экономический эффект, млн.тг}
    FieldByName('NominalEconomicEffectCtg').AsFloat:= _economic.UEconomicEffect / 1E6;

    {Относительный экономический эффект, млн.тг}
    FieldByName('RelativeEconomicEffectCtg').AsFloat:= _economic.OEconomicEffect / 1E6;

    {Объем горной массы запланированный к извлечению в рассматриваемом периоде, Vn в м3}
    FieldByName('PlannedRockVolumeCm').AsFloat:= _economic.PlanVolume_m3 / 1e3;

    {Объемно ориентированный условный экономический эффект, млн.тг}
    FieldByName('VOEconomicEffectCtg').AsFloat:= _economic.OOUEconomicEffect / 1e6;
  end;
end;


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
end;
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
  end;
end;


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
  end;
end;

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
  end;
end;

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
    end;
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;
end;

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
    end;
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;
end;

procedure TfmVariants.pmiSelectAllClick(Sender: TObject);
begin
  dbgVariants.SelectedRows.Clear;
  dbgVariants.SelectedRows.SelectAll;
end;
procedure TfmVariants.pmiUnSelectAllClick(Sender: TObject);
begin
  dbgVariants.SelectedRows.Clear;
end;

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
    end;
  finally
    RequeryVariants();
    NEESaveToLocal();
  end;
end;

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
      end;
      Close;
    finally
      Free;
    end;
    dbgVariants.SelectedRows.Clear;
  finally
    RequeryVariants();
  end;
end;

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
    end;
    RequeryVariants();
  finally
    quVariants.EnableControls;
  end;
end;

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
    end;
    RequeryVariants();
  finally
    quVariants.EnableControls;
  end;
end;
procedure TfmVariants.pmiExcelParamsDollarClick(Sender: TObject);
begin
  pmiExcelParamsDollar.Checked := not pmiExcelParamsDollar.Checked;
  with TIniFile.Create(IniFileName) do
  try
    WriteBool('Отчеты','InDollar',pmiExcelParamsDollar.Checked);
  finally
    Free;
  end;
end;

procedure TfmVariants.pmiExcelParamsThousandSeparatorClick(Sender: TObject);
begin
  pmiExcelParamsThousandSeparator.Checked := not pmiExcelParamsThousandSeparator.Checked;
  with TIniFile.Create(IniFileName) do
  try
    WriteBool('Отчеты','ThousandSeparator',pmiExcelParamsThousandSeparator.Checked);
  finally
    Free;
  end;
end;

procedure TfmVariants.pmiExcelClick(Sender: TObject);
begin
  //Excel
end;

procedure TfmVariants.pmiGraphicsClick(Sender: TObject);
begin
  esaShowVariantGraphicsDlg(DoVariantsCalcFields)
end;

procedure TfmVariants.PopupMenuPopup(Sender: TObject);
var
  _variants_enabled: boolean;
begin
  _variants_enabled:= (quVariants.Active) and (quVariants.RecordCount>0);
  pmiMark.Enabled         := _variants_enabled;
  pmiUnMark.Enabled       := _variants_enabled;
  pmiMarkAll.Enabled      := _variants_enabled;
  pmiUnMarkAll.Enabled    := _variants_enabled;
  pmiSelectAll.Enabled    := _variants_enabled;
  pmiUnSelectAll.Enabled  := (_variants_enabled) and (dbgVariants.SelectedRows.Count > 0);
  pmiDelete.Enabled         := _variants_enabled;
  pmiMoveUp.Enabled         := (_variants_enabled) and (quVariants.RecNo > 1);
  pmiMoveDown.Enabled       := (_variants_enabled) and (quVariants.RecNo < quVariants.RecordCount);
  pmiExcel.Enabled          := _variants_enabled;
  pmiGraphics.Enabled       := (quVariants.Active);
end;

procedure TfmVariants.dsVaraintsDataChange(Sender: TObject; Field: TField);
var
  _Vm3: double;
  _Vt: double;
  _Cost: double;
  _per: double;
  //
  _tmpQtn: double;
  _tmpPlan: double;
begin
  if quVariants.Active then
    dbgVariants.Columns[0].Footers[0].Value := Format('%d/%d',[quVariants.RecNo,quVariants.RecordCount])
  else
    dbgVariants.Columns[0].Footers[0].Value := '';


  _Vm3:= (quVariantsExcavatorsRockVm3.AsVariant +
          quVariantsCurrOreVm3.AsVariant +
          quVariantsCurrStrippingVm3.AsVariant
          ) / 2;
  dbgVariants.Columns[4].Footers[1].ValueType:= fvtStaticText;
  dbgVariants.Columns[4].Footers[1].Value:= format('%n', [_Vm3]);

  _tmpQtn:= _Vm3 * 100;
  _tmpPlan:= quVariantsPlannedRockVolumeCm.AsFloat / 620.5 * 1000;
//  _tmpPlan:= 1;//quVariantsPlannedRockVolumeCm.AsVariant * 1000 / 2 / 365 / 0.85;

  _per:= _tmpQtn / _tmpPlan;
  dbgVariants.Columns[3].Footers[1].ValueType:= fvtStaticText;
  dbgVariants.Columns[3].Footers[1].Value:= format('%n', [_per]);

  _Vt:= (quVariantsExcavatorsRockQtn.AsFloat +
         quVariantsCurrOreQtn.AsFloat +
         quVariantsCurrStrippingQtn.AsFloat
         ) / 2;
  dbgVariants.Columns[5].Footers[1].ValueType:= fvtStaticText;
  dbgVariants.Columns[5].Footers[1].Value:= format('%n', [_Vt]);

  _Cost:= (quVariantsEconomExpensesCtg.AsFloat +
          (quVariantsServiceExpensesCtg.AsFloat * 1000));

  dbgVariants.Columns[6].Footers[1].ValueType:= fvtStaticText;
  dbgVariants.Columns[6].Footers[1].Value:= format('%n', [_Cost / _Vm3]);

  dbgVariants.Columns[7].Footers[1].ValueType:= fvtStaticText;
  dbgVariants.Columns[7].Footers[1].Value:= format('%n', [_Cost / _Vt]);

//  dbgVariants.Columns[0].Footer.ValueType := fvtStaticText;
//  dbgVariants.Columns[0].Footer.Value     := 'ИТОГО (актов/сумма)';
//  dbgVariants.Columns[4].Footer.ValueType := fvtSum; // где 4- номер столбца, который суммируем
end;

procedure TfmVariants.dbgVariantsDrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
begin
  (Sender As TDBGridEh).DefaultDrawFooterCell(Rect, DataCol, Row, Column, State);
end;


procedure TfmVariants.TabControlChange(Sender: TObject);
begin
  dbgVariants.SelectedRows.Clear;
  quVariants.Close;
  case TabControl.TabIndex of
    1:   quVariants.SQL.Text := 'SELECT * FROM _ResultVariants WHERE IsPrint=TRUE ORDER BY SortIndex';
    2:   quVariants.SQL.Text := 'SELECT * FROM _ResultVariants WHERE IsPrint=FALSE ORDER BY SortIndex';
    else quVariants.SQL.Text := 'SELECT * FROM _ResultVariants ORDER BY SortIndex';
  end;
  quVariants.Open;
end;

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

  if ShowHidden then
  begin
    sbShowHidden.Caption:= '+' ;
    gbAdditinal.Visible:= True;
  end
  else
  begin
    sbShowHidden.Caption:= '-' ;
    gbAdditinal.Visible:= False;
  end;
end;

procedure TfmVariants.SetView;
begin
  // todo: vars | views
  lbProductOutPutPercent.Caption:= PRODUCT_FROM_1TONNA;
end;

end.
