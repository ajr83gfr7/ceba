unit unResultGraphView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, ImgList, ToolWin, esaModelingResults,
  GLTexture, GLCadencer, GLScene, GLObjects, GLGeomObjects, GLCanvas,//GLMisc,
  GLSkyBox, GLWin32Viewer, Menus, ActnList, GLMisc; {, GLCoordinates, BaseClasses,
  GLCrossPlatform, GLMaterial;               }

type
  TTrackBarState=(tbsNone,tbsPlay,tbsPause,tbsWaiting);
  TfmResultGraphView = class(TForm)
    Splitter: TSplitter;
    pnParams: TPanel;
    ScrollBox: TScrollBox;
    pbPunkts: TPaintBox;
    pnTitle: TPanel;
    lbDtTitle: TLabel;
    lbDt: TLabel;
    lbStrippingCoef: TLabel;
    lbStrippingCoefTitle: TLabel;
    lbAutosCount: TLabel;
    lbAutosCountTitle: TLabel;
    ImageList: TImageList;
    pnBtns: TPanel;
    tlbBtns: TToolBar;
    tbPrior: TToolButton;
    tbPlay: TToolButton;
    tbPause: TToolButton;
    tbStop: TToolButton;
    tbNext: TToolButton;
    GLSceneViewer: TGLSceneViewer;
    GLMaterialLibrary: TGLMaterialLibrary;
    GLCadencer: TGLCadencer;
    GLScene: TGLScene;
    GLSkyBox: TGLSkyBox;
    dcOpenpit: TGLDummyCube;
    GLCamera: TGLCamera;
    pbTrackBar: TPaintBox;
    PopupMenu: TPopupMenu;
    pmiPrior: TMenuItem;
    pmiPlay: TMenuItem;
    pmiPause: TMenuItem;
    pmiStop: TMenuItem;
    pmiNext: TMenuItem;
    ActionList: TActionList;
    actPlayerPrior: TAction;
    actPlayerPlay: TAction;
    actPlayerPause: TAction;
    actPlayerStop: TAction;
    actPlayerNext: TAction;
    actPlayer: TAction;
    dcAuto: TGLDummyCube;
    actObjectView: TAction;
    pmiPlayer: TMenuItem;
    pmiView: TMenuItem;
    lcTopLeft: TGLLightSource;
    lcRightBottom: TGLLightSource;
    dcExcavator: TGLDummyCube;
    actParamsVisible: TAction;
    actParamsVisible1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure GLCadencerProgress(Sender: TObject; const deltaTime,newTime: Double);
    procedure pbTrackBarPaint(Sender: TObject);
    procedure pbTrackBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actPlayerExecute(Sender: TObject);
    procedure actPlayerPriorExecute(Sender: TObject);
    procedure actPlayerPlayExecute(Sender: TObject);
    procedure actPlayerPauseExecute(Sender: TObject);
    procedure actPlayerStopExecute(Sender: TObject);
    procedure actPlayerNextExecute(Sender: TObject);
    procedure ScrollBoxResize(Sender: TObject);
    procedure pbPunktsPaint(Sender: TObject);
    procedure actObjectViewExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actParamsVisibleExecute(Sender: TObject);
  private
    FMousePos     : TPoint;           //Последняя позиция мыши
    FAnimator     : TResultAnimator3D;//Аниматор
    FdTmsec       : Integer;          //Шаг анимации, сек
    FTrackBarBmp  : TBitmap;          //Канва проигрывателя
    FTrackBarMin  : Single;           //Мин. положение проигрывателя
    FTrackBarMax  : Single;           //Макс. положение проигрывателя
    FTrackBarPos  : Single;           //Текущее положение проигрывателя
    FTrackBarDelta: Single;           //Шаг изменения положения проигрывателя
    FTrackBarState: TTrackBarState;   //Состояние проигрывателя
    FActiveObject : Integer;          //Объект просмотра: 000  - Карьер;
                                      //                  1(N) - Авто №(N);
                                      //                  2(N) - Экскаватор №(N)
    FPunktsBmp    : TBitmap;          //Времен.BMP для прорисовки пиктограмм пунктов PopupMenu
    procedure TrackBarPaint;
    procedure CreateAuto(var ADummyCube: TGLDummyCube);
    procedure CreateExcavator(var ADummyCube: TGLDummyCube);
    procedure CreateViewItems;
    procedure DestroyViewItems;
  public
  end;{TfmVisio}

var
  fmResultGraphView: TfmResultGraphView;

//Диалоговое окно графического просмотра результата моделирования
function esaShowResultGraphDlg(): Boolean;
implementation

uses unDM, Math, KeyBoard, Globals, VectorGeometry;

{$R *.dfm}

//Диалоговое окно графического просмотра результата моделирования
function esaShowResultGraphDlg(): Boolean;
begin
  Result := True;
  fmResultGraphView := TfmResultGraphView.Create(nil);
  try
    fmResultGraphView.ShowModal;
  finally
    Screen.Cursor := crDefault;
    fmResultGraphView.Free;
  end;{try}
end;{esaShowResultGraphDlg}

procedure TfmResultGraphView.FormCreate(Sender: TObject);
var Size,Center: RPoint3D;
begin

  HelpKeyword := Copy(Name,3,Length(Name)-2);
  //TrackBar-----------------------------------------------------------------------------------
  FTrackBarBmp := TBitmap.Create;
  FTrackBarMin  := 0.0;
  FTrackBarMax  := 100.0;
  FTrackBarPos  := 0.0;
  FTrackBarDelta:= 0.5;
  FTrackBarState:= tbsNone;
  FActiveObject := 0;
  FPunktsBmp := TBitmap.Create;
  //Animator-----------------------------------------------------------------------------------
  FAnimator := TResultAnimator3D.Create(dcOpenpit,fmDM.ADOConnection);
  if FAnimator.Openpit.LoadFromDB(DefaultParams.OpenpitId_Openpit) then
  try
    Screen.Cursor := crHourGlass;
    Center := FAnimator.Openpit.Center;
    Size := Point3D(abs(FAnimator.Openpit.MaxPoint.X-FAnimator.Openpit.MinPoint.X),
                    abs(FAnimator.Openpit.MaxPoint.Y-FAnimator.Openpit.MinPoint.Y),
                    abs(FAnimator.Openpit.MaxPoint.Z-FAnimator.Openpit.MinPoint.Z));
    //Размеры коорд. сетки
    dcOpenpit.CubeSize := Max(Size.X,Max(Size.Y,Size.Z));
    dcOpenpit.Position.SetPoint(Center.X,Center.Y,Center.Z);
    //
    GLSkyBox.Position.Assign(dcOpenpit.Position);
    //Позиция, Глубина просмотра камеры
    GLCamera.Position.SetPoint(Center.X,Center.Y,Center.Z+2*dcOpenpit.CubeSize);
    GLCamera.DepthOfView := 50*dcOpenpit.CubeSize;
    //Позиция источника света
//    lcTop.Position.SetPoint(0.0,0.0,0.49*dcOpenpit.CubeSize);
    lcTopLeft.Position.SetPoint(-0.49*dcOpenpit.CubeSize,-0.49*dcOpenpit.CubeSize,0.49*dcOpenpit.CubeSize);
    lcRightBottom.Position.SetPoint(+0.49*dcOpenpit.CubeSize,+0.49*dcOpenpit.CubeSize,0.49*dcOpenpit.CubeSize);
    //
    FAnimator.LoadFromFile(ExtractFilePath(Application.ExeName));
    if FAnimator.SelectedResultItemIndex>-1 then
    begin
      FTrackBarMin  := FAnimator.MinTsec;
      FTrackBarMax  := FAnimator.MaxTsec;
      FTrackBarPos  := FAnimator.CurTsec;
      FTrackBarState:= tbsWaiting;
      TrackBarPaint;
    end;
    //
  finally
    Screen.Cursor := crDefault;
  end;

  CreateAuto(dcAuto);
  CreateExcavator(dcExcavator);
  FdTmsec := 0;
  actPlayerExecute(Sender);
  CreateViewItems;

end;
procedure TfmResultGraphView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyViewItems;
  Screen.Cursor := crHourGlass;
  FAnimator.Free;
  FAnimator := nil;
  FTrackBarBmp.Free;
  FTrackBarBmp := nil;
  FPunktsBmp.Free;
  FPunktsBmp := nil;
  Screen.Cursor := crDefault;
end;{FormClose}
procedure TfmResultGraphView.FormPaint(Sender: TObject);
begin
  TrackBarPaint;
end;{FormPaint}
procedure TfmResultGraphView.FormShow(Sender: TObject);
begin
  pbPunkts.Height := ScrollBox.ClientHeight;
end;{FormShow}

procedure TfmResultGraphView.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if GLCamera.DistanceToTarget>5.0
  then GLCamera.AdjustDistanceToTarget(Power(1.1, WheelDelta/120))
  else GLCamera.AdjustDistanceToTarget(Power(1.1, abs(WheelDelta/120)));
end;{FormMouseWheel}

procedure TfmResultGraphView.GLCadencerProgress(Sender: TObject; const deltaTime,
  newTime: Double);
var
  ANewMousePos : TPoint;
  IsOk: Boolean;
begin
  if Focused then
  begin
    //Azimut and Zenit
    if IsKeyDown(VK_LBUTTON) then
    begin
      GetCursorPos(ANewMousePos);
      if (ANewMousePos.X>pnParams.Width+5)and(ANewMousePos.Y>20) then
      begin
        if GLCamera.TargetObject=dcOpenpit
        then IsOk := GLCamera.Position.Y>GLCamera.TargetObject.Position.Y
        else IsOk := GLCamera.Position.Y>dcOpenpit.Position.Y+GLCamera.TargetObject.Position.Z;
        if IsOk then
        begin
          if FMousePos.X<>0
          then GLCamera.MoveAroundTarget((FMousePos.Y-ANewMousePos.Y)*0.5,
                                         (FMousePos.X-ANewMousePos.X)*0.5);
        end{if}
        else GLCamera.MoveAroundTarget(-1.0, -1.0);
        FMousePos := ANewMousePos;
      end;{if}
    end
    else FMousePos.X:=0;
    //
    if IsKeyDown('Q') then GLCamera.Position.Z := 100.0;
  end;{if}
  //Анимация
  if FTrackBarState=tbsPlay then
  begin
    Inc(FdTmsec);
    if FdTmsec>=1 then
    begin
      FTrackBarPos := FTrackBarPos+FTrackBarDelta;
      if FTrackBarPos>FTrackBarMax then
      begin
        FTrackBarPos := FTrackBarMax;
        FTrackBarState := tbsWaiting;
        tbPlay.Down := false;
      end;{if}
      FAnimator.CurTsec := FTrackBarPos;
      actPlayerExecute(Sender);
      TrackBarPaint;
      FdTmsec := 0;
    end;{if}
  end;{if}
  GLSceneViewer.Invalidate;
end;{GLCadencerProgress}
procedure TfmResultGraphView.TrackBarPaint;
var
  ABound: TRect;
  ATrackBarPos: Single;
  X,ALeft,ARight: Integer;
begin
  if FTrackBarBmp=nil then Exit;
  FTrackBarBmp.Width := pbTrackBar.Width;
  FTrackBarBmp.Height := pbTrackBar.Height;
  ALeft := 10;
  ARight := pbTrackBar.Width-10;
  ABound := Rect(0,0,FTrackBarBmp.Width,FTrackBarBmp.Height);
  with FTrackBarBmp.Canvas do
  begin
    Brush.Color := clBtnFace;
    Pen.Color := clBtnFace;
    Rectangle(ABound.Left,ABound.Top,ABound.Right,ABound.Bottom);
    //Edit
    Pen.Color := clDkGray;
    Polyline([Point(ALeft,16),Point(ALeft,3),Point(ARight-1,3)]);
    Pen.Color := clBlack;
    Polyline([Point(Aleft+1,15),Point(ALeft+1,4),Point(ARight-2,4)]);
    Pen.Color := clWhite;
    Polyline([Point(ALeft,17),Point(ARight-1,17),Point(ARight-1,2)]);
    Brush.Color := clWhite;
    Pen.Color := clWhite;
    Rectangle(ALeft+2,5,ARight-2,16);
    //Track
    ATrackBarPos := FTrackBarPos;
    if ATrackBarPos<FTrackBarMin then ATrackBarPos := FTrackBarMin;
    if ATrackBarPos>FTrackBarMax then ATrackBarPos := FTrackBarMax;
    X := Round(ALeft+(ARight-ALeft+1)*(ATrackBarPos-FTrackBarMin)/(FTrackBarMax-FTrackBarMin));
    Brush.Color := clBtnFace;
    Pen.Color := clBtnFace;
    Polygon([Point(X,21),Point(X-4,17),Point(X-4,2),Point(X+4,2),Point(X+4,17)]);
    Pen.Color := clWhite;
    Polyline([Point(X-1,20),Point(X-4,17),Point(X-4,2),Point(X+4,2)]);
    Pen.Color := clDkGray;
    Polyline([Point(X,20),Point(X+3,17),Point(X+3,3)]);
    Pen.Color := clBlack;
    Polyline([Point(X,21),Point(X+4,17),Point(X+4,1)]);
  end;{with}
  pbTrackBar.Canvas.Draw(0,0,FTrackBarBmp);
end;{TrackBarPaint}

procedure TfmResultGraphView.pbTrackBarPaint(Sender: TObject);
begin
  TrackBarPaint;
end;{pbTrackBarPaint}

procedure TfmResultGraphView.pbTrackBarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var ALeft,ARight: Integer;
begin
  if (Shift=[])and(Button=mbLeft) then
  begin
    ALeft := 10;
    ARight := pbTrackBar.Width-10;
    if FTrackBarState<>tbsNone then
    if (ARight-ALeft+1)<>0 then
    if Y in [3..17]then
    begin
      FTrackBarPos := (X-ALeft)*(FTrackBarMax-FTrackBarMin)/(ARight-ALeft+1)+FTrackBarMin;
      if FTrackBarPos<FTrackBarMin then FTrackBarPos := FTrackBarMin;
      if FTrackBarPos>FTrackBarMax then FTrackBarPos := FTrackBarMax;
      FAnimator.CurTsec := FTrackBarPos;
      actPlayerExecute(Sender);
      TrackBarPaint;
    end;{if}
  end;{if}
end;{pbTrackBarMouseUp}

procedure TfmResultGraphView.actPlayerExecute(Sender: TObject);
var IsEnabled: Boolean;
begin
  IsEnabled := FTrackBarState<>tbsNone;
  actPlayerPrior.Enabled := IsEnabled and (FTrackBarPos>FTrackBarMin);
  actPlayerPlay.Enabled := IsEnabled;
  actPlayerPause.Enabled := IsEnabled;
  actPlayerStop.Enabled := IsEnabled;
  actPlayerNext.Enabled := IsEnabled and (FTrackBarPos<FTrackBarMax);
  actPlayerPlay.Checked := FTrackBarState in [tbsPlay];
  actPlayerPause.Checked := FTrackBarState in [tbsPause];
  lbDt.Caption := FormatFloat('0.00', FAnimator.RemainingShiftTsec/60);
  lbStrippingCoef.Caption := FormatFloat('0.00',FAnimator.CurStrippingCoef);
  lbAutosCount.Caption := Format('%d/%d',[FAnimator.CurAutosCount,FAnimator.Openpit.Autos.Count]); 
  pbPunktsPaint(Sender);
end;{actPlayerExecute}
procedure TfmResultGraphView.actPlayerPriorExecute(Sender: TObject);
begin
  if FTrackBarState<>tbsNone then
  begin
    FTrackBarPos := FTrackBarPos-FTrackBarDelta;
    if FTrackBarPos<FTrackBarMin then FTrackBarPos := FTrackBarMin;
    FAnimator.CurTsec := FTrackBarPos;
    actPlayerExecute(Sender);
    TrackBarPaint;
  end;{if}
end;{actPlayerPriorExecute}
procedure TfmResultGraphView.actPlayerPlayExecute(Sender: TObject);
begin
  if FTrackBarState in [tbsPause,tbsWaiting] then
  begin
    if FTrackBarPos >= FTrackBarMax then FTrackBarPos := FTrackBarMin;
    FAnimator.CurTsec := FTrackBarPos;
    FdTmsec := 0;
    FTrackBarState := tbsPlay;
    actPlayerExecute(Sender);
  end;{if}
end;{actPlayerPlayExecute}
procedure TfmResultGraphView.actPlayerPauseExecute(Sender: TObject);
begin
  if FTrackBarState in [tbsPlay] then
  begin
    FdTmsec := 0;
    FTrackBarState := tbsPause;
    actPlayerExecute(Sender);
  end;{if}
end;{actPlayerPauseExecute}
procedure TfmResultGraphView.actPlayerStopExecute(Sender: TObject);
begin
  if FTrackBarState in [tbsPlay] then
  begin
    FTrackBarPos := FTrackBarMin;
    FAnimator.CurTsec := FTrackBarPos;
    FdTmsec := 0;
    FTrackBarState := tbsWaiting;
    actPlayerExecute(Sender);
    TrackBarPaint;
  end;{if}
end;{actPlayerStopExecute}
procedure TfmResultGraphView.actPlayerNextExecute(Sender: TObject);
begin
  if FTrackBarState<>tbsNone then
  begin
    FTrackBarPos := FTrackBarPos+FTrackBarDelta;
    if FTrackBarPos>FTrackBarMax then FTrackBarPos := FTrackBarMax;
    FAnimator.CurTsec := FTrackBarPos;
    actPlayerExecute(Sender);
    TrackBarPaint;
  end;{if}
end;{actPlayerNextExecute}
procedure TfmResultGraphView.actObjectViewExecute(Sender: TObject);
var S: String;
begin
  if Sender Is TMenuItem then
  begin
    TMenuItem(Sender).Checked := true;
    S := IntToStr(TMenuItem(Sender).Tag);
    if S='0' then S := '00';
    FActiveObject := StrToInt(Copy(S,2,Length(S)-1));
    case S[1] of
      '1': GLCamera.TargetObject := FAnimator.Openpit.Autos[FActiveObject].Contur;
      '2': GLCamera.TargetObject := FAnimator.Openpit.LoadingPunkts[FActiveObject].Contur;
      '3': GLCamera.TargetObject := FAnimator.Openpit.UnLoadingPunkts[FActiveObject].Contur;
      '4': GLCamera.TargetObject := FAnimator.Openpit.ShiftPunkts[FActiveObject].Contur;
      else GLCamera.TargetObject := dcOpenpit;
    end;{case}
  end;{if}
end;{actObjectViewExecute}
procedure TfmResultGraphView.CreateViewItems;
var
  AItem: TMenuItem;
  I: Integer;
begin
  AItem := TMenuItem.Create(nil);
  AItem.Caption := 'Карьер';
  AItem.OnClick := actObjectView.OnExecute;
  AItem.GroupIndex := 1;
  AItem.RadioItem := true;
  AItem.Tag := 0;
  AItem.Checked := true;
  pmiView.Add(AItem);

  AItem := TMenuItem.Create(nil);
  AItem.Caption := '-';
  pmiView.Add(AItem);

  for I := 0 to FAnimator.Openpit.Autos.Count-1 do
  begin
    AItem := TMenuItem.Create(nil);
    AItem.Caption := Format('%.2d. %s',[I+1,FAnimator.Openpit.Autos[I].Name]);
    AItem.OnClick := actObjectView.OnExecute;
    AItem.Tag := StrToInt('1'+IntToStr(I));
    AItem.GroupIndex := 1;
    AItem.RadioItem := true;
    pmiView.Add(AItem);
  end;{for}

  AItem := TMenuItem.Create(nil);
  AItem.Caption := '-';
  pmiView.Add(AItem);

  for I := 0 to FAnimator.Openpit.LoadingPunkts.Count-1 do
  begin
    AItem := TMenuItem.Create(nil);
    AItem.Caption := Format('%.2d. %s',[I+1,FAnimator.Openpit.LoadingPunkts[I].Name]);
    AItem.OnClick := actObjectView.OnExecute;
    AItem.Tag := StrToInt('2'+IntToStr(I));
    AItem.GroupIndex := 1;
    AItem.RadioItem := true;
    pmiView.Add(AItem);
  end;{for}

  AItem := TMenuItem.Create(nil);
  AItem.Caption := '-';
  pmiView.Add(AItem);

  for I := 0 to FAnimator.Openpit.UnLoadingPunkts.Count-1 do
  begin
    AItem := TMenuItem.Create(nil);
    AItem.Caption := Format('%.2d. %s',[I+1,FAnimator.Openpit.UnLoadingPunkts[I].Name]);
    AItem.OnClick := actObjectView.OnExecute;
    AItem.Tag := StrToInt('3'+IntToStr(I));
    AItem.GroupIndex := 1;
    AItem.RadioItem := true;
    pmiView.Add(AItem);
  end;{for}

  AItem := TMenuItem.Create(nil);
  AItem.Caption := '-';
  pmiView.Add(AItem);

  for I := 0 to FAnimator.Openpit.ShiftPunkts.Count-1 do
  begin
    AItem := TMenuItem.Create(nil);
    AItem.Caption := Format('%.2d. %s',[I+1,FAnimator.Openpit.ShiftPunkts[I].Name]);
    AItem.OnClick := actObjectView.OnExecute;
    AItem.Tag := StrToInt('4'+IntToStr(I));
    AItem.GroupIndex := 1;
    AItem.RadioItem := true;
    pmiView.Add(AItem);
  end;{for}
end;{CreateViewItems}

procedure TfmResultGraphView.DestroyViewItems;
var I: Integer;
begin
  for I := pmiView.Count-1 downto 0 do
    pmiView.Items[I].Free;
end;{DestroyViewItems}

procedure TfmResultGraphView.ScrollBoxResize(Sender: TObject);
begin
  pbPunkts.Width  := ScrollBox.ClientWidth-2;
end;{ScrollBoxResize}

procedure TfmResultGraphView.pbPunktsPaint(Sender: TObject);
var
  I,J,ATextHeight,ARow,AWidth,AHeight,w0,w1,w2: Integer;
  S: String;
begin
  if (FPunktsBmp=nil)OR(not pnParams.Visible) then Exit;
  AWidth := pbPunkts.Width;
  AHeight := pbPunkts.Height;
  FPunktsBmp.Width := AWidth;
  FPunktsBmp.Height := AHeight;
  with FPunktsBmp.Canvas do
  begin
    Pen.Color := clBtnFace;
    Brush.Color := clBtnFace;
    Font.Color := clBlack;
    Rectangle(0,0,FPunktsBmp.Width,FPunktsBmp.Height);
    Pen.Color := clBlack;
    try
      Font.Name := 'Courier New';
      ATextHeight := TextHeight('Сулеймен');
      ARow := 16;
      //LoadingPunkts
      Font.Style := [fsBold];
      TextOut(16,ARow+1,'I. Пункты погрузки');
      Font.Style := [];
      Inc(ARow,ATextHeight);
      with FAnimator.Openpit do
      begin
        w0 := TextWidth(' № ');
        w2 := TextWidth('10000.000');
        w1 := AWidth-w0-3*w2;
        for I := 0 to LoadingPunkts.Count-1 do
        begin
          //Параметры ПП
          S := LoadingPunkts[I].Name;
          case LoadingPunkts[I].State of
            psWorking : Font.Color := clBlue;
            psManeuver: Font.Color := clYellow;
            else Font.Color := clBlack;
          end;{case}
          TextOut(2,ARow+1,S);
          Font.Color := clBlack;
          Inc(ARow,ATextHeight);
          MoveTo(2,ARow); LineTo(AWidth-2,ARow);
          //Шапка ГМ
          S := '№';
          TextOut((w0-TextWidth(S))div 2,ARow+1,S);
          S := 'Горная масса';
          TextOut(w0+(w1-TextWidth(S))div 2,ARow+1,S);
          S := 'V, тыс.м3';
          TextOut(w0+w1+(w2-TextWidth(S))div 2,ARow+1,S);
          S := 'Q, тыс.т';
          TextOut(w0+w1+w2+(w2-TextWidth(S))div 2,ARow+1,S);
          S := 'A, %';
          TextOut(w0+w1+2*w2+(w2-TextWidth(S))div 2,ARow+1,S);
          MoveTo(w0,ARow); LineTo(w0,ARow+ATextHeight*(LoadingPunkts[I].Count+1));
          MoveTo(w0+w1,ARow); LineTo(w0+w1,ARow+ATextHeight*(LoadingPunkts[I].Count+1));
          MoveTo(w0+w1+1*w2,ARow); LineTo(w0+w1+1*w2,ARow+ATextHeight*(LoadingPunkts[I].Count+1));
          MoveTo(w0+w1+2*w2,ARow); LineTo(w0+w1+2*w2,ARow+ATextHeight*(LoadingPunkts[I].Count+1));

          Inc(ARow,ATextHeight);
          MoveTo(2,ARow); LineTo(AWidth-2,ARow);
          //Параметры ГМ
          for J := 0 to LoadingPunkts[I].Count-1 do
          begin
            if LoadingPunkts[I].Rocks[J].A>=100.0
            then Font.Color := clRed;
            TextOut(4,ARow+1,IntToStr(J+1));
            TextOut(w0+2,ARow+1,LoadingPunkts[I].Rocks[J].Name);
            S := FormatFloat('0.000',LoadingPunkts[I].Rocks[J].RockV1000m3);
            TextOut(AWidth-2*w2-TextWidth(S)-1,ARow+1,S);
            S := FormatFloat('0.000',LoadingPunkts[I].Rocks[J].RockQ1000tn);
            TextOut(AWidth-w2-TextWidth(S)-1,ARow+1,S);
            S := FormatFloat('0.00',LoadingPunkts[I].Rocks[J].A);
            TextOut(AWidth-TextWidth(S)-1,ARow+1,S);
            Font.Color := clBlack;
            Inc(ARow,ATextHeight);
          end;{for}
          MoveTo(2,ARow); LineTo(2,ARow-(LoadingPunkts[I].Count+1)*ATextHeight);
          MoveTo(AWidth-2,ARow); LineTo(AWidth-2,ARow-(LoadingPunkts[I].Count+1)*ATextHeight);
          MoveTo(2,ARow); LineTo(AWidth-2,ARow);
        end;{for}
      end;{if}
      Inc(ARow,ATextHeight);

      //UnLoadingPunkts
      Font.Style := [fsBold];
      TextOut(16,ARow+1,'II. Пункты разгрузки');
      Font.Style := [];
      Inc(ARow,ATextHeight);
      with FAnimator.Openpit do
      begin
        w0 := TextWidth(' № ');
        w2 := TextWidth('10000.000');
        w1 := AWidth-w0-3*w2;
        for I := 0 to UnLoadingPunkts.Count-1 do
        begin
          //Параметры ПП
          S := UnLoadingPunkts[I].Name;
          case UnLoadingPunkts[I].State of
            psWorking : Font.Color := clBlue;
            psManeuver: Font.Color := clYellow;
            else Font.Color := clBlack;
          end;{case}
          TextOut(2,ARow+1,S);
          Font.Color := clBlack;
          Inc(ARow,ATextHeight);
          MoveTo(2,ARow); LineTo(AWidth-2,ARow);
          //Шапка ГМ
          S := '№';
          TextOut((w0-TextWidth(S))div 2,ARow+1,S);
          S := 'Горная масса';
          TextOut(w0+(w1-TextWidth(S))div 2,ARow+1,S);
          S := 'V, тыс.м3';
          TextOut(w0+w1+(w2-TextWidth(S))div 2,ARow+1,S);
          S := 'Q, тыс.т';
          TextOut(w0+w1+w2+(w2-TextWidth(S))div 2,ARow+1,S);
          S := 'C, %';
          TextOut(w0+w1+2*w2+(w2-TextWidth(S))div 2,ARow+1,S);
          MoveTo(w0,ARow); LineTo(w0,ARow+ATextHeight*(UnLoadingPunkts[I].Count+1));
          MoveTo(w0+w1,ARow); LineTo(w0+w1,ARow+ATextHeight*(UnLoadingPunkts[I].Count+1));
          MoveTo(w0+w1+1*w2,ARow); LineTo(w0+w1+1*w2,ARow+ATextHeight*(UnLoadingPunkts[I].Count+1));
          MoveTo(w0+w1+2*w2,ARow); LineTo(w0+w1+2*w2,ARow+ATextHeight*(UnLoadingPunkts[I].Count+1));

          Inc(ARow,ATextHeight);
          MoveTo(2,ARow); LineTo(AWidth-2,ARow);
          Font.Color := clBlack;
          //Параметры ГМ
          for J := 0 to UnLoadingPunkts[I].Count-1 do
          begin
            TextOut(2,ARow+1,IntToStr(J+1));
            TextOut(w0+2,ARow+1,UnLoadingPunkts[I].Rocks[J].Name);
            S := FormatFloat('0.000',UnLoadingPunkts[I].Rocks[J].RockV1000m3);
            TextOut(AWidth-2*w2-TextWidth(S)-1,ARow+1,S);
            S := FormatFloat('0.000',UnLoadingPunkts[I].Rocks[J].RockQ1000tn);
            TextOut(AWidth-w2-TextWidth(S)-1,ARow+1,S);
            S := FormatFloat('0.00',UnLoadingPunkts[I].Rocks[J].Content);
            TextOut(AWidth-TextWidth(S)-1,ARow+1,S);
            Inc(ARow,ATextHeight);
          end;{for}
          MoveTo(2,ARow); LineTo(2,ARow-(UnLoadingPunkts[I].Count+1)*ATextHeight);
          MoveTo(AWidth-2,ARow); LineTo(AWidth-2,ARow-(UnLoadingPunkts[I].Count+1)*ATextHeight);
          MoveTo(2,ARow); LineTo(AWidth-2,ARow);
          Font.Color := clBlack;
        end;{for}
      end;{if}
      if ARow>pbPunkts.Height
      then pbPunkts.Height := ARow+ATextHeight;
    except
    end;{try}
    pbPunkts.Canvas.Draw(0,0,FPunktsBmp);
  end;{with}
end;{pbPunktsPaint}

procedure TfmResultGraphView.CreateAuto(var ADummyCube: TGLDummyCube);
var AInfo: RGLConturInfo;
begin
  AInfo.Contur := ADummyCube;
  AInfo.Count := 110;
  SetLength(AInfo.Points,AInfo.Count);
  with AInfo do
  begin
    Points[  0] := Point3D(0.00,0.00,0.68);
    Points[  1] := Point3D(0.00,0.00,0.42);
    Points[  2] := Point3D(0.03,0.00,0.64);
    Points[  3] := Point3D(0.03,0.00,0.40);
    Points[  4] := Point3D(0.08,0.00,0.72);
    Points[  5] := Point3D(0.09,0.00,0.67);
    Points[  6] := Point3D(0.11,0.00,0.67);
    Points[  7] := Point3D(0.11,0.00,0.35);
    Points[  8] := Point3D(0.14,0.00,0.81);
    Points[  9] := Point3D(0.14,0.00,0.72);
    Points[ 10] := Point3D(0.14,0.00,0.67);
    Points[ 11] := Point3D(0.14,0.00,0.33);
    Points[ 12] := Point3D(0.17,0.00,0.32);
    Points[ 13] := Point3D(0.17,0.00,0.16);
    Points[ 14] := Point3D(0.21,0.00,0.67);
    Points[ 15] := Point3D(0.21,0.00,0.32);
    Points[ 16] := Point3D(0.23,0.00,0.16);
    Points[ 17] := Point3D(0.23,0.00,0.67);
    Points[ 18] := Point3D(0.23,0.00,0.32);
    Points[ 19] := Point3D(0.23,0.00,0.92);
    Points[ 20] := Point3D(0.26,0.00,0.32);
    Points[ 21] := Point3D(0.26,0.00,0.23);
    Points[ 22] := Point3D(0.26,0.00,0.10);
    Points[ 23] := Point3D(0.26,0.00,0.00);
    Points[ 24] := Point3D(0.30,0.00,0.16);
    Points[ 25] := Point3D(0.31,0.00,0.67);
    Points[ 26] := Point3D(0.31,0.00,0.32);
    Points[ 27] := Point3D(0.32,0.00,0.30);
    Points[ 28] := Point3D(0.32,0.00,0.18);
    Points[ 29] := Point3D(0.33,0.00,0.96);
    Points[ 30] := Point3D(0.33,0.00,0.67);
    Points[ 31] := Point3D(0.33,0.00,0.32);
    Points[ 32] := Point3D(0.36,0.00,0.16);
    Points[ 33] := Point3D(0.42,0.00,0.67);
    Points[ 34] := Point3D(0.42,0.00,0.32);
    Points[ 35] := Point3D(0.44,0.00,0.67);
    Points[ 36] := Point3D(0.44,0.00,0.32);
    Points[ 37] := Point3D(0.44,0.00,0.96);
    Points[ 38] := Point3D(0.51,0.00,0.67);
    Points[ 39] := Point3D(0.51,0.00,0.32);
    Points[ 40] := Point3D(0.54,0.00,0.67);
    Points[ 41] := Point3D(0.54,0.00,0.32);
    Points[ 42] := Point3D(0.54,0.00,0.92);
    Points[ 43] := Point3D(0.62,0.00,0.67);
    Points[ 44] := Point3D(0.62,0.00,0.32);
    Points[ 45] := Point3D(0.64,0.00,0.81);
    Points[ 46] := Point3D(0.64,0.00,0.72);
    Points[ 47] := Point3D(0.64,0.00,0.67);
    Points[ 48] := Point3D(0.64,0.00,0.32);
    Points[ 49] := Point3D(0.67,0.00,0.72);
    Points[ 50] := Point3D(0.68,0.00,0.32);
    Points[ 51] := Point3D(0.69,0.00,0.16);
    Points[ 52] := Point3D(0.69,0.00,0.72);
    Points[ 53] := Point3D(0.70,0.00,0.99);
    Points[ 54] := Point3D(0.71,0.00,0.34);
    Points[ 55] := Point3D(0.71,0.00,0.89);
    Points[ 56] := Point3D(0.72,0.00,0.72);
    Points[ 57] := Point3D(0.72,0.00,0.67);
    Points[ 58] := Point3D(0.72,0.00,0.40);
    Points[ 59] := Point3D(0.73,0.00,0.93);
    Points[ 60] := Point3D(0.73,0.00,0.84);
    Points[ 61] := Point3D(0.73,0.00,0.50);
    Points[ 62] := Point3D(0.73,0.00,0.49);
    Points[ 63] := Point3D(0.73,0.00,0.45);
    Points[ 64] := Point3D(0.75,0.00,0.81);
    Points[ 65] := Point3D(0.75,0.00,0.69);
    Points[ 66] := Point3D(0.75,0.00,0.53);
    Points[ 67] := Point3D(0.75,0.00,0.45);
    Points[ 68] := Point3D(0.75,0.00,0.30);
    Points[ 69] := Point3D(0.75,0.00,0.25);
    Points[ 70] := Point3D(0.75,0.00,0.18);
    Points[ 71] := Point3D(0.75,0.00,0.16);
    Points[ 72] := Point3D(0.75,0.00,0.90);
    Points[ 73] := Point3D(0.75,0.00,0.95);
    Points[ 74] := Point3D(0.79,0.00,0.32);
    Points[ 75] := Point3D(0.79,0.00,0.23);
    Points[ 76] := Point3D(0.79,0.00,0.10);
    Points[ 77] := Point3D(0.79,0.00,0.00);
    Points[ 78] := Point3D(0.79,0.00,0.91);
    Points[ 79] := Point3D(0.82,0.00,0.81);
    Points[ 80] := Point3D(0.82,0.00,0.69);
    Points[ 81] := Point3D(0.82,0.00,0.53);
    Points[ 82] := Point3D(0.82,0.00,0.16);
    Points[ 83] := Point3D(0.85,0.00,0.81);
    Points[ 84] := Point3D(0.85,0.00,0.69);
    Points[ 85] := Point3D(0.86,0.00,0.27);
    Points[ 86] := Point3D(0.87,0.00,0.20);
    Points[ 87] := Point3D(0.88,0.00,0.16);
    Points[ 88] := Point3D(0.90,0.00,0.93);
    Points[ 89] := Point3D(0.90,0.00,0.90);
    Points[ 90] := Point3D(0.91,0.00,0.69);
    Points[ 91] := Point3D(0.93,0.00,0.97);
    Points[ 92] := Point3D(0.93,0.00,0.81);
    Points[ 93] := Point3D(0.93,0.00,0.72);
    Points[ 94] := Point3D(0.94,0.00,0.74);
    Points[ 95] := Point3D(0.94,0.00,0.74);
    Points[ 96] := Point3D(0.95,0.00,0.82);
    Points[ 97] := Point3D(0.95,0.00,0.85);
    Points[ 98] := Point3D(0.95,0.00,0.82);
    Points[ 99] := Point3D(0.97,0.00,0.45);
    Points[100] := Point3D(0.97,0.00,0.34);
    Points[101] := Point3D(0.97,0.00,0.19);
    Points[102] := Point3D(0.98,0.00,0.58);
    Points[103] := Point3D(0.98,0.00,0.50);
    Points[104] := Point3D(0.99,0.00,0.53);
    Points[105] := Point3D(0.99,0.00,0.49);
    Points[106] := Point3D(0.99,0.00,0.45);
    Points[107] := Point3D(0.99,0.00,0.25);
    Points[108] := Point3D(1.00,0.00,0.53);
    Points[109] := Point3D(1.00,0.00,0.34);
  end;{with}
  AInfo.Size := Point3D(10.1,5.42,5.0);
  AInfo.Contur.Position.SetPoint(0.0,0.0,0.0);
  AInfo.Contur.CubeSize := AInfo.Size.Z;
  AddCube(AInfo,27,28,70,68,0.2,0.8,0.2,0.2,0.2);//Рама
  AddCube(AInfo,67,69,107,106,0.2,0.8,0.2,0.2,0.2);//Основание кабины
  AddPolygon(AInfo,[62,63,99,100,109,108,104,105],0.1,0.9,0.7,0.7,0.2);//Основание кабины2
  AddPolygon(AInfo,[85,87,101,107],0.25,0.75,0.1,0.1,0.1);//Рама кабины

  AddPolygon(AInfo,[60,61,103,102,93,97,78,72],0.5,0.9,0.9,0.9,0.0);//Кабина
  AddCube(AInfo,64,65,80,79,0.49,0.91,0.1,0.1,0.1);//Окно
  AddPolygon(AInfo,[83,84,90,92],0.49,0.91,0.1,0.1,0.1);//Переднее окно
  AddPolygon(AInfo,[96,94,95,98],0.55,0.85,0.1,0.1,0.1);//Лобовое окно
  AddCube(AInfo,65,66,81,80,0.49,0.91,0.6,0.6,0.0);//Дверь
  AddCylinder(AInfo,13,23,32,20,0.8,0.95, 0.1,0.1,0.1);//Заднее колесо 1
  AddCylinder(AInfo,13,23,32,20,0.62,0.77, 0.1,0.1,0.1);//Заднее колесо 2
  AddCylinder(AInfo,13,23,32,20,0.05,0.2, 0.1,0.1,0.1);//Заднее колесо 3
  AddCylinder(AInfo,13,23,32,20,0.23,0.38, 0.1,0.1,0.1);//Заднее колесо 4
  AddCylinder(AInfo,16,22,24,21,0.04,0.96, 0.7,0.7,0.7);//Задняя ось
  AddCylinder(AInfo,51,77,87,74,0.8,0.95, 0.1,0.1,0.1);//Переднее колесо 1
  AddCylinder(AInfo,51,77,87,74,0.05,0.2, 0.1,0.1,0.1);//Переднее колесо 2
  AddCylinder(AInfo,71,76,82,75,0.04,0.96, 0.7,0.7,0.7);//Передняя ось
  AddPolygon(AInfo,[2,3,12,50,54,58,57,5],0.01,0.99,0.6,0.6,0.0);//Кузов
  AddPolygon(AInfo,[0,1,3,2,5,6,7,11,10,14,15,18,17,25,26,31,30,
                    33,34,36,35,38,39,41,40,43,44,48,47,57,56,52,
                    55,59,73,89,91,88,53,49,4],0.0,1.0,1.0,1.0,0.0);//Секции Кузова
  AddSpaceText(AInfo,0,1,-0.1,0.0,-90.0,-90.0,0.0,0.0,0.0,'01');
  AddSpaceText(AInfo,108,109,0.1,0.0,90.0,90.0,0.0,0.0,0.0,'01');
  AddPolygon(AInfo,[8,9,46,45,42,37,29,19],0.05,0.95,0.4,0.4,0.4,1);//Груз
  AInfo.Points := nil;
  AInfo.Count  := 0;
end;{CreateAuto}

procedure TfmResultGraphView.CreateExcavator(var ADummyCube: TGLDummyCube);
var AInfo: RGLConturInfo;
begin
  AInfo.Contur := ADummyCube;
  AInfo.Count := 77;
  SetLength(AInfo.Points,AInfo.Count);
  with AInfo do
  begin
    Points[ 0] := Point3D(0.01,0.00,0.92);
    Points[ 1] := Point3D(0.01,0.00,0.41);
    Points[ 2] := Point3D(0.01,0.00,0.35);
    Points[ 3] := Point3D(0.01,0.00,0.97);
    Points[ 4] := Point3D(0.01,0.00,0.38);
    Points[ 5] := Point3D(0.01,0.00,0.23);
    Points[ 6] := Point3D(0.01,0.00,0.11);
    Points[ 7] := Point3D(0.03,0.00,0.97);
    Points[ 8] := Point3D(0.03,0.00,0.38);
    Points[ 9] := Point3D(0.03,0.00,0.34);
    Points[10] := Point3D(0.03,0.00,0.28);
    Points[11] := Point3D(0.03,0.00,0.04);
    Points[12] := Point3D(0.04,0.00,0.99);
    Points[13] := Point3D(0.04,0.00,0.95);
    Points[14] := Point3D(0.04,0.00,0.92);
    Points[15] := Point3D(0.04,0.00,0.30);
    Points[16] := Point3D(0.04,0.00,0.46);
    Points[17] := Point3D(0.05,0.00,0.41);
    Points[18] := Point3D(0.06,0.00,0.76);
    Points[19] := Point3D(0.06,0.00,0.00);
    Points[20] := Point3D(0.07,0.00,0.62);
    Points[21] := Point3D(0.07,0.00,0.47);
    Points[22] := Point3D(0.08,0.00,0.80);
    Points[23] := Point3D(0.08,0.00,0.72);
    Points[24] := Point3D(0.08,0.00,0.41);
    Points[25] := Point3D(0.08,0.00,0.34);
    Points[26] := Point3D(0.10,0.00,0.76);
    Points[27] := Point3D(0.11,0.00,0.34);
    Points[28] := Point3D(0.11,0.00,0.14);
    Points[29] := Point3D(0.13,0.00,0.81);
    Points[30] := Point3D(0.13,0.00,0.74);
    Points[31] := Point3D(0.13,0.00,0.07);
    Points[32] := Point3D(0.16,0.00,0.04);
    Points[33] := Point3D(0.16,0.00,0.00);
    Points[34] := Point3D(0.36,0.00,0.85);
    Points[35] := Point3D(0.37,0.00,0.74);
    Points[36] := Point3D(0.38,0.00,0.89);
    Points[37] := Point3D(0.38,0.00,0.81);
    Points[38] := Point3D(0.39,0.00,0.97);
    Points[39] := Point3D(0.39,0.00,0.93);
    Points[40] := Point3D(0.40,0.00,0.85);
    Points[41] := Point3D(0.44,0.00,0.68);
    Points[42] := Point3D(0.46,0.00,0.68);
    Points[43] := Point3D(0.46,0.00,0.11);
    Points[44] := Point3D(0.51,0.00,0.22);
    Points[45] := Point3D(0.51,0.00,0.00);
    Points[46] := Point3D(0.56,0.00,0.11);
    Points[47] := Point3D(0.57,0.00,0.35);
    Points[48] := Point3D(0.57,0.00,0.32);
    Points[49] := Point3D(0.57,0.00,0.28);
    Points[50] := Point3D(0.59,0.00,0.62);
    Points[51] := Point3D(0.59,0.00,0.45);
    Points[52] := Point3D(0.59,0.00,0.35);
    Points[53] := Point3D(0.59,0.00,0.28);
    Points[54] := Point3D(0.59,0.00,0.59);
    Points[55] := Point3D(0.60,0.00,0.72);
    Points[56] := Point3D(0.61,0.00,0.70);
    Points[57] := Point3D(0.62,0.00,0.27);
    Points[58] := Point3D(0.62,0.00,0.23);
    Points[59] := Point3D(0.66,0.00,0.70);
    Points[60] := Point3D(0.66,0.00,0.55);
    Points[61] := Point3D(0.66,0.00,0.45);
    Points[62] := Point3D(0.66,0.00,0.28);
    Points[63] := Point3D(0.68,0.00,0.70);
    Points[64] := Point3D(0.68,0.00,0.55);
    Points[65] := Point3D(0.71,0.00,0.70);
    Points[66] := Point3D(0.71,0.00,0.55);
    Points[67] := Point3D(0.72,0.00,0.72);
    Points[68] := Point3D(0.72,0.00,0.55);
    Points[69] := Point3D(0.76,0.00,0.27);
    Points[70] := Point3D(0.76,0.00,0.23);
    Points[71] := Point3D(0.81,0.00,0.11);
    Points[72] := Point3D(0.86,0.00,0.22);
    Points[73] := Point3D(0.86,0.00,0.00);
    Points[74] := Point3D(0.91,0.00,0.11);
    Points[75] := Point3D(1.00,0.00,0.55);
    Points[76] := Point3D(1.00,0.00,0.28);
  end;{with}
  AInfo.Size := Point3D(10.1,5.42,5.0);
  AInfo.Contur.Position.SetPoint(0.0,0.0,0.0);
  AInfo.Contur.CubeSize := AInfo.Size.Z;
  AddCube(AInfo,44,45,73,72,0.1,0.9,0.2,0.2,0.2);     //Гусеницы 1
  AddCylinder(AInfo,43,45,46,44,0.1,0.9,0.2,0.2,0.2); //Гусеницы 2
  AddCylinder(AInfo,71,73,74,72,0.1,0.9,0.2,0.2,0.2); //Гусеницы 3
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
  AddSpaceText(AInfo,68,75,1.0,0.1,0.0,90.0,0.0,0.0,0.0,'01');
  AddSpaceText(AInfo,75,76,0.1,0.0,90.0,90.0,0.0,0.0,0.0,'01');
  AInfo.Points := nil;
  AInfo.Count  := 0;
end;{CreateExcavator}

procedure TfmResultGraphView.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['A','a'] then
  begin
    dcExcavator.Visible := false;
    dcAuto.Visible := not dcAuto.Visible;
  end;{if}
  if Key in ['E','e'] then
  begin
    dcAuto.Visible := false;
    dcExcavator.Visible := not dcExcavator.Visible;
  end;{if}
end;{FormKeyPress}

procedure TfmResultGraphView.actParamsVisibleExecute(Sender: TObject);
begin
  actParamsVisible.Checked := not actParamsVisible.Checked;
  pnParams.Visible := actParamsVisible.Checked;
end;{actParamsVisibleExecute}

end.
