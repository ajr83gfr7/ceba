unit esaDBNavigators;
{
Елубаев Сулеймен Актлеуович
аспирант ИГД им.Д.А.Кунаева
Навигатор для карьерного пространства 2D
}
interface
uses
  ExtCtrls, Classes, Types, Controls, Messages, Graphics;
const
  WM_NAVIGATORVISIBLE=WM_USER+200;
type
  TDBNavigatorDrawEvent = procedure(ACanvas: TCanvas; ARect: TRect) of object;
  //TDBNavigator - класс "Навигатор" ----------------------------------------------------------
  TDBNavigator = class(TCustomPanel)
  private
    FIsClose     : Boolean;   //Признак нажатия на кнопку "Close"
    FbnCloseBtn  : TRect;     //Контур кнопки "Close"
    FBound       : TRect;     //Контур внутренней части формы
    FClientBound : TRect;     //Контур клиентской части формы
    FOnDraw      : TDBNavigatorDrawEvent;
    FBmp         : TBitmap;   //Дежурная bmp-ешка в качестве второго "буфера прорисовки"
    FOnMouseClick: TMouseEvent; 
    procedure DrawPanel;     
    procedure DrawTitle;
    procedure DrawCloseBtn;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton;
                          Shift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton;
                        Shift: TShiftState; X, Y: Integer);
    procedure SetSize(Value: TPoint);
    function GetSize: TPoint;
  public
    property ClientBound: TRect read FClientBound;
    property OnDraw: TDBNavigatorDrawEvent read FOnDraw write FOnDraw;
    property Size: TPoint read GetSize write SetSize;
    property OnMouseClick: TMouseEvent read FOnMouseClick write FOnMouseClick;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint;override;
    procedure InvalidateAll;
  end;{TDBNavigator}

implementation
uses Windows;
//TDBNavigator - класс "Навигатор" ------------------------------------------------------------
constructor TDBNavigator.Create(AOwner: TComponent);
begin
  FBmp := nil;
  inherited;
  FBmp := Graphics.TBitmap.Create;
  FIsClose := false;
  Width := 200;
  Height := 200;
  FBound := Rect(2,25,Width-2,Height-2);
  FbnCloseBtn := Rect(Width-8-16,6,Width-8,6+14);
  FClientBound := Rect(30,30,FBound.Right-FBound.Left-30+1,FBound.Bottom-FBound.Top-30+1);
  Color := clBlack;
  OnMouseDown := DoMouseDown;
  OnMouseUp := DoMouseUp;
  Caption := 'Навигатор';
  FOnMouseClick := nil;
end;{Create}
destructor TDBNavigator.Destroy;
begin
  FOnMouseClick := nil;
  FBmp.Free;
  FBmp := nil;
  inherited;
end;{Destroy}
//Рисую саму форму навигатора
procedure TDBNavigator.DrawPanel;
begin
  with Canvas do
  begin
    Pen.Color := clDkGray;
    MoveTo(0,Height-1); LineTo(Width-1,Height-1); LineTo(Width-1,0);
    MoveTo(1,Height-1); LineTo(1,1); LineTo(Width-1,1);
    Pen.Color := clWhite;
    MoveTo(0,0); LineTo(Width-2,0); LineTo(Width-2,Height-2); LineTo(0,Height-2); LineTo(0,0);
  end;{if}
end;{DrawPanel}
//Рисую заголовок формы навигатора
procedure TDBNavigator.DrawTitle;
begin
  with Canvas do
  begin
    Brush.Color := clActiveCaption;
    Pen.Color := clActiveCaption;
    Rectangle(Rect(2,2,Width-2,25));
    Font.Color := clWhite;
    Font.Style := [fsBold];
    TextOut(6,6,'Навигатор');
  end;{with}
end;{DrawTitle}
//Рисую кнопку закрытия "Close" формы навигатора
procedure TDBNavigator.DrawCloseBtn;
const
  clLightGrayEx=13160660;
  clGrayEx     =8421504;
  clDarkGrayEx =4210752;
var dX,dY: Integer;
begin
  with Canvas, FbnCloseBtn do
  begin
    if FIsClose then dX := 1 else dX := 0;
    dY := dX;
    Brush.Color := TColor(clLightGrayEx);
    Pen.Color := Brush.Color;
    Rectangle(FbnCloseBtn);
    if not FIsClose then Pen.Color := TColor(clDarkGrayEx) else Pen.Color := clWhite;
    MoveTo(Left,Bottom-1); LineTo(Right-1,Bottom-1); LineTo(Right-1,Top-1);
    Pen.Color := TColor(clGrayEx);
    if not FIsClose then
    begin
      MoveTo(Left+1,Bottom-2); LineTo(Right-2,Bottom-2); LineTo(Right-2,Top);
    end{if}
    else
    begin
      MoveTo(Left+1,Bottom-3); LineTo(Left+1,Top+1); LineTo(Right-2,Top+1);
    end;{else}
    if not FIsClose then Pen.Color := clWhite else Pen.Color := TColor(clDarkGrayEx);
    MoveTo(Left,Bottom-2); LineTo(Left,Top); LineTo(Right-1,Top);
    
    Pen.Color := clBlack;
    MoveTo(Left+ 4+dX,Top+ 3+dY); LineTo(Left+11+dX,Top+10+dY);
    MoveTo(Left+ 5+dX,Top+ 3+dY); LineTo(Left+12+dX,Top+10+dY);
    MoveTo(Left+ 4+dX,Top+ 9+dY); LineTo(Left+11+dX,Top+ 2+dY);
    MoveTo(Left+ 5+dX,Top+ 9+dY); LineTo(Left+12+dX,Top+ 2+dY);
  end;{with}
end;{DrawCloseBtn}
//прорисовка навигатора
procedure TDBNavigator.Paint;
begin
  FBmp.Width := FBound.Right-FBound.Left+1;
  FBmp.Height := FBound.Bottom-FBound.Top+1;
  with FBmp.Canvas do
  begin
    Pen.Color := clBlack;
    Brush.Color := clBlack;
    Rectangle(Rect(0,0,FBound.Right-FBound.Left+1,FBound.Bottom-FBound.Top+1));
    if Assigned(FOnDraw) then
    FOnDraw(FBmp.Canvas,FClientBound);
    Canvas.Draw(FBound.Left,FBound.Top,FBmp);
    DrawPanel;
    DrawTitle;
    DrawCloseBtn;
  end;{with}
end;{Paint}
procedure TDBNavigator.WMSize(var Message: TWMSize);
begin
  inherited;
  FBound := Rect(2,25,Width-2,Height-2);
  FClientBound := Rect(30,30,FBound.Right-FBound.Left-30+1,FBound.Bottom-FBound.Top-30+1);
  FbnCloseBtn := Rect(Width-8-16,6,Width-8,6+14);
  Invalidate;
end;{WMSize}
procedure TDBNavigator.DoMouseDown(Sender: TObject; Button: TMouseButton;
                                   Shift: TShiftState; X, Y: Integer);
begin
  if not FIsClose then
    if PtInRect(FbnCloseBtn,Point(X,Y)) then
    begin//щелкнул по кнопке закрытия
      FIsClose := true; Invalidate;
    end{if}
    else//щелкнул не по кнопке закрытия
      if PtInRect(Rect(2,2,Width-2,25),Point(X,Y)) then
      begin//если щелкнул по заголовку, то начинаю перетаскивание
        BeginDrag(false);
      end;{else}
end;{DoMouseDown}
procedure TDBNavigator.DoMouseUp(Sender: TObject; Button: TMouseButton;
                                 Shift: TShiftState; X, Y: Integer);
begin
  if FIsClose then
  begin
    FIsClose := false;
    if PtInRect(FbnCloseBtn,Point(X,Y))
    then Visible := false
    else Invalidate;
  end{if}
  else
  if not PtInRect(Rect(2,2,Width-2,25),Point(X,Y)) then
  if Assigned(FOnMouseClick)
  then FOnMouseClick(Sender,Button,Shift,X-FBound.Left,Y-FBound.Top);
end;{DoMouseUp}
procedure TDBNavigator.CMVisibleChanged(var Message: TMessage);
var
  AHandle: HWND;
begin
  AHandle := Parent.Handle;
  inherited;
  if not Visible then PostMessage(AHandle,WM_NAVIGATORVISIBLE,0,0);
  FIsClose := false;
end;{CMVisibleChanged}
procedure TDBNavigator.InvalidateAll;
begin
  InvalidateRect(Handle,nil,false)
end;{InvalidateRect}
function TDBNavigator.GetSize: TPoint;
begin
  Result := Point(Width,Height);
end;{GetSize}
procedure TDBNavigator.SetSize(Value: TPoint);
begin
  if ((Width<>Value.X)OR(Height<>VAlue.Y))and(Value.X>=100)and(Value.Y>=100) then
  begin
    Width := Value.X; Height := Value.Y;
  end;{if}
end;{SetSize}

end.
