unit esaGLScene2D;
{
Елубаев Сулеймен Актлеуович
аспирант ИГД им.Д.А.Кунаева
Алматы, 2004
Графическое ядро GLScene2D (для Редактора элементов карьерного пространства 2D)
}

interface
uses Windows, Messages, Globals, Classes, Forms, Controls, Graphics, ExtCtrls;
const
  GLF_START_LIST=1000;
type
  TOnScaleChanged=procedure (Sender: TObject; const Scale: Integer)of object;
  TOnRendering=procedure (Sender: TObject) of object;
  TGLScene2D=class;
  //"Канва GLScene" ---------------------------------------------------------------------------
  TGLViewer = class(TCustomControl)
  private
    FGLScene2D: TGLScene2D;
    procedure WMPAINT(var Msg: TWMPaint);message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetGLScene2D(const Value: TGLScene2D);
  public
    property GLScene2D: TGLScene2D read FGLScene2D write SetGLScene2D;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;
  end;{TGLViewer}

  TGLScene2DLayers = class;
  //TGLScene2D - класс "Графическое ядро" -----------------------------------------------------
  TGLScene2D = class
  private
    FDC            : HDC;            //контекст устройства
    Fhrc           : HGLRC;          //?
    FHandle        : HWND;           //Дескриптор Owner
    FCanvasHandle  : HWND;           //Дескриптор канвы Owner
    FGLViewer      : TGLViewer;      //Канва
    FLayers        :TGLScene2DLayers;//Слои подложки
    FScale         : Integer;        //Масштабирование, 1 x Scale
    FSpace         : TPoint;         //Отступ от центра, м

    FBoundPxl      : TRect;          //Контур экрана, пиксели
    FBoundMtr      : RBound3D;       //Контур экрана, м
    FScaledBoundMtr: RBound3D;       //Контур проецирования с учетом Scale и Space
    FScaledSizeMtr : RPoint3D;       //Размер Контура проецирования с учетом Scale и Space
    FMtrPerPxl     : Single;         //Размерность пикселя, м

    FOnDraw        : TNotifyEvent;   //Обработчик события при прорисовке
    FOnScaleChanged: TOnScaleChanged;//Обработчик события при изменении масштабирования
    FOnRendering   : TOnRendering;//Обработчик события при изменении контура проецирования
    FCoordGridStyle: TCoordGridStyle;//Стиль координатной сетки
    FCoordGridStep : Integer;        //Шаг координатной сетки, м
    FCoordGridMarks: Boolean;        //Текстовые отметки координатной сетки

    FIsMoving      : Boolean;        //Процесс перетаскивания?
    FMovingSpace0  : TPoint;         //Начальный сдвиг
    FMovingPos0    : RPoint3D;       //Начальная позиция
    FMovingPos1    : RPoint3D;       //Конечная позиция

    FInvalidateEnable: Boolean; //Разрешение на вызов прорисовки
    procedure SetBoundPxl(const Value: TRect);
    procedure SetBoundMtr(Value: RBound3D);
    procedure SetScale(const Value: Integer);
    procedure SetSpace(const Value: TPoint);
    procedure SetCoordGridMarks(const Value: Boolean);
    procedure SetCoordGridStep(const Value: Integer);
    procedure SetCoordGridStyle(const Value: TCoordGridStyle);
    procedure SetOnDragDrop    (const Value: TDragDropEvent);
    procedure SetOnDragOver    (const Value: TDragOverEvent);
    procedure SetOnKeyDown     (const Value: TKeyEvent);
    procedure SetOnMouseDown   (const Value: TMouseEvent);
    procedure SetOnMouseMove   (const Value: TMouseMoveEvent);
    procedure SetOnMouseUp     (const Value: TMouseEvent);
    procedure SetOnMouseWheel  (const Value: TMouseWheelEvent);
    procedure SetCursor(const Value: TCursor);

    function GetWidthPxl       : Integer;
    function GetHeightPxl      : Integer;
    function GetWidthMtr       : Single;
    function GetHeightMtr      : Single;
    function GetScaledWidthMtr : Single;
    function GetScaledHeightMtr: Single;
    function GetOnDragDrop    : TDragDropEvent;
    function GetOnDragOver    : TDragOverEvent;
    function GetOnKeyDown     : TKeyEvent;
    function GetOnMouseDown   : TMouseEvent;
    function GetOnMouseMove   : TMouseMoveEvent;
    function GetOnMouseUp     : TMouseEvent;
    function GetOnMouseWheel  : TMouseWheelEvent;
    function GetCursor: TCursor;

    procedure DefineDCPixelFormat;           //Установка формата пикселя
    procedure DefineOpenGLOnCreate;          //Инициализация графики OpenGL
    procedure DefineOpenGLOnDestroy;         //Финализация графики OpenGL
    procedure DefineOpenGLOnResize;          //Изменение видовых параметров OpenGL
    function  DefineScaledBoundMtr: RBound3D;//Расчет контура проецирования и его размера
    procedure DrawCoordGrid;                 //Прорисовка координатной сетки
    //Прорисовка координатной сетки: CoordGridStyle=cgsPoint
    procedure DrawCoordGridPointStyle(const MinValue, MaxValue: TPoint;
                                      const MaxI, MaxJ: Integer);
    //Прорисовка координатной сетки: CoordGridStyle=cgsCross
    procedure DrawCoordGridCrossStyle(const MinValue, MaxValue: TPoint;
                                      const MaxI, MaxJ: Integer);
    //Прорисовка координатной сетки: CoordGridStyle=cgsGrid
    procedure DrawCoordGridGridStyle(const MinValue, MaxValue: TPoint;
                                     const MaxI, MaxJ: Integer);
    //Прорисовка текстовых отметок координатной сетки
    procedure DrawCoordGridLabels(const MinValue, MaxValue: TPoint;
                                  const MaxI, MaxJ: Integer);
    //Прорисовка процесса перетаскивания
    procedure DrawMovingProcess;
  protected
  public
    property Handle         : HWND read FHandle;
    property CanvasHandle   : HWND read FCanvasHandle;
    property GLViewer       : TGLViewer read FGLViewer;
    property Layers         : TGLScene2DLayers read FLayers;
    property Scale          : Integer read FScale write SetScale;
    property Space          : TPoint read FSpace write SetSpace;
    property BoundPxl       : TRect read FBoundPxl write SetBoundPxl;
    property BoundMtr       : RBound3D read FBoundMtr write SetBoundMtr;
    property WidthPxl       : Integer read GetWidthPxl;
    property HeightPxl      : Integer read GetHeightPxl;
    property WidthMtr       : Single read GetWidthMtr;
    property HeightMtr      : Single read GetHeightMtr;
    property ScaledBoundMtr : RBound3D read FScaledBoundMtr;
    property ScaledSizeMtr  : RPoint3D read FScaledSizeMtr;
    property ScaledWidthMtr : Single read GetScaledWidthMtr;
    property ScaledHeightMtr: Single read GetScaledHeightMtr;
    property OnDraw         : TNotifyEvent read FOnDraw write FOnDraw;
    property OnScaleChanged : TOnScaleChanged read FOnScaleChanged write FOnScaleChanged;
    property OnRendering : TOnRendering read FOnRendering write FOnRendering;
    property CoordGridStyle : TCoordGridStyle read FCoordGridStyle write SetCoordGridStyle;
    property CoordGridStep  : Integer read FCoordGridStep write SetCoordGridStep;
    property CoordGridMarks : Boolean read FCoordGridMarks write SetCoordGridMarks;
    property MtrPerPxl      : Single read FMtrPerPxl;
    property OnDragDrop    : TDragDropEvent read GetOnDragDrop write SetOnDragDrop;
    property OnDragOver    : TDragOverEvent read GetOnDragOver write SetOnDragOver;
    property OnKeyDown     : TKeyEvent read GetOnKeyDown write SetOnKeyDown;
    property OnMouseDown   : TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property OnMouseMove   : TMouseMoveEvent read GetOnMouseMove write SetOnMouseMove;
    property OnMouseUp     : TMouseEvent read GetOnMouseUp write SetOnMouseUp;
    property OnMouseWheel  : TMouseWheelEvent read GetOnMouseWheel write SetOnMouseWheel;
    property Cursor        : TCursor read GetCursor write SetCursor;
    property InvalidateEnable: Boolean read FInvalidateEnable;

    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    procedure Invalidate;
    procedure Draw;
    //Масштабирование на DeltaScale относительно точки экрана(X,Y)
    procedure ScaleTo(const X, Y, DeltaScale: Integer);
    //Сдвиг на dX,dY
    procedure MoveBy(const dX, dY: Integer);//Сдвиг
    //Перевожу мировые координаты точки в пиксельные координаты экранной точки
    function DefinePointMtrToPxl(const APointMtr: RPoint3D): RPoint3D;
    //Перевожу пиксельные координаты экранной точки в мировые
    function DefinePointPxlToMtr(const APointPxl: RPoint3D): RPoint3D;
    //Начало перетаскивания контура
    procedure MovingStart(const PxlX,PxlY: Integer);
    //Процесс перетаскивания контура
    procedure MovingMove(const PxlX,PxlY: Integer);
    //Конец перетаскивания контура
    procedure MovingFinish(const PxlX,PxlY: Integer);
    //Отмена перетаскивания контура
    procedure MovingStop;
    procedure EnableInvalidate; //Разрешение на вызов прорисовки
    procedure DisableInvalidate;//Запрет на вызов прорисовки
    procedure DrawText(const X,Y: Single; const Text: String);
  end;{TGLScene2D}

  //"Объект GLScene2D" ------------------------------------------------------------------------
  TGLScene2DObject = class
  private
    FGLScene2D    : TGLScene2D;//ССылка на GLScene2D
    FIsSelected   : Boolean;   //Признак выделенности
    FVisible      : Boolean;   //Признак видимости
    //Graphic
    FColor        : TColor;    //Цвет объекта
    FSelectedColor: TColor;    //Цвет выделенного объекта
    function GetHandle: HWND;
    function GetCanvasHandle: HWND;
    procedure SetVisible(const Value: Boolean);
  protected
    procedure SetIsSelected(const Value: Boolean);virtual;
    procedure SetColor(const Value: TColor);virtual;
    procedure SetSelectedColor(const Value: TColor);virtual;
    procedure SetGLScene2D(const Value: TGLScene2D);virtual;
    property Handle       : HWND read GetHandle;
    property CanvasHandle : HWND read GetCanvasHandle;
    property GLScene2D    : TGLScene2D read FGLScene2D write SetGLScene2D;
    property IsSelected   : Boolean read FIsSelected write SetIsSelected;
    property Color        : TColor read FColor write SetColor;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor;
    property Visible: Boolean read FVisible write SetVisible;
    procedure Clear;virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Invalidate;
    procedure Draw;virtual;
    procedure EnableInvalidate; //Разрешение на вызов прорисовки
    procedure DisableInvalidate;//Запрет на вызов прорисовки
  end;{TGLScene2DObject}
  
  //"CustomПолилиния GLScene2D" ---------------------------------------------------------------
  TGLScene2DCustomPolyline = class(TGLScene2DObject)
  private
    //Geometry
    FItems             : TList;       //Точки объекта карьера
    FLength            : Single;      //Длина полилинии, м
    FSelectedIndex     : Integer;     //Индекс выделенной точки
    //Graphic
    FLineWidth         : Single;      //Ширина линии, pxl
    FLinePattern       : Word;        //Шаблон линии
    FLineFactor        : Integer;     //Коэффициент шаблона линии
    FRadius            : Integer;     //Радиус точек, pxl
    function GetItem(const Index: Integer): ROpenpitPoint3D;
    function GetCount: Integer;
    function GetFirst: ROpenpitPoint3D;
    function GetLast: ROpenpitPoint3D;
    function GetSelected: ROpenpitPoint3D;

    procedure SetSelectedIndex(const Value: Integer);
    procedure SetLineWidth(const Value: Single);
    procedure SetLinePattern(const Value: Word);
    procedure SetLineFactor(const Value: Integer);
    procedure SetRadius(const Value: Integer);
  protected
    procedure SetIsSelected(const Value: Boolean);override;
    procedure SetItem(const Index: Integer; const Value: ROpenpitPoint3D);virtual;
    procedure DefineLength;//Определяю длину полилинии
    property Items[const Index: Integer]: ROpenpitPoint3D read GetItem write SetItem;default;
    property Count: Integer read GetCount;
    property Length            : Single read FLength;
    property First             : ROpenpitPoint3D read GetFirst;
    property Last              : ROpenpitPoint3D read GetLast;
    property Selected          : ROpenpitPoint3D read GetSelected;
    property SelectedIndex     : Integer read FSelectedIndex write SetSelectedIndex;
    property LineWidth         : Single read FLineWidth write SetLineWidth;
    property LinePattern       : Word read FLinePattern write SetLinePattern;
    property LineFactor        : Integer read FLineFactor write SetLineFactor;
    property Radius            : Integer read FRadius write SetRadius;
    procedure Delete(const Index: Integer);virtual;
    procedure DeleteAll;virtual;
    function IndexOf(const X,Y,Distance: Single): Integer;
    procedure Clear;override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
  end;{TGLScene2DCustomPolyline}

  //"Полилиния GLScene2D" ---------------------------------------------------------------------
  TGLScene2DPolyline = class(TGLScene2DCustomPolyline)
  public
    property Items;
    property Count;
    property Length;
    property First;
    property Last;
    property Selected;
    property IsSelected;
    property SelectedIndex;
    property Color;
    property SelectedColor;
    property LineWidth;
    property LinePattern;
    property LineFactor;
    property Radius;
    function Add(const APoint: RPoint3D; const AId_Point: Integer=-1): Integer;virtual;
  end;{TGLScene2DPolyline}
  PGLScene2DPolyline=^TGLScene2DPolyline;

  //"Полигон GLScene2D" -----------------------------------------------------------------------
  TGLScene2DPolygon = class(TGLScene2DPolyline)
  public
    procedure Draw;override;
  end;{TGLScene2DPolygon}
  PGLScene2DPolygon=^TGLScene2DPolygon;

  //"Текстовая отметка GLScene2D" -------------------------------------------------------------
  TGLScene2DLabel = class(TGLScene2DCustomPolyline)
  private
    FText: String;
    function GetPoint: ROpenpitPoint3D;
    procedure SetPoint(const Value: ROpenpitPoint3D);
    function GetCoords: RPoint3D;
    procedure SetCoords(const Value: RPoint3D);
    procedure SetText(const Value: String);
  public
    property IsSelected;        //Признак выделенности текста
    property Color;             //Цвет текста
    property SelectedColor;     //Цвет выделенного текста
    property Radius;            //Радиус окружности текста
    property LineWidth;         //Ширина окружности текста, pxl
    property LinePattern;       //Шаблон линии окружности текста
    property LineFactor;        //Коэффициент шаблона линии окружности текста
    property Text: String read FText write SetText;
    property Point: ROpenpitPoint3D read GetPoint write SetPoint;
    property Coords: RPoint3D read GetCoords write SetCoords;
    procedure Draw;override;
    constructor Create;
  end;{TGLScene2DLabel}
  PGLScene2DLabel=^TGLScene2DLabel;

  //"Полилинии GLScene2D" ---------------------------------------------------------------------
  TGLScene2DPolylines = class(TGLScene2DObject)
  private
    FItems: TList;       //Полилинии
    function GetItem(const Index: Integer): TGLScene2DPolyline;
    function GetCount: Integer;
    function GetFirst: TGLScene2DPolyline;
    function GetLast: TGLScene2DPolyline;
  protected
    procedure SetGLScene2D(const Value: TGLScene2D);override;
  public
    property Items[const Index: Integer]: TGLScene2DPolyline read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGLScene2DPolyline read GetFirst;
    property Last              : TGLScene2DPolyline read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    procedure Append;
  end;{TGLScene2DPolylines}

  //"Полигоны GLScene2D" ----------------------------------------------------------------------
  TGLScene2DPolygons = class(TGLScene2DObject)
  private
    FItems: TList;       //Полигоны
    function GetItem(const Index: Integer): TGLScene2DPolygon;
    function GetCount: Integer;
    function GetFirst: TGLScene2DPolygon;
    function GetLast: TGLScene2DPolygon;
  protected
    procedure SetGLScene2D(const Value: TGLScene2D);override;
  public
    property Items[const Index: Integer]: TGLScene2DPolygon read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGLScene2DPolygon read GetFirst;
    property Last              : TGLScene2DPolygon read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    procedure Append;
  end;{TGLScene2DPolygons}

  //"Текстовые отметки GLScene2D" -------------------------------------------------------------
  TGLScene2DLabels = class(TGLScene2DObject)
  private
    FItems: TList;       //Текстовые отметки
    function GetItem(const Index: Integer): TGLScene2DLabel;
    function GetCount: Integer;
    function GetFirst: TGLScene2DLabel;
    function GetLast: TGLScene2DLabel;
  protected
    procedure SetGLScene2D(const Value: TGLScene2D);override;
  public
    property Items[const Index: Integer]: TGLScene2DLabel read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGLScene2DLabel read GetFirst;
    property Last              : TGLScene2DLabel read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    procedure Append;
  end;{TGLScene2DLabels}

  //"Слой GLScene2D" --------------------------------------------------------------------------
  TGLScene2DLayer = class(TGLScene2DObject)
  private
    FName       : String;
    FPolylines  : TGLScene2DPolylines;
    FLWPolylines: TGLScene2DPolylines;
    FLines      : TGLScene2DPolylines;
    FMLines     : TGLScene2DPolylines;
    FHatchs     : TGLScene2DPolygons;
    FLabels     : TGLScene2DLabels;
    procedure SetName(const Value: String);
  protected
    procedure SetGLScene2D(const Value: TGLScene2D);override;
  public
    property Name       : String read FName write SetName;
    property Polylines  : TGLScene2DPolylines read FPolylines;
    property LWPolylines: TGLScene2DPolylines read FLWPolylines;
    property Lines      : TGLScene2DPolylines read FLines;
    property MLines     : TGLScene2DPolylines read FMLines;
    property Hatchs     : TGLScene2DPolygons read FHatchs;
    property Labels     : TGLScene2DLabels read FLabels;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
  end;{TGLScene2DLayer}
  PGLScene2DLayer=^TGLScene2DLayer;

  //"Слои GLScene2D" --------------------------------------------------------------------------
  TGLScene2DLayers = class(TGLScene2DObject)
  private
    FItems: TList;       //Текстовые отметки
    function GetItem(const Index: Integer): TGLScene2DLayer;
    function GetCount: Integer;
    function GetFirst: TGLScene2DLayer;
    function GetLast: TGLScene2DLayer;
  protected
    procedure SetGLScene2D(const Value: TGLScene2D);override;
  public
    property Items[const Index: Integer]: TGLScene2DLayer read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGLScene2DLayer read GetFirst;
    property Last              : TGLScene2DLayer read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    function Append: Integer;
    procedure Delete(const Index: Integer);
    function IndexOf(const Name: String): Integer;
    //Считываю подложку из AutoCAD 2004 DXF
    function LoadFromAutoCAD2004DBXFile(const AFileName: String): Boolean;
    //Диалог.окно для установки Видимости для слоев
    function OptionsDialogExecute: Boolean;
  end;{TGLScene2DLayers}

implementation
uses Types, SysUtils, OpenGL, Math, StdCtrls, CheckLst, ValEdit, Grids;

//"Канва GLScene" -----------------------------------------------------------------------------
constructor TGLViewer.Create(AOwner: TComponent);
begin
  FGLScene2D := nil;
  inherited;
  if not Assigned(AOwner)
  then raise Exception.Create('Не определен AOwner: TComponent');
end;{Create}
destructor TGLViewer.Destroy;
begin
  FGLScene2D := nil;
  inherited;
end;{Destroy}
procedure TGLViewer.WMPAINT(var Msg: TWMPaint);
var ps : TPaintStruct;
begin
  BeginPaint(Handle, ps);
  if FGLScene2D<>nil then FGLScene2D.Draw;
  EndPaint(Handle, ps);
  Msg.Result := 0;
end;{WMPAINT}
procedure TGLViewer.WMSize(var Message: TWMSize);
begin
  inherited;
  if FGLScene2D<>nil
  then FGLScene2D.BoundPxl := Rect(0,0,ClientWidth,ClientHeight);
end;{WMSize}
procedure TGLViewer.SetGLScene2D(const Value: TGLScene2D);
begin
  if FGLScene2D<>Value then
  begin
    FGLScene2D := Value;
    Invalidate;
  end;{if}
end;{SetGLScene2D}

//TGLScene2D - класс "OpenGL2D" ---------------------------------------------------------------
procedure TGLScene2D.SetBoundPxl(const Value: TRect);
begin
  if (FBoundPxl.Left<>Value.Left)OR(FBoundPxl.Top<>Value.Top)OR
     (FBoundPxl.Right<>Value.Right)OR(FBoundPxl.Bottom<>Value.Bottom)then
  begin
    FBoundPxl := Value;
    DefineOpenGLOnResize;
  end;{if}
end;{SetBoundPxl}
procedure TGLScene2D.SetBoundMtr(Value: RBound3D);
begin
  //Проверка условия 1
  if (Value.MinX>Value.MaxX)OR(Value.MinY>Value.MaxY)OR(Value.MinZ>Value.MaxZ)
  then FBoundMtr := Bound3D(0.0,10000.0,0.0,10000.0,0.0,100.0)
  else FBoundMtr := Value;
  //Проверка условия 2
  if abs(FBoundMtr.MaxX-FBoundMtr.MinX)<100.0 then
  begin
    FBoundMtr.MinX := (FBoundMtr.MaxX+FBoundMtr.MinX)*0.5-50.0;
    FBoundMtr.MaxX := FBoundMtr.MinX + 100.0;
  end;{if}
  if abs(FBoundMtr.MaxY-FBoundMtr.MinY)<100.0 then
  begin
    FBoundMtr.MinY := (FBoundMtr.MaxY+FBoundMtr.MinY)*0.5-50.0;
    FBoundMtr.MaxY := FBoundMtr.MinY + 100.0;
  end;{if}
  if abs(FBoundMtr.MaxZ-FBoundMtr.MinZ)<10.0 then
  begin
    FBoundMtr.MinZ := (FBoundMtr.MaxZ+FBoundMtr.MinZ)*0.5-5.0;
    FBoundMtr.MaxZ := FBoundMtr.MinZ + 10.0;
  end;{if}
  DefineOpenGLOnResize;
end;{SetBoundMtr}
procedure TGLScene2D.SetScale(const Value: Integer);
begin
  if (Value>0)and(FScale<>Value) then
  begin
    FScale := Value;
    if Assigned(FOnScaleChanged)then FOnScaleChanged(Self,Value);
    DefineOpenGLOnResize;
  end;{if}
end;{SetScale}
procedure TGLScene2D.SetSpace(const Value: TPoint);
begin
  if (FSpace.X<>Value.X)OR(FSpace.Y<>Value.Y) then
  begin
    FSpace := Value;
    DefineOpenGLOnResize;
  end;{if}
end;{SetSpace}
procedure TGLScene2D.SetCoordGridStyle(const Value: TCoordGridStyle);
begin
  if FCoordGridStyle<>Value then
  begin
    FCoordGridStyle := Value;
    Invalidate;
  end;{if}
end;{SetCoordGridStyle}
procedure TGLScene2D.SetCoordGridStep(const Value: Integer);
begin
  if (FCoordGridStep<>Value)and InRange(Value,10,1000)and(Value mod 10=0) then
  begin
    FCoordGridStep := Value;
    Invalidate;
  end;{if}
end;{SetCoordGridStep}
procedure TGLScene2D.SetCoordGridMarks(const Value: Boolean);
begin
  if FCoordGridMarks<>Value then
  begin
    FCoordGridMarks := Value;
    Invalidate;
  end;{if}
end;{SetCoordGridMarks}
procedure TGLScene2D.SetOnDragDrop(const Value: TDragDropEvent);
begin
  if FGLViewer<>nil then FGLViewer.OnDragDrop := Value;
end;{SetOnDragDrop}
procedure TGLScene2D.SetOnDragOver(const Value: TDragOverEvent);
begin
  if FGLViewer<>nil then FGLViewer.OnDragOver := Value;
end;{SetOnDragOver}
procedure TGLScene2D.SetOnKeyDown(const Value: TKeyEvent);
begin
  if FGLViewer<>nil then FGLViewer.OnKeyDown := Value;
end;{SetOnKeyDown}
procedure TGLScene2D.SetOnMouseDown(const Value: TMouseEvent);
begin
  if FGLViewer<>nil then FGLViewer.OnMouseDown := Value;
end;{SetOnMouseDown}
procedure TGLScene2D.SetOnMouseMove(const Value: TMouseMoveEvent);
begin
  if FGLViewer<>nil then FGLViewer.OnMouseMove := Value;
end;{SetOnMouseMove}
procedure TGLScene2D.SetOnMouseUp(const Value: TMouseEvent);
begin
  if FGLViewer<>nil then FGLViewer.OnMouseUp := Value;
end;{SetOnMouseUp}
procedure TGLScene2D.SetOnMouseWheel(const Value: TMouseWheelEvent);
begin
  if FGLViewer<>nil
  then FGLViewer.OnMouseWheel := Value;
end;{SetOnMouseWheel}
procedure TGLScene2D.SetCursor(const Value: TCursor);
begin
  if FGLViewer<>nil
  then FGLViewer.Cursor := Value;
end;{SetCursor}
function TGLScene2D.GetCursor: TCursor;
begin
  if FGLViewer<>nil
  then Result := FGLViewer.Cursor
  else Result := crDefault;
end;{GetCursor}
function TGLScene2D.GetOnDragDrop: TDragDropEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnDragDrop;
end;{GetOnDragDrop}
function TGLScene2D.GetOnDragOver: TDragOverEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnDragOver;
end;{GetOnDragOver}
function TGLScene2D.GetOnKeyDown: TKeyEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnKeyDown;
end;{GetOnKeyDown}
function TGLScene2D.GetOnMouseDown: TMouseEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnMouseDown;
end;{GetOnMouseDown}
function TGLScene2D.GetOnMouseMove: TMouseMoveEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnMouseMove;
end;{GetOnMouseMove}
function TGLScene2D.GetOnMouseUp: TMouseEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnMouseUp;
end;{GetOnMouseUp}
function TGLScene2D.GetOnMouseWheel: TMouseWheelEvent;
begin
  if FGLViewer<>nil then Result := FGLViewer.OnMouseWheel;
end;{GetOnMouseWheel}
function TGLScene2D.GetWidthPxl: Integer;
begin
  Result := FBoundPxl.Right-FBoundPxl.Left;
end;{GetWidthPxl}
function TGLScene2D.GetHeightPxl: Integer;
begin
  Result := FBoundPxl.Bottom-FBoundPxl.Top;
end;{GetHeightPxl}
function TGLScene2D.GetWidthMtr: Single;
begin
  Result := FBoundMtr.MaxX-FBoundMtr.MinX;
end;{GetWidthMtr}
function TGLScene2D.GetHeightMtr: Single;
begin
  Result := FBoundMtr.MaxY-FBoundMtr.MinY;
end;{GetHeightMtr}
function TGLScene2D.GetScaledWidthMtr: Single;
begin
  Result := FScaledBoundMtr.MaxX-FScaledBoundMtr.MinX;
end;{GetScaledWidthMtr}
function TGLScene2D.GetScaledHeightMtr: Single;
begin
  Result := FScaledBoundMtr.MaxY-FScaledBoundMtr.MinY;
end;{GetScaledHeightMtr}

//Расчет контура проецирования и его размера
function TGLScene2D.DefineScaledBoundMtr: RBound3D;
var ACenter: RPoint3D;
begin
  //Размер контура проецирования
  FScaledSizeMtr.X := WidthMtr;
  FScaledSizeMtr.Y := HeightMtr;
  if WidthPxl<HeightPxl
  then FScaledSizeMtr.Y := FScaledSizeMtr.X*HeightPxl/WidthPxl
  else FScaledSizeMtr.X := FScaledSizeMtr.Y*WidthPxl/HeightPxl;
  FScaledSizeMtr.X := FScaledSizeMtr.X/FScale;
  FScaledSizeMtr.Y := FScaledSizeMtr.Y/FScale;
  //Центр контура проецирования
  ACenter.X := (FBoundMtr.MaxX+FBoundMtr.MinX)*0.5+FSpace.X;
  ACenter.Y := (FBoundMtr.MaxY+FBoundMtr.MinY)*0.5+FSpace.Y;
  //Контур проецирования
  Result.MinX := ACenter.X-FScaledSizeMtr.X*0.5;
  Result.MaxX := ACenter.X+FScaledSizeMtr.X*0.5;
  Result.MinY := ACenter.Y-FScaledSizeMtr.Y*0.5;
  Result.MaxY := ACenter.Y+FScaledSizeMtr.Y*0.5;
  //MtrPerPixel
  if WidthPxl>0
  then FMtrPerPxl := ScaledWidthMtr/WidthPxl
  else FMtrPerPxl := 0.0;
end;{GetCurrentBound}
//Установка формата пикселя
procedure TGLScene2D.DefineDCPixelFormat;
var
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(FDC, @pfd);
  SetPixelFormat(FDC, nPixelFormat, @pfd);
end;{DefineDCPixelFormat}
//Инициализация графики OpenGL
procedure TGLScene2D.DefineOpenGLOnCreate;
begin
  if FDC=0 then
  begin
    FDC := GetDC(Handle);
    DefineDCPixelFormat;
    Fhrc := wglCreateContext(FDC);
    wglMakeCurrent(FDC, Fhrc);
    glClearColor (0.0, 0.0, 0.0, 1.0); // цвет фона
    wglUseFontBitmaps (FCanvasHandle, 0, 255, GLF_START_LIST);
    DefineOpenGLOnResize;
  end;{if}
end;{DefineOpenGLOnCreate}
//Финализация графики OpenGL
procedure TGLScene2D.DefineOpenGLOnDestroy;
begin
  if FDC<>0 then
  begin
    glDeleteLists (GLF_START_LIST, 256);
    wglMakeCurrent(0, 0);
    wglDeleteContext(Fhrc);
    ReleaseDC(Handle, FDC);
    DeleteDC(FDC);
    FDC := 0;
  end;{if}
end;{DefineOpenGLOnDestroy}
//Изменение видовых параметров OpenGL
procedure TGLScene2D.DefineOpenGLOnResize;
begin
  if FDC=0 then Exit;
  wglMakeCurrent(FDC, Fhrc);
  //Расчет контура проецирования
  FScaledBoundMtr := DefineScaledBoundMtr;
  //Преобразование порта просмотра
  glViewport(0, 0, WidthPxl, HeightPxl);
  //Преобразование проецирования
  glMatrixMode(GL_PROJECTION);               //устанавливаю матрицу проецирования
  glLoadIdentity;                            //обнуляю матрицу в единичную
  with FScaledBoundMtr do                    //задаю ортогональное проецирование
    gluOrtho2D(MinX,MaxX,MinY,MaxY);
  //Преобразование вида и модели
  glMatrixMode(GL_MODELVIEW);                //устанавливаю матрицу видового преобразования
  glLoadIdentity;                            //обнуляю матрицу в единичную
  if Assigned(FOnRendering)then FOnRendering(Self);
  //Вызов прорисовки
  Invalidate;
end;{DefineOpenGLOnResize}
//Прорисовка координатной сетки: CoordGridStyle=cgsPoint
procedure TGLScene2D.DrawCoordGridPointStyle(const MinValue,MaxValue: TPoint;
                                             const MaxI,MaxJ: Integer);
var I,J: Integer;
begin
  glSetColor(clGray);
  glPointSize(2.0);
  glBegin(GL_POINTS);
    for I := 0 to MaxI do
      for J := 0 to MaxJ do
        glVertex(MinValue.X+I*CoordGridStep,MinValue.Y+J*CoordGridStep);
  glEnd;
  glPointSize(1.0);
end;{DrawCoordGridPointStyle}
//Прорисовка координатной сетки: CoordGridStyle=cgsCross
procedure TGLScene2D.DrawCoordGridCrossStyle(const MinValue,MaxValue: TPoint;
                                             const MaxI,MaxJ: Integer);
var I,J,SmallStep: Integer;
begin
  glColor(0.1,0.1,0.1);
  SmallStep := CoordGridStep div 4;
  glLineWidth(1.0);
  glBegin(GL_LINES);
    for I := 0 to MaxI do
      for J := 0 to MaxJ do
      begin
        glVertex(MinValue.X+I*CoordGridStep-SmallStep,MinValue.Y+J*CoordGridStep);
        glVertex(MinValue.X+I*CoordGridStep+SmallStep,MinValue.Y+J*CoordGridStep);
        glVertex(MinValue.X+I*CoordGridStep,MinValue.Y+J*CoordGridStep-SmallStep);
        glVertex(MinValue.X+I*CoordGridStep,MinValue.Y+J*CoordGridStep+SmallStep);
      end;{if}
  glEnd;
end;{DrawCoordGridCrossStyle}
//Прорисовка координатной сетки: CoordGridStyle=cgsGrid
procedure TGLScene2D.DrawCoordGridGridStyle(const MinValue,MaxValue: TPoint;
                                            const MaxI,MaxJ: Integer);
var I,J: Integer;
begin
  glColor(0.1,0.1,0.1);
  glLineWidth(1.0);
  glBegin(GL_LINES);
    for I := 0 to MaxI do
    begin
      glVertex(MinValue.X+I*CoordGridStep,MinValue.Y);
      glVertex(MinValue.X+I*CoordGridStep,MinValue.Y+MaxJ*CoordGridStep);
    end;{for}
    for J := 0 to MaxJ do
    begin
      glVertex(MinValue.X,MinValue.Y+J*CoordGridStep);
      glVertex(MinValue.X+MaxI*CoordGridStep,MinValue.Y+J*CoordGridStep);
    end;{for}
  glEnd;
end;{DrawCoordGridGridStyle}
//Прорисовка текстовых отметок координатной сетки
procedure TGLScene2D.DrawCoordGridLabels(const MinValue,MaxValue: TPoint;
                                         const MaxI,MaxJ: Integer);
var I,J,X0,X1,Y0,Y1: Integer;
begin
  if (CoordGridStyle<>cgsNone)and CoordGridMarks then
  begin
    Y0 := Round(MinValue.Y+MaxJ*CoordGridStep+(MtrPerPxl*10));
    Y1 := Round(MinValue.Y-(MtrPerPxl*10));
    for I := 0 to MaxI do
    if not Odd(I) then
    begin
      X0 := MinValue.X+I*CoordGridStep;
      DrawText(X0,Y0,IntToStr(X0));
      DrawText(X0,Y1,IntToStr(X0));
    end;{for}
    X0 := Round(MinValue.X+MaxI*CoordGridStep+(MtrPerPxl*10));
    X1 := Round(MinValue.X-(MtrPerPxl*30));
    for J := 0 to MaxJ do
    if not Odd(J) then
    begin
      Y0 := MinValue.Y+J*CoordGridStep;
      DrawText(X0,Y0,IntToStr(Y0));
      DrawText(X1,Y0,IntToStr(Y0));
    end;{for}
  end;{if}
end;{DrawCoordGridLabels}
//Прорисовка процесса перетаскивания
procedure TGLScene2D.DrawMovingProcess;
begin
  if FIsMoving then
  begin
    glSetColor(clYellow);
    glLineWidth(1.0);
    glLineStipple(1,$F0F0);
    glEnable(GL_LINE_STIPPLE);
    glBegin(GL_LINES);
      glVertex2f(FMovingPos0.X,FMovingPos0.Y);
      glVertex2f(FMovingPos1.X,FMovingPos1.Y);
    glEnd;
    glDisable(GL_LINE_STIPPLE);
    glPointSize(10.0);
    glBegin(GL_POINTS);
      glVertex2f(FMovingPos0.X,FMovingPos0.Y);
      glVertex2f(FMovingPos1.X,FMovingPos1.Y);
    glEnd;
    glPointSize(1.0);
  end;{if}
end;{DrawMovingProcess}
//Прорисовка координатной сетки
procedure TGLScene2D.DrawCoordGrid;
var
  MaxI,MaxJ: Integer;
  MinValue, MaxValue: TPoint;
begin
  if CoordGridStyle=cgsNone then Exit;
  //MinValue & MaxValue
  MinValue.X := Trunc(FBoundMtr.MinX);
  MinValue.X := MinValue.X-(MinValue.X mod CoordGridStep);
  MinValue.Y := Trunc(FBoundMtr.MinY);
  MinValue.Y := MinValue.Y-(MinValue.Y mod CoordGridStep);

  MaxValue.X := Trunc(FBoundMtr.MaxX);
  MaxValue.X := MaxValue.X+(CoordGridStep-(MaxValue.X mod CoordGridStep));
  MaxValue.Y := Trunc(FBoundMtr.MaxY);
  MaxValue.Y := MaxValue.Y+(CoordGridStep-(MaxValue.Y mod CoordGridStep));

  MaxI := (MaxValue.X-MinValue.X)div CoordGridStep-1;
  MaxJ := (MaxValue.Y-MinValue.Y)div CoordGridStep-1;
  case CoordGridStyle of
    cgsPoint: DrawCoordGridPointStyle(MinValue,MaxValue,MaxI,MaxJ);
    cgsCross: DrawCoordGridCrossStyle(MinValue,MaxValue,MaxI,MaxJ);
    cgsGrid: DrawCoordGridGridStyle(MinValue,MaxValue,MaxI,MaxJ);
  end;{case}
  //Рисую текстовые отметки
  DrawCoordGridLabels(MinValue,MaxValue,MaxI,MaxJ);
end;{DrawCoordGrid}
//Вывод текста
procedure TGLScene2D.DrawText(const X,Y: Single; const Text : String);
begin
  glRasterPos2f (X,Y);
  glListBase(GLF_START_LIST);
  glCallLists(Length(Text), GL_UNSIGNED_BYTE, PChar(Text));
end;{DrawText}

constructor TGLScene2D.Create(AOwner: TWinControl);
begin
  FGLViewer := nil;
  FLayers := nil;
  inherited Create;
  if not Assigned(AOwner) then raise Exception.Create('AOwner: TWinControl');
  FGLViewer := TGLViewer.Create(AOwner);
  FGLViewer.Parent    := AOwner;
  FGLViewer.Align     := alClient;
  FGLViewer.Color     := clBlack;
  FGLViewer.GLScene2D := Self;
  FLayers             := TGLScene2DLayers.Create;
  FLayers.GLScene2D   := Self;
  FDC                 := 0;
  Fhrc                := 0;
  FHandle             := FGLViewer.Handle;
  FCanvasHandle       := FGLViewer.Canvas.Handle;
  FOnDraw             := nil;
  FOnScaleChanged     := nil;
  FOnRendering        := nil;
  FScale              := 1;
  FSpace              := Point(0,0);
  FBoundPxl           := Rect(0,0,100,100);
  FBoundMtr           := Bound3D(0.0,10000.0,0.0,10000.0,0.0,100.0);
  FScaledBoundMtr     := FBoundMtr;
  FScaledSizeMtr      := Point3D(10000.0,10000.0,100.0);
  FMtrPerPxl          := ScaledWidthMtr/WidthPxl;
  FCoordGridStyle     := cgsGrid;
  FCoordGridStep      := 200;
  FCoordGridMarks     := true;

  FIsMoving           := false;
  FMovingPos0         := Point3D(0.0,0.0,0.0);
  FMovingPos1         := Point3D(0.0,0.0,0.0);
  FMovingSpace0       := FSpace;
  FInvalidateEnable   := true;
  DefineOpenGLOnCreate;
end;{Create}
destructor TGLScene2D.Destroy;
begin
  FOnDraw        := nil;
  FOnScaleChanged:= nil;
  FOnRendering   := nil;
  FLayers.Free;
  FLayers := nil;
  FGLViewer.Free;
  FGLViewer := nil;
  DefineOpenGLOnDestroy;
  inherited;
end;{Destroy}
procedure TGLScene2D.Invalidate;
begin
  if (FHandle<>0)and FInvalidateEnable then InvalidateRect(Handle,nil,false);
end;{Invalidate}
//Прорисовка OpenGL
procedure TGLScene2D.Draw;
begin
  wglMakeCurrent(FDC, Fhrc);
  glClear(GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT);
  DrawCoordGrid;
  if FLayers<>nil then FLayers.Draw;
  if Assigned(FOnDraw) then FOnDraw(Self);
  DrawMovingProcess;
  SwapBuffers(FDC);
  wglMakeCurrent(0,0);
end;{Draw}
//Перевожу мировые координаты точки в пиксельные координаты экранной точки
function TGLScene2D.DefinePointMtrToPxl(const APointMtr: RPoint3D): RPoint3D;
var ABound: RBound3D;
begin
  ABound := FScaledBoundMtr;
  Result.X := FBoundPxl.Left+WidthPxl*(APointMtr.X-ABound.MinX)/FScaledSizeMtr.X;
  Result.Y := FBoundPxl.Top+HeightPxl*(1-(APointMtr.Y-ABound.MinY)/FScaledSizeMtr.Y);
  Result.Z := 0.0;
end;{DefinePointMtrToPxl}
//Перевожу пиксельные координаты экранной точки в мировые
function TGLScene2D.DefinePointPxlToMtr(const APointPxl: RPoint3D): RPoint3D;
var ABound: RBound3D;
begin
  ABound := FScaledBoundMtr;
  Result.X := ABound.MinX+FScaledSizeMtr.X*(APointPxl.X-FBoundPxl.Left)/WidthPxl;
  Result.Y := ABound.MinY+FScaledSizeMtr.Y*(1-(APointPxl.Y-FBoundPxl.Top)/HeightPxl);
  Result.Z := 0.0;
end;{DefinePointPxlToMtr}
//Масштабирование на DeltaScale относительно точки экрана(X,Y)
procedure TGLScene2D.ScaleTo(const X,Y,DeltaScale: Integer);
var APointPxl,APointMtr0,APointMtr1: RPoint3D;
begin
  if DeltaScale<>0 then
  begin
    APointPxl := Point3D(X,Y,0.0);
    APointMtr0 := DefinePointPxlToMtr(APointPxl);
    Scale := Scale+DeltaScale;
    APointMtr1 := DefinePointPxlToMtr(APointPxl);
    MoveBy(Round(APointMtr0.X-APointMtr1.X),Round(APointMtr0.Y-APointMtr1.Y));
  end;{if}
end;{ScaleTo}
procedure TGLScene2D.MoveBy(const dX, dY: Integer);
begin
  Space := Point(FSpace.X+dX,FSpace.Y+dY);
end;{MoveBy}

//Начало перетаскивания контура
procedure TGLScene2D.MovingStart(const PxlX, PxlY: Integer);
begin
  if not FIsMoving then
  begin
    FIsMoving := true;
    FMovingPos0 := DefinePointPxlToMtr(Point3D(PxlX,PxlY,0.0));
    FMovingPos1 := FMovingPos0;
    FMovingSpace0 := FSpace;
    Invalidate;
  end;{if}
end;{MovingStart}
//Процесс перетаскивания контура
procedure TGLScene2D.MovingMove(const PxlX, PxlY: Integer);
begin
  if FIsMoving then
  begin
    FMovingPos1 := DefinePointPxlToMtr(Point3D(PxlX,PxlY,0.0));
    Invalidate;
  end;{if}
end;{MovingMove}
//Конец перетаскивания контура
procedure TGLScene2D.MovingFinish(const PxlX, PxlY: Integer);
begin
  if FIsMoving then
  begin
    FIsMoving := false;
    FMovingPos1 := DefinePointPxlToMtr(Point3D(PxlX,PxlY,0.0));
    Space := Point(FMovingSpace0.X-Round(FMovingPos1.X-FMovingPos0.X),
                   FMovingSpace0.Y-Round(FMovingPos1.Y-FMovingPos0.Y));
    FMovingSpace0 := Space;
    Invalidate;
  end;{if}
end;{MovingFinish}
//Отмена перетаскивания контура
procedure TGLScene2D.MovingStop;
begin
  if FIsMoving then
  begin
    FIsMoving := false;
    Space := FMovingSpace0;
    Invalidate;
  end;{if}
end;{MovingStop}
procedure TGLScene2D.DisableInvalidate;//Запрет на вызов прорисовки
begin
  FInvalidateEnable := false;
end;{DisableInvalidate}
procedure TGLScene2D.EnableInvalidate;//Разрешение на вызов прорисовки
begin
  FInvalidateEnable := true;
end;{EnableInvalidate}

//"Объект GLScene2D" --------------------------------------------------------------------------
function TGLScene2DObject.GetHandle: HWND;
begin
  if FGLScene2D<>nil then Result := FGLScene2D.Handle else Result := 0;
end;{GetHandle}
function TGLScene2DObject.GetCanvasHandle: HWND;
begin
  if FGLScene2D<>nil then Result := FGLScene2D.CanvasHandle else Result := 0;
end;{GetCanvasHandle}
constructor TGLScene2DObject.Create;
begin
  inherited;
  FGLScene2D := nil;
  //Geometry
  FIsSelected   := false;
  //Graphic
  FColor        := clRed;
  FSelectedColor:= clYellow;
  FVisible      := true;
end;{Create}
destructor TGLScene2DObject.Destroy;
begin
  Clear;
  FGLScene2D := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DObject.Invalidate;
begin
  if FGLScene2D<>nil then FGLScene2D.Invalidate;
end;{Invalidate}
procedure TGLScene2DObject.Clear;
begin
end;{Clear}
procedure TGLScene2DObject.Draw;
begin
end;{Draw}
procedure TGLScene2DObject.EnableInvalidate; //Разрешение на вызов прорисовки
begin
  if FGLScene2D<>nil then FGLScene2D.EnableInvalidate;
end;{EnableInvalidate}
procedure TGLScene2DObject.DisableInvalidate;//Запрет на вызов прорисовки
begin
  if FGLScene2D<>nil then FGLScene2D.DisableInvalidate;
end;{DisableInvalidate}
procedure TGLScene2DObject.SetIsSelected(const Value: Boolean);
begin
  if FIsSelected<>Value then
  begin
    FIsSelected := Value;
    Invalidate;
  end;{if}
end;{SetIsSelected}
procedure TGLScene2DObject.SetColor(const Value: TColor);
begin
  if FColor<>Value then
  begin
    FColor := Value;
    Invalidate;
  end;{if}
end;{SetColor}
procedure TGLScene2DObject.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor<>Value then
  begin
    FSelectedColor := Value;
    Invalidate;
  end;{if}
end;{SetSelectedColor}
procedure TGLScene2DObject.SetGLScene2D(const Value: TGLScene2D);
begin
  if FGLScene2D<>Value then
  begin
    FGLScene2D := Value;
    Invalidate;
  end;{if}
end;{SetGLScene2D}
procedure TGLScene2DObject.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible := Value;
    Invalidate;
  end;{if}
end;{SetVisible}

//"CustomПолилиния GLScene2D" -----------------------------------------------------------------
constructor TGLScene2DCustomPolyline.Create;
begin
  inherited;
  FItems   := TList.Create;
  //Geometry
  FLength             := 0.0;
  FSelectedIndex      := -1;
  //Graphic
  FLineWidth          := 1;
  FLinePattern        := $FFFF;
  FLineFactor         := 1;
  FRadius             := 2;
end;{Create}
destructor TGLScene2DCustomPolyline.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DCustomPolyline.Clear;
begin
  if FItems<>nil then
  begin
    ClearList(FItems);
    FLength := 0.0;
    FSelectedIndex := -1;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGLScene2DCustomPolyline.Draw;
var I: Integer;
begin
  if Visible and(Count>0) then
  begin
    //Polyline---------------------------------------------------------------------------------
    if Count>1 then
    begin
      glSetColor(FColor);
      if IsSelected
      then glLineStipple(1,$F0F0)
      else glLineStipple(FLineFactor,FLinePattern);
      glLineWidth(FLineWidth);
      glEnable(GL_LINE_STIPPLE);
      glBegin(GL_LINES);
        for I := 1 to Count-1 do
        begin
          glVertex2f(Items[I-1].Coords.X,Items[I-1].Coords.Y);
          glVertex2f(Items[I].Coords.X,Items[I].Coords.Y);
        end;{for}
      glEnd;
      glDisable(GL_LINE_STIPPLE);
    end;{if}
    //Points-----------------------------------------------------------------------------------
    if FIsSelected then
    begin//Все точки рисуются токо при выделении прямой
      glPointSize(FRadius*2);
      glSetColor(FColor);
      glEnable(GL_POINT_SMOOTH);
      glBegin(GL_POINTS);
        for I := 0 to Count-1 do
          if I<>FSelectedIndex
          then glVertex2f(Items[I].Coords.X,Items[I].Coords.Y);
      glEnd;
    end;{if}
    //SelectedPoint----------------------------------------------------------------------------
    if FSelectedIndex>-1 then
    begin
      glPointSize(FRadius*3);
      glSetColor(FSelectedColor);
      glBegin(GL_POINTS);
        glVertex2f(Selected.Coords.X,Selected.Coords.Y);
      glEnd;
    end;{if}
    glPointSize(1.0);
    glDisable(GL_POINT_SMOOTH);
  end;{if}
end;{Draw}
function TGLScene2DCustomPolyline.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGLScene2DCustomPolyline.GetItem(const Index: Integer): ROpenpitPoint3D;
begin
  if InRange(Index,0,Count-1)
  then Result := POpenpitPoint3D(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGLScene2DCustomPolyline.GetFirst: ROpenpitPoint3D;
begin
  if Count>0
  then Result := POpenpitPoint3D(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGLScene2DCustomPolyline.GetLast: ROpenpitPoint3D;
begin
  if Count>0
  then Result := POpenpitPoint3D(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
function TGLScene2DCustomPolyline.GetSelected: ROpenpitPoint3D;
begin
  if InRange(FSelectedIndex,0,Count-1)
  then Result := POpenpitPoint3D(FItems[FSelectedIndex])^
  else Raise Exception.Create(Format(EInvalidIndex,[FSelectedIndex,Count-1]));
end;{GetSelected}
procedure TGLScene2DCustomPolyline.SetSelectedIndex(const Value: Integer);
begin
  if (FSelectedIndex<>Value)and InRange(Value,-1,Count-1) then
  begin
    FSelectedIndex := Value;
    Invalidate;
  end;{if}
end;{SetSelectedIndex}
procedure TGLScene2DCustomPolyline.SetLineWidth(const Value: Single);
begin
  if (FLineWidth<>Value)and(Value>0.0) then
  begin
    FLineWidth := Value;
    Invalidate;
  end;{if}
end;{SetLineWidth}
procedure TGLScene2DCustomPolyline.SetLinePattern(const Value: Word);
begin
  if (FLinePattern<>Value)and(Value>0) then
  begin
    FLinePattern := Value;
    Invalidate;
  end;{if}
end;{SetLinePattern}
procedure TGLScene2DCustomPolyline.SetLineFactor(const Value: Integer);
begin
  if (FLineFactor<>Value)and(Value>0) then
  begin
    FLineFactor := Value;
    Invalidate;
  end;{if}
end;{SetLineFactor}
procedure TGLScene2DCustomPolyline.SetRadius(const Value: Integer);
begin
  if (FRadius<>Value)and(Value>0) then
  begin
    FRadius := Value;
    Invalidate;
  end;{if}
end;{SetRadius}
procedure TGLScene2DCustomPolyline.SetIsSelected(const Value: Boolean);
begin
  FSelectedIndex := -1;
  inherited;
end;{SetIsSelected}
procedure TGLScene2DCustomPolyline.SetItem(const Index: Integer;const Value: ROpenpitPoint3D);
begin
  if InRange(Index,0,Count-1) then
  begin
    POpenpitPoint3D(FItems[Index])^ := Value;
    DefineLength;
    Invalidate;
  end{if}
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{SetItem}
//Определяю длину полилинии
procedure TGLScene2DCustomPolyline.DefineLength;
var
  I: Integer;
  Item0,Item1: RPoint3D;
begin
  FLength := 0.0;
  if FItems<>nil then
  for I := 1 to FItems.Count-1 do
  begin
    Item0 := POpenpitPoint3D(FItems[I-1])^.Coords;
    Item1 := POpenpitPoint3D(FItems[I])^.Coords;
    FLength := FLength+sqrt(sqr(Item1.X-Item0.X)+sqr(Item1.Y-Item0.Y)+sqr(Item1.Z-Item0.Z));
  end;{for}
end;{DefineLength}
procedure TGLScene2DCustomPolyline.Delete(const Index: Integer);
var I: Integer;
begin
  if InRange(Index,0,FItems.Count-1) then
  for I := FItems.Count-1 downto 0 do
  if Index=I then
  begin
    FSelectedIndex := -1;
    FIsSelected := false;
    Dispose(FItems[I]);
    FItems.Delete(I);
    Invalidate;
    Break;
  end;{for}
end;{Delete}
procedure TGLScene2DCustomPolyline.DeleteAll;
begin
  FSelectedIndex := -1;
  FIsSelected := false;
  Clear;
end;{DeleteAll}
function TGLScene2DCustomPolyline.IndexOf(const X, Y, Distance: Single): Integer;
var
  I: Integer;
  R2: Single;
begin
  FSelectedIndex := -1;
  FIsSelected    := false;
  Result         := -1;
  //Point
  if GLScene2D<>nil then
  begin
    R2 := sqr(FRadius*GLScene2D.MtrPerPxl);
    for I := 0 to Count-1 do
    if sqr(Items[I].Coords.X-X)+sqr(Items[I].Coords.Y-Y)<=R2 then
    begin
      FSelectedIndex := I;
      FIsSelected := true;
      Break;
    end;{for}
  end;{if}
  //Polyline
  if not FIsSelected then
  begin
  end;{if}
  Invalidate;
end;{IndexOf}

//"Объект GLScene2D" --------------------------------------------------------------------------
function TGLScene2DPolyline.Add(const APoint: RPoint3D; const AId_Point: Integer=-1): Integer;
var AOpenpitPoint: POpenpitPoint3D;
begin
  New(AOpenpitPoint);
  AOpenpitPoint^.Id_Point := AId_Point;
  AOpenpitPoint^.Coords := APoint;
  FItems.Add(AOpenpitPoint);
  Result := FItems.Count-1;
  FSelectedIndex := -1;
  DefineLength;
  Invalidate;
end;{Add}

//"Полигон GLScene2D" -------------------------------------------------------------------------
procedure TGLScene2DPolygon.Draw;
var I: Integer;
begin
  if Visible and(Count>0) then
  begin
    //Polygon---------------------------------------------------------------------------------
    if Count>1 then
    begin
      glSetColor(FColor);
      if IsSelected
      then glLineStipple(1,$F0F0)
      else glLineStipple(FLineFactor,FLinePattern);
      glLineWidth(FLineWidth);
      glEnable(GL_LINE_STIPPLE);
      glBegin(GL_POLYGON);
        for I := 0 to Count-1 do
          glVertex2f(Items[I].Coords.X,Items[I].Coords.Y);
      glEnd;
      glDisable(GL_LINE_STIPPLE);
    end;{if}
    //Points-----------------------------------------------------------------------------------
    if FIsSelected then
    begin//Все точки рисуются токо при выделении прямой
      glPointSize(FRadius*2);
      glSetColor(FColor);
      glEnable(GL_POINT_SMOOTH);
      glBegin(GL_POINTS);
        for I := 0 to Count-1 do
          if I<>FSelectedIndex
          then glVertex2f(Items[I].Coords.X,Items[I].Coords.Y);
      glEnd;
    end;{if}
    //SelectedPoint----------------------------------------------------------------------------
    if FSelectedIndex>-1 then
    begin
      glPointSize(FRadius*3);
      glSetColor(FSelectedColor);
      glBegin(GL_POINTS);
        glVertex2f(Selected.Coords.X,Selected.Coords.Y);
      glEnd;
    end;{if}
    glPointSize(1.0);
    glDisable(GL_POINT_SMOOTH);
  end;{if}
end;{Draw}

//"Текстовая отметка GLScene2D" ---------------------------------------------------------------
function TGLScene2DLabel.GetPoint: ROpenpitPoint3D;
var AItem: POpenpitPoint3D;
begin
  if Count=0 then
  begin
    New(AItem);
    AItem^.Id_Point := 0;
    AItem^.Coords := Point3D(0.0,0.0,0.0);
    FItems.Add(AItem);
  end;{if}
  Result := POpenpitPoint3D(FItems.First)^;
end;{GetPoint}
procedure TGLScene2DLabel.SetPoint(const Value: ROpenpitPoint3D);
var AItem: POpenpitPoint3D;
begin
  if Count=0 then
  begin
    New(AItem);
    AItem^ := Value;
    FItems.Add(AItem);
  end;{if}
  POpenpitPoint3D(FItems.First)^ := Value;
  Invalidate;
end;{SetPoint}
function TGLScene2DLabel.GetCoords: RPoint3D;
var AItem: PPoint3D;
begin
  if Count=0 then
  begin
    New(AItem);
    AItem^ := Point3D(0.0,0.0,0.0);
    FItems.Add(AItem);
  end;{if}
  Result := PPoint3D(FItems.First)^;
end;{GetCoords}
procedure TGLScene2DLabel.SetCoords(const Value: RPoint3D);
var AItem: PPoint3D;
begin
  if Count=0 then
  begin
    New(AItem);
    AItem^ := Value;
    FItems.Add(AItem);
  end;{if}
  PPoint3D(FItems.First)^ := Value;
  Invalidate;
end;{SetCoords}
procedure TGLScene2DLabel.SetText(const Value: String);
begin
  if FText<>Value then
  begin
    FText := Value;
    Invalidate;
  end;{if}
end;{SetText}
procedure TGLScene2DLabel.Draw;
begin
  if Visible and(FGLScene2D<>nil)and(FText<>'')then
  begin
    glSetColor(FColor);
    FGLScene2D.DrawText(Coords.X,Coords.Y,FText);
  end;{if}
end;{Draw}
constructor TGLScene2DLabel.Create;
begin
  inherited;
  FText := '';
end;{Create}

//"Полилинии GLScene2D" -----------------------------------------------------------------------
constructor TGLScene2DPolylines.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGLScene2DPolylines.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DPolylines.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGLScene2DPolyline(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    FIsSelected := false;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGLScene2DPolylines.Draw;
var I: Integer;
begin
  if Visible then
  begin
    glPushMatrix;
    for I := 0 to Count-1 do
      Items[I].Draw;
    glPopMatrix;
  end;{if}
end;{Draw}
function TGLScene2DPolylines.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGLScene2DPolylines.GetItem(const Index: Integer): TGLScene2DPolyline;
begin
  if InRange(Index,0,Count-1)
  then Result := PGLScene2DPolyline(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGLScene2DPolylines.GetFirst: TGLScene2DPolyline;
begin
  if Count>0
  then Result := PGLScene2DPolyline(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGLScene2DPolylines.GetLast: TGLScene2DPolyline;
begin
  if Count>0
  then Result := PGLScene2DPolyline(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGLScene2DPolylines.SetGLScene2D(const Value: TGLScene2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GLScene2D := GLScene2D;
end;{SetGLScene2D}
procedure TGLScene2DPolylines.Append;
var AItem: PGLScene2DPolyline;
begin
  New(AItem);
  AItem^ := TGLScene2DPolyline.Create;
  AItem^.GLScene2D := FGLScene2D;
  FItems.Add(AItem);
  Invalidate;
end;{Append}

//"Полигоны GLScene2D" ------------------------------------------------------------------------
constructor TGLScene2DPolygons.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGLScene2DPolygons.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DPolygons.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGLScene2DPolygon(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    FIsSelected := false;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGLScene2DPolygons.Draw;
var I: Integer;
begin
  if Visible then
  begin
    glPushMatrix;
    for I := 0 to Count-1 do
      Items[I].Draw;
    glPopMatrix;
  end;{if}
end;{Draw}
function TGLScene2DPolygons.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGLScene2DPolygons.GetItem(const Index: Integer): TGLScene2DPolygon;
begin
  if InRange(Index,0,Count-1)
  then Result := PGLScene2DPolygon(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGLScene2DPolygons.GetFirst: TGLScene2DPolygon;
begin
  if Count>0
  then Result := PGLScene2DPolygon(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGLScene2DPolygons.GetLast: TGLScene2DPolygon;
begin
  if Count>0
  then Result := PGLScene2DPolygon(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGLScene2DPolygons.SetGLScene2D(const Value: TGLScene2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GLScene2D := GLScene2D;
end;{SetGLScene2D}
procedure TGLScene2DPolygons.Append;
var AItem: PGLScene2DPolygon;
begin
  New(AItem);
  AItem^ := TGLScene2DPolygon.Create;
  AItem^.GLScene2D := FGLScene2D;
  FItems.Add(AItem);
  Invalidate;
end;{Append}

//"Текстовые отметки GLScene2D" ---------------------------------------------------------------
constructor TGLScene2DLabels.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGLScene2DLabels.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DLabels.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGLScene2DLabel(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    FIsSelected := false;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGLScene2DLabels.Draw;
var I: Integer;
begin
  if Visible then
  begin
    glPushMatrix;
    for I := 0 to Count-1 do
      Items[I].Draw;
    glPopMatrix;
  end;{if}
end;{Draw}
function TGLScene2DLabels.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGLScene2DLabels.GetItem(const Index: Integer): TGLScene2DLabel;
begin
  if InRange(Index,0,Count-1)
  then Result := PGLScene2DLabel(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGLScene2DLabels.GetFirst: TGLScene2DLabel;
begin
  if Count>0
  then Result := PGLScene2DLabel(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGLScene2DLabels.GetLast: TGLScene2DLabel;
begin
  if Count>0
  then Result := PGLScene2DLabel(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGLScene2DLabels.SetGLScene2D(const Value: TGLScene2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GLScene2D := GLScene2D;
end;{SetGLScene2D}
procedure TGLScene2DLabels.Append;
var AItem: PGLScene2DLabel;
begin
  New(AItem);
  AItem^ := TGLScene2DLabel.Create;
  AItem^.GLScene2D := FGLScene2D;
  FItems.Add(AItem);
  Invalidate;
end;{Append}

//"Слой GLScene2D" ----------------------------------------------------------------------------
procedure TGLScene2DLayer.SetName(const Value: String);
begin
  if FName<>Value then
  begin
    FName := Value;
    Invalidate;
  end;{if}
end;{SetName}
procedure TGLScene2DLayer.SetGLScene2D(const Value: TGLScene2D);
begin
  inherited;
  LWPolylines.GLScene2D := GLScene2D;
  Polylines.GLScene2D := GLScene2D;
  MLines.GLScene2D := GLScene2D;
  Lines.GLScene2D := GLScene2D;
  MLines.GLScene2D := GLScene2D;
  Hatchs.GLScene2D := GLScene2D;
  Labels.GLScene2D := GLScene2D;
end;{SetGLScene2D}
procedure TGLScene2DLayer.Clear;
begin
  if FPolylines<>nil then FPolylines.Clear;
  if FLWPolylines<>nil then FLWPolylines.Clear;
  if FLines<>nil then FLines.Clear;
  if FMLines<>nil then FMLines.Clear;
  if FLabels<>nil then FLabels.Clear;
end;{Clear}
constructor TGLScene2DLayer.Create;
begin
  inherited;
  FName := '';
  FPolylines   := TGLScene2DPolylines.Create;
  FPolylines.GLScene2D := FGLScene2D;
  FLWPolylines := TGLScene2DPolylines.Create;
  FLWPolylines.GLScene2D := FGLScene2D;
  FLines       := TGLScene2DPolylines.Create;
  FLines.GLScene2D := FGLScene2D;
  FMLines      := TGLScene2DPolylines.Create;
  FMLines.GLScene2D := FGLScene2D;
  FHatchs      := TGLScene2DPolygons.Create;
  FHatchs.GLScene2D := FGLScene2D;
  FLabels      := TGLScene2DLabels.Create;
  FLabels.GLScene2D := FGLScene2D;
end;{Create}
destructor TGLScene2DLayer.Destroy;
begin
  FPolylines.Free;
  FPolylines := nil;
  FLWPolylines.Free;
  FLWPolylines := nil;
  FLines.Free;
  FLines := nil;
  FMLines.Free;
  FMLines := nil;
  FHatchs.Free;
  FHatchs := nil;
  FLabels.Free;
  FLabels := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DLayer.Draw;
begin
  if Visible then
  begin
    if FHatchs<>nil then FHatchs.Draw;
    if FPolylines<>nil then FPolylines.Draw;
    if FLWPolylines<>nil then FLWPolylines.Draw;
    if FMLines<>nil then FMLines.Draw;
    if FLines<>nil then FLines.Draw;
    if FLabels<>nil then FLabels.Draw;
  end;{if}
end;{Draw}

//"Слои GLScene2D" ----------------------------------------------------------------------------
constructor TGLScene2DLayers.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGLScene2DLayers.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGLScene2DLayers.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGLScene2DLayer(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGLScene2DLayers.Draw;
var I: Integer;
begin
  if Visible then
  begin
    glPushMatrix;
    //Полигоны
    for I := 0 to Count-1 do
      if Items[I].Visible then
        if Items[I].FHatchs<>nil then Items[I].FHatchs.Draw;
    //Остальные
    for I := 0 to Count-1 do
      if Items[I].Visible then
      begin
        if Items[I].FPolylines<>nil then Items[I].FPolylines.Draw;
        if Items[I].FLWPolylines<>nil then Items[I].FLWPolylines.Draw;
        if Items[I].FMLines<>nil then Items[I].FMLines.Draw;
        if Items[I].FLines<>nil then Items[I].FLines.Draw;
        if Items[I].FLabels<>nil then Items[I].FLabels.Draw;
      end;{if}
    glPopMatrix;
  end;{if}
end;{Draw}
function TGLScene2DLayers.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGLScene2DLayers.GetItem(const Index: Integer): TGLScene2DLayer;
begin
  if InRange(Index,0,Count-1)
  then Result := PGLScene2DLayer(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGLScene2DLayers.GetFirst: TGLScene2DLayer;
begin
  if Count>0
  then Result := PGLScene2DLayer(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGLScene2DLayers.GetLast: TGLScene2DLayer;
begin
  if Count>0
  then Result := PGLScene2DLayer(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGLScene2DLayers.SetGLScene2D(const Value: TGLScene2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GLScene2D := GLScene2D;
end;{SetGLScene2D}
function TGLScene2DLayers.Append: Integer;
var AItem: PGLScene2DLayer;
begin
  New(AItem);
  AItem^ := TGLScene2DLayer.Create;
  AItem^.GLScene2D := FGLScene2D;
  FItems.Add(AItem);
  Result := Count-1;
  Invalidate;
end;{Append}
procedure TGLScene2DLayers.Delete(const Index: Integer);
begin
  if InRange(Index,0,Count-1) then
  begin
    PGLScene2DLayer(FItems[Index])^.Free;
    Dispose(FItems[Index]);
    FItems.Delete(Index);
    Invalidate;
  end{if}
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{Delete}
function TGLScene2DLayers.IndexOf(const Name: String): Integer;
var I: Integer;
begin
  Result := -1;
  for I := 0 to Count-1 do
    if Items[I].Name=Name then
    begin
      Result := I; Break;
    end;{for}
end;{IndexOf}
//Диалог.окно для установки Видимости для слоев
function TGLScene2DLayers.OptionsDialogExecute: Boolean;
var
  Form: TForm;
  pnBtns: TPanel;
  btOk,btCancel: TButton;
  CheckListBox: TCheckListBox;
  I: Integer;
begin
   Result := false;
   Form := CreateDialogForm('Видимость слоев подложки',600,320);
   try
     pnBtns := TPanel.Create(Form);
     pnBtns.Parent := Form;
     pnBtns.Align := alBottom;
     pnBtns.BevelOuter := bvNone;
     pnBtns.BevelInner := bvNone;
     btOk := TButton.Create(pnBtns);
     SetButtonProperties(btOk,pnBtns,Point(224,8),'Ok',true,false,mrOk);
     btCancel := TButton.Create(pnBtns);
     SetButtonProperties(btCancel,pnBtns,Point(304,8),'Отмена',false,true,mrCancel);
     CheckListBox := TCheckListBox.Create(Form);
     CheckListBox.Parent := Form;
     CheckListBox.Align := alClient;
     for I := 0 to Count-1 do
     with Items[I] do
     begin
       CheckListBox.Items.Add(Format('%.50s (LWPolyline(%d) Polyline(%d) Line(%d) MLine(%d) Hatch(%d) MText(%d))',
         [Name,LWPolylines.Count,Polylines.Count,Lines.Count,MLines.Count,Hatchs.Count,Labels.Count]));
       CheckListBox.Checked[I] := Items[I].Visible;
     end;{for}
     if Form.ShowModal=mrOk then
     begin
       for I := 0 to Count-1 do
         Items[I].Visible := CheckListBox.Checked[I];
     end;{if}
   finally
     Form.Free;
   end;{try}
end;{OptionsDialogExecute}

//Считываю подложку из AutoCAD 2004 DXF
function TGLScene2DLayers.LoadFromAutoCAD2004DBXFile(const AFileName: String): Boolean;
type
  TObjectKind=(okNone,okLWPOLYLINE,okPOLYLINE,okMLINE,okLINE,okHATCH,okMTEXT);
  RObjectInfo=record
    Kind        : TObjectKind;//'  0'
    Layer       : String;     //'  8'
    Color       : TColor;     //' 62'
    Text        : String;     //'  1'
    LineWidth   : Single;     //'370'
    Points      : TList;
  end;
  function CreateForm(const AFileName: String; var ValueListEditor: TValueListEditor): TForm;
  begin
    Result := CreateDialogForm(Format('Конвертирую файл ''..\%s''...',
                              [ExtractFileName(AFileName)]),400,184);
    Result.FormStyle := fsStayOnTop;
    ValueListEditor := TValueListEditor.Create(Result);
    ValueListEditor.Parent := Result;
    ValueListEditor.Align := alClient;
    ValueListEditor.Enabled := false;
    ValueListEditor.ScrollBars := ssNone;
    ValueListEditor.TitleCaptions[0] := 'Объект';
    ValueListEditor.TitleCaptions[1] := 'Количество';
    ValueListEditor.Strings.Append('Layer=0');
    ValueListEditor.Strings.Append('LWPolyline=0');
    ValueListEditor.Strings.Append('Polyline=0');
    ValueListEditor.Strings.Append('MLine=0');
    ValueListEditor.Strings.Append('Line=0');
    ValueListEditor.Strings.Append('HATCH=0');
    ValueListEditor.Strings.Append('MText=0');
    ValueListEditor.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goColSizing,goRowSelect];
  end;{CreateForm}
  function GetObjectKind(const sId,sValue: String): TObjectKind;
  begin
    Result := okNone;
    if sId='  0' then
    begin
      if sValue='LWPOLYLINE' then Result := okLWPOLYLINE;
      if sValue='POLYLINE' then Result := okPOLYLINE;
      if sValue='MLINE' then Result := okMLINE;
      if sValue='LINE' then Result := okLINE;
      if sValue='HATCH' then Result := okHATCH;
      if sValue='MTEXT' then Result := okMTEXT;
    end;{if}
  end;{GetObjectKind}
  function GetObjectLayer(const sId,sValue: String): String;
  begin
    if sId='  8' then Result := sValue else Result := '';
  end;{GetObjectLayer}
  function GetObjectColor(const sId,sValue: String): TColor;
  begin
    if (sId<>' 62')OR(sValue='')
    then Result := clWhite
    else
      try
        Result := AutoCADColorTable[StrToInt(sValue)];
      except
        Result := clWhite;
      end;{try}
  end;{GetObjectColor}
  function GetObjectText(const sId,sValue: String): String;
  begin
    if sId='  1' then Result := ConvertAutoCADText(sValue) else Result := '';
  end;{GetObjectText}
  function GetObjectLineWidth(const sId,sValue: String): Single;
  begin
    if (sId='370')AND(sValue<>'') then Result := StrToFloatEx(sValue)*0.01 else Result := 0.3;
  end;{GetObjectLineWidth}
  function GetObjectX(const sId,sValue: String): Single;
  begin
    if ((sId=' 10')OR(sId=' 11'))AND(sValue<>'0.0')AND(sValue<>'0,0')AND(sValue<>'')
    then Result := StrToFloatEx(sValue)
    else Result := 0.0;
  end;{GetObjectX}
  function GetObjectY(const sId,sValue: String): Single;
  begin
    if ((sId=' 20')OR(sId=' 21'))AND(sValue<>'0.0')AND(sValue<>'0,0')AND(sValue<>'')
    then Result := StrToFloatEx(sValue)
    else Result := 0.0;
  end;{GetObjectY}
  function GetObjectVertexNo(const sId,sValue: String): Integer;
  begin
    if (sId<>' 70')OR(sValue='')
    then Result := 0
    else
      try
        Result := StrToInt(sValue);
      except
        Result := 0;
      end;{try}
  end;{GetObjectVertexNo}
  //Вытаскиваю данные по очередному объекту
  function GetObject(var AObjectInfo: RObjectInfo; var f: TextFile; var sId,sValue: String): Integer;
  var
    AObjectX        : Single;     //' 10' or ' 11'
    AObjectY        : Single;     //' 20' or ' 21'
    AObjectVertexNo : Integer;    //' 70'
    APoint          : PPoint3D;
    AIsDifferent    : Boolean;
    ABaseVertexNo   : Integer;
    AVertexState    : (vsNone,vsYes,vsNo);
    I: Integer;
  begin
    Result := 0;
    sId := '';
    try
      //Считываю INFO объекта и POINTS объекта-------------------------------------------------
      AObjectInfo.Layer     := '';      AObjectInfo.Color     := clWhite;
      AObjectInfo.Text      := '';      AObjectInfo.LineWidth := 0.3;
      AObjectX              := 0.0;     AObjectY              := 0.0;
      ClearList(AObjectInfo.Points);    AVertexState          := vsNone;
      while (not EOF(f)) AND (sId<>'  0') do
      begin
        ReadLn(f,sId); ReadLn(f,sValue);
        if (sId='  8') then AObjectInfo.Layer := GetObjectLayer(sId,sValue);
        if (sId=' 62') then AObjectInfo.Color := GetObjectColor(sId,sValue);
        if (sId='  1') then AObjectInfo.Text := GetObjectText(sId,sValue);
        if (sId='370') then AObjectInfo.LineWidth := GetObjectLineWidth(sId,sValue);
        if (sId=' 10')OR(sId=' 11') then AObjectX := GetObjectX(sId,sValue);
        if (sId=' 20')OR(sId=' 21') then
        begin
          AObjectY := GetObjectY(sId,sValue);
          if (abs(AObjectX)>=0.001)and(abs(AObjectX)>=0.001) then
          begin
            New(APoint);
            APoint^ := Point3D(AObjectX,AObjectY,0.0);
            AObjectInfo.Points.Add(APoint);
          end;{if}
        end;{if}
      end;{while}
      //Считываю VERTEX-Points объекта, если имеются, конечно----------------------------------
      if (sId='  0')and(sValue='VERTEX')then
      begin//VERTEX-точки имеются
        AObjectVertexNo  := 0;
        sId := '';
        ClearList(AObjectInfo.Points);//если имеются VERTEX-Points, то просто Points нафиг не нужны
        while not (EOF(f) OR((sID='  0')and(sValue<>'VERTEX'))) do
        begin
          ReadLn(f,sId); ReadLn(f,sValue);
          if (sId=' 10')OR(sId=' 11') then AObjectX := GetObjectX(sId,sValue);
          if (sId=' 20')OR(sId=' 21') then AObjectY := GetObjectY(sId,sValue);
          if (sId=' 70') then AObjectVertexNo := GetObjectVertexNo(sId,sValue);
          if (sId='  0') then
          begin
            if AVertexState=vsNone then
            begin
              if AObjectVertexNo<>0
              then AVertexState := vsYes
              else AVertexState := vsNo;
            end;{if}
            if AVertexState<>vsYes then AObjectVertexNo := 0;
            New(APoint);
            APoint^ := Point3D(AObjectX,AObjectY,AObjectVertexNo);
            AObjectInfo.Points.Add(APoint);
            AObjectVertexNo := 0;
          end;{if}
        end;{while}
        //Отсеиваю ненужные Vertex-Points
        if AObjectInfo.Points.Count>1 then
        begin
          //проверяю, различаются ли у Vertex-Points их VertexNo
          AIsDifferent := false;
          ABaseVertexNo := Round(PPoint3D(AObjectInfo.Points.First)^.Z);
          for I := 1 to AObjectInfo.Points.Count-1 do
          if ABaseVertexNo<>Round(PPoint3D(AObjectInfo.Points[I])^.Z)then
          begin
            AIsDifferent := true;
            ABaseVertexNo := Round(PPoint3D(AObjectInfo.Points[I])^.Z);
            Break;
          end;{for}
          //если VertexNo у Vertex-Points различаются, то удаляю все отличные от ABaseVertexNo
          if AIsDifferent then
            for I := AObjectInfo.Points.Count-1 downto 0 do
            if ABaseVertexNo<>Round(PPoint3D(AObjectInfo.Points[I])^.Z)then
            begin
              Dispose(AObjectInfo.Points[I]);
              AObjectInfo.Points.Delete(I);
            end;{for}
        end;{if}
      end;{else}
      //Итак, считал все данные по очередному объекту
      Result := AObjectInfo.Points.Count;
    except
      sId := '';
    end;{try}
  end;{GetObject}
  procedure IncCount(var ACount: Integer; const ANo: Integer; var ValueListEditor: TValueListEditor);
  begin
    Inc(ACount);
    ValueListEditor.Cells[1,ANo] := IntToStr(ACount);
    TForm(ValueListEditor.Owner).Repaint;
  end;{IncLayersCount}
var
  f               : TextFile;  //Файловая переменная
  sId,sValue      : String;    //Тип и значение записи файла
  Form            : TForm;     //Форма процесса конвертации
  ValueListEditor : TValueListEditor;
  AObjectInfo     : RObjectInfo;
  APointsCount    : Integer;
  ALayerIndex     : Integer;
  APolylines      : TGLScene2DPolylines;
  I,cLayers,cLWPolylines,cPolylines,cMLines,cLines,cHatchs,cMTexts: Integer;
begin
  Result := false;
  Form := nil;
  if not FileExists(AFileName)then Exit;
  //Начальные установки------------------------------------------------------------------------
  Screen.Cursor := crHourGlass;
  cLayers := 0; cLWPolylines := 0; cPolylines := 0;
  cMLines := 0; cLines       := 0; cMTexts    := 0; cHatchs := 0;
  AObjectInfo.Points := TList.Create;
  Clear;
  DisableInvalidate;
  //Считываю из файла ТОЛЬКО полилинии и текстовые отметки
  AssignFile(f,AFileName);
  try
    Reset(f);
    try
      Form := CreateForm(AFileName,ValueListEditor);
      Form.Show;
      Form.Repaint;
      AObjectInfo.Kind := okNone;
      while not EOF(f) do
      begin
        //Добираюсь до очередного объекта -----------------------------------------------------
        while (not EOF(f)) AND (AObjectInfo.Kind=okNone) do
        begin
          ReadLn(f,sId); ReadLn(f,sValue);
          AObjectInfo.Kind := GetObjectKind(sId,sValue);
        end;{while}
        //Добрался до очередного объекта ------------------------------------------------------
        if  AObjectInfo.Kind<>okNone then
        begin
          sId := '';
          //Итак, считал все данные по очередному объекту
          APointsCount := GetObject(AObjectInfo,f,sId,sValue);
          //Добавляю объект
          if (AObjectInfo.Kind in [okLINE,okMLINE,okPOLYLINE,okLWPOLYLINE,okHATCH])and(APointsCount>1)OR
             (AObjectInfo.Kind in [okMTEXT])and(APointsCount>0)then
          begin
            ALayerIndex := IndexOf(AObjectInfo.Layer);
            if ALayerIndex=-1 then
            begin
              ALayerIndex := Append;
              IncCount(cLayers,1,ValueListEditor);
            end;{if}
            Items[ALayerIndex].Name := AObjectInfo.Layer;
            if AObjectInfo.Kind in [okLINE,okMLINE,okPOLYLINE,okLWPOLYLINE] then
            begin
              case AObjectInfo.Kind of
                okLWPOLYLINE: APolylines := Items[ALayerIndex].LWPolylines;
                okPOLYLINE  : APolylines := Items[ALayerIndex].Polylines;
                okMLINE     : APolylines := Items[ALayerIndex].MLines;
                okLINE      : APolylines := Items[ALayerIndex].Lines;
                else          APolylines := nil;
              end;{case}
              if APolylines<>nil then
              begin
                APolylines.Append;
                APolylines.Last.Color := AObjectInfo.Color;
                APolylines.Last.LineWidth := AObjectInfo.LineWidth;
                for I := 0 to AObjectInfo.Points.Count-1 do
                  APolylines.Last.Add(PPoint3D(AObjectInfo.Points[I])^);
                with Items[ALayerIndex] do
                case AObjectInfo.Kind of
                  okLWPOLYLINE: IncCount(cLWPolylines,2,ValueListEditor);
                  okPOLYLINE  : IncCount(cPolylines,3,ValueListEditor);
                  okMLINE     : IncCount(cMLines,4,ValueListEditor);
                  okLINE      : IncCount(cLines,5,ValueListEditor);
                end;{case}
              end;{if}
            end{if}
            else
            if AObjectInfo.Kind=okHATCH then
            begin
              Items[ALayerIndex].Hatchs.Append;
              Items[ALayerIndex].Hatchs.Last.Color := AObjectInfo.Color;
              Items[ALayerIndex].Hatchs.Last.LineWidth := AObjectInfo.LineWidth;
              for I := 0 to AObjectInfo.Points.Count-1 do
                Items[ALayerIndex].Hatchs.Last.Add(PPoint3D(AObjectInfo.Points[I])^);
              IncCount(cHatchs,6,ValueListEditor);
            end{if}
            else
            if AObjectInfo.Kind=okMTEXT then
            begin
              Items[ALayerIndex].Labels.Append;
              Items[ALayerIndex].Labels.Last.Color := AObjectInfo.Color;
              Items[ALayerIndex].Labels.Last.LineWidth := AObjectInfo.LineWidth;
              Items[ALayerIndex].Labels.Last.Text := AObjectInfo.Text;
              Items[ALayerIndex].Labels.Last.Coords := PPoint3D(AObjectInfo.Points.First)^;
              IncCount(cMTexts,7,ValueListEditor);
            end;{if}
          end;{if}
          //
          AObjectInfo.Kind := GetObjectKind(sId,sValue)
        end;{if}
      end;{while}
      Result := Count>0;
    finally
      Form.Free;
      CloseFile(f);
    end;{try}
  except
    esaMsgError(Format('Не могу открыть файл "%s".'+#13+
                    'Файл имеет неверную структуру или занят другим приложением.',[AFileName]));
  end;{try}
  //Конечные установки-------------------------------------------------------------------------
  ClearList(AObjectInfo.Points);
  AObjectInfo.Points.Free;
  Screen.Cursor := crDefault;
  EnableInvalidate;
  Invalidate;
end;{LoadFromAutoCAD2004DBXFile}

end.
