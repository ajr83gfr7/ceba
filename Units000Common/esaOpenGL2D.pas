unit esaOpenGL2D;
{
Елубаев Сулеймен Актлеуович
аспирант ИГД им.Д.А.Кунаева
Графическое ядро OpenGL2D для Редактора 2D элементов карьерного пространства
}

interface
uses Windows, Messages, Globals, Graphics, Classes;
const
  GLF_START_LIST=1000;
  WM_GRAPHCERNEL_SCALE=WM_USER+300;
  WM_GRAPHCERNEL_RESIZE=WM_USER+301;
type
  TGraphCernel2DLayers=class;
  TOnBoundChange=procedure (var ABound: RBound3D)of object;
  //TGraphCernel2D - класс "Графическое ядро" -------------------------------------------------
  TGraphCernel2D = class
  private
    FDC          : HDC;  //контекст устройства
    Fhrc         : HGLRC;//?
    FHandle      : HWND;
    FCanvasHandle: HWND;
    FLayers      : TGraphCernel2DLayers;
    FScale       : Integer;
    FSpace       : TPoint;

    FScreenBoundPxl: TRect;
    FScreenBoundMtr: RBound3D;
    FCurrentScreenBoundMtr: RBound3D;
    FCurrentSizeMtr: RPoint3D;

    FOnDraw: TEmptyEvent;
    FOnBoundChange: TOnBoundChange;

    FMovingItems: array of TPoint;
    FMovingCount: Integer;

    FScalingItems: array of RPoint3D;
    FScalingCount: Integer;

    procedure SetDCPixelFormat;
    procedure DoCreateOpenGL;
    procedure DoDestroyOpenGL;
    procedure DoResizeOpenGL;
    procedure SetScreenBoundPxl(const Value: TRect);
    procedure SetScreenBoundMtr(Value: RBound3D);
    procedure SetScale(const Value: Integer);
    procedure SetSpace(const Value: TPoint);
    function GetScreenWidthPxl: Integer;
    function GetScreenHeightPxl: Integer;
    function GetScreenWidthMtr: Single;
    function GetScreenHeightMtr: Single;
    function GetCurrentScreenWidthMtr: Single;
    function GetCurrentScreenHeightMtr: Single;
    function GetCurrentScreenBoundMtr: RBound3D;
    function GetMtrPerPxl: Single;
    procedure DrawScalingRect;
    procedure DrawCoordGrid;
  public
    property Handle: HWND read FHandle;
    property CanvasHandle: HWND read FCanvasHandle;
    property OnDraw: TEmptyEvent read FOnDraw write FOnDraw;
    property OnBoundChange: TOnBoundChange read FOnBoundChange write FOnBoundChange;
    property ScreenBoundPxl: TRect read FScreenBoundPxl write SetScreenBoundPxl;
    property ScreenBoundMtr: RBound3D read FScreenBoundMtr write SetScreenBoundMtr;
    property ScreenWidthPxl: Integer read GetScreenWidthPxl;
    property ScreenHeightPxl: Integer read GetScreenHeightPxl;
    property ScreenWidthMtr: Single read GetScreenWidthMtr;
    property ScreenHeightMtr: Single read GetScreenHeightMtr;
    property CurrentScreenWidthMtr: Single read GetCurrentScreenWidthMtr;
    property CurrentScreenHeightMtr: Single read GetCurrentScreenHeightMtr;
    property Scale: Integer read FScale write SetScale;
    property Space: TPoint read FSpace write SetSpace;
    property CurrentScreenBoundMtr: RBound3D read FCurrentScreenBoundMtr;
    property CurrentSizeMtr: RPoint3D read FCurrentSizeMtr;
    property MtrPerPxl: Single read GetMtrPerPxl;
    property Layers: TGraphCernel2DLayers read FLayers;
    constructor Create(AHandle,ACanvasHandle: HWND);
    destructor Destroy; override;
    procedure Invalidate;
    procedure Draw;
    function PointPxlToMtr(const APointPxl: TPoint): RPoint3D;
    function PointMtrToPxl(const APointMtr: RPoint3D): TPoint;
    procedure MovingOn(const AX, AY: Integer);
    procedure MovingBy(const AX, AY: Integer);
    procedure MovingOff(const AX, AY: Integer);
    procedure ScaleTo(const AX, AY, ADeltaScale: Integer);
    procedure ScalingOn(const AX, AY: Integer);
    procedure ScalingBy(const AX, AY: Integer);
    procedure ScalingOff(const AX, AY: Integer);
    procedure MoveBy(const dX, dY: Integer);
    procedure ScaleByRect(const ARect: TRect);
    procedure ToCenter;
  end;{TGraphCernel2D}

  //"Объект GraphCernel2D" ------------------------------------------------------------------------
  TGraphCernel2DObject = class
  private
    FGraphCernel2D: TGraphCernel2D;//ССылка на GraphCernel2D
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
    procedure SetGraphCernel2D(const Value: TGraphCernel2D);virtual;
    property Handle       : HWND read GetHandle;
    property CanvasHandle : HWND read GetCanvasHandle;
    property GraphCernel2D    : TGraphCernel2D read FGraphCernel2D write SetGraphCernel2D;
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
  end;{TGraphCernel2DObject}
  
  //"CustomПолилиния GraphCernel2D" ---------------------------------------------------------------
  TGraphCernel2DCustomPolyline = class(TGraphCernel2DObject)
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
  end;{TGraphCernel2DCustomPolyline}

  //"Полилиния GraphCernel2D" ---------------------------------------------------------------------
  TGraphCernel2DPolyline = class(TGraphCernel2DCustomPolyline)
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
  end;{TGraphCernel2DPolyline}
  PGraphCernel2DPolyline=^TGraphCernel2DPolyline;

  //"Полигон GraphCernel2D" -----------------------------------------------------------------------
  TGraphCernel2DPolygon = class(TGraphCernel2DPolyline)
  public
    procedure Draw;override;
  end;{TGraphCernel2DPolygon}
  PGraphCernel2DPolygon=^TGraphCernel2DPolygon;

  //"Текстовая отметка GraphCernel2D" -------------------------------------------------------------
  TGraphCernel2DLabel = class(TGraphCernel2DCustomPolyline)
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
  end;{TGraphCernel2DLabel}
  PGraphCernel2DLabel=^TGraphCernel2DLabel;

  //"Полилинии GraphCernel2D" ---------------------------------------------------------------------
  TGraphCernel2DPolylines = class(TGraphCernel2DObject)
  private
    FItems: TList;       //Полилинии
    function GetItem(const Index: Integer): TGraphCernel2DPolyline;
    function GetCount: Integer;
    function GetFirst: TGraphCernel2DPolyline;
    function GetLast: TGraphCernel2DPolyline;
  protected
    procedure SetGraphCernel2D(const Value: TGraphCernel2D);override;
  public
    property Items[const Index: Integer]: TGraphCernel2DPolyline read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGraphCernel2DPolyline read GetFirst;
    property Last              : TGraphCernel2DPolyline read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    procedure Append;
  end;{TGraphCernel2DPolylines}

  //"Полигоны GraphCernel2D" ----------------------------------------------------------------------
  TGraphCernel2DPolygons = class(TGraphCernel2DObject)
  private
    FItems: TList;       //Полигоны
    function GetItem(const Index: Integer): TGraphCernel2DPolygon;
    function GetCount: Integer;
    function GetFirst: TGraphCernel2DPolygon;
    function GetLast: TGraphCernel2DPolygon;
  protected
    procedure SetGraphCernel2D(const Value: TGraphCernel2D);override;
  public
    property Items[const Index: Integer]: TGraphCernel2DPolygon read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGraphCernel2DPolygon read GetFirst;
    property Last              : TGraphCernel2DPolygon read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    procedure Append;
  end;{TGraphCernel2DPolygons}

  //"Текстовые отметки GraphCernel2D" -------------------------------------------------------------
  TGraphCernel2DLabels = class(TGraphCernel2DObject)
  private
    FItems: TList;       //Текстовые отметки
    function GetItem(const Index: Integer): TGraphCernel2DLabel;
    function GetCount: Integer;
    function GetFirst: TGraphCernel2DLabel;
    function GetLast: TGraphCernel2DLabel;
  protected
    procedure SetGraphCernel2D(const Value: TGraphCernel2D);override;
  public
    property Items[const Index: Integer]: TGraphCernel2DLabel read GetItem;default;
    property Count: Integer read GetCount;
    property First             : TGraphCernel2DLabel read GetFirst;
    property Last              : TGraphCernel2DLabel read GetLast;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
    procedure Append;
  end;{TGraphCernel2DLabels}

  //"Слой GraphCernel2D" --------------------------------------------------------------------------
  TGraphCernel2DLayer = class(TGraphCernel2DObject)
  private
    FName       : String;
    FPolylines  : TGraphCernel2DPolylines;
    FLWPolylines: TGraphCernel2DPolylines;
    FLines      : TGraphCernel2DPolylines;
    FMLines     : TGraphCernel2DPolylines;
    FHatchs     : TGraphCernel2DPolygons;
    FLabels     : TGraphCernel2DLabels;
    procedure SetName(const Value: String);
  protected
    procedure SetGraphCernel2D(const Value: TGraphCernel2D);override;
  public
    property Name       : String read FName write SetName;
    property Polylines  : TGraphCernel2DPolylines read FPolylines;
    property LWPolylines: TGraphCernel2DPolylines read FLWPolylines;
    property Lines      : TGraphCernel2DPolylines read FLines;
    property MLines     : TGraphCernel2DPolylines read FMLines;
    property Hatchs     : TGraphCernel2DPolygons read FHatchs;
    property Labels     : TGraphCernel2DLabels read FLabels;
    constructor Create;
    destructor Destroy; override;
    procedure Draw;override;
    procedure Clear;override;
  end;{TGraphCernel2DLayer}
  PGraphCernel2DLayer=^TGraphCernel2DLayer;

  //"Слои GraphCernel2D" --------------------------------------------------------------------------
  TGraphCernel2DLayers = class(TGraphCernel2DObject)
  private
    FItems: TList;       //Текстовые отметки
    FBound: RBound3D;
    function GetItem(const Index: Integer): TGraphCernel2DLayer;
    function GetCount : Integer;
    function GetFirst : TGraphCernel2DLayer;
    function GetLast  : TGraphCernel2DLayer;
    function GetWidth : Single;
    function GetHeight: Single;
    procedure DefineBound;
  protected
    procedure SetGraphCernel2D(const Value: TGraphCernel2D);override;
  public
    property Items[const Index: Integer]: TGraphCernel2DLayer read GetItem;default;
    property Count : Integer read GetCount;
    property First : TGraphCernel2DLayer read GetFirst;
    property Last  : TGraphCernel2DLayer read GetLast;
    property Bound : RBound3D read FBound;
    property Width : Single read GetWidth;
    property Height: Single read GetHeight;
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
  end;{TGraphCernel2DLayers}
  
//Вывод текста
procedure glOutTextXY(const X,Y: Single; const Litera : String);
implementation
uses Types, SysUtils, OpenGL, Math, StdCtrls, CheckLst, ValEdit, Grids,
 unDM, Forms, Controls, ExtCtrls;
//Вывод текста
procedure glOutTextXY(const X,Y: Single; const Litera : String);
begin
  glRasterPos2f (X,Y);
  glListBase(GLF_START_LIST);
  glCallLists(Length(Litera), GL_UNSIGNED_BYTE, PChar(Litera));
end;{glOutTextXY}

//TGraphCernel2D - класс "OpenGL2D" ----------------------------------------------------------------
procedure TGraphCernel2D.SetScreenBoundPxl(const Value: TRect);
begin
  if (FScreenBoundPxl.Left<>Value.Left)OR(FScreenBoundPxl.Top<>Value.Top)OR
     (FScreenBoundPxl.Right<>Value.Right)OR(FScreenBoundPxl.Bottom<>Value.Bottom)then
  begin
    FScreenBoundPxl := Value;
    DoResizeOpenGL;
  end;{if}
end;{SetScreenBoundPxl}
procedure TGraphCernel2D.SetScreenBoundMtr(Value: RBound3D);
begin
  if (Value.MinX>Value.MaxX)OR(Value.MinY>Value.MaxY)OR(Value.MinZ>Value.MaxZ)
  then FScreenBoundMtr := Bound3D(0.0,10000.0,0.0,10000.0,0.0,100.0)
  else FScreenBoundMtr := Value;
  if abs(FScreenBoundMtr.MaxX-FScreenBoundMtr.MinX)<100.0 then
  begin
    FScreenBoundMtr.MinX := (FScreenBoundMtr.MaxX+FScreenBoundMtr.MinX)*0.5-100.0;
    FScreenBoundMtr.MaxX := FScreenBoundMtr.MinX + 200.0;
  end;{if}
  if abs(FScreenBoundMtr.MaxY-FScreenBoundMtr.MinY)<100.0 then
  begin
    FScreenBoundMtr.MinY := (FScreenBoundMtr.MaxY+FScreenBoundMtr.MinY)*0.5-100.0;
    FScreenBoundMtr.MaxY := FScreenBoundMtr.MinY + 200.0;
  end;{if}
  if abs(FScreenBoundMtr.MaxZ-FScreenBoundMtr.MinZ)<100.0 then
  begin
    FScreenBoundMtr.MinZ := (FScreenBoundMtr.MaxZ+FScreenBoundMtr.MinZ)*0.5-100.0;
    FScreenBoundMtr.MaxZ := FScreenBoundMtr.MinZ + 200.0;
  end;{if}
  if Assigned(FOnBoundChange)then FOnBoundChange(Value);
  DoResizeOpenGL;
end;{SetScreenBoundMtr}
procedure TGraphCernel2D.SetScale(const Value: Integer);
begin
  if (Value>0)and(FScale<>Value) then
  begin
    FScale := Value;
    PostMessage(FHandle,WM_GRAPHCERNEL_SCALE,FScale,0);
    DoResizeOpenGL;
  end;{if}
end;{SetScale}
procedure TGraphCernel2D.SetSpace(const Value: TPoint);
begin
  if (FSpace.X<>Value.X)OR(FSpace.Y<>Value.Y) then
  begin
    FSpace := Value;
    DoResizeOpenGL;
  end;{if}
end;{SetSpace}
function TGraphCernel2D.GetScreenWidthPxl: Integer;
begin
  Result := FScreenBoundPxl.Right-FScreenBoundPxl.Left;
end;{GetScreenWidthPxl}
function TGraphCernel2D.GetScreenHeightPxl: Integer;
begin
  Result := FScreenBoundPxl.Bottom-FScreenBoundPxl.Top;
end;{GetScreenHeightPxl}
function TGraphCernel2D.GetScreenWidthMtr: Single;
begin
  Result := FScreenBoundMtr.MaxX-FScreenBoundMtr.MinX;
end;{GetScreenWidthMtr}
function TGraphCernel2D.GetScreenHeightMtr: Single;
begin
  Result := FScreenBoundMtr.MaxY-FScreenBoundMtr.MinY;
end;{GetScreenHeightMtr}
function TGraphCernel2D.GetCurrentScreenWidthMtr: Single;
begin
  Result := FCurrentScreenBoundMtr.MaxX-FCurrentScreenBoundMtr.MinX;
end;{GetCurrentScreenWidthMtr}
function TGraphCernel2D.GetCurrentScreenHeightMtr: Single;
begin
  Result := FCurrentScreenBoundMtr.MaxY-FCurrentScreenBoundMtr.MinY;
end;{GetCurrentScreenHeightMtr}
function TGraphCernel2D.GetCurrentScreenBoundMtr: RBound3D;
var
  ACanvasWidth,ACanvasHeight: Integer;
  ACenter: RPoint3D;
begin
  //Расчет контура проецирования
  ACanvasWidth := ScreenWidthPxl;
  ACanvasHeight := ScreenHeightPxl;
  FCurrentSizeMtr.X := ScreenWidthMtr;
  FCurrentSizeMtr.Y := ScreenHeightMtr;
  if ACanvasWidth<ACanvasHeight
  then FCurrentSizeMtr.Y := FCurrentSizeMtr.X*ACanvasHeight/ACanvasWidth
  else FCurrentSizeMtr.X := FCurrentSizeMtr.Y*ACanvasWidth/ACanvasHeight;
  FCurrentSizeMtr.X := FCurrentSizeMtr.X/FScale;
  FCurrentSizeMtr.Y := FCurrentSizeMtr.Y/FScale;
  ACenter.X := (FScreenBoundMtr.MaxX+FScreenBoundMtr.MinX)*0.5+FSpace.X;
  ACenter.Y := (FScreenBoundMtr.MaxY+FScreenBoundMtr.MinY)*0.5+FSpace.Y;

  Result.MinX := ACenter.X-FCurrentSizeMtr.X*0.5;
  Result.MaxX := ACenter.X+FCurrentSizeMtr.X*0.5;
  Result.MinY := ACenter.Y-FCurrentSizeMtr.Y*0.5;
  Result.MaxY := ACenter.Y+FCurrentSizeMtr.Y*0.5;
end;{GetCurrentScreenBound}
function TGraphCernel2D.GetMtrPerPxl: Single;
begin
  if ScreenWidthPxl>0
  then Result := CurrentScreenWidthMtr/ScreenWidthPxl
  else Result := 0.0;
end;{GetMtrPerPxl}
procedure TGraphCernel2D.SetDCPixelFormat;
var
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags   := PFD_DRAW_TO_WINDOW or
                   PFD_SUPPORT_OPENGL or
                   PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(FDC, @pfd);
  SetPixelFormat(FDC, nPixelFormat, @pfd);
end;{SetDCPixelFormat}
//Инициализация графики OpenGL
procedure TGraphCernel2D.DoCreateOpenGL;
begin
  if FDC=0 then
  begin
    FDC := GetDC(Handle);
    SetDCPixelFormat;
    Fhrc := wglCreateContext(FDC);
    wglMakeCurrent(FDC, Fhrc);
    glClearColor (0.0, 0.0, 0.0, 1.0); // цвет фона
    wglUseFontBitmaps (FCanvasHandle, 0, 255, GLF_START_LIST);
    DoResizeOpenGL;
  end;{if}
end;{DoCreateOpenGL}
//Уничтожение графики OpenGL
procedure TGraphCernel2D.DoDestroyOpenGL;
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
end;{DoDestroyOpenGL}
//Изменение видовых параметров OpenGL
procedure TGraphCernel2D.DoResizeOpenGL;
begin
  if FDC=0 then Exit;
  wglMakeCurrent(FDC, Fhrc);
  //Расчет контура проецирования
  FCurrentScreenBoundMtr := GetCurrentScreenBoundMtr;
  //Преобразование порта просмотра
  glViewport(0, 0, ScreenWidthPxl, ScreenHeightPxl);
  //Преобразование проецирования
  glMatrixMode(GL_PROJECTION);                      //устанавливаю матрицу проецирования
  glLoadIdentity;                                   //обнуляю матрицу в единичную
  with FCurrentScreenBoundMtr do                    //задаю ортогональное проецирование
    gluOrtho2D(MinX,MaxX,MinY,MaxY);

  //Преобразование вида и модели
  glMatrixMode(GL_MODELVIEW);                       //устанавливаю матрицу видового преобразования
  glLoadIdentity;                                   //обнуляю матрицу в единичную

  PostMessage(FHandle,WM_GRAPHCERNEL_RESIZE,0,0);
  //Вызов прорисовки
  Invalidate;
end;{DoResizeOpenGL}

constructor TGraphCernel2D.Create(AHandle,ACanvasHandle: HWND);
begin
  if AHandle=0 then raise Exception.Create('Неверное значение Handle='+IntToStr(AHandle));
  inherited Create;
  FHandle := AHandle;
  FCanvasHandle := ACanvasHandle;
  FDC := 0;
  Fhrc := 0;
  FScale := 1;
  FSpace := Point(0,0);
  FScreenBoundPxl := Rect(0,0,100,100);
  FScreenBoundMtr := Bound3D(0.0,10000.0,0.0,10000.0,0.0,100.0);
  FCurrentScreenBoundMtr := FScreenBoundMtr;
  FOnDraw := nil;
  FOnBoundChange := nil;
  FMovingItems := nil;
  FMovingCount := 0;
  FScalingItems := nil;
  FScalingCount := 0;
  FLayers := TGraphCernel2DLayers.Create;
  FLayers.GraphCernel2D := Self;
  DoCreateOpenGL;
end;{Create}

destructor TGraphCernel2D.Destroy;
begin
  FLayers.Free;
  FLayers := nil;
  DoDestroyOpenGL;
  FOnDraw := nil;
  FOnBoundChange := nil;
  FMovingItems := nil;
  FMovingCount := 0;
  FScalingItems := nil;
  FScalingCount := 0;
  inherited;
end;{Destroy}

procedure TGraphCernel2D.Invalidate;
begin
  if FHandle<>0 then InvalidateRect(Handle,nil,false);
end;{Invalidate}

//Прорисовка OpenGL
procedure TGraphCernel2D.Draw;
begin
  wglMakeCurrent(FDC, Fhrc);
  glClear(GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT);
  if FLayers<>nil then FLayers.Draw;
  DrawCoordGrid;
  if Assigned(FOnDraw) then FOnDraw;
  DrawScalingRect;
  SwapBuffers(FDC);
  wglMakeCurrent(0, 0);
end;{Draw}
procedure TGraphCernel2D.DrawScalingRect;
begin
  if FScalingCount=2 then
  begin
    glLineWidth(1.0);
    glLineStipple(2,$F0F0);
    glSetColor(clWhite);
    glEnable(GL_LINE_STIPPLE);
    glBegin(GL_LINE_STRIP);
      glVertex(FScalingItems[0].X,FScalingItems[0].Y);
      glVertex(FScalingItems[1].X,FScalingItems[0].Y);
      glVertex(FScalingItems[1].X,FScalingItems[1].Y);
      glVertex(FScalingItems[0].X,FScalingItems[1].Y);
      glVertex(FScalingItems[0].X,FScalingItems[0].Y);
    glEnd;
    glDisable(GL_LINE_STIPPLE);
  end;{if}
end;{DrawScalingRect}
procedure TGraphCernel2D.DrawCoordGrid;
var
  I,J,MaxI,MaxJ,SmallStep,X0,X1,Y0,Y1: Integer;
  MinValue, MaxValue: TPoint;
begin
  with DefaultParams do
  if CoordGridStyle<>cgsNone then
  begin
    MinValue.X := Trunc(FScreenBoundMtr.MinX);
    MinValue.X := MinValue.X-(MinValue.X mod CoordGridStep)-CoordGridStep;
    MinValue.Y := Trunc(FScreenBoundMtr.MinY);
    MinValue.Y := MinValue.Y-(MinValue.Y mod CoordGridStep)-CoordGridStep;

    MaxValue.X := Trunc(FScreenBoundMtr.MaxX);
    MaxValue.X := MaxValue.X+(CoordGridStep-MaxValue.X mod CoordGridStep)+CoordGridStep;
    MaxValue.Y := Trunc(FScreenBoundMtr.MaxY);
    MaxValue.Y := MaxValue.Y+(CoordGridStep-MaxValue.Y mod CoordGridStep)+CoordGridStep;
    MaxI := (MaxValue.X-MinValue.X)div CoordGridStep-1;
    MaxJ := (MaxValue.Y-MinValue.Y)div CoordGridStep-1;
    case CoordGridStyle of
      cgsPoint: begin
        glSetColor(clGray);
        glPointSize(2.0);
        glBegin(GL_POINTS);
          for I := 0 to MaxI do
            for J := 0 to MaxJ do
              glVertex(MinValue.X+I*CoordGridStep,MinValue.Y+J*CoordGridStep);
        glEnd;
      end;{cgsPoint}
      cgsCross: begin
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
      end;{cgsCross}
      cgsGrid: begin
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
      end;{cgsGrid}
    end;{case}
    if (CoordGridStyle<>cgsNone)and CoordGridMarks then
    begin
      Y0 := Round(MinValue.Y+MaxJ*CoordGridStep+(MtrPerPxl*10));
      Y1 := Round(MinValue.Y-(MtrPerPxl*10));
      for I := 0 to MaxI do
      if not Odd(I) then
      begin
        X0 := MinValue.X+I*CoordGridStep;
        glOutTextXY(X0,Y0,IntToStr(X0));
        glOutTextXY(X0,Y1,IntToStr(X0));
      end;{for}
      X0 := Round(MinValue.X+MaxI*CoordGridStep+(MtrPerPxl*10));
      X1 := Round(MinValue.X-(MtrPerPxl*30));
      for J := 0 to MaxJ do
      if not Odd(J) then
      begin
        Y0 := MinValue.Y+J*CoordGridStep;
        glOutTextXY(X0,Y0,IntToStr(Y0));
        glOutTextXY(X1,Y0,IntToStr(Y0));
      end;{for}
    end;{if}
  end;{if}
end;{DrawCoordGrid}
function TGraphCernel2D.PointPxlToMtr(const APointPxl: TPoint): RPoint3D;
var
  ACanvasWidth,ACanvasHeight: Integer;
  ABound: RBound3D;
begin
  //Расчет контура проецирования
  ACanvasWidth := ScreenWidthPxl;
  ACanvasHeight := ScreenHeightPxl;
  ABound := GetCurrentScreenBoundMtr;
  
  Result.X := RoundTo(ABound.MinX+FCurrentSizeMtr.X*(APointPxl.X-FScreenBoundPxl.Left)/ACanvasWidth,-3);
  Result.Y := RoundTo(ABound.MinY+FCurrentSizeMtr.Y*(1-(APointPxl.Y-FScreenBoundPxl.Top)/ACanvasHeight),-3);
  Result.Z := 0.0;
end;{PointPxlToMtr}
function TGraphCernel2D.PointMtrToPxl(const APointMtr: RPoint3D): TPoint;
var
  ACanvasWidth,ACanvasHeight: Integer;
  ABound: RBound3D;
begin
  //Расчет контура проецирования
  ACanvasWidth := ScreenWidthPxl;
  ACanvasHeight := ScreenHeightPxl;
  ABound := GetCurrentScreenBoundMtr;

  Result.X := Round(FScreenBoundPxl.Left+ACanvasWidth*(APointMtr.X-ABound.MinX)/FCurrentSizeMtr.X);
  Result.Y := Round(FScreenBoundPxl.Top+ACanvasHeight*(1-(APointMtr.Y-ABound.MinY)/FCurrentSizeMtr.Y));
end;{PointMtrToPxl}

procedure TGraphCernel2D.MovingOn(const AX,AY: Integer);
begin
  if FMovingCount>0 then
  begin
    FMovingCount := 0; FMovingItems := nil;
  end;{if}
  FMovingCount := 1;
  SetLength(FMovingItems,FMovingCount);
  FMovingItems[FMovingCount-1] := Point(AX,AY);
end;{MovingOn}
procedure TGraphCernel2D.MovingBy(const AX,AY: Integer);
var Delta: TPoint;
begin
  if (FMovingCount=1)and((FMovingItems[0].X<>AX)OR(FMovingItems[0].Y<>AY)) then
  begin
    FMovingCount := 2;
    SetLength(FMovingItems,FMovingCount);
    FMovingItems[FMovingCount-1] := Point(AX,AY);
    Delta := FSpace;
    if FMovingItems[0].X<>FMovingItems[1].X
    then Delta.X := Round(Delta.X+PointPxlToMtr(FMovingItems[0]).X-PointPxlToMtr(FMovingItems[1]).X);
    if FMovingItems[0].Y<>FMovingItems[1].Y
    then Delta.Y := Round(Delta.Y+PointPxlToMtr(FMovingItems[0]).Y-PointPxlToMtr(FMovingItems[1]).Y);
    FMovingCount := 1;
    SetLength(FMovingItems,FMovingCount);
    FMovingItems[FMovingCount-1] := Point(AX,AY);
    Space := Delta;
  end;{if}
end;{MovingBy}
procedure TGraphCernel2D.MovingOff(const AX,AY: Integer);
var Delta: TPoint;
begin
  if (FMovingCount=1)and((FMovingItems[0].X<>AX)OR(FMovingItems[0].Y<>AY)) then
  begin
    FMovingCount := 2;
    SetLength(FMovingItems,FMovingCount);
    FMovingItems[FMovingCount-1] := Point(AX,AY);
    Delta := Space;
    if FMovingItems[0].X<>FMovingItems[1].X
    then Delta.X := Round(Delta.X+PointPxlToMtr(FMovingItems[0]).X-PointPxlToMtr(FMovingItems[1]).X);
    if FMovingItems[0].Y<>FMovingItems[1].Y
    then Delta.Y := Round(Delta.Y+PointPxlToMtr(FMovingItems[0]).Y-PointPxlToMtr(FMovingItems[1]).Y);
    Space := Delta;
  end;{if}
  FMovingCount := 0; FMovingItems := nil;
end;{MovingOff}
procedure TGraphCernel2D.ScaleTo(const AX, AY, ADeltaScale: Integer);
var
  APoint0,APoint1,Delta: TPoint;
  APoint: RPoint3D;
begin
  APoint0 := Point(AX,AY);
  APoint := PointPxlToMtr(APoint0);
  Scale := Scale+ADeltaScale;
  APoint1 := PointMtrToPxl(APoint);
  Delta := Space;
  if APoint0.X<>APoint1.X
  then Delta.X := Round(Delta.X-PointPxlToMtr(APoint0).X+PointPxlToMtr(APoint1).X);
  if APoint0.Y<>APoint1.Y
  then Delta.Y := Round(Delta.Y-PointPxlToMtr(APoint0).Y+PointPxlToMtr(APoint1).Y);
  Space := Delta;
end;{ScaleTo}
procedure TGraphCernel2D.ScalingOn(const AX,AY: Integer);
begin
  if FScalingCount>0 then
  begin
    FScalingCount := 0; FScalingItems := nil;
  end;{if}
  FScalingCount := 1;
  SetLength(FScalingItems,FScalingCount);
  FScalingItems[FScalingCount-1] := PointPxlToMtr(Point(AX,AY));
end;{ScalingOn}
procedure TGraphCernel2D.ScalingBy(const AX,AY: Integer);
var APoint: RPoint3D;
begin
  APoint := PointPxlToMtr(Point(AX,AY));
  if FScalingCount=0 then Exit;
  if FScalingCount>=1 then
  begin
    FScalingCount := 2;
    SetLength(FScalingItems,FScalingCount);
  end;{if}
  FScalingItems[FScalingCount-1] := APoint;
  Invalidate;
end;{ScalingBy}
procedure TGraphCernel2D.ScalingOff(const AX,AY: Integer);
var APoint: RPoint3D;
//  ACenterX,ACenterY: Single;
//  ABound: RBound3D;
//  AWidth: Single;
begin
  APoint := PointPxlToMtr(Point(AX,AY));
  if FScalingCount=1 then
  begin
    FScalingCount := 2;
    SetLength(FScalingItems,FScalingCount);
    FScalingItems[FScalingCount-1] := APoint;
  end;{if}
  {
  if FScalingCount=2 then
  begin
    ACenterX := (FScalingItems[0].X+FScalingItems[1].X)*0.5;
    ACenterY := (FScalingItems[0].Y+FScalingItems[1].Y)*0.5;
    if ScreenWidthPxl>ScreenHeightPxl
    then AWidth := ScreenHeightMtr*ScreenWidthPxl/ScreenHeightPxl
    else AWidth := ScreenWidthMtr;

    ABound.MinX := Min(FScalingItems[0].X,FScalingItems[1].X);
    ABound.MaxX := Max(FScalingItems[0].X,FScalingItems[1].X);
    ABound.MinY := Min(FScalingItems[0].Y,FScalingItems[1].Y);
    ABound.MaxY := Max(FScalingItems[0].Y,FScalingItems[1].Y);
    ABound.MinZ := FCurrentScreenBoundMtr.MinZ;
    ABound.MaxZ := FCurrentScreenBoundMtr.MaxZ;
    FCurrentSizeMtr.X := ABound.MaxX-ABound.MinX;
    FCurrentSizeMtr.Y := ABound.MaxY-ABound.MinY;
    if ScreenWidthPxl<ScreenHeightPxl
    then FCurrentSizeMtr.Y := FCurrentSizeMtr.X*ScreenHeightPxl/ScreenWidthPxl
    else FCurrentSizeMtr.X := FCurrentSizeMtr.Y*ScreenWidthPxl/ScreenHeightPxl;
    ABound.MinX := ACenterX-FCurrentSizeMtr.X*0.5;
    ABound.MaxX := ACenterX+FCurrentSizeMtr.X*0.5;
    ABound.MinY := ACenterY-FCurrentSizeMtr.Y*0.5;
    ABound.MaxY := ACenterY+FCurrentSizeMtr.Y*0.5;
    FCurrentScreenBoundMtr := ABound;
    FScale := Ceil(AWidth/FCurrentSizeMtr.X);
    DoResizeOpenGL;
    Invalidate;
  end;{if}
  FScalingCount := 0; FScalingItems := nil;
  Invalidate;
end;{ScalingOff}

procedure TGraphCernel2D.MoveBy(const dX, dY: Integer);
var ASpace: TPoint;
begin
  ASpace.X := FSpace.X+dX;
  ASpace.Y := FSpace.Y+dY;
  Space := ASpace;
end;{MoveBy}
procedure TGraphCernel2D.ScaleByRect(const ARect: TRect);
begin
  if (ARect.Left=ARect.Right)OR(ARect.Top=ARect.Bottom)then Exit;
end;{ScaleByRect}
procedure TGraphCernel2D.ToCenter;
begin
  Scale := 1;
  Space := Point(0,0);
end;{ToCenter}

//"Объект GLScene2D" --------------------------------------------------------------------------
function TGraphCernel2DObject.GetHandle: HWND;
begin
  if FGraphCernel2D<>nil then Result := FGraphCernel2D.Handle else Result := 0;
end;{GetHandle}
function TGraphCernel2DObject.GetCanvasHandle: HWND;
begin
  if FGraphCernel2D<>nil then Result := FGraphCernel2D.CanvasHandle else Result := 0;
end;{GetCanvasHandle}
constructor TGraphCernel2DObject.Create;
begin
  inherited;
  FGraphCernel2D := nil;
  //Geometry
  FIsSelected   := false;
  //Graphic
  FColor        := clRed;
  FSelectedColor:= clYellow;
  FVisible      := true;
end;{Create}
destructor TGraphCernel2DObject.Destroy;
begin
  Clear;
  FGraphCernel2D := nil;
  inherited;
end;{Destroy}
procedure TGraphCernel2DObject.Invalidate;
begin
  if FGraphCernel2D<>nil then FGraphCernel2D.Invalidate;
end;{Invalidate}
procedure TGraphCernel2DObject.Clear;
begin
end;{Clear}
procedure TGraphCernel2DObject.Draw;
begin
end;{Draw}
procedure TGraphCernel2DObject.SetIsSelected(const Value: Boolean);
begin
  if FIsSelected<>Value then
  begin
    FIsSelected := Value;
    Invalidate;
  end;{if}
end;{SetIsSelected}
procedure TGraphCernel2DObject.SetColor(const Value: TColor);
begin
  if FColor<>Value then
  begin
    FColor := Value;
    Invalidate;
  end;{if}
end;{SetColor}
procedure TGraphCernel2DObject.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor<>Value then
  begin
    FSelectedColor := Value;
    Invalidate;
  end;{if}
end;{SetSelectedColor}
procedure TGraphCernel2DObject.SetGraphCernel2D(const Value: TGraphCernel2D);
begin
  if FGraphCernel2D<>Value then
  begin
    FGraphCernel2D := Value;
    Invalidate;
  end;{if}
end;{SetGraphCernel2D}
procedure TGraphCernel2DObject.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible := Value;
    Invalidate;
  end;{if}
end;{SetVisible}

//"CustomПолилиния GraphCernel2D" -----------------------------------------------------------------
constructor TGraphCernel2DCustomPolyline.Create;
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
destructor TGraphCernel2DCustomPolyline.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGraphCernel2DCustomPolyline.Clear;
begin
  if FItems<>nil then
  begin
    ClearList(FItems);
    FLength := 0.0;
    FSelectedIndex := -1;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGraphCernel2DCustomPolyline.Draw;
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
function TGraphCernel2DCustomPolyline.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGraphCernel2DCustomPolyline.GetItem(const Index: Integer): ROpenpitPoint3D;
begin
  if InRange(Index,0,Count-1)
  then Result := POpenpitPoint3D(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGraphCernel2DCustomPolyline.GetFirst: ROpenpitPoint3D;
begin
  if Count>0
  then Result := POpenpitPoint3D(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGraphCernel2DCustomPolyline.GetLast: ROpenpitPoint3D;
begin
  if Count>0
  then Result := POpenpitPoint3D(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
function TGraphCernel2DCustomPolyline.GetSelected: ROpenpitPoint3D;
begin
  if InRange(FSelectedIndex,0,Count-1)
  then Result := POpenpitPoint3D(FItems[FSelectedIndex])^
  else Raise Exception.Create(Format(EInvalidIndex,[FSelectedIndex,Count-1]));
end;{GetSelected}
procedure TGraphCernel2DCustomPolyline.SetSelectedIndex(const Value: Integer);
begin
  if (FSelectedIndex<>Value)and InRange(Value,-1,Count-1) then
  begin
    FSelectedIndex := Value;
    Invalidate;
  end;{if}
end;{SetSelectedIndex}
procedure TGraphCernel2DCustomPolyline.SetLineWidth(const Value: Single);
begin
  if (FLineWidth<>Value)and(Value>0.0) then
  begin
    FLineWidth := Value;
    Invalidate;
  end;{if}
end;{SetLineWidth}
procedure TGraphCernel2DCustomPolyline.SetLinePattern(const Value: Word);
begin
  if (FLinePattern<>Value)and(Value>0) then
  begin
    FLinePattern := Value;
    Invalidate;
  end;{if}
end;{SetLinePattern}
procedure TGraphCernel2DCustomPolyline.SetLineFactor(const Value: Integer);
begin
  if (FLineFactor<>Value)and(Value>0) then
  begin
    FLineFactor := Value;
    Invalidate;
  end;{if}
end;{SetLineFactor}
procedure TGraphCernel2DCustomPolyline.SetRadius(const Value: Integer);
begin
  if (FRadius<>Value)and(Value>0) then
  begin
    FRadius := Value;
    Invalidate;
  end;{if}
end;{SetRadius}
procedure TGraphCernel2DCustomPolyline.SetIsSelected(const Value: Boolean);
begin
  FSelectedIndex := -1;
  inherited;
end;{SetIsSelected}
procedure TGraphCernel2DCustomPolyline.SetItem(const Index: Integer;const Value: ROpenpitPoint3D);
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
procedure TGraphCernel2DCustomPolyline.DefineLength;
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
procedure TGraphCernel2DCustomPolyline.Delete(const Index: Integer);
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
procedure TGraphCernel2DCustomPolyline.DeleteAll;
begin
  FSelectedIndex := -1;
  FIsSelected := false;
  Clear;
end;{DeleteAll}
function TGraphCernel2DCustomPolyline.IndexOf(const X, Y, Distance: Single): Integer;
var
  I: Integer;
  R2: Single;
begin
  FSelectedIndex := -1;
  FIsSelected    := false;
  Result         := -1;
  //Point
  if GraphCernel2D<>nil then
  begin
    R2 := sqr(FRadius*GraphCernel2D.MtrPerPxl);
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

//"Объект GraphCernel2D" --------------------------------------------------------------------------
function TGraphCernel2DPolyline.Add(const APoint: RPoint3D; const AId_Point: Integer=-1): Integer;
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

//"Полигон GraphCernel2D" -------------------------------------------------------------------------
procedure TGraphCernel2DPolygon.Draw;
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

//"Текстовая отметка GraphCernel2D" ---------------------------------------------------------------
function TGraphCernel2DLabel.GetPoint: ROpenpitPoint3D;
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
procedure TGraphCernel2DLabel.SetPoint(const Value: ROpenpitPoint3D);
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
function TGraphCernel2DLabel.GetCoords: RPoint3D;
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
procedure TGraphCernel2DLabel.SetCoords(const Value: RPoint3D);
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
procedure TGraphCernel2DLabel.SetText(const Value: String);
begin
  if FText<>Value then
  begin
    FText := Value;
    Invalidate;
  end;{if}
end;{SetText}
procedure TGraphCernel2DLabel.Draw;
begin
  if Visible and(FGraphCernel2D<>nil)and(FText<>'')then
  begin
    glSetColor(FColor);
    glOutTextXY(Coords.X,Coords.Y,FText);
  end;{if}
end;{Draw}
constructor TGraphCernel2DLabel.Create;
begin
  inherited;
  FText := '';
end;{Create}

//"Полилинии GraphCernel2D" -----------------------------------------------------------------------
constructor TGraphCernel2DPolylines.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGraphCernel2DPolylines.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGraphCernel2DPolylines.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGraphCernel2DPolyline(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    FIsSelected := false;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGraphCernel2DPolylines.Draw;
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
function TGraphCernel2DPolylines.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGraphCernel2DPolylines.GetItem(const Index: Integer): TGraphCernel2DPolyline;
begin
  if InRange(Index,0,Count-1)
  then Result := PGraphCernel2DPolyline(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGraphCernel2DPolylines.GetFirst: TGraphCernel2DPolyline;
begin
  if Count>0
  then Result := PGraphCernel2DPolyline(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGraphCernel2DPolylines.GetLast: TGraphCernel2DPolyline;
begin
  if Count>0
  then Result := PGraphCernel2DPolyline(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGraphCernel2DPolylines.SetGraphCernel2D(const Value: TGraphCernel2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GraphCernel2D := GraphCernel2D;
end;{SetGraphCernel2D}
procedure TGraphCernel2DPolylines.Append;
var AItem: PGraphCernel2DPolyline;
begin
  New(AItem);
  AItem^ := TGraphCernel2DPolyline.Create;
  AItem^.GraphCernel2D := FGraphCernel2D;
  FItems.Add(AItem);
  Invalidate;
end;{Append}

//"Полигоны GraphCernel2D" ------------------------------------------------------------------------
constructor TGraphCernel2DPolygons.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGraphCernel2DPolygons.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGraphCernel2DPolygons.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGraphCernel2DPolygon(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    FIsSelected := false;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGraphCernel2DPolygons.Draw;
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
function TGraphCernel2DPolygons.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGraphCernel2DPolygons.GetItem(const Index: Integer): TGraphCernel2DPolygon;
begin
  if InRange(Index,0,Count-1)
  then Result := PGraphCernel2DPolygon(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGraphCernel2DPolygons.GetFirst: TGraphCernel2DPolygon;
begin
  if Count>0
  then Result := PGraphCernel2DPolygon(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGraphCernel2DPolygons.GetLast: TGraphCernel2DPolygon;
begin
  if Count>0
  then Result := PGraphCernel2DPolygon(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGraphCernel2DPolygons.SetGraphCernel2D(const Value: TGraphCernel2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GraphCernel2D := GraphCernel2D;
end;{SetGraphCernel2D}
procedure TGraphCernel2DPolygons.Append;
var AItem: PGraphCernel2DPolygon;
begin
  New(AItem);
  AItem^ := TGraphCernel2DPolygon.Create;
  AItem^.GraphCernel2D := FGraphCernel2D;
  FItems.Add(AItem);
  Invalidate;
end;{Append}

//"Текстовые отметки GraphCernel2D" ---------------------------------------------------------------
constructor TGraphCernel2DLabels.Create;
begin
  inherited;
  FItems   := TList.Create;
end;{Create}
destructor TGraphCernel2DLabels.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGraphCernel2DLabels.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    for I := FItems.Count-1 downto 0 do
    begin
      PGraphCernel2DLabel(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    FIsSelected := false;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGraphCernel2DLabels.Draw;
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
function TGraphCernel2DLabels.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGraphCernel2DLabels.GetItem(const Index: Integer): TGraphCernel2DLabel;
begin
  if InRange(Index,0,Count-1)
  then Result := PGraphCernel2DLabel(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGraphCernel2DLabels.GetFirst: TGraphCernel2DLabel;
begin
  if Count>0
  then Result := PGraphCernel2DLabel(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGraphCernel2DLabels.GetLast: TGraphCernel2DLabel;
begin
  if Count>0
  then Result := PGraphCernel2DLabel(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
procedure TGraphCernel2DLabels.SetGraphCernel2D(const Value: TGraphCernel2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GraphCernel2D := GraphCernel2D;
end;{SetGraphCernel2D}
procedure TGraphCernel2DLabels.Append;
var AItem: PGraphCernel2DLabel;
begin
  New(AItem);
  AItem^ := TGraphCernel2DLabel.Create;
  AItem^.GraphCernel2D := FGraphCernel2D;
  FItems.Add(AItem);
  Invalidate;
end;{Append}

//"Слой GraphCernel2D" ----------------------------------------------------------------------------
procedure TGraphCernel2DLayer.SetName(const Value: String);
begin
  if FName<>Value then
  begin
    FName := Value;
    Invalidate;
  end;{if}
end;{SetName}
procedure TGraphCernel2DLayer.SetGraphCernel2D(const Value: TGraphCernel2D);
begin
  inherited;
  LWPolylines.GraphCernel2D := GraphCernel2D;
  Polylines.GraphCernel2D := GraphCernel2D;
  MLines.GraphCernel2D := GraphCernel2D;
  Lines.GraphCernel2D := GraphCernel2D;
  MLines.GraphCernel2D := GraphCernel2D;
  Hatchs.GraphCernel2D := GraphCernel2D;
  Labels.GraphCernel2D := GraphCernel2D;
end;{SetGraphCernel2D}
procedure TGraphCernel2DLayer.Clear;
begin
  if FPolylines<>nil then FPolylines.Clear;
  if FLWPolylines<>nil then FLWPolylines.Clear;
  if FLines<>nil then FLines.Clear;
  if FMLines<>nil then FMLines.Clear;
  if FLabels<>nil then FLabels.Clear;
end;{Clear}
constructor TGraphCernel2DLayer.Create;
begin
  inherited;
  FName := '';
  FPolylines   := TGraphCernel2DPolylines.Create;
  FPolylines.GraphCernel2D := FGraphCernel2D;
  FLWPolylines := TGraphCernel2DPolylines.Create;
  FLWPolylines.GraphCernel2D := FGraphCernel2D;
  FLines       := TGraphCernel2DPolylines.Create;
  FLines.GraphCernel2D := FGraphCernel2D;
  FMLines      := TGraphCernel2DPolylines.Create;
  FMLines.GraphCernel2D := FGraphCernel2D;
  FHatchs      := TGraphCernel2DPolygons.Create;
  FHatchs.GraphCernel2D := FGraphCernel2D;
  FLabels      := TGraphCernel2DLabels.Create;
  FLabels.GraphCernel2D := FGraphCernel2D;
end;{Create}
destructor TGraphCernel2DLayer.Destroy;
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
procedure TGraphCernel2DLayer.Draw;
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

//"Слои GraphCernel2D" ----------------------------------------------------------------------------
constructor TGraphCernel2DLayers.Create;
begin
  inherited;
  FItems := TList.Create;
  FBound := Bound3D(0.0,0.0,0.0,0.0,0.0,0.0);
end;{Create}
destructor TGraphCernel2DLayers.Destroy;
begin
  Clear;
  FItems.Free;
  FItems := nil;
  inherited;
end;{Destroy}
procedure TGraphCernel2DLayers.Clear;
var I: Integer;
begin
  if FItems<>nil then
  begin
    FBound := Bound3D(0.0,0.0,0.0,0.0,0.0,0.0);
    for I := FItems.Count-1 downto 0 do
    begin
      PGraphCernel2DLayer(FItems[I])^.Free;
      Dispose(FItems[I]);
      FItems[I] := nil;
    end;{for}
    FItems.Clear;
    Invalidate;
  end;{if}
end;{Clear}
procedure TGraphCernel2DLayers.Draw;
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
function TGraphCernel2DLayers.GetCount: Integer;
begin
  if FItems<>nil then Result := FItems.Count else Result := 0;
end;{GetCount}
function TGraphCernel2DLayers.GetItem(const Index: Integer): TGraphCernel2DLayer;
begin
  if InRange(Index,0,Count-1)
  then Result := PGraphCernel2DLayer(FItems[Index])^
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{GetItem}
function TGraphCernel2DLayers.GetFirst: TGraphCernel2DLayer;
begin
  if Count>0
  then Result := PGraphCernel2DLayer(FItems[0])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetFirst}
function TGraphCernel2DLayers.GetLast: TGraphCernel2DLayer;
begin
  if Count>0
  then Result := PGraphCernel2DLayer(FItems[Count-1])^
  else Raise Exception.Create(Format(EInvalidIndex,[0,Count-1]));
end;{GetLast}
function TGraphCernel2DLayers.GetWidth : Single;
begin
  Result := FBound.MaxX-FBound.MinX
end;{GetWidth}
function TGraphCernel2DLayers.GetHeight: Single;
begin
  Result := FBound.MaxY-FBound.MinY
end;{GetHeight}
procedure TGraphCernel2DLayers.DefineBound;
const AMax=High(Integer);
var I,J,K: Integer;
begin
  FBound := Bound3D(AMax,-AMax,AMax,-AMax,AMax,-AMax);
  for I := 0 to Count-1 do
  begin
    for J := 0 to Items[I].Polylines.Count-1 do
    for K := 0 to Items[I].Polylines[J].Count-1 do
    with Items[I].Polylines[J][K].Coords do
    begin
      if FBound.MinX>X then FBound.MinX := X;
      if FBound.MaxX<X then FBound.MaxX := X;
      if FBound.MinY>Y then FBound.MinY := Y;
      if FBound.MaxY<Y then FBound.MaxY := Y;
      if FBound.MinZ>Z then FBound.MinZ := Z;
      if FBound.MaxZ<Z then FBound.MaxZ := Z;
    end;{for}
  end;{for}
  if FBound.MinX>FBound.MaxX then
  begin
    FBound.MinX := 0.0; FBound.MaxX := 0.0;
  end;{if}
  if FBound.MinY>FBound.MaxY then
  begin
    FBound.MinY := 0.0; FBound.MaxY := 0.0;
  end;{if}
  if FBound.MinZ>FBound.MaxZ then
  begin
    FBound.MinZ := 0.0; FBound.MaxZ := 0.0;
  end;{if}
end;{DefineBound}
procedure TGraphCernel2DLayers.SetGraphCernel2D(const Value: TGraphCernel2D);
var I: Integer;
begin
  inherited;
  for I := 0 to Count-1 do
    Items[I].GraphCernel2D := GraphCernel2D;
end;{SetGraphCernel2D}
function TGraphCernel2DLayers.Append: Integer;
var AItem: PGraphCernel2DLayer;
begin
  New(AItem);
  AItem^ := TGraphCernel2DLayer.Create;
  AItem^.GraphCernel2D := FGraphCernel2D;
  FItems.Add(AItem);
  Result := Count-1;
  Invalidate;
end;{Append}
procedure TGraphCernel2DLayers.Delete(const Index: Integer);
begin
  if InRange(Index,0,Count-1) then
  begin
    PGraphCernel2DLayer(FItems[Index])^.Free;
    Dispose(FItems[Index]);
    FItems.Delete(Index);
    Invalidate;
  end{if}
  else Raise Exception.Create(Format(EInvalidIndex,[Index,Count-1]));
end;{Delete}
function TGraphCernel2DLayers.IndexOf(const Name: String): Integer;
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
function TGraphCernel2DLayers.OptionsDialogExecute: Boolean;
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
function TGraphCernel2DLayers.LoadFromAutoCAD2004DBXFile(const AFileName: String): Boolean;
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
  APolylines      : TGraphCernel2DPolylines;
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
  DefineBound;
  Screen.Cursor := crDefault;
  Invalidate;
end;{LoadFromAutoCAD2004DBXFile}

end.
