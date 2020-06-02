unit unOpenpitEditor;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, esaOpenGL2D, esaDBNavigators, ActnList, ImgList, Types, Menus,
  StdCtrls, ToolWin, ExtCtrls, ComCtrls, Globals, esaDBOpenpitObjects;
  {dwd добавил types для использования TIntegerDynArrays}
type
  TToolsActionsStyle=(tasNone,tasPointer,tasPoints,tasBlocks,tasCrossRoads,
                      tasLoadingPunkts,tasUnLoadingPunkts,tasShiftPunkts,tasCourses,tasCoursesByBlocks,
                      tasScaleUp,tasScaleDown,tasScaleRect,tasMoving);
  TfmOpenpitEditor = class(TForm)
    ActionList: TActionList;
    actToolsPointer: TAction;
    actToolsPoints: TAction;
    actToolsBlocks: TAction;
    actToolsCrossRoads: TAction;
    actToolsLoadingPunkts: TAction;
    actToolsUnLoadingPunkts: TAction;
    actToolsShiftPunkts: TAction;
    actToolsCourses: TAction;
    actGraphicScaleUp: TAction;
    actGraphicScaleDown: TAction;
    actGraphicMoving: TAction;
    actGraphicCenter: TAction;
    actActionsNavigator: TAction;
    actActionsParams: TAction;
    actPopup: TAction;
    actPopupAdd: TAction;
    actPopupEdit: TAction;
    actPopupDelete: TAction;
    actPopupSelectAll: TAction;
    actPopupUnSelect: TAction;
    actPopupInterpolation: TAction;
    ImageList: TImageList;
    actActionsVisible: TAction;
    ControlBar: TControlBar;
    tlbTools: TToolBar;
    tbToolsPointer: TToolButton;
    tbToolsSep1: TToolButton;
    tbToolsPoints: TToolButton;
    tbToolsBlocks: TToolButton;
    tbToolsCrossRoads: TToolButton;
    tbToolsLoadingPunkts: TToolButton;
    tbToolsUnLoadingPunkts: TToolButton;
    tbToolsShiftPunkts: TToolButton;
    tbToolsCourses: TToolButton;
    stbMain: TStatusBar;
    pmMain: TPopupMenu;
    pmiMainAdd: TMenuItem;
    pmiMainEdit: TMenuItem;
    pmiMainDelete: TMenuItem;
    pmiMainSep1: TMenuItem;
    pmiMainSelectAll: TMenuItem;
    pmiMainUnSelect: TMenuItem;
    pmiMainSep2: TMenuItem;
    pmiMainInterpolation: TMenuItem;
    pmiMainSep4: TMenuItem;
    actActions3D: TAction;
    actOpenpitContur: TAction;
    actOpenpitAutoCADOpen: TAction;
    actOpenpitAutoCADEdit: TAction;
    actOpenpitAutoCADClose: TAction;
    tlbActions: TToolBar;
    tbActionsVisible: TToolButton;
    tbActionsSep2: TToolButton;
    tbActionsNavigator: TToolButton;
    tbActionsSep3: TToolButton;
    tbActionsParams: TToolButton;
    tbActionsSep4: TToolButton;
    tbActions3D: TToolButton;
    tlbGraphic: TToolBar;
    tbGraphicSep1: TToolButton;
    tbToolsScaleUp: TToolButton;
    tbToolsScaleDown: TToolButton;
    tbGraphicSep2: TToolButton;
    tbToolsMove: TToolButton;
    tbGraphicCenter: TToolButton;
    tlbOpenpit: TToolBar;
    tbOpenpitContur: TToolButton;
    tbOpenpitSep1: TToolButton;
    tbOpenpitAutoCADOpen: TToolButton;
    tbOpenpitAutoCADEdit: TToolButton;
    tbOpenpitAutoCADClose: TToolButton;
    btProCAD: TButton;
    pmiMainSep3: TMenuItem;
    pmiMainSelectCourse: TMenuItem;
    tbToolsCoursesByBlocks: TToolButton;
    actToolsCoursesByBlocks: TAction;
    tbActionsSep5: TToolButton;
    tbUklons: TToolButton;
    actActionsUklons: TAction;
    btnAdis: TButton;
    GroupBox1: TGroupBox;
    prBar: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure actToolsPointerExecute(Sender: TObject);
    procedure actGraphicCenterExecute(Sender: TObject);
    procedure actActionsNavigatorExecute(Sender: TObject);
    procedure actActionsParamsExecute(Sender: TObject);
    procedure actPopupExecute(Sender: TObject);
    procedure actPopupAddExecute(Sender: TObject);
    procedure actPopupEditExecute(Sender: TObject);
    procedure actPopupDeleteExecute(Sender: TObject);
    procedure actPopupSelectAllExecute(Sender: TObject);
    procedure actPopupUnSelectExecute(Sender: TObject);
    procedure actPopupInterpolationExecute(Sender: TObject);
    procedure actActionsVisibleExecute(Sender: TObject);
    procedure actActions3DExecute(Sender: TObject);
    procedure actOpenpitConturExecute(Sender: TObject);
    procedure actOpenpitAutoCADOpenExecute(Sender: TObject);
    procedure actOpenpitAutoCADEditExecute(Sender: TObject);
    procedure actOpenpitAutoCADCloseExecute(Sender: TObject);
    procedure btProCADClick(Sender: TObject);
    procedure pmiMainSelectCourseClick(Sender: TObject);
    procedure tbUklonsClick(Sender: TObject);
    procedure btnAdisClick(Sender: TObject);

  private
    FActiveAction: TToolsActionsStyle;
    FOpenGL2D    : TGraphCernel2D;
    FOpenpit     : TDBOpenpit; 
    FNavigator   : TDBNavigator;
    FMouseMtrPos : RPoint3D;
    procedure WMPAINT(var Msg: TWMPaint);message WM_PAINT;
    procedure WMSCALE(var Msg: TMessage);message WM_GRAPHCERNEL_SCALE;
    procedure WMRESIZE(var Msg: TMessage);message WM_GRAPHCERNEL_RESIZE;
    procedure WMNAVIGATOR(var Msg: TMessage);message WM_NAVIGATORVISIBLE;
    procedure WMSELECTED(var Msg: TMessage);message WM_SELECTED;
    procedure DoDraw;
    procedure DoBoundChange(var ABound: RBound3D);
    procedure DoNavigatorDraw(ACanvas: TCanvas; ARect: TRect);
    procedure DoNavigatorMouseClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ConvertToCebadan1;
    procedure OpenpProCADFile(AFileName: string);
  end;{TfmOpenpitEditor}

var
  fmOpenpitEditor: TfmOpenpitEditor;
//Диалоговое окно графического редактора
procedure esaShowOpenpitEditorDlg();
implementation
uses unDM, unOpenpitTools, esaDBDefaultParams, unOpenpitBound, unOpenpitView3D, DB, DBTables,
  Math;
{$R *.dfm}
const
  CRPOINTS=1;
  CRBLOCKS=2;
  CRCROSSROADS=3;
  CRLOADINGPUNKTS=4;
  CRUNLOADINGPUNKTS=5;
  CRSHIFTPUNKTS=6;
  CRCOURSES=7;
  CRZOOMUP=8;
  CRZOOMDOWN=9;
  CRMOVE=10;

type
  //Слои объектов Ербола
  TerbolGLScene2DLayers = class(TGraphCernel2DLayers)
  public
    property GraphCernel2D;
  end;{TerbolGLScene2DLayers}

var A: TerbolGLScene2DLayers;


//Диалоговое окно графического редактора
procedure esaShowOpenpitEditorDlg();
begin
  fmOpenpitEditor := TfmOpenpitEditor.Create(nil);
  try
    fmOpenpitEditor.ShowModal;
  finally
    fmOpenpitEditor.Free;
  end;{try}
end;{esaShowOpenpitEditorDlg}


function WithoutZap(strSource:string):String;
  var
    i: integer;
  begin
    result:= '';
    for i:= 1 to length(strSource) do
    begin
        if (strSource[i] <> ',') then
          result:= result + strSource[i]
        else
          result:= result + '.';

    end;{for}
  end;{function WithoutZap}



procedure TfmOpenpitEditor.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  Screen.Cursors[CRBLOCKS] := LoadCursor(HInstance, 'CRBLOCKS');
  Screen.Cursors[CRCROSSROADS] := LoadCursor(HInstance, 'CRBLOCKS');
  Screen.Cursors[CRLOADINGPUNKTS] := LoadCursor(HInstance, 'CRLOADINGPUNKTS');
  Screen.Cursors[CRUNLOADINGPUNKTS] := LoadCursor(HInstance, 'CRUNLOADINGPUNKTS');
  Screen.Cursors[CRSHIFTPUNKTS] := LoadCursor(HInstance, 'CRSHIFTPUNKTS');
  Screen.Cursors[CRCOURSES] := LoadCursor(HInstance, 'CRCOURSES');
  Screen.Cursors[CRZOOMUP] := LoadCursor(HInstance, 'CRZOOMIN');
  Screen.Cursors[CRZOOMDOWN] := LoadCursor(HInstance, 'CRZOOMOUT');
  Screen.Cursors[CRMOVE] := LoadCursor(HInstance, 'CRMOVE');

  Color := clBlack;
  tlbTools.Enabled := false;
  tlbActions.Enabled := false;
  PopupMenu := nil;
  FActiveAction := tasPointer;
  FOpenGL2D := nil;
  FOpenpit := nil;
  FNavigator := nil;

  FOpenGL2D := TGraphCernel2D.Create(Handle,Canvas.Handle);
  FOpenpit := TDBOpenpit.Create(fmDM.ADOConnection,FOpenGL2D,DefaultParams);
  Caption := '<'+FOpenpit.Name+'>';

  FOpenGL2D.OnDraw := DoDraw;
  FOpenGL2D.OnBoundChange := DoBoundChange;
  FOpenGL2D.ScreenBoundMtr := FOpenpit.Bound;

  FNavigator := TDBNavigator.Create(Self);
  FNavigator.OnDraw := DoNavigatorDraw;
  FNavigator.OnMouseClick := DoNavigatorMouseClick;
  FNavigator.Parent := Self;
  FNavigator.Top := ControlBar.Height+1;
  FNavigator.Visible := actActionsNavigator.Checked;
  FNavigator.Size := Point(250,250);

  PopupMenu := pmMain;
  tlbTools.Enabled := true;
  tlbActions.Enabled := true;

  FMouseMtrPos := FOpenGL2D.PointPxlToMtr(Mouse.CursorPos);
  A := TerbolGLScene2DLayers.Create;
  A.GraphCernel2D := FOpenGL2D;
  A.Append;

  //Tags
  actToolsPointer.Tag         := Integer(tasPointer);
  actToolsPoints.Tag          := Integer(tasPoints);
  actToolsBlocks.Tag          := Integer(tasBlocks);
  actToolsCrossRoads.Tag      := Integer(tasCrossRoads);
  actToolsLoadingPunkts.Tag   := Integer(tasLoadingPunkts);
  actToolsUnLoadingPunkts.Tag := Integer(tasUnLoadingPunkts);
  actToolsShiftPunkts.Tag     := Integer(tasShiftPunkts);
  actToolsCourses.Tag         := Integer(tasCourses);
  actToolsCoursesByBlocks.Tag := Integer(tasCoursesByBlocks);
  actGraphicScaleUp.Tag       := Integer(tasScaleUp);
  actGraphicScaleDown.Tag     := Integer(tasScaleDown);
//  actGraphicScaleRect.Tag     := Integer(tasScaleRect);
  actGraphicMoving.Tag        := Integer(tasMoving);


 

   FOpenpit.RefreshData;

 end;{FormCreate}

procedure TfmOpenpitEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A.Free;
  A := nil;
  FOpenGL2D.Free;
  FOpenGL2D := nil;
  FOpenpit.Free;
  FOpenpit := nil;
  FNavigator.Free;
  FNavigator := nil;
end;{FormClose}
procedure TfmOpenpitEditor.FormResize(Sender: TObject);
begin
  if FOpenGL2D<>nil
  then FOpenGL2D.ScreenBoundPxl := Rect(0,0,ClientWidth,ClientHeight);
  if FNavigator<>nil
  then FNavigator.Left := ClientWidth-FNavigator.Width-1;
end;{FormResize}
procedure TfmOpenpitEditor.FormShow(Sender: TObject);
begin
  Align := alClient;
  end;{FormShow}
procedure TfmOpenpitEditor.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (FOpenGL2D=nil)OR(FNavigator=nil) then Exit;
  //определяю нажатую кнопку и выполняю соответствующие действия
  case FActiveAction of
    tasScaleRect: if Shift=[ssLeft]then FOpenGL2D.ScalingOn(X,Y);
    tasMoving   : if Shift=[ssLeft]then FOpenGL2D.MovingOn(X,Y);
  end;{case}
end;{FormMouseDown}
procedure TfmOpenpitEditor.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (FOpenGL2D=nil)OR(FNavigator=nil) then Exit;
  FMouseMtrPos := FOpenGL2D.PointPxlToMtr(Point(X,Y));
  stbMain.Panels[1].Text := Format('X=%.3f Y=%.3f',[FMouseMtrPos.X,FMouseMtrPos.Y]);
  case FActiveAction of
    tasScaleRect: FOpenGL2D.ScalingBy(X,Y);
    tasMoving: begin
      FOpenGL2D.MovingBy(X,Y);
      if Shift=[ssLeft] then FNavigator.InvalidateAll;
    end;{MovingBy}
  end;{case}
end;{FormMouseMove}
procedure TfmOpenpitEditor.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  APoint: RPoint3D;
  AIndex: Integer;
begin
  if (FOpenGL2D=nil)OR(FNavigator=nil) then Exit;
  //определяю нажатую кнопку и выполняю соответствующие действия
  case FActiveAction of
    tasPointer: if (Button=mbLeft)and((Shift=[ssCtrl])OR(Shift=[]))
                then FOpenpit.SelectedObjects.Select(Point(X,Y), Shift);
    tasPoints:
      if Button=mbLeft then
      begin
        APoint := FOpenGL2D.PointPxlToMtr(Point(X,Y));
        FOpenpit.Points.Add(APoint.X,APoint.Y,DefaultParams.PointZ);
      end;{Point}
    tasBlocks,tasCrossRoads:    
      if (Button=mbLeft)and((Shift=[ssCtrl])OR(Shift=[]))and
         (FOpenpit.SelectedObjects.SelectedKind in [skBlockPoints,skCrossRoadPoints])
      then FOpenpit.SelectedObjects.SelectPoints(Point(X,Y),Shift);
    tasCourses:
      if (Button=mbLeft)and((Shift=[ssCtrl])OR(Shift=[]))and
         (FOpenpit.SelectedObjects.SelectedKind in [skCoursePoints])
      then FOpenpit.SelectedObjects.SelectPoints(Point(X,Y),Shift);
    tasCoursesByBlocks:
      if (Button=mbLeft)and((Shift=[ssCtrl])OR(Shift=[]))and
         (FOpenpit.SelectedObjects.SelectedKind in [skCourseBlocks])
      then FOpenpit.SelectedObjects.SelectBlocks(Point(X,Y),Shift);
    tasLoadingPunkts:
      if Button=mbLeft then
      with FOpenpit do
      if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then 
      begin
        APoint := GraphKernel.PointPxlToMtr(Point(X,Y));
        with GraphKernel do
          AIndex := SelectedObjects.FindPoint(APoint,DefaultParams.PointRadius*MtrPerPxl);
        if AIndex>-1 then FOpenpit.LoadingPunkts.Add(AIndex);
      end;{LoadingPunkt}
    tasUnLoadingPunkts:
      if Button=mbLeft then
      with FOpenpit do
      if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
      begin
        APoint := GraphKernel.PointPxlToMtr(Point(X,Y));
        with GraphKernel do
          AIndex := SelectedObjects.FindPoint(APoint,DefaultParams.PointRadius*MtrPerPxl);
        if AIndex>-1 then FOpenpit.UnLoadingPunkts.Add(AIndex);
      end;{UnLoadingPunkt}
    tasShiftPunkts:
      if Button=mbLeft then
      with FOpenpit do
      if (GraphKernel.ScreenWidthMtr>0.0)and(GraphKernel.ScreenWidthPxl>0)then
      begin
        APoint := GraphKernel.PointPxlToMtr(Point(X,Y));
        with GraphKernel do
          AIndex := SelectedObjects.FindPoint(APoint,DefaultParams.PointRadius*MtrPerPxl);
        if AIndex>-1 then FOpenpit.ShiftPunkts.Add(AIndex);
      end;{ShiftPunkt}
    tasScaleUp  : if Button=mbLeft then FOpenGL2D.ScaleTo(X,Y,1);
    tasScaleDown: if Button=mbLeft then FOpenGL2D.ScaleTo(X,Y,-1);
    tasScaleRect: FOpenGL2D.ScalingOff(X,Y);
    tasMoving   : FOpenGL2D.MovingOff(X,Y);
  end;{case}
end;{FormMouseUp}
procedure TfmOpenpitEditor.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if (FOpenGL2D=nil)OR(FNavigator=nil) then Exit;
  with FOpenGL2D.ScreenBoundMtr do
  begin
    if WheelDelta>0 then FOpenGL2D.ScaleTo(MousePos.X,MousePos.Y,-1);
    if WheelDelta<0 then FOpenGL2D.ScaleTo(MousePos.X,MousePos.Y,+1);
    if WheelDelta<>0 then MouseMove([],Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;{with}
end;{FormMouseWheel}
procedure TfmOpenpitEditor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (FOpenGL2D=nil)OR(FNavigator=nil) then Exit;
  if Shift=[] then
  begin
    case Key of
      Ord('W'), VK_UP   : FOpenGL2D.MoveBy(0,50);
      Ord('S'), VK_DOWN : FOpenGL2D.MoveBy(0,-50);
      Ord('A'), VK_LEFT : FOpenGL2D.MoveBy(-50,0);
      Ord('D'), VK_RIGHT: FOpenGL2D.MoveBy(50,0);
      VK_ADD            : FOpenGL2D.Scale := FOpenGL2D.Scale+1;
      VK_SUBTRACT       : FOpenGL2D.Scale := FOpenGL2D.Scale-1;
    end;{case}
    MouseMove([],Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;{if}
  if (Shift=[ssShift,ssCtrl,ssAlt])and(Key=Ord('S'))then ConvertToCebadan1;
end;{FormKeyDown}
procedure TfmOpenpitEditor.FormDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source Is TDBNavigator)AND PtInRect(ClientRect, Point(X,Y));
end;{FormDragOver}
procedure TfmOpenpitEditor.FormDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source Is TDBNavigator then
  with Source As TDBNavigator do
  begin
    Visible := false;
    EndDrag(false);
    if X<1 then X := 1;
    if X>Self.ClientWidth-1-Width then X := Self.ClientWidth-1-Width;
    if Y<1 then Y := 1;
    if Y>Self.ClientHeight-1-Height-stbMain.Height
    then Y := Self.ClientHeight-1-Height-stbMain.Height;
    Left := X;
    Top := Y;
    Visible := true;
  end;{if}
end;{FormDragDrop}
procedure TfmOpenpitEditor.WMPAINT(var Msg: TWMPaint);
var ps : TPaintStruct;
begin
  BeginPaint(Handle, ps);
    if FOpenGL2D<>nil then FOpenGL2D.Draw;
  EndPaint(Handle, ps);
  Msg.Result := 0;
 end;{WMPAINT}
procedure TfmOpenpitEditor.WMSCALE(var Msg: TMessage);
begin
  stbMain.Panels[0].Text := Format('Масштаб: 1x%d',[Msg.WParam]);
  Msg.Result := 0;
end;{WMSCALE}
procedure TfmOpenpitEditor.WMRESIZE(var Msg: TMessage);
begin                                               
  if FNavigator<>nil then FNavigator.InvalidateAll;
  Msg.Result := 0;
end;{WMRESIZE}
procedure TfmOpenpitEditor.WMNAVIGATOR(var Msg: TMessage);
begin
  case Msg.WParam of
    0: actActionsNavigator.Checked := FNavigator.Visible; //Навигатор видим/невидим
  end;{case}
  Msg.Result := 0;
end;{WMNAVIGATOR}
procedure TfmOpenpitEditor.WMSELECTED(var Msg: TMessage);
var No: Integer;
    S: String;
begin
  case Msg.LParam of
    0: stbMain.Panels[2].Text := '';
    1: with FOpenpit.SelectedObjects do
       begin
         No := Items[0]+1;
         S := '';
         case TSelectedKind(Msg.WParam) of
           skPoints,skBlockPoints,skCrossRoadPoints:
           with Points[0].Coords do
             S := Format(ESelectedPoint,[No,X,Y,Z]);
           skBlocks,skCrossRoads:
           with Blocks[0] do
             S := Format(ESelectedBlock,[No,BlockKindToStr(Kind),BlockLength]);
           skLoadingPunkts:
           with LoadingPunkts[0] do
             S:=Format(ESelectedLoadingPunkt,[No,ExcavatorName]);
           skUnLoadingPunkts:
           with UnLoadingPunkts[0] do
             S := Format(ESelectedUnLoadingPunkt,[No,UnLoadingPunktKindToStr(Kind),
                                                  AutoMaxCount,MaxV1000m3]);
           skShiftPunkts:
           with FOpenpit.ShiftPunkts[Items[0]].Coords do
             S := Format(ESelectedShiftPunkt,[No,X,Y,Z]);
           skCourses:
           with FOpenpit.Courses[Items[0]] do
             S := Format(ESelectedCourse,[No,Name,CourseLength]);
         end;{case}
         stbMain.Panels[2].Text := S;
       end;{with}
    else
       with FOpenpit.SelectedObjects do
       begin
         S := '';
         case TSelectedKind(Msg.WParam) of
           skPoints:
             S := Format(ESelectedPoints,[Count,SelectedNumbers]);
           skBlockPoints,skCrossRoadPoints:
             S := Format(ESelectedPointsEx,[Count,SelectedNumbers,TotalLength]);
           skBlocks,skCrossRoads:
             S := Format(ESelectedBlocks,[Count,SelectedNumbers]);
           skLoadingPunkts:
             S := Format(ESelectedLoadingPunkts,[Count,SelectedNumbers]);
           skUnLoadingPunkts:
             S := Format(ESelectedUnLoadingPunkts,[Count,SelectedNumbers]);
           skCourses:
             S := Format(ESelectedCourses,[Count,SelectedNumbers,TotalLength]);
           skShiftPunkts:
             S := Format(ESelectedShiftPunkts,[Count,SelectedNumbers]);
         end;{case}
         stbMain.Panels[2].Text := S;
       end;{with}
  end;{case}
  Msg.Result := 0;
end;{WMSELECTED}
procedure TfmOpenpitEditor.DoDraw;
begin
  if (FOpenGL2D<>nil)and(FOpenpit<>nil) then FOpenpit.Draw;
  if (FOpenGL2D<>nil)and(A<>nil) then A.Draw;
end;{DoDraw}
procedure TfmOpenpitEditor.DoBoundChange(var ABound: RBound3D);
const AMax=High(Integer);
var TempBound: RBound3D;
begin
  if (FOpenpit<>nil)and(FOpenGL2D<>nil)AND(FOpenGL2D.Layers.Count>0)then
  begin
    if (FOpenpit.Points.Count>1)OR(FOpenGL2D.Layers.Width>0)or(FOpenGL2D.Layers.Height>0)
    then TempBound := Bound3D(AMax,-AMax,AMax,-AMax,AMax,-AMax)
    else TempBound := ABound;
    if FOpenpit.Points.Count>1 then
    begin
      if TempBound.MinX>FOpenpit.Bound.MinX then TempBound.MinX := FOpenpit.Bound.MinX;
      if TempBound.MaxX<FOpenpit.Bound.MaxX then TempBound.MaxX := FOpenpit.Bound.MaxX;
      if TempBound.MinY>FOpenpit.Bound.MinY then TempBound.MinY := FOpenpit.Bound.MinY;
      if TempBound.MaxY<FOpenpit.Bound.MaxY then TempBound.MaxY := FOpenpit.Bound.MaxY;
      if TempBound.MinZ>FOpenpit.Bound.MinZ then TempBound.MinZ := FOpenpit.Bound.MinZ;
      if TempBound.MaxZ<FOpenpit.Bound.MaxZ then TempBound.MaxZ := FOpenpit.Bound.MaxZ;
    end;{if}
    if (FOpenGL2D.Layers.Width>0)or(FOpenGL2D.Layers.Height>0) then
    with FOpenGL2D.Layers do
    begin
      if TempBound.MinX>Bound.MinX then TempBound.MinX := Bound.MinX;
      if TempBound.MaxX<Bound.MaxX then TempBound.MaxX := Bound.MaxX;
      if TempBound.MinY>Bound.MinY then TempBound.MinY := Bound.MinY;
      if TempBound.MaxY<Bound.MaxY then TempBound.MaxY := Bound.MaxY;
      if TempBound.MinZ>Bound.MinZ then TempBound.MinZ := Bound.MinZ;
      if TempBound.MaxZ<Bound.MaxZ then TempBound.MaxZ := Bound.MaxZ;
    end;{if}
    ABound := TempBound;
  end;{if}
end;{DoBoundChange}
procedure TfmOpenpitEditor.DoNavigatorDraw(ACanvas: TCanvas; ARect: TRect);
var
  I,J,MaxJ,X,Y,Step  : Integer;
  MinValue,MaxValue  : TPoint;
  ABoundMtr          : RBound3D;//Контур проецирования
  ASizePxl           : TPoint;
  ASizeMtr,ACenterMtr: RPoint3D;
  AConturMtr         : RBound3D;//Контур проецирования с учетом Scale и Space, м
  AConturPxl         : TRect;   //Контур проецирования с учетом Scale и Space, pxl
begin
  if (FOpenGL2D=nil)or(FNavigator=nil) then Exit;
  //Вычисления---------------------------------------------------------------------------------
  ABoundMtr    := FOpenGL2D.ScreenBoundMtr;
  ACenterMtr   := Point3D((ABoundMtr.MaxX+ABoundMtr.MinX)*0.5,
                          (ABoundMtr.MaxY+ABoundMtr.MinY)*0.5,0.0);
  ASizeMtr     := Point3D(FOpenGL2D.ScreenWidthMtr,FOpenGL2D.ScreenHeightMtr,0.0);
  ASizePxl     := Point(ARect.Right-ARect.Left+1,ARect.Bottom-ARect.Top+1);
  if ASizePxl.X<ASizePxl.Y
  then ASizeMtr.Y := ASizeMtr.X*ASizePxl.Y/ASizePxl.X
  else ASizeMtr.X := ASizeMtr.Y*ASizePxl.X/ASizePxl.Y;
  ABoundMtr    := Bound3D(ACenterMtr.X-ASizeMtr.X*0.5, ACenterMtr.X+ASizeMtr.X*0.5,
                          ACenterMtr.Y-ASizeMtr.Y*0.5, ACenterMtr.Y+ASizeMtr.Y*0.5,0.0,0.0);
  //Рисование----------------------------------------------------------------------------------
  with ACanvas do
  begin
    Pen.Width := 1;
    Pen.Style := psSolid;
    //Рисую координатную сетку-----------------------------------------------------------------
    Step       := DefaultParams.CoordGridStep;
    MinValue   := Point(Trunc(FOpenGL2D.ScreenBoundMtr.MinX),Trunc(FOpenGL2D.ScreenBoundMtr.MinY));
    MinValue   := Point(MinValue.X-(MinValue.X mod Step),MinValue.Y-(MinValue.Y mod Step));
    MaxValue   := Point(Trunc(FOpenGL2D.ScreenBoundMtr.MaxX),Trunc(FOpenGL2D.ScreenBoundMtr.MaxY));
    MaxValue   := Point(MaxValue.X+(Step-(MaxValue.X mod Step)),MaxValue.Y+(Step-(MaxValue.Y mod Step)));

    MaxJ := (MaxValue.Y-MinValue.Y)div Step -1;
    Pen.Color := clGray;
    Brush.Color := Pen.Color;
    for I := 0 to ((MaxValue.X-MinValue.X)div Step)-1 do
      for J := 0 to MaxJ do
      begin
        X := Round(ARect.Left+ASizePxl.X*(MinValue.X+I*Step-ABoundMtr.MinX)/ASizeMtr.X);
        Y := Round(ARect.Top+ASizePxl.Y*(1-(MinValue.Y+J*Step-ABoundMtr.MinY)/ASizeMtr.Y));
        Pixels[X,Y] := clGray;
      end;{for}
    //рисую блок-участки-----------------------------------------------------------------------
    if FOpenpit.Blocks.Visible then
    begin
      Pen.Width := 2;
      for I := 0 to FOpenpit.Blocks.Count-1 do
      if FOpenpit.Blocks[I].Count>1 then
      with FOpenpit.Blocks[I] do
      begin
        Pen.Color := DefaultParams.BlockColors[Kind];
        X := Round(ARect.Left+ASizePxl.X*(Points[0].Coords.X-ABoundMtr.MinX)/ASizeMtr.X);
        Y := Round(ARect.Top+ASizePxl.Y*(1-(Points[0].Coords.Y-ABoundMtr.MinY)/ASizeMtr.Y));
        MoveTo(X,Y);
        for J := 1 to Count-1 do
        begin
          X := Round(ARect.Left+ASizePxl.X*(Points[J].Coords.X-ABoundMtr.MinX)/ASizeMtr.X);
          Y := Round(ARect.Top+ASizePxl.Y*(1-(Points[J].Coords.Y-ABoundMtr.MinY)/ASizeMtr.Y));
          LineTo(X,Y);
        end;{for}
      end;{for}
      Pen.Width := 1;
    end;{if}
    //Рисую прямоугольник экрана---------------------------------------------------------------
    AConturMtr := FOpenGL2D.CurrentScreenBoundMtr;
    with AConturMtr do
      AConturPxl := Rect(Round(ARect.Left+ASizePxl.X*(MinX-ABoundMtr.MinX)/ASizeMtr.X),
                         Round(ARect.Top+ASizePxl.Y*(1-(MinY-ABoundMtr.MinY)/ASizeMtr.Y)),
                         Round(ARect.Left+ASizePxl.X*(MaxX-ABoundMtr.MinX)/ASizeMtr.X),
                         Round(ARect.Top+ASizePxl.Y*(1-(MaxY-ABoundMtr.MinY)/ASizeMtr.Y)));
    Pen.Color := clRed;
    MoveTo(AConturPxl.Left,AConturPxl.Top);
    LineTo(AConturPxl.Right,AConturPxl.Top);
    LineTo(AConturPxl.Right,AConturPxl.Bottom);
    LineTo(AConturPxl.Left,AConturPxl.Bottom);
    LineTo(AConturPxl.Left,AConturPxl.Top);
    //если вышел за рамки контура
    if (AConturMtr.MaxX<ABoundMtr.MinX)OR(AConturMtr.MinX>ABoundMtr.MaxX)OR
       (AConturMtr.MaxY<ABoundMtr.MinY)OR(AConturMtr.MinY>ABoundMtr.MaxY) then
    begin
      Pen.Color := clRed;
      Brush.Color := clBlack;
      Pen.Width := 1;
      Pen.Style := psDot;
      X := Round(ARect.Left+ASizePxl.X*(ACenterMtr.X-ABoundMtr.MinX)/ASizeMtr.X);
      Y := Round(ARect.Top+ASizePxl.Y*(1-(ACenterMtr.Y-ABoundMtr.MinY)/ASizeMtr.Y));
      MoveTo(X,Y);
      LineTo((AConturPxl.Left+AConturPxl.Right)div 2,(AConturPxl.Top+AConturPxl.Bottom)div 2);
    end;{if}
  end;{with}
end;{DoNavigatorDraw}
procedure TfmOpenpitEditor.DoNavigatorMouseClick(Sender: TObject; Button: TMouseButton;
                                                Shift: TShiftState; X, Y: Integer);
var
  ABoundMtr          : RBound3D;//Контур проецирования
  ASizePxl           : TPoint;
  ASizeMtr,ACenterMtr: RPoint3D;
  AClientBound       : TRect;
  APoint             : RPoint3D;
begin
  if (FOpenGL2D=nil)or(FNavigator=nil) then Exit;
  //Вычисления---------------------------------------------------------------------------------
  AClientBound := FNavigator.ClientBound;
  ABoundMtr    := FOpenGL2D.ScreenBoundMtr;
  ACenterMtr.X := (ABoundMtr.MaxX+ABoundMtr.MinX)*0.5;
  ACenterMtr.Y := (ABoundMtr.MaxY+ABoundMtr.MinY)*0.5;

  with ABoundMtr do
    ASizeMtr := Point3D(MaxX-MinX,MaxY-MinY,MaxZ-MinZ);
  with AClientBound do
    ASizePxl := Point(Right-Left+1,Bottom-Top+1);
  if ASizePxl.X<ASizePxl.Y
  then ASizeMtr.Y := ASizeMtr.X*ASizePxl.Y/ASizePxl.X
  else ASizeMtr.X := ASizeMtr.Y*ASizePxl.X/ASizePxl.Y;

  ABoundMtr.MinX := ACenterMtr.X-ASizeMtr.X*0.5;
  ABoundMtr.MaxX := ACenterMtr.X+ASizeMtr.X*0.5;
  ABoundMtr.MinY := ACenterMtr.Y-ASizeMtr.Y*0.5;
  ABoundMtr.MaxY := ACenterMtr.Y+ASizeMtr.Y*0.5;

  APoint.X := ABoundMtr.MinX+ASizeMtr.X*(X-AClientBound.Left)/ASizePxl.X;
  APoint.Y := ABoundMtr.MinY+ASizeMtr.Y*(1-(Y-AClientBound.Top)/ASizePxl.Y);
  FOpenGL2D.Space := Point(Round(APoint.X-ACenterMtr.X),
                           Round(APoint.Y-ACenterMtr.Y));
end;{DoNavigatorMouseClick}

procedure TfmOpenpitEditor.actToolsPointerExecute(Sender: TObject);
var
  I: Integer;
  AAction: TAction;
begin
  if not(Sender is TAction) then Exit;
  //определяю нажатую кнопку ------------------------------------------------------------------
  if TAction(Sender).Checked then AAction := actToolsPointer else AAction := TAction(Sender);
  FOpenpit.SelectedObjects.SelectedKind := skPoints;
  if AAction.Tag<1 then Exit;
  for I := 0 to ActionList.ActionCount-1 do
    if ActionList.Actions[I].Tag>0
    then TAction(ActionList.Actions[I]).Checked := false;
  AAction.Checked := true;
  FActiveAction := TToolsActionsStyle(AAction.Tag);
  FOpenpit.SelectedObjects.Clear;
  //при нажатии любой кнопки
  Cursor := crCross;
  case FActiveAction of
    tasPoints: begin
      Cursor := CRPOINTS;
      FOpenpit.SelectedObjects.SelectedKind := skPoints;
    end;{Points}
    tasBlocks: begin
      Cursor := CRBLOCKS;
      FOpenpit.SelectedObjects.SelectedKind := skBlockPoints;
    end;{Blocks}
    tasCrossRoads:begin
      Cursor := CRCROSSROADS;
      FOpenpit.SelectedObjects.SelectedKind := skCrossRoadPoints;
    end;{CrossRoad}
    tasLoadingPunkts:begin
      Cursor := CRLOADINGPUNKTS;
      FOpenpit.SelectedObjects.SelectedKind := skLoadingPunkts;
    end;{tasLoadingPunkts}
    tasUnLoadingPunkts:begin
      Cursor := CRUNLOADINGPUNKTS;
      FOpenpit.SelectedObjects.SelectedKind := skUnLoadingPunkts;
    end;{tasUNLoadingPunkts}
    tasShiftPunkts:begin
      Cursor := CRSHIFTPUNKTS;
      FOpenpit.SelectedObjects.SelectedKind := skShiftPunkts;
    end;{tasShiftPunkts}
    tasCourses:begin
      Cursor := CRCOURSES;
      FOpenpit.SelectedObjects.SelectedKind := skCoursePoints;
    end;{tasCourses}
    tasCoursesByBlocks:begin
      Cursor := CRCOURSES;
      FOpenpit.SelectedObjects.SelectedKind := skCourseBlocks;
    end;{tasCourses}
    tasScaleUp:begin
      Cursor := CRZOOMUP;
    end;{tasScaleUp}
    tasScaleDown:begin
      Cursor := CRZOOMDOWN;
    end;{tasScaleDown}
    tasScaleRect:begin
      Cursor := crCross;
    end;{tasScaleRect}
    tasMoving:begin
      Cursor := CRMOVE;
    end;{Moving}
  end;{case}
end;{actToolsPointerExecute}

procedure TfmOpenpitEditor.actGraphicCenterExecute(Sender: TObject);
begin
  if FOpenGL2D<>nil then FOpenGL2D.ToCenter;
end;{actActionsCenterExecute}
procedure TfmOpenpitEditor.actActionsNavigatorExecute(Sender: TObject);
begin
  actActionsNavigator.Checked := not actActionsNavigator.Checked;
  FNavigator.Visible := actActionsNavigator.Checked;
end;{actActionsNavigatorExecute}
procedure TfmOpenpitEditor.actActionsParamsExecute(Sender: TObject);
begin
  if esaShowOpenpitToolsDlg(HelpKeyword) then
  begin
    FOpenGL2D.Invalidate;
    FNavigator.InvalidateAll;
  end;{if}
end;{actActionsParamsExecute}

procedure TfmOpenpitEditor.actPopupExecute(Sender: TObject);
var
  IsCount0,IsCount1,IsCount2: Boolean;
  SelectedKind: TSelectedKind;
begin
  SelectedKind := FOpenpit.SelectedObjects.SelectedKind;
  IsCount0 := FOpenpit.SelectedObjects.Count>0;
  IsCount1 := FOpenpit.SelectedObjects.Count>1;
  IsCount2 := FOpenpit.SelectedObjects.Count>2;
  actPopupInterpolation.Visible := SelectedKind in [skPoints,skBlocks];
  if SelectedKind in [skPoints,skLoadingPunkts,skUnLoadingPunkts,skShiftPunkts]
  then actPopupAdd.Caption := 'Переместить'
  else actPopupAdd.Caption := 'Добавить';
  pmiMainSelectCourse.Enabled := actToolsPointer.Checked and ((not IsCount0)or(SelectedKind=skCourses));
  actPopupAdd.Enabled := (IsCount0 and(not IsCount1)and
                         (SelectedKind in[skPoints,skLoadingPunkts,skUnLoadingPunkts,skShiftPunkts]))OR
                         (IsCount1 and(SelectedKind=skBlockPoints))or
                         (IsCount1 and(not IsCount2)and(SelectedKind=skCrossRoadPoints))or
                         (IsCount1 and(not IsCount2)and(SelectedKind=skCoursePoints))or
                         (IsCount0 and (SelectedKind=skCourseBlocks));
  actPopupEdit.Enabled := IsCount0 and(SelectedKind in [skPoints,skBlocks,skCrossRoads,
                          skLoadingPunkts,skUnLoadingPunkts]);
  actPopupDelete.Enabled := IsCount0 and(SelectedKind in [skPoints,skBlocks,skCrossRoads,
                          skLoadingPunkts,skUnLoadingPunkts,skShiftPunkts,skCourses]);
  actPopupSelectAll.Enabled := FActiveAction=tasPointer;
  actPopupUnSelect.Enabled := IsCount0;
  actPopupInterpolation.Enabled := ((SelectedKind=skPoints)and IsCount1)OR
                                   ((SelectedKind=skBlocks)and IsCount0 and (not IsCount1));
end;{actPopupExecute}
procedure TfmOpenpitEditor.actPopupAddExecute(Sender: TObject);
begin
  FOpenpit.SelectedObjects.AddSelectedObjectsTo(FMouseMtrPos.X,FMouseMtrPos.Y);
end;{actPopupAddExecute}
procedure TfmOpenpitEditor.actPopupEditExecute(Sender: TObject);
begin
  FOpenpit.SelectedObjects.EditorExecute;
end;{actPopupEditExecute}
procedure TfmOpenpitEditor.actPopupDeleteExecute(Sender: TObject);
begin
  FOpenpit.SelectedObjects.DeleteSelectedObjects;
end;{actPopupDeleteExecute}
procedure TfmOpenpitEditor.actPopupSelectAllExecute(Sender: TObject);
begin
  FOpenpit.SelectedObjects.SelectAll;
end;{actPopupSelectAllExecute}
procedure TfmOpenpitEditor.actPopupUnSelectExecute(Sender: TObject);
begin
  FOpenpit.SelectedObjects.Clear;
end;{actPopupUnSelectExecute}
procedure TfmOpenpitEditor.actPopupInterpolationExecute(Sender: TObject);
begin
  with FOpenpit.SelectedObjects do
  begin
    if (SelectedKind=skPoints)and(Count>1)
    then InterpolationPoints;
    if (SelectedKind=skBlocks)and(Count=1)
    then InterpolationBlocks;
    FNavigator.InvalidateAll;
  end;{with}
end;{actPopupInterpolationExecute}
procedure TfmOpenpitEditor.actActionsVisibleExecute(Sender: TObject);
begin
  with FOpenpit do
  if SelectedObjects.VisibleEditorExecute then
  begin
    FActiveAction := tasPointer;
    actToolsPointerExecute(actToolsPointer);
    actToolsPoints.Enabled := Points.Visible;
    actToolsBlocks.Enabled := Blocks.Visible and Points.Visible;
    actToolsCrossRoads.Enabled := actToolsBlocks.Enabled;
    actToolsLoadingPunkts.Enabled := LoadingPunkts.Visible and actToolsPoints.Enabled;
    actToolsUnLoadingPunkts.Enabled := UnLoadingPunkts.Visible and actToolsPoints.Enabled;
    actToolsShiftPunkts.Enabled := ShiftPunkts.Visible and actToolsPoints.Enabled;
    actToolsCourses.Enabled := Courses.Visible and actToolsBlocks.Enabled;
  end;{if}
end;{actActionsVisibleExecute}
procedure TfmOpenpitEditor.actActions3DExecute(Sender: TObject);
begin
  esaShowOpenpitView3DDlg(HelpKeyword);
end;{actActions3DExecute}
procedure TfmOpenpitEditor.actOpenpitConturExecute(Sender: TObject);
var bOpenpit: RBound3D;
begin
  bOpenpit := FOpenpit.Bound;
  if esaShowOpenpitBoundDlg(HelpKeyword,FOpenpit.Points.Bound,bOpenpit) then
  begin
    FOpenpit.Bound := bOpenpit;
    fmDM.quOpenpits.Refresh;
    fmDM.quOpenpits.Locate('Id_Openpit',FOpenpit.Id_Openpit,[])
  end;{if}
end;{actActionsOpenpitBoundExecute}
procedure TfmOpenpitEditor.actOpenpitAutoCADOpenExecute(Sender: TObject);
begin
  if FOpenGL2D<>nil then
  with TOpenDialog.Create(nil) do
  try
    InitialDir := ExtractFileDir(Application.ExeName);
    Filter := 'AutoCAD 2004 DXF (*.dxf)|*.dxf';
    Options := [ofPathMustExist,ofFileMustExist,ofEnableSizing];
    if Execute then
      if FOpenGL2D.Layers.LoadFromAutoCAD2004DBXFile(Trim(FileName))
      then FOpenGL2D.Layers.OptionsDialogExecute;
  finally
    Free;
  end;{try}
end;{actOpenpitAutoCADOpenExecute}
procedure TfmOpenpitEditor.actOpenpitAutoCADEditExecute(Sender: TObject);
begin
  if FOpenGL2D<>nil then FOpenGL2D.Layers.OptionsDialogExecute;
end;{actOpenpitAutoCADEditExecute}
procedure TfmOpenpitEditor.actOpenpitAutoCADCloseExecute(Sender: TObject);
begin
  if FOpenGL2D<>nil then FOpenGL2D.Layers.Clear;
end;{actOpenpitAutoCADCloseExecute}

//Конвертация Points,Blocks  в Cebadan-Auto,I
procedure TfmOpenpitEditor.ConvertToCebadan1;
type
  RTempPoint=record
    Id_Point: Integer;
    X,Y,Z   : Single;
  end;
  RTempBlock=record
    Id_Block    : Integer;
    Count       : Integer;
    PointIndexes: array of Integer;
  end;
var
  APath: String;//Путь к БД Cebadan-Auto,I
  APoints     : array of RTempPoint;
  APointsCount: Integer;
  ABlocks     : array of RTempBlock;
  ABlocksCount: Integer;
  I,J: Integer;
begin
  //Путь к БД
  APath := '';
  with TOpenDialog.Create(nil) do
  try
    InitialDir := ExtractFileDir(Application.ExeName);
    Filter := 'БД Cebadan-Auto, Версия 1.0 (*.db)|XYZ.db';
    Title := 'Конвертация в БД Cebadan-Auto, Версия 1.0';
    DefaultExt := '.db';
    if Execute then APath := ExtractFilePath(FileName);
  finally
    Free;
  end;{try}
  //Проверки существования таблиц характереных точек и блок-участков
  if APath='' then Exit;
  if not FileExists(APath+'XYZ.db') then esaMsgError('Не могу найти '+APath+'XYZ.db')
  else
  if not FileExists(APath+'Block_U.db') then esaMsgError('Не могу найти '+APath+'Block_U.db')
  else
  begin
    with fmDM do
    begin
      quPoints.Open;
      quRoadCoats.Open;
      quBlocks.Open;
      quBlockPoints.Open;
      //Считываю Points
      SetLength(APoints,quPoints.RecordCount);
      APointsCount := 0;
      quPoints.First;
      while not quPoints.Eof do
      begin
        Inc(APointsCount);
        APoints[APointsCount-1].Id_Point := quPointsId_Point.AsInteger;
        APoints[APointsCount-1].X        := quPointsX.AsFloat;
        APoints[APointsCount-1].Y        := quPointsY.AsFloat;
        APoints[APointsCount-1].Z        := quPointsZ.AsFloat;
        quPoints.Next;
      end;{while}
      SetLength(APoints,APointsCount);
      //Считываю Blocks
      SetLength(ABlocks,quBlocks.RecordCount);
      ABlocksCount := 0;
      quBlocks.First;
      while not quBlocks.Eof do
      begin
        quBlockPoints.Last;
        quBlockPoints.First;
        Inc(ABlocksCount);
        ABlocks[ABlocksCount-1].Id_Block := quBlocksId_Block.AsInteger;
        ABlocks[ABlocksCount-1].Count    := 0;
        SetLength(ABlocks[ABlocksCount-1].PointIndexes,quBlockPoints.RecordCount);
        while not quBlockPoints.Eof do
        begin
          for I := 0 to APointsCount-1 do
          if APoints[I].Id_Point=quBlockPointsId_Point.AsInteger then
          begin
            Inc(ABlocks[ABlocksCount-1].Count);
            ABlocks[ABlocksCount-1].PointIndexes[ABlocks[ABlocksCount-1].Count-1] := I;
            Break;
          end;{for}
          quBlockPoints.Next;
        end;{while}
        SetLength(ABlocks[ABlocksCount-1].PointIndexes,ABlocks[ABlocksCount-1].Count);
        quBlocks.Next;
      end;{while}
      SetLength(ABlocks,ABlocksCount);
      quBlockPoints.Close;
      quBlocks.Close;
      quRoadCoats.Close;
      quPoints.Close;
    end;{with}
    with TQuery.Create(nil) do
    try
      DatabaseName := APath;
      RequestLive := true;
      //Записываю Points
      SQL.Text := 'SELECT * FROM XYZ';
      Open;
      for I := 0 to APointsCount-1 do
      begin
        Append;
        FieldByName('X').AsFloat := APoints[I].X;
        FieldByName('Y').AsFloat := APoints[I].Y;
        FieldByName('Z').AsFloat := APoints[I].Z;
        Post;
      end;{for}
      Close;
      //Записываю Blocks
      SQL.Text := 'SELECT * FROM Block_U';
      Open;
      for I := 0 to ABlocksCount-1 do
      if ABlocks[I].Count>1 then
      begin
        Append;
        for J := 0 to ABlocks[I].Count-1 do
        begin
          FieldByName('N'+IntToStr(J+1)).AsInteger := ABlocks[I].PointIndexes[J]+1;
          if J>=24 then Break;
        end;{for}
        Post;
      end;{for}
      Close;
      APoints := nil;
      ABlocks := nil;
    finally
      Free;
    end;{try}
    esaMsgError('Конвертация завершена успешно');
  end;{else}
end;{ConvertToCebadan1}


procedure TfmOpenpitEditor.btProCADClick(Sender: TObject);
begin
  OpenpProCADFile('с.pcd')
{  A.Last.Polylines.Append;
  A.Last.Polylines.Last.Add(Point3D(300,4000,0));
  A.Last.Polylines.Last.Add(Point3D(5800,0,0));
  A.Last.Polylines.Last.Color := clWhite;}

{Erbol}
end;

procedure TfmOpenpitEditor.OpenpProCADFile(AFileName: string);
var
  FText: TextFile;
  FX, FY, fZ: Double;
  DataLine: string;
begin
  try
    if FileExists(AFileName) then AssignFile(FText, AFileName);
    Reset(FText);
    while not Eof(FText) do
    begin
      readLn(FText, DataLine);
      DataLine := Trim(DataLine);
      if DataLine = '$LAYER' then readLn(FText, DataLine);
      if (DataLine = '$L') then
      begin
        A.Last.Polylines.Append;
        readLn(FText, DataLine);
        readLn(FText, DataLine);
        A.Last.Polylines.Last.Color:=StrToInt(Trim(DataLine));
        readLn(FText, DataLine);
        readLn(FText, DataLine);
        readLn(FText, DataLine);
        A.Last.Polylines.Last.LineWidth:=StrToFloatEx(Trim(DataLine));
      end;{if}
      if DataLine = '$P'   then
      begin
        readLn(FText, DataLine);
        FX := StrToFloatEx(DataLine);
        readLn(FText, DataLine);
        FY := StrToFloatEx(DataLine);
        readLn(FText, DataLine);
        fZ := StrToFloatEx(DataLine);
        readLn(FText, DataLine);
        A.Last.Polylines.Last.Add(Point3D(FX, FY, fZ));
      end;{if}
    end;{while}
  finally
    CloseFile(FText);
  end;{try}
end;{OpenpProCADFile}

procedure TfmOpenpitEditor.pmiMainSelectCourseClick(Sender: TObject);
begin
  FOpenpit.SelectedObjects.SelectCourses();
end;{pmiMainSelectCourseClick}

procedure TfmOpenpitEditor.tbUklonsClick(Sender: TObject);
begin
  FOpenpit.AnalizeUklons();
end;{tbUklonsClick}

{dwd новая процежура с кнопкой для адиса}
procedure TfmOpenpitEditor.btnAdisClick(Sender: TObject);
var
x, y, z: Double;
I, J, K: Integer;
idpoint, borderPoint : RDBPoint;
corpoint : RDBPoint;
borderBlock : TDBBlock;
step : Double;
alreadyFindThePoint : Boolean;
addArr : TIntegerDynArray;
addArr2 : TIntegerDynArray;
addArrnewblock : TIntegerDynArray;
delarray : TIntegerDynArray;
parkNo: Integer;
corthekind : TIntegerDynArray;
corthekindblock : TIntegerDynArray;
blocklen :Integer;
lenght : Integer;
isFound : Boolean;
begin
 GroupBox1.Color := clWhite;
 GroupBox1.Visible := true;
 prBar.Visible := true;
 prbar.Position := 10;
 {корректирую координаты экскаваторов}
  Undm.fmDM.quAdisCourses.SQL.Text := 'Select X, Y, Z, ParkNo from AdisExcvCoord;';
  Undm.fmDM.quAdisCourses.Active := True;
  while Undm.fmDM.quAdisCourses.Eof = False  do
  begin
  	x := undm.fmDM.quAdisCourses.Fields.Fields[0].Value;
  	y := undm.fmDM.quAdisCourses.Fields.Fields[1].Value;
    parkNo:=undm.fmDM.quAdisCourses.Fields.Fields[3].Value;
    prbar.Position := prbar.Position +1;
	  if (x >0 ) or (y >0) then
  	begin
	  	step := 0.01;
      alreadyFindThePoint := False;
	  	z:= MaxInt;
	    //Поиск точки для экскаватора
	    // Если существует в базе данных данная точно то просто её запоминаем, и потом переносим туда экскаватор.
	    //Если точка с такими координатами не существует тогда ищем близжайщую точку и запоминаем БУ на котором находится найденная точка.
	    //Но поиск продолжаем в радиусе 7 едениц и проверяем есть ли другие блок участки которые находятся ниже уровнем на 5 едениц
	    undm.fmDM.quAdisPoints.SQL.Text := 'Select Id_Point, X, Y ,Z from OpenpitPoints Where Id_Openpit = 119 And X='
		  + WithoutZap(FloatToStrF(X, ffFixed, 7, 3)) + ' And Y =' + WithoutZap(FloatToStrF(Y,ffFixed,7,3))+ '; ';
		  undm.fmDM.quAdisPoints.Active := True;
		  if undm.fmDM.quAdisPoints.RecordCount >0 then
		  begin
			  idpoint := FOpenpit.Points.Items[FOpenpit.Points.IndexOf(undm.fmDM.quAdisPoints.Fields.Fields[0].Value)];
        {TODO не добавленна проверка принадлежности данной точки к нескольким БУ (ЕСЛИ ЭТО НЕОБХОДИМО)}
			 // for I:= 0 to FOpenpit.Blocks.Count-1 do
			 // 	for J:= 0 to FOpenpit.Blocks.Items[I].Count -1 do
			 //	  begin
			 //		  if (FOpenpit.Blocks.Items[I].Points[J].Id_Point = idpoint.Id_Point) then
			//	  end;
      end
      else
      begin
		  	While ((step < 7)or(alreadyFindThePoint = False)) do
		  	begin
		  		step := step + 0.1;
		  		for J:= 0 to FOpenpit.FBlocks.Count - 1 do
		  			for K:=0 to FOpenpit.FBlocks.Items[J].Count-1 do
		  			begin
		  				corpoint := FOpenpit.FBlocks.Items[J].Points[K];
		  				if (x - step <= corpoint.Coords.X) and
		  				   (x + step >= corpoint.Coords.X) and
                (y - step <= corpoint.Coords.Y) and
                (y + step >= corpoint.Coords.Y) then
		  				begin
               if (z - corpoint.Coords.Z > 3.5 )then
		  					begin
		  							borderPoint := corpoint;
		  							z := corpoint.Coords.Z;
		  							borderBlock := FOpenpit.FBlocks.Items[J];
		  							alreadyFindThePoint := True;
		  					end;
		  				end;
		  		  end;{FOR}
		  	end; {WHILE}

      undm.fmDM.quAdisPoints.Cancel;
       //теперь у нас есть точка где будет экскаватор и блок участок к которому он будет привязан.
	    //разделяем БУ на два бу по координате точки экскаватора
        for J := 0 to borderBlock.Count -1 do
        begin
		  	  if ((borderBlock.Points[J].Id_Point = borderPoint.Id_Point) And (J>0) And (J<borderBlock.Count -1)) then
		  	  begin
		  	  	SetLength(addArr, J+1);
		  	  	for K:=0 to J do
		  	  	  addArr[K] := FOpenpit.Points.IndexOf(borderBlock.Points[K].Id_Point);
		  	  	FOpenpit.FBlocks.Add(addArr);
		  	  	SetLength(addArr2, borderBlock.Count - J);
		  	  	For K:=J to borderBlock.Count -1 do
		  	  	  addArr2[K-J] := FOpenpit.Points.IndexOf(borderBlock.Points[K].Id_Point);
		  	  	FOpenpit.FBlocks.Add(addArr2);
		  	  	SetLength(delarray,1);
		  	  	delarray[0] := FOpenpit.FBlocks.IndexOf(borderBlock.Id_Block);
		  	  	FOpenpit.FBlocks.Delete(delarray);
		  	  	break;
		  	  end;
        end;
        FOpenpit.Points.Add(x,y,z);
        idpoint := FOpenpit.Points.Items[FOpenpit.Points.Count-1];
		    SetLength(addArrnewblock,2);
		    addArrnewblock[0] := FOpenpit.Points.IndexOf(borderPoint.Id_Point);
		    addArrnewblock[1] := FOpenpit.Points.Count -1;
		    FOpenpit.FBlocks.Add(addArrnewblock);
        end;{if}

	  	//Переношу на новые точки экскаваторы.
      undm.fmDM.quAdisPoints.Cancel;
		  undm.fmDM.quAdisPoints.SQL.Text := 'Select Id_Point from OpenpitLoadingPunkts,'+
	    	'OpenpitDeportExcavators Where OpenpitDeportExcavators.Id_DeportExcavator ='+
	    	' OpenpitLoadingPunkts.Id_DeportExcavator And OpenpitDeportExcavators.ParkNo ='+
	    	IntToStr(parkNo) + ' ;';
	  	undm.fmDM.quAdisPoints.Active:=True;
	    If undm.fmDM.quAdisPoints.RecordCount > 0 then
      begin
	  		undm.fmDM.quAdisPoints.Edit;
  			undm.fmDM.quAdisPoints.Fields.Fields[0].Value :=  idpoint.Id_Point;
  			undm.fmDM.quAdisPoints.Append;
  		end;
      undm.fmDM.quAdisPoints.Cancel;
    end;{IF X>0 or Y>0}
    prbar.Position := prbar.Position +1;
   Undm.fmDM.quAdisCourses.Next;
  end;{while}
   prbar.Position := 5000;
  //Разделяю БУ Для Пункта пересменки
  Undm.fmDM.quAdisCourses.Cancel;
  Undm.fmDM.quAdisCourses.SQL.Text := 'Select Id_Point from OpenpitShiftPunkts';
  Undm.fmDM.quAdisCourses.Active := True;
  while Undm.fmDM.quAdisCourses.Eof = false do
  begin
  for I:=0 to FOpenpit.FBlocks.Count -1 do
    for J:=0 to FOpenpit.FBlocks.Items[I].Count -1 do
    begin
      if (FOpenpit.FBlocks.Items[I].Points[J].Id_Point =
        Undm.fmDM.quAdisCourses.Fields.Fields[0].Value) then
        if (J=0) or (j=FOpenpit.FBlocks.Items[I].Count - 1) then
          break
        else
        begin
          SetLength(addArr, J+1);
		  	  For K := 0 to J do
            addArr[K] := FOpenpit.Points.IndexOf(FOpenpit.FBlocks.Items[I].Points[K].Id_Point);
          FOpenpit.FBlocks.Add(addArr);
          SetLength(addArr2,  FOpenpit.FBlocks.Items[I].Count - J);
          For K:=J to FOpenpit.FBlocks.Items[I].Count -1 do
		  	    addArr2[K-J] := FOpenpit.Points.IndexOf(FOpenpit.FBlocks.Items[I].Points[K].Id_Point);
		  	   FOpenpit.FBlocks.Add(addArr2);
		  	   SetLength(delarray,1);
		  	   delarray[0] := FOpenpit.FBlocks.IndexOf(FOpenpit.FBlocks.Items[I].Id_Block);
		  	   FOpenpit.FBlocks.Delete(delarray);
           prbar.Position := prbar.Position +1;
		  	    break;
        end;
    end;
     Undm.fmDM.quAdisCourses.Next;
  end;
     //Разделяю БУ Для cскладов
  Undm.fmDM.quAdisCourses.Cancel;
  Undm.fmDM.quAdisCourses.SQL.Text := 'Select Id_Point from OpenpitUnLoadingPunkts';
  Undm.fmDM.quAdisCourses.Active := True;
  while Undm.fmDM.quAdisCourses.Eof = false do
  begin
  for I:=0 to FOpenpit.FBlocks.Count -1 do
    for J:=0 to FOpenpit.FBlocks.Items[I].Count -1 do
    begin
      if (FOpenpit.FBlocks.Items[I].Points[J].Id_Point =
        Undm.fmDM.quAdisCourses.Fields.Fields[0].Value) then
        if (J=0) or (j=FOpenpit.FBlocks.Items[I].Count - 1) then
        break
        else
        begin
          SetLength(addArr, J+1);
		  	  For K := 0 to J do
            addArr[K] := FOpenpit.Points.IndexOf(FOpenpit.FBlocks.Items[I].Points[K].Id_Point);
          FOpenpit.FBlocks.Add(addArr);
          SetLength(addArr2,  FOpenpit.FBlocks.Items[I].Count - J);
          For K:=J to FOpenpit.FBlocks.Items[I].Count -1 do
		  	    addArr2[K-J] := FOpenpit.Points.IndexOf(FOpenpit.FBlocks.Items[I].Points[K].Id_Point);
		  	   FOpenpit.FBlocks.Add(addArr2);
		  	   SetLength(delarray,1);
		  	   delarray[0] := FOpenpit.FBlocks.IndexOf(FOpenpit.FBlocks.Items[I].Id_Block);
		  	   FOpenpit.FBlocks.Delete(delarray);
           prbar.Position := prbar.Position +1;
		  	    break;
        end;
    end;
     Undm.fmDM.quAdisCourses.Next;
  end;
  prbar.Position := 800;
  lenght:=1;
  {СОЗДАЁМ МАРШРУТЫ ДВИЖЕНИЯ АВТОСАМОСВАЛОВ}
  undm.fmDM.ADOSebadan.Cancel;
	undm.fmDM.ADOSebadan.CommandText := 'DELETE FROM OpenpitCourses;';
	undm.fmDM.ADOSebadan.Execute;
	undm.fmDM.ADOSebadan.Cancel;
  FOpenpit.RefreshData;
    //первый тип маршрутов
  Undm.fmDM.quAdisCourses.Cancel;
  Undm.fmDM.quAdisCourses.SQL.Text := 'Select Id_Point from OpenpitShiftPunkts';
  Undm.fmDM.quAdisCourses.Active := True;
  while Undm.fmDM.quAdisCourses.Eof = false do
  begin
	  undm.fmDM.quAdisPoints.Cancel;
	  undm.fmDM.quAdisPoints.SQL.Text := 'Select Id_Point from OpenpitLoadingPunkts';
	  undm.fmDM.quAdisPoints.Active := True;
    while undm.fmDM.quAdisPoints.Eof = false do
    begin
		  FOpenpit.FCourses.Add(Undm.fmDM.quAdisCourses.Fields.Fields[0].Value,undm.fmDM.quAdisPoints.Fields.Fields[0].Value);
      SetLength(corthekind,lenght);
      corthekind[lenght -1 ] := undm.fmDM.quAdisPoints.Fields.Fields[0].Value;
      lenght := lenght+1;
      prbar.Position := prbar.Position +1;
      undm.fmDM.quAdisPoints.Next;
    end;
    SetLength(corthekind,lenght);
    corthekind[lenght -1 ] := undm.fmDM.quAdisCourses.Fields.Fields[0].Value;
    lenght := lenght+1;
    Undm.fmDM.quAdisCourses.Next;
  end;
     //третий тип маршрутов
  undm.fmDM.quAdisPoints.Cancel;
  undm.fmDM.quAdisPoints.SQL.Text := 'Select Id_Point from OpenpitUnLoadingPunkts';
  undm.fmDM.quAdisPoints.Active := True;
  while undm.fmDM.quAdisPoints.Eof = false do
  begin
	  Undm.fmDM.quAdisCourses.Cancel;
	  Undm.fmDM.quAdisCourses.SQL.Text := 'Select Id_Point from OpenpitLoadingPunkts';
	  Undm.fmDM.quAdisCourses.Active :=True;
    while Undm.fmDM.quAdisCourses.Eof = false do
    begin
		  FOpenpit.FCourses.Add(Undm.fmDM.quAdisCourses.Fields.Fields[0].Value,undm.fmDM.quAdisPoints.Fields.Fields[0].Value);
      prbar.Position := prbar.Position +1;
      Undm.fmDM.quAdisCourses.Next;
    end;
	  undm.fmDM.quAdisPoints.Next;
  end;
   //второй тип маршрутов
  Undm.fmDM.quAdisCourses.Cancel;
  Undm.fmDM.quAdisCourses.SQL.Text := 'Select Id_Point from OpenpitUnLoadingPunkts';
  Undm.fmDM.quAdisCourses.Active :=True;
  while Undm.fmDM.quAdisCourses.Eof = false do
  begin
	  undm.fmDM.quAdisPoints.Cancel;
	  undm.fmDM.quAdisPoints.SQL.Text := 'Select Id_Point from OpenpitShiftPunkts';
	  undm.fmDM.quAdisPoints.Active := True;
	while undm.fmDM.quAdisPoints.Eof = false do
  begin
	  FOpenpit.FCourses.Add(Undm.fmDM.quAdisCourses.Fields.Fields[0].Value,undm.fmDM.quAdisPoints.Fields.Fields[0].Value);
    prbar.Position := prbar.Position +1;
    undm.fmDM.quAdisPoints.Next;
  end;
    SetLength(corthekind,lenght);
    corthekind[lenght -1 ] := undm.fmDM.quAdisCourses.Fields.Fields[0].Value;
    lenght := lenght+1;
    Undm.fmDM.quAdisCourses.Next;
  end;
{КОНЕЦ	 СОЗДАЁМ МАРШРУТЫ ДВИЖЕНИЯ АВТОСАМОСВАЛОВ}
       prbar.Position := 900;
{Редактирую БУ МАневров}
blocklen := 0;
for I:=0 to lenght -1 do
begin
 undm.fmDM.quAdisPoints.Cancel;
 undm.fmDM.quAdisPoints.SQL.Text := 'Select Id_Block from OpenpitBlockPoints'+
  ' Where Id_Point =' + IntToStr(corthekind[I]);
 undm.fmDM.quAdisPoints.Active := True;
  while undm.fmDM.quAdisPoints.Eof = false do
  begin
   blocklen := blocklen +1;
   SetLength (corthekindblock,blocklen);
   corthekindblock[blocklen-1] := undm.fmDM.quAdisPoints.Fields.Fields[0].Value;
   undm.fmDM.quAdisPoints.Next;
  end;
 end;

  undm.fmDM.quAdisPoints.Cancel;
  undm.fmDM.quAdisPoints.SQL.Text := 'Select Kind, Id_Block from OpenpitBlocks Where Kind = 2';
  undm.fmDM.quAdisPoints.Active := True;
    while undm.fmDM.quAdisPoints.Eof = false do
  begin
   Undm.fmDM.quAdisCourses.Cancel;
   Undm.fmDM.quAdisCourses.SQL.Text := 'Select Kind,Id_Block from OpenpitBlocks where Id_Block = '+IntToStr(undm.fmDM.quAdisPoints.Fields.Fields[1].Value) ;
   undm.fmDM.quAdisCourses.Active := true;
   undm.fmDM.quAdisCourses.Edit;
   undm.fmDM.quAdisCourses.Fields.Fields[0].Value := 0;
   undm.fmDM.quAdisCourses.Append;
   undm.fmDM.quAdisPoints.Next;

end;
 for I:=0 to  blocklen -1 do
 begin
  Undm.fmDM.quAdisCourses.Cancel;
  Undm.fmDM.quAdisCourses.SQL.Text := 'Select Kind,Id_Block from OpenpitBlocks where Id_Block = '+IntToStr(corthekindblock[I]) ;
  undm.fmDM.quAdisCourses.Active := true;
  undm.fmDM.quAdisCourses.Edit;
  undm.fmDM.quAdisCourses.Fields.Fields[0].Value := 2;
  undm.fmDM.quAdisCourses.Append;
 end;
  FOpenpit.RefreshData;
  prBar.Visible := false;
  GroupBox1.Visible := false;

end;



end.
