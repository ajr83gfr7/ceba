unit esaResultVariants;

interface
uses
  ADODb, esaGlobals;
type
  //Результат моделирования -----------------------------------------------------------------------------
  TesaResultVariant = class
  private
    FId_ResultVariant: Integer;//Код варианта моделирования
    FQuery           : TADOQuery;
    FPlanRatio       : Single;    //Степень выполнения плана по ГТСК, %
    FUdCtg_m3        : Single;    //Удельные текущие затраты по ГТСК, тг/м3
    FUdCtg_tn        : Single;    //Удельные текущие затраты по ГТСК, тг/т
    FPlannedRockVolumeCm        : Single;    //Запланировый объем горных работ, тыс. м3 (SEE)
  protected
    property Query: TADOQuery read FQuery;
  public
    property Id_ResultVariant: Integer read FId_ResultVariant;
    //Конструктор
    constructor Create(const AConnection: TADOConnection); virtual;
    destructor Destroy; override;
    //Добавление варианта
    procedure Append(const AOpenpit: String; const AShift: ResaShift; const APeriod: ResaPeriod; const ACommon: ResaCommon);
    //Сохранение информации по автосамосвалам
    procedure SaveAutos(
      const AAutos              : String;             //Автосамосвалы
      const AAutosCount0        : Integer;            //Количество автосамосвалов в рабочем состоянии
      const AAutosCount1        : Integer;            //Количество автосамосвалов в нерабочем состоянии
      const ATripsCount         : ResaDirectionValue; //Количество рейсов по направлениям движения
      const ARockVolume         : ResaRockVolume;     //Объем/Вес перевезенной ГМ, м3/т
      const ASmetr              : ResaDirectionValue; //Пробег по направлениям движения, м
      const AWAvgSkmLoading     : ResaDrobValue;      //Средневзвешенное расстояние транспортирования,км*т //Токо для моделей и суммарного значения!
      const AWAvgHm             : ResaDrobValue;      //Средная высота подъема, м
      const AAvgVkmh            : ResaDrobValue;      //Средняя скорость, км/ч
      const AAvgVkmhNulled      : ResaDrobValue;      //Средняя скорость в нулевом направлении
      const AAvgVkmhLoading     : ResaDrobValue;      //Средняя скорость в грузовом направлении
      const AAvgVkmhUnLoading   : ResaDrobValue;      //Средняя скорость в порожняковом направлении
      const AGx                 : ResaWorkValue;      //Расход топлива, л (в работе,в простое)
      const ADirGx              : ResaDirectionValue; //Расход топлива по направлениям, л
      const AUdGx_gr_tkm        : Single;             //Удельны расход топлива, г/ткм
      const ALoadingSkmRockQtn  : Single;             //Грузооборот, ткм
      const ATsec               : ResaTmin;           //Время, сек
      const ADirTsec            : ResaDirectionValue; //Время по направлениям, сек
      const ATyresCount         : Single;             //Количество шин
      const AUsedTyresCount     : Single;             //Количество израсходованных шин
      const ASumTyresCtg        : Single;             //Затраты на шины, тг
      const ASumGxCtg           : ResaWorkValue;      //Затраты на топливо в работе и простое, тг
      const ASumExploatationCtg : ResaWorkValue;      //Затраты эксплуатационные (в работе и простое), тг
      const ASumSparesGxCtg     : ResaWorkValue;      // - Затраты на запчасти для автосамосвала, тг/смена
      const ASumMaterialsGxCtg  : ResaWorkValue;      // - Затраты на смазочные материалы для автосамосвала, тг/смена
      const ASumMaintenanceCtg  : ResaWorkValue;      // - Затраты на содержание ремонтного персонала для автосамосвала, тг/смена
      const ASumSalaryCtg       : ResaWorkValue;      // - Затраты на зарплату для автосамосвала, тг/смена
      const ASumAmortizationCtg : Single);            //Величина амортизационных затрат, тг
    //Сохранение информации по экскаваторам
    procedure SaveExcavators(
      const AExcavators             : String;         //Экскаваторы
      const AExcavatorsCount0       : Integer;        //Количество экскаваторов в рабочем состоянии
      const AExcavatorsCount1       : Integer;        //Количество экскаваторов в нерабочем состоянии
      const AAutosCount             : Single;         //Количество погруженных автосамосвалов
      const ARockVolume             : ResaRockVolume; //Объем погруженой ГМ, м3
      const APlanRockVolume         : ResaRockVolume; //Плановый объем ГМ на смену, м3
      const ASumGx                  : ResaWorkValue;  //Расход электроэнергии, кВт*ч
      const ASumTmin                : ResaTmin;       //Время, мин (в работе,простое,при маневрах)
      const ASumExploatationCtg     : ResaWorkValue;  //Затраты эксплуатационные (в работе и простое), тг
      const ASumGxCtg               : ResaWorkValue;      // - Затраты на электроэнергию, тг/смена
      const ASumMaterialsGxCtg      : ResaWorkValue;      // - Затраты на материалы, тг/смена
      const ASumUnAccountedCtg      : ResaWorkValue;      // - Затраты неучтенные, тг/смена
      const ASumSalaryCtg           : ResaWorkValue;      // - Затраты на зарплату, тг/смена
      const ASumAmortizationCtg     : Single);        //Величина амортизационных затрат, тг
    //Сохранение информации по блок-участкам
    procedure SaveBlocks(
      const ABlocksCount               : Integer;           //Количество блок-участков
      const ALsm                       : Integer;           //Длина, cм
      const ARockVolume                : ResaRockVolume;    //Объем перевезенной горной массы
      const AAutosCount                : ResaDirectionValue;//Количество автосамосвалов
      const AWaitingsCount             : ResaDirectionValue;//Количество простоев автосамосвалов
      const AAvgVkmhNulled             : ResaDrobValue;     //Средняя скорость движения автосамосвалов в нулевом направлении, км/ч
      const AAvgVkmhLoading            : ResaDrobValue;     //Средняя скорость движения автосамосвалов в грузовом направлении, км/ч
      const AAvgVkmhUnLoading          : ResaDrobValue;     //Средняя скорость движения автосамосвалов в порожняковом направлении, км/ч
      const AMovingAvgTminNulled       : ResaDrobValue;     //Среднее время движения автосамосвалов в нулевом направлении, мин
      const AMovingAvgTminLoading      : ResaDrobValue;     //Среднее время движения автосамосвалов в грузовом направлении, мин
      const AMovingAvgTminUnLoading    : ResaDrobValue;     //Среднее время движения автосамосвалов в порожняковом направлении, мин
      const AWaitingAvgTminNulled      : ResaDrobValue;     //Среднее время простоев автосамосвалов в нулевом направлении, мин
      const AWaitingAvgTminLoading     : ResaDrobValue;     //Среднее время простоев автосамосвалов в грузовом направлении, мин
      const AWaitingAvgTminUnLoading   : ResaDrobValue;     //Среднее время простоев автосамосвалов в порожняковом направлении, мин
      const AEmploymentCoef            : Single;
      const AGx                        : ResaDirectionValue;//Расход топлива автосамосвалов по направлениям, л
      const AUdGx_l_m                  : Single;
      const ARepairCtg                 : Single;            //Затраты на поддержание, тг
      const AAmortizationCtg           : Single);           //Амортизационные отчисления, тг
    //Сохранение информации экономической
    procedure SaveEconomParams(const AExpensesCtg: Single);//Постоянные и неучтенные расходы,тг
    procedure UpdateProductivity();
  end;{TesaResultVariant}

implementation
uses SysUtils,unDM;

//Результат моделирования -------------------------------------------------------------------------------
//Конструктор
constructor TesaResultVariant.Create(const AConnection: TADOConnection);
begin
  inherited Create;
  FId_ResultVariant := 0;
  FUdCtg_m3 := 0.0;
  FUdCtg_tn := 0.0;
  FPlanRatio:= 0.0;
  FQuery := TADOQuery.Create(nil);
  Query.Connection := AConnection;
  Query.SQL.Text   := 'SELECT * FROM _ResultVariants ORDER BY SortIndex';
  Query.Open;
end;{Create}
destructor TesaResultVariant.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;{Destroy}
//Добавление варианта
procedure TesaResultVariant.Append( const AOpenpit: String;
                                    const AShift: ResaShift;
                                    const APeriod: ResaPeriod;
                                    const ACommon: ResaCommon);
var ASortIndex: Integer;
begin
  UpdateProductivity();
  if not Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    ASortIndex := Query.RecordCount+1;
    Query.Append;
    Query.FieldByName('SortIndex').AsInteger       := ASortIndex;
    Query.FieldByName('VariantDate').AsFloat       := Now;
    Query.FieldByName('IsPrint').AsBoolean         := True;
  end{if}
  else Query.Edit;
  Query.FieldByName('Variant').AsString            := AOpenpit;
  Query.FieldByName('PeriodTday').AsFloat          := APeriod.Tday;
  Query.FieldByName('PeriodKshift').AsFloat        := APeriod.Kshift;
  Query.FieldByName('ShiftTmin').AsFloat           := AShift.Tmin;
  Query.FieldByName('ShiftNaryadFactTmin').AsFloat := AShift.NaryadTmin;
  Query.FieldByName('ShiftTurnoverTmin').AsFloat   := AShift.TurnoverTmin;
  Query.FieldByName('ShiftKweek').AsFloat          := AShift.ShiftTimeUsingCoef.Kweek;
  Query.FieldByName('DollarCtg').AsFloat           := ACommon.DollarCtg;
  //@SEE added
  Query.FieldByName('CurrOreQtn').AsFloat          := ACommon.CurrOreQtn;
  Query.FieldByName('CurrOreVm3').AsFloat          := ACommon.CurrOreVm3;
  Query.FieldByName('CurrStrippingQtn').AsFloat    := ACommon.CurrStrippingQtn;
  Query.FieldByName('CurrStrippingVm3').AsFloat    := ACommon.CurrStrippingVm3;
  Query.FieldByName('Ks').AsFloat                  := ACommon.CurrStrippingCoef;
  Query.Post;

  FId_ResultVariant := Query.FieldByName('Id_ResultVariant').AsInteger;
  Query.Requery;
end;{Append}
//Сохранение информации по автосамосвалам
procedure TesaResultVariant.SaveAutos(
  const AAutos              : String;             //Автосамосвалы
  const AAutosCount0        : Integer;            //Количество автосамосвалов в рабочем состоянии
  const AAutosCount1        : Integer;            //Количество автосамосвалов в нерабочем состоянии
  const ATripsCount         : ResaDirectionValue; //Количество рейсов по направлениям движения
  const ARockVolume         : ResaRockVolume;     //Объем/Вес перевезенной ГМ, м3/т
  const ASmetr              : ResaDirectionValue; //Пробег по направлениям движения, м
  const AWAvgSkmLoading     : ResaDrobValue;      //Средневзвешенное расстояние транспортирования,км*т //Токо для моделей и суммарного значения!
  const AWAvgHm             : ResaDrobValue;      //Средная высота подъема, м
  const AAvgVkmh            : ResaDrobValue;      //Средняя скорость, км/ч
  const AAvgVkmhNulled      : ResaDrobValue;      //Средняя скорость в нулевом направлении
  const AAvgVkmhLoading     : ResaDrobValue;      //Средняя скорость в грузовом направлении
  const AAvgVkmhUnLoading   : ResaDrobValue;      //Средняя скорость в порожняковом направлении
  const AGx                 : ResaWorkValue;      //Расход топлива, л (в работе,в простое)
  const ADirGx              : ResaDirectionValue; //Расход топлива по направлениям, л
  const AUdGx_gr_tkm        : Single;             //Удельны расход топлива, г/ткм
  const ALoadingSkmRockQtn  : Single;             //Грузооборот, ткм
  const ATsec               : ResaTmin;           //Время, сек
  const ADirTsec            : ResaDirectionValue; //Время по направлениям, сек
  const ATyresCount         : Single;             //Количество шин
  const AUsedTyresCount     : Single;             //Количество израсходованных шин
  const ASumTyresCtg        : Single;             //Затраты на шины, тг
  const ASumGxCtg           : ResaWorkValue;      //Затраты на топливо в работе и простое, тг
  const ASumExploatationCtg : ResaWorkValue;      //Затраты эксплуатационные (в работе и простое), тг 
  const ASumSparesGxCtg     : ResaWorkValue;      // - Затраты на запчасти для автосамосвала, тг/смена
  const ASumMaterialsGxCtg  : ResaWorkValue;      // - Затраты на смазочные материалы для автосамосвала, тг/смена
  const ASumMaintenanceCtg  : ResaWorkValue;      // - Затраты на содержание ремонтного персонала для автосамосвала, тг/смена
  const ASumSalaryCtg       : ResaWorkValue;      // - Затраты на зарплату для автосамосвала, тг/смена
  const ASumAmortizationCtg : Single);            //Величина амортизационных затрат, тг
begin
  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('Autos').AsString                      := AAutos;
    Query.FieldByName('AutosAutosCount0').AsFloat            := AAutosCount0;
    Query.FieldByName('AutosAutosCount1').AsFloat            := AAutosCount1;
    Query.FieldByName('AutosTripsCountNulled').AsFloat       := ATripsCount.Nulled;
    Query.FieldByName('AutosTripsCountLoading').AsFloat      := ATripsCount.Loading;
    Query.FieldByName('AutosTripsCountUnLoading').AsFloat    := ATripsCount.UnLoading;
    Query.FieldByName('AutosRockVm3').AsFloat                := ARockVolume.Vm3;
    Query.FieldByName('AutosRockQtn').AsFloat                := ARockVolume.Qtn;
    Query.FieldByName('AutosSkmNulled').AsFloat              := ASmetr.Nulled*0.001;
    Query.FieldByName('AutosSkmLoading').AsFloat             := ASmetr.Loading*0.001;
    Query.FieldByName('AutosSkmUnLoading').AsFloat           := ASmetr.UnLoading*0.001;
    Query.FieldByName('AutosLoadingWAvgSkm').AsFloat         := esaDrob(AWAvgSkmLoading.Num,AWAvgSkmLoading.Den);
    Query.FieldByName('AutosLoadingAvgSkm').AsFloat          := esaDrob(ASmetr.Loading*0.001,ATripsCount.Loading);
    Query.FieldByName('AutosWAvgHm').AsFloat                 := esaDrob(AWAvgHm.Num,AWAvgHm.Den);
    Query.FieldByName('AutosShiftAvgSkm').AsFloat            := esaDrob(esaSummary(ASmetr)*0.001,AAutosCount0);
    Query.FieldByName('AutosShiftAvgSkm_reis').AsFloat       := esaDrob(esaSummary(ASmetr)*0.001,esaSummary(ATripsCount));
    Query.FieldByName('AutosAvgVkmhNulled').AsFloat          := esaDrob(AAvgVkmhNulled.Num,AAvgVkmhNulled.Den);
    Query.FieldByName('AutosAvgVkmhLoading').AsFloat         := esaDrob(AAvgVkmhLoading.Num,AAvgVkmhLoading.Den);
    Query.FieldByName('AutosAvgVkmhUnLoading').AsFloat       := esaDrob(AAvgVkmhUnLoading.Num,AAvgVkmhUnLoading.Den);
    Query.FieldByName('AutosAvgTechVkmh').AsFloat            := esaDrob(3.6*esaSummary(ASmetr),esaSummary(ATsec)-ATsec.Waiting);
    Query.FieldByName('AutosGxWork').AsFloat                 := AGx.Work;
    Query.FieldByName('AutosGxWaiting').AsFloat              := AGx.Waiting;
    Query.FieldByName('AutosGxNulled').AsFloat               := ADirGx.Nulled;
    Query.FieldByName('AutosGxLoading').AsFloat              := ADirGx.Loading;
    Query.FieldByName('AutosGxUnLoading').AsFloat            := ADirGx.UnLoading;
    Query.FieldByName('AutosUdGx_gr_tkm').AsFloat            := AUdGx_gr_tkm;
    Query.FieldByName('AutosGxCtg').AsFloat                  := esaSummary(ASumGxCtg);
    Query.FieldByName('AutosTminMoving').AsFloat             := ATsec.Moving/60;
    Query.FieldByName('AutosTminWaiting').AsFloat            := ATsec.Waiting/60;
    Query.FieldByName('AutosTminManevr').AsFloat             := ATsec.Manevr/60;
    Query.FieldByName('AutosTminOnLoading').AsFloat          := ATsec.OnLoading/60;
    Query.FieldByName('AutosTminOnUnLoading').AsFloat        := ATsec.OnUnLoading/60;
    Query.FieldByName('AutosTminNulled').AsFloat             := ADirTsec.Nulled/60;
    Query.FieldByName('AutosTminLoading').AsFloat            := ADirTsec.Loading/60;
    Query.FieldByName('AutosTminUnLoading').AsFloat          := ADirTsec.UnLoading/60;
    Query.FieldByName('AutosReysAvgTminNulled').AsFloat      := esaDrob(ADirTsec.Nulled,60*ATripsCount.Nulled);
    Query.FieldByName('AutosReysAvgTminLoading').AsFloat     := esaDrob(ADirTsec.Loading,60*ATripsCount.Loading);
    Query.FieldByName('AutosReysAvgTminUnLoading').AsFloat   := esaDrob(ADirTsec.UnLoading,60*ATripsCount.UnLoading);
    Query.FieldByName('AutosAvgTimeUsingCoef').AsFloat       := esaDrob(esaSummary(ATsec)-ATsec.Waiting,esaSummary(ATsec));
    Query.FieldByName('AutosTyresCount').AsFloat             := ATyresCount;
    Query.FieldByName('AutosTyresSkm').AsFloat               := esaSummary(ASmetr)*(1E-3);
    Query.FieldByName('AutosUsedTyresCount').AsFloat         := AUsedTyresCount;
    Query.FieldByName('AutosTyresCtg').AsFloat               := ASumTyresCtg;
    Query.FieldByName('AutosWorkSumGxCtg').AsFloat           := ASumGxCtg.Work;
    Query.FieldByName('AutosWorkSumTyresCtg').AsFloat        := ASumTyresCtg;
    Query.FieldByName('AutosWorkSparesCtg').AsFloat          := ASumSparesGxCtg.Work;
    Query.FieldByName('AutosWorkMaterialsCtg').AsFloat       := ASumMaterialsGxCtg.Work;
    Query.FieldByName('AutosWorkMaintenancesCtg').AsFloat    := ASumMaintenanceCtg.Work;
    Query.FieldByName('AutosWorkSalariesCtg').AsFloat        := ASumSalaryCtg.Work;
    Query.FieldByName('AutosWaitingSumGxCtg').AsFloat        := ASumGxCtg.Waiting;
    Query.FieldByName('AutosWaitingSparesCtg').AsFloat       := ASumSparesGxCtg.Waiting;
    Query.FieldByName('AutosWaitingMaterialsCtg').AsFloat    := ASumMaterialsGxCtg.Waiting;
    Query.FieldByName('AutosWaitingMaintenancesCtg').AsFloat := ASumMaintenanceCtg.Waiting;
    Query.FieldByName('AutosWaitingSalariesCtg').AsFloat     := ASumSalaryCtg.Waiting;
    Query.FieldByName('AutosAmortizationCtg').AsFloat        := ASumAmortizationCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveAutos}
//Сохранение информации по экскаваторам
procedure TesaResultVariant.SaveExcavators(
  const AExcavators             : String;         //Экскаваторы
  const AExcavatorsCount0       : Integer;        //Количество экскаваторов в рабочем состоянии
  const AExcavatorsCount1       : Integer;        //Количество экскаваторов в нерабочем состоянии
  const AAutosCount             : Single;         //Количество погруженных автосамосвалов
  const ARockVolume             : ResaRockVolume; //Объем погруженой ГМ, м3
  const APlanRockVolume         : ResaRockVolume; //Плановый объем ГМ на смену, м3
  const ASumGx                  : ResaWorkValue;  //Расход электроэнергии, кВт*ч
  const ASumTmin                : ResaTmin;       //Время, мин (в работе,простое,при маневрах)
  const ASumExploatationCtg     : ResaWorkValue;  //Затраты эксплуатационные (в работе и простое), тг
  const ASumGxCtg               : ResaWorkValue;      // - Затраты на электроэнергию, тг/смена
  const ASumMaterialsGxCtg      : ResaWorkValue;      // - Затраты на материалы, тг/смена
  const ASumUnAccountedCtg      : ResaWorkValue;      // - Затраты неучтенные, тг/смена
  const ASumSalaryCtg           : ResaWorkValue;      // - Затраты на зарплату, тг/смена
  const ASumAmortizationCtg     : Single);        //Величина амортизационных затрат, тг
begin
  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('Excavators').AsString                      := AExcavators;
    Query.FieldByName('ExcavatorsExcavatorsCount0').AsFloat       := AExcavatorsCount0;
    Query.FieldByName('ExcavatorsExcavatorsCount1').AsFloat       := AExcavatorsCount1;
    Query.FieldByName('ExcavatorsAutosCount').AsFloat             := AAutosCount;
    Query.FieldByName('ExcavatorsRockVm3').AsFloat                := ARockVolume.Vm3;
    Query.FieldByName('ExcavatorsRockQtn').AsFloat                := ARockVolume.Qtn;
    Query.FieldByName('ExcavatorsPlanRockVm3').AsFloat            := APlanRockVolume.Vm3;
    Query.FieldByName('ExcavatorsPlanRockQtn').AsFloat            := APlanRockVolume.Qtn;

    Query.FieldByName('ExcavatorsGxWork').AsFloat                 := ASumGx.Work;
    Query.FieldByName('ExcavatorsGxWaiting').AsFloat              := ASumGx.Waiting;

    Query.FieldByName('ExcavatorsTminWork').AsFloat               := ASumTmin.OnLoading;
    Query.FieldByName('ExcavatorsTminWaiting').AsFloat            := ASumTmin.Waiting;
    Query.FieldByName('ExcavatorsTminManevr').AsFloat             := ASumTmin.Manevr;
    Query.FieldByName('ExcavatorsUsingPunktCoef').AsFloat         := esaDrob(ASumTmin.OnLoading+ASumTmin.Manevr,esaSummary(ASumTmin));
    Query.FieldByName('ExcavatorsUsingTimeCoef').AsFloat          := esaDrob(ASumTmin.OnLoading,esaSummary(ASumTmin));

    Query.FieldByName('ExcavatorsWorkSumGxCtg').AsFloat           := ASumGxCtg.Work;
    Query.FieldByName('ExcavatorsWorkMaterialsCtg').AsFloat       := ASumMaterialsGxCtg.Work;
    Query.FieldByName('ExcavatorsWorkUnAccountedCtg').AsFloat     := ASumUnAccountedCtg.Work;
    Query.FieldByName('ExcavatorsWorkSalariesCtg').AsFloat        := ASumSalaryCtg.Work;
    Query.FieldByName('ExcavatorsWaitingSumGxCtg').AsFloat        := ASumGxCtg.Waiting;
    Query.FieldByName('ExcavatorsWaitingMaterialsCtg').AsFloat    := ASumMaterialsGxCtg.Waiting;
    Query.FieldByName('ExcavatorsWaitingUnAccountedCtg').AsFloat  := ASumUnAccountedCtg.Waiting;
    Query.FieldByName('ExcavatorsWaitingSalariesCtg').AsFloat     := ASumSalaryCtg.Waiting;
    Query.FieldByName('ExcavatorsAmortizationCtg').AsFloat        := ASumAmortizationCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveExcavators}
//Сохранение информации по блок-участкам
procedure TesaResultVariant.SaveBlocks(
  const ABlocksCount               : Integer;           //Количество блок-участков
  const ALsm                       : Integer;           //Длина, cм
  const ARockVolume                : ResaRockVolume;    //Объем перевезенной горной массы
  const AAutosCount                : ResaDirectionValue;//Количество автосамосвалов
  const AWaitingsCount             : ResaDirectionValue;//Количество простоев автосамосвалов
  const AAvgVkmhNulled             : ResaDrobValue;     //Средняя скорость движения автосамосвалов в нулевом направлении, км/ч
  const AAvgVkmhLoading            : ResaDrobValue;     //Средняя скорость движения автосамосвалов в грузовом направлении, км/ч
  const AAvgVkmhUnLoading          : ResaDrobValue;     //Средняя скорость движения автосамосвалов в порожняковом направлении, км/ч
  const AMovingAvgTminNulled       : ResaDrobValue;     //Среднее время движения автосамосвалов в нулевом направлении, мин
  const AMovingAvgTminLoading      : ResaDrobValue;     //Среднее время движения автосамосвалов в грузовом направлении, мин
  const AMovingAvgTminUnLoading    : ResaDrobValue;     //Среднее время движения автосамосвалов в порожняковом направлении, мин
  const AWaitingAvgTminNulled      : ResaDrobValue;     //Среднее время простоев автосамосвалов в нулевом направлении, мин
  const AWaitingAvgTminLoading     : ResaDrobValue;     //Среднее время простоев автосамосвалов в грузовом направлении, мин
  const AWaitingAvgTminUnLoading   : ResaDrobValue;     //Среднее время простоев автосамосвалов в порожняковом направлении, мин
  const AEmploymentCoef            : Single;
  const AGx                        : ResaDirectionValue;//Расход топлива автосамосвалов по направлениям, л
  const AUdGx_l_m                  : Single;
  const ARepairCtg                 : Single;            //Затраты на поддержание, тг
  const AAmortizationCtg           : Single);           //Амортизационные отчисления, тг
begin


  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('BlocksBlocksCount').AsFloat            := ABlocksCount;
    Query.FieldByName('BlocksLm').AsFloat                     := ALsm*0.01;
    Query.FieldByName('BlocksRockVm3').AsFloat                := ARockVolume.Vm3;
    Query.FieldByName('BlocksRockQtn').AsFloat                := ARockVolume.Qtn;
    Query.FieldByName('BlocksAutosCountNulled').AsFloat       := AAutosCount.Nulled;
    Query.FieldByName('BlocksAutosCountLoading').AsFloat      := AAutosCount.Loading;
    Query.FieldByName('BlocksAutosCountUnLoading').AsFloat    := AAutosCount.UnLoading;
    Query.FieldByName('BlocksWaitingsCountNulled').AsFloat    := AWaitingsCount.Nulled;
    Query.FieldByName('BlocksWaitingsCountLoading').AsFloat   := AWaitingsCount.Loading;
    Query.FieldByName('BlocksWaitingsCountUnLoading').AsFloat := AWaitingsCount.UnLoading;
    Query.FieldByName('BlocksAvgVkmhNulled').AsFloat          := esaDrob(AAvgVkmhNulled.Num,AAvgVkmhNulled.Den);
    Query.FieldByName('BlocksAvgVkmhLoading').AsFloat         := esaDrob(AAvgVkmhLoading.Num,AAvgVkmhLoading.Den);
    Query.FieldByName('BlocksAvgVkmhUnLoading').AsFloat       := esaDrob(AAvgVkmhUnLoading.Num,AAvgVkmhUnLoading.Den);

    Query.FieldByName('BlocksMovingAvgTminNulled').AsFloat    := esaDrob(AMovingAvgTminNulled.Num,AMovingAvgTminNulled.Den);
    Query.FieldByName('BlocksMovingAvgTminLoading').AsFloat   := esaDrob(AMovingAvgTminLoading.Num,AMovingAvgTminLoading.Den);
    Query.FieldByName('BlocksMovingAvgTminUnLoading').AsFloat := esaDrob(AMovingAvgTminUnLoading.Num,AMovingAvgTminUnLoading.Den);
    Query.FieldByName('BlocksWaitingAvgTminNulled').AsFloat   := esaDrob(AWaitingAvgTminNulled.Num,AWaitingAvgTminNulled.Den);
    Query.FieldByName('BlocksWaitingAvgTminLoading').AsFloat  := esaDrob(AWaitingAvgTminLoading.Num,AWaitingAvgTminLoading.Den);
    Query.FieldByName('BlocksWaitingAvgTminUnLoading').AsFloat:= esaDrob(AWaitingAvgTminUnLoading.Num,AWaitingAvgTminUnLoading.Den);
    Query.FieldByName('BlocksEmploymentCoef').AsFloat         := AEmploymentCoef;

    Query.FieldByName('BlocksGxNulled').AsFloat               := AGx.Nulled;
    Query.FieldByName('BlocksGxLoading').AsFloat              := AGx.Loading;
    Query.FieldByName('BlocksGxUnLoading').AsFloat            := AGx.UnLoading;
    Query.FieldByName('BlocksUdGx_l_m').AsFloat               := AUdGx_l_m;
    Query.FieldByName('BlocksRepairCtg').AsFloat              := ARepairCtg;
    Query.FieldByName('BlocksAmortizationCtg').AsFloat        := AAmortizationCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveBlocks}
//Сохранение информации экономической
procedure TesaResultVariant.SaveEconomParams(const AExpensesCtg: Single);//Постоянные и неучтенные расходы,тг
begin
  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('EconomExpensesCtg').AsFloat := AExpensesCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveEconomParams}


//Обновление производительности горной породы, коэф-та вскрыши
procedure TesaResultVariant.UpdateProductivity();
var
  FProductivityMineralWealthV1000m3 :single;
  FProductivityMineralWealthQ1000tn :single;
  FProductivityStrippingV1000m3 :single;
  FProductivityStrippingQ1000tn :single;
begin
  FProductivityMineralWealthV1000m3 := 0.0;
  FProductivityMineralWealthQ1000tn := 0.0;
  FProductivityStrippingV1000m3 := 0.0;
  FProductivityStrippingQ1000tn := 0.0;
  FPlannedRockVolumeCm := 0.0;
  with fmDM do
  begin
    quRockProductivity.Open;
    quRockProductivity.Requery;
    quRockProductivity.First;
    while not quRockProductivity.Eof do
    begin
      if quRockProductivityIsMineralWealth.AsBoolean then
      begin
        FProductivityMineralWealthV1000m3 := FProductivityMineralWealthV1000m3+
                                             quRockProductivityPlannedV1000m3.AsFloat;
        FProductivityMineralWealthQ1000tn := FProductivityMineralWealthQ1000tn+
                                             quRockProductivityPlannedQ1000tn.AsFloat;
      end{if}
      else
      begin
        FProductivityStrippingV1000m3 := FProductivityStrippingV1000m3+
                                         quRockProductivityPlannedV1000m3.AsFloat;
        FProductivityStrippingQ1000tn := FProductivityStrippingQ1000tn+
                                         quRockProductivityPlannedQ1000tn.AsFloat;
      end;{else}
      quRockProductivity.Next;
    end;{while}
     quRockProductivity.Close;
  end;{with}

  FPlannedRockVolumeCm := FProductivityMineralWealthV1000m3+ FProductivityStrippingV1000m3;

end;{UpdateProductivity}
end.
