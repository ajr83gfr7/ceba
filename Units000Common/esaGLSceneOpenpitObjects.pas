unit esaGLSceneOpenpitObjects;
{
Елубаев Сулеймен Актлеуович
аспирант ИГД им.Д.А.Кунаева
Графическое ядро OpenGL3D для элементов карьерного пространства с помощью GLScene
}

interface
uses Classes, ADODb, SysUtils, GLObjects, GLGeomObjects, GLTexture;
type
  PGLPolygon=^TGLPolygon;
  RPoint3D=record
    X,Y,Z: Single;
  end;{RPoint3D}
  PPoint3D=^RPoint3D;
  ROpenpitPoint3D=record
    Id_Point: Integer;
    Coords: RPoint3D;
  end;
  POpenpitPoint3D=^ROpenpitPoint3D;
  TResultOpenpit3D = class;
  //Объект карьера-----------------------------------------------------------------------------
  TResultOpenpitObject3D=class
  private
    FOwner: TResultOpenpit3D;
  public
    property Openpit: TResultOpenpit3D read FOwner;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitObject3D}

  //Характерные Точки карьера------------------------------------------------------------------
  TResultOpenpitPoints3D=class(TResultOpenpitObject3D)
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(const Index: Integer): ROpenpitPoint3D;
    procedure Update;
    procedure Clear;
    function IndexOf(const Id_Point: Integer): Integer;
  public
    property Items[const Index: Integer]: ROpenpitPoint3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitPoints3D}

  PInteger=^Integer;
  TBlockKind=(bkMoving,bkRoadDown,bkManeuver,bkCrossRoad);
  //Блок-участок карьера-----------------------------------------------------------------------
  TResultOpenpitBlock3D=class(TResultOpenpitObject3D)
  private
    FId_Block    : Integer;   //Код блок-участка карьера
    FStripCount  : Integer;   //Количество полос движения блок-участка карьера
    FStripWidth  : Single;    //Ширина полосы блок-участка карьера, м
    FKind        : TBlockKind;//Тип блок-участка карьера
    FPointIndexes: TList;     //Индексы точек блок-участка
    function GetCount: Integer;
    function GetId_Point0: Integer;
    function GetId_Point1: Integer;
    function GetItem(const Index: Integer): ROpenpitPoint3D;
    procedure Clear;
    function GetPointIndex(const Index: Integer): Integer;
    property PointIndexes[const Index: Integer]: Integer read GetPointIndex;
  public
    property Id_Block: Integer read FId_Block;
    property Id_Point0: Integer read GetId_Point0;
    property Id_Point1: Integer read GetId_Point1;
    property StripCount: Integer read FStripCount;
    property StripWidth: Single read FStripWidth;
    property Kind: TBlockKind read FKind;
    property Items[const Index: Integer]: ROpenpitPoint3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitBlock3D}
  POpenpitBlock3D=^TResultOpenpitBlock3D;

  //Блок-участки карьера-----------------------------------------------------------------------
  TResultOpenpitBlocks3D=class(TResultOpenpitObject3D)
  private
    FItems: TList;//Блок-участки карьера
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitBlock3D;
    procedure Update;
    procedure Clear;
    function IndexOf(const Id_Block: Integer): Integer;
  public
    property Items[const Index: Integer]: TResultOpenpitBlock3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitBlocks3D}

  TCourseKind=(ckCourseMoving,ckCourseTo,ckCourseFrom);
  //Маршрут карьера----------------------------------------------------------------------------
  TResultOpenpitCourse3D=class(TResultOpenpitObject3D)
  private
    FId_Course   : Integer;     //Код маршрута
    FKind        : TCourseKind; //Тип маршрута
    FId_Point0   : Integer;     //Начальная точка маршрута
    FBlockIndexes: TList;       //Индексы блок-участков маршрута
    FPoints      : TList;       //Точки маршрута
    FPolygon     : TList;       //Точки полигона контура маршрута
    FSurface     : TGLPolygon;  //Поверхность дороги
    FFloor       : TGLPolygon;  //Дно дороги
    FSubstrate   : TList;       //Полигоны подложки
    FCourseLength: Single;      //Длина маршрута, м
    FStripWidth  : Single;      //Средняя ширина маршрута, м
    function GetPointsCount: Integer;
    function GetBlocksCount: Integer;
    function GetPoint(const Index: Integer): ROpenpitPoint3D;
    procedure Clear;
    function GetBlockIndex(const Index: Integer): Integer;
    function GetBlock(const Index: Integer): TResultOpenpitBlock3D;
    procedure Update;
    property BlockIndexes[const Index: Integer]: Integer read GetBlockIndex;
    function GetPolygonCount: Integer;
    function GetPolygon(const Index: Integer): RPoint3D;
  public
    property CourseLength: Single read FCourseLength;
    property StripWidth: Single read FStripWidth;
    property Id_Course: Integer read FId_Course;
    property Kind: TCourseKind read FKind;
    property Points[const Index: Integer]: ROpenpitPoint3D read GetPoint;default;
    property PointsCount: Integer read GetPointsCount;
    property BlocksCount: Integer read GetBlocksCount;
    property Blocks[const Index: Integer]: TResultOpenpitBlock3D read GetBlock;
    property Polygon[const Index: Integer]: RPoint3D read GetPolygon;
    property PolygonCount: Integer read GetPolygonCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitCourse3D}
  POpenpitCourse3D=^TResultOpenpitCourse3D;

  //Маршруты карьера---------------------------------------------------------------------------
  TResultOpenpitCourses3D=class(TResultOpenpitObject3D)
  private
    FItems        : TList;
    FShowSubstrate: Boolean;//Показать подложку
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitCourse3D;
    procedure SetShowSubstrate(const Value: Boolean);
    procedure Update;
    procedure Clear;
  public
    property Items[const Index: Integer]: TResultOpenpitCourse3D read GetItem;default;
    property Count: Integer read GetCount;
    property ShowSubstrate: Boolean read FShowSubstrate write SetShowSubstrate;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitCourses3D}


  //Пункт карьера -----------------------------------------------------------------------------
  TResultOpenpitPunkt3D=class(TResultOpenpitObject3D)
  private
    function GetPosition: RPoint3D;
    function GetPoint: ROpenpitPoint3D;
  protected
    FId_Punkt  : Integer;
    FPointIndex: Integer;
    FObjects   : TGLDummyCube;
  public
    property Id_Punkt: Integer read FId_Punkt;
    property Position: RPoint3D read GetPosition;
    property Point: ROpenpitPoint3D read GetPoint;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitPunkt3D}
  POpenpitPunkt3D=^TResultOpenpitPunkt3D;

  //Пункты погрузки карьера--------------------------------------------------------------------
  TResultOpenpitLoadingPunkts3D=class(TResultOpenpitObject3D)
  private
    FItems: TList;//Блок-участки карьера
    function GetCount: Integer;
    function GetItem(const Index: Integer): TResultOpenpitPunkt3D;
    procedure Clear;
  protected
    procedure Update;virtual;
    function IndexOf(const Id_Punkt: Integer): Integer;
  public
    property Items[const Index: Integer]: TResultOpenpitPunkt3D read GetItem;default;
    property Count: Integer read GetCount;
    constructor Create(Owner: TResultOpenpit3D);
    destructor Destroy;override;
  end;{TResultOpenpitLoadingPunkts3D}

  //Пункты разгрузки карьера-------------------------------------------------------------------
  TResultOpenpitUnLoadingPunkts3D=class(TResultOpenpitLoadingPunkts3D)
  protected
    procedure Update;override;
  end;{TResultOpenpitUnLoadingPunkts3D}

  //Пункты пересменки карьера------------------------------------------------------------------
  TResultOpenpitShiftPunkts3D=class(TResultOpenpitLoadingPunkts3D)
  protected
    procedure Update;override;
  end;{TResultOpenpitShiftPunkts3D}

  TAutoDirection=(adLoading,adUnLoading);

  //Карьер-------------------------------------------------------------------------------------
  TResultOpenpit3D = class
  private
    FId_Openpit     : Integer;                  //Код карьера
    FName           : String;                   //Наименование карьера
    FCreateDate     : TDateTime;                //Дата создания карьера
    FNote           : String;                   //Примечание
    FMinPoint       : RPoint3D;                 //Минимальная точка карьера
    FMaxPoint       : RPoint3D;                 //Максимальная точка карьера
    FCenter         : RPoint3D;                 //Центр карьера
    FDBConnection   : TADOConnection;           //Соединение с БД карьера
    FPoints         : TResultOpenpitPoints3D;         //Характерные точки карьера
    FBlocks         : TResultOpenpitBlocks3D;         //Блок-участки карьера
    FLoadingPunkts  : TResultOpenpitLoadingPunkts3D;  //Пункты погрузки
    FUnLoadingPunkts: TResultOpenpitUnLoadingPunkts3D;//Пункты разгрузки
    FShiftPunkts    : TResultOpenpitShiftPunkts3D;    //Пункты пересменки
    FCourses        : TResultOpenpitCourses3D;        //Маршруты карьера
    FOwner          : TGLDummyCube;
    FSubstrateHeight: Single;                   //Высота подложки, м
  public
    property Id_Openpit     : Integer read FId_Openpit;
    property Name           : String read FName;
    property CreateDate     : TDateTime read FCreateDate;
    property Note           : String read FNote;
    property DBConnection   : TADOConnection read FDBConnection;
    property Points         : TResultOpenpitPoints3D read FPoints;
    property Blocks         : TResultOpenpitBlocks3D read FBlocks;
    property LoadingPunkts  : TResultOpenpitLoadingPunkts3D read FLoadingPunkts;
    property UnLoadingPunkts: TResultOpenpitUnLoadingPunkts3D read FUnLoadingPunkts;
    property ShiftPunkts    : TResultOpenpitShiftPunkts3D read FShiftPunkts;
    property Courses        : TResultOpenpitCourses3D read FCourses;
    property Owner          : TGLDummyCube read FOwner;
    property MinPoint       : RPoint3D read FMinPoint;
    property MaxPoint       : RPoint3D read FMaxPoint;
    property Center         : RPoint3D read FCenter;

    constructor Create(AOwner: TGLDummyCube; ADBConnection: TADOConnection);
    destructor Destroy; override;
    function LoadFromDB(const AId_Openpit: Integer= 0): Boolean;
    procedure Clear;
  end;

//Перевод координат 3D-точки в тип RPoint3D
function Point3D(const X,Y,Z: Single): RPoint3D;
implementation
uses Math, unDM, Forms, ExtCtrls, Controls, StdCtrls, DBGrids, DB, Dialogs,
  GLScene, GLCanvas, GLMisc;

//I. ГЛОБАЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ------------------------------------------------------------
//возвращаю прямоугольник вокруг отрезка с заданными вершинами с заданной шириной
//    Top0---------------------------Top1
//    Point0-------------------------Point1
//    Top3---------------------------Top2
procedure GetBoundAroundPiece(const Point0,Point1: RPoint3D;
                              const ADistance: Single;
                              var   Top0,Top1,Top2,Top3: RPoint3D);
var ALength, ARatio0, ARatio1, Xc, Yc, Alfa, ACos, ASin: Single;
begin
  ALength := sqrt(sqr(Point0.X-Point1.X)+sqr(Point0.Y-Point1.Y));
  Top0.X := Point0.X; Top0.Y := Point0.Y; Top0.Z := Point0.Z;
  Top3.X := Point0.X; Top3.Y := Point0.Y; Top3.Z := Point0.Z;
  Top1.X := Point1.X; Top1.Y := Point1.Y; Top1.Z := Point1.Z;
  Top2.X := Point1.X; Top2.Y := Point1.Y; Top2.Z := Point1.Z;
  if ALength<0.001 then Exit;
  ARatio0 := ADistance/ALength;
  ARatio1 := (ADistance+ALength)/ALength;
  Alfa := Pi*0.5;
  ACos := cos(Alfa); ASin := sin(Alfa);
  //ALeftTop, ALeftBottom
  Xc := Point0.X+(Point1.X-Point0.X)*ARatio0;
  Yc := Point0.Y+(Point1.Y-Point0.Y)*ARatio0;
  Top0.X := Point0.X + (Xc-Point0.X)*ACos+(Yc-Point0.Y)*ASin;
  Top0.Y := Point0.Y - (Xc-Point0.X)*ASin+(Yc-Point0.Y)*ACos;
  Top3.X := Point0.X + (Xc-Point0.X)*ACos+(Yc-Point0.Y)*(-ASin);
  Top3.Y := Point0.Y - (Xc-Point0.X)*(-ASin)+(Yc-Point0.Y)*ACos;
  //ARightTop, ARightBottom
  Xc := Point0.X+(Point1.X-Point0.X)*ARatio1;
  Yc := Point0.Y+(Point1.Y-Point0.Y)*ARatio1;
  Top1.X := Point1.X + (Xc-Point1.X)*ACos+(Yc-Point1.Y)*ASin;
  Top1.Y := Point1.Y - (Xc-Point1.X)*ASin+(Yc-Point1.Y)*ACos;
  Top2.X := Point1.X + (Xc-Point1.X)*ACos+(Yc-Point1.Y)*(-ASin);
  Top2.Y := Point1.Y - (Xc-Point1.X)*(-ASin)+(Yc-Point1.Y)*ACos;
end;{GetBoundAroundPiece}
//определяю пересечение отрезков (x0,y0)-(x1,y1) и (x2,y2)-(x3,y3)
//где x0,y0,x1,y1 - коор-ты первого отрезка
//    x2,y2,x3,y3 - коор-ты второго отрезка
//    Accuracy    - требуемая точность округления: 10, 100, 1000...
//Результат:
//    pcrNotCrossed - не пересекаются
//    pcrParallel   - параллельны
//    pcrCrossed    - пересекаются
//    pcrTotalTop   - выходят из одной точки
//    X,Y         - коор-ты точки пересечения

//Решение:
  //1. Нахожу т.пересечения прямых A1*X+B1*Y+C1=0 и A2*X+B2*Y+C2=0
  //           |B1 C1|          |C1 A1|
  //           |B2 C2|          |C2 A2|
  //       X = -------      Y = -------
  //           |A1 B1|          |A1 B1|
  //           |A2 B2|          |A2 B2|

  //      |A1 B1|
  //если  |A2 B2| = 0, то прямые параллельны      X=-1 Y=-1 Result=2
  //иначе проверяю, на принадлежность (X,Y) диапазонам [X0,Y0]и[X1,Y1]
  //                                  (X,Y) диапазонам [X2,Y2]и[X3,Y3]
type
  TPiecesCrossedResult=(pcrNotCrossed,pcrParallel,pcrCrossed,pcrTotalTop);
function ArePiecesCrossed(var   APoint: RPoint3D;
                          const APoint0,APoint1,APoint2,APoint3: RPoint3D;
                          const Accuracy: Single): TPiecesCrossedResult;
  //true: X лежит между [A,B]или[B,A]
  function IsBetween(X,A,B: Single): boolean;
  begin
    Result := ((A<=B)and(A<=X)and(X<=B))OR((A>B)and(B<=X)and(X<=A));
  end;{IsBetween}
var A1,B1,C1,A2,B2,C2,D: Single;
begin
  APoint.Z := (APoint1.Z+APoint2.Z)*0.5;
  //1.нахожу коэф-ты двух прямых
  A1 := APoint1.Y-APoint0.Y;
  B1 := -APoint1.X+APoint0.X;
  C1 := -APoint0.X*APoint1.Y+APoint0.Y*APoint1.X;
  A2 := APoint3.Y-APoint2.Y;
  B2 := -APoint3.X+APoint2.X;
  C2 := -APoint2.X*APoint3.Y+APoint2.Y*APoint3.X;
  D := A1*B2-A2*B1;
  if abs(D)<=Accuracy then
  begin                    //параллельны
    Result := pcrParallel; APoint.X := -1.0; APoint.Y := -1.0;
  end{if}
  else
  begin                    //не параллельны
    APoint.X := (B1*C2-B2*C1)/D;
    APoint.Y := (C1*A2-C2*A1)/D;
    if IsBetween(APoint.X,APoint0.X,APoint1.X)and
       IsBetween(APoint.X,APoint2.X,APoint3.X)and
       IsBetween(APoint.Y,APoint0.Y,APoint1.Y)and
       IsBetween(APoint.Y,APoint2.Y,APoint3.Y)
    then Result := pcrCrossed       //пересекаются
    else Result := pcrNotCrossed;   //не пересекаются
  end;{else}
  if Result=pcrCrossed then
  if ((abs(APoint.X-APoint0.X)<=Accuracy)and(abs(APoint.Y-APoint0.Y)<=Accuracy))OR
     ((abs(APoint.X-APoint1.X)<=Accuracy)and(abs(APoint.Y-APoint1.Y)<=Accuracy))OR
     ((abs(APoint.X-APoint2.X)<=Accuracy)and(abs(APoint.Y-APoint2.Y)<=Accuracy))OR
     ((abs(APoint.X-APoint3.X)<=Accuracy)and(abs(APoint.Y-APoint3.Y)<=Accuracy))
  then Result := pcrTotalTop;
end;{ArePiecesCrossed}
//Перевод координат 3D-точки в тип RPoint3D
function Point3D(const X,Y,Z: Single): RPoint3D;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;{Point3D}
//Очистка списка
procedure ClearList(var AList: TList);
var I: Integer;
begin
  for I := AList.Count-1 downto 0 do
  begin
    Dispose(AList[I]);
    AList.Delete(I);
  end;{for}
end;{ClearList}

//II. ОБРАБОТЧИКИ МЕТОДОВ ОБЪЕКТОВ КАРЬЕРА-----------------------------------------------------
//Объект карьера-------------------------------------------------------------------------------
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

//Характерные Точки карьера--------------------------------------------------------------------
constructor TResultOpenpitPoints3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FItems := TList.Create;
end;{Create}
destructor TResultOpenpitPoints3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitPoints3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitPoints3D.GetItem(const Index: Integer): ROpenpitPoint3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := POpenpitPoint3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitPoints3D.Clear;
begin
  ClearList(FItems);
end;{Clear}
function TResultOpenpitPoints3D.IndexOf(const Id_Point: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count-1 do
  if Items[I].Id_Point=Id_Point then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TResultOpenpitPoints3D.Update;
var AItem: POpenpitPoint3D;
begin
  Clear;
  if FOwner.Id_Openpit>0 then
  with TADOQuery.Create(nil) do
  try
    Connection := FOwner.DBConnection;
    SQL.Text := 'SELECT * FROM OpenpitPoints WHERE Id_Openpit='+IntToStr(FOwner.Id_Openpit);
    Open;
    while not EOF do
    begin
      New(AItem);
      AItem^.Id_Point := FieldByName('Id_Point').AsInteger;
      AItem^.Coords.X := FieldByName('X').AsFloat;
      AItem^.Coords.Y := FieldByName('Y').AsFloat;
      AItem^.Coords.Z := FieldByName('Z').AsFloat;
      FItems.Add(AItem);
      Next;
    end;{while}
    Close;
  finally
    Free;
  end;{try}
end;{RefreshData}

//Блок-участок карьера-------------------------------------------------------------------------
procedure TResultOpenpitBlock3D.Clear;
begin
  ClearList(FPointIndexes);
  FId_Block   := 0;
  FStripCount := 2;
  FStripWidth := 12.5;
  FKind       := bkMoving;
end;{Clear}
constructor TResultOpenpitBlock3D.Create;
begin
  inherited;
  FId_Block   := 0;
  FStripCount := 2;
  FStripWidth := 12.5;
  FKind       := bkMoving;
  FPointIndexes := TList.Create;
end;{Create}
destructor TResultOpenpitBlock3D.Destroy;
begin
  Clear;
  FPointIndexes.Free;
  FPointIndexes := nil;
  inherited;
end;{Destroy}
function TResultOpenpitBlock3D.GetCount: Integer;
begin
  Result := FPointIndexes.Count;
end;{GetCount}
function TResultOpenpitBlock3D.GetId_Point0: Integer;
begin
  if Count>0
  then Result := Items[0].Id_Point
  else Result := 0;
end;{GetId_Point0}
function TResultOpenpitBlock3D.GetId_Point1: Integer;
begin
  if Count>0
  then Result := Items[Count-1].Id_Point
  else Result := 0;
end;{GetId_Point1}
function TResultOpenpitBlock3D.GetItem(const Index: Integer): ROpenpitPoint3D;
begin
  if InRange(Index,0,Count-1)
  then Result := FOwner.Points[PointIndexes[Index]]
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,Count-1]));
end;{GetItem}
function TResultOpenpitBlock3D.GetPointIndex(const Index: Integer): Integer;
begin
  if InRange(Index,0,FPointIndexes.Count-1)
  then Result := PInteger(FPointIndexes[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FPointIndexes.Count-1]));
end;{GetPointIndex}

//Блок-участки карьера-------------------------------------------------------------------------
constructor TResultOpenpitBlocks3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FItems := TList.Create;
end;{Create}
destructor TResultOpenpitBlocks3D.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
function TResultOpenpitBlocks3D.GetCount: Integer;
begin
  Result := FItems.Count;
end;{GetCount}
function TResultOpenpitBlocks3D.GetItem(const Index: Integer): TResultOpenpitBlock3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := POpenpitBlock3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitBlocks3D.Clear;
var I: Integer;
begin
  for I := FItems.Count-1 downto 0 do
  begin
    POpenpitBlock3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
function TResultOpenpitBlocks3D.IndexOf(const Id_Block: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count-1 do
  if Items[I].Id_Block=Id_Block then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TResultOpenpitBlocks3D.Update;
var
  AItem: POpenpitBlock3D;
  AIntItem: PInteger;
  quBlocks,quBlockPoints: TADOQuery;
begin
  quBlocks := nil;
  Clear;
  if FOwner.Id_Openpit>0 then
    quBlocks := TADOQuery.Create(nil);
  quBlockPoints := TADOQuery.Create(nil);
  try
    quBlocks.Connection := FOwner.DBConnection;
    quBlocks.SQL.Text := 'SELECT * FROM OpenpitBlocks WHERE Id_Openpit='+IntToStr(FOwner.Id_Openpit);
    quBlocks.Open;
    quBlockPoints.Connection := FOwner.DBConnection;
    quBlockPoints.SQL.Text := 'SELECT * FROM OpenpitBlockPoints WHERE Id_Block=:Id_Block';
    quBlockPoints.Open;
    while not quBlocks.EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitBlock3D.Create(FOwner);
      AItem^.FId_Block := quBlocks.FieldByName('Id_Block').AsInteger;
      AItem^.FStripCount := quBlocks.FieldByName('StripCount').AsInteger;
      AItem^.FStripWidth := quBlocks.FieldByName('StripWidth').AsFloat;
      AItem^.FKind := TBlockKind(quBlocks.FieldByName('Kind').AsInteger);
      quBlockPoints.Parameters.ParamByName('Id_Block').Value := AItem^.FId_Block;
      quBlockPoints.Requery;
      while not quBlockPoints.EOF do
      begin
        New(AIntItem);
        AIntItem^ := FOwner.Points.IndexOf(quBlockPoints.FieldByName('Id_Point').AsInteger);
        AItem.FPointIndexes.Add(AIntItem);
        quBlockPoints.Next;
      end;{while}
      FItems.Add(AItem);
      quBlocks.Next;
    end;{while}
    quBlocks.Close;
    quBlockPoints.Close;
  finally
    quBlocks.Free;
    quBlockPoints.Free;
  end;{try}
end;{RefreshData}

//Маршрут карьера------------------------------------------------------------------------------
procedure TResultOpenpitCourse3D.Clear;
var I: Integer;
begin
  ClearList(FPoints);
  ClearList(FPolygon);
  ClearList(FBlockIndexes);
  FSurface.Free;
  FSurface := nil;
  FFloor.Free;
  FFloor := nil;

  FId_Course    := 0;
  FKind         := ckCourseMoving;
  FId_Point0    := 0;
  FCourseLength := 0.0;
  FStripWidth  := 0.0;

  for I := FSubstrate.Count-1 downto 0 do
  begin
    PGLPolygon(FSubstrate[I])^.Free;
    Dispose(FSubstrate[I]);
    FSubstrate.Delete(I);
  end;{for}
end;{Clear}
constructor TResultOpenpitCourse3D.Create;
begin
  inherited;
  FId_Course := 0;
  FKind      := ckCourseMoving;
  FId_Point0 := 0;
  FPoints := TList.Create;
  FBlockIndexes := TList.Create;
  FPolygon := TList.Create;
  FSurface := nil;
  FFloor := nil;
  FSubstrate := TList.Create;
  FCourseLength := 0.0;
  FStripWidth  := 0.0;
end;{Create}
destructor TResultOpenpitCourse3D.Destroy;
begin
  Clear;
  FPoints.Free;
  FPoints := nil;
  FBlockIndexes.Free;
  FBlockIndexes := nil;
  FPolygon.Free;
  FPolygon := nil;
  FSurface := nil;
  FFloor := nil;
  FSubstrate.Free;
  FSubstrate := nil;
  inherited;
end;{Destroy}
function TResultOpenpitCourse3D.GetPointsCount: Integer;
begin
  Result := FPoints.Count;
end;{GetPointsCount}
function TResultOpenpitCourse3D.GetPolygonCount: Integer;
begin
  Result := FPolygon.Count;
end;{GetPolygonCount}
function TResultOpenpitCourse3D.GetBlocksCount: Integer;
begin
  Result := FBlockIndexes.Count;
end;{GetBlocksCount}
function TResultOpenpitCourse3D.GetPoint(const Index: Integer): ROpenpitPoint3D;
begin
  if InRange(Index,0,FPoints.Count-1)
  then Result := POpenpitPoint3D(FPoints[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FPoints.Count-1]));
end;{GetPoint}
function TResultOpenpitCourse3D.GetPolygon(const Index: Integer): RPoint3D;
begin
  if InRange(Index,0,FPolygon.Count-1)
  then Result := PPoint3D(FPolygon[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FPolygon.Count-1]));
end;{GetPoint}
function TResultOpenpitCourse3D.GetBlockIndex(const Index: Integer): Integer;
begin
  if InRange(Index,0,FBlockIndexes.Count-1)
  then Result := PInteger(FBlockIndexes[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FBlockIndexes.Count-1]));
end;{GetBlockIndex}
function TResultOpenpitCourse3D.GetBlock(const Index: Integer): TResultOpenpitBlock3D;
begin
  if InRange(Index,0,BlocksCount-1)
  then Result := FOwner.Blocks[BlockIndexes[Index]]
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,BlocksCount-1]));
end;{GetBlock}
procedure TResultOpenpitCourse3D.Update;
type
  RTempBlock=record
    Top0,Top1,Bottom0,Bottom1: RPoint3D;
    Point0,Point1: ROpenpitPoint3D;
  end;
  PTempBlock=^RTempBlock;
var
  I,J: Integer;
  ATempBlock,ATempBlockOld: PTempBlock;
  Id_Point0: Integer;
  ATempBlocks: TList;
  ABlockWidth: Single;
  AOpenpitPoint: POpenpitPoint3D;
  AIndex: Integer;
  APoint: PPoint3D;
  ATopPoints,ABottomPoints: TList;
  ASubstrate: PGLPolygon;
begin
  //Очистка всех данных -----------------------------------------------------------------------
  FCourseLength := 0.0;
  ClearList(FPoints);
  ClearList(FPolygon);
  FSurface.Free;
  FSurface := nil;
  FFloor.Free;
  FFloor := nil;
  for I := FSubstrate.Count-1 downto 0 do
  begin
    PGLPolygon(FSubstrate[I])^.Free;
    Dispose(FSubstrate[I]);
    FSubstrate.Delete(I);
  end;{for}
  if (BlocksCount=0)or(FId_Point0=0) then Exit;
  //Заполнение и Обрамление блок-участков маршрута---------------------------------------------
  AIndex := FOwner.Points.IndexOf(FId_Point0);
  Id_Point0 := FOwner.Points[AIndex].Id_Point;
  ATempBlocks := TList.Create;
  FStripWidth := 0.0;
  for I := 0 to BlocksCount-1 do
  if Blocks[I].Count>0 then
  begin
    if Blocks[I].StripCount=1
    then ABlockWidth := Blocks[I].StripWidth*0.5
    else ABlockWidth := Blocks[I].StripWidth;
    FStripWidth := FStripWidth+ABlockWidth;
    for J := 1 to Blocks[I].Count-1 do
    begin
      New(ATempBlock);
      if Blocks[I].Id_Point0=Id_Point0
      then ATempBlock^.Point0 := Blocks[I].Items[J-1]
      else ATempBlock^.Point0 := Blocks[I].Items[Blocks[I].Count-J];
      if Blocks[I].Id_Point1=Id_Point0
      then ATempBlock^.Point1 := Blocks[I].Items[Blocks[I].Count-1-J]
      else ATempBlock^.Point1 := Blocks[I].Items[J];

      GetBoundAroundPiece(ATempBlock^.Point0.Coords,ATempBlock^.Point1.Coords,ABlockWidth,
                          ATempBlock^.Top0,ATempBlock^.Top1,ATempBlock^.Bottom1,ATempBlock^.Bottom0);
      ATempBlocks.Add(ATempBlock);
    end;
    if Blocks[I].Id_Point0=Id_Point0 then
      Id_Point0 := Blocks[I].Id_Point1
    else
      Id_Point0 := Blocks[I].Id_Point0;
  end;
  if BlocksCount>0
  then FStripWidth := FStripWidth/BlocksCount
  else FStripWidth := 0.0;
  //Нахожу точки левой, правой обочины и оси маршрута -----------------------------------------
  ATopPoints := TList.Create;
  ABottomPoints := TList.Create;
  for I := 0 to ATempBlocks.Count-1 do
  begin
    ATempBlock := ATempBlocks[I];
    if I=0 then//Первая точка
    begin
      New(AOpenpitPoint);//Ось маршрута--------------
      AOpenpitPoint^ := ATempBlock^.Point0;
      FPoints.Add(AOpenpitPoint);
      New(APoint);       //Левая обочина маршрута----
      APoint^ := ATempBlock^.Top0;
      ATopPoints.Add(APoint);
      New(APoint);       //Правая обочина маршрута---
      APoint^ := ATempBlock^.Bottom0;
      ABottomPoints.Add(APoint);
    end;
    New(AOpenpitPoint);//Ось маршрута----------------
    AOpenpitPoint^ := ATempBlock^.Point1;
    FPoints.Add(AOpenpitPoint);
    if I>0 then
    begin
      ATempBlockOld := ATempBlocks[I-1];
      New(APoint);       //Левая обочина маршрута----
      if ArePiecesCrossed(APoint^,ATempBlockOld^.Top0,ATempBlockOld^.Top1,
                          ATempBlock^.Top0,ATempBlock^.Top1,0.0001)=pcrParallel then
      begin
        APoint^.X := ATempBlockOld^.Top1.X;
        APoint^.Y := ATempBlockOld^.Top1.Y;
      end;
      ATopPoints.Add(APoint);
      New(APoint);       //Правая обочина маршрута---
      if ArePiecesCrossed(APoint^,ATempBlockOld^.Bottom0,ATempBlockOld^.Bottom1,
                          ATempBlock^.Bottom0,ATempBlock^.Bottom1,0.0001)=pcrParallel then
      begin
        APoint^.X := ATempBlockOld^.Bottom1.X;
        APoint^.Y := ATempBlockOld^.Bottom1.Y;
      end;
      ABottomPoints.Add(APoint);
    end;
  end;
  //Заполнение точек полигона маршрута
  for I := 0 to ATopPoints.Count-1 do
  begin
    New(APoint);
    APoint^ := PPoint3D(ATopPoints[I])^;
    FPolygon.Add(APoint);
  end;{for}
  for I := ABottomPoints.Count-1 downto 0 do
  begin
    New(APoint);
    APoint^ := PPoint3D(ABottomPoints[I])^;
    FPolygon.Add(APoint);
  end;{for}
  //Заполнение полигонов и полилиний OpenGL 3D-------------------------------------------------
  //Полотно дороги
  FSurface:=(FOwner.FOwner.AddNewChild(TGLPolygon) as TGLPolygon);
  FSurface.Material.FrontProperties.Ambient.SetColor(0.7,0.4,0.4);
  FSurface.Material.FrontProperties.Diffuse.SetColor(0.7,0.4,0.4);
  FSurface.Material.BackProperties.Ambient.SetColor(0.7,0.4,0.4);
  FSurface.Material.BackProperties.Diffuse.SetColor(0.7,0.4,0.4);
  for I := 0 to PolygonCount-1 do
    FSurface.AddNode(Polygon[I].X-FOwner.FCenter.X,
                     Polygon[I].Y-FOwner.FCenter.Y,
                     Polygon[I].Z-FOwner.FCenter.Z);
  //Дно подложки дороги
  FFloor:=(FOwner.FOwner.AddNewChild(TGLPolygon) as TGLPolygon);
  FFloor.Material.FrontProperties.Ambient.SetColor(0.7,0.7,0.7);
  FFloor.Material.FrontProperties.Diffuse.SetColor(0.7,0.7,0.7);
  FFloor.Material.BackProperties.Ambient.SetColor(0.7,0.7,0.7);
  FFloor.Material.BackProperties.Diffuse.SetColor(0.7,0.7,0.7);
  for I := 0 to PolygonCount-1 do
    FFloor.AddNode(Polygon[I].X-FOwner.FCenter.X,
                   Polygon[I].Y-FOwner.FCenter.Y,
                   FOwner.FMinPoint.Z-FOwner.FSubstrateHeight-FOwner.FCenter.Z);

  //Подложка дороги
  if PolygonCount>0 then
  begin
    New(ASubstrate); 
    ASubstrate^ :=(FOwner.FOwner.AddNewChild(TGLPolygon) as TGLPolygon);
    ASubstrate^.Material.FrontProperties.Ambient.SetColor(0.7,0.7,0.7);
    ASubstrate^.Material.FrontProperties.Diffuse.SetColor(0.7,0.7,0.7);
    ASubstrate^.Material.BackProperties.Ambient.SetColor(0.7,0.7,0.7);
    ASubstrate^.Material.BackProperties.Diffuse.SetColor(0.7,0.7,0.7);
    ASubstrate^.AddNode(Polygon[0].X-FOwner.FCenter.X,
                        Polygon[0].Y-FOwner.FCenter.Y,
                        Polygon[0].Z-FOwner.FCenter.Z);
    ASubstrate^.AddNode(Polygon[PolygonCount-1].X-FOwner.FCenter.X,
                        Polygon[PolygonCount-1].Y-FOwner.FCenter.Y,
                        Polygon[PolygonCount-1].Z-FOwner.FCenter.Z);
    ASubstrate^.AddNode(Polygon[PolygonCount-1].X-FOwner.FCenter.X,
                        Polygon[PolygonCount-1].Y-FOwner.FCenter.Y,
                        FOwner.FMinPoint.Z-FOwner.FSubstrateHeight-FOwner.FCenter.Z);
    ASubstrate^.AddNode(Polygon[0].X-FOwner.FCenter.X,
                        Polygon[0].Y-FOwner.FCenter.Y,
                        FOwner.FMinPoint.Z-FOwner.FSubstrateHeight-FOwner.FCenter.Z);
    FSubstrate.Add(ASubstrate);
  end;{if}
  for J := 1 to PolygonCount-1 do
  begin
    New(ASubstrate); 
    ASubstrate^:=(FOwner.FOwner.AddNewChild(TGLPolygon) as TGLPolygon);
    ASubstrate^.Material.FrontProperties.Ambient.SetColor(0.7,0.7,0.7);
    ASubstrate^.Material.FrontProperties.Diffuse.SetColor(0.7,0.7,0.7);
    ASubstrate^.Material.BackProperties.Ambient.SetColor(0.7,0.7,0.7);
    ASubstrate^.Material.BackProperties.Diffuse.SetColor(0.7,0.7,0.7);
    ASubstrate^.AddNode(Polygon[J-1].X-FOwner.FCenter.X,
                     Polygon[J-1].Y-FOwner.FCenter.Y,
                     Polygon[J-1].Z-FOwner.FCenter.Z);
    ASubstrate^.AddNode(Polygon[J].X-FOwner.FCenter.X,
                     Polygon[J].Y-FOwner.FCenter.Y,
                     Polygon[J].Z-FOwner.FCenter.Z);
    ASubstrate^.AddNode(Polygon[J].X-FOwner.FCenter.X,
                     Polygon[J].Y-FOwner.FCenter.Y,
                     FOwner.FMinPoint.Z-FOwner.FSubstrateHeight-FOwner.FCenter.Z);
    ASubstrate^.AddNode(Polygon[J-1].X-FOwner.FCenter.X,
                     Polygon[J-1].Y-FOwner.FCenter.Y,
                     FOwner.FMinPoint.Z-FOwner.FSubstrateHeight-FOwner.FCenter.Z);
    FSubstrate.Add(ASubstrate);
  end;{for}
  //Длина дороги, м
  FCourseLength := 0.0;
  for I := 1 to PointsCount-1 do
    FCourseLength := FCourseLength+
      sqrt(sqr(Points[I].Coords.X-Points[I-1].Coords.X)+
           sqr(Points[I].Coords.Y-Points[I-1].Coords.Y)+
           sqr(Points[I].Coords.Z-Points[I-1].Coords.Z));
  //Free;
  ClearList(ATopPoints);
  ATopPoints.Free;
  ClearList(ABottomPoints);
  ABottomPoints.Free;
  ClearList(ATempBlocks);
  ATempBlocks.Free;
end;{Update}


//Маршруты карьера-----------------------------------------------------------------------------
constructor TResultOpenpitCourses3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FShowSubstrate := true;
  FItems := TList.Create;
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
  then Result := POpenpitCourse3D(FItems[Index])^
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
      Items[I].FFloor.Visible := Value;
      for J := 0 to Items[I].FSubstrate.Count-1 do
        PGLPolygon(Items[I].FSubstrate[J])^.Visible := Value;
    end;{for}
  end;{if}
end;{SetShowSubstrate}
procedure TResultOpenpitCourses3D.Clear;
var I: Integer;
begin
  for I := FItems.Count-1 downto 0 do
  begin
    POpenpitCourse3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
procedure TResultOpenpitCourses3D.Update;
var
  ACourse                 : POpenpitCourse3D;
  ACourseBlockIndex       : PInteger;
  quCourses,quCourseBlocks: TADOQuery;
begin
  quCourses := nil;
  Clear;
  if FOwner.Id_Openpit>0 then
  quCourses := TADOQuery.Create(nil);
  quCourseBlocks := TADOQuery.Create(nil);
  try
    quCourses.Connection := FOwner.DBConnection;
    quCourses.SQL.Text := 'SELECT * FROM OpenpitCourses WHERE Id_Openpit='+
      IntToStr(FOwner.Id_Openpit);
    quCourses.Open;
    quCourseBlocks.Connection := FOwner.DBConnection;
    quCourseBlocks.SQL.Text := 'SELECT * FROM OpenpitCourseBlocks WHERE Id_Course=:Id_Course';
    quCourseBlocks.Open;
    while not quCourses.EOF do
    begin
      New(ACourse);
      ACourse^ := TResultOpenpitCourse3D.Create(FOwner);
      ACourse^.FId_Course := quCourses.FieldByName('Id_Course').AsInteger;
      ACourse^.FId_Point0 := quCourses.FieldByName('Id_Point0').AsInteger;
      ACourse^.FKind := TCourseKind(quCourses.FieldByName('Kind').AsInteger);
      quCourseBlocks.Parameters.ParamByName('Id_Course').Value := ACourse^.FId_Course;
      quCourseBlocks.Requery;
      while not quCourseBlocks.EOF do
      begin
        New(ACourseBlockIndex);
        ACourseBlockIndex^ :=
          FOwner.Blocks.IndexOf(quCourseBlocks.FieldByName('Id_Block').AsInteger);
        ACourse^.FBlockIndexes.Add(ACourseBlockIndex);
        quCourseBlocks.Next;
      end;{while}
      ACourse^.Update;
      FItems.Add(ACourse);
      quCourses.Next;
    end;{while}
    quCourses.Close;
    quCourseBlocks.Close;
  finally
    quCourses.Free;
    quCourseBlocks.Free;
  end;{try}
end;{RefreshData}

//Карьер---------------------------------------------------------------------------------------
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
  FBlocks.Clear;
  FPoints.Clear;
end;{Clear}
constructor TResultOpenpit3D.Create(AOwner: TGLDummyCube; ADBConnection: TADOConnection);
begin
  inherited Create;
  if not Assigned(ADBConnection)
  then raise Exception.Create('Не создан DBConnection: TADOConnection');
  if not Assigned(AOwner)
  then raise Exception.Create('Не создан Owner: TGLDummyCube');
  FDBConnection    := ADBConnection;
  FOwner           := AOwner;
  FId_Openpit      := 0;
  FName            := '';
  FCreateDate      := Now;
  FNote            := '';
  FMinPoint        := Point3D(-50.0,-50.0,-50.0);
  FMaxPoint        := Point3D(+50.0,+50.0,+50.0);
  FCenter          := Point3D(0.0,0.0,0.0);
  FSubstrateHeight := 100.0;
  FPoints          := TResultOpenpitPoints3D.Create(Self);
  FBlocks          := TResultOpenpitBlocks3D.Create(Self);
  FCourses         := TResultOpenpitCourses3D.Create(Self);
  FLoadingPunkts   := TResultOpenpitLoadingPunkts3D.Create(Self);
  FUnLoadingPunkts := TResultOpenpitUnLoadingPunkts3D.Create(Self);
  FShiftPunkts     := TResultOpenpitShiftPunkts3D.Create(Self);
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
  FBlocks.Free;
  FBlocks := nil;
  FPoints.Free;
  FPoints := nil;
  FOwner := nil;
  inherited;
end;{Destroy}
//Загрузка карьера из БД
function TResultOpenpit3D.LoadFromDB(const AId_Openpit: Integer= 0): Boolean;
begin
  Clear;
  with TADOQuery.Create(nil) do
  try
    Connection := FDBConnection;
    SQL.Text := 'SELECT * FROM Openpits WHERE Id_Openpit='+IntToStr(AId_Openpit);
    Open;
    FId_Openpit := AId_Openpit;
    FName := FieldByName('Name').AsString;
    FCreateDate := FieldByName('DateCreate').AsDateTime;
    FMinPoint.X := FieldByName('MinX').AsFloat;
    FMinPoint.Y := FieldByName('MinY').AsFloat;
    FMinPoint.Z := FieldByName('MinZ').AsFloat;
    FMaxPoint.X := FieldByName('MaxX').AsFloat;
    FMaxPoint.Y := FieldByName('MaxY').AsFloat;
    FMaxPoint.Z := FieldByName('MaxZ').AsFloat;
    FCenter.X := (FMinPoint.X+FMaxPoint.X)*0.5;
    FCenter.Y := (FMinPoint.Y+FMaxPoint.Y)*0.5;
    FCenter.Z := (FMinPoint.Z+FMaxPoint.Z)*0.5;
    Close;
    FPoints.Update;
    FBlocks.Update;
    FCourses.Update;
    FLoadingPunkts.Update;
    FUnLoadingPunkts.Update;
    FShiftPunkts.Update;
    Result := true;
  finally
    Free;
  end;{try}
end;{LoadFromDB}

//Пункт карьера -------------------------------------------------------------------------------
constructor TResultOpenpitPunkt3D.Create(Owner: TResultOpenpit3D);
begin
  inherited;
  FId_Punkt := 0;
  FPointIndex := -1;
  FObjects := (FOwner.FOwner.AddNewChild(TGLDummyCube) as TGLDummyCube);
  FObjects.Position.Style := csPoint;
  FObjects.CubeSize := 30.0;
end;{Create}
destructor TResultOpenpitPunkt3D.Destroy;
begin
  FObjects.Free;
  FObjects := nil;
  inherited;
end;{Destroy}
function TResultOpenpitPunkt3D.GetPoint: ROpenpitPoint3D;
begin
  if InRange(FPointIndex,0,FOwner.Points.Count-1)
  then Result := FOwner.Points[FPointIndex]
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
             'Допустимый диапазон: [0..%d]',[FPointIndex,FOwner.Points.Count-1]));
end;{GetPoint}
function TResultOpenpitPunkt3D.GetPosition: RPoint3D;
begin
  if InRange(FPointIndex,0,FOwner.Points.Count-1)
  then Result := FOwner.Points[FPointIndex].Coords
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
             'Допустимый диапазон: [0..%d]',[FPointIndex,FOwner.Points.Count-1]));
end;{GetPosition}

//Пункты погрузки -----------------------------------------------------------------------------
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
function TResultOpenpitLoadingPunkts3D.GetItem(const Index: Integer): TResultOpenpitPunkt3D;
begin
  if InRange(Index,0,FItems.Count-1)
  then Result := POpenpitPunkt3D(FItems[Index])^
  else raise Exception.Create(Format('Неверное значение индекса списка %d. '+
                                     'Допустимый диапазон: [0..%d]',[Index,FItems.Count-1]));
end;{GetItem}
procedure TResultOpenpitLoadingPunkts3D.Clear;
var I: Integer;
begin
  for I := FItems.Count-1 downto 0 do
  begin
    POpenpitPunkt3D(FItems[I])^.Free;
    Dispose(FItems[I]);
    FItems.Delete(I);
  end;{for}
end;{Clear}
function TResultOpenpitLoadingPunkts3D.IndexOf(const Id_Punkt: Integer): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count-1 do
  if Items[I].Id_Punkt=Id_Punkt then
  begin
    Result := I; Break;
  end;{for}
end;{IndexOf}
procedure TResultOpenpitLoadingPunkts3D.Update;
var
  AItem: POpenpitPunkt3D;
  quLoadingPunkts: TADOQuery;
  AAnnulus: TGLAnnulus;
begin
  quLoadingPunkts := nil;
  Clear;
  if FOwner.Id_Openpit>0 then
  quLoadingPunkts := TADOQuery.Create(nil);
  try
    quLoadingPunkts.Connection := FOwner.DBConnection;
    quLoadingPunkts.SQL.Text := 'SELECT * FROM OpenpitLoadingPunkts '+
                                'WHERE Id_Openpit='+IntToStr(FOwner.Id_Openpit);
    quLoadingPunkts.Open;
    while not quLoadingPunkts.EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitPunkt3D.Create(FOwner);
      with AItem^ do
      begin
        FId_Punkt := quLoadingPunkts.FieldByName('Id_LoadingPunkt').AsInteger;
        FPointIndex := FOwner.FPoints.IndexOf(quLoadingPunkts.FieldByName('Id_Point').AsInteger);
        FObjects.Position.SetPoint(Point.Coords.X-FOwner.Center.X,
                                   Point.Coords.Y-FOwner.Center.Y,
                                   Point.Coords.Z-FOwner.Center.Z+1.0);
        AAnnulus:=(FObjects.AddNewChild(TGLAnnulus) as TGLAnnulus);
        AAnnulus.Material.FrontProperties.Ambient.SetColor(0.0,1.0,0.0);
        AAnnulus.Material.FrontProperties.Diffuse.SetColor(0.0,1.0,0.0);
        AAnnulus.Material.BackProperties.Ambient.SetColor(0.0,1.0,0.0);
        AAnnulus.Material.BackProperties.Diffuse.SetColor(0.0,1.0,0.0);
        AAnnulus.TopRadius := FObjects.CubeSize;
        AAnnulus.TopInnerRadius := FObjects.CubeSize-10.0;
        AAnnulus.BottomRadius := FObjects.CubeSize;
        AAnnulus.BottomInnerRadius := FObjects.CubeSize-10.0;
        AAnnulus.Height := Point.Coords.Z+1.0-FOwner.MinPoint.Z+FOwner.FSubstrateHeight;
        AAnnulus.PitchAngle := 90;
        AAnnulus.Position.SetPoint(0.0,0.0,-AAnnulus.Height*0.5);
      end;{with}
      FItems.Add(AItem);
      quLoadingPunkts.Next;
    end;{while}
    quLoadingPunkts.Close;
  finally
    quLoadingPunkts.Free;
  end;{try}
end;{RefreshData}

//Пункты разгрузки ----------------------------------------------------------------------------
procedure TResultOpenpitUnLoadingPunkts3D.Update;
var
  AItem: POpenpitPunkt3D;
  quUnLoadingPunkts: TADOQuery;
  AAnnulus: TGLAnnulus;
begin
  quUnLoadingPunkts := nil;
  Clear;
  if FOwner.Id_Openpit>0 then
  quUnLoadingPunkts := TADOQuery.Create(nil);
  try
    quUnLoadingPunkts.Connection := FOwner.DBConnection;
    quUnLoadingPunkts.SQL.Text := 'SELECT * FROM OpenpitUnLoadingPunkts '+
                                  'WHERE Id_Openpit='+IntToStr(FOwner.Id_Openpit);
    quUnLoadingPunkts.Open;
    while not quUnLoadingPunkts.EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitPunkt3D.Create(FOwner);
      with AItem^ do
      begin
        FId_Punkt := quUnLoadingPunkts.FieldByName('Id_UnLoadingPunkt').AsInteger;
        FPointIndex := FOwner.FPoints.IndexOf(quUnLoadingPunkts.FieldByName('Id_Point').AsInteger);
        FObjects.Position.SetPoint(Point.Coords.X-FOwner.Center.X,
                                   Point.Coords.Y-FOwner.Center.Y,
                                   Point.Coords.Z-FOwner.Center.Z+1.0);
        AAnnulus:=(FObjects.AddNewChild(TGLAnnulus) as TGLAnnulus);
        AAnnulus.Material.FrontProperties.Ambient.SetColor(0.0,0.0,1.0);
        AAnnulus.Material.FrontProperties.Diffuse.SetColor(0.0,0.0,1.0);
        AAnnulus.Material.BackProperties.Ambient.SetColor(0.0,0.0,1.0);
        AAnnulus.Material.BackProperties.Diffuse.SetColor(0.0,0.0,1.0);
        AAnnulus.TopRadius := FObjects.CubeSize;
        AAnnulus.TopInnerRadius := FObjects.CubeSize-10.0;
        AAnnulus.BottomRadius := FObjects.CubeSize;
        AAnnulus.BottomInnerRadius := FObjects.CubeSize-10.0;
        AAnnulus.Height := Point.Coords.Z+1.0-FOwner.MinPoint.Z+FOwner.FSubstrateHeight;
        AAnnulus.PitchAngle := 90;
        AAnnulus.Position.SetPoint(0.0,0.0,-AAnnulus.Height*0.5);
      end;{with}
      FItems.Add(AItem);
      quUnLoadingPunkts.Next;
    end;{while}
    quUnLoadingPunkts.Close;
  finally
    quUnLoadingPunkts.Free;
  end;{try}
end;{RefreshData}

//Пункты пересменки ---------------------------------------------------------------------------
procedure TResultOpenpitShiftPunkts3D.Update;
var
  AItem: POpenpitPunkt3D;
  quShiftPunkts: TADOQuery;
  ACube: TGLCube;
  AFrustrum: TGLFrustrum;
begin
  quShiftPunkts := nil;
  Clear;
  if FOwner.Id_Openpit>0 then
  quShiftPunkts := TADOQuery.Create(nil);
  try
    quShiftPunkts.Connection := FOwner.DBConnection;
    quShiftPunkts.SQL.Text := 'SELECT * FROM OpenpitShiftPunkts '+
                              'WHERE Id_Openpit='+IntToStr(FOwner.Id_Openpit);
    quShiftPunkts.Open;
    while not quShiftPunkts.EOF do
    begin
      New(AItem);
      AItem^ := TResultOpenpitPunkt3D.Create(FOwner);
      with AItem^ do
      begin
        FId_Punkt := quShiftPunkts.FieldByName('Id_ShiftPunkt').AsInteger;
        FPointIndex := FOwner.FPoints.IndexOf(quShiftPunkts.FieldByName('Id_Point').AsInteger);
        FObjects.Position.SetPoint(Point.Coords.X-FOwner.Center.X,
                                   Point.Coords.Y-FOwner.Center.Y,
                                   Point.Coords.Z-FOwner.Center.Z);
        ACube:=(FObjects.AddNewChild(TGLCube) as TGLCube);
        ACube.Material.FrontProperties.Ambient.SetColor(1.0,1.0,0.0);
        ACube.Material.FrontProperties.Diffuse.SetColor(1.0,1.0,0.0);
        ACube.Material.BackProperties.Ambient.SetColor(1.0,1.0,0.0);
        ACube.Material.BackProperties.Diffuse.SetColor(1.0,1.0,0.0);
        ACube.CubeDepth := FObjects.CubeSize;
        ACube.CubeWidth := FObjects.CubeSize;
        ACube.CubeHeight := FObjects.CubeSize;
        ACube.Position.SetPoint(0.0,0.0,ACube.CubeDepth*0.5);
        AFrustrum:=(FObjects.AddNewChild(TGLFrustrum) as TGLFrustrum);
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
      quShiftPunkts.Next;
    end;{while}
    quShiftPunkts.Close;
  finally
    quShiftPunkts.Free;
  end;{try}
end;{RefreshData}

end.
