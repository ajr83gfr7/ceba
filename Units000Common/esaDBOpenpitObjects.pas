unit esaDBOpenpitObjects;
{
Елубаев Сулеймен Актлеуович
аспирант ИГД им.Д.А.Кунаева
Объекты ориентированные на таблицы БД
для Редактора элементов карьерного пространства OpenpitEditor
}
interface
uses esaOpenGL2D, Windows, esaDBDefaultParams, ADODb, Types, Globals, Messages, Graphics, Forms,
     ValEdit, StdCtrls, Classes;
const
  WM_SELECTED=WM_USER+500;

  EUnsignedGraphKernel   = 'Не задано графическое ядро GraphKernel: TGraphKernel2D.';
  EUnsignedOpenpit       = 'Не задан карьер Openpit: TDBOpenpit.';
  EUnsignedDefaultParams = 'Не заданы Параметры по умолчанию DefaultParams: TDBDefaultParams.';
  EUnsignedDBConnection  = 'Не задано соединение с базой данных DBConnection: TADOConnection.';
  
  EClosedDBConnection = 'DBConnection: TADOConnection не активизирован.';

  EEmptyDBTable = 'Таблица "%s" не заполнена.';

  EDuplicatePoint='Характерная точка с координатами (X=%.3f; Y=%.3f) уже существует.';
  EDuplicateLoadingPunkt='В данной точке №%d уже расположен пункт погрузки №%d.';
  EDuplicateUnLoadingPunkt='В данной точке №%d уже расположен пункт рагрузки №%d.';
  EDuplicateShiftPunkt='В данной точке №%d уже расположен пункт пересменки №%d.';

  EInvalidIndex = 'Неверное значение индекса %d. Допустимый диапазон: [0..%d].';
  EInvalidBlockPointsCount='Для создания блок-участка необходимо наличие не менее двух точек.';
  EInvalidCrossRoadPointsCount='Необходимо ровно две точки для создания перекрестка.';
type
  TDBRoadCoats=class;
  TDBExcavatorCharacs=class;
  TDBAutoCharacs=class;
  TDBExcavators=class;
  TDBAutos=class;
  TDBRocks=class;
  TDBPoints = class;
  TDBBlocks = class;
  TDBCourse = class;
  TDBCourses = class;
  TDBLoadingPunkts = class;
  TDBUnLoadingPunkts = class;
  TDBShiftPunkt=class;
  TDBShiftPunkts = class;
  TDBSelectedObjects = class;
  //TDBOpenpit - класс "Карьер" ---------------------------------------------------------------
  TDBOpenpit = class
  private
    FId_Openpit: Integer;              //Уникальный код карьера
    FName      : String;               //Наименование карьера
    FDateCreate: TDateTime;            //Дата создания карьера
    FBound     : RBound3D;

    FGraphKernel  : TGraphCernel2D;    //Ссылка на графическое ядро
    FDefaultParams: TDBDefaultParams;  //Ссылка на значения по умолчанию
    FDBConnection : TADOConnection;    //Ссылка на физическую БД

    FRoadCoats       : TDBRoadCoats;        //Дорожные покрытия
    FExcavatorCharacs: TDBExcavatorCharacs; //Модели экскаваторов
    FAutoCharacs     : TDBAutoCharacs;      //Модели автосамосвалов
    FExcavators      : TDBExcavators;       //Экскаваторы
    FAutos           : TDBAutos;            //Автосамосвалы
    FRocks           : TDBRocks;            //Добываемые горные породы
    FPoints          : TDBPoints;           //Характерные точки карьера
    FLoadingPunkts   : TDBLoadingPunkts;    //Пункты погрузки карьера
    FUnLoadingPunkts : TDBUnLoadingPunkts;  //Пункты разгрузки карьера
    FShiftPunkts     : TDBShiftPunkts;      //Пункты пересменки карьера
    FSelectedObjects : TDBSelectedObjects;//Выделенные объекты карьера
    function GetHandle      : HWND;
    function GetCanvasHandle: HWND;
    procedure CheckDefaultParams;
    procedure SetBound(const Value: RBound3D);
  public
    {dwd}
    FBlocks          : TDBBlocks;           //Блок-участки карьера
    FCourses         : TDBCourses;          //Маршруты движения карьера

    property GraphKernel  : TGraphCernel2D read FGraphKernel;
    property DefaultParams: TDBDefaultParams read FDefaultParams;
    property DBConnection : TADOConnection read FDBConnection;
    property Bound        : RBound3D read FBound write SetBound;
    property Handle       : HWND read GetHandle;
    property CanvasHandle : HWND read GetCanvasHandle;
    property Id_Openpit: Integer read FId_Openpit;
    property Name      : String read FName;
    property DateCreate: TDateTime read FDateCreate;
    property RoadCoats       : TDBRoadCoats read FRoadCoats;
    property AutoCharacs     : TDBAutoCharacs read FAutoCharacs;
    property ExcavatorCharacs: TDBExcavatorCharacs read FExcavatorCharacs;
    property Autos           : TDBAutos read FAutos;
    property Excavators      : TDBExcavators read FExcavators;
    property Rocks           : TDBRocks read FRocks;
    property Points          : TDBPoints read FPoints;
    property Blocks          : TDBBlocks read FBlocks;
    property Courses         : TDBCourses read FCourses;
    property LoadingPunkts   : TDBLoadingPunkts read FLoadingPunkts;
    property UnLoadingPunkts : TDBUnLoadingPunkts read FUnLoadingPunkts;
    property ShiftPunkts     : TDBShiftPunkts read FShiftPunkts;
    property SelectedObjects : TDBSelectedObjects read FSelectedObjects;
    constructor Create(ADBConnection: TADOConnection; AGraphCernel: TGraphCernel2D;
                       ADefaultParams: TDBDefaultParams);
    destructor Destroy; override;
    procedure Draw;
    procedure RefreshData;
    procedure ConvertToCEBADAN;
    procedure ConvertFromCEBADAN;
    procedure ConvertToPCD;
    //Анализ уклонов
    procedure AnalizeUklons();
  end;{TDBOpenpit}

  //TDBGlobalObject - класс "Глобальный объект" -----------------------------------------------
  TDBGlobalObject = class
  private
    FOpenpit: TDBOpenpit;
    FVisible: Boolean;
    function GetHandle      : HWND;
    function GetCanvasHandle: HWND;
    function GetGraphKernel    : TGraphCernel2D;
    function GetDefaultParams  : TDBDefaultParams;
    function GetDBConnection   : TADOConnection;
    procedure SetVisible(const Value: Boolean);
  public
    property Openpit     : TDBOpenpit read FOpenpit;
    property Visible     : Boolean read FVisible write SetVisible;
    property Handle      : HWND read GetHandle;
    property CanvasHandle: HWND read GetCanvasHandle;
    property GraphKernel    : TGraphCernel2D read GetGraphKernel;
    property DefaultParams  : TDBDefaultParams read GetDefaultParams;
    property DBConnection   : TADOConnection read GetDBConnection;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Invalidate;
    procedure RefreshData;virtual;
  end;{TDBGlobalObject}

  //TDBRoadCoatUSK - класс "Коэффициенты уд.сопротивления качению Дорожного покрытия" ---------
  RDBRoadCoatUSK=record
    P           : Single; //Весовой диапазон авто, т.
    ValueMin    : Single; //Миним.значение, Н/кН
    ValueMax    : Single; //Максим.значение, Н/кН
  end;
  TDBRoadCoatUSK = class
  private
    FId_RoadCoat : Integer;          //Код дорожного покрытия
    FName        : String;           //Дорожное покрытие
    FItems: array of RDBRoadCoatUSK; //Список коэф-тов уд.сопротивления качению
    FCount: Integer;                 //Количество
    function GetItem(Index: Integer): RDBRoadCoatUSK;
    procedure SetId_RoadCoat(const Value: Integer);
    procedure SetName(Value: String);
  public
    property Items[Index: Integer]: RDBRoadCoatUSK read GetItem;default;
    property Count: Integer read FCount;
    property Id_RoadCoat : Integer read FId_RoadCoat write SetId_RoadCoat;          
    property Name        : String read FName write SetName;          
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AP,AValueMin,AValueMax: Single);
  end;{TDBRoadCoatUSK}
  //TDBRoadCoats - класс "Дорожные покрытия" --------------------------------------------------
  TDBRoadCoats = class(TDBGlobalObject)
  private
    FItems: array of TDBRoadCoatUSK; //Список дорожных покрытий
    FCount: Integer;                 //Количество дорожных покрытий
    function GetItem(Index: Integer): TDBRoadCoatUSK;
  public
    property Items[Index: Integer]: TDBRoadCoatUSK read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(const AId_RoadCoat: Integer): Integer;overload;
    function IndexOf(const ARoadCoat: String): Integer;overload;
    procedure RefreshData;override;
  end;{TDBRoadCoats}
  //TDBExcavatorCharacs - класс "Модели экскаваторов" -----------------------------------------
  RDBExcavatorCharac=record
    Id_Excavator  : Integer;//Уникальный код модели экскаватора
    Name          : String; //Модель
    BucketCapacity: Single; //Емкость ковша, м3
    CycleTime     : Single; //Время цикла, с
    Id_Engine     : Integer;//Код двигателя
    EngineName    : String; //Марка двигателя
    EngineNmax    : Single; //Максимальная мощность двигателя, кВт
    ELength       : Single; //Длина, м
    EWidth        : Single; //Ширина, м
    EHeight       : Single; //Высота, м
  end;
  TDBExcavatorCharacs = class(TDBGlobalObject)
  private
    FItems: array of RDBExcavatorCharac; //Список моделей экскаваторов
    FCount: Integer;                     //Количество моделей экскаваторов
    function GetItem(Index: Integer): RDBExcavatorCharac;
  public
    property Items[Index: Integer]: RDBExcavatorCharac read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(const AId_Excavator: Integer): Integer;
    function FindBy(const AId_Engine: Integer): Integer;
    procedure RefreshData;override;
  end;{TDBExcavatorCharacs}
  //TDBAutoCharacs - класс "Модели автосамосвалов" --------------------------------------------
  RDBAutoCharac=record
    Id_Auto         : Integer;//Уникальный код модели экскаватора
    Name            : String; //Модель
    BodySpace       : Single; //Объем кузова, м3
    Tonnage         : Single; //Грузоподъемность, т
    P               : Single; //Масса автосамосвала, т
    F               : Single; //Площадь лобовой поверхности, м2
    Ro              : Single; //Коэф-нт обтекаемости авто
    TransmissionKind: TAutoTransmissionKind;//Тип трансмиссии: 0-ГМ, 1-ЭМ
    TransmissionKPD : Single; //КПД трансмиссии
    t_r             : Single; //Время разгрузки, с
    Rmin            : Single; //Минимальный радиус поворота, м
    TyresCount      : Integer;//Количество шин
    Id_Engine       : Integer;//Код двигателя
    EngineName      : String; //Марка двигателя
    EngineNmax      : Single; //Максимальная мощность двигателя, кВт
    ALength         : Single; //Длина, м
    AWidth          : Single; //Ширина, м
    AHeight         : Single; //Высота, м
  end;
  TDBAutoCharacs = class(TDBGlobalObject)
  private
    FItems: array of RDBAutoCharac; //Список моделей автосамосвалов
    FCount: Integer;                //Количество моделей автосамосвалов
    function GetItem(Index: Integer): RDBAutoCharac;
  public
    property Items[Index: Integer]: RDBAutoCharac read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(const AId_Auto: Integer): Integer;
    function FindBy(const AId_Engine: Integer): Integer;
    procedure RefreshData;override;
  end;{TDBAutoCharacs}
  
  //TDBExcavator - класс "Экскаватор списочного парка" ----------------------------------------
  TDBExcavator = class(TDBGlobalObject)
  private
    FId_DeportExcavator: Integer; //Уникальный код экскаватора списочного парка
    FId_Excavator      : Integer; //Код модели экскаватора
    FExcavatorInd      : Integer; //Индекс модели экскаватора
    FParkNo            : Integer; //Номер в парке
    FEYear             : Integer; //Год выпуска
    FWorkState         : Boolean; //Рабочее состояние: Да/нет
    FCost              : Single;  //Стоимость, тыс.тн
    FFactCycleTime     : Single;  //Фактическое время цикла, с
    FAddCostMaterials  : Single;  //Дополнительные стоимостные затраты на материалы, тыс.тн/мес
    FAddCostUnAccounted: Single;  //Дополнительные стоимостные затраты неучтенные, тыс.тн/мес
    FEngineKIM         : Single;  //Коэф-нт использования мощности двигателя, 0,25-0,35
    FEngineKPD         : Single;  //КПД двигателя, 0,936-0,948
    FName              : String;  //Наименование экскаватора
    FSENAmortizationRate: Single;  //Годовая норма амортизации
    function GetCharac: RDBExcavatorCharac;
    procedure SetId_DeportExcavator(const Value: Integer);
    procedure SetId_Excavator      (const Value: Integer);
    procedure SetParkNo            (const Value: Integer);
    procedure SetEYear             (const Value: Integer);
    procedure SetWorkState         (const Value: Boolean);
    procedure SetCost              (const Value: Single);
    procedure SetFactCycleTime     (const Value: Single);
    procedure SetAddCostMaterials  (const Value: Single);
    procedure SetAddCostUnAccounted(const Value: Single);
    procedure SetEngineKIM         (const Value: Single);
    procedure SetEngineKPD         (const Value: Single);
    procedure SetSENAmortizationRate (const Value: Single);//: Single;  //Годовая норма амортизации
  public
    property Characs: RDBExcavatorCharac read GetCharac;
    property Id_DeportExcavator: Integer read FId_DeportExcavator write SetId_DeportExcavator;
    property Id_Excavator      : Integer read FId_Excavator write SetId_Excavator;
    property ParkNo            : Integer read FParkNo write SetParkNo;
    property EYear             : Integer read FEYear write SetEYear;
    property WorkState         : Boolean read FWorkState write SetWorkState;
    property Cost              : Single read FCost write SetCost;
    property FactCycleTime     : Single read FFactCycleTime write SetFactCycleTime;
    property AddCostMaterials  : Single read FAddCostMaterials write SetAddCostMaterials;
    property AddCostUnAccounted: Single read FAddCostUnAccounted write SetAddCostUnAccounted;
    property EngineKIM         : Single read FEngineKIM write SetEngineKIM;
    property EngineKPD         : Single read FEngineKPD write SetEngineKPD;
    property TotalName         : String read FName;
    property SENAmortizationRate: Single read FSENAmortizationRate write SetSENAmortizationRate;
    constructor Create(AOpenpit: TDBOpenpit);
  end;{TDBExcavator}
  //TDBExcavators - класс "Экскаваторы списочного парка" --------------------------------------
  TDBExcavators = class(TDBGlobalObject)
  private
    FItems: array of TDBExcavator; //Список экскаваторов списочного парка
    FCount: Integer;               //Количество экскаваторов списочного парка
    function GetItem(Index: Integer): TDBExcavator;
  public
    property Items[Index: Integer]: TDBExcavator read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(const AId_DeportExcavator: Integer): Integer;overload;
    function IndexOf(const ATotalName: String): Integer;overload;
    procedure RefreshData;override;
  end;{TDBExcavators}
  //TDBAuto - класс "Автосамосвал списочного парка" -------------------------------------------
  TDBAuto = class(TDBGlobalObject)
  private
    FId_DeportAuto   : Integer; //Уникальный код автосамосвала списочного парка
    FId_Auto         : Integer; //Код модели автосамосвала
    FAutoInd         : Integer; //Индекс модели автосамосвала
    FParkNo          : Integer; //Номер в парке
    FAYear           : Integer; //Год выпуска
    FWorkState       : Boolean; //Рабочее состояние: Да/нет
    FFactTonnage     : Single;  //Фактическая грузоподъемность, т
    FCost            : Single;  //Стоимость, тыс.тн
    FAmortizationRate: Single;  //Норма амортизации на 1 тыс.км
    FTransmissionKPD : Single;  //КПД трансмиссии, 0..1
    FEngineKPD       : Single;  //КПД двигателя, 0..1
    FTyreCost        : Single;  //Стоимость 1 шины, тыс.тн
    FTyresRaceRate   : Single;  //Норма пробега шин, тыс.км.
    FId_ShiftPunkt   : Integer; //Код пункта пересменки
    FShiftPunktInd   : Integer; //Код пункта пересменки
    FId_Course       : Integer; //Код маршрута движения
    FCourseInd       : Integer; //Код маршрута движения
    function GetCharac: RDBAutoCharac;
    function GetCourse: TDBCourse;
    function GetShiftPunkt: TDBShiftPunkt;
    procedure SetId_DeportAuto   (const Value: Integer);
    procedure SetId_Auto         (const Value: Integer);
    procedure SetParkNo          (const Value: Integer);
    procedure SetAYear           (const Value: Integer);
    procedure SetWorkState       (const Value: Boolean);
    procedure SetFactTonnage     (const Value: Single);  
    procedure SetCost            (const Value: Single);
    procedure SetAmortizationRate(const Value: Single);
    procedure SetTransmissionKPD (const Value: Single);
    procedure SetEngineKPD       (const Value: Single);
    procedure SetTyreCost        (const Value: Single);
    procedure SetTyresRaceRate   (const Value: Single);
    procedure SetId_ShiftPunkt   (const Value: Integer);
    procedure SetId_Course       (const Value: Integer);
  public
    property Characs: RDBAutoCharac read GetCharac;
    property Courses: TDBCourse read GetCourse;
    property ShiftPunkts: TDBShiftPunkt read GetShiftPunkt;
    property Id_DeportAuto   : Integer read FId_DeportAuto write SetId_DeportAuto;
    property Id_Auto         : Integer read FId_Auto write SetId_Auto;
    property ParkNo          : Integer read FParkNo write SetParkNo;
    property AYear           : Integer read FAYear write SetAYear;
    property WorkState       : Boolean read FWorkState write SetWorkState;
    property FactTonnage     : Single read FFactTonnage write SetFactTonnage;  
    property Cost            : Single read FCost write SetCost;
    property AmortizationRate: Single read FAmortizationRate write SetAmortizationRate;
    property TransmissionKPD : Single read FTransmissionKPD write SetTransmissionKPD;
    property EngineKPD       : Single read FEngineKPD write SetEngineKPD;
    property TyreCost        : Single read FTyreCost write SetTyreCost;
    property TyresRaceRate   : Single read FTyresRaceRate write SetTyresRaceRate;
    property Id_ShiftPunkt   : Integer read FId_ShiftPunkt write SetId_ShiftPunkt;
    property Id_Course       : Integer read FId_Course write SetId_Course;
    constructor Create(AOpenpit: TDBOpenpit);
  end;{TDBAutoCharacs}
  //TDBAutos - класс "Автосамосвалы списочного парка" -----------------------------------------
  TDBAutos = class(TDBGlobalObject)
  private
    FItems: array of TDBAuto; //Список автосамосвалов списочного парка
    FCount: Integer;           //Количество автосамосвалов списочного парка
    function GetItem(Index: Integer): TDBAuto;
  public
    property Items[Index: Integer]: TDBAuto read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(const AId_DeportAuto: Integer): Integer;
    procedure RefreshData;override;
  end;{TDBAutos}
  //TDBRocks - класс "Добываемые горные породы на карьере" ------------------------------------
  RDBRock=record
    Id_Rock        : Integer;//Код горной породы
    Name           : String; //Наименование горной породы
    IsMineralWealth: Boolean;//Полезное ископаемое?
  end;{RDBRock}
  TDBRocks = class(TDBGlobalObject)
  private
    FItems: array of RDBRock; //Список горных пород
    FCount: Integer;          //Количество горных пород
    function GetItem(Index: Integer): RDBRock;
  public
    property Items[Index: Integer]: RDBRock read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    function IndexOf(const AId_Rock: Integer): Integer;
    procedure RefreshData;override;
  end;{TDBRocks}

  RDBPoint=record
    Id_Point: Integer;
    Coords: RPoint3D;
  end;
  //TDBPoints - класс "Характерные точки" -----------------------------------------------------
  TDBPoints = class(TDBGlobalObject)
  private
    FItems: array of RDBPoint; //Список характерных точек таблицы
    FCount: Integer;           //Количество характерных точек таблицы
    FBound: RBound3D;          //Контур характерных точек таблицы
    procedure SetItem(Index: Integer; Value: RDBPoint);
    function GetItem(Index: Integer): RDBPoint;
    function GetAssignedObjects(var sId_Points: String;
                                const APointIndexes: TIntegerDynArray): String;
  public
    property Items[Index: Integer]: RDBPoint read GetItem write SetItem;default;
    property Count: Integer read FCount;
    property Bound: RBound3D read FBound;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Clear;
    procedure RefreshData;override;
    procedure UpdateBound;
    procedure Draw;
    function IndexOf(const AX,AY: Single): Integer;overload;
    function IndexOf(const AId_Point: Integer): Integer;overload;
    procedure Add(const AX,AY,AZ: Single);
    function Delete(const APointIndexes: TIntegerDynArray): Boolean;
    procedure DeleteAll;
    procedure SetTotalZ(AZ: Single; const APointIndexes: TIntegerDynArray);
    procedure Interpolation(const APointIndexes: TIntegerDynArray; const AZ0,AZ1: Single);
  end;{TDBPoints}

  //TDBBlock - класс "Блок-участок" -----------------------------------------------------------
  TDBBlock = class(TDBGlobalObject)
  private
    FId_Block    : Integer;          //Код блок-участка
    FStripCount  : Byte;             //Количество полос движения
    FStripWidth  : Single;           //Ширина полосЫ движения, м
    FId_RoadCoat : Integer;          //Код дорожного покрытия
    FRoadCoatInd : Integer;          //Индекс дорожного покрытия
    FLoadingVmax : Single;           //Допускаемая скорость, км/ч
    FUnLoadingVmax: Single;           //Допускаемая скорость, км/ч
    FKind        : TBlockKind;       //Тип блок-участка
    FCount       : Integer;          //Количество точек блок-участка
    FPointIndexes: TIntegerDynArray; //Индексы характерных точек блок-участка
    FLength      : Single;           //Длина блок-участка, м
    FLeftCoords,FRightCoords: array of RPoint3D; //Левая и правая обочины Блок-участка
    procedure SetId_Block   (const Value: Integer);
    procedure SetStripCount (const Value: Byte);
    procedure SetStripWidth (const Value: Single);
    procedure SetId_RoadCoat(const Value: Integer);
    procedure SetLoadingVmax       (const Value: Single);
    procedure SetUnLoadingVmax       (const Value: Single);
    procedure SetKind       (const Value: TBlockKind);
    function GetPointIndex(Index: Integer): Integer;
    function GetPoint(Index: Integer): RDBPoint;
    function GetLeftCoord(Index: Integer): RPoint3D;
    function GetRightCoord(Index: Integer): RPoint3D;
    function GetCenterCoord(Index: Integer): RPoint3D;
    procedure UpdateLength;
  public
    property Id_Block   : Integer read FId_Block write SetId_Block;
    property StripCount : Byte read FStripCount write SetStripCount;
    property StripWidth : Single read FStripWidth write SetStripWidth;
    property Id_RoadCoat: Integer read FId_RoadCoat write SetId_RoadCoat;
    property RoadCoatInd: Integer read FRoadCoatInd;
    property LoadingVmax: Single read FLoadingVmax write SetLoadingVmax;
    property UnLoadingVmax: Single read FUnLoadingVmax write SetUnLoadingVmax;
    property Kind       : TBlockKind read FKind write SetKind; //тип БУ
    property BlockLength: Single read FLength;
    property PointIndexes[Index: Integer]: Integer read GetPointIndex;default;
    property Count: Integer read FCount;        //количество БУ
    property Points[Index: Integer]: RDBPoint read GetPoint;
    property LeftCoords[Index: Integer]: RPoint3D read GetLeftCoord;
    property RightCoords[Index: Integer]: RPoint3D read GetRightCoord;
    property CenterCoords[Index: Integer]: RPoint3D read GetCenterCoord;
    property Lm: Single read FLength; //Длина блок-участка, м
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
  end;{TDBBlock}
  //TDBBlocks - класс "Блок-участки" ----------------------------------------------------------
  TDBBlocks = class(TDBGlobalObject)
  private
    FCount: Integer;           //Количество блок-участков
    FItems: array of TDBBlock; //Блок-участки
    function GetItem(Index: Integer): TDBBlock;
    function GetAssignedObjects(var sId_Blocks: String;
                                const ABlockIndexes: TIntegerDynArray): String;
  public
    property Items[Index: Integer]: TDBBlock read GetItem;default;
    property Count: Integer read FCount;
    procedure SetTotalValues(const sStripCount,sStripWidth,sId_RoadCoat,sKind,sLoadingVmax,sUnLoadingVmax: String;
                             const ABlockIndexes: TIntegerDynArray);
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    function FindBy(const AId_Point: Integer): String;
    function IndexOf(const APointIndexes: TIntegerDynArray): Integer;overload;
    function IndexOf(const AId_Block: Integer): Integer;overload;
    function Add(const APointsIndexes: TIntegerDynArray;
                 const AIsCrossRoad: Boolean=false): Integer;

    function Delete(const ABlocksIndexes: TIntegerDynArray): Boolean;
    procedure DeleteAll;
    procedure Draw;
    procedure RefreshData;override;
    procedure Clear;
    procedure UpdateLength;
  end;{TDBBlocks}

  //TDBCourse - класс "Маршрут движения" ------------------------------------------------------
  TCourseKind=(ckCourseMoving,ckCourseTo,ckCourseFrom);
  TDBCourse = class(TDBGlobalObject)
  private
    FId_Course        : Integer;          //Код маршрута
    FId_Point0        : Integer;          //Код начальной точки
    FId_Point1        : Integer;          //Код конечной точки
    FKind             : TCourseKind;
    FCount            : Integer;          //Количество блок-участков маршрута
    FBlockIndexes     : TIntegerDynArray; //Индексы блок-участков маршрута
    FLength           : Single;           //Длина маршрута, м
    FPointIndexes     : TIntegerDynArray; //Индексы точек маршрута
    FPointIndexesCount: Integer;          //Количество точек
    FLeftCoords,FRightCoords: array of RPoint3D; //Левая и правая обочина маршрутов

    procedure SetId_Course   (const Value: Integer);
    procedure SetId_Point0   (const Value: Integer);
    procedure SetId_Point1   (const Value: Integer);
    function GetBlock(Index: Integer): TDBBlock;
    function GetBlockIndex(Index: Integer): Integer;
    function GetCenterCoord(Index: Integer): RPoint3D;
    function GetLeftCoord(Index: Integer): RPoint3D;
    function GetRightCoord(Index: Integer): RPoint3D;
    function GetName: String;
    procedure UpdateLength;
  public
    property Id_Course   : Integer read FId_Course write SetId_Course;
    property Id_Point0   : Integer read FId_Point0 write SetId_Point0;
    property Id_Point1   : Integer read FId_Point1 write SetId_Point1;
    property Kind        : TCourseKind read FKind;
    property Name        : String read GetName;
    property Count: Integer read FCount;
    property BlockIndexes[Index: Integer]: Integer read GetBlockIndex;default;
    property Blocks[Index: Integer]: TDBBlock read GetBlock;

    property CourseLength: Single read FLength;
    property PointIndexesCount: Integer read FPointIndexesCount;
    property CenterCoords[Index: Integer]: RPoint3D read GetCenterCoord;
    property LeftCoords[Index: Integer]: RPoint3D read GetLeftCoord;
    property RightCoords[Index: Integer]: RPoint3D read GetRightCoord;

    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
  end;{TDBCourse}
  //TDBCourses - класс "Маршруты движения" ----------------------------------------------------
  TDBCourses = class(TDBGlobalObject)
  private
    FCount: Integer;            //Количество маршрутов
    FItems: array of TDBCourse; //Маршруты
    function GetItem(Index: Integer): TDBCourse;
    function IsPosibleCourse(const AId_Point0, AId_Point1: Integer): TIntegerDynArray;
  public
    property Items[Index: Integer]: TDBCourse read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    function IndexOf(const AId_Point0,AId_Point1: Integer): Integer;overload;
    function IndexOf(const AId_Course: Integer): Integer;overload;
    function FindBlocks(const AId_Block: Integer): String;
    function FindPoints(const AId_Point: Integer): String;
    function Add(const AId_Point0,AId_Point1: Integer): Integer; overload;
    function Add(const AIndexes: TIntegerDynArray): Integer; overload;
    function Delete(const ACoursesIndexes: TIntegerDynArray): Boolean;
    procedure DeleteAll;
    procedure Draw;
    procedure RefreshData;override;
    procedure Clear;
    procedure UpdateLength;
  end;{TDBCourses}

  //TDBLoadingPunktRock - класс "Добываемая горная порода на пункте погрузки" -----------------
  TDBLoadingPunktRock = class(TDBGlobalObject)
  private
    FId_Rock   : Integer; //Код типа погружаемой породы
    FRockInd   : Integer; //Индекс типа погружаемой породы
    FContent   : Single;  //Содержание полезного ископаемого в руде, % >=0.0
    FPlannedVm3: Single;  //План на период, куб.м. >=0.0

    procedure SetId_Rock   (const Value: Integer);
    procedure SetContent   (const Value: Single);
    procedure SetPlannedVm3(const Value: Single);
    function GetRock: RDBRock;
  public
    property Id_Rock   : Integer read FId_Rock write SetId_Rock;
    property Content   : Single read FContent write SetContent;
    property PlannedVm3: Single read FPlannedVm3 write SetPlannedVm3;
    property Rock: RDBRock read GetRock;
    constructor Create(AOpenpit: TDBOpenpit);
  end;{TDBLoadingPunktRocks}

  //TDBPunkt - класс "Пункт" ------------------------------------------------------------------
  TDBPunkt = class(TDBGlobalObject)
  private
    FId_Point: Integer;
    FPointInd: Integer;
    procedure SetId_Point(const Value: Integer);
    function GetCoords: RPoint3D;
  public
    property Id_Point: Integer read FId_Point write SetId_Point;
    property PointInd: Integer read FPointInd;
    property Coords: RPoint3D read GetCoords;
    constructor Create(AOpenpit: TDBOpenpit);
  end;{TDBPunkt}
  //TDBLoadingPunkt - класс "Пункт погрузки" --------------------------------------------------
  TDBLoadingPunkt = class(TDBPunkt)
  private
    FId_LoadingPunkt: Integer;           //Код пункта погрузки
    FId_DeportExcavator: Integer;        //Код экскаватора, закрепленного за ПП
    FDeportExcavatorInd: Integer;        //Индекс экскаватора, закрепленного за ПП
    FCount: Integer;                     //Количество горных пород, добываемых на данном ПП
    FItems: array of TDBLoadingPunktRock;//Список горных пород, добываемых на данном ПП
    procedure SetId_LoadingPunkt(const Value: Integer);
    procedure SetId_DeportExcavator(const Value: Integer);
    function GetItem(Index: Integer): TDBLoadingPunktRock;
    function GetDeportExcavator: TDBExcavator;
    function GetDeportExcavatorName: String;
  public
    property Count: Integer read FCount;
    property Items[Index: Integer]: TDBLoadingPunktRock read GetItem;default;
    property Id_LoadingPunkt: Integer read FId_LoadingPunkt write SetId_LoadingPunkt;
    property Id_DeportExcavator: Integer read FId_DeportExcavator write SetId_DeportExcavator;
    property Excavator: TDBExcavator read GetDeportExcavator;
    property ExcavatorName: String read GetDeportExcavatorName;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Add(const AId_Rock: Integer; const AContent,APlannedVm3: Single);
    procedure Clear;
  end;{TDBLoadingPunkt}
  //TDBLoadingPunkts - класс "Пункты погрузки" ------------------------------------------------
  TDBLoadingPunkts = class(TDBGlobalObject)
  private
    FCount: Integer;                  //Количество пунктов погрузки
    FItems: array of TDBLoadingPunkt; //Список пунктов погрузки
    function GetItem(Index: Integer): TDBLoadingPunkt;
    function GetAssignedObjects(var sId_LoadingPunkts: String;
                                const ALoadingPunktIndexes: TIntegerDynArray): String;
  public
    property Items[Index: Integer]: TDBLoadingPunkt read GetItem;default;
    property Count: Integer read FCount;
    procedure SetTotalValues(sId_DeportExcavator: String;
                             const ALoadingPunktIndexes: TIntegerDynArray);
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    function IndexOf(const APointIndex: Integer): Integer;
    function FindBy(const AId_Point: Integer): String;
    function Add(const APointIndex: Integer): Integer;
    function Delete(const ALoadingPunktsIndexes: TIntegerDynArray): Boolean;
    procedure Draw;
    procedure RefreshData;override;
    procedure Clear;
  end;{TDBLoadingPunkts}

  //TDBUnLoadingPunktRock - класс "Горная порода на пункте разгрузки" -------------------------
  TDBUnLoadingPunktRock = class(TDBGlobalObject)
  private
    FId_Rock        : Integer; //Код горной породы
    FRockInd        : Integer; //Индекс горной породы
    FRequiredContent: Single;  //Требуемое содержание, %
    FInitialContent : Single;  //Содержание на начало смены, %
    FInitialVm3   : Single;  //Объем на начало смены, м3

    procedure SetId_Rock        (const Value: Integer);
    procedure SetRequiredContent(const Value: Single);
    procedure SetInitialContent (const Value: Single);
    procedure SetInitialVm3   (const Value: Single);
    function GetRock: RDBRock;
  public
    property Id_Rock        : Integer read FId_Rock write SetId_Rock;
    property RequiredContent: Single read FRequiredContent write SetRequiredContent;
    property InitialContent : Single read FInitialContent write SetInitialContent;
    property InitialVm3   : Single read FInitialVm3 write SetInitialVm3;
    property Rock: RDBRock read GetRock;
    constructor Create(AOpenpit: TDBOpenpit);
  end;{TDBUnLoadingPunktRock}
  
  //TDBUnLoadingPunkt - класс "Пункт разгрузки" -----------------------------------------------
  TDBUnLoadingPunkt = class(TDBPunkt)
  private
    FId_UnLoadingPunkt: Integer;            //Код Пункта Разгрузки (ПР)
    FCount: Integer;                        //Количество горных пород, добываемых на данном ПР
    FItems: array of TDBUnLoadingPunktRock; //Список горных пород, добываемых на данном ПР
    FMaxV1000m3       : Single;             //Емкость приемного бункера, тыс.м3
    FAutoMaxCount     : Integer;            //Число авто, к-х можно разместить на пункте
    FKind             : TUnLoadingPunktKind;//Тип пункта разгрузки
    procedure SetId_UnLoadingPunkt(const Value: Integer);
    function GetItem(Index: Integer): TDBUnLoadingPunktRock;
    procedure SetMaxV1000m3(const Value: Single);
    procedure SetAutoMaxCount(const Value: Integer);
    procedure SetKind(const Value: TUnLoadingPunktKind);
  public
    property Count: Integer read FCount;
    property Items[Index: Integer]: TDBUnLoadingPunktRock read GetItem;default;
    property Id_UnLoadingPunkt: Integer read FId_UnLoadingPunkt write SetId_UnLoadingPunkt;
    property MaxV1000m3: Single read FMaxV1000m3 write SetMaxV1000m3;
    property AutoMaxCount: Integer read FAutoMaxCount write SetAutoMaxCount;
    property Kind: TUnLoadingPunktKind read FKind write SetKind;

    procedure Clear;
    function FindBy(const AId_Rock: Integer;ARequiredContent: Single): Integer;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy;override;
    procedure Add(const AId_Rock: Integer;
                  const ARequiredContent,AInitialContent,AInitialVm3: Single);
  end;{TDBUnLoadingPunkt}
  //TDBUnLoadingPunkts - класс "Пункты погрузки" ----------------------------------------------
  TDBUnLoadingPunkts = class(TDBGlobalObject)
  private
    FCount: Integer;                    //Количество Пунктов Разгрузки
    FItems: array of TDBUnLoadingPunkt; //Список Пунктов Разгрузки
    function GetItem(Index: Integer): TDBUnLoadingPunkt;
    function GetAssignedObjects(var sId_UnLoadingPunkts: String;
      const AUnLoadingPunktIndexes: TIntegerDynArray): String;
  public
    property Items[Index: Integer]: TDBUnLoadingPunkt read GetItem;default;
    property Count: Integer read FCount;
    procedure SetTotalValues(const sMaxV1000m3,sAutoMaxCount,sKind: String;
                             const AUnLoadingPunktIndexes: TIntegerDynArray);
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    function IndexOf(const APointIndex: Integer): Integer;
    function FindBy(const AId_Point: Integer): String;
    function Add(const APointIndex: Integer): Integer;
    function Delete(const AUnLoadingPunktsIndexes: TIntegerDynArray): Boolean;
    procedure Draw;
    procedure RefreshData;override;
    procedure Clear;
  end;{TDBUnLoadingPunkts}

  //TDBShiftPunkts - класс "Пункты пересменки" ------------------------------------------------
  TDBShiftPunkt = class(TDBPunkt)
  private
    FId_ShiftPunkt: Integer;  //Код пункта пересменки
    procedure SetId_ShiftPunkt(const Value: Integer);
  public
    property Id_ShiftPunkt: Integer read FId_ShiftPunkt write SetId_ShiftPunkt;
    constructor Create(AOpenpit: TDBOpenpit);
  end;{TDBShiftPunkt}
  TDBShiftPunkts = class(TDBGlobalObject)
  private
    FCount: Integer;                //Количество пунктов пересменки
    FItems: array of TDBShiftPunkt; //Список пунктов пересменки
    function GetItem(Index: Integer): TDBShiftPunkt;
    function GetAssignedObjects(var sId_ShiftPunkts: String;
                                const AShiftPunktIndexes: TIntegerDynArray): String;
  public
    property Items[Index: Integer]: TDBShiftPunkt read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    function IndexOf(const APointIndex: Integer): Integer;
    function FindBy(const AId_Point: Integer): String;
    function Add(const APointIndex: Integer): Integer;
    function Delete(const AShiftPunktsIndexes: TIntegerDynArray): Boolean;
    procedure Draw;
    procedure RefreshData;override;
    procedure Clear;
  end;{TDBShiftPunkts}
  //TDBSelectedObjects - класс "Список индексов выделенных объектов" --------------------------
  TSelectedKind=(skPoints,skBlockPoints,skCrossRoadPoints,skBlocks,skCrossRoads,skCoursePoints,skCourseBlocks,
                 skCourses,skLoadingPunkts,skUnLoadingPunkts,skShiftPunkts);
  TDBSelectedObjects = class(TDBGlobalObject)
    procedure DoKeyPress(Sender: TObject; var Key: Char);
  private
    FIndexes        : TIntegerDynArray;  //Список индексов выделенных объектов
    FCount          : Integer;           //Количество выделенных объектов
    FSelectedNumbers: String;            //Список номеров выделенных объектов

    FColor          : TColor;            //Цвет выделенных объектов
    FSelectedKind   : TSelectedKind;     //Тип выделенного объекта
    FLength         : Single;            //Длина выделенного объекта, м

    function GetItem(Index: Integer): Integer;
    procedure SetColor(Value: TColor);
    procedure SetSelectedKind(Value: TSelectedKind);
    procedure UpdateLength;
    procedure CreateEditorForm(var Form: TForm; W,H: Integer;
                               var ValueListEditor: TValueListEditor;
                               const ACaption: String;
                               var btOk,btCancel: TButton);
    //для точек
    function GetPoint(Index: Integer): RDBPoint;
    function CheckPointsEditorValues(const sX, sY, sZ: String): Boolean;
    procedure DrawPoints;
    procedure PointsEditorExecute;
    //для блок-участков
    function GetBlock(Index: Integer): TDBBlock;
    function CheckBlocksEditorValues(const sStripCount, sStripWidth,sLoadingVmax,sUnLoadingVmax: String): Boolean;
    function FindBlock(const APoint: RPoint3D): Integer;
    procedure DrawBlocks;
    procedure BlocksEditorExecute;
    //для маршрутов
    function GetCourse(Index: Integer): TDBCourse;
    function FindCourse(const APoint: RPoint3D): Integer;
    procedure DrawCourses;
    //для пунктов погрузки
    function GetLoadingPunkt(Index: Integer): TDBLoadingPunkt;
    function FindLoadingPunkt(const APoint: RPoint3D): Integer;
    procedure DrawLoadingPunkts;
    procedure LoadingPunktsEditorExecute;
    //для пунктов рагрузки
    function GetUnLoadingPunkt(Index: Integer): TDBUnLoadingPunkt;
    function CheckUnLoadingPunktsEditorValues(const sMaxV1000m3, sAutoMaxCount: String): Boolean;
    function FindUnLoadingPunkt(const APoint: RPoint3D): Integer;
    procedure DrawUnLoadingPunkts;
    procedure UnLoadingPunktsEditorExecute;
    //для пунктов пересменки
    function GetShiftPunkt(Index: Integer): TDBShiftPunkt;
    function FindShiftPunkt(const APoint: RPoint3D): Integer;
    procedure DrawShiftPunkts;
    function InterpolationDlg(var AZ0, AZ1: Single): Boolean;
  public
    function FindPoint(const APoint: RPoint3D; const ARadiusMtr: Single): Integer;
    property Count: Integer read FCount;
    property Items[Index: Integer]: Integer read GetItem;
    property Color: TColor read FColor write SetColor;
    property SelectedKind: TSelectedKind read FSelectedKind write SetSelectedKind;
    property SelectedNumbers: String read FSelectedNumbers;
    property TotalLength: Single read FLength;

    //для точек
    property Points[Index: Integer]: RDBPoint read GetPoint;
    //для блок-участков
    property Blocks[Index: Integer]: TDBBlock read GetBlock;
    //для маршрутов
    property Courses[Index: Integer]: TDBCourse read GetCourse;
    //для пунктов погрузки
    property LoadingPunkts[Index: Integer]: TDBLoadingPunkt read GetLoadingPunkt;
    //для пунктов разгрузки
    property UnLoadingPunkts[Index: Integer]: TDBUnLoadingPunkt read GetUnLoadingPunkt;
    //для пунктов пересменки
    property ShiftPunkts[Index: Integer]: TDBShiftPunkt read GetShiftPunkt;

    constructor Create(AOpenpit: TDBOpenpit);
    destructor Destroy; override;
    procedure Draw;

    procedure Add(const Item: Integer);
    procedure Clear;
    procedure Delete(const Index: Integer);
    function IndexOf(const Item: Integer): Integer;

    procedure AddSelectedObjectsTo(const AX,AY: Single);
    procedure DeleteSelectedObjects;
    procedure EditorExecute;
    procedure Select(const pxlPoint: TPoint; const Shift: TShiftState);
    procedure SelectAll;

    //для точек
    procedure InterpolationPoints;
    procedure InterpolationBlocks;
    function SelectPoints(const pxlPoint: TPoint;const Shift: TShiftState): Integer;
    //для блок-участков
    function SelectBlocks(const pxlPoint: TPoint;const Shift: TShiftState): Integer;
    //для маршрутов
    function SelectCourses(const pxlPoint: TPoint;const Shift: TShiftState): Integer; overload;
    //Выделение маршрутов
    function SelectCourses(): Boolean; overload;
    //для пунктов погрузки
    function SelectLoadingPunkts(const pxlPoint: TPoint;const Shift: TShiftState): Integer;
    //для пунктов разгрузки
    function SelectUnLoadingPunkts(const pxlPoint: TPoint;const Shift: TShiftState): Integer;
    //для пунктов пересменки
    function SelectShiftPunkts(const pxlPoint: TPoint;const Shift: TShiftState): Integer;
    function VisibleEditorExecute: Boolean;
  end;{TDBSelectedObjects}

function BlockKindToStr(const ABlockKind: TBlockKind): String;
function UnLoadingPunktKindToStr(const AUnLoadingPunktKind: TUnLoadingPunktKind): String;
//function CourseKindToStr(const ACourseKind: TCourseKind): String;
implementation
uses SysUtils, DB, Math, OpenGL, Variants, Controls, Grids, ExtCtrls, CheckLst, DBTables, Dialogs,
  esaDBOpenpitUklons;
  
function BlockKindToStr(const ABlockKind: TBlockKind): String;
begin
  case ABlockKind of
    bukMoving   : Result := 'Участок движения';
    bukRoadDown : Result := 'Съезд';
    bukManeuver : Result := 'Участок для маневра';
    bukCrossRoad: Result := 'Перекресток';
    else Result := '';
  end;{case}
end;{BlockKindToStr}
function UnLoadingPunktKindToStr(const AUnLoadingPunktKind: TUnLoadingPunktKind): String;
begin
  case AUnLoadingPunktKind of
    ulpkFactory: Result := 'Фабрика';
    ulpkStorage: Result := 'Перегрузочный склад';
    ulpkSpoil  : Result := 'Отвал';
  else Result := '';
  end;{case}
end;{UnLoadingPunktKindToStr}
(*
function CourseKindToStr(const ACourseKind: TCourseKind): String;
begin
  case ACourseKind of
    ckulpkFactory: Result := 'Фабрика';
    ulpkStorage: Result := 'Перегрузочный склад';
    ulpkSpoil  : Result := 'Отвал';
  else Result := '';
  end;{case}
end;{CourseKindToStr}
*)
//TDBOpenpit - класс "Карьер" -----------------------------------------------------------------
function TDBOpenpit.GetHandle: HWND;
begin
  if FGraphKernel<>nil then Result := FGraphKernel.Handle else Result := 0;
end;{GetHandle}
function TDBOpenpit.GetCanvasHandle: HWND;
begin
  if FGraphKernel<>nil then Result := FGraphKernel.CanvasHandle else Result := 0;
end;{GetCanvasHandle}
procedure TDBOpenpit.CheckDefaultParams;
begin
  DefaultParams.OpenpitId_Openpit := FId_Openpit;
  if AutoCharacs.IndexOf(DefaultParams.DeportAutoId_Auto)=-1 then
  begin
    if AutoCharacs.Count=0
    then DefaultParams.DeportAutoId_Auto := 0
    else DefaultParams.DeportAutoId_Auto := AutoCharacs[0].Id_Auto;
  end;{if}
  if ExcavatorCharacs.IndexOf(DefaultParams.DeportExcId_Excavator)=-1 then
  begin
    if ExcavatorCharacs.Count=0
    then DefaultParams.DeportExcId_Excavator := 0
    else DefaultParams.DeportExcId_Excavator := ExcavatorCharacs[0].Id_Excavator;
  end;{if}
  if RoadCoats.IndexOf(DefaultParams.BlockId_RoadCoat)=-1 then
  begin
    if RoadCoats.Count=0
    then DefaultParams.BlockId_RoadCoat := 0
    else DefaultParams.BlockId_RoadCoat := RoadCoats[0].Id_RoadCoat;
  end;{if}
  if AutoCharacs.FindBy(DefaultParams.AutoId_Engine)=-1 then
  begin
    if AutoCharacs.Count=0
    then DefaultParams.AutoId_Engine := 0
    else DefaultParams.AutoId_Engine := AutoCharacs[0].Id_Engine;
  end;{if}
  if ExcavatorCharacs.FindBy(DefaultParams.ExcavatorId_Engine)=-1 then
  begin
    if ExcavatorCharacs.Count=0
    then DefaultParams.ExcavatorId_Engine := 0
    else DefaultParams.ExcavatorId_Engine := ExcavatorCharacs[0].Id_Engine;
  end;{if}
end;{CheckDefaultParams}
procedure TDBOpenpit.SetBound(const Value: RBound3D);
begin
  if (abs(Value.MinX-Value.MaxX)>0.0)and
     (abs(Value.MinX-Value.MaxX)>0.0)and
     (abs(Value.MinX-Value.MaxX)>0.0)then
  begin
    FBound.MinX := Min(Value.MinX,Value.MaxX);
    FBound.MinY := Min(Value.MinY,Value.MaxY);
    FBound.MinZ := Min(Value.MinZ,Value.MaxZ);
    FBound.MaxX := Max(Value.MinX,Value.MaxX);
    FBound.MaxY := Max(Value.MinY,Value.MaxY);
    FBound.MaxZ := Max(Value.MinZ,Value.MaxZ);
    FGraphKernel.ScreenBoundMtr := FBound;
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'SELECT * FROM Openpits WHERE Id_Openpit='+IntToStr(Id_Openpit);
      Open;
      if RecordCount>0 then
      begin
        Edit;
        FieldByName('MinX').AsFloat := FBound.MinX;
        FieldByName('MinY').AsFloat := FBound.MinY;
        FieldByName('MinZ').AsFloat := FBound.MinZ;
        FieldByName('MaxX').AsFloat := FBound.MaxX;
        FieldByName('MaxY').AsFloat := FBound.MaxY;
        FieldByName('MaxZ').AsFloat := FBound.MaxZ;
        Post;
      end;{if}
      Close;
    finally
      Free;
    end;{try}
  end;{if}
end;{SetBound}

constructor TDBOpenpit.Create(ADBConnection: TADOConnection; AGraphCernel: TGraphCernel2D;
                              ADefaultParams: TDBDefaultParams);
begin
  FGraphKernel := nil;
  FDefaultParams := nil;
  FDBConnection := nil;
  FId_Openpit := 0;
  FName := '';
  FDateCreate := Now;
  FSelectedObjects := nil;
  FRoadCoats := nil;
  FExcavatorCharacs := nil;
  FAutoCharacs := nil;
  FExcavators := nil;
  FAutos := nil;
  FRocks := nil;
  FPoints := nil;
  FBlocks := nil;
  FLoadingPunkts := nil;
  FUnLoadingPunkts := nil;
  FShiftPunkts := nil;
  FCourses := nil;
  inherited Create;
  if AGraphCernel=nil then raise Exception.Create(EUnsignedGraphKernel);
  if ADefaultParams=nil then raise Exception.Create(EUnsignedDefaultParams);
  if ADBConnection=nil then raise Exception.Create(EUnsignedDBConnection);
  if not ADBConnection.Connected then raise Exception.Create(EClosedDBConnection);
  FGraphKernel := AGraphCernel;
  FDefaultParams := ADefaultParams;
  FDBConnection := ADBConnection;
  FRoadCoats := TDBRoadCoats.Create(Self);
  FExcavatorCharacs := TDBExcavatorCharacs.Create(Self);
  FExcavators := TDBExcavators.Create(Self);
  FAutoCharacs := TDBAutoCharacs.Create(Self);
  FRocks := TDBRocks.Create(Self);
  FPoints := TDBPoints.Create(Self);
  FBlocks := TDBBlocks.Create(Self);
  FLoadingPunkts := TDBLoadingPunkts.Create(Self);
  FUnLoadingPunkts := TDBUnLoadingPunkts.Create(Self);
  FShiftPunkts := TDBShiftPunkts.Create(Self);
  FCourses := TDBCourses.Create(Self);
  FAutos := TDBAutos.Create(Self);
  FSelectedObjects := TDBSelectedObjects.Create(Self);

  FBound := Bound3D(0.0,5000.0,0.0,5000.0,0.0,500.0);
  RefreshData;
end;{Create}
destructor TDBOpenpit.Destroy;
begin
  FSelectedObjects.Free;
  FSelectedObjects := nil;
  FLoadingPunkts.Free;
  FLoadingPunkts := nil;
  FUnLoadingPunkts.Free;
  FUnLoadingPunkts := nil;
  FShiftPunkts.Free;
  FShiftPunkts := nil;
  FCourses.Free;
  FCourses := nil;
  FBlocks.Free;
  FBlocks := nil;
  FPoints.Free;
  FPoints := nil;

  FRoadCoats.Free;
  FRoadCoats := nil;
  FExcavators.Free;
  FExcavators := nil;
  FExcavatorCharacs.Free;
  FExcavatorCharacs := nil;
  FAutos.Free;
  FAutos := nil;
  FAutoCharacs.Free;
  FAutoCharacs := nil;
  FRocks.Free;
  FRocks := nil;
  FGraphKernel := nil;
  FDefaultParams := nil;
  FDBConnection := nil;
  inherited;
end;{Destroy}
procedure TDBOpenpit.Draw;
begin
  FCourses.Draw;
  FLoadingPunkts.Draw;
  FUnLoadingPunkts.Draw;
  FShiftPunkts.Draw;
  FBlocks.Draw;
  FPoints.Draw;
  FSelectedObjects.Draw;
end;{Draw}
//Обновить данные карьера
procedure TDBOpenpit.RefreshData;
begin
  //Очищаю объекты
  FSelectedObjects.Clear;
  FLoadingPunkts.Clear;
  FUnLoadingPunkts.Clear;
  FShiftPunkts.Clear;
  FCourses.Clear;
  FBlocks.Clear;
  FPoints.Clear;
  FRoadCoats.Clear;
  FExcavatorCharacs.Clear;
  FAutoCharacs.Clear;
  FExcavators.Clear;
  FAutos.Clear;
  FRocks.Clear;

  FId_Openpit := 0;
  FName := '';
  FDateCreate := Now;

  FRoadCoats.RefreshData;
  FExcavatorCharacs.RefreshData;
  FAutoCharacs.RefreshData;
  //Считываю данные карьера
  with TADOQuery.Create(nil) do
  try
    Connection := FDBConnection;
    SQL.Text := 'SELECT * FROM Openpits';
    Open;
    if RecordCount=0
    then raise Exception.Create(Format(EEmptyDBTable,['Карьеры']))
    else
    begin
      if not Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[])
      then DefaultParams.OpenpitId_Openpit := FieldByName('Id_Openpit').AsInteger;
      FId_Openpit := FieldByName('Id_Openpit').AsInteger;
      FDateCreate := FieldByName('DateCreate').AsDateTime;
      FName       := FieldByName('Name').AsString;
      FBound.MinX := FieldByName('MinX').AsFloat;
      FBound.MinY := FieldByName('MinY').AsFloat;
      FBound.MinZ := FieldByName('MinZ').AsFloat;
      FBound.MaxX := FieldByName('MaxX').AsFloat;
      FBound.MaxY := FieldByName('MaxY').AsFloat;
      FBound.MaxZ := FieldByName('MaxZ').AsFloat;
    end;{else}
    Close;
  finally
    Free;
  end;{try}
  FRocks.RefreshData;
  FExcavators.RefreshData;
  FPoints.RefreshData;
  FBlocks.RefreshData;
  FCourses.RefreshData;
  FLoadingPunkts.RefreshData;
  FUnLoadingPunkts.RefreshData;
  FShiftPunkts.RefreshData;
  FAutos.RefreshData;

  CheckDefaultParams;
  FGraphKernel.ScreenBoundMtr := FBound;
end;{RefreshData}
//
procedure TDBOpenpit.ConvertToCEBADAN;
var
  AOpenDlg : TOpenDialog;
  ATable: TTable;
  I,J: Integer;
begin
  AOpenDlg := TOpenDialog.Create(Nil);
  try
    AOpenDlg.Filter := 'Файлы таблиц Paradox (*.db)|*.db';
    if AOpenDlg.Execute then
    begin
      AOpenDlg.FileName := ExtractFilePath(AOpenDlg.FileName);
      if not FileExists(AOpenDlg.FileName+'XYZ.db')
      then esaMsgError('Не могу найти таблицу '''+AOpenDlg.FileName+'XYZ.db'+'''')
      else
      if not FileExists(AOpenDlg.FileName+'Block_U.db')
      then esaMsgError('Не могу найти таблицу '''+AOpenDlg.FileName+'Block_U.db'+'''')
      else
      begin
        ATable := TTable.Create(nil);
        try
          ATable.DatabaseName := AOpenDlg.FileName;
          ATable.TableName := 'XYZ';
          ATable.Open;
          while not ATable.Eof do
            ATable.Delete;
          for I := 0 to Points.Count-1 do
          begin
            ATable.Append;
            ATable.FieldByName('X').AsFloat := Points[I].Coords.X;
            ATable.FieldByName('Y').AsFloat := Points[I].Coords.Y;
            ATable.FieldByName('Z').AsFloat := Points[I].Coords.Z;
            ATable.Post;
          end;{for}
          ATable.Close;

          ATable.TableName := 'Block_U';
          ATable.Open;
          while not ATable.Eof do
            ATable.Delete;
          for I := 0 to Blocks.Count-1 do
          if Blocks[I].Count<=25 then
          begin
            ATable.Append;
            for J := 0 to Blocks[I].Count-1 do
              ATable.FieldByName('N'+IntToStr(J+1)).AsInteger := Blocks[I].PointIndexes[J]+1;
            ATable.Post;
          end{for}
          else esaMsgError(Format('Блок-участок №%d содержит более 25 точек (%d точки)',[I+1,Blocks[I].Count]));
          ATable.Close;
        finally
          ATable.Free;
        end;{try}
      end;{else}
    end;{if}
  finally
    AOpenDlg.Free;
  end;{try}
end;{ConvertToCEBADAN}
procedure TDBOpenpit.ConvertFromCEBADAN;
var
  AOpenDlg : TOpenDialog;
  ATable: TTable;
  I: Integer;
  ABlockPoints: TIntegerDynArray;
  ABlockPointsCount: Integer;
begin
  AOpenDlg := TOpenDialog.Create(Nil);
  try
    AOpenDlg.Filter := 'Файлы таблиц Paradox (*.db)|*.db';
    if AOpenDlg.Execute then
    begin
      AOpenDlg.FileName := ExtractFilePath(AOpenDlg.FileName);
      if not FileExists(AOpenDlg.FileName+'XYZ.db')
      then esaMsgError('Не могу найти таблицу '''+AOpenDlg.FileName+'XYZ.db'+'''')
      else
      if not FileExists(AOpenDlg.FileName+'Block_U.db')
      then esaMsgError('Не могу найти таблицу '''+AOpenDlg.FileName+'Block_U.db'+'''')
      else
      begin
        Courses.DeleteAll;
        Blocks.DeleteAll;
        Points.DeleteAll;
        ATable := TTable.Create(nil);
        try
          ATable.DatabaseName := AOpenDlg.FileName;
          ATable.TableName := 'XYZ';
          ATable.Open;
          ATable.Last;
          ATable.First;
          while not ATable.Eof do
          begin
            Points.Add(ATable.FieldByName('X').AsFloat,
                       ATable.FieldByName('Y').AsFloat,
                       ATable.FieldByName('Z').AsFloat);
            ATable.Next;
          end;{while}
          ATable.Close;

          ATable.TableName := 'Block_U';
          ATable.Open;
          while not ATable.Eof do
          begin
            SetLength(ABlockPoints,25);
            ABlockPointsCount := 0;
            for I := 1 to 25 do
            if ATable.FieldByName('N'+IntToStr(I)).AsInteger>0 then
            begin
              Inc(ABlockPointsCount);
              ABlockPoints[ABlockPointsCount-1] := ATable.FieldByName('N'+IntToStr(I)).AsInteger-1;
            end{if}
            else Break;
            SetLength(ABlockPoints,ABlockPointsCount);
            Blocks.Add(ABlockPoints);
            ATable.Next;
          end;{while}
          ATable.Close;
        finally
          ATable.Free;
        end;{try}
        Bound := Points.FBound;
      end;{else}
    end;{if}
  finally
    AOpenDlg.Free;
  end;{try}
end;{ConvertFromCEBADAN}
procedure TDBOpenpit.ConvertToPCD;
var
  ASaveDlg : TSaveDialog;
  I,J: Integer;
  f: TextFile;
  IsExist: Boolean;
begin
  ASaveDlg := TSaveDialog.Create(Nil);
  try
    ASaveDlg.Filter := 'Файлы ProCAD (*.pcd)|*.pcd';
    ASaveDlg.DefaultExt := '.pcd';
    ASaveDlg.FileName := 'АвтотрассаЖитикара2004.pcd';
    if ASaveDlg.Execute then
    begin
      IsExist := FileExists(ASaveDlg.FileName);
      if (IsExist and esaMsgQuestionYN('Файл '''+ASaveDlg.FileName+''' существует. Перезаписать?'))OR
         (not IsExist)then
      begin
        AssignFile(f,ASaveDlg.FileName);
        Rewrite(f);
        writeln(f,'$LAYER');
        writeln(f,'Автотрасса Житикара2004 Сулеймен');
        for I := 0 to Blocks.Count-1 do
        begin
          writeln(f,'$L');
          case Blocks[I].Kind of
            bukRoadDown : writeln(f,'Съезд');
            bukManeuver : writeln(f,'Блок-участок для маневра');
            bukCrossRoad: writeln(f,'Перекресток');
            else          writeln(f,'Блок-участок движения');
          end;{case}
          writeln(f,DefaultParams.BlockColors[Blocks[I].Kind]);
          writeln(f,'0');
          writeln(f,'0');
          writeln(f,'1');
          for J := 0 to Blocks[I].Count-1 do
          begin
            writeln(f,'$P');
            writeln(f,FloatToStr(Blocks[I].Points[J].Coords.X));
            writeln(f,FloatToStr(Blocks[I].Points[J].Coords.Y));
            writeln(f,FloatToStr(Blocks[I].Points[J].Coords.Z));
            writeln(f,'');
          end;{for}
        end;{for}
        CloseFile(f);
      end;{if}
    end;{if}
  finally
    ASaveDlg.Free;
  end;{try}
end;{ConvertToPCD}
//Анализ уклонов
procedure TDBOpenpit.AnalizeUklons();
var
  I,J    : Integer;
  AUklons: TesaBlockUklons;
  ACount : Integer;
  p0,p1  : RPoint3D;
begin
  ACount := 0;
  SetLength(AUklons,Points.Count);
  for I := 0 to Blocks.Count-1 do
  if Blocks[I].Kind=bukRoadDown then
  for J := 1 to Blocks[I].Count-1 do
  begin
    if Blocks[I].Points[J-1].Coords.Z<=Blocks[I].Points[J].Coords.Z then
    begin
      p0 := Blocks[I].Points[J-1].Coords;
      p1 := Blocks[I].Points[J].Coords;
    end{if}
    else
    begin
      p1 := Blocks[I].Points[J-1].Coords;
      p0 := Blocks[I].Points[J].Coords;
    end;{else}
    Inc(ACount);
    AUklons[ACount-1].p0 := p0;
    AUklons[ACount-1].p1 := p1;
    AUklons[ACount-1].Lm := sqrt(sqr(p1.X-p0.X)+sqr(p1.Y-p0.Y)+sqr(p1.Z-p0.Z));
    AUklons[ACount-1].Lx := sqrt(sqr(p1.X-p0.X)+sqr(p1.Y-p0.Y));
    AUklons[ACount-1].Hm := p1.Z-p0.Z;
    if AUklons[ACount-1].Lx>0.0
    then AUklons[ACount-1].Uprommile := 1000.0*AUklons[ACount-1].Hm/AUklons[ACount-1].Lx
    else AUklons[ACount-1].Uprommile := 0.0;
  end;{for}
  SetLength(AUklons,ACount);
  esaShowOpenpitUklonsDlg(AUklons);
end;{AnalizeUklons}
//TDBGlobalObject - класс "Глобальный объект" -------------------------------------------------
function TDBGlobalObject.GetHandle: HWND;
begin
  if FOpenpit<>nil then Result := FOpenpit.Handle else Result := 0;
end;{GetHandle}
function TDBGlobalObject.GetCanvasHandle: HWND;
begin
  if FOpenpit<>nil then Result := FOpenpit.CanvasHandle else Result := 0;
end;{GetCanvasHandle}
function TDBGlobalObject.GetGraphKernel: TGraphCernel2D;
begin
  if FOpenpit<>nil then Result := FOpenpit.GraphKernel else Result := nil;
end;{GetGraphKernel}
function TDBGlobalObject.GetDefaultParams: TDBDefaultParams;
begin
  if FOpenpit<>nil then Result := FOpenpit.DefaultParams else Result := nil;
end;{GetDefaultParams}
function TDBGlobalObject.GetDBConnection: TADOConnection;
begin
  if FOpenpit<>nil then Result := FOpenpit.DBConnection else Result := nil;
end;{GetDBConnection}
procedure TDBGlobalObject.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible := Value;
    Invalidate;
  end;{if}
end;{SetVisible}
constructor TDBGlobalObject.Create(AOpenpit: TDBOpenpit);
begin
  FOpenpit := nil;
  inherited Create;
  if AOpenpit=nil then raise Exception.Create(EUnsignedOpenpit);
  FOpenpit := AOpenpit;
  FVisible := true;
end;{Create}
destructor TDBGlobalObject.Destroy;
begin
  FOpenpit := nil;
  inherited;
end;{Destroy}
procedure TDBGlobalObject.Invalidate;
begin
  InvalidateRect(Handle,nil,false);
end;{Invalidate}
procedure TDBGlobalObject.RefreshData;
begin
end;{RefreshData}

//TDBRoadCoatUSK - класс "Коэффициенты уд.сопротивления качению Дорожного покрытия" -----------
function TDBRoadCoatUSK.GetItem(Index: Integer): RDBRoadCoatUSK;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
procedure TDBRoadCoatUSK.SetId_RoadCoat(const Value: Integer);
begin
  if (Value>0)and(FId_RoadCoat<>Value)then
  begin
    FId_RoadCoat := Value;
  end;{if}
end;{SetId_RoadCoat}
procedure TDBRoadCoatUSK.SetName(Value: String);
begin
  Value := Trim(Value);
  if (Value<>'')and(FName<>Value)then
  begin
    FName := Value;
  end;{if}
end;{SetName}
constructor TDBRoadCoatUSK.Create;
begin
  FId_RoadCoat := 0;
  FName := '';
  inherited;
  Clear;
end;{Create}
destructor TDBRoadCoatUSK.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBRoadCoatUSK.Add(const AP, AValueMin, AValueMax: Single);
begin
  Inc(FCount);
  SetLength(FItems,FCount);
  FItems[FCount-1].P            := AP;
  FItems[FCount-1].ValueMin     := AValueMin;
  FItems[FCount-1].ValueMax     := AValueMax;
end;{Add}
procedure TDBRoadCoatUSK.Clear;
begin
  FCount := 0;
  FItems := nil;
end;{Clear}

//TDBRoadCoats - класс "Дорожные покрытия" ----------------------------------------------------
function TDBRoadCoats.GetItem(Index: Integer): TDBRoadCoatUSK;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TDBRoadCoats.Create(AOpenpit: TDBOpenpit);
begin
  FItems := nil;
  FCount := 0;
  inherited;
end;{Create}
destructor TDBRoadCoats.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBRoadCoats.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FItems := nil;
  FCount := 0;
end;{Clear}
function TDBRoadCoats.IndexOf(const AId_RoadCoat: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_RoadCoat=AId_RoadCoat then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
function TDBRoadCoats.IndexOf(const ARoadCoat: String): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Name=ARoadCoat then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
procedure TDBRoadCoats.RefreshData;
var quRoadCoats,quRoadCoatUSKs: TADOQuery;
    dsRoadCoats: TDataSource;
begin
  Clear;
  quRoadCoats := TADOQuery.Create(nil);
  try
    quRoadCoats.Connection := DBConnection;
    quRoadCoats.SQL.Text := 'SELECT * FROM RoadCoats ORDER BY SortIndex';
    quRoadCoats.Open;
    
    dsRoadCoats := TDataSource.Create(nil);
    try
      dsRoadCoats.DataSet := quRoadCoats;
      quRoadCoatUSKs := TADOQuery.Create(nil);
      try
        quRoadCoatUSKs.Connection := DBConnection;
        quRoadCoatUSKs.DataSource := dsRoadCoats;
        quRoadCoatUSKs.SQL.Text := 'SELECT * FROM RoadCoatUSKs '+
                                   'WHERE Id_RoadCoat=:Id_RoadCoat ORDER BY P';
        quRoadCoatUSKs.Open;
        FCount := quRoadCoats.RecordCount;
        SetLength(FItems,FCount);
        while not quRoadCoats.Eof do
        begin
          quRoadCoatUSKs.Last;
          quRoadCoatUSKs.First;
          FItems[quRoadCoats.RecNo-1] := TDBRoadCoatUSK.Create;
          with quRoadCoats do
          begin
            FItems[quRoadCoats.RecNo-1].Id_RoadCoat := FieldByName('Id_RoadCoat').AsInteger;
            FItems[quRoadCoats.RecNo-1].Name := FieldByName('Name').AsString;
          end;{with}
          while not quRoadCoatUSKs.Eof do
          begin
            FItems[quRoadCoats.RecNo-1].Add(quRoadCoatUSKs.FieldByName('P').AsFloat,
                                            quRoadCoatUSKs.FieldByName('ValueMin').AsFloat,
                                            quRoadCoatUSKs.FieldByName('ValueMin').AsFloat);
            quRoadCoatUSKs.Next;
          end;{while}
          quRoadCoats.Next;
        end;{while}
        quRoadCoatUSKs.Close;
      finally
        quRoadCoatUSKs.Free;
      end;{try}
    finally
      dsRoadCoats.Free;
    end;{try}
    quRoadCoats.Close;
  finally
    quRoadCoats.Free;
  end;{try}
end;{RefreshData}
//TDBExcavatorCharacs - класс "Модели экскаваторов" -------------------------------------------
function TDBExcavatorCharacs.GetItem(Index: Integer): RDBExcavatorCharac;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TDBExcavatorCharacs.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TDBExcavatorCharacs.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBExcavatorCharacs.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
function TDBExcavatorCharacs.IndexOf(const AId_Excavator: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Excavator=AId_Excavator then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
function TDBExcavatorCharacs.FindBy(const AId_Engine: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Engine=AId_Engine then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
procedure TDBExcavatorCharacs.RefreshData;
begin
  Clear;
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT E.*,EE.Name as EngineName, EE.Nmax as EngineNmax '+
                'FROM Excavators E, ExcavatorEngines EE '+
                'WHERE EE.Id_Engine=E.Id_Engine ORDER BY E.SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    begin
      FItems[RecNo-1].Id_Excavator := FieldByName('Id_Excavator').AsInteger;
      FItems[RecNo-1].Name := FieldByName('Name').AsString;
      FItems[RecNo-1].BucketCapacity := FieldByName('BucketCapacity').AsFloat;
      FItems[RecNo-1].CycleTime := FieldByName('CycleTime').AsFloat;
      FItems[RecNo-1].ELength := FieldByName('ELength').AsFloat;
      FItems[RecNo-1].EWidth := FieldByName('EWidth').AsFloat;
      FItems[RecNo-1].EHeight := FieldByName('EHeight').AsFloat;
      FItems[RecNo-1].Id_Engine := FieldByName('Id_Engine').AsInteger;
      FItems[RecNo-1].EngineName := FieldByName('EngineName').AsString;
      FItems[RecNo-1].EngineNmax := FieldByName('EngineNmax').AsFloat;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{RefreshData}

//TDBAutoCharacs - класс "Модели автосамосвалов" ----------------------------------------------
function TDBAutoCharacs.GetItem(Index: Integer): RDBAutoCharac;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TDBAutoCharacs.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TDBAutoCharacs.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBAutoCharacs.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
function TDBAutoCharacs.IndexOf(const AId_Auto: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Auto=AId_Auto then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
function TDBAutoCharacs.FindBy(const AId_Engine: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Engine=AId_Engine then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
procedure TDBAutoCharacs.RefreshData;
begin
  Clear;
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT A.*,AE.Name as EngineName, AE.Nmax as EngineNmax '+
                'FROM Autos A, AutoEngines AE '+
                'WHERE AE.Id_Engine=A.Id_Engine ORDER BY A.SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    with FItems[RecNo-1] do
    begin
      Id_Auto := FieldByName('Id_Auto').AsInteger;
      Name := FieldByName('Name').AsString;
      BodySpace := FieldByName('BodySpace').AsFloat;
      Tonnage := FieldByName('Tonnage').AsFloat;
      P := FieldByName('P').AsFloat;
      F := FieldByName('F').AsFloat;
      Ro := FieldByName('Ro').AsFloat;
      TransmissionKind := TAutoTransmissionKind(FieldByName('TransmissionKind').AsInteger);
      TransmissionKPD := FieldByName('TransmissionKPD').AsFloat;
      t_r := FieldByName('t_r').AsFloat;
      Rmin := FieldByName('Rmin').AsFloat;
      TyresCount := FieldByName('TyresCount').AsInteger;

      ALength := FieldByName('ALength').AsFloat;
      AWidth := FieldByName('AWidth').AsFloat;
      AHeight := FieldByName('AHeight').AsFloat;
      Id_Engine := FieldByName('Id_Engine').AsInteger;
      EngineName := FieldByName('EngineName').AsString;
      EngineNmax := FieldByName('EngineNmax').AsFloat;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{RefreshData}

//TDBExcavator - класс "Экскаватор списочного парка" ------------------------------------------
function TDBExcavator.GetCharac: RDBExcavatorCharac;
var ACount: Integer;
begin
  ACount := Openpit.ExcavatorCharacs.Count;
  if InRange(FExcavatorInd,0,ACount-1)
  then Result := Openpit.ExcavatorCharacs[FExcavatorInd]
  else raise Exception.Create(Format(EInvalidIndex,[FExcavatorInd,ACount-1]));
end;{GetCharac}
procedure TDBExcavator.SetId_DeportExcavator(const Value: Integer);
begin
  if (FId_DeportExcavator<>Value)and(Value>0) then
  begin
    FId_DeportExcavator := Value;
  end;{if}
end;{SetId_DeportExcavator}
procedure TDBExcavator.SetId_Excavator(const Value: Integer);
begin
  if FId_Excavator<>Value then
  begin
    FExcavatorInd := Openpit.ExcavatorCharacs.IndexOf(Value);
    if FExcavatorInd>-1 then FId_Excavator := Value else FId_Excavator := 0;
    if FId_Excavator>0
    then FName := Format('%s(%d)',[Openpit.ExcavatorCharacs[FExcavatorInd].Name,FParkNo]);
  end;{if}
end;{SetId_Excavator}
procedure TDBExcavator.SetParkNo(const Value: Integer);
begin
  if (FParkNo<>Value)and(Value>0) then
  begin
    FParkNo := Value;
    if FId_Excavator>0
    then FName := Format('%s(%d)',[Openpit.ExcavatorCharacs[FExcavatorInd].Name,FParkNo]);
  end;{if}
end;{SetParkNo}
procedure TDBExcavator.SetEYear(const Value: Integer);
begin
  if (FEYear<>Value)and(Value>0) then
  begin
    FEYear := Value;
  end;{if}
end;{SetEYear}
procedure TDBExcavator.SetWorkState(const Value: Boolean);
begin
  if FWorkState<>Value then
  begin
    FWorkState := Value;
  end;{if}
end;{SetWorkState}
procedure TDBExcavator.SetCost(const Value: Single);
begin
  if (FCost<>Value)and(Value>0.0) then
  begin
    FCost := Value;
  end;{if}
end;{SetCost}
procedure TDBExcavator.SetFactCycleTime(const Value: Single);
begin
  if (FFactCycleTime<>Value)and(Value>0.0) then
  begin
    FFactCycleTime := Value;
  end;{if}
end;{SetFactCycleTime}
procedure TDBExcavator.SetAddCostMaterials(const Value: Single);
begin
  if (FAddCostMaterials<>Value)and(Value>=0.0) then
  begin
    FAddCostMaterials := Value;
  end;{if}
end;{SetAddCostMaterials}
procedure TDBExcavator.SetAddCostUnAccounted(const Value: Single);
begin
  if (FAddCostUnAccounted<>Value)and(Value>=0.0) then
  begin
    FAddCostUnAccounted := Value;
  end;{if}
end;{SetAddCostUnAccounted}
procedure TDBExcavator.SetEngineKIM(const Value: Single);
begin
  if (FEngineKIM<>Value)and InRange(Value,0.2,1.0) then //0.25-0.35
  begin
    FEngineKIM := Value;
  end;{if}
end;{SetEngineKIM}
procedure TDBExcavator.SetEngineKPD(const Value: Single);
begin
  if (FEngineKPD<>Value)and InRange(Value,0.9,1.0) then //0.936-0.948
  begin
    FEngineKPD := Value;
  end;{if}
end;{SetEngineKPD}
procedure TDBExcavator.SetSENAmortizationRate(const Value: Single);
begin
  if (FSENAmortizationRate<>Value)and InRange(Value,0.1,1.0) then
  begin
    FSENAmortizationRate := Value;
  end;{if}
end;{SetSENAmortizationRate}
constructor TDBExcavator.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_DeportExcavator := 0;
  FId_Excavator := 0;
  FExcavatorInd := -1;
  FParkNo := 0;
  FEYear := 0;
  FWorkState := true;
  FCost := 0.0;
  FFactCycleTime := 0.0;
  FAddCostMaterials := 0.0;
  FAddCostUnAccounted := 0.0;
  FEngineKIM := 1.0;
  FEngineKPD := 0.0;
  FSENAmortizationRate := 0.0;
end;{Create}
//TDBExcavators - класс "Экскаваторы списочного парка" ----------------------------------------
function TDBExcavators.GetItem(Index: Integer): TDBExcavator;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TDBExcavators.Create(AOpenpit: TDBOpenpit);
begin
  FItems := nil;
  FCount := 0;
  inherited;
end;{Create}
destructor TDBExcavators.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBExcavators.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FItems := nil;
  FCount := 0;
end;{Clear}
function TDBExcavators.IndexOf(const AId_DeportExcavator: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_DeportExcavator=AId_DeportExcavator then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
function TDBExcavators.IndexOf(const ATotalName: String): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].TotalName=ATotalName then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
procedure TDBExcavators.RefreshData;
begin
  Clear;
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitDeportExcavators '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' '+
                'ORDER BY SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    begin
      FItems[RecNo-1] := TDBExcavator.Create(Openpit);
      FItems[RecNo-1].Id_DeportExcavator := FieldByName('Id_DeportExcavator').AsInteger;
      FItems[RecNo-1].Id_Excavator := FieldByName('Id_Excavator').AsInteger;
      FItems[RecNo-1].ParkNo := FieldByName('ParkNo').AsInteger;
      FItems[RecNo-1].EYear := FieldByName('EYear').AsInteger;
      FItems[RecNo-1].WorkState := FieldByName('WorkState').AsBoolean;
      FItems[RecNo-1].Cost := FieldByName('Cost').AsFloat;
      FItems[RecNo-1].FactCycleTime := FieldByName('FactCycleTime').AsFloat;
      FItems[RecNo-1].AddCostMaterials := FieldByName('AddCostMaterials').AsFloat;
      FItems[RecNo-1].AddCostUnAccounted := FieldByName('AddCostUnAccounted').AsFloat;
      FItems[RecNo-1].EngineKIM := FieldByName('EngineKIM').AsFloat;
      FItems[RecNo-1].EngineKPD := FieldByName('EngineKPD').AsFloat;
      FItems[RecNo-1].SENAmortizationRate := FieldByName('SENAmortizationRate').AsFloat;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{RefreshData}

//TDBAuto - класс "Автосамосвал списочного парка" ---------------------------------------------
function TDBAuto.GetCharac: RDBAutoCharac;
begin
  if InRange(FAutoInd,0,Openpit.AutoCharacs.Count-1)
  then Result := Openpit.AutoCharacs[FAutoInd]
  else raise Exception.Create(Format(EInvalidIndex,[FAutoInd,Openpit.AutoCharacs.Count-1]));
end;{GetCharac}
function TDBAuto.GetCourse: TDBCourse;
begin
  if InRange(FCourseInd,0,Openpit.Courses.Count-1)
  then Result := Openpit.Courses[FCourseInd]
  else raise Exception.Create(Format(EInvalidIndex,[FCourseInd,Openpit.Courses.Count-1]));
end;{GetCourse}
function TDBAuto.GetShiftPunkt: TDBShiftPunkt;
var ACount: Integer;
begin
  ACount := Openpit.ShiftPunkts.Count;
  if InRange(FShiftPunktInd,0,ACount-1)
  then Result := Openpit.ShiftPunkts[FShiftPunktInd]
  else raise Exception.Create(Format(EInvalidIndex,[FShiftPunktInd,ACount-1]));
end;{GetShiftPunkt}
procedure TDBAuto.SetId_DeportAuto(const Value: Integer);
begin
  if (FId_DeportAuto<>Value)and(Value>0) then
  begin
    FId_DeportAuto := Value;
  end;{if}
end;{SetId_DeportAuto}
procedure TDBAuto.SetId_Auto(const Value: Integer);
begin
  if FId_Auto<>Value then
  begin
    FAutoInd := Openpit.AutoCharacs.IndexOf(Value);
    if FAutoInd>-1 then FId_Auto := Value else FId_Auto := 0;
  end;{if}
end;{SetId_Auto}
procedure TDBAuto.SetParkNo(const Value: Integer);
begin
  if (FParkNo<>Value)and(Value>0) then
  begin
    FParkNo := Value;
  end;{if}
end;{SetParkNo}
procedure TDBAuto.SetAYear(const Value: Integer);
begin
  if (FAYear<>Value)and(Value>0) then
  begin
    FAYear := Value;
  end;{if}
end;{SetAYear}
procedure TDBAuto.SetWorkState(const Value: Boolean);
begin
  if FWorkState<>Value then
  begin
    FWorkState := Value;
  end;{if}
end;{SetWorkState}
procedure TDBAuto.SetFactTonnage(const Value: Single);
begin
  if (FFactTonnage<>Value)and(Value>0.0) then
  begin
    FFactTonnage := Value;
  end;{if}
end;{SetFactTonnage}
procedure TDBAuto.SetCost(const Value: Single);
begin
  if (FCost<>Value)and(Value>0.0) then
  begin
    FCost := Value;
  end;{if}
end;{SetCost}
procedure TDBAuto.SetAmortizationRate(const Value: Single);
begin
  if (FAmortizationRate<>Value)and InRange(Value,0.1,1.0) then
  begin
    FAmortizationRate := Value;
  end;{if}
end;{SetAmortizationRate}
procedure TDBAuto.SetTransmissionKPD(const Value: Single);
begin
  if (FTransmissionKPD<>Value)and InRange(Value,0.1,1.0) then
  begin
    FTransmissionKPD := Value;
  end;{if}
end;{SetTransmissionKPD}
procedure TDBAuto.SetEngineKPD(const Value: Single);
begin
  if (FEngineKPD<>Value)and InRange(Value,0.1,1.0) then
  begin
    FEngineKPD := Value;
  end;{if}
end;{SetEngineKPD}
procedure TDBAuto.SetTyreCost(const Value: Single);
begin
  if (FTyreCost<>Value)and(Value>0.0) then
  begin
    FTyreCost := Value;
  end;{if}
end;{SetTyreCost}
procedure TDBAuto.SetTyresRaceRate(const Value: Single);
begin
  if (FTyresRaceRate<>Value)and(Value>0.0) then
  begin
    FTyresRaceRate := Value;
  end;{if}
end;{SetTyresRaceRate}
procedure TDBAuto.SetId_Course(const Value: Integer);
begin
  if FId_Course<>Value then
  begin
    FCourseInd := Openpit.Courses.IndexOf(Value) ;
    if FCourseInd>-1 then FId_Course := Value else FId_Course := 0;
  end;{if}
end;{SetId_Course}
procedure TDBAuto.SetId_ShiftPunkt(const Value: Integer);
begin
  if FId_ShiftPunkt<>Value then
  begin
    FShiftPunktInd := Openpit.ShiftPunkts.IndexOf(Value);
    if FShiftPunktInd>-1 then FId_ShiftPunkt := Value else FId_ShiftPunkt := 0;
  end;{if}
end;{SetId_ShiftPunkt}
constructor TDBAuto.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_DeportAuto   := 0;
  FId_Auto         := 0;
  FAutoInd         := -1;
  FParkNo          := 0;
  FAYear           := 0;
  FWorkState       := true;
  FFactTonnage     := 0.0;
  FCost            := 0.0;
  FAmortizationRate:= 0.0;
  FTransmissionKPD := 0.0;
  FEngineKPD       := 0.0;
  FTyreCost        := 0.0;
  FTyresRaceRate   := 0.0;
  FId_ShiftPunkt   := 0;
  FShiftPunktInd   := -1;
  FId_Course       := 0;
  FCourseInd       := -1;
end;{Create}
//TDBAutos - класс "Автосамосвалы списочного парка" -------------------------------------------
function TDBAutos.GetItem(Index: Integer): TDBAuto;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TDBAutos.Create(AOpenpit: TDBOpenpit);
begin
  FItems := nil;
  FCount := 0;
  inherited;
end;{Create}
destructor TDBAutos.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBAutos.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FItems := nil;
  FCount := 0;
end;{Clear}
function TDBAutos.IndexOf(const AId_DeportAuto: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_DeportAuto=AId_DeportAuto then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
procedure TDBAutos.RefreshData;
begin
  Clear;
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitDeportAutos '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' '+
                'ORDER BY SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    begin
      FItems[RecNo-1] := TDBAuto.Create(Openpit);
      FItems[RecNo-1].Id_DeportAuto := FieldByName('Id_DeportAuto').AsInteger;
      FItems[RecNo-1].Id_Auto := FieldByName('Id_Auto').AsInteger;
      FItems[RecNo-1].ParkNo := FieldByName('ParkNo').AsInteger;
      FItems[RecNo-1].AYear := FieldByName('AYear').AsInteger;
      FItems[RecNo-1].WorkState := FieldByName('WorkState').AsBoolean;
      FItems[RecNo-1].FactTonnage := FieldByName('FactTonnage').AsFloat;
      FItems[RecNo-1].Cost := FieldByName('Cost').AsFloat;
      FItems[RecNo-1].AmortizationRate := FieldByName('AmortizationRate').AsFloat;
      FItems[RecNo-1].TransmissionKPD := FieldByName('TransmissionKPD').AsFloat;
      FItems[RecNo-1].EngineKPD := FieldByName('EngineKPD').AsFloat;
      FItems[RecNo-1].TyreCost := FieldByName('TyreCost').AsFloat;
      FItems[RecNo-1].TyresRaceRate := FieldByName('TyresRaceRate').AsFloat;
      FItems[RecNo-1].Id_ShiftPunkt := FieldByName('Id_ShiftPunkt').AsInteger;
      FItems[RecNo-1].Id_Course := FieldByName('Id_Course').AsInteger;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{RefreshData}

//TDBRocks - класс "Добываемые горные породы на карьере" --------------------------------------
function TDBRocks.GetItem(Index: Integer): RDBRock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TDBRocks.Create(AOpenpit: TDBOpenpit);
begin
  FItems := nil;
  FCount := 0;
  inherited;
end;{Create}
destructor TDBRocks.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBRocks.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
function TDBRocks.IndexOf(const AId_Rock: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Rock=AId_Rock then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
procedure TDBRocks.RefreshData;
begin
  Clear;
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitRocks WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+
    ' ORDER BY SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    begin
      FItems[RecNo-1].Id_Rock := FieldByName('Id_Rock').AsInteger;
      FItems[RecNo-1].Name := FieldByName('Name').AsString;
      FItems[RecNo-1].IsMineralWealth := FieldByName('IsMineralWealth').AsBoolean;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{RefreshData}

//TDBPoints - класс "Характерные точки" -------------------------------------------------------
procedure TDBPoints.SetItem(Index: Integer; Value: RDBPoint);
var Result,iX,iY,iZ: Integer;
begin
  if InRange(Index,0,FCount-1)then
  begin
    Result := IndexOf(Value.Coords.X,Value.Coords.Y);
    if Result=-1 then
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'SELECT * FROM OpenpitPoints WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
      Open;
      if Locate('Id_Point',FItems[Index].Id_Point,[])then
      begin
        iX := Round(1000*Value.Coords.X);
        iY := Round(1000*Value.Coords.Y);
        iZ := Round(1000*Value.Coords.Z);
        Edit;
        FieldByName('X').AsFloat := iX*0.001;
        FieldByName('Y').AsFloat := iY*0.001;
        FieldByName('Z').AsFloat := iZ*0.001;
        Post;
        FItems[Index].Coords.X := iX*0.001;
        FItems[Index].Coords.Y := iY*0.001;
        FItems[Index].Coords.Z := iZ*0.001;
      end;{if}
      Close;
    finally
      Free;
      Openpit.Blocks.UpdateLength;
      Openpit.Courses.UpdateLength;
      UpdateBound;
      Invalidate;
    end{try}
    else esaMsgError(Format(EDuplicatePoint,[Value.Coords.X,Value.Coords.Y]));
  end{if}
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{SetItem}
function TDBPoints.GetItem(Index: Integer): RDBPoint;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TDBPoints.GetAssignedObjects(var sId_Points: String;
                                      const APointIndexes: TIntegerDynArray): String;
var
  I,ACount: Integer;
  S,sBlockPointsNo,sBlocksNo,
  sLoadingPunktPointsNo,sLoadingPunktsNo,
  sUnLoadingPunktPointsNo,sUnLoadingPunktsNo,
  sCoursePointsNo,sCoursesNo,
  sShiftPunktPointsNo,sShiftPunktsNo: String;
begin
  Result := '';
  ACount := Length(APointIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  //-------------------------------------------------------------------------------------------
  //Составляю:
  //  список кодов харак.точек sId_Points
  //  список индексов точек и элементов карьера, в состав к-х входят данные точки 
  sId_Points := '';
  sBlocksNo := '';
  sBlockPointsNo := '';
  sLoadingPunktsNo := '';
  sLoadingPunktPointsNo := '';
  sUnLoadingPunktsNo := '';
  sUnLoadingPunktPointsNo := '';
  sShiftPunktsNo := '';
  sShiftPunktPointsNo := '';
  sCoursesNo := '';
  sCoursePointsNo := '';
  for I := 0 to ACount-1 do
  begin
    sId_Points := sId_Points+IntToStr(Openpit.Points[APointIndexes[I]].Id_Point)+',';
    S := Openpit.Blocks.FindBy(Openpit.Points[APointIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sBlockPointsNo := sBlockPointsNo+IntToStr(APointIndexes[I]+1)+',';
      sBlocksNo := sBlocksNo+S+',';
    end;{if}
    S := Openpit.LoadingPunkts.FindBy(Openpit.Points[APointIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sLoadingPunktPointsNo := sLoadingPunktPointsNo+IntToStr(APointIndexes[I]+1)+',';
      sLoadingPunktsNo := sLoadingPunktsNo+S+',';
    end;{if}
    S := Openpit.UnLoadingPunkts.FindBy(Openpit.Points[APointIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sUnLoadingPunktPointsNo := sUnLoadingPunktPointsNo+IntToStr(APointIndexes[I]+1)+',';
      sUnLoadingPunktsNo := sUnLoadingPunktsNo+S+',';
    end;{if}
    S := Openpit.ShiftPunkts.FindBy(Openpit.Points[APointIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sShiftPunktPointsNo := sShiftPunktPointsNo+IntToStr(APointIndexes[I]+1)+',';
      sShiftPunktsNo := sShiftPunktsNo+S+',';
    end;{if}
    S := Openpit.Courses.FindPoints(Openpit.Points[APointIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sCoursePointsNo := sCoursePointsNo+IntToStr(APointIndexes[I]+1)+',';
      sCoursesNo := sCoursesNo+S+',';
    end;{if}
  end;{for}
  //Убираю конечную запятую -------------------------------------------------------------------
  if sId_Points<>'' then System.Delete(sId_Points,Length(sId_Points),1);
  if sBlockPointsNo<>'' then System.Delete(sBlockPointsNo,Length(sBlockPointsNo),1); 
  if sBlocksNo<>'' then System.Delete(sBlocksNo,Length(sBlocksNo),1);
  if sLoadingPunktPointsNo<>''
  then System.Delete(sLoadingPunktPointsNo,Length(sLoadingPunktPointsNo),1);
  if sLoadingPunktsNo<>'' then System.Delete(sLoadingPunktsNo,Length(sLoadingPunktsNo),1);
  if sUnLoadingPunktPointsNo<>''
  then System.Delete(sUnLoadingPunktPointsNo,Length(sUnLoadingPunktPointsNo),1);
  if sUnLoadingPunktsNo<>''
  then System.Delete(sUnLoadingPunktsNo,Length(sUnLoadingPunktsNo),1);
  if sShiftPunktPointsNo<>''
  then System.Delete(sShiftPunktPointsNo,Length(sShiftPunktPointsNo),1);
  if sShiftPunktsNo<>'' then System.Delete(sShiftPunktsNo,Length(sShiftPunktsNo),1);
  if sCoursePointsNo<>''
  then System.Delete(sCoursePointsNo,Length(sCoursePointsNo),1);
  if sCoursesNo<>'' then System.Delete(sCoursesNo,Length(sCoursesNo),1);
  DeleteDuplicateValues(sId_Points);
  DeleteDuplicateValues(sBlockPointsNo);
  DeleteDuplicateValues(sBlocksNo);
  DeleteDuplicateValues(sLoadingPunktPointsNo);
  DeleteDuplicateValues(sLoadingPunktsNo);
  DeleteDuplicateValues(sUnLoadingPunktPointsNo);
  DeleteDuplicateValues(sUnLoadingPunktsNo);
  DeleteDuplicateValues(sShiftPunktPointsNo);
  DeleteDuplicateValues(sShiftPunktsNo);
  DeleteDuplicateValues(sCoursePointsNo);
  DeleteDuplicateValues(sCoursesNo);
  //Result
  if (sId_Points<>'')AND((sBlocksNo<>'')or(sLoadingPunktsNo<>'')or
                         (sUnLoadingPunktsNo<>'')or(sShiftPunktsNo<>''))
  then Result := 'Характерные точки №№ '+sBlockPointsNo+' входят в состав:'+CR;
  if sBlocksNo<>''
  then Result := Result+'- блок-участков №№ '+sBlocksNo+CR;
  if sLoadingPunktPointsNo<>''
  then Result := Result+'- пунктов погрузки №№ '+sLoadingPunktsNo+CR;
  if sUnLoadingPunktPointsNo<>''
  then Result := Result+'- пунктов рагрузки №№ '+sUnLoadingPunktsNo+CR;
  if sShiftPunktPointsNo<>''
  then Result := Result+'- пунктов пересменки №№ '+sShiftPunktsNo+CR;
  if sCoursePointsNo<>''
  then Result := Result+'- маршрутов движения №№ '+sCoursesNo+CR;
end;{GetAssignedObjects}
constructor TDBPoints.Create(AOpenpit: TDBOpenpit);
begin
  FBound := Bound3D(0.0,0.0,0.0,0.0,0.0,0.0);
  inherited;
  Clear;
end;{Create}
destructor TDBPoints.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBPoints.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
procedure TDBPoints.RefreshData;
begin
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitPoints WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    First;
    while not Eof do
    begin
      FItems[RecNo-1].Id_Point := FieldByName('Id_Point').AsInteger;
      FItems[RecNo-1].Coords.X := RoundTo(FieldByName('X').AsFloat,-3);
      FItems[RecNo-1].Coords.Y := RoundTo(FieldByName('Y').AsFloat,-3);
      FItems[RecNo-1].Coords.Z := RoundTo(FieldByName('Z').AsFloat,-3);
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  UpdateBound;
end;{RefreshData}
procedure TDBPoints.UpdateBound;
var I: Integer;
begin
  FBound.MinX := High(Integer);  FBound.MaxX := -High(Integer);
  FBound.MinY := High(Integer);  FBound.MaxY := -High(Integer);
  FBound.MinZ := High(Integer);  FBound.MaxZ := -High(Integer);
  for I := 0 to FCount-1 do
  begin
    if FBound.MinX>FItems[I].Coords.X then FBound.MinX := FItems[I].Coords.X;
    if FBound.MaxX<FItems[I].Coords.X then FBound.MaxX := FItems[I].Coords.X;
    if FBound.MinY>FItems[I].Coords.Y then FBound.MinY := FItems[I].Coords.Y;
    if FBound.MaxY<FItems[I].Coords.Y then FBound.MaxY := FItems[I].Coords.Y;
    if FBound.MinZ>FItems[I].Coords.Z then FBound.MinZ := FItems[I].Coords.Z;
    if FBound.MaxZ<FItems[I].Coords.Z then FBound.MaxZ := FItems[I].Coords.Z;
  end;{for}
  if FCount=0 then FBound := Bound3D(0.0,0.0,0.0,0.0,0.0,0.0);
end;{UpdateBound}
procedure TDBPoints.Draw;
var
  I: Integer;
  S: String;
  dX: Single;
begin
  if (FCount=0)or(not Visible) then Exit;
  glPushMatrix;
    //Рисую точки
    glEnable(GL_POINT_SMOOTH);
    glPointSize(2*DefaultParams.PointRadius);
    glSetColor(DefaultParams.PointColor);
    glBegin(GL_POINTS);
      for I := 0 to FCount-1 do
        glVertex2f(FItems[I].Coords.X,FItems[I].Coords.Y);
    glEnd;
    //Рисую текстовые отметки
    if DefaultParams.PointMarkStyle<>pmsNone then
    begin
      dX := DefaultParams.PointRadius*GraphKernel.MtrPerPxl;
      for I := 0 to FCount-1 do
      begin
        with FItems[I].Coords do
        case DefaultParams.PointMarkStyle of
          pmsNumber: S := Format('%d.',[I+1]);
          pmsCoord : S := Format('(%.3f; %.3f; %.3f)',[X,Y,Z]);
          else       S := Format('%d. (%.3f; %.3f; %.3f)',[I+1,X,Y,Z]);
        end;{case}
        glOutTextXY(FItems[I].Coords.X+dX,FItems[I].Coords.Y+dX,S);
      end;{for}
    end;{if}
  glPopMatrix;
end;{Draw}
function TDBPoints.IndexOf(const AX,AY: Single): Integer;
var I,R2: Integer;
begin
  Result := -1;
  //если новая точка находится ближе R м
  R2 := sqr(DefaultParams.PointMinDistance);
  for I := 0 to FCount-1 do
  if sqr(FItems[I].Coords.X-AX)+sqr(FItems[I].Coords.Y-AY)<=R2 then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
function TDBPoints.IndexOf(const AId_Point: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Point=AId_Point then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TDBPoints.Add(const AX,AY,AZ: Single);
var iX,iY,iZ: Integer;
begin
  if IndexOf(AX,AY)=-1 then
  begin
    iX := Round(AX*1000); iY := Round(AY*1000); iZ := Round(AZ*1000);
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'SELECT * FROM OpenpitPoints WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
      Open;
      Append;
      FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
      FieldByName('X').AsFloat := iX*0.001;
      FieldByName('Y').AsFloat := iY*0.001;
      FieldByName('Z').AsFloat := iZ*0.001;
      Post;
      Inc(FCount);
      SetLength(FItems,FCount);
      FItems[FCount-1].Id_Point := FieldByName('Id_Point').AsInteger;
      FItems[FCount-1].Coords.X := iX*0.001;
      FItems[FCount-1].Coords.Y := iY*0.001;
      FItems[FCount-1].Coords.Z := iZ*0.001;
      Close;
    finally
      Free;
    end;{try}
    UpdateBound;
    Invalidate;
  end;{if}
end;{Add}
function TDBPoints.Delete(const APointIndexes: TIntegerDynArray): Boolean;
var
  ACount: Integer;
  Msg,sId_Points: String;
begin
  Result := false;
  ACount := Length(APointIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  Msg := GetAssignedObjects(sId_Points,APointIndexes);
  //Проверки ----------------------------------------------------------------------------------
  if sId_Points<>'' then //выбраны коды удаляемых точек
  if Msg<>''
  then esaMsgError(Msg+CR+'Удаление невозможно без их предварительного расформирования.')
  else
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'DELETE FROM OpenpitPoints WHERE Id_Point in('+sId_Points+')';
      ExecSQL;
      Result := true;
    finally
      Free;
      Openpit.RefreshData;
    end;{try}
end;{Delete}
procedure TDBPoints.DeleteAll;
var
  Msg,sId_Points: String;
  APointIndexes: TIntegerDynArray;
  I: Integer;
begin
  if FCount=0 then Exit;
  SetLength(APointIndexes,FCount);
  for I := 0 to FCount-1 do
    APointIndexes[I] := I;
  Msg := GetAssignedObjects(sId_Points,APointIndexes);
  //Проверки ----------------------------------------------------------------------------------
  if sId_Points<>'' then //выбраны коды удаляемых точек
  if Msg<>''
  then esaMsgError(Msg+CR+'Удаление невозможно без их предварительного расформирования.')
  else
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'DELETE FROM OpenpitPoints WHERE Id_Point in('+sId_Points+')';
      ExecSQL;
    finally
      Free;
      Openpit.RefreshData;
    end;{try}
end;{DeleteAll}
procedure TDBPoints.SetTotalZ(AZ: Single; const APointIndexes: TIntegerDynArray);
var
  I,ACount: Integer;
  S: String; 
begin
  ACount := Length(APointIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  AZ := RoundTo(AZ,-3);
  S := '';
  for I := 0 to ACount-1 do
  begin
    FItems[APointIndexes[I]].Coords.Z := AZ;
    S := S+IntToStr(FItems[APointIndexes[I]].Id_Point)+',';
  end;{for}
  if S<>'' then
  begin
    S := Copy(S,1,Length(S)-1);
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'UPDATE OpenpitPoints SET Z='+IntToStr(Round(1000*AZ))+'/1000 '+
                  'WHERE Id_Point in('+S+')';
      ExecSQL;
    finally
      Free;
      Invalidate;
    end;{try}
  end;{if}
end;{SetTotalZ}
procedure TDBPoints.Interpolation(const APointIndexes: TIntegerDynArray; const AZ0,AZ1: Single);
var
  I,ACount: Integer;
  ATotalLength,Z: Single;
  Arr: array of Single;
begin
  ACount := Length(APointIndexes);
  if ACount<2 then Exit;
  SetLength(Arr,ACount);
  Arr[0] := 0;
  ATotalLength := 0.0;
  for I := 1 to ACount-1 do
  begin
    ATotalLength := ATotalLength+
              sqrt(sqr(FItems[APointIndexes[I]].Coords.X-FItems[APointIndexes[I-1]].Coords.X)+
              sqr(FItems[APointIndexes[I]].Coords.Y-FItems[APointIndexes[I-1]].Coords.Y));
    Arr[I] := ATotalLength;
  end;{for}
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    for I := 0 to ACount-1 do
    begin
      Z := AZ0+(AZ1-AZ0)*Arr[I]/ATotalLength;
      FItems[APointIndexes[I]].Coords.Z := RoundTo(Z,-3);
      SQL.Text := 'UPDATE OpenpitPoints SET Z='+IntToStr(Round(1000*Z))+'/1000 '+
                  'WHERE Id_Point='+IntToStr(FItems[APointIndexes[I]].Id_Point);
      ExecSQL;
    end;{for}
  finally
    Free;
    Arr := nil;
    Invalidate;
  end;{try}
end;{Interpolation}

//TDBBlock - класс "Блок-участок" -------------------------------------------------------------
procedure TDBBlock.SetId_Block(const Value: Integer);
begin
  if (FId_Block<>Value)and(Value>0)then
  begin
    FId_Block := Value;
  end;{if}
end;{SetId_Block}
procedure TDBBlock.SetStripCount(const Value: Byte);
begin
  if (FStripCount<>Value)and(Value in [1,2]) then
  begin
    FStripCount := Value;
    UpdateLength;
    Invalidate;
  end;{if}
end;{SetStripCount}
procedure TDBBlock.SetStripWidth(const Value: Single);
begin
  if (FStripWidth<>Value)and InRange(Value,1.0,100.0) then
  begin
    FStripWidth := Value;
    UpdateLength;
    Invalidate;
  end;{if}
end;{SetStripWidth}
procedure TDBBlock.SetId_RoadCoat(const Value: Integer);
begin
  if FId_RoadCoat<>Value then
  begin
    FRoadCoatInd := Openpit.RoadCoats.IndexOf(Value);
    if FRoadCoatInd>-1 then FId_RoadCoat := Value else FId_RoadCoat := 0;
  end;{if}
end;{SetId_RoadCoat}
procedure TDBBlock.SetLoadingVmax(const Value: Single);
begin
  if (FLoadingVmax<>Value)and(Value>=5.0) then
  begin
    FLoadingVmax := Value;
  end;{if}
end;{SetLoadingVmax}
procedure TDBBlock.SetUnLoadingVmax(const Value: Single);
begin
  if (FUnLoadingVmax<>Value)and(Value>=5.0) then
  begin
    FUnLoadingVmax := Value;
  end;{if}
end;{SetUnLoadingVmax}
procedure TDBBlock.SetKind(const Value: TBlockKind);
begin
  if FKind<>Value then
  begin
    FKind := Value;
    Invalidate;
  end;{if}
end;{SetKind}
function TDBBlock.GetPointIndex(Index: Integer): Integer;
begin
  if InRange(Index,0,FCount-1)
  then Result := FPointIndexes[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TDBBlock.GetPoint(Index: Integer): RDBPoint;
begin
  if InRange(Index,0,FCount-1)
  then Result := Openpit.Points[FPointIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetPoint}
function TDBBlock.GetLeftCoord(Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FCount-1)
  then Result := FLeftCoords[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetLeftCoord}
function TDBBlock.GetRightCoord(Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FCount-1)
  then Result := FRightCoords[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetRightCoord}
function TDBBlock.GetCenterCoord(Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FCount-1)
  then Result := Openpit.Points[FPointIndexes[Index]].Coords
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{CenterCoord}
procedure TDBBlock.UpdateLength;
type
  RSide=record
    LeftTop,RightTop,RightBottom,LeftBottom: RPoint3D;
  end;
var
  I: Integer;
  ASides: array of RSide;
  AStripWidth: Single;
begin
  SetLength(FLeftCoords,FCount);
  SetLength(FRightCoords,FCount);
  FLength := 0.0;
  if FCount=0 then Exit;
  if FStripCount=1
  then AStripWidth := 0.5*FStripWidth
  else AStripWidth := FStripWidth;
  SetLength(ASides,FCount);
  FLeftCoords[0] := CenterCoords[0];
  FLeftCoords[0].Y := FLeftCoords[0].Y+AStripWidth;
  FRightCoords[0] := CenterCoords[0];
  FRightCoords[0].Y := FRightCoords[0].Y-AStripWidth;
  for I := 1 to FCount-1 do
  begin
    FLength  := FLength+sqrt(sqr(Points[I].Coords.X-Points[I-1].Coords.X)+
                             sqr(Points[I].Coords.Y-Points[I-1].Coords.Y)+
                             sqr(Points[I].Coords.Z-Points[I-1].Coords.Z));
    with ASides[I] do
      GetBound3DAroundPiece(CenterCoords[I-1],CenterCoords[I],AStripWidth,
                            LeftTop,RightTop,RightBottom,LeftBottom);
    FLeftCoords[I] := ASides[I].RightTop;
    FRightCoords[I] := ASides[I].RightBottom;
    if I=1 then
    begin
      FLeftCoords[0] := ASides[I].LeftTop;
      FRightCoords[0] := ASides[I].LeftBottom;
    end;{if}
    if I>1 then
    begin
      FLeftCoords[I-1] := CrossingPoint(ASides[I-1].LeftTop,ASides[I-1].RightTop,
                                        ASides[I].LeftTop,  ASides[I].RightTop);
      FRightCoords[I-1] := CrossingPoint(ASides[I-1].LeftBottom,ASides[I-1].RightBottom,
                                         ASides[I].LeftBottom,  ASides[I].RightBottom);
    end;{if}
  end;{for}
  ASides := nil;
end;{UpdateLength}
constructor TDBBlock.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_Block := 0;
  FStripCount := DefaultParams.BlockStripCount;
  FStripWidth := DefaultParams.BlockStripWidth;
  FRoadCoatInd := Openpit.RoadCoats.IndexOf(DefaultParams.BlockId_RoadCoat);
  if FRoadCoatInd=-1 then DefaultParams.BlockId_RoadCoat := 0;
  FId_RoadCoat := DefaultParams.BlockId_RoadCoat;
  FLoadingVmax := DefaultParams.BlockLoadingVmax;
  FUnLoadingVmax := DefaultParams.BlockUnLoadingVmax;
  FKind := DefaultParams.BlockKind;
  FLength := 0.0;
  FCount := 0;
  FPointIndexes := nil;
  FLeftCoords := nil;
  FRightCoords := nil;
end;{Create}
destructor TDBBlock.Destroy; 
begin
  FCount := 0;
  FPointIndexes := nil;
  FLeftCoords := nil;
  FRightCoords := nil;
  inherited;
end;{Destroy}
//TDBBlocks - класс "Блок-участки" ------------------------------------------------------------
function TDBBlocks.GetItem(Index: Integer): TDBBlock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
procedure TDBBlocks.SetTotalValues(const sStripCount,sStripWidth,sId_RoadCoat,sKind,sLoadingVmax,sUnLoadingVmax: String;
                                   const ABlockIndexes: TIntegerDynArray);
var
  I,ACount: Integer;
  S,Values: String;
begin
  ACount := Length(ABlockIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  for I := 0 to ACount-1 do
  begin
    if sStripCount <>'' then FItems[ABlockIndexes[I]].StripCount  := StrToInt(sStripCount);
    if sStripWidth <>'' then FItems[ABlockIndexes[I]].StripWidth  := StrToFloat(sStripWidth);
    if sId_RoadCoat<>'' then FItems[ABlockIndexes[I]].Id_RoadCoat := StrToInt(sId_RoadCoat);
    if sKind       <>'' then FItems[ABlockIndexes[I]].Kind        := TBlockKind(StrToInt(sKind));
    if sLoadingVmax<>'' then FItems[ABlockIndexes[I]].LoadingVmax := StrToFloat(sLoadingVmax);
    if sUnLoadingVmax<>'' then FItems[ABlockIndexes[I]].UnLoadingVmax := StrToFloat(sUnLoadingVmax);
    S := S+IntToStr(FItems[ABlockIndexes[I]].Id_Block)+',';
  end;{for}
  if S<>'' then
  try
    S := Copy(S,1,Length(S)-1);
    Values := '';
    if sStripCount<>''
    then Values := Format('%s StripCount=%s,',[Values,sStripCount]);
    if sStripWidth<>''
    then Values := Format('%s StripWidth=%d/10,',[Values,Round(StrToFloat(sStripWidth)*10)]);
    if sId_RoadCoat<>''
    then Values := Format('%s Id_RoadCoat=%s,',[Values,sId_RoadCoat]);
    if sKind<>''
    then Values := Format('%s Kind=%s,',[Values,sKind]);
    if sLoadingVmax<>''
    then Values := Format('%s LoadingVmax=%d/10,',[Values,Round(StrToFloat(sLoadingVmax)*10)]);
    if sUnLoadingVmax<>''
    then Values := Format('%s UnLoadingVmax=%d/10,',[Values,Round(StrToFloat(sUnLoadingVmax)*10)]);
    if Values<>'' then
    with TADOQuery.Create(nil) do
    try
      System.Delete(Values,Length(Values),1);
      Connection := DBConnection;
      SQL.Text := 'UPDATE OpenpitBlocks SET '+Values+' WHERE Id_Block in('+S+')';
      ExecSQL;
    finally
      Free;
    end;{try}
  finally
    Invalidate;
  end;{try}
end;{SetTotalValues}
constructor TDBBlocks.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TDBBlocks.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TDBBlocks.FindBy(const AId_Point: Integer): String;
var I,J: Integer;
begin
  Result := '';
  for I := 0 to FCount-1 do
    for J := 0 to FItems[I].Count-1 do
    if FItems[I].Points[J].Id_Point=AId_Point then
    begin
      Result := Result+IntToStr(I+1)+','; Break;
    end;{for}
  if Length(Result)>1 then Result := Copy(Result,1,Length(Result)-1);
end;{FindBy}
//Возвращает индекс блок-участка, состоящего из данного набора точек
function TDBBlocks.IndexOf(const APointIndexes: TIntegerDynArray): Integer;
var
  I,J,ACount: Integer;
  IsIdentical: Boolean;
begin
  Result := -1;
  ACount := Length(APointIndexes);
  if (ACount=0)OR(FCount=0)then Exit;
  for I := 1 to FCount-1 do
  if ACount=FItems[I].Count then
  begin
    IsIdentical := true;
    for J := 0 to FItems[I].Count-1 do
      if FItems[I][J]<>APointIndexes[J] then
      begin
        IsIdentical := false; Break;
      end;{for}
    if IsIdentical then
    for J := 0 to FItems[I].Count-1 do
      if FItems[I][J]<>APointIndexes[ACount-1-J] then
      begin
        IsIdentical := true; Break;
      end;{for}
    if IsIdentical then
    begin
      Result := I; Break;
    end;{for}
  end;{for}
end;{IndexOf}
function TDBBlocks.IndexOf(const AId_Block: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
    if FItems[I].Id_Block=AId_Block then
    begin
      Result := I; Break;
    end;{for}
end;{IndexOf}

function TDBBlocks.Add(const APointsIndexes: TIntegerDynArray;
                       const AIsCrossRoad: Boolean=false): Integer;
var
  I,ACount: Integer;
  AKind: TBlockKind;
begin
  Result:= -1;
  ACount := Length(APointsIndexes);
  //0.Уже предполагается, что одинаковых точек в исходном массиве индексов нет ----------------
  //1а.Необходимо как минимум две точки для создания БУ
  if (ACount<2)and(not AIsCrossRoad)then
  begin
    esaMsgError(EInvalidBlockPointsCount); Exit;
  end;{if}
  //1б.Необходимо ровно две точки для создания перекрестка
  if (ACount<>2)and AIsCrossRoad then
  begin
    esaMsgError(EInvalidBlockPointsCount); Exit;
  end;{if}
  if Openpit.RoadCoats.Count=0     //2.Необходима заполненность "Типы дорожного покрытия"
  then esaMsgError(Format(EEmptyDBTable,['Дорожные покрытия']))
  else
  begin
    //тип блок-участка
    if AIsCrossRoad
    then AKind := bukCrossRoad
    else
      begin
        if abs(Openpit.Points[APointsIndexes[0]].Coords.Z-Openpit.Points[APointsIndexes[ACount-1]].Coords.Z)>7
        then AKind := bukRoadDown
        else
          if (Openpit.LoadingPunkts.IndexOf(APointsIndexes[0])>-1)OR
             (Openpit.LoadingPunkts.IndexOf(APointsIndexes[ACount-1])>-1)OR
             (Openpit.UnLoadingPunkts.IndexOf(APointsIndexes[0])>-1)OR
             (Openpit.UnLoadingPunkts.IndexOf(APointsIndexes[ACount-1])>-1)OR
             (Openpit.ShiftPunkts.IndexOf(APointsIndexes[0])>-1)OR
             (Openpit.ShiftPunkts.IndexOf(APointsIndexes[ACount-1])>-1)
          then AKind := bukManeuver
          else AKind := bukMoving;
      end;{else}
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      //Добавляю блок-участок
      SQL.Text := 'SELECT * FROM OpenpitBlocks';
      Open;
      Append;
      FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
      FieldByName('StripCount').AsInteger := DefaultParams.BlockStripCount;
      FieldByName('StripWidth').AsFloat := DefaultParams.BlockStripWidth;
      FieldByName('Id_RoadCoat').AsInteger := DefaultParams.BlockId_RoadCoat;
      FieldByName('LoadingVmax').AsFloat := DefaultParams.BlockLoadingVmax;
      FieldByName('UnLoadingVmax').AsFloat := DefaultParams.BlockUnLoadingVmax;
      FieldByName('Kind').AsInteger := Integer(AKind);
      Post;

      Inc(FCount);
      SetLength(FItems,FCount);
      FItems[FCount-1] := TDBBlock.Create(Openpit);
      FItems[FCount-1].Id_Block := FieldByName('Id_Block').AsInteger;
      FItems[FCount-1].FKind    := AKind;
      FItems[FCount-1].FPointIndexes := Copy(APointsIndexes);
      FItems[FCount-1].FCount := ACount;
      FItems[FCount-1].UpdateLength;
      Close;
      //Добавляю точки блок-участка
      //Добавляю блок-участок
      SQL.Text := 'SELECT * FROM OpenpitBlockPoints';
      Open;
      for I := 0 to ACount-1 do
      begin
        Append;
        FieldByName('Id_Block').AsInteger := FItems[FCount-1].Id_Block;
        FieldByName('Id_Point').AsInteger := FOpenpit.Points[APointsIndexes[I]].Id_Point;
        Post;
      end;{for}
      Close;
    finally
      Free;
    end;{try}
    Result := FCount-1;
    Invalidate;
  end;{else}
end;{Add}



function TDBBlocks.GetAssignedObjects(var sId_Blocks: String;
                                      const ABlockIndexes: TIntegerDynArray): String;
var
  I,ACount: Integer;
  S,sCourseBlocksNo,sCoursesNo: String;
begin
  Result := '';
  ACount := Length(ABlockIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  //-------------------------------------------------------------------------------------------
  //Составляю:
  //  список кодов блок-участков sId_Bloks
  //  список индексов маршрутов карьера, в состав к-х входят данные БУ 
  sId_Blocks := '';
  sCoursesNo := '';
  sCourseBlocksNo := '';
  for I := 0 to ACount-1 do
  begin
    sId_Blocks := sId_Blocks+IntToStr(Openpit.Blocks[ABlockIndexes[I]].Id_Block)+',';
    S := Openpit.Courses.FindBlocks(Openpit.Blocks[ABlockIndexes[I]].Id_Block);
    if S<>'' then
    begin
      sCourseBlocksNo := sCourseBlocksNo+IntToStr(ABlockIndexes[I]+1)+',';
      sCoursesNo := sCoursesNo+S+',';
    end;{if}
  end;{for}
  //Убираю конечную запятую -------------------------------------------------------------------
  if sId_Blocks<>'' then System.Delete(sId_Blocks,Length(sId_Blocks),1);
  if sCourseBlocksNo<>'' then System.Delete(sCourseBlocksNo,Length(sCourseBlocksNo),1);
  if sCoursesNo<>'' then System.Delete(sCoursesNo,Length(sCoursesNo),1);
  DeleteDuplicateValues(sId_Blocks);
  DeleteDuplicateValues(sCourseBlocksNo);
  DeleteDuplicateValues(sCoursesNo);
  //Result
  if (sId_Blocks<>'')AND(sCoursesNo<>'')
  then Result := 'Блок-участки №№ '+sCourseBlocksNo+' входят в состав:'+CR;
  if sCoursesNo<>''
  then Result := Result+'- маршрутов №№ '+sCoursesNo+CR;
  if Result<>''
  then Result := Result+'Удаление невозможно без их предварительного расформирования.';
end;{GetAssignedObjects}
function TDBBlocks.Delete(const ABlocksIndexes: TIntegerDynArray): Boolean;
var
  ACount: Integer;
  Msg,sId_Blocks: String; 
begin
  Result := false;
  ACount := Length(ABlocksIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  Msg := GetAssignedObjects(sId_Blocks,ABlocksIndexes);
  //Проверки ----------------------------------------------------------------------------------
  if sId_Blocks<>'' then //выбраны коды удаляемых блок-участков
  if Msg<>''             //данные блок-участки входят в какие-либо маршруты
  then esaMsgError(Msg)
  else
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'DELETE FROM OpenpitBlocks WHERE Id_Block in('+sId_Blocks+')';
      ExecSQL;
      Result := true;
    finally
      Free;
      Openpit.RefreshData;
    end;{try}
end;{Delete}
procedure TDBBlocks.DeleteAll;
var
  Msg,sId_Blocks: String;
  ABlocksIndexes: TIntegerDynArray;
  I: Integer;
begin
  if FCount=0 then Exit;
  SetLength(ABlocksIndexes,FCount);
  for I := 0 to FCount-1 do
    ABlocksIndexes[I] := I;
  Msg := GetAssignedObjects(sId_Blocks,ABlocksIndexes);
  //Проверки ----------------------------------------------------------------------------------
  if sId_Blocks<>'' then //выбраны коды удаляемых блок-участков
  if Msg<>''             //данные блок-участки входят в какие-либо маршруты
  then esaMsgError(Msg)
  else
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'DELETE FROM OpenpitBlocks WHERE Id_Block in('+sId_Blocks+')';
      ExecSQL;
    finally
      Free;
      Openpit.RefreshData;
    end;{try}
end;{DeleteAll}
procedure TDBBlocks.Draw;
var I,J: Integer;
begin
  if (not Visible)OR(FCount=0) then Exit;
  glDisable(GL_LINE_STIPPLE);
  glLineWidth(1.0);
  for I := 0 to FCount-1 do
  begin                           
    glSetColor(DefaultParams.BlockColors[FItems[I].Kind]);
    glBegin(GL_LINES);
    for J := 1 to FItems[I].Count-1 do
    begin
      if DefaultParams.BlockStyle=bvsReal then
      begin
        glVertex2f(FItems[I].LeftCoords[J-1].X,FItems[I].LeftCoords[J-1].Y);
        glVertex2f(FItems[I].LeftCoords[J].X,FItems[I].LeftCoords[J].Y);
        glVertex2f(FItems[I].RightCoords[J-1].X,FItems[I].RightCoords[J-1].Y);
        glVertex2f(FItems[I].RightCoords[J].X,FItems[I].RightCoords[J].Y);
      end;{if}
      if (FItems[I].StripCount=2)OR(DefaultParams.BlockStyle=bvsNone) then
      begin
        glVertex2f(FItems[I].Points[J-1].Coords.X,FItems[I].Points[J-1].Coords.Y);
        glVertex2f(FItems[I].Points[J].Coords.X,FItems[I].Points[J].Coords.Y);
      end;{if}
    end;{for}
    glEnd;
  end;{for}
end;{Draw}
procedure TDBBlocks.RefreshData;
var quBlocks,quBlockPoints: TADOQuery;
    dsBlocks: TDataSource;
begin
  Clear;
  quBlocks := TADOQuery.Create(nil);
  try
    quBlocks.Connection := DBConnection;
    quBlocks.SQL.Text := 'SELECT * FROM OpenpitBlocks WHERE Id_Openpit='+
                         IntToStr(Openpit.Id_Openpit);
    quBlocks.Open;
    dsBlocks := TDataSource.Create(nil);
    try
      dsBlocks.DataSet := quBlocks;
      quBlockPoints := TADOQuery.Create(nil);
      try
        quBlockPoints.Connection := DBConnection;
        quBlockPoints.DataSource := dsBlocks;
        quBlockPoints.SQL.Text := 'SELECT * FROM OpenpitBlockPoints WHERE Id_Block=:Id_Block';
        quBlockPoints.Open;
        FCount := quBlocks.RecordCount;
        SetLength(FItems,FCount);
        quBlocks.First;
        while not quBlocks.Eof do
        begin
          FItems[quBlocks.RecNo-1] := TDBBlock.Create(Openpit);
          with quBlocks do
          begin
            FItems[quBlocks.RecNo-1].FId_Block := FieldByName('Id_Block').AsInteger;
            FItems[quBlocks.RecNo-1].FStripCount := FieldByName('StripCount').AsInteger;
            FItems[quBlocks.RecNo-1].FStripWidth := FieldByName('StripWidth').AsFloat;
            FItems[quBlocks.RecNo-1].FId_RoadCoat := FieldByName('Id_RoadCoat').AsInteger;
            FItems[quBlocks.RecNo-1].FLoadingVmax := FieldByName('LoadingVmax').AsFloat;
            FItems[quBlocks.RecNo-1].FUnLoadingVmax := FieldByName('UnLoadingVmax').AsFloat;
            FItems[quBlocks.RecNo-1].FKind := TBlockKind(FieldByName('Kind').AsInteger);
          end;{with}
          quBlockPoints.Last;
          quBlockPoints.First;
          FItems[quBlocks.RecNo-1].FCount := quBlockPoints.RecordCount;
          SetLength(FItems[quBlocks.RecNo-1].FPointIndexes,FItems[quBlocks.RecNo-1].FCount);
          while not quBlockPoints.Eof do
          begin
            FItems[quBlocks.RecNo-1].FPointIndexes[quBlockPoints.RecNo-1] :=
              Openpit.Points.IndexOf(quBlockPoints.FieldByName('Id_Point').AsInteger);
            quBlockPoints.Next;
          end;{while}
          FItems[quBlocks.RecNo-1].UpdateLength;
          quBlocks.Next;
        end;{while}
        quBlockPoints.Close;
      finally
        quBlockPoints.Free;
      end;{try}
    finally
      dsBlocks.Free;
    end;{try}
    quBlocks.Close;
  finally
    quBlocks.Free;
  end;{try}
end;{RefreshData}
procedure TDBBlocks.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FCount := 0;
  FItems := nil;
end;{Clear}
procedure TDBBlocks.UpdateLength;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].UpdateLength;
end;{UpdateLength}

//TDBCourse - класс "Маршрут движения" --------------------------------------------------------
procedure TDBCourse.SetId_Course(const Value: Integer);
begin
  if (FId_Course<>Value)and(Value>0)then
  begin
    FId_Course := Value;
  end;{if}
end;{SetId_Course}
procedure TDBCourse.SetId_Point0(const Value: Integer);
begin
  if (FId_Point0<>Value)and(Value>0)then
  begin
    FId_Point0 := Value;
  end;{if}
end;{SetId_Point0}
procedure TDBCourse.SetId_Point1(const Value: Integer);
begin
  if (FId_Point1<>Value)and(Value>0)then
  begin
    FId_Point1 := Value;
  end;{if}
end;{SetId_Point1}
function TDBCourse.GetBlockIndex(Index: Integer): Integer;
begin
  if InRange(Index,0,FCount-1)
  then Result := FBlockIndexes[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetBlockIndex}
function TDBCourse.GetBlock(Index: Integer): TDBBlock;
begin
  if InRange(Index,0,FCount-1)
  then Result := Openpit.Blocks[FBlockIndexes[Index]]          
  else raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetId_Block}
function TDBCourse.GetCenterCoord(Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FPointIndexesCount-1)
  then Result := Openpit.Points[FPointIndexes[Index]].Coords
  else raise Exception.Create(Format(EInvalidIndex,[Index,FPointIndexesCount-1]));
end;{GetCenterCoord}
function TDBCourse.GetLeftCoord(Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FPointIndexesCount-1)
  then Result := FLeftCoords[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index,FPointIndexesCount-1]));
end;{GetLeftCoord}
function TDBCourse.GetRightCoord(Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FPointIndexesCount-1)
  then Result := FRightCoords[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index,FPointIndexesCount-1]));
end;{GetRightCoord}
function TDBCourse.GetName: String;
begin
  case FKind of
    ckCourseMoving: Result := 'Пункт погрузки - Пункт разгрузки';
    ckCourseTo    : Result := 'Пункт пересменки - Пункт погрузки';
  else              Result := 'Пункт разгрузки - Пункт пересменки';
  end;{case}
end;{GetName}
procedure TDBCourse.UpdateLength;
var
  I,J,K: Integer;
  AWidth: Single; //Максим.ширина дороги маршрута, м
  ATempWidth: Single;
  ABlockPoints: TIntegerDynArray;
  ABlockPointsCount: Integer;
  AId_Point0: Integer;
  ASides: array of record
    LeftTop,RightTop,RightBottom,LeftBottom: RPoint3D;
  end;
begin
  FLength := 0.0;
  FPointIndexesCount := 0;
  FLeftCoords := nil;
  FRightCoords := nil;
  FPointIndexes := nil;
  ABlockPoints := nil;
  if FCount=0 then Exit;
  //составляю список индексов характерных точек(полилинию) маршрута 
  FPointIndexesCount := 0;
  AId_Point0 := FId_Point0;
  AWidth := 0.0;
  for I := 0 to FCount-1 do
  begin
    //копирую список индексов точек i-го блок-участка
    ABlockPointsCount := Openpit.Blocks[FBlockIndexes[I]].Count;
    ABlockPoints := Copy(Openpit.Blocks[FBlockIndexes[I]].FPointIndexes);
    //если необходимо, переворачиваю данный список
    if Openpit.Points[ABlockPoints[0]].Id_Point<>AId_Point0 then
      for J := 0 to (ABlockPointsCount div 2)-1 do
      begin
        K := ABlockPoints[J];
        ABlockPoints[J] := ABlockPoints[ABlockPointsCount-1-J];
        ABlockPoints[ABlockPointsCount-1-J] := K;
      end;{for}
    //добавляю ABlockPointsCount или ABlockPointsCount-1 последних точек в общий список
    if I=0 then K := 0 else K := 1;
    for J := K to ABlockPointsCount-1 do
    begin
      Inc(FPointIndexesCount);
      SetLength(FPointIndexes,FPointIndexesCount);
      FPointIndexes[FPointIndexesCount-1] := ABlockPoints[J];
    end;{J}
    AId_Point0 := Openpit.Points[ABlockPoints[ABlockPointsCount-1]].Id_Point;
    //длина маршрута
    FLength := FLength+Openpit.Blocks[FBlockIndexes[I]].BlockLength;
    //максимальная ширина маршрута
    with Openpit.Blocks[FBlockIndexes[I]] do
      ATempWidth := StripCount*StripWidth;
    if AWidth<ATempWidth then AWidth := ATempWidth;
  end;{for}
  //составляю список точек обочины дороги маршрута
  SetLength(FLeftCoords,FPointIndexesCount);
  SetLength(FRightCoords,FPointIndexesCount);
  SetLength(ASides,FPointIndexesCount);
  AWidth := AWidth*0.5;
  for I := 1 to FPointIndexesCount-1 do
  begin
    with ASides[I] do
      GetBound3DAroundPiece(CenterCoords[I-1],CenterCoords[I],AWidth,
                            LeftTop,RightTop,RightBottom,LeftBottom);
    FLeftCoords[I] := ASides[I].RightTop;
    FRightCoords[I] := ASides[I].RightBottom;
    if I=1 then
    begin
      FLeftCoords[I-1] := ASides[I].LeftTop;
      FRightCoords[I-1] := ASides[I].LeftBottom;
    end;{if}
    if I>1 then
    begin
      FLeftCoords[I-1] := CrossingPoint(ASides[I-1].LeftTop,ASides[I-1].RightTop,
                                        ASides[I].LeftTop,ASides[I].RightTop);
      FRightCoords[I-1] := CrossingPoint(ASides[I-1].LeftBottom,ASides[I-1].RightBottom,
                                         ASides[I].LeftBottom,ASides[I].RightBottom);
    end;{if}
  end;{for}
  ABlockPoints := nil;
  ASides := nil;
end;{UpdateLength}
constructor TDBCourse.Create(AOpenpit: TDBOpenpit);
begin
  FId_Course := 0;
  FLength := 0.0;
  FId_Point0 := 0;
  FId_Point1 := 0;
  FPointIndexesCount := 0;
  FKind := ckCourseMoving;
  inherited;
  FCount := 0;
  FBlockIndexes := nil;
  FLeftCoords := nil;
  FRightCoords := nil;
  FPointIndexes := nil;
end;{Create}
destructor TDBCourse.Destroy; 
begin
  FCount := 0;
  FBlockIndexes := nil;
  FLeftCoords := nil;
  FRightCoords := nil;
  FPointIndexes := nil;
  inherited;
end;{Destroy}

//TDBCourses - класс "Маршруты движения" ------------------------------------------------------
function TDBCourses.GetItem(Index: Integer): TDBCourse;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
constructor TDBCourses.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TDBCourses.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TDBCourses.IndexOf(const AId_Point0,AId_Point1: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
    if ((FItems[I].Id_Point0=AId_Point0)and(FItems[I].Id_Point1=AId_Point1))OR
       ((FItems[I].Id_Point0=AId_Point1)and(FItems[I].Id_Point1=AId_Point0))then
    begin
      Result := I; Break;
    end;{for}
end;{IndexOf}
function TDBCourses.IndexOf(const AId_Course: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
    if FItems[I].Id_Course=AId_Course then
    begin
      Result := I; Break;
    end;{for}
end;{IndexOf}
function TDBCourses.FindBlocks(const AId_Block: Integer): String;
var I,J: Integer;
begin
  Result := '';
  for I := 0 to FCount-1 do
    for J := 0 to FItems[I].Count-1 do
      if FItems[I].Blocks[J].Id_Block=AId_Block then
      begin
        Result := Result+IntToStr(I+1)+','; Break;
      end;{for}
  if Length(Result)>1 then Result := Copy(Result,1,Length(Result)-1);
end;{FindBlocks}
function TDBCourses.FindPoints(const AId_Point: Integer): String;
var I: Integer;
begin
  Result := '';
  for I := 0 to FCount-1 do
    if (FItems[I].Id_Point0=AId_Point)OR(FItems[I].Id_Point1=AId_Point) then
    begin
      Result := Result+IntToStr(I+1)+','; Break;
    end;{for}
  if Length(Result)>1 then Result := Copy(Result,1,Length(Result)-1);
end;{FindPoints}

function TDBCourses.IsPosibleCourse(const AId_Point0,AId_Point1: Integer): TIntegerDynArray;
type      {dwd}
  TVariantResult=(vrNone,vrExist,vrNotExist);
  RVariant=record
    Result: TVariantResult;
    Length : Single;
    ABlockIndexes: TIntegerDynArray;
    ABlockLengths: TIntegerDynArray;
    ABlockIndexesCount: Integer;
  end;
  RBlock=record
    Index,Id_Block,Id_Point0,Id_Point1,PointInd0,PointInd1: Integer;
    Length: Single;
    PointsCount : Integer;
    Points : TIntegerDynArray;
  end;
var
  ABlocks: array of RBlock;
  ABlocksCount,AVariantsCount: Integer;
  AVariants: array of RVariant;
  procedure FindNextNode(AId_Point00,AId_Point11,AVrntInd: Integer);
  var
    I,J,ALastId_Point,AOldCount: Integer;
    AOldLength: Single;
    IsFirst,IsExist,IsFound,isnotfind: Boolean;
  begin
    IsFirst := true;
    IsFound := false;
    AOldCount := AVariants[AVrntInd].ABlockIndexesCount;
    AOldLength := AVariants[AVrntInd].Length;
    for I := 0 to ABlocksCount-1 do//пробегаю по всем блок-участкам
    if (ABlocks[I].PointInd0=AId_Point00)or(ABlocks[I].PointInd1=AId_Point00)then
    begin//если нашел след.блок-участок, примыкающий к точке APointInd0
      //проверяю, есть ли этот блок-участок в данном списке
      IsExist := false;
      for J := 0 to AVariants[AVrntInd].ABlockIndexesCount-1 do
      if AVariants[AVrntInd].ABlockIndexes[J]=I then
      begin
        IsExist := true; Break;
      end;{for}
      if not IsExist then
      begin//есть очередной блок-участок
        IsFound := true;
        if ABlocks[I].PointInd0=AId_Point00
        then ALastId_Point := ABlocks[I].PointInd1
        else ALastId_Point := ABlocks[I].PointInd0;
        if not IsFirst then//если не единственный блок-участок найден, то рост вниз
        begin
          Inc(AVariantsCount);
          SetLength(AVariants,AVariantsCount);
          AVariants[AVariantsCount-1].Result := vrNone;
          AVariants[AVariantsCount-1].Length := AOldLength;
          AVariants[AVariantsCount-1].ABlockIndexes := Copy(AVariants[AVrntInd].ABlockIndexes,0,AOldCount);
          AVariants[AVariantsCount-1].ABlockIndexesCount := AOldCount;
          AVrntInd := AVariantsCount-1;
        end;{if}
        Inc(AVariants[AVrntInd].ABlockIndexesCount);
        SetLength(AVariants[AVariantsCount-1].ABlockIndexes,AVariants[AVrntInd].ABlockIndexesCount);
        AVariants[AVariantsCount-1].ABlockIndexes[AVariants[AVrntInd].ABlockIndexesCount-1] := I;
        AVariants[AVariantsCount-1].Length := AVariants[AVariantsCount-1].Length+ABlocks[I].Length;
        IsFirst := false;

        //вариант с окончанием поиска маршрута когда точка будет окончательной и не скраю БУ
       
        isnotfind:=true;
        for J:=0 to Length(ABlocks[I].Points)-1  do
        begin
          if (ALastId_Point=AId_Point11) or (ABlocks[I].Points[J] = AId_Point11) then
          begin
          AVariants[AVrntInd].Result := vrExist; //данный вариант завершен
          isnotfind :=false;
          break;
          end;
        end;
        if ALastId_Point=AId_Point11
        then AVariants[AVrntInd].Result := vrExist //данный вариант завершен
        else FindNextNode(ALastId_Point,AId_Point11,AVrntInd);
      end;{if}
    end;{for}
    if not IsFound //если для данного варианта не нашелсяь очередной блок-участков, то заканчиваю его
    then AVariants[AVrntInd].Result := vrNotExist;
  end;{FindNextNode}
var
  I,J,K,AIndex: Integer;
  AMinLength: Single;
  start: Boolean;
  addArr : TIntegerDynArray;
  addArr2 : TIntegerDynArray;
  isLastFristPoint : Boolean;
  isLastSecondPoint : Boolean;
  delarray : TIntegerDynArray;
begin
start := true;
isLastSecondPoint := False;
isLastFristPoint := False;
  //initialization
  Result := nil;
  AVariants := nil;
  AVariantsCount := 0;
  //составляю список всех блок-участков
  ABlocksCount := Openpit.Blocks.Count;
  SetLength(ABlocks,ABlocksCount);
  for I := 0 to Openpit.Blocks.Count-1 do
  begin
    ABlocks[I].Index := I;
    ABlocks[I].Id_Block := Openpit.Blocks[I].Id_Block;
    ABlocks[I].PointInd0 := Openpit.Blocks[I].FPointIndexes[0];
    ABlocks[I].PointInd1 := Openpit.Blocks[I].FPointIndexes[Openpit.Blocks[I].Count-1];
    ABlocks[I].Id_Point0 := Openpit.Blocks[I].Points[0].Id_Point;
    ABlocks[I].Id_Point1 := Openpit.Blocks[I].Points[Openpit.Blocks[I].Count-1].Id_Point;
    ABlocks[I].Length := Openpit.Blocks[I].BlockLength;
    ABlocks[I].PointsCount :=  Openpit.Blocks[I].Count - 1;
    if ABlocks[I].PointsCount >1 then
    begin
      SetLength(ABlocks[I].Points,Length(Openpit.Blocks[I].FPointIndexes));
      for J := 0 to Length(Openpit.Blocks[I].FPointIndexes)-1  do
        begin
        // ABlocks[I].Points[J] := Openpit.Blocks[I].Points[J].Id_Point;
          ABlocks[I].Points[J] := Openpit.Blocks[I].FPointIndexes[J];
      //   if ABlocks[I].Points[J] = 5877 then
      //   isLastFristPoint := true;
      end;
    end;
      if (ABlocks[I].PointInd0 = AId_Point0) or (ABlocks[I].PointInd1 =AId_Point0) then
      isLastFristPoint := true;
      if (ABlocks[I].PointInd0 = AId_Point1) or (ABlocks[I].PointInd1 =AId_Point1) then
      isLastSecondPoint := true;
  end;{for}


  if not isLastFristPoint then
  begin
    for I := 0 to Openpit.Blocks.Count-1 do
      for J := 0 to Length(ABlocks[I].Points) -1 do
      begin
        if ABlocks[I].Points[J] = AId_Point0 then
        begin
          SetLength(addArr, J+1);
          for K:=0 to J do
            addArr[K] := ABlocks[I].Points[K];
          Openpit.Blocks.Add(addArr);
          SetLength(addArr2, Length(ABlocks[I].Points) - J);
          For K:=J to Length(ABlocks[I].Points) -1 do
            addArr2[K-J] := ABlocks[I].Points[K];
          Openpit.Blocks.Add(addArr2);
          SetLength(delarray,1);
          delarray[0] := Openpit.Blocks.IndexOf(Openpit.Blocks.Items[I].FId_Block);
          Openpit.Blocks.Delete(delarray);
          FOpenpit.RefreshData;
          break;
        end;
      end;
  end;
  //delarray := null;

  if not isLastSecondPoint then
  begin
    for I := 0 to Openpit.Blocks.Count-1 do
      for J := 0 to Length(ABlocks[I].Points) -1 do
      begin
        if ABlocks[I].Points[J] = AId_Point1 then
        begin
        
          SetLength(addArr, J+1);
          for K:=0 to J do
            addArr[K] := ABlocks[I].Points[K];
          Openpit.Blocks.Add(addArr);
          SetLength(addArr2, Length(ABlocks[I].Points) - J);
          For K:=J to Length(ABlocks[I].Points) -1 do
            addArr2[K-J] := ABlocks[I].Points[K];
          Openpit.Blocks.Add(addArr2);

          SetLength(delarray,1);
          delarray[0] := Openpit.Blocks.IndexOf(Openpit.Blocks.Items[I].FId_Block);
          Openpit.Blocks.Delete(delarray);
          Openpit.RefreshData;
          break;
        end;
      end;
  end;

  for I := 0 to ABlocksCount-1 do
    //for J:=0 to Length(ABlocks[I].Points) -1 do
  begin
   if (ABlocks[I].PointInd0=AId_Point0)or(ABlocks[I].PointInd1=AId_Point0)
   then
    begin
      Inc(AVariantsCount);
      SetLength(AVariants,AVariantsCount);
      AVariants[AVariantsCount-1].Result := vrNone;
      AVariants[AVariantsCount-1].ABlockIndexesCount := 1;
      SetLength(AVariants[AVariantsCount-1].ABlockIndexes,1);
      AVariants[AVariantsCount-1].ABlockIndexes[0] := I;
      if ABlocks[I].PointInd0 = AId_Point0
      then FindNextNode(ABlocks[I].PointInd1,AId_Point1,AVariantsCount-1)
      else FindNextNode(ABlocks[I].PointInd0,AId_Point1,AVariantsCount-1);
    end;
  end;{for}
  //Выбираю маршрут с кратчайшим расстоянием
  AIndex := -1;
  AMinLength := High(Integer);
  for I := 0 to AVariantsCount-1 do
  if (AVariants[I].Result=vrExist)and(AVariants[I].Length<AMinLength)then
  begin
    AMinLength := AVariants[I].Length;
    AIndex := I;
  end;{for}
 {
  if AMinLength -1 = High(Integer) then
  begin
  for I:= 0 to ABlocksCount do
    for J:= 1 to ABlocks[I].PointsCount -1  do
    begin
      if ABlocks[I].Points[J] = AId_Point0 then
      begin
        SetLength(addArr,J+1);
        For K:=0 to J do
        begin
          addArr[K]:= ABlocks[I].Points[K];
        end;
        Openpit.FBlocks.Add(addArr);
        Openpit.Blocks.Add(addArr);
        SetLength(addArr2,ABlocks[I].PointsCount -J);
        For K:= J to ABlocks[I].PointsCount do
          addArr2[K-J] := ABlocks[I].Points[K];
         Openpit.FBlocks.Add(addArr2);
         Openpit.Blocks.Add(addArr2);
        // IsPosibleCourse(AId_Point0,AId_Point1);
      end;
    end;
  end
 // else start := false;
   }
//   end;

  //Возвращаю маршрут с кратчайшим расстоянием
  if AIndex>-1 then Result := Copy(AVariants[AIndex].ABlockIndexes);
  //finalization
  ABlocks := nil;
  AVariants := nil;
end;{IsPosibleCourse}

function TDBCourses.Add(const AId_Point0,AId_Point1: Integer): Integer;
type
  TPointType=(ptNone,ptLoadingPunkt,ptUnLoadingPunkt,ptShiftPunkt);
  function GetKind(Id_Point0: Integer): TPointType;
  begin
    Result := ptNone;
    if (Result=ptNone)and(Openpit.LoadingPunkts.FindBy(Id_Point0)<>'')
    then Result := ptLoadingPunkt;
    if (Result=ptNone)and(Openpit.UnLoadingPunkts.FindBy(Id_Point0)<>'')
    then Result := ptUnLoadingPunkt;
    if (Result=ptNone)and(Openpit.ShiftPunkts.FindBy(Id_Point0)<>'')
    then Result := ptShiftPunkt;
  end;{GetKind}
var
  I,AIndex0,AIndex1: Integer;
  AIndexes: TIntegerDynArray;
  AKind0,AKind1: TPointType;
begin
  AIndexes := nil;
  Result := -1;
  AIndex0 := Openpit.Points.IndexOf(AId_Point0);
  AIndex1 := Openpit.Points.IndexOf(AId_Point1);
  if AIndex0=-1 then esaMsgError('Неверный код заданной начальной точки маршрута.')
  else
  if AIndex1=-1 then esaMsgError('Неверный код заданной конечной точки маршрута.')
  else
  if IndexOf(AId_Point0,AId_Point1)>-1
  then esaMsgError(Format('Маршрут между точками №%d-%d уже существует.',[AIndex0+1,AIndex1+1]))
  else
  begin
    AKind0 := GetKind(AId_Point0);
    AKind1 := GetKind(AId_Point1);
    if (AKind0 in [ptNone])or(AKind1 in [ptNone])or
       ((AKind0=ptLoadingPunkt)and(AKind1<>ptUnLoadingPunkt))or
       ((AKind0=ptShiftPunkt)and(AKind1<>ptLoadingPunkt))or
       ((AKind0=ptUnLoadingPunkt)and(AKind1<>ptShiftPunkt))
    then esaMsgError('Необходима одна из следующих комбинаций начальной и конечной '+
                  'точек для создания маршрута:'+CR+
                  ' - Пункт погрузки-Пункт разгрузки'+CR+
                  ' - Пункт пересменки-Пункт погрузки'+CR+
                  ' - Пункт разгрузки-Пункт пересменки')
    else
    begin
      AIndexes := IsPosibleCourse(AIndex0,AIndex1);
      if AIndexes = nil
      then esaMsgError(Format('Между точками №%d-%d не существует маршрута.',
                    [AId_Point0, AId_Point1]))
      else
      begin
        Inc(FCount);
        SetLength(FItems,FCount);
        FItems[FCount-1] := TDBCourse.Create(Openpit);
        FItems[FCount-1].Id_Point0 := AId_Point0;
        FItems[FCount-1].Id_Point1 := AId_Point1;
        FItems[FCount-1].FCount := Length(AIndexes);
        FItems[FCount-1].FBlockIndexes := Copy(AIndexes);
        if (AKind0=ptShiftPunkt)and(AKind1=ptLoadingPunkt)
        then FItems[FCount-1].FKind := ckCourseTo
        else
        if (AKind0=ptUnLoadingPunkt)and(AKind1=ptShiftPunkt)
        then FItems[FCount-1].FKind := ckCourseFrom
        else FItems[FCount-1].FKind := ckCourseMoving;
        with TADOQuery.Create(nil) do
        try
          Connection :=DBConnection;
          SQL.Text := 'SELECT * FROM OpenpitCourses';
          Open;
          Append;
          FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
          FieldByName('Id_Point0').AsInteger := AId_Point0;
          FieldByName('Id_Point1').AsInteger := AId_Point1;
          FieldByName('Kind').AsInteger := Integer(FItems[FCount-1].FKind);
          Post;
          FItems[FCount-1].FId_Course := FieldByName('Id_Course').AsInteger;
          Close;
          SQL.Text := 'SELECT * FROM OpenpitCourseBlocks';
          Open;
          for I := 0 to FItems[FCount-1].FCount-1 do
          begin
            Append;
            FieldByName('Id_Course').AsInteger := FItems[FCount-1].Id_Course;
            FieldByName('Id_Block').AsInteger := FItems[FCount-1].Blocks[I].Id_Block;
            Post;
          end;{for}
          Close;
          FItems[FCount-1].UpdateLength;
        finally
          Free;
        end;{try}
        AIndexes := nil;
        Result := FCount-1;
        Invalidate;
      end;{else}
    end;{else}
  end;{else}
end;{Add}
function TDBCourses.Add(const AIndexes: TIntegerDynArray): Integer;
const
  eText0 = 'Выделено %d блок-участков формируемого маршрута.'+CR+
           'Маршрут должен состоять минимум из 5х блок-участков:'+CR+
           'Начальный пункт - БУ для маневров - БУ движения - БУ для маневров - Конечный пункт';
  eText1 = 'Необходима одна из следующих комбинаций начального '+
           'и конечного пункта для создания маршрута:'+CR+
           ' - Пункт погрузки-Пункт разгрузки'+CR+
           ' - Пункт пересменки-Пункт погрузки'+CR+
           ' - Пункт разгрузки-Пункт пересменки';
  eText21= 'Первый блок-участок маршрута должен быть блок-участком для маневра';
  eText22= 'Последний блок-участок маршрута должен быть блок-участком для маневра';
  eText3 = 'По выделенным блок-участкам невозможно проложить маршрут';
  eText41= 'Нет ни одного блок-участка движения/съезда в маршруте';
  eText42= 'Нет ни одного перекрестка в маршруте';
type
  TPointType=(ptNone,ptLoadingPunkt,ptUnLoadingPunkt,ptShiftPunkt);
  function GetKind(const ABlock: TDBBlock; var AId_Point: Integer): TPointType;
    function _GetKind(const AId_Point: Integer): TPointType;
    begin
      Result := ptNone;
      if (Result=ptNone)and(Openpit.LoadingPunkts.FindBy(AId_Point)<>'')
      then Result := ptLoadingPunkt;
      if (Result=ptNone)and(Openpit.UnLoadingPunkts.FindBy(AId_Point)<>'')
      then Result := ptUnLoadingPunkt;
      if (Result=ptNone)and(Openpit.ShiftPunkts.FindBy(AId_Point)<>'')
      then Result := ptShiftPunkt;
    end;{_GetKind}
  begin
    AId_Point := -1;
    Result := _GetKind(ABlock.Points[0].Id_Point);
    if Result<>ptNone then AId_Point := ABlock.Points[0].Id_Point else
    begin
      Result := _GetKind(ABlock.Points[ABlock.Count-1].Id_Point);
      if Result<>ptNone then AId_Point := ABlock.Points[ABlock.Count-1].Id_Point;
    end;{if}
  end;{GetKind}
var
  AKind0,AKind1                         : TPointType;
  AId_Point0,AId_Point1,AId_Point       : Integer;
  ABlock0,ABlock1,ABlock                : TDBBlock;
  I,ACount,cCrossRoad,cMovingAndRoadDown: Integer;
begin
  Result := -1;
  ACount := Length(AIndexes);
  if ACount<5 then esaMsgError(eText0,[ACount]) else
  begin
    ABlock0 := Openpit.Blocks[AIndexes[0]];
    ABlock1 := Openpit.Blocks[AIndexes[ACount-1]];
    AKind0 := GetKind(ABlock0,AId_Point0);
    AKind1 := GetKind(ABlock1,AId_Point1);
    if (AKind0 in [ptNone])or(AKind1 in [ptNone])or
       ((AKind0=ptLoadingPunkt)and(AKind1<>ptUnLoadingPunkt))or
       ((AKind0=ptShiftPunkt)and(AKind1<>ptLoadingPunkt))or
       ((AKind0=ptUnLoadingPunkt)and(AKind1<>ptShiftPunkt)) then esaMsgError(eText1) else
    if Openpit.Blocks[AIndexes[0]].Kind<>bukManeuver then esaMsgError(eText21) else
    if Openpit.Blocks[AIndexes[ACount-1]].Kind<>bukManeuver then esaMsgError(eText22) else
    begin
      cCrossRoad         := 0;
      cMovingAndRoadDown := 0;
      if ABlock0.Points[0].Id_Point=AId_Point0
      then AId_Point := ABlock0.Points[ABlock0.Count-1].Id_Point
      else AId_Point := ABlock0.Points[0].Id_Point;
      for I := 1 to ACount-1 do
      begin
        ABlock := Openpit.Blocks[AIndexes[I]];
        if (ABlock.Points[0].Id_Point=AId_Point)or(ABlock.Points[ABlock.Count-1].Id_Point=AId_Point) then
        begin
          if ABlock.Points[0].Id_Point=AId_Point
          then AId_Point := ABlock.Points[ABlock.Count-1].Id_Point
          else AId_Point := ABlock.Points[0].Id_Point;
        end{if}
        else
        begin
          esaMsgError(eText3); Exit;
        end;{else}
        if (I<ACount-1)and(ABlock.Kind in [bukMoving,bukRoadDown]) then Inc(cMovingAndRoadDown);
        if (I<ACount-1)and(ABlock.Kind=bukCrossRoad) then Inc(cCrossRoad);
      end;{for}
      if cMovingAndRoadDown=0 then esaMsgError(eText41) else
      if cCrossRoad=0 then esaMsgError(eText42) else
      begin
        Inc(FCount);                                              
        SetLength(FItems,FCount);
        FItems[FCount-1]               := TDBCourse.Create(Openpit);
        FItems[FCount-1].Id_Point0     := AId_Point0;
        FItems[FCount-1].Id_Point1     := AId_Point1;
        FItems[FCount-1].FCount        := Length(AIndexes);
        FItems[FCount-1].FBlockIndexes := Copy(AIndexes);
        if (AKind0=ptShiftPunkt)and(AKind1=ptLoadingPunkt)
        then FItems[FCount-1].FKind := ckCourseTo
        else
        if (AKind0=ptUnLoadingPunkt)and(AKind1=ptShiftPunkt)
        then FItems[FCount-1].FKind := ckCourseFrom
        else FItems[FCount-1].FKind := ckCourseMoving;
        with TADOQuery.Create(nil) do
        try
          Connection :=DBConnection;
          SQL.Text := 'SELECT * FROM OpenpitCourses';
          Open;
          Append;
          FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
          FieldByName('Id_Point0').AsInteger  := AId_Point0;
          FieldByName('Id_Point1').AsInteger  := AId_Point1;
          FieldByName('Kind').AsInteger       := Integer(FItems[FCount-1].FKind);
          Post;
          FItems[FCount-1].FId_Course         := FieldByName('Id_Course').AsInteger;
          Close;
          SQL.Text := 'SELECT * FROM OpenpitCourseBlocks';
          Open;
          for I := 0 to FItems[FCount-1].FCount-1 do
          begin
            Append;
            FieldByName('Id_Course').AsInteger:= FItems[FCount-1].Id_Course;
            FieldByName('Id_Block').AsInteger := FItems[FCount-1].Blocks[I].Id_Block;
            Post;
          end;{for}
          Close;
          FItems[FCount-1].UpdateLength;
        finally
          Free;
        end;{try}
        Result := FCount-1;
        Invalidate;
      end;{if}
    end;{else}
  end;{else}
end;{Add}
function TDBCourses.Delete(const ACoursesIndexes: TIntegerDynArray): Boolean;
var
  I,ACount: Integer;
  S: String; 
begin
  Result := false;
  ACount := Length(ACoursesIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  for I := 0 to ACount-1 do
    S := S+IntToStr(FItems[ACoursesIndexes[I]].Id_Course)+',';
  if S<>'' then
  with TADOQuery.Create(nil) do
  try
    S := Copy(S,1,Length(S)-1);
    Connection := DBConnection;
    SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_Course=Null WHERE Id_Course in('+S+')';
    ExecSQL;
    SQL.Text := 'DELETE FROM OpenpitCourses WHERE Id_Course in('+S+')';
    ExecSQL;
    Result := true;
  finally
    Free;
    Openpit.RefreshData;
  end;{try}
end;{Delete}
procedure TDBCourses.DeleteAll;
var
  I: Integer;
  S: String;
begin
  if FCount=0 then Exit;
  S := '';
  for I := 0 to FCount-1 do
    S := S+IntToStr(FItems[I].Id_Course)+',';
  if S<>'' then
  with TADOQuery.Create(nil) do
  try
    S := Copy(S,1,Length(S)-1);
    Connection := DBConnection;
    SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_Course=Null WHERE Id_Course in('+S+')';
    ExecSQL;
    SQL.Text := 'DELETE FROM OpenpitCourses WHERE Id_Course in('+S+')';
    ExecSQL;
  finally
    Free;
    Openpit.RefreshData;
  end;{try}
end;{DeleteAll}
procedure TDBCourses.Draw;
var I,J: Integer;
begin
  if (not Visible)OR(FCount=0) then Exit;
  glDisable(GL_LINE_STIPPLE);
  glLineWidth(1.0);
//  glSetColor(DefaultParams.CourseColor);
  glSetColor(clDarkGrayEx);
  for I := 0 to FCount-1 do
  begin
    for J := 1 to FItems[I].PointIndexesCount-1 do
    begin
    glBegin(GL_POLYGON);
      glVertex2f(FItems[I].LeftCoords[J-1].X,FItems[I].LeftCoords[J-1].Y);
      glVertex2f(FItems[I].LeftCoords[J].X,FItems[I].LeftCoords[J].Y);
      glVertex2f(FItems[I].RightCoords[J].X,FItems[I].RightCoords[J].Y);
      glVertex2f(FItems[I].RightCoords[J-1].X,FItems[I].RightCoords[J-1].Y);
    glEnd;
  (*
      glVertex2f(FItems[I].LeftCoords[J-1].X,FItems[I].LeftCoords[J-1].Y);
      glVertex2f(FItems[I].LeftCoords[J].X,FItems[I].LeftCoords[J].Y);
      glVertex2f(FItems[I].RightCoords[J-1].X,FItems[I].RightCoords[J-1].Y);
      glVertex2f(FItems[I].RightCoords[J].X,FItems[I].RightCoords[J].Y);
  *)
    end;{for}
  end;{for}
end;{Draw}
procedure TDBCourses.RefreshData;
var
  quCourses,quCourseBlocks: TADOQuery;
  dsCourses: TDataSource;
begin
  Clear;
  quCourses := TADOQuery.Create(nil);
  try
    quCourses.Connection := DBConnection;
    quCourses.SQL.Text := 'SELECT * FROM OpenpitCourses WHERE Id_Openpit='+
                           IntToStr(Openpit.Id_Openpit)+'';
    quCourses.Open;
    dsCourses := TDataSource.Create(nil);
    try
      dsCourses.DataSet := quCourses;
      quCourseBlocks := TADOQuery.Create(nil);
      try
        quCourseBlocks.Connection := DBConnection;
        quCourseBlocks.DataSource := dsCourses;
        quCourseBlocks.SQL.Text := 'SELECT * FROM OpenpitCourseBlocks '+
                                   'WHERE Id_Course=:Id_Course';
        quCourseBlocks.Open;

        FCount := quCourses.RecordCount;
        SetLength(FItems,quCourses.RecordCount);
        FCount := 0;
        quCourses.Last;
        quCourses.First;
        while not quCourses.Eof do
        begin
          FCount := FCount+1;
          FItems[FCount-1] := TDBCourse.Create(Openpit);
          FItems[FCount-1].Id_Course := quCourses.FieldByName('Id_Course').AsInteger;
          FItems[FCount-1].Id_Point0 := quCourses.FieldByName('Id_Point0').AsInteger;
          FItems[FCount-1].Id_Point1 := quCourses.FieldByName('Id_Point1').AsInteger;
          FItems[FCount-1].FKind := TCourseKind(quCourses.FieldByName('Kind').AsInteger);
          quCourseBlocks.Last;
          quCourseBlocks.First;
          FItems[FCount-1].FCount := quCourseBlocks.RecordCount;
          SetLength(FItems[FCount-1].FBlockIndexes,FItems[FCount-1].FCount);
          while not quCourseBlocks.Eof do
          begin
            FItems[FCount-1].FBlockIndexes[quCourseBlocks.RecNo-1] :=
              Openpit.Blocks.IndexOf(quCourseBlocks.FieldByName('Id_Block').AsInteger);
            quCourseBlocks.Next;
          end;{while}
          FItems[FCount-1].UpdateLength;
          quCourses.Next;
        end;{while}
        Invalidate;
        quCourseBlocks.Close;
      finally
        quCourseBlocks.Free;
      end;{try}
    finally
      dsCourses.Free;
    end;{try}
    quCourses.Close;
  finally
    quCourses.Free;
  end;{try}
end;{RefreshData}
procedure TDBCourses.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FCount := 0;
  FItems := nil;
end;{Clear}
procedure TDBCourses.UpdateLength;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].UpdateLength;
end;{UpdateLength}

//TDBLoadingPunktRock - класс "Добываемая горная порода на пункте погрузки" -------------------
procedure TDBLoadingPunktRock.SetId_Rock(const Value: Integer);
begin
  if FId_Rock<>Value then
  begin
    FRockInd := Openpit.Rocks.IndexOf(Value);
    if FRockInd=-1 then FId_Rock := 0 else FId_Rock := Value;
  end;{if}
end;{SetId_Rock}
procedure TDBLoadingPunktRock.SetContent(const Value: Single);
begin
  if InRange(Value,0.0,100.0)then
  begin
    FContent := Value;
  end;{if}
end;{SetContent}
procedure TDBLoadingPunktRock.SetPlannedVm3(const Value: Single);
begin
  if Value>=0.0 then
  begin
    FPlannedVm3 := Value;
  end;{if}
end;{SetPlannedVm3}
function TDBLoadingPunktRock.GetRock: RDBRock;
begin
  if InRange(FRockInd,0,Openpit.Rocks.Count-1)
  then Result := Openpit.Rocks[FRockInd]          
  else raise Exception.Create(Format(EInvalidIndex,[FRockInd,Openpit.Rocks.Count-1]));
end;{GetRock}
constructor TDBLoadingPunktRock.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_Rock := 0;
  FRockInd := -1;
  FContent := 0.0;
  FPlannedVm3 := 0.0;
end;{Create}

//TDBPunkt - класс "Пункт" --------------------------------------------------------------------
procedure TDBPunkt.SetId_Point(const Value: Integer);
begin
  if FId_Point<>Value then
  begin
    FPointInd := Openpit.Points.IndexOf(Value);
    if FPointInd=-1 then FId_Point := 0 else FId_Point := Value;
  end;{if}
end;{SetId_Point}
function TDBPunkt.GetCoords: RPoint3D;
begin
  if InRange(FPointInd,0,Openpit.Points.Count-1)
  then Result := Openpit.Points[FPointInd].Coords          
  else raise Exception.Create(Format(EInvalidIndex,[FPointInd,Openpit.Points.Count-1]));
end;{GetCoords}
constructor TDBPunkt.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_Point := 0;
  FPointInd := -1;
end;{Create}

//TDBLoadingPunkt - класс "Пункт погрузки" ----------------------------------------------------
procedure TDBLoadingPunkt.SetId_LoadingPunkt(const Value: Integer);
begin
  if FId_LoadingPunkt<>Value then
  begin
    FId_LoadingPunkt := Value;
  end;{if}
end;{SetId_LoadingPunkt}
procedure TDBLoadingPunkt.SetId_DeportExcavator(const Value: Integer);
begin
  if FId_DeportExcavator<>Value then
  begin
    FDeportExcavatorInd := Openpit.Excavators.IndexOf(Value);
    if FDeportExcavatorInd>-1 then FId_DeportExcavator := Value else FId_DeportExcavator := 0;
  end;{if}
end;{SetId_DeportExcavator}
function TDBLoadingPunkt.GetItem(Index: Integer): TDBLoadingPunktRock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TDBLoadingPunkt.GetDeportExcavator: TDBExcavator;
begin
  if InRange(FDeportExcavatorInd,0,Openpit.Excavators.Count-1)
  then Result := Openpit.Excavators[FDeportExcavatorInd]
  else Result := nil;
end;{GetDeportExcavator}
function TDBLoadingPunkt.GetDeportExcavatorName: String;
begin
  if (Excavator<>nil)and(Excavator.Id_Excavator>0)
  then Result := Format('%s(%d)',[Excavator.Characs.Name,Excavator.ParkNo])
  else Result := '';
end;{GetDeportExcavatorName}
constructor TDBLoadingPunkt.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
  FId_LoadingPunkt := 0;
  FId_DeportExcavator := 0;
  FDeportExcavatorInd := -1;
end;{Create}
destructor TDBLoadingPunkt.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBLoadingPunkt.Add(const AId_Rock: Integer; const AContent,APlannedVm3: Single);
var AIndex: Integer;
begin
  AIndex := Openpit.Rocks.IndexOf(AId_Rock);
  if AIndex>-1 then
  begin
    Inc(FCount);
    SetLength(FItems,FCount);
    FItems[FCount-1] := TDBLoadingPunktRock.Create(Openpit);
    FItems[FCount-1].FId_Rock := AId_Rock;
    FItems[FCount-1].FRockInd := AIndex;
    FItems[FCount-1].Content := AContent;
    FItems[FCount-1].PlannedVm3 := APlannedVm3;
  end;{if}
end;{Add}
procedure TDBLoadingPunkt.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FItems := nil;
  FCount := 0;
end;{Clear}
//TDBLoadingPunkts - класс "Пункты погрузки" --------------------------------------------------
function TDBLoadingPunkts.GetItem(Index: Integer): TDBLoadingPunkt;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TDBLoadingPunkts.GetAssignedObjects(var sId_LoadingPunkts: String;
                                             const ALoadingPunktIndexes: TIntegerDynArray): String;
var
  I,ACount: Integer;
  S,sCourseLoadingPunktsNo,sCoursesNo: String;
begin
  Result := '';
  ACount := Length(ALoadingPunktIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  //-------------------------------------------------------------------------------------------
  //Составляю:
  //  список пунктов погрузки sId_LoadingPunkts
  //  список индексов маршрутов карьера, содержащих данные пункты
  sId_LoadingPunkts := '';
  sCoursesNo := '';
  sCourseLoadingPunktsNo := '';
  for I := 0 to ACount-1 do
  begin
    sId_LoadingPunkts := sId_LoadingPunkts+
      IntToStr(Openpit.LoadingPunkts[ALoadingPunktIndexes[I]].Id_LoadingPunkt)+',';
    S := Openpit.Courses.FindPoints(Openpit.LoadingPunkts[ALoadingPunktIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sCourseLoadingPunktsNo := sCourseLoadingPunktsNo+IntToStr(ALoadingPunktIndexes[I]+1)+',';
      sCoursesNo := sCoursesNo+S+',';
    end;{if}
  end;{for}
  //Убираю конечную запятую -------------------------------------------------------------------
  if sId_LoadingPunkts<>'' then System.Delete(sId_LoadingPunkts,Length(sId_LoadingPunkts),1);
  if sCourseLoadingPunktsNo<>''
  then System.Delete(sCourseLoadingPunktsNo,Length(sCourseLoadingPunktsNo),1);
  if sCoursesNo<>'' then System.Delete(sCoursesNo,Length(sCoursesNo),1);
  DeleteDuplicateValues(sId_LoadingPunkts);
  DeleteDuplicateValues(sCourseLoadingPunktsNo);
  DeleteDuplicateValues(sCoursesNo);
  //Result
  if (sId_LoadingPunkts<>'')AND(sCoursesNo<>'')
  then Result := 'Пункты погрузки №№ '+sCourseLoadingPunktsNo+' входят в состав:'+CR;
  if sCoursesNo<>''
  then Result := Result+'- маршрутов №№ '+sCoursesNo+CR;
  if Result<>''
  then Result := Result+'Удаление невозможно без их предварительного расформирования.';
end;{GetAssignedObjects}
procedure TDBLoadingPunkts.SetTotalValues(sId_DeportExcavator: String;
                                          const ALoadingPunktIndexes: TIntegerDynArray);
var
  I,ACount: Integer;
  S,Values,sDeportExcavator: String;
begin
  ACount := Length(ALoadingPunktIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  if ACount<>1 then sId_DeportExcavator := '';
  if sId_DeportExcavator='' then
  begin
    sDeportExcavator := '';
    sId_DeportExcavator := '0';
  end;{if}
  for I := 0 to ACount-1 do
  begin
    FItems[ALoadingPunktIndexes[I]].Id_DeportExcavator := StrToInt(sId_DeportExcavator);
    S := S+IntToStr(FItems[ALoadingPunktIndexes[I]].Id_LoadingPunkt)+',';
  end;{for}
  if S<>'' then
  begin
    S := Copy(S,1,Length(S)-1);
    Values := '';
    if sId_DeportExcavator<>'0'
    then Values := Format('%s Id_DeportExcavator=%s,',[Values,sId_DeportExcavator])
    else Values := Format('%s Id_DeportExcavator=Null,',[Values]);
    if Values<>'' then
    with TADOQuery.Create(nil) do
    try
      System.Delete(Values,Length(Values),1);
      Connection := DBConnection;
      SQL.Text := 'UPDATE OpenpitLoadingPunkts SET '+Values+' WHERE Id_LoadingPunkt in('+S+')';
      ExecSQL;
    finally
      Free;
      Invalidate;
    end;{try}
  end;{if}
end;{SetTotalValues}
constructor TDBLoadingPunkts.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TDBLoadingPunkts.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TDBLoadingPunkts.IndexOf(const APointIndex: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].PointInd=APointIndex then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
function TDBLoadingPunkts.FindBy(const AId_Point: Integer): String;
var I: Integer;
begin
  Result := '';
  for I := 0 to FCount-1 do
    if FItems[I].Id_Point=AId_Point then
    begin
      Result := Result+IntToStr(I+1)+','; Break;
    end;{for}
  if Length(Result)>1 then Result := Copy(Result,1,Length(Result)-1);
end;{FindBy}
function TDBLoadingPunkts.Add(const APointIndex: Integer): Integer;
var AIndex: Integer;
begin
  Result:= -1;
  if not InRange(APointIndex,0,Openpit.Points.Count-1)
  then esaMsgError(Format(EInvalidIndex,[APointIndex,Openpit.Points.Count-1]))
  else
  begin
    AIndex := IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateLoadingPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    AIndex := Openpit.UnLoadingPunkts.IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateUnLoadingPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    AIndex := Openpit.ShiftPunkts.IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateShiftPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    if Openpit.Rocks.Count=0
    then esaMsgError(Format(EEmptyDBTable,['Типы горной породы']))
    else
      with TADOQuery.Create(nil) do
      try
        Connection := DBConnection;
        SQL.Text := 'SELECT * FROM OpenpitLoadingPunkts '+
                    'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
        Open;
        Append;
        FieldByName('SortIndex').AsInteger := FCount+1;
        FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
        FieldByName('Id_Point').AsInteger := Openpit.Points[APointIndex].Id_Point;
        FieldByName('Id_DeportExcavator').AsVariant := Null;
        Post;
        Inc(FCount);
        SetLength(FItems,FCount);
        FItems[FCount-1] := TDBLoadingPunkt.Create(Openpit);
        FItems[FCount-1].Id_LoadingPunkt := FieldByName('Id_LoadingPunkt').AsInteger;
        FItems[FCount-1].Id_Point := Openpit.Points[APointIndex].Id_Point;
        Result := FCount-1;
        Close;
      finally
        Free;
        Invalidate;
      end;{try}
  end;{else}
end;{Add}
function TDBLoadingPunkts.Delete(const ALoadingPunktsIndexes: TIntegerDynArray): Boolean;
var
  I,ACount: Integer;
  S,Msg: String; 
begin
  Result := false;
  ACount := Length(ALoadingPunktsIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  for I := 0 to ACount-1 do
    S := S+IntToStr(FItems[ALoadingPunktsIndexes[I]].Id_LoadingPunkt)+',';
  if S<>'' then
  begin
    Msg := GetAssignedObjects(S,ALoadingPunktsIndexes);
    if Msg<>''
    then esaMsgError(Msg)
    else
      with TADOQuery.Create(nil) do
      try
        Connection := DBConnection;
        SQL.Text := 'DELETE FROM OpenpitLoadingPunkts WHERE Id_LoadingPunkt in('+S+')';
        ExecSQL;
        Result := true;
      finally
        Free;
        Openpit.RefreshData;
      end;{try}
  end;{if}
end;{Delete}
procedure TDBLoadingPunkts.Draw;
var
  I: Integer;
  dX: Single;
begin
  if (not Visible)OR(FCount=0) then Exit;
  glPushMatrix;
    glSetColor(DefaultParams.LoadingPunktColor);
    dX := DefaultParams.LoadingPunktRadius*GraphKernel.MtrPerPxl;
    for I := 0 to FCount-1 do
    begin
      glBegin(GL_LINE_LOOP);
        glVertex2f(FItems[I].Coords.X-dX,FItems[I].Coords.Y-dX);
        glVertex2f(FItems[I].Coords.X+dX,FItems[I].Coords.Y-dX);
        glVertex2f(FItems[I].Coords.X+dX,FItems[I].Coords.Y+dX);
        glVertex2f(FItems[I].Coords.X-dX,FItems[I].Coords.Y+dX);
      glEnd;
    end;{if}
    if DefaultParams.LoadingPunktStyle=pvsNumber then
      for I := 0 to FCount-1 do
      begin
        glOutTextXY(FItems[I].Coords.X+dX,FItems[I].Coords.Y+dX,Format('%d. %s',[I+1,FItems[I].ExcavatorName]));
      end;{for}
  glPopMatrix;
end;{Draw}
procedure TDBLoadingPunkts.RefreshData;
var
  quLoadingPunkts,quLoadingPunktRocks: TADOQuery;
  dsLoadingPunkts: TDataSource;
begin
  Clear;
  quLoadingPunkts := TADOQuery.Create(nil);
  try
    quLoadingPunkts.Connection := DBConnection;
    quLoadingPunkts.SQL.Text := 'SELECT * FROM OpenpitLoadingPunkts WHERE Id_Openpit='+
                                IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
    quLoadingPunkts.Open;
    dsLoadingPunkts := TDataSource.Create(nil);
    try
      dsLoadingPunkts.DataSet := quLoadingPunkts;
      quLoadingPunktRocks := TADOQuery.Create(nil);
      try
        quLoadingPunktRocks.Connection := DBConnection;
        quLoadingPunktRocks.SQL.Text := 'SELECT * FROM OpenpitLoadingPunktRocks '+
                                        'WHERE Id_LoadingPunkt=:Id_LoadingPunkt ORDER BY SortIndex';
        quLoadingPunktRocks.DataSource := dsLoadingPunkts;
        quLoadingPunktRocks.Open;
        FCount := quLoadingPunkts.RecordCount;
        SetLength(FItems,FCount);
        quLoadingPunkts.First;
        while not quLoadingPunkts.Eof do
        begin
          FItems[quLoadingPunkts.RecNo-1] := TDBLoadingPunkt.Create(Openpit);
          with FItems[quLoadingPunkts.RecNo-1] do
          begin
            Id_LoadingPunkt    := quLoadingPunkts.FieldByName('Id_LoadingPunkt').AsInteger;
            Id_Point           := quLoadingPunkts.FieldByName('Id_Point').AsInteger;
            Id_DeportExcavator := quLoadingPunkts.FieldByName('Id_DeportExcavator').AsInteger;
          end;{with}
          quLoadingPunktRocks.Last;
          quLoadingPunktRocks.First;
          with quLoadingPunktRocks do
          while not Eof do
          begin 
            FItems[quLoadingPunkts.RecNo-1].Add(FieldByName('Id_Rock').AsInteger,
                                                FieldByName('Content').AsFloat,
                                                FieldByName('PlannedV1000m3').AsFloat);
            Next;
          end;{while}
          quLoadingPunkts.Next;
        end;{while}
        quLoadingPunktRocks.Close;
      finally
        quLoadingPunktRocks.Free;
      end;{try}
    finally
      dsLoadingPunkts.Free;
    end;{try}
    quLoadingPunkts.Close;
  finally
    quLoadingPunkts.Free;
  end;{try}
  Invalidate;
end;{RefreshData}
procedure TDBLoadingPunkts.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FCount := 0;
  FItems := nil;
end;{Clear}

//TDBUnLoadingPunktRock - класс "Породы на пункте разгрузки" ----------------------------------
procedure TDBUnLoadingPunktRock.SetId_Rock(const Value: Integer);
begin
  if FId_Rock<>Value then
  begin
    FRockInd := Openpit.Rocks.IndexOf(Value);
    if FRockInd=-1 then FId_Rock := 0 else FId_Rock := Value;
  end;{if}
end;{SetId_Rock}
procedure TDBUnLoadingPunktRock.SetRequiredContent(const Value: Single);
begin
  if (FRequiredContent<>Value)and InRange(Value,1.0,100.0) then
  begin
    FRequiredContent := Value;
  end;{if}
end;{SetRequiredContent}
procedure TDBUnLoadingPunktRock.SetInitialContent (const Value: Single);
begin
  if (FInitialContent<>Value)and InRange(Value,1.0,100.0) then
  begin
    FInitialContent := Value;
  end;{if}
end;{SetInitialContent}
procedure TDBUnLoadingPunktRock.SetInitialVm3   (const Value: Single);
begin
  if (FInitialVm3<>Value)and(Value>=0.0) then
  begin
    FInitialVm3 := Value;
  end;{if}
end;{SetInitialVm3}
function TDBUnLoadingPunktRock.GetRock: RDBRock;
begin
  if InRange(FRockInd,0,Openpit.Rocks.Count-1)
  then Result := Openpit.Rocks[FRockInd]
  else raise Exception.Create(Format(EInvalidIndex,[FRockInd,Openpit.Rocks.Count-1]));
end;{GetRock}
constructor TDBUnLoadingPunktRock.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_Rock := 0;
  FRockInd := -1;
  FRequiredContent := 0.0;
  FInitialContent := 0.0;
  FInitialVm3 := 0.0;
end;{Create}

//TDBUnLoadingPunkt - класс "Пункт разгрузки" -------------------------------------------------
procedure TDBUnLoadingPunkt.SetId_UnLoadingPunkt(const Value: Integer);
begin
  if FId_UnLoadingPunkt<>Value then
  begin
    FId_UnLoadingPunkt := Value;
  end;{if}
end;{SetId_UnLoadingPunkt}
function TDBUnLoadingPunkt.GetItem(Index: Integer): TDBUnLoadingPunktRock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
procedure TDBUnLoadingPunkt.SetMaxV1000m3(const Value: Single);
begin
  if (FMaxV1000m3<>Value)and(Value>0.0)then
  begin
    FMaxV1000m3 := Value;
  end;{if}
end;{SetMaxV1000m3}
procedure TDBUnLoadingPunkt.SetAutoMaxCount(const Value: Integer);
begin
  if (AutoMaxCount<>Value)and(Value>0)then
  begin
    FAutoMaxCount := Value;
  end;{if}
end;{SetUnLoadingPunktAutoMaxCount}
procedure TDBUnLoadingPunkt.SetKind(const Value: TUnLoadingPunktKind);
begin
  if Kind<>Value then
  begin
    FKind := Value;
  end;{if}
end;{SetUnLoadingPunktKind}
procedure TDBUnLoadingPunkt.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FCount := 0;
  FItems := nil;
end;{Clear}    
function TDBUnLoadingPunkt.FindBy(const AId_Rock: Integer;ARequiredContent: Single): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if (FItems[I].Id_Rock=AId_Rock)and IsZero(FItems[I].RequiredContent-ARequiredContent,0.1)then
  begin
    Result := I; Break;
  end;{for}
end;{FindBy}
constructor TDBUnLoadingPunkt.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
  FId_UnLoadingPunkt := 0;
  FMaxV1000m3 := 0.0;
  FAutoMaxCount := 0;
  FKind := ulpkFactory;
end;{Create}
destructor TDBUnLoadingPunkt.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBUnLoadingPunkt.Add(const AId_Rock: Integer;
                                const ARequiredContent,AInitialContent,AInitialVm3: Single);
var AIndex: Integer;
begin
  AIndex := Openpit.Rocks.IndexOf(AId_Rock);
  if AIndex>-1 then
  begin
    Inc(FCount);
    SetLength(FItems,FCount);
    FItems[FCount-1] := TDBUnLoadingPunktRock.Create(Openpit);
    FItems[FCount-1].FId_Rock := AId_Rock;
    FItems[FCount-1].FRockInd := AIndex;
    FItems[FCount-1].RequiredContent := ARequiredContent;
    FItems[FCount-1].InitialContent := AInitialContent;
    FItems[FCount-1].InitialVm3 := AInitialVm3;
  end;{if}
end;{Add}

//TDBUnLoadingPunkts - класс "Пункты погрузки" --------------------------------------------------
function TDBUnLoadingPunkts.GetItem(Index: Integer): TDBUnLoadingPunkt;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TDBUnLoadingPunkts.GetAssignedObjects(var sId_UnLoadingPunkts: String;
                                               const AUnLoadingPunktIndexes: TIntegerDynArray): String;
var
  I,ACount: Integer;
  S,sCourseUnLoadingPunktsNo,sCoursesNo: String;
begin
  Result := '';
  ACount := Length(AUnLoadingPunktIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  //-------------------------------------------------------------------------------------------
  //Составляю:
  //  список пунктов разгрузки sId_UnLoadingPunkts
  //  список индексов маршрутов карьера, содержащих данные пункты
  sId_UnLoadingPunkts := '';
  sCoursesNo := '';
  sCourseUnLoadingPunktsNo := '';
  for I := 0 to ACount-1 do
  begin
    with Openpit.UnLoadingPunkts[AUnLoadingPunktIndexes[I]] do
      sId_UnLoadingPunkts := sId_UnLoadingPunkts+IntToStr(Id_UnLoadingPunkt)+',';
    S := Openpit.Courses.FindPoints(Openpit.UnLoadingPunkts[AUnLoadingPunktIndexes[I]].Id_Point);
    if S<>'' then
    begin
      sCourseUnLoadingPunktsNo := sCourseUnLoadingPunktsNo+
                                  IntToStr(AUnLoadingPunktIndexes[I]+1)+',';
      sCoursesNo := sCoursesNo+S+',';
    end;{if}
  end;{for}
  //Убираю конечную запятую -------------------------------------------------------------------
  if sId_UnLoadingPunkts<>''
  then System.Delete(sId_UnLoadingPunkts,Length(sId_UnLoadingPunkts),1);
  if sCourseUnLoadingPunktsNo<>''
  then System.Delete(sCourseUnLoadingPunktsNo,Length(sCourseUnLoadingPunktsNo),1);
  if sCoursesNo<>''
  then System.Delete(sCoursesNo,Length(sCoursesNo),1);
  DeleteDuplicateValues(sId_UnLoadingPunkts);
  DeleteDuplicateValues(sCourseUnLoadingPunktsNo);
  DeleteDuplicateValues(sCoursesNo);
  //Result
  if (sId_UnLoadingPunkts<>'')AND(sCoursesNo<>'')
  then Result := 'Пункты погрузки №№ '+sCourseUnLoadingPunktsNo+' входят в состав:'+CR;
  if sCoursesNo<>''
  then Result := Result+'- маршрутов №№ '+sCoursesNo+CR;
  if Result<>''
  then Result := Result+'Удаление невозможно без их предварительного расформирования.';
end;{GetAssignedObjects}
procedure TDBUnLoadingPunkts.SetTotalValues(const sMaxV1000m3,sAutoMaxCount,sKind: String;
                                            const AUnLoadingPunktIndexes: TIntegerDynArray);
var
  I,ACount: Integer;
  S,Values: String;
begin
  ACount := Length(AUnLoadingPunktIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  for I := 0 to ACount-1 do
  with FItems[AUnLoadingPunktIndexes[I]] do
  begin
    if sMaxV1000m3  <>'' then MaxV1000m3  := StrToFloat(sMaxV1000m3);
    if sAutoMaxCount<>'' then AutoMaxCount:= StrToInt(sAutoMaxCount);
    if sKind        <>'' then Kind        := TUnLoadingPunktKind(StrToInt(sKind));
    S := S+IntToStr(Id_UnLoadingPunkt)+',';
  end;{for}
  if S<>'' then
  begin
    S := Copy(S,1,Length(S)-1);
    Values := '';
    if sMaxV1000m3<>''
    then Values := Format('%s MaxV1000m3=%d/10,',[Values,Round(StrToFloat(sMaxV1000m3)*10)]);
    if sAutoMaxCount<>''
    then Values := Format('%s AutoMaxCount=%d,',[Values,StrToInt(sAutoMaxCount)]);
    if sKind<>''
    then Values := Format('%s Kind=%d,',[Values,StrToInt(sKind)]);
    if Values<>'' then
    with TADOQuery.Create(nil) do
    try
      System.Delete(Values,Length(Values),1);
      Connection := DBConnection;
      SQL.Text := 'UPDATE OpenpitUnLoadingPunkts SET '+Values+
                  ' WHERE Id_UnLoadingPunkt in('+S+')';
      ExecSQL;
    finally
      Free;
      Invalidate;
    end;{try}
  end;{if}
end;{SetTotalValues}

constructor TDBUnLoadingPunkts.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TDBUnLoadingPunkts.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TDBUnLoadingPunkts.IndexOf(const APointIndex: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
    if FItems[I].PointInd=APointIndex then
    begin
      Result := I; Break;
    end;{for}
end;{IndexOf}
function TDBUnLoadingPunkts.FindBy(const AId_Point: Integer): String;
var I: Integer;
begin
  Result := '';
  for I := 0 to FCount-1 do
    if FItems[I].Id_Point=AId_Point then
    begin
      Result := Result+IntToStr(I+1)+','; Break;
    end;{for}
  if Length(Result)>1 then Result := Copy(Result,1,Length(Result)-1);
end;{FindBy}
function TDBUnLoadingPunkts.Add(const APointIndex: Integer): Integer;
var AIndex: Integer;
begin
  Result:= -1;
  if not InRange(APointIndex,0,Openpit.Points.Count-1)
  then esaMsgError(Format(EInvalidIndex,[APointIndex,Openpit.Points.Count-1]))
  else
  begin
    AIndex := IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateUnLoadingPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    AIndex := Openpit.LoadingPunkts.IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateLoadingPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    AIndex := Openpit.ShiftPunkts.IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateShiftPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    if Openpit.Rocks.Count=0
    then esaMsgError(Format(EEmptyDBTable,['Типы горной породы']))
    else
      with TADOQuery.Create(nil) do
      try
        Connection := DBConnection;
        SQL.Text := 'SELECT * FROM OpenpitUnLoadingPunkts '+
                    'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
        Open;
        Append;
        FieldByName('SortIndex').AsInteger := FCount+1;
        FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
        FieldByName('Id_Point').AsInteger := Openpit.Points[APointIndex].Id_Point;
        FieldByName('MaxV1000m3').AsFloat := DefaultParams.UnLoadingPunktMaxV1000m3;
        FieldByName('AutoMaxCount').AsInteger := DefaultParams.UnLoadingPunktAutoMaxCount;
        FieldByName('Kind').AsInteger := Integer(DefaultParams.UnLoadingPunktKind);
        Post;
        Inc(FCount);
        SetLength(FItems,FCount);
        FItems[FCount-1] := TDBUnLoadingPunkt.Create(Openpit);
        FItems[FCount-1].Id_UnLoadingPunkt := FieldByName('Id_UnLoadingPunkt').AsInteger;
        FItems[FCount-1].Id_Point := Openpit.Points[APointIndex].Id_Point;
        FItems[FCount-1].MaxV1000m3 := FieldByName('MaxV1000m3').AsFloat;
        FItems[FCount-1].AutoMaxCount := FieldByName('AutoMaxCount').AsInteger;
        FItems[FCount-1].Kind := TUnLoadingPunktkind(FieldByName('Kind').AsInteger);
        Result := FCount-1;
        Close;
      finally
        Free;
        Invalidate;
      end;{try}
  end;{else}
end;{Add}
function TDBUnLoadingPunkts.Delete(const AUnLoadingPunktsIndexes: TIntegerDynArray): Boolean;
var
  I,ACount: Integer;
  S,Msg: String; 
begin
  Result := false;
  ACount := Length(AUnLoadingPunktsIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  for I := 0 to ACount-1 do
    S := S+IntToStr(FItems[AUnLoadingPunktsIndexes[I]].Id_UnLoadingPunkt)+',';
  if S<>'' then
  begin
    Msg := GetAssignedObjects(S,AUnLoadingPunktsIndexes);
    if Msg<>''
    then esaMsgError(Msg)
    else
      with TADOQuery.Create(nil) do
      try
        Connection := DBConnection;
        SQL.Text := 'DELETE FROM OpenpitUnLoadingPunkts WHERE Id_UnLoadingPunkt in('+S+')';
        ExecSQL;
        Result := true;
      finally
        Free;
        Openpit.RefreshData;
      end;{try}
  end;{if}
end;{Delete}
procedure TDBUnLoadingPunkts.Draw;
var
  I: Integer;
  dX: Single;
begin
  if (not Visible)OR(FCount=0) then Exit;
  glPushMatrix;
    dX := DefaultParams.UnLoadingPunktRadius*GraphKernel.MtrPerPxl;
    glSetColor(DefaultParams.UnLoadingPunktColor);
    for I := 0 to FCount-1 do
    begin
      glBegin(GL_LINE_LOOP);
        glVertex2f(Items[I].Coords.X-dX,Items[I].Coords.Y-dX);
        glVertex2f(Items[I].Coords.X+dX,Items[I].Coords.Y-dX);
        glVertex2f(Items[I].Coords.X+dX,Items[I].Coords.Y+dX);
        glVertex2f(Items[I].Coords.X-dX,Items[I].Coords.Y+dX);
      glEnd;
    end;{if}
    if DefaultParams.UnLoadingPunktStyle=pvsNumber then
      for I := 0 to FCount-1 do
        glOutTextXY(Items[I].Coords.X+dX,Items[I].Coords.Y+dX,Format('%d.',[I+1]));
  glPopMatrix;
end;{Draw}
procedure TDBUnLoadingPunkts.RefreshData;
var
  quUnLoadingPunkts,quUnLoadingPunktRocks: TADOQuery;
  dsUnLoadingPunkts: TDataSource;
begin
  Clear;
  quUnLoadingPunkts := TADOQuery.Create(nil);
  try
    quUnLoadingPunkts.Connection := DBConnection;
    quUnLoadingPunkts.SQL.Text := 'SELECT * FROM OpenpitUnLoadingPunkts WHERE Id_Openpit='+
                                IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
    quUnLoadingPunkts.Open;
    dsUnLoadingPunkts := TDataSource.Create(nil);
    try
      dsUnLoadingPunkts.DataSet := quUnLoadingPunkts;
      quUnLoadingPunktRocks := TADOQuery.Create(nil);
      try
        quUnLoadingPunktRocks.Connection := DBConnection;
        quUnLoadingPunktRocks.SQL.Text := 'SELECT * FROM OpenpitUnLoadingPunktRocks '+
                                          'WHERE Id_UnLoadingPunkt=:Id_UnLoadingPunkt ORDER BY SortIndex';
        quUnLoadingPunktRocks.DataSource := dsUnLoadingPunkts;
        quUnLoadingPunktRocks.Open;
        FCount := quUnLoadingPunkts.RecordCount;
        SetLength(FItems,FCount);
        quUnLoadingPunkts.First;
        while not quUnLoadingPunkts.Eof do
        begin
          FItems[quUnLoadingPunkts.RecNo-1] := TDBUnLoadingPunkt.Create(Openpit);
          with FItems[quUnLoadingPunkts.RecNo-1],quUnLoadingPunkts do
          begin
            Id_UnLoadingPunkt:= FieldByName('Id_UnLoadingPunkt').AsInteger;
            Id_Point         := FieldByName('Id_Point').AsInteger;
            MaxV1000m3       := FieldByName('MaxV1000m3').AsFloat;
            AutoMaxCount     := FieldByName('AutoMaxCount').AsInteger;
            Kind             := TUnLoadingPunktKind(FieldByName('Kind').AsInteger);
          end;{with}
          quUnLoadingPunktRocks.Last;
          quUnLoadingPunktRocks.First;
          with quUnLoadingPunktRocks do
          while not Eof do
          begin 
            FItems[quUnLoadingPunkts.RecNo-1].Add(FieldByName('Id_Rock').AsInteger,
                                                  FieldByName('RequiredContent').AsFloat,
                                                  FieldByName('InitialContent').AsFloat,
                                                  FieldByName('InitialV1000m3').AsFloat);
            Next;
          end;{while}
          quUnLoadingPunkts.Next;
        end;{while}
        quUnLoadingPunktRocks.Close;
      finally
        quUnLoadingPunktRocks.Free;
      end;{try}
    finally
      dsUnLoadingPunkts.Free;
    end;{try}
    quUnLoadingPunkts.Close;
  finally
    quUnLoadingPunkts.Free;
  end;{try}
  Invalidate;
end;{RefreshData}
procedure TDBUnLoadingPunkts.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FCount := 0;
  FItems := nil;
end;{Clear}
//TDBShiftPunkts - класс "Пункты пересменки" --------------------------------------------------
procedure TDBShiftPunkt.SetId_ShiftPunkt(const Value: Integer);
begin
  if FId_ShiftPunkt<>Value then
  begin
    FId_ShiftPunkt := Value;
  end;{if}
end;{SetId_ShiftPunkt}
constructor TDBShiftPunkt.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FId_ShiftPunkt := 0;
end;{Create}
//TDBShiftPunkts - класс "Пункты пересменки" --------------------------------------------------
function TDBShiftPunkts.GetItem(Index: Integer): TDBShiftPunkt;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TDBShiftPunkts.GetAssignedObjects(var sId_ShiftPunkts: String;
                                           const AShiftPunktIndexes: TIntegerDynArray): String;
var
  I,ACount: Integer;
  S,sCourseShiftPunktsNo,sCoursesNo: String;
begin
  Result := '';
  ACount := Length(AShiftPunktIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  //-------------------------------------------------------------------------------------------
  //Составляю:
  //  список пунктов погрузки sId_ShiftPunkts
  //  список индексов маршрутов карьера, содержащих данные пункты
  sId_ShiftPunkts := '';
  sCoursesNo := '';
  sCourseShiftPunktsNo := '';
  for I := 0 to ACount-1 do
  with Openpit.ShiftPunkts[AShiftPunktIndexes[I]] do
  begin
    sId_ShiftPunkts := sId_ShiftPunkts+IntToStr(Id_ShiftPunkt)+',';
    S := Openpit.Courses.FindPoints(Id_Point);
    if S<>'' then
    begin
      sCourseShiftPunktsNo := sCourseShiftPunktsNo+IntToStr(AShiftPunktIndexes[I]+1)+',';
      sCoursesNo := sCoursesNo+S+',';
    end;{if}
  end;{for}
  //Убираю конечную запятую -------------------------------------------------------------------
  if sId_ShiftPunkts<>'' then System.Delete(sId_ShiftPunkts,Length(sId_ShiftPunkts),1);
  if sCourseShiftPunktsNo<>''
  then System.Delete(sCourseShiftPunktsNo,Length(sCourseShiftPunktsNo),1);
  if sCoursesNo<>'' then System.Delete(sCoursesNo,Length(sCoursesNo),1);
  DeleteDuplicateValues(sId_ShiftPunkts);
  DeleteDuplicateValues(sCourseShiftPunktsNo);
  DeleteDuplicateValues(sCoursesNo);
  //Result
  if (sId_ShiftPunkts<>'')AND(sCoursesNo<>'')
  then Result := 'Пункты погрузки №№ '+sCourseShiftPunktsNo+' входят в состав:'+CR;
  if sCoursesNo<>''
  then Result := Result+'- маршрутов №№ '+sCoursesNo+CR;
  if Result<>''
  then Result := Result+'Удаление невозможно без их предварительного расформирования.';
end;{GetAssignedObjects}
constructor TDBShiftPunkts.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TDBShiftPunkts.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TDBShiftPunkts.IndexOf(const APointIndex: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].PointInd=APointIndex then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
function TDBShiftPunkts.FindBy(const AId_Point: Integer): String;
var I: Integer;
begin
  Result := '';
  for I := 0 to FCount-1 do
    if FItems[I].Id_Point=AId_Point then
    begin
      Result := Result+IntToStr(I+1)+','; Break;
    end;{for}
  if Length(Result)>1 then Result := Copy(Result,1,Length(Result)-1);
end;{FindBy}
function TDBShiftPunkts.Add(const APointIndex: Integer): Integer;
var AIndex: Integer;
begin
  Result:= -1;
  if not InRange(APointIndex,0,Openpit.Points.Count-1)
  then esaMsgError(Format(EInvalidIndex,[APointIndex,Openpit.Points.Count-1]))
  else
  begin
    AIndex := IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateShiftPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    AIndex := Openpit.UnLoadingPunkts.IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateUnLoadingPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    AIndex := Openpit.LoadingPunkts.IndexOf(APointIndex);
    if AIndex<>-1 then
    begin
      esaMsgError(Format(EDuplicateLoadingPunkt,[APointIndex+1,AIndex+1])); Exit;
    end;{if}
    with TADOQuery.Create(nil) do
    try
      Connection := DBConnection;
      SQL.Text := 'SELECT * FROM OpenpitShiftPunkts '+
                  'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
      Open;
      Append;
      FieldByName('SortIndex').AsInteger := FCount+1;
      FieldByName('Id_Openpit').AsInteger := Openpit.Id_Openpit;
      FieldByName('Id_Point').AsInteger := Openpit.Points[APointIndex].Id_Point;
      Post;
      Inc(FCount);
      SetLength(FItems,FCount);
      FItems[FCount-1] := TDBShiftPunkt.Create(Openpit);
      FItems[FCount-1].Id_ShiftPunkt := FieldByName('Id_ShiftPunkt').AsInteger;
      FItems[FCount-1].Id_Point := Openpit.Points[APointIndex].Id_Point;
      Close;
      Result := FCount-1;
      Invalidate;
    finally
      Free;
    end;{try}
  end;{else}
end;{Add}
function TDBShiftPunkts.Delete(const AShiftPunktsIndexes: TIntegerDynArray): Boolean;
var
  I,ACount: Integer;
  S,Msg: String; 
begin
  Result := false;
  ACount := Length(AShiftPunktsIndexes);
  if (ACount=0)OR(FCount=0) then Exit;
  S := '';
  for I := 0 to ACount-1 do
    S := S+IntToStr(FItems[AShiftPunktsIndexes[I]].Id_ShiftPunkt)+',';
  if S<>'' then
  begin
    Msg := GetAssignedObjects(S,AShiftPunktsIndexes);
    if Msg<>''
    then esaMsgError(Msg)
    else
      with TADOQuery.Create(nil) do
      try
        Connection := DBConnection;
        SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_ShiftPunkt=Null WHERE Id_ShiftPunkt in('+S+')';
        ExecSQL;
        SQL.Text := 'DELETE FROM OpenpitShiftPunkts WHERE Id_ShiftPunkt in('+S+')';
        ExecSQL;
        Result := true;
      finally
        Free;
        Openpit.RefreshData;
      end;{try}
  end;{if}
end;{Delete}
procedure TDBShiftPunkts.Draw;
var
  I: Integer;
  dX: Single;
begin
  if (not Visible)OR(FCount=0) then Exit;
  glPushMatrix;
    dX := DefaultParams.ShiftPunktRadius*GraphKernel.MtrPerPxl;
    glSetColor(DefaultParams.ShiftPunktColor);
    for I := 0 to FCount-1 do
    with Items[I].Coords do
    begin
      glBegin(GL_LINE_LOOP);
        glVertex2f(X-dX,Y-dX);
        glVertex2f(X+dX,Y-dX);
        glVertex2f(X+dX,Y+dX);
        glVertex2f(X-dX,Y+dX);
      glEnd;
    end;{if}
    if DefaultParams.ShiftPunktStyle=pvsNumber then
      for I := 0 to FCount-1 do
        glOutTextXY(Items[I].Coords.X+dX,Items[I].Coords.Y+dX,Format('%d.',[I+1]));
  glPopMatrix;
end;{Draw}
procedure TDBShiftPunkts.RefreshData;
begin
  Clear;
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitShiftPunkts '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    First;
    while not Eof do
    begin
      FItems[RecNo-1] := TDBShiftPunkt.Create(Openpit);
      with FItems[RecNo-1] do
      begin
        Id_ShiftPunkt := FieldByName('Id_ShiftPunkt').AsInteger;
        Id_Point      := FieldByName('Id_Point').AsInteger;
      end;{with}
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  Invalidate;
end;{RefreshData}
procedure TDBShiftPunkts.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Free;
  FCount := 0;
  FItems := nil;
end;{Clear}
//TDBSelectedObjects - класс "Список индексов выделенных объектов" ----------------------------
procedure TDBSelectedObjects.DoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [',','.'] then Key := DecimalSeparator;
  if not(Key in ['0'..'9',DecimalSeparator,#8]) then Key := #0;
end;{DoKeyPress}
function TDBSelectedObjects.GetItem(Index: Integer): Integer;
begin
  if InRange(Index,0,FCount-1)
  then Result := FIndexes[Index]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
procedure TDBSelectedObjects.SetColor(Value: TColor);
begin
  if (FColor<>Value)and(Value<>clBlack) then
  begin
    FColor := Value;
    Invalidate;
  end;{if}
end;{SetColor}
procedure TDBSelectedObjects.SetSelectedKind(Value: TSelectedKind);
begin
  if FSelectedKind<>Value then
  begin
    FSelectedKind := Value;
    Clear;
    Invalidate;
  end;{if}
end;{SetSelectedKind}
procedure TDBSelectedObjects.UpdateLength;
var I: Integer;
begin
  FLength := 0.0;
  FSelectedNumbers := '';
  if FSelectedKind in [skPoints,skBlockPoints,skCrossRoadPoints]then
    for I := 1 to FCount-1 do
      FLength  := FLength+sqrt(sqr(Points[I].Coords.X-Points[I-1].Coords.X)+
                               sqr(Points[I].Coords.Y-Points[I-1].Coords.Y)+
                               sqr(Points[I].Coords.Z-Points[I-1].Coords.Z));

  for I := 0 to FCount-1 do
    FSelectedNumbers := FSelectedNumbers+IntToStr(FIndexes[I]+1)+',';
  if FSelectedNumbers<>'' then System.Delete(FSelectedNumbers,Length(FSelectedNumbers),1);
  PostMessage(Handle,WM_SELECTED,Integer(FSelectedKind),FCount);
end;{UpdateLength}
procedure TDBSelectedObjects.CreateEditorForm(var Form: TForm; W,H: Integer;
                                              var ValueListEditor: TValueListEditor;
                                              const ACaption: String;
                                              var btOk,btCancel: TButton);
begin
  Form := nil;
  ValueListEditor := nil;
  btOk := nil;
  btCancel := nil;
  //Создаю редактор ---------------------------------------------------------------------------
  Form := TForm.Create(nil);
  with Form do
  begin
    Width := W; Height := H; BorderStyle := bsDialog; BorderIcons := BorderIcons+[biHelp];
    Caption := 'Свойства'; Position := poScreenCenter;
  end;{with}
  ValueListEditor := TValueListEditor.Create(Form);
  with ValueListEditor do
  begin
    Parent := Form; Height := Form.ClientHeight-48; Align := alTop;
    TitleCaptions[0] := ACaption; TitleCaptions[1] := '№ '+FSelectedNumbers;
    OnKeyPress := DoKeyPress; Options := Options-[goColSizing];
  end;{with}
  btOk := TButton.Create(Form);
  with btOk do
  begin
    Parent := Form; Caption := 'Ok'; Default := true; ModalResult := mrOk; Width := 72;
    Left := (W div 2)-Width-16; Top := Form.ClientHeight-Height-12; 
  end;{with}
  btCancel := TButton.Create(Form);
  with btCancel do
  begin
    Parent := Form; Caption := 'Отмена'; Cancel := true; ModalResult := mrCancel; Width := 72;
    Left := (W div 2)+16; Top := Form.ClientHeight-Height-12;
  end;{with}
end;{CreateEditorForm}
function TDBSelectedObjects.GetPoint(Index: Integer): RDBPoint;
var ACount: Integer;
begin
  if FSelectedKind in [skPoints,skBlockPoints,skCrossRoadPoints,skCoursePoints]
  then ACount := FCount else ACount := 0;
  if InRange(Index,0,ACount-1)
  then Result := Openpit.Points[FIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetPoint}
function TDBSelectedObjects.CheckPointsEditorValues(const sX,sY,sZ: String): Boolean;
  function CheckValue(const sValue,aPrompt: String): Boolean;
  begin
    Result := true;
    if FCount=1 then
    begin
      try
        StrToFloat(sValue)
      except
        Result := false;
        esaMsgError(Format(EInvalidSingleValue,[sValue,aPrompt]));
      end;{try}
    end;{if}
  end;{CheckValue}
begin
  Result := CheckValue(sX,'X') and CheckValue(sY,'Y');
  if Result and(not((FCount>1)and(sZ=''))) then Result := CheckValue(sZ,'Z');
end;{CheckPointsEditorValues}
function TDBSelectedObjects.FindPoint(const APoint: RPoint3D;
                                      const ARadiusMtr: Single): Integer;
var
  I: Integer;
  RR: Single;
begin
  Result := -1;
  if not Openpit.Points.Visible then Exit;
  RR := sqr(ARadiusMtr);
  for I := 0 to Openpit.Points.Count-1 do
    with Openpit.Points[I].Coords do
    if sqr(X-APoint.X)+sqr(Y-APoint.Y)<=RR then
    begin
      Result := I; Break;
    end;{for}
end;{FindPoint}
procedure TDBSelectedObjects.DrawPoints;
var I: Integer;
begin
  if(FCount=0)OR(not(FSelectedKind in[skPoints,skBlockPoints,skCrossRoadPoints,skCoursePoints]))
  then Exit;  
  glPushMatrix;
    if FSelectedKind in [skBlockPoints,skCrossRoadPoints,skCoursePoints] then
    begin
      glSetColor(clDkGray);
      glBegin(GL_LINE_STRIP);
        for I := 0 to FCount-1 do
          glVertex2f(Points[I].Coords.X,Points[I].Coords.Y);
      glEnd;
    end;{if}
    glEnable(GL_POINT_SMOOTH);
    glPointSize(4*DefaultParams.PointRadius);
    glSetColor(FColor);
    glBegin(GL_POINTS);
      for I := 0 to FCount-1 do
        glVertex2f(Points[I].Coords.X,Points[I].Coords.Y);
    glEnd;
    //начальная точка
    glPointSize(2*DefaultParams.PointRadius);
    glSetColor(clBlack);
    glBegin(GL_POINTS);
      glVertex2f(Points[0].Coords.X,Points[0].Coords.Y);
    glEnd;
  glPopMatrix;
end;{DrawPoints}
procedure TDBSelectedObjects.PointsEditorExecute;
var
  Form: TForm;
  ValueListEditor: TValueListEditor;
  btOk,btCancel: TButton;
  I,Result,ACount: Integer;
  sX,sY,sZ: String;
  IsOk: Boolean;
  APoint: RDBPoint;
begin
  if FCount=0 then Exit;
  //Определяю значения полей sX,sY,sZ ---------------------------------------------------------
  sX := '<None>'; sY := '<None>'; sZ := '';
  if FCount=1 then
  begin//выбрана одна точка
    sX := FormatFloat('0.000',Points[0].Coords.X);
    sY := FormatFloat('0.000',Points[0].Coords.Y);
  end;{if}
  sZ := FormatFloat('0.000',Points[0].Coords.Z);
  for I := 1 to FCount-1 do
  if FormatFloat('0.000',Points[I].Coords.Z)<>sZ then
  begin
    sZ := ''; Break;
  end;{for}

  //Создаю редактор ---------------------------------------------------------------------------
  CreateEditorForm(Form,320,240,ValueListEditor,'Характерные точки',btOk,btCancel);
  try
    with ValueListEditor do
    begin
      Strings.Text := 'X='+CR+'Y='+CR+'Z=';
      ItemProps['X'].ReadOnly := FCount>1; ItemProps['Y'].ReadOnly := FCount>1;
      repeat
        Values['X'] := sX; Values['Y'] := sY; Values['Z'] := sZ;
        Result := Form.ShowModal;
        IsOk := (Result<>mrOk)OR((Result=mrOk)and
                (CheckPointsEditorValues(Values['X'],Values['Y'],Values['Z'])));
        if IsOk then
        begin
          sX := Values['X']; sY := Values['Y']; sZ := Values['Z'];
        end;{if}
      until IsOk;
      //заношу новые значения -----------------------------------------------------------------
      if IsOk and (Result=mrOk) then
      begin
        ACount := FCount;
        FCount := 0;
        if (ACount>1)and(sZ<>'') //выбрано несколько точек и задано общее значение Z
        then Openpit.Points.SetTotalZ(StrToFloat(sZ),FIndexes);
        if ACount=1 then //выбрана одна точка и заданы значения X,Y,Z
        begin
          APoint.Id_Point := Openpit.Points[FIndexes[0]].Id_Point;
          APoint.Coords.X := StrToFloat(sX);
          APoint.Coords.Y := StrToFloat(sY);
          APoint.Coords.Z := StrToFloat(sZ);
          Openpit.Points[FIndexes[0]] := APoint;
        end;{if}
        FCount := ACount;
        UpdateLength;
        Invalidate;
      end;{if}
    end;{with}
  finally
    Form.Free;
  end;{try}
end;{PointsEditorExecute}
//для блок-участков
function TDBSelectedObjects.GetBlock(Index: Integer): TDBBlock;
var ACount: Integer;
begin
  if FSelectedKind in [skBlocks,skCrossRoads,skCourseBlocks]
  then ACount := FCount else ACount := 0;
  if InRange(Index,0,ACount-1)
  then Result := Openpit.Blocks[FIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetBlock}
function TDBSelectedObjects.CheckBlocksEditorValues(const sStripCount,sStripWidth,sLoadingVmax,sUnLoadingVmax: String): Boolean;
begin
  Result := CheckStrValue(sStripCount,'Количество полос движения',1,2,FCount>1)AND
            CheckStrValue(sStripWidth,'Ширина полосЫ движения, м',1.0,100.0,FCount>1)AND
            CheckStrValue(sLoadingVmax,'Допускаемая скорость (груз.), км/ч',5.0,500.0,FCount>1)AND
            CheckStrValue(sUnLoadingVmax,'Допускаемая скорость (порожн.), км/ч',5.0,500.0,FCount>1)
end;{CheckBlocksEditorValues}
function TDBSelectedObjects.FindBlock(const APoint: RPoint3D): Integer;
var
  I,J: Integer;
  ABlock: TDBBlock;
  px0,py0,px1,py1,x0,y0,x1,y1,xc,yc,a,R: Single;
begin
  Result := -1;
  if not Openpit.Blocks.Visible then Exit;
  for I := 0 to Openpit.Blocks.Count-1 do
  begin
    ABlock := Openpit.Blocks[I];
    for J := 1 to ABlock.Count-1 do
    begin
      if ABlock.StripCount=1
      then R := ABlock.StripWidth*0.5
      else R := ABlock.StripWidth;
      px0 := ABlock.Points[J-1].Coords.X;
      py0 := ABlock.Points[J-1].Coords.Y;
      px1 := ABlock.Points[J].Coords.X;
      py1 := ABlock.Points[J].Coords.Y;
      //Нахожу угол наклона текущего ребра к оси OX
      a := AngleByOXInRad(px1-px0,py1-py0);
      //Поворачиваю ребро на ось OX
      x0 := px0;
      y0 := py0;
      x1 := px0 + (px1-px0)*Cos(a)+(py1-py0)*Sin(a);
      y1 := py0 - (px1-px0)*Sin(a)+(py1-py0)*Cos(a);
      //Поворачиваю точку X,Y аналогично текущему звену
      xc := px0 + (APoint.X-px0)*Cos(a)+(APoint.Y-py0)*Sin(a);
      yc := py0 - (APoint.X-px0)*Sin(a)+(APoint.Y-py0)*Cos(a);
      if InRange(xc,x0-0.01,x1+0.01) and InRange(yc,y0-R,y1+R)
      then Result := I;
//      if InRange(xc,x0-R,x1+R) and InRange(yc,y0-R,y1+R)
//      then Result := I;
      if Result>-1 then Break;
    end;{for}
    if Result>-1 then Break;
  end;{for}
end;{FindBlock}
procedure TDBSelectedObjects.DrawBlocks;
var I,J: Integer;
begin
  if FCount=0 then Exit;
  glLineStipple(1,$F0F0);
  glEnable(GL_LINE_STIPPLE);
  glLineWidth(3.0);
  for I := 0 to FCount-1 do
  begin
    glSetColor(clYellow);
    glBegin(GL_LINES);
    for J := 1 to Blocks[I].Count-1 do
    begin
      if DefaultParams.BlockStyle=bvsReal then
      begin
        glVertex2f(Blocks[I].LeftCoords[J-1].X,Blocks[I].LeftCoords[J-1].Y);
        glVertex2f(Blocks[I].LeftCoords[J].X,Blocks[I].LeftCoords[J].Y);
        glVertex2f(Blocks[I].RightCoords[J-1].X,Blocks[I].RightCoords[J-1].Y);
        glVertex2f(Blocks[I].RightCoords[J].X,Blocks[I].RightCoords[J].Y);
      end{if}
      else
      begin
        glVertex2f(Blocks[I].CenterCoords[J-1].X,Blocks[I].CenterCoords[J-1].Y);
        glVertex2f(Blocks[I].CenterCoords[J].X,Blocks[I].CenterCoords[J].Y);
      end;{else}
    end;{for}
    glEnd;
  end;{for}
  glDisable(GL_LINE_STIPPLE);
end;{Draw}
procedure TDBSelectedObjects.BlocksEditorExecute;
const
  cStripCount = 'Количество полос движения';
  cStripWidth = 'Ширина полосЫ движения, м';
  cRoadCoat   = 'Тип дорожного покрытия';
  cKind       = 'Тип блок-участка';
  cLoadingVmax   = 'Допускаемая скорость (груз.), км/ч';
  cUnLoadingVmax = 'Допускаемая скорость (порожн.), км/ч';
var
  Form: TForm;
  ValueListEditor: TValueListEditor;
  btOk,btCancel: TButton;
  sStripCount,sStripWidth,sId_RoadCoat,sKind,sLoadingVmax,sUnLoadingVmax: String;
  IsOk: Boolean;
  I,Result,ACount,AIndex: Integer;
  AKind: (kNotCrossRoads,kCrossRoads,kMixedKind);//тип выделенных блок-участков
begin
  if FCount=0 then Exit;
  if Openpit.RoadCoats.Count=0
  then raise Exception.Create(Format(EEmptyDBTable,['Дорожные покрытия']));
  //Определяю значения полей StripCount,StripWidth,StripId_Openpit ----------------------------
  sStripCount := IntToStr(Blocks[0].StripCount);
  sStripWidth := FormatFloat('0.0',Blocks[0].StripWidth);
  sId_RoadCoat := IntToStr(Blocks[0].Id_RoadCoat);
  sKind := IntToStr(Integer(Blocks[0].Kind));
  sLoadingVmax := FormatFloat('0.0',Blocks[0].LoadingVmax);
  sUnLoadingVmax := FormatFloat('0.0',Blocks[0].UnLoadingVmax);

  if Blocks[0].Kind<>bukCrossRoad then AKind := kNotCrossRoads else AKind := kCrossRoads;
  for I := 1 to FCount-1 do
  begin
    if IntToStr(Blocks[I].StripCount)<>sStripCount then sStripCount := '';
    if FormatFloat('0.0',Blocks[I].StripWidth)<>sStripWidth then sStripWidth := '';
    if IntToStr(Blocks[I].Id_RoadCoat)<>sId_RoadCoat then sId_RoadCoat := '';
    if IntToStr(Integer(Blocks[I].Kind))<>sKind then sKind := '';
    if FormatFloat('0.0',Blocks[I].LoadingVmax)<>sLoadingVmax then sLoadingVmax := '';
    if FormatFloat('0.0',Blocks[I].UnLoadingVmax)<>sUnLoadingVmax then sUnLoadingVmax := '';
    if AKind<>kMixedKind then
      if ((AKind=kNotCrossRoads)and(Blocks[I].Kind=bukCrossRoad))OR
         ((AKind=kCrossRoads)and(Blocks[I].Kind<>bukCrossRoad))
      then AKind := kMixedKind;
  end;{if}

  //Создаю редактор ---------------------------------------------------------------------------
  if FSelectedKind=skCrossRoads
  then CreateEditorForm(Form,600,240,ValueListEditor,'Перекрестки',btOk,btCancel)
  else CreateEditorForm(Form,600,240,ValueListEditor,'Блок-участки',btOk,btCancel);
  try
    //Заполняю параметры ValueListEditor-------------------------------------------------------
    with ValueListEditor do
    begin
      //Заношу общие параметры ValueListEditor
      Strings.Text := cStripCount+'='+CR+
                      cStripWidth+'='+CR+
                      cRoadCoat+'='+CR+
                      cLoadingVmax+'='+CR+
                      cUnLoadingVmax+'=';
      //Заношу параметры ValueListEditor "Тип блок-участка"
      if AKind=kNotCrossRoads then
      begin
        Strings.Add('Тип блок-участка=');
        with ItemProps[cKind] do
        begin
          PickList.Text := ''+CR+'Участок движения'+CR+'Съезд'+CR+'Участок для маневра';
          EditStyle := esPickList;
          ReadOnly := true;
        end;{with}
      end;{if}
      //Заношу параметры ValueListEditor "Тип дорожного покрытия"
      with ItemProps[cRoadCoat] do
      begin
        PickList.Add('');
        for I := 0 to Openpit.RoadCoats.Count-1 do
          PickList.Add(Openpit.RoadCoats[I].Name);
        EditStyle := esPickList;
        ReadOnly := true;
      end;{with}
      ColWidths[0] := 170;
    end;{with}
    //-----------------------------------------------------------------------------------------
    with ValueListEditor do
    repeat
      Values[cStripCount] := sStripCount;
      Values[cStripWidth] := sStripWidth;
      Values[cLoadingVmax]:= sLoadingVmax;
      Values[cUnLoadingVmax]:= sUnLoadingVmax;
      if sId_RoadCoat=''
      then Values[cRoadCoat] := ''
      else
      begin
        AIndex := Openpit.RoadCoats.IndexOf(StrToInt(sId_RoadCoat));
        if AIndex>-1
        then Values[cRoadCoat] := Openpit.RoadCoats[AIndex].Name
        else Values[cRoadCoat] := '';
      end;{else}
      if AKind=kNotCrossRoads then
        if sKind=''
        then Values[cKind] := ''
        else Values[cKind] := ItemProps[cKind].PickList.Strings[StrToInt(sKind)+1];
      Result := Form.ShowModal;
      IsOk :=(Result<>mrOk)OR((Result=mrOk)and
             (CheckBlocksEditorValues(Values[cStripCount],Values[cStripWidth],Values[cLoadingVmax],Values[cUnLoadingVmax])));
    until IsOk;
    //заношу новые значения -------------------------------------------------------------------
    with ValueListEditor do
    if IsOk and (Result=mrOk) then
    begin
      ACount := FCount;
      FCount := 0;
      sStripCount:=Values[cStripCount]; sStripWidth:=Values[cStripWidth]; sLoadingVmax:=Values[cLoadingVmax];
      sUnLoadingVmax:=Values[cUnLoadingVmax];
      sId_RoadCoat := '';
      if Values[cRoadCoat]<>'' then
      begin
        AIndex := Openpit.RoadCoats.IndexOf(Values[cRoadCoat]);
        if AIndex>-1 then sId_RoadCoat := IntToStr(Openpit.RoadCoats[AIndex].Id_RoadCoat);
      end;{if}
      sKind := '';           
      if (AKind=kNotCrossRoads)and(Values[cKind]<>'') 
      then sKind := IntToStr(ItemProps[cKind].PickList.IndexOf(Values[cKind])-1);
      Openpit.Blocks.SetTotalValues(sStripCount,sStripWidth,sId_RoadCoat,sKind,sLoadingVmax,sUnLoadingVmax,FIndexes);
      FCount := ACount;
      UpdateLength;
      Invalidate;
    end;{if}
  finally
    Form.Free;
  end;{try}
end;{EditorExecute}
//для маршрутов
function TDBSelectedObjects.GetCourse(Index: Integer): TDBCourse;
var ACount: Integer;
begin
  if FSelectedKind in [skCourses]
  then ACount := FCount else ACount := 0;
  if InRange(Index,0,ACount-1)
  then Result := Openpit.Courses[FIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetCourse}
function TDBSelectedObjects.FindCourse(const APoint: RPoint3D): Integer;
var
  I,J,K: Integer;
  ABlock: TDBBlock;
  px0,py0,px1,py1,x0,y0,x1,y1,xc,yc,a,R: Single;
begin
  Result := -1;
  if not Openpit.Courses.Visible then Exit;
  for I := 0 to Openpit.Courses.Count-1 do
  if Openpit.Courses[I].Visible then
  for J := 0 to Openpit.Courses[I].Count-1 do
  begin
    ABlock := Openpit.Courses[I].Blocks[J];
    for K := 1 to ABlock.Count-1 do
    begin
      if ABlock.StripCount=1
      then R := ABlock.StripWidth*0.5
      else R := ABlock.StripWidth;
      px0 := ABlock.Points[K-1].Coords.X;
      py0 := ABlock.Points[K-1].Coords.Y;
      px1 := ABlock.Points[K].Coords.X;
      py1 := ABlock.Points[K].Coords.Y;
      //Нахожу угол наклона текущего ребра к оси OX
      a := AngleByOXInRad(px1-px0,py1-py0);
      //Поворачиваю ребро на ось OX
      x0 := px0;
      y0 := py0;
      x1 := px0 + (px1-px0)*Cos(a)+(py1-py0)*Sin(a);
      y1 := py0 - (px1-px0)*Sin(a)+(py1-py0)*Cos(a);
      //Поворачиваю точку X,Y аналогично текущему звену
      xc := px0 + (APoint.X-px0)*Cos(a)+(APoint.Y-py0)*Sin(a);
      yc := py0 - (APoint.X-px0)*Sin(a)+(APoint.Y-py0)*Cos(a);
      if InRange(xc,x0-0.01,x1+0.01) and InRange(yc,y0-R,y1+R)
      then Result := I;
//      if InRange(xc,x0-R,x1+R) and InRange(yc,y0-R,y1+R)
//      then Result := I;
      if Result>-1 then Break;
    end;{for}
    if Result>-1 then Break;
  end;{for}
end;{FindCourse}
procedure TDBSelectedObjects.DrawCourses;
var I,J: Integer;
begin
  if FCount=0 then Exit;
  glLineStipple(1,$F0F0);
  glEnable(GL_LINE_STIPPLE);
  glLineWidth(3.0);
  glSetColor(clYellow);
  for I := 0 to FCount-1 do
  begin
    glBegin(GL_LINES);
    for J := 1 to Courses[I].PointIndexesCount-1 do
    begin
      glVertex2f(Courses[I].LeftCoords[J-1].X,Courses[I].LeftCoords[J-1].Y);
      glVertex2f(Courses[I].LeftCoords[J].X,Courses[I].LeftCoords[J].Y);
      glVertex2f(Courses[I].RightCoords[J-1].X,Courses[I].RightCoords[J-1].Y);
      glVertex2f(Courses[I].RightCoords[J].X,Courses[I].RightCoords[J].Y);
    end;{for}
    glEnd;
  end;{for}
  glDisable(GL_LINE_STIPPLE);
end;{Draw}
//для пунктов погрузки
function TDBSelectedObjects.GetLoadingPunkt(Index: Integer): TDBLoadingPunkt;
var ACount: Integer;
begin
  if FSelectedKind in [skLoadingPunkts,skCrossRoads]
  then ACount := FCount else ACount := 0;
  if InRange(Index,0,ACount-1)
  then Result := Openpit.LoadingPunkts[FIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetLoadingPunkt}
function TDBSelectedObjects.FindLoadingPunkt(const APoint: RPoint3D): Integer;
var
  I: Integer;
  dX: Single;
  APoint0,APoint1,APoint2,APoint3: RPoint3D;
begin
  Result := -1;
  if not Openpit.LoadingPunkts.Visible then Exit;
  dX := DefaultParams.LoadingPunktRadius*Openpit.GraphKernel.MtrPerPxl;
  for I := 0 to Openpit.LoadingPunkts.Count-1 do
  begin
    APoint0 := Openpit.LoadingPunkts[I].Coords;
    APoint1 := APoint0; APoint2 := APoint0; APoint3 := APoint0;
    APoint0.X := APoint0.X-dX; APoint0.Y := APoint0.Y+dX;
    APoint1.X := APoint1.X+dX; APoint1.Y := APoint1.Y+dX;
    APoint2.X := APoint2.X+dX; APoint2.Y := APoint2.Y-dX;
    APoint3.X := APoint3.X-dX; APoint3.Y := APoint3.Y-dX;
    if PtInPgn(APoint,[APoint0,APoint1,APoint2,APoint3]) then
    begin
      Result := I; Break;
    end;{for}
    if Result>-1 then Break;
  end;{for}
end;{FindLoadingPunkt}
procedure TDBSelectedObjects.DrawLoadingPunkts;
var
  I: Integer;
  dX: Single;
begin
  if FCount=0 then Exit;
  glPushMatrix;
    dX := (DefaultParams.LoadingPunktRadius+2)*GraphKernel.MtrPerPxl;
    glSetColor(clYellow);
    for I := 0 to FCount-1 do
    with Openpit.LoadingPunkts[FIndexes[I]].Coords do
    begin
      glBegin(GL_LINE_LOOP);
        glVertex2f(X-dX,Y-dX);
        glVertex2f(X+dX,Y-dX);
        glVertex2f(X+dX,Y+dX);
        glVertex2f(X-dX,Y+dX);
      glEnd;
    end;{if}
  glPopMatrix;
end;{Draw}
procedure TDBSelectedObjects.LoadingPunktsEditorExecute;
var
  Form: TForm;
  ValueListEditor: TValueListEditor;
  btOk,btCancel: TButton;
  sId_DeportExcavator,sDeportExcavator: String;
  IsOk: Boolean;
  I,J,Result,ACount: Integer;
begin
  if FCount<>1 then Exit;
  if Openpit.Rocks.Count=0 then raise Exception.Create(Format(EEmptyDBTable,['Горные породы']));
  //Определяю значения полей StripCount,StripWidth,StripId_Openpit ----------------------------
  sId_DeportExcavator := ''; sDeportExcavator := '';
  //Создаю редактор ---------------------------------------------------------------------------
  CreateEditorForm(Form,600,240,ValueListEditor,'Пункты погрузки',btOk,btCancel);
  try
    //Заполняю параметры ValueListEditor-------------------------------------------------------
    with ValueListEditor do
    begin
      //Заношу параметры ValueListEditor "Экскаватор"
      if LoadingPunkts[0].Id_DeportExcavator>0
      then sId_DeportExcavator := IntToStr(LoadingPunkts[0].Id_DeportExcavator)
      else sId_DeportExcavator := '';
      Strings.Add('Экскаватор=');
      ItemProps['Экскаватор'].EditStyle := esPickList;
      ItemProps['Экскаватор'].ReadOnly := true;
      ItemProps['Экскаватор'].PickList.Add('');
      //Заношу еще не выбранные Экскаваторы
      for I := 0 to Openpit.Excavators.Count-1 do
      if Openpit.Excavators[I].WorkState then
      begin
        IsOk := true;
        for J := 0 to Openpit.LoadingPunkts.Count-1 do
          if Openpit.LoadingPunkts[J].Id_LoadingPunkt<>LoadingPunkts[0].Id_LoadingPunkt then
          begin
            IsOk := Openpit.LoadingPunkts[J].Id_DeportExcavator<>
                    Openpit.Excavators[I].Id_DeportExcavator;
            if not IsOk then Break;
          end;{for}
        if IsOk then ItemProps['Экскаватор'].PickList.Add(Openpit.Excavators[I].TotalName);
      end;{for}
      ColWidths[0] := 170;
    end;{with}
    //-----------------------------------------------------------------------------------------
    if FCount=1 then
    begin
      ValueListEditor.Values['Экскаватор'] := '';
      if sId_DeportExcavator<>''
      then I := Openpit.Excavators.IndexOf(StrToInt(sId_DeportExcavator))
      else I := -1;
      if (sId_DeportExcavator<>'')and(I>-1)
      then ValueListEditor.Values['Экскаватор'] := Openpit.Excavators[I].TotalName;
    end;{if}
    Result := Form.ShowModal;
    //заношу новые значения -------------------------------------------------------------------
    with ValueListEditor do
    if Result=mrOk then
    begin
      ACount := FCount;
      FCount := 0;
      sId_DeportExcavator := '';
      if (Values['Экскаватор']<>'')and(ACount=1)then
      begin
        I := Openpit.Excavators.IndexOf(Values['Экскаватор']);
        if I>-1 then
        begin
          sId_DeportExcavator := IntToStr(Openpit.Excavators[I].Id_DeportExcavator);
          sDeportExcavator := Openpit.Excavators[I].TotalName;
        end;{if}
      end;{if}
      Openpit.LoadingPunkts.SetTotalValues(sId_DeportExcavator,FIndexes);
      FCount := ACount;
      Invalidate;
      UpdateLength;
    end;{if}
  finally
    Form.Free;
  end;{try}
end;{EditorExecute}

//для пунктов разгрузки
function TDBSelectedObjects.GetUnLoadingPunkt(Index: Integer): TDBUnLoadingPunkt;
var ACount: Integer;
begin
  if FSelectedKind in [skUnLoadingPunkts,skCrossRoads]
  then ACount := FCount else ACount := 0;
  if InRange(Index,0,ACount-1)
  then Result := Openpit.UnLoadingPunkts[FIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetUnLoadingPunkt}
function TDBSelectedObjects.CheckUnLoadingPunktsEditorValues(const sMaxV1000m3, sAutoMaxCount: String): Boolean;
begin
  Result := CheckStrValue(sMaxV1000m3,'Емкость приемного бункера, тыс.м3',1.0,High(Integer),FCount>1)AND
            CheckStrValue(sAutoMaxCount,'Макс.количество автосамосвалов',1,50,FCount>1);
end;{CheckUnLoadingPunktsEditorValues}
function TDBSelectedObjects.FindUnLoadingPunkt(const APoint: RPoint3D): Integer;
var
  I: Integer;
  dX: Single;
  APoint0,APoint1,APoint2,APoint3: RPoint3D;
begin
  Result := -1;
  if not Openpit.UnLoadingPunkts.Visible then Exit;
  dX := DefaultParams.UnLoadingPunktRadius*Openpit.GraphKernel.MtrPerPxl;
  for I := 0 to Openpit.UnLoadingPunkts.Count-1 do
  begin
    APoint0 := Openpit.UnLoadingPunkts[I].Coords;
    APoint1 := APoint0; APoint2 := APoint0; APoint3 := APoint0;
    APoint0.X := APoint0.X-dX; APoint0.Y := APoint0.Y+dX;
    APoint1.X := APoint1.X+dX; APoint1.Y := APoint1.Y+dX;
    APoint2.X := APoint2.X+dX; APoint2.Y := APoint2.Y-dX;
    APoint3.X := APoint3.X-dX; APoint3.Y := APoint3.Y-dX;
    if PtInPgn(APoint,[APoint0,APoint1,APoint2,APoint3]) then
    begin
      Result := I; Break;
    end;{for}
    if Result>-1 then Break;
  end;{for}
end;{FindUnLoadingPunkt}
procedure TDBSelectedObjects.DrawUnLoadingPunkts;
var
  I: Integer;
  dX: Single;
begin
  if FCount=0 then Exit;
  glPushMatrix;
    dX := (DefaultParams.UnLoadingPunktRadius+2)*GraphKernel.MtrPerPxl;
    glSetColor(clYellow);
    for I := 0 to FCount-1 do
    with Openpit.UnLoadingPunkts[FIndexes[I]].Coords do
    begin
      glBegin(GL_LINE_LOOP);
        glVertex2f(X-dX,Y-dX);
        glVertex2f(X+dX,Y-dX);
        glVertex2f(X+dX,Y+dX);
        glVertex2f(X-dX,Y+dX);
      glEnd;
    end;{if}
  glPopMatrix;
end;{Draw}
procedure TDBSelectedObjects.UnLoadingPunktsEditorExecute;
const
  cMaxV1000m3  ='Емкость приемного бункера, тыс.м3';
  cAutoMaxCount='Макс.количество автосамосвалов';
  cKind        ='Тип пункта разгрузки';
var
  Form: TForm;
  ValueListEditor: TValueListEditor;
  btOk,btCancel: TButton;
  sAutoMaxCount,sMaxV1000m3,sKind: String;
  IsOk: Boolean;
  I,Result,ACount: Integer;
begin
  if FCount=0 then Exit;
  //Определяю значения полей StripCount,StripWidth,StripId_Openpit ----------------------------
  sAutoMaxCount := IntToStr(UnLoadingPunkts[0].AutoMaxCount);
  sMaxV1000m3 := FormatFloat('0.0',UnLoadingPunkts[0].MaxV1000m3);
  sKind := IntToStr(Integer(UnLoadingPunkts[0].Kind));
  for I := 0 to FCount-1 do
  begin
    if IntToStr(UnLoadingPunkts[I].AutoMaxCount)<>sAutoMaxCount then sAutoMaxCount := '';
    if FormatFloat('0.0',UnLoadingPunkts[I].MaxV1000m3)<>sMaxV1000m3 then sMaxV1000m3 := '';
    if IntToStr(Integer(UnLoadingPunkts[I].Kind))<>sKind then sKind := '';
  end;{if}
  //Создаю редактор ---------------------------------------------------------------------------
  CreateEditorForm(Form,600,240,ValueListEditor,'Пункты разгрузки',btOk,btCancel);
  try
    //Заполняю параметры ValueListEditor-------------------------------------------------------
    with ValueListEditor do
    begin
      //Заношу общие параметры ValueListEditor
      Strings.Text := cAutoMaxCount+'='+CR+cMaxV1000m3+'='+CR+cKind+'=';                             
      //Заношу параметры ValueListEditor "Тип пункта разгрузки"
      with ItemProps[cKind] do
      begin
        PickList.Text := ''+CR+'Фабрика'+CR+'Перегрузочный склад'+CR+'Отвал';
        EditStyle := esPickList;
        ReadOnly := true;
      end;{with}
      ColWidths[0] := 250;
    end;{with}
    //-----------------------------------------------------------------------------------------
    with ValueListEditor do
    repeat
      Values[cAutoMaxCount] := sAutoMaxCount;
      Values[cMaxV1000m3]     := sMaxV1000m3;
      if sKind<>''
      then Values[cKind] := ItemProps[cKind].PickList.Strings[StrToInt(sKind)+1]
      else Values[cKind] := sKind;
      Result := Form.ShowModal;
      IsOk := (Result<>mrOk)OR((Result=mrOk)and
              (CheckUnLoadingPunktsEditorValues(Values[cMaxV1000m3],Values[cAutoMaxCount])));
    until IsOk;
    //заношу новые значения -------------------------------------------------------------------
    with ValueListEditor do
    if IsOk and (Result=mrOk) then
    begin
      ACount := FCount;
      FCount := 0;
      sMaxV1000m3    := Values[cMaxV1000m3];
      sAutoMaxCount:= Values[cAutoMaxCount];
      sKind        := Values[cKind];
      if sKind<>''
      then sKind := IntToStr(ItemProps[cKind].PickList.IndexOf(sKind)-1);
      Openpit.UnLoadingPunkts.SetTotalValues(sMaxV1000m3,sAutoMaxCount,sKind,FIndexes);
      FCount := ACount;
      Invalidate;
      UpdateLength;
    end;{if}
  finally
    Form.Free;
  end;{try}
end;{EditorExecute}

//для пунктов пересменки
function TDBSelectedObjects.GetShiftPunkt(Index: Integer): TDBShiftPunkt;
var ACount: Integer;
begin
  if FSelectedKind in [skShiftPunkts,skCrossRoads]
  then ACount := FCount else ACount := 0;
  if InRange(Index,0,ACount-1)
  then Result := Openpit.ShiftPunkts[FIndexes[Index]]
  else raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetShiftPunkt}
function TDBSelectedObjects.FindShiftPunkt(const APoint: RPoint3D): Integer;
var
  I: Integer;
  dX: Single;
  APoint0,APoint1,APoint2,APoint3: RPoint3D;
begin
  Result := -1;
  if not Openpit.ShiftPunkts.Visible then Exit;
  dX := DefaultParams.ShiftPunktRadius*GraphKernel.MtrPerPxl;
  for I := 0 to Openpit.ShiftPunkts.Count-1 do
  begin
    APoint0 := Openpit.ShiftPunkts[I].Coords;
    APoint1 := APoint0; APoint2 := APoint0; APoint3 := APoint0;
    APoint0.X := APoint0.X-dX; APoint0.Y := APoint0.Y+dX;
    APoint1.X := APoint1.X+dX; APoint1.Y := APoint1.Y+dX;
    APoint2.X := APoint2.X+dX; APoint2.Y := APoint2.Y-dX;
    APoint3.X := APoint3.X-dX; APoint3.Y := APoint3.Y-dX;
    if PtInPgn(APoint,[APoint0,APoint1,APoint2,APoint3]) then
    begin
      Result := I; Break;
    end;{for}
    if Result>-1 then Break;
  end;{for}
end;{FindShiftPunkt}
procedure TDBSelectedObjects.DrawShiftPunkts;
var
  I: Integer;
  dX: Single;
begin
  if FCount=0 then Exit;
  glPushMatrix;
    dX := (DefaultParams.ShiftPunktRadius+2)*GraphKernel.MtrPerPxl;
    glSetColor(clYellow);
    for I := 0 to FCount-1 do
    with Openpit.ShiftPunkts[FIndexes[I]].Coords do
    begin
      glBegin(GL_LINE_LOOP);
        glVertex2f(X-dX,Y-dX);
        glVertex2f(X+dX,Y-dX);
        glVertex2f(X+dX,Y+dX);
        glVertex2f(X-dX,Y+dX);
      glEnd;
    end;{if}
  glPopMatrix;
end;{Draw}

constructor TDBSelectedObjects.Create(AOpenpit: TDBOpenpit);
begin
  inherited;
  FColor := clYellow;
  FSelectedKind := skPoints;
  Clear;
end;{Create}
destructor TDBSelectedObjects.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDBSelectedObjects.Draw;
begin
  if FCount>0 then 
  case FSelectedKind of
    skPoints,skBlockPoints,skCrossRoadPoints,skCoursePoints: DrawPoints;
    skBlocks,skCrossRoads,skCourseBlocks                   : DrawBlocks;
    skCourses                                              : DrawCourses;
    skLoadingPunkts                                        : DrawLoadingPunkts;
    skUnLoadingPunkts                                      : DrawUnLoadingPunkts;
    skShiftPunkts                                          : DrawShiftPunkts;
  end;{case}
end;{Draw}

procedure TDBSelectedObjects.Add(const Item: Integer);
var Result,ACount: Integer;
begin
  case FSelectedKind of
    skPoints,skBlockPoints,
    skCrossRoadPoints,skCoursePoints    : ACount := Openpit.Points.Count;
    skBlocks,skCrossRoads,skCourseBlocks: ACount := Openpit.Blocks.Count;
    skCourses                           : ACount := Openpit.Courses.Count;
    skLoadingPunkts                     : ACount := Openpit.LoadingPunkts.Count;
    skUnLoadingPunkts                   : ACount := Openpit.UnLoadingPunkts.Count;
    skShiftPunkts                       : ACount := Openpit.ShiftPunkts.Count;
  else ACount := 0;
  end;{case}
  Result := IndexOf(Item);
  if Result=-1 then//если индекса такой точки еще нет в списке
  begin
    if InRange(Item,0,ACount-1) then
    begin
      if (FSelectedKind=skCrossRoadPoints)AND(FCount>=2)
      then FCount := 0;
      if (FSelectedKind=skCoursePoints)AND(FCount>=2)
      then FCount := 0;
      Inc(FCount);
      SetLength(FIndexes,FCount);
      FIndexes[FCount-1] := Item;
      UpdateLength;
      Invalidate;
    end;{if}
  end{if}
  else Delete(Result);
end;{Add}
procedure TDBSelectedObjects.Clear;
begin
  FIndexes := nil;
  FCount := 0;
  UpdateLength;
  Invalidate;
end;{Clear}
procedure TDBSelectedObjects.Delete(const Index: Integer);
var I: Integer;
begin
  if InRange(Index,0,FCount-1)then
  begin
    for I := Index+1 to FCount-1 do
      FIndexes[I-1] := FIndexes[I];
    Dec(FCount);
    SetLength(FIndexes,FCount);
    UpdateLength;
    Invalidate;
  end;{if}
end;{Delete}
function TDBSelectedObjects.IndexOf(const Item: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FIndexes[I]=Item then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TDBSelectedObjects.AddSelectedObjectsTo(const AX,AY: Single);
var APoint: RDBPoint;
begin
  if FCount=0 then Exit;
  case FSelectedKind of
    skPoints:
      if FCount=1 then
      begin
        APoint := Openpit.Points[FIndexes[0]];
        APoint.Coords.X := AX;
        APoint.Coords.Y := AY;
        Openpit.Points[FIndexes[0]] := APoint;
      end;{if}
    skLoadingPunkts:
      if FCount=1 then
      begin                      
        APoint := Openpit.Points[Openpit.LoadingPunkts[FIndexes[0]].PointInd];
        APoint.Coords.X := AX;
        APoint.Coords.Y := AY;
        Openpit.Points[Openpit.LoadingPunkts[FIndexes[0]].PointInd] := APoint;
      end;{if}
    skUnLoadingPunkts:
      if FCount=1 then
      begin                      
        APoint := Openpit.Points[Openpit.UnLoadingPunkts[FIndexes[0]].PointInd];
        APoint.Coords.X := AX;
        APoint.Coords.Y := AY;
        Openpit.Points[Openpit.UnLoadingPunkts[FIndexes[0]].PointInd] := APoint;
      end;{if}
    skShiftPunkts:
      if FCount=1 then
      begin                      
        APoint := Openpit.Points[Openpit.ShiftPunkts[FIndexes[0]].PointInd];
        APoint.Coords.X := AX;
        APoint.Coords.Y := AY;
        Openpit.Points[Openpit.ShiftPunkts[FIndexes[0]].PointInd] := APoint;
      end;{if}
    skBlockPoints: begin
      Openpit.Blocks.Add(FIndexes,false);
      Clear;
    end;
    skCrossRoadPoints:
    begin
      Openpit.Blocks.Add(FIndexes,true);
      Clear;
    end;
    skCoursePoints:
      if FCount=2 then
      begin
        Openpit.Courses.Add(Points[0].Id_Point,Points[1].Id_Point);
        Clear;
      end;{if}
    skCourseBlocks:
      if FCount>0 then
      begin
        Openpit.Courses.Add(FIndexes);
        Clear;
      end;{if}
  end;{case}
end;{AddSelectedObjectsTo}
procedure TDBSelectedObjects.DeleteSelectedObjects;
var 
  ACount  : Integer;
  Result  : Boolean; 
begin
  if FCount>0 then
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  begin
    ACount := FCount;
    FCount := 0;
    Result := false;
    case FSelectedKind of
      skPoints         : Result := Openpit.Points.Delete(FIndexes);
      skBlocks         : Result := Openpit.Blocks.Delete(FIndexes);
      skCourses        : Result := Openpit.Courses.Delete(FIndexes);
      skLoadingPunkts  : Result := Openpit.LoadingPunkts.Delete(FIndexes);
      skUnLoadingPunkts: Result := Openpit.UnLoadingPunkts.Delete(FIndexes);
      skShiftPunkts    : Result := Openpit.ShiftPunkts.Delete(FIndexes);
    end;{case}
    if Result then FIndexes := nil else FCount := ACount;
    UpdateLength;
    Invalidate;
  end;{if}
end;{DeleteAllObjects}
procedure TDBSelectedObjects.EditorExecute;
begin
  case FSelectedKind of
    skPoints             : PointsEditorExecute;
    skBlocks,skCrossRoads: BlocksEditorExecute;
    skLoadingPunkts      : LoadingPunktsEditorExecute;
    skUnLoadingPunkts    : UnLoadingPunktsEditorExecute;
  end;{case}
end;{EditorExecute}
procedure TDBSelectedObjects.Select(const pxlPoint: TPoint; const Shift: TShiftState);
var
  APointIndex,ABlockIndex,ACourseIndex,ALoadingPunktIndex,
  AUnLoadingPunktIndex,AShiftPunktIndex: Integer;
  APoint: RPoint3D;
  AMtrPerPxl: Single;//Кол-во метров в одном пикселе
  AIndex: Integer;
begin
  with Openpit do
  begin
    if not((GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0))then Exit;
    AMtrPerPxl := GraphKernel.MtrPerPxl;
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    APointIndex := FindPoint(APoint,DefaultParams.PointRadius*AMtrPerPxl);
    if APointIndex=-1 then ABlockIndex := FindBlock(APoint) else ABlockIndex := -1;
    if (APointIndex=-1)and(ABlockIndex=-1)
    then ALoadingPunktIndex := FindLoadingPunkt(APoint) else ALoadingPunktIndex := -1;
    if (APointIndex=-1)and(ABlockIndex=-1)and(ALoadingPunktIndex=-1)
    then AUnLoadingPunktIndex := FindUnLoadingPunkt(APoint) else AUnLoadingPunktIndex := -1;
    if (APointIndex=-1)and(ABlockIndex=-1)and
       (ALoadingPunktIndex=-1)and(AUnLoadingPunktIndex=-1)
    then AShiftPunktIndex := FindShiftPunkt(APoint) else AShiftPunktIndex := -1;
    if (APointIndex=-1)and(ABlockIndex=-1)and(ALoadingPunktIndex=-1)and
       (AUnLoadingPunktIndex=-1)and(AShiftPunktIndex=-1)
    then ACourseIndex := FindCourse(APoint) else ACourseIndex := -1;
    if (APointIndex>-1)XOR(ABlockIndex>-1)XOR(ALoadingPunktIndex>-1)XOR
       (AUnLoadingPunktIndex>-1)XOR(AShiftPunktIndex>-1)XOR(ACourseIndex>-1)then
    begin
      if APointIndex>-1 then
      begin
        if not(FSelectedKind in [skPoints,skBlockPoints,skCrossRoadPoints])
        then SelectedKind := skPoints;
        AIndex := IndexOf(APointIndex);
        if Shift<>[ssCtrl]then
        begin //если одиночное выделение
          Clear; Add(APointIndex);
        end{if}
        else//если групповое выделение
          if AIndex=-1 then Add(APointIndex)else Delete(AIndex);
      end;{if}
      if ABlockIndex>-1 then
      begin
        if not(FSelectedKind in [skBlocks,skCrossRoads])
        then SelectedKind := skBlocks;
        AIndex := IndexOf(ABlockIndex);
        if Shift<>[ssCtrl]then
        begin //если одиночное выделение
          Clear; Add(ABlockIndex);
        end{if}
        else//если групповое выделение
          if AIndex=-1 then Add(ABlockIndex)else Delete(AIndex);
      end;{if}
      if ALoadingPunktIndex>-1 then
      begin
        if not(FSelectedKind in [skLoadingPunkts])
        then SelectedKind := skLoadingPunkts;
        AIndex := IndexOf(ALoadingPunktIndex);
        if Shift<>[ssCtrl]then
        begin //если одиночное выделение
          Clear; Add(ALoadingPunktIndex);
        end{if}
        else//если групповое выделение
          if AIndex=-1 then Add(ALoadingPunktIndex)else Delete(AIndex);
      end;{if}
      if AUnLoadingPunktIndex>-1 then
      begin
        if not(FSelectedKind in [skUnLoadingPunkts])
        then SelectedKind := skUnLoadingPunkts;
        AIndex := IndexOf(AUnLoadingPunktIndex);
        if Shift<>[ssCtrl]then
        begin //если одиночное выделение
          Clear; Add(AUnLoadingPunktIndex);
        end{if}
        else//если групповое выделение
          if AIndex=-1 then Add(AUnLoadingPunktIndex)else Delete(AIndex);
      end;{if}
      if AShiftPunktIndex>-1 then
      begin
        if not(FSelectedKind in [skShiftPunkts])
        then SelectedKind := skShiftPunkts;
        AIndex := IndexOf(AShiftPunktIndex);
        if Shift<>[ssCtrl]then
        begin //если одиночное выделение
          Clear; Add(AShiftPunktIndex);
        end{if}
        else//если групповое выделение
          if AIndex=-1 then Add(AShiftPunktIndex)else Delete(AIndex);
      end;{if}
      if ACourseIndex>-1 then
      begin
        if not(FSelectedKind in [skCourses])
        then SelectedKind := skCourses;
        AIndex := IndexOf(ACourseIndex);
        if Shift<>[ssCtrl]then
        begin //если одиночное выделение
          Clear; Add(ACourseIndex);
        end{if}
        else//если групповое выделение
          if AIndex=-1 then Add(ACourseIndex)else Delete(AIndex);
      end;{if}
    end{if}
    else Clear;
  end;{with}
end;{Select}
procedure TDBSelectedObjects.SelectAll;
var I: Integer;
begin
  Clear;
  case SelectedKind of
    skPoints,skBlockPoints,skCrossRoadPoints:
      for I := 0 to Openpit.Points.Count-1 do
        Add(I);
    skBlocks,skCrossRoads:
      for I := 0 to Openpit.Blocks.Count-1 do
        Add(I);
    skCourses:
      for I := 0 to Openpit.Courses.Count-1 do
        Add(I);
    skLoadingPunkts:
      for I := 0 to Openpit.LoadingPunkts.Count-1 do
        Add(I);
    skUnLoadingPunkts:
      for I := 0 to Openpit.UnLoadingPunkts.Count-1 do
        Add(I);
    skShiftPunkts:
      for I := 0 to Openpit.ShiftPunkts.Count-1 do
        Add(I);
  end;{case}
end;{SelectAll}

function TDBSelectedObjects.InterpolationDlg(var AZ0,AZ1: Single): Boolean;
var
  Res  : Integer;
  fmInterpolation: TForm;
  ledFrom,ledTo  : TLabeledEdit;
  IsOk           : Boolean;
  btOk,btCancel  : TButton;
  Z0,Z1: Single;
begin
  Result := false;
  Z0 := AZ0;
  Z1 := AZ1;
  fmInterpolation := TForm.Create(nil);
  try
    with fmInterpolation do
    begin
      BorderIcons := BorderIcons+[biHelp];
      BorderStyle := bsDialog;
      Width := 288; Height := 168;
      Caption := 'Интерполяция высот';
      Position := poScreenCenter;
    end;{with}
    ledFrom := TLabeledEdit.Create(fmInterpolation);
    with ledFrom do
    begin
      Parent := fmInterpolation; EditLabel.Caption := 'Начальная высота, м';
      LabelPosition := lpLeft; LabelSpacing := 8; Left := 136; Top := 24;
      Text := FormatFloat('0.000',AZ0);
    end;{with}
    ledTo := TLabeledEdit.Create(fmInterpolation);
    with ledTo do
    begin
      Parent := fmInterpolation; EditLabel.Caption := 'Конечная высота, м  ';
      LabelPosition := lpLeft; LabelSpacing := 8; Left := 136; Top := 64;
      Text := FormatFloat('0.000',AZ1);
    end;{with}
    btOk := TButton.Create(fmInterpolation);
    with btOk do
    begin
      Parent := fmInterpolation;
      Left := 56; Top := 104; Caption := 'Ok'; Default := true; ModalResult := mrOk;
    end;{with}
    btCancel := TButton.Create(fmInterpolation);
    with btCancel do
    begin
      Parent := fmInterpolation;
      Left := 148; Top := 104; Caption := 'Отмена'; Cancel := true; ModalResult := mrCancel;
    end;{with}
    repeat
      IsOk := true;
      ledFrom.Text := FormatFloat('0.###',AZ0); ledTo.Text   := FormatFloat('0.###',AZ1);
      Res := fmInterpolation.ShowModal;
      if Res=mrOk then
      begin
        try
          Z0 := StrToFloat(ledFrom.Text);
        except
          IsOk := false;
          esaMsgError(Format(EInvalidSingleValue,[ledFrom.Text,ledFrom.EditLabel.Caption]));
        end;{try}
        try
          Z1 := StrToFloat(ledTo.Text);
        except
          IsOk := false;
          esaMsgError(Format(EInvalidSingleValue,[ledTo.Text,ledTo.EditLabel.Caption]));
        end;{try}
        if IsOk then
        begin
          Result := true;
          AZ0 := Z0; AZ1 := Z1;
        end;{if}
      end;{if}
    until IsOk or (Res<>mrOk);
  finally
    fmInterpolation.Free;
  end;{try}
end;{InterpolationDlg}
procedure TDBSelectedObjects.InterpolationPoints;
var Z0,Z1: Single;
begin
  if (SelectedKind<>skPoints)OR(Count<2) then Exit;
  Z0 := Points[0].Coords.Z;
  Z1 := Points[Count-1].Coords.Z;
  if InterpolationDlg(Z0,Z1) then
  begin
    Openpit.Points.Interpolation(FIndexes,Z0,Z1);
    UpdateLength;
    Invalidate;
  end;{if}
end;{InterpolationPoints}
procedure TDBSelectedObjects.InterpolationBlocks;
var Z0,Z1: Single;
begin
  if (SelectedKind<>skBlocks)OR(Count<>1) then Exit;
  Z0 := Blocks[0].Points[0].Coords.Z;
  Z1 := Blocks[0].Points[Blocks[0].Count-1].Coords.Z;
  if InterpolationDlg(Z0,Z1) then
  begin
    Openpit.Points.Interpolation(Blocks[0].FPointIndexes,Z0,Z1);
    Blocks[0].UpdateLength;
    Invalidate;
  end;{if}
end;{InterpolationBlocks}
function TDBSelectedObjects.SelectPoints(const pxlPoint: TPoint;
                                         const Shift: TShiftState): Integer;
var
  APoint: RPoint3D;
  AMtrPerPxl: Single;//Кол-во метров в одном пикселе
  AIndex: Integer;
begin
  Result := -1;
  if not Openpit.Points.Visible then Exit;
  if not(SelectedKind in [skPoints,skBlockPoints,skCrossRoadPoints,skCoursePoints])
  then SelectedKind := skPoints;
  with Openpit do
  if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
  begin
    AMtrPerPxl := GraphKernel.MtrPerPxl;
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    Result := FindPoint(APoint,10*AMtrPerPxl);
    if Result>-1 then //если выделяю точку
    begin
      if ssCtrl in Shift then//если групповое выделение
      begin
        AIndex := IndexOf(Result);
        if AIndex=-1 then Add(Result) else Delete(AIndex);
      end{if}
      else//если одиночное выделение
      begin
        Clear; Add(Result);
      end;{else}
    end{if}
    else Clear;
  end;{if}
end;{SelectPoints}
//для блок-участков
function TDBSelectedObjects.SelectBlocks(const pxlPoint: TPoint;
                                         const Shift: TShiftState): Integer;
var
  APoint: RPoint3D;
  AIndex: Integer;
begin
  Result := -1;
  if not Openpit.Blocks.Visible then Exit;
  if not(SelectedKind in [skBlocks,skCrossRoads,skCourseBlocks])
  then SelectedKind := skBlocks;
  with Openpit do
  if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
  begin
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    Result := FindBlock(APoint);
    if Result>-1 then //если выделяю точку
    begin
      if ssCtrl in Shift then//если групповое выделение
      begin
        AIndex := IndexOf(Result);
        if AIndex=-1 then 
        begin
          if FCount>0 then
          begin
            if (FSelectedKind=skCrossRoads)and(Blocks[AIndex].Kind<>bukCrossRoad)
            then SelectedKind := skBlocks;
            if (FSelectedKind<>skCrossRoads)and(FSelectedKind<>skCourseBlocks)and(Blocks[AIndex].Kind=bukCrossRoad)
            then SelectedKind := skCrossRoads;
          end;{else}
          Add(Result);
        end{if}
        else Delete(AIndex);
      end{if}
      else//если одиночное выделение
      begin
        Clear; Add(Result);
      end;{else}
    end{if}
    else Clear;
  end;{if}
end;{SelectBlocks}
//для маршрутов
function TDBSelectedObjects.SelectCourses(const pxlPoint: TPoint;
                                          const Shift: TShiftState): Integer;
var
  APoint: RPoint3D;
  AIndex: Integer;
begin
  Result := -1;
  if not Openpit.Courses.Visible then Exit;
  if not(SelectedKind in [skCourses])
  then SelectedKind := skCourses;
  with Openpit do
  if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
  begin
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    Result := FindCourse(APoint);
    if Result>-1 then //если выделяю точку
    begin
      if ssCtrl in Shift then//если групповое выделение
      begin
        AIndex := IndexOf(Result);
        if AIndex=-1 then Add(Result) else Delete(AIndex);
      end{if}
      else//если одиночное выделение
      begin
        Clear; Add(Result);
      end;{else}
    end{if}
    else Clear;
  end;{if}
end;{SelectCourses}
//Выделение маршрутов
function TDBSelectedObjects.SelectCourses(): Boolean;
var
  I         : Integer;
  fmCourses : TForm;
  clbCourses: TCheckListBox;
  Z0,Z1,Lm  : Single;
begin
  Result := False;
  fmCourses := TForm.Create(nil);
  try
    fmCourses.Caption     := 'Маршруты';
    fmCourses.Width       := 600;
    fmCourses.Height      := 400;
    fmCourses.BorderStyle := bsDialog;
    fmCourses.Position    := poScreenCenter;
    clbCourses            := TCheckListBox.Create(fmCourses);
    clbCourses.Parent     := fmCourses;
    clbCourses.Align      := alTop;
    clbCourses.Height     := 332;
    SelectedKind          := skCourses;
    for I := 0 to Openpit.Courses.Count-1 do
    begin
      Z0 := Openpit.Courses[I].CenterCoords[0].Z;                                                
      Z1 := Openpit.Courses[I].CenterCoords[Openpit.Courses[I].PointIndexesCount-1].Z;                                                
      Lm := Openpit.Courses[I].CourseLength;                                                
      case Openpit.Courses[I].Kind of
        ckCourseTo    : clbCourses.Items.Add(Format('%s(гор.%.2f) - %s(гор.%.2f), Длина: %.2fм',['Пункт пересменки',Z0,'Пункт погрузки',Z1,Lm]));
        ckCourseFrom  : clbCourses.Items.Add(Format('%s(гор.%.2f) - %s(гор.%.2f), Длина: %.2fм',['Пункт разгрузки',Z0,'Пункт пересменки',Z1,Lm]));
        else            clbCourses.Items.Add(Format('%s(гор.%.2f) - %s(гор.%.2f), Длина: %.2fм',['Пункт погрузки',Z0,'Пункт разгрузки',Z1,Lm]));
      end;{case}
      clbCourses.Checked[I] := IndexOf(I)>-1;
    end;{for}
    with TButton.Create(fmCourses) do
    begin
      Parent      := fmCourses;
      Top         := 344;
      Left        := 416;
      Width       := 72;
      Caption     := 'Ok';
      ModalResult := mrOk;
      Default     := True;
      Enabled     := clbCourses.Items.Count>0;
    end;{with}
    with TButton.Create(fmCourses) do
    begin
      Parent      := fmCourses;
      Top         := 344;
      Left        := 504;
      Width       := 72;
      Caption     := 'Отмена';
      ModalResult := mrCancel;
      Cancel      := True;
    end;{with}
    if fmCourses.ShowModal=mrOk then
    begin
      Clear;
      FSelectedKind := skCourses;
      for I := 0 to clbCourses.Items.Count-1 do
      if clbCourses.Checked[I] then Add(I);
    end;{if}
  finally
    fmCourses.Free;
  end;{try}
end;{SelectCourses}
//для пунктов погрузки
function TDBSelectedObjects.SelectLoadingPunkts(const pxlPoint: TPoint;
                                                const Shift: TShiftState): Integer;
var
  APoint: RPoint3D;
  AIndex: Integer;
begin
  Result := -1;
  if not Openpit.LoadingPunkts.Visible then Exit;
  if not(SelectedKind in [skLoadingPunkts])
  then SelectedKind := skLoadingPunkts;
  with Openpit do
  if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
  begin
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    Result := FindLoadingPunkt(APoint);
    if Result>-1 then //если выделяю точку
    begin
      if ssCtrl in Shift then//если групповое выделение
      begin
        AIndex := IndexOf(Result);
        if AIndex=-1 then Add(Result) else Delete(AIndex);
      end{if}
      else//если одиночное выделение
      begin
        Clear; Add(Result);
      end;{else}
    end{if}
    else Clear;
  end;{if}
end;{SelectLoadingPunkts}
//для пунктов разгрузки
function TDBSelectedObjects.SelectUnLoadingPunkts(const pxlPoint: TPoint;
                                                  const Shift: TShiftState): Integer;
var
  APoint: RPoint3D;
  AIndex: Integer;
begin
  Result := -1;
  if not Openpit.UnLoadingPunkts.Visible then Exit;
  if not(SelectedKind in [skUnLoadingPunkts])
  then SelectedKind := skUnLoadingPunkts;
  with Openpit do
  if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
  begin
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    Result := FindUnLoadingPunkt(APoint);
    if Result>-1 then //если выделяю точку
    begin
      if ssCtrl in Shift then//если групповое выделение
      begin
        AIndex := IndexOf(Result);
        if AIndex=-1 then Add(Result) else Delete(AIndex);
      end{if}
      else//если одиночное выделение
      begin
        Clear; Add(Result);
      end;{else}
    end{if}
    else Clear;
  end;{if}
end;{SelectUnLoadingPunkts}
//для пунктов пересменки
function TDBSelectedObjects.SelectShiftPunkts(const pxlPoint: TPoint;
                                              const Shift: TShiftState): Integer;
var
  APoint: RPoint3D;
  AIndex: Integer;
begin
  Result := -1;
  if not Openpit.ShiftPunkts.Visible then Exit;
  if not(SelectedKind in [skShiftPunkts])
  then SelectedKind := skShiftPunkts;
  with Openpit do
  if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
  begin
    APoint := GraphKernel.PointPxlToMtr(pxlPoint);
    Result := FindShiftPunkt(APoint);
    if Result>-1 then //если выделяю точку
    begin
      if ssCtrl in Shift then//если групповое выделение
      begin
        AIndex := IndexOf(Result);
        if AIndex=-1 then Add(Result) else Delete(AIndex);
      end{if}
      else//если одиночное выделение
      begin
        Clear; Add(Result);
      end;{else}
    end{if}
    else Clear;
  end;{if}
end;{SelectShiftPunkts}

function TDBSelectedObjects.VisibleEditorExecute: Boolean;
var
  Form: TForm;
  CheckListBox: TCheckListBox;
  btOk,btCancel: TButton;
begin
  Result := false;
  Form := TForm.Create(nil);
  try
    with Form do
    begin
      BorderStyle := bsDialog; Width := 240; Height := 240;
      Position := poScreenCenter; Caption := 'Видимость элементов карьера';
    end;{with}
    CheckListBox := TCheckListBox.Create(Form);
    with CheckListBox do
    begin
      Parent := Form; Align := alTop; Height := 168;
      Items.Text := 'Характерные точки'+CR+'Блок-участки'+CR+'Маршруты движения'+CR+
                    'Пункты погрузки'+CR+'Пункты разгрузки'+CR+'Пункты пересменки';
      Checked[0] := Openpit.Points.Visible;
      Checked[1] := Openpit.Blocks.Visible;
      Checked[2] := Openpit.Courses.Visible;
      Checked[3] := Openpit.LoadingPunkts.Visible;
      Checked[4] := Openpit.UnLoadingPunkts.Visible;
      Checked[5] := Openpit.ShiftPunkts.Visible;
      ItemIndex := 0;
    end;{with}
    Form.ActiveControl := CheckListBox;
    btOk := TButton.Create(Form);
    with btOk do
    begin
      Parent := Form; Caption := 'Ok'; Top := 180; Left := 40; ModalResult := mrOk;
      Default := true;
    end;{with}
    btCancel := TButton.Create(Form);
    with btCancel do
    begin
      Parent := Form; Caption := 'Отмена'; Top := 180; Left := 124; ModalResult := mrCancel;
      Cancel := true;
    end;{with}
    if Form.ShowModal=mrOk then
    begin
      Result := true;
      Openpit.Points.Visible := CheckListBox.Checked[0];
      Openpit.Blocks.Visible := CheckListBox.Checked[1];
      Openpit.Courses.Visible := CheckListBox.Checked[2];
      Openpit.LoadingPunkts.Visible := CheckListBox.Checked[3];
      Openpit.UnLoadingPunkts.Visible := CheckListBox.Checked[4];
      Openpit.ShiftPunkts.Visible := CheckListBox.Checked[5];
    end;{if}
  finally
    Form.Free;
  end;{try}
end;{VisibleEditorExecute}

end.
