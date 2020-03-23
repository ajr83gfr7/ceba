unit esaDBDefaultParams;

interface
uses Graphics, Globals;
type
  //TDBDefaultParams - класс "Параметры по умолчанию" -----------------------------------------
  TDBDefaultParams = class
  private
    FFileName: String;
    //Двигатели
    FAutoEngineNmax: Single;//максимальная мощность двигателя, кВт
    //Автосамосвалы
    FAutoBodySpace       : Single; //Объем кузова, м3
    FAutoTonnage         : Single; //Грузоподъемность, т
    FAutoP               : Single; //Масса автосамосвала, т
    FAutoF               : Single; //Площадь лобового сечения автосамосвала, м2
    FAutoRo              : Single; //коэф-нт обтекаемости автосамосвала, т
    FAutoTransmissionKind: TAutoTransmissionKind;//Тип трансмиссии: 0-ГМ, 1-ЭМ
    FAutoTransmissionKPD : Single; //КПД трансмиссии
    FAutoId_Engine       : Integer;//Код двигателя
    FAutoT_r             : Single; //Время разгрузки, с
    FAutoRmin            : Single; //Минимальный радиус поворота, м
    FAutoTyresCount      : Integer;//Количество шин
    FAutoLength          : Single; //Длина, м
    FAutoWidth           : Single; //Ширина, м
    FAutoHeight          : Single; //Высота, м
    //Двигатели
    FExcavatorEngineNmax : Single;//максимальная мощность двигателя, кВт
    //Экскаваторы
    FExcavatorBucketCapacity  : Single; //Объем ковша, м3
    FExcavatorCycleTime       : Single; //Время цикла, с
    FExcavatorId_Engine       : Integer;//Код двигателя
    FExcavatorLength          : Single; //Длина, м
    FExcavatorWidth           : Single; //Ширина, м
    FExcavatorHeight          : Single; //Высота, м
    //Экскаваторы списочного парка
    FDeportExcId_Excavator      : Integer;//Код модели экскаватора
    FDeportExcEYear             : Integer;//Год выпуска
    FDeportExcWorkState         : Boolean;//Рабочее состояние: Да/нет
    FDeportExcCost              : Single; //Стоимость, тыс.тн
    FDeportExcFactCycleTime     : Single; //Фактическое время цикла, с
    FDeportExcAddCostMaterials  : Single; //Дополнительные стоимостные затраты на материалы, тыс.тн/мес
    FDeportExcAddCostUnAccounted: Single; //Дополнительные стоимостные затраты неучтенные, тыс.тн/мес
    FDeportExcEngineKIM         : Single; //Коэф-нт использования мощности двигателя, 0,25-0,35
    FDeportExcEngineKPD         : Single; //КПД двигателя, 0,936-0,948
    FDeportSENExcAmortizationRate : Single;  //Годовая норма амортизации экскаватора.
    //Автосамосвалы списочного парка
    FDeportAutoId_Auto          : Integer; //Код модели автосамосвала
    FDeportAutoAYear            : Integer; //Год выпуска
    FDeportAutoFactTonnage      : Single;  //Фактическая грузоподъемность, т
    FDeportAutoWorkState        : Boolean; //Рабочее состояние: Да/нет
    FDeportAutoCost             : Single;  //Стоимость, тыс.тн
    FDeportAutoAmortizationRate : Single;  //Норма амортизации на 1000 км.
    FDeportAutoTransmissionKPD  : Single;  //КПД трансмиссии, 0..1
    FDeportAutoEngineKPD        : Single;  //КПД двигателя, 0..1
    FDeportAutoTyreCost         : Single;  //Стоимость 1 шины, тыс.тн
    FDeportAutoTyresRaceRate     : Single;  //Норма пробега шин, тыс.км
    //Параметры дизайна карьерного пространства
    FCoordGridStyle: TCoordGridStyle; //Стиль координатной сетки
    FCoordGridStep : Integer;         //Шаг координатной сетки, м 
    FCoordGridMarks: Boolean;         //Текстовые отметки координатной сетки
    //Карьер
    FOpenpitId_Openpit: Integer;      //Код открытого карьера
    //Характерные точки
    FPointZ          : Single;         //Высота характерной точки карьера, м
    FPointMinDistance: Byte;           //Мин.расстояние между характерными точками, м
    FPointColor      : TColor;         //Цвет характерной точки
    FPointRadius     : Byte;           //Радиус характерной точки, pxl
    FPointMarkStyle  : TPointMarkStyle;//Стиль подвиси точки
    //Блок-участки
    FBlockColors     : array[TBlockKind]of TColor; //Цвета типов блок-участка
    FBlockStripCount : Byte;                       //Количество полос движения
    FBlockStripWidth : Single;                     //Ширина полосЫ движения, м
    FBlockLoadingVmax: Single;                     //Допускаемая скорость, км/ч
    FBlockUnLoadingVmax: Single;                     //Допускаемая скорость, км/ч
    FBlockId_RoadCoat: Integer;                    //Код дорожного покрытия
    FBlockKind       : TBlockKind;                 //Тип блок-участка
    FBlockStyle      : TBlockViewStyle;            //Стиль отображения блок-участка
    //Маршруты движения
    FCourseColor: TColor;           //Цвет маршрутов
    FCourseStyle: TCourseViewStyle; //Стиль отображения маршрутов
    //Горные породы
    FRockIsMineralWealth: Boolean;                   //Полезное ископаемое?
    //Пункты погрузки
    FLoadingPunktRockDensityInBlock: Single;         //Плотность в целике, т/м3
    FLoadingPunktRockShatteringCoef: Single;         //Коэффициент разрыхления
    FLoadingPunktRockContent       : Single;         //Среднее содержание полезного ископаемого, %
    FLoadingPunktRockPlannedV1000m3: Single;         //План на период, тыс.м3
    FLoadingPunktColor             : TColor;         //Цвет
    FLoadingPunktRadiusCoef        : Integer;        //Радиус=РадиусТочки*Coef
    FLoadingPunktRadius            : Integer;        //Радиус=РадиусТочки*Coef
    FLoadingPunktStyle             : TPunktViewStyle;//Стиль отображения
    //Пункты разгрузки
    FUnLoadingPunktMaxV1000m3       : Single;  //Емкость приемного бункера, тыс.м3
    FUnLoadingPunktAutoMaxCount   : Integer; //Число авто, к-х можно разместить на пункте
    FUnLoadingPunktKind           : TUnLoadingPunktKind;//Тип пункта разгрузки
    FUnLoadingPunktRockRequiredContent: Single;  //Требуемое Содержание, %
    FUnLoadingPunktRockInitialContent : Single;  //Содержание на начало смены, %
    FUnLoadingPunktRockInitialV1000m3 : Single;  //Объем на начало смены, тыс.м3
    FUnLoadingPunktColor          : TColor;      //Цвет
    FUnLoadingPunktRadiusCoef     : Integer;     //Радиус=РадиусТочки*Coef
    FUnLoadingPunktRadius         : Integer;     //Радиус=РадиусТочки*Coef
    FUnLoadingPunktStyle          : TPunktViewStyle;//Стиль отображения
    //Пункты пересменки
    FShiftPunktColor     : TColor;     //Цвет
    FShiftPunktRadiusCoef: Integer;    //Радиус=РадиусТочки*Coef
    FShiftPunktRadius    : Integer;    //Радиус=РадиусТочки*Coef
    FShiftPunktStyle     : TPunktViewStyle;//Стиль отображения
    //Дополнительные общие показатели
    FParamsTotalKurs                        : Single; //Курс доллара, тенге
    FParamsTotalExpenses                    : Single; //Величина постоянных и нечтенных расходов, тыс.тенге/год
    FParamsTotalSalaryCoef                  : Single; //Коэффициент учета отчислений из фонда заработной платы
    FParamsTotalShiftUsingCoefNormal        : Single; //Коэффициент использования времени смены В нормальных условиях
    FParamsTotalShiftUsingCoefDayShift      : Single; //Коэффициент использования времени смены Дневных смен
    FParamsTotalShiftUsingCoefExplosion     : Single; //Коэффициент использования времени смены В день производства взрывных работ
    FParamsTotalShiftUsingCoefExplosionCount: Integer;//Коэффициент использования времени смены Количество взрывов в неделю
    //Дополнительные показатели по экскаваторам
    FParamsExcavsSalaryMashinist0 : Single; //Основная зарплата машиниста, тыс.тн/мес
    FParamsExcavsSalaryMashinist1 : Single; //Дополнительная зарплата машиниста, тыс.тн/мес
    FParamsExcavsSalaryAssistant0 : Single; //Основная зарплата помощника машиниста, тыс.тн/мес
    FParamsExcavsSalaryAssistant1 : Single; //Дополнительная зарплата помощника машиниста, тыс.тн/мес
    FParamsExcavsWorkShiftsCount  : Integer;//Количество рабочих смен в месяц
    FParamsExcavsWorkShiftDuration: Single; //Продолжительность рабочей смены, час
    FParamsExcavsShiftTurnoverTime: Integer;//Время пересменки экскаваторов, мин
    FParamsExcavsEnergyCost       : Single; //Стоимость 1 кВт*час электроэнергии, тенге
    FParamsExcavsAmortazationNorm : Single; //Норма амортизации
    //Дополнительные показатели по автосамосвалам
    FParamsAutosSalary0          : Single; //Основная зарплата водителя, тыс.тн/мес
    FParamsAutosSalary1          : Single; //Дополнительная зарплата водителя, тыс.тн/мес
    FParamsAutosWorkShiftsCount  : Integer;//Количество рабочих смен в месяц
    FParamsAutosWorkShiftDuration: Single; //Продолжительность рабочей смены, час
    FParamsAutosShiftTurnoverTime: Integer;//Время пересменки автосамосвалов, мин
    FParamsAutosFuelCostWinter   : Single; //Стоимость дизельного топлива "Зимнее", тенге/литр
    FParamsAutosFuelCostSummer   : Single; //Стоимость дизельного топлива "Летнее", тенге/литр
    FParamsAutosWinterMonthCount : Integer;//Количество зимних месяцев в году
    FParamsAutosFuelCostTarif    : TAutosFuelCostTarif; //Учет тарифа стоимости топлива
    //Дополнительные показатели по режиму работы в открытом цикле
    FParamsWorkRegimeKind        : TAutoWorkRegime;//Признак распределения порожних авто при
                                                   //открытом цикле: 0-усреднение качества,
                                                   //1-равномерное распределение по ПП
    FParamsWorkRegimeIsStrippingCoefUsing: Boolean;//Учитывать коэффициент вскрыши?
    //Дополнительные показатели моделирования
    FModelingParamsShiftDuration            : Integer;//Продолжительность смены, мин
    FModelingParamsPeriodDuration           : Integer;//Продолжительность рассматриваемого периода, дни
    FModelingParamsIsAccumulateData         : Boolean;//Накапливать данные?
    FModelingParamsAnimationTimeScale       : Integer;//Масштаб времени анимации, 1х

    //Дополнительные показатели по затратам на текущие ремонты авто
    FParamsAutosSpares           : Single;
    FParamsAutosGreasingSubstance: Single;
    FParamsAutosMaintenanceCost  : Single;
    //Дополнительные показатели по затратам на содержание дороги
    FParamsRoadsBuildingCosts    : Single;
    FParamsRoadsKeepingCosts     : Single;
    FParamsRoadsAmortizationNorm : Single;

    //Автосамосвалы
    procedure SetAutoEngineNmax(Value: Single);
    procedure SetAutoBodySpace(Value: Single);
    procedure SetAutoTonnage(Value: Single);
    procedure SetAutoP(Value: Single);
    procedure SetAutoF(Value: Single);
    procedure SetAutoRo(Value: Single);
    procedure SetAutoTransmissionKind(Value: TAutoTransmissionKind);
    procedure SetAutoTransmissionKindAsByte(const Value: Byte);
    procedure SetAutoTransmissionKPD(Value: Single);
    procedure SetAutoId_Engine(Value: Integer);
    procedure SetAutoT_r(Value: Single);
    procedure SetAutoRmin(Value: Single);
    procedure SetAutoTyresCount(Value: Integer);
    procedure SetAutoLength(Value: Single);
    procedure SetAutoWidth(Value: Single);
    procedure SetAutoHeight(Value: Single);
    procedure SetExcavatorEngineNmax(Value: Single);
    //Экскаваторы
    procedure SetExcavatorBucketCapacity(Value: Single);
    procedure SetExcavatorCycleTime(Value: Single);
    procedure SetExcavatorId_Engine(Value: Integer);
    procedure SetExcavatorLength(Value: Single);
    procedure SetExcavatorWidth(Value: Single);
    procedure SetExcavatorHeight(Value: Single);
    //Экскаваторы списочного парка
    procedure SetDeportExcId_Excavator      (Value: Integer);
    procedure SetDeportExcEYear             (Value: Integer);
    procedure SetDeportExcWorkState         (Value: Boolean);
    procedure SetDeportExcCost              (Value: Single);
    procedure SetDeportExcFactCycleTime     (Value: Single);
    procedure SetDeportExcAddCostMaterials  (Value: Single);
    procedure SetDeportExcAddCostUnAccounted(Value: Single);
    procedure SetDeportExcEngineKIM         (Value: Single);
    procedure SetDeportExcEngineKPD         (Value: Single);
    procedure SetDeportSENExcAmortizationRate  (Value: Single);
    //Автосамосвалы списочного парка
    procedure SetDeportAutoId_Auto          (Value: Integer); 
    procedure SetDeportAutoAYear            (Value: Integer);
    procedure SetDeportAutoFactTonnage      (Value: Single);
    procedure SetDeportAutoWorkState        (Value: Boolean);
    procedure SetDeportAutoCost             (Value: Single);
    procedure SetDeportAutoAmortizationRate (Value: Single);
    procedure SetDeportAutoTransmissionKPD  (Value: Single);
    procedure SetDeportAutoEngineKPD        (Value: Single);
    procedure SetDeportAutoTyreCost         (Value: Single);
    procedure SetDeportAutoTyresRaceRate     (Value: Single);
    //Карьер
    procedure SetOpenpitId_Openpit(Value: Integer);
    //Характерные точки
    procedure SetPointZ(Value: Single);
    procedure SetPointMinDistance(Value: Byte);
    procedure SetPointColor(Value: TColor);
    procedure SetPointRadius(Value: Byte);   
    procedure SetPointMarkStyle(Value: TPointMarkStyle);   
    //Координатная сетка
    procedure SetCoordGridStyle(Value: TCoordGridStyle);
    procedure SetCoordGridStep(Value: Integer);
    procedure SetCoordGridMarks(Value: Boolean);
    //Блок-участки
    procedure SetBlockColor      (Index: TBlockKind; Value: TColor);
    function  GetBlockColor      (Index: TBlockKind): TColor;
    procedure SetBlockStripCount (Value: Byte);
    procedure SetBlockStripWidth (Value: Single);
    procedure SetBlockLoadingVmax(Value: Single);            
    procedure SetBlockUnLoadingVmax(Value: Single);            
    procedure SetBlockId_RoadCoat(Value: Integer);
    procedure SetBlockKind       (Value: TBlockKind);
    procedure SetBlockStyle      (Value: TBlockViewStyle);
    //Маршруты движения
    procedure SetCourseColor(Value: TColor);
    procedure SetCourseStyle(Value: TCourseViewStyle);
    //Горная порода
    procedure SetRockIsMineralWealth(Value: Boolean);
    //Пункты погрузки
    procedure SetLoadingPunktRockDensityInBlock (Value: Single);
    procedure SetLoadingPunktRockShatteringCoef (Value: Single);
    procedure SetLoadingPunktRockContent        (Value: Single);
    procedure SetLoadingPunktRockPlannedV1000m3(Value: Single);
    procedure SetLoadingPunktColor     (Value: TColor);
    procedure SetLoadingPunktRadiusCoef(Value: Integer);
    procedure SetLoadingPunktStyle     (Value: TPunktViewStyle);
    //Пункты разгрузки
    procedure SetUnLoadingPunktMaxV1000m3       (Value: Single);
    procedure SetUnLoadingPunktAutoMaxCount   (Value: Integer);
    procedure SetUnLoadingPunktKind           (Value: TUnLoadingPunktKind);
    procedure SetUnLoadingPunktRockRequiredContent(Value: Single);
    procedure SetUnLoadingPunktRockInitialContent (Value: Single);
    procedure SetUnLoadingPunktRockInitialV1000m3   (Value: Single);
    procedure SetUnLoadingPunktColor          (Value: TColor);
    procedure SetUnLoadingPunktRadiusCoef     (Value: Integer);
    procedure SetUnLoadingPunktStyle          (Value: TPunktViewStyle);
    //Пункты пересменки
    procedure SetShiftPunktColor(Value: TColor);
    procedure SetShiftPunktRadiusCoef(Value: Integer);
    procedure SetShiftPunktStyle(Value: TPunktViewStyle);
    //Дополнительные параметры
    procedure SetParamsTotalKurs(Value: Single);
    procedure SetParamsTotalExpenses(Value: Single);
    procedure SetParamsTotalSalaryCoef(Value: Single);
    procedure SetParamsTotalShiftUsingCoefNormal(Value: Single);
    procedure SetParamsTotalShiftUsingCoefDayShift(Value: Single);
    procedure SetParamsTotalShiftUsingCoefExplosion(Value: Single);
    procedure SetParamsTotalShiftUsingCoefExplosionCount(Value: Integer);
    procedure SetParamsExcavsSalaryMashinist0(Value: Single);
    procedure SetParamsExcavsSalaryMashinist1(Value: Single);
    procedure SetParamsExcavsSalaryAssistant0(Value: Single);
    procedure SetParamsExcavsSalaryAssistant1(Value: Single);
    procedure SetParamsExcavsWorkShiftsCount(Value: Integer);
    procedure SetParamsExcavsWorkShiftDuration(Value: Single);
    procedure SetParamsExcavsEnergyCost(Value: Single);
    procedure SetParamsExcavsAmortazationNorm(Value: Single);
    procedure SetParamsAutosSalary0(Value: Single);
    procedure SetParamsAutosSalary1(Value: Single);
    procedure SetParamsAutosWorkShiftsCount(Value: Integer);
    procedure SetParamsAutosWorkShiftDuration(Value: Single);
    procedure SetParamsAutosFuelCostWinter(Value: Single);
    procedure SetParamsAutosFuelCostSummer(Value: Single);
    procedure SetParamsAutosWinterMonthCount(Value: Integer);
    procedure SetParamsAutosFuelCostTarif(Value: TAutosFuelCostTarif);
    procedure SetParamsAutosSpares           (Value: Single);
    procedure SetParamsAutosGreasingSubstance(Value: Single);
    procedure SetParamsAutosMaintenanceCost  (Value: Single);
    procedure SetParamsRoadsBuildingCosts    (Value: Single);
    procedure SetParamsRoadsKeepingCosts     (Value: Single);
    procedure SetParamsRoadsAmortizationNorm (Value: Single);
    procedure SetParamsWorkRegimeKind(Value: TAutoWorkRegime);
    procedure SetParamsWorkRegimeIsStrippingCoefUsing(Value: Boolean);
    procedure SetParamsAutosShiftTurnoverTime(Value: Integer);
    procedure SetParamsExcavsShiftTurnoverTime(Value: Integer);
    procedure SetModelingParamsShiftDuration(Value: Integer);
    procedure SetModelingParamsPeriodDuration(Value: Integer);
    procedure SetModelingParamsIsAccumulateData(Value: Boolean);
    procedure SetModelingParamsAnimationTimeScale(Value: Integer);
  public
    property FileName: String read FFileName;
    //Двигатели
    property AutoEngineNmax: Single read FAutoEngineNmax write SetAutoEngineNmax;
    property ExcavatorEngineNmax: Single read FExcavatorEngineNmax write SetExcavatorEngineNmax;
    //Автосамосвалы
    property AutoBodySpace: Single read FAutoBodySpace write SetAutoBodySpace;
    property AutoTonnage: Single read FAutoTonnage write SetAutoTonnage;
    property AutoP: Single read FAutoP write SetAutoP;
    property AutoF: Single read FAutoF write SetAutoF;
    property AutoRo: Single read FAutoRo write SetAutoRo;
    property AutoTransmissionKind: TAutoTransmissionKind read FAutoTransmissionKind write SetAutoTransmissionKind;
    property AutoTransmissionKindAsByte: Byte write SetAutoTransmissionKindAsByte;
    property AutoTransmissionKPD: Single read FAutoTransmissionKPD write SetAutoTransmissionKPD;
    property AutoId_Engine: Integer read FAutoId_Engine write SetAutoId_Engine;
    property AutoT_r: Single read FAutoT_r write SetAutoT_r;
    property AutoRmin: Single read FAutoRmin write SetAutoRmin;
    property AutoTyresCount: Integer read FAutoTyresCount write SetAutoTyresCount;
    property AutoLength: Single read FAutoLength write SetAutoLength;
    property AutoWidth: Single read FAutoWidth write SetAutoWidth;
    property AutoHeight: Single read FAutoHeight write SetAutoHeight;
    //Экскаваторы
    property ExcavatorBucketCapacity: Single read FExcavatorBucketCapacity write SetExcavatorBucketCapacity;
    property ExcavatorCycleTime: Single read FExcavatorCycleTime write SetExcavatorCycleTime;
    property ExcavatorId_Engine: Integer read FExcavatorId_Engine write SetExcavatorId_Engine;
    property ExcavatorLength: Single read FExcavatorLength write SetExcavatorLength;
    property ExcavatorWidth: Single read FExcavatorWidth write SetExcavatorWidth;
    property ExcavatorHeight: Single read FExcavatorHeight write SetExcavatorHeight;
    //Экскаваторы списочного парка
    property DeportExcId_Excavator      : Integer read FDeportExcId_Excavator write SetDeportExcId_Excavator;
    property DeportExcEYear             : Integer read FDeportExcEYear write SetDeportExcEYear;
    property DeportExcWorkState         : Boolean read FDeportExcWorkState write SetDeportExcWorkState;
    property DeportExcCost              : Single read FDeportExcCost write SetDeportExcCost;
    property DeportExcFactCycleTime     : Single read FDeportExcFactCycleTime write SetDeportExcFactCycleTime;
    property DeportExcAddCostMaterials  : Single read FDeportExcAddCostMaterials write SetDeportExcAddCostMaterials;
    property DeportExcAddCostUnAccounted: Single read FDeportExcAddCostUnAccounted write SetDeportExcAddCostUnAccounted;
    property DeportExcEngineKIM         : Single read FDeportExcEngineKIM write SetDeportExcEngineKIM;
    property DeportExcEngineKPD         : Single read FDeportExcEngineKPD write SetDeportExcEngineKPD;
    property DeportSENExcAmortizationRate : Single read FDeportSENExcAmortizationRate write SetDeportSENExcAmortizationRate;

    //Автосамосвалы списочного парка
    property DeportAutoId_Auto          : Integer read FDeportAutoId_Auto write SetDeportAutoId_Auto;
    property DeportAutoAYear            : Integer read FDeportAutoAYear write SetDeportAutoAYear;
    property DeportAutoFactTonnage      : Single read FDeportAutoFactTonnage write SetDeportAutoFactTonnage;
    property DeportAutoWorkState        : Boolean read FDeportAutoWorkState write SetDeportAutoWorkState;
    property DeportAutoCost             : Single read FDeportAutoCost write SetDeportAutoCost;
    property DeportAutoAmortizationRate : Single read FDeportAutoAmortizationRate write SetDeportAutoAmortizationRate;
    property DeportAutoTransmissionKPD  : Single read FDeportAutoTransmissionKPD write SetDeportAutoTransmissionKPD;
    property DeportAutoEngineKPD        : Single read FDeportAutoEngineKPD write SetDeportAutoEngineKPD;
    property DeportAutoTyreCost         : Single read FDeportAutoTyreCost write SetDeportAutoTyreCost;
    property DeportAutoTyresRaceRate    : Single read FDeportAutoTyresRaceRate write SetDeportAutoTyresRaceRate;
    //Карьер
    property OpenpitId_Openpit: Integer read FOpenpitId_Openpit write SetOpenpitId_Openpit;
    //Характерные точки
    property PointZ          : Single read FPointZ write SetPointZ;
    property PointMinDistance: Byte read FPointMinDistance write SetPointMinDistance;
    property PointColor      : TColor read FPointColor write SetPointColor;
    property PointRadius     : Byte read FPointRadius write SetPointRadius;   
    property PointMarkStyle  : TPointMarkStyle read FPointMarkStyle write SetPointMarkStyle;   
    //Координатная сетка
    property CoordGridStyle: TCoordGridStyle read FCoordGridStyle write SetCoordGridStyle;
    property CoordGridStep : Integer read FCoordGridStep write SetCoordGridStep;
    property CoordGridMarks: Boolean read FCoordGridMarks write SetCoordGridMarks;
    //Блок-участки
    property BlockColors[Index: TBlockKind]: TColor read GetBlockColor write SetBlockColor;
    property BlockStripCount : Byte read FBlockStripCount write SetBlockStripCount;
    property BlockStripWidth : Single read FBlockStripWidth write SetBlockStripWidth;
    property BlockLoadingVmax       : Single read FBlockLoadingVmax write SetBlockLoadingVmax;
    property BlockUnLoadingVmax       : Single read FBlockUnLoadingVmax write SetBlockUnLoadingVmax;
    property BlockId_RoadCoat: Integer read FBlockId_RoadCoat write SetBlockId_RoadCoat;
    property BlockKind       : TBlockKind read FBlockKind write SetBlockKind;
    property BlockStyle      : TBlockViewStyle read FBlockStyle write SetBlockStyle;
    //Маршруты движения
    property CourseColor: TColor read FCourseColor write SetCourseColor;
    property CourseStyle: TCourseViewStyle read FCourseStyle write SetCourseStyle;
    //Горные породы
    property RockIsMineralWealth: Boolean read FRockIsMineralWealth write SetRockIsMineralWealth;
    //Пункты погрузки
    property LoadingPunktRockDensityInBlock : Single read FLoadingPunktRockDensityInBlock write SetLoadingPunktRockDensityInBlock;
    property LoadingPunktRockShatteringCoef : Single read FLoadingPunktRockShatteringCoef write SetLoadingPunktRockShatteringCoef;
    property LoadingPunktRockContent        : Single read FLoadingPunktRockContent write SetLoadingPunktRockContent;
    property LoadingPunktRockPlannedV1000m3 : Single read FLoadingPunktRockPlannedV1000m3 write SetLoadingPunktRockPlannedV1000m3;
    property LoadingPunktColor     : TColor read FLoadingPunktColor write SetLoadingPunktColor;
    property LoadingPunktRadiusCoef: Integer read FLoadingPunktRadiusCoef write SetLoadingPunktRadiusCoef;
    property LoadingPunktRadius    : Integer read FLoadingPunktRadius;
    property LoadingPunktStyle     : TPunktViewStyle read FLoadingPunktStyle write SetLoadingPunktStyle;
    //Пункты разгрузки
    property UnLoadingPunktMaxV1000m3       : Single read FUnLoadingPunktMaxV1000m3 write SetUnLoadingPunktMaxV1000m3;
    property UnLoadingPunktAutoMaxCount   : Integer read FUnLoadingPunktAutoMaxCount write SetUnLoadingPunktAutoMaxCount;
    property UnLoadingPunktKind           : TUnLoadingPunktKind read FUnLoadingPunktKind write SetUnLoadingPunktKind;
    property UnLoadingPunktRockRequiredContent: Single read FUnLoadingPunktRockRequiredContent write SetUnLoadingPunktRockRequiredContent;
    property UnLoadingPunktRockInitialContent : Single read FUnLoadingPunktRockInitialContent write SetUnLoadingPunktRockInitialContent;
    property UnLoadingPunktRockInitialV1000m3   : Single read FUnLoadingPunktRockInitialV1000m3 write SetUnLoadingPunktRockInitialV1000m3;
    property UnLoadingPunktColor          : TColor read FUnLoadingPunktColor write SetUnLoadingPunktColor;
    property UnLoadingPunktRadiusCoef     : Integer read FUnLoadingPunktRadiusCoef write SetUnLoadingPunktRadiusCoef;
    property UnLoadingPunktRadius         : Integer read FUnLoadingPunktRadius;
    property UnLoadingPunktStyle          : TPunktViewStyle read FUnLoadingPunktStyle write SetUnLoadingPunktStyle;
    //Пункты пересменки
    property ShiftPunktColor     : TColor read FShiftPunktColor write SetShiftPunktColor;
    property ShiftPunktRadiusCoef: Integer read FShiftPunktRadiusCoef write SetShiftPunktRadiusCoef;
    property ShiftPunktRadius    : Integer read FShiftPunktRadius;
    property ShiftPunktStyle     : TPunktViewStyle read FShiftPunktStyle write SetShiftPunktStyle;
    //Дополнительные параметры
    property ParamsTotalKurs: Single read FParamsTotalKurs write SetParamsTotalKurs;
    property ParamsTotalExpenses: Single read FParamsTotalExpenses write SetParamsTotalExpenses;
    property ParamsTotalSalaryCoef: Single read FParamsTotalSalaryCoef write SetParamsTotalSalaryCoef;
    property ParamsTotalShiftUsingCoefNormal: Single read FParamsTotalShiftUsingCoefNormal write SetParamsTotalShiftUsingCoefNormal;
    property ParamsTotalShiftUsingCoefDayShift: Single read FParamsTotalShiftUsingCoefDayShift write SetParamsTotalShiftUsingCoefDayShift;
    property ParamsTotalShiftUsingCoefExplosion: Single read FParamsTotalShiftUsingCoefExplosion write SetParamsTotalShiftUsingCoefExplosion;
    property ParamsTotalShiftUsingCoefExplosionCount: Integer read FParamsTotalShiftUsingCoefExplosionCount write SetParamsTotalShiftUsingCoefExplosionCount;
    property ParamsExcavsSalaryMashinist0: Single read FParamsExcavsSalaryMashinist0 write SetParamsExcavsSalaryMashinist0;
    property ParamsExcavsSalaryMashinist1: Single read FParamsExcavsSalaryMashinist1 write SetParamsExcavsSalaryMashinist1;
    property ParamsExcavsSalaryAssistant0: Single read FParamsExcavsSalaryAssistant0 write SetParamsExcavsSalaryAssistant0;
    property ParamsExcavsSalaryAssistant1: Single read FParamsExcavsSalaryAssistant1 write SetParamsExcavsSalaryAssistant1;
    property ParamsExcavsWorkShiftsCount: Integer read FParamsExcavsWorkShiftsCount write SetParamsExcavsWorkShiftsCount;
    property ParamsExcavsWorkShiftDuration: Single read FParamsExcavsWorkShiftDuration write SetParamsExcavsWorkShiftDuration;
    property ParamsExcavsEnergyCost: Single read FParamsExcavsEnergyCost write SetParamsExcavsEnergyCost;
    property ParamsExcavsAmortazationNorm: Single read FParamsExcavsAmortazationNorm write SetParamsExcavsAmortazationNorm;
    property ParamsAutosSalary0: Single read FParamsAutosSalary0 write SetParamsAutosSalary0;
    property ParamsAutosSalary1: Single read FParamsAutosSalary1 write SetParamsAutosSalary1;
    property ParamsAutosWorkShiftsCount: Integer read FParamsAutosWorkShiftsCount write SetParamsAutosWorkShiftsCount;
    property ParamsAutosWorkShiftDuration: Single read FParamsAutosWorkShiftDuration write SetParamsAutosWorkShiftDuration;
    property ParamsAutosFuelCostWinter: Single read FParamsAutosFuelCostWinter write SetParamsAutosFuelCostWinter;
    property ParamsAutosFuelCostSummer: Single read FParamsAutosFuelCostSummer write SetParamsAutosFuelCostSummer;
    property ParamsAutosWinterMonthCount: Integer read FParamsAutosWinterMonthCount write SetParamsAutosWinterMonthCount;
    property ParamsAutosFuelCostTarif: TAutosFuelCostTarif read FParamsAutosFuelCostTarif write SetParamsAutosFuelCostTarif;
    property ParamsAutosSpares           : Single read FParamsAutosSpares write SetParamsAutosSpares;
    property ParamsAutosGreasingSubstance: Single read FParamsAutosGreasingSubstance write SetParamsAutosGreasingSubstance;
    property ParamsAutosMaintenanceCost  : Single read FParamsAutosMaintenanceCost write SetParamsAutosMaintenanceCost;
    property ParamsRoadsBuildingCosts    : Single read FParamsRoadsBuildingCosts write SetParamsRoadsBuildingCosts;
    property ParamsRoadsKeepingCosts     : Single read FParamsRoadsKeepingCosts write SetParamsRoadsKeepingCosts;
    property ParamsRoadsAmortizationNorm : Single read FParamsRoadsAmortizationNorm write SetParamsRoadsAmortizationNorm;
    property ParamsWorkRegimeKind        : TAutoWorkRegime read FParamsWorkRegimeKind write SetParamsWorkRegimeKind;
    property ParamsWorkRegimeIsStrippingCoefUsing: Boolean read FParamsWorkRegimeIsStrippingCoefUsing write SetParamsWorkRegimeIsStrippingCoefUsing;
    property ParamsAutosShiftTurnoverTime: Integer read FParamsAutosShiftTurnoverTime write SetParamsAutosShiftTurnoverTime;
    property ParamsExcavsShiftTurnoverTime: Integer read FParamsExcavsShiftTurnoverTime write SetParamsExcavsShiftTurnoverTime;
    property ModelingParamsShiftDuration: Integer read FModelingParamsShiftDuration write SetModelingParamsShiftDuration;
    property ModelingParamsPeriodDuration: Integer read FModelingParamsPeriodDuration write SetModelingParamsPeriodDuration;
    property ModelingParamsIsAccumulateData: Boolean read FModelingParamsIsAccumulateData write SetModelingParamsIsAccumulateData;
    property ModelingParamsAnimationTimeScale: Integer read FModelingParamsAnimationTimeScale write SetModelingParamsAnimationTimeScale;

    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile;
    procedure SaveToFile;
    //Сохранение параметров списочного парка автосамосвалов
    procedure SaveAutoParams(
      const AId_AutoModel,AYear      : Integer;
      const AWorkState               : Boolean;
      const AQtn,ABalanceC1000tg     : Single;
      const AAmortizationR1000km     : Single;
      const ATransmissionKPD         : Single;
      const AEngineKPD               : Single;
      const ATyreC1000tg             : Single;
      const ATyresAmortizationR1000km: Single);
  end;{TDBDefaultParams}
implementation
uses Math, DateUtils, SysUtils, Forms, IniFiles;
//TDBDefaultParams - класс "Параметры" --------------------------------------------------------
procedure TDBDefaultParams.SetAutoEngineNmax(Value: Single);
begin
  if (FAutoEngineNmax<>Value)and(Value>=1.0)then
  begin
    FAutoEngineNmax := Value;
    SaveToFile;
  end;{if}
end;{SetAutoEngineNmax}
procedure TDBDefaultParams.SetAutoBodySpace(Value: Single);
begin
  if (FAutoBodySpace<>Value)and(Value>=1.0)then
  begin
    FAutoBodySpace := Value;
    SaveToFile;
  end;{if}
end;{SetAutoBodySpace}
procedure TDBDefaultParams.SetAutoTonnage(Value: Single);
begin
  if (FAutoTonnage<>Value)and(Value>=1.0)then
  begin
    FAutoTonnage := Value;
    SaveToFile;
  end;{if}
end;{SetAutoTonnage}
procedure TDBDefaultParams.SetAutoP(Value: Single);
begin
  if (FAutoP<>Value)and(Value>=1.0)then
  begin
    FAutoP := Value;
    SaveToFile;
  end;{if}
end;{SetAutoP}
procedure TDBDefaultParams.SetAutoF(Value: Single);
begin
  if (FAutoF<>Value)and(Value>=1.0)then
  begin
    FAutoF := Value;
    SaveToFile;
  end;{if}
end;{SetAutoF}
procedure TDBDefaultParams.SetAutoRo(Value: Single);
begin
  if (FAutoRo<>Value)and(Value>=0.0)and(Value<=1.0)then
  begin
    FAutoRo := Value;
    SaveToFile;
  end;{if}
end;{SetAutoF}
procedure TDBDefaultParams.SetAutoTransmissionKind(Value: TAutoTransmissionKind);
begin
  if FAutoTransmissionKind<>Value then
  begin
    FAutoTransmissionKind := Value;
    SaveToFile;
  end;{if}
end;{SetAutoTransmissionKind}
procedure TDBDefaultParams.SetAutoTransmissionKindAsByte(const Value: Byte);
begin
  if Value in [0..1] then
  if Byte(FAutoTransmissionKind)<>Value then
  begin
    FAutoTransmissionKind := TAutoTransmissionKind(Value);
    SaveToFile;
  end;{if}
end;{SetAutoTransmissionKindAsByte}
procedure TDBDefaultParams.SetAutoTransmissionKPD(Value: Single);
begin
  if (FAutoTransmissionKPD<>Value)and(InRange(Value,0.0,1.0))then
  begin
    FAutoTransmissionKPD := Value;
    SaveToFile;
  end;{if}
end;{SetAutoTransmissionKPD}
procedure TDBDefaultParams.SetAutoId_Engine(Value: Integer);
begin
  if (FAutoId_Engine<>Value)and(Value>0)then
  begin
    FAutoId_Engine := Value;
    SaveToFile;
  end;{if}
end;{SetAutoId_Engine}
procedure TDBDefaultParams.SetAutoT_r(Value: Single);
begin
  if (FAutoT_r<>Value)and(Value>0.0)then
  begin
    FAutoT_r := Value;
    SaveToFile;
  end;{if}
end;{SetAutoT_r}
procedure TDBDefaultParams.SetAutoRmin(Value: Single);
begin
  if (FAutoRmin<>Value)and(Value>=0.0)then {?}
  begin
    FAutoRmin := Value;
    SaveToFile;
  end;{if}
end;{SetAutoRmin}
procedure TDBDefaultParams.SetAutoTyresCount(Value: Integer);
begin
  if (FAutoTyresCount<>Value)and(Value>0)then
  begin
    FAutoTyresCount := Value;
    SaveToFile;
  end;{if}
end;{SetAutoTyresCount}
procedure TDBDefaultParams.SetAutoLength(Value: Single);
begin
  if (FAutoLength<>Value)and(Value>=1.0)then
  begin
    FAutoLength := Value;
    SaveToFile;
  end;{if}
end;{SetAutoLength}
procedure TDBDefaultParams.SetAutoWidth(Value: Single);
begin
  if (FAutoWidth<>Value)and(Value>=1.0)then
  begin
    FAutoWidth := Value;
    SaveToFile;
  end;{if}
end;{SetAutoWidth}
procedure TDBDefaultParams.SetAutoHeight(Value: Single);
begin
  if (FAutoHeight<>Value)and(Value>=1.0)then
  begin
    FAutoHeight := Value;
    SaveToFile;
  end;{if}
end;{SetAutoHeight}
procedure TDBDefaultParams.SetExcavatorEngineNmax(Value: Single);
begin
  if (FExcavatorEngineNmax<>Value)and(Value>=1.0)then
  begin
    FExcavatorEngineNmax := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorEngineNmax}
constructor TDBDefaultParams.Create;
begin
  inherited;
  //данные по умолчанию заданы для БЕЛАЗ-548
  FAutoEngineNmax       := 405.0;
  FAutoBodySpace        := 26.0;
  FAutoTonnage          := 42.0;
  FAutoP                := 29.5;
  FAutoF                := 10.0; {?}
  FAutoRo               := 0.4; {?}
  FAutoTransmissionKind := atkGM;
  FAutoTransmissionKPD  := 0.78;
  FAutoId_Engine        := 0;
  FAutoT_r              := 78.0;
  FAutoRmin             := 10.2; 
  FAutoTyresCount       := 6;
  FAutoLength           := 12.54;
  FAutoWidth            := 4.0;
  FAutoHeight           := 3.95;

  //данные по умолчанию заданы для ЭКГ-12.5
  FExcavatorEngineNmax     := 1250.0;
  FExcavatorBucketCapacity := 12.5;
  FExcavatorCycleTime      := 32.0;
  FExcavatorId_Engine      := 0;
  FExcavatorLength         := 15.0;
  FExcavatorWidth          := 10.0;
  FExcavatorHeight         := 12.0;
  //Экскаваторы списочного парка
  FDeportExcId_Excavator      := 0;
  FDeportExcEYear             := YearOf(Now);
  FDeportExcWorkState         := true;
  FDeportExcCost              := 1000000.00;
  FDeportExcFactCycleTime     := 30.0;
  FDeportExcAddCostMaterials  := 0.0;
  FDeportExcAddCostUnAccounted:= 0.0;
  FDeportExcEngineKIM         := 0.25;
  FDeportExcEngineKPD         := 0.936;
  FDeportSENExcAmortizationRate := 0.65;
  //Автосамосвалы списочного парка
  FDeportAutoId_Auto          := 0;
  FDeportAutoAYear            := YearOf(Now);
  FDeportAutoFactTonnage      := 30.0;
  FDeportAutoWorkState        := true;
  FDeportAutoCost             := 1000000.00;
  FDeportAutoAmortizationRate := 0.65;
  FDeportAutoTransmissionKPD  := 0.78;
  FDeportAutoEngineKPD        := 0.65;
  FDeportAutoTyreCost         := 1000000.00;
  FDeportAutoTyresRaceRate     := 35.00;
  //Карьер
  FOpenpitId_Openpit:= 0;
  //Характерные точки
  FPointZ           := 520.0;
  FPointMinDistance := 1;
  FPointRadius      := 2;
  FPointColor       := clBlue;
  FPointMarkStyle   := pmsNone;
  //Координатная сетка
  FCoordGridStyle := cgsCross;
  FCoordGridStep := 200;
  FCoordGridMarks := true;
  //Параметры блок-участков
  FBlockColors[bukMoving]   := clMaroon;
  FBlockColors[bukRoadDown] := clRed;
  FBlockColors[bukManeuver] := clYellow;
  FBlockColors[bukCrossRoad]:= clAqua;
  FBlockStripCount := 2;
  FBlockStripWidth := 12.5;
  FBlockLoadingVmax       := 20.0;
  FBlockUnLoadingVmax       := 40.0;
  FBlockId_RoadCoat:= 0;
  FBlockKind       := bukMoving;
  FBlockStyle      := bvsNone;
  //Маршруты
  FCourseColor := clWhite;
  FCourseStyle := cvsNone;
  //Тип горной породы
  FRockIsMineralWealth := true;

  //Пункты погрузки
  FLoadingPunktRockDensityInBlock := 2.20;
  FLoadingPunktRockShatteringCoef := 1.1;
  FLoadingPunktRockContent        := 3.2;
  FLoadingPunktRockPlannedV1000m3 := 4.0;
  FLoadingPunktColor              := clGreen;
  FLoadingPunktRadiusCoef         := 4;
  FLoadingPunktStyle              := pvsNone;
  //Пункты разгрузки
  FUnLoadingPunktMaxV1000m3       := 1000000.0;
  FUnLoadingPunktAutoMaxCount   := 3;
  FUnLoadingPunktKind           := ulpkFactory;
  FUnLoadingPunktRockRequiredContent:= 3.2;
  FUnLoadingPunktRockInitialContent := 0.0;
  FUnLoadingPunktRockInitialV1000m3   := 0.0;
  FUnLoadingPunktColor          := clBlue;
  FUnLoadingPunktRadiusCoef     := 4;
  FUnLoadingPunktStyle          := pvsNone;
  //Пункты пересменки
  FShiftPunktColor := clYellow;
  FShiftPunktRadiusCoef:= 4;
  FShiftPunktStyle := pvsNone;
  FLoadingPunktRadius := FLoadingPunktRadiusCoef*FPointRadius;
  FUnLoadingPunktRadius := FUnLoadingPunktRadiusCoef*FPointRadius;
  FShiftPunktRadius := FShiftPunktRadiusCoef*FPointRadius;
  //Дополнительные параметры
  FParamsTotalKurs := 146.8;
  FParamsTotalExpenses := 2000.0;
  FParamsTotalSalaryCoef := 1.26;
  FParamsTotalShiftUsingCoefNormal := 1.0;
  FParamsTotalShiftUsingCoefDayShift := 0.65;
  FParamsTotalShiftUsingCoefExplosion := 0.30;
  FParamsTotalShiftUsingCoefExplosionCount := 1;
  FParamsExcavsSalaryMashinist0 := 30.0;
  FParamsExcavsSalaryMashinist1 := 10.00;
  FParamsExcavsSalaryAssistant0 := 20.00;
  FParamsExcavsSalaryAssistant1 := 5.00;
  FParamsExcavsWorkShiftsCount := 60;
  FParamsExcavsWorkShiftDuration := 12.00;
  FParamsExcavsEnergyCost := 2.00;
  FParamsExcavsAmortazationNorm := 0.07;
  FParamsAutosSalary0 := 30.00;
  FParamsAutosSalary1 := 0.00;
  FParamsAutosWorkShiftsCount := 90;
  FParamsAutosWorkShiftDuration := 8.00;
  FParamsAutosFuelCostWinter := 40.00;
  FParamsAutosFuelCostSummer := 36.00;
  FParamsAutosWinterMonthCount := 7;
  FParamsAutosFuelCostTarif := afctAverage;
  FParamsAutosSpares := 30.00;
  FParamsAutosGreasingSubstance := 30.00;
  FParamsAutosMaintenanceCost := 30.00;
  FParamsRoadsBuildingCosts := 100.00;
  FParamsRoadsKeepingCosts := 100.00;
  FParamsRoadsAmortizationNorm := 0.10;
  FParamsWorkRegimeKind := awrQualityAveraging;
  FParamsWorkRegimeIsStrippingCoefUsing := true;
  FParamsAutosShiftTurnoverTime := 30;
  FParamsExcavsShiftTurnoverTime := 0;
  FModelingParamsShiftDuration := 720;
  FModelingParamsPeriodDuration := 180;
  FModelingParamsIsAccumulateData := true;
  FModelingParamsAnimationTimeScale := 1;
  

  FFileName := ChangeFileExt(Application.ExeName,'.ini');
  LoadFromFile;
end;{Create}
destructor TDBDefaultParams.Destroy;
begin
  SaveToFile;
  inherited;
end;{Destroy}
procedure TDBDefaultParams.LoadFromFile;
const
  sAu='Автосамосвалы';
  sEn='Двигатели';
  sEx='Экскаваторы';
  sDE='Экскаваторы списочного парка';
  sDA='Автосамосвалы списочного парка';
  sOp='Карьер';
  sPo='Характерные точки';
  sCG='Координатная сетка';
  sBU='Блок-участки';
  sCo='Маршруты';
  sRo='Горная порода';
  sLP='Пункты погрузки';
  sUP='Пункты разгрузки';
  sSP='Пункты пересменки';
  sDP='Дополнительные параметры';
  sMP='Параметры моделирования';
var IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(FFileName);
  try
    with IniFile do
    begin
      //Note: по умолчанию заданы параметры автосамосвала "БелАЗ-548".
      //Двигатели
      FAutoEngineNmax := ReadInteger(sEn,'AutoEngineNmax',40500)*0.01;
      //Автосамосвалы
      FAutoBodySpace        := ReadInteger(sAu,'AutoBodySpace',260)*0.1;
      FAutoTonnage          := ReadInteger(sAu,'AutoTonnage',4200)*0.01;
      FAutoP                := ReadInteger(sAu,'AutoP',2950)*0.01;
      FAutoF                := ReadInteger(sAu,'AutoF',1000)*0.01;
      FAutoRo               := ReadInteger(sAu,'AutoRo',40)*0.01;
      FAutoTransmissionKind := TAutoTransmissionKind(ReadInteger(sAu,'AutoTransmissionKind',Integer(atkGM)));
      FAutoTransmissionKPD  := ReadInteger(sAu,'AutoTransmissionKPD',78)*0.01;
      FAutoId_Engine        := ReadInteger(sAu,'AutoId_Engine',0);
      FAutoT_r              := ReadInteger(sAu,'AutoT_r',7800)*0.01;
      FAutoRmin             := ReadInteger(sAu,'AutoRmin',1020)*0.01;
      FAutoTyresCount       := ReadInteger(sAu,'AutoTyresCount',6);
      FAutoLength          := ReadInteger(sAu,'AutoLength',1254)*0.01;
      FAutoWidth           := ReadInteger(sAu,'AutoWidth',400)*0.01;
      FAutoHeight          := ReadInteger(sAu,'AutoHeight',395)*0.01;
      //Note: данные по умолчанию заданы для ЭКГ-12.5
      //Двигатели
      FExcavatorEngineNmax := ReadInteger(sEn,'ExcavatorEngineNmax',125000)*0.01;
      //Экскаваторы
      FExcavatorBucketCapacity  := ReadInteger(sEx,'ExcavatorBucketCapacity',1250)*0.01;
      FExcavatorCycleTime       := ReadInteger(sEx,'ExcavatorCycleTime',3200)*0.01;
      FExcavatorId_Engine       := ReadInteger(sEx,'ExcavatorId_Engine',0);
      FExcavatorLength          := ReadInteger(sEx,'ExcavatorLength',1500)*0.01;
      FExcavatorWidth           := ReadInteger(sEx,'ExcavatorWidth',1000)*0.01;
      FExcavatorHeight          := ReadInteger(sEx,'ExcavatorHeight',1200)*0.01;
      //Экскаваторы списочного парка
      FDeportExcId_Excavator      := ReadInteger(sDE,'DeportExcId_Excavator',0);
      FDeportExcEYear             := ReadInteger(sDE,'DeportExcEYear',YearOf(Now));
      FDeportExcWorkState         := ReadBool(sDE,'DeportExcWorkState',true);
      FDeportExcCost              := ReadInteger(sDE,'DeportExcCost',100000000)*0.01;
      FDeportExcFactCycleTime     := ReadInteger(sDE,'DeportExcFactCycleTime',3000)*0.01;
      FDeportExcAddCostMaterials  := ReadInteger(sDE,'DeportExcAddCostMaterials',0);
      FDeportExcAddCostUnAccounted:= ReadInteger(sDE,'DeportExcAddCostUnAccounted',0);
      FDeportExcEngineKIM         := ReadInteger(sDE,'DeportExcEngineKIM',25)*0.01;
      FDeportExcEngineKPD         := ReadInteger(sDE,'DeportExcEngineKPD',936)*0.001;
      FDeportSENExcAmortizationRate  := ReadInteger(sDE,'DeportSENExcAmortizationRate',65)*0.0001;
      //Автосамосвалы списочного парка
      FDeportAutoId_Auto           := ReadInteger(sDA,'DeportAutoId_Auto',0);
      FDeportAutoAYear             := ReadInteger(sDA,'DeportAutoAYear',YearOf(Now));
      FDeportAutoWorkState         := ReadBool(sDA,'DeportAutoWorkState',true);
      FDeportAutoCost              := ReadInteger(sDA,'DeportAutoCost',100000000)*0.01;
      FDeportAutoFactTonnage       := ReadInteger(sDA,'DeportAutoFactTonnage',3000)*0.01;
      FDeportAutoAmortizationRate  := ReadInteger(sDA,'DeportAutoAmortizationRate',65)*0.0001;
      FDeportAutoTransmissionKPD   := ReadInteger(sDA,'DeportAutoTransmissionKPD',78)*0.01;
      FDeportAutoEngineKPD         := ReadInteger(sDA,'DeportAutoEngineKPD',65)*0.01;
      FDeportAutoTyreCost          := ReadInteger(sDA,'DeportAutoTyreCost',100000000)*0.01;
      FDeportAutoTyresRaceRate     := ReadInteger(sDA,'DeportAutoTyresRaceRate',3500)*0.01;
      //Карьер
      FOpenpitId_Openpit := ReadInteger(sOp,'OpenpitId_Openpit',0);
      //Характерные точки
      FPointZ            := ReadInteger(sPo,'PointZ',520000)*0.001;
      FPointColor        := ReadInteger(sPo,'PointColor',Integer(clBlue));
      FPointMinDistance  := ReadInteger(sPo,'PointMinDistance',1);
      FPointRadius       := ReadInteger(sPo,'PointRadius',2);
      FPointMarkStyle    := TPointMarkStyle(ReadInteger(sPo,'PointMarkStyle',Integer(pmsNone)));
      //Параметры дизайна карьерного пространства
      FCoordGridStyle := TCoordGridStyle(ReadInteger(sCG,'CoordGridStyle',Integer(cgsCross)));
      FCoordGridStep  := ReadInteger(sCG,'CoordGridStep',200);
      FCoordGridMarks := ReadInteger(sCG,'CoordGridMarks',1)<>0;
      //Блок-участки
      FBlockColors[bukMoving]   := TColor(ReadInteger(sBU,'BlockColorMoving',Integer(clMaroon)));
      FBlockColors[bukRoadDown] := TColor(ReadInteger(sBU,'BlockColorRoadDown',Integer(clRed)));
      FBlockColors[bukManeuver] := TColor(ReadInteger(sBU,'BlockColorManeuver',Integer(clYellow)));
      FBlockColors[bukCrossRoad] := TColor(ReadInteger(sBU,'BlockColorCrossRoad',Integer(clLime)));
      FBlockStripCount := ReadInteger(sBU,'BlockStripCount',2);
      FBlockStripWidth := ReadInteger(sBU,'BlockStripWidth',125)*0.1;
      FBlockLoadingVmax       := ReadInteger(sBU,'BlockLoadingVmax',400)*0.1;
      FBlockUnLoadingVmax       := ReadInteger(sBU,'BlockUnLoadingVmax',400)*0.1;
      FBlockId_RoadCoat:= ReadInteger(sBU,'BlockId_RoadCoat',0);
      FBlockKind       := TBlockKind(ReadInteger(sBU,'BlockKind',Integer(bukMoving)));
      FBlockStyle      := TBlockViewStyle(ReadInteger(sBU,'BlockStyle',Integer(bvsReal)));
      //Маршруты
      FCourseColor := TColor(ReadInteger(sCo,'CourseColor',Integer(clWhite)));
      FCourseStyle := TCourseViewStyle(ReadInteger(sCo,'CourseStyle',Integer(clNone)));
      //Горные породы
      FRockIsMineralWealth := ReadBool(sRo,'RockIsMineralWealth',true);
      FLoadingPunktRockDensityInBlock:= ReadInteger(sRo,'LoadingPunktRockDensityInBlock',220)*0.01;
      FLoadingPunktRockShatteringCoef:= ReadInteger(sRo,'LoadingPunktRockShatteringCoef',110)*0.01;
      FLoadingPunktRockContent       := ReadInteger(sRo,'LoadingPunktRockContent',32)*0.1;
      //Пункты погрузки
      FLoadingPunktRockPlannedV1000m3:= ReadInteger(sLP,'LoadingPunktRockPlannedV1000m3',40)*0.1;
      FLoadingPunktColor     := ReadInteger(sLP,'LoadingPunktColor',Integer(clGreen));
      FLoadingPunktRadiusCoef:= ReadInteger(sLP,'LoadingPunktRadiusCoef',4);
      FLoadingPunktStyle     := TPunktViewStyle(ReadInteger(sLP,'LoadingPunktStyle',Integer(pvsNone)));
      //Пункты разгрузки
      FUnLoadingPunktMaxV1000m3       := ReadInteger(sUP,'UnLoadingPunktMaxV1000m3',1000)*0.1;
      FUnLoadingPunktAutoMaxCount   := ReadInteger(sUP,'UnLoadingPunktAutoMaxCount',3);
      FUnLoadingPunktKind           := TUnLoadingPunktKind(ReadInteger(sUP,'UnLoadingPunktKind',Integer(ulpkFactory)));
      FUnLoadingPunktRockRequiredContent:= ReadInteger(sUP,'UnLoadingPunktRockRequiredContent',32)*0.1;
      FUnLoadingPunktRockInitialContent := ReadInteger(sUP,'UnLoadingPunktRockInitialContent',0);
      FUnLoadingPunktRockInitialV1000m3   := ReadInteger(sUP,'UnLoadingPunktRockInitialV1000m3',0);
      FUnLoadingPunktColor          := ReadInteger(sUP,'UnLoadingPunktColor',Integer(clBlue));
      FUnLoadingPunktRadiusCoef     := ReadInteger(sUP,'UnLoadingPunktRadiusCoef',4);
      FUnLoadingPunktStyle          := TPunktViewStyle(ReadInteger(sUP,'UnLoadingPunktStyle',Integer(pvsNone)));
      //Пункты пересменки
      FShiftPunktColor     := ReadInteger(sSP,'ShiftPunktColor',Integer(clYellow));
      FShiftPunktRadiusCoef:= ReadInteger(sSP,'ShiftPunktRadiusCoef',4);
      FShiftPunktStyle     := TPunktViewStyle(ReadInteger(sSP,'ShiftPunktStyle',Integer(pvsNone)));
      //Дополнительные параметры
      FParamsTotalKurs := ReadInteger(sDP,'ParamsTotalKurs',14680)*0.01;
      FParamsTotalExpenses := ReadInteger(sDP,'ParamsTotalExpenses',200000)*0.01;
      FParamsTotalSalaryCoef := ReadInteger(sDP,'ParamsTotalSalaryCoef',1260)*0.001;
      FParamsTotalShiftUsingCoefNormal := ReadInteger(sDP,'ParamsTotalShiftUsingCoefNormal',1000)*0.001;
      FParamsTotalShiftUsingCoefDayShift := ReadInteger(sDP,'ParamsTotalShiftUsingCoefDayShift',0650)*0.001;
      FParamsTotalShiftUsingCoefExplosion := ReadInteger(sDP,'ParamsTotalShiftUsingCoefExplosion',0300)*0.001;
      FParamsTotalShiftUsingCoefExplosionCount := ReadInteger(sDP,'ParamsTotalShiftUsingCoefExplosionCount',1);
      FParamsExcavsSalaryMashinist0 := ReadInteger(sDP,'ParamsExcavsSalaryMashinist0',3000)*0.01;
      FParamsExcavsSalaryMashinist1 := ReadInteger(sDP,'ParamsExcavsSalaryMashinist1',1000)*0.01;
      FParamsExcavsSalaryAssistant0 := ReadInteger(sDP,'ParamsExcavsSalaryAssistant0',2000)*0.01;
      FParamsExcavsSalaryAssistant1 := ReadInteger(sDP,'ParamsExcavsSalaryAssistant1',500)*0.01;
      FParamsExcavsWorkShiftsCount := ReadInteger(sDP,'ParamsExcavsWorkShiftsCount',60);
      FParamsExcavsWorkShiftDuration := ReadInteger(sDP,'ParamsExcavsWorkShiftDuration',1200)*0.01;
      FParamsExcavsEnergyCost := ReadInteger(sDP,'ParamsExcavsEnergyCost',200)*0.01;
      FParamsExcavsAmortazationNorm := ReadInteger(sDP,'ParamsExcavsAmortazationNorm',0070)*0.001;
      FParamsAutosSalary0 := ReadInteger(sDP,'ParamsAutosSalary0',3000)*0.01;
      FParamsAutosSalary1 := ReadInteger(sDP,'ParamsAutosSalary1',000)*0.01;
      FParamsAutosWorkShiftsCount := ReadInteger(sDP,'ParamsAutosWorkShiftsCount',90);
      FParamsAutosWorkShiftDuration := ReadInteger(sDP,'ParamsAutosWorkShiftDuration',800)*0.01;
      FParamsAutosFuelCostWinter := ReadInteger(sDP,'ParamsAutosFuelCostWinter',4000)*0.01;
      FParamsAutosFuelCostSummer := ReadInteger(sDP,'ParamsAutosFuelCostSummer',3600)*0.01;
      FParamsAutosWinterMonthCount := ReadInteger(sDP,'ParamsAutosWinterMonthCount',7);
      FParamsAutosFuelCostTarif := TAutosFuelCostTarif(ReadInteger(sDP,'ParamsAutosFuelCostTarif',Integer(afctAverage)));
      FParamsAutosShiftTurnoverTime := ReadInteger(sDP,'ParamsAutosShiftTurnoverTime',30);
      FParamsExcavsShiftTurnoverTime := ReadInteger(sDP,'ParamsExcavsShiftTurnoverTime',0);

      FParamsAutosSpares := ReadInteger(sDP,'ParamsAutosSpares',3000)*0.01;
      FParamsAutosGreasingSubstance := ReadInteger(sDP,'ParamsAutosGreasingSubstance',3000)*0.01;
      FParamsAutosMaintenanceCost := ReadInteger(sDP,'ParamsAutosMaintenanceCost',3000)*0.01;
      FParamsRoadsBuildingCosts := ReadInteger(sDP,'ParamsRoadsBuildingCosts',10000)*0.01;
      FParamsRoadsKeepingCosts := ReadInteger(sDP,'ParamsRoadsKeepingCosts',10000)*0.01;
      FParamsRoadsAmortizationNorm := ReadInteger(sDP,'ParamsRoadsAmortizationNorm',0100)*0.001;

      FParamsWorkRegimeKind := TAutoWorkRegime(ReadInteger(sDP,'ParamsWorkRegimeKind',Integer(awrQualityAveraging)));
      FParamsWorkRegimeIsStrippingCoefUsing := ReadBool(sDP,'ParamsWorkRegimeIsStrippingCoefUsing',true);
      
      FModelingParamsShiftDuration := ReadInteger(sMP,'ModelingParamsShiftDuration',720);
      FModelingParamsPeriodDuration := ReadInteger(sMP,'ModelingParamsPeriodDuration',180);
      FModelingParamsIsAccumulateData := ReadBool(sMP,'ModelingParamsIsAccumulateData',true);
      FModelingParamsAnimationTimeScale := ReadInteger(sMP,'ModelingParamsAnimationTimeScale',1);
    end;{with}
  finally
    IniFile.Free;
  end;{try}
  FLoadingPunktRadius := FLoadingPunktRadiusCoef*FPointRadius;
  FUnLoadingPunktRadius := FUnLoadingPunktRadiusCoef*FPointRadius;
  FShiftPunktRadius := FShiftPunktRadiusCoef*FPointRadius;
end;{LoadFromFile}
procedure TDBDefaultParams.SaveToFile;
const
  sAu='Автосамосвалы';
  sEn='Двигатели';
  sEx='Экскаваторы';
  sDE='Экскаваторы списочного парка';
  sDA='Автосамосвалы списочного парка';
  sOp='Карьер';
  sPo='Характерные точки';
  sCG='Координатная сетка';
  sBU='Блок-участки';
  sCo='Маршруты';
  sRo='Горная порода';
  sLP='Пункты погрузки';
  sUP='Пункты разгрузки';
  sSP='Пункты пересменки';
  sDP='Дополнительные параметры';
  sMP='Параметры моделирования';
var IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(FFileName);
  try
    with IniFile do
    begin
      //Note: по умолчанию заданы параметры автосамосвала "БелАЗ-548".
      //Двигатели
      WriteInteger(sEn,'AutoEngineNmax',Round(100*FAutoEngineNmax));
      //Автосамосвалы
      WriteInteger(sAu,'AutoBodySpace',Round(10*FAutoBodySpace));
      WriteInteger(sAu,'AutoTonnage',Round(100*FAutoTonnage));
      WriteInteger(sAu,'AutoP',Round(100*FAutoP));
      WriteInteger(sAu,'AutoF',Round(100*FAutoF));
      WriteInteger(sAu,'AutoRo',Round(100*FAutoRo));
      WriteInteger(sAu,'AutoTransmissionKind',Integer(FAutoTransmissionKind));
      WriteInteger(sAu,'AutoTransmissionKPD',Round(100*FAutoTransmissionKPD));
      WriteInteger(sAu,'AutoId_Engine',AutoId_Engine);
      WriteInteger(sAu,'AutoT_r',Round(100*FAutoT_r));
      WriteInteger(sAu,'AutoRmin',Round(100*FAutoRmin));
      WriteInteger(sAu,'AutoTyresCount',AutoTyresCount);
      WriteInteger(sAu,'AutoLength',Round(100*FAutoLength));
      WriteInteger(sAu,'AutoWidth',Round(100*FAutoWidth));
      WriteInteger(sAu,'AutoHeight',Round(100*FAutoHeight));

      //Note: данные по умолчанию заданы для ЭКГ-12.5
      //Двигатели
      WriteInteger(sEn,'ExcavatorEngineNmax',Round(100*FExcavatorEngineNmax));
      //Экскаваторы
      WriteInteger(sEx,'ExcavatorBucketCapacity',Round(100*FExcavatorBucketCapacity));
      WriteInteger(sEx,'ExcavatorCycleTime',Round(100*FExcavatorCycleTime));
      WriteInteger(sEx,'ExcavatorId_Engine',ExcavatorId_Engine);
      WriteInteger(sEx,'ExcavatorLength',Round(100*FExcavatorLength));
      WriteInteger(sEx,'ExcavatorWidth',Round(100*FExcavatorWidth));
      WriteInteger(sEx,'ExcavatorHeight',Round(100*FExcavatorHeight));
      //Автосамосвалы списочного парка
      WriteInteger(sDA,'DeportAutoId_Auto',FDeportAutoId_Auto);
      WriteInteger(sDA,'DeportAutoAYear',FDeportAutoAYear);
      WriteBool(sDA,'DeportAutoWorkState',FDeportAutoWorkState);
      WriteInteger(sDA,'DeportAutoCost',Round(100*FDeportAutoCost));
      WriteInteger(sDA,'DeportAutoFactTonnage',Round(100*FDeportAutoFactTonnage));
      WriteInteger(sDA,'DeportAutoAmortizationRate',Round(10000*FDeportAutoAmortizationRate));
      WriteInteger(sDA,'DeportAutoTransmissionKPD',Round(100*FDeportAutoTransmissionKPD));
      WriteInteger(sDA,'DeportAutoEngineKPD',Round(100*FDeportAutoEngineKPD));
      WriteInteger(sDA,'DeportAutoTyreCost',Round(100*FDeportAutoTyreCost));
      WriteInteger(sDA,'DeportAutoTyresRaceRate',Round(100*FDeportAutoTyresRaceRate));
      //Экскаваторы списочного парка
      WriteInteger(sDE,'DeportExcId_Excavator',FDeportExcId_Excavator);
      WriteInteger(sDE,'DeportExcEYear',FDeportExcEYear);
      WriteBool(sDE,'DeportExcWorkState',FDeportExcWorkState);
      WriteInteger(sDE,'DeportExcCost',Round(100*FDeportExcCost));
      WriteInteger(sDE,'DeportExcFactCycleTime',Round(100*FDeportExcFactCycleTime));
      WriteInteger(sDE,'DeportExcAddCostMaterials',Round(100*FDeportExcAddCostMaterials));
      WriteInteger(sDE,'DeportExcAddCostUnAccounted',Round(100*FDeportExcAddCostUnAccounted));
      WriteInteger(sDE,'DeportExcEngineKIM',Round(100*FDeportExcEngineKIM));
      WriteInteger(sDE,'DeportExcEngineKPD',Round(1000*FDeportExcEngineKPD));
      WriteInteger(sDE,'DeportSENexcAmortizationRate',Round(10000*FDeportSENExcAmortizationRate));
      //Карьер
      WriteInteger(sOp,'OpenpitId_Openpit',FOpenpitId_Openpit);
      //Характерные точки
      WriteInteger(sPo,'PointZ',Round(1000*FPointZ));
      WriteInteger(sPo,'PointRadius',FPointRadius);
      WriteInteger(sPo,'PointMinDistance',FPointMinDistance);
      WriteInteger(sPo,'PointColor',Integer(FPointColor));
      WriteInteger(sPo,'PointMarkStyle',Integer(FPointMarkStyle));
      //Параметры дизайна карьерного пространства
      WriteInteger(sCG,'CoordGridStyle',Integer(FCoordGridStyle));
      WriteInteger(sCG,'CoordGridStep',FCoordGridStep);
      if FCoordGridMarks
      then WriteInteger(sCG,'CoordGridMarks',1)
      else WriteInteger(sCG,'CoordGridMarks',0);
      //Блок-участки
      WriteInteger(sBU,'BlockColorMoving',Integer(FBlockColors[bukMoving]));
      WriteInteger(sBU,'BlockColorRoadDown',Integer(FBlockColors[bukRoadDown]));
      WriteInteger(sBU,'BlockColorManeuver',Integer(FBlockColors[bukManeuver]));
      WriteInteger(sBU,'BlockColorCrossRoad',Integer(FBlockColors[bukCrossRoad]));
      WriteInteger(sBU,'BlockStripCount',FBlockStripCount);
      WriteInteger(sBU,'BlockStripWidth',Round(10*FBlockStripWidth));
      WriteInteger(sBU,'BlockLoadingVmax',Round(10*BlockLoadingVmax));
      WriteInteger(sBU,'BlockUnLoadingVmax',Round(10*BlockUnLoadingVmax));
      WriteInteger(sBU,'BlockId_RoadCoat',FBlockId_RoadCoat);
      WriteInteger(sBU,'BlockKind',Integer(FBlockKind));
      WriteInteger(sBU,'BlockStyle',Integer(FBlockStyle));
      //Маршруты
      WriteInteger(sCo,'CourseColor',Integer(FCourseColor));
      WriteInteger(sCo,'CourseStyle',Integer(FCourseStyle));
      //Горные породы
      WriteBool(sRo,'RockIsMineralWealth',FRockIsMineralWealth);
      //Пункты погрузки
      WriteInteger(sRo,'LoadingPunktRockDensityInBlock',Round(100*FLoadingPunktRockDensityInBlock));
      WriteInteger(sRo,'LoadingPunktRockShatteringCoef',Round(100*FLoadingPunktRockShatteringCoef));
      WriteInteger(sRo,'LoadingPunktRockContent',Round(10*FLoadingPunktRockContent));
      WriteInteger(sLP,'LoadingPunktRockPlannedV1000m3',Round(10*FLoadingPunktRockPlannedV1000m3));
      WriteInteger(sLP,'LoadingPunktColor',Integer(FLoadingPunktColor));
      WriteInteger(sLP,'LoadingPunktRadiusCoef',FLoadingPunktRadiusCoef);
      WriteInteger(sLP,'LoadingPunktStyle',Integer(FLoadingPunktStyle));
      //Пункты разгрузки
      WriteInteger(sUP,'UnLoadingPunktMaxV1000m3',Round(10*FUnLoadingPunktMaxV1000m3));
      WriteInteger(sUP,'UnLoadingPunktAutoMaxCount',FUnLoadingPunktAutoMaxCount);
      WriteInteger(sUP,'UnLoadingPunktKind',Integer(FUnLoadingPunktKind));
      WriteInteger(sUP,'UnLoadingPunktRockRequiredContent',Round(10*FUnLoadingPunktRockRequiredContent));
      WriteInteger(sUP,'UnLoadingPunktRockInitialContent',Round(10*FUnLoadingPunktRockInitialContent));
      WriteInteger(sUP,'UnLoadingPunktRockInitialV1000m3',Round(10*FUnLoadingPunktRockInitialV1000m3));
      WriteInteger(sUP,'UnLoadingPunktColor',Integer(FUnLoadingPunktColor));
      WriteInteger(sUP,'UnLoadingPunktRadiusCoef',FUnLoadingPunktRadiusCoef);
      WriteInteger(sUP,'UnLoadingPunktStyle',Integer(FUnLoadingPunktStyle));
      //Пункты пересменки
      WriteInteger(sSP,'ShiftPunktColor',Integer(FShiftPunktColor));
      WriteInteger(sSP,'ShiftPunktRadiusCoef',FShiftPunktRadiusCoef);
      WriteInteger(sSP,'ShiftPunktStyle',Integer(FShiftPunktStyle));
      //Дополнительные параметры
      WriteInteger(sDP,'ParamsTotalKurs',Round(FParamsTotalKurs*100));
      WriteInteger(sDP,'ParamsTotalExpenses',Round(FParamsTotalExpenses*100));
      WriteInteger(sDP,'ParamsTotalSalaryCoef',Round(FParamsTotalSalaryCoef*1000));
      WriteInteger(sDP,'ParamsTotalShiftUsingCoefNormal',Round(FParamsTotalShiftUsingCoefNormal*1000));
      WriteInteger(sDP,'ParamsTotalShiftUsingCoefDayShift',Round(FParamsTotalShiftUsingCoefDayShift*1000));
      WriteInteger(sDP,'ParamsTotalShiftUsingCoefExplosion',Round(FParamsTotalShiftUsingCoefExplosion*1000));
      WriteInteger(sDP,'ParamsTotalShiftUsingCoefExplosionCount',FParamsTotalShiftUsingCoefExplosionCount);
      WriteInteger(sDP,'ParamsExcavsSalaryMashinist0',Round(FParamsExcavsSalaryMashinist0*100));
      WriteInteger(sDP,'ParamsExcavsSalaryMashinist1',Round(FParamsExcavsSalaryMashinist1*100));
      WriteInteger(sDP,'ParamsExcavsSalaryAssistant0',Round(FParamsExcavsSalaryAssistant0*100));
      WriteInteger(sDP,'ParamsExcavsSalaryAssistant1',Round(FParamsExcavsSalaryAssistant1*100));
      WriteInteger(sDP,'ParamsExcavsWorkShiftsCount',FParamsExcavsWorkShiftsCount);
      WriteInteger(sDP,'ParamsExcavsWorkShiftDuration',Round(FParamsExcavsWorkShiftDuration*100));
      WriteInteger(sDP,'ParamsExcavsEnergyCost',Round(FParamsExcavsEnergyCost*100));
      WriteInteger(sDP,'ParamsExcavsAmortazationNorm',Round(FParamsExcavsAmortazationNorm*1000));
      WriteInteger(sDP,'ParamsAutosSalary0',Round(FParamsAutosSalary0*100));
      WriteInteger(sDP,'ParamsAutosSalary1',Round(FParamsAutosSalary1*100));
      WriteInteger(sDP,'ParamsAutosWorkShiftsCount',FParamsAutosWorkShiftsCount);
      WriteInteger(sDP,'ParamsAutosWorkShiftDuration',Round(FParamsAutosWorkShiftDuration*100));
      WriteInteger(sDP,'ParamsAutosFuelCostWinter',Round(FParamsAutosFuelCostWinter*100));
      WriteInteger(sDP,'ParamsAutosFuelCostSummer',Round(FParamsAutosFuelCostSummer*100));
      WriteInteger(sDP,'ParamsAutosWinterMonthCount',FParamsAutosWinterMonthCount);
      WriteInteger(sDP,'ParamsAutosFuelCostTarif',Integer(FParamsAutosFuelCostTarif));
      WriteInteger(sDP,'ParamsAutosSpares',Round(FParamsAutosSpares*100));
      WriteInteger(sDP,'ParamsAutosGreasingSubstance',Round(FParamsAutosGreasingSubstance*100));
      WriteInteger(sDP,'ParamsAutosMaintenanceCost',Round(FParamsAutosMaintenanceCost*100));
      WriteInteger(sDP,'ParamsAutosShiftTurnoverTime',FParamsAutosShiftTurnoverTime);
      WriteInteger(sDP,'ParamsExcavsShiftTurnoverTime',FParamsExcavsShiftTurnoverTime);
      WriteInteger(sDP,'ParamsRoadsBuildingCosts',Round(FParamsRoadsBuildingCosts*100));
      WriteInteger(sDP,'ParamsRoadsKeepingCosts',Round(FParamsRoadsKeepingCosts*100));
      WriteInteger(sDP,'ParamsRoadsAmortizationNorm',Round(FParamsRoadsAmortizationNorm*1000));

      WriteInteger(sDP,'ParamsWorkRegimeKind',Integer(FParamsWorkRegimeKind));
      WriteBool(sDP,'ParamsWorkRegimeIsStrippingCoefUsing',FParamsWorkRegimeIsStrippingCoefUsing);

      WriteInteger(sMP,'ModelingParamsShiftDuration',FModelingParamsShiftDuration);
      WriteInteger(sMP,'ModelingParamsPeriodDuration',FModelingParamsPeriodDuration);
      WriteBool(sMP,'ModelingParamsIsAccumulateData',FModelingParamsIsAccumulateData);
      WriteInteger(sMP,'ModelingParamsAnimationTimeScale',FModelingParamsAnimationTimeScale);
    end;{with}
  finally
    IniFile.Free;
  end;{try}
end;{SaveToFile}

procedure TDBDefaultParams.SetExcavatorBucketCapacity(Value: Single);
begin
  if (FExcavatorBucketCapacity<>Value)and(Value>=1.0)then
  begin
    FExcavatorBucketCapacity := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorBucketCapacity}
procedure TDBDefaultParams.SetExcavatorCycleTime(Value: Single);
begin
  if (FExcavatorCycleTime<>Value)and(Value>=1.0)then
  begin
    FExcavatorCycleTime := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorCycleTime}
procedure TDBDefaultParams.SetExcavatorId_Engine(Value: Integer);
begin
  if (FExcavatorId_Engine<>Value)and(Value>0)then
  begin
    FExcavatorId_Engine := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorId_Engine}
procedure TDBDefaultParams.SetExcavatorLength(Value: Single);
begin
  if (FExcavatorLength<>Value)and(Value>=1.0)then
  begin
    FExcavatorLength := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorLength}
procedure TDBDefaultParams.SetExcavatorWidth(Value: Single);
begin
  if (FExcavatorWidth<>Value)and(Value>=1.0)then
  begin
    FExcavatorWidth := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorWidth}
procedure TDBDefaultParams.SetExcavatorHeight(Value: Single);
begin
  if (FExcavatorHeight<>Value)and(Value>=1.0)then
  begin
    FExcavatorHeight := Value;
    SaveToFile;
  end;{if}
end;{SetExcavatorHeight}
//Экскаваторы списочного парка
procedure TDBDefaultParams.SetDeportExcId_Excavator      (Value: Integer);
begin
  if (FDeportExcId_Excavator<>Value)and(Value>0)then
  begin
    FDeportExcId_Excavator := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcId_Excavator}
procedure TDBDefaultParams.SetDeportExcEYear             (Value: Integer);
begin
  if (FDeportExcEYear<>Value)and(Value>1950)then
  begin
    FDeportExcEYear := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcEYear}
procedure TDBDefaultParams.SetDeportExcWorkState         (Value: Boolean);
begin
  if FDeportExcWorkState<>Value then
  begin
    FDeportExcWorkState := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcWorkState}
procedure TDBDefaultParams.SetDeportExcCost              (Value: Single);
begin
  if (FDeportExcCost<>Value)and(Value>=0.0)then
  begin
    FDeportExcCost := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcCost}
procedure TDBDefaultParams.SetDeportExcFactCycleTime     (Value: Single);
begin
  if (FDeportExcFactCycleTime<>Value)and(Value>0.0)then
  begin
    FDeportExcFactCycleTime := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcFactCycleTime}
procedure TDBDefaultParams.SetDeportExcAddCostMaterials  (Value: Single);
begin
  if (FDeportExcAddCostMaterials<>Value)and(Value>=0.0)then
  begin
    FDeportExcAddCostMaterials := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcAddCostMaterials}
procedure TDBDefaultParams.SetDeportExcAddCostUnAccounted(Value: Single);
begin
  if (FDeportExcAddCostUnAccounted<>Value)and(Value>0.0)then
  begin
    FDeportExcAddCostUnAccounted := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcAddCostUnAccounted}
procedure TDBDefaultParams.SetDeportExcEngineKIM         (Value: Single);
begin
  if (FDeportExcEngineKIM<>Value)and InRange(Value,0.25,0.35)then
  begin
    FDeportExcEngineKIM := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcEngineKIM}
procedure TDBDefaultParams.SetDeportExcEngineKPD         (Value: Single);
begin
  if (FDeportExcEngineKPD<>Value)and InRange(Value,0.936,0.948)then
  begin
    FDeportExcEngineKPD := Value;
    SaveToFile;
  end;{if}
end;{SetDeportExcEngineKPD}
procedure TDBDefaultParams.SetDeportSENExcAmortizationRate (Value: Single);
begin
  if (FDeportSENExcAmortizationRate<>Value)and(Value>0.0) then
  begin
    FDeportSENExcAmortizationRate := Value;
    SaveToFile;
  end;{if}
end;{SetDeportSENExcAmortizationRate}
//Автосамосвалы списочного парка
procedure TDBDefaultParams.SetDeportAutoId_Auto          (Value: Integer);
begin
  if (FDeportAutoId_Auto<>Value)and(Value>0) then
  begin
    FDeportAutoId_Auto := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoId_Auto}
procedure TDBDefaultParams.SetDeportAutoAYear            (Value: Integer);
begin
  if (FDeportAutoAYear<>Value)and(Value>1950) then
  begin
    FDeportAutoAYear := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoAYear}
procedure TDBDefaultParams.SetDeportAutoFactTonnage      (Value: Single);
begin
  if (FDeportAutoFactTonnage<>Value)and(Value>0.0) then
  begin
    FDeportAutoFactTonnage := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoFactTonnage}
procedure TDBDefaultParams.SetDeportAutoWorkState        (Value: Boolean);
begin
  if FDeportAutoWorkState<>Value then
  begin
    FDeportAutoWorkState := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoWorkState}
procedure TDBDefaultParams.SetDeportAutoCost             (Value: Single);
begin
  if (FDeportAutoCost<>Value)and(Value>=0.0) then
  begin
    FDeportAutoCost := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoCost}
procedure TDBDefaultParams.SetDeportAutoAmortizationRate (Value: Single);
begin
  if (FDeportAutoAmortizationRate<>Value)and(Value>0.0) then
  begin
    FDeportAutoAmortizationRate := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoAmortizationRate}
procedure TDBDefaultParams.SetDeportAutoTransmissionKPD  (Value: Single);
begin
  if (FDeportAutoTransmissionKPD<>Value)and InRange(Value,0.1,1.0) then
  begin
    FDeportAutoTransmissionKPD := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoTransmissionKPD}
procedure TDBDefaultParams.SetDeportAutoEngineKPD        (Value: Single);
begin
  if (FDeportAutoEngineKPD<>Value)and InRange(Value,0.1,1.0) then
  begin
    FDeportAutoEngineKPD := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoEngineKPD}
procedure TDBDefaultParams.SetDeportAutoTyreCost         (Value: Single);
begin
  if (FDeportAutoTyreCost<>Value)and(Value>=0.0) then
  begin
    FDeportAutoTyreCost := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoTyreCost}
procedure TDBDefaultParams.SetDeportAutoTyresRaceRate     (Value: Single);
begin
  if (FDeportAutoTyresRaceRate<>Value)and(Value>0.0) then
  begin
    FDeportAutoTyresRaceRate := Value;
    SaveToFile;
  end;{if}
end;{SetDeportAutoTyresRaceRate}
//Сохранение параметров списочного парка автосамосвалов
procedure TDBDefaultParams.SaveAutoParams(
  const AId_AutoModel,AYear      : Integer;
  const AWorkState               : Boolean;
  const AQtn,ABalanceC1000tg     : Single;
  const AAmortizationR1000km     : Single;
  const ATransmissionKPD         : Single;
  const AEngineKPD               : Single;
  const ATyreC1000tg             : Single;
  const ATyresAmortizationR1000km: Single);
begin
  FDeportAutoId_Auto          := AId_AutoModel;
  FDeportAutoAYear            := AYear;
  FDeportAutoFactTonnage      := AQtn;
  FDeportAutoWorkState        := AWorkState;
  FDeportAutoCost             := ABalanceC1000tg;
  FDeportAutoAmortizationRate := AAmortizationR1000km;
  FDeportAutoTransmissionKPD  := ATransmissionKPD;
  FDeportAutoEngineKPD        := AEngineKPD;
  FDeportAutoTyreCost         := ATyreC1000tg;
  FDeportAutoTyresRaceRate    := ATyresAmortizationR1000km;
  SaveToFile;
end;{SaveAutoParams}
//Карьер
procedure TDBDefaultParams.SetOpenpitId_Openpit(Value: Integer);
begin
  if (FOpenpitId_Openpit<>Value)AND(Value>0)then
  begin
    FOpenpitId_Openpit := Value;
    SaveToFile;
  end;{if}
end;{SetOpenpitId_Openpit}
procedure TDBDefaultParams.SetPointZ(Value: Single);
begin
  Value := RoundTo(Value,-3);
  if FPointZ<>Value then
  begin
    FPointZ := Value;
    SaveToFile;
  end;{if}
end;{SetPointZ}
procedure TDBDefaultParams.SetPointMinDistance(Value: Byte);
begin
  if (FPointMinDistance<>Value)and InRange(Value,1,50) then
  begin
    FPointMinDistance := Value;
    SaveToFile;
  end;{if}
end;{SetPointMinDistance}
procedure TDBDefaultParams.SetPointColor(Value: TColor);
begin
  if (FPointColor<>Value)and(Value<>clBlack) then
  begin
    FPointColor := Value;
    SaveToFile;
  end;{if}
end;{SetPointColor}
procedure TDBDefaultParams.SetPointRadius(Value: Byte);
begin
  if (FPointRadius<>Value)and InRange(Value,1,50) then
  begin
    FPointRadius := Value;
    FLoadingPunktRadius := FLoadingPunktRadiusCoef*FPointRadius;
    FUnLoadingPunktRadius := FUnLoadingPunktRadiusCoef*FPointRadius;
    FShiftPunktRadius := FShiftPunktRadiusCoef*FPointRadius;
    SaveToFile;
  end;{if}
end;{SetPointRadius}
procedure TDBDefaultParams.SetPointMarkStyle(Value: TPointMarkStyle);
begin
  if FPointMarkStyle<>Value then
  begin
    FPointMarkStyle := Value;
    SaveToFile;
  end;{if}
end;{SetPointMarkStyle}
procedure TDBDefaultParams.SetCoordGridStyle(Value: TCoordGridStyle);
begin
  if FCoordGridStyle<>Value then
  begin
    FCoordGridStyle := Value;
    SaveToFile;
  end;{if}
end;{SetCoordGridStyle}
procedure TDBDefaultParams.SetCoordGridStep(Value: Integer);
begin
  if (FCoordGridStep<>Value)and InRange(Value,10,1000)and(Value mod 10=0) then
  begin
    FCoordGridStep := Value;
    SaveToFile;
  end;{if}
end;{SetCoordGridStep}
procedure TDBDefaultParams.SetCoordGridMarks(Value: Boolean);
begin
  if FCoordGridMarks<>Value then
  begin
    FCoordGridMarks := Value;
    SaveToFile;
  end;{if}
end;{SetCoordGridMarks}

procedure TDBDefaultParams.SetBlockColor(Index: TBlockKind; Value: TColor);
begin
  if (FBlockColors[Index]<>Value)and(Value<>clBlack) then
  begin
    FBlockColors[Index] := Value;
    SaveToFile;
  end;{if}
end;{SetBlockColor}
function TDBDefaultParams.GetBlockColor(Index: TBlockKind): TColor;
begin
  Result := FBlockColors[Index];
end;{GetBlockColor}
procedure TDBDefaultParams.SetBlockStripCount(Value: Byte);
begin
  if (FBlockStripCount<>Value)and(Value in [1,2]) then
  begin
    FBlockStripCount := Value;
    SaveToFile;
  end;{if}
end;{SetBlockStripCount}
procedure TDBDefaultParams.SetBlockStripWidth(Value: Single);
begin
  Value := RoundTo(Value,-1);
  if (FBlockStripWidth<>Value)and InRange(Value,1.0,100.0) then
  begin
    FBlockStripWidth := Value;
    SaveToFile;
  end;{if}
end;{SetBlockStripWidth}
procedure TDBDefaultParams.SetBlockLoadingVmax(Value: Single);
begin
  Value := RoundTo(Value,-1);
  if (FBlockLoadingVmax<>Value)and (Value>=5.0) then
  begin
    FBlockLoadingVmax := Value;
    SaveToFile;
  end;{if}
end;{SetBlockLoadingVmax}
procedure TDBDefaultParams.SetBlockUnLoadingVmax(Value: Single);
begin
  Value := RoundTo(Value,-1);
  if (FBlockUnLoadingVmax<>Value)and (Value>=5.0) then
  begin
    FBlockUnLoadingVmax := Value;
    SaveToFile;
  end;{if}
end;{SetBlockUnLoadingVmax}
procedure TDBDefaultParams.SetBlockId_RoadCoat(Value: Integer);
begin
  if (FBlockId_RoadCoat<>Value)and(Value>0) then
  begin
    FBlockId_RoadCoat := Value;
    SaveToFile;
  end;{if}
end;{SetBlockId_RoadCount}
procedure TDBDefaultParams.SetBlockKind(Value: TBlockKind);
begin
  if (FBlockKind<>Value)and(Value<>bukCrossRoad) then
  begin
    FBlockKind := Value;
    SaveToFile;
  end;{if}
end;{SetBlockKind}
procedure TDBDefaultParams.SetBlockStyle(Value: TBlockViewStyle);
begin
  if FBlockStyle<>Value then
  begin
    FBlockStyle := Value;
    SaveToFile;
  end;{if}
end;{SetBlockStyle}
//Маршруты движения
procedure TDBDefaultParams.SetCourseColor(Value: TColor);
begin
  if FCourseColor<>Value then
  begin
    FCourseColor := Value;
    SaveToFile;
  end;{if}
end;{SetCourseColor}
procedure TDBDefaultParams.SetCourseStyle(Value: TCourseViewStyle);
begin
  if FCourseStyle<>Value then
  begin
    FCourseStyle := Value;
    SaveToFile;
  end;{if}
end;{SetCourseStyle}

procedure TDBDefaultParams.SetRockIsMineralWealth(Value: Boolean);
begin
  if FRockIsMineralWealth<>Value then
  begin
    FRockIsMineralWealth := Value;
    SaveToFile;
  end;{if}
end;{SetRockIsMineralWealth}
//Пункты погрузки
procedure TDBDefaultParams.SetLoadingPunktRockDensityInBlock (Value: Single);
begin
  if (FLoadingPunktRockDensityInBlock<>Value)and(Value>0.0) then
  begin
    FLoadingPunktRockDensityInBlock := Value;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktRockDensityInBlock}
procedure TDBDefaultParams.SetLoadingPunktRockShatteringCoef (Value: Single);
begin
  if (FLoadingPunktRockShatteringCoef<>Value)and(Value>0.0) then
  begin
    FLoadingPunktRockShatteringCoef := Value;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktRockShatteringCoef}
procedure TDBDefaultParams.SetLoadingPunktRockContent   (Value: Single);
begin
  if (FLoadingPunktRockContent<>Value)and InRange(Value,1.0,100.0)then
  begin
    FLoadingPunktRockContent := Value;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktRockContent}    
procedure TDBDefaultParams.SetLoadingPunktRockPlannedV1000m3(Value: Single);
begin
  if (FLoadingPunktRockPlannedV1000m3<>Value)and(Value>0.0)then
  begin
    FLoadingPunktRockPlannedV1000m3 := Value;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktRockPlannedVm3}    
procedure TDBDefaultParams.SetLoadingPunktColor     (Value: TColor);
begin
  if (FLoadingPunktColor<>Value)and(Value<>clBlack)then
  begin
    FLoadingPunktColor := Value;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktColor}
procedure TDBDefaultParams.SetLoadingPunktRadiusCoef(Value: Integer);
begin
  if (FLoadingPunktRadiusCoef<>Value)and(Value>0)then
  begin
    FLoadingPunktRadiusCoef := Value;
    FLoadingPunktRadius := FLoadingPunktRadiusCoef*FPointRadius;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktRadius}
procedure TDBDefaultParams.SetLoadingPunktStyle     (Value: TPunktViewStyle);
begin
  if FLoadingPunktStyle<>Value then
  begin
    FLoadingPunktStyle := Value;
    SaveToFile;
  end;{if}
end;{SetLoadingPunktStyle}
//Пункты разгрузки
procedure TDBDefaultParams.SetUnLoadingPunktMaxV1000m3       (Value: Single);
begin
  if (FUnLoadingPunktMaxV1000m3<>Value)and(Value>0.0)then
  begin
    FUnLoadingPunktMaxV1000m3 := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktMaxV1000m3}    
procedure TDBDefaultParams.SetUnLoadingPunktAutoMaxCount   (Value: Integer);
begin
  if (FUnLoadingPunktAutoMaxCount<>Value)and(Value>0)then
  begin
    FUnLoadingPunktAutoMaxCount := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktAutoMaxCount}
procedure TDBDefaultParams.SetUnLoadingPunktKind           (Value: TUnLoadingPunktKind);
begin
  if FUnLoadingPunktKind<>Value then
  begin
    FUnLoadingPunktKind := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktKind}
procedure TDBDefaultParams.SetUnLoadingPunktRockRequiredContent(Value: Single);
begin
  if (FUnLoadingPunktRockRequiredContent<>Value)and InRange(Value,1.0,100.0)then
  begin
    FUnLoadingPunktRockRequiredContent := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktRockRequiredContent}    
procedure TDBDefaultParams.SetUnLoadingPunktRockInitialContent (Value: Single);
begin
  if (FUnLoadingPunktRockInitialContent<>Value)and InRange(Value,1.0,100.0)then
  begin
    FUnLoadingPunktRockInitialContent := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktRockInitialContent}    
procedure TDBDefaultParams.SetUnLoadingPunktRockInitialV1000m3   (Value: Single);
begin
  if (FUnLoadingPunktRockInitialV1000m3<>Value)and(Value>=0.0)then
  begin
    FUnLoadingPunktRockInitialV1000m3 := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktRockInitialV1000m3}    
procedure TDBDefaultParams.SetUnLoadingPunktColor          (Value: TColor);
begin
  if (FUnLoadingPunktColor<>Value)and(Value<>clBlack)then
  begin
    FUnLoadingPunktColor := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktCoolor}
procedure TDBDefaultParams.SetUnLoadingPunktRadiusCoef(Value: Integer);
begin
  if (FUnLoadingPunktRadiusCoef<>Value)and(Value>0)then
  begin
    FUnLoadingPunktRadiusCoef := Value;
    FUnLoadingPunktRadius := FUnLoadingPunktRadiusCoef*FPointRadius;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktRadius}
procedure TDBDefaultParams.SetUnLoadingPunktStyle          (Value: TPunktViewStyle);
begin
  if FUnLoadingPunktStyle<>Value then
  begin
    FUnLoadingPunktStyle := Value;
    SaveToFile;
  end;{if}
end;{SetUnLoadingPunktStyle}
//Пункты пересменки
procedure TDBDefaultParams.SetShiftPunktColor (Value: TColor);
begin
  if (FShiftPunktColor<>Value)and(Value<>clBlack)then
  begin
    FShiftPunktColor := Value;
    SaveToFile;
  end;{if}
end;{SetShiftPunktCoolor}
procedure TDBDefaultParams.SetShiftPunktRadiusCoef(Value: Integer);
begin
  if (FShiftPunktRadiusCoef<>Value)and(Value>0)then
  begin
    FShiftPunktRadiusCoef := Value;
    FShiftPunktRadius := FShiftPunktRadiusCoef*FPointRadius;
    SaveToFile;
  end;{if}
end;{SetShiftPunktRadius}
procedure TDBDefaultParams.SetShiftPunktStyle (Value: TPunktViewStyle);
begin
  if FShiftPunktStyle<>Value then
  begin
    FShiftPunktStyle := Value;
    SaveToFile;
  end;{if}
end;{SetShiftPunktStyle}
procedure TDBDefaultParams.SetParamsTotalKurs(Value: Single);
begin
  if (FParamsTotalKurs<>Value)and(Value>0.0)then
  begin
    FParamsTotalKurs := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalKurs}
procedure TDBDefaultParams.SetParamsTotalExpenses(Value: Single);
begin
  if (FParamsTotalKurs<>Value)and(Value>=0.0)then
  begin
    FParamsTotalKurs := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalKurs}
procedure TDBDefaultParams.SetParamsTotalSalaryCoef(Value: Single);
begin
  if (FParamsTotalKurs<>Value)and(Value>0.0)then
  begin
    FParamsTotalKurs := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalKurs}
procedure TDBDefaultParams.SetParamsTotalShiftUsingCoefNormal(Value: Single);
begin
  if (FParamsTotalShiftUsingCoefNormal<>Value)and InRange(Value,0.0,1.0)then
  begin
    FParamsTotalShiftUsingCoefNormal := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalShiftUsingCoefNormal}
procedure TDBDefaultParams.SetParamsTotalShiftUsingCoefDayShift(Value: Single);
begin
  if (FParamsTotalShiftUsingCoefDayShift<>Value)and InRange(Value,0.0,1.0)then
  begin
    FParamsTotalShiftUsingCoefDayShift := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalShiftUsingCoefDayShift}
procedure TDBDefaultParams.SetParamsTotalShiftUsingCoefExplosion(Value: Single);
begin
  if (FParamsTotalShiftUsingCoefExplosion<>Value)and InRange(Value,0.0,1.0)then
  begin
    FParamsTotalShiftUsingCoefExplosion := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalShiftUsingCoefExplosion}
procedure TDBDefaultParams.SetParamsTotalShiftUsingCoefExplosionCount(Value: Integer);
begin
  if (FParamsTotalShiftUsingCoefExplosionCount<>Value)and(Value>=0)then
  begin
    FParamsTotalShiftUsingCoefExplosionCount := Value;
    SaveToFile;
  end;{if}
end;{SetParamsTotalShiftUsingCoefExplosionCount}
procedure TDBDefaultParams.SetParamsExcavsSalaryMashinist0(Value: Single);
begin
  if (FParamsExcavsSalaryMashinist0<>Value)and(Value>0.0)then
  begin
    FParamsExcavsSalaryMashinist0 := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsSalaryMashinist0}
procedure TDBDefaultParams.SetParamsExcavsSalaryMashinist1(Value: Single);
begin
  if (FParamsExcavsSalaryMashinist1<>Value)and(Value>=0.0)then
  begin
    FParamsExcavsSalaryMashinist1 := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsSalaryMashinist1}
procedure TDBDefaultParams.SetParamsExcavsSalaryAssistant0(Value: Single);
begin
  if (FParamsExcavsSalaryAssistant0<>Value)and(Value>0.0)then
  begin
    FParamsExcavsSalaryAssistant0 := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsSalaryAssistant0}
procedure TDBDefaultParams.SetParamsExcavsSalaryAssistant1(Value: Single);
begin
  if (FParamsExcavsSalaryAssistant1<>Value)and(Value>=0.0)then
  begin
    FParamsExcavsSalaryAssistant1 := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsSalaryAssistant1}
procedure TDBDefaultParams.SetParamsExcavsWorkShiftsCount(Value: Integer);
begin
  if (FParamsExcavsWorkShiftsCount<>Value)and(Value>0)then
  begin
    FParamsExcavsWorkShiftsCount := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsWorkShiftsCount}
procedure TDBDefaultParams.SetParamsExcavsWorkShiftDuration(Value: Single);
begin
  if (FParamsExcavsWorkShiftDuration<>Value)and(Value>0.0)then
  begin
    FParamsExcavsWorkShiftDuration := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsWorkShiftDuration}
procedure TDBDefaultParams.SetParamsExcavsEnergyCost(Value: Single);
begin
  if (FParamsExcavsEnergyCost<>Value)and(Value>0.0)then
  begin
    FParamsExcavsEnergyCost := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsEnergyCost}
procedure TDBDefaultParams.SetParamsExcavsAmortazationNorm(Value: Single);
begin
  if (FParamsExcavsAmortazationNorm<>Value)and InRange(Value,0.0,1.0)then
  begin
    FParamsExcavsAmortazationNorm := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsAmortazationNorm}
procedure TDBDefaultParams.SetParamsAutosSalary0(Value: Single);
begin
  if (FParamsAutosSalary0<>Value)and(Value>0.0)then
  begin
    FParamsAutosSalary0 := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosSalary0}
procedure TDBDefaultParams.SetParamsAutosSalary1(Value: Single);
begin
  if (FParamsAutosSalary1<>Value)and(Value>=0.0)then
  begin
    FParamsAutosSalary1 := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosSalary1}
procedure TDBDefaultParams.SetParamsAutosWorkShiftsCount(Value: Integer);
begin
  if (FParamsAutosWorkShiftsCount<>Value)and(Value>0)then
  begin
    FParamsAutosWorkShiftsCount := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosWorkShiftsCount}
procedure TDBDefaultParams.SetParamsAutosWorkShiftDuration(Value: Single);
begin
  if (FParamsAutosWorkShiftDuration<>Value)and(Value>0.0)then
  begin
    FParamsAutosWorkShiftDuration := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosWorkShiftDuration}
procedure TDBDefaultParams.SetParamsAutosFuelCostWinter(Value: Single);
begin
  if (FParamsAutosFuelCostWinter<>Value)and(Value>0.0)then
  begin
    FParamsAutosFuelCostWinter := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosFuelCostWinter}
procedure TDBDefaultParams.SetParamsAutosFuelCostSummer(Value: Single);
begin
  if (FParamsAutosFuelCostSummer<>Value)and(Value>0.0)then
  begin
    FParamsAutosFuelCostSummer := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosFuelCostSummer}
procedure TDBDefaultParams.SetParamsAutosWinterMonthCount(Value: Integer);
begin
  if (FParamsAutosWinterMonthCount<>Value)and InRange(Value,0,12)then
  begin
    FParamsAutosWinterMonthCount := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosWinterMonthCount}
procedure TDBDefaultParams.SetParamsAutosFuelCostTarif(Value: TAutosFuelCostTarif);
begin
  if FParamsAutosFuelCostTarif<>Value then
  begin
    FParamsAutosFuelCostTarif := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosFuelCostTarif}
procedure TDBDefaultParams.SetParamsAutosSpares(Value: Single);
begin
  if (FParamsAutosSpares<>Value)and(Value>0.0)then
  begin
    FParamsAutosSpares := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosSpares}
procedure TDBDefaultParams.SetParamsAutosGreasingSubstance(Value: Single);
begin
  if (FParamsAutosGreasingSubstance<>Value)and(Value>0.0)then
  begin
    FParamsAutosGreasingSubstance := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosGreasingSubstance}
procedure TDBDefaultParams.SetParamsAutosMaintenanceCost(Value: Single);
begin
  if (FParamsAutosMaintenanceCost<>Value)and(Value>0.0)then
  begin
    FParamsAutosMaintenanceCost := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosMaintenanceCost}
procedure TDBDefaultParams.SetParamsRoadsBuildingCosts(Value: Single);
begin
  if (FParamsRoadsBuildingCosts<>Value)and(Value>0.0)then
  begin
    FParamsRoadsBuildingCosts := Value;
    SaveToFile;
  end;{if}
end;{SetParamsRoadsBuildingCosts}
procedure TDBDefaultParams.SetParamsRoadsKeepingCosts(Value: Single);
begin
  if (FParamsRoadsKeepingCosts<>Value)and(Value>0.0)then
  begin
    FParamsRoadsKeepingCosts := Value;
    SaveToFile;
  end;{if}
end;{SetParamsRoadsKeepingCosts}
procedure TDBDefaultParams.SetParamsRoadsAmortizationNorm(Value: Single);
begin
  if (FParamsRoadsAmortizationNorm<>Value)and InRange(Value,0.0,1.0)then
  begin
    FParamsRoadsAmortizationNorm := Value;
    SaveToFile;
  end;{if}
end;{SetParamsRoadsAmortizationNorm}
procedure TDBDefaultParams.SetParamsWorkRegimeKind(Value: TAutoWorkRegime);
begin
  if FParamsWorkRegimeKind<>Value then
  begin
    FParamsWorkRegimeKind := Value;
    SaveToFile;
  end;{if}
end;{SetParamsWorkRegimeKind}
procedure TDBDefaultParams.SetParamsWorkRegimeIsStrippingCoefUsing(Value: Boolean);
begin
  if FParamsWorkRegimeIsStrippingCoefUsing<>Value then
  begin
    FParamsWorkRegimeIsStrippingCoefUsing := Value;
    SaveToFile;
  end;{if}
end;{SetParamsWorkRegimeIsStrippingCoefUsing}
procedure TDBDefaultParams.SetParamsAutosShiftTurnoverTime(Value: Integer);
begin
  if (FParamsAutosShiftTurnoverTime<>Value)and(Value>=0)then
  begin
    FParamsAutosShiftTurnoverTime := Value;
    SaveToFile;
  end;{if}
end;{SetParamsAutosShiftTurnoverTime}
procedure TDBDefaultParams.SetParamsExcavsShiftTurnoverTime(Value: Integer);
begin
  if (FParamsExcavsShiftTurnoverTime<>Value)and(Value>=0)then
  begin
    FParamsExcavsShiftTurnoverTime := Value;
    SaveToFile;
  end;{if}
end;{SetParamsExcavsShiftTurnoverTime}
procedure TDBDefaultParams.SetModelingParamsShiftDuration(Value: Integer);
begin
  if (FModelingParamsShiftDuration<>Value)and(FModelingParamsShiftDuration>0) then
  begin
    FModelingParamsShiftDuration := Value;
    SaveToFile;
  end;{if}
end;{SetModelingParamsShiftDuration}
procedure TDBDefaultParams.SetModelingParamsPeriodDuration(Value: Integer);
begin
  if (FModelingParamsPeriodDuration<>Value)and(FModelingParamsPeriodDuration>0) then
  begin
    FModelingParamsPeriodDuration := Value;
    SaveToFile;
  end;{if}
end;{SetModelingParamsPeriodDuration}
procedure TDBDefaultParams.SetModelingParamsIsAccumulateData(Value: Boolean);
begin
  if FModelingParamsIsAccumulateData<>Value then
  begin
    FModelingParamsIsAccumulateData := Value;
    SaveToFile;
  end;{if}
end;{SetModelingParamsIsAccumulateData}
procedure TDBDefaultParams.SetModelingParamsAnimationTimeScale(Value: Integer);
begin
  if (FModelingParamsAnimationTimeScale<>Value)and(FModelingParamsAnimationTimeScale>0) then
  begin
    FModelingParamsAnimationTimeScale := Value;
    SaveToFile;
  end;{if}
end;{SetModelingParamsAnimationTimeScale}

end.
