unit unOpenpitView3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, GLCanvas, GLMisc, GLScene, GLCadencer, GLWin32Viewer,
  GLObjects,
  GLTexture, esaGLSceneOpenpitObjects; {GLCoordinates, GLCrossPlatform,
  BaseClasses;                        }

type
  TfmOpenpitView3D = class(TForm)
    GLScene: TGLScene;
    GLSceneViewer: TGLSceneViewer;
    GLCadencer: TGLCadencer;
    GLCamera: TGLCamera;
    dcOpenpit: TGLDummyCube;
    lcTopLeft: TGLLightSource;
    lcTopRight: TGLLightSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure GLCadencerProgress(Sender: TObject; const deltaTime, newTime: Double);
  private
    FMousePos: TPoint;
    FOpenpit: TResultOpenpit3D;//Карьер
  public
  end;

var
  fmOpenpitView3D: TfmOpenpitView3D;

//Диалоговое окно 3D
function esaShowOpenpitView3DDlg(const AHelpKeyword: String): Boolean;
implementation

uses unDM, Math, KeyBoard;

{$R *.dfm}

//Диалоговое окно 3D
function esaShowOpenpitView3DDlg(const AHelpKeyword: String): Boolean;
begin
  Screen.Cursor := crHourGlass;
  fmOpenpitView3D := TfmOpenpitView3D.Create(nil);
  try
    fmOpenpitView3D.HelpKeyword := AHelpKeyword;
    Screen.Cursor := crDefault;
    fmOpenpitView3D.ShowModal;
    Result := True;
  finally
    fmOpenpitView3D.Free;
  end;
end;

procedure TfmOpenpitView3D.FormCreate(Sender: TObject);
var Size,Center: RPoint3D;
begin
  FOpenpit := TResultOpenpit3D.Create(dcOpenpit,fmDM.ADOConnection);
  dcOpenpit.Position.Style := csPoint;
  GLCamera.Position.Style := csPoint;
  lcTopLeft.Position.Style := csPoint;
  lcTopRight.Position.Style := csPoint;
  FMousePos := Point(0,0);
  FOpenpit.LoadFromDB(fmDM.quOpenpitsId_Openpit.AsInteger);
  Size := Point3D(abs(FOpenpit.MaxPoint.X-FOpenpit.MinPoint.X),
                  abs(FOpenpit.MaxPoint.Y-FOpenpit.MinPoint.Y),
                  abs(FOpenpit.MaxPoint.Z-FOpenpit.MinPoint.Z));
  Center := FOpenpit.Center;
  //Размеры коорд. сетки
  dcOpenpit.CubeSize := Max(Size.X,Max(Size.Y,Size.Z));
  dcOpenpit.Position.SetPoint(Center.X,Center.Y,Center.Z);
  //Позиция, Глубина просмотра камеры
  GLCamera.Position.SetPoint(Center.X,Center.Y,Center.Z+2*dcOpenpit.CubeSize);
  GLCamera.DepthOfView := 50*dcOpenpit.CubeSize;
  //Позиция источника света
  lcTopLeft.Position.SetPoint(-0.49*dcOpenpit.CubeSize,-0.49*dcOpenpit.CubeSize,0.49*dcOpenpit.CubeSize);
  lcTopRight.Position.SetPoint(0.49*dcOpenpit.CubeSize,0.49*dcOpenpit.CubeSize,0.49*dcOpenpit.CubeSize);
end;

procedure TfmOpenpitView3D.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Screen.Cursor := crHourGlass;
  FOpenpit.Free;
  FOpenpit := nil;
  Screen.Cursor := crDefault;
end;

procedure TfmOpenpitView3D.FormShow(Sender: TObject);
begin
  Align := alClient;
end;
procedure TfmOpenpitView3D.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  if GLCamera.DistanceToTarget>5.0
  then GLCamera.AdjustDistanceToTarget(Power(1.1, WheelDelta/120))
  else GLCamera.AdjustDistanceToTarget(Power(1.1, abs(WheelDelta/120)));
end;

procedure TfmOpenpitView3D.GLCadencerProgress(Sender: TObject;
  const deltaTime, newTime: Double);
var ANewMousePos : TPoint;
begin
  if Focused then
  begin
    //Azimut and Zenit
    if IsKeyDown(VK_LBUTTON) then
    begin
      GetCursorPos(ANewMousePos);
      if ANewMousePos.Y>20 then
      begin
        if GLCamera.Position.Y>dcOpenpit.Position.Y then
        begin
          if FMousePos.X<>0
          then GLCamera.MoveAroundTarget((FMousePos.Y-ANewMousePos.Y)*0.5,
                                         (FMousePos.X-ANewMousePos.X)*0.5);
        end{if}
        else GLCamera.MoveAroundTarget(-1.0, (FMousePos.X-ANewMousePos.X)*0.5);
        FMousePos.X:=Screen.Width div 2;
        FMousePos.Y:=Screen.Height div 2;
        SetCursorPos(FMousePos.X, FMousePos.Y);
      end;{if}
    end
    else FMousePos.X:=0;
    if IsKeyDown(VK_ESCAPE)then Close;
  end;{if}
  GLSceneViewer.Invalidate;
end;{GLCadencerProgress}

end.
