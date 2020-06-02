unit unOpenpitTools;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Spin, DBCtrls, ColorGrd;

type
  TDisignerKind=(dkPoints,dkBlockMoving,dkBlockRoadDown,dkBlockManeuver,dkBlockCrossRoad,
                 dkCourses,dkPunktLoading,dkPunktUnLoading,dkPunktShift);
  RDisignerStyle=record
    Text: String;
    ItemIndex: Integer;
  end;
  
  TfmOpenpitTools = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btCancel: TButton;
    pcMain: TPageControl;
    tsDisigner: TTabSheet;
    grbDisignerGrid: TGroupBox;
    lbDisignerGridStep: TLabel;
    seDisignerGridStep: TSpinEdit;
    chbDisignerGridMarks: TCheckBox;
    pbDisignerGrid: TPaintBox;
    tsDefault: TTabSheet;
    gbDefaultPoints: TGroupBox;
    gbDefaultBlocks: TGroupBox;
    lbDefaultPointsZ: TLabel;
    edDefaultPointsZ: TEdit;
    lbDefaultBlocksStripCount: TLabel;
    edDefaultBlocksStripWidth: TEdit;
    lbDefaultBlocksStripWidth: TLabel;
    lbDefaultBlocksVmax0: TLabel;
    edDefaultBlocksVmax0: TEdit;
    cbDefaultBlocksType: TComboBox;
    lbDefaultBlocksType: TLabel;
    lbDefaultBlocksRoadCoat: TLabel;
    dblcbDefaultBlocksRoadCoat: TDBLookupComboBox;
    seDefaultBlocksStripCount: TSpinEdit;
    lbDisignerGridStyle: TLabel;
    cbDisignerGridStyle: TComboBox;
    gbDisigner: TGroupBox;
    lbDisignerRadius: TLabel;
    lbDisignerColor: TLabel;
    lsbDisigner: TListBox;
    seDisignerRadius: TSpinEdit;
    clbDisignerColor: TColorBox;
    rgDisignerStyle: TRadioGroup;
    btApply: TButton;
    gbDefaultLoadingPunkts: TGroupBox;
    dblcbDefaultLoadingPunktsRock: TDBLookupComboBox;
    lbDefaultLoadingPunktsRock: TLabel;
    edDefaultLoadingPunktsContent: TEdit;
    lbDefaultLoadingPunktsContent: TLabel;
    edDefaultLoadingPunktsPlannedV1000m3: TEdit;
    lbDefaultLoadingPunktsPlannedV1000m3: TLabel;
    gbDefaultUnLoadingPunkts: TGroupBox;
    lbDefaultUnLoadingPunktsMaxV1000m3: TLabel;
    edDefaultUnLoadingPunktsMaxV1000m3: TEdit;
    lbDefaultUnLoadingPunktsAutoMaxCount: TLabel;
    seDefaultUnLoadingPunktsAutoMaxCount: TSpinEdit;
    cbDefaultUnLoadingPunktsKind: TComboBox;
    lbDefaultUnLoadingPunktsKind: TLabel;
    edDefaultUnLoadingPunktsRequiredContent: TEdit;
    lbDefaultUnLoadingPunktsRequiredContent: TLabel;
    edDefaultUnLoadingPunktsInitialContent: TEdit;
    lbDefaultUnLoadingPunktsInitialContent: TLabel;
    edDefaultUnLoadingPunktsInitialV1000m3: TEdit;
    lbDefaultUnLoadingPunktsInitialV1000m3: TLabel;
    edDefaultBlocksVmax1: TEdit;
    lbDefaultBlocksVmax1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure seDisignerGridStepChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lsbDisignerClick(Sender: TObject);
    procedure lsbDisignerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbDisignerColorChange(Sender: TObject);
  private
    FBmp: TBitmap;
    FDisignerColors: array[TDisignerKind] of TColor;
    FDisignerRadiuses: array[TDisignerKind] of Integer;
    FDisignerStyles: array[TDisignerKind] of RDisignerStyle;
    FDisignerPoints: array[1..16] of TPoint;
    procedure DrawDisignerGrid;
    procedure DisignerInit;
    function GetDisignerKind: TDisignerKind;
    procedure SetDisignerKind(Value: TDisignerKind);
  public
    property DisignerKind: TDisignerKind read GetDisignerKind write SetDisignerKind;
  end;{TfmOpenpitTools}

var
  fmOpenpitTools: TfmOpenpitTools;

//Диалоговое окно настроек диалогового окна
function esaShowOpenpitToolsDlg(const AHelpKeyword: String): Boolean;
implementation

{$R *.dfm}
uses
  Math, unDM, Globals, Types, esaDBDefaultParams;

//Диалоговое окно настроек диалогового окна
function esaShowOpenpitToolsDlg(const AHelpKeyword: String): Boolean;
begin
  fmOpenpitTools := TfmOpenpitTools.Create(nil);
  try
    fmOpenpitTools.HelpKeyword := AHelpKeyword+'Points';
    Result := fmOpenpitTools.ShowModal=mrOk;
  finally
    fmOpenpitTools.Free;
  end;{try}
end;{esaShowOpenpitToolsDlg}

procedure TfmOpenpitTools.FormCreate(Sender: TObject);
begin
  with fmDM do
  begin
    quRocks.Open;
    quRoadCoats.Open;
  end;{with}
  FBmp := TBitmap.Create;
  cbDisignerGridStyle.ItemIndex := Integer(DefaultParams.CoordGridStyle);
  seDisignerGridStep.Value := DefaultParams.CoordGridStep;
  chbDisignerGridMarks.Checked := DefaultParams.CoordGridMarks;


  edDefaultPointsZ.Text := FormatFloat('0.000',DefaultParams.PointZ);

  seDefaultBlocksStripCount.Value := DefaultParams.BlockStripCount;
  edDefaultBlocksStripWidth.Text := FormatFloat('0.0',DefaultParams.BlockStripWidth);
  edDefaultBlocksVmax0.Text := FormatFloat('0.0',DefaultParams.BlockLoadingVmax);
  edDefaultBlocksVmax1.Text := FormatFloat('0.0',DefaultParams.BlockUnLoadingVmax);
  if not fmDM.quRoadCoats.Locate('Id_RoadCoat',DefaultParams.BlockId_RoadCoat,[])
  then DefaultParams.BlockId_RoadCoat := fmDM.quRoadCoatsId_RoadCoat.AsInteger;
  dblcbDefaultBlocksRoadCoat.KeyValue := fmDM.quRoadCoatsId_RoadCoat.AsInteger;
  dblcbDefaultBlocksRoadCoat.Enabled := fmDM.quRoadCoats.RecordCount>0;
  lbDefaultBlocksRoadCoat.Enabled := dblcbDefaultBlocksRoadCoat.Enabled;
  cbDefaultBlocksType.ItemIndex := Integer(DefaultParams.BlockKind);

  dblcbDefaultLoadingPunktsRock.KeyValue := fmDM.quRocksId_Rock.AsInteger;
  dblcbDefaultLoadingPunktsRock.Enabled := fmDM.quRocks.RecordCount>0;
  lbDefaultLoadingPunktsRock.Enabled := dblcbDefaultLoadingPunktsRock.Enabled;
  edDefaultLoadingPunktsContent.Text := FormatFloat('0.0',DefaultParams.LoadingPunktRockContent);
  edDefaultLoadingPunktsPlannedV1000m3.Text := FormatFloat('0.0',DefaultParams.LoadingPunktRockPlannedV1000m3);

  edDefaultUnLoadingPunktsMaxV1000m3.Text := FormatFloat('0.0',DefaultParams.UnLoadingPunktMaxV1000m3);
  seDefaultUnLoadingPunktsAutoMaxCount.Value := DefaultParams.UnLoadingPunktAutoMaxCount;
  cbDefaultUnLoadingPunktsKind.ItemIndex := Integer(DefaultParams.UnLoadingPunktKind);
  edDefaultUnLoadingPunktsRequiredContent.Text := FormatFloat('0.0',DefaultParams.UnLoadingPunktRockRequiredContent);
  edDefaultUnLoadingPunktsInitialContent.Text := FormatFloat('0.0',DefaultParams.UnLoadingPunktRockInitialContent);
  edDefaultUnLoadingPunktsInitialV1000m3.Text := FormatFloat('0.0',DefaultParams.UnLoadingPunktRockInitialV1000m3);

  DisignerInit;
  pcMain.ActivePageIndex := 0;
  btApply.Enabled := false;
end;{FormCreate}
procedure TfmOpenpitTools.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FBmp.Free;
  with fmDM do
  begin
    quRocks.Close;
    quRoadCoats.Close;
  end;{with}
end;{FormClose}
procedure TfmOpenpitTools.FormShow(Sender: TObject);
begin
  seDisignerGridStep.Tag := seDisignerGridStep.Value;
end;{FormShow}
procedure TfmOpenpitTools.FormPaint(Sender: TObject);
begin
  case pcMain.ActivePageIndex of
    1: begin
      DrawDisignerGrid;
    end;{tsDisigner}
  end;{case}
end;{FormPaint}

procedure TfmOpenpitTools.btOkClick(Sender: TObject);
begin
  if seDisignerGridStep.Text='' then raise Exception.Create('Не введено значение "Шаг координатной сетки, м"');
  if seDisignerRadius.Text='' then raise Exception.Create('Не введено значение "Радиус, pxl"');
  if seDefaultBlocksStripCount.Text='' then raise Exception.Create('Не введено значение "Количество полос движения"');
  
  if CheckEditValue(edDefaultPointsZ,CaptionToStr(lbDefaultPointsZ.Caption),'0.000',DefaultParams.PointZ,-MinSingle,MaxSingle)then
  if CheckEditValue(edDefaultBlocksStripWidth,CaptionToStr(lbDefaultBlocksStripWidth.Caption),'0.000',DefaultParams.BlockStripWidth,1.0,100.0)then
  if CheckEditValue(edDefaultBlocksVmax0,CaptionToStr(lbDefaultBlocksVmax0.Caption),'0.000',DefaultParams.BlockLoadingVmax,0.0,100.0)then
  if CheckEditValue(edDefaultBlocksVmax1,CaptionToStr(lbDefaultBlocksVmax1.Caption),'0.000',DefaultParams.BlockUnLoadingVmax,0.0,100.0)then
  if CheckEditValue(edDefaultLoadingPunktsContent,CaptionToStr(lbDefaultLoadingPunktsContent.Caption),'0.0',DefaultParams.LoadingPunktRockContent,1.0,100.0)then
  if CheckEditValue(edDefaultLoadingPunktsPlannedV1000m3,CaptionToStr(lbDefaultLoadingPunktsPlannedV1000m3.Caption),'0.0',DefaultParams.LoadingPunktRockPlannedV1000m3,1.0,High(Integer))then

  if CheckEditValue(edDefaultUnLoadingPunktsMaxV1000m3,CaptionToStr(lbDefaultUnLoadingPunktsMaxV1000m3.Caption),'0.0',DefaultParams.UnLoadingPunktMaxV1000m3,1.0,High(Integer))then
  if CheckEditValue(edDefaultUnLoadingPunktsRequiredContent,CaptionToStr(lbDefaultUnLoadingPunktsRequiredContent.Caption),'0.0',DefaultParams.UnLoadingPunktRockRequiredContent,1.0,100.0)then
  if CheckEditValue(edDefaultUnLoadingPunktsInitialContent,CaptionToStr(lbDefaultUnLoadingPunktsInitialContent.Caption),'0.0',DefaultParams.UnLoadingPunktRockInitialContent,0.0,100.0)then
  if CheckEditValue(edDefaultUnLoadingPunktsInitialV1000m3,CaptionToStr(lbDefaultUnLoadingPunktsInitialV1000m3.Caption),'0.0',DefaultParams.UnLoadingPunktRockInitialV1000m3,0.0,High(Integer))then
  begin
    DefaultParams.CoordGridStyle := TCoordGridStyle(cbDisignerGridStyle.ItemIndex);
    DefaultParams.CoordGridStep := seDisignerGridStep.Value;
    DefaultParams.CoordGridMarks := chbDisignerGridMarks.Checked;

    DefaultParams.PointColor     := FDisignerColors[dkPoints];
    DefaultParams.PointRadius    := FDisignerRadiuses[dkPoints]; 
    DefaultParams.PointMarkStyle := TPointMarkStyle(FDisignerStyles[dkPoints].ItemIndex);
    DefaultParams.PointZ         := StrToFloat(edDefaultPointsZ.Text);

    DefaultParams.BlockColors[bukMoving] := FDisignerColors[dkBlockMoving];
    DefaultParams.BlockColors[bukRoadDown] := FDisignerColors[dkBlockRoadDown];
    DefaultParams.BlockColors[bukManeuver] := FDisignerColors[dkBlockManeuver];
    DefaultParams.BlockColors[bukCrossRoad] := FDisignerColors[dkBlockCrossRoad];
    DefaultParams.BlockStyle := TBlockViewStyle(FDisignerStyles[dkBlockMoving].ItemIndex);

    DefaultParams.BlockStripCount := seDefaultBlocksStripCount.Value;
    DefaultParams.BlockStripWidth := StrToFloat(edDefaultBlocksStripWidth.Text);
    DefaultParams.BlockLoadingVmax:= StrToFloat(edDefaultBlocksVmax0.Text);
    DefaultParams.BlockUnLoadingVmax:= StrToFloat(edDefaultBlocksVmax1.Text);
    DefaultParams.BlockId_RoadCoat:= fmDM.quRoadCoatsId_RoadCoat.AsInteger;
    DefaultParams.BlockKind       := TBlockKind(cbDefaultBlocksType.ItemIndex);

    DefaultParams.CourseColor := FDisignerColors[dkCourses];
    DefaultParams.CourseStyle := TCourseViewStyle(FDisignerStyles[dkCourses].ItemIndex);

    DefaultParams.LoadingPunktRockContent    := StrToFloat(edDefaultLoadingPunktsContent.Text);
    DefaultParams.LoadingPunktRockPlannedV1000m3 := StrToFloat(edDefaultLoadingPunktsPlannedV1000m3.Text);
    DefaultParams.LoadingPunktColor  := FDisignerColors[dkPunktLoading];
    DefaultParams.LoadingPunktRadiusCoef := FDisignerRadiuses[dkPunktLoading];
    DefaultParams.LoadingPunktStyle  := TPunktViewStyle(FDisignerStyles[dkPunktLoading].ItemIndex);
    
    DefaultParams.UnLoadingPunktMaxV1000m3        := StrToFloat(edDefaultUnLoadingPunktsMaxV1000m3.Text);
    DefaultParams.UnLoadingPunktAutoMaxCount    := seDefaultUnLoadingPunktsAutoMaxCount.Value;
    DefaultParams.UnLoadingPunktKind            := TUnLoadingPunktKind(cbDefaultUnLoadingPunktsKind.ItemIndex);
    DefaultParams.UnLoadingPunktRockRequiredContent := StrToFloat(edDefaultUnLoadingPunktsRequiredContent.Text);
    DefaultParams.UnLoadingPunktRockInitialContent  := StrToFloat(edDefaultUnLoadingPunktsInitialContent.Text);
    DefaultParams.UnLoadingPunktRockInitialV1000m3    := StrToFloat(edDefaultUnLoadingPunktsInitialV1000m3.Text);
    DefaultParams.UnLoadingPunktColor  := FDisignerColors[dkPunktUnLoading];
    DefaultParams.UnLoadingPunktRadiusCoef := FDisignerRadiuses[dkPunktUnLoading];
    DefaultParams.UnLoadingPunktStyle  := TPunktViewStyle(FDisignerStyles[dkPunktUnLoading].ItemIndex);

    DefaultParams.ShiftPunktColor  := FDisignerColors[dkPunktShift];
    DefaultParams.ShiftPunktRadiusCoef := FDisignerRadiuses[dkPunktShift];
    DefaultParams.ShiftPunktStyle  := TPunktViewStyle(FDisignerStyles[dkPunktShift].ItemIndex);

    if Sender=btOk then ModalResult := mrOk
    else
    begin
      PostMessage(TForm(Owner).Handle,WM_PAINT,0,0);//?
      PostMessage(TForm(Owner).Handle,WM_SIZE,0,0);
      TButton(Sender).Enabled := false;
    end;{else}
  end;{if}
end;{btOkClick}

procedure TfmOpenpitTools.seDisignerGridStepChange(Sender: TObject);
begin
  if seDisignerGridStep.Text<>'' then
  begin
    seDisignerGridStep.Tag := seDisignerGridStep.Value;
    btApply.Enabled := true;
    DrawDisignerGrid;
  end;{if}
end;{seDisignerGridStepChange}

procedure TfmOpenpitTools.DrawDisignerGrid;
const
  AStep=15;
var
  ARect: TRect;
  I,J: Integer;
  ACountX,ACountY: Integer;
  ASmallStep: Integer;
  ATop: TPoint;
begin
  ARect := Rect(0,0,pbDisignerGrid.Width,pbDisignerGrid.Height);
  FBmp.Width := pbDisignerGrid.Width;
  FBmp.Height := pbDisignerGrid.Height;
  with FBmp.Canvas do
  begin
    Pen.Style := psSolid;
    Brush.Color := clBlack;
    Pen.Color := Brush.Color;
    Rectangle(ARect);
    ACountX := (ARect.Right-AStep-TextWidth('1000м.')) div AStep;
    ACountY := (ARect.Bottom-AStep) div AStep;
    Pen.Color := clDkGray;
    case cbDisignerGridStyle.ItemIndex of
      1,2: begin
        ASmallStep := AStep div 4;
        for I := 1 to ACountX do
          for J := 1 to ACountY do
          begin
            if cbDisignerGridStyle.ItemIndex=1
            then Pixels[I*AStep,J*AStep] := clWhite  //Point
            else
            begin//Cross
              MoveTo(I*AStep-ASmallStep,J*AStep); LineTo(I*AStep+ASmallStep,J*AStep);
              MoveTo(I*AStep,J*AStep-ASmallStep); LineTo(I*AStep,J*AStep+ASmallStep);
            end;{else}
          end;{for}
      end;{Point&Cross}
      3: begin
        for I := 1 to ACountX do
        begin
          MoveTo(I*AStep,1*AStep); LineTo(I*AStep,ACountY*AStep);
        end;{for}
        for J := 1 to ACountY do
        begin
          MoveTo(1*AStep,J*AStep); LineTo(ACountX*AStep,J*AStep);
        end;{for}
      end;{Grid}
    end;{case}
    if cbDisignerGridStyle.ItemIndex<>0 then
    begin
      if chbDisignerGridMarks.Checked then
      begin
        Brush.Color :=clDkGray;
        Pen.Color :=clDkGray;
        for I := 1 to ACountX do
          Rectangle(AStep*I,ACountY*AStep+5,AStep*I+AStep div 2, ACountY*AStep+5+AStep div 5);
        for J := 3 to ACountY do
          Rectangle(AStep*ACountX+5,J*AStep,AStep*ACountX+5+AStep div 2, J*AStep+AStep div 5);
      end;{if}
      Pen.Color := clRed;
      Brush.Color :=clBlack;
      Font.Color := Pen.Color;
      ATop.X := (1+ACountX)*AStep;
      ATop.Y := Round(AStep*1.5);
      MoveTo(ACountX*AStep,AStep);
      lineTo(ATop.X,ATop.Y);
      LineTo(ACountX*AStep,2*AStep);
      TextOut(ATop.X,ATop.Y-TextHeight('2')div 2,seDisignerGridStep.Text+'м');
    end;{if}
  end;{with}
  pbDisignerGrid.Canvas.Draw(0,0,FBmp);
end;{DrawDisignerGrid}
procedure TfmOpenpitTools.pcMainChange(Sender: TObject);
begin
  FormPaint(Sender);
end;{pcMainChange}
procedure TfmOpenpitTools.DisignerInit;
begin
  FDisignerColors[dkPoints] := DefaultParams.PointColor;
  FDisignerColors[dkBlockMoving] := DefaultParams.BlockColors[bukMoving];
  FDisignerColors[dkBlockRoadDown] := DefaultParams.BlockColors[bukRoadDown];
  FDisignerColors[dkBlockManeuver] := DefaultParams.BlockColors[bukManeuver];
  FDisignerColors[dkBlockCrossRoad] := DefaultParams.BlockColors[bukCrossRoad];
  FDisignerColors[dkCourses] := DefaultParams.CourseColor;
  FDisignerColors[dkPunktLoading] := DefaultParams.LoadingPunktColor;
  FDisignerColors[dkPunktUnLoading] := DefaultParams.UnLoadingPunktColor;
  FDisignerColors[dkPunktShift] := DefaultParams.ShiftPunktColor;
  FDisignerRadiuses[dkPoints] := DefaultParams.PointRadius;
  FDisignerRadiuses[dkPunktLoading] := DefaultParams.LoadingPunktRadiusCoef;
  FDisignerRadiuses[dkPunktUnLoading] := DefaultParams.UnLoadingPunktRadiusCoef;
  FDisignerRadiuses[dkPunktShift] := DefaultParams.ShiftPunktRadiusCoef;

  FDisignerStyles[dkPoints].Text := 'Нету'+#13#10+'Только Номер'+#13#10+'Только Координаты'+#13#10+'Номер и Координаты';
  FDisignerStyles[dkPoints].ItemIndex := Integer(DefaultParams.PointMarkStyle);
  FDisignerStyles[dkBlockMoving].Text := 'Ось дороги'+#13#10+'Реальная дорога';
  FDisignerStyles[dkBlockMoving].ItemIndex := Integer(DefaultParams.BlockStyle);
  FDisignerStyles[dkBlockRoadDown] := FDisignerStyles[dkBlockMoving];
  FDisignerStyles[dkBlockManeuver] := FDisignerStyles[dkBlockMoving];
  FDisignerStyles[dkBlockCrossRoad] := FDisignerStyles[dkBlockMoving];
  FDisignerStyles[dkCourses].Text := 'Нету'+#13#10+'Номера';
  FDisignerStyles[dkCourses].ItemIndex := Integer(DefaultParams.CourseStyle);

  FDisignerStyles[dkPunktLoading].Text := 'Нету'+#13#10+'Номера';
  FDisignerStyles[dkPunktLoading].ItemIndex := Integer(DefaultParams.LoadingPunktStyle);
  FDisignerStyles[dkPunktUnLoading].Text := FDisignerStyles[dkPunktLoading].Text;
  FDisignerStyles[dkPunktUnLoading].ItemIndex := Integer(DefaultParams.UnLoadingPunktStyle);
  FDisignerStyles[dkPunktShift].Text := FDisignerStyles[dkPunktLoading].Text;
  FDisignerStyles[dkPunktShift].ItemIndex := Integer(DefaultParams.ShiftPunktStyle);
  DisignerKind := dkPoints;

  FDisignerPoints[ 1] := Point( 14, 39);
  FDisignerPoints[ 2] := Point( 34, 35);
  FDisignerPoints[ 3] := Point( 68, 42);
  FDisignerPoints[ 4] := Point( 84, 49);
  FDisignerPoints[ 5] := Point(112, 62);
  FDisignerPoints[ 6] := Point(156, 70);
  FDisignerPoints[ 7] := Point(207, 77);
  FDisignerPoints[ 8] := Point(252, 73);
  FDisignerPoints[ 9] := Point(289, 58);
  FDisignerPoints[10] := Point(300, 29);
  FDisignerPoints[11] := Point(283, 13);
  FDisignerPoints[12] := Point(249, 13);
  FDisignerPoints[13] := Point(226, 31);
  FDisignerPoints[14] := Point( 46, 57);
  FDisignerPoints[15] := Point( 30, 71);
  FDisignerPoints[16] := Point( 20, 85);
end;{DisignerInit}
function TfmOpenpitTools.GetDisignerKind: TDisignerKind;
begin
  if lsbDisigner.ItemIndex=-1 then SetDisignerKind(dkPoints);
  Result := TDisignerKind(lsbDisigner.ItemIndex);
end;{GetDisignerKind}
procedure TfmOpenpitTools.SetDisignerKind(Value: TDisignerKind);
begin
  rgDisignerStyle.Tag := 1;
  lsbDisigner.ItemIndex := Integer(Value);
  clbDisignerColor.Selected := FDisignerColors[Value];
  clbDisignerColor.Tag := Integer(clbDisignerColor.Selected);
  seDisignerRadius.Value := FDisignerRadiuses[Value];
  rgDisignerStyle.Items.Text := FDisignerStyles[Value].Text;
  rgDisignerStyle.ItemIndex := FDisignerStyles[Value].ItemIndex;
  seDisignerRadius.Enabled := not(Value in [dkBlockMoving,dkBlockRoadDown,dkBlockManeuver,dkBlockCrossRoad,dkCourses]);
  lbDisignerRadius.Enabled := seDisignerRadius.Enabled;
  if Value in [dkPunktLoading,dkPunktUnLoading,dkPunktShift]
  then lbDisignerRadius.Caption := 'Радиу&с х.точек(pxl) *'
  else lbDisignerRadius.Caption := 'Радиу&с, pxl';
  rgDisignerStyle.Tag := 0;
end;{SetDisignerKind}

procedure TfmOpenpitTools.lsbDisignerClick(Sender: TObject);
begin
  if lsbDisigner.ItemIndex>-1
  then DisignerKind := TDisignerKind(lsbDisigner.ItemIndex)
  else DisignerKind := TDisignerKind(0);
end;{lsbDisignerClick}

procedure TfmOpenpitTools.lsbDisignerKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  lsbDisignerClick(Sender);
end;{lsbDisignerKeyDown}

procedure TfmOpenpitTools.clbDisignerColorChange(Sender: TObject);
begin
  if rgDisignerStyle.Tag>0 then Exit;
  if clbDisignerColor.Selected<>clBlack
  then clbDisignerColor.Tag := clbDisignerColor.Selected
  else
  begin
    esaMsgError('Использование черного цвета запрещено');
    clbDisignerColor.Selected := clbDisignerColor.Tag;
  end;{else}

  FDisignerColors[DisignerKind] := clbDisignerColor.Selected;
  if seDisignerRadius.Text<>''
  then FDisignerRadiuses[DisignerKind] := seDisignerRadius.Value;
  FDisignerStyles[DisignerKind].ItemIndex := rgDisignerStyle.ItemIndex;
  if DisignerKind in [dkBlockMoving,dkBlockRoadDown,dkBlockManeuver,dkBlockCrossRoad]then
  begin
    FDisignerStyles[dkBlockMoving].ItemIndex := rgDisignerStyle.ItemIndex;
    FDisignerStyles[dkBlockRoadDown].ItemIndex := rgDisignerStyle.ItemIndex;
    FDisignerStyles[dkBlockManeuver].ItemIndex := rgDisignerStyle.ItemIndex;
    FDisignerStyles[dkBlockCrossRoad].ItemIndex := rgDisignerStyle.ItemIndex;
  end;{if}
  btApply.Enabled := true;
end;{clbDisignerColorChange}
end.
