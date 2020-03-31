unit esaModelingResults;

interface
uses Globals, Classes, ADODb, SysUtils, GLObjects, GLGeomObjects, GLTexture,
     GLScene, StdCtrls, ComCtrls, GLSpaceText,
     TXTWriter;
type
  PGLPolygon=^TGLPolygon;
  //Запись списка данных моделирования
  RResultItem=record
    ResultItemIndex: Integer;//Уникальный индекс
    dTsec          : Integer;//Текущее время моделирования, сек
    StrippingCoef  : Single; //Текущий коэффициент вскрыши, т/т
  end;{RResultItem}
  PResultItem=^RResultItem;
  //Запись данных по автосамосвалам
  RResultAuto=record
    ResultItemIndex: Integer;       //Уникальный индекс
    AutoIndex      : Byte;          //Уникальный индекс автосамосвала
    IndentPosition : RPoint3D;      //Текущее положение
    Direction      : TAutoDirection;//Направление движения
    State          : TAutoState;    //Состояние
    ZenitAngle     : Single;        //Зенит, C
    AzimutAngle    : Single;        //Азимут, C
    Vkmh           : Single;        //Текущая скорость движения, км/ч
    W              : Single;        //Текущее значение Полного сопротивления движению, kН
  end;{RResultAuto}
  PResultAuto=^RResultAuto;
  //Пункт погрузки
  RResultLoadingPunkt=record
    ResultItemIndex  : Integer;                    //Уникальный индекс
    LoadingPunktIndex: Byte;                       //Уникальный индекс пункта погрузки
    State            : TPunktState;                //Состояние пункта погрузки
  end;{RResultLoadingPunkt}
  PResultLoadingPunkt=^RResultLoadingPunkt;
  //Добываемая ГМ пункта погрузки
  RResultLoadingPunktRock=record
    ResultItemIndex      : Integer;                    //Уникальный индекс
    LoadingPunktIndex    : Byte;                       //Уникальный индекс пункта погрузки
    LoadingPunktRockIndex: Byte;                       //Уникальный индекс добываемой ГМ
    RockV1000m3          : Single;                     //Объем погруженной ГМ, тыс.м3
    RockQ1000tn          : Single;                     //Масса погруженной ГМ, тыс.т
  end;{RResultLoadingPunktRock}
  PResultLoadingPunktRock=^RResultLoadingPunktRock;
  //Пункт разгрузки
  RResultUnloadingPunkt=record
    ResultItemIndex    : Integer;                    //Уникальный индекс
    UnloadingPunktIndex: Byte;                       //Уникальный индекс пункта разгрузки
    State              : TPunktState;                //Состояние пункта разгрузки
  end;{RResultUnloadingPunkt}
  PResultUnloadingPunkt=^RResultUnloadingPunkt;
  //Разгружаемая ГМ пункта разгрузки
  RResultUnloadingPunktRock=record
    UnloadingPunktRockIndex: Byte;                   //Индекс пункта разгрузки
    UnloadingPunktIndex    : Byte;                   //Уникальный индекс пункта разгрузки
    ResultItemIndex        : Integer;                //Уникальный индекс
    RockV1000m3            : Single;                 //Объем разгруженной ГМ, тыс.м3
    RockQ1000tn            : Single;                 //Масса разгруженной ГМ, тыс.т
    Content                : Single;                 //Текущее содержание, %
  end;{RResultUnloadingPunktRock}
  PResultUnloadingPunktRock=^RResultUnloadingPunktRock;
  //
  TResultOpenpit3D = class;
  //1.Объект карьера --------------------------------------------------------------------------
  TResultOpenpitObject3D=class
  private
    FOwner: TResultOpenpit3D;
  public
    property Openpit: TResultOpenpit3D read FOwner;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;virtual;abstract;
    procedure Clear;virtual;abstract;
  end;{TResultOpenpitObject3D}

  TCourseKind=(ckCourseMoving,ckCourseTo,ckCourseFrom);
  //2.Маршрут карьера -------------------------------------------------------------------------
  TResultOpenpitCourse3D=class(TResultOpenpitObject3D)
  private
    FId_Course     : Integer;     //Код маршрута
    FKind          : TCourseKind; //Тип маршрута
    FId_Point0     : Integer;     //Код начальной точки маршрута
    FPoints        : TList;       //Точки маршрута
    FCourseLength  : Single;      //Длина маршрута, м
    FStripWidth    : Single;      //Средняя ширина маршрута, м
    FShowSubstrate : Boolean;     //Показать подложку
    FSubstrateCeil : TGLPolygon;  //Полигон поверхности дороги
    FSubstrateSides: TList;       //Список боковых полигонов дороги
    function GetPointsCount: Integer;
    function GetPoint(const Index: Integer): ROpenpitPoint3D;
    procedure SetShowSubstrate(const Value : Boolean);
    //Очистить списки
    procedure ClearSubstrateCeil;
    procedure ClearSubstrateSides;
    //для Update
    procedure GetCourseSubBlocks(const quBlocks,quBlockPoints: TADOQuery;
                                 var   ASubBlocks: TList);
    procedure GetSortedSubBlocks(const startPoint: integer;
                                 var blocks: TList);
    procedure GetCourseSidePoints(const ASubBlocks: TList; var ATopPoints,ABottomPoints: TList);
    procedure GetPolygons(const ATopPoints, ABottomPoints: TList);
  public
    property Id_Course: Integer read FId_Course;
    property Kind: TCourseKind read FKind;
    property Id_Point0: Integer read FId_Point0;
    property CourseLength: Single read FCourseLength;
    property StripWidth: Single read FStripWidth;
    property ShowSubstrate: Boolean read FShowSubstrate write SetShowSubstrate;

    property Points[const Index: Integer]: ROpenpitPoint3D read GetPoint;default;
    property PointsCount: Integer read GetPointsCount;

    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Clear;override;
    procedure Update;override;
  end;{TResultOpenpitCourse3D}
  PResultOpenpitCourse3D=^TResultOpenpitCourse3D;

  //3.Маршруты карьера ------------------------------------------------------------------------
  TResultOpenpitCourses3D=class(TResultOpenpitObject3D)
  private
    FItems        : TList;
    FShowSubstrate: Boolean;//Показать подложку
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitCourse3D;
    procedure SetShowSubstrate(const Value: Boolean);
  public      
    //
    _tmp_n: integer;
    property Items[const Index: Integer]: TResultOpenpitCourse3D read GetItem;default;
    property Count: Integer read GetCount;
    property ShowSubstrate: Boolean read FShowSubstrate write SetShowSubstrate;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update(ALabel      : TLabel;
                     AProgressBar: TProgressBar);reintroduce;
    procedure Clear;override;
  end;{TResultOpenpitCourses3D}

  //4.Пункт карьера ---------------------------------------------------------------------------
  TResultOpenpitPunkt3D=class(TResultOpenpitObject3D)
  private
    FPosition: RPoint3D;       //Точка пункта
    FContur  : TGLDummyCube;   //Контур пункта
    FName    : String;         //Наименование пункта
  protected
    procedure SetPosition(const Value: RPoint3D);virtual;
  public
    property Position: RPoint3D read FPosition write SetPosition;
    property Contur: TGLDummyCube read FContur;
    property Name: String read FName;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitPunkt3D}

  //5.Добываемая ГМ пункта погрузки карьера ---------------------------------------------------
  TResultOpenpitLoadingPunktRock3D=class(TResultOpenpitObject3D)
  private
    FName              : String;//Горная масса
    FPlannedRockV1000m3: Single;//План.объем ГМ, тыс.м3
    FPlannedRockQ1000tn: Single;//План.масса ГМ, тыс.т
    FRockV1000m3       : Single;//Объем погруженной ГМ, тыс.м3
    FRockQ1000tn       : Single;//Масса погруженной ГМ, тыс.т
    FResultRocks       : TList;
    function GetA      : Single;//Степень выполнения плана, %
    procedure SetRockV1000m3(const Value: Single);
    procedure SetRockQ1000tn(const Value: Single);
    procedure SetParams(const AResultItemIndex: Integer);
  public
    property Name              : String read FName;
    property PlannedRockV1000m3: Single read FPlannedRockV1000m3;
    property PlannedRockQ1000tn: Single read FPlannedRockQ1000tn;
    property RockV1000m3       : Single read FRockV1000m3 write SetRockV1000m3;
    property RockQ1000tn       : Single read FRockQ1000tn write SetRockQ1000tn;
    property A                 : Single read GetA;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitLoadingPunktRock3D}
  PResultOpenpitLoadingPunktRock3D=^TResultOpenpitLoadingPunktRock3D;

  //6.Пункт погрузки карьера ------------------------------------------------------------------
  TResultOpenpitLoadingPunkt3D=class(TResultOpenpitPunkt3D)
  private
    FState: TPunktState;//Текущее состояние пунта погрузки
    FItems: TList;      //Список добываемой ГМ
    FResultPunkts: TList;
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitLoadingPunktRock3D;
    procedure SetState(const Value: TPunktState);
    procedure SetParams(const AResultItemIndex: Integer);
  public
    property Rocks[const Index: Integer]: TResultOpenpitLoadingPunktRock3D read GetItem;
    property Count: Integer read GetCount;
    property State: TPunktState read FState write SetState;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitLoadingPunkt3D}
  PResultOpenpitLoadingPunkt3D=^TResultOpenpitLoadingPunkt3D;

  //7.Пункты погрузки карьера -----------------------------------------------------------------
  TResultOpenpitLoadingPunkts3D=class(TResultOpenpitObject3D)
  private
    FItems: TList;//Пункты погрузки карьера
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitLoadingPunkt3D;
    procedure FillConturPoints(var APoints: TPoints3DArray; var ACount: Integer);
  public
    property Items[const Index: Integer]: TResultOpenpitLoadingPunkt3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update(ALabel      : TLabel;
                     AProgressBar: TProgressBar);reintroduce;
    procedure Clear;override;
  end;{TResultOpenpitLoadingPunkts3D}

  //8.Разгружаемая ГМ пункта разгрузки карьера ------------------------------------------------
  TResultOpenpitUnLoadingPunktRock3D=class(TResultOpenpitObject3D)
  private
    FName              : String;//Горная масса
    FRockV1000m3       : Single;//Объем разгруженной ГМ, тыс.м3
    FRockQ1000tn       : Single;//Масса разгруженной ГМ, тыс.т
    FContent           : Single;//Текущее содержание, %
    FResultRocks       : TList;
    procedure SetRockV1000m3(const Value: Single);
    procedure SetRockQ1000tn(const Value: Single);
    procedure SetContent(const Value: Single);
    procedure SetParams(const AResultItemIndex: Integer);
  public
    property Name              : String read FName;
    property RockV1000m3       : Single read FRockV1000m3 write SetRockV1000m3;
    property RockQ1000tn       : Single read FRockQ1000tn write SetRockQ1000tn;
    property Content           : Single read FContent write SetContent;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitUnLoadingPunktRock3D}
  PResultOpenpitUnLoadingPunktRock3D=^TResultOpenpitUnLoadingPunktRock3D;

  //9.Пункт разгрузки карьера -----------------------------------------------------------------
  TResultOpenpitUnLoadingPunkt3D=class(TResultOpenpitPunkt3D)
  private
    FState: TPunktState;//Текущее состояние пунта разгрузки
    FItems: TList;      //Список разгружаемой ГМ
    FResultPunkts: TList;
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitUnLoadingPunktRock3D;
    procedure SetState(const Value: TPunktState);
    procedure SetParams(const AResultItemIndex: Integer);
  public
    property Rocks[const Index: Integer]: TResultOpenpitUnLoadingPunktRock3D read GetItem;
    property Count: Integer read GetCount;
    property State: TPunktState read FState write SetState;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitUnLoadingPunkt3D}
  PResultOpenpitUnLoadingPunkt3D=^TResultOpenpitUnLoadingPunkt3D;

  //10.Пункты разгрузки карьера ---------------------------------------------------------------
  TResultOpenpitUnLoadingPunkts3D=class(TResultOpenpitObject3D)
  private
    FItems: TList;//Пункты разгрузки карьера
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitUnLoadingPunkt3D;
  public
    property Items[const Index: Integer]: TResultOpenpitUnLoadingPunkt3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitUnLoadingPunkts3D}

  //11.Пункт пересменки карьера ---------------------------------------------------------------
  TResultOpenpitShiftPunkt3D=class(TResultOpenpitPunkt3D);
  PResultOpenpitShiftPunkt3D=^TResultOpenpitShiftPunkt3D;

  //12.Пункты пересменки карьера --------------------------------------------------------------
  TResultOpenpitShiftPunkts3D=class(TResultOpenpitObject3D)
    FItems: TList;//Пункты пересменки карьера
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitShiftPunkt3D;
  public
    property Items[const Index: Integer]: TResultOpenpitShiftPunkt3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update;override;
    procedure Clear;override;
  end;{TOpenpitShiftPunkts3D}

  //13.Автосамосвал списочного парка ----------------------------------------------------------
  TResultOpenpitAuto3D=class(TResultOpenpitPunkt3D)
  private
    FDirection  : TAutoDirection;//Направление движения
    FState      : TAutoState;    //Состояние
    FAutoCamera : TGLCamera;
    FResultAutos: TList;
    function QuickFindResultAutoIndex(AResultItemIndex: Integer): Integer;
    procedure SetParams(const AResultItemIndex: Integer; const ALambda: Single);
  protected
    procedure SetPosition(const Value: RPoint3D);override;
  public
    property Camera: TGLCamera read FAutoCamera;
    property Direction: TAutoDirection read FDirection;
    property State: TAutoState read FState;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy; override;
    procedure Update;override;
    procedure Clear;override;
  end;{TResultOpenpitAuto3D}
  PResultOpenpitAuto3D=^TResultOpenpitAuto3D;

  //14.Автосамосвалы списочного парка автосамосвалов ------------------------------------------
  TResultOpenpitAutos3D=class(TResultOpenpitObject3D)
  private
    FItems: TList;//Автосамосвалы
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitAuto3D;
    procedure FillConturPoints(var APoints: TPoints3DArray; var ACount: Integer);
  public
    property Items[const Index: Integer]: TResultOpenpitAuto3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
    procedure Update(ALabel      : TLabel;
                     AProgressBar: TProgressBar);reintroduce;
    procedure Clear;override;
  end;{TResultOpenpitAutos3D}

  //15.Карьер ---------------------------------------------------------------------------------
  TResultOpenpit3D = class
  private
    FId_Openpit     : Integer;                  //Код карьера
    FName           : String;                   //Наименование карьера
    FCreateDate     : TDateTime;                //Дата создания карьера
    FNote           : String;                   //Примечание
    FShiftTsec      : Integer;                  //Продолжительность смены, сек
    FMinPoint       : RPoint3D;                 //Минимальная точка карьера
    FMaxPoint       : RPoint3D;                 //Максимальная точка карьера
    FCenter         : RPoint3D;                 //Центр карьера
    FDBConnection   : TADOConnection;           //Соединение с БД карьера
    FCourses        : TResultOpenpitCourses3D;        //Маршруты карьера
    FLoadingPunkts  : TResultOpenpitLoadingPunkts3D;  //Пункты погрузки
    FUnLoadingPunkts: TResultOpenpitUnLoadingPunkts3D;//Пункты разгрузки
    FShiftPunkts    : TResultOpenpitShiftPunkts3D;    //Пункты пересменки
    FAutos          : TResultOpenpitAutos3D;          //Пункты погрузки
    FContur         : TGLDummyCube;             //Контур карьера
    FSubstrateHeight: Single;                   //Высота подложки, м
    function GetShowAxes: Boolean;
    procedure SetShowAxes(const Value: Boolean);
  public
    property Id_Openpit     : Integer read FId_Openpit;
    property Name           : String read FName;
    property CreateDate     : TDateTime read FCreateDate;
    property Note           : String read FNote;
    property ShiftTsec      : Integer read FShiftTsec;
    property DBConnection   : TADOConnection read FDBConnection;
    property Courses        : TResultOpenpitCourses3D read FCourses;
    property LoadingPunkts  : TResultOpenpitLoadingPunkts3D read FLoadingPunkts;
    property UnLoadingPunkts: TResultOpenpitUnLoadingPunkts3D read FUnLoadingPunkts;
    property ShiftPunkts    : TResultOpenpitShiftPunkts3D read FShiftPunkts;
    property Autos          : TResultOpenpitAutos3D read FAutos;
    property Contur         : TGLDummyCube read FContur;
    property MinPoint       : RPoint3D read FMinPoint;
    property MaxPoint       : RPoint3D read FMaxPoint;
    property Center         : RPoint3D read FCenter;
    property SubstrateHeight: Single read FSubstrateHeight;
    property ShowAxes: Boolean read GetShowAxes write SetShowAxes;

    constructor Create(AContur: TGLDummyCube; ADBConnection: TADOConnection);
    destructor Destroy; override;
    function LoadFromDB(const AId_Openpit: Integer= 0): Boolean;
    procedure Clear;
  end;{TResultOpenpit3D}


  //16.Аниматор результатов моделирования -----------------------------------------------------
  TResultAnimator3D=class
  private
    FOpenpit                : TResultOpenpit3D;
    FResultItems            : TList;  //
    FMinTsec                : Single; //Мин. время моделирования, сек
    FMaxTsec                : Single; //Макс.время моделирования, сек
    FCurTsec                : Single; //Текущее время моделирования, сек
    FCurStrippingCoef       : Single; //Текущий коэффициент вскрыши, т/т
    FCurAutosCount          : Integer;//Текущее количество работающих авто
    FSelectedResultItemIndex: Integer;//
    function GetRemainingShiftTsec: Single;                  
    procedure SetCurTsec(const Value: Single);
  public
    property Openpit: TResultOpenpit3D read FOpenpit;
    property MinTsec: Single read FMinTsec;
    property MaxTsec: Single read FMaxTsec;
    property CurTsec: Single read FCurTsec write SetCurTsec;
    property CurStrippingCoef: Single read FCurStrippingCoef;
    property CurAutosCount: Integer read FCurAutosCount;
    property SelectedResultItemIndex: Integer read FSelectedResultItemIndex;
    property RemainingShiftTsec: Single read GetRemainingShiftTsec;
    constructor Create(AContur: TGLDummyCube; ADBConnection: TADOConnection);
    destructor Destroy;override;
    procedure Clear;
    procedure LoadFromFile(const APath: String);
  end;{TResultAnimator3D}

const
  SizeResultItem=SizeOf(RResultItem);
  SizeResultAuto=SizeOf(RResultAuto);
  SizeResultLoadingPunkt=SizeOf(RResultLoadingPunkt);
  SizeResultLoadingPunktRock=SizeOf(RResultLoadingPunktRock);
  SizeResultUnLoadingPunkt=SizeOf(RResultUnLoadingPunkt);
  SizeResultUnLoadingPunktRock=SizeOf(RResultUnLoadingPunktRock);

type
  RSubBlockExpansion=record
    isOneLane: boolean;
  end;
  RSubBlock=record
    Top0,Top1,Bottom0,Bottom1: RPoint3D;
    Point0,Point1            : ROpenpitPoint3D;
    Exp: RSubBlockExpansion;
  end;
  PSubBlock=^RSubBlock;
  RGLConturInfo=record
    Contur: TGLDummyCube;
    Points: TPoints3DArray;
    Count : Integer;
    Size  : RPoint3D;
  end;{RGLConturInfo}
function AddCube(var Info: RGLConturInfo;
                 const AIndex0,AIndex1,AIndex2,AIndex3: Integer;
                 const RatioY0,RatioY1,R,G,B: Single;
                 const ATag: Integer=0): TGLCube;
function AddCylinder(var Info: RGLConturInfo;
                     const AIndex0,AIndex1,AIndex2,AIndex3: Integer;
                     const RatioY0,RatioY1,R,G,B: Single): TGLCylinder;
function AddPolygon(var Info: RGLConturInfo;
                    const AIndexes: array of Integer;
                    const RatioY0,RatioY1,R,G,B: Single;
                    const ATag: Integer=0): TGLPolygon;
function AddSpaceText(var Info: RGLConturInfo;
                      const AIndex0,AIndex1: Integer;
                      const ASpaceX,ASpaceZ,ATurnAngle,ARollAngle,R,G,B: Single;
                      const AText: String): TGLSpaceText;
implementation
uses Math, DB, GLCanvas,GLMisc, Forms;

//I. ГЛОБАЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ------------------------------------------------------------
//
procedure SetSceneObjectColor(AObject: TGLSceneObject; const R,G,B: Single);
begin
  AObject.Material.FrontProperties.Ambient.SetColor(R,G,B);
  AObject.Material.FrontProperties.Diffuse.SetColor(R,G,B);
  AObject.Material.BackProperties.Ambient.SetColor(R,G,B);
  AObject.Material.BackProperties.Diffuse.SetColor(R,G,B);
end;{SetSceneObjectColor}
function AddCube(var Info: RGLConturInfo;
                 const AIndex0,AIndex1,AIndex2,AIndex3: Integer;
                 const RatioY0,RatioY1,R,G,B: Single;
                 const ATag: Integer=0): TGLCube;
begin
  with Info do
  begin
    Result:=(Contur.AddNewChild(TGLCube) as TGLCube);
    SetSceneObjectColor(Result,R,G,B);
    Result.CubeWidth  := Size.X*abs(Points[AIndex3].X-Points[AIndex0].X);
    Result.CubeHeight := Size.Y*abs(RatioY1-RatioY0);
    Result.CubeDepth  := Size.Z*abs(Points[AIndex0].Z-Points[AIndex1].Z);
    Result.Position.SetPoint(Size.X*0.5*(Points[AIndex0].X+Points[AIndex3].X-1),
                             Size.Y*0.5*(RatioY0+RatioY1-1),
                             Size.Z*0.5*(Points[AIndex0].Z+Points[AIndex1].Z));
    Result.Tag := ATag;
  end;{with}
end;{AddCube}
function AddCylinder(var Info: RGLConturInfo;
                     const AIndex0,AIndex1,AIndex2,AIndex3: Integer;
                     const RatioY0,RatioY1,R,G,B: Single): TGLCylinder;
begin
  with Info do
  begin
    Result:=(Contur.AddNewChild(TGLCylinder) as TGLCylinder);
    SetSceneObjectColor(Result,R,G,B);
    Result.TopRadius := Size.Z*abs(Points[AIndex3].Z-Points[AIndex1].Z)*0.5;
    Result.BottomRadius := Result.TopRadius;
    Result.Height       := Size.Y*abs(RatioY1-RatioY0);
    Result.Position.SetPoint(Size.X*0.5*(Points[AIndex0].X+Points[AIndex2].X-1),
                             Size.Y*0.5*(RatioY0+RatioY1-1),
                             Size.Z*0.5*(Points[AIndex1].Z+Points[AIndex3].Z));
  end;{with}
end;{AddCylinder}
function AddPolygon(var Info: RGLConturInfo;
                    const AIndexes: array of Integer;
                    const RatioY0,RatioY1,R,G,B: Single;
                    const ATag: Integer=0): TGLPolygon;
var
  I,AInd,ALow,AHigh: Integer;
  Y0,Y1: Single;
begin
  with Info do
  begin
    ALow := Low(AIndexes);
    AHigh := High(AIndexes);
    //Лицевая часть
    Result:=(Contur.AddNewChild(TGLPolygon) as TGLPolygon);
    Result.Tag := ATag;
    SetSceneObjectColor(Result,R,G,B);
    Y0 := Size.Y*(RatioY0-0.5);
    Y1 := Size.Y*(RatioY1-0.5);
    for I := ALow to AHigh do
      Result.AddNode(Size.X*(Points[AIndexes[I]].X-0.5), Y0,
                     Size.Z*(Points[AIndexes[I]].Z));
    //Задняя часть
    Result:=(Contur.AddNewChild(TGLPolygon) as TGLPolygon);
    Result.Tag := ATag;
    SetSceneObjectColor(Result,R,G,B);
    for I := ALow to AHigh do
      Result.AddNode(Size.X*(Points[AIndexes[I]].X-0.5),Y1,
                     Size.Z*(Points[AIndexes[I]].Z));
    //Боковая часть
    for I := ALow to AHigh do
    begin
      Result:=(Contur.AddNewChild(TGLPolygon) as TGLPolygon);
      Result.Tag := ATag;
      SetSceneObjectColor(Result,R,G,B);
      if I=ALow then AInd := AHigh else AInd := I-1;
      Result.AddNode(Size.X*(Points[AIndexes[AInd]].X-0.5), Y0,
                     Size.Z*(Points[AIndexes[AInd]].Z));
      Result.AddNode(Size.X*(Points[AIndexes[I]].X-0.5), Y0,
                     Size.Z*(Points[AIndexes[I]].Z));
      Result.AddNode(Size.X*(Points[AIndexes[I]].X-0.5), Y1,
                     Size.Z*(Points[AIndexes[I]].Z));
      Result.AddNode(Size.X*(Points[AIndexes[AInd]].X-0.5), Y1,
                     Size.Z*(Points[AIndexes[AInd]].Z));
    end;{for}
  end;{with}
end;{AddPolygon}
function AddSpaceText(var Info: RGLConturInfo;
                      const AIndex0,AIndex1: Integer;
                      const ASpaceX,ASpaceZ,ATurnAngle,ARollAngle,R,G,B: Single;
                      const AText: String): TGLSpaceText;
begin
  with Info do
  begin
    Result:=(Contur.AddNewChild(TGLSpaceText) as TGLSpaceText);
    SetSceneObjectColor(Result,R,G,B);
    Result.Text := AText;
    Result.TurnAngle := ATurnAngle;
    Result.RollAngle := ARollAngle;
    Result.Position.Style := csPoint;
    Result.Position.SetPoint(Size.X*(Points[AIndex0].X-0.5)+ASpaceX, 0.0,
                             Size.Z*0.5*(Points[AIndex0].Z+Points[AIndex1].Z)+ASpaceZ);
    Result.TextHeight := Size.Z*(abs(Points[AIndex0].Z-Points[AIndex1].Z)*0.9);
    Result.Adjust.Horz := haCenter;
    Result.Adjust.Vert := vaCenter;
  end;{with}
end;{AddSpaceText}

//II. ОБРАБОТЧИКИ МЕТОДОВ ОБЪЕКТОВ КАРЬЕРА-----------------------------------------------------
//1.Объект карьера ----------------------------------------------------------------------------
constructor TResultOpenpitObject3D.Create(Owner: TResultOpenpit3D);
begin
  inherited Create;
  if not Assigned(Owner)
  then raise Exception.Create('Не создан Owner: TResultOpenpit3D');
  FOwner := Owner;
end;{Create}
destructor TResultOpenpitObject3D.Destroy;
begin
  FOwner := nil;
  inherited;
end;{Destroy}

//2.Маршрут карьера ---------------------------------------------------------------------------
procedure TResultOpenpitCourse3D.ClearSubstrateCeil;
begin
  FSubstrateCeil.Free;
  FSubstrateCeil := nil;
end;{ClearSubstrateCeil}
procedure TResultOpenpitCourse3D.ClearSubstrateSides;
var I: Integer;
begin
  for I := FSubstrateSides.Count-1 downto 0 do
  begin
    PGLPolygon(FSubstrateSides[I])^.Free;
    Dispose(FSubstrateSides[I]);
    FSubstrateSides.Delete(I);
  end;{for}
end;{ClearSubstrateSides}
procedure TResultOpenpitCourse3D.Clear;
begin
  ClearList(FPoints);
  ClearSubstrateCeil;
  ClearSubstrateSides;

  FId_Course    := 0;
  FKind         := ckCourseMoving;
  FId_Point0    := 0;
  FCourseLength := 0.0;
  FStripWidth   := 0.0;
end;{Clear}
constructor TResultOpenpitCourse3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FId_Course     := 0;
  FKind          := ckCourseMoving;
  FId_Point0     := 0;
  FPoints        := TList.Create;
  FSubstrateCeil := nil;
  FSubstrateSides:= TList.Create;
  FCourseLength  := 0.0;
  FStripWidth    := 0.0;
  FShowSubstrate := true;
end;{Create}
destructor TResultOpenpitCourse3D.Destroy;
begin
  Clear;
  FPoints.Free;
  FSubstrateSides.Free;
  FPoints         := nil;
  FSubstrateCeil  := nil;
  FSubstrateSides := nil;
  inherited;
end;{Destroy}
function TResultOpenpitCourse3D.GetPoint(const Index: Integer): ROpenpitPoint3D;
begin
  if InRange(Index,0,FPoints.Count-1)
  then Result := POpenpitPoint3D(FPoints[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FPoints.Count-1]));
end;{GetPoint}
function TResultOpenpitCourse3D.GetPointsCount: Integer;
begin
  Result := FPoints.Count;
end;{GetPointsCount}
procedure TResultOpenpitCourse3D.SetShowSubstrate(const Value: Boolean);
var I: Integer;
begin
  if FShowSubstrate<>Value then
  begin
    FShowSubstrate := Value;
    for I := 0 to FSubstrateSides.Count-1 do
      PGLPolygon(FSubstrateSides[I])^.Visible := Value;
  end;{if}
end;{SetShowSubstrate}
//Заполняю список подблок-участков SubBlocks с учетом направления и вычисляю сразу StripWidth
procedure TResultOpenpitCourse3D.GetCourseSubBlocks(const quBlocks,quBlockPoints: TADOQuery;
                                                    var   ASubBlocks: TList);
var
  ABlockStripCount: integer;
  ABlockStripWidth: Single;
  ASubBlock: PSubBlock;
  APoints: TList;
  APoint: POpenpitPoint3D;
  AId_Point,I: Integer;
  //
  foo: integer;
  bar: boolean;
begin
  //1. Считываю данные по маршруту: quBlocks, quBlockPoints
  //2. Создаю список подблок-участков ASubBlocks с учетом направления
  //3. Вычисляю сразу StripWidth и CourseLength
  FStripWidth := 0.0;
  FCourseLength := 0.0;
  AId_Point := FId_Point0;
  APoints := TList.Create;
  quBlocks.Last;
  quBlocks.First;
  while not quBlocks.Eof do
  begin
    quBlockPoints.Last;
    quBlockPoints.First;
    if quBlockPoints.RecordCount>0 then
    begin
      foo:= quBlocks.FieldByName('id_Block').AsInteger;

      //StripCount
      ABlockStripCount:= quBlocks.FieldByName('StripCount').AsInteger;
      //StripWidth
      if ABlockStripCount=1 then
        ABlockStripWidth := quBlocks.FieldByName('StripWidth').AsFloat//*0.5
      else
        ABlockStripWidth := quBlocks.FieldByName('StripWidth').AsFloat;
      FStripWidth := FStripWidth+ABlockStripWidth;
      //Считываю точки блок-участка в APoints
      while not quBlockPoints.Eof do
      begin
        New(APoint);
        APoint^.Id_Point := quBlockPoints.FieldByName('Id_Point').AsInteger;
        APoint^.Coords.X := quBlockPoints.FieldByName('X').AsFloat;
        APoint^.Coords.Y := quBlockPoints.FieldByName('Y').AsFloat;
        APoint^.Coords.Z := quBlockPoints.FieldByName('Z').AsFloat;
        APoints.Add(APoint);
        quBlockPoints.Next;
      end;
      //Переворачиваю APoints в зависимости от направления маршрута
      if POpenpitPoint3D(APoints[0])^.Id_Point <> AId_Point then
        for I := 0 to (APoints.Count div 2)-1 do
          APoints.Exchange(I,APoints.Count-1-I);
      //ASubBlocks
      for I := 1 to APoints.Count-1 do
      begin
        New(ASubBlock);
        ASubBlock^.Point0 := POpenpitPoint3D(APoints[I-1])^;
        ASubBlock^.Point1 := POpenpitPoint3D(APoints[I])^;

        GetBoundAroundPiece(ASubBlock^.Point0.Coords,ASubBlock^.Point1.Coords,
                            ABlockStripWidth,
                            ASubBlock^.Top0,ASubBlock^.Top1,
                            ASubBlock^.Bottom1,ASubBlock^.Bottom0);
        ASubBlock^.Exp.isOneLane:= (ABlockStripCount = 1);
        ASubBlocks.Add(ASubBlock);
        FCourseLength :=
          FCourseLength+sqrt(sqr(ASubBlock^.Point1.Coords.X-ASubBlock^.Point0.Coords.X)+
                             sqr(ASubBlock^.Point1.Coords.Y-ASubBlock^.Point0.Coords.Y)+
                             sqr(ASubBlock^.Point1.Coords.Z-ASubBlock^.Point0.Coords.Z));
      end;
      AId_Point := POpenpitPoint3D(APoints.Last)^.Id_Point;
      ClearList(APoints);
    end;{if}
    quBlocks.Next;
  end;{while}
  if quBlocks.RecordCount>0
  then FStripWidth := FStripWidth/quBlocks.RecordCount
  else FStripWidth := 0.0;
  //Удаление временных списков
  ClearList(APoints);
  APoints.Free;
  GetSortedSubBlocks(FId_Point0, ASubBlocks);
end;{GetCourseSubBlocks}

//Список точек оси, левой и правой обочины дороги----------------------------------------------
procedure TResultOpenpitCourse3D.GetCourseSidePoints(const ASubBlocks: TList;
                                                     var ATopPoints,ABottomPoints: TList);
  procedure PointTransfer(const bsource: PSubBlock;
                          const psource: PPoint3D;
                          var ptarget:PPoint3DExt);
  begin
    ptarget^.X:= psource^.X;
    ptarget^.Y:= psource^.Y;
    ptarget^.Z:= psource^.Z;
    ptarget^.Exp.isOneLane:= bsource^.Exp.isOneLane;
  end;
var
  I: Integer;
  ASubBlockOld,ASubBlock: PSubBlock;
  AOpenpitPoint: POpenpitPoint3D;
  APoint: PPoint3D;
  APointExt: PPoint3DExt;
  txt: TWriter;
begin
  //Нахожу точки левой, правой обочины и оси маршрута -----------------------------------------
  for I := 0 to ASubBlocks.Count-1 do
  begin
    ASubBlock := ASubBlocks[I];
      New(AOpenpitPoint);//Ось маршрута--------------
      AOpenpitPoint^ := ASubBlock^.Point0;
      FPoints.Add(AOpenpitPoint);
      New(APoint);       //Левая обочина маршрута----
      New(APointExt);
      APoint^ := ASubBlock^.Top0;
      PointTransfer(ASubBlock, APoint, APointExt);
      Dispose(APoint);
      ATopPoints.Add(APointExt);
      New(APoint);       //Правая обочина маршрута---
      New(APointExt);
      APoint^ := ASubBlock^.Bottom0;
      PointTransfer(ASubBlock, APoint, APointExt);
      Dispose(APoint);
      ABottomPoints.Add(APointExt);
      //
      New(AOpenpitPoint);//Ось маршрута--------------
      AOpenpitPoint^ := ASubBlock^.Point1;
      FPoints.Add(AOpenpitPoint);
      New(APoint);       //Левая обочина маршрута----
      New(APointExt);
      APoint^ := ASubBlock^.Top1;
      PointTransfer(ASubBlock, APoint, APointExt);
      Dispose(APoint);
      ATopPoints.Add(APointExt);
      New(APoint);       //Правая обочина маршрута---
      New(APointExt);
      APoint^ := ASubBlock^.Bottom1;
      PointTransfer(ASubBlock, APoint, APointExt);
      Dispose(APoint);
      ABottomPoints.Add(APointExt);
  end;
end;{GetCourseSidePoints}
//Создание и заполнение списка полигонов поверхности и подложки дороги-------------------------
procedure TResultOpenpitCourse3D.GetPolygons(const ATopPoints,ABottomPoints: TList);
  procedure SetColor(var APolygon: TGLPolygon; const R,G,B: Single);
  begin
    APolygon.Material.FrontProperties.Ambient.SetColor(R,G,B);
    APolygon.Material.FrontProperties.Diffuse.SetColor(R,G,B);
    APolygon.Material.BackProperties.Ambient.SetColor(R,G,B);
    APolygon.Material.BackProperties.Diffuse.SetColor(R,G,B);
  end;
  procedure Check_min(var _minx: single;
                      var _miny: single;
                      var _minz: single;
                      point: PPoint3DExt);//PPoint3DExt
  begin
    if _minx > point.X then
      _minx:= point.X;
    if _miny > point.Y then
      _miny:= point.Y;
    if _minz > point.Z then
      _minz:= point.Z;
  end;
  procedure Check_max(var _maxx: single;
                      var _maxy: single;
                      var _maxz: single;
                      point: PPoint3DExt);//PPoint3DExt
  begin
    if _maxx < point.X then
      _maxx:= point.X;
    if _maxy < point.Y then
      _maxy:= point.Y;
    if _maxz < point.Z then
      _maxz:= point.Z;
  end;
const
  MINVIEWHIGHT = 6;
var
  I: Integer;
  APolygon: TList;
  APoint: PPoint3DExt;
  ACenter: RPoint3D;
  AMinZ,AHeight: Single;
  ASubstrateSide: PGLPolygon;
  //
  _minx, _miny, _minz: single;
  _maxx, _maxy, _maxz: single;
begin
  ACenter := Openpit.Center;
  APolygon := TList.Create;
  AMinZ := Openpit.MinPoint.Z;
  AHeight := Openpit.SubstrateHeight;
  //Заполнение точек полигона маршрута---------------------------------------------------------
  for I := 0 to ATopPoints.Count-1 do
  begin
    New(APoint);
    APoint^ := PPoint3DExt(ATopPoints[I])^;
    APolygon.Add(APoint);
  end;
  for I := ABottomPoints.Count-1 downto 0 do
  begin
    New(APoint);
    APoint^ := PPoint3DExt(ABottomPoints[I])^;
    APolygon.Add(APoint);
  end;
  //u+
  _minx:= 10000;
  _miny:= 10000;
  _minz:= 10000;
  _maxx:= 0;
  _maxy:= 0;
  _maxz:= 0;
  //
  //Заполнение полигонов и полилиний OpenGL 3D-------------------------------------------------
  //Поверхность дороги
  for I := 1 to ATopPoints.Count-1 do
  begin
    FSubstrateCeil:=(Openpit.Contur.AddNewChild(TGLPolygon) as TGLPolygon);
    if not PPoint3DExt(ATopPoints[I-1])^.Exp.isOneLane then
      SetColor(FSubstrateCeil,0.7,0.4,0.4)
    else
      SetColor(FSubstrateCeil,0.4,0.7,0.4);

    //
    Check_min(_minx, _miny, _minz, PPoint3DExt(ATopPoints[I-1]));
    Check_min(_minx, _miny, _minz, ATopPoints[I]);
    Check_min(_minx, _miny, _minz, ABottomPoints[I-1]);
    Check_min(_minx, _miny, _minz, ABottomPoints[I]);
    //
    Check_max(_maxx, _maxy, _maxz, PPoint3DExt(ATopPoints[I-1]));
    Check_max(_maxx, _maxy, _maxz, ATopPoints[I]);
    Check_max(_maxx, _maxy, _maxz, ABottomPoints[I-1]);
    Check_max(_maxx, _maxy, _maxz, ABottomPoints[I]);
    //
    FSubstrateCeil.AddNode(PPoint3DExt(ATopPoints[I-1])^.X-ACenter.X,
                           PPoint3DExt(ATopPoints[I-1])^.Y-ACenter.Y,
                           PPoint3DExt(ATopPoints[I-1])^.Z-ACenter.Z);
    FSubstrateCeil.AddNode(PPoint3DExt(ATopPoints[I])^.X-ACenter.X,
                           PPoint3DExt(ATopPoints[I])^.Y-ACenter.Y,
                           PPoint3DExt(ATopPoints[I])^.Z-ACenter.Z);
    FSubstrateCeil.AddNode(PPoint3DExt(ABottomPoints[I])^.X-ACenter.X,
                           PPoint3DExt(ABottomPoints[I])^.Y-ACenter.Y,
                           PPoint3DExt(ABottomPoints[I])^.Z-ACenter.Z);
    FSubstrateCeil.AddNode(PPoint3DExt(ABottomPoints[I-1])^.X-ACenter.X,
                           PPoint3DExt(ABottomPoints[I-1])^.Y-ACenter.Y,
                           PPoint3DExt(ABottomPoints[I-1])^.Z-ACenter.Z);
  end;
  (*
  //Поверхность дороги
  FSubstrateCeil:=(Openpit.Contur.AddNewChild(TGLPolygon) as TGLPolygon);
  SetColor(FSubstrateCeil,0.7,0.4,0.4);
  for I := 0 to APolygon.Count-1 do
    FSubstrateCeil.AddNode(PPoint3D(APolygon[I])^.X-ACenter.X,
                           PPoint3D(APolygon[I])^.Y-ACenter.Y,
                           PPoint3D(APolygon[I])^.Z-ACenter.Z);
  *)
  //Боковые грани дороги (замыкающая)

  if APolygon.Count>0 then
  begin
    New(ASubstrateSide);
    ASubstrateSide^ :=(Openpit.Contur.AddNewChild(TGLPolygon) as TGLPolygon);
    SetColor(ASubstrateSide^,0.7,0.7,0.7);
    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[0])^.X-ACenter.X,
                            PPoint3DExt(APolygon[0])^.Y-ACenter.Y,
                            PPoint3DExt(APolygon[0])^.Z-ACenter.Z);
    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[APolygon.Count-1])^.X-ACenter.X,
                            PPoint3DExt(APolygon[APolygon.Count-1])^.Y-ACenter.Y,
                            PPoint3DExt(APolygon[APolygon.Count-1])^.Z-ACenter.Z);

    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[APolygon.Count-1])^.X-ACenter.X,
                            PPoint3DExt(APolygon[APolygon.Count-1])^.Y-ACenter.Y,
//                            AMinZ-AHeight-ACenter.Z);
                            PPoint3DExt(APolygon[0])^.Z-ACenter.Z - MINVIEWHIGHT);

    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[0])^.X-ACenter.X,
                            PPoint3DExt(APolygon[0])^.Y-ACenter.Y,
//                            AMinZ-AHeight-ACenter.Z);
                            PPoint3DExt(APolygon[APolygon.Count-1])^.Z-ACenter.Z - MINVIEWHIGHT);
    FSubstrateSides.Add(ASubstrateSide);
  end;

  //Боковые грани дороги (остальные)

  for I := 1 to APolygon.Count-1 do
  begin
    New(ASubstrateSide);
    ASubstrateSide^:=(Openpit.Contur.AddNewChild(TGLPolygon) as TGLPolygon);
    SetColor(ASubstrateSide^,0.7,0.7,0.7);
    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[I-1])^.X-ACenter.X,
                            PPoint3DExt(APolygon[I-1])^.Y-ACenter.Y,
                            PPoint3DExt(APolygon[I-1])^.Z-ACenter.Z);
    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[I])^.X-ACenter.X,
                            PPoint3DExt(APolygon[I])^.Y-ACenter.Y,
                            PPoint3DExt(APolygon[I])^.Z-ACenter.Z);
    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[I])^.X-ACenter.X,
                            PPoint3DExt(APolygon[I])^.Y-ACenter.Y,
                            //AMinZ-AHeight-ACenter.Z);
                            PPoint3DExt(APolygon[I-1])^.Z-ACenter.Z - MINVIEWHIGHT);

    ASubstrateSide^.AddNode(PPoint3DExt(APolygon[I-1])^.X-ACenter.X,
                            PPoint3DExt(APolygon[I-1])^.Y-ACenter.Y,
                            //AMinZ-AHeight-ACenter.Z);
                            PPoint3DExt(APolygon[I])^.Z-ACenter.Z - MINVIEWHIGHT);
    FSubstrateSides.Add(ASubstrateSide);
  end;

end;
procedure TResultOpenpitCourse3D.Update;
begin
end;{Update}

//3.Маршруты карьера --------------------------------------------------------------------------
constructor TResultOpenpitCourses3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FShowSubstrate := true;
  FItems := TList.Create;

  //
  _tmp_n:= 0;
end;{Create}
destructor TResultOpenpitCourses3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitCourses3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitCourses3D.GetItem(const Index: Integer): TResultOpenpitCourse3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitCourse3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitCourses3D.SetShowSubstrate(const Value: Boolean);
var I,J: Integer;
begin
  if FShowSubstrate<>Value then
  begin
    FShowSubstrate := Value;
    for I := 0 to Count-1 do
    begin
      for J := 0 to Items[I].FSubstrateSides.Count-1 do
        PGLPolygon(Items[I].FSubstrateSides[J])^.Visible := Value;
    end;{for}
  end;{if}
end;{SetShowSubstrate}
procedure TResultOpenpitCourses3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitCourse3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
procedure TResultOpenpitCourses3D.Update(ALabel      : TLabel;
                                         AProgressBar: TProgressBar);
type
  TListSortCompare = function (p1, p2:pointer): Integer;

  function SortCompare(p1, p2:pointer):integer;
  var
    APoint00, APoint01: POpenpitPoint3D;
    APoint10, APoint11: POpenpitPoint3D;
  begin
    New(APoint00);New(APoint01);New(APoint10);New(APoint11);
    try
      APoint00^:= PSubBlock(p1).Point0;
      APoint01^:= PSubBlock(p1).Point1;
      APoint10^:= PSubBlock(p2).Point0;
      APoint11^:= PSubBlock(p2).Point1;

      if (APoint00.Id_Point = APoint10.Id_Point) and
         (APoint01.Id_Point = APoint11.Id_Point) then
         Result:= 0
      else
      if
         (APoint00.Id_Point = APoint11.Id_Point) or
         (APoint00.Id_Point = APoint10.Id_Point) or
         (APoint01.Id_Point = APoint11.Id_Point) or
         (APoint01.Id_Point = APoint10.Id_Point) then
        Result:= 1
      else
        Result:= -1;
    finally
      Dispose(APoint00);Dispose(APoint01);Dispose(APoint10);Dispose(APoint11);
    end;
  end;
  function check_sort(list:TList):boolean;
  var
    APoint00, APoint01: POpenpitPoint3D;
    APoint10, APoint11: POpenpitPoint3D;
    Ablock0, Ablock1: PSubBlock;
    i: integer;
  begin
    Result:= true;
    New(APoint00);New(APoint01);New(APoint10);New(APoint11);
    try
      for i:= 1 to list.Count - 1 do
      begin
        Ablock0:= list[i-1];
        Ablock1:= list[i];

        APoint00^:= Ablock0.Point0;
        APoint01^:= Ablock0.Point1;
        APoint10^:= Ablock1.Point0;
        APoint11^:= Ablock1.Point1;

        if (APoint01.Id_Point <> APoint10.Id_Point) and
           (APoint01.Id_Point <> APoint11.Id_Point) and
           (APoint00.Id_Point <> APoint10.Id_Point) and
           (APoint00.Id_Point <> APoint11.Id_Point) then
          Result:= false;

        if not Result then
          Break;
      end;
    finally
      Dispose(APoint00);Dispose(APoint01);Dispose(APoint10);Dispose(APoint11);
    end;
  end;

var
  ACourse: PResultOpenpitCourse3D;
  ASubBlocks,ATopPoints,ABottomPoints: TList;
  quCourses,quBlocks,quBlockPoints: TADOQuery;
  dsCourses,dsBlocks: TDAtaSource;
  //
  i: integer;
  txt: TWriter;
  ASubBlock: PSubBlock;
  APoint0, APoint1: POpenpitPoint3D;
  ACompFunc: TListSortCompare;
begin
  Clear;
  if Openpit.Id_Openpit=0 then Exit;
  ALabel.Caption := 'Блок-участки автотрассы...';
  ATopPoints := TList.Create;   //Точки левой обочины маршрута
  ABottomPoints := TList.Create;//Точки правой обочины маршрута
  ASubBlocks := TList.Create;   //Блок-участки маршрута
  quCourses := TADOQuery.Create(nil);
  try
    dsCourses := TDataSource.Create(nil);
    dsCourses.DataSet := quCourses;
    quCourses.Connection := Openpit.DBConnection;
    quCourses.SQL.Text := Format('SELECT * FROM OpenpitCourses WHERE Id_Openpit=%d',
                                 [Openpit.Id_Openpit]);
    quCourses.Open;
    quBlocks := TADOQuery.Create(nil);
    quBlocks.DataSource := dsCourses;
    dsBlocks := TDataSource.Create(nil);
    dsBlocks.DataSet := quBlocks;
    quBlocks.Connection := Openpit.DBConnection;
    quBlocks.SQL.Text := 'SELECT CB.*,B.StripCount,B.StripWidth '+
                         'FROM OpenpitCourseBlocks CB,OpenpitBlocks B '+
                         'WHERE (CB.Id_Course=:Id_Course)and'+
                         '      (B.Id_Block=CB.Id_Block)';
    quBlocks.Open;
    quBlockPoints := TADOQuery.Create(nil);
    quBlockPoints.Connection := Openpit.DBConnection;
    quBlockPoints.DataSource := dsBlocks;
    quBlockPoints.SQL.Text := 'SELECT BP.*,P.X,P.Y,P.Z '+
                              'FROM OpenpitBlockPoints BP, OpenpitPoints P '+
                              'WHERE (BP.Id_Block=:Id_Block)and(BP.Id_Point=P.Id_Point)';
    quBlockPoints.Open;
    AProgressBar.Min := 0;
    AProgressBar.Position := 0;
    AProgressBar.Max := quCourses.RecordCount-1;
    TForm(AProgressBar.Owner).Repaint;
    while not quCourses.EOF do
    begin
      New(ACourse);
      ACourse^ := TResultOpenpitCourse3D.Create(Openpit);
      ACourse^.FId_Course := quCourses.FieldByName('Id_Course').AsInteger;
      ACourse^.FId_Point0 := quCourses.FieldByName('Id_Point0').AsInteger;
      ACourse^.FKind := TCourseKind(quCourses.FieldByName('Kind').AsInteger);
      ACourse^.FCourseLength := 0.0;
      ACourse^.FStripWidth   := 0.0;
      ClearList(ACourse^.FPoints);
      ACourse^.ClearSubstrateCeil;
      ACourse^.ClearSubstrateSides;
      if (ACourse^.FId_Course>0)or(ACourse^.FId_Point0>0) then
      //if false then
      begin//НЕОБХОДИМО ЗАДАТЬ FId_Course и FId_Point

    inc(_tmp_n);
    //if _tmp_n < 2 then
    //if ACourse^.FId_Course in [46] then
    begin
        //Создаю список подблок-участков SubBlocks с учетом направления -----------------------
        //и вычисляю сразу StripWidth и CourseLength
        ACourse^.GetCourseSubBlocks(quBlocks,quBlockPoints,ASubBlocks);
        //Список точек оси, левой и правой обочины дороги--------------------------------------
        ACourse^.GetCourseSidePoints(ASubBlocks,ATopPoints,ABottomPoints);
        //Создание и заполнение списка полигонов поверхности и подложки дороги-----------------
        ACourse^.GetPolygons(ATopPoints,ABottomPoints);
    //
    end;
    //
        //Очистка временных списков------------------------------------------------------------
        ClearList(ASubBlocks);
        ClearList(ATopPoints);
        ClearList(ABottomPoints);
      end;{if}
      FItems.Add(ACourse);
      AProgressBar.Position := AProgressBar.Position+1;
      quCourses.Next;
    end;{while}
    quCourses.Close;
    quBlockPoints.Close;
    quBlockPoints.Free;
    quBlocks.Close;
    quBlocks.Free;
    dsBlocks.Free;
    dsCourses.Free;
  finally
    quCourses.Free;
  end;{try}
  //Финализация -------------------------------------------------------------------------------
  ASubBlocks.Free;
  ATopPoints.Free;
  ABottomPoints.Free;
end;{Update}

//4.Пункт карьера -----------------------------------------------------------------------------
constructor TResultOpenpitPunkt3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FPosition := Point3D(0.0,0.0,0.0);
  FContur := (Openpit.Contur.AddNewChild(TGLDummyCube) as TGLDummyCube);
  FContur.Position.Style := csPoint;
  FContur.CubeSize := 30.0;
  FName := '';
end;{Create}
destructor TResultOpenpitPunkt3D.Destroy;
begin
  Clear;
  FContur.Free;
  FContur := nil;
  inherited;
end;{Destroy}
procedure TResultOpenpitPunkt3D.SetPosition(const Value: RPoint3D);
begin
  FPosition := Value;
  FContur.Position.SetPoint(Value.X,Value.Y,Value.Z);
end;{SetPosition}
procedure TResultOpenpitPunkt3D.Update;
begin
end;{Update}
procedure TResultOpenpitPunkt3D.Clear;
begin
end;{Clear}

//5.Добываемая ГМ пункта погрузки карьера------------------------------------------------------
function TResultOpenpitLoadingPunktRock3D.GetA: Single;
begin
  if FPlannedRockV1000m3>0.0
  then Result := FRockV1000m3/FPlannedRockV1000m3*100.0
  else Result := 0.0;
end;{GetA}
procedure TResultOpenpitLoadingPunktRock3D.SetRockV1000m3(const Value: Single);
begin
  if FRockV1000m3<>Value then
  begin
    FRockV1000m3 := Value;
  end;{if}
end;{SetRockV1000m3}
procedure TResultOpenpitLoadingPunktRock3D.SetRockQ1000tn(const Value: Single);
begin
  if FRockQ1000tn<>Value then
  begin
    FRockQ1000tn := Value;
  end;{if}
end;{SetRockQ1000tn}
procedure TResultOpenpitLoadingPunktRock3D.SetParams(const AResultItemIndex: Integer);
var
  I: Integer;
  AItem: RResultLoadingPunktRock;
begin
  if FResultRocks.Count=0 then Exit;
  for I := 1 to FResultRocks.Count-1 do
  begin
    AItem := PResultLoadingPunktRock(FResultRocks[I])^;
    if AItem.ResultItemIndex>AResultItemIndex then
    begin
      AItem := PResultLoadingPunktRock(FResultRocks[I-1])^;
      FRockV1000m3 := AItem.RockV1000m3;
      FRockQ1000tn := AItem.RockQ1000tn;
      Break;
    end;{if}
  end;{for}
end;{SetParams}
constructor TResultOpenpitLoadingPunktRock3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FPlannedRockV1000m3 := 0.0;
  FPlannedRockQ1000tn := 0.0;
  FRockV1000m3 := 0.0;
  FRockQ1000tn := 0.0;
  FResultRocks := TList.Create;
end;{Create}
destructor TResultOpenpitLoadingPunktRock3D.Destroy;
begin
  if FResultRocks<>nil then ClearList(FResultRocks);
  FResultRocks.Free;
  FResultRocks := nil;
  inherited;
end;{Destroy}
procedure TResultOpenpitLoadingPunktRock3D.Update;
begin
end;{Update}
procedure TResultOpenpitLoadingPunktRock3D.Clear;
begin
  if FResultRocks<>nil then ClearList(FResultRocks);
end;{Clear}

//6.Пункт погрузки карьера --------------------------------------------------------------------
function TResultOpenpitLoadingPunkt3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitLoadingPunkt3D.GetItem(const Index: Integer): TResultOpenpitLoadingPunktRock3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitLoadingPunktRock3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitLoadingPunkt3D.SetState(const Value: TPunktState);
var
  I: Integer;
  Color: RPoint3D;
begin
  if FState<>Value then
  begin
    FState := Value;
    case FState of
      psWorking : Color := Point3D(1.0,0.0,0.0);
      psManeuver: Color := Point3D(0.0,1.0,0.0);
      else        Color := Point3D(0.6,0.6,0.0);
    end;{case}
    for I := 0 to FContur.Count-1 do
    if FContur.Children[I].Tag=1 then
    if FContur.Children[I] Is TGLCube then
    with TGLSceneObject(FContur.Children[I]).Material do
    begin
      FrontProperties.Ambient.SetColor(Color.X,Color.Y,Color.Z);
      FrontProperties.Diffuse.SetColor(Color.X,Color.Y,Color.Z);
      BackProperties.Ambient.SetColor(Color.X,Color.Y,Color.Z);
      BackProperties.Diffuse.SetColor(Color.X,Color.Y,Color.Z);
    end;{if}
  end;{if}
end;{SetState}
procedure TResultOpenpitLoadingPunkt3D.SetParams(const AResultItemIndex: Integer);
var
  I: Integer;
  AItem: RResultLoadingPunkt;
begin
  if FResultPunkts.Count=0 then Exit;
  for I := 1 to FResultPunkts.Count-1 do
  begin
    AItem := PResultLoadingPunkt(FResultPunkts[I])^;
    if AItem.ResultItemIndex>AResultItemIndex then
    begin
      AItem := PResultLoadingPunkt(FResultPunkts[I-1])^;
      FState := AItem.State;
      Break;
    end;{if}
  end;{for}
  for I := 0 to Count-1 do
    Rocks[I].SetParams(AResultItemIndex);
end;{SetParams}
constructor TResultOpenpitLoadingPunkt3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FState := psWaiting;
  FItems := TList.Create;
  FResultPunkts := TList.Create;
end;{Create}
destructor TResultOpenpitLoadingPunkt3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  FResultPunkts.Free;
  FResultPunkts := nil;
  inherited;
end;{Destroy}
procedure TResultOpenpitLoadingPunkt3D.Update;
begin
end;{Update}
procedure TResultOpenpitLoadingPunkt3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitLoadingPunktRock3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
  if FResultPunkts<>nil then ClearList(FResultPunkts);
end;{Clear}

//7.Пункты погрузки карьера -------------------------------------------------------------------
constructor TResultOpenpitLoadingPunkts3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FItems := TList.Create;
end;{Create}
destructor TResultOpenpitLoadingPunkts3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitLoadingPunkts3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitLoadingPunkts3D.GetItem(const Index: Integer): TResultOpenpitLoadingPunkt3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitLoadingPunkt3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitLoadingPunkts3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitLoadingPunkt3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
procedure TResultOpenpitLoadingPunkts3D.FillConturPoints(var APoints: TPoints3DArray;
                                                            var ACount: Integer);
begin
  ACount := 77;
  SetLength(APoints,ACount);
  APoints[ 0] := Point3D(0.01,0.00,0.92);
  APoints[ 1] := Point3D(0.01,0.00,0.41);
  APoints[ 2] := Point3D(0.01,0.00,0.35);
  APoints[ 3] := Point3D(0.01,0.00,0.97);
  APoints[ 4] := Point3D(0.01,0.00,0.38);
  APoints[ 5] := Point3D(0.01,0.00,0.23);
  APoints[ 6] := Point3D(0.01,0.00,0.11);
  APoints[ 7] := Point3D(0.03,0.00,0.97);
  APoints[ 8] := Point3D(0.03,0.00,0.38);
  APoints[ 9] := Point3D(0.03,0.00,0.34);
  APoints[10] := Point3D(0.03,0.00,0.28);
  APoints[11] := Point3D(0.03,0.00,0.04);
  APoints[12] := Point3D(0.04,0.00,0.99);
  APoints[13] := Point3D(0.04,0.00,0.95);
  APoints[14] := Point3D(0.04,0.00,0.92);
  APoints[15] := Point3D(0.04,0.00,0.30);
  APoints[16] := Point3D(0.04,0.00,0.46);
  APoints[17] := Point3D(0.05,0.00,0.41);
  APoints[18] := Point3D(0.06,0.00,0.76);
  APoints[19] := Point3D(0.06,0.00,0.00);
  APoints[20] := Point3D(0.07,0.00,0.62);
  APoints[21] := Point3D(0.07,0.00,0.47);
  APoints[22] := Point3D(0.08,0.00,0.80);
  APoints[23] := Point3D(0.08,0.00,0.72);
  APoints[24] := Point3D(0.08,0.00,0.41);
  APoints[25] := Point3D(0.08,0.00,0.34);
  APoints[26] := Point3D(0.10,0.00,0.76);
  APoints[27] := Point3D(0.11,0.00,0.34);
  APoints[28] := Point3D(0.11,0.00,0.14);
  APoints[29] := Point3D(0.13,0.00,0.81);
  APoints[30] := Point3D(0.13,0.00,0.74);
  APoints[31] := Point3D(0.13,0.00,0.07);
  APoints[32] := Point3D(0.16,0.00,0.04);
  APoints[33] := Point3D(0.16,0.00,0.00);
  APoints[34] := Point3D(0.36,0.00,0.85);
  APoints[35] := Point3D(0.37,0.00,0.74);
  APoints[36] := Point3D(0.38,0.00,0.89);
  APoints[37] := Point3D(0.38,0.00,0.81);
  APoints[38] := Point3D(0.39,0.00,0.97);
  APoints[39] := Point3D(0.39,0.00,0.93);
  APoints[40] := Point3D(0.40,0.00,0.85);
  APoints[41] := Point3D(0.44,0.00,0.68);
  APoints[42] := Point3D(0.46,0.00,0.68);
  APoints[43] := Point3D(0.46,0.00,0.11);
  APoints[44] := Point3D(0.51,0.00,0.22);
  APoints[45] := Point3D(0.51,0.00,0.00);
  APoints[46] := Point3D(0.56,0.00,0.11);
  APoints[47] := Point3D(0.57,0.00,0.35);
  APoints[48] := Point3D(0.57,0.00,0.32);
  APoints[49] := Point3D(0.57,0.00,0.28);
  APoints[50] := Point3D(0.59,0.00,0.62);
  APoints[51] := Point3D(0.59,0.00,0.45);
  APoints[52] := Point3D(0.59,0.00,0.35);
  APoints[53] := Point3D(0.59,0.00,0.28);
  APoints[54] := Point3D(0.59,0.00,0.59);
  APoints[55] := Point3D(0.60,0.00,0.72);
  APoints[56] := Point3D(0.61,0.00,0.70);
  APoints[57] := Point3D(0.62,0.00,0.27);
  APoints[58] := Point3D(0.62,0.00,0.23);
  APoints[59] := Point3D(0.66,0.00,0.70);
  APoints[60] := Point3D(0.66,0.00,0.55);
  APoints[61] := Point3D(0.66,0.00,0.45);
  APoints[62] := Point3D(0.66,0.00,0.28);
  APoints[63] := Point3D(0.68,0.00,0.70);
  APoints[64] := Point3D(0.68,0.00,0.55);
  APoints[65] := Point3D(0.71,0.00,0.70);
  APoints[66] := Point3D(0.71,0.00,0.55);
  APoints[67] := Point3D(0.72,0.00,0.72);
  APoints[68] := Point3D(0.72,0.00,0.55);
  APoints[69] := Point3D(0.76,0.00,0.27);
  APoints[70] := Point3D(0.76,0.00,0.23);
  APoints[71] := Point3D(0.81,0.00,0.11);
  APoints[72] := Point3D(0.86,0.00,0.22);
  APoints[73] := Point3D(0.86,0.00,0.00);
  APoints[74] := Point3D(0.91,0.00,0.11);
  APoints[75] := Point3D(1.00,0.00,0.55);
  APoints[76] := Point3D(1.00,0.00,0.28);
end;{FillConturPoints}
procedure TResultOpenpitLoadingPunkts3D.Update(ALabel      : TLabel;
                                               AProgressBar: TProgressBar);
var
  AItem: PResultOpenpitLoadingPunkt3D;
  ARock: PResultOpenpitLoadingPunktRock3D;
  AInfo: RGLConturInfo;
  quPunkts,quRocks: TADOQuery;
  dsPunkts: TDataSource;
  S: String;
begin
  Clear;
  if Openpit.Id_Openpit=0 then Exit;
  ALabel.Caption := 'Списочный парк экскаваторов...';
  quPunkts := TADOQuery.Create(nil);
  try
    dsPunkts := TDataSource.Create(nil);
    dsPunkts.DataSet := quPunkts;
    FillConturPoints(AInfo.Points,AInfo.Count);
    quPunkts.Connection := Openpit.DBConnection;
    quPunkts.SQL.Text :=
      'SELECT LP.*,DE.Id_Excavator,DE.ParkNo,E.Name,E.EWidth,E.EHeight,E.ELength,P.X,P.Y,P.Z '+
      'FROM OpenpitLoadingPunkts LP,OpenpitDeportExcavators DE,Excavators E,OpenpitPoints P '+
      'WHERE (LP.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and '+
      '      (DE.Id_DeportExcavator=LP.Id_DeportExcavator)and '+
      '      (E.Id_Excavator=DE.Id_Excavator)and '+
      '      (P.Id_Point=LP.Id_Point) '+
      'ORDER BY LP.SortIndex';

    quPunkts.Open;
    quRocks := TADOQuery.Create(nil);
    quRocks.DataSource := dsPunkts;
    quRocks.Connection := Openpit.DBConnection;
    quRocks.SQL.Text := 'SELECT LPR.*, R.Name '+
                        'FROM OpenpitLoadingPunktRocks LPR,OpenpitRocks R '+
                        'WHERE (LPR.Id_LoadingPunkt=:Id_LoadingPunkt)and'+
                        '      (R.Id_Rock=LPR.Id_Rock) '+
                        'ORDER BY LPR.SortIndex';
    quRocks.Open;
    AProgressBar.Min := 0;
    AProgressBar.Position := 0;
    AProgressBar.Max := quPunkts.RecordCount-1;
    TForm(AProgressBar.Owner).Repaint;
    while not quPunkts.EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitLoadingPunkt3D.Create(Openpit);
      with AItem^ do
      begin
        FPosition := Point3D(quPunkts.FieldByName('X').AsFloat,
                             quPunkts.FieldByName('Y').AsFloat,
                             quPunkts.FieldByName('Z').AsFloat);
        FName := Format('%s (№%.2d) Гор.%.2f',[quPunkts.FieldByName('Name').AsString,
                                               quPunkts.FieldByName('ParkNo').AsInteger,
                                               quPunkts.FieldByName('Z').AsFloat]);
        AInfo.Size := Point3D(quPunkts.FieldByName('ELength').AsFloat,
                              quPunkts.FieldByName('EWidth').AsFloat,
                              quPunkts.FieldByName('EHeight').AsFloat);
//        FContur.CubeSize := Max(AInfo.Size.X,Max(AInfo.Size.Y,AInfo.Size.Z));
        FContur.CubeSize := AInfo.Size.Z;
        FContur.Position.SetPoint(Position.X-Openpit.Center.X,
                                  Position.Y-Openpit.Center.Y,
                                  Position.Z-Openpit.Center.Z);
        AInfo.Contur := AItem^.FContur;

        AddCube(AInfo,44,45,73,72,0.1,0.9,0.2,0.2,0.2);     //Гусеницы 1
        AddCylinder(AInfo,43,45,46,44,0.1,0.9,0.2,0.2,0.2); //Гусеницы 2
        AddCylinder(AInfo,71,73,74,72,0.1,0.9,0.2,0.2,0.2); //Гусеницы 3
//        (*
        AddCube(AInfo,57,58,70,69,0.2,0.8,1.0,1.0,0.0);     //Ось кабины
        AddCube(AInfo,60,62,76,75,0.0,1.0,0.6,0.6,0.0,1);   //Двигатель
        AddCube(AInfo,51,53,62,61,0.0,1.0,1.0,1.0,0.0);     //Основание кабины
        AddCube(AInfo,47,49,53,52,0.0,1.0,1.0,1.0,0.0);     //Основание подпорки стрелы
        AddPolygon(AInfo,[55,50,51,54,56,59,60,64,63,65,66,68,67],0.0,1.0,1.0,1.0,0.0);//Вверх кабины
        AddPolygon(AInfo,[50,38,29,12,3,0,20,21,24,25,27,30,35,51],0.4,0.6,1.0,1.0,0.0);//Стрела основная
        AddCylinder(AInfo,34,37,40,36,0.39,0.61,0.2,0.2,0.2); //Шарнир 1
        AddCylinder(AInfo,18,23,26,22,0.39,0.61,0.2,0.2,0.2); //Шарнир 1
        AddPolygon(AInfo,[41,48,47,42],0.48,0.52,0.6,0.6,0.0);//Подпорка Стрелы 1
        AddPolygon(AInfo,[13,14,39,38],0.48,0.52,0.6,0.6,0.0);//Подпорка Стрелы 2
        AddCube(AInfo,3,4,8,7,0.48,0.52,0.6,0.6,0.0);//Подпорка Стрелы 3
        AddPolygon(AInfo,[21,16,1,2,10,15,9,8,17,24],0.48,0.52,0.6,0.6,0.0);//Подпорка Стрелы 4
        AddPolygon(AInfo,[25,10,5,6,11,19,33,32,31,28,27],0.3,0.7,1.0,1.0,0.0);//Ковш
//        *)
        S := Format('%.2d',[quPunkts.FieldByName('ParkNo').AsInteger]);
        AddSpaceText(AInfo,68,75,1.0,0.1,0.0,90.0,0.0,0.0,0.0,S);
        AddSpaceText(AInfo,75,76,0.1,0.0,90.0,90.0,0.0,0.0,0.0,S);
      end;{with}
      quRocks.Last;
      quRocks.First;
      while not quRocks.Eof do
      begin
        New(ARock);
        ARock^ := TResultOpenpitLoadingPunktRock3D.Create(Openpit);
        ARock^.FPlannedRockV1000m3 := quRocks.FieldByName('PlannedV1000m3').AsFloat;
        ARock^.FPlannedRockQ1000tn := quRocks.FieldByName('PlannedV1000m3').AsFloat*
                                      quRocks.FieldByName('DensityInBlock').AsFloat;
        ARock^.FName               := quRocks.FieldByName('Name').AsString;
        AItem^.FItems.Add(ARock);
        quRocks.Next;
      end;{while}
      FItems.Add(AItem);
      AProgressBar.Position := AProgressBar.Position+1;
      quPunkts.Next;
    end;{while}
    quRocks.Close;
    quRocks.Free;
    quPunkts.Close;
    dsPunkts.Free;
  finally
    quPunkts.Free;
  end;{try}
  AInfo.Points := nil;
  AInfo.Count := 0;
end;{Update}

//8.Разгружаемая ГМ пункта разгрузки карьера --------------------------------------------------
procedure TResultOpenpitUnLoadingPunktRock3D.SetRockV1000m3(const Value: Single);
begin
  if FRockV1000m3<>Value then
  begin
    FRockV1000m3 := Value;
  end;{if}
end;{SetRockV1000m3}
procedure TResultOpenpitUnLoadingPunktRock3D.SetRockQ1000tn(const Value: Single);
begin
  if FRockQ1000tn<>Value then
  begin
    FRockQ1000tn := Value;
  end;{if}
end;{SetRockQ1000tn}
procedure TResultOpenpitUnLoadingPunktRock3D.SetContent(const Value: Single);
begin
  if FContent<>Value then
  begin
    FContent := Value;
  end;{if}
end;{SetContent}
procedure TResultOpenpitUnLoadingPunktRock3D.SetParams(const AResultItemIndex: Integer);
var
  I: Integer;
  AItem: RResultUnLoadingPunktRock;
begin
  if FResultRocks.Count=0 then Exit;
  for I := 1 to FResultRocks.Count-1 do
  begin
    AItem := PResultUnLoadingPunktRock(FResultRocks[I])^;
    if AItem.ResultItemIndex>AResultItemIndex then
    begin
      AItem := PResultUnLoadingPunktRock(FResultRocks[I-1])^;
      FRockV1000m3 := AItem.RockV1000m3;
      FRockQ1000tn := AItem.RockQ1000tn;
      FContent := AItem.Content;
      Break;
    end;{if}
  end;{for}
end;{SetParams}
constructor TResultOpenpitUnLoadingPunktRock3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FRockV1000m3 := 0.0;
  FRockQ1000tn := 0.0;
  FContent     := 0.0;
  FResultRocks := TList.Create;
end;{Create}
destructor TResultOpenpitUnLoadingPunktRock3D.Destroy;
begin
  Clear;
  FResultRocks.Free;
  FResultRocks := nil;
  inherited;
end;{Destroy}
procedure TResultOpenpitUnLoadingPunktRock3D.Update;
begin
end;{Update}
procedure TResultOpenpitUnLoadingPunktRock3D.Clear;
begin
  if FResultRocks<>nil then ClearList(FResultRocks);
end;{Clear}

//9.Пункт разгрузки карьера -------------------------------------------------------------------
function TResultOpenpitUnLoadingPunkt3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitUnLoadingPunkt3D.GetItem(const Index: Integer): TResultOpenpitUnLoadingPunktRock3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitUnLoadingPunktRock3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitUnLoadingPunkt3D.SetState(const Value: TPunktState);
var
  I: Integer;
  Color: RPoint3D;
begin
  if FState<>Value then
  begin
    FState := Value;
    case FState of
      psWorking : Color := Point3D(1.0,0.0,0.0);
      psManeuver: Color := Point3D(0.0,1.0,0.0);
      else        Color := Point3D(0.2,0.2,0.2);
    end;{case}
    for I := 0 to FContur.Count-1 do
    if FContur.Children[I].Tag=1 then
    if FContur.Children[I] Is TGLAnnulus then
    with TGLSceneObject(FContur.Children[I]).Material do
    begin
      FrontProperties.Ambient.SetColor(Color.X,Color.Y,Color.Z);
      FrontProperties.Diffuse.SetColor(Color.X,Color.Y,Color.Z);
      BackProperties.Ambient.SetColor(Color.X,Color.Y,Color.Z);
      BackProperties.Diffuse.SetColor(Color.X,Color.Y,Color.Z);
    end;{if}
  end;{if}
end;{SetState}
procedure TResultOpenpitUnLoadingPunkt3D.SetParams(const AResultItemIndex: Integer);
var
  I: Integer;
  AItem: RResultUnLoadingPunkt;
begin
  if FResultPunkts.Count=0 then Exit;
  for I := 1 to FResultPunkts.Count-1 do
  begin
    AItem := PResultUnLoadingPunkt(FResultPunkts[I])^;
    if AItem.ResultItemIndex>AResultItemIndex then
    begin
      if I<FResultPunkts.Count-1 then
        AItem := PResultUnLoadingPunkt(FResultPunkts[I-1])^;
      FState := AItem.State;
      Break;
    end;{if}
  end;{for}
  for I := 0 to Count-1 do
    Rocks[I].SetParams(AResultItemIndex);
end;{SetParams}
constructor TResultOpenpitUnLoadingPunkt3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FState := psWaiting;
  FItems := TList.Create;
  FResultPunkts := TList.Create;
end;{Create}
destructor TResultOpenpitUnLoadingPunkt3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  FResultPunkts.Free;
  FResultPunkts := nil;
  inherited;
end;{Destroy}
procedure TResultOpenpitUnLoadingPunkt3D.Update;
begin
end;{Update}
procedure TResultOpenpitUnLoadingPunkt3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitUnLoadingPunktRock3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
  if FResultPunkts<>nil then ClearList(FResultPunkts);
end;{Clear}

//10.Пункты разгрузки карьера -----------------------------------------------------------------
constructor TResultOpenpitUnLoadingPunkts3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FItems := TList.Create;
end;{Create}
destructor TResultOpenpitUnLoadingPunkts3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitUnLoadingPunkts3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitUnLoadingPunkts3D.GetItem(const Index: Integer): TResultOpenpitUnLoadingPunkt3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitUnLoadingPunkt3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitUnLoadingPunkts3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitUnLoadingPunkt3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
procedure TResultOpenpitUnLoadingPunkts3D.Update;
const
  MINVIEWHIGHT = 6;
var
  AItem: PResultOpenpitUnLoadingPunkt3D;
  ARock: PResultOpenpitUnLoadingPunktRock3D;
  quPunkts,quRocks: TADOQuery;
  dsPunkts: TDataSource;
  AAnnulus: TGLAnnulus;
begin
  Clear;
  if Openpit.Id_Openpit=0 then Exit;
  quPunkts := TADOQuery.Create(nil);
  try
    dsPunkts := TDataSource.Create(nil);
    dsPunkts.DataSet := quPunkts;
    quPunkts.Connection := Openpit.DBConnection;
    quPunkts.SQL.Text := 'SELECT UP.*, P.X,P.Y,P.Z '+
                'FROM OpenpitUnLoadingPunkts UP, OpenpitPoints P '+
                'WHERE (UP.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and'+
                '      (P.Id_Point=UP.Id_Point)'+
                'ORDER BY UP.SortIndex';
    quPunkts.Open;
    quRocks := TADOQuery.Create(nil);
    quRocks.DataSource := dsPunkts;
    quRocks.Connection := Openpit.DBConnection;
    quRocks.SQL.Text := 'SELECT UPR.*, R.Name '+
                        'FROM OpenpitUnLoadingPunktRocks UPR,OpenpitRocks R '+
                        'WHERE (UPR.Id_UnLoadingPunkt=:Id_UnLoadingPunkt)and'+
                        '      (R.Id_Rock=UPR.Id_Rock) '+
                        'ORDER BY UPR.SortIndex';
    quRocks.Open;
    while not quPunkts.EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitUnLoadingPunkt3D.Create(Openpit);
      with AItem^ do
      begin
        FPosition := Point3D(quPunkts.FieldByName('X').AsFloat,
                             quPunkts.FieldByName('Y').AsFloat,
                             quPunkts.FieldByName('Z').AsFloat);
        case TUnLoadingPunktKind(quPunkts.FieldByName('Kind').AsInteger) of
          ulpkFactory: FName := 'Фабрика';
          ulpkStorage: FName := 'П.Склад';
          else         FName := 'Отвал';
        end;{case}
        FName := Format('%s Гор.%.2f',[FName, quPunkts.FieldByName('Z').AsFloat]);
        FContur.Position.SetPoint(Position.X-Openpit.Center.X,
                                  Position.Y-Openpit.Center.Y,
                                  Position.Z-Openpit.Center.Z+1.0);
        FContur.CubeSize := 30.0;
        AAnnulus:=(FContur.AddNewChild(TGLAnnulus) as TGLAnnulus);
        AAnnulus.Material.FrontProperties.Ambient.SetColor(0.2,0.2,0.2);
        AAnnulus.Material.FrontProperties.Diffuse.SetColor(0.2,0.2,0.2);
        AAnnulus.Material.BackProperties.Ambient.SetColor(0.2,0.2,0.2);
        AAnnulus.Material.BackProperties.Diffuse.SetColor(0.2,0.2,0.2);
        AAnnulus.TopRadius := 30.0;
        AAnnulus.TopInnerRadius := 28.0;
        AAnnulus.BottomRadius := 12.0;
        AAnnulus.BottomInnerRadius := 0.0;
        AAnnulus.PitchAngle := -90.0;
        AAnnulus.Height := Position.Z-Openpit.Center.Z - MINVIEWHIGHT;
        //AAnnulus.Height := abs(Position.Z-Openpit.MinPoint.Z+Openpit.SubstrateHeight);
        AAnnulus.Position.SetPoint(0.0,0.0,-AAnnulus.Height*0.5);
        AAnnulus.Tag := 1;
      end;{with}
      quRocks.Last;
      quRocks.First;
      while not quRocks.Eof do
      begin
        New(ARock);
        ARock^ := TResultOpenpitUnLoadingPunktRock3D.Create(Openpit);
        ARock^.FName := quRocks.FieldByName('Name').AsString;
        AItem^.FItems.Add(ARock);
        quRocks.Next;
      end;{while}
      FItems.Add(AItem);
      quPunkts.Next;
    end;{while}
    quRocks.Close;
    quRocks.Free;
    quPunkts.Close;
    dsPunkts.Free;
  finally
    quPunkts.Free;
  end;{try}
end;{Update}

//12.Пункты пересменки карьера ----------------------------------------------------------------
constructor TResultOpenpitShiftPunkts3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FItems := TList.Create;
end;{Create}
destructor TResultOpenpitShiftPunkts3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitShiftPunkts3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitShiftPunkts3D.GetItem(const Index: Integer): TResultOpenpitShiftPunkt3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitShiftPunkt3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitShiftPunkts3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitShiftPunkt3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
procedure TResultOpenpitShiftPunkts3D.Update;
var
  AItem: PResultOpenpitShiftPunkt3D;
  ACube: TGLCube;
  AFrustrum: TGLFrustrum;
begin
  Clear;
  if Openpit.Id_Openpit>0 then
  with TADOQuery.Create(nil) do
  try
    Connection := Openpit.DBConnection;
    SQL.Text := 'SELECT SP.*, P.X,P.Y,P.Z '+
                'FROM OpenpitShiftPunkts SP, OpenpitPoints P '+
                'WHERE (SP.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and'+
                '      (P.Id_Point=SP.Id_Point)'+
                'ORDER BY SP.SortIndex';
    Open;
    while not EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitShiftPunkt3D.Create(Openpit);
      with AItem^ do
      begin
        FPosition := Point3D(FieldByName('X').AsFloat,
                             FieldByName('Y').AsFloat,
                             FieldByName('Z').AsFloat);
        FName := Format('ППС Гор.%.2f',[FieldByName('Z').AsFloat]);
        
        FContur.Position.SetPoint(Position.X-Openpit.Center.X,
                                  Position.Y-Openpit.Center.Y,
                                  Position.Z-Openpit.Center.Z);
        ACube:=(FContur.AddNewChild(TGLCube) as TGLCube);
        ACube.Material.FrontProperties.Ambient.SetColor(1.0,1.0,0.0);
        ACube.Material.FrontProperties.Diffuse.SetColor(1.0,1.0,0.0);
        ACube.Material.BackProperties.Ambient.SetColor(1.0,1.0,0.0);
        ACube.Material.BackProperties.Diffuse.SetColor(1.0,1.0,0.0);
        ACube.CubeDepth := FContur.CubeSize;
        ACube.CubeWidth := FContur.CubeSize;
        ACube.CubeHeight := FContur.CubeSize;
        ACube.Position.SetPoint(0.0,0.0,ACube.CubeDepth*0.5);
        AFrustrum:=(FContur.AddNewChild(TGLFrustrum) as TGLFrustrum);
        AFrustrum.Material.FrontProperties.Ambient.SetColor(0.5,0.5,0.0);
        AFrustrum.Material.FrontProperties.Diffuse.SetColor(0.5,0.5,0.0);
        AFrustrum.Material.BackProperties.Ambient.SetColor(0.5,0.5,0.0);
        AFrustrum.Material.BackProperties.Diffuse.SetColor(0.5,0.5,0.0);
        AFrustrum.ApexHeight := 10.0;
        AFrustrum.Height := 10.0;
        AFrustrum.BaseDepth := 40.0;
        AFrustrum.BaseWidth := 40.0;
        AFrustrum.PitchAngle := -90.0;
        AFrustrum.Position.SetPoint(0.0,0.0,ACube.CubeDepth);
      end;{with}
      FItems.Add(AItem);
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{Update}

//13.Автосамосвал списочного парка ------------------------------------------------------------
procedure TResultOpenpitAuto3D.SetPosition(const Value: RPoint3D);
begin
  FPosition := Value;
  FContur.Position.SetPoint(Value.X-Openpit.Center.X,
                            Value.Y-Openpit.Center.Y,
                            Value.Z-Openpit.Center.Z);
end;{SetPosition}
constructor TResultOpenpitAuto3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FDirection := adLoading;
  FState := asWaiting;
  FPosition := Point3D(0.0,0.0,0.0);
  FContur.Direction.Style := csPoint;
  FContur.Position.Style := csPoint;
  FContur.Up.Style := csPoint;
  FAutoCamera := (FContur.AddNewChild(TGLCamera) as TGLCamera);
  FAutoCamera.Position.Style := csPoint;
  FAutoCamera.FocalLength := 100.0;
  FAutoCamera.DepthOfView := 50*Openpit.Contur.CubeSize;
  FAutoCamera.TargetObject := FContur;
  FAutoCamera.CameraStyle := csInfinitePerspective;
  FResultAutos := TList.Create;
end;{Create}
destructor TResultOpenpitAuto3D.Destroy;
begin
  FAutoCamera.Free;
  FAutoCamera := nil;
  ClearList(FResultAutos);
  FResultAutos.Free;
  FResultAutos := nil;
  inherited;
end;{Destroy}
//Быстрый 
function TResultOpenpitAuto3D.QuickFindResultAutoIndex(AResultItemIndex: Integer): Integer;
var
  AInd0,AInd1,AInd: Integer;
  AAuto0,AAuto1: RResultAuto;
begin
  Result := -1;
  if FResultAutos.Count=0 then Exit;
  //Т.к. данные в FResultAutos отсортированы по полю ResultAutoIndex, то
  //для быстрого поиска использую алгоритм быстрого поиска делением пополам,
  //где в конечном результате Ind0 и Ind1 - диапазон, содержащий значение AResultAutoIndex,
  //причем Ind0=AResultAutoIndex
  //Условие: AResultAuto содержится в FResultAutos!!!
  AInd0 := 0; AInd1 := FResultAutos.Count-1; 
  while Result=-1 do
  begin
    AAuto0 := PResultAuto(FResultAutos[AInd0])^;
    AAuto1 := PResultAuto(FResultAutos[AInd1])^;
    if (AAuto0.ResultItemIndex=AResultItemIndex)OR(AAuto1.ResultItemIndex=AResultItemIndex)then
    begin
      if AAuto0.ResultItemIndex=AResultItemIndex then Result := AInd0 else Result := AInd1;
    end{if}
    else
    begin
      AInd := (AInd0+AInd1)div 2;
      AAuto1 := PResultAuto(FResultAutos[AInd])^;
      if InRange(AResultItemIndex,AAuto0.ResultItemIndex,AAuto1.ResultItemIndex)
      then AInd1 := AInd
      else AInd0 := AInd;
    end;{else}
  end;{while}
end;{QuickFindIndex}
procedure TResultOpenpitAuto3D.SetParams(const AResultItemIndex: Integer;
                                         const ALambda: Single);
var
  ADirection    : TAutoDirection;
  AState        : TAutoState;
  AAzimut,AZenit: Single;
  APosition     : RPoint3D;
  AGruzVisible  : Boolean;
  AAuto0,AAuto1 : RResultAuto;
  ADelta: RPoint3D;
  I: Integer;
  AIndex: Integer;
begin
  if FResultAutos.Count=0 then Exit;
  AIndex := QuickFindResultAutoIndex(AResultItemIndex);
  if AIndex<>-1 then
  begin
    AAuto0 := PResultAuto(FResultAutos[AIndex])^;
    if AIndex<FResultAutos.Count-1
    then AAuto1 := PResultAuto(FResultAutos[AIndex+1])^
    else AAuto1 := AAuto0;
    ADirection  := AAuto0.Direction;
    AState      := AAuto0.State;
    AAzimut     := AAuto0.AzimutAngle;
    AZenit      := AAuto0.ZenitAngle;
    if abs(ALambda-1.0)<0.001 then
    begin
      ADirection  := AAuto1.Direction;
      AState      := AAuto1.State;
      AAzimut     := AAuto1.AzimutAngle;
      AZenit      := AAuto1.ZenitAngle;
    end;{if}
    ADelta := Point3D(AAuto1.IndentPosition.X-AAuto0.IndentPosition.X,
                      AAuto1.IndentPosition.Y-AAuto0.IndentPosition.Y,
                      AAuto1.IndentPosition.Z-AAuto0.IndentPosition.Z);
    APosition := Point3D(AAuto0.IndentPosition.X+ADelta.X*ALambda,
                         AAuto0.IndentPosition.Y+ADelta.Y*ALambda,
                         AAuto0.IndentPosition.Z+ADelta.Z*ALambda);
    if FDirection<>ADirection then
    begin
      FDirection := ADirection;
      AGruzVisible := FDirection=adLoading;
      for I := 0 to FContur.Count-1 do
        if FContur.Children[I].Tag=1
        then FContur.Children[I].Visible := AGruzVisible;
    end;{if}
    FState := AState;
    Position := APosition;
    FContur.TurnAngle := 0.0;
    FContur.RollAngle := AAzimut;
    FContur.TurnAngle := AZenit;
  end;{if}
end;{SetParams}
procedure TResultOpenpitAuto3D.Clear;
var I: Integer;
begin
  FPosition := Point3D(0.0,0.0,0.0);
  for I := FContur.Count-1 downto 0 do
  begin
    if FContur.Children[I] Is TGLPolygon
    then (FContur.Children[I] As TGLPolygon).Free
    else
      if FContur.Children[I] Is TGLCylinder
      then (FContur.Children[I] As TGLCylinder).Free
      else
        if FContur.Children[I] Is TGLCube
        then (FContur.Children[I] As TGLCube).Free
  end;{for}
  if FResultAutos<>nil then ClearList(FResultAutos);
end;{Clear}
procedure TResultOpenpitAuto3D.Update;
begin
end;{Update}

//14.Автосамосвалы списочного парка автосамосвалов --------------------------------------------
constructor TResultOpenpitAutos3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FItems := TList.Create;
end;{Create}
destructor TResultOpenpitAutos3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitAutos3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitAutos3D.GetItem(const Index: Integer): TResultOpenpitAuto3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := PResultOpenpitAuto3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitAutos3D.Clear;
var I: Integer;
begin
  if FItems<>nil then
  for I := FItems.Count-1 downto 0 do
  begin
    PResultOpenpitAuto3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
procedure TResultOpenpitAutos3D.FillConturPoints(var APoints: TPoints3DArray;
                                                 var ACount: Integer);
begin
  ACount := 110;
  SetLength(APoints,ACount);
  APoints[  0] := Point3D(0.00,0.00,0.68);
  APoints[  1] := Point3D(0.00,0.00,0.42);
  APoints[  2] := Point3D(0.03,0.00,0.64);
  APoints[  3] := Point3D(0.03,0.00,0.40);
  APoints[  4] := Point3D(0.08,0.00,0.72);
  APoints[  5] := Point3D(0.09,0.00,0.67);
  APoints[  6] := Point3D(0.11,0.00,0.67);
  APoints[  7] := Point3D(0.11,0.00,0.35);
  APoints[  8] := Point3D(0.14,0.00,0.81);
  APoints[  9] := Point3D(0.14,0.00,0.72);
  APoints[ 10] := Point3D(0.14,0.00,0.67);
  APoints[ 11] := Point3D(0.14,0.00,0.33);
  APoints[ 12] := Point3D(0.17,0.00,0.32);
  APoints[ 13] := Point3D(0.17,0.00,0.16);
  APoints[ 14] := Point3D(0.21,0.00,0.67);
  APoints[ 15] := Point3D(0.21,0.00,0.32);
  APoints[ 16] := Point3D(0.23,0.00,0.16);
  APoints[ 17] := Point3D(0.23,0.00,0.67);
  APoints[ 18] := Point3D(0.23,0.00,0.32);
  APoints[ 19] := Point3D(0.23,0.00,0.92);
  APoints[ 20] := Point3D(0.26,0.00,0.32);
  APoints[ 21] := Point3D(0.26,0.00,0.23);
  APoints[ 22] := Point3D(0.26,0.00,0.10);
  APoints[ 23] := Point3D(0.26,0.00,0.00);
  APoints[ 24] := Point3D(0.30,0.00,0.16);
  APoints[ 25] := Point3D(0.31,0.00,0.67);
  APoints[ 26] := Point3D(0.31,0.00,0.32);
  APoints[ 27] := Point3D(0.32,0.00,0.30);
  APoints[ 28] := Point3D(0.32,0.00,0.18);
  APoints[ 29] := Point3D(0.33,0.00,0.96);
  APoints[ 30] := Point3D(0.33,0.00,0.67);
  APoints[ 31] := Point3D(0.33,0.00,0.32);
  APoints[ 32] := Point3D(0.36,0.00,0.16);
  APoints[ 33] := Point3D(0.42,0.00,0.67);
  APoints[ 34] := Point3D(0.42,0.00,0.32);
  APoints[ 35] := Point3D(0.44,0.00,0.67);
  APoints[ 36] := Point3D(0.44,0.00,0.32);
  APoints[ 37] := Point3D(0.44,0.00,0.96);
  APoints[ 38] := Point3D(0.51,0.00,0.67);
  APoints[ 39] := Point3D(0.51,0.00,0.32);
  APoints[ 40] := Point3D(0.54,0.00,0.67);
  APoints[ 41] := Point3D(0.54,0.00,0.32);
  APoints[ 42] := Point3D(0.54,0.00,0.92);
  APoints[ 43] := Point3D(0.62,0.00,0.67);
  APoints[ 44] := Point3D(0.62,0.00,0.32);
  APoints[ 45] := Point3D(0.64,0.00,0.81);
  APoints[ 46] := Point3D(0.64,0.00,0.72);
  APoints[ 47] := Point3D(0.64,0.00,0.67);
  APoints[ 48] := Point3D(0.64,0.00,0.32);
  APoints[ 49] := Point3D(0.67,0.00,0.72);
  APoints[ 50] := Point3D(0.68,0.00,0.32);
  APoints[ 51] := Point3D(0.69,0.00,0.16);
  APoints[ 52] := Point3D(0.69,0.00,0.72);
  APoints[ 53] := Point3D(0.70,0.00,0.99);
  APoints[ 54] := Point3D(0.71,0.00,0.34);
  APoints[ 55] := Point3D(0.71,0.00,0.89);
  APoints[ 56] := Point3D(0.72,0.00,0.72);
  APoints[ 57] := Point3D(0.72,0.00,0.67);
  APoints[ 58] := Point3D(0.72,0.00,0.40);
  APoints[ 59] := Point3D(0.73,0.00,0.93);
  APoints[ 60] := Point3D(0.73,0.00,0.84);
  APoints[ 61] := Point3D(0.73,0.00,0.50);
  APoints[ 62] := Point3D(0.73,0.00,0.49);
  APoints[ 63] := Point3D(0.73,0.00,0.45);
  APoints[ 64] := Point3D(0.75,0.00,0.81);
  APoints[ 65] := Point3D(0.75,0.00,0.69);
  APoints[ 66] := Point3D(0.75,0.00,0.53);
  APoints[ 67] := Point3D(0.75,0.00,0.45);
  APoints[ 68] := Point3D(0.75,0.00,0.30);
  APoints[ 69] := Point3D(0.75,0.00,0.25);
  APoints[ 70] := Point3D(0.75,0.00,0.18);
  APoints[ 71] := Point3D(0.75,0.00,0.16);
  APoints[ 72] := Point3D(0.75,0.00,0.90);
  APoints[ 73] := Point3D(0.75,0.00,0.95);
  APoints[ 74] := Point3D(0.79,0.00,0.32);
  APoints[ 75] := Point3D(0.79,0.00,0.23);
  APoints[ 76] := Point3D(0.79,0.00,0.10);
  APoints[ 77] := Point3D(0.79,0.00,0.00);
  APoints[ 78] := Point3D(0.79,0.00,0.91);
  APoints[ 79] := Point3D(0.82,0.00,0.81);
  APoints[ 80] := Point3D(0.82,0.00,0.69);
  APoints[ 81] := Point3D(0.82,0.00,0.53);
  APoints[ 82] := Point3D(0.82,0.00,0.16);
  APoints[ 83] := Point3D(0.85,0.00,0.81);
  APoints[ 84] := Point3D(0.85,0.00,0.69);
  APoints[ 85] := Point3D(0.86,0.00,0.27);
  APoints[ 86] := Point3D(0.87,0.00,0.20);
  APoints[ 87] := Point3D(0.88,0.00,0.16);
  APoints[ 88] := Point3D(0.90,0.00,0.93);
  APoints[ 89] := Point3D(0.90,0.00,0.90);
  APoints[ 90] := Point3D(0.91,0.00,0.69);
  APoints[ 91] := Point3D(0.93,0.00,0.97);
  APoints[ 92] := Point3D(0.93,0.00,0.81);
  APoints[ 93] := Point3D(0.93,0.00,0.72);
  APoints[ 94] := Point3D(0.94,0.00,0.74);
  APoints[ 95] := Point3D(0.94,0.00,0.74);
  APoints[ 96] := Point3D(0.95,0.00,0.82);
  APoints[ 97] := Point3D(0.95,0.00,0.85);
  APoints[ 98] := Point3D(0.95,0.00,0.82);
  APoints[ 99] := Point3D(0.97,0.00,0.45);
  APoints[100] := Point3D(0.97,0.00,0.34);
  APoints[101] := Point3D(0.97,0.00,0.19);
  APoints[102] := Point3D(0.98,0.00,0.58);
  APoints[103] := Point3D(0.98,0.00,0.50);
  APoints[104] := Point3D(0.99,0.00,0.53);
  APoints[105] := Point3D(0.99,0.00,0.49);
  APoints[106] := Point3D(0.99,0.00,0.45);
  APoints[107] := Point3D(0.99,0.00,0.25);
  APoints[108] := Point3D(1.00,0.00,0.53);
  APoints[109] := Point3D(1.00,0.00,0.34);
end;{FillConturPoints}
procedure TResultOpenpitAutos3D.Update(ALabel      : TLabel;
                                       AProgressBar: TProgressBar);
var
  AItem: PResultOpenpitAuto3D;
  AInfo: RGLConturInfo;
  APos,ACenter: RPoint3D;
  S: String;
begin
  Clear;
  if Openpit.Id_Openpit=0 then Exit;
  ALabel.Caption := 'Списочный парк автосамосвалов...';
  with TADOQuery.Create(nil) do
  try
    FillConturPoints(AInfo.Points,AInfo.Count);
    Connection := Openpit.DBConnection;
    SQL.Text :=
      'SELECT DA.*,A.Name,A.AWidth,A.AHeight,A.ALength,P.X,P.Y,P.Z '+
      'FROM OpenpitDeportAutos DA,Autos A,OpenpitShiftPunkts SP,OpenpitPoints P '+
      'WHERE (DA.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and'+
      '      (A.Id_Auto=DA.Id_Auto)and'+
      '      (SP.Id_ShiftPunkt=DA.Id_ShiftPunkt)and'+
      '      (P.Id_Point=SP.Id_Point)'+
      'ORDER BY DA.SortIndex';

    Open;
    AProgressBar.Min := 0;
    AProgressBar.Position := 0;
    AProgressBar.Max := RecordCount-1;
    TForm(AProgressBar.Owner).Repaint;
    while not EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitAuto3D.Create(Openpit);
      APos := Point3D(FieldByName('X').AsFloat,
                      FieldByName('Y').AsFloat,
                      FieldByName('Z').AsFloat);
      ACenter := Openpit.Center;
      AItem^.FPosition := APos;
      AItem^.FName := Format('%s (№%.2d)',[FieldByName('Name').AsString,
                                           FieldByName('ParkNo').AsInteger]);
      AInfo.Size := Point3D(FieldByName('ALength').AsFloat,
                            FieldByName('AWidth').AsFloat,
                            FieldByName('AHeight').AsFloat);
      AItem^.FContur.CubeSize := AInfo.Size.Z;
      AItem^.FContur.Position.SetPoint(APos.X-ACenter.X,
                                       APos.Y-ACenter.Y,
                                       APos.Z-ACenter.Z);
      AItem^.FAutoCamera.Position.Z := 2*AInfo.Size.Z;
      AInfo.Contur := AItem^.FContur;
      AddCube(AInfo,27,28,70,68,0.2,0.8,0.2,0.2,0.2);//Рама
//      (*
      AddCube(AInfo,67,69,107,106,0.2,0.8,0.2,0.2,0.2);//Основание кабины
      AddPolygon(AInfo,[62,63,99,100,109,108,104,105],0.1,0.9,0.7,0.7,0.2);//Основание кабины2
      AddPolygon(AInfo,[85,87,101,107],0.25,0.75,0.1,0.1,0.1);//Рама кабины

      AddPolygon(AInfo,[60,61,103,102,93,97,78,72],0.5,0.9,0.9,0.9,0.0);//Кабина
      AddCube(AInfo,64,65,80,79,0.49,0.91,0.1,0.1,0.1);//Окно
      AddPolygon(AInfo,[83,84,90,92],0.49,0.91,0.1,0.1,0.1);//Переднее окно
      AddPolygon(AInfo,[96,94,95,98],0.55,0.85,0.1,0.1,0.1);//Лобовое окно
      AddCube(AInfo,65,66,81,80,0.49,0.91,0.6,0.6,0.0);//Дверь
//      *)
      AddCylinder(AInfo,13,23,32,20,0.8,0.95, 0.1,0.1,0.1);//Заднее колесо 1
      AddCylinder(AInfo,13,23,32,20,0.62,0.77, 0.1,0.1,0.1);//Заднее колесо 2
      AddCylinder(AInfo,13,23,32,20,0.05,0.2, 0.1,0.1,0.1);//Заднее колесо 3
      AddCylinder(AInfo,13,23,32,20,0.23,0.38, 0.1,0.1,0.1);//Заднее колесо 4
      AddCylinder(AInfo,16,22,24,21,0.04,0.96, 0.7,0.7,0.7);//Задняя ось
      AddCylinder(AInfo,51,77,87,74,0.8,0.95, 0.1,0.1,0.1);//Переднее колесо 1
      AddCylinder(AInfo,51,77,87,74,0.05,0.2, 0.1,0.1,0.1);//Переднее колесо 2
      AddCylinder(AInfo,71,76,82,75,0.04,0.96, 0.7,0.7,0.7);//Передняя ось
//      (*
      AddPolygon(AInfo,[2,3,12,50,54,58,57,5],0.01,0.99,0.6,0.6,0.0);//Кузов
      AddPolygon(AInfo,[0,1,3,2,5,6,7,11,10,14,15,18,17,25,26,31,30,
                        33,34,36,35,38,39,41,40,43,44,48,47,57,56,52,
                        55,59,73,89,91,88,53,49,4],0.0,1.0,1.0,1.0,0.0);//Секции Кузова
//      *)
      S := Format('%.2d',[FieldByName('ParkNo').AsInteger]);
      AddSpaceText(AInfo,0,1,-0.1,0.0,-90.0,-90.0,0.0,0.0,0.0,S);
      AddSpaceText(AInfo,108,109,0.1,0.0,90.0,90.0,0.0,0.0,0.0,S);
      AddPolygon(AInfo,[8,9,46,45,42,37,29,19],0.05,0.95,0.4,0.4,0.4,1);//Груз
      FItems.Add(AItem);
      AProgressBar.Position := AProgressBar.Position+1;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  AInfo.Points := nil;
  AInfo.Count := 0;
end;{Update}

//15.Карьер -----------------------------------------------------------------------------------
function TResultOpenpit3D.GetShowAxes: Boolean;
begin
  Result := FContur.VisibleAtRunTime;
end;{GetShowAxes}
procedure TResultOpenpit3D.SetShowAxes(const Value: Boolean);
begin
  FContur.VisibleAtRunTime := Value;
end;{SetShowAxes}
procedure TResultOpenpit3D.Clear;
begin
  FId_Openpit := 0;
  FName       := '';
  FCreateDate := Now;
  FNote       := '';
  FMinPoint   := Point3D(-50.0,-50.0,-50.0);
  FMaxPoint   := Point3D(+50.0,+50.0,+50.0);
  FCenter     := Point3D(0.0,0.0,0.0);
  FLoadingPunkts.Clear;
  FUnLoadingPunkts.Clear;
  FShiftPunkts.Clear;
  FCourses.Clear;
  FAutos.Clear;
end;{Clear}
constructor TResultOpenpit3D.Create(AContur: TGLDummyCube; ADBConnection: TADOConnection);
begin
  inherited Create;
  if not Assigned(ADBConnection)
  then raise Exception.Create('Не создан DBConnection: TADOConnection');
  if not Assigned(AContur)
  then raise Exception.Create('Не создан Contur: TGLDummyCube');
  FDBConnection    := ADBConnection;
  FContur          := AContur;
  FId_Openpit      := 0;
  FName            := '';
  FCreateDate      := Now;
  FNote            := '';
  FShiftTsec       := 0;
  FMinPoint        := Point3D(-50.0,-50.0,-50.0);
  FMaxPoint        := Point3D(+50.0,+50.0,+50.0);
  FCenter          := Point3D(0.0,0.0,0.0);
  FSubstrateHeight := 100.0;
  FCourses         := TResultOpenpitCourses3D.Create(Self);
  FLoadingPunkts   := TResultOpenpitLoadingPunkts3D.Create(Self);
  FUnLoadingPunkts := TResultOpenpitUnLoadingPunkts3D.Create(Self);
  FShiftPunkts     := TResultOpenpitShiftPunkts3D.Create(Self);
  FAutos           := TResultOpenpitAutos3D.Create(Self);
end;{Create}
destructor TResultOpenpit3D.Destroy;
begin
  Clear;
  FDBConnection := nil;
  FShiftPunkts.Free;
  FShiftPunkts := nil;
  FUnLoadingPunkts.Free;
  FUnLoadingPunkts := nil;
  FLoadingPunkts.Free;
  FLoadingPunkts := nil;
  FCourses.Free;
  FCourses := nil;
  FAutos.Free;
  FAutos := nil;
  FContur.Free;
  FContur := nil;
  inherited;
end;{Destroy}
//Загрузка карьера из БД
function TResultOpenpit3D.LoadFromDB(const AId_Openpit: Integer= 0): Boolean;
var
  AForm: TForm;
  ALabel: TLabel;
  AProgressBar: TProgressBar;
begin
  Result := false;
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM Openpits WHERE Id_Openpit='+IntToStr(AId_Openpit);
    Open;
    Clear;
    if RecordCount=1 then
    begin
      FId_Openpit := FieldByName('Id_Openpit').AsInteger;
      FName := FieldByName('Name').AsString;
      FCreateDate := FieldByName('DateCreate').AsDateTime;
      FShiftTsec   := FieldByName('ParamsShiftDuration').AsInteger*60;

      FMinPoint.X := FieldByName('MinX').AsFloat;
      FMinPoint.Y := FieldByName('MinY').AsFloat;
      FMinPoint.Z := FieldByName('MinZ').AsFloat;
      FMaxPoint.X := FieldByName('MaxX').AsFloat;
      FMaxPoint.Y := FieldByName('MaxY').AsFloat;
      FMaxPoint.Z := FieldByName('MaxZ').AsFloat;
      FCenter.X := (FMinPoint.X+FMaxPoint.X)*0.5;
      FCenter.Y := (FMinPoint.Y+FMaxPoint.Y)*0.5;
      FCenter.Z := (FMinPoint.Z+FMaxPoint.Z)*0.5;
      AForm  := CreateDialogForm('Загрузка...',400,100);
      try
        ALabel := TLabel.Create(AForm);
        SetLabelProperties(ALabel,AForm,Point(16,16),'');
        AProgressBar := CreateProgressBar(AForm,AForm,Point(16,32),360);
        AForm.FormStyle := fsStayOnTop;
        AForm.Show;
        FCourses.Update(ALabel,AProgressBar);
        FUnLoadingPunkts.Update;
        FLoadingPunkts.Update(ALabel,AProgressBar);
        FShiftPunkts.Update;
        FAutos.Update(ALabel,AProgressBar);
        Result := true;
      finally
        AForm.Free;
      end;{try}
    end;{if}
    Close;
  finally
    Free;
  end;{try}
end;{LoadFromDB}


//16.Аниматор результатов моделирования -------------------------------------------------------
constructor TResultAnimator3D.Create(AContur: TGLDummyCube; ADBConnection: TADOConnection);
begin
  inherited Create;
  FOpenpit := TResultOpenpit3D.Create(AContur,ADBConnection);
  FResultItems := TList.Create;
  FMinTsec            := 0.0;
  FMaxTsec            := 100.0;
  FCurTsec            := -1.0;
  FCurStrippingCoef   := 0.0;
  FCurAutosCount      := 0;
  FSelectedResultItemIndex := -1;
end;{Create}
destructor TResultAnimator3D.Destroy;
begin
  Clear;
  FResultItems.Free;
  FResultItems := nil;
  FOpenpit.Free;
  FOpenpit := nil;
  inherited;
end;{Destroy}
procedure TResultAnimator3D.Clear;
begin
  FMinTsec            := 0.0;
  FMaxTsec            := 100.0;
  FCurTsec            := -1.0;
  FCurStrippingCoef   := 0.0;
  FCurAutosCount      := 0;
  FSelectedResultItemIndex := -1;
  ClearList(FResultItems);
end;{Clear}
procedure TResultAnimator3D.LoadFromFile(const APath: String);
var
  AFileHandle: Integer;    //Дескриптор файла
  AResultItem: PResultItem;//Указатель на ResultItem
  AResultAuto: PResultAuto;//Указатель на ResultAuto
  ALP: PResultLoadingPunkt;//Указатель на ResultLoadingPunkt
  ALPR: PResultLoadingPunktRock;//Указатель на ResultLoadingPunktRock
  AUP: PResultUnLoadingPunkt;//Указатель на ResultUnLoadingPunkt
  AUPR: PResultUnLoadingPunktRock;//Указатель на ResultUnLoadingPunktRock
  I,ACount   : Integer;
begin
  Clear;
  //Check all files' existing -----------------------------------------------------------------
  if not FileExists(APath+'ResultItems.esa')then Exit;
  if not FileExists(APath+'ResultAutos.esa')then Exit;
  if not FileExists(APath+'ResultLoadingPunkts.esa')then Exit;
  if not FileExists(APath+'ResultLoadingPunktRocks.esa')then Exit;
  //ResultItems -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultItems.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultItem;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(AResultItem);
      FileRead(AFileHandle,AResultItem^,SizeResultItem);
      FResultItems.Add(AResultItem);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //ResultAutos -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultAutos.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultAuto;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(AResultAuto);
      FileRead(AFileHandle,AResultAuto^,SizeResultAuto);
      if Openpit.Autos[AResultAuto^.AutoIndex].FResultAutos.Count=1 then
      with PResultAuto(Openpit.Autos[AResultAuto^.AutoIndex].FResultAutos.Last)^ do
      begin
        ZenitAngle := AResultAuto^.ZenitAngle;
        AzimutAngle := AResultAuto^.AzimutAngle;
      end;{if}
      Openpit.Autos[AResultAuto^.AutoIndex].FResultAutos.Add(AResultAuto);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //ResultLoadingPunkts -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultLoadingPunkts.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultLoadingPunkt;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(ALP);
      FileRead(AFileHandle,ALP^,SizeResultLoadingPunkt);
      Openpit.LoadingPunkts[ALP^.LoadingPunktIndex].FResultPunkts.Add(ALP);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //ResultLoadingPunktRocks -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultLoadingPunktRocks.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultLoadingPunktRock;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(ALPR);
      FileRead(AFileHandle,ALPR^,SizeResultLoadingPunktRock);
      Openpit.LoadingPunkts[ALPR^.LoadingPunktIndex].Rocks[ALPR^.LoadingPunktRockIndex].FResultRocks.Add(ALPR);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //ResultUnLoadingPunkts -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultUnLoadingPunkts.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultUnLoadingPunkt;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(AUP);
      FileRead(AFileHandle,AUP^,SizeResultUnLoadingPunkt);
      Openpit.UnLoadingPunkts[AUP^.UnLoadingPunktIndex].FResultPunkts.Add(AUP);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //ResultUnLoadingPunktRocks -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultUnLoadingPunktRocks.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultUnLoadingPunktRock;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(AUPR);
      FileRead(AFileHandle,AUPR^,SizeResultUnLoadingPunktRock);
      Openpit.UnLoadingPunkts[AUPR^.UnloadingPunktIndex].Rocks[AUPR^.UnLoadingPunktRockIndex].FResultRocks.Add(AUPR);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //-------------------------------------------------------------------------------------------
  if FResultItems.Count>0 then
  begin
    FMinTsec := PResultItem(FResultItems.First)^.dTsec;
    FMaxTsec := PResultItem(FResultItems.Last)^.dTsec;
    CurTsec := PResultItem(FResultItems.First)^.dTsec;
  end;{if}
end;{LoadFromFile}

function TResultAnimator3D.GetRemainingShiftTsec: Single;
begin
  Result := FOpenpit.ShiftTsec-FCurTsec;
end;{GetRemainingShiftTsec}
procedure TResultAnimator3D.SetCurTsec(const Value: Single);
var
  I: Integer;
  AResultItem0,AResultItem1: RResultItem; 
  Lambda: Single;
begin
  if (FCurTsec<>Value)and InRange(Value,FMinTsec,FMaxTsec)then
  begin
    FCurTsec := Value;
    //ResultItems -----------------------------------------------------------------------------
    FSelectedResultItemIndex := -1;
    Lambda := 0.0;
    for I := 1 to FResultItems.Count-1 do
    begin
      AResultItem0 := PResultItem(FResultItems[I-1])^;
      AResultItem1 := PResultItem(FResultItems[I])^;
      if InRange(FCurTsec,AResultItem0.dTsec,AResultItem1.dTsec) then
      begin
        FSelectedResultItemIndex := I-1;
        FCurStrippingCoef   := AResultItem0.StrippingCoef;
        Lambda := (Value-AResultItem0.dTsec)/(AResultItem1.dTsec-AResultItem0.dTsec);
        Break;
      end;{if}
    end;{for}
    //ResultAutos -----------------------------------------------------------------------------
    FCurAutosCount := 0;
    for I := 0 to Openpit.Autos.Count-1 do
    if Openpit.Autos[I].State<>asUnWorked then
    begin
      if Openpit.Autos[I].State<>asAbort then Inc(FCurAutosCount);
      Openpit.Autos[I].SetParams(FSelectedResultItemIndex,Lambda);
    end;{for}
    FCurAutosCount := 0;
    for I := 0 to Openpit.Autos.Count-1 do
      if Openpit.Autos[I].State in [asMovingFk,asMovingHh,asMovingBt,asWaiting]
      then Inc(FCurAutosCount);
    //ResultLoadingPunkts ---------------------------------------------------------------------
    for I := 0 to Openpit.LoadingPunkts.Count-1 do
      Openpit.LoadingPunkts[I].SetParams(FSelectedResultItemIndex);
    //ResultUnLoadingPunkts ---------------------------------------------------------------------
    for I := 0 to Openpit.UnLoadingPunkts.Count-1 do
      Openpit.UnLoadingPunkts[I].SetParams(FSelectedResultItemIndex);
  end;{if}
end;{SetCurTsec}
//todo: .2
//u+
procedure TResultOpenpitCourse3D.GetSortedSubBlocks(const startPoint: integer;
                                                    var blocks: TList);
  function Crossed(p0, p1: PSubBlock):boolean;
  begin
    Result:= ((p0.Point0.Id_Point = p1.Point0.Id_Point) or (p0.Point0.Id_Point = p1.Point1.Id_Point)) or
             ((p0.Point1.Id_Point = p1.Point0.Id_Point) or (p0.Point1.Id_Point = p1.Point1.Id_Point));
  end;
  function Ordered(p0, p1: PSubBlock):boolean;
  begin
    Result:= (p0.Point1.Id_Point = p1.Point0.Id_Point);
  end;
  procedure ChangePoints(block: PSubBlock);
  var
    _top, _bottom: PPoint3D;
    _point: POpenpitPoint3D;
  begin
    New(_point);New(_top);New(_bottom);
    _point^:= block.Point0;
    _top^:= block.Top0;
    _bottom^:= block.Bottom0;
    block.Point0:= block.Point1;
    block.Top0:= block.Top1;
    block.Bottom0:= block.Bottom1;
    block.Point1:= _point^;
    block.Top1:= _top^;
    block.Bottom1:= _bottom^;
    Dispose(_point);Dispose(_top);Dispose(_bottom);
  end;
  function isStartBlock(block: PSubBlock): boolean;
  begin
    Result:= (startPoint = block.Point0.Id_Point) or
             (startPoint = block.Point1.Id_Point);
    if (Result) and (block.Point1.Id_Point = startPoint) then
      ChangePoints(block);
  end;
  procedure SetFirstPoint();
  var
    i: integer;
  begin
    for i:= 0 to blocks.Count - 1 do
      if isStartBlock(blocks[i]) then
      begin
        blocks.Exchange(0, i);
        Break;
      end;
  end;
var
  lengthOfList: integer;
  rightItem: integer;
  targetItem: integer;
  ABlockR: PSubBlock;
  ABlockT: PSubBlock;
begin
  SetFirstPoint();

  lengthOfList:= blocks.Count;
  targetItem:= 1;
  rightItem:= 0;

  while true do
  begin
    if rightItem = lengthOfList-1 then
      Break;

    ABlockT:= blocks[targetItem];
    ABlockR:= blocks[rightItem];

    if Crossed(ABlockR, ABlockT) then
    begin
      if not Ordered(ABlockR, ABlockT) then
        ChangePoints(ABlockT);
      Inc(rightItem);
      blocks.Exchange(targetItem, rightItem);
    end;

    if targetItem = lengthOfList-1 then
      targetItem:= rightItem;
    Inc(targetItem);
  end;
end;
//u-

end.
