unit esaRunObjects;

interface
uses ADODb, StdCtrls, Classes, Globals, Types, Forms, ExtCtrls, Windows, Gauges, esaResultVariants, esaGlobals;

//ul
const uAI=12;

type
  TDispatcher=class;
  TesaOpenpit=class;
  TesaAutos=class;
  TesaAuto=class;
  TesaResultBlockEvents=class;
  TesaResultExcavatorEvents=class;
  TesaResultUnloadingPunktEvents=class;

  //TesaDBCustomObject - ����� "������ ��� �������, ��������� � �������� ��" ------------------
  TesaDBObject = class
    procedure Clear;virtual;
  public
  end;{TesaDBObject}
  //TesaDBCustomObject - ����� "������ ��� �������, ��������� � �������� ��" ------------------
  TesaDBCustomObject = class(TesaDBObject)
  private
    FDispatcher: TDispatcher;//������ �� ���������
    function GetOpenpit: TesaOpenpit;
    function GetAutos: TesaAutos;
    function GetDBConnection : TADOConnection;
  public
    property Openpit: TesaOpenpit read GetOpenpit;
    property Autos: TesaAutos read GetAutos;
    property Dispatcher: TDispatcher read FDispatcher;
    property DBConnection: TADOConnection read GetDBConnection;
    //�������� ���� �������
    function CheckAllTerms: Boolean;virtual;
    //���������� ������ �� ���
    procedure RefreshData;virtual;
    //����������� ���������-������
    procedure SendCalcErrorMsg(const AMessage: String; const AIsFooter: Boolean = True);
    procedure SendInputDataErrorMsg(const AMessage: String; const AIsFooter: Boolean = True);
    //����������� ���������-��������������
    procedure SendWarningMsg(const AMessage: String);
    //����������� ���������
    procedure SendMessage(const AMessage: String; const AIsOtstup: Boolean=True);
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaDBCustomObject}


  //RESARoadCoatUSK - ������������ ��.������������� ������� ��������� ��������
  RESARoadCoatUSK=record
    Ptn    : Single; //������� �������� ����, �.
    WminHkH: Single; //�����.��������, �/��
    WmaxHkH: Single; //������.��������, �/��
    WavgHkH: Single; //������� ��������, �/��
  end;
  //TesaRoadCoat - ����� "�������� ��������" --------------------------------------------------
  TesaRoadCoat = class(TesaDBObject)
  private
    FId_RoadCoat       : Integer;                 //��� ��������� ��������
    FName              : String;                  //�������� ��������
    FItems             : array of RESARoadCoatUSK;//������ ����-��� ��.������������� �������
    FCount             : Integer;                 //����������
    //�������������� ����������
    FBuildingC1000tn   : Single; //������� �� ���������� ����������, ���.�����
    FKeepingYearC1000tn: Single; //���������� ����������, ���.�����/���
    FAmortizationR     : Single; //����� �����������
    function GetItem(const Index: Integer): RESARoadCoatUSK;
  public
    property Items[const Index: Integer]: RESARoadCoatUSK read GetItem;default;
    property Count: Integer read FCount;
    property Id_RoadCoat       : Integer read FId_RoadCoat;
    property Name              : String read FName;
    property BuildingC1000tn   : Single read FBuildingC1000tn;
    property KeepingYearC1000tn: Single read FKeepingYearC1000tn;
    property AmortizationR     : Single read FAmortizationR;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;override;
    function Wk(const AAutoP: Single): Single;
  end;{TesaRoadCoat}

  //TesaRoadCoats - ����� "�������� ��������" -------------------------------------------------
  TesaRoadCoats = class(TesaDBCustomObject)
  private
    FItems: array of TesaRoadCoat; //������ �������� ��������
    FCount: Integer;               //���������� �������� ��������
    function GetItem(const Index: Integer): TesaRoadCoat;
  public
    property Items[const Index: Integer]: TesaRoadCoat read GetItem;default;
    property Count: Integer read FCount;

    procedure Clear;override;
    function CheckAllTerms: Boolean;override;
    function FindBy(const AId_RoadCoat: Integer): Integer;
    procedure RefreshData;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaRoadCoats}

  //TesaRocks - ����� "���������� ������ ������ �� �������" -----------------------------------
  RESARock=record
    Id_Rock        : Integer;//��� ������ ������
    Name           : String; //������������ ������ ������
    IsMineralWealth: Boolean;//�������� ����������?
  end;{RESARock}
  TesaRocks = class(TesaDBCustomObject)
  private
    FItems: array of RESARock; //������ ������ �����
    FCount: Integer;          //���������� ������ �����
    function GetItem(const Index: Integer): RESARock;
  public
    property Items[const Index: Integer]: RESARock read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    procedure Clear;override;
    function CheckAllTerms: Boolean;override;
    procedure RefreshData;override;
    function FindBy(const AId_Rock: Integer): Integer;
  end;{TesaRocks}

  //TesaExcavatorModels - ����� "������ ������������" -----------------------------------------
  RESAExcavatorModel=record
    Id_Excavator  : Integer;//���������� ��� ������ �����������
    Name          : String; //������
    MaxVm3        : Single; //������� �����, �3
    MaxTsec       : Single; //����� �������� �����, �
    Id_Engine     : Integer;//��� ���������
    Engine        : String; //����� ���������
    EngineMaxNkVt : Single; //������������ �������� ���������, ���
    Lm            : Single; //�����, �
    Wm            : Single; //������, �
    Hm            : Single; //������, �
  end;
  TesaExcavatorModels = class(TesaDBCustomObject)
  private
    FItems: array of RESAExcavatorModel; //������ ������� ������������
    FCount: Integer;                      //���������� ������� ������������
    function GetItem(const Index: Integer): RESAExcavatorModel;
  public
    property Items[const Index: Integer]: RESAExcavatorModel read GetItem;default;
    property Count: Integer read FCount;
    procedure Clear;override;
    function FindBy(const AId_Excavator: Integer): Integer;
    function CheckAllTerms: Boolean;override;
    procedure RefreshData;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaExcavatorModels}

  //������� �������������� ������ �������������� ----------------------------------------------
  RESAAutoFk=record
    Vkmh: Single;//��������, ��/�
    FkH : Single;//���� ����, ��
  end;
  //TesaAutoModel - ����� "������ ����" -------------------------------------------------------
  TAutoTransmissionKind=(atkGM,atkEM); 
  RESAAutoModel = record
    Id_Auto         : Integer;//���������� ��� ������ �����������
    Name            : String; //������
    MaxVm3          : Single; //����� ������, �3
    MaxQtn          : Single; //����������������, �
    Ptn             : Single; //����� �������������, �
    F               : Single; //������� ������� �����������, �2
    Ro              : Single; //����-�� ������������ ����
    TransmissionKind: TAutoTransmissionKind;//��� �����������: 0-��, 1-��
    TransmissionKPD : Single; //��� �����������
    MaxTsec         : Single; //����� ���������, �
    Rmin            : Single; //����������� ������ ��������, �
    TyresCount      : Integer;//���������� ���
    Id_Engine       : Integer;//��� ���������
    Engine          : String; //����� ���������
    EngineMaxNkVt   : Single; //������������ �������� ���������, ���
    Lm              : Single; //�����, �
    Wm              : Single; //������, �
    Hm              : Single; //������, �
    MaxVkmh         : Single; //��������������� ��������, ��/�
    MaxFkH          : Single; //������������ ���� ����, ��
    Fks: array of RESAAutoFk; //������� ���������������
    FksCount: Integer;        //����������

    //�������������� ������� �� ������� ��������� ������ ��� ����
    SparesCpercent       : Single; //������� �� �������� � ���������, � % � �������� �� �������
    MaterialsCpercent    : Single; //������� �� ��������� ���������, � % � �������� �� �������
    MaintenanceMonthC1000tg: Single; //���������� ���������� ���������, ���.�����/���
    //
    CurrAmortizationCtg  : Single; //���������.������� �� ���� ���� ������ ������, �����
    CurrWorkCtg          : Single; //������� � ������ �� ���� ���� ������ ������, �����
    CurrWaitingCtg       : Single; //������� � ������� �� ���� ���� ������ ������, �����
  end;{RESAAutoModel}
  //TesaAutoModels - ����� "������ ��������������" --------------------------------------------
  TesaAutoModels = class(TesaDBCustomObject)
  private
    FItems: array of RESAAutoModel; //������ ������� ��������������
    FCount: Integer;                //���������� ������� ��������������
    function GetItem(const Index: Integer): RESAAutoModel;
  public
    property Items[const Index: Integer]: RESAAutoModel read GetItem;default;
    property Count: Integer read FCount;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    procedure Clear;override;
    function CheckAllTerms: Boolean;override;
    procedure RefreshData;override;
    function FindBy(const AId_Auto: Integer): Integer;
  end;{TesaAutoModels}

  TesaLoadingPunkt = class;
  //TesaExcavator - ����� "���������� ���������� �����" ---------------------------------------
  TesaExcavator = class(TesaDBCustomObject)
  private
    FLoadingPunkt      : TesaLoadingPunkt;
    FId_DeportExcavator: Integer; //���������� ��� ����������� ���������� �����
    FExcavatorIndex    : Integer; //������ ������ �����������
    FParkNo            : Integer; //����� � �����
    FEYear             : Integer; //��� �������
    FWorkState         : Boolean; //������� ���������: ��/���
    FC1000tg           : Single;  //���������, ���.��
    FTsec              : Single;  //����������� ����� �����, �
    FAddMaterialsMonthC1000tg  : Single;  //�������������� ����������� ������� �� ���������, ���.��/���
    FAddUnAccountedMonthC1000tg: Single;  //�������������� ����������� ������� ����������, ���.��/���
    FEngineKIM         : Single;  //����-�� ������������� �������� ���������, 0,25-0,35
    FEngineKPD         : Single;  //��� ���������, 0,936-0,948
    FName              : String;  //������������ �����������
    FSENAmortizationRate: Single; // ������� ����� ����������� �����������
    FEvents            : TesaResultExcavatorEvents;
    function GetModel: RESAExcavatorModel;
  public
    property Events            : TesaResultExcavatorEvents read FEvents;
    property Model             : RESAExcavatorModel read GetModel;
    property Id_DeportExcavator: Integer read FId_DeportExcavator;
    property ExcavatorIndex    : Integer read FExcavatorIndex;
    property ParkNo            : Integer read FParkNo;
    property EYear             : Integer read FEYear;
    property WorkState         : Boolean read FWorkState;
    property C1000tg           : Single read FC1000tg;
    property Tsec             : Single read FTsec;
    property AddMaterialsMonthC1000tg  : Single read FAddMaterialsMonthC1000tg;
    property AddUnAccountedMonthC1000tg: Single read FAddUnAccountedMonthC1000tg;
    property EngineKIM         : Single read FEngineKIM;
    property EngineKPD         : Single read FEngineKPD;
    property TotalName         : String read FName;
    property SENAmortizationRate : Single read FSENAmortizationRate;
    property LoadingPunkt      : TesaLoadingPunkt read FLoadingPunkt;

    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    procedure Clear; override;
  end;{TesaExcavator}

  //TesaExcavators - ����� "����������� ���������� �����" -------------------------------------
  TesaExcavators = class(TesaDBCustomObject)
  private
    FItems: array of TesaExcavator; //������ ������������ ���������� �����
    FCount: Integer;               //���������� ������������ ���������� �����
    FWorkedCount: Integer;         //���������� ������������ � ������� ���������
    function GetItem(const Index: Integer): TesaExcavator;
  public
    property Items[const Index: Integer]: TesaExcavator read GetItem;default;
    property Count: Integer read FCount;
    property WorkedCount: Integer read FWorkedCount;
    procedure Clear;override;
    function CheckAllTerms: Boolean;override;
    procedure RefreshData;override;
    function FindBy(const AId_DeportExcavator: Integer): Integer;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaExcavators}

  //������������ ����� �������������� ����� ������������---------------------------------------
  RESAAutoAccordance=Record
    Id_Auto: Integer;
    Id_Excavator: Integer;
  end;
  TesaAutoAccordances=class(TesaDBCustomObject)
  private
    FCount: Integer;
    FItems: array of RESAAutoAccordance;
  public
    function IsAccordance(const AId_Auto,AId_Excavator: Integer): Boolean;
    procedure RefreshData;override;
    procedure Clear;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaAutoAccordances}

  //TesaSubBlock - ����� "���-����-�������" ------------------------------------
  TesaBlock=class;
  TesaSubBlock=class(TesaDBCustomObject)
  private
    FCurrRightAutoIndex: Integer;//������ ����, ��������� ������ ������
    FCurrLeftAutoIndex : Integer;//������ ����, ��������� ����� ������
    FItems: TPoints3DArray;//������ �����
    FCount: Integer;       //���������� �����
    FBlockIndex: Integer;  //������ ��
    FLm        : Single;   //�����, �

    function GetItem(const Index: Integer): RPoint3D;
    function GetRoadCoat: TesaRoadCoat;
    function GetBlock: TesaBlock;
  public
    property Items[const Index: Integer]: RPoint3D read GetItem;default;
    property Count: Integer read FCount;
    property Lm: Single read FLm;
    property Block: TesaBlock read GetBlock;
    property RoadCoat: TesaRoadCoat read GetRoadCoat;

    procedure Clear;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaSubBlock}

  //TesaBlock - ����� "����-�������" ----------------------------------------------------------
  TesaBlock = class(TesaDBCustomObject)
  private
    FId_Block     : Integer;   //��� ����-�������
    FStripsN      : Byte;      //���������� ����� ��������
    FStripWm      : Single;    //������ ������ ��������, �
    FRoadCoatIndex: Integer;   //������ ��������� ��������
    FLoadingVmax  : Single;    //����������� ��������, ��/�
    FUnLoadingVmax: Single;    //����������� ��������, ��/�
    FKind         : TBlockKind;//��� ����-�������
    FLsm          : Integer;   //����� ����-�������, ��
    FId_Point0    : Integer;   //��� ��������� �����
    FId_Point1    : Integer;   //��� �������� �����

    FSubBlocks     : Array of TesaSubBlock;//Sub-����-�������
    FSubBlocksCount: Integer;              //���������� sub-����-��������
    FSumRockVolume: ResaRockVolume;//����� ������������ ������ �����, �3
    FSumAutoCount1: array[TAutoDirection,TAutoState]of Integer; //���������� ��������� ����
    FSumAutoDTsec1: array[TAutoDirection,TAutoState]of Single;  //����� �������� ����, sec
    FSumAutoGXltr1: array[TAutoDirection,TAutoState]of Single;  //������ �������, �
    FSumAutoV1    : array[TAutoDirection,TAutoState]of Single;  //��������� �������� ����, ��/�
    FSumAutoVCount1: array[TAutoDirection,TAutoState]of Integer; //���������� ��������� ��������
    FSumWgCount1  : array[TAutoDirection]of Integer;            //���������� ��������
    FEvents: TesaResultBlockEvents;
    function GetRoadCoat: TesaRoadCoat;
    function GetSubBlock(const Index: Integer): TesaSubBlock;
    //���������� �������� ���-����-��������
    procedure UpdateSubBlocks(APointsList: TList; const ABlockIndex: Integer);
  public
    property Events: TesaResultBlockEvents read FEvents;
    property Id_Block   : Integer read FId_Block;
    property Id_Point0  : Integer read FId_Point0;
    property Id_Point1  : Integer read FId_Point1;
    property StripsN : Byte read FStripsN;
    property StripWm : Single read FStripWm;
    property RoadCoatInd: Integer read FRoadCoatIndex;
    property RoadCoat   : TesaRoadCoat read GetRoadCoat;
    property LoadingVmax       : Single read FLoadingVmax;
    property UnLoadingVmax       : Single read FUnLoadingVmax;
    property Kind       : TBlockKind read FKind;
    property BlockLsm   : Integer read FLsm;
    property SubBlocksCount: Integer read FSubBlocksCount;
    property SubBlocks[const Index: Integer]: TesaSubBlock read GetSubBlock;
    procedure Clear;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaBlock}

  //TesaBlocks - ����� "����-�������" ---------------------------------------------------------
  TesaBlocks = class(TesaDBCustomObject)
  private
    FCount: Integer;            //���������� ����-��������
    FItems: array of TesaBlock; //����-�������
    FSubBlocksCount: Integer;   //���������� sub-����-�������� ���� ����-��������
    function GetItem(const Index: Integer): TesaBlock;
  public
    property Items[const Index: Integer]: TesaBlock read GetItem;default;
    property Count: Integer read FCount;
    function FindBy(const AId_Block: Integer): Integer;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    procedure Clear;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaBlocks}

  //TesaPunkt - ����� "�����" -----------------------------------------------------------------
  TesaPunkt = class(TesaDBCustomObject)
  private
    FId_Punkt: Integer;
    FId_Point: Integer;
    FCoords  : RPoint3D;
  public
    property Id_Point: Integer read FId_Point;
    property Coords: RPoint3D read FCoords;
    property Id_Punkt: Integer read FId_Punkt;
    property Horizont: Single read FCoords.Z;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaPunkt}

  //TesaLoadingPunktRock - ����� "���������� ������ ������ �� ������ ��������" ----------------
  TesaLoadingPunktRock = class(TesaDBCustomObject)
  private
    FRockIndex     : Integer;         //������ ���� ����������� ������
    FContent       : Single;          //���������� ��������� ����������� � ����, % >=0.0
    FPeriodPlanQtn : Single;          //���� �� ������, �. >=0.0
    FDensityInBlock: Single;          //��������� � ������, �/�3
    FShatteringCoef: Single;          //����������� �����������
    FShiftFactRock : ResaRockVolume;  //����� ����������� ������ �����, �3
    function GetRock: RESARock;
    function GetShiftFactRemainingQtn: Single;
    function GetShiftPlanQtn : Single;
  public
    property Content              : Single read FContent;
    property PeriodPlanQtn        : Single read FPeriodPlanQtn;
    property ShiftPlanQtn         : Single read GetShiftPlanQtn;
    property ShiftFactRock        : ResaRockVolume read FShiftFactRock;
    property ShiftFactRemainingQtn: Single read GetShiftFactRemainingQtn;//���������� ��, �
    property Rock: RESARock read GetRock;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    procedure AddShiftFactRock(const AShiftFactVm3,AShiftFactQtn: Single);
  end;{TesaLoadingPunktRock}

  //TesaLoadingPunkt - ����� "����� ��������" -------------------------------------------------
  TesaLoadingPunkt = class(TesaPunkt)
  private
    FId_LoadingPunkt: Integer; //��� ������ ��������
    FExcavatorIndex : Integer; //������ �����������, ������������� �� ��
    FName           : String;
    FExcavatorName  : String;
    FPeriodPlanVm3  : Single; //�������� ����� �� �� ������, �3
    FPeriodPlanQtn  : Single; //�������� ����� �� �� ������, �
    FShiftFactVm3   : Single; //����������� ����� �� �� �����, �3
    FShiftFactQtn   : Single; //����������� ����� �� �� �����, �
    FCount: Integer;                      //���������� ������ �����, ���������� �� ������ ��
    FItems: array of TesaLoadingPunktRock;//������ ������ �����, ���������� �� ������ ��

    FCurrState   : TPunktState;//��������� �����������
    FSumDTsec    : array[TPunktState] of Integer;//����� ������, �������, �������, sec
    FSumAutoCount: Integer;//�-�� ����������� ����

    function GetItem(const Index: Integer): TesaLoadingPunktRock;
    function GetExcavator: TesaExcavator;
    function GetId_Excavator: Integer;
    function GetShiftPlanVm3: Single;
    function GetShiftPlanQtn: Single;
  public
    property PeriodPlanVm3: Single read FPeriodPlanVm3;
    property PeriodPlanQtn: Single read FPeriodPlanQtn;
    property ShiftPlanVm3 : Single read GetShiftPlanVm3;
    property ShiftPlanQtn : Single read GetShiftPlanQtn;
    property ShiftFactVm3 : Single read FShiftFactVm3;
    property ShiftFactQtn : Single read FShiftFactQtn;
    property RockCount: Integer read FCount;
    property Rocks[const Index: Integer]: TesaLoadingPunktRock read GetItem;default;
    property Id_LoadingPunkt: Integer read FId_LoadingPunkt;
    property Excavator: TesaExcavator read GetExcavator;
    property Id_Excavator: Integer read GetId_Excavator;
    property ExcavatorName: String read FExcavatorName;
    property Name: String read FName;
    procedure Clear;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    function IndexOf(const AId_Rock: Integer): Integer;
    procedure AddPeriodPlanRock(const APeriodPlanVm3,APeriodPlanQtn: Single);
  end;

  //TesaLoadingPunkts - ����� "������ ��������" -----------------------------------------------
  TesaLoadingPunkts = class(TesaDBCustomObject)
  private
    FCount: Integer;                  //���������� ������� ��������
    FItems: array of TesaLoadingPunkt; //������ ������� ��������
    FPlannedStrippingCoef: Single;//����������� ����������� �������, �/�
    FPlannedStrippingCoefVm3: Single;//����������� ����������� �������, �3/�3
    FRocksContentMin: Single; //����������� ���������� ��������� ����������� �� ������� ��������, %
    FRocksContentMax: Single; //������������ ���������� ��������� ����������� �� ������� ��������, %
    //FPlanRockVolume: RRockVolume; //�������� ����� ��� ������� ��������
    function GetItem(const Index: Integer): TesaLoadingPunkt;
    function GetPlanRockVolume: RRockVolume;
  public
    property Items[const Index: Integer]: TesaLoadingPunkt read GetItem;default;
    property Count: Integer read FCount;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    procedure Clear;override;
    function FindBy(const AId_Point: Integer): Integer;
    function IndexOf(const AId_LoadingPunkt: Integer): Integer;

    property RocksContentMin: Single read FRocksContentMin;
    property RocksContentMax: Single read FRocksContentMax;
    property PlanRockVolume: RRockVolume read GetPlanRockVolume;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaLoadingPunkts}

  //TesaUnLoadingPunktRock - ����� "������ ������ �� ������ ���������" ------------------------
  TesaUnLoadingPunktRock = class(TesaDBCustomObject)
  private
    FId_UnLoadingPunktRock: Integer; //��� ������ ������
    FRockIndex      : Integer; //������ ������ ������
    FRequiredContent: Single;  //��������� ����������, %
    FInitialContent : Single;  //���������� �� ������ �����, %
    FInitialVm3     : Single;  //����� �� ������ �����, �3
    FInitialQtn     : Single;  //����� �� ������ �����, �

    FCurrRockVolume : ResaRockVolume;//����� ������������ ������ �����, �3
    FCurrContent : Single;//������� ����������, %
    FSumAutoCount: Integer;//���������� ������������ ����
    function GetRock: RESARock;
  public
    property RequiredContent: Single read FRequiredContent;
    property InitialContent : Single read FInitialContent;
    property InitialVm3     : Single read FInitialVm3;
    property InitialQtn     : Single read FInitialQtn;
    property Rock: RESARock read GetRock;
    constructor Create(ADispatcher: TDispatcher);
    procedure Clear; override;
  end;{TesaUnLoadingPunktRock}


  //TesaUnLoadingPunkt - ����� "����� ���������" ----------------------------------------------
  TesaUnLoadingPunkt = class(TesaPunkt)
  private
    FId_UnLoadingPunkt: Integer;            //��� ������ ��������� (��)
    FCount: Integer;                        //���������� ������ �����, ���������� �� ������ ��
    FItems: array of TesaUnLoadingPunktRock;//������ ������ �����, ���������� �� ������ ��
    FMaxVm3           : Single;             //������� ��������� �������, �3
    FAutoMaxCount     : Integer;            //����� ����, �-� ����� ���������� �� ������
    FKind             : TUnLoadingPunktKind;//��� ������ ���������
    FName             : String;

    FCurrState        : TPunktState;//��������� ��
    FCurrAutoCount    : Integer;//���������� �������������� ����
    FSumDTsec         : array[TPunktState] of Integer;//����� ������, �������, �������, ���

    FCostsWork        : Single; //������� � ������, ��
    FCostsProstoy     : Single; //������� � �������, ��
    FAmortizationCtg  : Single; //��������������� ����������, ��
    FCostsSummary     : Single; //��������� �������, ��
    FEvents           : TesaResultUnloadingPunktEvents;
    function GetItem(const Index: Integer): TesaUnLoadingPunktRock;
    function GetIsEmpty: Boolean;//�������� ���?
  public
    property Events           : TesaResultUnloadingPunktEvents read FEvents;
    procedure Clear;override;
    property RockCount: Integer read FCount;
    property Rocks[const Index: Integer]: TesaUnLoadingPunktRock read GetItem;default;
    property Id_UnLoadingPunkt: Integer read FId_UnLoadingPunkt;
    property MaxVm3: Single read FMaxVm3;
    property AutoMaxCount: Integer read FAutoMaxCount;
    property Kind: TUnLoadingPunktKind read FKind;
    property Name: String read FName;
    property IsEmpty: Boolean read GetIsEmpty;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    function IndexOf(const AId_Rock: Integer): Integer;
  end;

  //TesaUnLoadingPunkts - ����� "������ ��������" ---------------------------------------------
  TesaUnLoadingPunkts = class(TesaDBCustomObject)
  private
    FCount: Integer;                     //���������� ������� ���������
    FItems: array of TesaUnLoadingPunkt; //������ ������� ���������
    function GetItem(const Index: Integer): TesaUnLoadingPunkt;
  public
    property Items[const Index: Integer]: TesaUnLoadingPunkt read GetItem;default;
    property Count: Integer read FCount;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    procedure Clear;override;
    function FindBy(const AId_Point: Integer): Integer;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaUnLoadingPunkts}
  
  //TesaShiftPunkts - ����� "������ ����������" -----------------------------------------------
  TesaShiftPunkt = class(TesaPunkt)
  private
    FId_ShiftPunkt: Integer;  //��� ������ ����������
    FName         : String;
  public
    property Id_ShiftPunkt: Integer read FId_ShiftPunkt;
    property Name: String read FName;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaShiftPunkt}
  TesaShiftPunkts = class(TesaDBCustomObject)
  private
    FCount: Integer;                 //���������� ������� ����������
    FItems: array of TesaShiftPunkt; //������ ������� ����������
    function GetItem(Index: Integer): TesaShiftPunkt;
    function IndexOf(const AId_ShiftPunkt: Integer): Integer;
  public
    property Items[Index: Integer]: TesaShiftPunkt read GetItem;default;
    property Count: Integer read FCount;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    procedure Clear;override;
    function FindBy(const AId_Point: Integer): Integer;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaShiftPunkts}

  TesaCourse=class;
  //TesaCourseBlock - ����� "����-������� �������� ��������" ----------------------------------
  TesaCourseBlock = class(TesaDBCustomObject)
  private
    FCourseIndex  : Integer;//������ ��������
    FBlockIndex   : Integer;//������ ����-�������
    FBlockSubIndex: Integer;//������ sub-����-������� ����-������� � �������� FBlockInd

    FPoints: TPoints3DArray;
    FCount: Integer;

    FLm       : Single;  //�����, �
    FIsRightDirection: Boolean;//����������� ����-������� � �������� ���������

    function GetBlock        : TesaBlock;
    function GetBlockRoadCoat: TesaRoadCoat;
    function GetBlockKind    : TBlockKind;
    function GetCourse       : TesaCourse;
    procedure SetLeftAutoIndex(const Value: Integer);
    procedure SetRightAutoIndex(const Value: Integer);
    function  GetLeftAutoIndex: Integer;
    function  GetRightAutoIndex : Integer;
    function GetPoint0: RPoint3D;
    function GetPoint1: RPoint3D;
    procedure Update;
  public
    property Block   : TesaBlock read GetBlock;
    property Kind: TBlockKind read GetBlockKind;
    property RoadCoat: TesaRoadCoat read GetBlockRoadCoat;
    property Course  : TesaCourse read GetCourse;
    property LeftAutoIndex: Integer read GetLeftAutoIndex write SetLeftAutoIndex;
    property RightAutoIndex: Integer read GetRightAutoIndex write SetRightAutoIndex;
    property Point0          : RPoint3D read GetPoint0;
    property Point1          : RPoint3D read GetPoint1;
    property Lm          : Single read FLm;
    property IsRightDirection: Boolean read FIsRightDirection;
    constructor Create(ADispatcher: TDispatcher);
    procedure Clear;override;
  end;{TesaCourseBlock}

  //TesaCourse - ����� "������� ��������" -----------------------------------------------------
  TCourseKind=(ckCourseMoving,ckCourseSP_LP,ckCourseUP_SP);
  TesaCourse = class(TesaDBCustomObject)
  private
    FId_Course  : Integer;          //��� ��������
    FCourseIndex: Integer;          //������ ��������
    FPunktIndex0: Integer;          //������ ���������� ������
    FPunktIndex1: Integer;          //������ ��������� ������
    FId_Point0  : Integer;          //��� ��������� �����
    FId_Point1  : Integer;          //��� �������� �����
    FKind       : TCourseKind;      //��� ��������
    FLm         : Single;           //����� ��������, �
    FItems      : array of TesaCourseBlock;//����-������� ��������
    FCount      : Integer;                 //���������� ����-��������
    FName       : String;
    function GetItem(const Index: Integer): TesaCourseBlock;
    function GetPunkt0: TesaPunkt;
    function GetPunkt1: TesaPunkt;
    function GetFirst: TesaCourseBlock;
    function GetLast: TesaCourseBlock;
    procedure Update(const ABlockIndexes: TIntegerDynArray; const ABlocksCount: Integer);
  public
    property Id_Course   : Integer read FId_Course;
    property Punkt0      : TesaPunkt read GetPunkt0;
    property Punkt1      : TesaPunkt read GetPunkt1;
    property First       : TesaCourseBlock read GetFirst;
    property Last        : TesaCourseBlock read GetLast;
    property Kind        : TCourseKind read FKind;
    property Items[const Index: Integer]: TesaCourseBlock read GetItem;default;
    property Count: Integer read FCount;
    property Lm: Single read FLm;
    property Name        : String read FName;

    procedure Clear;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaCourse}

  //TesaCourses - ����� "�������� ��������" ---------------------------------------------------
  TesaCourses = class(TesaDBCustomObject)
  private
    FCount: Integer;            //���������� ���������
    FItems: array of TesaCourse; //��������
    function GetItem(const Index: Integer): TesaCourse;
  public
    property Items[const Index: Integer]: TesaCourse read GetItem;default;
    property Count: Integer read FCount;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    procedure Clear;override;
    function FindBy(const AId_Course: Integer): Integer;overload;
    function FindBy(const AId_Point0,AId_Point1: Integer): Integer;overload;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaCourses}


  //��� �������: 1-��������, 2-�������, 3-�������
  TesaResultExcavatorEventKind = (eekNone,eekLoading,eekWaiting,eekManevr);
  //������� ����������� --------------------------------------------------------
  TesaResultExcavatorEvent = class
  private
    FKind        : TesaResultExcavatorEventKind; //��� �������
    FTsec        : Single;                       //����������������� ��������, ���
    FGx          : Single;                       //������ �������, ���*�
    FRock        : RESARock;                     //����������� ��
    FRockVolume  : ResaRockVolume;               //����� ����������� ��
    FId_DumpModel: Integer;                      //��� ������ �������������
    FDumpModel   : String;                       //������
    FDumpNo      : Integer;                      //����� � �����
  public
    property Kind        : TesaResultExcavatorEventKind read FKind;
    property Tsec        : Single read FTsec;
    property Gx          : Single read FGx;
    property Rock        : RESARock read FRock;
    property RockVolume  : ResaRockVolume read FRockVolume;
    property Id_DumpModel: Integer read FId_DumpModel;
    property DumpModel   : String read FDumpModel;
    property DumpNo      : Integer read FDumpNo;
    constructor Create; virtual;
  end;{TesaResultExcavatorEvent}
  //������� ����������� --------------------------------------------------------
  TesaResultExcavatorEvents = class
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultExcavatorEvent;
    function _GetItem(const Index: Integer): TesaResultExcavatorEvent;
    function GetFirst: TesaResultExcavatorEvent;
    function GetLast: TesaResultExcavatorEvent;
  protected
    property Items[const Index: Integer]: TesaResultExcavatorEvent read GetItem; default;
    property _Items[const Index: Integer]: TesaResultExcavatorEvent read _GetItem;
    property Count: Integer read FCount;
    property First: TesaResultExcavatorEvent read GetFirst;
    property Last: TesaResultExcavatorEvent read GetLast;
    procedure Clear;
    procedure Append;
    //��������
    procedure Loading(const dTsec: Integer; const ARock: ResaRock; const ARockVolume: ResaRockVolume; const AAuto: TesaAuto);
    //�������
    procedure Manevr(const AGx: Single; const dTsec: Integer; const AAuto: TesaAuto);
  public
    constructor Create; virtual;                
    destructor Destroy; override;                
  end;{TesaResultExcavatorEvents}

  //��� �������: 1-��������, 2-�������, 3-�������
  TesaResultUnloadingPunktEventKind = (uekNone,uekLoading,uekWaiting,uekManevr);
  //������� �� ------------------------------------------------------------------------------------------
  TesaResultUnloadingPunktEvent = class
  private
    FKind        : TesaResultUnloadingPunktEventKind; //��� �������
    FTsec        : Single;                            //����������������� ��������, ���
    FRock        : RESARock;                          //������������ ��
    FRockVolume  : ResaRockVolume;                    //����� ������������ ��
    FRockContent : Single;                            //����������, %
    FId_DumpModel: Integer;                           //��� ������ �������������
    FDumpModel   : String;                            //������
    FDumpNo      : Integer;                           //����� � �����
  public
    property Kind        : TesaResultUnloadingPunktEventKind read FKind;
    property Tsec        : Single read FTsec;
    property Rock        : RESARock read FRock;
    property RockVolume  : ResaRockVolume read FRockVolume;
    property RockContent : Single read FRockContent;
    property Id_DumpModel: Integer read FId_DumpModel;
    property DumpModel   : String read FDumpModel;
    property DumpNo      : Integer read FDumpNo;
    constructor Create; virtual;
  end;{TesaResultUnloadingPunktEvent}
  //������� �� ------------------------------------------------------------------------------------------
  TesaResultUnloadingPunktEvents = class
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultUnloadingPunktEvent;
    function _GetItem(const Index: Integer): TesaResultUnloadingPunktEvent;
    function GetFirst: TesaResultUnloadingPunktEvent;
    function GetLast: TesaResultUnloadingPunktEvent;
  protected
    property Items[const Index: Integer]: TesaResultUnloadingPunktEvent read GetItem; default;
    property _Items[const Index: Integer]: TesaResultUnloadingPunktEvent read _GetItem;
    property Count: Integer read FCount;
    property First: TesaResultUnloadingPunktEvent read GetFirst;
    property Last: TesaResultUnloadingPunktEvent read GetLast;
    procedure Clear;
    procedure Append;
    //��������
    procedure UnLoading(const dTsec: Integer; const ARock: ResaRock; const ARockVolume: ResaRockVolume; const ARockContent: Single; const AAuto: TesaAuto);
    //�������
    procedure Manevr(const AGx: Single; const dTsec: Integer; const AAuto: TesaAuto);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;{TesaResultUnloadingPunktEvents}

  //��� �������: 1-��������, 2-���������, 3-�������, 4-��������, 5-�������, 6-���, 7-������
  TesaResultAutoEventKind = (ekNone,ekLoadingPunkt,ekUnLoadingPunkt,ekWaiting,ekMoving,ekManevr, ekATC, ekAbort);
  //����������� �������� (��� Kind=ekMoving or ekManevr): 1-���������, 2-������������, 3-�������
  TesaResultAutoEventDirection = (edNone,edLoading,edUnLoading,edNulled);
  //������� ������������� ------------------------------------------------------
  TesaResultAutoEvent = class
  private
    FKind      : TesaResultAutoEventKind;      //��� �������
    FDirection : TesaResultAutoEventDirection; //����������� ��������
    FIdPunkt0  : Integer;                //��� ���������� �������
    FHorizont0 : Single;                 //�������� ���������� �������
    FIdPunkt1  : Integer;                //��� ��������� �������
    FHorizont1 : Single;                 //�������� ��������� �������
    FSm        : Single;                 //���������� ����������, �
    FTsec      : Single;                 //����������������� ��������, ���
    FGx        : Single;                 //������ �������, �
    FId_Rock   : Integer;                //��� ����������� ��
    FRock      : String;                 //������������ ����������� ��
    FRockIsMineralWealth: Boolean;       //������� ��������� ����������� ����������� ��
    FQuality  :   Single;
    FRockVolume         : ResaRockVolume;//����� ����������� ��, �3
    FAvgVkmh            : ResaDrobValue; //������� �������� ��������, ��/�
  public
    property Kind      : TesaResultAutoEventKind read FKind;
    property Direction : TesaResultAutoEventDirection read FDirection;
    property IdPunkt0 : Integer read FIdPunkt0;
    property Horizont0 : Single read FHorizont0;
    property IdPunkt1 : Integer read FIdPunkt1;
    property Horizont1 : Single read FHorizont1;
    property Sm        : Single read FSm;
    property Tsec      : Single read FTsec;
    property Gx        : Single read FGx;
    property Id_Rock   : Integer read FId_Rock;
    property Rock      : String read FRock;
    property RockIsMineralWealth: Boolean read FRockIsMineralWealth;
    property RockVolume: ResaRockVolume read FRockVolume;
    property AvgVkmh   : ResaDrobValue read FAvgVkmh;
    constructor Create; virtual;
  end;{TesaResultAutoEvent}
  //������� ������������� ------------------------------------------------------
  TesaResultAutoEvents = class(TesaResultAutoEvent)
  private
    FItems     : TList;
    FCount     : Integer;
    //������� �������� ��� �������� �� ����-�������� ��������(�������� �� ��������)
    FWAvgHmNum : Single;                 //��������� ������� ������ ������� �� = Hm0+..+HmN
    FWAvgHmDen : Single;                 //��������� ������� ������ ������� �� = N
    FAvgHmNum  : Single;                 //��������� ������� ������ ������� �� = Hm0+..+HmN
    FAvgHmDen  : Single;                 //����������� ������� ������ ������� �� = N
    function GetItem(const Index: Integer): TesaResultAutoEvent;
    function _GetItem(const Index: Integer): TesaResultAutoEvent;
    function GetFirst: TesaResultAutoEvent;
    function GetLast: TesaResultAutoEvent;
  protected
    property Items[const Index: Integer]: TesaResultAutoEvent read GetItem; default;
    property _Items[const Index: Integer]: TesaResultAutoEvent read _GetItem;
    property Count: Integer read FCount;
    property First: TesaResultAutoEvent read GetFirst;
    property Last: TesaResultAutoEvent read GetLast;
    procedure Clear;
    procedure Append;
    //����� ����������
    procedure Shifting(const APunkt: TesaPunkt);
    //�������������� ����������
    procedure Aborting(const dTsec: Single; const AKind: TesaResultAutoEventKind; const ADirection: TesaResultAutoEventDirection);
    //��������
    procedure Loading(const AGx: Single; const dTsec: Integer; const APunkt: TesaPunkt);
    //���������
    procedure UnLoading(const AGx: Single; const dTsec: Integer; const ARock: RESARock; const ARockVolume: ResaRockVolume; const APunkt: TesaPunkt);
    //�������
    procedure Waiting(const AGx: Single; const dTsec: Integer; const ADir: TesaResultAutoEventDirection; const ARock: RESARock; const ARockVolume: ResaRockVolume; const APunkt0,APunkt1: TesaPunkt);
    //�������
    procedure Manevr(const AGx: Single; const dTsec: Integer; const ADir: TesaResultAutoEventDirection; const AId_Punkt0,AId_Punkt1: Integer; const ARock: RESARock; const ARockVolume: ResaRockVolume; const AWAvgHmNum,AWAvgHmDen,AAvgHmNum,AAvgHmDen,AAvgVkmhNum,AAvgVkmhDen,Sm: Single);
    //��������
    procedure Moving;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;{TesaResultAutoEvents}

  //��� �������: 1-�������, 2-��������, 3-�������
  TesaResultBlockEventKind = (bekNone,bekWaiting,bekMoving,bekManevr);
  //������� ����-������� -------------------------------------------------------
  TesaResultBlockEvent = class
  private
    FRockVolume            : ResaRockVolume;//����������� ��

    FMovingTminNulled      : ResaDrobValue;    //����� �������� � ������� �����������, ���
    FMovingTminLoading     : ResaDrobValue;    //����� �������� � �������� �����������, ���
    FMovingTminUnLoading   : ResaDrobValue;    //����� �������� � ������������ �����������, ���

    FWaitingTminNulled     : ResaDrobValue;    //����� �������� � ������� �����������, ���
    FWaitingTminLoading    : ResaDrobValue;    //����� �������� � �������� �����������, ���
    FWaitingTminUnLoading  : ResaDrobValue;    //����� �������� � ������������ �����������, ���

    FMovingGx              : ResaDirectionValue;//������ ������� � �������� �� ������������, �
    FWaitingGx             : ResaDirectionValue;//������ ������� � ������� �� ������������, �

    FVkmhNulled            : ResaDrobValue;      //�������� �������� � ������� �����������, ��/� (���������)
    FVkmhLoading           : ResaDrobValue;      //�������� �������� � �������� �����������, ��/� (���������)
    FVkmhUnLoading         : ResaDrobValue;      //�������� �������� � ������������ �����������, ��/� (���������)

    FWaitingsCount         : ResaDirectionValue; //���������� �������� �� ������������
    FAutosCount            : ResaDirectionValue; //���������� �������������� �� ������������
  public
    property RockVolume            : ResaRockVolume read FRockVolume;

    property MovingTminNulled      : ResaDrobValue read FMovingTminNulled;
    property MovingTminLoading     : ResaDrobValue read FMovingTminLoading;
    property MovingTminUnLoading   : ResaDrobValue read FMovingTminUnLoading;
    
    property WaitingTminNulled     : ResaDrobValue read FWaitingTminNulled;
    property WaitingTminLoading    : ResaDrobValue read FWaitingTminLoading;
    property WaitingTminUnLoading  : ResaDrobValue read FWaitingTminUnLoading;

    property MovingGx              : ResaDirectionValue read FMovingGx;
    property WaitingGx             : ResaDirectionValue read FWaitingGx;

    property VkmhNulled            : ResaDrobValue read FVkmhNulled;
    property VkmhLoading           : ResaDrobValue read FVkmhLoading;
    property VkmhUnLoading         : ResaDrobValue read FVkmhUnLoading;

    property WaitingsCount         : ResaDirectionValue read FWaitingsCount;
    property AutosCount            : ResaDirectionValue read FAutosCount;

    procedure Clear; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(ADect: TesaResultBlockEvent);
  end;{TesaResultBlockEvent}
  //������� ����-������� -------------------------------------------------------
  TesaResultBlockEvents = class(TesaResultBlockEvent)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultBlockEvent;
    function _GetItem(const Index: Integer): TesaResultBlockEvent;
    function GetFirst: TesaResultBlockEvent;
    function GetLast: TesaResultBlockEvent;
  protected
    property Items[const Index: Integer]: TesaResultBlockEvent read GetItem; default;
    property _Items[const Index: Integer]: TesaResultBlockEvent read _GetItem;
    property Count: Integer read FCount;
    property First: TesaResultBlockEvent read GetFirst;
    property Last: TesaResultBlockEvent read GetLast;
    //������������ ������
    procedure Accumulate(
      const ADir   : TAutoDirection;
      const AState : TAutoState;
      const AAuto  : TesaAuto;
      const AIsDone: Boolean = False);
  public
    procedure Clear; override;
    constructor Create; override;
  end;{TesaResultBlockEvents}


  //TesaAuto - ����� "������������ ���������� �����" ------------------------------------------
  TesaAmortizationKind = (akYear,ak1000km);
  TesaAuto = class(TesaDBCustomObject)
  private
    FId_DeportAuto   : Integer; //���������� ��� ������������� ���������� �����
    FAutoModelIndex  : Integer; //������ ������ �������������
    FName            : String;
    FParkNo          : Integer; //����� � �����
    FAYear           : Integer; //��� �������
    FWorkState       : Boolean; //������� ���������: ��/���
    FFactTonnage     : Single;  //����������� ����������������, �
    FC1000tg         : Single;  //���������, ���.��
    FAmortizationKind: TesaAmortizationKind;  //��� �����������: �������/�� 1 ���.��
    FAmortizationRate: Single;  //����� �����������: �������/�� 1 ���.��
    FTransmissionKPD : Single;  //��� �����������, 0..1
    FEngineKPD               : Single;  //��� ���������, 0..1
    FTyreC1000tg             : Single;  //��������� 1 ����, ���.��
    FTyresAmortizationR1000km: Single;  //����� ������� ���, ���.��.
    FShiftPunktIndex         : Integer; //��� ������ ����������
    FCourseIndex             : Integer; //��� �������� ��������, �� ������� ��������� ����

    FCurrCourseIndex      : Integer;//������ �������� �������� ��������
    FCurrCourseBlockIndex : Integer;//������ sub-����-�������
    FCurrPunktIndex       : Integer;//������ ������ ��������/���������/����������
    FCurrState            : TAutoState;//��������� �������� ����
    FCurrDirection        : TAutoDirection;//����������� ����
    FCurrPosition         : TAutoPosition;//��������� ����

    FCurrRockLoadingPunktIndex    : Integer;//������ ��, ������ ������� �� ������ ������ ��
    FCurrRockLoadingPunktRockIndex: Integer;//������ �� ������� ��, ����������� �� �.������
    FCurrRockVolumeRequired       : ResaRockVolume; //V ��, �-� ������� ���������, �3
    FCurrRock                     : RESARock;
    FCurrRockVolume               : ResaRockVolume; //����� ����������� �� ������ ������ ��, �3
    FCurrRockContent              : Single; //���������� ����������� �� ������ ������ ��, �/��

    FSumRocksVm3          : Single;//����� ������������ ��, �3
    FSumRocksQtn          : Single;//����� ������������ ��, �
    FSumDSmtr: array[TAutoDirection,TAutoPosition,TAutoState]of Single;//�������. ����������, �
    FSumDTsec: array[TAutoDirection,TAutoPosition,TAutoState]of Single;//����������� �����, sec
    FSumGXltr: array[TAutoDirection,TAutoPosition,TAutoState]of Single;//����������� �������, �
    FSumQtnDSkm           : Single;//=Skm_j * RockQtn, ��*� - ��� ���������.�����-� �����-���
    FSumHmtr              : Single;//=Hm_j * Lm_j, �*� - ��� ���������.������ ������� ��
    FSumHLmtr             : Single;//=Lm_j1+..+Lm_jn, � - ����� ���� ����� ������� ��
    FSumTripsCount        : array[TAutoDirection]of Integer;//���������� ������
    FSumVavg              : Single;//����� ��������� �������� �� ��������, ��/� (��.V ��������)
    FSumVavgCount         : Integer;//���-�� �������� ��������� �������� (��.V ��������)

    FAutoIndex            : Integer; //������ ���� � ��������� �����
    FCurrPoint            : RPoint3D;//������� ����������
    FCurrIndentPoint      : RPoint3D;//������� ��������� ����������
    FCurrZenit            : Single;  //�����, ����
    FCurrAzimut           : Single;  //������, ����
    FCurrV0               : Single;  //��������� �������� �� ���.��, ��/�
    FCurrV1               : Single;  //�������� �������� �� ���.��, ��/�
    FCurrV                : Single;  //������� �������� �� ���.��, ��/�
    FCurrVavg             : Single;  //������� �������� �� ���.��, ��/�
    FCurrW0               : Single;  //��������� ������ ������������� �������� �� ���.��, k�
    FCurrW1               : Single;  //�������� ������ ������������� �������� �� ���.��, k�
    FCurrW                : Single;  //������� ������������� �������� �� ���.��, k�

    FCurrGx               : Single;//��������������� ������� ��� ���������� ����� ��, �
    FCurrGxReq            : Single;//����������� ������� ��� ����������� ��, �
    FCurrDt0Sec           : Integer;//����������� ����� ��� ���������� ����� ��, sec
    FCurrDt1Sec           : Integer;//���������� ����� ��� ����������� ��, sec
    FCurrDtReqSec         : Integer;//������ ����� ��� ����������� ��, sec

    FEvents               : TesaResultAutoEvents; //������� �������������

    function GetModel: RESAAutoModel;
    function GetId_Auto: Integer;
    function GetCourse: TesaCourse;
    function GetCourseBlock: TesaCourseBlock;
    function GetCurrCourse: TesaCourse;
    function GetCurrCourseBlock: TesaCourseBlock;
    function GetShiftPunkt: TesaShiftPunkt;
    function GetRock: RESARock;
    function GetLoadingPunktRock: TesaLoadingPunktRock;

    //��������� � ��������� ��� ��������� ���������?
    function GetIsStopped: Boolean;
    //��������� � �������(� NOT IsStopped)?
    function GetIsWaiting: Boolean;
    //��������� � ������(NOT IsStopped � NOT IsWaiting)?
    function GetIsWorking: Boolean;
    //��������� �� ������ ���������?
    function GetIsOnUnloadingPunkt: Boolean;
    function GetCurrCourseBlockHmtr: Single;
  public
    property Events                  : TesaResultAutoEvents read FEvents;
    property TyreC1000tg             : Single read FTyreC1000tg;
    property TyresAmortizationR1000km: Single read FTyresAmortizationR1000km;
    property AutoIndex: Integer read FAutoIndex;
    property Model: RESAAutoModel read GetModel;
    property Id_Auto: Integer read GetId_Auto;
    property Course: TesaCourse read GetCourse;
    property Block: TesaCourseBlock read GetCourseBlock;
    property CurrCourse: TesaCourse read GetCurrCourse;
    property CurrBlock: TesaCourseBlock read GetCurrCourseBlock;
    property CurrBlockHmtr: Single read GetCurrCourseBlockHmtr;
    property ShiftPunkt: TesaShiftPunkt read GetShiftPunkt;
    property Name: String read FName;
    property IsStopped: Boolean read GetIsStopped;
    property IsWaiting: Boolean read GetIsWaiting;
    property IsWorking: Boolean read GetIsWorking;
    property IsOnUnloadingPunkt: Boolean read GetIsOnUnloadingPunkt;
    property Rock: RESARock read GetRock;
    property LoadingPunktRock: TesaLoadingPunktRock read GetLoadingPunktRock;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    procedure Clear;override;
    //����������� ���� ���� FkH, H
    function DefineFH(Vkmh: Single): Single;
    //����������� �����.������������� ������� w0, H
    function DefineW0_(const Ptn, Q: Single; const ARoadCoat: TesaRoadCoat): Single;
    //����������� ������� ������������� �� ��������� �����, W��, �
    function DefineWv(const Vkmh: Single): Single;
    //��������� �������� ������ ������� ��� ����������� �������� ��������� g�, �/���*�
    function DefineGn_(): Single;
    //��������� �������� ������ ������� ��� ��������(������� �����) g�, �/��
    function DefineGd_(Ga,Ggm,wo_,wi_: Single): Single;
    //��������� �������� ������ ������� ��� ��������/���������/������.������� gi, �/�
    function DefineGi_(): Single;
  end;{TesaAuto}

  //TesaAutos - ����� "������������� ���������� �����" ----------------------------------------
  TesaAutosArr=array of TesaAuto;
  TesaAutos = class(TesaDBCustomObject)
  private
    FItems: TesaAutosArr; //������ �������������� ���������� �����
    FCount: Integer;      //���������� �������������� ���������� �����
    FWorkedCount: Integer;//���������� �������������� � ���.���������
    function GetItem(const Index: Integer): TesaAuto;
  public
    procedure Clear;override;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    property Items[const Index: Integer]: TesaAuto read GetItem;default;
    property Count: Integer read FCount;
    function FindBy(const AId_Auto: Integer): Integer;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaAutos}

  //������� �� ����������
  RESAAdditionalRoadParam=record
    Id_RoadCoat       : Integer;//��� ��������� ��������
    BuildingC1000tn   : Single; //������� �� ���������� ����������, ���.�����
    KeepingYearC1000tn: Single; //���������� ����������, ���.�����/���
    AmortizationR     : Single; //����� �����������
  end;
  //������ "�������������� ���������� �� ����������" ------------------------------------------
  TesaAdditionalRoadParams=class(TesaDBCustomObject)
  private
    FCount: Integer;
    FItems: array of RESAAdditionalRoadParam;
    function GetItem(const Index: Integer): RESAAdditionalRoadParam;
  public
    property Count: Integer read FCount;
    property Items[const Index: Integer]: RESAAdditionalRoadParam read GetItem;
    function FindBy(const AId_RoadCoat: Integer): Integer;
    procedure Clear;override;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaAdditionalRoadParams}

  //�������������� ������� �� ������� ��������� ������ ��� ����
  RESAAdditionalAutoParam=record
    Id_Auto                  : Integer;//��� ������ ����
    SparesCpercent           : Single; //������� �� �������� � ���������, � % � �������� �� �������
    MaterialsCpercent        : Single; //������� �� ��������� ���������, � % � �������� �� �������
    MaintenanceMonthC1000tg  : Single; //���������� ���������� ���������, ���.�����/���
  end;
  //������ "�������������� ���������� �� ����������" ------------------------------------------
  TesaAdditionalAutoParams=class(TesaDBCustomObject)
  private
    FCount: Integer;
    FItems: array of RESAAdditionalAutoParam;
    function GetItem(const Index: Integer): RESAAdditionalAutoParam;
  public
    property Count: Integer read FCount;
    property Items[const Index: Integer]: RESAAdditionalAutoParam read GetItem;
    function FindBy(const AId_Auto: Integer): Integer;
    procedure Clear;override;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
  end;{TesaAdditionalAutoParams}

  //TesaOpenpit - ����� "������" --------------------------------------------------------------
  TesaOpenpit = class(TesaDBCustomObject)
  private
    FId_Openpit: Integer;              //���������� ��� �������
    FName      : String;               //������������ �������
    FDateCreate: TDateTime;            //���� �������� �������
    FPeriod    : ResaPeriod;           //������ �������
    FShift     : ResaShift;            //������ �����
    FCommon    : ResaCommon;           //������ ��������������
    //�������������� ���������� �������������
    FRoadCoats       : TesaRoadCoats;        //�������� ��������
    FRocks           : TesaRocks;            //���������� ������ ������
    FExcavatorModels : TesaExcavatorModels;  //������ ������������
    FAutoModels      : TesaAutoModels;       //������ ��������������
    FExcavators      : TesaExcavators;       //�����������
    FAutoAccordances : TesaAutoAccordances;  //������������ ����� ���� ����� ������������
    FBlocks          : TesaBlocks;           //����-������� �������
    FLoadingPunkts   : TesaLoadingPunkts;    //������ �������� �������
    FUnLoadingPunkts : TesaUnLoadingPunkts;  //������ ��������� �������
    FShiftPunkts     : TesaShiftPunkts;      //������ ���������� �������
    FCourses         : TesaCourses;          //�������� �������� �������
    FAutos           : TesaAutos;            //�������������
    FAdditionalRoadParams: TesaAdditionalRoadParams;//�������������� ���������� �� ����������
    FAdditionalAutoParams: TesaAdditionalAutoParams;//�������������� ���������� �� ����� ����

    procedure SetId_Openpit(Value: Integer);
  public
    property Id_Openpit: Integer read FId_Openpit write SetId_Openpit;
    property Name      : String read FName;
    property DateCreate: TDateTime read FDateCreate;
    procedure RefreshData;override;
    function CheckAllTerms: Boolean;override;
    property Period    : ResaPeriod read FPeriod;
    property Shift     : ResaShift read FShift;
    property Common    : ResaCommon read FCommon;
    //
    property Autos          : TesaAutos read FAutos;
    property AutoModels     : TesaAutoModels read FAutoModels;
    property Excavators     : TesaExcavators read FExcavators;
    property ExcavatorModels: TesaExcavatorModels read FExcavatorModels;
    property Rocks          : TesaRocks read FRocks;
    property RoadCoats      : TesaRoadCoats read FRoadCoats;
    property Blocks         : TesaBlocks read FBlocks;
    property LoadingPunkts  : TesaLoadingPunkts read FLoadingPunkts;
    property UnLoadingPunkts: TesaUnLoadingPunkts read FUnLoadingPunkts;
    property ShiftPunkts    : TesaShiftPunkts read FShiftPunkts;
    property Courses: TesaCourses read FCourses;          
    property AutoAccordances          : TesaAutoAccordances read FAutoAccordances;
    constructor Create(ADispatcher: TDispatcher);
    destructor Destroy; override;
    procedure Clear;override;
  end;{TesaOpenpit}

  //������ "�������������" --------------------------------------------------------------------
  TDispatcher=class(TCustomMemo)
  private
    //������������ ����������
    FForm            : TForm;  //����� ����������
    FpnBtns          : TPanel; //������ ������
    FGauge           : TGauge; //����� �������� ������� �����
    FbtOk            : TButton;//������ "��"
    FTimer           : TTimer; //������: ����� 1 ��� �������� ����� ��������� Run
    //������
    FIsRunning       : Boolean;//������� ������� ������� ��������
    FIsStop          : Boolean;//������� ������ ������� ��������
    FIsErrorInputData: Boolean;//������� ������������� ���������� ������ � ������� ������
    FIsErrorCalc     : Boolean;//������� ������������� ���������� ������ ��� ������� ��������
    //�������
    FDBConnection    : TADOConnection; //������ �� ���������� ��
    FOpenpit         : TesaOpenpit;    //������ "������"
    FVariant         : TesaResultVariant;    //��������� �������������
    //������� �������������� ���������
    FCurrUnWorkedAutosCount : Integer;//���������� ���� � ��������� ���������
    FCurrAbortAutosCount    : Integer;//���������� ���� � "���������" ���������
    FCurrDoneAutosCount     : Integer;//���������� ����, ����������� �����
    FCurrWaitingAutosCount  : Integer;//���������� ���� � �������
    FCurrWorkingAutosCount  : Integer;//���������� ���� � ������
    FCurrAutos              : array of TesaAuto;
    FResultItemIndex        : Integer;//������ ������� �������� ����� �������������
    FShiftTsec              : Integer;//������������ ����� �����, ���
    FCurrTsecNaryad         : Integer;//������� ����� � ������, sec {!!!}
    FCurrAutoCostsGxTgPerLtr: Single;//��������� 1 ����� ����������
    //������� ������������ ���������
    FCurrStrippingCoef      : Single;//����������� �������, m3/m3 #�/�
    FCurrOreQtn             : Single;//����� ������� ����, �
    FCurrOreVm3             : Single;//����� ������� ����, m3
    FCurrOreQua             : Single;
    FCurrStrippingQtn       : Single;//����� ������� �������, �
    FCurrStrippingVm3       : Single;//����� ������� �������, m3
    //����������� ������ �������� ������
    FfhResultItems          : Integer;//���������� ������� �������������
    FfhAutos                : Integer;//��������� ��������������
    FfhLoadingPunkts        : Integer;//��������� ��
    FfhLoadingPunktRocks    : Integer;//��������� �� ��
    FfhUnLoadingPunkts      : Integer;//��������� ��
    FfhUnLoadingPunktRocks  : Integer;//��������� �� ��
    FList0,FList1           : TList;//��������� ������ ��� ������ �������� ��� �������� �����

    FResultId_Shift: Integer;
    _tmp_bool : boolean;

    function GetId_Openpit: Integer;
    function GetAutos: TesaAutos;
    function GetLoadingPunkts: TesaLoadingPunkts;
    function GetUnLoadingPunkts: TesaUnLoadingPunkts;
    function GetShiftPunkts: TesaShiftPunkts;
    function GetBlocks: TesaBlocks;
    function GetCourses: TesaCourses;
    function GetRocks: TesaRocks;
    function GetAutoAccordances: TesaAutoAccordances;
//    procedure SendCalcErrorMsg(const AMessage: String; const AIsFooter: Boolean=true);
//    procedure SendInputDataErrorMsg(const AMessage: String; const AIsFooter: Boolean=true);
    procedure SendWarningMsg(const AMessage: String);
    //
    procedure SetGaugeValue(const Value: Integer);
    //��������������� ����������� �������
    procedure DoFormShow(Sender: TObject);
    procedure DoTimer(Sender: TObject);
    //��������� ������� ��������
    procedure RunCalcs;                                 //I.   ������ ������� ��������
    procedure RunInitialization(var ATime: _SystemTime);//I.1. �������������
    procedure RunReadData(var ATime: _SystemTime);      //I.2. ���������� ������
    procedure RunSaveResults(var ATime: _SystemTime);   //I.4. ���������� �����������
    procedure RunFinalization(var ATime0: _SystemTime); //I.5. �����������
    //�������� ��� ������(����,exc,lp,lpr,up,upr,r..) � �������� ����
    procedure SaveResultLists(const APath: String);
    //�������� ����� ������� � � �������� ����
    procedure AppendResultItem(const T: Integer);
    procedure AppendResultAutos;
    procedure AppendResultLoadingPunkt(const AIndex: Integer);
    procedure AppendResultLoadingPunkts;
    procedure AppendResultUnLoadingPunkt(const AIndex: Integer);
    procedure AppendResultUnLoadingPunkts;
    //��������� � ������ ��������
    procedure SendMessageStartTime(var ATime0: _SystemTime; const AMessage: String;
                                   const AIsMilliSecunds: Boolean = False);
    //��������� �� ��������� ��������
    procedure SendMessageFinishTime(const ATime0: _SystemTime; const AMessage: String;
                                    const AIsBlankLine: Boolean = True);
    //��������� ������ �������� ��� ����
    function DefineAutosCourse(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� � �������� ������ �� ��� � ��
    function DefineAutosClosedCourseSPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� � �������� ������ �� ��� � ��
    function DefineAutosOpenedCourseSPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
    function DefineAutosClosedCourseLPUP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
    function DefineAutosOpenedCourseLPUP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
    function DefineAutosClosedCourseUPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
    function DefineAutosOpenedCourseUPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //��������� ������ �������� ��� ���� �� �� � ���
    function DefineAutosCourseUPSP(AAuto: TesaAuto; var AErrMsg: String): Integer;
    //-----------------------------------------------------------------------------------------
    //I.3. ������ �������� (82 lines)
    procedure RunModeling_(var ATime: _SystemTime);
    //������������� ���������� ��������� ������� ��������
    procedure DefineInitLoadingPunkts_;
    //������������� ���������� ��������� ������� ���������
    procedure DefineInitUnLoadingPunkts_;
    //������������� ���������� ��������� ����-��������
    procedure DefineInitBlocks_;
    //������� ������ �� ������� �������������
    procedure DefineInitAuto_(AAuto: TesaAuto);
    //������������� ���������� ��������� ��������������
    procedure DefineInitAutos_;
    //���������� ���� ����:  � ��������, � �������, � ������, � �����.���������
    procedure DefineAutosSorting_;
    //��������� ������� ����������� �������
    procedure DefineCurrStrippingCoef_;
    //��������� ��������� �����.��� �������������
    function DefineAutosMinDtSec_: Integer;
    //��������� �������������� ����, ����������� lambda-����� ����������� ����
    procedure DefineAutosCurrPoint_(var AAuto: TesaAuto; const Lambda: Single);

    //���������� ��������������� ���������� �������� �� ������ ���������� �������
    procedure DefineAutosGoBy_(const dTsec, ACurrTsecNaryad: Integer);
    //���������� �������������(� ��������) ���������� �������� �� ������ ���������� �������
    procedure DefineMovingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
    //������� ����� ��������/��������/����������
    procedure DefineAutosPlacePunkt_(AAuto: TesaAuto; const ACurrTsecNaryad: Integer);
    //������� ��������� ��
    procedure DefineAutosPlaceNextBlock_(AAuto: TesaAuto);
    //byKamil �������� ������ ����� �� ������� ������, ���� ������� ����������
    //���� �����/����� ������������, �� ��������� true
    function CheckCascadeOneLane_(CurrCourse: TesaCourse; BlockIndex: integer; upDirection: boolean; Value: integer): boolean;
    //���������� ������� ��
    procedure DefineAutosEmptyCurrBlock_(AAuto: TesaAuto);
    //��������� RequiredDistance � RequiredTime ����
    //����� � ������� �� ������ ���������
    procedure DefineAutosUhozhuVProstoyOnUP__(AAuto: TesaAuto);
    //����� � �������
    procedure DefineAutosUhozhuVProstoy_(AAuto: TesaAuto; ANextBlockAutoIndex:Integer);
    //���������� �������������(��������) ���������� �������� �� ������ ���������� �������
    procedure DefineLoadingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
    //���������� �������������(���������) ���������� �������� �� ������ ���������� �������
    procedure DefineUnLoadingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
    //���������� �������������(�������) ���������� �������� �� ������ ���������� �������
    procedure DefineWaitingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
    //���������� � �� ����������� ������������� �����
    procedure SaveTotalResults;
    //���������� � �� ����������� ������������� �� ��������������
    procedure SaveAutosResultsNew;
    //���������� � �� ����������� ������������� �� ��
    procedure SaveBlocksResultsNew;
    //���������� � �� ����������� ������������� �� ������������
    procedure SaveExcavatorsResultsNew;
    //���������� � �� ����������� ������������� �� ������� ���������
    procedure SaveUnLoadingPunktsResultsNew;
    //���������� � �� ����������� ������������� �� ������������� �����������
    procedure SaveEconomResultsNew;
    //���������� � �� ����������� ������������� �� ������
    procedure SavePeriodResultsNew;
    //�������� ������������� ������� ����
    procedure CheckEndOfShiftForAutos(const dTsec, ACurrTsecNaryad: Integer);
    procedure DefineMovingAutosRequredParams_(AAuto: TesaAuto; const V0: Single; const ADirection: TAutoDirection);
    function DefineAydarGx_(AAuto: TesaAuto;dLmtr,Vkmh,SumSoprotiv,dTsec: Single): Single;
    procedure DefineAutosIndent(const APoint0, APoint1        : RPoint3D;
                                      const AStripWm,ABlockLm: Single;
                                      var APoint                    : RPoint3D;
                                      var AAzimut,AZenit            : Single);
    function DefineW0HkH(const ARoadCoat: TesaRoadCoat; const AutoQtn, RockQtn: Single): Single;
  protected
    //��������� ��������� ������������� ��������, ��.��
    function DefineAydarSumSoprotiv_(const ARoadCoat: TesaRoadCoat; const Ptn,Q,Vkmh,i_: Single): Single;
  public
    //u+
    _tmp_test_auto: string;
    _tmp_int: integer;
    //u-
    property Variant: TesaResultVariant read FVariant;
    property ResultId_Shift: Integer read FResultId_Shift;
    property DBConnection: TADOConnection read FDBConnection;
    property Id_Openpit: Integer read GetId_Openpit;
    //����������� ��������� � Memo ����� ����������
    procedure SendMessage(const AMessage: String);
    //����������� ���������-�������������� ������ � Memo ����� ����������
    procedure SendBlankMessage;
    property Openpit         : TesaOpenpit read FOpenpit;
    property Autos           : TesaAutos read GetAutos;
    property LoadingPunkts   : TesaLoadingPunkts read GetLoadingPunkts;
    property UnLoadingPunkts : TesaUnLoadingPunkts read GetUnLoadingPunkts;
    property ShiftPunkts     : TesaShiftPunkts read GetShiftPunkts;
    property Blocks          : TesaBlocks read GetBlocks;
    property Courses         : TesaCourses read GetCourses;
    property Rocks           : TesaRocks read GetRocks;
    property AutoAccordances : TesaAutoAccordances read GetAutoAccordances;
    property IsRunning       : Boolean read FIsRunning;
    property IsStop          : Boolean read FIsStop;
    property IsErrorInputData: Boolean read FIsErrorInputData;
    property IsErrorCalc     : Boolean read FIsErrorCalc;
    constructor Create(AOwner: TComponent; ADBConnection: TADOConnection);reintroduce;
    destructor Destroy;override;
    procedure Run(const AId_Openpit: Integer);//������ ������� ��������
    procedure Stop;                           //���������� ������� ��������
  end;{TDispatcher}

  //�������� ������ �� ������������� -------------------------------------------
  TesaResultAuto = class
  private
    FDispatcher         : TDispatcher;
    FAuto               : TesaAuto;
    FId_ResultShift     : Integer;//��� �����
    FAutosCount         : Integer;
    FId_ResultShiftAuto : Integer;//��� ������������� ���������� �����
    FId_DumpModel1      : Integer;//��� ������
    FDumpModel          : String;//��� ������

    FTripsCount         : ResaDirectionValue; //���������� ������ �� ������������ ��������
    FRockVolume         : ResaRockVolume;     //�����/��� ������������ ��, �3/�
    FSm                 : ResaDirectionValue; //������ �� ������������ ��������, �
    FWAvgSkmLoading     : ResaDrobValue;      //���������������� ���������� �����������������,��*� //���� ��� ������� � ���������� ��������!
    FWAvgHm             : ResaDrobValue;      //������� ������ �������, �
    FAvgVkmh            : ResaDrobValue;      //������� ��������, ��/�
    FAvgVkmhNulled      : ResaDrobValue;      //������� �������� � ������� �����������
    FAvgVkmhLoading     : ResaDrobValue;      //������� �������� � �������� �����������
    FAvgVkmhUnLoading   : ResaDrobValue;      //������� �������� � ������������ �����������
    FGx                 : ResaWorkValue;      //������ �������, � (� ������,� �������)
    FDirGx              : ResaDirectionValue; //������ ������� �� ������������, �
    FLoadingSkmRockQtn  : Single;             //�����������, ���
    FTsec               : ResaTmin;           //�����, ���
    FDirTsec            : ResaDirectionValue; //����� �� ������������, ���
    FUsedTyresCount     : Single;             //���������� ��������������� ���

    //����������� ���������
    FSumTyresCtg        : Single;             //������� �� ����, ��
    FSumGxCtg           : ResaWorkValue;      //������� �� ������� � ������ � �������, ��
    FSumExploatationCtg : ResaWorkValue;      //������� ���������������� (� ������ � �������), �� 
    FSumSparesGxCtg     : ResaWorkValue;      // - ������� �� �������� ��� �������������, ��/�����
    FSumMaterialsGxCtg  : ResaWorkValue;      // - ������� �� ��������� ��������� ��� �������������, ��/�����
    FSumMaintenanceCtg  : ResaWorkValue;      // - ������� �� ���������� ���������� ��������� ��� �������������, ��/�����
    FSumSalaryCtg       : ResaWorkValue;      // - ������� �� �������� ��� �������������, ��/�����
    FSumAmortizationCtg : Single;             //�������� ��������������� ������, ��
    //�������� ������ �������, �/���
    function GetUdGx_gr_tkm(): Single;
  public
    property Dispatcher        : TDispatcher read FDispatcher;
    property Auto              : TesaAuto read FAuto;
    property Id_ResultShift    : Integer read FId_ResultShift;
    property Id_ResultShiftAuto: Integer read FId_ResultShiftAuto;
    property Id_DumpModel1     : Integer read FId_DumpModel1;
    property DumpModel         : String read FDumpModel;
    property AutosCount        : Integer read FAutosCount;
    property TripsCount        : ResaDirectionValue read FTripsCount;
    property RockVolume        : ResaRockVolume read FRockVolume;
    property Sm                : ResaDirectionValue read FSm;
    property WAvgSkmLoading    : ResaDrobValue read FWAvgSkmLoading;
    property WAvgHm            : ResaDrobValue read FWAvgHm;
    property AvgVkmh           : ResaDrobValue read FAvgVkmh;
    property AvgVkmhNulled     : ResaDrobValue read FAvgVkmhNulled;
    property AvgVkmhLoading    : ResaDrobValue read FAvgVkmhLoading;
    property AvgVkmhUnLoading  : ResaDrobValue read FAvgVkmhUnLoading;
    property Gx                : ResaWorkValue read FGx;
    property DirGx             : ResaDirectionValue read FDirGx;
    property UdGx_gr_tkm       : Single read GetUdGx_gr_tkm;
    property LoadingSkmRockQtn : Single read FLoadingSkmRockQtn;
    property Tsec              : ResaTmin read FTsec;
    property DirTsec           : ResaDirectionValue read FDirTsec;
    property UsedTyresCount    : Single read FUsedTyresCount;
    property SumTyresCtg       : Single read FSumTyresCtg;
    property SumGxCtg          : ResaWorkValue read FSumGxCtg;
    property SumExploatationCtg: ResaWorkValue read FSumExploatationCtg;
    property SumSparesGxCtg    : ResaWorkValue read FSumSparesGxCtg;
    property SumMaterialsGxCtg : ResaWorkValue read FSumMaterialsGxCtg;
    property SumMaintenanceCtg : ResaWorkValue read FSumMaintenanceCtg;
    property SumSalaryCtg      : ResaWorkValue read FSumSalaryCtg;
    property SumAmortizationCtg: Single read FSumAmortizationCtg;
    constructor Create(ADispatcher: TDispatcher); virtual;
    destructor Destroy; override;
  end;{TesaResultAuto}
  
  //�������� ������ �� ������ �������������� -----------------------------------
  TesaResultAutoModel = class(TesaResultAuto)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultAuto;
    function GetLast: TesaResultAuto;
  protected
    procedure Append(const AAuto: TesaResultAuto);
    procedure Clear;
  public
    property Items[const Index: Integer]: TesaResultAuto read GetItem; default;
    property Count: Integer read FCount;
    property Last: TesaResultAuto read GetLast;
    constructor Create(ADispatcher: TDispatcher); override;
    destructor Destroy; override;
  end;{TesaResultAutoModel}
  
  //�������� ������ �� ������ �������������� -----------------------------------
  TesaResultAutoModels = class(TesaResultAuto)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultAutoModel;
    function GetLast: TesaResultAutoModel;
  protected
    procedure Append(const AAuto: TesaResultAuto);
    procedure Clear;
    procedure Update;
    function IndexOf(const AId_DumpModel: Integer): Integer;
  public
    property Items[const Index: Integer]: TesaResultAutoModel read GetItem; default;
    property Count: Integer read FCount;
    property Last: TesaResultAutoModel read GetLast;
    constructor Create(ADispatcher: TDispatcher); override;
    destructor Destroy; override;
  end;{TesaResultAutoModels}

  //�������� ������ �� ����������� -------------------------------------------
  TesaResultExcavator = class
  private
    FDispatcher             : TDispatcher;
    FExcavator              : TesaExcavator;
    FId_ResultShift         : Integer;        //��� �����
    FExcavatorsCount        : Integer;
    FId_ResultShiftExcavator: Integer;        //��� ����������� ���������� �����
    FId_DumpModel           : Integer;        //��� ������
    FDumpModel              : String;         //��� ������
    FLoadingAutosCount      : Single;         //���������� ����������� ��������������
    FRockVolume             : ResaRockVolume; //����� ���������� ��, �3
    FRockShiftPlan          : ResaRockVolume; //�������� ����� �� �� �����, �3
    FSumGx                  : ResaWorkValue;  //������ ��������������, ���*�
    FSumTmin                : ResaTmin;       //�����, ��� (� ������,�������,��� ��������)
    //����������� ���������
    FSumExploatationCtg     : ResaWorkValue;  //������� ���������������� (� ������ � �������), ��
    FSumGxCtg               : ResaWorkValue;      // - ������� �� ��������������, ��/�����
    FSumMaterialsGxCtg      : ResaWorkValue;      // - ������� �� ���������, ��/�����
    FSumUnAccountedCtg      : ResaWorkValue;      // - ������� ����������, ��/�����
    FSumSalaryCtg           : ResaWorkValue;      // - ������� �� ��������, ��/�����
    FSumAmortizationCtg     : Single;         //�������� ��������������� ������, ��
  public
    property Dispatcher             : TDispatcher read FDispatcher;
    property Excavator              : TesaExcavator read FExcavator;
    property Id_ResultShift         : Integer read FId_ResultShift;
    property Id_ResultShiftExcavator: Integer read FId_ResultShiftExcavator;
    property Id_DumpModel           : Integer read FId_DumpModel;
    property DumpModel              : String read FDumpModel;
    property ExcavatorsCount        : Integer read FExcavatorsCount;

    property LoadingAutosCount      : Single read FLoadingAutosCount;
    property RockVolume             : ResaRockVolume read FRockVolume;
    property RockShiftPlan          : ResaRockVolume read FRockShiftPlan;
    property SumGx                  : ResaWorkValue read FSumGx;
    property SumTmin                : ResaTmin read FSumTmin;
    property SumExploatationCtg     : ResaWorkValue read FSumExploatationCtg;
    property SumGxCtg               : ResaWorkValue read FSumGxCtg;
    property SumMaterialsGxCtg      : ResaWorkValue read FSumMaterialsGxCtg;
    property SumUnAccountedCtg      : ResaWorkValue read FSumUnAccountedCtg;
    property SumSalaryCtg           : ResaWorkValue read FSumSalaryCtg;
    property SumAmortizationCtg     : Single read FSumAmortizationCtg;
    
    constructor Create(ADispatcher: TDispatcher); virtual;
    destructor Destroy; override;
  end;{TesaResultExcavator}

  //�������� ������ �� ������ ������������ -----------------------------------
  TesaResultExcavatorModel = class(TesaResultExcavator)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultExcavator;
    function GetLast: TesaResultExcavator;
  protected
    procedure Append(const AExcavator: TesaResultExcavator);
    procedure Clear;
  public
    property Items[const Index: Integer]: TesaResultExcavator read GetItem; default;
    property Count: Integer read FCount;
    property Last: TesaResultExcavator read GetLast;
    constructor Create(ADispatcher: TDispatcher); override;
    destructor Destroy; override;
  end;{TesaResultExcavatorModel}

  //�������� ������ �� ������ ������������ -----------------------------------
  TesaResultExcavatorModels = class(TesaResultExcavator)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultExcavatorModel;
    function GetLast: TesaResultExcavatorModel;
  protected
    procedure Append(const AExcavator: TesaResultExcavator);
    procedure Clear;
    procedure Update;
    function IndexOf(const AId_DumpModel: Integer): Integer;
    function FindExcavatorOf(const AId_LoadingPunkt: Integer): TesaResultExcavator;
  public
    property Items[const Index: Integer]: TesaResultExcavatorModel read GetItem; default;
    property Count: Integer read FCount;
    property Last: TesaResultExcavatorModel read GetLast;
    constructor Create(ADispatcher: TDispatcher); override;
    destructor Destroy; override;
  end;{TesaResultExcavatorModels}
  
  //�������� ������ �� �� -------------------------------------------------------------------------------
  TesaResultBlock = class
  private
    FDispatcher                : TDispatcher;//���������
    FBlock                     : TesaBlock;  //����
    FId_ResultShift            : Integer;    //��� �����
    FId_ResultShiftBlock       : Integer;    //��� ��
    FId_RoadCoat               : Integer;    //��� ��������� ��������
    FRoadCoat                  : String;     //������������ ��������� ��������
    //�������������� ����������
    FBlocksCount               : Integer;           //���������� ����-��������
    FLsm                       : Integer;           //�����, c�
    FRockVolume                : ResaRockVolume;    //����� ������������ ������ �����
    FAutosCount                : ResaDirectionValue;//���������� ��������������
    FWaitingsCount             : ResaDirectionValue;//���������� �������� ��������������
    FAvgVkmhNulled             : ResaDrobValue;     //������� �������� �������� �������������� � ������� �����������, ��/�
    FAvgVkmhLoading            : ResaDrobValue;     //������� �������� �������� �������������� � �������� �����������, ��/�
    FAvgVkmhUnLoading          : ResaDrobValue;     //������� �������� �������� �������������� � ������������ �����������, ��/�
    //���������� ������������� �������� �������
    FMovingAvgTminNulled       : ResaDrobValue;     //������� ����� �������� �������������� � ������� �����������, ���
    FMovingAvgTminLoading      : ResaDrobValue;     //������� ����� �������� �������������� � �������� �����������, ���
    FMovingAvgTminUnLoading    : ResaDrobValue;     //������� ����� �������� �������������� � ������������ �����������, ���
    FWaitingAvgTminNulled      : ResaDrobValue;     //������� ����� �������� �������������� � ������� �����������, ���
    FWaitingAvgTminLoading     : ResaDrobValue;     //������� ����� �������� �������������� � �������� �����������, ���
    FWaitingAvgTminUnLoading   : ResaDrobValue;     //������� ����� �������� �������������� � ������������ �����������, ���
    //���������� ������� �������
    FGx                        : ResaDirectionValue;//������ ������� �������������� �� ������������, �
    //����������� ���������
    FRepairCtg                 : Single;     //������� �� �����������, ��
    FAmortizationCtg           : Single;     //��������������� ����������, ��
    FBuildingCtg               : Single;     //������� �� �������������, ��
    function GetUdGx_l_m: Single;
    function GetCtg: Single;
    function GetEmploymentCoef: Single;     
  public
    property Dispatcher                : TDispatcher read FDispatcher;
    property Block                     : TesaBlock read FBlock;
    property Id_ResultShift            : Integer read FId_ResultShift;
    property Id_ResultShiftBlock       : Integer read FId_ResultShiftBlock;
    property Id_RoadCoat               : Integer read FId_RoadCoat;    
    property RoadCoat                  : String read FRoadCoat;
    //�������������� ����������
    property BlocksCount               : Integer read FBlocksCount;    
    property Lsm                       : Integer read FLsm;    
    property RockVolume                : ResaRockVolume read FRockVolume;     
    property AutosCount                : ResaDirectionValue read FAutosCount;
    property WaitingsCount             : ResaDirectionValue read FWaitingsCount;
    property AvgVkmhNulled             : ResaDrobValue read FAvgVkmhNulled;
    property AvgVkmhLoading            : ResaDrobValue read FAvgVkmhLoading;
    property AvgVkmhUnLoading          : ResaDrobValue read FAvgVkmhUnLoading;
    //���������� ������������� �������� �������
    property MovingAvgTminNulled       : ResaDrobValue read FMovingAvgTminNulled;
    property MovingAvgTminLoading      : ResaDrobValue read FMovingAvgTminLoading;
    property MovingAvgTminUnLoading    : ResaDrobValue read FMovingAvgTminUnLoading;
    property WaitingAvgTminNulled      : ResaDrobValue read FWaitingAvgTminNulled;
    property WaitingAvgTminLoading     : ResaDrobValue read FWaitingAvgTminLoading;
    property WaitingAvgTminUnLoading   : ResaDrobValue read FWaitingAvgTminUnLoading;
    property EmploymentCoef            : Single read GetEmploymentCoef;
    //���������� ������� �������
    property Gx                        : ResaDirectionValue read FGx;
    property UdGx_l_m                  : Single read GetUdGx_l_m;
    //����������� ���������
    property RepairCtg                 : Single read FRepairCtg;
    property AmortizationCtg           : Single read FAmortizationCtg;
    property BuildingCtg               : Single read FBuildingCtg;
    property Ctg                       : Single read GetCtg;    

    constructor Create(ADispatcher: TDispatcher); virtual;
    destructor Destroy; override;
  end;{TesaResultBlock}

  //�������� ������ �� ������ �� ------------------------------------------------------------------------
  TesaResultBlockModel = class(TesaResultBlock)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultBlock;
    function GetLast: TesaResultBlock;
  protected
    procedure Append(const ABlock: TesaResultBlock);
    procedure Clear;
  public
    property Items[const Index: Integer]: TesaResultBlock read GetItem; default;
    property Count: Integer read FCount;
    property Last: TesaResultBlock read GetLast;
    constructor Create(ADispatcher: TDispatcher); override;
    destructor Destroy; override;
  end;{TesaResultBlockModel}

  //�������� ������ �� ���� �� --------------------------------------------------------------------------
  TesaResultBlockModels = class(TesaResultBlock)
  private
    FItems: TList;
    FCount: Integer;
    function GetItem(const Index: Integer): TesaResultBlockModel;
    function GetLast: TesaResultBlockModel;
  protected
    procedure Append(const ABlock: TesaResultBlock);
    procedure Clear;
    procedure Update;
    function IndexOf(const AId_RoadCoat: Integer): Integer;
  public
    property Items[const Index: Integer]: TesaResultBlockModel read GetItem; default;
    property Count: Integer read FCount;
    property Last: TesaResultBlockModel read GetLast;
    constructor Create(ADispatcher: TDispatcher); override;
    destructor Destroy; override;
  end;{TesaResultBlockModels}

//ul
  uCourse=class
  public
    blocks: array of integer;
    strip1: array of integer;
    has1:   boolean;
    sblocks: array of integer;

//    function uClAuto(aa : TesaAuto):TesaAuto;
//    function uMovingAutoParams(AAuto: TesaAuto; const V0: Single;
//      const ADirection: TAutoDirection):integer; // ������ ������� �� ����
    function autoInd(pit: TesaOpenpit; blockInd : integer):integer;
//    function nextBlock:integer;
//    function prevBlock:integer;
  end;



//������ ��������������
function esaShowDispatcherDlg(const AOwner: TComponent; const AConnection: TADOConnection; const AId_Openpit: Integer): Boolean;

procedure uFLog(s:string; fn: string = 'uFLog.txt'; createNew : boolean = false);

(*
  ================================================================================
    ================================================================================
    ================================================================================
  ================================================================================
*)
implementation
uses SysUtils, Math, Db, Controls, Graphics, unDM, esaModelingResults,
  DateUtils, esaConstants, Dialogs, StdConvs,
  TXTWriter;


//ul ��������� ������ uCourse
function uCourse.autoInd(pit: TesaOpenpit; blockInd :integer):integer;
//var //i:integer;
//  block:TesaBlock;
//  cbl:TesaCourseBlock;
begin
//  block:=pit.Blocks.Items[blockInd];
  //if block<>nil then
    //pit.Courses.  block.Id_Block
    Result:=-1;//pit.Blocks.
end;



//ul-

//������ ��������������
function esaShowDispatcherDlg(
  const AOwner: TComponent;
  const AConnection: TADOConnection;
  const AId_Openpit: Integer): Boolean;
var
  AutoDispatcher: TDispatcher;
begin
  Result := True;
  AutoDispatcher := TDispatcher.Create(AOwner, AConnection);
  try
    AutoDispatcher.Run(AId_Openpit);
  finally
    AutoDispatcher.Free;
  end;
end;

const
  sBlankLine='--------------------------------------------------------------------------------';
  EADOConnectionNull  ='�� ����� ADOConnection: TADOConnection';
  EADOConnectionClosed='��� ���������� ADOConnection: TADOConnection � ����� ������';

  EInvalidIndex = '�������� �������� ������� %d. ���������� ��������: [0..%d].';
  EAutoDispatcherNull ='�� ����� AutoDispatcher: TDispatcher';
  ERoadCoatsEmpty='��� ������ �� �������� ���������';
  ERoadCoatsUSKsEmpty='��� ��������� �������� "%s" �� ������ ������������ '+
                      '��������� ������������� �������';
  ERocksEmpty='��� ������ �� ������ �������';
  EExcavatorModelsEmpty='��� ������ �� ������� ������������';
  EAutoModelsEmpty='��� ������ �� ������� ��������������';
  EExcavatorsWorkState='� ��������� ����� ��� �� ������ ����������� � ������� ���������';

  EBlocksMinLm='����� ����-������� �%d ������ ���� ������';
  ELoadingPunktsEmpty='��� ������ �� ������� ��������';
  ELoadingPunktsRocksPlane='��� ������(��) �������� �%s �� ������ '+
                           '����������� ������ ������ ������';
  ELoadingPunktsExcavator='�� �������(���) �������� �%s �� ��������� ����������';
  ELoadingPunktsWorkState='�� �������(���) �������� �%s ��������� ���������� '+
                          '� ��������� ���������';
  ELoadingPunktsRockContent='����������� �������� ���������� ���� �� ������� �������� '+
                            '������ ������������� ����������';
  EUnLoadingPunktsRockPlane='��� ������ ��������� �%d �� ������ ������ ����.';
  EUnLoadingPunktsFactoryStripping='��� ������ ��������� (������������������� �������) �%d '+
                                   '������ ������ �������.';
  EUnLoadingPunktsSpoilStripping='��� ������ ��������� (�����) �%d �� ������ ������ �������.';
  EUnLoadingPunktsSpoilRock='��� ������ ��������� (�����) �%d ������ ������ ����.';
  EUnLoadingPunktsContent='��� ������ ��������� �%d ������ �������� �������� '+
                          '���������� ���������� %.1f%% ��� "%s". '+
                          '����������� ��������: (%.1f..%.1f)';
  EUnLoadingPunktsMaxAutoCount='����� ��������� �%d �� ����� ������� �� ���� ������������.';
  EShiftPunktsEmpty='��� ������ �� ������� ����������';
  ECourseLP_UP      ='��� �� ������ �������� ���� "����� �������� - ����� ���������"';
  ECourseSP_LP      ='��� �� ������ �������� ���� "����� ���������� - ����� ��������"';
  ECourseUP_SP      ='��� �� ������ �������� ���� "����� ��������� - ����� ����������"';
  ECourseBlocksCount='�������(�) �%s ������ �������� ��� ������� �� ���� ����-�������� '+
                     '(������� ��� ������� - ������� ��� �������� - ������� ��� �������)';
  ECourseExtreme    ='��������� � �������� ����-������� ��������(��) �%s ������ ���� ���� '+
                     '"����-������� ��� �������"';
  ECoursePunkts     ='�� ������ ��������� �(���) �������� ������ ��������(��) �%s';
  EAutosWorkState   ='� ��������� ����� ��� �� ������ ������������� � ������� ���������';
  EAutosShiftsPunkts='��������� ������������ �������������� %s '+
                     '�� ���������� �� ������� ����������';
  EAutosEscavator   ='������������� �%s ���������� �� ��������� � ����������������� ��� '+
                     '��� ����� �����������';
  EAutosCourseSP_LP ='������������� %s, ������������ �� ��������� �%d, �� ����� ������ � '+
                      '������ ���������� �%d � ������ �������� �%d';
  EAutosCourseUP_SP ='������������� %s, ������������ �� ��������� �%d, �� ����� ������ � '+
                     '������ ��������� �%d � ������ ���������� �%d';
  EAutosCourseTupik ='� ������������� %s ��� ������ �� �� ���� ������� ��������';
  EAutosWrongVk     ='� ������������� %s ��������������� �������� ������ 10 ��/�';
  EAutosWrongFkMax  ='� ������������� %s ������������ ���� ���� ������ 100 �H';

  ERoadCoatAdditionalEmpty='��� ��������� �������� "%s" ��� �������������� �����������';
  EAutoAdditionalEmpty    ='��� ������������� %s ��� �������������� �����������';

  EAutosNotFoundClosedCourseSPLP='��� ���� %s ��� �������� ������ �� ��� %s  �� �������� %s, �� ������� �� ���������';
  EAutosNotFoundCourseUPSP='��� ���� %s ��� �������� ������ �� ��� %s';
  EAutosNotFoundClosedCourse='��� ���� %s ��� ��������, �� ������� �� ���������';
  EAutosNotFoundOpenedCourse='��� ���� %s �� ���� ���������� ������� ��������';
  EAutosClosedCourseRockNone='��� ���� %s ��� ������ ������ ����� �� �������� %s, �� ������� �� ���������';
  EAutosRockNone='��� ���� %s �� �� %s ��� ������ ������ ����� (������� %s)';
  EAutosAborted='���� %s �� �� ���� �������� �� � ������� %.2f ��������';

//---------------------------------------------------------------------------------------------  
type
  RListItem=record
    Course            : TesaCourse;//���������� �������
    AutoCount         : Integer;   //�-�� ���� � ���.���������, �������� � ������ �����������
    ShiftPlanRatio1E5 : Integer;   //������� ���������� ����� �� ���������� ��
    Lmm               : Integer;   //����� ��������, ��
    LoadingPunktRock  : TesaLoadingPunktRock;
    UnLoadingPunktRock: TesaUnLoadingPunktRock;
  end;{RListItem}
  PListItem=^RListItem;
  //������ �������� ��� ����������� �������������
  function GetEqualDistrubationCourseIndex(var AList: TList): Integer;
  var
    I: Integer;
    AItem0,AItem1: PListItem;
  begin
    Result := -1;
    if AList.Count>0 then
    begin
      AItem0 := PListItem(AList[0]);
      for I := 1 to AList.Count-1 do
      begin
        AItem1 := PListItem(AList[I]);
        if AItem0^.AutoCount>AItem1^.AutoCount
        then AItem0 := AItem1
        else
          if AItem0^.AutoCount=AItem1^.AutoCount then
          begin
            if AItem0^.ShiftPlanRatio1E5>AItem1^.ShiftPlanRatio1E5
            then AItem0 := AItem1
            else
              if (AItem0^.ShiftPlanRatio1E5=AItem1^.ShiftPlanRatio1E5)AND(AItem0^.Lmm>AItem1^.Lmm) 
              then AItem0 := AItem1
          end;{else}
      end;{for}
      Result := AItem0^.Course.FCourseIndex;
    end;{if}
  end;{GetEqualDistrubationCourseIndex}
  procedure ClearList1(var AList: TList);
  var I: Integer;
  begin
    if AList<>nil then
    begin
      for I := AList.Count-1 downto 0 do
        AList[I] := nil;
      AList.Clear;
    end;{if}
  end;{ClearList1}
  //�������� ������0 �� ����������� 1.������� ���������� �����
  //                                2.�-�� ���� � ���.���������, �������� � �����.�����������
  //                                3.����� ��������
  procedure SortList(var AList: TList);
  var
    AItem0,AItem1: PListItem;
    I,J          : Integer;
  begin
    for I := 0 to AList.Count-1-1 do
      for J := I+1 to AList.Count-1 do
      begin
        AItem0 := PListItem(AList[I]);
        AItem1 := PListItem(AList[J]);
        if (AItem0^.ShiftPlanRatio1E5>AItem1^.ShiftPlanRatio1E5)OR
           ((AItem0^.ShiftPlanRatio1E5=AItem1^.ShiftPlanRatio1E5)and
            ((AItem0^.AutoCount>AItem1^.AutoCount)or
             ((AItem0^.AutoCount=AItem1^.AutoCount)and(AItem0^.Lmm>AItem1^.Lmm))))
        then AList.Exchange(I,J);
      end;{for}
  end;{SortList}
//---------------------------------------------------------------------------------------------

//TesaDBObject - ����� "������ ��� �������" ---------------------------------------------------
procedure TesaDBObject.Clear;
begin
end;{Clear}

//TesaDBCustomObject - ����� "������ ��� �������, ��������� � �������� ��" --------------------
function TesaDBCustomObject.GetOpenpit: TesaOpenpit;
begin
  if FDispatcher<>nil then Result := FDispatcher.Openpit else Result := nil;
end;{GetOpenpit}
function TesaDBCustomObject.GetAutos: TesaAutos;
begin
  if Openpit=nil then Result := nil else Result := Openpit.Autos;
end;{GetAutos}
function TesaDBCustomObject.GetDBConnection: TADOConnection;
begin
  if FDispatcher<>nil then Result := FDispatcher.DBConnection else Result := nil;
end;{GetDBConnection}
constructor TesaDBCustomObject.Create(ADispatcher: TDispatcher);
begin
  FDispatcher := nil;
  inherited Create;
  if ADispatcher=nil then Raise Exception.Create(EAutoDispatcherNull);
  FDispatcher := ADispatcher;
end;{Create}
destructor TesaDBCustomObject.Destroy;
begin
  FDispatcher := nil;
  inherited;
end;{Destroy}
function TesaDBCustomObject.CheckAllTerms: Boolean;
begin
  Result := True;
end;{CheckAllTerms}
procedure TesaDBCustomObject.RefreshData;
begin
  if CheckAllTerms then SendMessage('Ok') else SendInputDataErrorMsg('');
  SendMessage('');
end;{RefreshData}
procedure TesaDBCustomObject.SendCalcErrorMsg(const AMessage: String;
                                              const AIsFooter: Boolean=True);
begin
  if FDispatcher=nil then Exit;
  if AMessage<>'' then
  begin
    SendMessage('Error: '+AMessage+'!');
    FDispatcher.FIsErrorCalc := True;
  end;{if}
  if AIsFooter then SendMessage('������ ���������...');
end;{SendErrorMsg}
procedure TesaDBCustomObject.SendInputDataErrorMsg(const AMessage: String;
                                                   const AIsFooter: Boolean=True);
begin
  if FDispatcher=nil then Exit;
  if AMessage<>'' then
  begin
    SendMessage('Error: '+AMessage+'!');
    FDispatcher.FIsErrorInputData := True;
  end;{if}
  if AIsFooter then SendMessage('������ ���������...');
end;{SendErrorMsg}
procedure TesaDBCustomObject.SendWarningMsg(const AMessage: String);
begin
  if FDispatcher=nil then Exit;
  if AMessage<>'' then SendMessage('Warning: '+AMessage+'.');
end;{SendWarningMsg}
procedure TesaDBCustomObject.SendMessage(const AMessage: String; const AIsOtstup: Boolean=True);
begin
  if AMessage<>''then
    if AIsOtstup
    then FDispatcher.SendMessage('   '+AMessage)
    else FDispatcher.SendMessage(AMessage);
end;{SendMessage}

//TesaRoadCoat - ����� "�������� ��������" ----------------------------------------------------
function TesaRoadCoat.GetItem(const Index: Integer): RESARoadCoatUSK;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaRoadCoat.Create;
begin
  inherited;
  FId_RoadCoat := 0;
  FName := '';
  FBuildingC1000tn := 0.0;
  FKeepingYearC1000tn := 0.0;
  FAmortizationR := 0.0;
  Clear;
end;{Create}
destructor TesaRoadCoat.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaRoadCoat.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaRoadCoat.Wk(const AAutoP: Single): Single;
var
  I: Integer;
  Lambda: Single;
begin
  Result := 0.0;
  for I := 1 to FCount-1 do
  if InRange(AAutoP,FItems[I-1].Ptn,FItems[I].Ptn) then
  begin
    Lambda := (AAutoP-FItems[I-1].Ptn)/(FItems[I].Ptn-FItems[I-1].Ptn);
    Result := FItems[I-1].WavgHkH+Lambda*(FItems[I].WavgHkH-FItems[I-1].WavgHkH);
    Break;
  end;{for}
end;{Wk}

//TesaRoadCoats - ����� "�������� ��������" ---------------------------------------------------
function TesaRoadCoats.GetItem(const Index: Integer): TesaRoadCoat;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaRoadCoats.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaRoadCoats.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaRoadCoats.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaRoadCoats.CheckAllTerms: Boolean;
var I: Integer;
begin
  //������� ��������
  //1.������� ��� ������� ������ ���� ��������
  //2.������� ������������� ��������� ������������� ������� ��� ������� ���� ��������
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg(ERoadCoatsEmpty,False);
  for I := 0 to FCount-1 do
  if FItems[I].Count=0 then
  begin
    SendInputDataErrorMsg(Format(ERoadCoatsUSKsEmpty,[FItems[I].Name]),False);
    Result := False;
  end;{for}
end;{CheckAllTerms}
function TesaRoadCoats.FindBy(const AId_RoadCoat: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_RoadCoat=AId_RoadCoat then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
procedure TesaRoadCoats.RefreshData;
var
  quRoadCoats,quRoadCoatUSKs: TADOQuery;
  dsRoadCoats: TDataSource;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('�������� ��������...');
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
          FItems[quRoadCoats.RecNo-1] := TesaRoadCoat.Create;
          with quRoadCoats do
          begin
            FItems[RecNo-1].FId_RoadCoat := FieldByName('Id_RoadCoat').AsInteger;
            FItems[RecNo-1].FName := FieldByName('Name').AsString;
            FItems[RecNo-1].FCount := quRoadCoatUSKs.RecordCount;
            SetLength(FItems[RecNo-1].FItems,quRoadCoatUSKs.RecordCount);
          end;{with}
          while not quRoadCoatUSKs.Eof do
          begin
            with FItems[quRoadCoats.RecNo-1].FItems[quRoadCoatUSKs.RecNo-1] do
            begin
              Ptn     := quRoadCoatUSKs.FieldByName('P').AsFloat;
              WminHkH := quRoadCoatUSKs.FieldByName('ValueMin').AsFloat;
              WmaxHkH := quRoadCoatUSKs.FieldByName('ValueMax').AsFloat;
              WavgHkH := (WminHkH+WmaxHkH)*0.5;
            end;{with}
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
  inherited;
end;{RefreshData}

//TesaRocks - ����� "���������� ������ ������ �� �������" -------------------------------------
function TesaRocks.GetItem(const Index: Integer): RESARock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaRocks.Create(ADispatcher: TDispatcher);
begin
  FItems := nil;
  FCount := 0;
  inherited;
end;{Create}
destructor TesaRocks.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaRocks.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaRocks.CheckAllTerms: Boolean;
begin
  //������� ��������
  //1.������� ��� ������� ������ ���� ������ ������
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg(ERocksEmpty,False);
end;{CheckAllTerms}
procedure TesaRocks.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������ ������...');
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitRocks WHERE Id_Openpit='+IntToStr(FDispatcher.Id_Openpit)+' ORDER BY SortIndex';
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
  inherited;
end;{RefreshData}
function TesaRocks.FindBy(const AId_Rock: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Rock=AId_Rock then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}

//TesaExcavatorModels - ����� "������ ������������" -------------------------------------------
function TesaExcavatorModels.GetItem(const Index: Integer): RESAExcavatorModel;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaExcavatorModels.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
end;{Create}
destructor TesaExcavatorModels.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaExcavatorModels.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaExcavatorModels.FindBy(const AId_Excavator: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Excavator=AId_Excavator then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
function TesaExcavatorModels.CheckAllTerms: Boolean;
begin
  //������� ��������
  //1.������� ��� ������� ������ ���� �����������
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg(EExcavatorModelsEmpty,False);
end;{CheckAllTerms}
procedure TesaExcavatorModels.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������ ������������...');
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
      FItems[RecNo-1].MaxVm3 := FieldByName('BucketCapacity').AsFloat;
      FItems[RecNo-1].MaxTsec := FieldByName('CycleTime').AsFloat;
      FItems[RecNo-1].Lm := FieldByName('ELength').AsFloat;
      FItems[RecNo-1].Wm := FieldByName('EWidth').AsFloat;
      FItems[RecNo-1].Hm := FieldByName('EHeight').AsFloat;
      FItems[RecNo-1].Id_Engine := FieldByName('Id_Engine').AsInteger;
      FItems[RecNo-1].Engine := FieldByName('EngineName').AsString;
      FItems[RecNo-1].EngineMaxNkVt := FieldByName('EngineNmax').AsFloat;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  inherited;
end;{RefreshData}

//TesaAutoModels - ����� "������ ��������������" ---------------------------------------------
function TesaAutoModels.GetItem(const Index: Integer): RESAAutoModel;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaAutoModels.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaAutoModels.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaAutoModels.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
    FItems[I].Fks := nil;
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaAutoModels.FindBy(const AId_Auto: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Auto=AId_Auto then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
procedure TesaAutoModels.RefreshData;
var
  quAutoFks: TADOQuery;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������ ��������������...');
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT A.*,AE.Name as EngineName, AE.Nmax as EngineNmax '+
                'FROM Autos A, AutoEngines AE '+
                'WHERE AE.Id_Engine=A.Id_Engine ORDER BY A.SortIndex';
    Open;
    quAutoFks := TADOQuery.Create(nil);
    try
      quAutoFks.Connection := DBConnection;
      quAutoFks.SQL.Text := 'SELECT * FROM AutoFks WHERE Id_Auto=:Id_Auto ORDER BY V';
      quAutoFks.Open;
      FCount := RecordCount;
      SetLength(FItems,FCount);
      while not EOF do
      with FItems[RecNo-1] do
      begin
        SparesCpercent := 0.0;
        MaterialsCpercent := 0.0;
        MaintenanceMonthC1000tg := 0.0;
        Id_Auto := FieldByName('Id_Auto').AsInteger;
        Name := FieldByName('Name').AsString;
        MaxVm3 := FieldByName('BodySpace').AsFloat;
        MaxQtn := FieldByName('Tonnage').AsFloat;
        Ptn := FieldByName('P').AsFloat;
        F := FieldByName('F').AsFloat;
        Ro := FieldByName('Ro').AsFloat;
        TransmissionKind := TAutoTransmissionKind(FieldByName('TransmissionKind').AsInteger);
        TransmissionKPD := FieldByName('TransmissionKPD').AsFloat;
        MaxTsec := FieldByName('t_r').AsFloat;
        Rmin := FieldByName('Rmin').AsFloat;
        TyresCount := FieldByName('TyresCount').AsInteger;
        Lm := FieldByName('ALength').AsFloat;
        Wm := FieldByName('AWidth').AsFloat;
        Hm := FieldByName('AHeight').AsFloat;
        Id_Engine := FieldByName('Id_Engine').AsInteger;
        Engine := FieldByName('EngineName').AsString;
        EngineMaxNkVt := FieldByName('EngineNmax').AsFloat;
        CurrAmortizationCtg := 0.0;
        CurrWorkCtg := 0.0;
        CurrWaitingCtg := 0.0;
        quAutoFks.Parameters.ParamByName('Id_Auto').Value := Id_Auto;
        quAutoFks.Requery;

        MaxVkmh := 0.0;
        MaxFkH := 0.0;
        FksCount := quAutoFks.RecordCount;
        SetLength(Fks,FksCount);
        quAutoFks.First;
        while not quAutoFks.Eof do
        begin
          Fks[quAutoFks.RecNo-1].Vkmh  := quAutoFks.FieldByName('V').AsFloat;
          Fks[quAutoFks.RecNo-1].FkH := quAutoFks.FieldByName('Fk').AsFloat;
          if MaxVkmh<Fks[quAutoFks.RecNo-1].Vkmh
          then MaxVkmh := Fks[quAutoFks.RecNo-1].Vkmh;
          if MaxFkH<Fks[quAutoFks.RecNo-1].FkH
          then MaxFkH := Fks[quAutoFks.RecNo-1].FkH;
          quAutoFks.Next;
        end;{while}
        Next;
      end;{while}
      quAutoFks.Close;
    finally
      quAutoFks.Free;
    end;{try}
    Close;
  finally
    Free;
  end;{try}
  inherited;
end;{RefreshData}
function TesaAutoModels.CheckAllTerms: Boolean;
begin
  //������� ��������
  //1.������� ��� ������� ������ ���� �������������
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg(EAutoModelsEmpty,False);
end;{CheckAllTerms}

//TesaExcavator - ����� "���������� ���������� �����" -----------------------------------------
function TesaExcavator.GetModel: RESAExcavatorModel;
var ACount: Integer;
begin
  ACount := Openpit.ExcavatorModels.Count;
  if InRange(FExcavatorIndex,0,ACount-1)
  then Result := Openpit.ExcavatorModels[FExcavatorIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FExcavatorIndex,ACount-1]));
end;{GetModel}
constructor TesaExcavator.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FId_DeportExcavator := 0;
  FExcavatorIndex := -1;
  FParkNo := 0;
  FEYear := 0;
  FWorkState := True;
  FC1000tg := 0.0;
  FTsec := 0.0;
  FAddMaterialsMonthC1000tg := 0.0;
  FAddUnAccountedMonthC1000tg := 0.0;
  FEngineKIM := 1.0;
  FEngineKPD := 0.0;
  FLoadingPunkt := nil;
  FSENAmortizationRate := 0.0;
  FEvents := TesaResultExcavatorEvents.Create;
end;{Create}
destructor TesaExcavator.Destroy;
begin
  FLoadingPunkt := nil;
  Clear;
  FEvents.Free;
  FEvents := nil;
  inherited;
end;{Destroy}
procedure TesaExcavator.Clear;
begin
  if Assigned(FEvents) then Events.Clear;
end;{Clear} 

//TesaExcavators - ����� "����������� ���������� �����" ---------------------------------------
function TesaExcavators.GetItem(const Index: Integer): TesaExcavator;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;
constructor TesaExcavators.Create(ADispatcher: TDispatcher);
begin
  FItems := nil;
  FCount := 0;
  FWorkedCount := 0;
  inherited;
end;{Create}
destructor TesaExcavators.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaExcavators.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
  FWorkedCount := 0;
end;{Clear}
function TesaExcavators.FindBy(const AId_DeportExcavator: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_DeportExcavator=AId_DeportExcavator then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
procedure TesaExcavators.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('��������� ���� ������������...');
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitDeportExcavators '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
    Open;
    SetLength(FItems,RecordCount);
    FCount := 0;
    while not EOF do
    begin
      Inc(FCount);
      FItems[FCount-1] := TesaExcavator.Create(FDispatcher);
      with FItems[FCount-1] do
      begin
        FId_DeportExcavator := FieldByName('Id_DeportExcavator').AsInteger;
        FParkNo := FieldByName('ParkNo').AsInteger;
        FExcavatorIndex := Openpit.ExcavatorModels.FindBy(FieldByName('Id_Excavator').AsInteger);
        FName := Format('%s(%d)',[Model.Name,FParkNo]);
        FEYear := FieldByName('EYear').AsInteger;
        FWorkState := FieldByName('WorkState').AsBoolean;
        if FWorkState then Inc(FWorkedCount);
        FC1000tg := FieldByName('Cost').AsFloat;
        FTsec := FieldByName('FactCycleTime').AsFloat;
        FAddMaterialsMonthC1000tg := FieldByName('AddCostMaterials').AsFloat;
        FAddUnAccountedMonthC1000tg := FieldByName('AddCostUnAccounted').AsFloat;
        FEngineKIM := FieldByName('EngineKIM').AsFloat;
        FEngineKPD := FieldByName('EngineKPD').AsFloat;
        FSENAmortizationRate := FieldByName('SENAmortizationRate').AsFloat;
      end;{with}
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  inherited;
end;{RefreshData}
function TesaExcavators.CheckAllTerms: Boolean;
begin
  Result := FWorkedCount>0;
  //������� ��������
  //1.������� � ����� ��� ������� ������ ����������� � ������� ���������
  if not Result then SendInputDataErrorMsg(EExcavatorsWorkState,False);
end;{CheckAllTerms}

//������������ ����� �������������� ����� ������������-----------------------------------------
constructor TesaAutoAccordances.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
end;{Create}
destructor TesaAutoAccordances.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaAutoAccordances.Clear;
begin
  FCount := 0;
  FItems := nil;
end;{Clear}
//�������� ������������ ���� ������������� AId_Auto ���� ����������� AId_Excavator
function TesaAutoAccordances.IsAccordance(const AId_Auto,AId_Excavator: Integer): Boolean;
var
  I: Integer;
  bIsExist: Boolean;
begin
  Result := FCount=0;
  if not Result then
  begin
    bIsExist := False;//����� ��� ���� ���-��?
    for I := 0 to FCount-1 do
      if FItems[I].Id_Auto=AId_Auto then
      begin
        bIsExist := True; Break;
      end;{if}
    if not bIsExist
    then Result := True//���� �� ���-�� ����� ��� ����, �� ��� ����������� ��������
    else
    for I := 0 to FCount-1 do
      if (FItems[I].Id_Auto=AId_Auto)and(FItems[I].Id_Excavator=AId_Excavator)then
      begin
        Result := True; Break;
      end;{if}
  end;{if}
end;{IsAccordance}

procedure TesaAutoAccordances.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������������ ����� �������������� ����� ������������...');
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitAutoExcavAccordances '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    First;
    while not Eof do
    begin
      FItems[RecNo-1].Id_Auto     := FieldByName('Id_Auto').AsInteger;
      FItems[RecNo-1].Id_Excavator:= FieldByName('Id_Excavator').AsInteger;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  Inherited;
end;{RefreshData}

//TesaSubBlock - ����� "���-����-�������" -----------------------------------------------------
procedure TesaSubBlock.Clear;
begin
  FItems := nil;
  FCount := 0;
  FLm := 0.0;
  FCurrRightAutoIndex := -1;
  FCurrLeftAutoIndex := -1;
end;{Clear}
constructor TesaSubBlock.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
  FBlockIndex := -1;
end;{Create}
destructor TesaSubBlock.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TesaSubBlock.GetItem(const Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaSubBlock.GetRoadCoat: TesaRoadCoat;
begin
  if InRange(FBlockIndex,0,Openpit.Blocks.Count-1)
  then Result := Openpit.Blocks[FBlockIndex].RoadCoat
  else Raise Exception.Create(Format(EInvalidIndex,[FBlockIndex, Openpit.Blocks.Count-1]));
end;{GetRoadCoat}
function TesaSubBlock.GetBlock: TesaBlock;
begin
  if InRange(FBlockIndex,0,Openpit.Blocks.Count-1)
  then Result := Openpit.Blocks[FBlockIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FBlockIndex, Openpit.Blocks.Count-1]));
end;{GetBlock}

//TesaBlock - ����� "����-�������" ------------------------------------------------------------
function TesaBlock.GetRoadCoat: TesaRoadCoat;
begin
  if InRange(FRoadCoatIndex,0,Openpit.RoadCoats.Count-1)
  then Result := Openpit.RoadCoats[FRoadCoatIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FRoadCoatIndex, Openpit.RoadCoats.Count-1]));
end;{GetRoadCoat}
function TesaBlock.GetSubBlock(const Index: Integer): TesaSubBlock;
begin
  if InRange(Index,0,FSubBlocksCount-1)
  then Result := FSubBlocks[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FSubBlocksCount-1]));
end;{GetSubBlock}
//��������� ����-������� �� ���-����-������� ������, ������ ������������ ����������
procedure TesaBlock.UpdateSubBlocks(APointsList: TList; const ABlockIndex: Integer);
const
  mDistance10=10;    //����������� ���������� ����� �������, 10 ������
  mDistance50=50;    //���������� ����������, 50 ������
type
  RPoint=record
    Coords: RPoint3D;
    IzRizka: Boolean;
    Lm: Single;
  end;
var
  APointsLm: array of Single;
  APoints: array of RPoint;
  I,J: Integer;
  Lambda: Single;
  ACount: Integer;
  ACurrLm: Integer;
  mmLm: Integer;
  AIndex: Integer;
  ACoords0,ACoords1: RPoint3D;
  ABlockKinds: Set of TBlockKind;
begin
  //�������
  Clear;
  if APointsList.Count<2 then Exit;
  //���������� �����---------------------------------------------------------------------------
  SetLength(APointsLm,APointsList.Count);
  APointsLm[0] := 0.0;
  FLsm := 0;
  for I := 1 to APointsList.Count-1 do
  begin
    ACoords0 := PPoint3D(APointsList[I-1])^;
    ACoords1 := PPoint3D(APointsList[I])^;
    APointsLm[I]  := APointsLm[I-1]+sqrt(sqr(ACoords1.X-ACoords0.X)+
                                         sqr(ACoords1.Y-ACoords0.Y)+
                                         sqr(ACoords1.Z-ACoords0.Z));
  end;{for}
  FLsm := Round(100*APointsLm[APointsList.Count-1]);
  //�������� ����-������� �� 10 ������ � �������� ����� � APoints -----------------------------
  mmLm := Round(FLsm*10);
  ACount := (mmLm div (mDistance10*1000))+1;
  SetLength(APoints,2*ACount);
  for I := 0 to ACount-1 do
  begin
    ACurrLm := I*mDistance10;
    for J := 1 to APointsList.Count-1 do
    if InRange(ACurrLm,APointsLm[J-1],APointsLm[J])then
    begin
      ACoords0 := PPoint3D(APointsList[J-1])^;
      ACoords1 := PPoint3D(APointsList[J])^;
      Lambda :=(ACurrLm-APointsLm[J-1])/(APointsLm[J]-APointsLm[J-1]);
      APoints[I].Coords.X := ACoords0.X+(ACoords1.X-ACoords0.X)*Lambda;
      APoints[I].Coords.Y := ACoords0.Y+(ACoords1.Y-ACoords0.Y)*Lambda;
      APoints[I].Coords.Z := ACoords0.Z+(ACoords1.Z-ACoords0.Z)*Lambda;
      APoints[I].Lm := ACurrLm;
      APoints[I].IzRizka := (I=0)OR
                            ((I>0)and(ACurrLm mod mDistance50 = 0)and
                             (mmLm-1000*ACurrLm>=1000*mDistance50));
      Break;
    end;{for}
  end;{for}
  //�������� ��������� �����, �� ����������� � ����������� �� 10 ������
  if mmLm mod (1000*mDistance10)<>0 then
  begin
    Inc(ACount);
    APoints[ACount-1].Coords := PPoint3D(APointsList.Last)^;
    APoints[ACount-1].Lm := FLsm*0.01;
  end;{if}
  APoints[ACount-1].IzRizka := true;
  //������, ������,�������� ��� �������, ����������� �.���������� ��� ������ ����-�������!!!
  //��� ����� ��� ����� ������, ����� ������ � ��������� �����
  ABlockKinds := [bukMoving,bukRoadDown];
  if not(FKind in ABlockKinds) then
  begin
    for I := 1 to ACount-2 do
      APoints[I].IzRizka := false;
  end;{if}
  //��������� ��� ���������� � ���-����-�������
  FSubBlocksCount := 0;
  SetLength(FSubBlocks,2*ACount);
  AIndex := 0;
  for I := 1 to ACount-1 do
  if APoints[I].IzRizka then
  begin
    Inc(FSubBlocksCount);
    FSubBlocks[FSubBlocksCount-1] := TesaSubBlock.Create(FDispatcher);
    FSubBlocks[FSubBlocksCount-1].FBlockIndex := ABlockIndex;
    FSubBlocks[FSubBlocksCount-1].FLm := APoints[I].Lm;
    FSubBlocks[FSubBlocksCount-1].FCount := I-AIndex+1;
    SetLength(FSubBlocks[FSubBlocksCount-1].FItems,FSubBlocks[FSubBlocksCount-1].Count);
    for J := AIndex to I do
      FSubBlocks[FSubBlocksCount-1].FItems[J-AIndex] := APoints[J].Coords;
    AIndex := I;
  end;{for}
  SetLength(FSubBlocks,FSubBlocksCount);
  //UdateLm
  for I := 0 to FSubBlocksCount-1 do
  begin
    FSubBlocks[I].FLm := 0.0;
    for J := 1 to FSubBlocks[I].FCount-1 do
    begin
      FSubBlocks[I].FLm := FSubBlocks[I].FLm +
        sqrt(sqr(FSubBlocks[I].FItems[J-1].X-FSubBlocks[I].FItems[J].X)+
             sqr(FSubBlocks[I].FItems[J-1].Y-FSubBlocks[I].FItems[J].Y)+
             sqr(FSubBlocks[I].FItems[J-1].Z-FSubBlocks[I].FItems[J].Z));
    end;{for}
  end;{for}
  //������� ���������� ������ �����
  APoints := nil;
  APointsLm := nil;
end;{UpdateSubBlocks}
constructor TesaBlock.Create(ADispatcher: TDispatcher);
var
  ADir: TAutoDirection;
  AState : TAutoState;
begin
  inherited;
  FEvents := TesaResultBlockEvents.Create;
  FId_Block := 0;
  FStripsN := 0;
  FStripWm := 0;
  FRoadCoatIndex := -1;
  FRoadCoatIndex := -1;
  FLoadingVmax := 0;
  FUnLoadingVmax := 0;
  FKind := bukMoving;
  FLsm := 0;
  FSubBlocks := nil;
  FSubBlocksCount := 0;
  FId_Point0 := 0;
  FId_Point1 := 0;
  FSumRockVolume := esaRockVolume();
  for ADir := Low(TAutoDirection) to High(TAutoDirection) do
  begin
    FSumWgCount1[ADir]:= 0;
    for AState := Low(TAutoState) to High(TAutoState) do
    begin
      FSumAutoCount1[ADir,AState] := 0;
      FSumAutoDTsec1[ADir,AState] := 0.0;
      FSumAutoGXltr1[ADir,AState] := 0.0;
      FSumAutoV1[ADir,AState]     := 0.0;
      FSumAutoVCount1[ADir,AState]:= 0;
    end;{for}
  end;{for}
end;{Create}
destructor TesaBlock.Destroy;
begin
  Clear;
  FEvents.Free;
  FEvents := nil;
  inherited;
end;{Destroy}
procedure TesaBlock.Clear;
var
  I: Integer;
begin
  for I := 0 to FSubBlocksCount-1 do
  begin
    FSubBlocks[I].Free;
    FSubBlocks[I] := nil;
  end;{for}
  FSubBlocks := nil;
  FSubBlocksCount := 0;
  if Assigned(FEvents) then Events.Clear;
end;{Clear}

//TesaBlocks - ����� "����-�������" -----------------------------------------------------------
function TesaBlocks.GetItem(const Index: Integer): TesaBlock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
constructor TesaBlocks.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TesaBlocks.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TesaBlocks.FindBy(const AId_Block: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
    if FItems[I].Id_Block=AId_Block then
    begin
      Result := I; Break;
    end;{for}
end;{IndexOf}

// ������ ����-������� �������...
procedure TesaBlocks.RefreshData;
var
  quBlocks,quBlockPoints: TADOQuery;
  dsBlocks: TDataSource;
  APoints: TList;
  AItem: PPoint3D;
  I: Integer;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  APoints := TList.Create;
  SendMessage('����-������� �������...');
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
        quBlockPoints.SQL.Text := 'SELECT BP.*,P.X,P.Y,P.Z '+
                                  'FROM OpenpitBlockPoints BP, OpenpitPoints P '+
                                  'WHERE (Id_Block=:Id_Block)and'+
                                  '      (P.Id_Point=BP.Id_Point)';
        //�������� ����-�������
        quBlockPoints.Open;
        FCount := quBlocks.RecordCount;
        SetLength(FItems,FCount);
        quBlocks.First;
        while not quBlocks.Eof do
        begin
          FItems[quBlocks.RecNo-1] := TesaBlock.Create(FDispatcher);
          with quBlocks, FItems[quBlocks.RecNo-1] do
          begin
            FId_Block := FieldByName('Id_Block').AsInteger;
            FStripsN := FieldByName('StripCount').AsInteger;
            FStripWm := FieldByName('StripWidth').AsFloat;
            FRoadCoatIndex := Openpit.RoadCoats.FindBy(FieldByName('Id_RoadCoat').AsInteger);
            FLoadingVmax := FieldByName('LoadingVmax').AsFloat;
            FUnLoadingVmax := FieldByName('UnLoadingVmax').AsFloat;
            FKind := TBlockKind(FieldByName('Kind').AsInteger);
          end;{with}
          quBlockPoints.Last;
          FItems[quBlocks.RecNo-1].FId_Point1 := quBlockPoints.FieldByName('Id_Point').AsInteger;
          quBlockPoints.First;
          FItems[quBlocks.RecNo-1].FId_Point0 := quBlockPoints.FieldByName('Id_Point').AsInteger;
          //�������� ����� ����-��������
          while not quBlockPoints.Eof do
          begin
            New(AItem);
            AItem^.X := quBlockPoints.FieldByName('X').AsFloat;
            AItem^.Y := quBlockPoints.FieldByName('Y').AsFloat;
            AItem^.Z := quBlockPoints.FieldByName('Z').AsFloat;
            APoints.Add(AItem);
            quBlockPoints.Next;
          end;{while}
          //�������� ����-������� �� 50 �
          FItems[quBlocks.RecNo-1].UpdateSubBlocks(APoints,quBlocks.RecNo-1);
          //���������� ���-�� ���� ��
          FSubBlocksCount := FSubBlocksCount+FItems[quBlocks.RecNo-1].FSubBlocksCount;
          //������ ��������� ������ ����� �������� ��
          for I := 0 to APoints.Count-1 do
          begin
            Dispose(APoints[I]);
            APoints[I] := nil;
          end;{for}
          APoints.Clear;
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
  APoints.Free;
  Inherited;
end;{RefreshData}
function TesaBlocks.CheckAllTerms: Boolean;
var bIsExistMoving,bIsExistRoadDown,bIsExistManeuver,bIsExistCrossRoad: Boolean;
    I: Integer;
begin
  //������� ��������
  //1.������� ��� ������� ������ �� �������� � ������� ���������
  //2.������� ��� ������� ������ �� �������� � ������� ���������
  //3.������� ��� ������� ������ ����������� � ������� ���������
  //4.������� ��� ������� ������ ������ � ������� ���������
  //5.�� ������ �������� ��� ������� �� 2 �����
  bIsExistMoving := False;
  bIsExistManeuver := False;
  bIsExistCrossRoad := False;
  bIsExistRoadDown := False;
  Result := True;
  for I := 0 to FCount-1 do
  begin
    case FItems[I].Kind of
      bukMoving: bIsExistMoving := True;
      bukRoadDown: bIsExistRoadDown := True;
      bukManeuver: bIsExistManeuver := True;
      bukCrossRoad: bIsExistCrossRoad := True;
    end;{case}
    if FItems[I].BlockLsm<100 then
    begin
      SendInputDataErrorMsg(Format(EBlocksMinLm,[I+1]),False);
      Result := False;
    end;{if}
  end;{for}
  Result := Result and bIsExistMoving and bIsExistManeuver;
  if not bIsExistMoving then SendInputDataErrorMsg('��� �� ������ ����-������� ��������',False);
  if not bIsExistManeuver then SendInputDataErrorMsg('��� �� ������ ����-������� �������',False);
  if not bIsExistRoadDown then SendWarningMsg('��� �� ������ ������');
  if not bIsExistCrossRoad then SendWarningMsg('��� �� ������ �����������');
end;{CheckAllTerms}
procedure TesaBlocks.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
  FSubBlocksCount := 0;
end;{Clear}

//TesaPunkt - ����� "�����" -------------------------------------------------------------------
constructor TesaPunkt.Create;
begin
  inherited;
  FId_Point := 0;
  FCoords   := Point3D(0.0,0.0,0.0);
  FId_Punkt := 0;
end;{Create}
destructor TesaPunkt.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//TesaLoadingPunktRock - ����� "���������� ������ ������ �� ������ ��������" ------------------
function TesaLoadingPunktRock.GetRock: RESARock;
begin
  if InRange(FRockIndex,0,Openpit.Rocks.Count-1)
  then Result := Openpit.Rocks[FRockIndex]          
  else Raise Exception.Create(Format(EInvalidIndex,[FRockIndex,Openpit.Rocks.Count-1]));
end;{GetRock}
function TesaLoadingPunktRock.GetShiftFactRemainingQtn: Single;
begin
  if (abs(ShiftPlanQtn-ShiftFactRock.Qtn)>0.001)and(ShiftPlanQtn>ShiftFactRock.Qtn)
  then Result := ShiftPlanQtn-ShiftFactRock.Qtn
  else Result := 0.0;
end;{GetShiftFactRemainingQtn}
function TesaLoadingPunktRock.GetShiftPlanQtn : Single;
begin
  if Dispatcher.Openpit.Period.Kshift>0.0
  then Result := PeriodPlanQtn/Dispatcher.Openpit.Period.Kshift
  else Result := 0.0;
end;{GetShiftPlanQtn}

constructor TesaLoadingPunktRock.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FRockIndex     := -1;
  FContent       := 0.0;
  FPeriodPlanQtn := 0.0;
  FShiftFactRock := esaRockVolume();
end;{Create}
destructor TesaLoadingPunktRock.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaLoadingPunktRock.AddShiftFactRock(const AShiftFactVm3,AShiftFactQtn: Single);
begin
  FShiftFactRock.Vm3 := ShiftFactRock.Vm3+AShiftFactVm3;
  FShiftFactRock.Qtn := ShiftFactRock.Qtn+AShiftFactQtn;
end;{AddShiftFactRock}


//TesaLoadingPunkt - ����� "����� ��������" ---------------------------------------------------
function TesaLoadingPunkt.GetItem(const Index: Integer): TesaLoadingPunktRock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TesaLoadingPunkt.GetExcavator: TesaExcavator;
begin
  if InRange(FExcavatorIndex,0,Openpit.Excavators.Count-1)
  then Result := Openpit.Excavators[FExcavatorIndex]
  else Result := nil;
end;{GetExcavator}
function TesaLoadingPunkt.GetId_Excavator: Integer;
begin
  if InRange(FExcavatorIndex,0,Openpit.Excavators.Count-1)
  then Result := Openpit.Excavators[FExcavatorIndex].Model.Id_Excavator
  else Result := 0;
end;{GetId_Excavator}
function TesaLoadingPunkt.GetShiftPlanVm3: Single;
begin
  if Dispatcher.Openpit.Period.Kshift>0.0
  then Result := PeriodPlanVm3/Dispatcher.Openpit.Period.Kshift
  else Result := 0.0;
end;{GetShiftPlanVm3}
function TesaLoadingPunkt.GetShiftPlanQtn: Single;
begin
  if Dispatcher.Openpit.Period.Kshift>0.0
  then Result := PeriodPlanQtn/Dispatcher.Openpit.Period.Kshift
  else Result := 0.0;
end;{GetShiftPlanQtn}
procedure TesaLoadingPunkt.Clear;
var
  I: Integer;
  J: TPunktState;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems         := nil;
  FCount         := 0;
  FPeriodPlanVm3 := 0.0;
  FPeriodPlanQtn := 0.0;
  FShiftFactVm3  := 0.0;
  FShiftFactQtn  := 0.0;
  FCurrState     := psWaiting;
  for J := Low(TPunktState) to High(TPunktState) do
    FSumDTsec[J] := 0;
  FSumAutoCount  := 0;
end;{Clear}
constructor TesaLoadingPunkt.Create(ADispatcher: TDispatcher);
var J: TPunktState;
begin
  inherited;
  FCount          := 0;
  FItems          := nil;
  FId_LoadingPunkt:= 0;
  FExcavatorIndex := -1;
  FExcavatorName  := '';
  FName           := '';
  FPeriodPlanVm3  := 0.0;
  FPeriodPlanQtn  := 0.0;
  FShiftFactVm3   := 0.0;
  FShiftFactQtn   := 0.0;
  FCurrState      := psWaiting;
  for J := Low(TPunktState) to High(TPunktState) do
    FSumDTsec[J] := 0;
  FSumAutoCount     := 0;
end;{Create}
destructor TesaLoadingPunkt.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TesaLoadingPunkt.IndexOf(const AId_Rock: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to RockCount-1 do
  if Rocks[I].Rock.Id_Rock=AId_Rock then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TesaLoadingPunkt.AddPeriodPlanRock(const APeriodPlanVm3,APeriodPlanQtn: Single);
begin
 FPeriodPlanVm3:= PeriodPlanVm3 + APeriodPlanVm3;
 FPeriodPlanQtn:= PeriodPlanQtn + APeriodPlanQtn;
end;{AddPeriodPlanRock}
//TesaLoadingPunkts - ����� "������ ��������" -------------------------------------------------
function TesaLoadingPunkts.GetItem(const Index: Integer): TesaLoadingPunkt;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]          
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
constructor TesaLoadingPunkts.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FPlannedStrippingCoef := 0.0;
  FPlannedStrippingCoefVm3:= 0.0;
  FCount := 0;
  FItems := nil;
  FRocksContentMin := 0.0;
  FRocksContentMax := 0.0;
end;{Create}
destructor TesaLoadingPunkts.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaLoadingPunkts.RefreshData;
var
  quLoadingPunkts,quLoadingPunktRocks: TADOQuery;
  dsLoadingPunkts: TDataSource;
  Qvskrysha,Qruda: Single;
  QvskryshaVm3,QrudaVm3: Single;
  I,J: Integer;
  APunkt: TesaLoadingPunkt;
  ARock: TesaLoadingPunktRock;
begin
  Clear;
  Qvskrysha := 0.0;
  Qruda     := 0.0;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������ ��������...');
  quLoadingPunkts := TADOQuery.Create(nil);
  try
    quLoadingPunkts.Connection := DBConnection;
    quLoadingPunkts.SQL.Text := 'SELECT LP.*, P.X, P.Y, P.Z '+
                                'FROM OpenpitLoadingPunkts LP, OpenpitPoints P '+
                                'WHERE (LP.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and'+
                                '      (P.Id_Point=LP.Id_Point) ORDER BY LP.SortIndex';
    quLoadingPunkts.Open;
    dsLoadingPunkts := TDataSource.Create(nil);
    try
      dsLoadingPunkts.DataSet := quLoadingPunkts;
      quLoadingPunktRocks := TADOQuery.Create(nil);
      try
        quLoadingPunktRocks.Connection := DBConnection;
        quLoadingPunktRocks.SQL.Text := 'SELECT R.* '+
                                        'FROM OpenpitLoadingPunktRocks R '+
                                        'WHERE R.Id_LoadingPunkt=:Id_LoadingPunkt '+
                                        'ORDER BY R.SortIndex';
        quLoadingPunktRocks.DataSource := dsLoadingPunkts;
        quLoadingPunktRocks.Open;
        FCount := quLoadingPunkts.RecordCount;
        SetLength(FItems,FCount);
        quLoadingPunkts.First;
        while not quLoadingPunkts.Eof do
        begin
          FItems[quLoadingPunkts.RecNo-1] := TesaLoadingPunkt.Create(FDispatcher);
          APunkt := FItems[quLoadingPunkts.RecNo-1];
          APunkt.FId_LoadingPunkt    := quLoadingPunkts.FieldByName('Id_LoadingPunkt').AsInteger;
          APunkt.FExcavatorIndex := Openpit.Excavators.FindBy(quLoadingPunkts.FieldByName('Id_DeportExcavator').AsInteger);

          APunkt.Excavator.FLoadingPunkt := APunkt;
          if APunkt.FExcavatorIndex<>-1
          then APunkt.FExcavatorName := Format('%s (�%.2d)',[APunkt.Excavator.Model.Name,APunkt.Excavator.ParkNo])
          else APunkt.FExcavatorName := '';
          APunkt.FName     := Format('�%d. %s',[quLoadingPunkts.RecNo,APunkt.ExcavatorName]);
          APunkt.FId_Punkt := APunkt.FId_LoadingPunkt;
          APunkt.FId_Point := quLoadingPunkts.FieldByName('Id_Point').AsInteger;
          APunkt.FCoords.X := quLoadingPunkts.FieldByName('X').AsFloat;
          APunkt.FCoords.Y := quLoadingPunkts.FieldByName('Y').AsFloat;
          APunkt.FCoords.Z := quLoadingPunkts.FieldByName('Z').AsFloat;
          quLoadingPunktRocks.Last;
          quLoadingPunktRocks.First;
          APunkt.FCount := quLoadingPunktRocks.RecordCount;
          SetLength(APunkt.FItems,quLoadingPunktRocks.RecordCount);
          APunkt.FPeriodPlanVm3 := 0.0;
          APunkt.FPeriodPlanQtn := 0.0;
          with quLoadingPunktRocks do
          while not Eof do
          begin
            APunkt.FItems[RecNo-1]:= TesaLoadingPunktRock.Create(FDispatcher);
            ARock                 := APunkt.FItems[RecNo-1];
            ARock.FRockIndex      := Openpit.Rocks.FindBy(FieldByName('Id_Rock').AsInteger);
            ARock.FContent        := FieldByName('Content').AsFloat;
            ARock.FPeriodPlanQtn  := Round(FieldByName('PlannedV1000m3').AsFloat*1000)*FieldByName('DensityInBlock').AsFloat;
            ARock.FDensityInBlock := FieldByName('DensityInBlock').AsFloat;
            ARock.FShatteringCoef := FieldByName('ShatteringCoef').AsFloat;
            APunkt.AddPeriodPlanRock(FieldByName('PlannedV1000m3').AsFloat*1000, ARock.PeriodPlanQtn);
            Next;
          end;{while}
          quLoadingPunkts.Next;
        end;{while}
        quLoadingPunktRocks.Close;
      finally
        quLoadingPunktRocks.Free;
      end;
    finally
      dsLoadingPunkts.Free;
    end;
    quLoadingPunkts.Close;
  finally
    quLoadingPunkts.Free;
  end;
  for I := 0 to Count-1 do
    for J := 0 to Items[I].RockCount-1 do
    begin
      if Items[I].Rocks[J].Rock.IsMineralWealth then
        Qruda := Qruda+Items[I].Rocks[J].PeriodPlanQtn
      else
        Qvskrysha := Qvskrysha+Items[I].Rocks[J].PeriodPlanQtn;
    end;
  for i:= 0 to Count-1 do
    for j:= 0 to Items[I].RockCount-1 do
    begin
      if Items[I].Rocks[J].Rock.IsMineralWealth then
        QrudaVm3:= QrudaVm3 + Items[I].FPeriodPlanVm3
      else
        QvskryshaVm3:= QvskryshaVm3 + Items[I].FPeriodPlanVm3;
    end;
  if Qruda > 0.0 then
    FPlannedStrippingCoef:= Qvskrysha / Qruda;
  if QrudaVm3 > 0.0 then
    FPlannedStrippingCoefVm3:= QvskryshaVm3 / QrudaVm3;
  inherited;
end;
function TesaLoadingPunkts.CheckAllTerms: Boolean;
  procedure SendMyMsg(AMsg,APrompt: String);
  begin
    if AMsg<>'' then SendInputDataErrorMsg(Format(APrompt,[Copy(AMsg,1,Length(AMsg)-1)]),False);
  end;{SendMyMsg}
var
  I,J: Integer;
  sErrorRocks,sErrorExcs,sErrorExcStates: String;
begin
  //������� ��������
  //1. ������� ��� ������� ������ ������ ��������
  //2. ������� ����������� ������� ������ ������ ��� ������� ������ ��������
  //3. ������� ���������� ����������� ��� ������� ������ ��������
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg(ELoadingPunktsEmpty,False);
  sErrorRocks := '';
  sErrorExcs  := '';
  sErrorExcStates := '';
  FRocksContentMin := MaxInt;
  FRocksContentMax := 0.0;
  for I := 0 to FCount-1 do
  begin
    if FItems[I].RockCount=0
    then sErrorRocks := sErrorRocks+IntToStr(I+1)+',';
    if FItems[I].FExcavatorIndex=-1
    then sErrorExcs := sErrorExcs+IntToStr(I+1)+','
    else 
      if not FItems[I].Excavator.WorkState
      then sErrorExcStates := sErrorExcStates+IntToStr(I+1)+',';
    for J := 0 to FItems[I].RockCount-1 do
    if FItems[I].Rocks[J].Rock.IsMineralWealth then
    begin
      if FRocksContentMin > FItems[I].Rocks[J].Content
      then FRocksContentMin := FItems[I].Rocks[J].Content;
      if FRocksContentMax < FItems[I].Rocks[J].Content
      then FRocksContentMax := FItems[I].Rocks[J].Content;
    end;{for}
  end;{for}
  SendMyMsg(sErrorRocks,ELoadingPunktsRocksPlane);
  SendMyMsg(sErrorExcs,ELoadingPunktsExcavator);
  SendMyMsg(sErrorExcStates,ELoadingPunktsWorkState);
  Result := Result and(sErrorRocks='')and(sErrorExcs='')and(sErrorExcStates='');
  if Result and (FRocksContentMax-FRocksContentMin<0.0)then
  begin
    Result := False;
    SendInputDataErrorMsg(ELoadingPunktsRockContent,False);
  end;{if}
end;{CheckAllTerms}
procedure TesaLoadingPunkts.Clear;
var I: Integer;
begin
  FPlannedStrippingCoef := 0.0;
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaLoadingPunkts.FindBy(const AId_Point: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Point=AId_Point then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
function TesaLoadingPunkts.IndexOf(const AId_LoadingPunkt: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_LoadingPunkt=AId_LoadingPunkt then
  begin
    Result := I; Break;
  end;{if}
end;{IndexOf}
//TesaUnLoadingPunktRock - ����� "������ �� ������ ���������" ---------------------------------
function TesaUnLoadingPunktRock.GetRock: RESARock;
begin
  if InRange(FRockIndex,0,Openpit.Rocks.Count-1)
  then Result := Openpit.Rocks[FRockIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FRockIndex,Openpit.Rocks.Count-1]));
end;{GetRock}
constructor TesaUnLoadingPunktRock.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
end;{Create}
procedure TesaUnLoadingPunktRock.Clear;
begin
  FRockIndex := -1;
  FRequiredContent := 0.0;
  FInitialContent := 0.0;
  FInitialQtn := 0.0;
  FInitialVm3 := 0.0;
  FId_UnLoadingPunktRock := 0;

  FCurrRockVolume := esaRockVolume();
  FCurrContent := 0.0;
  FSumAutoCount := 0;
end;{Clear}

//TesaUnLoadingPunkt - ����� "����� ���������" ------------------------------------------------
function TesaUnLoadingPunkt.GetItem(const Index: Integer): TesaUnLoadingPunktRock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
//�������� ���?
function TesaUnLoadingPunkt.GetIsEmpty: Boolean;
begin
  Result := FCurrAutoCount<FAutoMaxCount;
end;{GetIsEmpty}
procedure TesaUnLoadingPunkt.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
  if Assigned(FEvents) then Events.Clear;
end;{Clear}
constructor TesaUnLoadingPunkt.Create(ADispatcher: TDispatcher);
var I: TPunktState;
begin
  inherited;
  FId_UnLoadingPunkt := 0;
  FCount             := 0;
  FItems             := nil;
  FMaxVm3            := 0.0;
  FAutoMaxCount      := 0;
  FKind              := ulpkFactory;
  FName              := '';
  FCurrState         := psWaiting;
  FCurrAutoCount     := 0;
  for I := Low(TPunktState) to High(TPunktState) do
    FSumDTsec[I] := 0;
  FCostsWork         := 0.0;
  FCostsProstoy      := 0.0;
  FAmortizationCtg   := 0.0;
  FCostsSummary      := 0.0;
  FEvents            := TesaResultUnloadingPunktEvents.Create;
end;{Create}
destructor TesaUnLoadingPunkt.Destroy;
begin
  Clear;
  FreeAndNil(FEvents);
  inherited;
end;{Destroy}
function TesaUnLoadingPunkt.IndexOf(const AId_Rock: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to RockCount-1 do
  if Rocks[I].Rock.Id_Rock=AId_Rock then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}

//TesaUnLoadingPunkts - ����� "������ ��������" -----------------------------------------------
function TesaUnLoadingPunkts.GetItem(const Index: Integer): TesaUnLoadingPunkt;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
constructor TesaUnLoadingPunkts.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TesaUnLoadingPunkts.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaUnLoadingPunkts.RefreshData;
var
  quUnLoadingPunkts,quUnLoadingPunktRocks: TADOQuery;
  dsUnLoadingPunkts: TDataSource;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������ ���������...');
  quUnLoadingPunkts := TADOQuery.Create(nil);
  try
    quUnLoadingPunkts.Connection := DBConnection;
    quUnLoadingPunkts.SQL.Text := 'SELECT UP.*,P.X,P.Y,P.Z  '+
                                  'FROM OpenpitUnLoadingPunkts UP, OpenpitPoints P '+
                                  'WHERE (UP.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and'+
                                  '      (P.Id_Point=UP.Id_Point) '+
                                  'ORDER BY UP.SortIndex';
    quUnLoadingPunkts.Open;
    dsUnLoadingPunkts := TDataSource.Create(nil);
    try
      dsUnLoadingPunkts.DataSet := quUnLoadingPunkts;
      quUnLoadingPunktRocks := TADOQuery.Create(nil);
      try
        quUnLoadingPunktRocks.Connection := DBConnection;
        quUnLoadingPunktRocks.SQL.Text := 'SELECT * FROM OpenpitUnLoadingPunktRocks '+
                                          'WHERE Id_UnLoadingPunkt=:Id_UnLoadingPunkt '+
                                          'ORDER BY SortIndex';
        quUnLoadingPunktRocks.DataSource := dsUnLoadingPunkts;
        quUnLoadingPunktRocks.Open;
        FCount := quUnLoadingPunkts.RecordCount;
        SetLength(FItems,FCount);
        quUnLoadingPunkts.First;
        while not quUnLoadingPunkts.Eof do
        begin
          FItems[quUnLoadingPunkts.RecNo-1] := TesaUnLoadingPunkt.Create(FDispatcher);
          with FItems[quUnLoadingPunkts.RecNo-1],quUnLoadingPunkts do
          begin
            FId_UnLoadingPunkt:= FieldByName('Id_UnLoadingPunkt').AsInteger;
            FId_Punkt         := FId_UnLoadingPunkt;
            FId_Point         := FieldByName('Id_Point').AsInteger;
            FCoords.X         := FieldByName('X').AsFloat;
            FCoords.Y         := FieldByName('Y').AsFloat;
            FCoords.Z         := FieldByName('Z').AsFloat;
            FMaxVm3           := FieldByName('MaxV1000m3').AsFloat*1000;
            FAutoMaxCount     := FieldByName('AutoMaxCount').AsInteger;
            FKind             := TUnLoadingPunktKind(FieldByName('Kind').AsInteger);
            FName             := Format('�%d.',[quUnLoadingPunkts.RecNo]);
            case FKind of
              ulpkFactory: FName := FName+' "�������"';
              ulpkStorage: FName := FName+' "������������� �����"';
              ulpkSpoil  : FName := FName+' "�����"';
            end;{case}
          end;{with}
          quUnLoadingPunktRocks.Last;
          quUnLoadingPunktRocks.First;
          FItems[quUnLoadingPunkts.RecNo-1].FCount := quUnLoadingPunktRocks.RecordCount;
          SetLength(FItems[quUnLoadingPunkts.RecNo-1].FItems,quUnLoadingPunktRocks.RecordCount);
          with quUnLoadingPunktRocks do
          while not Eof do
          begin
            FItems[quUnLoadingPunkts.RecNo-1].FItems[RecNo-1] :=
              TesaUnLoadingPunktRock.Create(FDispatcher);
            with FItems[quUnLoadingPunkts.RecNo-1].FItems[RecNo-1] do
            begin
              FId_UnLoadingPunktRock := FieldByName('Id_UnLoadingPunktRock').AsInteger;
              FRockIndex := Openpit.Rocks.FindBy(FieldByName('Id_Rock').AsInteger);
              FRequiredContent := FieldByName('RequiredContent').AsFloat;
              FInitialContent := FieldByName('InitialContent').AsFloat;
              FInitialVm3 := FieldByName('InitialV1000m3').AsFloat;
              FInitialQtn := FInitialVm3;//?
            end;{with}
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
  inherited;
end;{RefreshData}
function TesaUnLoadingPunkts.CheckAllTerms: Boolean;
var
  I,J,AOreCount,AStrippingCount: Integer;
  EUnLoadingPunktsRocks: String;
begin
  //������� ��������
  //1. ������� ��� ������� ������ ������ ���������
  //2. ������� ������ ��������� ������ ����, ����� - �������
  //3. ������� ������������ ������ ������ ��� ������� ������ ���������
  //4. �������� ������������ �������� ���������� ����������
  //   �� ������� ��������� ��������� ��������. � �������������
  //   �������� ���������� �� ������� ��������
  //5. ������ ��������� ��� ������� ���� ����
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg('��� ������ �� ������� ���������',False);
  EUnLoadingPunktsRocks := '';
  for I := 0 to FCount-1 do
  begin
    AOreCount := 0;
    AStrippingCount := 0;
    for J := 0 to FItems[I].RockCount-1 do
    begin
      if FItems[I].Rocks[J].Rock.IsMineralWealth then
      begin
        Inc(AOreCount);
        if not InRange(FItems[I].Rocks[J].RequiredContent,
                       Openpit.LoadingPunkts.RocksContentMin,
                       Openpit.LoadingPunkts.RocksContentMax)then
        begin
          Result := False;
          with FItems[I].Rocks[J],Openpit.LoadingPunkts do
            SendInputDataErrorMsg(Format(EUnLoadingPunktsContent,
              [I+1,RequiredContent,Rock.Name,RocksContentMin,RocksContentMax]),False);
        end;{if}
      end{if}
      else Inc(AStrippingCount);
    end;{for}
    case FItems[I].Kind of
      ulpkFactory:
      if (AOreCount=0)or(AStrippingCount<>0)then
      begin
        Result := False;
        if AOreCount=0 then SendInputDataErrorMsg(Format(EUnLoadingPunktsRockPlane,[I+1]),False);
        if AStrippingCount<>0
        then SendInputDataErrorMsg(Format(EUnLoadingPunktsFactoryStripping,[I+1]),False);
      end;{�������}
      ulpkStorage:
      if AOreCount=0 then
      begin
        Result := False;
        if AOreCount=0 then SendInputDataErrorMsg(Format(EUnLoadingPunktsRockPlane,[I+1]),False);
      end;{�����}
      ulpkSpoil:
      if (AOreCount<>0)or(AStrippingCount=0)then
      begin
        Result := False;
        if AStrippingCount=0
        then SendInputDataErrorMsg(Format(EUnLoadingPunktsSpoilStripping,[I+1]),False);
        if AOreCount<>0 then SendInputDataErrorMsg(Format(EUnLoadingPunktsSpoilRock,[I+1]),False);
      end;{�����}
    end;{case}
    //������� 5
    if (not Result)and(FItems[I].AutoMaxCount<1) then
    begin
      Result := false;
      SendInputDataErrorMsg(Format(EUnLoadingPunktsMaxAutoCount,[I+1]),False);
    end;{if}
  end;{for}
end;{CheckAllTerms}
procedure TesaUnLoadingPunkts.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaUnLoadingPunkts.FindBy(const AId_Point: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Point=AId_Point then
  begin
    Result := I; Break;
  end;{if}
end;{FindBy}
//TesaShiftPunkts - ����� "������ ����������" -------------------------------------------------
constructor TesaShiftPunkt.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FId_ShiftPunkt := 0;
end;{Create}
destructor TesaShiftPunkt.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
//TesaShiftPunkts - ����� "������ ����������" -------------------------------------------------
function TesaShiftPunkts.GetItem(Index: Integer): TesaShiftPunkt;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
constructor TesaShiftPunkts.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TesaShiftPunkts.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaShiftPunkts.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('������ ����������...');
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT SP.*,P.X,P.Y,P.Z '+
                'FROM OpenpitShiftPunkts SP, OpenpitPoints P '+
                'WHERE (SP.Id_Openpit='+IntToStr(Openpit.Id_Openpit)+')and'+
                '      (P.Id_Point=SP.Id_Point) '+
                'ORDER BY SP.SortIndex';
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    First;
    while not Eof do
    begin
      FItems[RecNo-1] := TesaShiftPunkt.Create(FDispatcher);
      with FItems[RecNo-1] do
      begin
        FId_ShiftPunkt := FieldByName('Id_ShiftPunkt').AsInteger;
        FId_Punkt      := FId_ShiftPunkt;
        FId_Point      := FieldByName('Id_Point').AsInteger;
        FCoords.X      := FieldByName('X').AsFloat;
        FCoords.Y      := FieldByName('Y').AsFloat;
        FCoords.Z      := FieldByName('Z').AsFloat;
        FName          := Format('�%d',[RecNo]);
      end;{with}
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  inherited;
end;{RefreshData}
function TesaShiftPunkts.CheckAllTerms: Boolean;
begin
  //������� ��������
  //1. ������� ��� ������� ������ ������ ����������
  Result := FCount>0;
  if not Result then SendInputDataErrorMsg(EShiftPunktsEmpty,False);
end;{CheckAllTerms}

procedure TesaShiftPunkts.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
end;{Clear}
function TesaShiftPunkts.FindBy(const AId_Point: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Point=AId_Point then
  begin
    Result := I; Break;
  end;{for}
end;{FindBy}
function TesaShiftPunkts.IndexOf(const AId_ShiftPunkt: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].FId_ShiftPunkt=AId_ShiftPunkt then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}

//TesaCourseBlock - ����� "���-����-������� �������� ��������" -----------------------------
function TesaCourseBlock.GetBlock: TesaBlock;
begin
  if InRange(FBlockIndex,0,Openpit.Blocks.Count-1)
  then Result := Openpit.Blocks[FBlockIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FBlockIndex,Openpit.Blocks.Count-1]));
end;{GetBlock}
function TesaCourseBlock.GetCourse: TesaCourse;
begin
  if InRange(FCourseIndex,0,Openpit.Courses.Count-1)
  then Result := Openpit.Courses[FCourseIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FCourseIndex,Openpit.Courses.Count-1]));
end;{GetCourse}
function TesaCourseBlock.GetBlockKind: TBlockKind;
begin
  Result := Block.Kind;
end;{GetBlockKind}
function TesaCourseBlock.GetBlockRoadCoat: TesaRoadCoat;
begin
  if InRange(FBlockIndex,0,Openpit.Blocks.Count-1)
  then Result := Openpit.Blocks[FBlockIndex].RoadCoat
  else Raise Exception.Create(Format(EInvalidIndex,[FBlockIndex,Openpit.Blocks.Count-1]));
end;{GetBlockRoadCoat} 
function TesaCourseBlock.GetRightAutoIndex: Integer;
begin
  if FIsRightDirection
  then Result := Block.FSubBlocks[FBlockSubIndex].FCurrRightAutoIndex
  else Result := Block.FSubBlocks[FBlockSubIndex].FCurrLeftAutoIndex;
end;{GetRightAutoIndex}
function TesaCourseBlock.GetPoint0: RPoint3D;
begin
  if FCount>0 then Result := FPoints[0] else Result := Point3D(0.0,0.0,0.0);
end;{GetPoint0}
function TesaCourseBlock.GetPoint1: RPoint3D;
begin
  if FCount>0 then Result := FPoints[FCount-1] else Result := Point3D(0.0,0.0,0.0);
end;{GetPoint1}
procedure TesaCourseBlock.Update;
var I: Integer;
begin
  for I := 1 to FCount-1 do
    FLm := sqrt(sqr(FPoints[I-1].X-FPoints[I].X)+sqr(FPoints[I-1].Y-FPoints[I].Y)+sqr(FPoints[I-1].Z-FPoints[I].Z));
//  if abs(FPoint1.Z-FPoint0.Z)<0.001
//  then FUklon := 0.0
//  else FUklon := 1000*sqrt(sqr(FPoint0.X-FPoint1.X)+sqr(FPoint0.Y-FPoint1.Y))/(FPoint1.Z-FPoint0.Z);
end;{Update}
function TesaCourseBlock.GetLeftAutoIndex: Integer;
begin
  if FIsRightDirection
  then Result := Block.FSubBlocks[FBlockSubIndex].FCurrLeftAutoIndex
  else Result := Block.FSubBlocks[FBlockSubIndex].FCurrRightAutoIndex;
end;{GetLeftAutoIndex}
procedure TesaCourseBlock.SetLeftAutoIndex(const Value: Integer);
begin
  if FIsRightDirection
  then Block.FSubBlocks[FBlockSubIndex].FCurrLeftAutoIndex := Value
  else Block.FSubBlocks[FBlockSubIndex].FCurrRightAutoIndex := Value;
end;{SetLeftAutoIndex}
procedure TesaCourseBlock.SetRightAutoIndex(const Value: Integer);
begin
  if FIsRightDirection
  then Block.FSubBlocks[FBlockSubIndex].FCurrRightAutoIndex := Value
  else Block.FSubBlocks[FBlockSubIndex].FCurrLeftAutoIndex := Value;
end;{SetRightAutoIndex}
constructor TesaCourseBlock.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
  Update;
end;{GetBlockCharacs}
procedure TesaCourseBlock.Clear;
begin
  FCourseIndex := -1;
  FBlockIndex := -1;
  FBlockSubIndex := -1;
  FPoints := nil;
  FCount := 0;
  FLm := 0.0;
  FIsRightDirection := true;
end;{GetBlockCharacs}
//TesaCourse - ����� "������� ��������" -------------------------------------------------------
function TesaCourse.GetItem(const Index: Integer): TesaCourseBlock;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
function TesaCourse.GetPunkt0: TesaPunkt;
begin
  Result := nil;            
  if FCount>0 then
  case FKind of
    ckCourseMoving: Result := Openpit.LoadingPunkts[FPunktIndex0];
    ckCourseSP_LP : Result := Openpit.ShiftPunkts[FPunktIndex0];
    ckCourseUP_SP : Result := Openpit.UnLoadingPunkts[FPunktIndex0];
  end;{case}
end;{GetPunkt0}
function TesaCourse.GetPunkt1: TesaPunkt;
begin
  Result := nil;            
  if FCount>0 then
  case FKind of
    ckCourseMoving: Result := Openpit.UnLoadingPunkts[FPunktIndex1];
    ckCourseSP_LP : Result := Openpit.LoadingPunkts[FPunktIndex1];
    ckCourseUP_SP : Result := Openpit.ShiftPunkts[FPunktIndex1];
  end;{case}
end;{GetPunkt1}
function TesaCourse.GetFirst: TesaCourseBlock;
begin
  if FCount>0
  then Result := FItems[0]
  else Raise Exception.Create(Format(EInvalidIndex,[0,FCount-1]));
end;{GetFirst}
function TesaCourse.GetLast: TesaCourseBlock;
begin
  if FCount>0
  then Result := FItems[FCount-1]
  else Raise Exception.Create(Format(EInvalidIndex,[0,FCount-1]));
end;{GetLast}
procedure TesaCourse.Update(const ABlockIndexes: TIntegerDynArray; const ABlocksCount: Integer);
type
  RSubBlock=record
    CourseIndex     : Integer;
    BlockIndex      : Integer;
    BlockSubIndex   : Integer;
    IsRightDirection: Boolean;
    Lm          : Single;
    Points: TPoints3DArray;
    Count: Integer;
  end;
  PSubBlock=^RSubBlock;
var
  I,J,K: Integer;
  AId_Point: Integer;
  AIsRightDirection: Boolean;
  ASubBlocks: TList;
  ACourseSubBlock: PSubBlock;
  ABlock: TesaBlock;
  ASubBlock: TesaSubBlock;
begin
  Clear;
  //��������� ������ ���-�� ��������
  ASubBlocks := TList.Create;
  AId_Point := FId_Point0;
  for I := 0 to ABlocksCount-1 do
  begin//��
    ABlock := Openpit.Blocks[ABlockIndexes[I]];
    AIsRightDirection := ABlock.FId_Point0=AId_Point;
    for J := 0 to ABlock.FSubBlocksCount-1 do
    begin//SubBlocks
      if AIsRightDirection
      then K := J
      else K := ABlock.FSubBlocksCount-1-J;
      ASubBlock := ABlock.FSubBlocks[K];      
//      if AIsRightDirection
//      then ASubBlock := ABlock.FSubBlocks[J]
//      else ASubBlock := ABlock.FSubBlocks[ABlock.FSubBlocksCount-1-J];
      New(ACourseSubBlock);
      ACourseSubBlock^.CourseIndex      := FCourseIndex;
      ACourseSubBlock^.BlockIndex       := ABlockIndexes[I];
//      ACourseSubBlock^.BlockSubIndex    := ASubBlocks.Count+1;
      ACourseSubBlock^.BlockSubIndex    := K;
      ACourseSubBlock^.IsRightDirection := AIsRightDirection;
      ACourseSubBlock^.Lm := ASubBlock.Lm;
      ACourseSubBlock^.Count := ASubBlock.FCount;
      SetLength(ACourseSubBlock^.Points,ACourseSubBlock^.Count);
      for K := 0 to ASubBlock.FCount-1 do
      begin//SubBlock Points
        if AIsRightDirection
        then ACourseSubBlock^.Points[K] := ASubBlock.Items[K]
        else ACourseSubBlock^.Points[K] := ASubBlock.Items[ASubBlock.FCount-1-K];
      end;{for}
      ASubBlocks.Add(ACourseSubBlock);
    end;{for}
    if AIsRightDirection
    then AId_Point := ABlock.FId_Point1
    else AId_Point := ABlock.FId_Point0;
  end;{for}
  //�������� ������ ���-�� ��������
  FLm := 0.0;
  FCount := ASubBlocks.Count;
  SetLength(FItems,FCount);
  for I := 0 to ASubBlocks.Count-1 do
  begin
    ACourseSubBlock := PSubBlock(ASubBlocks[I]);
    FItems[I] := TesaCourseBlock.Create(FDispatcher);
    FItems[I].FCourseIndex := ACourseSubBlock^.CourseIndex;
    FItems[I].FBlockIndex := ACourseSubBlock^.BlockIndex;
    FItems[I].FBlockSubIndex := ACourseSubBlock^.BlockSubIndex;
    FItems[I].FLm := ACourseSubBlock^.Lm;
    FItems[I].FIsRightDirection := ACourseSubBlock^.IsRightDirection;
    FItems[I].FCount := ACourseSubBlock^.Count;
    FItems[I].FPoints := Copy(ACourseSubBlock^.Points);
    FLm := FLm+FItems[I].FLm;
  end;{for}
  //�����������
  for I := ASubBlocks.Count-1 downto 0 do
  begin
    ACourseSubBlock := PSubBlock(ASubBlocks[I]);
    ACourseSubBlock^.Points := nil;
    Dispose(ASubBlocks[I]);
    ASubBlocks[I] := nil;
  end;{for}
  ASubBlocks.Clear;
  ASubBlocks.Free;
end;{Update}
constructor TesaCourse.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FId_Course   := 0;
  FCourseIndex := -1;
  FPunktIndex0 := -1;
  FPunktIndex1 := -1;
  FId_Point0   := 0;
  FId_Point1   := 0;
  FKind := ckCourseMoving;
  FLm := 0.0;
  FCount := 0;
  FItems := nil;
  FName := '';
end;{Create}
destructor TesaCourse.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaCourse.Clear;
var I: Integer;
begin
  FLm := 0.0;
  for I := 0 to FCount-1 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
end;{Clear}
//TesaCourses - ����� "�������� ��������" -----------------------------------------------------
function TesaCourses.GetItem(const Index: Integer): TesaCourse;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index,FCount-1]));
end;{GetItem}
constructor TesaCourses.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FCount := 0;
  FItems := nil;
end;{Create}
destructor TesaCourses.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaCourses.RefreshData;
var
  quCourses,quCourseBlocks: TADOQuery;
  dsCourses: TDataSource;
  ABlocksIndexes: TIntegerDynArray;
  ACount: Integer;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('��������...');
  quCourses := TADOQuery.Create(nil);
  try
    quCourses.Connection := DBConnection;
    quCourses.SQL.Text := 'SELECT * FROM OpenpitCourses WHERE Id_Openpit='+
                           IntToStr(Openpit.Id_Openpit);
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

        FCount := 0;
        SetLength(FItems,quCourses.RecordCount);
        quCourses.First;
        while not quCourses.Eof do
        begin
          Inc(FCount);
          quCourseBlocks.Last;
          quCourseBlocks.First;
          FItems[FCount-1] := TesaCourse.Create(FDispatcher);
          FItems[FCount-1].FId_Course := quCourses.FieldByName('Id_Course').AsInteger;
          FItems[FCount-1].FCourseIndex := FCount-1;
          FItems[FCount-1].FName := Format('�%d',[FCount]);
          FItems[FCount-1].FId_Point0 := quCourses.FieldByName('Id_Point0').AsInteger;
          FItems[FCount-1].FId_Point1 := quCourses.FieldByName('Id_Point1').AsInteger;
          FItems[FCount-1].FKind := TCourseKind(quCourses.FieldByName('Kind').AsInteger);
          case FItems[FCount-1].FKind of
            ckCourseMoving: begin
              FItems[FCount-1].FPunktIndex0 := Openpit.LoadingPunkts.FindBy(FItems[FCount-1].FId_Point0);
              FItems[FCount-1].FPunktIndex1 := Openpit.UnLoadingPunkts.FindBy(FItems[FCount-1].FId_Point1);
            end;{ckCourseMoving}
            ckCourseSP_LP: begin
              FItems[FCount-1].FPunktIndex0 := Openpit.ShiftPunkts.FindBy(FItems[FCount-1].FId_Point0);
              FItems[FCount-1].FPunktIndex1 := Openpit.LoadingPunkts.FindBy(FItems[FCount-1].FId_Point1);
            end;{ckCourseSP_LP}
            ckCourseUP_SP: begin
              FItems[FCount-1].FPunktIndex0 := Openpit.UnLoadingPunkts.FindBy(FItems[FCount-1].FId_Point0);
              FItems[FCount-1].FPunktIndex1 := Openpit.ShiftPunkts.FindBy(FItems[FCount-1].FId_Point1);
            end;{ckCourseUP_PS}
          end;{case}
          ACount := 0;
          SetLength(ABlocksIndexes,quCourseBlocks.RecordCount);
          while not quCourseBlocks.Eof do
          begin
            Inc(ACount);
            ABlocksIndexes[ACount-1] := Openpit.Blocks.FindBy(quCourseBlocks.FieldByName('Id_Block').AsInteger);
            quCourseBlocks.Next;
          end;{while}
          FItems[FCount-1].Update(ABlocksIndexes,quCourseBlocks.RecordCount);
          quCourses.Next;
        end;{while}
        quCourseBlocks.Close;
        ABlocksIndexes := nil;
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
  inherited;
end;{RefreshData}
function TesaCourses.CheckAllTerms: Boolean;
  procedure SendMyMsg(AMsg,APrompt: String);
  begin
    if AMsg<>'' then SendInputDataErrorMsg(Format(APrompt,[Copy(AMsg,1,Length(AMsg)-1)]),False);
  end;{SendMyMsg}
var
  I: Integer;
  bIsExistMoving,bIsExistTo,bIsExistFrom: Boolean;//������� 1
  sIsThreeBlocks,sIsManeuver,sIsPunkts: String; //������� 2-4
begin
  //������� ��������:
  //1. ������ ���� � ������� ��� ������� �� ������ �������� ������� ����
  //2. ��������� � �������� �� �������� ������ ���� ���� "����-������� ��� �������"
  //3. ������ ���� ������ ��������� � �������� ������ ��������
  //������� 1
  bIsExistMoving := False;
  bIsExistTo := False;
  bIsExistFrom := False;
  //������� 2-4
  sIsThreeBlocks := ''; sIsManeuver := '';
  sIsPunkts := ''; 
  for I := 0 to FCount-1 do
  begin
    //������� 1
    case FItems[I].Kind of
      ckCourseMoving: bIsExistMoving := True;
      ckCourseSP_LP : bIsExistTo := True;
      ckCourseUP_SP : bIsExistFrom := True;
    end;{case}
    //������� 2
    if FItems[I].FCount>=3 then
      if (FItems[I].First.Kind<>bukManeuver)OR
         (FItems[I].Last.Kind<>bukManeuver)
      then sIsManeuver := sIsManeuver+IntToStr(I+1)+',';
    //������� 3
    if (FItems[I].FPunktIndex0=-1)OR(FItems[I].FPunktIndex1=-1)
    then sIsPunkts := sIsPunkts+IntToStr(I+1)+',';
  end;{for}
  //������� �� ���������
  if not bIsExistMoving then SendInputDataErrorMsg(ECourseLP_UP,False);
  if not bIsExistTo then SendInputDataErrorMsg(ECourseSP_LP,False);
  if not bIsExistFrom then SendInputDataErrorMsg(ECourseUP_SP,False);
  SendMyMsg(sIsThreeBlocks,ECourseBlocksCount);
  SendMyMsg(sIsManeuver,ECourseExtreme);
  SendMyMsg(sIsPunkts,ECoursePunkts);
  Result := bIsExistMoving and bIsExistTo and bIsExistFrom and
           (sIsThreeBlocks='')and(sIsManeuver='')and(sIsPunkts='');
end;{CheckAllTerms}
procedure TesaCourses.Clear;
var I: Integer;
begin
  for I := 0 to FCount-1 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FCount := 0;
  FItems := nil;
end;{Clear}
function TesaCourses.FindBy(const AId_Course: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Course=AId_Course then
  begin
    Result := I; Break;
  end;{for}
end;{FindBy}
function TesaCourses.FindBy(const AId_Point0,AId_Point1: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
    if ((FItems[I].FId_Point0=AId_Point0)and(FItems[I].FId_Point1=AId_Point1))OR
       ((FItems[I].FId_Point0=AId_Point1)and(FItems[I].FId_Point1=AId_Point0))then
    begin
      Result := I; Break;
    end;{for}
end;{FindBy}

//������� ����������� ----------------------------------------------------------
constructor TesaResultExcavatorEvent.Create;
begin
  inherited;
  FKind         := eekNone;
  FTsec         := 0.0;
  FGx           := 0.0;
  FRock.Id_Rock         := 0;
  FRock.Name            := '';
  FRock.IsMineralWealth := False;
  FRockVolume   := esaRockVolume();
  FId_DumpModel := 0;
  FDumpModel    := '';
  FDumpNo       := 0;
end;{Create}
//������� ����������� ----------------------------------------------------------
function TesaResultExcavatorEvents.GetItem(const Index: Integer): TesaResultExcavatorEvent;
begin
  if InRange(Index,0,FCount-1)
  then Result := _GetItem(Index)
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultExcavatorEvents._GetItem(const Index: Integer): TesaResultExcavatorEvent;
begin
  Result := TesaResultExcavatorEvent(FItems.List^[Index])
end;{_GetItem}
function TesaResultExcavatorEvents.GetFirst: TesaResultExcavatorEvent;
begin
  if FCount>0 then Result := _GetItem(0) else Result := nil;
end;{GetFirst}
function TesaResultExcavatorEvents.GetLast: TesaResultExcavatorEvent;
begin
  if FCount>0 then Result := _GetItem(FCount-1) else Result := nil;
end;{GetLast}
procedure TesaResultExcavatorEvents.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      _Items[I].Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
procedure TesaResultExcavatorEvents.Append;
begin
  if not Assigned(FItems) then FItems := TList.Create;
  FItems.Add(TesaResultExcavatorEvent.Create);
  FCount := FItems.Count;
end;{Append}
//��������
procedure TesaResultExcavatorEvents.Loading(const dTsec: Integer; const ARock: ResaRock; const ARockVolume: ResaRockVolume; const AAuto: TesaAuto);
begin
  Append;
  Last.FKind         := eekLoading;
  Last.FTsec         := dTsec;
  Last.FGx           := 0.0;
  Last.FRock         := ARock;
  Last.FRockVolume   := ARockVolume;
  Last.FId_DumpModel := AAuto.Model.Id_Auto;
  Last.FDumpModel    := AAuto.Model.Name;
  Last.FDumpNo       := AAuto.FParkNo;
end;{Loading}
//������
procedure TesaResultExcavatorEvents.Manevr(const AGx: Single; const dTsec: Integer; const AAuto: TesaAuto);
begin
  Append;
  Last.FKind         := eekManevr;
  Last.FTsec         := dTsec;
  Last.FGx           := AGx;
  Last.FRock.Id_Rock         := 0;
  Last.FRock.Name            := '';
  Last.FRock.IsMineralWealth := False;
  Last.FRockVolume   := esaRockVolume();
  Last.FId_DumpModel := AAuto.Model.Id_Auto;
  Last.FDumpModel    := AAuto.Model.Name;
  Last.FDumpNo       := AAuto.FParkNo;
end;{Manevr}
constructor TesaResultExcavatorEvents.Create;
begin
  inherited;
  FItems      := nil;
  FCount      := 0;
end;{Create}
destructor TesaResultExcavatorEvents.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//������� �� --------------------------------------------------------------------------------------------
constructor TesaResultUnloadingPunktEvent.Create;
begin
  inherited;
  FKind                 := uekNone;
  FTsec                 := 0.0;
  FRock.Id_Rock         := 0;
  FRock.Name            := '';
  FRock.IsMineralWealth := False;
  FRockVolume           := esaRockVolume();
  FRockContent          := 0.0;
  FId_DumpModel         := 0;
  FDumpModel            := '';
  FDumpNo               := 0;
end;{Create}
//������� ����������� ----------------------------------------------------------
function TesaResultUnloadingPunktEvents.GetItem(const Index: Integer): TesaResultUnloadingPunktEvent;
begin
  if InRange(Index,0,FCount-1)
  then Result := _GetItem(Index)
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultUnloadingPunktEvents._GetItem(const Index: Integer): TesaResultUnloadingPunktEvent;
begin
  Result := TesaResultUnloadingPunktEvent(FItems.List^[Index])
end;{_GetItem}
function TesaResultUnloadingPunktEvents.GetFirst: TesaResultUnloadingPunktEvent;
begin
  if FCount>0 then Result := _GetItem(0) else Result := nil;
end;{GetFirst}
function TesaResultUnloadingPunktEvents.GetLast: TesaResultUnloadingPunktEvent;
begin
  if FCount>0 then Result := _GetItem(FCount-1) else Result := nil;
end;{GetLast}
procedure TesaResultUnloadingPunktEvents.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      _Items[I].Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
procedure TesaResultUnloadingPunktEvents.Append;
begin
  if not Assigned(FItems) then FItems := TList.Create;
  FItems.Add(TesaResultUnloadingPunktEvent.Create);
  FCount := FItems.Count;
end;{Append}
//��������
procedure TesaResultUnloadingPunktEvents.UnLoading(const dTsec: Integer; const ARock: ResaRock; const ARockVolume: ResaRockVolume; const ARockContent: Single; const AAuto: TesaAuto);
begin
  Append;
  Last.FKind         := uekLoading;
  Last.FTsec         := dTsec;
  Last.FRock         := ARock;
  Last.FRockVolume   := ARockVolume;
  Last.FRockContent  := ARockContent;
  Last.FId_DumpModel := AAuto.Model.Id_Auto;
  Last.FDumpModel    := AAuto.Model.Name;
  Last.FDumpNo       := AAuto.FParkNo;
end;{Loading}
//������
procedure TesaResultUnloadingPunktEvents.Manevr(const AGx: Single; const dTsec: Integer; const AAuto: TesaAuto);
begin
  Append;
  Last.FKind                 := uekManevr;
  Last.FTsec                 := dTsec;
  Last.FRock.Id_Rock         := 0;
  Last.FRock.Name            := '';
  Last.FRock.IsMineralWealth := False;
  Last.FRockVolume           := esaRockVolume();
  Last.FId_DumpModel         := AAuto.Model.Id_Auto;
  Last.FDumpModel            := AAuto.Model.Name;
  Last.FDumpNo               := AAuto.FParkNo;
end;{Manevr}
constructor TesaResultUnloadingPunktEvents.Create;
begin
  inherited;
  FItems      := nil;
  FCount      := 0;
end;{Create}
destructor TesaResultUnloadingPunktEvents.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//������� ������������� --------------------------------------------------------
constructor TesaResultAutoEvent.Create;
begin
  inherited;
  FKind       := ekNone;
  FDirection  := edNone;
  FIdPunkt0   := 0;
  FHorizont0  := 0.0;
  FIdPunkt1   := 0;
  FHorizont1  := 0.0;
  FSm         := 0.0;
  FTsec       := 0.0;
  FGx         := 0.0;
  FId_Rock    := 0;
  FRock       := '';
  FRockIsMineralWealth := False;
  FRockVolume          := esaRockVolume();
  FAvgVkmh             := esaDrobValue();
end;{Create}

//������� ������������� ------------------------------------------------------
function TesaResultAutoEvents.GetItem(const Index: Integer): TesaResultAutoEvent;
begin
  if InRange(Index,0,FCount-1)
  then Result := _GetItem(Index)
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultAutoEvents._GetItem(const Index: Integer): TesaResultAutoEvent;
begin
  Result := TesaResultAutoEvent(FItems.List^[Index])
end;{_GetItem}
function TesaResultAutoEvents.GetFirst: TesaResultAutoEvent;
begin
  if FCount>0 then Result := _GetItem(0) else Result := nil;
end;{GetFirst}
function TesaResultAutoEvents.GetLast: TesaResultAutoEvent;
begin
  if FCount>0 then Result := _GetItem(FCount-1) else Result := nil;
end;{GetLast}
procedure TesaResultAutoEvents.Clear;
var I: Integer;
begin
  FKind       := ekNone;
  FDirection  := edNone;
  FIdPunkt0   := 0;
  FHorizont0  := 0.0;
  FIdPunkt1   := 0;
  FHorizont1  := 0.0;
  FSm         := 0.0;
  FTsec       := 0.0;
  FGx         := 0.0;
  FId_Rock    := 0;
  FRock       := '';
  FRockIsMineralWealth := False;
  FRockVolume := esaRockVolume();
  FWAvgHmNum  := 0.0;
  FWAvgHmDen  := 0.0;
  FAvgHmNum   := 0.0;
  FAvgHmDen   := 0.0;
  FAvgVkmh    := esaDrobValue();
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      _Items[I].Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
procedure TesaResultAutoEvents.Append;
begin
  if not Assigned(FItems) then
    FItems := TList.Create;
  FItems.Add(TesaResultAutoEvent.Create);
  FCount := FItems.Count;
end;{Append}
//����� ����������
procedure TesaResultAutoEvents.Shifting(const APunkt: TesaPunkt);
begin
  Append;
  Last.FKind      := ekATC;
  Last.FDirection := edNulled;
  Last.FIdPunkt0  := APunkt.Id_Punkt;
  Last.FHorizont0 := APunkt.Horizont;
  Last.FIdPunkt1  := APunkt.Id_Punkt;
  Last.FHorizont1 := APunkt.Horizont;
end;{Shifting}
//�������������� ����������
procedure TesaResultAutoEvents.Aborting(const dTsec: Single;
                                        const AKind: TesaResultAutoEventKind;
                                        const ADirection: TesaResultAutoEventDirection
                                        );
begin
  Append;
  Last.FKind:= AKind;
  if AKind <> ekMoving then
    Last.FKind:= ekATC;
  Last.FTsec:= dTsec;
end;
//��������
procedure TesaResultAutoEvents.Loading(const AGx: Single; const dTsec: Integer; const APunkt: TesaPunkt);
begin
  Append;
  Last.FKind      := ekLoadingPunkt;
  Last.FIdPunkt0  := APunkt.Id_Punkt;
  Last.FHorizont0 := APunkt.Horizont;
  Last.FIdPunkt1  := APunkt.Id_Punkt;
  Last.FHorizont1 := APunkt.Horizont;
  Last.FTsec      := dTsec;
  Last.FGx        := AGx;
end;{Loading}
//���������
procedure TesaResultAutoEvents.UnLoading(const AGx: Single; const dTsec: Integer; const ARock: RESARock; const ARockVolume: ResaRockVolume; const APunkt: TesaPunkt);
begin
  Append;
  Last.FKind      := ekUnLoadingPunkt;
  Last.FIdPunkt0  := APunkt.Id_Punkt;
  Last.FHorizont0 := APunkt.Horizont;
  Last.FIdPunkt1  := APunkt.Id_Punkt;
  Last.FHorizont1 := APunkt.Horizont;
  Last.FTsec      := dTsec;
  Last.FGx        := AGx;
  Last.FId_Rock   := ARock.Id_Rock;
  Last.FRock      := ARock.Name;
  Last.FRockIsMineralWealth := ARock.IsMineralWealth;
  Last.FRockVolume:= ARockVolume
end;{UnLoading}
//�������
procedure TesaResultAutoEvents.Waiting(const AGx: Single; const dTsec: Integer;
          const ADir: TesaResultAutoEventDirection; const ARock: RESARock;
          const ARockVolume: ResaRockVolume; const APunkt0,APunkt1: TesaPunkt);
begin
  Append;
  Last.FKind      := ekWaiting;
  Last.FDirection := ADir;
  Last.FIdPunkt0  := APunkt0.Id_Punkt;
  Last.FHorizont0 := 0.0;
  Last.FIdPunkt1  := APunkt0.Id_Punkt;
  Last.FHorizont1 := 0.0;
  Last.FTsec      := dTsec;
  Last.FGx        := AGx;
  Last.FId_Rock   := ARock.Id_Rock;
  Last.FRock      := ARock.Name;
  Last.FRockIsMineralWealth := ARock.IsMineralWealth;
  Last.FRockVolume := ARockVolume;
end;{Waiting}
//������
procedure TesaResultAutoEvents.Manevr(const AGx: Single;
                                      const dTsec: Integer;
                                      const ADir: TesaResultAutoEventDirection;
                                      const AId_Punkt0,AId_Punkt1: Integer;
                                      const ARock: RESARock;
                                      const ARockVolume: ResaRockVolume;
                                      const AWAvgHmNum,AWAvgHmDen,AAvgHmNum,AAvgHmDen,AAvgVkmhNum,AAvgVkmhDen,Sm: Single);
begin
  Append;
  Last.FKind      := ekManevr;
  Last.FDirection := ADir;
  Last.FIdPunkt0  := AId_Punkt0;
  Last.FHorizont0 := 0.0;
  Last.FIdPunkt1  := AId_Punkt1;
  Last.FHorizont1 := 0.0;
  Last.FSm        := Sm;
  Last.FTsec      := dTsec;
  Last.FGx        := AGx;
  Last.FId_Rock   := ARock.Id_Rock;
  Last.FRock      := ARock.Name;
  Last.FRockIsMineralWealth := ARock.IsMineralWealth;
  Last.FRockVolume:= ARockVolume;
  Last.FAvgVkmh   := esaDrobValue(AAvgVkmhNum,AAvgVkmhDen);
end;{Manevr}
//��������
procedure TesaResultAutoEvents.Moving;
begin
  Append;
  Last.FKind      := FKind;
  Last.FDirection := FDirection;
  Last.FIdPunkt0  := FIdPunkt0;
  Last.FHorizont0 := FHorizont0;
  Last.FIdPunkt1  := FIdPunkt1;
  Last.FHorizont1 := FHorizont1;
  Last.FSm        := FSm;
  Last.FTsec      := FTsec;
  Last.FGx        := FGx;
  Last.FId_Rock   := FId_Rock;
  Last.FRock      := FRock;
  Last.FRockIsMineralWealth := FRockIsMineralWealth;
  Last.FRockVolume:= FRockVolume;
  Last.FAvgVkmh   := FAvgVkmh;
  //�������
  FKind           := ekNone;
  FDirection      := edNone;
  FIdPunkt0       := 0;
  FHorizont0      := 0.0;
  FIdPunkt1       := 0;
  FHorizont1      := 0.0;
  FSm             := 0.0;
  FTsec           := 0.0;
  FGx             := 0.0;
  FId_Rock        := 0;
  FRock           := '';
  FRockIsMineralWealth := False;
  FRockVolume     := esaRockVolume();
  FWAvgHmNum      := 0.0;
  FWAvgHmDen      := 0.0;
  FAvgHmNum       := 0.0;
  FAvgHmDen       := 0.0;
  FAvgVkmh        := esaDrobValue();
end;{Moving}
constructor TesaResultAutoEvents.Create;
begin
  inherited;
  FItems      := nil;
  FCount      := 0;
  FWAvgHmNum  := 0.0;
  FWAvgHmDen  := 0.0;
  FAvgHmNum   := 0.0;
  FAvgHmDen   := 0.0;
end;{Create}
destructor TesaResultAutoEvents.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//������� ����-������� ---------------------------------------------------------
procedure TesaResultBlockEvent.Clear;
begin
  FRockVolume            := esaRockVolume();

  FMovingTminNulled      := esaDrobValue();
  FMovingTminLoading     := esaDrobValue();
  FMovingTminUnLoading   := esaDrobValue();
  
  FWaitingTminNulled     := esaDrobValue();
  FWaitingTminLoading    := esaDrobValue();
  FWaitingTminUnLoading  := esaDrobValue();
  
  FMovingGx              := esaDirectionValue();
  FWaitingGx             := esaDirectionValue();

  FVkmhNulled            := esaDrobValue();
  FVkmhLoading           := esaDrobValue();
  FVkmhUnLoading         := esaDrobValue();

  FWaitingsCount         := esaDirectionValue();
  FAutosCount            := esaDirectionValue();
end;{Clear}
constructor TesaResultBlockEvent.Create;
begin
  inherited;
  Clear;
end;{Create}
destructor TesaResultBlockEvent.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaResultBlockEvent.Assign(ADect: TesaResultBlockEvent);
begin
  FRockVolume            := ADect.RockVolume;

  FMovingTminNulled      := ADect.MovingTminNulled;
  FMovingTminLoading     := ADect.MovingTminLoading;
  FMovingTminUnLoading   := ADect.MovingTminUnLoading;
  
  FWaitingTminNulled     := ADect.WaitingTminNulled;
  FWaitingTminLoading    := ADect.WaitingTminLoading;
  FWaitingTminUnLoading  := ADect.WaitingTminUnLoading;

  FMovingGx              := ADect.MovingGx;
  FWaitingGx             := ADect.WaitingGx;

  FVkmhNulled            := ADect.VkmhNulled;
  FVkmhLoading           := ADect.VkmhLoading;
  FVkmhUnLoading         := ADect.FVkmhUnLoading;

  FWaitingsCount         := ADect.WaitingsCount;
  FAutosCount            := ADect.AutosCount;
end;{Assign}

//������� ����-������� ---------------------------------------------------------
function TesaResultBlockEvents.GetItem(const Index: Integer): TesaResultBlockEvent;
begin
  if InRange(Index,0,FCount-1)
  then Result := _GetItem(Index)
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultBlockEvents._GetItem(const Index: Integer): TesaResultBlockEvent;
begin
  Result := TesaResultBlockEvent(FItems.List^[Index])
end;{_GetItem}
function TesaResultBlockEvents.GetFirst: TesaResultBlockEvent;
begin
  if FCount>0 then Result := _GetItem(0) else Result := nil;
end;{GetFirst}
function TesaResultBlockEvents.GetLast: TesaResultBlockEvent;
begin
  if FCount>0 then Result := _GetItem(FCount-1) else Result := nil;
end;{GetLast}
procedure TesaResultBlockEvents.Clear;
var I: Integer;
begin
  inherited Clear;
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      _Items[I].Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
//������������ ������
procedure TesaResultBlockEvents.Accumulate(
      const ADir   : TAutoDirection;
      const AState : TAutoState;
      const AAuto  : TesaAuto;
      const AIsDone: Boolean = False);
begin
  if ADir=adLoading
  then FRockVolume := esaSum(RockVolume,AAuto.FCurrRockVolume);

  if AState in [asMovingFk,asMovingHh,asMovingBt] then
  case ADir of
    adLoading  : begin
      FMovingTminLoading := esaSum(MovingTminLoading,AAuto.FCurrDtReqSec/60,1.0);
      FMovingGx.Loading := MovingGx.Loading+AAuto.FCurrGxReq;
      FVkmhLoading := esaSum(VkmhLoading,AAuto.FCurrVavg,1.0);
    end;{adLoading}
    adUnLoading  : begin
      FMovingTminUnLoading := esaSum(MovingTminUnLoading,AAuto.FCurrDtReqSec/60,1.0);
      FMovingGx.UnLoading := MovingGx.UnLoading+AAuto.FCurrGxReq;
      FVkmhUnLoading := esaSum(VkmhUnLoading,AAuto.FCurrVavg,1.0);
    end;{adUnLoading}
    else begin
      FMovingTminNulled := esaSum(MovingTminNulled,AAuto.FCurrDtReqSec/60,1.0);
      FMovingGx.Nulled  := MovingGx.Nulled+AAuto.FCurrGxReq;
      FVkmhNulled := esaSum(VkmhNulled,AAuto.FCurrVavg,1.0);
    end;{adNull}
  end;{case}
  if AState in [asWaiting] then
  case ADir of
    adLoading  : begin
      FWaitingTminLoading := esaSum(WaitingTminLoading,AAuto.FCurrDtReqSec/60,1.0);
      FWaitingGx.Loading := WaitingGx.Loading+AAuto.FCurrGxReq;
      FWaitingsCount.Loading := FWaitingsCount.Loading+1.0;
    end;{adLoading}
    adUnLoading  : begin
      FWaitingTminUnLoading := esaSum(WaitingTminUnLoading,AAuto.FCurrDtReqSec/60,1.0);
      FWaitingGx.UnLoading := WaitingGx.UnLoading+AAuto.FCurrGxReq;
      FWaitingsCount.UnLoading := FWaitingsCount.UnLoading+1.0;
    end;{adUnLoading}
    else begin
      FWaitingTminNulled := esaSum(WaitingTminNulled,AAuto.FCurrDtReqSec/60,1.0);
      FWaitingGx.Nulled := WaitingGx.Nulled+AAuto.FCurrGxReq;
      FWaitingsCount.Nulled := FWaitingsCount.Nulled+1.0;
    end;{adNull}
  end;{case}

  if AIsDone then
  begin
    if AState in [asMovingFk,asMovingHh,asMovingBt] then
    case ADir of
      adLoading  : FAutosCount.Loading   := AutosCount.Loading+1.0;
      adUnLoading: FAutosCount.UnLoading := AutosCount.UnLoading+1.0;
      else         FAutosCount.Nulled    := AutosCount.Nulled+1.0;
    end;{case}
    if not Assigned(FItems) then FItems := TList.Create;
    FItems.Add(TesaResultBlockEvent.Create);
    FCount := FItems.Count;
    Items[Count-1].Assign(Self);
    inherited Clear;
  end;{if}
end;{Accumulate}
constructor TesaResultBlockEvents.Create;
begin
  inherited;
  FItems      := nil;
  FCount      := 0;
end;{Create}

//TesaAuto - ����� "������������ ���������� �����" -----------------------------
function TesaAuto.GetModel: RESAAutoModel;
begin
  if InRange(FAutoModelIndex,0,Openpit.AutoModels.Count-1) then
    Result := Openpit.AutoModels[FAutoModelIndex]
  else
    Raise Exception.Create(Format(EInvalidIndex,[FAutoModelIndex,Openpit.AutoModels.Count-1]));
end;
function TesaAuto.GetId_Auto: Integer;
begin
  if InRange(FAutoModelIndex,0,Openpit.AutoModels.Count-1)
  then Result := Openpit.AutoModels[FAutoModelIndex].Id_Auto
  else Result := 0;
end;{GetId_Auto}
function TesaAuto.GetCourse: TesaCourse;
begin
  if InRange(FCourseIndex,0,Openpit.Courses.Count-1)
  then Result := Openpit.Courses[FCourseIndex]
  else Result := nil;
end;{GetCourse}
function TesaAuto.GetCourseBlock: TesaCourseBlock;
begin
  Result := nil;
  if Course<>nil then
    if InRange(FCurrCourseBlockIndex,0,Course.Count-1)
    then Result := Course.Items[FCurrCourseBlockIndex]
end;{GetSubBlock}
function TesaAuto.GetCurrCourse: TesaCourse;
begin
  if InRange(FCurrCourseIndex,0,Openpit.Courses.Count-1)
  then Result := Openpit.Courses[FCurrCourseIndex]
  else Result := nil;
end;{GetCurrCourse}
function TesaAuto.GetCurrCourseBlock: TesaCourseBlock;
begin
  Result := nil;
  if CurrCourse<>nil then                   
    if InRange(FCurrCourseBlockIndex,0,CurrCourse.Count-1)
    then Result := CurrCourse.Items[FCurrCourseBlockIndex]
end;{GetCurrSubBlock}
function TesaAuto.GetCurrCourseBlockHmtr: Single;
begin
  Result := 0.0;
  if CurrBlock<>nil then
  begin
    if FCurrDirection=adUnLoading
    then Result := CurrBlock.FPoints[0].Z-CurrBlock.FPoints[CurrBlock.FCount-1].Z
    else Result := CurrBlock.FPoints[CurrBlock.FCount-1].Z-CurrBlock.FPoints[0].Z;
  end;{if}
end;{GetCurrCourseBlockHmtr}
function TesaAuto.GetShiftPunkt: TesaShiftPunkt;
var ACount: Integer;
begin
  ACount := Openpit.ShiftPunkts.Count;
  if InRange(FShiftPunktIndex,0,ACount-1)
  then Result := Openpit.ShiftPunkts[FShiftPunktIndex]
  else Raise Exception.Create(Format(EInvalidIndex,[FShiftPunktIndex,ACount-1]));
end;{GetShiftPunkt}
function TesaAuto.GetRock: RESARock;
begin
  Result.Id_Rock := 0;
  Result.Name := '';
  Result.IsMineralWealth := false;
  with Openpit do
  if InRange(FCurrRockLoadingPunktIndex,0,LoadingPunkts.Count-1)then
    with LoadingPunkts[FCurrRockLoadingPunktIndex] do
      if InRange(FCurrRockLoadingPunktRockIndex,0,RockCount-1)
      then Result := Rocks[FCurrRockLoadingPunktRockIndex].Rock;
end;{GetRock}
function TesaAuto.GetLoadingPunktRock: TesaLoadingPunktRock;
begin
  Result := nil;
  with Openpit do
  if InRange(FCurrRockLoadingPunktIndex,0,LoadingPunkts.Count-1)then
    with LoadingPunkts[FCurrRockLoadingPunktIndex] do
      if InRange(FCurrRockLoadingPunktRockIndex,0,RockCount-1)
      then Result := Rocks[FCurrRockLoadingPunktRockIndex];
end;{GetLoadingPunktRock}
//��������� � ��������� ��� ��������� ���������?
function TesaAuto.GetIsStopped: Boolean;
begin
  Result := FCurrState in [asAbort,asUnWorked,asDone];
end;{GetIsStopped}
//��������� � �������(� NOT IsStopped)?
function TesaAuto.GetIsWaiting: Boolean;
begin
  Result := FCurrState=asWaiting;
end;{GetIsStopped}
//��������� � ������(NOT IsStopped � NOT IsWaiting)?
function TesaAuto.GetIsWorking: Boolean;
begin
  Result := not(IsWaiting Or IsStopped);
end;{GetIsWorking}
//��������� �� ������ ���������?
function TesaAuto.GetIsOnUnloadingPunkt: Boolean;
begin
  Result := (FCurrPosition=apOnPunkt1)and(FCurrDirection=adLoading);
end;{GetIsOnUnloadingPunkt}
constructor TesaAuto.Create(ADispatcher: TDispatcher);
begin
  inherited;
  FName := '';
  FId_DeportAuto   := 0;
  FAutoModelIndex  := -1;
  FParkNo          := 0;
  FAYear           := 0;
  FWorkState       := True;
  FFactTonnage     := 0.0;
  FC1000tg         := 0.0;
  FAmortizationKind:= akYear;
  FAmortizationRate:= 0.0;
  FTransmissionKPD := 0.0;
  FEngineKPD       := 0.0;
  FTyreC1000tg     := 0.0;
  FTyresAmortizationR1000km := 0.0;
  FShiftPunktIndex := -1;
  FCourseIndex     := -1;
  FAutoIndex := -1;
  FEvents   := TesaResultAutoEvents.Create;
  Clear;
end;{Create}
destructor TesaAuto.Destroy;
begin
  Clear;
  FEvents.Free;
  FEvents := nil;
  inherited;
end;{Destroy}
procedure TesaAuto.Clear;
var
  APos: TAutoPosition;
  ADir: TAutoDirection;
  AState: TAutoState;
begin
  FName := '';
  FAutoIndex := -1;
  FCurrCourseIndex        := -1;
  FCurrCourseBlockIndex   := -1;
  FCurrPunktIndex         := -1;
  FCurrState              := asWaiting;
  FCurrDirection          := adFromSP;
  FCurrPosition           := apNone;
  FCurrRockLoadingPunktIndex    := -1;
  FCurrRockLoadingPunktRockIndex:= -1;
  FCurrRock.Id_Rock             := 0;
  FCurrRock.Name                := '';
  FCurrRock.IsMineralWealth     := False;
  FCurrRockVolume               := esaRockVolume();
  FCurrRockContent              := 0.0;
  FCurrRockVolumeRequired       := esaRockVolume();

  FCurrPoint := Point3D(0.0,0.0,0.0);
  FCurrIndentPoint := FCurrPoint;
  FCurrAzimut:= 0.0;
  FCurrZenit := 0.0;
  FCurrV0    := 0.0;
  FCurrV1    := 0.0;
  FCurrV     := 0.0;
  FCurrVavg  := 0.0;
  FCurrW0    := 0.0;
  FCurrW1    := 0.0;
  FCurrW     := 0.0;

  FCurrDt0Sec  := 0;
  FCurrDt1Sec  := 0;
  FCurrDtReqSec:= 0;
  FCurrGx      := 0.0;
  FCurrGxReq   := 0.0;
  FSumQtnDSkm  := 0.0;
  FSumHmtr     := 0.0;
  FSumHLmtr    := 0.0;
  FSumVavg     := 0.0;
  FSumVavgCount:= 0;
  //Summary
  FSumRocksVm3           := 0.0;
  FSumRocksQtn           := 0.0;
  for ADir := Low(TAutoDirection) to High(TAutoDirection) do
  begin
    FSumTripsCount[ADir] := 0;
    for APos := Low(TAutoPosition) to High(TAutoPosition) do
    for AState := Low(TAutoState) to High(TAutoState) do
    begin
      FSumDSmtr[ADir,APos,AState] := 0.0;
      FSumDTsec[ADir,APos,AState] := 0.0;
      FSumGXltr[ADir,APos,AState] := 0.0;
    end;{for}
  end;{for}
  if Assigned(FEvents) then Events.Clear;
end;{Clear}
//����������� ���� ���� Fk, H
function TesaAuto.DefineFH(Vkmh: Single): Single;
var
  I: Integer;
  Lambda: Single;
  //
  v_min, v_max: single;
begin
  Result := 0.0;
  if Model.FksCount>0 then
  begin
    if Vkmh > Model.FKs[Model.FksCount-1].Vkmh then
      Vkmh:= Model.FKs[Model.FksCount-1].Vkmh;
    for I:= 1 to Model.FksCount-1 do
      with Model do
      begin
        v_min:= FKs[I-1].Vkmh;
        v_max:= FKs[I].Vkmh;
        if InRange(Vkmh, v_min, v_max) then
        begin
          Lambda:= (Vkmh - FKs[I-1].Vkmh) / (FKs[I].Vkmh - FKs[I-1].Vkmh);
          Result:= FKs[I-1].FkH + Lambda * (FKs[I].FkH - FKs[I-1].FkH);
          Break;
        end;
      end;
    Result := Result * 1000.0;
  end;
end;
//����������� �����.������������� ������� w0, H
function TesaAuto.DefineW0_(const Ptn,Q: Single; const ARoadCoat: TesaRoadCoat): Single;
var I: Integer;
begin
  //��� ���������� ����
  Result := 0.0;
  for I := 1 to ARoadCoat.Count-1 do
  if InRange(Ptn+Q,ARoadCoat[I-1].Ptn,ARoadCoat[I].Ptn) then
  begin
    Result := ARoadCoat[I].WavgHkH; Break;
  end;{for}
  //��� ��������� ���� (���������� �� 20-25%)
  if Q<1.0
  then Result := Result+Result*(0.20+0.25)*0.5;
end;{DefineW0_}
//����������� ������� ������������� �� ��������� �����, W��, �
function TesaAuto.DefineWv(const Vkmh: Single): Single;
begin
  Result := Model.Ro*Model.F*Vkmh*Vkmh;
end;{DefineWv}
//��������� �������� ������ ������� ��� ����������� �������� ��������� g�, �/���*�
function TesaAuto.DefineGn_(): Single;
const
  Qdt=43.4;//������� �������� ����������, ���/�
var
  Ne: Single;//����������� ��� ���������
begin
  //�.�.�������, �.�.���� "������ ������.����������.������-��" ������������,2002;���.130;�.4.17
  Ne := FEngineKPD;
  if Ne>0.0
  then Result := 3600/(Qdt*Ne)
  else Result := 0.0;
end;{DefineGn_}
//��������� �������� ������ ������� ��� ��������(������� �����) g�, �/��
function TesaAuto.DefineGd_(Ga,Ggm,wo_,wi_: Single): Single;
const
  ro=0.825;//��������� ���������� �������, ��/�
  kpj=1.0;//��������.����-�, ������-��� ���-��� g� � �������� �������� �� j-� ������� ������
var
  gn: Single;//�������� ������ ������� ��� ����������� �������� ��������� g�, �/���*�
  Na: Single;//��� ����������� ����
begin
  //�.�.�������, �.�.���� "������ ������.����������.������-��" ������������,2002;���.135;�.4.29
  gn := DefineGn_();
  Na := FTransmissionKPD;
  if Na>0.0
  then Result := gn*(Ga+Ggm)*(wo_+wi_)*kpj/(3.67*100*Na*ro)
  else Result := 0.0;
end;{DefineGd_}
//��������� �������� ������ ������� ��� ��������/���������/������.������� gi, �/�
function TesaAuto.DefineGi_(): Single;
const
  ro=0.825;//��������� ���������� �������, ��/�
var
  gn: Single;//�������� ������ ������� ��� ����������� �������� ��������� g�, �/���*�
  Nd: Single;//�����.�������� ��������� ����
  knj: Single;//������� ������������� �������� ��������� = Nd ����/Nd �����
begin
  //�.�.�������, �.�.���� "������ ������.����������.������-��" ������������,2002;���.135;�.4.30
  gn := DefineGn_();
  if Model.TransmissionKPD>0.0
  then knj := FTransmissionKPD/Model.TransmissionKPD{? ������ ��������� ��������� �����������}
  else knj := 0.0;
  Nd := Model.EngineMaxNkVt;
  Result := gn*Nd*knj/(1000*ro)
end;{DefineGi_}
//TesaAutos - ����� "������������� ���������� �����" ------------------------------------------
function TesaAutos.GetItem(const Index: Integer): TesaAuto;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaAutos.Create(ADispatcher: TDispatcher);
begin
  FItems := nil;
  FCount := 0;
  FWorkedCount := 0;
  inherited;
end;{Create}
destructor TesaAutos.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TesaAutos.Clear;
var I: Integer;
begin
  for I := FCount-1 downto 0 do
  begin
    FItems[I].Free;
    FItems[I] := nil;
  end;{for}
  FItems := nil;
  FCount := 0;
  FWorkedCount := 0;
end;{Clear}
procedure TesaAutos.RefreshData;
var AIndex: Integer;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('��������� ���� ��������������...');
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitDeportAutos '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit)+' ORDER BY SortIndex';
    Open;
    FWorkedCount := 0;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    AIndex := 0;
    while not EOF do
    begin
      FItems[AIndex] := TesaAuto.Create(FDispatcher);
      FItems[AIndex].FId_DeportAuto := FieldByName('Id_DeportAuto').AsInteger;
      FItems[AIndex].FAutoModelIndex := Openpit.AutoModels.FindBy(FieldByName('Id_Auto').AsInteger);
      FItems[AIndex].FAutoIndex := AIndex;
      FItems[AIndex].FParkNo := FieldByName('ParkNo').AsInteger;
      FItems[AIndex].FAYear := FieldByName('AYear').AsInteger;
      FItems[AIndex].FWorkState := FieldByName('WorkState').AsBoolean;
      FItems[AIndex].FFactTonnage := FieldByName('FactTonnage').AsFloat;
      FItems[AIndex].FC1000tg := FieldByName('Cost').AsFloat;
      FItems[AIndex].FAmortizationKind := TesaAmortizationKind(FieldByName('AmortizationKind').AsInteger);
      FItems[AIndex].FAmortizationRate := FieldByName('AmortizationRate').AsFloat;
      FItems[AIndex].FTransmissionKPD := FieldByName('TransmissionKPD').AsFloat;
      FItems[AIndex].FEngineKPD := FieldByName('EngineKPD').AsFloat;
      FItems[AIndex].FTyreC1000tg := FieldByName('TyreCost').AsFloat;
      FItems[AIndex].FTyresAmortizationR1000km := FieldByName('TyresRaceRate').AsFloat;
      FItems[AIndex].FShiftPunktIndex := Openpit.ShiftPunkts.IndexOf(FieldByName('Id_ShiftPunkt').AsInteger);
      FItems[AIndex].FCourseIndex := Openpit.Courses.FindBy(FieldByName('Id_Course').AsInteger);
      if FItems[AIndex].FWorkState then Inc(FWorkedCount);
      if FItems[AIndex].FAutoModelIndex<>-1
      then FItems[AIndex].FName := Format('�%d %s',[FItems[AIndex].FParkNo,FItems[AIndex].Model.Name])
      else FItems[AIndex].FName := '';
      Inc(AIndex);
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  Inherited;
end;{RefreshData}
function TesaAutos.CheckAllTerms: Boolean;
  procedure SendMyMsg(AMsg,APrompt: String);
  begin
    if AMsg<>'' then SendInputDataErrorMsg(Format(APrompt,[Copy(AMsg,1,Length(AMsg)-1)]),False);
  end;{SendMyMsg}
type
  PCourseIndex=^Integer;
var
  sShiftPunkt,sAccordance: String;
  I,J: Integer;
  iShiftPunktId_Point,iLoadingPunktId_Point,iUnLoadingPunktId_Point: Integer;
  iLoadingPunktInd,iUnLoadingPunktInd,iId_Excavator: Integer;
  bIsAccordanceEnabled: Boolean;
  ACourseIndex: PCourseIndex;
  AAllowedCourseIndexes: TList;
begin
  Result := True;
  //������� ��������
  //1.������� � ����� ��� ������� ������ ������������� � ������� ���������
  //2.���� �.�. ��������� �� ������� ��������
  //3.��� ����,������������� �� ���������, ������ ��������������� ���� ����������� �� �� ������� ��������
  //4.����,������������ �� ���������, �.����� ����������� ��������� � ���������
  //5.����,�� ������������ �� ���������, �.����� ����������� ������� � ��������� ��� ������� ������ ��������
  //6.� ���� �.�. MaxVkmh>10 ��/�  
  //7.� ���� �.�. MaxFkH>100 ��  
  sShiftPunkt := '';
  sAccordance := '';
  AAllowedCourseIndexes := TList.Create;
  for I := 0 to FCount-1 do
  with FItems[I] do
  begin
    if FWorkState then //�������� ������ ���� � ������� ���������
    begin
      //������� 2
      if FShiftPunktIndex=-1 then sShiftPunkt := sShiftPunkt+IntToStr(FParkNo)+',';

      if Course<>nil then//���� � �������� �����(��������� �� ���������� ���������)
      begin
        //������� 3
        iLoadingPunktId_Point   := Course.Punkt0.Id_Point;
        iUnLoadingPunktId_Point := Course.Punkt1.Id_Point;
        iShiftPunktId_Point     := ShiftPunkt.Id_Point;
        iLoadingPunktInd        := Openpit.LoadingPunkts.FindBy(iLoadingPunktId_Point);
        iUnLoadingPunktInd      := Openpit.UnLoadingPunkts.FindBy(iUnLoadingPunktId_Point);
        iId_Excavator           := TesaLoadingPunkt(Course.Punkt0).Excavator.Model.Id_Excavator;
        //������� 3
        if not Openpit.AutoAccordances.IsAccordance(Model.Id_Auto,iId_Excavator)
        then sAccordance := sAccordance+IntToStr(FParkNo)+',';
        //���������� �� ��� ���� ������� "����� ����������-����� ��������"
        if Openpit.Courses.FindBy(iShiftPunktId_Point,iLoadingPunktId_Point)=-1 then
        begin
          SendInputDataErrorMsg(Format(EAutosCourseSP_LP,
            [Name,FCourseIndex+1,FShiftPunktIndex+1,iLoadingPunktInd+1]),False);
          Result := False;
        end;{if}
        //���������� �� ��� ���� ������� "����� ���������-����� ����������"
        if Openpit.Courses.FindBy(iUnLoadingPunktId_Point,iShiftPunktId_Point)=-1 then
        begin
          SendInputDataErrorMsg(Format(EAutosCourseUP_SP,
            [Name,FCourseIndex+1,iUnLoadingPunktInd+1,FShiftPunktIndex+1]),False);
          Result := False;
        end;{if}
        //�������� ������ ������������ ��������
        New(ACourseIndex);
        ACourseIndex^ := FCourseIndex;
        AAllowedCourseIndexes.Add(ACourseIndex);
      end{if}
      else//���� � �������� �����(�� ��������� �� ���������� ���������)
      if FShiftPunktIndex>-1 then
      begin
        bIsAccordanceEnabled := False;
        for J := 0 to Openpit.Courses.Count-1 do
        if Openpit.Courses[J].Kind=ckCourseMoving then //�������� �� ���� ��������� ��������
        begin
          iLoadingPunktId_Point   := Openpit.Courses[J].Punkt0.Id_Point;
          iUnLoadingPunktId_Point := Openpit.Courses[J].Punkt1.Id_Point;
          iShiftPunktId_Point     := ShiftPunkt.Id_Point;
          iId_Excavator := TesaLoadingPunkt(Openpit.Courses[J].Punkt0).Excavator.Model.Id_Excavator;
          if (Openpit.Courses.FindBy(iShiftPunktId_Point,iLoadingPunktId_Point)>-1)AND
             (Openpit.Courses.FindBy(iUnLoadingPunktId_Point,iShiftPunktId_Point)>-1)AND
             (Openpit.AutoAccordances.IsAccordance(Model.Id_Auto,iId_Excavator))then
          begin//���� I-� ���� ����� ����� �� J-� �������, � ��������������� ����� ����������
//            SendMessage(Format('������������ %s ����� ��������� �� �������� �%d',[Name,J+1]));
            bIsAccordanceEnabled := True;
            //�������� ������ ������������ ��������
            New(ACourseIndex);
            ACourseIndex^ := J;
            AAllowedCourseIndexes.Add(ACourseIndex);
          end;{if}
        end;{for}
        if not bIsAccordanceEnabled then
        begin//���� I-� ���� �� ����� ������ �� �� ���� ������� ��������
          Result := False;
          SendInputDataErrorMsg(Format(EAutosCourseTupik,[Name]),False);
        end;{if}
      end;{else}
    end;{if}
    //������� 6
    if FItems[I].FWorkState and(FItems[I].Model.MaxVkmh<10.0) then
    begin
      Result := False;
      SendInputDataErrorMsg(Format(EAutosWrongVk,[Name]),False);
    end;{if}
    //������� 7
    if FItems[I].FWorkState and(FItems[I].Model.MaxFkH<100.0) then
    begin
      Result := False;
      SendInputDataErrorMsg(Format(EAutosWrongFkMax,[Name]),False);
    end;{if}
  end;{for}
  AAllowedCourseIndexes.Free;
  if FWorkedCount=0 then SendInputDataErrorMsg(EAutosWorkState);//������� 1
  SendMyMsg(sShiftPunkt,EAutosShiftsPunkts);//������� 2
  SendMyMsg(sAccordance,EAutosEscavator);//������� 3
  Result := Result and (FWorkedCount>0) and (sShiftPunkt='');
end;{CheckAllTerms}
function TesaAutos.FindBy(const AId_Auto: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Model.Id_Auto=AId_Auto then
  begin
    Result := I; Break;
  end;{for}
end;{FindBy}

//������ "�������������� ���������� �� ����������" --------------------------------------------
function TesaAdditionalRoadParams.GetItem(const Index: Integer): RESAAdditionalRoadParam;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaAdditionalRoadParams.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
end;{Create}
destructor TesaAdditionalRoadParams.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TesaAdditionalRoadParams.FindBy(const AId_RoadCoat: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_RoadCoat=AId_RoadCoat then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TesaAdditionalRoadParams.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
procedure TesaAdditionalRoadParams.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('�������������� ���������� �� ����������...');
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitRoadOtherAccounts '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    begin
      FItems[RecNo-1].Id_RoadCoat := FieldByName('Id_RoadCoat').AsInteger;
      FItems[RecNo-1].BuildingC1000tn := FieldByName('BuildingCosts').AsFloat;
      FItems[RecNo-1].KeepingYearC1000tn := FieldByName('KeepingCosts').AsFloat;
      FItems[RecNo-1].AmortizationR := FieldByName('AmortizationNorm').AsFloat;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  inherited;
end;{RefreshData}
function TesaAdditionalRoadParams.CheckAllTerms: Boolean;
var I,AIndex: Integer;
begin
  Result := True;
  //������� ��������
  //1.������� �������������� ����������� ��� ������� ��������� ��������
  for I := 0 to Openpit.RoadCoats.Count-1 do
  begin
    AIndex := FindBy(Openpit.RoadCoats[I].Id_RoadCoat);
    if AIndex=-1 then
    begin
      Result := False;
      SendInputDataErrorMsg(Format(ERoadCoatAdditionalEmpty,[Openpit.RoadCoats[I].Name]),False);
    end{if}
    else
    begin
      Openpit.RoadCoats.FItems[I].FBuildingC1000tn := Items[AIndex].BuildingC1000tn;
      Openpit.RoadCoats.FItems[I].FKeepingYearC1000tn := Items[AIndex].KeepingYearC1000tn;
      Openpit.RoadCoats.FItems[I].FAmortizationR := Items[AIndex].AmortizationR;
    end;{else}
  end;{AIndex}
end;{CheckAllTerms}
//������ "�������������� ���������� �� ����������" --------------------------------------------
function TesaAdditionalAutoParams.GetItem(const Index: Integer): RESAAdditionalAutoParam;
begin
  if InRange(Index,0,FCount-1)
  then Result := FItems[Index]
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
constructor TesaAdditionalAutoParams.Create(ADispatcher: TDispatcher);
begin
  inherited;
  Clear;
end;{Create}
destructor TesaAdditionalAutoParams.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
function TesaAdditionalAutoParams.FindBy(const AId_Auto: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FCount-1 do
  if FItems[I].Id_Auto=AId_Auto then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TesaAdditionalAutoParams.Clear;
begin
  FItems := nil;
  FCount := 0;
end;{Clear}
procedure TesaAdditionalAutoParams.RefreshData;
begin
  Clear;
  if FDispatcher.IsErrorInputData then Exit;
  SendMessage('�������������� ���������� �� ��������������...');
  with TADOQuery.Create(Nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitAutoOtherAccounts '+
                'WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
    Open;
    FCount := RecordCount;
    SetLength(FItems,FCount);
    while not EOF do
    begin
      FItems[RecNo-1].Id_Auto := FieldByName('Id_Auto').AsInteger;
      FItems[RecNo-1].SparesCpercent := FieldByName('Spares').AsFloat;
      FItems[RecNo-1].MaterialsCpercent := FieldByName('GreasingSubstance').AsFloat;
      FItems[RecNo-1].MaintenanceMonthC1000tg := FieldByName('MaintenanceCost').AsFloat;
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
  inherited;
end;{RefreshData}
function TesaAdditionalAutoParams.CheckAllTerms: Boolean;
var I,AIndex: Integer;
begin
  Result := True;
  //������� ��������
  //1.������� �������������� ����������� ��� ������� ���� �������������
  for I := 0 to Openpit.AutoModels.Count-1 do
  if Openpit.Autos.FindBy(Openpit.AutoModels[I].Id_Auto)>-1 then
  begin
    AIndex := FindBy(Openpit.AutoModels[I].Id_Auto);
    if AIndex=-1 then
    begin
      Result := False;
      SendInputDataErrorMsg(Format(EAutoAdditionalEmpty,[Openpit.AutoModels[I].Name]),False);
    end{if}
    else
    begin
      Openpit.AutoModels.FItems[I].SparesCpercent := Items[AIndex].SparesCpercent;
      Openpit.AutoModels.FItems[I].MaterialsCpercent := Items[AIndex].MaterialsCpercent;
      Openpit.AutoModels.FItems[I].MaintenanceMonthC1000tg := Items[AIndex].MaintenanceMonthC1000tg;
    end;{else}
  end;{AIndex}
end;{CheckAllTerms}
//TesaOpenpit - ����� "������" ----------------------------------------------------------------
procedure TesaOpenpit.SetId_Openpit(Value: Integer);
begin
  if (FId_Openpit=0)and(Value>0)and(not FDispatcher.IsRunning) then
  begin
    FId_Openpit := Value;
  end;{if}
end;{SetId_Openpit}
constructor TesaOpenpit.Create(ADispatcher: TDispatcher);
begin
  FPeriod := esaPeriod();
  FShift  := esaShift();
  FCommon := esaCommon();
  FId_Openpit := 0;
  FName := '';
  FDateCreate := Now;
  FRoadCoats := nil;
  FRocks := nil;
  FExcavatorModels := nil;
  FAutoModels := nil;
  FExcavators := nil;
  FAutoAccordances := nil;
  FBlocks := nil;
  FLoadingPunkts := nil;
  FUnLoadingPunkts := nil;
  FShiftPunkts := nil;
  FCourses := nil;
  FAutos := nil;
  FAdditionalRoadParams := nil;
  FAdditionalAutoParams := nil;
  inherited Create(ADispatcher);
  //�������������� ����� ����������
  FCommon.DollarCtg           := 146.8;
  FCommon.YearExpensesCtg     := 2000000.0;
  FCommon.SalaryCoef          := 1.26;
  //�������������� ���������� �� ������������
  FCommon.ExcavatorMashinistSalary := esaSalary(30000.0,10000.0);
  FCommon.ExcavatorAssistantSalary := esaSalary(20000.0, 5000.0);
  FCommon.ExcavatorFuelCtg         := 2.00;
  FCommon.ExcavatorAmortizationR   := 0.07;
  //�������������� ���������� �� ��������������
  FCommon.AutoDriverSalary := esaSalary(30000.0,0.0);
  FCommon.AutoFuel := esaAutoFuel(40.0,36.0,7,fctAverage);
  //�������������� ���������� �� ������ ������ � �������� �����
  FCommon.AutoWorkRegime     := wrQualityAveraging;
  FCommon.StrippingCoefUsing := True;
  //�������������� ���������� �������������
  FShift                     := esaShift(1.0,0.65,0.30,1,720,30);
  FPeriod.Tday               := 180;
  FPeriod.AnimationTsec      := 1;
  //�������� ��������
  FRoadCoats := TesaRoadCoats.Create(ADispatcher);
  FRocks := TesaRocks.Create(ADispatcher);
  FExcavatorModels := TesaExcavatorModels.Create(ADispatcher);
  FAutoModels := TesaAutoModels.Create(ADispatcher);
  FExcavators := TesaExcavators.Create(ADispatcher);
  FAutoAccordances := TesaAutoAccordances.Create(ADispatcher);
  FBlocks := TesaBlocks.Create(ADispatcher);
  FLoadingPunkts := TesaLoadingPunkts.Create(ADispatcher);
  FUnLoadingPunkts := TesaUnLoadingPunkts.Create(ADispatcher);
  FShiftPunkts := TesaShiftPunkts.Create(ADispatcher);
  FCourses := TesaCourses.Create(ADispatcher);
  FAutos := TesaAutos.Create(ADispatcher);
  FAdditionalRoadParams := TesaAdditionalRoadParams.Create(ADispatcher);
  FAdditionalAutoParams := TesaAdditionalAutoParams.Create(ADispatcher);
end;{Create}
destructor TesaOpenpit.Destroy; 
begin
  FAutoAccordances.Free;
  FAutoAccordances := nil;
  FExcavators.Free;
  FExcavators := nil;

  FExcavatorModels.Free;
  FExcavatorModels := nil;

  FAutoModels.Free;
  FAutoModels := nil;

  FRoadCoats.Free;
  FRoadCoats := nil;

  FRocks.Free;
  FRocks := nil;

  FBlocks.Free;
  FBlocks := nil;

  FLoadingPunkts.Free;
  FLoadingPunkts := nil;
  FUnLoadingPunkts.Free;
  FUnLoadingPunkts := nil;
  FShiftPunkts.Free;
  FShiftPunkts := nil;

  FCourses.Free;
  FCourses := nil;

  FAutos.Free;
  FAutos := nil;
  FAdditionalRoadParams.Free;
  FAdditionalRoadParams := nil;
  FAdditionalAutoParams.Free;
  FAdditionalAutoParams := nil;
  inherited;
end;{Destroy}
procedure TesaOpenpit.Clear;
begin
  FPeriod := esaPeriod();
  FShift  := esaShift();
  FCommon := esaCommon();
  FAutoAccordances.Clear;
  FExcavators.Clear;
  FExcavatorModels.Clear;
  FAutoModels.Clear;
  FRoadCoats.Clear;
  FRocks.Clear;
  FBlocks.Clear;
  FLoadingPunkts.Clear;
  FUnLoadingPunkts.Clear;
  FShiftPunkts.Clear;
  FCourses.Clear;
  FAutos.Clear;
  FAdditionalRoadParams.Clear;
  FAdditionalAutoParams.Clear;
end;{Clear}
procedure TesaOpenpit.RefreshData;
begin
  FRoadCoats.Clear;
  FRocks.Clear;
  FExcavatorModels.Clear;
  FAutoModels.Clear;
  FExcavators.Clear;
  FAutoAccordances.Clear;
  FBlocks.Clear;
  FLoadingPunkts.Clear;
  FUnLoadingPunkts.Clear;
  FShiftPunkts.Clear;
  FCourses.Clear;
  FAutos.Clear;
  FAdditionalRoadParams.Clear;
  FAdditionalAutoParams.Clear;

  if FDispatcher.IsErrorInputData then Exit;
  with TADOQuery.Create(nil) do
  try
    Connection := FDispatcher.DBConnection;
    SQL.Text := 'SELECT * FROM Openpits WHERE Id_Openpit='+IntToStr(FId_Openpit);
    Open;
    if RecordCount>0 then
    begin
      FId_Openpit                 := FieldByName('Id_Openpit').AsInteger;
      FName                       := FieldByName('Name').AsString;
      FDateCreate                 := FieldByName('DateCreate').AsDateTime;
      //�������������� ����� ����������
      FCommon.DollarCtg           := FieldByName('TotalKurs').AsFloat;
      FCommon.YearExpensesCtg     := FieldByName('TotalExpenses').AsFloat*1000;
      FCommon.SalaryCoef          := FieldByName('TotalSalaryCoef').AsFloat;
      //�������������� ���������� �� ������ ������ � �������� �����
      FCommon.AutoWorkRegime     := TesaAutosWorkRegimeKind(FieldByName('WorkRegimeKind').AsInteger);
      FCommon.StrippingCoefUsing := FieldByName('WorkRegimeIsStrippingCoefUsing').AsBoolean;
      //�������������� ���������� �� ������������
      FCommon.ExcavatorMashinistSalary := esaSalary(FieldByName('ExcavsSalaryMashinist0').AsFloat*1000,
                                                    FieldByName('ExcavsSalaryMashinist1').AsFloat*1000);
      FCommon.ExcavatorAssistantSalary := esaSalary(FieldByName('ExcavsSalaryAssistant0').AsFloat*1000,
                                                    FieldByName('ExcavsSalaryAssistant1').AsFloat*1000);
      FCommon.ExcavatorFuelCtg         := FieldByName('ExcavsEnergyCost').AsFloat;
      FCommon.ExcavatorAmortizationR   := FieldByName('ExcavsAmortazationNorm').AsFloat;
      //�������������� ���������� �� ��������������
      FCommon.AutoDriverSalary := esaSalary(FieldByName('AutosSalary0').AsFloat*1000,
                                            FieldByName('AutosSalary1').AsFloat*1000);
      FCommon.AutoFuel           := esaAutoFuel(FieldByName('AutosFuelCostSummer').AsFloat,
                                                FieldByName('AutosFuelCostWinter').AsFloat,
                                                FieldByName('AutosWinterMonthCount').AsInteger,
                                                TesaAutoFuelCostTarifKind(FieldByName('AutosFuelCostTarif').AsInteger));
      //�������������� ���������� �������������
      FShift                     := esaShift(FieldByName('TotalShiftUsingCoefNormal').AsFloat,
                                             FieldByName('TotalShiftUsingCoefDayShift').AsFloat,
                                             FieldByName('TotalShiftUsingCoefExplosion').AsFloat,
                                             FieldByName('TotalShiftUsingCoefExplosionCount').AsInteger,
                                             Round(FieldByName('AutosWorkShiftDuration').AsFloat*60),
                                             FieldByName('AutosShiftTurnoverTime').AsInteger);
      FPeriod                    := esaPeriod(FieldByName('ParamsPeriodDuration').AsInteger,
                                              FieldByName('ParamsAnimationTimeScale').AsInteger,
                                              Shift.Tmin,Shift.ShiftTimeUsingCoef.Kweek);
    end{if}
    else SendInputDataErrorMsg('��� ������ �� �������');
    Close;
  finally
    Free;
  end;{try}
  FRoadCoats.RefreshData;
  FRocks.RefreshData;
  FExcavatorModels.RefreshData;
  FAutoModels.RefreshData;

  FExcavators.RefreshData;
  FAutoAccordances.RefreshData;
  FBlocks.RefreshData;
  FLoadingPunkts.RefreshData;
  FUnLoadingPunkts.RefreshData;
  FShiftPunkts.RefreshData;
  FCourses.RefreshData;
  FAutos.RefreshData;
  FAdditionalRoadParams.RefreshData;
  FAdditionalAutoParams.RefreshData;
  FDispatcher.FForm.Update;
end;
function TesaOpenpit.CheckAllTerms: Boolean;
begin
  Result := true;
end;

//������ "�������������" ----------------------------------------------------------------------
function TDispatcher.GetId_Openpit: Integer;
begin
  Result := FOpenpit.Id_Openpit;
end;{GetId_Openpit}
function TDispatcher.GetAutos: TesaAutos;
begin
  if FOpenpit<>nil then Result := FOpenpit.Autos else Result := nil;
end;{GetAutos}
function TDispatcher.GetLoadingPunkts: TesaLoadingPunkts;
begin
  if FOpenpit<>nil then Result := FOpenpit.LoadingPunkts else Result := nil;
end;{GetLoadingPunkts}
function TDispatcher.GetUnLoadingPunkts: TesaUnLoadingPunkts;
begin
  if FOpenpit<>nil then Result := FOpenpit.UnLoadingPunkts else Result := nil;
end;{GetUnLoadingPunkts}
function TDispatcher.GetShiftPunkts: TesaShiftPunkts;
begin
  if FOpenpit<>nil then Result := FOpenpit.ShiftPunkts else Result := nil;
end;{GetShiftPunkts}
function TDispatcher.GetBlocks: TesaBlocks;
begin
  if FOpenpit<>nil then Result := FOpenpit.Blocks else Result := nil;
end;{GetBlocks}
function TDispatcher.GetCourses: TesaCourses;
begin
  if FOpenpit<>nil then Result := FOpenpit.Courses else Result := nil;
end;{GetCourses}
function TDispatcher.GetRocks: TesaRocks;
begin
  if FOpenpit<>nil then Result := FOpenpit.Rocks else Result := nil;
end;{GetRocks}
function TDispatcher.GetAutoAccordances: TesaAutoAccordances;
begin
  if FOpenpit<>nil then Result := FOpenpit.AutoAccordances else Result := nil;
end;{GetAutoAccordances}
(*
procedure TDispatcher.SendCalcErrorMsg(const AMessage: String; const AIsFooter: Boolean=True);
begin
  if Openpit<>nil then Openpit.SendCalcErrorMsg(AMessage,AIsFooter);
end;{SendCalcErrorMsg}
procedure TDispatcher.SendInputDataErrorMsg(const AMessage: String; const AIsFooter: Boolean=True);
begin
  if Openpit<>nil then Openpit.SendInputDataErrorMsg(AMessage,AIsFooter);
end;{SendInputDataErrorMsg}
*)
procedure TDispatcher.SendWarningMsg(const AMessage: String);
begin
  if Openpit<>nil then Openpit.SendWarningMsg(AMessage);
end;{SendWarningMsg}
//
procedure TDispatcher.SetGaugeValue(const Value: Integer);
begin
  FGauge.Progress := Value;
//  FGauge.Parent.Parent.Repaint; //Form.pnBtns.Gauge
end;{SetGaugeValue}
procedure TDispatcher.DoFormShow(Sender: TObject);
begin
  FTimer.Enabled := True;
end;{DoFormShow}
procedure TDispatcher.DoTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  Screen.Cursor := crHourGlass;
  FbtOk.Enabled := False;
  try
    RunCalcs;
  finally
    FbtOk.Enabled := True;
    FbtOk.SetFocus;
    Screen.Cursor := crDefault;
  end;
end;
//I.������ ������� ��������
procedure TDispatcher.RunCalcs;
var
  AStartTime,
  AStartTime0,
  AStartTime1,
  AStartTime2: _SYSTEMTIME;
begin
  //������ ------------------------------------------------------------------------------------
  RunInitialization(AStartTime);
  //I.���������� ������ -----------------------------------------------------------------------
  RunReadData(AStartTime0);
  //II.������������� --------------------------------------------------------------------------
  RunModeling_(AStartTime1);
  //III. ���������� ����������� ������������� -------------------------------------------------
  RunSaveResults(AStartTime2);
  //-------------------------------------------------------------------------------------------
  RunFinalization(AStartTime);
end;{RunCalcs}
//I.1. �������������
procedure TDispatcher.RunInitialization(var ATime: _SystemTime);
begin
  if (not FIsRunning)OR FIsStop then Exit;
  //������ ------------------------------------------------------------------------------------
  SendMessageStartTime(ATime,'����� ������ �������������',True);
  SendBlankMessage;
end;{RunInitialization}
//I.2. ���������� ������
procedure TDispatcher.RunReadData(var ATime: _SystemTime);
begin
  //I.���������� ������ -----------------------------------------------------------------------
  SendMessageStartTime(ATime,'I.���������� ������');
  FOpenpit.RefreshData;
  SendMessageFinishTime(ATime,'����� ���������� ������');
end;{RunReadData}
procedure TDispatcher.RunSaveResults(var ATime: _SystemTime);
begin
  if (not FIsRunning)OR FIsStop OR FIsErrorInputData then Exit;
  //III. ���������� ����������� ������������� -------------------------------------------------
  SendMessageStartTime(ATime,'III. ���������� ����������� ������� ��������');
  SaveTotalResults;
  SaveAutosResultsNew;      //New!!!
  SaveExcavatorsResultsNew; //New!!!
  SaveBlocksResultsNew;     //New!!!
  SaveUnLoadingPunktsResultsNew;  //New!!!
  SaveEconomResultsNew;     //New!!!
  SavePeriodResultsNew;     //New!!!
  SendMessageFinishTime(ATime,'����� ���������� ����������� ������� ��������');
end;{RunSaveResults}
//I.4. ���������� �����������
procedure TDispatcher.RunFinalization(var ATime0: _SystemTime);
begin
  if (not FIsRunning)OR FIsStop then Exit;
  //����� -------------------------------------------------------------------------------------
  SendMessageFinishTime(ATime0,'����� ����� �������������',False);
  Beep;//�������� ������ �� ��������� �������������(��������� I.36)
end;{RunFinalization}
//�������� ��� ������(����,exc,lp,lpr,up,upr,r..) � �������� ���� 
procedure TDispatcher.SaveResultLists(const APath: String);
(*
var
  I,J: Integer;
  ARock: RResultInputRock;
  ALoadingPunkt: RResultInputLoadingPunkt;
  ALoadingPunktRock: RResultInputLoadingPunktRock;
  AUnLoadingPunkt: RResultInputUnLoadingPunkt;
  AUnLoadingPunktRock: RResultInputUnLoadingPunktRock;
  AAuto: RResultInputAuto;
  AFileHandle: Integer;
*)
begin
(*
  // � ������ ��������� ������������ ���������� ������ ������� ��, ����, ��, �� ��, ��, �� ��
  // � ���� ResultsTotal.ESA � ��������������� AFileHandle
  // ��������� ������ ����� ResultsTotal.ESA
  // 1.��.Count, ��_1.. ��_N, Autos.Count, Auto1...AutoN,
  // 2.��1.Count, ��1 [��1.��.Count, ��1.��_1...��1.��_N]...
  //   ��_N.Count, ��_N [��_N.��.Count, ��_N.��_1...��_N.��_N],
  // 3.��1.Count, ��1 [��1.��.Count, ��1.��_1...��1.��_N]...
  //   ��_N.Count, ��_N [��_N.��.Count, ��_N.��_1...��_N.��_N]
  AFileHandle := FileCreate(APath+'ResultsTotal.ESA');
  //Rocks
  FileWrite(AFileHandle,Rocks.Count,SizeInteger);
  for I := 0 to Rocks.Count-1 do
  begin
    ARock.Name := Rocks[I].Name;
    FileWrite(AFileHandle,ARock,SizeResultInputRock);
  end;{for}
  //Autos (���-� � ��������� ���������)
  FileWrite(AFileHandle,Autos.Count,SizeInteger);
  for I := 0 to Autos.Count-1 do
  begin
    AAuto.Id_DeportAuto := Autos[I].FId_DeportAuto;
    AAuto.Name := Autos[I].Name;
    FileWrite(AFileHandle,AAuto,SizeResultInputAuto);
  end;{for}
  //LoadingPunkts
  FileWrite(AFileHandle,LoadingPunkts.Count,SizeInteger);
  for I := 0 to LoadingPunkts.Count-1 do
  begin
    ALoadingPunkt.Name  := LoadingPunkts[I].FName;
    ALoadingPunkt.Point := LoadingPunkts[I].FCoords;
    FileWrite(AFileHandle,ALoadingPunkt,SizeResultInputLoadingPunkt);
    //LoadingPuntRocks
    FileWrite(AFileHandle,LoadingPunkts[I].RockCount,SizeInteger);
    for J := 0 to LoadingPunkts[I].RockCount-1 do
    begin
      ALoadingPunktRock.RockIndex      := LoadingPunkts[I].Rocks[J].FRockIndex;
      ALoadingPunktRock.Content        := LoadingPunkts[I].Rocks[J].FContent;
      ALoadingPunktRock.PlannedV1000m3 := LoadingPunkts[I].Rocks[J].FPlannedVm3*0.001;
      ALoadingPunktRock.PlannedQ1000tn := LoadingPunkts[I].Rocks[J].FPlannedQtn*0.001;
      FileWrite(AFileHandle,ALoadingPunktRock,SizeResultInputLoadingPunktRock);
    end;{for}
  end;{for}
  //UnLoadingPunkts
  FileWrite(AFileHandle,UnLoadingPunkts.Count,SizeInteger);
  for I := 0 to UnLoadingPunkts.Count-1 do
  begin
    AUnLoadingPunkt.Name := UnLoadingPunkts[I].Name;
    AUnLoadingPunkt.Point := UnLoadingPunkts[I].FCoords;
    AUnLoadingPunkt.MaxV1000m3 := UnLoadingPunkts[I].FMaxVm3*0.001;
    FileWrite(AFileHandle,AUnLoadingPunkt,SizeResultInputUnLoadingPunkt);
    //UnLoadingPuntRocks
    FileWrite(AFileHandle,UnLoadingPunkts[I].RockCount,SizeInteger);
    for J := 0 to UnLoadingPunkts[I].RockCount-1 do
    begin
      AUnLoadingPunktRock.RockIndex      := UnLoadingPunkts[I].Rocks[J].FRockIndex;
      AUnLoadingPunktRock.RequiredContent:= UnLoadingPunkts[I].Rocks[J].FRequiredContent;
      FileWrite(AFileHandle,AUnLoadingPunktRock,SizeResultInputUnLoadingPunktRock);
    end;{for}
  end;{for}
  FileClose(AFileHandle);
  *)
end;{SaveResultLists}
//�������� ����� ������� � ������ ��������
procedure TDispatcher.AppendResultItem(const T: Integer);
var AItem: RResultItem;
begin
  //ResultItem (���N)
  AItem.ResultItemIndex := FResultItemIndex;
  AItem.dTsec := T;
  AItem.StrippingCoef := FCurrStrippingCoef;
  FileWrite(FfhResultItems,AItem,SizeResultItem);
end;{AppendResultItem}
//�������� ���� � ������ ��������
procedure TDispatcher.AppendResultAutos();
var
  I: Integer;
  AItem: RResultAuto;
begin
  //ResultAutos (Auto 1..N)
  for I := 0 to Autos.Count-1 do
  if Autos[I].FCurrState<>asUnWorked then
  begin
    AItem.AutoIndex := Autos[I].FAutoIndex;
    AItem.ResultItemIndex := FResultItemIndex;
    AItem.IndentPosition := Autos[I].FCurrIndentPoint;
    AItem.ZenitAngle := Autos[I].FCurrZenit;
    AItem.AzimutAngle := Autos[I].FCurrAzimut;
    AItem.Direction := Autos[I].FCurrDirection;
    AItem.State := Autos[I].FCurrState;
    AItem.Vkmh := Autos[I].FCurrV;
    AItem.W := Autos[I].FCurrW;
    FileWrite(FfhAutos,AItem,SizeResultAuto);
  end;{for}
end;{AppendResultAutos}
//�������� �� � ������ ��������
procedure TDispatcher.AppendResultLoadingPunkt(const AIndex: Integer);
var
  ALoadingPunkt      : RResultLoadingPunkt;
  ALoadingPunktRock  : RResultLoadingPunktRock;
  I: Integer;
begin
  ALoadingPunkt.ResultItemIndex := FResultItemIndex;
  ALoadingPunkt.LoadingPunktIndex := AIndex;
  ALoadingPunkt.State := LoadingPunkts[AIndex].FCurrState;
  FileWrite(FfhLoadingPunkts,ALoadingPunkt,SizeResultLoadingPunkt);
  //LoadingPunktRocks (��i.�� 1...N)
  for I := 0 to LoadingPunkts[AIndex].RockCount-1 do
  begin
    ALoadingPunktRock.LoadingPunktRockIndex := I;
    ALoadingPunktRock.LoadingPunktIndex := AIndex;
    ALoadingPunktRock.ResultItemIndex := FResultItemIndex;
    ALoadingPunktRock.RockV1000m3 := LoadingPunkts[AIndex].Rocks[I].ShiftFactRock.Vm3*0.001;
    ALoadingPunktRock.RockQ1000tn := LoadingPunkts[AIndex].Rocks[I].ShiftFactRock.Qtn*0.001;
    FileWrite(FfhLoadingPunktRocks,ALoadingPunktRock,SizeResultLoadingPunktRock);
  end;{for}
end;{AppendResultLoadingPunkt}
//�������� ������ �������� � ������ ��������
procedure TDispatcher.AppendResultLoadingPunkts();
var I: Integer;
begin
  for I := 0 to LoadingPunkts.Count-1 do
    AppendResultLoadingPunkt(I);
end;{AppendResultLoadingPunkts}
//�������� �� � ������ ��������
procedure TDispatcher.AppendResultUnLoadingPunkt(const AIndex: Integer);
var
  AUnLoadingPunkt      : RResultUnLoadingPunkt;
  AUnLoadingPunktRock  : RResultUnLoadingPunktRock;
  I: Integer;
begin
  AUnLoadingPunkt.ResultItemIndex := FResultItemIndex;
  AUnLoadingPunkt.UnLoadingPunktIndex := AIndex;
  AUnLoadingPunkt.State := UnLoadingPunkts[AIndex].FCurrState;
  FileWrite(FfhUnLoadingPunkts,AUnLoadingPunkt,SizeResultUnLoadingPunkt);
  //UnLoadingPunktRocks (��i.�� 1..N)
  for I := 0 to UnLoadingPunkts[AIndex].RockCount-1 do
  begin
    AUnLoadingPunktRock.UnloadingPunktRockIndex := I;
    AUnLoadingPunktRock.ResultItemIndex := FResultItemIndex;
    AUnLoadingPunktRock.UnloadingPunktIndex := AIndex;
    AUnLoadingPunktRock.RockV1000m3 := UnLoadingPunkts[AIndex].Rocks[I].FCurrRockVolume.Vm3*0.001;
    AUnLoadingPunktRock.RockQ1000tn := UnLoadingPunkts[AIndex].Rocks[I].FCurrRockVolume.Qtn*0.001;
    AUnLoadingPunktRock.Content := UnLoadingPunkts[AIndex].Rocks[I].FCurrContent;
    FileWrite(FfhUnLoadingPunktRocks,AUnLoadingPunktRock,SizeResultUnLoadingPunktRock);
  end;{for}
end;{AppendResultUnLoadingPunkt}
//�������� ������ ��������� � ������ ��������
procedure TDispatcher.AppendResultUnLoadingPunkts();
var I: Integer;
begin
  for I := 0 to UnLoadingPunkts.Count-1 do
    AppendResultUnLoadingPunkt(I);
end;{AppendResultUnLoadingPunkts}
//����������� ��������� � ������ ��������
procedure TDispatcher.SendMessageStartTime(var ATime0: _SystemTime; const AMessage: String;
                                              const AIsMilliSecunds: Boolean = False);
begin
  GetSystemTime(ATime0);
  with ATime0 do
    if AIsMilliSecunds
    then SendMessage(Format(AMessage+' (%.2d:%.2d:%.2d:%.3d).',[wHour+6,wMinute,wSecond,wMilliSeconds]))
    else SendMessage(Format(AMessage+' (%.2d:%.2d:%.2d).',[wHour+6,wMinute,wSecond]));;
end;{SendMessageStartTime}
//����������� ��������� �� ��������� ��������
procedure TDispatcher.SendMessageFinishTime(const ATime0: _SystemTime; const AMessage: String;
                                                const AIsBlankLine: Boolean = True);
var
  ATime1: _SYSTEMTIME;
  dMilliSec: LongInt;
  AMsg: String;  
begin
  GetSystemTime(ATime1);
  dMilliSec := (ATime1.wMilliseconds+1000*(ATime1.wSecond+ATime1.wMinute*60+ATime1.wHour*3600))-
               (ATime0.wMilliseconds+1000*(ATime0.wSecond+ATime0.wMinute*60+ATime0.wHour*3600));
  ATime1.wMilliseconds := dMilliSec mod 1000;
  dMilliSec := dMilliSec-ATime1.wMilliseconds;
  if dMilliSec>0
  then dMilliSec := dMilliSec div 1000
  else dMilliSec := 0;
  if dMilliSec>3600
  then ATime1.wHour := dMilliSec div 3600
  else ATime1.wHour := 0;
  dMilliSec := dMilliSec-ATime1.wHour*3600;
  if dMilliSec>60
  then ATime1.wMinute := dMilliSec div 60
  else ATime1.wMinute := 0;
  ATime1.wSecond := dMilliSec-ATime1.wMinute*60;
  AMsg := ': ';
  if ATime1.wHour>0 then AMsg := AMsg+IntToStr(ATime1.wHour)+' � ';
  if (ATime1.wHour>0)OR(ATime1.wMinute>0) then AMsg := AMsg+IntToStr(ATime1.wMinute)+' ��� ';
  if (ATime1.wHour>0)OR(ATime1.wMinute>0)OR(ATime1.wSecond>0)OR(ATime1.wMilliseconds=0)
  then AMsg := AMsg+IntToStr(ATime1.wSecond)+' ��� ';
  if ATime1.wMilliseconds>0
  then AMsg := AMsg+IntToStr(ATime1.wMilliseconds)+' ��';
  SendMessage(AMessage+AMsg);
  if AIsBlankLine then SendBlankMessage;
end;{SendMessageFinishTime}
//����������� ��������� � Memo ����� ����������
procedure TDispatcher.SendMessage(const AMessage: String);
begin
  if AMessage<>'' then Lines.Add(AMessage);
end;{SendMessage}
//����������� ���������-�������������� ������ � Memo ����� ����������
procedure TDispatcher.SendBlankMessage;
begin
  SendMessage(sBlankLine+sBlankLine+sBlankLine);
end;{SendBlankMessage}
constructor TDispatcher.Create(AOwner: TComponent; ADBConnection: TADOConnection);
begin
  //u+
  //_tmp_test_auto:= '�9 �����-7555:9';
  _tmp_test_auto:= '�1 Howo 6*4 ZZ3257N3847A:1';
  _tmp_int:= 0;
  _tmp_bool:= false;
  //u-
  FResultId_Shift := 0;
  FOpenpit := nil;
  FDBConnection := nil;
  FIsErrorInputData := True;
  FIsErrorCalc := false;
  inherited Create(nil);

  FForm := TForm.Create(AOwner);
  Parent := FForm;
  FForm.Constraints.MinWidth := 800;
  FForm.Constraints.MinHeight := 400;
  FForm.Caption := '�������������...';
  FForm.Width := FForm.Constraints.MinWidth;
  FForm.Height := FForm.Constraints.MinHeight;
  FForm.Position := poScreenCenter;
  FForm.BorderIcons := [biSystemMenu,biMaximize];
  //FForm.FormStyle := fsStayOnTop;
  FpnBtns := TPanel.Create(FForm);
  FpnBtns.Parent := FForm;
  FpnBtns.Align := alBottom;
  FpnBtns.BevelOuter := bvNone;
  //
  FGauge := TGauge.Create(FpnBtns);
  FGauge.Parent := FpnBtns;
  FGauge.Left := 8;
  FGauge.Top := 12;
  FGauge.Width := 640;
  FGauge.Height := 16;
  FGauge.Kind := gkHorizontalBar;
  FGauge.ForeColor := clNavy;
  FGauge.BorderStyle := bsNone;
  FGauge.Visible := false;
  //
  FbtOk := TButton.Create(FpnBtns);
  FbtOk.Parent := FpnBtns;
  FbtOk.Caption := 'Ok';
  FbtOk.ModalResult := mrOk;
  FbtOk.Top := 8;
  FbtOk.Left := FpnBtns.Width-104;
  FbtOk.Anchors := [akTop, akRight];
  FForm.ActiveControl := FbtOk;

  Align := alClient;
  ReadOnly := True;
  Color := clBtnFace;
  ScrollBars := ssVertical;

  FIsRunning := False;
  FIsStop := False;

  if ADBConnection=nil then
    Raise Exception.Create(EADOConnectionNull);
  if not ADBConnection.Connected then
    Raise Exception.Create(EADOConnectionClosed);

  FDBConnection := ADBConnection;
  FOpenpit := TesaOpenpit.Create(Self);
  //
  FTimer := TTimer.Create(FForm);
  FTimer.Enabled := False;
  FTimer.Interval := 1000;
  FTimer.OnTimer := DoTimer;
  FForm.OnShow := DoFormShow;
  FForm.ActiveControl := FbtOk;
  FIsErrorInputData := False;
  //
  FCurrUnWorkedAutosCount:= 0;
  FCurrDoneAutosCount    := 0;
  FCurrAbortAutosCount   := 0;
  FCurrWaitingAutosCount := 0;
  FCurrWorkingAutosCount := 0;
  FCurrAutos := nil;
  FShiftTsec      := 0;
  FCurrTsecNaryad := 0;
  FCurrAutoCostsGxTgPerLtr := 0.0;
  FList0 := TList.Create;
  FList1 := TList.Create;
  FVariant := TesaResultVariant.Create(fmDM.ADOConnection);
end;
destructor TDispatcher.Destroy;
var I: Integer;
begin
  FreeAndNil(FVariant);
  for I := 0 to FList1.Count-1 do
    FList1[I] := nil;
  ClearList(FList0);
  FList1.Free;
  FList1 := nil;
  FList0.Free;
  FList0 := nil;
  FCurrAutos := nil;
  FTimer.Free;
  FTimer := nil;
  FOpenpit.Free;
  FOpenpit := nil;

  FbtOk.Free;
  FbtOk := nil;
  FGauge.Free;
  FGauge := nil;
  FpnBtns.Free;
  FpnBtns := nil;
  Parent := nil;
  FForm.Free;
  FForm := nil;
  FDBConnection := nil;

  inherited;
end;{Destroy}
//������ ������� ��������
procedure TDispatcher.Run(const AId_Openpit: Integer);
begin
  if FIsRunning then
    Application.MessageBox('������������� ��� �����������.', '������', MB_OK+MB_ICONERROR)
  else
    if not (FIsErrorCalc or FIsErrorInputData)then
    begin
      FOpenpit.Id_Openpit := AId_Openpit;
      FbtOk.Enabled := False;
      FIsRunning := True;
      FIsStop := False;
      FTimer.Enabled := False;
      FForm.ShowModal;
      FTimer.Enabled := False;
      FIsRunning := False;
      FIsStop := False;
    end;{else}
end;{Run}
//���������� ������� ��������
procedure TDispatcher.Stop;
begin
  if FIsRunning then
  begin
    FIsStop := True;
  end;{if}
end;{Stop}

//��������� ������ �������� ��� ����
function TDispatcher.DefineAutosCourse(AAuto: TesaAuto; var AErrMsg: String): Integer;
begin
  Result := -1;
  if AAuto.FCurrPosition=apNone then //�� ���
  begin
    if AAuto.FCourseIndex<>-1
    then Result := DefineAutosClosedCourseSPLP(AAuto,AErrMsg)
    else Result := DefineAutosOpenedCourseSPLP(AAuto,AErrMsg);
  end{if}
  else
    if AAuto.FCurrPosition=apOnPunkt1 then
    case AAuto.FCurrDirection of
      adUnLoading,adFromSP: begin//���������� �� ��
        if AAuto.FCourseIndex<>-1
        then Result := DefineAutosClosedCourseLPUP(AAuto,AErrMsg)
        else Result := DefineAutosOpenedCourseLPUP(AAuto,AErrMsg);
      end;{apLP}
      adLoading: begin //������������� �� ��
        if FCurrTsecNaryad<FShiftTsec-Openpit.Shift.TurnoverTmin*60 then
        begin//����� ����� �� �����������
          if AAuto.FCourseIndex<>-1
          then Result := DefineAutosClosedCourseUPLP(AAuto,AErrMsg)
          else Result := DefineAutosOpenedCourseUPLP(AAuto,AErrMsg);
        end{if}
        else
        begin//����� ����� �����������
          Result := DefineAutosCourseUPSP(AAuto,AErrMsg);
        end;{else}
      end;{apUP}
    end;{case}
end;{DefineAutosCourse}
//��������� ������ �������� ��� ���� � �������� ������ �� ��� � ��
function TDispatcher.DefineAutosClosedCourseSPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
var
  I: Integer;
  MinD: Single;
begin
  Result := -1;
  AErrMsg := '';
  if (AAuto=nil)OR(AAuto.FCourseIndex=-1)then Exit;
  //1.������������ ������ �������� ������ �� ��� �� ��
  //2.����� ��� ������� ��������, �� �������� ����� ������� ��  ��������,
  //  ������������� �� ������ ����
  //3. ���� ����� ��������� ���������, �� ������� ����������
  MinD := MaxInt;
  for I := 0 to Courses.Count-1 do
    if Courses[I].FKind=ckCourseSP_LP then                 //������� 1
      if Courses[I].FId_Point1=AAuto.Course.FId_Point0 then//������� 2
        if Courses[I].Lm<MinD then                     //������� 3
        begin
          Result := I; MinD := Courses[I].Lm;
        end;{if}
  if Result=-1 then
    AErrMsg := Format(EAutosNotFoundClosedCourseSPLP,[AAuto.Name,AAuto.ShiftPunkt.Name,AAuto.Course.Name]);
end;{DefineAutosClosedCourseSPLP}
//��������� ������ �������� ��� ���� � �������� ������ �� ��� � ��
function TDispatcher.DefineAutosOpenedCourseSPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
var
  I,J       : Integer;
  AItem     : PListItem;
  APunkt0   : TesaShiftPunkt;
  APunkt1   : TesaLoadingPunkt;
  ARock1    : TesaLoadingPunktRock;
  AIsOreDone: Boolean;
begin
  Result := -1;
  AErrMsg := '';
  ClearList1(FList1);
  ClearList(FList0);
  //���� ���� �� ���, �� ������ AAuto.CurrCourse.Kind=ckCourseSP_LP
  APunkt0 := AAuto.ShiftPunkt;
  //������� I. ������ ������0 ��������� (��� -> ��) -------------------------------------------
  // - ����� �� ������� �� ������� ��� � ��
  // - �������� ��� ���� ������������ ���� ���� ���� ����������� �� ��
  // - ��������� ��� ������� �������� �-�� ���� � ���.���������, �������� � ������ �����������
  // - ��������� ��� �� ������� �������� ������� ���������� ����� �� ������ ��
  // - ��������� ����� ������� ��������
  //�)�������� ������0 �� ����������� 1.������� ���������� �����
  //                                  2.�-�� ���� � ���.���������, �������� � ������ �����������
  //                                  3.����� ��������
  for I := 0 to Courses.Count-1 do  //������� I �)������ ������0 ------------------------------
    if (Courses[I].Kind=ckCourseSP_LP)AND                //������� ������ �� ���?
       (Courses[I].FId_Point0=APunkt0.Id_Point)then      //�� ����� �����?
    begin
      APunkt1 := TesaLoadingPunkt(Courses[I].Punkt1);//����� ��������
      //������������ ����� ���� � �����������
      if AutoAccordances.IsAccordance(AAuto.Id_Auto,APunkt1.Id_Excavator)then
      begin
        //��������� ��, ���������� ���
        ARock1 := nil;
        for J := 0 to APunkt1.RockCount-1 do
          if APunkt1[J].ShiftFactRemainingQtn>0.0 then
          begin
            ARock1 := APunkt1[J]; Break;
          end;{if}
        if (ARock1=nil)and(APunkt1.RockCount>0)
        then ARock1 := APunkt1.Rocks[APunkt1.RockCount-1];
        if ARock1<>nil then//���� ��?
        begin                                   
          New(AItem);
          AItem^.Course            := Courses[I];                   //�������
          AItem^.Lmm               := Round(1000*Courses[I].Lm);    //����� ��������, ��
          AItem^.LoadingPunktRock  := ARock1;                       //��
          if ARock1.ShiftPlanQtn>0.0
          then AItem^.ShiftPlanRatio1E5 := Round(100000*ARock1.ShiftFactRock.Qtn/ARock1.ShiftPlanQtn)
          else AItem^.ShiftPlanRatio1E5 := 0;                            //������� ���������� �����
          AItem^.AutoCount         := 0;                            //�-��, ����, �������� � ������ �����������
          for J := 0 to Autos.Count-1 do
          if (Autos[J].FId_DeportAuto<>AAuto.FId_DeportAuto)AND      //������ ���� �� �������
             (Autos[J].FCurrCourseIndex>-1)AND                       //������� ���������?
             (Autos[J].CurrCourse.Id_Course=Courses[I].FId_Course)AND//��������� �� ������ ��������?
             (Autos[J].IsWaiting OR Autos[J].IsWorking)AND           //� ������� ���������?
             (Autos[J].FCurrDirection=adFromSP)                      
          then Inc(AItem^.AutoCount);
          FList0.Add(AItem);
        end;{if}
      end;{if}
    end;{for}
  SortList(FList0);//������� I �) ����������

  //������� II. ������� ����� ������������ ������� --------------------------------------------
  if (FList0.Count > 0)and                                         //�������� ����?
     (Openpit.Common.StrippingCoefUsing)and                //��������� ����������� �������?
     (FCurrStrippingCoef < LoadingPunkts.FPlannedStrippingCoef)and //�����<�����
     (FCurrOreQtn > 0.0)then                                       //���� ������
  begin
    //������ ������1 �� ��������
    AIsOreDone := true;
    for I := 0 to FList0.Count-1 do
    begin
      AItem := PListItem(FList0[I]);
      if not AItem^.LoadingPunktRock.Rock.IsMineralWealth then
      begin
        if AItem^.LoadingPunktRock.ShiftFactRemainingQtn>0.0 then AIsOreDone := false;
        FList1.Add(AItem);
      end;{if}
    end;{for}
    //���� � ������ ���� ���� ���� ������������� �������, �� ������ �����������
    if not AIsOreDone then
      for I := FList1.Count-1 downto 0 do
      if not(PListItem(FList1[I])^.LoadingPunktRock.ShiftFactRemainingQtn>0.0)then
      begin
        FList1[I] := nil; FList1.Delete(I);
      end;{for}
    if FList1.Count>0 then
    begin
      if Openpit.Common.AutoWorkRegime<>wrEqualDistrubation//���� �� ����������� �������������
      then Result := PListItem(FList1[0])^.Course.FCourseIndex//� ����������� ����������� �����
      else Result := GetEqualDistrubationCourseIndex(FList1); //� ����������� ��������������
    end;{if}
  end;{if}

  //������� III. �������� �������������: ���������� ��������-----------------------------------
  if (FList0.Count>0)and                               //�������� ����?
     (Result=-1)and                                    //����������� ������� �� ��������?
     (Openpit.Common.AutoWorkRegime=wrQualityAveraging)then //���������� ��������?
  begin
    ClearList1(FList1);
    //������ ������1 �� �����
    AIsOreDone := true;
    for I := 0 to FList0.Count-1 do
    begin
      AItem := PListItem(FList0[I]);
      if AItem^.LoadingPunktRock.Rock.IsMineralWealth then
      begin
        if AItem^.LoadingPunktRock.ShiftFactRemainingQtn>0.0 then AIsOreDone := false;
        FList1.Add(AItem);
      end;{if}
    end;{for}
    //���� � ������ ���� ���� ���� ������������� ����, �� ������ �����������
    if not AIsOreDone then
      for I := FList1.Count-1 downto 0 do
      if not(PListItem(FList1[I])^.LoadingPunktRock.ShiftFactRemainingQtn>0.0)then
      begin
        FList1[I] := nil; FList1.Delete(I);
      end;{for}
    if FList1.Count>0 then
    begin
      if Openpit.Common.AutoWorkRegime<>wrEqualDistrubation//���� �� ����������� �������������
      then Result := PListItem(FList1[0])^.Course.FCourseIndex//� ����������� ����������� �����
      else Result := GetEqualDistrubationCourseIndex(FList1); //� ����������� ��������������
    end;{if}
  end;{if}

  //������� IV. �������� �������������: ����������� �������������------------------------------
  if (FList0.Count>0)and(Result=-1)
  then Result := GetEqualDistrubationCourseIndex(FList0);

  if Result=-1
  then AErrMsg := Format(EAutosNotFoundOpenedCourse,[AAuto.Name]);
  ClearList(FList0);
  ClearList1(FList1);
end;{DefineAutosOpenedCourseSPLP}
//��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
function TDispatcher.DefineAutosClosedCourseLPUP(AAuto: TesaAuto; var AErrMsg: String): Integer;
begin
  AErrMsg := '';
  Result := AAuto.FCourseIndex;
  if Result=-1 then
    AErrMsg := Format(EAutosNotFoundClosedCourse,[AAuto.Name]);
end;{DefineAutosClosedCourseLPUP}
//��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
function TDispatcher.DefineAutosOpenedCourseLPUP(AAuto: TesaAuto; var AErrMsg: String): Integer;
var
  I,J,AId_Rock0: Integer;
  AItem  : PListItem;
  APunkt0: TesaLoadingPunkt;
  APunkt1: TesaUnLoadingPunkt;
  ADeltaContent,AMaxDeltaContent: Single;
begin
  Result  := -1;
  AErrMsg := '';
  AId_Rock0 := AAuto.Rock.Id_Rock;     //��� �� �������� ����
  if AAuto.CurrCourse.Kind=ckCourseMoving //����� ��������
  then APunkt0 := TesaLoadingPunkt(AAuto.CurrCourse.Punkt0) //ckCourseMoving
  else APunkt0 := TesaLoadingPunkt(AAuto.CurrCourse.Punkt1);//ckCourseSP_LP
  //������� I. ������ ������0 ��������� (�� -> ��) --------------------------------------------
  // - ����� �� ������� �� ������� �� � ��
  // - �������� ��� ���� ��� ������������ �� �� ��
  // - ��������� ��� ������� �������� �-�� ���� � ���.���������, �������� � ������ �����������
  // - ��������� ��� �� ������� �������� ����� ������������ ��
  // - ��������� ����� ������� ��������
  //�)�������� ������0 �� ����������� 1.������ ������������ ��
  //                                  2.�-�� ���� � ���.���������, �������� � ������ �����������
  //                                  3.����� ��������
  for I := 0 to Courses.Count-1 do  //������� I �)������ ������0 ------------------------------
  if Courses[I].Kind=ckCourseMoving then               //������� ��������?
  if Courses[I].FId_Point0=APunkt0.Id_Point then       //�� ����� �����?
  begin
    APunkt1 := TesaUnLoadingPunkt(Courses[I].Punkt1);  //����� ���������
    J := APunkt1.IndexOf(AId_Rock0);
    if J>-1 then             //���� ����� �� �� ��?
    begin
      New(AItem);
      AItem^.Course            := Courses[I];                   //�������
      AItem^.Lmm               := Round(1000*Courses[I].Lm);//����� ��������, ��
      AItem^.UnLoadingPunktRock:= APunkt1.Rocks[J];             //��
      AItem^.ShiftPlanRatio1E5 := Round(10000*APunkt1.Rocks[J].FCurrRockVolume.Vm3);//
      AItem^.AutoCount         := 0;                            //�-��, ����, �������� � ������ �����������
      for J := 0 to Autos.Count-1 do
      if (Autos[J].FId_DeportAuto<>AAuto.FId_DeportAuto)AND      //������ ���� �� �������
         (Autos[J].FCurrCourseIndex>-1)AND                       //������� ���������?
         (Autos[J].CurrCourse.Id_Course=Courses[I].FId_Course)AND//��������� �� ������ ��������?
         (Autos[J].IsWaiting OR Autos[J].IsWorking)AND           //� ������� ���������?
         (Autos[J].FCurrDirection=adLoading)                     //����.�����������?
      then Inc(AItem^.AutoCount);
      FList0.Add(AItem);
    end;{if}
  end;{for}
  SortList(FList0); //������� I �)�������� ������0 �� ����������� �-�� ����, �������� � ���� �����������---------

  //������� II. ������� ����� ������������ ������� --------------------------------------------
  if (FList0.Count > 0)and                                     //�������� ����?
     (Openpit.Common.StrippingCoefUsing)and            //��������� ����������� �������?
     (not AAuto.Rock.IsMineralWealth)and                     //�������?
     (Openpit.Common.AutoWorkRegime <> wrEqualDistrubation)and      //�� ��������.�������������?
     (FCurrStrippingCoef < LoadingPunkts.FPlannedStrippingCoef)//�����<�����
  then Result := PListItem(FList0[0])^.Course.FCourseIndex;

  //������� III. �������� �������������: ���������� ��������-----------------------------------
  if (FList0.Count>0)and                               //�������� ����?
     (Result=-1)and                                    //����������� ������� �� ��������?
     (AAuto.Rock.IsMineralWealth)and                   //����?
     (Openpit.Common.AutoWorkRegime=wrQualityAveraging)then //���������� ��������?
  begin
    Result := -1;
    J := -1;
    AMaxDeltaContent := 0.0;
    for I := 0 to FList0.Count-1 do
    begin
      AItem := PListItem(FList0[I]);
      ADeltaContent := AItem^.UnLoadingPunktRock.FRequiredContent-
                       AItem^.UnLoadingPunktRock.FCurrContent;
      if ADeltaContent>=0.0 then//�������� � ��������� ����������?
      if AAuto.LoadingPunktRock.FContent>
         AItem^.UnLoadingPunktRock.FCurrContent then//������� ������ ����������?
        if (J=-1)OR((J>-1)and(AMaxDeltaContent<ADeltaContent)) then
        begin
          AMaxDeltaContent := ADeltaContent; J := I;
        end;{if}
    end;{for}
    if J>-1 then Result := PListItem(FList0[J])^.Course.FCourseIndex;
  end;{if}

  //������� IV. �������� �������������: ����������� �������������------------------------------
  if (FList0.Count>0)and(Result=-1)
  then Result := GetEqualDistrubationCourseIndex(FList0);

  if Result=-1
  then AErrMsg := Format(EAutosNotFoundOpenedCourse,[AAuto.Name]);
  ClearList(FList0);
end;{DefineAutosOpenedCourseLPUP}
//��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
function TDispatcher.DefineAutosClosedCourseUPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
begin
  AErrMsg := '';
  Result := AAuto.FCourseIndex;
  if Result=-1
  then AErrMsg := Format(EAutosNotFoundClosedCourse,[AAuto.Name]);
end;{DefineAutosClosedCourseUPLP}
//��������� ������ �������� ��� ���� � �������� ������ �� �� � ��
function TDispatcher.DefineAutosOpenedCourseUPLP(AAuto: TesaAuto; var AErrMsg: String): Integer;
var
  I,J       : Integer;
  AItem     : PListItem;
  APunkt0   : TesaUnLoadingPunkt;
  APunkt1   : TesaLoadingPunkt;
  ARock1    : TesaLoadingPunktRock;
  AIsOreDone: Boolean;
begin
  Result := -1;
  AErrMsg := '';
  ClearList1(FList1);
  ClearList(FList0);
  //���� ���� �� ���, �� ������ AAuto.CurrCourse.Kind=ckCourseSP_LP
  APunkt0 := TesaUnLoadingPunkt(AAuto.CurrCourse.Punkt1);
  //������� I. ������ ������0 ��������� (�� -> ��) --------------------------------------------
  // - ����� �� ������� �� ������� �� � ��
  // - �������� ��� ���� ������������ ���� ���� ���� ����������� �� ��
  // - ��������� ��� ������� �������� �-�� ���� � ���.���������, �������� � ������ �����������
  // - ��������� ��� �� ������� �������� ������� ���������� ����� �� ������ ��
  // - ��������� ����� ������� ��������
  //�)�������� ������0 �� ����������� 1.������� ���������� �����
  //                                  2.�-�� ���� � ���.���������, �������� � ������ �����������
  //                                  3.����� ��������
  for I := 0 to Courses.Count-1 do  //������� I �)������ ������0 ------------------------------
    if (Courses[I].Kind=ckCourseMoving)AND               //������� ��������?
       (Courses[I].FId_Point1=APunkt0.Id_Point)then      //�� ����� �����?
    begin
      APunkt1 := TesaLoadingPunkt(Courses[I].Punkt0);//����� ��������
      //������������ ����� ���� � �����������
      if AutoAccordances.IsAccordance(AAuto.Id_Auto,APunkt1.Id_Excavator)then
      begin
        //��������� ��, ���������� ���
        ARock1 := nil;
        for J := 0 to APunkt1.RockCount-1 do
          if APunkt1[J].ShiftFactRemainingQtn>0.0 then
          begin
            ARock1 := APunkt1[J]; Break;
          end;{if}
        if (ARock1=nil)and(APunkt1.RockCount>0)
        then ARock1 := APunkt1.Rocks[APunkt1.RockCount-1];
        if ARock1<>nil then//���� ��?
        begin
          New(AItem);
          AItem^.Course            := Courses[I];                   //�������
          AItem^.Lmm               := Round(1000*Courses[I].Lm);    //����� ��������, ��
          AItem^.LoadingPunktRock  := ARock1;                       //��
          if ARock1.ShiftPlanQtn>0.0
          then AItem^.ShiftPlanRatio1E5 := Round(100000*ARock1.ShiftFactRock.Qtn/ARock1.ShiftPlanQtn)
          else AItem^.ShiftPlanRatio1E5 := 0;                            //������� ���������� �����
          AItem^.AutoCount         := 0;                            //�-��, ����, �������� � ������ �����������
          for J := 0 to Autos.Count-1 do
          if (Autos[J].FId_DeportAuto<>AAuto.FId_DeportAuto)AND      //������ ���� �� �������
             (Autos[J].FCurrCourseIndex>-1)AND                       //������� ���������?
             (Autos[J].CurrCourse.Id_Course=Courses[I].FId_Course)AND//��������� �� ������ ��������?
             (Autos[J].IsWaiting OR Autos[J].IsWorking)AND           //� ������� ���������?
             (Autos[J].FCurrDirection=adUnLoading)                   //�� -> ��?
          then Inc(AItem^.AutoCount);
          FList0.Add(AItem);
        end;{if}
      end;{if}
    end;{for}
  SortList(FList0);//������� I �) ����������

  //������� II. ������� ����� ������������ ������� --------------------------------------------
  if (FList0.Count>0)and                                         //�������� ����?
     (Openpit.Common.StrippingCoefUsing)and                //��������� ����������� �������?
     (FCurrStrippingCoef<LoadingPunkts.FPlannedStrippingCoef)and //�����<�����
     (FCurrOreQtn>0.0)then                                       //���� ������
  begin
    //������ ������1 �� ��������
    AIsOreDone := true;
    for I := 0 to FList0.Count-1 do
    begin
      AItem := PListItem(FList0[I]);
      if not AItem^.LoadingPunktRock.Rock.IsMineralWealth then
      begin
        if AItem^.LoadingPunktRock.ShiftFactRemainingQtn>0.0 then AIsOreDone := false;
        FList1.Add(AItem);
      end;{if}
    end;{for}
    //���� � ������ ���� ���� ���� ������������� �������, �� ������ �����������
    if not AIsOreDone then
      for I := FList1.Count-1 downto 0 do
      if not(PListItem(FList1[I])^.LoadingPunktRock.ShiftFactRemainingQtn>0.0)then
      begin
        FList1[I] := nil; FList1.Delete(I);
      end;{for}
    if FList1.Count>0 then
    begin
      if Openpit.Common.AutoWorkRegime<>wrEqualDistrubation//���� �� ����������� �������������
      then Result := PListItem(FList1[0])^.Course.FCourseIndex//� ����������� ����������� �����
      else Result := GetEqualDistrubationCourseIndex(FList1); //� ����������� ��������������
    end;{if}
  end;{if}

  //������� III. �������� �������������: ���������� ��������-----------------------------------
  if (FList0.Count>0)and                               //�������� ����?
     (Result=-1)and                                    //����������� ������� �� ��������?
     (Openpit.Common.AutoWorkRegime=wrQualityAveraging)then //���������� ��������?
  begin
    ClearList1(FList1);
    //������ ������1 �� �����
    AIsOreDone := true;
    for I := 0 to FList0.Count-1 do
    begin
      AItem := PListItem(FList0[I]);
      if AItem^.LoadingPunktRock.Rock.IsMineralWealth then
      begin
        if AItem^.LoadingPunktRock.ShiftFactRemainingQtn>0.0 then AIsOreDone := false;
        FList1.Add(AItem);
      end;{if}
    end;{for}
    //���� � ������ ���� ���� ���� ������������� ����, �� ������ �����������
    if not AIsOreDone then
      for I := FList1.Count-1 downto 0 do
      if not(PListItem(FList1[I])^.LoadingPunktRock.ShiftFactRemainingQtn>0.0)then
      begin
        FList1[I] := nil; FList1.Delete(I);
      end;{for}
    if FList1.Count>0 then
    begin
      if Openpit.Common.AutoWorkRegime<>wrEqualDistrubation//���� �� ����������� �������������
      then Result := PListItem(FList1[0])^.Course.FCourseIndex//� ����������� ����������� �����
      else Result := GetEqualDistrubationCourseIndex(FList1); //� ����������� ��������������
    end;{if}
  end;{if}

  //������� IV. �������� �������������: ����������� �������������------------------------------
  if (FList0.Count>0)and(Result=-1)
  then Result := GetEqualDistrubationCourseIndex(FList0);

  if Result=-1
  then AErrMsg := Format(EAutosNotFoundOpenedCourse,[AAuto.Name]);
  ClearList(FList0);
  ClearList1(FList1);
end;{DefineAutosOpenedCourseUPLP}
//��������� ������ �������� ��� ���� �� �� � ��C
function TDispatcher.DefineAutosCourseUPSP(AAuto: TesaAuto; var AErrMsg: String): Integer;
var
  I: Integer;
  MinD: Single;
begin
  AErrMsg := '';
  Result := -1;
  if AAuto=nil then Exit;
  if AAuto.FCourseIndex>-1 then Result := AAuto.FCourseIndex;//�������� ����
  //1.������������ ������ �������� ������ �� �� �� ���
  //2.����� ��� ������� ��������, �� �������� ����� ������� ��  ���,
  //  ������������� �� ������ ����
  //3. ���� ����� ��������� ���������, �� ������� ����������
  MinD := MaxInt;
  if Result=-1 then//�������� ����
  for I := 0 to Courses.Count-1 do
    if Courses[I].FId_Course<>AAuto.CurrCourse.FId_Course then    //������� 0
    if Courses[I].FKind=ckCourseUP_SP then                        //������� 1
      if Courses[I].FId_Point0=AAuto.CurrCourse.FId_Point1 then   //������� 2a
      if Courses[I].FId_Point1=AAuto.ShiftPunkt.FId_Point then    //������� 2b
        if Courses[I].Lm<MinD then                            //������� 3
        begin
          Result := I; MinD := Courses[I].Lm;
        end;{if}
  if Result=-1 then                                                           
    AErrMsg := Format(EAutosNotFoundCourseUPSP,[AAuto.Name,AAuto.ShiftPunkt.Name]);
end;{DefineAutosCourseUPSP}

//---------------------------------------------------------------------------------------------
//                                A U T O D I S P A T C H E R
//---------------------------------------------------------------------------------------------
//I.3. ������ �������� (82 lines)
procedure TDispatcher.RunModeling_(var ATime: _SystemTime);
var
  APath           : String; //���� � ������� �����
  dTsec,I         : Integer;//��������� ��� �������������, sec
  AMinDT,AMaxDT   : Integer;//�����/������.��� �������������
  //
  tmp: string;
begin
  if FIsErrorInputData or FIsErrorCalc then Exit;
  //��������� ��������� �������� --------------------------------------------------------------
  //����������� �������� ������
  FfhResultItems         := 0; FfhAutos               := 0; FfhLoadingPunkts       := 0;
  FfhLoadingPunktRocks   := 0; FfhUnLoadingPunkts     := 0; FfhUnLoadingPunktRocks := 0;
  FResultItemIndex      := 0;//������ ������� �������� ����� �������������
  //��� ����������� �����./������. ���� �������������, ���
  AMinDT := MaxInt;
  AMaxDT := 0;
  if (not FIsRunning)OR FIsStop then Exit;//������ ��.������ ��� ������ �������������
  SendMessageStartTime(ATime,'II.������ ��������');//������ �������������
  try
    FGauge.Visible := true;
    //II.������������� ------------------------------------------------------------------------
    //1. ������������� ------------------------------------------------------------------------
    //������ ����� �������� ������
    APath                 := ExtractFilePath(Application.ExeName);
    FfhResultItems         := FileCreate(APath+'ResultItems.ESA');
    FfhAutos               := FileCreate(APath+'ResultAutos.ESA');
    FfhLoadingPunkts       := FileCreate(APath+'ResultLoadingPunkts.ESA');
    FfhLoadingPunktRocks   := FileCreate(APath+'ResultLoadingPunktRocks.ESA');
    FfhUnLoadingPunkts     := FileCreate(APath+'ResultUnLoadingPunkts.ESA');
    FfhUnLoadingPunktRocks := FileCreate(APath+'ResultUnLoadingPunktRocks.ESA');
    //����������� ������������� ������� �����, ���
    FShiftTsec := Openpit.Shift.Tmin*60;
    FGauge.MaxValue := FShiftTsec;
    //��������� ���������� ��������� �����-������������� ������������
    DefineInitLoadingPunkts_;  //������������� ������� ��������
    DefineInitUnLoadingPunkts_;//������������� ������� ���������
    DefineCurrStrippingCoef_;  //���.����-�� �������
    DefineInitBlocks_;         //������������� ����-��������
    DefineInitAutos_;          //������������� ��������������
    DefineAutosSorting_;       //���������� ��������������
    //���������� ���������� ��������� � �������� �����
    SaveResultLists(APath);
    AppendResultItem(0);
    AppendResultAutos();
    AppendResultLoadingPunkts();
    AppendResultUnLoadingPunkts();
    //�������
    for I := 0 to Autos.Count-1 do
      if Autos[I].FCurrState<>asUnWorked then
        Autos[I].Events.Shifting(Autos[I].ShiftPunkt);
    tmp:= '0';
    //2. �������� ���� ------------------------------------------------------------------------
    FCurrTsecNaryad := 0;
    while FCurrTsecNaryad<FShiftTsec do
    begin

      if (FCurrTsecNaryad>10600) then
        _tmp_bool:= false;

//      if (FCurrTsecNaryad>10513) then// 14, 6
//      if (FCurrTsecNaryad>2513) then// 5, 9
      if (FCurrTsecNaryad>6800) then
      begin
        _tmp_bool:= true;
//        TXTWriter.TWriter.WriteToTXT(format('( %d )',
//                                            [FCurrTsecNaryad]));
      end;
      if (FCurrTsecNaryad>10544) then
        tmp:= '2';

      if (FCurrTsecNaryad>10576) then
        tmp:= '2';

      if (FCurrTsecNaryad>6982) then
        tmp:= '2';

      Inc(FResultItemIndex);                    //��������� ��������
      dTsec:= DefineAutosMinDtSec_;             //����������� ���������� ���� �������������
      if FCurrTsecNaryad+dTsec>FShiftTsec then  //�������� ���������� ���� �������������
        dTsec := FShiftTsec-FCurrTsecNaryad;
      if dTsec>0 then                           //����.��� ������������� ���������
      begin
        DefineAutosGoBy_(dTsec,FCurrTsecNaryad);//�������� ����s �� dTsec �������
        DefineAutosSorting_;                    //���������� ����
        if AMinDT>dTsec then AMinDT := dTsec;   //MinDtSec
        if AMaxDT<dTsec then AMaxDT := dTsec;   //MaxDtSec
        AppendResultAutos;                      //���������� �������������� � �������� ����
      end{if}
      else
      begin
        SendWarningMsg('��������� ��� ������������� �� ���������');
        SendMessage('������ ��������...');
        FIsErrorCalc := true;
      end;{else}
      //�������� ������������� ������� ����������
      if FShiftTsec - FCurrTsecNaryad = dTsec then
        CheckEndOfShiftForAutos(dTsec, FCurrTsecNaryad);

      if (not FIsErrorCalc)and(FCurrWorkingAutosCount+FCurrWaitingAutosCount=0)then
      begin
//        SendWarningMsg('�� �������� �������������� � ������� ���������');
        SendMessage('������ ��������...');
        FIsErrorCalc := true;
      end;
      FCurrTsecNaryad := FCurrTsecNaryad+dTsec;//���.����� �����, ���
      DefineCurrStrippingCoef_;                //���.����������� �������
      AppendResultItem(FCurrTsecNaryad);       //������ �������� ������
      FGauge.Progress := FCurrTsecNaryad;
      if FIsStop OR FIsErrorCalc then
        Break; //��������� ������ ��� ��������� ������
    end;{while}
    AppendResultLoadingPunkts();
    AppendResultUnLoadingPunkts();
  finally
    SetGaugeValue(FGauge.MaxValue);
    FGauge.Visible := false;
    //3. ����������� --------------------------------------------------------------------------
    //�������� �������� ������
    FileClose(FfhResultItems);     FileClose(FfhAutos);
    FileClose(FfhLoadingPunkts);   FileClose(FfhLoadingPunktRocks);
    FileClose(FfhUnLoadingPunkts); FileClose(FfhUnLoadingPunktRocks);
    //��������� � ���������� ������ �������������, ���/���.���� �������������
    SendMessageFinishTime(ATime,'����� ������� ��������');//��������� I.20
    SendMessage(Format('Min: %d ���   Max: %d ���',[AMinDT,AMaxDt]));
  end;{try}
end;{RunModeling_}
//������������� ���������� ��������� ������� ��������
procedure TDispatcher.DefineInitLoadingPunkts_;
var
  AState: TPunktState;//��������� ������
  I,J: Integer;
begin
  for I := 0 to LoadingPunkts.Count-1 do
  begin
    LoadingPunkts[I].FCurrState := psWaiting;
    LoadingPunkts[I].FSumAutoCount     := 0;
    for AState := Low(TPunktState) to High(TPunktState) do
      LoadingPunkts[I].FSumDTsec[AState]:= 0;
    //LoadingPunktRocks
    for J := 0 to LoadingPunkts[I].FCount-1 do
      LoadingPunkts[I].FItems[J].FShiftFactRock := esaRockVolume();
  end;{for}
end;{DefineInitLoadingPunkts_}
//������������� ���������� ��������� ������� ���������
procedure TDispatcher.DefineInitUnLoadingPunkts_;
var
  AState: TPunktState;//��������� ������
  I,J: Integer;
begin
  for I := 0 to UnLoadingPunkts.Count-1 do
  begin
    UnLoadingPunkts[I].FCurrState        := psWaiting;
    UnLoadingPunkts[I].FCurrAutoCount    := 0;
    for AState := Low(TPunktState) to High(TPunktState) do
      UnLoadingPunkts[I].FSumDTsec[AState]:= 0;
    UnLoadingPunkts[I].FCostsWork        := 0.0;
    UnLoadingPunkts[I].FCostsProstoy     := 0.0;
    UnLoadingPunkts[I].FAmortizationCtg:= 0.0;
    UnLoadingPunkts[I].FCostsSummary     := 0.0;
    //UnLoadingPunktRocks
    for J := 0 to UnLoadingPunkts[I].FCount-1 do
    begin
      UnLoadingPunkts[I].FItems[J].FCurrRockVolume := esaRockVolume();{?Initial}
      UnLoadingPunkts[I].FItems[J].FCurrContent := UnLoadingPunkts[I].FItems[J].FInitialContent;
      UnLoadingPunkts[I].FItems[J].FSumAutoCount:= 0;
    end;{for}
  end;{for}
end;{DefineInitUnLoadingPunkts_}
//���������� ������� ����������� �������
procedure TDispatcher.DefineCurrStrippingCoef_;
var I,J: Integer;
begin
  FCurrStrippingQtn  := 0.0;//����� ������� �������, �
  FCurrOreVm3        := 0.0;//����� ������� ����, m3
  FCurrOreQtn        := 0.0;//����� ������� ����, m3
  FCurrStrippingVm3  := 0.0;//����������� �������, �/�
  for I := 0 to UnLoadingPunkts.Count-1 do
  begin
    for J := 0 to UnLoadingPunkts[I].RockCount-1 do
    begin
      if not UnLoadingPunkts[I].Rocks[J].Rock.IsMineralWealth then
      begin//�������
        //StrippingQtn := StrippingQtn+FUnLoadingPunkts[I].Rocks[J].FInitialQtn;{?}
        FCurrStrippingVm3:= FCurrStrippingVm3 + UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Vm3;
        FCurrStrippingQtn:= FCurrStrippingQtn + UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Qtn;
      end{if}
      else
      begin//����
        //OreQtn := OreQtn+FUnLoadingPunkts[I].Rocks[J].FInitialQtn;{?}
        FCurrOreVm3:= FCurrOreVm3 + UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Vm3;
        FCurrOreQtn:= FCurrOreQtn + UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Qtn;
        FCurrOreQua:= (FCurrOreQua * FCurrOreQtn +
         UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Qtn + FCurrOreQtn); //���������
      end;{else}
    end;{for}
  end;{for}
  if FCurrOreQtn > 0.0 then
  begin
//    FCurrStrippingCoef := FCurrStrippingQtn/FCurrOreQtn;
//    FCurrStrippingCoef:= FCurrStrippingVm3/FCurrOreVm3;
  end;
end;{DefineCurrStrippingCoef_}
//������������� ���������� ��������� ����-��������
procedure TDispatcher.DefineInitBlocks_;
var
  I,J: Integer;
  ADir: TAutoDirection;
  AState : TAutoState;
begin
  for I := 0 to Blocks.Count-1 do
  begin
    Blocks[I].FSumRockVolume := esaRockVolume();
    for ADir := Low(TAutoDirection) to High(TAutoDirection) do
    begin
      Blocks[I].FSumWgCount1[ADir]:= 0;
      for AState := Low(TAutoState) to High(TAutoState) do
      begin
        Blocks[I].FSumAutoCount1[ADir,AState] := 0;
        Blocks[I].FSumAutoDTsec1[ADir,AState] := 0.0;
        Blocks[I].FSumAutoGXltr1[ADir,AState] := 0.0;
        Blocks[I].FSumAutoV1[ADir,AState]     := 0.0;
        Blocks[I].FSumAutoVCount1[ADir,AState]:= 0;
      end;{for}
    end;{for}
    //SubBlocks
    for J := 0 to Blocks[I].FSubBlocksCount-1 do
    begin
      Blocks[I].FSubBlocks[J].FCurrRightAutoIndex := -1;
      Blocks[I].FSubBlocks[J].FCurrLeftAutoIndex  := -1;
    end;{for}
  end;{for}
end;{DefineInitBlocks_}
//������� ������ �� ������� �������������
procedure TDispatcher.DefineInitAuto_(AAuto: TesaAuto);
var
  APos: TAutoPosition;
  ADir: TAutoDirection;
  AState: TAutoState;
begin
  //��������� (���� �� ������ ���������� � �������)
  AAuto.FCurrCourseIndex      := -1;
  AAuto.FCurrCourseBlockIndex := -1;
  AAuto.FCurrPunktIndex       := AAuto.FShiftPunktIndex;
  if not AAuto.FWorkState
  then AAuto.FCurrState       := asUnWorked//������������ � ��������� ���������
  else AAuto.FCurrState       := asWaiting;//������������ � �������
  AAuto.FCurrDirection        := adFromSP;
  AAuto.FCurrPosition         := apNone;
  //��� ����? (��������� ������)
  AAuto.FCurrRockLoadingPunktIndex    := -1;
  AAuto.FCurrRockLoadingPunktRockIndex:= -1;
  AAuto.FCurrRockVolumeRequired       := esaRockVolume();
  AAuto.FCurrRock.Id_Rock             := 0;
  AAuto.FCurrRock.Name                := '';
  AAuto.FCurrRock.IsMineralWealth     := False;
  AAuto.FCurrRockVolume               := esaRockVolume();
  AAuto.FCurrRockContent              := 0.0;
  //��������� �������� (���� �� ����� �� ���)
  AAuto.FCurrPoint   := AAuto.ShiftPunkt.Coords;
  AAuto.FCurrIndentPoint := AAuto.ShiftPunkt.Coords;
  AAuto.FCurrAzimut  := 0.0;
  AAuto.FCurrZenit   := 0.0;
  AAuto.FCurrV0      := 0.0;
  AAuto.FCurrV1      := 0.0;
  AAuto.FCurrV       := 0.0;
  AAuto.FCurrVavg    := 0.0;
  AAuto.FCurrW0      := 0.0;
  AAuto.FCurrW1      := 0.0;
  AAuto.FCurrW       := 0.0;
  AAuto.FCurrGx      := 0.0;
  AAuto.FCurrGxReq   := 0.0;
  AAuto.FCurrDt0Sec  := 0;
  AAuto.FCurrDt1Sec  := 0;
  AAuto.FCurrDtReqSec:= 0;
  AAuto.FSumQtnDSkm  := 0.0;
  AAuto.FSumHmtr     := 0.0;
  AAuto.FSumHLmtr    := 0.0;
  AAuto.FSumVavg     := 0.0;
  AAuto.FSumVavgCount:= 0;
  //��������� ���������� (�����)
  AAuto.FSumRocksVm3          := 0.0;
  AAuto.FSumRocksQtn          := 0.0;
  for ADir := Low(TAutoDirection) to High(TAutoDirection) do
  begin
    AAuto.FSumTripsCount[ADir] := 0;
    for APos := Low(TAutoPosition) to High(TAutoPosition) do
    for AState := Low(TAutoState) to High(TAutoState) do
    begin
      AAuto.FSumDSmtr[ADir,APos,AState] := 0.0;
      AAuto.FSumDTsec[ADir,APos,AState] := 0.0;
      AAuto.FSumGXltr[ADir,APos,AState] := 0.0;
    end;{for}
  end;{for}
end;{DefineInitAuto_}
//������������� ���������� ��������� ��������������
procedure TDispatcher.DefineInitAutos_;
var
  I,cIndex: Integer;
  ACourse: TesaCourse;
  ABlock: TesaCourseBlock;
  AErrMsg: String;
begin
  SetLength(FCurrAutos,Autos.Count);
  for I := 0 to Autos.Count-1 do
  begin
    DefineInitAuto_(Autos[I]);//������� ��� ��������� i-�� �������������
    //�����������
    if Autos[I].FCurrState<>asUnWorked then
    begin//������������ � ������� ���������
      //��������� ������� �������
      cIndex := DefineAutosCourse(Autos[I],AErrMsg);
      if cIndex=-1 then
      begin//���� �� ��������� �������
        Autos[I].FCurrState := asAbort;  SendWarningMsg(AErrMsg);
      end{if}
      else
      begin//���� ��������� �������
        ACourse := Courses[cIndex];
        ABlock  := ACourse[0];
        Autos[I].FCurrCourseIndex := cIndex;
        if ABlock.RightAutoIndex=-1 then
        begin//���� ����-������� ��������, ������� ����-�������
          ABlock.RightAutoIndex          := Autos[I].AutoIndex;
          Autos[I].FCurrCourseBlockIndex := 0;
          Autos[I].FCurrPosition         := apManeuverFromPunkt0;
          Autos[I].FCurrState            := asMovingFk;
          Autos[I].FCurrPunktIndex       := -1;
          DefineMovingAutosRequredParams_(Autos[I],0.0,adFromSP);
        end{if}
        else
        begin//���� ����-������� �� ��������, ����� � �������
          Autos[I].FCurrDt0Sec        := 0;
          Autos[I].FCurrDt1Sec        := Autos[ABlock.RightAutoIndex].FCurrDtReqSec;
          Autos[I].FCurrDtReqSec      := Autos[ABlock.RightAutoIndex].FCurrDtReqSec;
          Autos[I].FCurrGx            := 0.0;
          Autos[I].FCurrGxReq         := DefineAydarGx_(Autos[I],0.0,0.0,0.0,Autos[I].FCurrDt1Sec);
        end;{else}
      end;{else}
    end;{else}
    //�������� ������ ��� ���������� ����������
    FCurrAutos[I] := Autos[I];
  end;{for}

  //ul
  //uflog('new',true);
(*  uflog('autoIndex='+IntToStr(uAI));
  ACourse:= Autos[uAI].CurrCourse;
  for i:=0 to ACourse.Count-1 do   begin
    ABlock:=ACourse.Items[i];
    uflog(IntToStr(ABlock.FBlockIndex));
  end;  *)

end;{DefineInitAutos_}
//���������� ���� ����:  � ��������, � �������, � ������, � �����.��������� (82 lines)
procedure TDispatcher.DefineAutosSorting_;
  //����� ������� ������������� � ��������� AIndex0,AIndex1
  procedure ExchangeBy(const AIndex0,AIndex1: Integer);
  var AAuto: Pointer;
  begin
    AAuto := FCurrAutos[AIndex0];
    FCurrAutos[AIndex0] := nil;
    FCurrAutos[AIndex0] := FCurrAutos[AIndex1];
    FCurrAutos[AIndex1] := nil;
    FCurrAutos[AIndex1] := AAuto;
  end;{ExchangeBy}
var
  I,J,K,L: Integer;
  cUnWorked,cDone,cAbort,cWaiting,cWorking: Integer;//������� ���-�� ���� �� ������� ���� ��������� 
  Tsec: Integer;//����� ��� ���� � ������� �� ������������ ����.��, ���
begin
  //1.����������� ���-�� ���� �� ������� ���� ��������� ---------------------------------------
  FCurrUnWorkedAutosCount := 0;  FCurrAbortAutosCount  := 0;
  FCurrWaitingAutosCount  := 0;  FCurrWorkingAutosCount := 0;
  FCurrDoneAutosCount     := 0;  
  for I := 0 to Autos.Count-1 do
  case Autos[I].FCurrState of
    asWaiting : Inc(FCurrWaitingAutosCount);
    asAbort   : Inc(FCurrAbortAutosCount);
    asUnWorked: Inc(FCurrUnWorkedAutosCount);
    asDone    : Inc(FCurrDoneAutosCount);
    else        Inc(FCurrWorkingAutosCount);
  end;{case}
  //2.���������� ���� �� ���������� -----------------------------------------------------------
  cWorking := 0; cWaiting := 0; cAbort := 0; cUnWorked := 0; cDone := 0;
  for I := 0 to Autos.Count-1 do
  begin
    if Autos[I].IsWorking then         //������������� � ������
    begin
      Inc(cWorking);
      FCurrAutos[cWorking-1] := Autos[I];
    end{if}
    else
    if Autos[I].IsWaiting then         //������������� � �������
    begin
      Inc(cWaiting);
      FCurrAutos[FCurrWorkingAutosCount+cWaiting-1] := Autos[I];
    end{if}
    else
    if Autos[I].FCurrState=asAbort then//������������� � ������
    begin
      Inc(cAbort);
      FCurrAutos[FCurrWorkingAutosCount+FCurrWaitingAutosCount+cAbort-1] := Autos[I];
    end{if}
    else
    if Autos[I].FCurrState=asDone then//�������������, ����������� ������
    begin
      Inc(cDone);
      FCurrAutos[FCurrWorkingAutosCount+FCurrWaitingAutosCount+FCurrAbortAutosCount+cDone-1] :=
        Autos[I];
    end{if}
    else
    begin                              //������������� � ��������� ���������
      Inc(cUnWorked);
      FCurrAutos[FCurrWorkingAutosCount+FCurrWaitingAutosCount+
                 FCurrAbortAutosCount+FCurrDoneAutosCount+cUnWorked-1] := Autos[I];
    end;{else}
  end;{for}
  //3.���������� ���� � ������ �� ����������� ������� �� ���������� �������� ��������----------
  for I := 0 to FCurrWorkingAutosCount-1 do //1�-����, �-�� ������ ��������� t ��������� �-���
    for J := I+1 to FCurrWorkingAutosCount-1 do
      if FCurrAutos[I].FCurrDt1Sec>FCurrAutos[J].FCurrDt1Sec then ExchangeBy(I,J);
  //4.���������� ���� � ������� �� ����������� ������� �� ������������ ����.�������------------
  for I := FCurrWorkingAutosCount to FCurrWorkingAutosCount+FCurrWaitingAutosCount-1 do
    for J := I+1 to FCurrWorkingAutosCount+FCurrWaitingAutosCount-1 do
      if FCurrAutos[I].FCurrDt1Sec>FCurrAutos[J].FCurrDt1Sec then ExchangeBy(I,J);
  //4.1.���������� ���� � ������� �� �������� ����.������� ��������---------------------------- 
  if FCurrWaitingAutosCount>0 then //�.�. ���� ��� 2� ���� ������������ ����������� ����.��, 
  begin                            //�� ������ ������� ���, ��� ������ ����
    L    := FCurrWorkingAutosCount;                          //������ 1-�� ���� � �������
    Tsec := FCurrAutos[FCurrWorkingAutosCount].FCurrDt1Sec;//����� �� �������-��� ����.��
    for I := FCurrWorkingAutosCount+1 to FCurrWorkingAutosCount+FCurrWaitingAutosCount-1 do
    begin//�������� �� ���� ���� � �������, ������� �� 2-��
      if (FCurrAutos[I].FCurrDt1Sec<>Tsec)OR
         (I=FCurrWorkingAutosCount+FCurrWaitingAutosCount-1)then
      begin//������� �� ���� � ������ FCurrDt1Sec ��� �� ������.���� � �������
        for J := L to I-1 do     //�������� ���� � ������� �� ����������� CurrDt0Sec
          for K := J+1 to I-1 do //� ������.FCurrDt1Sec
            if FCurrAutos[J].FCurrDt0Sec<FCurrAutos[K].FCurrDt0Sec then ExchangeBy(J,K);
        L := I;//��������� ������ 1�� ���� �� ����.������ ���� � ������� � ������ FCurrDt1Sec
        Tsec := FCurrAutos[L].FCurrDt1Sec;
      end;{if}
    end{for}
  end;{if}
end;{DefineAutosSorting_}
//��������� ��������� �����.��� �������������
function TDispatcher.DefineAutosMinDtSec_: Integer;
var I: Integer;
begin
  Result := MaxInt;
  for I := 0 to Autos.Count-1 do
  //  if FCurrAutos[I].IsWorking then//� ���.���������, �� � �������, �� � ������
//-------------------------------------------------------------------------------------------------------
//IsWorking �� ����������� ��� ��������� ���� MovingHH � ���������� FCurrAutos[I].FCurrDt1Sec=0!!!
    if (FCurrAutos[I].IsWorking)and(FCurrAutos[I].FCurrDt1Sec>0) then
    //� ���.���������, �� � �������, �� � ������
//-------------------------------------------------------------------------------------------------------
      if Result > FCurrAutos[I].FCurrDt1Sec then
        Result := FCurrAutos[I].FCurrDt1Sec;
 // if abs(Result-MaxInt)<5 then Result := 0;
end;
procedure TDispatcher.DefineAutosIndent(const APoint0,APoint1         : RPoint3D;
                                        const AStripWm,ABlockLm: Single;
                                        var APoint                    : RPoint3D;
                                        var AAzimut,AZenit            : Single);
begin
  if ABlockLm>0.0 then
  begin
    AAzimut := AngleByOXInGrad(APoint1.X-APoint0.X,APoint1.Y-APoint0.Y);
    AZenit  := -arcsin((APoint1.Z-APoint0.Z)/ABlockLm)*GradPerRad;
    APoint := GetRightPoint(APoint,APoint0,APoint1,AStripWm);
  end;{if}
end;{DefineAutosIndent}

//��������� �������������� ����, ����������� lambda-����� ����������� ����
procedure TDispatcher.DefineAutosCurrPoint_(var AAuto: TesaAuto; const Lambda: Single);
var
  S0,S1,dS: Single;
  I: Integer;
  APoint0,APoint1,APoint,AIndentPoint: RPoint3D;
  AStripWm: Single;
begin
  //CurBlock<>Nill !!!
  APoint := AAuto.FCurrPoint;
  AIndentPoint := AAuto.FCurrPoint;
  S1 := AAuto.CurrBlock.Lm*Lambda;//������� �������
  S0 := 0.0;//������� �������
  for I := 1 to AAuto.CurrBlock.FCount-1 do
  begin
    if AAuto.FCurrDirection=adUnLoading then
    begin
      APoint0 := AAuto.CurrBlock.FPoints[AAuto.CurrBlock.FCount-1-I+1];
      APoint1 := AAuto.CurrBlock.FPoints[AAuto.CurrBlock.FCount-1-I];
    end{if}
    else
    begin
      APoint0 := AAuto.CurrBlock.FPoints[I-1];
      APoint1 := AAuto.CurrBlock.FPoints[I];
    end;{else}
    dS := sqrt(sqr(APoint0.X-APoint1.X)+sqr(APoint0.Y-APoint1.Y)+sqr(APoint0.Z-APoint1.Z));
    if InRange(S1,S0,S0+dS)then
    begin
      APoint.X := APoint0.X+(APoint1.X-APoint0.X)*((S1-S0)/dS);//������� �����
      APoint.Y := APoint0.Y+(APoint1.Y-APoint0.Y)*((S1-S0)/dS);
      APoint.Z := APoint0.Z+(APoint1.Z-APoint0.Z)*((S1-S0)/dS);
      AIndentPoint := APoint;
      if AAuto.CurrBlock.Block.FStripsN=1
      then AStripWm := AAuto.CurrBlock.Block.FStripWm*0.25
      else AStripWm := AAuto.CurrBlock.Block.FStripWm*0.5;
      DefineAutosIndent(APoint0,APoint1,AStripWm,dS,AIndentPoint,AAuto.FCurrAzimut,AAuto.FCurrZenit);
      Break;
    end{if}
    else S0 := S0+dS;
  end;{for}
  AAuto.FCurrPoint := APoint;
  AAuto.FCurrIndentPoint := AIndentPoint;
end;{DefineAutosCurrPoint_}

//���������� ��������������� ���������� �������� �� ������ ���������� �������
procedure TDispatcher.DefineAutosGoBy_(const dTsec, ACurrTsecNaryad: Integer);
var I,cWorking,cWaiting, cDoneing, cAll: Integer;
//ul
  uCR: TesaCourse;
  s,l,r,q:string;
  //
  zero_ResaRockVolume: ResaRockVolume;
  //
  tmp_auto_name: string;
  _tmp_dir, _tmp_state, _tmp_pos: string;
  _tmp_left, _tmp_right, _tmp_id: integer;
begin
  cWorking := FCurrWorkingAutosCount;//���������� ���� � ������
  cWaiting := FCurrWaitingAutosCount;//���������� ���� � �������
  cDoneing:= FCurrDoneAutosCount;//���������� ���� ����������� ������
  cAll:= cWorking + cWaiting;

  //�������� �� ��������������, ������� � ������ ----------------------------------------------
  for I := 0 to cWorking-1 do
  begin

//    if (FCurrAutos[I].FParkNo in [2, 6, 10]) then
//      if _tmp_bool then
      begin
        case FCurrAutos[I].FCurrDirection of
          adLoading: _tmp_dir:= 'adLoading  ';
          adUnLoading: _tmp_dir:= 'adUnLoading';
        end;
        case FCurrAutos[I].FCurrState of
          asMovingFk: _tmp_state:= 'asMovingFk';
          asMovingHh: _tmp_state:= 'asMovingHh';
          asMovingBt: _tmp_state:= 'asMovingBt';
          asWaiting:  _tmp_state:= 'asWaiting ';
          asAbort:    _tmp_state:= 'asAbort   ';
          asUnWorked: _tmp_state:= 'asUnWorked';
          asDone:     _tmp_state:= 'asDone    ';
        end;
        case FCurrAutos[I].FCurrPosition of
          apNone:               _tmp_pos:= 'apNone              ';
          apManeuverFromPunkt0: _tmp_pos:= 'apManeuverFromPunkt0';
          apToPunkt1:           _tmp_pos:= 'apToPunkt1          ';
          apManeuverToPunkt1:   _tmp_pos:= 'apManeuverToPunkt1  ';
          apOnPunkt1:           _tmp_pos:= 'apOnPunkt1          ';
        end;
        _tmp_left:= Courses[11].Last.LeftAutoIndex;
        _tmp_right:= Courses[11].Last.RightAutoIndex;
        _tmp_id:= Courses[11].Last.FBlockIndex;

        tmp_auto_name:= format('auto %d [%s | %s | %s | %d]',
                                [FCurrAutos[I].FParkNo, _tmp_dir, _tmp_state, _tmp_pos, FCurrAutos[I].FCurrCourseBlockIndex]);

//        TXTWriter.TWriter.WriteToTXT(format('%s', [tmp_auto_name]));
//        TXTWriter.TWriter.WriteToTXT(format('left side: %d | right side: %d', [_tmp_left, _tmp_right]));

      end;
    if FCurrAutos[I].FCurrPosition=apOnPunkt1 then
    begin
//      if (tmp_auto_name='14')then
//        tmp_auto_name:= format('%s!', [tmp_auto_name]);
      if FCurrAutos[I].FCurrDirection in [adFromSP,adUnLoading]
      then
      begin
        DefineLoadingAutosGoBy_(FCurrAutos[I],dTsec,ACurrTsecNaryad);   //��������
      end
      else
      begin
        DefineUnLoadingAutosGoBy_(FCurrAutos[I],dTsec,ACurrTsecNaryad);//���������
      end;
    end
    else
      begin
        DefineMovingAutosGoBy_(FCurrAutos[I],dTsec,ACurrTsecNaryad);     //��������
      end;
  end;
  //�������� �� ��������������, ������� � ������� ---------------------------------------------
  for I := cWorking to cAll-1 do
  begin

//    if
//       (FCurrAutos[I].FParkNo in [14, 6])
//       (FCurrAutos[I].FParkNo in [2, 6, 10]) then
//      if _tmp_bool then
      begin
        case FCurrAutos[I].FCurrDirection of
          adLoading: _tmp_dir:= 'adLoading  ';
          adUnLoading: _tmp_dir:= 'adUnLoading';
        end;
        case FCurrAutos[I].FCurrState of
          asMovingFk: _tmp_state:= 'asMovingFk';
          asMovingHh: _tmp_state:= 'asMovingHh';
          asMovingBt: _tmp_state:= 'asMovingBt';
          asWaiting:  _tmp_state:= 'asWaiting ';
          asAbort:    _tmp_state:= 'asAbort   ';
          asUnWorked: _tmp_state:= 'asUnWorked';
          asDone:     _tmp_state:= 'asDone    ';
        end;
        case FCurrAutos[I].FCurrPosition of
          apNone:               _tmp_pos:= 'apNone              ';
          apManeuverFromPunkt0: _tmp_pos:= 'apManeuverFromPunkt0';
          apToPunkt1:           _tmp_pos:= 'apToPunkt1          ';
          apManeuverToPunkt1:   _tmp_pos:= 'apManeuverToPunkt1  ';
          apOnPunkt1:           _tmp_pos:= 'apOnPunkt1          ';
        end;
        tmp_auto_name:= format('auto %d [%s | %s | %s | %d]',
                                [FCurrAutos[I].FParkNo, _tmp_dir, _tmp_state, _tmp_pos, FCurrAutos[I].FCurrCourseBlockIndex]);
//        TXTWriter.TWriter.WriteToTXT(format('%s', [tmp_auto_name]));
      end;

    DefineWaitingAutosGoBy_(FCurrAutos[I],dTsec,ACurrTsecNaryad);        //�������
  end;
  for I := cAll to cAll + cDoneing - 1 do
  begin
    zero_ResaRockVolume.Vm3:= 0;
    zero_ResaRockVolume.Qtn:= 0;
    zero_ResaRockVolume.Qua:= 0;
    zero_ResaRockVolume.Excv:= 0;

    FCurrAutos[I].Events.Waiting(0,dTsec,edNone,FCurrAutos[I].FCurrRock,
                           zero_ResaRockVolume,FCurrAutos[I].CurrCourse.Punkt1,
                           FCurrAutos[I].CurrCourse.Punkt1);
  end;
end;

//ul
//function uBadAuto(autos:TesaAutos; curs:TesaCourse; curBI:integer;
//          adir:TAutoDirection; var tSec : integer ):integer;
function uBadAuto(autos:TesaAutos; auto : TesaAuto; var tSec : integer ; dx:integer):integer;
var //dx,
    bi:integer;
    dBeg, dEnd:integer;
    len1, len2:single;
    bs1:boolean;
    tai:integer;
    curs: TesaCourse;
    Vsr:single;
begin
   Result:=-1; tSec:=0;

  curs:=auto.CurrCourse;
  dBeg := 0; dEnd:=curs.Count-1;

  //if auto.FCurrState=asWaiting then exit;
  //if auto.FCurrDirection=adLoading then exit;
  //if curs.Kind = ckCourseMoving then dx:=dx*(-1);
  //if auto.FCurrDirection=adUnLoading then dx:=dx*(-1);
  //if not ( auto.FCurrDirection in [adLoading,adToSP])  then dx:=dx*(-1);

  bi:=auto.FCurrCourseBlockIndex+dx;
  len1:=0.0; len2:=0.0;
  bs1:=false;
  tSec:=0;

  // ���� ��������� ����� ���������� ��������
  // ���� ��������� ��� ��������� ��� ������ - �� �������
  while( (bi>dBeg) and (bi<dEnd)) do begin
     if(curs.Items[bi].Block.StripsN = 1) then
     begin
        //uflog('bi.strip1='+inttostr(curs.Items[bi].FBlockIndex));
        bs1:=true;
        len1:=len1+ curs.Items[bi].Lm;
        if(curs.Items[bi].LeftAutoIndex<>-1) then
        begin
          Result:=curs.Items[bi].LeftAutoIndex;
          tSec:=curs.Autos[Result].FCurrDt1Sec+2;    // ���� �������� len1!!!
          vsr:=curs.Autos[Result].FCurrV1;
          if vsr <= 0.0 then vsr:=curs.Autos[Result].FCurrVavg;
          if vsr <= 0.0 then vsr:=auto.FCurrV / 2.0;
          tSec:=tsec+round(1.1*(3600*(0.001*(len1))/vsr));
          exit;
        end;
     end;
     if(curs.Items[bi].Block.StripsN <> 1) then break;
     bi:=bi+dx;
  end;

  if auto.FCurrDirection=adLoading then exit;

  if( bs1 ) then // ���� ������������� �����
  begin // ����� len1 ������� ����������
    len2:=0;
    while( (bi>dBeg) and (bi<dEnd)) do begin
      if(curs.Items[bi].Block.StripsN = 2) then
      begin
        len2:=len2+ curs.Items[bi].Lm;

        // ���� ����� �� ������, �� ���� ��������
        tai:=curs.Items[bi].LeftAutoIndex;// RightAutoIndex;
        if(tai<>-1 ) then
        begin
          // ��� ���� ��� ���������� � ����� �� ����
          if autos[tai].FCurrState=asWaiting then exit;
          //curs.Autos[curs.Items[bi].RightAutoIndex].FCurrV - �������� ����
          vsr:=autos[tai].FCurrV;
          tSec:=round(1.1*(3600*(0.001*(len2+len1))/vsr));
          Result:=tai;
          exit;
        end;

        // ���� ��������� ����� ������� �� len1
        if (len2 >= len1 ) then  // ���� ������6 �� ������ ��������
        begin
           Result:=-1;
           tSec:=0;
           exit;
        end;

      end;
      //if(curs.Items[bi].Block.StripsN  1) then break;
      bi:=bi+dx;
     end;
   end;
   Result:=-1;
end;
//ul-

//ul ����� ���������� ���� ��� �������
procedure uLogAuto(a:TesaAuto; title : string);
var s:string;
begin
   uflog('*'+title);
   uflog('AutoIndex='+inttostr(a.AutoIndex));
   uflog('FCurrCourseIndex='+inttostr(a.FCurrCourseIndex));
   uflog('FCurrCourseBlockIndex='+inttostr(a.FCurrCourseBlockIndex));
   case a.FCurrDirection of
    adFromSP: s:='adFromSP';
    adLoading: s:='adLoading';
    adToSP:     s:='adToSP';
    adUnLoading: s:='adUnLoading';
    adUnknown:   s:='adUnknown';
   end;
   uflog('FCurrDirection='+s);
   case a.FCurrState of
      asAbort : s:='asAbort';
      asDone : s:='asDone';
      asMovingBt: s:='asMovingBt';
      asMovingFk: s:='asMovingFk';
      asMovingHh: s:='asMovingHh';
      asUnWorked: s:='asUnWorked';
      asWaiting: s:='asWaiting';
   end;
   uflog('FCurrState='+s);
end;
//ul-


//���������� �������������(� ��������) ���������� �������� �� ������ ���������� ������� (59 L)
procedure TDispatcher.DefineMovingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
var
  APos         : TAutoPosition; //���.��������� ����
  AState       : TAutoState;    //���.��������� ����
  ADir         : TAutoDirection;//���.����������� ����
  Lambda       : Single;        //�������.����������� ����������� ������� ����
  ABadAutoIndex: Integer;       //������ ����, ��������� ���� ��
  eDir         : TesaResultAutoEventDirection;
  eIdPunkt0,eIdPunkt1  : Integer;
  eHorizont0,eHorizont1: Single;
  eWAvgHmNum,eWAvgHmDen: Single;
  eAvgHmNum,eAvgHmDen  : Single;
  ANextBlock           : TesaBlock;
  ALoadingPunkt        : TesaLoadingPunkt;
  AUnloadingPunkt      : TesaUnloadingPunkt;

  uBAI,uRSec,dx:integer; // ������ ��������� ���� � �����, � ����������� ����

  isOneLane: boolean;

  //
  cut_sec: integer;
  //
  tmp_auto_name: string;
begin
  APos := AAuto.FCurrPosition;
  ADir := AAuto.FCurrDirection;
  AState := AAuto.FCurrState;
  //1.�������� dTsec ������� ------------------------------------------------------------------
  with AAuto do
  begin
    cut_sec:= 0;
    if dTsec > FCurrDt1Sec then//�� ������ ��������
    begin
      cut_sec:= dTsec - FCurrDt1Sec;
      dTsec:= FCurrDt1Sec;
    end;
    FCurrDt0Sec := FCurrDt0Sec+dTsec;//������
    FCurrDt1Sec := FCurrDt1Sec-dTsec;//��������
    Lambda := FCurrDt0Sec/FCurrDtReqSec;
    DefineAutosCurrPoint_(AAuto,Lambda);//������������ � �����
    FCurrV     := FCurrV0+(FCurrV1-FCurrV0)*Lambda;//�����.��������
    FCurrW     := FCurrW0+(FCurrW1-FCurrW0)*Lambda;//�����.��������
    FCurrGx    := FCurrGxReq*Lambda;//������������� �������
    //2.������ �� ����� ���.��? ------------------------------------------------
    if FCurrDt1Sec<1 then
    begin

      if (AAuto.FParkNo=10) then
        _tmp_test_auto:= '';

      //��������� ���������� ����
      FSumDSmtr[ADir,APos,AState] := FSumDSmtr[ADir,APos,AState] + CurrBlock.Lm;
      FSumDTsec[ADir,APos,AState] := FSumDTsec[ADir,APos,AState] + FCurrDtReqSec;
      FSumGXltr[ADir,APos,AState] := FSumGXltr[ADir,APos,AState] + FCurrGxReq;
      FSumVavg := FSumVavg+FCurrVavg;
      FSumVavgCount := FSumVavgCount+1;
      eWAvgHmNum := 0.0;
      eWAvgHmDen := 0.0;
      eAvgHmNum := 0.0;
      eAvgHmDen := 0.0;
      //$ ����������� ��������
      if ADir=adLoading then
      begin
        FSumQtnDSkm := FSumQtnDSkm+0.001*CurrBlock.Lm*FCurrRockVolume.Qtn;
        if CurrBlockHmtr>0.0 then
        begin
//          FSumHmtr := FSumHmtr+CurrBlockHmtr*CurrBlock.Lm;
//          FSumHLmtr := FSumHLmtr+CurrBlock.Lm;
          FSumHmtr := FSumHmtr+CurrBlockHmtr;
          FSumHLmtr := 1;
        end;{if}
        if CurrBlock<>nil then
        begin
          eWAvgHmNum:= abs(CurrBlock.Point0.Z-CurrBlock.Point1.Z)*FCurrRockVolume.Qtn;
          if eWAvgHmNum>0.0 then
            eWAvgHmDen := FCurrRockVolume.Qtn;
          eAvgHmNum:= abs(CurrBlock.Point0.Z-CurrBlock.Point1.Z);
          if eAvgHmNum>0.0 then
            eAvgHmDen := 1.0;
        end;{if}
      end;{if}
      eDir := edNone;
      eIdPunkt0 := 0;
      eHorizont0 := 0.0;
      eIdPunkt1 := 0;
      eHorizont1 := 0.0;
      ALoadingPunkt := nil;
      AUnloadingPunkt := nil;
      case ADir of
        adFromSP: begin
          eDir          := edNulled;
          eIdPunkt0     := ShiftPunkts[Courses[FCurrCourseIndex].FPunktIndex0].Id_ShiftPunkt;
          eHorizont0    := ShiftPunkts[Courses[FCurrCourseIndex].FPunktIndex0].FCoords.Z;
          eIdPunkt1     := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1].Id_LoadingPunkt;
          eHorizont1    := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1].FCoords.Z;
          ALoadingPunkt := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1];
        end;{adFromSP}
        adToSP: begin
          eDir := edNulled;
          eIdPunkt0       := UnLoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0].Id_UnLoadingPunkt;
          eHorizont0      := UnLoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0].FCoords.Z;
          eIdPunkt1       := ShiftPunkts[Courses[FCurrCourseIndex].FPunktIndex1].Id_ShiftPunkt;
          eHorizont1      := ShiftPunkts[Courses[FCurrCourseIndex].FPunktIndex1].FCoords.Z;
          AUnloadingPunkt := UnloadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0];
        end;{adToSP}
        adLoading: begin
          eDir := edLoading;
          eIdPunkt0 := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0].Id_LoadingPunkt;
          eHorizont0 := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0].FCoords.Z;
          eIdPunkt1 := UnLoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1].Id_UnLoadingPunkt;
          eHorizont1 := UnLoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1].FCoords.Z;
          ALoadingPunkt := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0];
          AUnloadingPunkt := UnloadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1];
        end;{adLoading}
        adUnLoading: begin
          eDir            := edUnLoading;
          AUnloadingPunkt := UnloadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1];
          eIdPunkt0       := UnLoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1].Id_UnLoadingPunkt;
          eHorizont0      := UnLoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex1].FCoords.Z;
          eIdPunkt1       := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0].Id_LoadingPunkt;
          eHorizont1      := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0].FCoords.Z;
          ALoadingPunkt   := LoadingPunkts[Courses[FCurrCourseIndex].FPunktIndex0];
        end;{adUnLoading}
      end;{case}

      if APos in [apManeuverFromPunkt0,apManeuverToPunkt1] then
      begin
        Events.Manevr(FCurrGxReq, FCurrDt0Sec + cut_sec, eDir, eIdPunkt0, eIdPunkt1, FCurrRock, FCurrRockVolume, eWAvgHmNum, eWAvgHmDen, eAvgHmNum, eAvgHmDen, FCurrVavg, 1, CurrBlock.Lm);
      end
      else//�������� �� �� ��������
      begin
        Events.FKind      := ekMoving;
        Events.FDirection := eDir;
        Events.FIdPunkt0  := eIdPunkt0;
        Events.FHorizont0 := eHorizont0;
        Events.FIdPunkt1  := eIdPunkt1;
        Events.FHorizont1 := eHorizont1;
        Events.FSm        := Events.FSm+CurrBlock.Lm;
        Events.FTsec      := Events.FTsec + FCurrDt0Sec + cut_sec;
        Events.FGx        := Events.FGx+FCurrGxReq;
        Events.FId_Rock   := FCurrRock.Id_Rock;
        Events.FRock      := FCurrRock.Name;
        Events.FRockIsMineralWealth := FCurrRock.IsMineralWealth;
        Events.FRockVolume:= FCurrRockVolume;
        Events.FWAvgHmNum := Events.FWAvgHmNum+eWAvgHmNum;
        Events.FWAvgHmDen := Events.FWAvgHmDen+eWAvgHmDen;
        Events.FAvgHmNum  := Events.FAvgHmNum+eAvgHmNum;
        Events.FAvgHmDen  := Events.FAvgHmDen+eAvgHmDen;
        Events.FAvgVkmh   := esaSum(Events.AvgVkmh,FCurrVavg,1);
      end;
      //3. ������ �� ����� ��������? ----------------------------------------------------------
      if APos=apManeuverToPunkt1 then
      begin//3.1.������ �� ����� �������� (�.�. ��������� ������ � ��������� � ������)
        //������ �� �� =========================================================
        if (ALoadingPunkt<>nil)and(ADir in [adUnLoading,adFromSp]) then
          ALoadingPunkt.Excavator.Events.Manevr(0.0,FCurrDtReqSec,AAuto);
        if (AUnloadingPunkt<>nil)and(ADir in [adLoading]) then
          AUnloadingPunkt.Events.Manevr(0.0,FCurrDtReqSec,AAuto);
        //======================================================================

        //�����, � �������� �������� ����, ��������?
        if ((ADir=adLoading)and(UnLoadingPunkts[CurrCourse.FPunktIndex1].IsEmpty))OR
           ((ADir=adLoading)and(CurrCourse.Last.RightAutoIndex=FAutoIndex))or
           (ADir<>adLoading)then
        begin//���� �� �������� (�� � ��� ������ ��������)
          DefineAutosEmptyCurrBlock_(AAuto);                 //���������� ���. ��
          DefineAutosPlacePunkt_(AAuto,ACurrTsecNaryad);     //������� �����
        end
        else
        begin
          DefineAutosUhozhuVProstoyOnUP__(AAuto);         //����� � ������� �� ������
        end;
      end
      else
      begin//3.2. ��� �� ������� �� ����� ��������(�.�. ������� ��� ��)
        //������ �� �� =========================================================
        if (ALoadingPunkt<>nil)and
           (APos=apManeuverFromPunkt0)and
           (ADir=adLoading) then
          ALoadingPunkt.Excavator.Events.Manevr(0.0,FCurrDtReqSec,AAuto);
        if (AUnloadingPunkt<>nil)and
           (APos=apManeuverFromPunkt0)and
           (ADir in [adLoading,adToSP]) then
          AUnloadingPunkt.Events.Manevr(0.0,FCurrDtReqSec,AAuto);
        //======================================================================

        //���������� �������
        if ADir=adUnLoading then
          ANextBlock := AAuto.CurrCourse[FCurrCourseBlockIndex-1].Block
        else
          ANextBlock := AAuto.CurrCourse[FCurrCourseBlockIndex +1 ].Block;
        if ANextBlock.Kind=bukManeuver then
          Events.Moving;
        //������ "�������" ����, ����������� ����.��
//        if not isOneLane then
        begin
          if ADir=adUnLoading then
            ABadAutoIndex := AAuto.CurrCourse[FCurrCourseBlockIndex-1].LeftAutoIndex
          else
            ABadAutoIndex := AAuto.CurrCourse[FCurrCourseBlockIndex+1].RightAutoIndex;
        end;

        if (ABadAutoIndex = -1) or (ABadAutoIndex = AAuto.FAutoIndex) then//����.�� �������� ���� ����� ����
        begin
          DefineAutosEmptyCurrBlock_(AAuto);                 //���������� ���. ��
          DefineAutosPlaceNextBlock_(AAuto);                 //������� ����.��
        end
        else
        begin
          DefineAutosUhozhuVProstoy_(AAuto,ABadAutoIndex);//����� � �������
        end;
      end;
    // ������ ������ ��������
    end;
  end;
end;


//���������� ������� �� (68 L)
procedure TDispatcher.DefineAutosEmptyCurrBlock_(AAuto: TesaAuto);
var
  ADir  : TAutoDirection;          //���. ����������� ����
  AState: TAutoState;              //���. ��������� ����
  ABlock0,ABlock1: TesaCourseBlock;//������������� � ���������� ��
  ACourseBlockIndex0: Integer;     //������ �������� ��
  lPunkt: TesaLoadingPunkt;
  uPunkt: TesaUnLoadingPunkt;
  pState: TPunktState;
begin
  ADir := AAuto.FCurrDirection;
  AState  := AAuto.FCurrState;
  ACourseBlockIndex0 := AAuto.FCurrCourseBlockIndex;
  with AAuto.CurrBlock.Block do
  begin
    //0. H����� �������/��������� ��-----------------------------------------------------------
    ABlock0 := AAuto.CurrCourse[ACourseBlockIndex0];
    //������ ��������� ��
    if  AAuto.FCurrPosition=apManeuverToPunkt1
    then ABlock1 := nil //���� ������� ��������� �� ������� �������� ���
    else                //���� ��� �� ������� ��������� �� ������� ��������
      if ADir=adUnLoading
      then ABlock1 := AAuto.CurrCourse[ACourseBlockIndex0-1]
      else ABlock1 := AAuto.CurrCourse[ACourseBlockIndex0+1];
    //1. ��������� ��������� ����-�������------------------------------------------------------
    FSumRockVolume              := esaSum(FSumRockVolume,AAuto.FCurrRockVolume);
    FSumAutoDTsec1[ADir,AState] := FSumAutoDTsec1[ADir,AState]+AAuto.FCurrDtReqSec;
    FSumAutoGXltr1[ADir,AState] := FSumAutoGXltr1[ADir,AState]+AAuto.FCurrGxReq;
    if AState in [asMovingFk,asMovingHh,asMovingBt] then
    begin
      FSumAutoV1[ADir,AState]     := FSumAutoV1[ADir,AState]+AAuto.FCurrVavg;
      FSumAutoVCount1[ADir,AState]:= FSumAutoVCount1[ADir,AState]+1;
    end;{if}

    if AState=asWaiting
    then FSumWgCount1[ADir]:= FSumWgCount1[ADir]+1;
    if ABlock0<>nil then
    if ((ABlock1<>nil)and(ABlock1.FBlockIndex<>ABlock0.FBlockIndex))OR
       (ABlock1=nil)
    then
    begin
      FSumAutoCount1[ADir,AState] := FSumAutoCount1[ADir,AState]+1;
      Events.Accumulate(ADir,AState,AAuto,True);
    end{if}
    else Events.Accumulate(ADir,AState,AAuto);
    //2. ���������� ���.����-�������-----------------------------------------------------------
    case ADir of
      adLoading:begin //�������� �����������---------------------------------------------------
        if {(ABlock0.Kind=bukCrossRoad)OR}                //���� ������� ����������� ���
           (ABlock0.Block.StripsN=1)OR                //             ��������� ���
           (AAuto.FCurrPosition=apManeuverFromPunkt0)then//             ����������� ��,
        begin                                            //�� ���������� ��� ������� ��
          if(AAuto.CurrBlock.LeftAutoIndex = AAuto.FAutoIndex)or(AAuto.CurrBlock.RightAutoIndex = AAuto.FAutoIndex)then
          begin
            AAuto.CurrBlock.LeftAutoIndex := -1;
            AAuto.CurrBlock.RightAutoIndex := -1;
          end;
        end
        else AAuto.CurrBlock.RightAutoIndex := -1;       //����� ������ ������ ������� ������
        if AAuto.FCurrPosition=apManeuverFromPunkt0 then
        begin//�������� ����������� ��
          lPunkt := TesaLoadingPunkt(AAuto.CurrCourse.Punkt0);
          pState := lPunkt.FCurrState;
          lPunkt.FSumDTsec[pState] := lPunkt.FSumDTsec[pState]+AAuto.FCurrDtReqSec;
          lPunkt.FCurrState := psWaiting;
          AppendResultLoadingPunkt(AAuto.CurrCourse.FPunktIndex0);
        end;{if}
      end;{adLoading}
      adUnLoading: begin//������������ �����������---------------------------------------------
        if AAuto.FCurrPosition<>apManeuverToPunkt1 then
        begin//���� ������� �� ����������� ��, �� ���������� �� ����� ��
          if {(ABlock0.Kind=bukCrossRoad)OR}//���� �����������
            (ABlock0.Block.StripsN=1) then//��� ���������,
          begin
            if(AAuto.CurrBlock.LeftAutoIndex = AAuto.FAutoIndex)or(AAuto.CurrBlock.RightAutoIndex = AAuto.FAutoIndex)then
            begin
              AAuto.CurrBlock.LeftAutoIndex := -1;
              AAuto.CurrBlock.RightAutoIndex := -1;
            end;
          end
          else
            AAuto.CurrBlock.LeftAutoIndex := -1;     //���������� ����� ������� ������   
        end;{if}
        if AAuto.FCurrPosition=apManeuverFromPunkt0 then
        begin//�������� ������. �� ������ ���������
          uPunkt := TesaUnLoadingPunkt(AAuto.CurrCourse.Punkt1);
          pState := psManeuver;//! �.�.����� ���� � psWorking
          uPunkt.FSumDTsec[pState] := uPunkt.FSumDTsec[pState]+AAuto.FCurrDtReqSec;
          if uPunkt.FCurrAutoCount=0
          then uPunkt.FCurrState := psWaiting;
          AppendResultUnLoadingPunkt(AAuto.CurrCourse.FPunktIndex1);
        end;{if}
      end;{adUnLoading}
      adFromSP   : //�� ��� � ��---------------------------------------------------------------
        if AAuto.FCurrPosition<>apManeuverToPunkt1 then
        begin//���� ������� �� ����������� ��, �� ���������� �� ����� ��
          if {(ABlock0.Kind=bukCrossRoad)OR}//���� �����������
            (ABlock0.Block.StripsN=1) then//��� ���������,
          begin
            if(AAuto.CurrBlock.LeftAutoIndex = AAuto.FAutoIndex)or(AAuto.CurrBlock.RightAutoIndex = AAuto.FAutoIndex)then
            begin
              AAuto.CurrBlock.LeftAutoIndex := -1;
              AAuto.CurrBlock.RightAutoIndex := -1;
            end;
          end
          else
            AAuto.CurrBlock.RightAutoIndex := -1;     //���������� ����� ������� ������
        end;{if}
      adToSP     : //�� �� � ���---------------------------------------------------------------
        begin                                                                          
          if {(ABlock0.Kind=bukCrossRoad)OR}//���� �����������
            (ABlock0.Block.StripsN=1) then//��� ���������,
          begin
            if(AAuto.CurrBlock.LeftAutoIndex = AAuto.FAutoIndex)or(AAuto.CurrBlock.RightAutoIndex = AAuto.FAutoIndex)then
            begin
              AAuto.CurrBlock.LeftAutoIndex := -1;
              AAuto.CurrBlock.RightAutoIndex := -1;
            end;
          end
          else
            AAuto.CurrBlock.RightAutoIndex := -1;     //���������� ����� ������� ������
          if AAuto.FCurrPosition=apManeuverFromPunkt0 then
          begin//�������� ������. �� ������ ���������
            uPunkt := TesaUnLoadingPunkt(AAuto.CurrCourse.Punkt0);{!}
            pState := psManeuver;//! �.�.����� ���� � psWorking
            uPunkt.FSumDTsec[pState] := uPunkt.FSumDTsec[pState]+AAuto.FCurrDtReqSec;
            if uPunkt.FCurrAutoCount=0
            then uPunkt.FCurrState := psWaiting;
            AppendResultUnLoadingPunkt(AAuto.CurrCourse.FPunktIndex1);
          end;{if}
        end;{dToSP}
    end;{case}
  end;{with}
end;{DefineAutosEmptyCurrBlock_}
//������� ����� ��������/��������/���������� {76 L}
procedure TDispatcher.DefineAutosPlacePunkt_(AAuto: TesaAuto; const ACurrTsecNaryad: Integer);
  //����������� ���� � ������ ����������� �� � ������� �������� (������ �����)
  procedure _GetRockAndLoadingTsec(const lPunkt           : TesaLoadingPunkt;
                                    const lRock           : TesaLoadingPunktRock;
                                    var   ARockVolume     : ResaRockVolume;
                                    var   ALoadingTsec    : Integer);
  var
    AExcavatorCicleCount: Single;//���������� ������� ������ ����������� �� �������� ������
    AKovshVm3,AKovshQtn : Single;//�����(�3)� ���(�) �� � ����� �����������
  begin
    ARockVolume            := esaRockVolume();
    ALoadingTsec           := 0;
    AKovshVm3              := lPunkt.Excavator.Model.MaxVm3/lRock.FShatteringCoef;    //����� �� � �����, �3
    AExcavatorCicleCount   := AAuto.Model.MaxVm3/AKovshVm3;                           //�-�� ���.������ �����������
    AKovshQtn              := AKovshVm3*lRock.FDensityInBlock;//��� �� � �����, �
    ARockVolume.Qtn        := AKovshQtn*AExcavatorCicleCount;                         //��� �� � ������, �
    ARockVolume.Qua        := lRock.FContent;
    ARockVolume.Excv       := lPunkt.Excavator.ParkNo; {dwd}

    if ARockVolume.Qtn>AAuto.FFactTonnage then//��������������� ��� ����.���������������� ����
    begin
      AExcavatorCicleCount := AAuto.FFactTonnage/AKovshQtn;                           //�-�� ���.������ �����������
      ARockVolume.Qtn      := AKovshQtn*AExcavatorCicleCount;                         //��� �� � ������, �
    end;{if}
    ARockVolume.Vm3        := ARockVolume.Qtn/lRock.FDensityInBlock;                  //����� �� � ������, �3
    ALoadingTsec           := Round(Ceil(AExcavatorCicleCount)*lPunkt.Excavator.Tsec);//����� ��������, ���
  end;{_GetRockAndLoadingTsec}
var
  lPunkt: TesaLoadingPunkt;
  lRock : TesaLoadingPunktRock;
  uPunkt: TesaUnLoadingPunkt;
  pState: TPunktState;
  AutoTRequiredSec,I: Integer;
begin
  with AAuto do
  begin
    //��������� ����
    AutoTRequiredSec := FCurrDtReqSec;//��������
    FCurrCourseBlockIndex    := -1;
    FCurrPunktIndex          := CurrCourse.FPunktIndex1;
    FCurrState               := asMovingHh;
    FCurrPosition            := apOnPunkt1;
    case FCurrDirection of
      //1.������ �� ����� �������� ------------------------------------------------------------
      adUnLoading,adFromSP: begin
        //1.1.��������� ����
        if FCurrDirection=adUnLoading                   //���� ������.�����������,
        then FCurrPunktIndex := CurrCourse.FPunktIndex0;//�� ��- � ������ ��������;
        lPunkt := LoadingPunkts[FCurrPunktIndex];       //����� ��������
        pState := lPunkt.FCurrState;
        FCurrPoint := lPunkt.Coords;                    //����������
        FCurrIndentPoint := FCurrPoint;
        FCurrAzimut := 0.0;
        FCurrZenit  := 0.0;
        FCurrDtReqSec:= Round(lPunkt.Excavator.FTsec);//���
        //1.2.����� ���� ���� �� ��
        FCurrRockLoadingPunktIndex:= FCurrPunktIndex;
        lRock := nil;
        FCurrRockLoadingPunktRockIndex := -1;
        for I := 0 to lPunkt.FCount-1 do
          if lPunkt[I].ShiftFactRemainingQtn>0.0 then
          begin
            FCurrRockLoadingPunktRockIndex:= I;
            Break;
          end;{if}
        if (FCurrRockLoadingPunktRockIndex=-1)and(lPunkt.FCount>0)
        then FCurrRockLoadingPunktRockIndex := lPunkt.FCount-1;
        if FCurrRockLoadingPunktRockIndex>-1 then
        begin//���������� ���� �� � ������� ��������
          lRock   := lPunkt[FCurrRockLoadingPunktRockIndex];
          _GetRockAndLoadingTsec(lPunkt,lRock,FCurrRockVolumeRequired,FCurrDtReqSec);
        end;{if}
        if lRock=nil then
        begin//���� �� �� ����������� ��
          SendWarningMsg(Format(EAutosRockNone,[Name,lPunkt.Name,CurrCourse.Name]));
          FCurrState := asAbort;
        end;{if}
        //1.3.����� ��������� ��
        lPunkt.FSumDTsec[pState] := lPunkt.FSumDTsec[pState]+AutoTRequiredSec;
        lPunkt.FCurrState := psWorking;
        AppendResultLoadingPunkt(FCurrPunktIndex);
      end;{� ��}
      //2.������ �� ����� ��������� -----------------------------------------------------------
      adLoading: begin
        //2.1.����� ��������� ������ ���������
        uPunkt := UnLoadingPunkts[FCurrPunktIndex];
        pState := uPunkt.FCurrState;
        uPunkt.FSumDTsec[pState] := uPunkt.FSumDTsec[pState]+AutoTRequiredSec;
        Inc(uPunkt.FCurrAutoCount);//���-�� �������-����� ����
        uPunkt.FCurrState := psWorking;
        AppendResultUnLoadingPunkt(FCurrPunktIndex);
        //2.2.��������� ����
        FCurrPoint  := uPunkt.Coords;   //���������
        FCurrIndentPoint := FCurrPoint;
        FCurrAzimut := 0.0;
        FCurrZenit  := 0.0;
        FCurrDtReqSec:= Round(Model.MaxTsec);//sec
      end;{� ��}
      //3.������ �� ����� ���������� ----------------------------------------------------------
      adToSP: begin
        FCurrState   := asDone;
        FCurrPoint   := ShiftPunkt.Coords;
        FCurrIndentPoint := FCurrPoint;
        FCurrAzimut  := 0.0;
        FCurrZenit   := 0.0;
        FCurrDtReqSec:= 0;
        Events.Shifting(ShiftPunkt);
      end;{� ���}
    end;{case}
    //��������� ����
    FCurrV0          := 0.0;   FCurrV1     := 0.0;
    FCurrV           := 0.0;   FCurrVavg   := 0.0;
    FCurrW0          := 0.0;   FCurrW1     := 0.0;
    FCurrW           := 0.0;
    FCurrDt0Sec      := 0;     FCurrDt1Sec := FCurrDtReqSec;//���
    FCurrGx          := 0.0;   FCurrGxReq  := DefineAydarGx_(AAuto,0.0,0.0,0.0,FCurrDt1Sec);
  end;{with}
end;{DefineAutosPlacePunkt_}

//ul ��� ����������� �� ������ �����
function uGetGrAuto( course : TesaCourse; dir: TAutoDirection; blInd:integer):integer;
begin
  Result:=-1;
end;
//ul-



function TDispatcher.CheckCascadeOneLane_(CurrCourse: TesaCourse; BlockIndex: integer; upDirection: boolean; Value: integer): boolean;
var
  CourseBlock: TesaCourseBlock;
begin
  Result:= false;
  CourseBlock:= CurrCourse[BlockIndex];

  if(CourseBlock.Block.FStripsN = 1)then
  begin
    CourseBlock.RightAutoIndex := Value;
    CourseBlock.LeftAutoIndex  := Value;

    if upDirection then inc(BlockIndex)
    else dec(BlockIndex);
    CheckCascadeOneLane_(CurrCourse, BlockIndex, upDirection, Value);
    Result:= true;
  end;
end;
//������� ��������� ��
procedure TDispatcher.DefineAutosPlaceNextBlock_(AAuto: TesaAuto);
var
  ACourseBlockIndex1: Integer;//������ ����.�� ������� ��������
  ABlock0,ABlock1   : TesaCourseBlock;//����.�� ������� ��������

  lPunkt: TesaLoadingPunkt;
  uPunkt: TesaUnLoadingPunkt;
  AIndent: Single;               //���������� ����� ���� �� ��� ������ �� ������ ������, m
  APos0,APos1: RPoint3D;
  _courseDirection: boolean;
begin
  with AAuto do
  begin
    _courseDirection:= FCurrDirection<>adUnLoading;
    //1.��������� ����.��----------------------------------------------------------------------
    if FCurrPunktIndex<>-1 then
    begin//���� �� �� ��� �� ��� ���
      if FCurrDirection<>adUnLoading                     //���� �� ������.�����������
      then ACourseBlockIndex1 := 0                       //�� ������ �� ������� ��������,
      else ACourseBlockIndex1 := CurrCourse.Count-1;     //����� ��������� �� ������� ��������;
      ABlock0 := nil;
    end{if}
    else
    begin//���� �� �� ������
      if FCurrDirection<>adUnLoading                     //���� �� ������.�����������
      then ACourseBlockIndex1 := FCurrCourseBlockIndex+1 //�� ����.�� ������� ��������,
      else ACourseBlockIndex1 := FCurrCourseBlockIndex-1;//����� ����.�� ������� ��������,
      ABlock0 := CurrBlock;
    end;{else}
    //2.������� ����.��------------------------------------------------------------------------
    ABlock1 := CurrCourse[ACourseBlockIndex1];
    if(not CheckCascadeOneLane_(CurrCourse, ACourseBlockIndex1, _courseDirection, AutoIndex)) then
    begin
      if {(ABlock1.Kind=bukCrossRoad)OR}            //���� ����������� ���
         //(ABlock1.Block.StripsN=1)OR             //��������� ���
         ((ABlock1.Kind=bukManeuver)and             //����������� �������,
          (ABlock0<>nil)and(ABlock0.Kind<>bukManeuver)and
          (not(FCurrDirection in [adLoading,adToSP])))then
      begin                                         //�� ������� ��� ������� ������
        ABlock1.RightAutoIndex := AutoIndex;
        ABlock1.LeftAutoIndex  := AutoIndex;
      end{if}
      else
      begin                                         //����� ������� ���� ������� ������
        if FCurrDirection=adUnLoading
        then ABlock1.LeftAutoIndex  := AutoIndex
        else ABlock1.RightAutoIndex := AutoIndex;
      end;{else}
    end;

    //ul
   //ul-


    //3.��������� �������������----------------------------------------------------------------
    FCurrCourseBlockIndex := ACourseBlockIndex1;
    FCurrPunktIndex       := -1;
    FCurrState            := asMovingFk;
    if FCurrDirection<>adUnLoading
    then FCurrPoint       := ABlock1.Point0
    else FCurrPoint       := ABlock1.Point1;

    FCurrIndentPoint := FCurrPoint;
    APos0 := FCurrPoint;
    if FCurrDirection<>adUnLoading
    then APos1 := ABlock1.Point1
    else APos1 := ABlock1.Point0;
    if CurrBlock.Block.StripsN=1
    then AIndent := CurrBlock.Block.StripWm*0.25
    else AIndent := CurrBlock.Block.StripWm*0.5;
    DefineAutosIndent(APos0,APos1,AIndent,CurrBlock.Lm,FCurrIndentPoint,FCurrAzimut,FCurrZenit);
    if (ABlock1.Kind=bukManeuver)and(ABlock0<>nil)and(ABlock0.Kind<>bukManeuver)
    then FCurrPosition    := apManeuverToPunkt1
    else FCurrPosition    := apToPunkt1;
    //4.��������� ��������� ������� ����.��----------------------------------------------------
    DefineMovingAutosRequredParams_(AAuto,FCurrV1,FCurrDirection);
    //5.���� ����� ������.��� ������.��--------------------------------------------------------
    if FCurrPosition=apManeuverToPunkt1 then
    begin
      case AAuto.FCurrDirection of
        adFromSP: begin
          lPunkt := TesaLoadingPunkt(AAuto.CurrCourse.Punkt1);
          lPunkt.FCurrState := psManeuver;
          AppendResultLoadingPunkt(AAuto.CurrCourse.FPunktIndex1);
        end;{adFromSP}
        adUnLoading: begin
          lPunkt := TesaLoadingPunkt(AAuto.CurrCourse.Punkt0);
          lPunkt.FCurrState := psManeuver;
          AppendResultLoadingPunkt(AAuto.CurrCourse.FPunktIndex0);
        end;{adUnLoading}
        adLoading: begin
          uPunkt := TesaUnLoadingPunkt(AAuto.CurrCourse.Punkt1);
          if uPunkt.FCurrState=psWaiting
          then uPunkt.FCurrState := psManeuver;
          AppendResultUnLoadingPunkt(AAuto.CurrCourse.FPunktIndex1);
        end;{adLoading}
      end;{case}
    end;{if}
  end;{with}
end;{DefineAutosPlaceNextBlock_}


procedure uFLog(s:string; fn: string = 'uFLog.txt'; createNew : boolean = false);
//const
//  fn='uFLog.txt';
var
  tf : TextFile;
begin
  AssignFile(tf, fn);
  if ( not FileExists(fn) ) or ( createNew ) then
  begin
    ReWrite(tf);
    Writeln(tf,'File Created : '+datetimetostr( now));
    CloseFile(tf);
  end;
  Append(tf);
//  WriteLn(tf, datetimetostr( now) +' '+s);
  WriteLn(tf, s);
  CloseFile(tf);
end;

(*
//��������� RequiredDistance � RequiredTime ����
procedure TDispatcher.DefineAutosRequredParams_(AAuto: TesaAuto; const V0: Single);
const
  g=9.8;//���������, �/c2
  nu=112;//����������� ���������
var
  I              : Integer;
  APoint0,APoint1: RPoint3D;//���������-�������� ����� sub-����-�������
  dSmtr          : Single;//����������, �
  dHmtr,Hmtr     : Single;//�������-����� ������ �������, �
  dTsec,Tsec     : Single;//�������-����� ����� ��������, ���
  AV0,AV1,AVavg  : Single;//���������-��������-������� ��������, ��/�
  Ptn,Ggm,Ga       : Single;//��� ����, ��; ����� �����/����, �
  w0_,W0         : Single;//��������(�/kH)-������(�) ������������� �������
  wi_,Wi         : Single;//��������(�/kH)-������(�) ������������� �� ������
  Wv             : Single;//������ ������������� �� ��������� �����, �
  Wk,FkH          : Single;//��������� �������������, H; ���� ����, �
  a_             : Single;//��������� ��������, m/s2
  Radicand       : Single;//����������� ��������� ��������� ��������
  dGxLtr,GxLtr   : Single;//�������-����� ������ �������, �
begin
  with AAuto do
  begin
    //����� �����/����, �
    Ggm := FCurrRockQtn; Ga := Model.Ptn;
    //��� �������������, ��
    Ptn := (Ga+Ggm)*g;// �*�/c2=1000��*�/c2=1000�=��
    //�������� �� ������� ����-�������
    AV0 := V0; AV1 := AV0; Tsec := 0.0; GxLtr := 0.0; Hmtr := 0.0;
    for I := 1 to CurrBlock.FCount-1 do
    begin
      //��������� ��������� � �������� ����� sub-����-������� APoint0,APoint1
      if FCurrDirection=adUnLoading then
      begin
        APoint0 := CurrBlock.FPoints[CurrBlock.FCount-1-I+1];
        APoint1 := CurrBlock.FPoints[CurrBlock.FCount-1-I];
      end{if}
      else
      begin
        APoint0 := CurrBlock.FPoints[I]; APoint1 := CurrBlock.FPoints[I-1];
      end;{else}
      dSmtr := sqrt(sqr(APoint0.X-APoint1.X)+sqr(APoint0.Y-APoint1.Y)+sqr(APoint0.Z-APoint1.Z));
      dHmtr := APoint1.Z-APoint0.Z;
      Hmtr := Hmtr+dHmtr;
      //������������� ��������
      w0_ := DefineW0_(Ga,Ggm,CurrBlock.RoadCoat);//H
      W0 := Ptn*w0_;//H
      wi_ := 1000*dHmtr/sqrt(sqr(APoint0.X-APoint1.X)+sqr(APoint0.Y-APoint1.Y)); //H/kH
      Wi := Ptn*wi_;//H
      Wv := DefineWv(AV0); //H
      Wk := W0+Wv+Wi;//H
      //���� ����, �
      FkH := DefineFH(v0);//H
      FkH := FkH-FkH*(Model.TransmissionKPD-FTransmissionKPD);
      //��������� ��������, �/c2
      a_ := nu*(FkH-Wk)/(1000*(Ga+Ggm));// �/�� = (��*m/c2)/�� = �/c2
      //dV/dT=A -> (v1-v0)/(dS/((v0+v1)/2))=A -> (v1^2-v0^2)/2dS=A -> v1^2=v0^2+2*dS*A
      Radicand := AV0*AV0+2*(dSmtr*0.001)*a_;
      if Radicand>0.0 then
      begin
        AV1 := sqrt(Radicand); AVavg := 0.5*(AV0+AV1);
        //����� ��������, sec
        dTsec := 3600*(0.001*dSmtr)/AVavg;                  Tsec  := Tsec+dTsec;
        //������ �������, ����
        dGxLtr := (0.001*dSmtr)*DefineGd_(Ga,Ggm,w0_,wi_);  GxLtr := GxLtr+dGxLtr;
        AV0 := AV1;
      end{if}
      else
      begin//�� ���� ���������� ��
        SendWarningMsg(Format(EAutosAborted,[Name,wi_]));
        FCurrState := asAbort; AV1 := 0.0; Tsec := 0.0; GxLtr := 0.0;
        Break;
      end;{else}
    end;{for}
    //��������� ���������
    if FCurrState<>asAbort then
    begin
      if Hmtr<0.0 then FCurrState := asMovingHh else FCurrState := asMovingFk;
    end;{if}
    //��������� ��������
    FCurrV0 := V0; FCurrV1 := AV1; FCurrV := V0; FCurrVavg:= (FCurrV0+FCurrV1)*0.5;
    //��������� �����
    FCurrDtReqSec := Round(Tsec); FCurrDt0Sec := 0; FCurrDt1Sec := FCurrDtReqSec;
    //��������� Gx
    FCurrGx := 0.0; FCurrGxReq := GxLtr;
  end;{with}
end;{DefineAutosRequredParams_}
*)
//��������� RequiredDistance � RequiredTime ����
procedure TDispatcher.DefineMovingAutosRequredParams_(AAuto: TesaAuto; const V0: Single; const ADirection: TAutoDirection);
const
  g=9.8;// ��������� ���������� ������� (�/c2)
  dT=1;//sec
var
  I              : Integer;
  APoint0,APoint1: RPoint3D;//���������-�������� ����� sub-����-�������
  dSmtr          : Single;//����������, �
  dHmtr,Hmtr     : Single;//�������-����� ������ �������, �
  dTsec,Tsec     : Single;//�������-����� ����� ��������, ���
  dVkmh,AV0,AV1,AVavg  : Single;//���������-��������-������� ��������, ��/�
  W0,W1          : Single;//���������-�������� ������ �������������, �H
  Ggm,Ga         : Single;//��� ����, ��; ����� �����/����, �
  dGxLtr,GxLtr   : Single;//�������-����� ������ �������, �
  Q_kK_l                    : Single; //������������ ����������� �������, ����/�
  nu_n                      : Single; //����������� �������� ��������
  nnu_d,nnu_tr,nnu_k,nnu_kom: Single; //������������ nu_n � ���������� ���������
  nu_d,nu_tr,nu_k,nu_kom    : Single; //������������ nu_n �������

  wi_            : Single;//�������� ������������� �� ������, �/kH
  w0_            : Single;//�������� ������������� �� �������, �/kH
  a,b: Single;

  FkHkH : Single;
  AMaxVkmh: Single;
begin
  FkHkH := 0.0;
  with AAuto do
  begin
    //�������� ��� ������������ ����� ������� �������� � ����������� ���������
    nnu_d   := 0.4;
//    nnu_tr  := 0.78;
    nnu_tr  := AAuto.Model.TransmissionKPD;
    nnu_k   := 0.9;
    nnu_kom := 0.95;

    //�������� ��� ������������ ����� ������� �������� �������
    nu_d    := 0.4;
    {nu_d    := AAuto.FEngineKPD;}
//    nu_tr   := FTransmissionKPD*0.78;
    nu_tr   := AAuto.FTransmissionKPD*AAuto.Model.TransmissionKPD;
    nu_k    := 0.9;
    nu_kom  := 0.9;
    //����������� �������� ��������
    nu_n    := nu_d*nu_tr*nu_k*nu_kom/Max((nnu_d*nnu_tr*nnu_k*nnu_kom),0.001);
    Q_kK_l  := 8500.0;   //������������ ����������� ����������, ����/�
    //����� �����/����, �
    Ggm:= FCurrRockVolume.Qtn;
    Ga:= Model.Ptn;
    //�������� �� ������� ����-�������
    AV0:= V0;
    AV1:= AV0;
    Tsec:= 0.0;
    GxLtr:= 0.0;
    Hmtr:= 0.0;
    W0:= -1;
    W1:= 0.0;
    for I := 1 to CurrBlock.FCount-1 do
    begin
      //��������� ��������� � �������� ����� sub-����-������� APoint0,APoint1
      if FCurrDirection=adUnLoading then
      begin
        APoint0:= CurrBlock.FPoints[CurrBlock.FCount-1 - I + 1];
        APoint1:= CurrBlock.FPoints[CurrBlock.FCount-1 - I];
      end
      else
      begin
        APoint0 := CurrBlock.FPoints[I-1]; APoint1 := CurrBlock.FPoints[I];
      end;
      dSmtr := sqrt(sqr(APoint0.X-APoint1.X)+sqr(APoint0.Y-APoint1.Y)+sqr(APoint0.Z-APoint1.Z));
      dHmtr := APoint1.Z-APoint0.Z;
      Hmtr := Hmtr+dHmtr;
      //������������� ��������
      wi_:= 1000 * dHmtr / sqrt(sqr(APoint0.X - APoint1.X) + sqr(APoint0.Y - APoint1.Y)); //H/kH

//      if wi_>80.0
//      then wi_ := 80.0;

      w0_:= DefineW0HkH(CurrBlock.RoadCoat, Model.MaxQtn, Ggm);
      FkHkH:= DefineFH(AV0) / (g * (Ga + Ggm));//H/(g*�)=H/kH
      dVkmh:= 2 * (dSmtr * 0.001) * 12.96 * (nu_n * FkHkH - ((w0_ * 0.1) + wi_));

      if W0 < 0.0 then
        W0:= ((w0_ * 0.1) + wi_) * (g * (Ga + Ggm));
      W1:= ((w0_ * 0.1) + wi_) * (g * (Ga + Ggm));

      if (AV0 * AV0 + dVkmh) < 0 then
        break;

      AV1 := sqrt(AV0 * AV0 + dVkmh);
///////////////////////////////
      if AV1 > 0.0 then
      begin
        AVavg:= 0.5 * (AV0 + AV1);
        //����� ��������, sec
        dTsec:= 3600 * (0.001 * dSmtr) / AVavg;
        Tsec:= Tsec + dTsec;
        //������ �������, ����
        //��������� ������ �������
        a:= FkHkH * (AV1 * AV1 - AV0 * AV0) * (Ga+Ggm);
        b:= 2 * Q_kK_l * (nu_d * nu_tr * nu_k * nu_kom) * 12.96 * (nu_n * FkHkH - ((w0_ * 0.1) + wi_));
        if a * b > 0.0 then
          dGxLtr:= a/b
        else
          dGxLtr:= 0.0;
        GxLtr:= GxLtr + dGxLtr;
        AV0:= AV1;
      end
      else
      begin//�� ���� ���������� ��
        //$ ������ ������
        SendWarningMsg(Format(EAutosAborted,[Name,wi_]));
        FCurrState := asAbort;
        AV1 := 0.0;
        Tsec := 0.0;
        GxLtr := 0.0;
        Break;
      end;
/////////////////////////
     if ADirection=adLoading then
      AMaxVkmh:= CurrBlock.Block.LoadingVmax
     else
      AMaxVkmh:= CurrBlock.Block.UnLoadingVmax;
      if AV1 >= AMaxVkmh then //��������� ����������� ��������
      begin
        AV1:= AMaxVkmh;
        FkHkH:= 0.0;
      end;
      if AV1 >= AAuto.Model.MaxVkmh then //��������� ����������� ��������
      begin
        AV1:= AAuto.Model.MaxVkmh;
        FkHkH:= 0.0;
      end;

    end;
    //��������� ���������
    if FCurrState<>asAbort then
    begin
      if (Hmtr < 0.0)or(FkHkH < 0.001) then
        FCurrState:= asMovingHh
      else
        FCurrState := asMovingFk;
    end;
    //��������� ��������
    FCurrV0:= V0;
    FCurrV1:= AV1;
    FCurrV:= V0;
    FCurrVavg:= (FCurrV0 + FCurrV1) * 0.5;
    //��������� W
    FCurrW0:= W0;
    FCurrW1:= W1;
    FCurrW:= W0;
    //��������� �����
    FCurrDtReqSec:= Round(Tsec);
    FCurrDt0Sec:= 0;
    FCurrDt1Sec:= FCurrDtReqSec;
    //��������� Gx
    FCurrGx:= 0.0;
    FCurrGxReq:= GxLtr;
  end;
end;
//����� � ������� �� ������ ���������
procedure TDispatcher.DefineAutosUhozhuVProstoyOnUP__(AAuto: TesaAuto);
var I: Integer;
begin
  with AAuto do
  begin
    FCurrV0 := 0.0; FCurrV1 := 0.0; FCurrV := 0.0; FCurrVavg := 0.0;
    FCurrW0 := 0.0; FCurrW1 := 0.0; FCurrW := 0.0;
    FCurrDtReqSec := High(Integer);
    for I := 0 to Autos.Count-1 do
      if Autos[I].IsOnUnloadingPunkt and
        (UnLoadingPunkts[Autos[I].FCurrPunktIndex].FId_Point=CurrCourse.Punkt1.Id_Point)and
        (FCurrDtReqSec>Autos[I].FCurrDt1Sec)
      then FCurrDtReqSec := Autos[I].FCurrDt1Sec;
    FCurrDt1Sec        := FCurrDtReqSec;
    FCurrDt0Sec        := 0;
    FCurrState         := asWaiting;
    FCurrGx            := 0.0;
    FCurrGxReq         := DefineAydarGx_(AAuto,0.0,0.0,0.0,FCurrDt1Sec);
  end;{with}
end;{DefineAutosUhozhuVProstoyOnUP_}
//����� � �������
procedure TDispatcher.DefineAutosUhozhuVProstoy_(AAuto: TesaAuto;ANextBlockAutoIndex: Integer);
begin
  with AAuto do
  begin
    FCurrV0 := 0.0; FCurrV1 := 0.0; FCurrV := 0.0; FCurrVavg := 0.0;
    FCurrW0 := 0.0; FCurrW1 := 0.0; FCurrW := 0.0;
    FCurrDt0Sec          := 0;
    FCurrDt1Sec          := Autos[ANextBlockAutoIndex].FCurrDt1Sec;
    FCurrDtReqSec        := FCurrDt1Sec;
    FCurrState           := asWaiting;
    FCurrGx              := 0.0;
    FCurrGxReq           := DefineAydarGx_(AAuto,0.0,0.0,0.0,FCurrDt1Sec);
  end;{with}
end;{DefineAutosUhozhuVProstoy_}
//���������� �������������(��������) ���������� �������� �� ������ ���������� �������
procedure TDispatcher.DefineLoadingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
var
  cIndex : Integer;              //������ ���������� ��������
  AErrMsg: String;               //������ ��� ������ ��������
  APunkt : TesaLoadingPunkt;     //����� ��������
  ARock  : TesaLoadingPunktRock; //��������� ��
  pState : TPunktState;          //��������� ������
  ADir   : TAutoDirection;       //����������� ����
  APos   : TAutoPosition;        //��������� ����
  AState : TAutoState;           //��������� ����
  AIndent: Single;               //���������� ����� ���� �� ��� ������ �� ������ ������, m
  //
  tmp_auto_name: string;
  _a: TesaAuto;
begin
  with AAuto do
  begin
    ADir   := FCurrDirection;
    APos   := FCurrPosition;
    AState := FCurrState;
    //1. ���������� dT ������� ----------------------------------------------------------------
    if dTsec>FCurrDt1Sec then dTsec := FCurrDt1Sec;//�� ������ ��������
    FCurrDt0Sec := FCurrDt0Sec+dTsec;//������
    FCurrDt1Sec := FCurrDt1Sec-dTsec;//��������
    FCurrGx       := FCurrGxReq*FCurrDt0Sec/FCurrDtReqSec;
    //2. ����������? --------------------------------------------------------------------------
    if FCurrDt1Sec<1 then
    begin
      //$����� ��������
      Events.Loading(FCurrGxReq,FCurrDtReqSec,LoadingPunkts[FCurrPunktIndex]);
      //�������� ������ �������� --------------------------------------------------------------
      APunkt                  := LoadingPunkts[FCurrPunktIndex];
      pState                  := APunkt.FCurrState;
      APunkt.FSumDTsec[pState]:= APunkt.FSumDTsec[pState]+FCurrDtReqSec;
      APunkt.FSumAutoCount    := APunkt.FSumAutoCount+1;
      APunkt.FCurrState       := psManeuver;//� ����� ����� ���������
      //��
      ARock := APunkt.Rocks[FCurrRockLoadingPunktRockIndex];
      ARock.AddShiftFactRock(FCurrRockVolumeRequired.Vm3,FCurrRockVolumeRequired.Qtn);
//      if ARock.RemainingRockVm3<0.001 {!}
//      then SendWarningMsg(Format('�� �� %s ����������� �� %s',[APunkt.Name,ARock.Rock.Name]));

      //$����� ��������
      APunkt.Excavator.Events.Loading(FCurrDtReqSec,ARock.Rock,FCurrRockVolumeRequired,AAuto);

      //�������� � �������� ����
      AppendResultLoadingPunkt(FCurrPunktIndex);
      //��������� ���� ------------------------------------------------------------------------
      //��������� ����������
      FSumRocksVm3                := FSumRocksVm3;
      FSumRocksQtn                := FSumRocksQtn;
      FSumDSmtr[ADir,APos,AState] := FSumDSmtr[ADir,APos,AState]+0.0;
      FSumDTsec[ADir,APos,AState] := FSumDTsec[ADir,APos,AState]+FCurrDtReqSec;
      FSumGXltr[ADir,APos,AState] := FSumGXltr[ADir,APos,AState]+FCurrGxReq;
      FSumTripsCount[ADir]        := FSumTripsCount[ADir]+1;
      //��� ���� � ����� � ������?
      FCurrRockLoadingPunktIndex     := FCurrPunktIndex;
      FCurrRockLoadingPunktRockIndex := FCurrRockLoadingPunktRockIndex;
      FCurrRock.Id_Rock              := ARock.Rock.Id_Rock;
      FCurrRock.Name                 := ARock.Rock.Name;
      FCurrRock.IsMineralWealth      := ARock.Rock.IsMineralWealth;
      FCurrRockVolume                := FCurrRockVolumeRequired;
      FCurrRockContent               := ARock.Content;
      FCurrRockVolumeRequired        := esaRockVolume();{?}
      //$ ����� ��������
      //��������� �������
      cIndex := DefineAutosCourse(AAuto,AErrMsg);
      if cIndex=-1 then
      begin//���� �� ��������� �������
        FCurrState := asAbort; SendWarningMsg(AErrMsg);
        //$ ������ ������
      end{if}
      else
      begin//���� ��������� �������
        //������� ����-������� �������, ������� ����� ������ ������ ����
        //$ ������ �������
        FCurrCourseIndex      := cIndex;
        FCurrCourseBlockIndex := 0;
        FCurrPunktIndex       := -1;
        FCurrState            := asMovingFk;
        FCurrDirection        := adLoading;
        FCurrPosition         := apManeuverFromPunkt0;
        FCurrPoint            := FCurrPoint;
        DefineMovingAutosRequredParams_(AAuto,0.0,FCurrDirection);

        if CurrBlock.Block.StripsN=1 then
          AIndent := CurrBlock.Block.StripWm*0.25
        else
          AIndent := CurrBlock.Block.StripWm*0.5;
        FCurrIndentPoint := FCurrPoint;
        DefineAutosIndent(CurrBlock.Point0,
                          CurrBlock.Point1,
                          AIndent,
                          CurrBlock.Lm,
                          FCurrIndentPoint,
                          FCurrAzimut,FCurrZenit);
      end;{else}
    end;{else}
  end;{with}
end;{DefineLoadingAutosGoBy}
//���������� �������������(���������) ���������� �������� �� ������ ���������� �������
procedure TDispatcher.DefineUnLoadingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
var
  ACourse : TesaCourse;
  ABlock  : TesaCourseBlock;
  cIndex,I: Integer;               //������ ���������� ��������
  AErrMsg : String;                //������ ��� ������ ��������
  APunkt  : TesaUnLoadingPunkt;    //����� ��������
  ARock   : TesaUnLoadingPunktRock;//��������� ��
  pState  : TPunktState;           //��������� ������
  ADir    : TAutoDirection;        //����������� ����
  APos    : TAutoPosition;         //��������� ����
  AState  : TAutoState;            //��������� ����
  AIndent : Single;               //���������� ����� ���� �� ��� ������ �� ������ ������, m
  AContent: Single;
  //
  tmp_auto_name: string;
  _a: TesaAuto;
begin
  with AAuto do
  begin
    ADir := FCurrDirection; APos := FCurrPosition; AState := FCurrState;
    //1. ����������� dT ������� ---------------------------------------------------------------
    if dTsec>FCurrDt1Sec then
      dTsec := FCurrDt1Sec;//�� ������ ��������
    FCurrDt0Sec := FCurrDt0Sec+dTsec; FCurrDt1Sec := FCurrDt1Sec-dTsec;
    FCurrGx       := FCurrGxReq*FCurrDt0Sec/FCurrDtReqSec;
    ACourse := nil;
    //2. �����������? -------------------------------------------------------------------------
    if FCurrDt1Sec<1 then
    begin
      //$����� ���������
      Events.UnLoading(FCurrGxReq,FCurrDtReqSec,FCurrRock,FCurrRockVolume,UnLoadingPunkts[FCurrPunktIndex]);
      //Auto-----------------------------------------------------------------------------------
      FSumRocksVm3                := FSumRocksVm3+FCurrRockVolume.Vm3;
      FSumRocksQtn                := FSumRocksQtn+FCurrRockVolume.Qtn;
      FSumDSmtr[ADir,APos,AState] := FSumDSmtr[ADir,APos,AState]+0.0;
      FSumDTsec[ADir,APos,AState] := FSumDTsec[ADir,APos,AState]+FCurrDtReqSec;
      FSumGXltr[ADir,APos,AState] := FSumGXltr[ADir,APos,AState]+FCurrGxReq;
      FSumTripsCount[ADir]        := FSumTripsCount[ADir]+1;
      //$ ����� ���������
      //��������� �������
      cIndex := DefineAutosCourse(AAuto,AErrMsg);
      if cIndex=-1 then
      begin//���� �� ��������� �������
        FCurrState := asAbort;
        SendWarningMsg(AErrMsg);
        ABlock := nil;
        //$ ������ ������
      end{if}
      else
      begin//���� ��������� �������
        ACourse := Courses[cIndex];
        if ACourse.Kind=ckCourseUP_SP then
          ABlock:= ACourse.First //���� ������������ �� ���
        else
          ABlock:= ACourse.Last; //���� ����� �� �������� �� ��
      end;{else}
      //����� ���������
      APunkt := UnLoadingPunkts[FCurrPunktIndex];
      pState := APunkt.FCurrState;
      APunkt.FSumDTsec[pState] := APunkt.FSumDTsec[pState]+FCurrDtReqSec;
      AContent := 0.0;
      for I := 0 to APunkt.FCount-1 do
        if APunkt[I].Rock.Id_Rock=Rock.Id_Rock then
        begin
          ARock := APunkt.Rocks[I];
          ARock.FCurrContent :=(ARock.FCurrRockVolume.Vm3*ARock.FCurrContent+
                                FCurrRockVolume.Vm3*FCurrRockContent)/(ARock.FCurrRockVolume.Vm3+FCurrRockVolume.Vm3);
          ARock.FCurrRockVolume := esaSum(ARock.FCurrRockVolume,FCurrRockVolume);
          ARock.FSumAutoCount:= ARock.FSumAutoCount+1;
          AContent := ARock.FCurrContent;
          Break;
        end;
      //$����� ��������
      APunkt.Events.UnLoading(FCurrDtReqSec,Rock,FCurrRockVolume,AContent,AAuto);
      if cIndex>-1 then//���������� ��
        if ((ACourse.Kind<>ckCourseUP_SP)and(ABlock.LeftAutoIndex=-1))OR
           ((ACourse.Kind=ckCourseUP_SP)and(ABlock.RightAutoIndex=-1)) then
          Dec(APunkt.FCurrAutoCount);//���������� ��

      if APunkt.FCurrAutoCount=0 then
        APunkt.FCurrState  := psManeuver;//� ����� ����� ����-���
      //$ ������ �������
      AppendResultUnLoadingPunkt(FCurrPunktIndex);//������ � �������� ����
      //Auto
      //��� ���� � ����� � ������?
      FCurrRockLoadingPunktIndex:= -1;  FCurrRockLoadingPunktRockIndex := -1;
      FCurrRock.Id_Rock := 0;
      FCurrRock.Name := '';
      FCurrRock.IsMineralWealth := False;
      FCurrRockVolume     := esaRockVolume(); FCurrRockContent    := 0.0;
      FCurrRockVolumeRequired:= esaRockVolume();

      if cIndex>-1 then//���� ��������� �������
        if FCurrTsecNaryad<FShiftTsec-Openpit.Shift.TurnoverTmin*60 then
        begin//����� ����� �� �����������
          if ABlock.LeftAutoIndex=-1 then
          begin//����.�� ��������, ����� ��
            //$ ������ ��������
            FCurrCourseIndex := cIndex;       FCurrCourseBlockIndex := Courses[cIndex].FCount-1;
            FCurrPunktIndex  := -1;           FCurrState            := asMovingFk;
            FCurrDirection   := adUnLoading;  FCurrPosition         := apManeuverFromPunkt0;{?}
            FCurrPoint       := FCurrPoint;
            ABlock.LeftAutoIndex := AutoIndex;
            DefineMovingAutosRequredParams_(AAuto,0.0,FCurrDirection);

            FCurrIndentPoint := FCurrPoint;
            if CurrBlock.Block.StripsN=1
            then AIndent := CurrBlock.Block.StripWm*0.25
            else AIndent := CurrBlock.Block.StripWm*0.5;
            DefineAutosIndent(CurrBlock.Point1,
                              CurrBlock.Point0,
                              AIndent,CurrBlock.Lm,FCurrIndentPoint,FCurrAzimut,FCurrZenit);
          end{if}
          else//����.�� �����
          begin//���� � �������
            if (FCurrPosition = apOnPunkt1) and (FCurrDirection = adLoading) then
            begin
              FCurrCourseIndex:= cIndex;
              FCurrCourseBlockIndex:= Courses[cIndex].FCount-1;
              FCurrPunktIndex:= -1;
              FCurrPoint:= FCurrPoint;

              FCurrDirection:= adUnLoading;
              FCurrPosition:= apManeuverFromPunkt0;{?}
            end;

            FCurrState   := asWaiting;
            FCurrV0 := 0.0; FCurrV1 := 0.0; FCurrV := 0.0; FCurrVavg := 0.0;
            FCurrDt0Sec  := 0;
            FCurrW0 := 0.0; FCurrW1 := 0.0; FCurrW := 0.0;
            FCurrDt1Sec  := Autos[ABlock.LeftAutoIndex].FCurrDt1Sec;
            FCurrDtReqSec:= FCurrDt1Sec;
            FCurrGx      := 0.0; FCurrGxReq:= DefineAydarGx_(AAuto,0.0,0.0,0.0,FCurrDt1Sec);
          end;{else}
        end{if}
        else
        begin//����� ����� ����������� (����������� �� ���)
          if ABlock.RightAutoIndex=-1 then
          begin//����.�� ��������, ����� ��
            //$ ������ ��������
            FCurrCourseIndex := cIndex;       FCurrCourseBlockIndex := 0;
            FCurrPunktIndex  := -1;           FCurrState            := asMovingFk;
            FCurrDirection   := adToSP;      FCurrPosition          := apManeuverFromPunkt0;{?}
            FCurrPoint       := FCurrPoint;
            ABlock.RightAutoIndex := AutoIndex;
            DefineMovingAutosRequredParams_(AAuto,0.0,FCurrDirection);

            FCurrIndentPoint := FCurrPoint;
            if CurrBlock.Block.StripsN=1
            then AIndent := CurrBlock.Block.StripWm*0.25
            else AIndent := CurrBlock.Block.StripWm*0.5;
            DefineAutosIndent(CurrBlock.Point0,
                              CurrBlock.Point1,
                              AIndent,CurrBlock.Lm,FCurrIndentPoint,FCurrAzimut,FCurrZenit);
          end{if}
          else//����.�� �����
          begin//���� � �������
            FCurrState   := asWaiting;
            FCurrV0 := 0.0; FCurrV1 := 0.0; FCurrV := 0.0; FCurrVavg := 0.0;
            FCurrW0 := 0.0; FCurrW1 := 0.0; FCurrW := 0.0;
            FCurrDt0Sec:= 0;
            FCurrDt1Sec  := Autos[ABlock.RightAutoIndex].FCurrDt1Sec;
            FCurrDtReqSec:= FCurrDt1Sec;
            FCurrGx      := 0.0;        FCurrGxReq:= DefineAydarGx_(AAuto,0.0,0.0,0.0,FCurrDt1Sec);
          end;{else}
        end;{else}
    end;{else}
  end;{with}
end;{DefineUnUnLoadingAutosGoBy}
//���������� �������������(�������) ���������� �������� �� ������ ���������� ������� {85 L}
procedure TDispatcher.DefineWaitingAutosGoBy_(AAuto: TesaAuto; dTsec,ACurrTsecNaryad: Integer);
  procedure UpdateWaitingParams(const iBadAuto: Integer);
  begin//��������: ����� ��� �����?
    AAuto.FCurrDtReqSec := Autos[iBadAuto].FCurrDt1Sec;
    AAuto.FCurrDt0Sec   := 0;      AAuto.FCurrDt1Sec := AAuto.FCurrDtReqSec;
    AAuto.FCurrGxReq    := DefineAydarGx_(AAuto,0.0,0.0,0.0,AAuto.FCurrDt1Sec);
    AAuto.FCurrGx     := 0.0;
  end;{UpdateWaitingParams}
var
  iBlock0,iBlock1,iBadAuto,I: Integer;
  APos    : TAutoPosition;
  AState  : TAutoState;
  ADir    : TAutoDirection;
  APunkt  : TesaUnLoadingPunkt;
  eDir    : TesaResultAutoEventDirection;
  AAutoIndex: Integer;
  //
  _cut_sec: integer;
  tmp_auto_name: string;
begin
  with AAuto do
  begin
    _cut_sec:= 0;
    if dTsec > FCurrDt1Sec then//�� ������ ��������
    begin
      _cut_sec:= dTsec - FCurrDt1Sec;
      dTsec:= FCurrDt1Sec;
    end;
    APos := FCurrPosition; ADir := FCurrDirection; AState := FCurrState;
    //1.���������� ��� dT ������� -------------------------------------------------------------
    FCurrDt0Sec := FCurrDt0Sec+dTsec;  FCurrDt1Sec := FCurrDt1Sec-dTsec;
    FCurrGx       := FCurrGxReq*FCurrDt0Sec/FCurrDtReqSec;
    //2. ����� �������� �����������? ----------------------------------------------------------
    if FCurrDt1Sec<1 then
    begin
      //��������� ���������� ����
      FSumDTsec[ADir,APos,AState] := FSumDTsec[ADir,APos,AState] + FCurrDtReqSec;
      FSumGXltr[ADir,APos,AState] := FSumGXltr[ADir,APos,AState] + FCurrGxReq;
//      if (ADir=adLoading)and((APos=apManeuverToPunkt1)or(APos=apOnPunkt1)) then
      if ((ADir=adLoading)and(APos=apManeuverToPunkt1)) then
      begin//2.1.������ ������� ������� �� ��?-------------------------------------------------
        APunkt := UnLoadingPunkts[CurrCourse.FPunktIndex1];
        if (ADir<>adLoading)OR //������ ������ ��������, ��� ����, ��� ���������� �� ������.��
           ((ADir=adLoading)and(APunkt.FCurrAutoCount<APunkt.FAutoMaxCount))then //��
        begin//2.1.1.��/��/��� �����������-----------------------------------------------------
          //$ ����� �������
          eDir := edNone;
          case FCurrDirection of
            adLoading: eDir := edLoading;
            adUnLoading: eDir := edUnLoading;
            adFromSP,adToSP: eDir := edNulled;
          end;
          Events.Waiting(FCurrGxReq, FCurrDt0Sec + _cut_sec, eDir, FCurrRock, FCurrRockVolume,
            CurrCourse.Punkt1, CurrCourse.Punkt0);
          DefineAutosEmptyCurrBlock_(AAuto);//���������� ���.��
          DefineAutosPlacePunkt_(AAuto,ACurrTsecNaryad);    //������� ����.�����
        end{if}
        else
        begin//2.1.2.�� �� �����������---------------------------------------------------------
          //������ ������ ����, �-�� ������ ������� �������� ��������������
          iBadAuto := -1;
          for I := 0 to Autos.Count-1 do
            if Autos[I].IsWorking then //������������ ��� ������� ����
            begin
              AAutoIndex := AAuto.AutoIndex;
              if I<>AAutoIndex then //������������ ��� ����, ����� �������
                if Autos[I].IsOnUnloadingPunkt then//��� ����, �-� ��� ����������
                  if Autos[I].CurrCourse.Punkt1.Id_Point=
                    CurrCourse.Punkt1.FId_Point then//��� ����, �-� �� ������ ��
                  begin
                    if iBadAuto=-1 then
                      iBadAuto := Autos[I].FAutoIndex
                    else
                      if Autos[iBadAuto].FCurrDt1Sec<Autos[I].FCurrDt1Sec then
                        iBadAuto := I;
                  end;
            end;
          if iBadAuto=-1 then
          begin//����� ��������� ������� �� �����������
            FCurrState := asAbort; {? ���������: �� ���������}
          end{if}
          else
          begin
            UpdateWaitingParams(iBadAuto);//�������� ����� ��� �����
          end;
        end;{else}
      end{if}
      else
      begin//2.2.������ ������� ������� �� ����.��---------------------------------------------
        //��������� ������ ���.��
        iBlock0 := FCurrCourseBlockIndex;
        //��������� ������ ����.��
        if FCurrPunktIndex<>-1 then//���� ���� ����� �� ������(�� ��� � �������)
        begin
          if ADir=adUnLoading                      //���� ������.�����������,
          then iBlock1 := CurrCourse.Count-1       //�� ��������� �� ��������,
          else iBlock1 := 0;                       //����� ������ �� ��������
        end{if}
        else                   //���� ���� �� ����� �� ������
          if ADir<>adUnLoading then
            iBlock1 := iBlock0+1
          else
            iBlock1 := iBlock0-1;
        //������ "�������" ����
        if ADir<>adUnLoading then
          iBadAuto := CurrCourse[iBlock1].RightAutoIndex
        else
          iBadAuto := CurrCourse[iBlock1].LeftAutoIndex;
        if iBadAuto=-1 then
        begin                                            //����.�� �����������
          //$ ����� �������
          eDir := edNone;
          case FCurrDirection of
            adLoading: eDir := edLoading;
            adUnLoading: eDir := edUnLoading;
            adFromSP: eDir := edNulled;
            adToSP: eDir := edNulled;
          end;{case}
          if FCurrDirection <> adUnLoading then
          begin
            Events.Waiting(FCurrGxReq,FCurrDt0Sec + _cut_sec,eDir,FCurrRock,
                           FCurrRockVolume,CurrCourse.Punkt0,CurrCourse.Punkt1);
          end
          else
          begin
            Events.Waiting(FCurrGxReq,FCurrDt0Sec + _cut_sec,eDir,FCurrRock,
                           FCurrRockVolume,CurrCourse.Punkt1,CurrCourse.Punkt0);
          end;
          if AAuto.FCurrCourseBlockIndex>-1 then
            DefineAutosEmptyCurrBlock_(AAuto);//���������� ������� ��
          DefineAutosPlaceNextBlock_(AAuto);     //������� ��������� ��
        end{if}
        else
        begin //����.�� ��� �� �����������
          Events.Waiting(FCurrGxReq,FCurrDt0Sec + _cut_sec,eDir,FCurrRock,
                         FCurrRockVolume,CurrCourse.Punkt1,
                         CurrCourse.Punkt0);

          UpdateWaitingParams(iBadAuto);
        end;
      end;{else}
    end;{if}
  end;{with}
end;{DefineWaitingAutosGoBy}
//���������� � �� ����������� ������������� �����
procedure TDispatcher.SaveTotalResults;
var
  i:integer;
  ExcvOreVm3, ExcvStrippingVm3: double;
begin
  FGauge.Visible := True;
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ����� �����������..');
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'SELECT * FROM Openpits WHERE Id_Openpit='+IntToStr(Openpit.Id_Openpit);
    Open;
    Edit;
    FieldByName('ResultStrippingCoef').AsFloat := FCurrStrippingCoef;
    FieldByName('ResultTnaryadSec').AsInteger := FCurrTsecNaryad;
    FieldByName('ResultPeriodCoef').AsFloat := Openpit.Period.Kshift;
     //@SEE added for NominalEconomicEffect

    Openpit.FCommon.PeriodCoef:=Openpit.Period.Kshift;
    Openpit.FCommon.CurrOreQtn:=FCurrOreQtn;
    Openpit.FCommon.CurrOreVm3:=FCurrOreVm3;
    Openpit.FCommon.CurrStrippingQtn:=FCurrStrippingQtn;
    Openpit.FCommon.CurrStrippingVm3:=FCurrStrippingVm3;
    
    if FCurrOreQtn > 0.0 then
      Openpit.FCommon.CurrStrippingCoef:= FCurrStrippingQtn/FCurrOreQtn;    
//      Openpit.FCommon.CurrStrippingCoef:= Openpit.LoadingPunkts.FPlannedStrippingCoefVm3;
//      Openpit.FCommon.CurrStrippingCoef:= FCurrStrippingVm3/FCurrOreVm3
    Post;
    Close;
  finally
    Free;
  end;
  //ResultShifts ---------------------------------------------------------------
  with TADOQuery.Create(nil) do
  try
    Connection := DBConnection;
    SQL.Text := 'DELETE FROM _ResultShifts';
    ExecSQL;
    SQL.Text := 'SELECT * FROM _ResultShifts';
    Open;
    Append;
    Openpit.FShift.NaryadTmin                  := FCurrTsecNaryad/60;
    FieldByName('Id_Openpit').AsInteger        := Openpit.Id_Openpit;
    FieldByName('ShiftNaryadTmin').AsFloat     := Openpit.Shift.NaryadTmin;
    FieldByName('ShiftTmin').AsInteger         := Openpit.Shift.Tmin;
    FieldByName('ShiftPeresmenkaTmin').AsFloat := Openpit.Shift.TurnoverTmin;
    FieldByName('ShiftKweek').AsFloat          := Openpit.Shift.ShiftTimeUsingCoef.Kweek;
    FieldByName('PeriodKshift').AsFloat        := Openpit.Period.Kshift;
    FieldByName('PeriodTday').AsInteger        := Openpit.Period.Tday;
    FieldByName('DollarCtg').AsFloat           := Openpit.Common.DollarCtg;
    FieldByName('ExpensesYearC1000tg').AsFloat := Openpit.Common.YearExpensesCtg*0.001;
    Post;
    FResultId_Shift := FieldByName('Id_ResultShift').AsInteger;
    Close;
  finally
    Free;
  end;
  Variant.Append(Openpit.Name,Openpit.Shift,Openpit.Period,Openpit.Common);
  FOpenpit.SendMessage('Ok');
end;

//���������� � �� ����������� ������������� �� ��������������
procedure TDispatcher.SaveAutosResultsNew;
const
  T = True; F = False;
  procedure _AddReport(const AQuery: TADOQuery; const AKind: Integer; const AItem: TesaResultAuto);
    procedure _Add(const q: TADOQuery; const ARecName: String; const AKey: ResaKeyParams; ANum: Single; const ADen: Single=-1.0); 
    var I: Integer;
    begin
      //������������� Value
      if not(ADen<0.0) then if ADen>0.0 then ANum := ANum/ADen else ANum := 0.0; 
      //��������� � ��
      q.Append;
      for I := 1 to q.Fields.Count-1 do
        q.Fields[I].Clear;
      q.FieldByName('Id_ResultShift').AsInteger          := ResultId_Shift;
      if AKind = 1
      then q.FieldByName('Id_ResultShiftAuto').AsInteger := AItem.Id_ResultShiftAuto;
      if AKind = 2
      then q.FieldByName('Id_DumpModel').AsInteger       := AItem.Id_DumpModel1;
      if AKind = 2     //������ 3?
      then q.FieldByName('DumpModel').AsString           := AItem.DumpModel;
      q.FieldByName('Kind').AsInteger                    := AKind;
      q.FieldByName('IsChangeable').AsBoolean            := AKey.IsChangeable;
      q.FieldByName('RecordNo').AsInteger                := AKey.No;
      q.FieldByName('RecordName').AsString               := ARecName;
      q.FieldByName('Name').AsString                     := AKey.Key;
      if ANum>-1.0
      then q.FieldByName('Value').AsFloat                := ANum;
      q.Post;
    end;{_Add}
  begin
    with AItem do
    begin
      //�������������� ���������
      _Add(AQuery,  'I',CesaAutosQuantity,-1.0);
      _Add(AQuery,  '1',CesaAutosAutosCount,AutosCount);
      _Add(AQuery,  '2',CesaAutosTripsCount,esaSummary(TripsCount));
      _Add(AQuery,  '3',CesaAutosTripsCountNulled,TripsCount.Nulled);
      _Add(AQuery,  '4',CesaAutosTripsCountLoading,TripsCount.Loading);
      _Add(AQuery,  '5',CesaAutosTripsCountUnLoading,TripsCount.UnLoading);
      _Add(AQuery,  '6',CesaAutosRock,-1.0);
      _Add(AQuery,  '7',CesaAutosRockVm3,RockVolume.Vm3);
      _Add(AQuery,  '8',CesaAutosRockQtn,RockVolume.Qtn);
      _Add(AQuery,  '9',CesaAutosSkm,esaSummary(Sm),1000);
      _Add(AQuery, '10',CesaAutosSkmNulled,Sm.Nulled,1000);
      _Add(AQuery, '11',CesaAutosSkmLoading,Sm.Loading,1000);
      _Add(AQuery, '12',CesaAutosSkmUnLoading,Sm.UnLoading,1000);
      _Add(AQuery, '13',CesaAutosLoadingSkm,Sm.Loading,1000);
      _Add(AQuery, '14',CesaAutosLoadingWAvgSkm,WAvgSkmLoading.Num,WAvgSkmLoading.Den);
      _Add(AQuery, '15',CesaAutosLoadingAvgSkm,Sm.Loading*0.001,TripsCount.Loading);
      _Add(AQuery, '16',CesaAutosWAvgHm,WAvgHm.Num,WAvgHm.Den);
      _Add(AQuery, '17',CesaAutosShiftAvgSkm1,esaSummary(Sm)*0.001,AutosCount);
      _Add(AQuery, '18',CesaAutosShiftAvgSkm_reis,esaSummary(Sm)*0.001,esaSummary(TripsCount));
      _Add(AQuery, '19',CesaAutosAvgVkmh,AvgVkmh.Num,AvgVkmh.Den);
      _Add(AQuery, '20',CesaAutosAvgVkmhNulled,AvgVkmhNulled.Num,AvgVkmhNulled.Den);
      _Add(AQuery, '21',CesaAutosAvgVkmhLoading,AvgVkmhLoading.Num,AvgVkmhLoading.Den);
      _Add(AQuery, '22',CesaAutosAvgVkmhUnLoading,AvgVkmhUnLoading.Num,AvgVkmhUnLoading.Den);
      _Add(AQuery, '23',CesaAutosAvgTechVkmh,3.6*esaSummary(Sm),esaSummary(Tsec)-Tsec.Waiting);
      //������ �������
      _Add(AQuery, 'II',CesaAutosFuel,-1.0);
      _Add(AQuery,  '1',CesaAutosGx,esaSummary(Gx));
      _Add(AQuery,  '2',CesaAutosGxWork,Gx.Work);
      _Add(AQuery,  '3',CesaAutosGxWaiting,Gx.Waiting);
      _Add(AQuery,  '4',CesaAutosDirGx,esaSummary(DirGx));
      _Add(AQuery,  '5',CesaAutosGxNulled,DirGx.Nulled);
      _Add(AQuery,  '6',CesaAutosGxLoading,DirGx.Loading);
      _Add(AQuery,  '7',CesaAutosGxUnLoading,DirGx.UnLoading);
      _Add(AQuery,  '8',CesaAutosUdGx_gr_tkm,UdGx_gr_tkm,-1.0);
      _Add(AQuery,  '9',CesaAutosGxCtg,esaSummary(SumGxCtg));
      //�����
      _Add(AQuery,'III',CesaAutosWorkTime,-1.0);
      _Add(AQuery,  '1',CesaAutosTmin,esaSummary(Tsec),60);
      _Add(AQuery,  '2',CesaAutosTminMoving,Tsec.Moving,60);
      _Add(AQuery,  '3',CesaAutosTminWaiting,Tsec.Waiting,60);
      _Add(AQuery,  '4',CesaAutosTminManevr,Tsec.Manevr,60);
      _Add(AQuery,  '5',CesaAutosTminOnLoading,Tsec.OnLoading,60);
      _Add(AQuery,  '6',CesaAutosTminOnUnLoading,Tsec.OnUnLoading,60);
      _Add(AQuery,  '7',CesaAutosDirTmin,esaSummary(DirTsec),60);
      _Add(AQuery,  '8',CesaAutosTminNulled,DirTsec.Nulled,60);
      _Add(AQuery,  '9',CesaAutosTminLoading,DirTsec.Loading,60);
      _Add(AQuery, '10',CesaAutosTminUnLoading,DirTsec.UnLoading,60);
      _Add(AQuery, '11',CesaAutosReysAvgTmin,esaSummary(DirTsec),60*esaSummary(TripsCount));
      _Add(AQuery, '12',CesaAutosReysAvgTminNulled,DirTsec.Nulled,60*TripsCount.Nulled);
      _Add(AQuery, '13',CesaAutosReysAvgTminLoading,DirTsec.Loading,60*TripsCount.Loading);
      _Add(AQuery, '14',CesaAutosReysAvgTminUnLoading,DirTsec.UnLoading,60*TripsCount.UnLoading);
      _Add(AQuery, '15',CesaAutosAvgTimeUsingCoef,esaSummary(Tsec)-Tsec.Waiting,esaSummary(Tsec));
      //����
      _Add(AQuery, 'IV',CesaAutosTyres,-1.0);
      if AKind=1 then
      begin
        _Add(AQuery,'1',CesaAutosTyresCount,FAuto.Model.TyresCount);
        _Add(AQuery,'2',CesaAutosTyresAmortizationR1000km,FAuto.TyresAmortizationR1000km);
        _Add(AQuery,'3',CesaAutosTyreC1000tg,FAuto.FTyreC1000tg);
      end{if}
      else
      begin
        _Add(AQuery,'1',CesaAutosTyresCount,-1.0);
        _Add(AQuery,'2',CesaAutosTyresAmortizationR1000km,-1.0);
        _Add(AQuery,'3',CesaAutosTyreC1000tg,-1.0);
      end;{else}
      _Add(AQuery,  '4',CesaAutosTyresS1000km,esaSummary(Sm),1E6); //������, ���.��
      _Add(AQuery,  '5',CesaAutosUsedTyresCount,UsedTyresCount);
      _Add(AQuery,  '6',CesaAutosTyresCtg,SumTyresCtg);
      //����������� ���������
      _Add(AQuery,  'V',CesaAutosCosts,-1.0);
      _Add(AQuery,  '1',CesaAutosWorkCtg,SumExploatationCtg.Work);
      _Add(AQuery,  '2',CesaAutosWorkSumGxCtg,SumGxCtg.Work);
      _Add(AQuery,  '3',CesaAutosWorkSumTyresCtg,SumTyresCtg);
      _Add(AQuery,  '4',CesaAutosWorkSparesCtg,SumSparesGxCtg.Work);
      _Add(AQuery,  '5',CesaAutosWorkMaterialsCtg,SumMaterialsGxCtg.Work);
      _Add(AQuery,  '6',CesaAutosWorkMaintenancesCtg,SumMaintenanceCtg.Work);
      _Add(AQuery,  '7',CesaAutosWorkSalariesCtg,SumSalaryCtg.Work);
      _Add(AQuery,  '8',CesaAutosWaitingCtg,SumExploatationCtg.Waiting);
      _Add(AQuery,  '9',CesaAutosWaitingSumGxCtg,SumGxCtg.Waiting);
      _Add(AQuery, '10',CesaAutosWaitingSparesCtg,SumSparesGxCtg.Waiting);
      _Add(AQuery, '11',CesaAutosWaitingMaterialsCtg,SumMaterialsGxCtg.Waiting);
      _Add(AQuery, '12',CesaAutosWaitingMaintenancesCtg,SumMaintenanceCtg.Waiting);
      _Add(AQuery, '13',CesaAutosWaitingSalariesCtg,SumSalaryCtg.Waiting);
      _Add(AQuery, '14',CesaAutosAmortizationCtg,SumAmortizationCtg);
      _Add(AQuery, '15',CesaAutosCtg,SumExploatationCtg.Work+SumExploatationCtg.Waiting+SumAmortizationCtg);
    end;{with}
  end;{_AddReport}
var
  quEvents       : TADOQuery;
  quAutos        : TADOQuery;
  quReps         : TADOQuery;
  _E             : TesaResultAutoEvent;
  I,J,K          : Integer;
  _Models        : TesaResultAutoModels;
  _A             : TesaResultAuto;
  _LoadingSm     : Single;//���������� ���������� �� ������� �������� ��������, �
  _LoadingPunktHm: Single;//������ ������� �� ������� �������� ��������, �
  ADirPrior,ADirNext: TesaResultAutoEventDirection;//���������� � ��������� �����������
  AShiftsCount   : Single;//���������� ���� � ������
  AAutos         : String;  //������ ����
  AAutosCount0   : Integer; //���������� ���� � �������/��������� ���������
  AAutosCount1   : Integer; //���������� ���� � �������/��������� ���������
  ATyresCount    : Integer; //���������� ���� ���
begin
  if ResultId_Shift<1 then Exit;
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ��������������..');
  AShiftsCount := 24*60/Openpit.Shift.Tmin;
  quAutos := TADOQuery.Create(nil);
  quAutos.Connection := DBConnection;
  quAutos.SQL.Text := 'SELECT * FROM _ResultShiftAutos';
  quEvents := TADOQuery.Create(nil);
  quEvents.Connection := DBConnection;
  quEvents.SQL.Text := 'SELECT * FROM _ResultShiftAutoEvents';

  //----------------------------------------------------------------------------
  // I. �������� ��� ������, �������� �������������, ������� 
  //----------------------------------------------------------------------------
  _Models := TesaResultAutoModels.Create(Self);
  try
    quAutos.Open;
    quEvents.Open;
//=======================================================================================================
    FGauge.MaxValue := Autos.Count;
    for I := 0 to Autos.Count-1 do
    begin
      SetGaugeValue(I);
      
      //�������� ������������ --------------------------------------------------
      quAutos.Append;
      quAutos.FieldByName('Id_ResultShift').AsInteger             := ResultId_Shift;
      quAutos.FieldByName('Id_DumpModel').AsInteger               := Autos[I].Model.Id_Auto;
      quAutos.FieldByName('DumpModel').AsString                   := Autos[I].Model.Name;
      quAutos.FieldByName('DumpNo').AsInteger                     := Autos[I].FParkNo;
      quAutos.FieldByName('DumpYear').AsInteger                   := Autos[I].FAYear;
      quAutos.FieldByName('DumpPtn').AsFloat                      := Autos[I].Model.Ptn;
      quAutos.FieldByName('DumpQtn').AsFloat                      := Autos[I].FFactTonnage;
      quAutos.FieldByName('DumpMaxTsec').AsFloat                  := Autos[I].Model.MaxTsec;
      quAutos.FieldByName('DumpMaxNkVt').AsFloat                  := Autos[I].Model.EngineMaxNkVt;
      quAutos.FieldByName('DumpC1000tg').AsFloat                  := Autos[I].FC1000tg;
      quAutos.FieldByName('DumpAmortizationKind').AsInteger       := Integer(Autos[I].FAmortizationKind);
      quAutos.FieldByName('DumpAmortizationRate').AsFloat         := Autos[I].FAmortizationRate;
      quAutos.FieldByName('DumpTyresN').AsInteger                 := Autos[I].Model.TyresCount;
      quAutos.FieldByName('DumpTyreC1000tg').AsFloat              := Autos[I].FTyreC1000tg;
      quAutos.FieldByName('DumpTyresAmortizationR1000km').AsFloat := Autos[I].TyresAmortizationR1000km;
      quAutos.FieldByName('DumpTransmissionKPD').AsFloat          := Autos[I].FTransmissionKPD;
      quAutos.FieldByName('DumpEngineKPD').AsFloat                := Autos[I].FEngineKPD;
      quAutos.FieldByName('DumpWorkState').AsBoolean              := Autos[I].FWorkState;
      quAutos.Post;
      //�������� ������������ --------------------------------------------------
      _A                     := TesaResultAuto.Create(Self);
      _A.FAuto               := Autos[I];
      _A.FId_ResultShift     := ResultId_Shift;
      _A.FId_ResultShiftAuto := quAutos.FieldByName('Id_ResultShiftAuto').AsInteger;
      _A.FId_DumpModel1      := Autos[I].Model.Id_Auto;
      _A.FDumpModel          := Autos[I].Model.Name;
      _A.FLoadingSkmRockQtn  := 0.0;
      //������� ----------------------------------------------------------------
      _LoadingSm := 0.0;
      _LoadingPunktHm := 0.0;
      ADirPrior := edNone;
      ADirNext  := edNone;
      for J := 0 to Autos[I].Events.Count-1 do
      begin
        _E := Autos[I].Events[J];
        if J>0 then ADirPrior := Autos[I].Events[J-1].Direction;
        if J<Autos[I].Events.Count-1 then ADirNext := Autos[I].Events[J+1].Direction;
        //�������� ������� -----------------------------------------------------
        quEvents.Append;
        for K := 1 to quEvents.Fields.Count-1 do
          quEvents.Fields[K].Clear;
        quEvents.FieldByName('Id_ResultShiftAuto').AsInteger :=
          quAutos.FieldByName('Id_ResultShiftAuto').AsInteger;
        quEvents.FieldByName('Kind').AsInteger := Integer(_E.Kind);
        if _E.Direction<>edNone
        then quEvents.FieldByName('Direction').AsInteger := Integer(_E.Direction);
        if _E.FKind in [ekMoving,ekManevr]
        then quEvents.FieldByName('Sm').AsFloat := _E.Sm;
        quEvents.FieldByName('Tmin').AsFloat := _E.Tsec/60;
        quEvents.FieldByName('Gx').AsFloat := _E.Gx;
        if _E.IdPunkt0>0
        then quEvents.FieldByName('Id_Punkt0').AsInteger := _E.IdPunkt0;
        if _E.Kind in [ekLoadingPunkt,ekUnLoadingPunkt,ekATC]
        then quEvents.FieldByName('Horizont0').AsFloat := _E.FHorizont0;
        if _E.IdPunkt1>0
        then quEvents.FieldByName('Id_Punkt1').AsInteger := _E.IdPunkt1;
        if _E.Kind in [ekLoadingPunkt,ekUnLoadingPunkt,ekATC]
        then quEvents.FieldByName('Horizont1').AsFloat := _E.FHorizont1;
        //��������� ������ _SumLoadingSm
        if (_E.FKind in [ekMoving,ekManevr])and(_E.Direction = edLoading) then
        begin
          _LoadingSm := _LoadingSm + _E.Sm;
          _A.FLoadingSkmRockQtn := _A.FLoadingSkmRockQtn+_E.Sm*0.001*_E.RockVolume.Qtn;
        end;{if}
        if _E.FKind = ekLoadingPunkt then _LoadingPunktHm := _E.Horizont1;
        if _E.Kind = ekUnLoadingPunkt then
        begin
          if _E.Id_Rock>0
          then quEvents.FieldByName('Id_Rock').AsInteger        := _E.Id_Rock;
          if _E.Id_Rock>0
          then quEvents.FieldByName('Rock').AsString            := _E.Rock;
          quEvents.FieldByName('RockIsMineralWealth').AsBoolean := _E.RockIsMineralWealth;
          quEvents.FieldByName('RockVm3').AsFloat               := _E.RockVolume.Vm3;
          quEvents.FieldByName('RockQtn').AsFloat               := _E.RockVolume.Qtn;
          quEvents.FieldByName('RockQua').AsFloat               := _E.RockVolume.Qua; {dwd}
          quEvents.FieldByName('Excv').AsFloat                  := _E.RockVolume.Excv;

          quEvents.FieldByName('WAvgLoadingSkmNum').AsFloat     := _LoadingSm*0.001*_E.RockVolume.Qtn;
          quEvents.FieldByName('WAvgLoadingSkmDen').AsFloat     := _E.RockVolume.Qtn;
          quEvents.FieldByName('WAvgHmNum').AsFloat             := abs(_E.Horizont1-_LoadingPunktHm)*_E.RockVolume.Qtn;
          quEvents.FieldByName('WAvgHmDen').AsFloat             := _E.RockVolume.Qtn;
        end;{if}
        if _E.Kind in [ekMoving,ekManevr] then
        begin
          quEvents.FieldByName('AvgVkmhNum').AsFloat            := _E.AvgVkmh.Num;
          quEvents.FieldByName('AvgVkmhDen').AsFloat            := _E.AvgVkmh.Den;
        end;{if}
        quEvents.Post;

        //-----------------------------------------------------------------------------------------------
        //-----------------------------------------------------------------------------------------------
        //�������� �� �������� �������� ������ �� ������� ������������� ---------------------------------
        
        //���������� ������ -----------------------------------------------------------------------------
        if ((ADirPrior=edNulled)and(_E.Kind=ekLoadingPunkt))OR  //�������� � ���������� ������� �����������
           ((ADirNext =edNulled)and(_E.Kind=ekUnLoadingPunkt))  //��������� � ��������� ������� �����������
        then _A.FTripsCount.Nulled := _A.FTripsCount.Nulled + 1.0;
        if (ADirNext=edLoading)and(_E.Kind=ekLoadingPunkt)  //�������� � ��������� �������� �����������
        then _A.FTripsCount.Loading := _A.FTripsCount.Loading + 1.0;
        if (ADirNext=edUnLoading)and(_E.Kind=ekUnLoadingPunkt)  //��������� � ��������� ������������ �����������
        then _A.FTripsCount.UnLoading := _A.FTripsCount.UnLoading + 1.0;
        //������ ----------------------------------------------------------------------------------------
        if _E.Direction=edNulled then _A.FSm.Nulled := _A.FSm.Nulled + _E.Sm;//������� �����������
        if _E.Direction=edLoading then _A.FSm.Loading := _A.FSm.Loading + _E.Sm;//�������� �����������
        if _E.Direction=edUnLoading then _A.FSm.UnLoading := _A.FSm.UnLoading + _E.Sm;//������������ �����������
        //����� -----------------------------------------------------------------------------------------
        case _E.Kind of
          ekLoadingPunkt  : _A.FTsec.OnLoading   := _A.Tsec.OnLoading   + _E.Tsec;
          ekUnLoadingPunkt: _A.FTsec.OnUnLoading := _A.Tsec.OnUnLoading + _E.Tsec;
          ekWaiting       : _A.FTsec.Waiting     := _A.Tsec.Waiting     + _E.Tsec;
          ekMoving        : _A.FTsec.Moving      := _A.Tsec.Moving      + _E.Tsec;
          ekManevr        : _A.FTsec.Manevr      := _A.Tsec.Manevr      + _E.Tsec;
          ekATC,ekAbort   : _A.FTsec.Waiting     := _A.Tsec.Waiting     + _E.Tsec;
        end;{case}
        if (_E.Direction=edNulled)OR                           //������� �����������
           ((ADirPrior=edNulled)and(_E.Kind=ekLoadingPunkt))   //�������� � ���������� ������� �����������
        then _A.FDirTsec.Nulled := _A.DirTsec.Nulled + _E.Tsec;
        if (_E.Direction=edLoading)OR                          //�������� �����������
           (_E.Kind=ekUnLoadingPunkt)                          //���������
        then _A.FDirTsec.Loading := _A.DirTsec.Loading + _E.Tsec;
        if (_E.Direction=edUnLoading)OR                        //������������ �����������
           ((ADirPrior=edUnLoading)and(_E.Kind=ekLoadingPunkt))//�������� � ���������� ������������ �����������
        then _A.FDirTsec.UnLoading := _A.DirTsec.UnLoading + _E.Tsec;
        //���� ------------------------------------------------------------------------------------------
        if _E.Kind=ekUnLoadingPunkt //���������
        then _A.FRockVolume := esaSum(_A.RockVolume,_E.RockVolume);
        //������� ---------------------------------------------------------------------------------------
        if (_E.Direction=edNulled)OR                           //������� �����������
           ((ADirPrior=edNulled)and(_E.Kind=ekLoadingPunkt))   //�������� � ���������� ������� �����������
        then _A.FDirGx.Nulled := _A.DirGx.Nulled + _E.Gx;
        if (_E.Direction=edLoading)OR                          //�������� �����������
           (_E.Kind=ekUnLoadingPunkt)                          //���������
        then _A.FDirGx.Loading := _A.DirGx.Loading + _E.Gx;
        if (_E.Direction=edUnLoading)OR                        //������������ �����������
           ((ADirPrior=edUnLoading)and(_E.Kind=ekLoadingPunkt))//�������� � ���������� ������������ �����������
        then _A.FDirGx.UnLoading := _A.DirGx.UnLoading + _E.Gx;
        if _E.Kind<>ekWaiting then _A.FGx.Work    := _A.Gx.Work + _E.Gx;
        if _E.Kind=ekWaiting  then _A.FGx.Waiting := _A.Gx.Waiting + _E.Gx;
        //���������������� �������� ---------------------------------------------------------------------
        if _E.Kind=ekUnLoadingPunkt then//���������
        begin
          _A.FWAvgSkmLoading := esaSum(_A.WAvgSkmLoading,_LoadingSm*0.001*_E.RockVolume.Qtn,_E.RockVolume.Qtn);
          _A.FWAvgHm         := esaSum(_A.WAvgHm,abs(_E.Horizont1-_LoadingPunktHm)*_E.RockVolume.Qtn,_E.RockVolume.Qtn);
          //������� ��������� ������ _SumLoadingSm � _SumLoadingHm
          _LoadingSm            := 0.0;
          _LoadingPunktHm       := 0.0;
        end;{if}
        //������� �������� ------------------------------------------------------------------------------
        if (_E.Kind<>ekWaiting)and(_E.Direction in [edLoading,edUnLoading,edNulled])
        then _A.FAvgVkmh := esaSum(_A.AvgVkmh,_E.AvgVkmh);
        if (_E.Kind<>ekWaiting)and(_E.Direction=edNulled)
        then _A.FAvgVkmhNulled := esaSum(_A.AvgVkmhNulled,_E.AvgVkmh);
        if (_E.Kind<>ekWaiting)and(_E.Direction=edLoading)
        then _A.FAvgVkmhLoading := esaSum(_A.AvgVkmhLoading,_E.AvgVkmh);
        if (_E.Kind<>ekWaiting)and(_E.Direction=edUnLoading)
        then _A.FAvgVkmhUnLoading := esaSum(_A.AvgVkmhUnLoading,_E.AvgVkmh);
      end;{for}
      if Autos[I].TyresAmortizationR1000km>0.0 then
        _A.FUsedTyresCount:= Autos[I].Model.TyresCount*esaSummary(_A.Sm)*(1E-6)/Autos[I].TyresAmortizationR1000km;
      _A.FSumTyresCtg:= _A.UsedTyresCount * Autos[I].TyreC1000tg * 1000;
      _A.FSumGxCtg           := esaWorkValue(_A.Gx.Work*Openpit.Common.AutoFuel.Ctg,_A.Gx.Waiting*Openpit.Common.AutoFuel.Ctg);
      if _A.Auto.FAmortizationKind=ak1000km
      then _A.FSumAmortizationCtg := (esaSummary(_A.Sm)*(1E-6))*_A.Auto.FAmortizationRate*(1000.0*_A.Auto.FC1000tg)
      else _A.FSumAmortizationCtg := _A.Auto.FAmortizationRate/(Openpit.Period.Tday*AShiftsCount)*(1000.0*_A.Auto.FC1000tg);
      
//�������� 2007_10_14 ��������� ������ ����������� �� ������� �� ����������� �� �������!!!
//      _A.FSumAmortizationCtg := (_A.Sm*(1E-6))*_A.Auto.FAmortizationRate*(1000.0*_A.Auto.FC1000tg);
//      _A.FSumAmortizationCtg := {_A.Auto.FAmortizationRate}0.125*(1000.0*_A.Auto.FC1000tg)/(365*AShiftsCount);

      _A.FSumExploatationCtg := esaWorkValue();
      _Models.Append(_A);
    end;{for}
    quAutos.Close;
    quEvents.Close;
    _Models.Update;

    //--------------------------------------------------------------------------
    // II. �������� Report1,Report2,Report3
    //--------------------------------------------------------------------------
    AAutos       := '';
    AAutosCount0 := 0;
    AAutosCount1 := 0;
    ATyresCount  := 0;
    quReps := TADOQuery.Create(nil);
    quReps.Connection := DBConnection;
    quReps.SQL.Text := 'SELECT * FROM _ResultShiftAutoReports';
    quReps.Open;
    FGauge.MaxValue := _Models.Count;
    for I := 0 to _Models.Count-1 do
    begin
      SetGaugeValue(I);
      for J := 0 to _Models[I].Count-1 do
      begin
        _AddReport(quReps,1,_Models[I][J]);
        ATyresCount := ATyresCount+_Models[I][J].Auto.Model.TyresCount;
        if _Models[I][J].Auto.FWorkState
        then Inc(AAutosCount0)
        else Inc(AAutosCount1);
      end;{for}
      _AddReport(quReps,2,_Models[I]);
      if AAutos=''
      then AAutos := Format('%s (%d ��)',[_Models[I].DumpModel,_Models[I].Count])
      else AAutos := Format('%s; %s (%d ��)',[AAutos,_Models[I].DumpModel,_Models[I].Count]);
    end;{for}
    _AddReport(quReps,3,_Models);
    quReps.Free;
    //---------------------------------------------------------------------------------------------------
    Variant.SaveAutos(AAutos,AAutosCount0,AAutosCount1,_Models.TripsCount,_Models.RockVolume,_Models.Sm,_Models.WAvgSkmLoading,_Models.WAvgHm,
      _Models.AvgVkmh,_Models.AvgVkmhNulled,_Models.AvgVkmhLoading,_Models.AvgVkmhUnLoading,_Models.Gx,_Models.DirGx,
      _Models.UdGx_gr_tkm,_Models.LoadingSkmRockQtn,_Models.Tsec,_Models.DirTsec,ATyresCount,_Models.UsedTyresCount,
      _Models.SumTyresCtg,_Models.SumGxCtg,_Models.SumExploatationCtg,_Models.SumSparesGxCtg,_Models.SumMaterialsGxCtg,
      _Models.SumMaintenanceCtg,_Models.SumSalaryCtg,_Models.SumAmortizationCtg);
    SetGaugeValue(FGauge.MaxValue);
    FOpenpit.SendMessage('Ok');
  finally
    _Models.Free;
  end;{try}
  quEvents.Free;
  quAutos.Free;
end;{SaveAutosResultsNew}
//���������� � �� ����������� ������������� �� ������������
procedure TDispatcher.SaveExcavatorsResultsNew;
const
  GxPkg_l = 0.84; //��������� ����������, ��/�
  T = True; F = False;
  procedure _AddReport(const AQuery: TADOQuery; const AKind: Integer; const AItem: TesaResultExcavator);
    procedure _Add(const q: TADOQuery; const ARecName: String; const AKey: ResaKeyParams; ANum: Single; const ADen: Single=-1.0);
    var I: Integer;
    begin
      //������������� Value
      if not(ADen<0.0) then if ADen>0.0 then ANum := ANum/ADen else ANum := 0.0;
      //��������� � ��
      q.Append;
      for I := 1 to q.Fields.Count-1 do
        q.Fields[I].Clear;
      q.FieldByName('Id_ResultShift').AsInteger               := ResultId_Shift;
      if AKind = 1
      then q.FieldByName('Id_ResultShiftExcavator').AsInteger := AItem.Id_ResultShiftExcavator;
      if AKind = 2
      then q.FieldByName('Id_DumpModel').AsInteger            := AItem.Id_DumpModel;
      q.FieldByName('Kind').AsInteger                         := AKind;
      q.FieldByName('IsChangeable').AsBoolean                 := AKey.IsChangeable;
      q.FieldByName('RecordNo').AsInteger                     := AKey.No;
      q.FieldByName('RecordName').AsString                    := ARecName;
      q.FieldByName('Name').AsString                          := AKey.Key;
      if ANum>-1.0
      then q.FieldByName('Value').AsFloat                     := ANum;
      q.Post;
    end;{_Add}
  begin
    with AItem do
    begin
      //�������������� ���������
      _Add(AQuery,  'I',CesaExcavsQuantity,-1.0);
      _Add(AQuery,  '1',CesaExcavsExcavatorsCount,ExcavatorsCount);
      _Add(AQuery,  '2',CesaExcavsLoadingAutosCount,LoadingAutosCount);
      _Add(AQuery,  '3',CesaExcavsRockPlanVm3,RockShiftPlan.Vm3);
      _Add(AQuery,  '4',CesaExcavsRockVm3,RockVolume.Vm3);
      _Add(AQuery,  '5',CesaExcavsRockQtn,RockVolume.Qtn);
      _Add(AQuery,  '6',CesaExcavsPlanRockRatio,100*RockVolume.Vm3,RockShiftPlan.Vm3);
      //������ �������
      _Add(AQuery, 'II',CesaExcavsFuel,-1.0);
      _Add(AQuery,  '1',CesaExcavsGx,esaSummary(SumGx));
      _Add(AQuery,  '1',CesaExcavsGxWork,SumGx.Work);
      _Add(AQuery,  '1',CesaExcavsGxWaiting,SumGx.Waiting);
      //�����
      _Add(AQuery,'III',CesaExcavsTime,-1.0);
      _Add(AQuery,  '1',CesaExcavsTmin,esaSummary(SumTmin));
      _Add(AQuery,  '2',CesaExcavsTminWork,SumTmin.OnLoading);
      _Add(AQuery,  '3',CesaExcavsTminWaiting,SumTmin.Waiting);
      _Add(AQuery,  '4',CesaExcavsTminManevr,SumTmin.Manevr);
      _Add(AQuery,  '5',CesaExcavsUsingPunktCoef,SumTmin.OnLoading+SumTmin.Manevr,esaSummary(SumTmin));
      _Add(AQuery,  '6',CesaExcavsUsingTimeCoef,SumTmin.OnLoading,esaSummary(SumTmin));
      //����������� ���������
      _Add(AQuery, 'IV',CesaExcavsCosts,-1.0);
      _Add(AQuery,  '1',CesaExcavsWorkCtg,SumExploatationCtg.Work);
      _Add(AQuery,  '2',CesaExcavsWorkSumGxCtg,SumGxCtg.Work);
      _Add(AQuery,  '3',CesaExcavsWorkMaterialsCtg,SumMaterialsGxCtg.Work);
      _Add(AQuery,  '4',CesaExcavsWorkUnAccountedCtg,SumUnAccountedCtg.Work);
      _Add(AQuery,  '5',CesaExcavsWorkSalariesCtg,SumSalaryCtg.Work);
      _Add(AQuery,  '6',CesaExcavsWaitingCtg,SumExploatationCtg.Waiting);
      _Add(AQuery,  '7',CesaExcavsWaitingSumGxCtg,SumGxCtg.Waiting);
      _Add(AQuery,  '8',CesaExcavsWaitingMaterialsCtg,SumMaterialsGxCtg.Waiting);
      _Add(AQuery,  '9',CesaExcavsWaitingUnAccountedCtg,SumUnAccountedCtg.Waiting);
      _Add(AQuery, '10',CesaExcavsWaitingSalariesCtg,SumSalaryCtg.Waiting);
      _Add(AQuery, '11',CesaExcavsAmortizationCtg,SumAmortizationCtg);
      _Add(AQuery, '12',CesaExcavsCtg,SumExploatationCtg.Work+SumExploatationCtg.Waiting+SumAmortizationCtg);
    end;{with}
  end;{_AddReport}
var
  quEvents       : TADOQuery;
  quExcavators   : TADOQuery;
  quReps         : TADOQuery;
  _Ev            : TesaResultExcavatorEvent;
  I,J,K          : Integer;
  _Models        : TesaResultExcavatorModels;
  _Ex            : TesaResultExcavator;
  AGxCoef        : Single;
  AExcavators     : String;  //������ ������������ 
  AExcavatorsCount0: Integer; //���������� ������������ � ������� ���������
  AExcavatorsCount1: Integer; //���������� ������������ � ������� ���������
begin
  if ResultId_Shift<1 then Exit;
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ������������..');

  quExcavators := TADOQuery.Create(nil);
  quExcavators.Connection := DBConnection;
  quExcavators.SQL.Text := 'SELECT * FROM _ResultShiftExcavators';
  quEvents := TADOQuery.Create(nil);
  quEvents.Connection := DBConnection;
  quEvents.SQL.Text := 'SELECT * FROM _ResultShiftExcavatorEvents';

  //----------------------------------------------------------------------------
  // I. �������� ��� ������, �������� �������������, �������
  //----------------------------------------------------------------------------
  _Models:= TesaResultExcavatorModels.Create(Self);
  try
    quExcavators.Open;
    quEvents.Open;
    FGauge.MaxValue:= LoadingPunkts.Count;
    for I:= 0 to LoadingPunkts.Count-1 do
    begin
      SetGaugeValue(I);
      //�������� ������������ --------------------------------------------------
      quExcavators.Append;
      quExcavators.FieldByName('Id_ResultShift').AsInteger := ResultId_Shift;
      quExcavators.FieldByName('Id_DumpModel').AsInteger := LoadingPunkts[I].Excavator.Model.Id_Excavator;
      quExcavators.FieldByName('DumpModel').AsString := LoadingPunkts[I].Excavator.Model.Name;
      quExcavators.FieldByName('DumpNo').AsInteger := LoadingPunkts[I].Excavator.FParkNo;
      quExcavators.FieldByName('DumpYear').AsInteger := LoadingPunkts[I].Excavator.FEYear;
      quExcavators.FieldByName('DumpTsec').AsFloat := LoadingPunkts[I].Excavator.FTsec;
      quExcavators.FieldByName('DumpMaxVm3').AsFloat := LoadingPunkts[I].Excavator.Model.MaxVm3;
      quExcavators.FieldByName('DumpMaxNkVt').AsFloat := LoadingPunkts[I].Excavator.Model.EngineMaxNkVt;
      quExcavators.FieldByName('DumpEngineKIM').AsFloat := LoadingPunkts[I].Excavator.EngineKIM;
      quExcavators.FieldByName('DumpEngineKPD').AsFloat := LoadingPunkts[I].Excavator.EngineKPD;
      quExcavators.FieldByName('DumpC1000tg').AsFloat := LoadingPunkts[I].Excavator.FC1000tg;
      quExcavators.FieldByName('DumpMaterialsMonthC1000tg').AsFloat := LoadingPunkts[I].Excavator.FAddMaterialsMonthC1000tg;
      quExcavators.FieldByName('DumpUnAccountedMonthC1000tg').AsFloat := LoadingPunkts[I].Excavator.FAddUnAccountedMonthC1000tg;
      quExcavators.FieldByName('Id_LoadingPunkt').AsInteger := LoadingPunkts[I].FId_LoadingPunkt;
      quExcavators.FieldByName('Horizont').AsFloat := LoadingPunkts[I].Horizont;
      quExcavators.FieldByName('DumpWorkState').AsBoolean := LoadingPunkts[I].Excavator.WorkState;
      quExcavators.Post;
      //�������� ������������ --------------------------------------------------
      _Ex                          := TesaResultExcavator.Create(Self);
      _Ex.FExcavator               := LoadingPunkts[I].Excavator;
      _Ex.FId_ResultShift          := ResultId_Shift;
      _Ex.FId_ResultShiftExcavator := quExcavators.FieldByName('Id_ResultShiftExcavator').AsInteger;
      _Ex.FId_DumpModel           := LoadingPunkts[I].Excavator.Model.Id_Excavator;
      _Ex.FDumpModel               := LoadingPunkts[I].Excavator.Model.Name;
      //������� ----------------------------------------------------------------
      for J := 0 to LoadingPunkts[I].Excavator.Events.Count-1 do
      begin
        _Ev := LoadingPunkts[I].Excavator.Events[J];
        if _Ev.Kind = eekLoading then AGxCoef := 1.0 else AGxCoef := 0.1;
        _Ev.FGx := LoadingPunkts[I].Excavator.Model.EngineMaxNkVt*
                   LoadingPunkts[I].Excavator.EngineKPD*
                   LoadingPunkts[I].Excavator.EngineKIM/60*_Ev.Tsec/60*AGxCoef;
        //�������� ������� -----------------------------------------------------
        quEvents.Append;
        for K := 1 to quEvents.Fields.Count-1 do
        quEvents.Fields[K].Clear;
        quEvents.FieldByName('Id_ResultShiftExcavator').AsInteger :=
          quExcavators.FieldByName('Id_ResultShiftExcavator').AsInteger;
        quEvents.FieldByName('Kind').AsInteger                  := Integer(_Ev.Kind);
        quEvents.FieldByName('Tmin').AsFloat                    := _Ev.Tsec/60;
        quEvents.FieldByName('Gx').AsFloat                      := _Ev.Gx;
        if _Ev.Kind = eekLoading then
        begin
          quEvents.FieldByName('Id_Rock').AsInteger             := _Ev.Rock.Id_Rock;
          quEvents.FieldByName('Rock').AsString                 := _Ev.Rock.Name;
          quEvents.FieldByName('RockIsMineralWealth').AsBoolean := _Ev.Rock.IsMineralWealth;
          quEvents.FieldByName('RockVm3').AsFloat               := _Ev.RockVolume.Vm3;
          quEvents.FieldByName('RockQtn').AsFloat               := _Ev.RockVolume.Qtn;
          quEvents.FieldByName('RockQua').AsFloat               := _Ev.RockVolume.Qua;  {dwd}
          quEvents.FieldByName('Excv').AsFloat                  := _Ev.RockVolume.Excv;
        end;{if}
        quEvents.FieldByName('Id_DumpModel').AsInteger          := _Ev.Id_DumpModel;
        quEvents.FieldByName('DumpModel').AsString              := _Ev.DumpModel;
        quEvents.FieldByName('DumpNo').AsInteger                := _Ev.DumpNo;
        quEvents.Post;
        //�������� �� �������� �������� ������ �� ������� ������������� ------
        if _Ev.Kind=eekLoading then //��������
        begin
          _Ex.FLoadingAutosCount  := _Ex.LoadingAutosCount + 1;
          _Ex.FRockVolume         := esaSum(_Ex.RockVolume,_Ev.RockVolume);
          _Ex.FSumTmin.OnLoading  := _Ex.SumTmin.OnLoading + _Ev.Tsec/60;
        end;{if}
        if _Ev.Kind=eekManevr
        then _Ex.FSumTmin.Manevr  := _Ex.SumTmin.Manevr + _Ev.Tsec/60;
      end;{for}
      _Ex.FSumTmin.Waiting        := 0.0;
      _Ex.FSumGx                  := esaWorkValue();
      _Models.Append(_Ex);
    end;{for}

    SetGaugeValue(0);
    FGauge.MaxValue := Openpit.Excavators.Count;
    for I := 0 to Openpit.Excavators.Count-1 do //����������� � ��������� ���������
    if not Openpit.Excavators[I].WorkState then
    begin
      SetGaugeValue(I);
      //�������� ������������ --------------------------------------------------
      quExcavators.Append;
      quExcavators.FieldByName('Id_ResultShift').AsInteger := ResultId_Shift;
      quExcavators.FieldByName('Id_DumpModel').AsInteger := Openpit.Excavators[I].Model.Id_Excavator;
      quExcavators.FieldByName('DumpModel').AsString := Openpit.Excavators[I].Model.Name;
      quExcavators.FieldByName('DumpNo').AsInteger := Openpit.Excavators[I].ParkNo;
      quExcavators.FieldByName('DumpYear').AsInteger := Openpit.Excavators[I].EYear;
      quExcavators.FieldByName('DumpTsec').AsFloat := Openpit.Excavators[I].Tsec;
      quExcavators.FieldByName('DumpMaxVm3').AsFloat := Openpit.Excavators[I].Model.MaxVm3;
      quExcavators.FieldByName('DumpMaxNkVt').AsFloat := Openpit.Excavators[I].Model.EngineMaxNkVt;
      quExcavators.FieldByName('DumpEngineKIM').AsFloat := Openpit.Excavators[I].EngineKIM;
      quExcavators.FieldByName('DumpEngineKPD').AsFloat := Openpit.Excavators[I].EngineKPD;
      quExcavators.FieldByName('DumpC1000tg').AsFloat := Openpit.Excavators[I].C1000tg;
      quExcavators.FieldByName('DumpMaterialsMonthC1000tg').AsFloat := Openpit.Excavators[I].AddMaterialsMonthC1000tg;
      quExcavators.FieldByName('DumpUnAccountedMonthC1000tg').AsFloat := Openpit.Excavators[I].AddUnAccountedMonthC1000tg;
      quExcavators.FieldByName('Id_LoadingPunkt').Clear;
      quExcavators.FieldByName('Horizont').Clear;
      quExcavators.FieldByName('DumpWorkState').AsBoolean := Openpit.Excavators[I].WorkState;
      quExcavators.Post;
      //�������� ������������ --------------------------------------------------
      _Ex                          := TesaResultExcavator.Create(Self);
      _Ex.FExcavator               := Openpit.Excavators[I];
      _Ex.FId_ResultShift          := ResultId_Shift;
      _Ex.FId_ResultShiftExcavator := quExcavators.FieldByName('Id_ResultShiftExcavator').AsInteger;
      _Ex.FId_DumpModel            := Openpit.Excavators[I].Model.Id_Excavator;
      _Ex.FDumpModel               := Openpit.Excavators[I].Model.Name;
      _Ex.FSumTmin.Waiting         := 0.0;
      _Ex.FSumGx                   := esaWorkValue();
      _Models.Append(_Ex);
    end;{for}
    
    quExcavators.Close;
    quEvents.Close;
    _Models.Update;

    //--------------------------------------------------------------------------
    // II. �������� Report1,Report2,Report3
    //--------------------------------------------------------------------------
    quReps := TADOQuery.Create(nil);
    quReps.Connection := DBConnection;
    quReps.SQL.Text := 'SELECT * FROM _ResultShiftExcavatorReports';
    quReps.Open;
    AExcavators := '';
    AExcavatorsCount0 := 0;
    AExcavatorsCount1 := 0;
    FGauge.MaxValue := _Models.Count;
    for I := 0 to _Models.Count-1 do
    begin
      SetGaugeValue(I);
      for J := 0 to _Models[I].Count-1 do
      begin
        _AddReport(quReps,1,_Models[I][J]);
        if _Models[I][J].Excavator.FWorkState
        then Inc(AExcavatorsCount0)
        else Inc(AExcavatorsCount1);
      end;{for}
      _AddReport(quReps,2,_Models[I]);
      if AExcavators=''
      then AExcavators := Format('%s (%d ��)',[_Models[I].DumpModel,_Models[I].Count])
      else AExcavators := Format('%s; %s (%d ��)',[AExcavators,_Models[I].DumpModel,_Models[I].Count]);
    end;{for}
    _AddReport(quReps,3,_Models);
    quReps.Free;
    Variant.SaveExcavators(AExcavators,AExcavatorsCount0,AExcavatorsCount1,
      _Models.LoadingAutosCount,_Models.RockVolume,_Models.RockShiftPlan,
      _Models.SumGx,_Models.SumTmin,_Models.SumExploatationCtg,
      _Models.SumGxCtg,_Models.SumMaterialsGxCtg, _Models.SumUnAccountedCtg,
      _Models.SumSalaryCtg,_Models.SumAmortizationCtg);
    SetGaugeValue(FGauge.MaxValue);
    FOpenpit.SendMessage('Ok');
  finally
    _Models.Free;
  end;{try}
  quEvents.Free;
  quExcavators.Free;
end;{SaveExcavatorsResultsNew}
//���������� � �� ����������� ������������� �� ������� ���������
procedure TDispatcher.SaveUnLoadingPunktsResultsNew;
var
  I,J,K,AId : Integer;
  q0,q1,q2: TADOQuery;
  AAutosCount: Integer;
  AUnloadingTmin,AManeuvrTmin: Single;
  ARockVolume: ResaRockVolume;
begin
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ������� ��������..');
  q0 := TADOQuery.Create(nil);
  q0.Connection := fmDM.ADOConnection;
  q0.SQL.Text := 'SELECT * FROM _ResultShiftUnloadingPunkts';
  q0.Open;
  q1 := TADOQuery.Create(nil);
  q1.Connection := fmDM.ADOConnection;
  q1.SQL.Text := 'SELECT * FROM _ResultShiftUnloadingPunktEvents';
  q1.Open;
  q2  := TADOQuery.Create(nil);
  q2.Connection := fmDM.ADOConnection;
  q2.SQL.Text := 'SELECT * FROM _ResultShiftUnloadingPunktRocks';
  q2.Open;
  FGauge.MaxValue := UnLoadingPunkts.Count;
  for I := 0 to UnLoadingPunkts.Count-1 do
  begin
    SetGaugeValue(I);
    //������� ��������� ����������� �� �� ---------------------------------------------------------------
    AAutosCount    := 0;
    AUnloadingTmin := 0.0;
    AManeuvrTmin   := 0.0;
    ARockVolume    := esaRockVolume();
    for J := 0 to UnLoadingPunkts[I].Events.Count-1 do
    begin
      case UnLoadingPunkts[I].Events[J].Kind of
        uekLoading: begin
          AAutosCount    := AAutosCount+1;
          AUnloadingTmin := AUnloadingTmin+UnLoadingPunkts[I].Events[J].Tsec/60;
          ARockVolume    := esaSum(ARockVolume,UnLoadingPunkts[I].Events[J].RockVolume);
        end;{uekLoading}
        uekManevr: begin
          AManeuvrTmin := AManeuvrTmin+UnLoadingPunkts[I].Events[J].Tsec/60;
        end;{uekManevr}
      end;{case}
    end;{for}
    //���������� ��������� ����������� �� �� ------------------------------------------------------------
    q0.Append;
    q0.FieldByName('Id_ResultShift').AsInteger      := ResultId_Shift;
    q0.FieldByName('Id_UnloadingPunkt').AsInteger   := UnLoadingPunkts[I].Id_UnLoadingPunkt;
    q0.FieldByName('Horizont').AsFloat              := UnLoadingPunkts[I].Horizont;
    q0.FieldByName('MaxV1000m3').AsFloat            := UnLoadingPunkts[I].MaxVm3*0.001;
    q0.FieldByName('Kind').AsInteger                := Integer(UnLoadingPunkts[I].Kind);
    q0.FieldByName('UnloadingAutosCount').AsInteger := AAutosCount;
    q0.FieldByName('UnloadingTmin').AsFloat         := AUnloadingTmin;
    q0.FieldByName('ManeuvrTmin').AsFloat           := AManeuvrTmin;
    q0.FieldByName('RockVm3').AsFloat               := ARockVolume.Vm3;
    q0.FieldByName('RockQtn').AsFloat               := ARockVolume.Qtn;
    q0.FieldByName('RockQua').AsFloat               := ARockVolume.Qua;   {dwd}
    q0.FieldByName('Excv').AsFloat                  := ARockVolume.Excv;   {dwd}
    q0.Post;
    AId := q0.FieldByName('Id_ResultShiftUnloadingPunkt').AsInteger;
    //���������� ������� �� �� --------------------------------------------------------------------------
    for J := 0 to UnLoadingPunkts[I].Events.Count-1 do
    begin
      q1.Append;
      for K := 1 to q1.FieldCount-1 do
        q1.Fields[K].Clear;
      q1.FieldByName('Id_ResultShiftUnloadingPunkt').AsInteger := AId;
      q1.FieldByName('Kind').AsInteger := Integer(UnLoadingPunkts[I].Events[J].Kind);
      q1.FieldByName('Tmin').AsFloat := UnLoadingPunkts[I].Events[J].Tsec/60;
      if UnLoadingPunkts[I].Events[J].Rock.Id_Rock>0 then
      begin
        q1.FieldByName('Id_Rock').AsInteger := UnLoadingPunkts[I].Events[J].Rock.Id_Rock;
        q1.FieldByName('Rock').AsString := UnLoadingPunkts[I].Events[J].Rock.Name;
        q1.FieldByName('RockIsMineralWealth').AsBoolean := UnLoadingPunkts[I].Events[J].Rock.IsMineralWealth;
        q1.FieldByName('RockVm3').AsFloat := UnLoadingPunkts[I].Events[J].RockVolume.Vm3;
        q1.FieldByName('RockQtn').AsFloat := UnLoadingPunkts[I].Events[J].RockVolume.Qtn;
        q1.FieldByName('RockQua').AsFloat := UnLoadingPunkts[I].Events[J].RockVolume.Qua;    {dwd}
        q1.FieldByName('Excv').AsFloat := UnLoadingPunkts[I].Events[J].RockVolume.Excv;    {dwd}
      end;{if}
      if UnLoadingPunkts[I].Events[J].Id_DumpModel>0 then
      begin
        q1.FieldByName('Id_DumpModel').AsInteger := UnLoadingPunkts[I].Events[J].Id_DumpModel;
        q1.FieldByName('DumpModel').AsString := UnLoadingPunkts[I].Events[J].DumpModel;
        q1.FieldByName('DumpNo').AsInteger := UnLoadingPunkts[I].Events[J].DumpNo;
      end;{if}
      q1.Post;
    end;{for}
    //���������� �� �� �� -------------------------------------------------------------------------------
    for J := 0 to UnLoadingPunkts[I].RockCount-1 do
    begin
      q2.Append;
      q2.FieldByName('Id_ResultShiftUnloadingPunkt').AsInteger := AId;
      q2.FieldByName('UnloadingAutosCount').AsInteger := UnLoadingPunkts[I].Rocks[J].FSumAutoCount;
      q2.FieldByName('RockVm3').AsFloat := UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Vm3;
      q2.FieldByName('RockQtn').AsFloat := UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Qtn;
      q2.FieldByName('RockQua').AsFloat := UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Qua;      {dwd}
      q2.FieldByName('Excv').AsFloat := UnLoadingPunkts[I].Rocks[J].FCurrRockVolume.Excv;      {dwd}
      q2.FieldByName('RequiredContent').AsFloat := UnLoadingPunkts[I].Rocks[J].RequiredContent;
      q2.FieldByName('Content').AsFloat := UnLoadingPunkts[I].Rocks[J].FCurrContent;
      q2.FieldByName('Id_Rock').AsInteger := UnLoadingPunkts[I].Rocks[J].Rock.Id_Rock;
      q2.FieldByName('Rock').AsString := UnLoadingPunkts[I].Rocks[J].Rock.Name;
      q2.FieldByName('RockIsMineralWealth').AsBoolean := UnLoadingPunkts[I].Rocks[J].Rock.IsMineralWealth;
      q2.Post;
    end;{for}
  end;{for}
  q0.Free;
  q1.Free;
  q2.Free;
  SetGaugeValue(FGauge.MaxValue);
  FOpenpit.SendMessage('Ok');
end;{SaveUnLoadingPunktsResultsNew}
//���������� � �� ����������� ������������� �� ������������� �����������
procedure TDispatcher.SaveEconomResultsNew;
  //
  procedure _GetSummaryAutoParams(var AWorkCtg,AWaitingCtg,AAmortizationCtg: Single);
  const fName='Value';
  begin
    AWorkCtg := 0.0; AWaitingCtg := 0.0; AAmortizationCtg := 0.0;
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := Format('SELECT * FROM _ResultShiftAutoReports WHERE (Id_ResultShift=%d)and(Kind=3)',[ResultId_Shift]);
      Open;
      if Locate('RecordNo',CesaAutosWorkCtg.No,[])then AWorkCtg := FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaAutosWaitingCtg.No,[])then AWaitingCtg := FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaAutosAmortizationCtg.No,[])then AAmortizationCtg := FieldByName(fName).AsFloat;
      Close;
    finally
      Free;
    end;
  end;
  //
  procedure _GetSummaryExcavatorParams(var AWorkCtg,AWaitingCtg,AAmortizationCtg: Single; var ARockVolume: ResaRockVolume);
  const fName='Value';
  begin
    AWorkCtg := 0.0; AWaitingCtg := 0.0; AAmortizationCtg := 0.0; ARockVolume := esaRockVolume();
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := Format('SELECT * FROM _ResultShiftExcavatorReports WHERE (Id_ResultShift=%d)and(Kind=3)',[ResultId_Shift]);
      Open;
      if Locate('RecordNo',CesaExcavsWorkCtg.No,[])then
        AWorkCtg := FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaExcavsWaitingCtg.No,[])then
        AWaitingCtg := FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaExcavsAmortizationCtg.No,[])then
        AAmortizationCtg := FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaExcavsRockVm3.No,[])then
        ARockVolume.Vm3:= FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaExcavsRockQtn.No,[])then
        ARockVolume.Qtn := FieldByName(fName).AsFloat;
      Close;
    finally
      Free;
    end;
  end;
  //
  procedure _GetSummaryBlockParams(var ARepairCtg,AAmortizationCtg: Single);
  const fName='Value';
  begin
    ARepairCtg := 0.0; AAmortizationCtg := 0.0;
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := Format('SELECT * FROM _ResultShiftBlockReports WHERE (Id_ResultShift=%d)and(Kind=3)',[ResultId_Shift]);
      Open;
      if Locate('RecordNo',CesaBlocksRepairCtg.No,[])then
        ARepairCtg := FieldByName(fName).AsFloat;
      if Locate('RecordNo',CesaBlocksAmortizationCtg.No,[])then
        AAmortizationCtg := FieldByName(fName).AsFloat;
      Close;
    finally
      Free;
    end;
  end;
  //
  procedure _Add(const q: TADOQuery;
                 const ARecName: String;
                 const AKey: ResaKeyParams;
                 ANum: Single;
                 ADen: Single=-1.0);overload;
  var
    I: Integer;
  begin
    if not(ADen<0.0) then
      if ADen>0.0 then
        ANum := ANum/ADen
      else
        ANum := 0.0;
    q.Append;
    for I := 1 to q.Fields.Count-1 do
      q.Fields[I].Clear;
    q.FieldByName('Id_ResultShift').AsInteger := ResultId_Shift;
    q.FieldByName('IsChangeable').AsBoolean := AKey.IsChangeable;
    q.FieldByName('RecordNo').AsInteger := AKey.No;
    q.FieldByName('RecordName').AsString := ARecName;
    q.FieldByName('Name').AsString := AKey.Key;
    if ANum > -1.0 then
      q.FieldByName('Value').AsFloat := ANum/1000;
    q.Post;
  end;
  //
  procedure _Add(const q: TADOQuery;
                 const AKind,ARecNo: Integer;
                 const AName: String;
                 AValue: Single=0.0);overload;
  var I: Integer;
  begin
    q.Append;
    for I := 1 to q.Fields.Count-1 do
      q.Fields[I].Clear;
    q.FieldByName('Id_ResultShift').AsInteger := ResultId_Shift;
    q.FieldByName('SeriaNo').AsInteger := AKind;
    q.FieldByName('RecordNo').AsInteger := ARecNo;
    q.FieldByName('Name').AsString := AName;
    q.FieldByName('Value').AsFloat := AValue;
    q.Post;
  end;
  //
  procedure _SaveToResultOfVariant(ProductPriceCtg,
                                   MTWorkByScheduleCtg,
                                   ServiceExpensesCtg: double);

  //�������� � ����� ��������� �������
  const
    SELECT_ID_RESULT_VARIANT = 'SELECT Id_ResultVariant ' +
                               'FROM _ResultVariants ' +
                               'WHERE VariantDate = (SELECT MAX(VariantDate) FROM _ResultVariants)';
    SELECT_PLAN_SUM = 'SELECT SUM(PlannedV1000m3) AS PlanV1000m3 ' +
                      'FROM OpenpitLoadingPunktRocks';
    UPDATE_RESULT_VARIANT = 'UPDATE _ResultVariants ' +
                            'SET ' +
                            'ProductPriceCtg=:ProductPriceCtg, ' +
                            'MTWorkByScheduleCtg=:MTWorkByScheduleCtg, ' +
                            'ServiceExpensesCtg=:ServiceExpensesCtg, ' +
                            'PlannedRockVolumeCm=:PlannedRockVolumeCm ' +
                            'WHERE Id_ResultVariant=:Id_ResultVariant';
  var
    _qry: TADOQuery;
    Id_ResultVariant: integer;
    plan: double;
  begin
    _qry:= TADOQuery.Create(nil);
    _qry.Connection:= fmDM.ADOConnection;
    with _qry do
    begin
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_ID_RESULT_VARIANT;
      Open;
      Id_ResultVariant:= FieldValues['Id_ResultVariant'];
      Close;
      SQL.Clear;
      SQL.Text:= SELECT_PLAN_SUM;
      Open;
      plan:= FieldValues['PlanV1000m3'];
      Close;
      SQL.Clear;
      SQL.Text:= UPDATE_RESULT_VARIANT;
      Parameters.ParamByName('ProductPriceCtg').Value:= ProductPriceCtg;
      Parameters.ParamByName('MTWorkByScheduleCtg').Value:= MTWorkByScheduleCtg;
      Parameters.ParamByName('ServiceExpensesCtg').Value:= ServiceExpensesCtg;
      Parameters.ParamByName('PlannedRockVolumeCm').Value:= plan;

      Parameters.ParamByName('Id_ResultVariant').Value:= Id_ResultVariant;
      ExecSQL;
      Close;
      Free;
    end;
  end;
var
  AWorkCtg0,AWorkCtg1,ARepairCtg2                      : Single;//������� � ������, ��
  AWaitingCtg0,AWaitingCtg1                            : Single;//������� � �������, ��
  AAmortizationCtg0,AAmortizationCtg1,AAmortizationCtg2: Single;//�������.����������, ��
  ACtg0,ACtg1,ACtg2                                    : Single;//������� ���������, ��
  ARockVolume                                          : ResaRockVolume;//������������������, �3. � �.
  AExpensesCtg                                         : Single;//���������� � ���������� �������, ��
  qu: TADOQuery;
  //
  ProductPriceCtg: double;
  MTWorkByScheduleCtg: double;
  ServiceExpensesCtg: double;
begin
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ������������� �����������..');
  try
    _GetSummaryAutoParams(AWorkCtg0,AWaitingCtg0,AAmortizationCtg0);
    _GetSummaryExcavatorParams(AWorkCtg1,AWaitingCtg1,AAmortizationCtg1,ARockVolume);
    _GetSummaryBlockParams(ARepairCtg2,AAmortizationCtg2);
    AExpensesCtg := Openpit.Common.YearExpensesCtg/(365*24*60) * Openpit.Shift.Tmin;
    ACtg0 := AWorkCtg0+AWaitingCtg0+AAmortizationCtg0;
    ACtg1 := AWorkCtg1+AWaitingCtg1+AAmortizationCtg1;
    ACtg2 := ARepairCtg2+AAmortizationCtg2;
    qu := TADOQuery.Create(nil);
    try
      qu.Connection := fmDM.ADOConnection;
      qu.SQL.Text := Format('SELECT * FROM _ResultEconomReports WHERE Id_ResultShift=%d',[ResultId_Shift]);
      qu.Open;
      while not qu.Eof do
        qu.Delete;
      _Add(qu, 'I',  CesaEconomAutos,-1.0);
      _Add(qu, '1',  CesaEconomWorkCtg0,AWorkCtg0);
      _Add(qu, '2',  CesaEconomWaitingCtg0,AWaitingCtg0);
      _Add(qu, '3',  CesaEconomAmortizationCtg0,AAmortizationCtg0);
      _Add(qu, '4',  CesaEconomCtg0,ACtg0);
      _Add(qu, 'II', CesaEconomExcavs,-1.0);
      _Add(qu, '1',  CesaEconomWorkCtg1,AWorkCtg1);
      _Add(qu, '2',  CesaEconomWaitingCtg1,AWaitingCtg1);
      _Add(qu, '3',  CesaEconomAmortizationCtg1,AAmortizationCtg1);
      _Add(qu, '4',  CesaEconomCtg1,ACtg1);
      _Add(qu, 'III',CesaEconomBlocks,-1.0);
      _Add(qu, '1',  CesaEconomRepairCtg2,ARepairCtg2);
      _Add(qu, '2',  CesaEconomAmortizationCtg2,AAmortizationCtg2);
      _Add(qu, '3',  CesaEconomCtg2,ACtg2);
      _Add(qu, 'IV', CesaEconomSummary,-1.0);
      _Add(qu, '1',  CesaEconomCtg,ACtg0+ACtg1+ACtg2+AExpensesCtg);
      _Add(qu, '2',  CesaEconomExpluationCtg,AWorkCtg0+AWaitingCtg0+AWorkCtg1+AWaitingCtg1+ARepairCtg2);
      _Add(qu, '3',  CesaEconomAmortizationCtg,AAmortizationCtg0+AAmortizationCtg1+AAmortizationCtg2);
      _Add(qu, '4',  CesaEconomExpensesCtg,AExpensesCtg);
      _Add(qu, '5',  CesaEconomRockVm3,ARockVolume.Vm3);
      _Add(qu, '6',  CesaEconomRockQtn,ARockVolume.Qtn);
      _Add(qu, '7',  CesaEconomUdExpluationCtgm3,AWorkCtg0+AWaitingCtg0+AWorkCtg1+AWaitingCtg1+ARepairCtg2,ARockVolume.Vm3);
      _Add(qu, '8',  CesaEconomUdExpluationCtgtn ,AWorkCtg0+AWaitingCtg0+AWorkCtg1+AWaitingCtg1+ARepairCtg2,ARockVolume.Qtn);
      _Add(qu, '9',  CesaEconomUdAmortizationCtgm3,AAmortizationCtg0+AAmortizationCtg1+AAmortizationCtg2,ARockVolume.Vm3);
      _Add(qu,'10',  CesaEconomUdAmortizationCtgtn,AAmortizationCtg0+AAmortizationCtg1+AAmortizationCtg2,ARockVolume.Qtn);
      _Add(qu,'11',  CesaEconomUdCtgm3,ACtg0+ACtg1+ACtg2+AExpensesCtg,ARockVolume.Vm3);
      _Add(qu,'12',  CesaEconomUdCtgtn,ACtg0+ACtg1+ACtg2+AExpensesCtg,ARockVolume.Qtn);
      qu.Close;
      qu.SQL.Text := Format('SELECT * FROM _ResultEconomDistributation WHERE Id_ResultShift=%d ORDER BY SeriaNo,RecordNo',[ResultId_Shift]);
      qu.Open;
      while not qu.Eof do
        qu.Delete;
      _Add(qu,1,1,'�������������',AWorkCtg0+AWaitingCtg0);
      _Add(qu,1,2,'�����������',AWorkCtg1+AWaitingCtg1);
      _Add(qu,1,3,'����������',ARepairCtg2);
      _Add(qu,1,4,'������');
      _Add(qu,2,1,'�������������',AAmortizationCtg0);
      _Add(qu,2,2,'�����������',AAmortizationCtg1);
      _Add(qu,2,3,'����������',AAmortizationCtg2);
      _Add(qu,2,4,'������');
      _Add(qu,3,1,'�������������',ACtg0);
      _Add(qu,3,2,'�����������',ACtg1);
      _Add(qu,3,3,'����������',ACtg2);
      _Add(qu,3,4,'������',AExpensesCtg);
      qu.Close;
      Variant.SaveEconomParams(AExpensesCtg);
    finally
      qu.Free;
    end;
    ProductPriceCtg:= (ACtg0+ACtg1+ACtg2+AExpensesCtg) / (ARockVolume.Qtn);//���
    MTWorkByScheduleCtg:= (ACtg0+ACtg1+ACtg2+AExpensesCtg) / 1000000;
    ServiceExpensesCtg:= (AWorkCtg0+AWaitingCtg0+AWorkCtg1+AWaitingCtg1+ARepairCtg2 +
                         AAmortizationCtg0+AAmortizationCtg1+AAmortizationCtg2) / 1000;

    _SaveToResultOfVariant(ProductPriceCtg, MTWorkByScheduleCtg, ServiceExpensesCtg);
    SetGaugeValue(FGauge.MaxValue);
    FOpenpit.SendMessage('Ok');
  finally
  end;
end;
//���������� � �� ����������� ������������� �� ������
procedure TDispatcher.SavePeriodResultsNew;
var q0,q1, q_resultVariants: TADOQuery;
  procedure _Add(const ARecordName: String; const ARecordNo: Integer; const AName: String = ''); overload;
  begin
    q1.Append;
    q1.FieldByName('Id_ResultShift').AsInteger    := ResultId_Shift;
    q1.FieldByName('Id_DumpModel').AsInteger      := q0.FieldByName('Id_DumpModel').AsInteger;
    q1.FieldByName('DumpModel').AsString          := q0.FieldByName('DumpModel').AsString;
    q1.FieldByName('RecordName').AsString         := ARecordName;
    q1.FieldByName('RecordNo').AsInteger          := ARecordNo;
    if ARecordNo mod 100 <> 0 then
      q1.FieldByName('IsChangeable').AsBoolean := q0.FieldByName('IsChangeable'+IntToStr(ARecordNo)).AsBoolean
    else
      q1.FieldByName('IsChangeable').AsBoolean := False;
    if ARecordNo mod 100 <> 0 then
      q1.FieldByName('Name').AsString          := q0.FieldByName('Name'+IntToStr(ARecordNo)).AsString
    else
      q1.FieldByName('Name').AsString          := AName;
    if ARecordNo mod 100 <> 0 then
      q1.FieldByName('Value').AsFloat          := q0.FieldByName('Value'+IntToStr(ARecordNo)).AsFloat
    else
      q1.FieldByName('Value'). Clear;
    q1.Post;
  end;
  procedure _Add(const ARock: RESARock; const ARecordName: String; const ARecordNo: Integer; const AIsChangeable: Boolean; const AName: String; const AValue: Single); overload;
  begin
    q1.Append;
    q1.FieldByName('Id_ResultShift').AsInteger      := ResultId_Shift;
    q1.FieldByName('Id_Rock').AsInteger             := ARock.Id_Rock;
    q1.FieldByName('Rock').AsString                 := ARock.Name;
    q1.FieldByName('RockIsMineralWealth').AsBoolean := ARock.IsMineralWealth;

    q1.FieldByName('RecordName').AsString           := ARecordName;
    q1.FieldByName('RecordNo').AsInteger            := ARecordNo;
    if ARecordNo mod 100 <> 0 then
      q1.FieldByName('IsChangeable').AsBoolean   := AIsChangeable
    else
      q1.FieldByName('IsChangeable').AsBoolean   := False;
    if AName<>'' then
      q1.FieldByName('Name').AsString            := AName
    else
      q1.FieldByName('Name').Clear;
    if (ARecordNo mod 100 <> 0)and(not (AValue<0.0)) then
      q1.FieldByName('Value').AsFloat            := AValue
    else
      q1.FieldByName('Value'). Clear;
    q1.Post;
  end;
var
  I,J,K: Integer;
  AShiftPlanRockQtn: Single;
  AShiftPlanRockQtn_sum: Single;
  AShiftPlanRockVm3: single;
  AShiftPlanRockVm3_sum: single;
  ARockVolume: ResaRockVolume;
  ARockVolume_sum: ResaRockVolume;
  _str: string;
  _RESARock: RESARock;
  //
  AVm3, AQt: double;
  AVm3_sum, AQt_sum: double;
  //
  _tmpQtn: double;
  _tmpPlan: double;
begin
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ������ �������������..');
  q0 := TADOQuery.Create(nil);
  q0.Connection := fmDM.ADOConnection;
  q1 := TADOQuery.Create(nil);
  q1.Connection := fmDM.ADOConnection;
  q1.SQL.Text := 'SELECT * FROM _ResultTechnologicAutoParams';
  q1.Open;
  //������ �� ������� �������������� --------------------------------------------------------------------
  q0.SQL.Text := Format('SELECT DISTINCT A.Id_DumpModel,A.DumpModel,'+
                        '                B.IsChangeable AS IsChangeable101,B.Name AS Name101,B.Value AS Value101,'+
                        '                C.IsChangeable AS IsChangeable102,C.Name AS Name102,C.Value AS Value102,'+
                        '                D.IsChangeable AS IsChangeable103,D.Name AS Name103,D.Value AS Value103,'+
                        '                E.IsChangeable AS IsChangeable201,E.Name AS Name201,E.Value AS Value201,'+
                        '                F.IsChangeable AS IsChangeable202,F.Name AS Name202,F.Value AS Value202 '+
                        'FROM _ResultShiftAutoReports A,_ResultShiftAutoReports B,'+
                        '     _ResultShiftAutoReports C,_ResultShiftAutoReports D,'+
                        '     _ResultShiftAutoReports E,_ResultShiftAutoReports F '+
                        'WHERE (A.Kind=2)and(A.Id_ResultShift=%d)and'+
                        '      (B.Id_DumpModel=A.Id_DumpModel)and(B.RecordNo=%d)and'+
                        '      (C.Id_DumpModel=A.Id_DumpModel)and(C.RecordNo=%d)and'+
                        '      (D.Id_DumpModel=A.Id_DumpModel)and(D.RecordNo=%d)and'+
                        '      (E.Id_DumpModel=A.Id_DumpModel)and(E.RecordNo=%d)and'+
                        '      (F.Id_DumpModel=A.Id_DumpModel)and(F.RecordNo=%d)',
                        [ResultId_Shift,CesaAutosGx.No,CesaAutosUdGx_gr_tkm.No,CesaAutosGxCtg.No,
                         CesaAutosUsedTyresCount.No,CesaAutosTyresCtg.No]);
  q0.Open;
  FGauge.MaxValue := q0.RecordCount;
  SetGaugeValue(0);
  while not q0.Eof do
  begin
    SetGaugeValue(FGauge.Progress+1);
    _Add('I', 100,CesaAutosFuel.Key);
    _Add('1', 101);
    _Add('2', 102);
    _Add('3', 103);
    _Add('II',200,CesaAutosTyres.Key);
    _Add('1', 201);
    _Add('2', 202);
    q0.Next;
  end;
  q0.Close;
  q1.Close;
  //������ �� ����� ������ ����� ------------------------------------------------------------------------
  // todo:    ���������� �� ������
  q1.SQL.Text := 'SELECT * FROM _ResultTechnologicRockParams';
  q1.Open;
  FGauge.MaxValue := Openpit.Rocks.Count;
  AShiftPlanRockQtn_sum:= 0.0;
  AShiftPlanRockVm3_sum:= 0.0;
  ARockVolume_sum:= esaRockVolume();
  AVm3_sum:= 0; AQt_sum:= 0;
  for I:= 0 to Openpit.Rocks.Count-1 do
  begin
    SetGaugeValue(I);
    AShiftPlanRockQtn:= 0.0;
    AShiftPlanRockVm3:= 0.0;
    //AShiftPlanRockQtn_sum:= 0.0;
    //AShiftPlanRockVm3_sum:= 0.0;
    ARockVolume       := esaRockVolume();
    for J := 0 to LoadingPunkts.Count-1 do
    begin
      for K := 0 to LoadingPunkts[J].RockCount-1 do
        if LoadingPunkts[J].Rocks[K].Rock.Id_Rock = Openpit.Rocks[I].Id_Rock then
        begin
          AShiftPlanRockQtn:= AShiftPlanRockQtn + (LoadingPunkts[J].FPeriodPlanQtn / 1000);
          AShiftPlanRockQtn_sum:= AShiftPlanRockQtn_sum + (LoadingPunkts[J].FPeriodPlanQtn / 1000);
          AShiftPlanRockVm3:= AShiftPlanRockVm3 + (LoadingPunkts[J].FPeriodPlanVm3 / 1000);
          AShiftPlanRockVm3_sum:= AShiftPlanRockVm3_sum + (LoadingPunkts[J].FPeriodPlanVm3 / 1000);
        end;
      for K := 0 to LoadingPunkts[J].Excavator.Events.Count-1 do
        if (LoadingPunkts[J].Excavator.Events[K].Rock.Id_Rock = Openpit.Rocks[I].Id_Rock) and
           (LoadingPunkts[J].Excavator.Events[K].Kind = eekLoading) then
        begin
          ARockVolume:= esaSum(ARockVolume, LoadingPunkts[J].Excavator.Events[K].RockVolume);
          ARockVolume_sum:= esaSum(ARockVolume_sum, LoadingPunkts[J].Excavator.Events[K].RockVolume);
        end;
    end;
    if Openpit.Rocks[I].IsMineralWealth then
    begin
      AVm3:= (ARockVolume.Vm3 + FCurrOreVm3) / 2;
      AQt:= (ARockVolume.Qtn + FCurrOreQtn) / 2;

      _str:= format('�������� ����� (%s) Q, �', [Openpit.Rocks[I].Name]);
      //_Add(Openpit.Rocks[I], '1', 101, True, _str, AShiftPlanRockQtn_sum / 620.5 * 1000);
      _Add(Openpit.Rocks[I], '1', 101, True, _str, AShiftPlanRockQtn);
    end
    else
    begin
      AVm3:= (ARockVolume.Vm3 + FCurrStrippingVm3) / 2;
      AQt:= (ARockVolume.Qtn + FCurrStrippingQtn) / 2;

      _str:= format('�������� ��� (%s) V, �3', [Openpit.Rocks[I].Name]);
      //_Add(Openpit.Rocks[I], '1', 101, True, _str, AShiftPlanRockQtn_sum / 620.5 * 1000);
      _Add(Openpit.Rocks[I], '1', 101, True, _str, AShiftPlanRockVm3);
    end;
    AVm3_sum:= AVm3_sum + AVm3;
    AQt_sum:= AQt_sum + AQt;

    _str:= format('����������� ����� (%s) V, �3', [Openpit.Rocks[I].Name]);
    _Add(Openpit.Rocks[I], '2', 102, True, _str, AVm3);
    _str:= format('����������� ��� (%s) Q, �', [Openpit.Rocks[I].Name]);
    _Add(Openpit.Rocks[I], '3', 103, True, _str, AQt);

    _tmpQtn:= 100 * AQt;
    //_tmpPlan:= AShiftPlanRockQtn_sum / 620.5 * 1000;
    _tmpPlan:= AShiftPlanRockQtn;
    if AShiftPlanRockQtn > 0.0 then
      _Add(Openpit.Rocks[I], '4', 104, False, '������������ �����, %', _tmpQtn / _tmpPlan)
    else
      _Add(Openpit.Rocks[I],'4',104,False,'������������ �����, %',0.0);
  end;
  // summ
  _RESARock.Id_Rock:= 100;
  _RESARock.Name:= '������ �����';
  _RESARock.IsMineralWealth:= false;
  _str:= format('�������� ����� (%s) V, �3', ['������ �����']);
  //_Add(_RESARock, '1', 101, True, _str, AShiftPlanRockVm3_sum / 620.5 * 1000);
  _Add(_RESARock, '1', 101, True, _str, AShiftPlanRockVm3_sum);
  _str:= format('����������� ����� (%s) V, �3', ['������ �����']);
  _Add(_RESARock, '2', 102, True, _str, AVm3_sum);
  _str:= format('����������� ��� (%s) Q, �', ['������ �����']);
  _Add(_RESARock, '3', 103, True, _str, AQt_sum);
  _str:= '������������ �����, %';
  //
  _tmpQtn:= 100 * AVm3_sum;
  //_tmpPlan:= AShiftPlanRockVm3_sum / 620.5 * 1000;
  _tmpPlan:= AShiftPlanRockVm3_sum;

  _Add(_RESARock, '4', 104, False, _str, _tmpQtn / _tmpPlan);
  //
  q0.Free;
  q1.Free;
  SetGaugeValue(FGauge.MaxValue);
  FOpenpit.SendMessage('Ok');
end;{SavePeriodResultsNew}
//���������� � �� ����������� ������������� �� ������������
procedure TDispatcher.SaveBlocksResultsNew;
const
  GxPkg_l = 0.84; //��������� ����������, ��/�
  T = True; F = False;
  procedure _AddReport(const AQuery: TADOQuery; const AKind: Integer; const AItem: TesaResultBlock);
    procedure _Add(const q: TADOQuery; const ARecName: String; const AKey: ResaKeyParams; ANum: Single; const ADen: Single=-1.0);
    var I: Integer;
    begin
      //������������� Value
      if not(ADen<0.0) then if ADen>0.0 then ANum := ANum/ADen else ANum := 0.0;
      //��������� � ��
      q.Append;
      for I := 1 to q.Fields.Count-1 do
        q.Fields[I].Clear;
      q.FieldByName('Id_ResultShift').AsInteger               := ResultId_Shift;
      if AKind = 1
      then q.FieldByName('Id_ResultShiftBlock').AsInteger     := AItem.Id_ResultShiftBlock;
      if AKind = 2
      then q.FieldByName('Id_RoadCoat').AsInteger             := AItem.Id_RoadCoat;
      if AKind = 2
      then q.FieldByName('RoadCoat').AsString                 := AItem.RoadCoat;
      q.FieldByName('Lsm').AsInteger                          := AItem.Lsm;
      q.FieldByName('Kind').AsInteger                         := AKind;
      q.FieldByName('IsChangeable').AsBoolean                 := AKey.IsChangeable;
      q.FieldByName('RecordNo').AsInteger                     := AKey.No;
      q.FieldByName('RecordName').AsString                    := ARecName;
      q.FieldByName('Name').AsString                          := AKey.Key;
      if ANum>-1.0
      then q.FieldByName('Value').AsFloat                     := ANum;
      q.Post;
    end;{_Add}
  begin
    with AItem do
    begin
      //�������������� ���������
      _Add(AQuery,  'I',CesaBlocksQuantity,-1.0);
      _Add(AQuery,  '1',CesaBlocksBlocksCount,BlocksCount);
      _Add(AQuery,  '2',CesaBlocksLm,Lsm,100);
      _Add(AQuery,  '3',CesaBlocksRock,-1.0);
      _Add(AQuery,  '4',CesaBlocksRockVm3,RockVolume.Vm3);
      _Add(AQuery,  '5',CesaBlocksRockQtn,RockVolume.Qtn);
      _Add(AQuery,  '6',CesaBlocksAutosCount,esaSummary(AutosCount));
      _Add(AQuery,  '7',CesaBlocksAutosCountNulled,AutosCount.Nulled);
      _Add(AQuery,  '8',CesaBlocksAutosCountLoading,AutosCount.Loading);
      _Add(AQuery,  '9',CesaBlocksAutosCountUnLoading,AutosCount.UnLoading);
      _Add(AQuery, '10',CesaBlocksWaitingsCount,esaSummary(WaitingsCount));
      _Add(AQuery, '11',CesaBlocksWaitingsCountNulled,WaitingsCount.Nulled);
      _Add(AQuery, '12',CesaBlocksWaitingsCountLoading,WaitingsCount.Loading);
      _Add(AQuery, '13',CesaBlocksWaitingsCountUnLoading,WaitingsCount.UnLoading);
      _Add(AQuery, '14',CesaBlocksAvgVkmh,AvgVkmhNulled.Num+AvgVkmhLoading.Num+AvgVkmhUnLoading.Num,AvgVkmhNulled.Den+AvgVkmhLoading.Den+AvgVkmhUnLoading.Den);
      _Add(AQuery, '15',CesaBlocksAvgVkmhNulled,AvgVkmhNulled.Num,AvgVkmhNulled.Den);
      _Add(AQuery, '16',CesaBlocksAvgVkmhLoading,AvgVkmhLoading.Num,AvgVkmhLoading.Den);
      _Add(AQuery, '17',CesaBlocksAvgVkmhUnLoading,AvgVkmhUnLoading.Num,AvgVkmhUnLoading.Den);
      //�����
      _Add(AQuery, 'II',CesaBlocksTime,-1.0);
      _Add(AQuery,  '1',CesaBlocksMovingAvgTmin,MovingAvgTminNulled.Num+MovingAvgTminLoading.Num+MovingAvgTminUnLoading.Num,MovingAvgTminNulled.Den+MovingAvgTminLoading.Den+MovingAvgTminUnLoading.Den);
      _Add(AQuery,  '2',CesaBlocksMovingAvgTminNulled,MovingAvgTminNulled.Num,MovingAvgTminNulled.Den);
      _Add(AQuery,  '3',CesaBlocksMovingAvgTminLoading,MovingAvgTminLoading.Num,MovingAvgTminLoading.Den);
      _Add(AQuery,  '4',CesaBlocksMovingAvgTminUnLoading,MovingAvgTminUnLoading.Num,MovingAvgTminUnLoading.Den);
      _Add(AQuery,  '5',CesaBlocksWaitingAvgTmin,WaitingAvgTminNulled.Num+WaitingAvgTminLoading.Num+WaitingAvgTminUnLoading.Num,WaitingAvgTminNulled.Den+WaitingAvgTminLoading.Den+WaitingAvgTminUnLoading.Den);
      _Add(AQuery,  '6',CesaBlocksWaitingAvgTminNulled,WaitingAvgTminNulled.Num,WaitingAvgTminNulled.Den);
      _Add(AQuery,  '7',CesaBlocksWaitingAvgTminLoading,WaitingAvgTminLoading.Num,WaitingAvgTminLoading.Den);
      _Add(AQuery,  '8',CesaBlocksWaitingAvgTminUnLoadung,WaitingAvgTminUnLoading.Num,WaitingAvgTminUnLoading.Den);
      _Add(AQuery,  '9',CesaBlocksEmploymentCoef,EmploymentCoef);
      //������ �������
      _Add(AQuery,'III',CesaBlocksFuel,-1.0);
      _Add(AQuery,  '1',CesaBlocksGx,esaSummary(Gx));
      _Add(AQuery,  '2',CesaBlocksGxNulled,Gx.Nulled);
      _Add(AQuery,  '3',CesaBlocksGxLoading,Gx.Loading);
      _Add(AQuery,  '4',CesaBlocksGxUnLoading,Gx.UnLoading);
      _Add(AQuery,  '5',CesaBlocksUdGx_l_m,UdGx_l_m);
      //����������� ���������
      _Add(AQuery, 'IV',CesaBlocksCosts,-1.0);
      _Add(AQuery,  '1',CesaBlocksRepairCtg,RepairCtg);
      _Add(AQuery,  '2',CesaBlocksAmortizationCtg,AmortizationCtg);
      _Add(AQuery,  '3',CesaBlocksBuildingCtg,BuildingCtg);
      _Add(AQuery,  '4',CesaBlocksCtg,Ctg);
    end;{with}
  end;{_AddReport}
var
  quBlocks       : TADOQuery;
  quReps         : TADOQuery;
  _BEv           : TesaResultBlockEvent;
  I,J            : Integer;
  _Models        : TesaResultBlockModels;
  _B             : TesaResultBlock;
  ABlocksCount   : Integer;
begin
  if ResultId_Shift<1 then Exit;
  SetGaugeValue(0);
  FOpenpit.SendMessage('���������� ����������� ������������� �� ����������..');

  quBlocks := TADOQuery.Create(nil);
  quBlocks.Connection := DBConnection;
  quBlocks.SQL.Text := 'SELECT * FROM _ResultShiftBlocks';
  //----------------------------------------------------------------------------
  // I. �������� ��� ������, �������� �������������, �������
  //----------------------------------------------------------------------------
  _Models := TesaResultBlockModels.Create(Self);
  try
    quBlocks.Open;
    FGauge.MaxValue := Blocks.Count;
    for I := 0 to Blocks.Count-1 do
    begin
      SetGaugeValue(I);
      //�������� ������������ --------------------------------------------------
      quBlocks.Append;
      quBlocks.FieldByName('Id_ResultShift').AsInteger   := ResultId_Shift;
      quBlocks.FieldByName('Id_Block').AsInteger         := Blocks[I].Id_Block;
      quBlocks.FieldByName('Id_RoadCoat').AsInteger      := Blocks[I].RoadCoat.Id_RoadCoat;
      quBlocks.FieldByName('RoadCoat').AsString          := Blocks[I].RoadCoat.Name;
      quBlocks.FieldByName('Lsm').AsInteger              := Blocks[I].FLsm;
      quBlocks.FieldByName('BuildingC1000tg').AsFloat    := 1000*Blocks[I].RoadCoat.BuildingC1000tn*Blocks[I].BlockLsm*(1E-5);
      quBlocks.FieldByName('KeepingYearC1000tg').AsFloat := 1000*Blocks[I].RoadCoat.KeepingYearC1000tn*Blocks[I].BlockLsm*(1E-5)*Openpit.Shift.Tmin/(365*24*60);
      quBlocks.FieldByName('AmortizationR').AsFloat      := 1000*Blocks[I].RoadCoat.BuildingC1000tn*Blocks[I].BlockLsm*(1E-5)*Blocks[I].RoadCoat.AmortizationR*Openpit.Shift.Tmin/(365*24*60);
      quBlocks.Post;
      //�������� ������������ --------------------------------------------------
      _B                          := TesaResultBlock.Create(Self);
      _B.FBlock                   := Blocks[I];
      _B.FId_ResultShift          := ResultId_Shift;
      _B.FId_ResultShiftBlock     := quBlocks.FieldByName('Id_ResultShiftBlock').AsInteger;
      _B.FId_RoadCoat             := Blocks[I].RoadCoat.Id_RoadCoat;
      _B.FRoadCoat                := Blocks[I].RoadCoat.Name;
      _B.FBuildingCtg             := quBlocks.FieldByName('BuildingC1000tg').AsFloat;
      _B.FRepairCtg               := quBlocks.FieldByName('KeepingYearC1000tg').AsFloat;
      _B.FAmortizationCtg         := quBlocks.FieldByName('AmortizationR').AsFloat;
      _B.FBlocksCount             := 1;
      _B.FLsm                     := Blocks[I].FLsm;
      //������� ----------------------------------------------------------------
      for J := 0 to Blocks[I].Events.Count-1 do
      begin
        _BEv                         := Blocks[I].Events[J];
        _B.FRockVolume               := esaSum(_B.RockVolume,_BEv.RockVolume);

        _B.FAutosCount               := esaSum(_B.AutosCount,_BEv.AutosCount);
        _B.FWaitingsCount            := esaSum(_B.WaitingsCount,_BEv.WaitingsCount);

        _B.FAvgVkmhNulled            := esaSum(_B.AvgVkmhNulled,_BEv.VkmhNulled);
        _B.FAvgVkmhLoading           := esaSum(_B.AvgVkmhLoading,_BEv.VkmhLoading);
        _B.FAvgVkmhUnLoading         := esaSum(_B.AvgVkmhUnLoading,_BEv.VkmhUnLoading);

        _B.FMovingAvgTminNulled      := esaSum(_B.MovingAvgTminNulled,_BEv.MovingTminNulled);
        _B.FMovingAvgTminLoading     := esaSum(_B.MovingAvgTminLoading,_BEv.MovingTminLoading);
        _B.FMovingAvgTminUnLoading   := esaSum(_B.MovingAvgTminUnLoading,_BEv.MovingTminUnLoading);

        _B.FWaitingAvgTminNulled      := esaSum(_B.WaitingAvgTminNulled,_BEv.WaitingTminNulled);
        _B.FWaitingAvgTminLoading     := esaSum(_B.WaitingAvgTminLoading,_BEv.WaitingTminLoading);
        _B.FWaitingAvgTminUnLoading   := esaSum(_B.WaitingAvgTminUnLoading,_BEv.WaitingTminUnLoading);

        _B.FGx.Nulled                := _B.Gx.Nulled + _BEv.MovingGx.Nulled + _BEv.WaitingGx.Nulled;
        _B.FGx.Loading               := _B.Gx.Loading + _BEv.MovingGx.Loading + _BEv.WaitingGx.Loading;
        _B.FGx.UnLoading             := _B.Gx.UnLoading + _BEv.MovingGx.UnLoading + _BEv.WaitingGx.UnLoading;
        //�������� ������� -----------------------------------------------------
      end;{for}
      _Models.Append(_B);
    end;{for}
    quBlocks.Close;
    _Models.Update;

    //--------------------------------------------------------------------------
    // II. �������� Report1,Report2,Report3
    //--------------------------------------------------------------------------
    quReps := TADOQuery.Create(nil);
    quReps.Connection := DBConnection;
    quReps.SQL.Text := 'SELECT * FROM _ResultShiftBlockReports';
    quReps.Open;
    ABlocksCount:= 0;
    for I := 0 to _Models.Count-1 do
    begin
      FGauge.MaxValue := _Models[I].Count;
      for J := 0 to _Models[I].Count-1 do
      begin
        SetGaugeValue(J);
        _AddReport(quReps,1,_Models[I][J]);
        Inc(ABlocksCount);
      end;{for}
      _AddReport(quReps,2,_Models[I]);
    end;{for}
    _AddReport(quReps,3,_Models);
    quReps.Free;
    Variant.SaveBlocks(ABlocksCount,_Models.Lsm,_Models.RockVolume,_Models.AutosCount,_Models.WaitingsCount,
      _Models.AvgVkmhNulled,_Models.AvgVkmhLoading,_Models.AvgVkmhUnLoading,_Models.MovingAvgTminNulled,
      _Models.MovingAvgTminLoading,_Models.MovingAvgTminUnLoading,_Models.WaitingAvgTminNulled,
      _Models.WaitingAvgTminLoading,_Models.WaitingAvgTminUnLoading,_Models.EmploymentCoef,_Models.Gx,
      _Models.UdGx_l_m,_Models.RepairCtg,_Models.AmortizationCtg);
    SetGaugeValue(FGauge.MaxValue);
    FOpenpit.SendMessage('Ok');
  finally
    _Models.Free;
  end;{try}
  quBlocks.Free;
end;{SaveBlocksResultsNew}

function TDispatcher.DefineW0HkH(const ARoadCoat: TesaRoadCoat; const AutoQtn,RockQtn: Single): Single;
var
  Ptn0,Ptn1,Value0,Value1: Single;
  I: Integer;
begin
  Result := 0.0;
  if (ARoadCoat<>nil)and(ARoadCoat.Count>0) then
  begin
    Ptn0  := 0.0;
    Value0:= 0.0;
    //�������� �� ���������� ��������� Ptn
    
    if AutoQtn>ARoadCoat[ARoadCoat.Count-1].Ptn then
    begin
      I := ARoadCoat.Count-1;
      Ptn1  := ARoadCoat[I].Ptn;
      if AutoQtn<=40.0
      then Value1:= ARoadCoat[I].WminHkH
      else
      if AutoQtn>=110.0
      then Value1:= ARoadCoat[I].WmaxHkH
      else Value1:= ARoadCoat[I].WavgHkH;
      Dec(I);
      if I<0 then I := 0;
      Ptn0  := ARoadCoat[I].Ptn;
      if AutoQtn<=40.0
      then Value0:= ARoadCoat[I].WminHkH
      else
      if AutoQtn>=110.0
      then Value0:= ARoadCoat[I].WmaxHkH
      else Value0:= ARoadCoat[I].WavgHkH;
      Result := Value0+(Value1-Value0)*(AutoQtn-Ptn0)/Max((Ptn1-Ptn0),1.0);
    end{if}
    else
    begin
      //�������� �� ���������� ��������� Ptn
      for I := 1 to ARoadCoat.Count-1 do
      begin
        Ptn1  := ARoadCoat[I].Ptn;
        if AutoQtn<=40.0
        then Value1:= ARoadCoat[I].WminHkH
        else
        if AutoQtn>=110.0
        then Value1:= ARoadCoat[I].WmaxHkH
        else Value1:= ARoadCoat[I].WavgHkH;
        if InRange(AutoQtn,Ptn0,Ptn1) then
        begin
          Result := Value0+(Value1-Value0)*(AutoQtn-Ptn0)/Max((Ptn1-Ptn0),1.0);
          Break;
        end;{if}
        Ptn0 := Ptn1;
        Value0 := Value1;
      end;{for}
    end;{else}
    //��� ������� �������������� ���������� �� 20%
    if RockQtn<0.01 then Result := Result*1.2;
  end;{if}
end;{DefineW0HkH}
//��������� ��������� ������������� ��������, ��.��
function TDispatcher.DefineAydarSumSoprotiv_(const ARoadCoat: TesaRoadCoat;
                                             const Ptn,Q, Vkmh, i_: Single): Single;
var
  P0,Value0,Value1,percent_minus: Single;
  I: Integer;
begin
  Value0 := 0.0;
  Value1 := 0.0;
  P0 := 0.0;
  if ARoadCoat<>nil then
  for I := 0 to ARoadCoat.Count-1 do
  if InRange(Ptn,P0,ARoadCoat[I].Ptn) then
  begin
    Value0 := ARoadCoat[I].WminHkH;//kH/�
    Value1 := ARoadCoat[I].WmaxHkH;//kH/�
    Break;
  end{if}
  else P0 := ARoadCoat[I].Ptn;

  // ������� �������� W0 � ������������ �� ��������� ��������
  // �������������
  // ��������� ������ : |x2 - x1   y2 - y1|
  //                    |x  - x1   y  - y1| = 0
  //  (x2-x1)*(y-y1) - (y2-y1)*(x-x1) = 0
  // x1 = 15; x2 = 20 ��/���
  // y1 = V1; y2 = V2 ��/�
  // ATrucks[NumberAuto].Speed
  Result := ((Value1-Value0)*(Vkmh-15.0) / (20.0-15.0) ) + Value0;
  // ���� ������������ ��������, �� �������� W0 ����������� ��
  // 15-29% � ����������� �� ��������
  // x1 = 15; x2 = 20 ��/���
  // y1 = 15%; y2 = 29%
  // ATrucks[NumberAuto].Speed
  if Q < 1.0 then
  begin
    percent_minus := ( (29.0-15.0)*(Vkmh-15.0) / (20.0-15.0) ) + 15.0;
    Result := Result + (percent_minus/100)*Result;
  end;{if}
  if Result <= 0 then Result := 1.0;
  Result := Result*0.1;//� %
  Result := (Result+(i_*0.1))*0.01;//� ��.��������
end;{DefineAydarSumSoprotiv_}

// ������ ��c���� ������� ���������������
function TDispatcher.DefineAydarGx_(AAuto: TesaAuto;dLmtr,Vkmh,SumSoprotiv,dTsec: Single): Single;
var
  A, N : Double;   // ������, N - ����������� ��������
  Ptn : Double;
  Etalon : Double;
  Ga,Ggm,KPDfact: Single;
begin
  //������ ����� ����, �
  Ga := AAuto.Model.Ptn; Ggm := AAuto.FCurrRockVolume.Qtn;
  KPDfact := AAuto.FTransmissionKPD;
  Ptn := Ga + Ggm;
  // 1 �.�. = 0,736 ���   (1 �.�. = 736 ��)
  // 1 ���� = 4186,8 ��
  // 8500 ����/� - ������������ ����������� ���������� �������
  N := ( (Ptn*1000.0) * SumSoprotiv * Vkmh / 273.75 ) * 736;   // ��
  A := N * dTsec;   // ��

  if A > 0 then
    // � �������� ��� ������ > 0
    // 0.4 - ��� ���������
    Result := A / (4186.8 * 8500.0 * KPDfact * 0.4)
  else
  begin
    // � ������� ��� ��� �������� ����
    N := ( (Ggm * 1000.0) * 0.1 * 20.0 / 273.75 ) * 736;   // ��
    A := N * dTsec;   // ��
    Etalon := A / (4186.8 * 8500.0 * KPDfact * 0.4);
    Result := 0.1 * Etalon;
  end;
end;{DefineAydarGx_}

//�������� ������ �� ������������� ---------------------------------------------
//�������� ������ �������, �/���
function TesaResultAuto.GetUdGx_gr_tkm(): Single;
const GxPkg_l = 0.84; //��������� ����������, ��/�
begin
  if LoadingSkmRockQtn>0.0
  then Result := (DirGx.Loading+DirGx.UnLoading)*1000*GxPkg_l/LoadingSkmRockQtn
  else Result := 0.0;
end;{GetUdGx_gr_tkm}
constructor TesaResultAuto.Create(ADispatcher: TDispatcher);
begin
  inherited Create;
  FDispatcher        := ADispatcher;
  FAuto              := nil;
  FId_ResultShift    := 0;
  FAutosCount        := 0;
  FId_ResultShiftAuto:= 0;
  FId_DumpModel1     := 0;
  FDumpModel         := '';
  FTripsCount        := esaDirectionValue();
  FRockVolume        := esaRockVolume();
  FSm                := esaDirectionValue();
  FWAvgSkmLoading    := esaDrobValue();
  FWAvgHm            := esaDrobValue();
  FAvgVkmh           := esaDrobValue();
  FAvgVkmhNulled     := esaDrobValue();
  FAvgVkmhLoading    := esaDrobValue();
  FAvgVkmhUnLoading  := esaDrobValue();
  FGx                := esaWorkValue();
  FDirGx             := esaDirectionValue();
  FLoadingSkmRockQtn := 0.0;
  FTsec              := esaTmin();
  FDirTsec           := esaDirectionValue();
  FUsedTyresCount    := 0.0;
  FSumTyresCtg       := 0.0;
  FSumGxCtg          := esaWorkValue();
  FSumExploatationCtg:= esaWorkValue();
  FSumSparesGxCtg    := esaWorkValue();
  FSumMaterialsGxCtg := esaWorkValue();
  FSumMaintenanceCtg := esaWorkValue();
  FSumSalaryCtg      := esaWorkValue();
  FSumAmortizationCtg:= 0.0;
end;{Create}
destructor TesaResultAuto.Destroy; 
begin
  FAuto              := nil;
  FDispatcher        := nil;
  inherited;
end;{Destroy}

//�������� ������ �� ������ �������������� -------------------------------------
function TesaResultAutoModel.GetItem(const Index: Integer): TesaResultAuto;
begin
  if InRange(Index,0,FCount-1)
  then Result := TesaResultAuto(FItems[Index])
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultAutoModel.GetLast: TesaResultAuto;
begin
  if FCount>0
  then Result := TesaResultAuto(FItems.Last)
  else Result := nil;
end;{GetLast}
procedure TesaResultAutoModel.Append(const AAuto: TesaResultAuto);
begin
  if not Assigned(FItems) then FItems := TList.Create;
  FItems.Add(AAuto);
  FCount := FItems.Count;
  Inc(FAutosCount);
end;{Append}
procedure TesaResultAutoModel.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      TesaResultAuto(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
constructor TesaResultAutoModel.Create;
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaResultAutoModel.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//�������� ������ �� ������ �������������� -----------------------------------
function TesaResultAutoModels.GetItem(const Index: Integer): TesaResultAutoModel;
begin
  if InRange(Index,0,FCount-1)
  then Result := TesaResultAutoModel(FItems[Index])
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultAutoModels.GetLast: TesaResultAutoModel;
begin
  if FCount>0
  then Result := TesaResultAutoModel(FItems.Last)
  else Result := nil;
end;{GetLast}
procedure TesaResultAutoModels.Append(const AAuto: TesaResultAuto);
var
  AItem: TesaResultAutoModel;
  AIndex: Integer;
begin
  AAuto.FAutosCount := 1;
  AIndex := IndexOf(AAuto.Id_DumpModel1);
  if AIndex=-1 then
  begin
    AItem := TesaResultAutoModel.Create(FDispatcher);
    AItem.FId_DumpModel1 := AAuto.Id_DumpModel1;
    AItem.FDumpModel := AAuto.DumpModel;
    if not Assigned(FItems) then FItems := TList.Create;
    FItems.Add(AItem);
    FCount := FItems.Count;
  end{if}
  else AItem := Items[AIndex];
  AItem.Append(AAuto);
  Inc(FAutosCount);
end;{Append}
procedure TesaResultAutoModels.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      TesaResultAutoModel(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
procedure TesaResultAutoModels.Update;
const AMonthTmin = 30*24*60; //����������������� �������� ������, ���
var
  I,J                 : Integer;
  AShiftTmin          : Integer;       //����������������� �����, ��� (720 ���)
  AMonthSalaryCtg     : Single;        //�������� ��������, ��/���
  AMonthMaintenanceCtg: Single;        //������� �� ���������� ���������� ��������� ��� �������������, ��/���
  AWorkCount              : Integer;
begin
  AShiftTmin      := Dispatcher.Openpit.Shift.Tmin;
  AMonthSalaryCtg := Dispatcher.Openpit.Common.AutoDriverSalary.Ctg*Dispatcher.Openpit.Common.SalaryCoef;
  //I. ����������� �������������� ���������� ��������������, �������, ��������� ---------------
  FDispatcher.SetGaugeValue(0);
  FDispatcher.FGauge.MaxValue := Count;
  for I := 0 to Count-1 do //�� �������
  begin
    FDispatcher.SetGaugeValue(I);
    AWorkCount := 0;
    for J := 0 to Items[I].Count-1 do //�� ��������������
      if Items[I][J].Auto.FWorkState
      then Inc(AWorkCount);
    for J := 0 to Items[I].Count-1 do //�� ��������������
    begin
      //���������
      if Items[I][J].Auto.FWorkState then
      begin
        Items[I][J].FSumSparesGxCtg.Work        := 0.01*Items[I][J].Auto.Model.SparesCpercent*Items[I][J].SumGxCtg.Work;
        Items[I][J].FSumSparesGxCtg.Waiting     := 0.01*Items[I][J].Auto.Model.SparesCpercent*Items[I][J].SumGxCtg.Waiting;
        Items[I][J].FSumMaterialsGxCtg.Work     := 0.01*Items[I][J].Auto.Model.MaterialsCpercent*Items[I][J].SumGxCtg.Work;
        Items[I][J].FSumMaterialsGxCtg.Waiting  := 0.01*Items[I][J].Auto.Model.MaterialsCpercent*Items[I][J].SumGxCtg.Waiting;
        AMonthMaintenanceCtg                    := 1000*Items[I][J].Auto.Model.MaintenanceMonthC1000tg/AWorkCount;
        Items[I][J].FSumMaintenanceCtg.Work     := AMonthMaintenanceCtg/AMonthTmin*Max(0.0,AShiftTmin-Items[I].Tsec.Waiting/60);
        Items[I][J].FSumMaintenanceCtg.Waiting  := AMonthMaintenanceCtg/AMonthTmin*(Items[I].Tsec.Waiting/60);
        Items[I][J].FSumSalaryCtg.Work          := AMonthSalaryCtg/AMonthTmin*Max(0.0,AShiftTmin-Items[I].Tsec.Waiting/60);
        Items[I][J].FSumSalaryCtg.Waiting       := AMonthSalaryCtg/AMonthTmin*(Items[I].Tsec.Waiting/60);
      end{if}
      else
      begin
        Items[I][J].FSumSparesGxCtg             := esaWorkValue();
        Items[I][J].FSumMaterialsGxCtg          := esaWorkValue();
        Items[I][J].FSumMaintenanceCtg          := esaWorkValue();
        Items[I][J].FSumSalaryCtg               := esaWorkValue();
      end;{else}
      Items[I][J].FSumExploatationCtg.Work    := Items[I][J].SumTyresCtg+Items[I][J].SumGxCtg.Work+Items[I][J].SumSalaryCtg.Work+Items[I][J].SumSparesGxCtg.Work+Items[I][J].SumMaterialsGxCtg.Work+Items[I][J].SumMaintenanceCtg.Work;
      Items[I][J].FSumExploatationCtg.Waiting := Items[I][J].SumGxCtg.Waiting+Items[I][J].SumSalaryCtg.Waiting+Items[I][J].SumSparesGxCtg.Waiting+Items[I][J].SumMaterialsGxCtg.Waiting+Items[I][J].SumMaintenanceCtg.Waiting;
      //�� �������
      Items[I].FTripsCount           := esaSum(Items[I].TripsCount,Items[I][J].TripsCount);
      Items[I].FRockVolume           := esaSum(Items[I].RockVolume,Items[I][J].RockVolume);
      Items[I].FSm                   := esaSum(Items[I].Sm,Items[I][J].Sm);
      Items[I].FWAvgHm               := esaSum(Items[I].WAvgHm,Items[I][J].WAvgHm);
      Items[I].FAvgVkmh              := esaSum(Items[I].AvgVkmh,Items[I][J].AvgVkmh);
      Items[I].FAvgVkmhNulled        := esaSum(Items[I].AvgVkmhNulled,Items[I][J].AvgVkmhNulled);
      Items[I].FAvgVkmhLoading       := esaSum(Items[I].AvgVkmhLoading,Items[I][J].AvgVkmhLoading);
      Items[I].FAvgVkmhUnLoading     := esaSum(Items[I].AvgVkmhUnLoading,Items[I][J].AvgVkmhUnLoading);
      Items[I].FWAvgSkmLoading       := esaSum(Items[I].WAvgSkmLoading,Items[I][J].WAvgSkmLoading);
      Items[I].FGx                   := esaSum(Items[I].Gx,Items[I][J].Gx);
      Items[I].FDirGx                := esaSum(Items[I].DirGx,Items[I][J].DirGx);
      Items[I].FTsec                 := esaSum(Items[I].Tsec,Items[I][J].Tsec);
      Items[I].FDirTsec              := esaSum(Items[I].DirTsec,Items[I][J].DirTsec);
      Items[I].FUsedTyresCount       := Items[I].UsedTyresCount+Items[I][J].UsedTyresCount;
      Items[I].FSumTyresCtg          := Items[I].SumTyresCtg+Items[I][J].SumTyresCtg;
      Items[I].FSumGxCtg             := esaSum(Items[I].SumGxCtg,Items[I][J].SumGxCtg);
      Items[I].FSumExploatationCtg   := esaSum(Items[I].SumExploatationCtg,Items[I][J].SumExploatationCtg);
      Items[I].FSumSparesGxCtg       := esaSum(Items[I].SumSparesGxCtg,Items[I][J].SumSparesGxCtg);
      Items[I].FSumMaterialsGxCtg    := esaSum(Items[I].SumMaterialsGxCtg,Items[I][J].SumMaterialsGxCtg);
      Items[I].FSumMaintenanceCtg    := esaSum(Items[I].SumMaintenanceCtg,Items[I][J].SumMaintenanceCtg);
      Items[I].FSumSalaryCtg         := esaSum(Items[I].SumSalaryCtg,Items[I][J].SumSalaryCtg);
      Items[I].FSumAmortizationCtg   := Items[I].SumAmortizationCtg+Items[I][J].SumAmortizationCtg;
      Items[I].FLoadingSkmRockQtn    := Items[I].LoadingSkmRockQtn+Items[I][J].LoadingSkmRockQtn;
    end;{for}
    //���������
    FTripsCount         := esaSum(TripsCount,Items[I].TripsCount);
    FRockVolume         := esaSum(RockVolume,Items[I].RockVolume);
    FSm                 := esaSum(Sm,Items[I].Sm);
    FWAvgHm             := esaSum(WAvgHm,Items[I].WAvgHm);
    FWAvgSkmLoading     := esaSum(WAvgSkmLoading,Items[I].WAvgSkmLoading);
    FAvgVkmh            := esaSum(AvgVkmh,Items[I].AvgVkmh);
    FAvgVkmhNulled      := esaSum(AvgVkmhNulled,Items[I].AvgVkmhNulled);
    FAvgVkmhLoading     := esaSum(AvgVkmhLoading,Items[I].AvgVkmhLoading);
    FAvgVkmhUnLoading   := esaSum(AvgVkmhUnLoading,Items[I].AvgVkmhUnLoading);
    FGx                 := esaSum(Gx,Items[I].Gx);
    FDirGx              := esaSum(DirGx,Items[I].DirGx);
    FTsec               := esaSum(Tsec,Items[I].Tsec);
    FDirTsec            := esaSum(DirTsec,Items[I].DirTsec);
    FUsedTyresCount     := UsedTyresCount+Items[I].UsedTyresCount;
    FSumTyresCtg        := SumTyresCtg+Items[I].SumTyresCtg;
    FSumGxCtg           := esaSum(SumGxCtg,Items[I].SumGxCtg);
    FSumExploatationCtg := esaSum(SumExploatationCtg,Items[I].SumExploatationCtg);
    FSumSparesGxCtg     := esaSum(SumSparesGxCtg,Items[I].SumSparesGxCtg);
    FSumMaterialsGxCtg  := esaSum(SumMaterialsGxCtg,Items[I].SumMaterialsGxCtg);
    FSumMaintenanceCtg  := esaSum(SumMaintenanceCtg,Items[I].SumMaintenanceCtg);
    FSumSalaryCtg       := esaSum(SumSalaryCtg,Items[I].SumSalaryCtg);
    FSumAmortizationCtg := SumAmortizationCtg+Items[I].SumAmortizationCtg;
    FLoadingSkmRockQtn  := LoadingSkmRockQtn+Items[I].LoadingSkmRockQtn;
  end;{for}
end;{Update}
function TesaResultAutoModels.IndexOf(const AId_DumpModel: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to Count-1 do
  if Items[I].Id_DumpModel1=AId_DumpModel then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
constructor TesaResultAutoModels.Create;
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaResultAutoModels.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//�������� ������ �� ����������� ---------------------------------------------
constructor TesaResultExcavator.Create(ADispatcher: TDispatcher);
begin
  inherited Create;
  FDispatcher             := ADispatcher;
  FExcavator              := nil;
  FId_ResultShift         := 0;
  FId_ResultShiftExcavator:= 0;
  FId_DumpModel          := 0;
  FDumpModel              := '';
  FExcavatorsCount        := 0;
  FLoadingAutosCount      := 0.0;
  FRockVolume             := esaRockVolume();
  FRockShiftPlan          := esaRockVolume();
  FSumGx                  := esaWorkValue();
  FSumTmin                := esaTmin();
  FSumExploatationCtg     := esaWorkValue();
  FSumGxCtg               := esaWorkValue();
  FSumUnAccountedCtg      := esaWorkValue();
  FSumMaterialsGxCtg      := esaWorkValue();
  FSumSalaryCtg           := esaWorkValue();
  FSumAmortizationCtg     := 0.0;
end;{Create}
destructor TesaResultExcavator.Destroy; 
begin
  FExcavator              := nil;
  FDispatcher             := nil;
  inherited;
end;{Destroy}

//�������� ������ �� ������ ������������ -------------------------------------
function TesaResultExcavatorModel.GetItem(const Index: Integer): TesaResultExcavator;
begin
  if InRange(Index,0,FCount-1)
  then Result := TesaResultExcavator(FItems[Index])
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultExcavatorModel.GetLast: TesaResultExcavator;
begin
  if FCount>0
  then Result := TesaResultExcavator(FItems.Last)
  else Result := nil;
end;{GetLast}
procedure TesaResultExcavatorModel.Append(const AExcavator: TesaResultExcavator);
begin
  if not Assigned(FItems) then FItems := TList.Create;
  FItems.Add(AExcavator);
  FCount := FItems.Count;
  Inc(FExcavatorsCount);
end;{Append}
procedure TesaResultExcavatorModel.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      TesaResultExcavator(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
constructor TesaResultExcavatorModel.Create;
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaResultExcavatorModel.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//�������� ������ �� ������ ������������ -----------------------------------
function TesaResultExcavatorModels.GetItem(const Index: Integer): TesaResultExcavatorModel;
begin
  if InRange(Index,0,FCount-1)
  then Result := TesaResultExcavatorModel(FItems[Index])
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultExcavatorModels.GetLast: TesaResultExcavatorModel;
begin
  if FCount>0
  then Result := TesaResultExcavatorModel(FItems.Last)
  else Result := nil;
end;{GetLast}
procedure TesaResultExcavatorModels.Append(const AExcavator: TesaResultExcavator);
var
  AItem: TesaResultExcavatorModel;
  AIndex: Integer;
begin
  AExcavator.FExcavatorsCount := 1;
  AIndex := IndexOf(AExcavator.Id_DumpModel);
  if AIndex=-1 then
  begin
    AItem := TesaResultExcavatorModel.Create(FDispatcher);
    AItem.FId_DumpModel := AExcavator.Id_DumpModel;
    AItem.FDumpModel     := AExcavator.DumpModel;
    if not Assigned(FItems) then FItems := TList.Create;
    FItems.Add(AItem);
    FCount := FItems.Count;
  end{if}
  else AItem := Items[AIndex];
  AItem.Append(AExcavator);
  Inc(FExcavatorsCount);
end;{Append}
procedure TesaResultExcavatorModels.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      TesaResultExcavatorModel(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
procedure TesaResultExcavatorModels.Update;
const AMonthTmin = 30*24*60; //����������������� �������� ������, ���
var
  I,J            : Integer;
  AEnergyCtg_kVth: Single; //��������� 1 ���*� �������, ��
  AShiftTmin          : Integer;       //����������������� �����, ��� (720 ���)
  AMonthSalaryCtg     : Single;        //�������� ��������, ��/���
  AShiftsCount   : Single;//���������� ���� � ������
begin
  AShiftsCount    := 24*60/Dispatcher.Openpit.Shift.Tmin;
  AShiftTmin      := Dispatcher.Openpit.Shift.Tmin;
  AMonthSalaryCtg := (Dispatcher.Openpit.Common.ExcavatorMashinistSalary.Ctg+
                      Dispatcher.Openpit.Common.ExcavatorAssistantSalary.Ctg)*Dispatcher.Openpit.Common.SalaryCoef;

  AEnergyCtg_kVth := FDispatcher.Openpit.Common.ExcavatorFuelCtg;
  //I. ����������� �������������� ���������� ������������, �������, ��������� ---------------
  FDispatcher.SetGaugeValue(0);
  FDispatcher.FGauge.MaxValue := Count;
  for I := 0 to Count-1 do //�� �������
  begin
    FDispatcher.SetGaugeValue(I);
    for J := 0 to Items[I].Count-1 do //�� ������������
    begin
      //���������
      if Items[I][J].Excavator.WorkState then
      begin
        Items[I][J].FSumGx.Work                 := Items[I][J].Excavator.Model.EngineMaxNkVt*
                                                   Items[I][J].Excavator.EngineKPD*
                                                   Items[I][J].Excavator.EngineKIM*
                                                   (Items[I][J].SumTmin.OnLoading)/60;
        Items[I][J].FSumGx.Waiting              := Items[I][J].Excavator.Model.EngineMaxNkVt*
                                                   Items[I][J].Excavator.EngineKPD*
                                                   Items[I][J].Excavator.EngineKIM*
                                                   (Items[I][J].SumTmin.Waiting+Items[I][J].SumTmin.Manevr)/60*0.1;
        Items[I][J].FSumTmin.Waiting            := AShiftTmin-Items[I][J].SumTmin.OnLoading-Items[I][J].SumTmin.Manevr;
        Items[I][J].FSumGxCtg.Work              := AEnergyCtg_kVth*Items[I][J].FSumGx.Work;
        Items[I][J].FSumGxCtg.Waiting           := AEnergyCtg_kVth*Items[I][J].FSumGx.Waiting;
        Items[I][J].FSumMaterialsGxCtg.Work     := 1000*Items[I][J].Excavator.AddMaterialsMonthC1000tg/AMonthTmin*Max(0.0,AShiftTmin-Items[I].SumTmin.Waiting);
        Items[I][J].FSumMaterialsGxCtg.Waiting  := 1000*Items[I][J].Excavator.AddMaterialsMonthC1000tg/AMonthTmin*(Items[I].SumTmin.Waiting);
        Items[I][J].FSumUnAccountedCtg.Work     := 1000*Items[I][J].Excavator.AddUnAccountedMonthC1000tg/AMonthTmin*Max(0.0,AShiftTmin-Items[I].SumTmin.Waiting);
        Items[I][J].FSumUnAccountedCtg.Waiting  := 1000*Items[I][J].Excavator.AddUnAccountedMonthC1000tg/AMonthTmin*(Items[I].SumTmin.Waiting);
        Items[I][J].FSumSalaryCtg.Work          := AMonthSalaryCtg/AMonthTmin*Max(0.0,AShiftTmin-Items[I].SumTmin.Waiting);
        Items[I][J].FSumSalaryCtg.Waiting       := AMonthSalaryCtg/AMonthTmin*(Items[I].SumTmin.Waiting);
        Items[I][J].FSumExploatationCtg.Work    := Items[I][J].SumGxCtg.Work+Items[I][J].SumSalaryCtg.Work+Items[I][J].SumMaterialsGxCtg.Work+Items[I][J].SumUnAccountedCtg.Work;
        Items[I][J].FSumExploatationCtg.Waiting := Items[I][J].SumGxCtg.Waiting+Items[I][J].SumSalaryCtg.Waiting+Items[I][J].SumMaterialsGxCtg.Waiting+Items[I][J].SumUnAccountedCtg.Waiting;
        Items[I][J].FRockShiftPlan              := esaRockVolume(Items[I][J].Excavator.LoadingPunkt.ShiftPlanVm3,Items[I][J].Excavator.LoadingPunkt.ShiftPlanQtn);
      end{if}
      else
      begin
        Items[I][J].FSumGx                      := esaWorkValue();
        Items[I][J].FSumTmin                    := esaTmin();
        Items[I][J].FSumGxCtg                   := esaWorkValue();
        Items[I][J].FSumMaterialsGxCtg          := esaWorkValue();
        Items[I][J].FSumUnAccountedCtg          := esaWorkValue();
        Items[I][J].FSumSalaryCtg               := esaWorkValue();
        Items[I][J].FSumExploatationCtg         := esaWorkValue();
        Items[I][J].FRockShiftPlan              := esaRockVolume();
      end;{else}
      Items[I][J].FSumAmortizationCtg         := (1000*Items[I][J].Excavator.C1000tg)*Items[I][J].Excavator.SENAmortizationRate/(Dispatcher.Openpit.Period.Tday*AShiftsCount);
     // Items[I][J].FSumAmortizationCtg         := (1000*Items[I][J].Excavator.C1000tg)*Dispatcher.Openpit.Common.ExcavatorAmortizationR/(Dispatcher.Openpit.Period.Tday*AShiftsCount);
      //�� �������
      Items[I].FLoadingAutosCount  := Items[I].LoadingAutosCount+Items[I][J].LoadingAutosCount;
      Items[I].FRockVolume         := esaSum(Items[I].RockVolume,Items[I][J].RockVolume);
      Items[I].FRockShiftPlan      := esaSum(Items[I].RockShiftPlan,Items[I][J].RockShiftPlan);
      Items[I].FSumGx              := esaSum(Items[I].SumGx,Items[I][J].SumGx);
      Items[I].FSumGxCtg           := esaSum(Items[I].SumGxCtg,Items[I][J].SumGxCtg);
      Items[I].FSumTmin            := esaSum(Items[I].SumTmin,Items[I][J].SumTmin);
      Items[I].FSumExploatationCtg := esaSum(Items[I].SumExploatationCtg,Items[I][J].SumExploatationCtg);
      Items[I].FSumMaterialsGxCtg  := esaSum(Items[I].SumMaterialsGxCtg,Items[I][J].SumMaterialsGxCtg);
      Items[I].FSumUnAccountedCtg  := esaSum(Items[I].SumUnAccountedCtg,Items[I][J].SumUnAccountedCtg);
      Items[I].FSumSalaryCtg       := esaSum(Items[I].SumSalaryCtg,Items[I][J].SumSalaryCtg);
      Items[I].FSumAmortizationCtg := Items[I].SumAmortizationCtg+Items[I][J].SumAmortizationCtg;
    end;{for}
    //���������
    FLoadingAutosCount  := LoadingAutosCount+Items[I].LoadingAutosCount;
    FRockVolume         := esaSum(RockVolume,Items[I].RockVolume);
    FRockShiftPlan      := esaSum(RockShiftPlan,Items[I].RockShiftPlan);
    FSumGx              := esaSum(SumGx,Items[I].SumGx);
    FSumGxCtg           := esaSum(SumGxCtg,Items[I].SumGxCtg);
    FSumTmin            := esaSum(SumTmin,Items[I].SumTmin);
    FSumExploatationCtg := esaSum(SumExploatationCtg,Items[I].SumExploatationCtg);
    FSumMaterialsGxCtg  := esaSum(SumMaterialsGxCtg,Items[I].SumMaterialsGxCtg);
    FSumUnAccountedCtg  := esaSum(SumUnAccountedCtg,Items[I].SumUnAccountedCtg);
    FSumSalaryCtg       := esaSum(SumSalaryCtg,Items[I].SumSalaryCtg);
    FSumAmortizationCtg := SumAmortizationCtg+Items[I].SumAmortizationCtg;
  end;{for}
end;{Update}
function TesaResultExcavatorModels.IndexOf(const AId_DumpModel: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to Count-1 do
  if Items[I].Id_DumpModel=AId_DumpModel then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
function TesaResultExcavatorModels.FindExcavatorOf(const AId_LoadingPunkt: Integer): TesaResultExcavator;
var I,J: Integer;
begin
  Result := nil;
  for I := 0 to Count-1 do
  for J := 0 to Items[I].Count-1 do
  if Items[I][J].Excavator.FLoadingPunkt.Id_LoadingPunkt=AId_LoadingPunkt then
  begin
    Result := Items[I][J]; Break;
  end;{for}
end;{FindExcavatorOf}
constructor TesaResultExcavatorModels.Create;
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaResultExcavatorModels.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//�������� ������ �� �� ---------------------------------------------------------------------------------
function TesaResultBlock.GetUdGx_l_m: Single;
begin
  if Lsm>0
  then Result := (Gx.Nulled+Gx.Loading+Gx.UnLoading)/(Lsm*0.01)
  else Result := 0.0;
end;{GetUdGx_l_m}
function TesaResultBlock.GetCtg: Single;
begin
  Result := RepairCtg+AmortizationCtg;
end;{GetCtg}
function TesaResultBlock.GetEmploymentCoef: Single;
begin
  if Dispatcher.FShiftTsec>0 then
  Result := (MovingAvgTminNulled.Num+MovingAvgTminLoading.Num+MovingAvgTminUnLoading.Num+
             WaitingAvgTminNulled.Num+WaitingAvgTminLoading.Num+WaitingAvgTminUnLoading.Num)/Dispatcher.Openpit.Shift.Tmin
  else Result := 0.0;
end;{GetEmploymentCoef}
constructor TesaResultBlock.Create(ADispatcher: TDispatcher);
begin
  inherited Create;
  FDispatcher                := ADispatcher;
  FBlock                     := nil;
  FId_ResultShift            := 0;
  FId_ResultShiftBlock       := 0;
  FId_RoadCoat               := 0;    
  FRoadCoat                  := '';
  //�������������� ����������
  FBlocksCount               := 1;    
  FLsm                       := 0;    
  FRockVolume                := esaRockVolume();     
  FAutosCount                := esaDirectionValue();
  FWaitingsCount             := esaDirectionValue();
  FAvgVkmhNulled             := esaDrobValue();
  FAvgVkmhLoading            := esaDrobValue();
  FAvgVkmhUnLoading          := esaDrobValue();
  //���������� ������������� �������� �������
  FMovingAvgTminNulled       := esaDrobValue();
  FMovingAvgTminLoading      := esaDrobValue();
  FMovingAvgTminUnLoading    := esaDrobValue();
  FWaitingAvgTminNulled      := esaDrobValue();
  FWaitingAvgTminLoading     := esaDrobValue();
  FWaitingAvgTminUnLoading   := esaDrobValue();
  //���������� ������� �������
  FGx                        := esaDirectionValue();
  //����������� ���������
  FRepairCtg                 := 0.0;
  FAmortizationCtg           := 0.0;
  FBuildingCtg               := 0.0;
end;{Create}
destructor TesaResultBlock.Destroy;
begin
  FBlock                  := nil;
  FDispatcher             := nil;
  inherited;
end;{Destroy}

//�������� ������ �� ������ �� --------------------------------------------------------------------------
function TesaResultBlockModel.GetItem(const Index: Integer): TesaResultBlock;
begin
  if InRange(Index,0,FCount-1)
  then Result := TesaResultBlock(FItems[Index])
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultBlockModel.GetLast: TesaResultBlock;
begin
  if FCount>0
  then Result := TesaResultBlock(FItems.Last)
  else Result := nil;
end;{GetLast}
procedure TesaResultBlockModel.Append(const ABlock: TesaResultBlock);
begin
  if not Assigned(FItems) then FItems := TList.Create;
  FItems.Add(ABlock);
  FCount := FItems.Count;
  Inc(FBlocksCount);
end;{Append}
procedure TesaResultBlockModel.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      TesaResultBlock(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
constructor TesaResultBlockModel.Create;
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaResultBlockModel.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}

//�������� ������ �� ���� �� ----------------------------------------------------------------------------
function TesaResultBlockModels.GetItem(const Index: Integer): TesaResultBlockModel;
begin
  if InRange(Index,0,FCount-1)
  then Result := TesaResultBlockModel(FItems[Index])
  else Raise Exception.Create(Format(EInvalidIndex,[Index, FCount-1]));
end;{GetItem}
function TesaResultBlockModels.GetLast: TesaResultBlockModel;
begin
  if FCount>0
  then Result := TesaResultBlockModel(FItems.Last)
  else Result := nil;
end;{GetLast}
procedure TesaResultBlockModels.Append(const ABlock: TesaResultBlock);
var
  AItem: TesaResultBlockModel;
  AIndex: Integer;
begin
  ABlock.FBlocksCount := 1;
  AIndex := IndexOf(ABlock.Id_RoadCoat);
  if AIndex=-1 then
  begin
    AItem := TesaResultBlockModel.Create(FDispatcher);
    AItem.FId_RoadCoat := ABlock.Id_RoadCoat;
    AItem.FRoadCoat := ABlock.RoadCoat;
    if not Assigned(FItems) then FItems := TList.Create;
    FItems.Add(AItem);
    FCount := FItems.Count;
  end{if}
  else AItem := Items[AIndex];
  AItem.Append(ABlock);
  Inc(FBlocksCount);
end;{Append}
procedure TesaResultBlockModels.Clear;
var I: Integer;
begin
  FCount := 0;
  if Assigned(FItems) then
  begin
    for I := FItems.Count-1 downto 0 do
      TesaResultBlockModel(FItems[I]).Free;
    FItems.Free;
    FItems := nil;
  end;{if}
end;{Clear}
procedure TesaResultBlockModels.Update;
var I,J: Integer;
begin
  //I. ����������� �������������� ���������� ������������, �������, ��������� ---------------
  FDispatcher.SetGaugeValue(0);
  FDispatcher.FGauge.MaxValue := Count;
  for I := 0 to Count-1 do //�� �������
  begin
    FDispatcher.SetGaugeValue(I);
    for J := 0 to Items[I].Count-1 do //�� ������������
    begin
      //���������
      //�� �������
      Items[I].FBlocksCount               := Items[I].BlocksCount + Items[I][J].BlocksCount;
      Items[I].FLsm                       := Items[I].Lsm + Items[I][J].Lsm;
      Items[I].FRockVolume                := esaSum(Items[I].RockVolume,Items[I][J].RockVolume);
      Items[I].FAutosCount                := esaSum(Items[I].AutosCount,Items[I][J].AutosCount);
      Items[I].FWaitingsCount             := esaSum(Items[I].WaitingsCount,Items[I][J].WaitingsCount);
      Items[I].FAvgVkmhNulled             := esaSum(Items[I].AvgVkmhNulled,Items[I][J].AvgVkmhNulled);
      Items[I].FAvgVkmhLoading            := esaSum(Items[I].AvgVkmhLoading,Items[I][J].AvgVkmhLoading);
      Items[I].FAvgVkmhUnLoading          := esaSum(Items[I].AvgVkmhUnLoading,Items[I][J].AvgVkmhUnLoading);
      Items[I].FMovingAvgTminNulled       := esaSum(Items[I].MovingAvgTminNulled,Items[I][J].MovingAvgTminNulled);
      Items[I].FMovingAvgTminLoading      := esaSum(Items[I].MovingAvgTminLoading,Items[I][J].MovingAvgTminLoading);
      Items[I].FMovingAvgTminUnLoading    := esaSum(Items[I].MovingAvgTminUnLoading,Items[I][J].MovingAvgTminUnLoading);
      Items[I].FWaitingAvgTminNulled      := esaSum(Items[I].WaitingAvgTminNulled,Items[I][J].WaitingAvgTminNulled);
      Items[I].FWaitingAvgTminLoading     := esaSum(Items[I].WaitingAvgTminLoading,Items[I][J].WaitingAvgTminLoading);
      Items[I].FWaitingAvgTminUnLoading   := esaSum(Items[I].WaitingAvgTminUnLoading,Items[I][J].WaitingAvgTminUnLoading);
      Items[I].FGx                        := esaSum(Items[I].Gx,Items[I][J].Gx);
      Items[I].FRepairCtg                 := Items[I].RepairCtg + Items[I][J].RepairCtg;
      Items[I].FAmortizationCtg           := Items[I].AmortizationCtg + Items[I][J].AmortizationCtg;
      Items[I].FBuildingCtg               := Items[I].BuildingCtg + Items[I][J].BuildingCtg;
    end;{for}
    //���������
    FLsm                       := Lsm + Items[I].Lsm;
    FRockVolume                := esaSum(RockVolume,Items[I].RockVolume);
    FAutosCount                := esaSum(AutosCount,Items[I].AutosCount);
    FWaitingsCount             := esaSum(WaitingsCount,Items[I].WaitingsCount);
    FAvgVkmhNulled             := esaSum(AvgVkmhNulled,Items[I].AvgVkmhNulled);
    FAvgVkmhLoading            := esaSum(AvgVkmhLoading,Items[I].AvgVkmhLoading);
    FAvgVkmhUnLoading          := esaSum(AvgVkmhUnLoading,Items[I].AvgVkmhUnLoading);
    FMovingAvgTminNulled       := esaSum(MovingAvgTminNulled,Items[I].MovingAvgTminNulled);
    FMovingAvgTminLoading      := esaSum(MovingAvgTminLoading,Items[I].MovingAvgTminLoading);
    FMovingAvgTminUnLoading    := esaSum(MovingAvgTminUnLoading,Items[I].MovingAvgTminUnLoading);
    FWaitingAvgTminNulled      := esaSum(WaitingAvgTminNulled,Items[I].WaitingAvgTminNulled);
    FWaitingAvgTminLoading     := esaSum(WaitingAvgTminLoading,Items[I].WaitingAvgTminLoading);
    FWaitingAvgTminUnLoading   := esaSum(WaitingAvgTminUnLoading,Items[I].WaitingAvgTminUnLoading);
    FGx                        := esaSum(Gx,Items[I].Gx);
    FRepairCtg                 := RepairCtg + Items[I].RepairCtg;
    FAmortizationCtg           := AmortizationCtg + Items[I].AmortizationCtg;
    FBuildingCtg               := BuildingCtg + Items[I].BuildingCtg;
  end;{for}
  FBlocksCount                 := BlocksCount - 1;//+ Items[I].BlocksCount;
end;{Update}
function TesaResultBlockModels.IndexOf(const AId_RoadCoat: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to Count-1 do
  if Items[I].Id_RoadCoat=AId_RoadCoat then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
constructor TesaResultBlockModels.Create;
begin
  inherited;
  FItems := nil;
  FCount := 0;
end;{Create}
destructor TesaResultBlockModels.Destroy;
begin
  Clear;
  inherited;
end;{Destroy}
procedure TDispatcher.CheckEndOfShiftForAutos(const dTsec, ACurrTsecNaryad: Integer);
var
  i: integer;
  cWorking: integer;
  cWaiting: integer;
  cTargeting: integer;
  //
  LastDtSec: single;
begin
  cWorking := FCurrWorkingAutosCount;//���������� ���� � ������
  cWaiting := FCurrWaitingAutosCount;//���������� ���� � �������
  cTargeting:= cWorking + cWaiting;//������� ���������� ����
  for i := 0 to cTargeting - 1 do
    with FCurrAutos[i] do
    begin
      LastDtSec:= FCurrDt0Sec;
      if Events.FKind = ekMoving then
        LastDtSec:= Events.FTsec + FCurrDt0Sec;
      Events.Aborting(LastDtSec,
                      Events.FKind,
                      Events.FDirection);
    end;
end;

function TesaLoadingPunkts.GetPlanRockVolume: RRockVolume;
var
  i: integer;
  rock_plan_m3, rock_plan_t: single;
begin
  rock_plan_m3:= 0;
  rock_plan_t:= 0;
  for i:= 0 to Count do
  begin
    rock_plan_m3:= rock_plan_m3 + Items[i].FPeriodPlanVm3;
    rock_plan_t:= rock_plan_t + Items[i].FPeriodPlanQtn;
  end;
  Result.Vm3:= rock_plan_m3;
  Result.Qtn:= rock_plan_t;
end;

end.

