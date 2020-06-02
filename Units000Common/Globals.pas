unit Globals;

interface
uses Graphics, Types, StdCtrls, ADODb, DBGrids, ExtCtrls, Db, Grids, Forms, Classes,
     Controls, ComCtrls;
const
  SizeInteger=SizeOf(Integer);
  GradPerRad=180/Pi;

  hCell=18;
  CR = #13#10;
  //������������� �����
  clLtGrayEx    = 15790320; //RGB(240,240,240);
  clLightGrayEx = 13160660;
  clGrayEx      = 8421504;
  clDarkGrayEx  = 4210752;
  //������� ��� ������� Format
  EInvalidIndex   = '�������� �������� ������� %d. ���������� ��������: [0..%d].';
  EInvalidSingleValue='�������� ������������ �������� "%s" ��� ���� "%s".';
  EInvalidSingleValueEx='�������� ������������ �������� "%s" ��� ���� "%s". ���������� ��������: [%f..%f].';
  EInvalidIntegerValue='�������� ����� �������� "%s" ��� ���� "%s".';
  EInvalidIntegerValueEx='�������� ����� �������� "%s" ��� ���� "%s". ���������� ��������: [%d..%d].';

  EDeleteConfirm='��� �������� ������ ������ ����� �������� ��� ������, ��������� � ���.'+#13#10+'������� "%s"?';
  EDeleteAllConfirm='��� �������� ������� ����� �������� ��� ������, ��������� � ����.'+#13#10+'������� ��� ������?';
  EDefaultConfirm='���������� �������� ������ ������ ��� �������� �� ���������?';

  ESelectedPoint='�������� ����������� ����� �%d (X: %.3f; Y: %.3f; Z: %.3f).';
  ESelectedBlock='������� ����-������� �%d (���: %s; �����: %.3f �).';
  ESelectedLoadingPunkt='������� ����� �������� �%d (����������: "%s").';
  ESelectedUnLoadingPunkt='������� ����� ��������� �%d (���: "%s"; ����.���-�� ��������������: %d; ����� ����������� �������: %.1f).';
  ESelectedShiftPunkt='������� ����� ���������� �%d (X: %.3f; Y: %.3f; Z: %.3f).';
  ESelectedCourse='������� ������� �%d (���: %s; �����: %.3f �).';

  ESelectedPoints='�������� %d �����������(��) �����(��) (�� %s).';
  ESelectedPointsEx='�������� %d �����������(��) �����(��) (�� %s; �����: %.3f �).';
  ESelectedBlocks='�������� %d ����-�������(��) (�� %s).';
  ESelectedBlocksEx='�������� %d ����-�������(��) (�� %s; �����: %.3f �).';
  ESelectedLoadingPunkts='�������� %d ������(��) �������� (�� %s).';
  ESelectedUnLoadingPunkts='�������� %d ������(��) ��������� (�� %s).';
  ESelectedShiftPunkts='�������� %d ������(��) ���������� (�� %s).';
  ESelectedCourses='�������� �%d ��������(��) (�� %s).';

  EDuplicateObj='%s ''%s'' ��� ����������.';

  EEmptyOpenGL   = '�� ������ ����������� ���� OpenGL: OpenGL2D.';
  EEmptyPoints   = '�� ����� ������ ����������� �����.';
  EEmptyOpenpit  = '�� ����� ������ Openpit: TDBOpenpit.';
  EEmptyAutoEngines= '�� ��������� ������� "��������� ��������������".';
  EEmptyExcavatorEngines= '�� ��������� ������� "��������� ������������".';
  EEmptyExcavators= '�� ��������� ������� "������ ������������".';
  EEmptyAutos= '�� ��������� ������� "������ ��������������".';
  EEmptyRoadCoats= '�� ��������� ������� "���� ��������� ��������".';
  EEmptyRocks= '�� ��������� ������� "���� ������ ������".';
  EEmptyLoadingPunkts= '�� ��������� ������� "������ ��������".';
  EEmptyUnLoadingPunkts= '�� ��������� ������� "������ ���������".';
  EEmptyDeportExcavators= '�� ��������� ������� "����������� ���������� �����".';

  EDBParams='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Persist Security Info=False';
  EDBNotFound='�� ���� ������� ���� ������ "%s".';
  AutoCADColorTable:array [1..256] of TColor=(255,
       65535,   65280,16776960,16711680,16711935,16777215, 8421504,16777215,
         255, 8355839,     204, 6710988,     153, 5000345,     127, 4145023,
          76, 2500172,   16383, 8364031,   13260, 6717388,    9881, 5005209,
        8063, 4149119,    4940, 2502476,   32767, 8372223,   26316, 6724044,
       19609, 5010073,   16255, 4153215,    9804, 2505036,   49151, 8380415,
       39372, 6730444,   29337, 5014937,   24447, 4157311,   14668, 2507340,
       65535, 8388607,   52428, 6737100,   39321, 5020057,   32639, 4161407,
       19532, 2509900,   65471, 8388575,   52377, 6737074,   39282, 5020037,
       32607, 4161391,   19513, 2509890,   65407, 8388543,   52326, 6737049,
       39244, 5020018,   32575, 4161375,   19494, 2509881,   65343, 8388511,
       52275, 6737023,   39206, 5019999,   32543, 4161359,   19475, 2509871,
       65280, 8388479,   52224, 6736998,   39168, 5019980,   32512, 4161343,
       19456, 2509862, 4194048,10485631, 3394560, 8375398, 2529536, 6265164,
     2064128, 5209919, 1264640, 3099686, 8388352,12582783, 6736896,10079334,
     5019904, 7510348, 4161280, 6258495, 2509824, 3755046,12582656,14679935,
    10079232,11717734, 7510272, 8755532, 6258432, 7307071, 3755008, 4344870,
    16776960,16777087,13421568,13421670,10066176,10066252, 8355584, 8355647,
     5000192, 5000230,16760576,16768895,13408512,13415014,10056192,10061132,
     8347392, 8351551, 4995328, 4997670,16744192,16760703,13395456,13408614,
    10046464,10056268, 8339200, 8347455, 4990464, 4995366,16727808,16752511,
    13382400,13401958,10036736,10051404, 8331008, 8343359, 4985600, 4992806,
    16711680,16744319,13369344,13395558,10027008,10046540, 8323072, 8339263,
     4980736, 4990502,16711743,16744351,13369395,13395583,10027046,10046559,
     8323103, 8339279, 4980755, 4990511,16711807,16744383,13369446,13395609,
    10027084,10046578, 8323135, 8339295, 4980774, 4990521,16711871,16744415,
    13369497,13395634,10027122,10046597, 8323167, 8339311, 4980793, 4990530,
    16711935,16744447,13369548,13395660,10027161,10046617, 8323199, 8339327,
     4980812, 4990540,12517631,14647295,10027212,11691724, 7471257, 8735897,
     6226047, 7290751, 3735628, 4335180, 8323327,12550143, 6684876,10053324,
     4980889, 7490713, 4128895, 6242175, 2490444, 3745356, 4129023,10452991,
     3342540, 8349388, 2490521, 6245529, 2031743, 5193599, 1245260, 3089996,
     3355443, 5987163, 8684676,11382189,14079702,16777215,16777215);
type
  //����������� ����
  //Loading  - ��������          : apManeuverFromLP,apGruzh,apManeuverToUP,apUP
  //UnLoading- ������������      : apManeuverFromUP,apPorozh,apManeuverToLP,apLP
  //dFromSP  - ����� � ���       : apSP,apManeuverFromSP,apFromSP,apManeuverToLPFromSP,apLPFromSP
  //dToSP    - ����������� �� ���: apManeuverToSPFromUP,apToSP,apManeuverToSP
  TAutoDirection=(adLoading,adUnLoading,adFromSP,adToSP,adUnknown);
  //��������� ���� - ��������: ����;�������� ���;����������;�������;������;��������� ���������;���������
  TAutoState=(asMovingFk,asMovingHh,asMovingBt,asWaiting,asAbort,asUnWorked,asDone);
  //��������� ����
  TAutoPosition=(apNone,apManeuverFromPunkt0,apToPunkt1,apManeuverToPunkt1,apOnPunkt1);
  RAutoDirPosState=record
    Direction: TAutoDirection;
    Position : TAutoPosition;
    State    : TAutoState;
  end;
  TAutoDirectionArr=array[TAutoDirection]of Single;

  //��������� ������ ��������/���������
  TPunktState=(psWorking,psManeuver,psWaiting);
  //��� ������ ���������
  TUnLoadingPunktKind=(ulpkFactory,ulpkStorage,ulpkSpoil);

  TAutoTransmissionKind=(atkGM,atkEM);
  TAutosFuelCostTarif=(afctWinter,afctSummer,afctAverage);
  TAutoWorkRegime=(awrQualityAveraging,awrEqualDistrubation);

  TCoordGridStyle = (cgsNone,cgsPoint,cgsCross,cgsGrid);
  TPointMarkStyle = (pmsNone,pmsNumber,pmsCoord,pmsBoth);
  TBlockViewStyle     = (bvsNone,bvsReal);
  TPunktViewStyle     = (pvsNone,pvsNumber);
  TCourseViewStyle    = (cvsNone,cvsNumber);

  TBlockKind=(bukMoving,bukRoadDown,bukManeuver,bukCrossRoad);
//  TUnLoadingPunktKind=(ulpkFactory,ulpkStorage,ulpkSpoil);
  TEmptyEvent = procedure of object;
  TPointsArray=array of TPoint;
  RPoint3D=record
    X,Y,Z: Single;
  end;
  PPoint3D=^RPoint3D;
  RPointExpansion=record
    isOneLane: boolean;
  end;
  RPoint3DExt=record
    X,Y,Z: Single;
    Exp: RPointExpansion;
  end;
  PPoint3DExt=^RPoint3DExt;
  TPoints3DArray=array of RPoint3D;
  ROpenpitPoint3D=record
    Id_Point: Integer;
    Coords: RPoint3D;
  end;
  POpenpitPoint3D=^ROpenpitPoint3D;
  RCoursePoint3D=record
    Position: RPoint3D;
    Length: Single;
  end;
  RBound3D=record
    MinX,MaxX,MinY,MaxY,MinZ,MaxZ: Single;
  end;
const
  SizePoint3D=SizeOf(RPoint3D);
type
  TPiecesCrossedResult=(pcrNotCrossed,pcrParallel,pcrCrossed,pcrTotalTop);

//I. ��������� ��� ������������ ����� ---------------------------------------------------------
//�������� ���������� ����� 3D � ��� RPoint3D
function Point3D(const X,Y,Z: Single): RPoint3D;
//�������� �������� ������� 3D � ��� RBound3D
function Bound3D(const MinX,MaxX,MinY,MaxY,MinZ,MaxZ: Single): RBound3D;

//II. ��������� ��� OpenGL --------------------------------------------------------------------
//�������� TColor � RGB � ������������ ���� � OpenGL
procedure glSetColor(const Color: TColor);
//������� ������
procedure ClearList(var AList: TList);

//III. ��������� ������ ��������� -------------------------------------------------------------
//��������� �� ������
procedure esaMsgError(Msg: string); overload;
procedure esaMsgError(const AFormat: String; const AArgs: array of const); overload;
//��������� ������������� Yes/No
function esaMsgQuestionYN(Msg: string): boolean;
//��������� ������������� Yes/No/Cancel
function esaMsgQuestionYNC(Msg: string): integer;
//��������� �� ����������
procedure esaMsgInformatin(Msg: string);

//IV. ��������� ��� ����� ��������� �������� --------------------------------------------------
//���� ���������� �������� 
function InputName(const ACaption,APrompt: string;
                   var AValue: string;
                   const AMaxLength: Word;
                   const AAllowBlank: boolean = false): boolean;
//���� ���������� �������� � ���� ������� ��
function InputNameEx(const ACaption,APrompt,AFieldName: string;
                     const AQuery: TADOQuery;
                     var AValue: String;
                     const AAllowBlank: boolean = false): boolean;

//V. ��������� ��� ������ � ��������������� ���������������� ----------------------------------
//���������� ������������� ������ ������� � ��������� ��������� � �������
procedure GetBound3DAroundPiece(const APoint0, APoint1: RPoint3D;
                                const AWidth: Single;
                                var   ALeftTop,ARightTop,ARightBottom,ALeftBottom: RPoint3D);
//��������� ������������� ������ ������� � ��������� ��������� � �������� �������
//    Top0---------------------------Top1
//    Point0-------------------------Point1
//    Top3---------------------------Top2
procedure GetBoundAroundPiece(const Point0,Point1: RPoint3D;
                              const ADistance: Single;
                              var   Top0,Top1,Top2,Top3: RPoint3D);
//���������� ����������� ���� ������ (APoint0-APoint1)�(Point2-APoint3)
function CrossingPoint(const APoint0,APoint1,APoint2,APoint3: RPoint3D): RPoint3D;
//�������� ����� � �������?
function PtInPgn(const APoint: RPoint3D; const Pgn: Array of RPoint3D): Boolean;
//������� ����� ������ �� ��������� ������ �� �������� ����������
function GetRightPoint(const Point,Top0,Top1: RPoint3D; const Distance: Single): RPoint3D;
//���������� ����(� ��������) �/� ������ (XOY-XY)� ���� OX
function AngleByOXInGrad(const X,Y: Single): Single;
//���������� ����(� ��������) �/� ������ (XOY-XY)� ���� OX
function AngleByOXInRad(const X,Y: Single): Single;
//��������� ����������� �������� (x0,y0)-(x1,y1) � (x2,y2)-(x3,y3)
function ArePiecesCrossed(var   APoint: RPoint3D;
                          const APoint0,APoint1,APoint2,APoint3: RPoint3D;
                          const Accuracy: Single): TPiecesCrossedResult;


//VI. ��������� ��������� ���������, ��������� �������� ---------------------------------------
//������ ���������� �������� (2,) �� ������ (1,2,3,2,4,45,..)
procedure DeleteDuplicateValues(var S: String);
//�������� FloatToStr  � �������� �������
function FormatFloatEx(const Format: string; Value: Single): String;
//�������� ������� String � Float � ������ DecimalSeparator
function StrToFloatEx(Value: string): Single;
//����������� ����� AutoCAD 2004 DXF
function ConvertAutoCADText(const Text: String): String;
//�������� ������ ���������� �� Caption
function CaptionToStr(ACaption: string): string;

//VII. ��������� ��� ������ � ��������� �� ----------------------------------------------------
//�������� ��� �������� �� ���������� ��������� � ������� ��
function CanCloseModifiedQuery(var Query: TADOQuery; Name: string): boolean;

//VIII. ��������� ��� ������ � TDBGrid --------------------------------------------------------
//���������� AutoWidth � ������� ������� � �������� ��������
procedure FitColumnByIndex(var Grid: TDBGrid; const Index: Integer);
//������ Right's �������� Grid'� � �������� � ������ �� ������
procedure UpdateColumnRights(const AGrid: TDBGrid; var AColWidths: TIntegerDynArray);
//������������ ������ Grid'�
procedure DrawGridCell(ACanvas: TCanvas;ALeft,ATop,ARight,ABottom: Integer; Captions: array of string);
//������������ ����� Grid'�
procedure DrawGridTitle(var APaintBox: TPaintBox; var AGrid: TDBGrid;
                        const AMaxRowCount: Integer; AColWidths: TIntegerDynArray);
//������������ ������ DBGrid'�
procedure DrawDBGridColumnCell(var ADBGrid: TDBGrid;
                               const Rect: TRect;
                               const DataCol: Integer;
                               const Column: TColumn;
                               const State: TGridDrawState);
//����� ������� ��� Boolean ���� DBGrid'a
procedure DrawDBGridTick(const ACanvas: TCanvas; const ARect: TRect; const AValue: Boolean);

//IX. ��������� ������������ �������� ����� ������ �� ��������� ��������� ---------------------
//�������� �������� FloatField'a: Field.AsFloat > AMin
function IsFloatFieldMoreMin(AField: TField; const AMin: Single): Boolean;
//�������� �������� FloatField'a: Field.AsFloat >= AMin
function IsFloatFieldMoreEqualMin(AField: TField; const AMin: Single): Boolean;
//�������� �������� FloatField'a: Field.AsFloat in [AMin,AMax]  � ��������� 0.1
function IsFloatFieldInRange1(AField: TField; const AMin,AMax: Single): Boolean;
//�������� �������� FloatField'a: Field.AsFloat in [AMin,AMax]  � ��������� 0.01
function IsFloatFieldInRange2(AField: TField; const AMin,AMax: Single): Boolean;
//�������� �������� FloatField'a: Field.AsFloat in [AMin,AMax]  � ��������� 0.001
function IsFloatFieldInRange3(AField: TField; const AMin,AMax: Single): Boolean;
//�������� �������� IntegerField'a: Field.AsInteger > AMin
function IsIntegerFieldMoreMin(AField: TField; const AMin: Integer): Boolean;
//�������� �������� IntegerField'a: Field.AsInteger >= AMin
function IsIntegerFieldMoreEqualMin(AField: TField; const AMin: Integer): Boolean;
//�������� �������� IntegerField'a: Field.AsInteger in [AMin,AMax]  
function IsIntegerFieldInRange(AField: TField; const AMin,AMax: Integer): Boolean;

//X. ��������� ������������ �������� �����(� ��������� �������) ��������� ��������� -----------
//�������� ������������ ����� �������� �����(� ��������� �������) ��������� ���������
function CheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Integer;
                       const AIsBlankAllowed: Boolean): Boolean;overload;
//�������� ������������ ������������ �������� �����(� ��������� �������) ��������� ���������
function CheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Single;
                       const AIsBlankAllowed: Boolean): Boolean;overload;

//XI. ��������� ������������ �������� ����� TEdit'� ��������� ��������� -----------------------
//�������� ������������ ������������ �������� ���� TEdit ��������� ���������
function CheckEditValue(var AEdit: TEdit;
                        APrompt,AMask: String;
                        ADefault,AMin,AMax: Single): Boolean;overload;
//�������� ������������ ����� �������� ���� TEdit ��������� ���������
function CheckEditValue(var AEdit: TEdit;
                        APrompt: String;
                        ADefault,AMin,AMax: Integer): Boolean;overload;

//XIII. ��������� ��������� �������� ������� ������ -------------------------------------------
//�������� ������������ ����� ������.����� �� OnKeyPress
procedure CheckFloatValueOnKeyPress(const Text: String; var Key: Char);
//�������� ������������ ����� ������ ����� �� OnKeyPress
procedure CheckIntValueOnKeyPress(var Key: Char);

//XIV. ��������� �������� ����������� ---------------------------------------------------------
//������ ���������� ����
function CreateDialogForm(const ACaption: String; const AWidth,AHeight: Integer): TForm;
//������������ �������� � LabeledEdit
procedure SetLabeledEditProperties(var ALabeledEdit: TLabeledEdit;
                                   const AParent: TWinControl;
                                   const APrompt,AText: String;
                                   const ALeft,ATop,AWidth: Integer;
                                   const AMaxLength: Integer;
                                   const AAnchors: TAnchors);
//������������ �������� � TButton
procedure SetButtonProperties(const AButton: TButton;
                              const AParent: TWinControl;
                              const APosition: TPoint;
                              const ACaption: String;
                              const ADefault,ACancel: Boolean;
                              const AModalResult: TModalResult);
//������������ �������� � TLabel
procedure SetLabelProperties(const ALabel: TLabel;
                             const AParent: TWinControl;
                             const APosition: TPoint;
                             const ACaption: String);
//������ ProgressBar
function CreateProgressBar(const AOwner : TComponent;
                           const AParent: TWinControl;
                           const APosition: TPoint;
                           const AWidth: Integer): TProgressBar;
//XV ��������� "������-������" ----------------------------------------------------------------
//������ �� ���������� ��������� ��� ��������� ��������� ����� (Result*.ESA)
procedure DeleteResultFiles;

implementation
uses Windows, SysUtils, Math, OpenGL, Variants;

//I. ��������� ��� ������������ ����� ---------------------------------------------------------
//�������� ���������� ����� 3D � ��� RPoint3D
function Point3D(const X,Y,Z: Single): RPoint3D;
begin
  Result.X := RoundTo(X,-3);
  Result.Y := RoundTo(Y,-3);
  Result.Z := RoundTo(Z,-3);
end;{Point3D}
//�������� �������� ������� 3D � ��� RBound3D
function Bound3D(const MinX,MaxX,MinY,MaxY,MinZ,MaxZ: Single): RBound3D;
begin
  Result.MinX := RoundTo(MinX,-3);
  Result.MinY := RoundTo(MinY,-3);
  Result.MinZ := RoundTo(MinZ,-3);
  Result.MaxX := RoundTo(MaxX,-3);
  Result.MaxY := RoundTo(MaxY,-3);
  Result.MaxZ := RoundTo(MaxZ,-3);
end;{Bound3D}

//II. ��������� ��� OpenGL --------------------------------------------------------------------
//�������� TColor � RGB � ������������ ���� � OpenGL
procedure glSetColor(const Color: TColor);
var R,G,B: byte;
begin
  R := Color;
  G := Color shr 8;
  B := Color shr 16;
  glColor(R,G,B);
end;{glSetColor}
//������� ������
procedure ClearList(var AList: TList);
var I: Integer;
begin
  if AList<>nil then
  begin
    for I := AList.Count-1 downto 0 do
    begin
      if AList[I]<>nil then Dispose(AList[I]);
      AList[I] := nil;
    end;{for}
    AList.Clear;
  end;{if}
end;{ClearList}

//III. ��������� ������ ��������� -------------------------------------------------------------
//��������� �� ������
procedure esaMsgError(Msg: string);
begin
  Beep;
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'.')then Msg := Msg+'.';
  Application.MessageBox(PChar(Msg),'������',MB_ICONERROR);
end;{esaMsgError}
procedure esaMsgError(const AFormat: String; const AArgs: array of const);
begin
  esaMsgError(Format(AFormat,AArgs));
end;{esaMsgError}
//��������� ������������� Yes/No
function esaMsgQuestionYN(Msg: string): Boolean;
begin
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'?')then Msg := Msg+'?';
  Result := Application.MessageBox(PChar(Msg),'�������������',
                                   MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2)=IDYES;
end;{esaMsgQuestionYN}
//��������� ������������� Yes/No/Cancel
function esaMsgQuestionYNC(Msg: string): integer;
begin
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'?')then Msg := Msg+'?';
  Result := Application.MessageBox(PChar(Msg),'�������������',MB_ICONQUESTION+MB_YESNOCANCEL+MB_DEFBUTTON1);
end;{esaMsgQuestionYNC}
//��������� �� ����������
procedure esaMsgInformatin(Msg: string);
begin
  SysUtils.Beep;
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'.')then Msg := Msg+'.';
  Application.MessageBox(PChar(Msg),'����������',MB_ICONINFORMATION);
end;{esaMsgInformatin}

//IV. ��������� ��� ����� ��������� �������� --------------------------------------------------
//���� ���������� �������� 
function InputName(const ACaption,APrompt: string;
                   var AValue: string;
                   const AMaxLength: Word;
                   const AAllowBlank: boolean = false): boolean;
var
  fmDlg: TForm;
  ledName: TLabeledEdit;
  btOk,btCancel: TButton;
begin
  AValue := Trim(AValue);
  if (AMaxLength>0)and(Length(AValue)>AMaxLength) then SetLength(AValue,AMaxLength);
  fmDlg := CreateDialogForm(ACaption,400,128);
  try
    ledName := TLabeledEdit.Create(fmDlg);
    SetLabeledEditProperties(ledName,fmDlg,APrompt,AValue,16,24,368,AMaxLength,[akLeft,akTop,akRight]);
    btOk := TButton.Create(fmDlg);
    SetButtonProperties(btOk,fmDlg,Point(224,64),'Ok',true,false,mrOk);
    btCancel := TButton.Create(fmDlg);
    SetButtonProperties(btCancel,fmDlg,Point(304,64),'������',false,true,mrCancel);
    repeat
      Result := fmDlg.ShowModal=mrOk;
      ledName.Text := Trim(ledName.Text);
      if (not AAllowBlank)and(ledName.Text='')and Result
      then esaMsgError('�� ������� �������� "'+APrompt+'".');
    until ((not AAllowBlank)and(ledName.Text<>''))OR AAllowBlank OR (not Result);
    AValue := ledName.Text;
    if (AMaxLength>0)and(Length(AValue)>AMaxLength) then SetLength(AValue,AMaxLength);
  finally
    fmDlg.Free;
  end;{try}
end;{InputName}
//���� ���������� �������� � ���� ������� ��
function InputNameEx(const ACaption,APrompt,AFieldName: string;
                     const AQuery: TADOQuery;
                     var AValue: String;
                     const AAllowBlank: boolean = false): boolean;
var
  fmDlg: TForm;
  cbName: TComboBox;
  btOk,btCancel: TButton;
  lbName: TLabel;
begin
  fmDlg := CreateDialogForm(ACaption,400,128);
  try
    lbName := TLabel.Create(fmDlg);
    SetLabelProperties(lbName,fmDlg,Point(16,8),APrompt);
    cbName := TComboBox.Create(fmDlg);
    with cbName do
    begin
      Parent := fmDlg; Left := 16; Top := 24; Width := 368;
      Anchors := [akLeft,akTop,akRight];
      Style := csDropDownList;
      if AAllowBlank then cbName.Items.Add('');
      AQuery.First;
      while not AQuery.Eof do
      begin
        cbName.Items.Add(AQuery.FieldByName(AFieldName).AsString);
        AQuery.Next;
      end;{while}
      if cbName.Items.Count>0 then cbName.ItemIndex := cbName.Items.IndexOf(AValue);
      if cbName.ItemIndex=-1 then cbName.ItemIndex := 0;
    end;{with}
    btOk := TButton.Create(fmDlg);
    SetButtonProperties(btOk,fmDlg,Point(224,64),'Ok',true,false,mrOk);
    btCancel := TButton.Create(fmDlg);
    SetButtonProperties(btCancel,fmDlg,Point(304,64),'������',false,true,mrCancel);
    Result := fmDlg.ShowModal=mrOk;
    if Result then AValue := cbName.Text;
  finally
    fmDlg.Free;
  end;{try}
end;{InputNameEx}

//V. ��������� ��� ������ � ��������������� ���������������� ----------------------------------
//���������� ������������� ������ ������� � ��������� ��������� � �������
procedure GetBound3DAroundPiece(const APoint0, APoint1: RPoint3D;
                                const AWidth: Single;
                                var   ALeftTop,ARightTop,ARightBottom,ALeftBottom: RPoint3D);
var ALength,Xc,Yc,Alfa,ACos,ASin: Single;
begin
  ALength := sqrt(sqr(APoint0.X-APoint1.X)+sqr(APoint0.Y-APoint1.Y));
  ALeftTop  := APoint0; ALeftBottom  := APoint0;
  ARightTop := APoint1; ARightBottom := APoint1;
  //ALeftTop, ALeftBottom
  Xc := APoint0.X+(APoint1.X-APoint0.X)*AWidth/ALength;
  Yc := APoint0.Y+(APoint1.Y-APoint0.Y)*AWidth/ALength;
  Alfa := Pi*0.5;
  ACos := cos(Alfa); ASin := sin(Alfa);
  ALeftTop.X := RoundTo(APoint0.X + (Xc-APoint0.X)*ACos+(Yc-APoint0.Y)*ASin,-3);
  ALeftTop.Y := RoundTo(APoint0.Y - (Xc-APoint0.X)*ASin+(Yc-APoint0.Y)*ACos,-3);
  ALeftTop.Z := RoundTo(APoint0.Z,-3);
  ALeftBottom.X := RoundTo(APoint0.X + (Xc-APoint0.X)*ACos+(Yc-APoint0.Y)*(-ASin),-3);
  ALeftBottom.Y := RoundTo(APoint0.Y - (Xc-APoint0.X)*(-ASin)+(Yc-APoint0.Y)*ACos,-3);
  ALeftBottom.Z := RoundTo(APoint0.Z,-3);
  //ARightTop, ARightBottom
  Xc := APoint0.X+(APoint1.X-APoint0.X)*(AWidth+ALength)/ALength;
  Yc := APoint0.Y+(APoint1.Y-APoint0.Y)*(AWidth+ALength)/ALength;
  ARightTop.X := RoundTo(APoint1.X + (Xc-APoint1.X)*ACos+(Yc-APoint1.Y)*ASin,-3);
  ARightTop.Y := RoundTo(APoint1.Y - (Xc-APoint1.X)*ASin+(Yc-APoint1.Y)*ACos,-3);
  ARightTop.Z := RoundTo(APoint1.Z,-3);
  ARightBottom.X := RoundTo(APoint1.X + (Xc-APoint1.X)*ACos+(Yc-APoint1.Y)*(-ASin),-3);
  ARightBottom.Y := RoundTo(APoint1.Y - (Xc-APoint1.X)*(-ASin)+(Yc-APoint1.Y)*ACos,-3);
  ARightBottom.Z := RoundTo(APoint1.Z,-3);
end;{GetBound3DAroundPiece}
//��������� ������������� ������ ������� � ��������� ��������� � �������� �������
//    Top0---------------------------Top1
//    Point0-------------------------Point1
//    Top3---------------------------Top2
procedure GetBoundAroundPiece(const Point0,Point1: RPoint3D;
                              const ADistance: Single;
                              var   Top0,Top1,Top2,Top3: RPoint3D);
var ALength,ARatio0,ARatio1,Xc,Yc,Alfa,ACos,ASin: Single;
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
//���������� ����������� ���� ������ (APoint0-APoint1)�(Point2-APoint3)
function CrossingPoint(const APoint0,APoint1,APoint2,APoint3: RPoint3D): RPoint3D;
var A1,B1,C1,A2,B2,C2: Single;
begin
  //1.������ ����-�� ���� ������
  A1 := APoint1.Y-APoint0.Y;
  B1 := -APoint1.X+APoint0.X;
  C1 := -APoint0.X*APoint1.Y+APoint0.Y*APoint1.X;
  A2 := APoint3.Y-APoint2.Y;
  B2 := -APoint3.X+APoint2.X;
  C2 := -APoint2.X*APoint3.Y+APoint2.Y*APoint3.X;
  if IsZero(A1*B2-A2*B1,0.001) then
  begin                    //�����������
    Result.X := (APoint1.X+APoint2.X)*0.5;
    Result.Y := (APoint1.Y+APoint2.Y)*0.5;
  end{if}
  else
  begin                    //�� �����������
    Result.X := (B1*C2-B2*C1)/(A1*B2-A2*B1);
    Result.Y := (C1*A2-C2*A1)/(A1*B2-A2*B1);
  end;{else}
end;{CrossingPoint}
//�������� ����� � �������?
function PtInPgn(const APoint: RPoint3D; const Pgn: Array of RPoint3D): Boolean;
type
  TSign=-1..1;
  function GetSign(Point,Point0,Point1: RPoint3D): TSign;
  var A,B,C,ABC: Single;
  begin
    Result := 0;
    A := Point1.Y-Point0.Y;
    B := -Point1.X+Point0.X;
    C := -Point0.X*Point1.Y+Point0.Y*Point1.X;
    ABC := A*Point.X+B*Point.Y+C;
    if ABC>0.0 then Result := 1;
    if ABC<0.0 then Result := -1;
  end;{GetSign}
var
  I,Ind0,Ind1: Integer;
  APoint0,APoint1: RPoint3D;
  ASign,ASign0: -1..1;
begin
  Result := false;
  Ind0 := Low(Pgn); Ind1 := High(Pgn);
  if Ind1-Ind0<0 then Exit;
  //1.������ ����-�� ���� ������
  ASign := 0;
  Result := true;
  for I := Ind0+1 to Ind1+1 do
  begin
    APoint0 := Pgn[I-1];
    if I=Ind1+1 then APoint1 := Pgn[0] else APoint1 := Pgn[I];
    ASign0 := GetSign(APoint,APoint0,Apoint1);
    if (ASign=0)and(ASign0<>0)then ASign := ASign0;
    if (ASign<>0)and(ASign0<>0)then
    if ASign<>ASign0 then
    begin
      Result := false; Break;
    end;{if}
  end;{for}
end;{PtInPgn}
//������� ����� ������ �� ��������� ������ �� �������� ����������
function GetRightPoint(const Point,Top0,Top1: RPoint3D; const Distance: Single): RPoint3D;
const Alfa=Pi*0.5;
var
  ALength,ARatio,Xc,Yc,ACos,ASin: Single;
  Point0,Point1: RPoint3D;
begin
  Result := Point;
  ALength := sqrt(sqr(Top1.X-Top0.X)+sqr(Top1.Y-Top0.Y));
  if ALength>0.0 then
  begin
    ACos := cos(Pi*0.5); ASin := sin(Pi*0.5);
    ARatio := Distance/ALength;
    Xc := Top0.X+(Top1.X-Top0.X)*ARatio;
    Yc := Top0.Y+(Top1.Y-Top0.Y)*ARatio;
    Point0.X := Top0.X + (Xc-Top0.X)*ACos+(Yc-Top0.Y)*ASin;//Top0
    Point0.Y := Top0.Y - (Xc-Top0.X)*ASin+(Yc-Top0.Y)*ACos;
    Point0.Z := Top0.Z;
    ARatio := (Distance+ALength)/ALength;
    Xc := Top0.X+(Top1.X-Top0.X)*ARatio;
    Yc := Top0.Y+(Top1.Y-Top0.Y)*ARatio;
    Point1.X := Top1.X + (Xc-Top1.X)*ACos+(Yc-Top1.Y)*ASin;
    Point1.Y := Top1.Y - (Xc-Top1.X)*ASin+(Yc-Top1.Y)*ACos;
    Point1.Z := Top1.Z;
    ARatio := sqrt(sqr(Point.X-Top0.X)+sqr(Point.Y-Top0.Y))/ALength;
    Result.X := Point0.X+(Point1.X-Point0.X)*ARatio;
    Result.Y := Point0.Y+(Point1.Y-Point0.Y)*ARatio;
    Result.Z := Point0.Z+(Point1.Z-Point0.Z)*ARatio;
  end;{if}
end;{GetRightPoint}
//��������� ����������� �������� (x0,y0)-(x1,y1) � (x2,y2)-(x3,y3)
//��� x0,y0,x1,y1 - ����-�� ������� �������
//    x2,y2,x3,y3 - ����-�� ������� �������
//    Accuracy    - ��������� �������� ����������: 10, 100, 1000...
//���������:
//    pcrNotCrossed - �� ������������
//    pcrParallel   - �����������
//    pcrCrossed    - ������������
//    pcrTotalTop   - ������� �� ����� �����
//    X,Y         - ����-�� ����� �����������

//�������:
  //1. ������ �.����������� ������ A1*X+B1*Y+C1=0 � A2*X+B2*Y+C2=0
  //           |B1 C1|          |C1 A1|
  //           |B2 C2|          |C2 A2|
  //       X = -------      Y = -------
  //           |A1 B1|          |A1 B1|
  //           |A2 B2|          |A2 B2|

  //      |A1 B1|
  //����  |A2 B2| = 0, �� ������ �����������      X=-1 Y=-1 Result=2
  //����� ��������, �� �������������� (X,Y) ���������� [X0,Y0]�[X1,Y1]
  //                                  (X,Y) ���������� [X2,Y2]�[X3,Y3]
function ArePiecesCrossed(var   APoint: RPoint3D;
                          const APoint0,APoint1,APoint2,APoint3: RPoint3D;
                          const Accuracy: Single): TPiecesCrossedResult;
  //true: X ����� ����� [A,B]���[B,A]
  function IsBetween(X,A,B: Single): boolean;
  begin
    Result := ((A<=B)and(A<=X)and(X<=B))OR((A>B)and(B<=X)and(X<=A));
  end;{IsBetween}
var A1,B1,C1,A2,B2,C2,D: Single;
begin
  APoint.Z:= (APoint1.Z + APoint2.Z) * 0.5;
  //1.������ ����-�� ���� ������
  A1:= APoint1.Y - APoint0.Y;
  B1:= -APoint1.X + APoint0.X;
  C1:= -APoint0.X * APoint1.Y + APoint0.Y * APoint1.X;
  A2:= APoint3.Y - APoint2.Y;
  B2:= -APoint3.X + APoint2.X;
  C2:= -APoint2.X * APoint3.Y + APoint2.Y * APoint3.X;
  D:= A1 * B2 - A2 * B1;
  if abs(D)<=Accuracy then
  begin                    //�����������
    Result:= pcrParallel;
    APoint.X := -1.0;
    APoint.Y := -1.0;
  end{if}
  else
  begin                    //�� �����������
    APoint.X := (B1 * C2 - B2 * C1)/D;
    APoint.Y := (C1 * A2 - C2 * A1)/D;
    if IsBetween(APoint.X, APoint0.X, APoint1.X)and
       IsBetween(APoint.X, APoint2.X, APoint3.X)and
       IsBetween(APoint.Y, APoint0.Y, APoint1.Y)and
       IsBetween(APoint.Y, APoint2.Y, APoint3.Y)
    then Result := pcrCrossed       //������������
    else Result := pcrNotCrossed;   //�� ������������
  end;{else}
  if Result=pcrCrossed then
  if ((abs(APoint.X-APoint0.X)<=Accuracy)and(abs(APoint.Y-APoint0.Y)<=Accuracy))OR
     ((abs(APoint.X-APoint1.X)<=Accuracy)and(abs(APoint.Y-APoint1.Y)<=Accuracy))OR
     ((abs(APoint.X-APoint2.X)<=Accuracy)and(abs(APoint.Y-APoint2.Y)<=Accuracy))OR
     ((abs(APoint.X-APoint3.X)<=Accuracy)and(abs(APoint.Y-APoint3.Y)<=Accuracy))
  then Result := pcrTotalTop;
end;{ArePiecesCrossed}
//���������� ����(� ��������) �/� ������ (XOY-XY)� ���� OX
function AngleByOXInGrad(const X,Y: Single): Single;
begin
  Result := 0;
  if (X=0)and(Y=0)then Result := 0.0;                            // ����� XOY
  if (X>0)and(Y=0)then Result := 0.0;                            // ��� ��
  if (X>0)and(Y>0)then Result := 180*Arctan(abs(Y/X))/Pi;        // I   ��������
  if (X=0)and(Y>0)then Result := 90.0;                           // ��� �Y
  if (X<0)and(Y>0)then Result := 180-180*(Arctan(abs(Y/X)))/Pi;  // II  ��������
  if (X<0)and(Y=0)then Result := 180.0;                          // ��� -OX
  if (X=0)and(Y<0)then Result := 270.0;                          // ��� -OY
  if (X<0)and(Y<0)then Result := 180.0+180.0*(Arctan(abs(Y/X)))/Pi;// III ��������
  if (X>0)and(Y<0)then Result := 360-180*(Arctan(abs(Y/X)))/Pi;  // IV  ��������
end;{ AngleByOXInGrad}
//���������� ����(� ��������) �/� ������ (XOY-XY)� ���� OX
function AngleByOXInRad(const X,Y: Single): Single;
begin
  Result := Pi/180.0*AngleByOXInGrad(X,Y);
end;{ AngleByOXInRad}

//VI. ��������� ��������� ���������, ��������� �������� ---------------------------------------
//������ ���������� �������� (2,) �� ������ (1,2,3,2,4,45,..)
procedure DeleteDuplicateValues(var S: String);
var
  NewS,Value: String;
  AIndex: Integer;
begin
  NewS := ''; S := S+','; AIndex := Pos(',',S);
  while AIndex>0 do
  begin
    Value := Copy(S,1,AIndex);
    System.Delete(S,1,AIndex);
    if Pos(','+Value,','+NewS)=0 then NewS := NewS+Value;
    AIndex := Pos(',',S);
  end;{while}
  S := Copy(NewS,1,Length(NewS)-1);
end;{DeleteDuplicateValues}
//�������� FloatToStr  � �������� �������
function FormatFloatEx(const Format: string; Value: Single): String;
var I,J: Integer;
begin
  Result := FormatFloat(Format,Value);
  J := 0;
  for I := Pos(DecimalSeparator,Result)-1 downto 1 do
  begin
    Inc(J);
    if J mod 3 = 0
    then Insert(' ',Result,I);
  end;{for}
end;{FormatFloatEx}
//�������� ������� String � Float � ������ DecimalSeparator
function StrToFloatEx(Value: string): Single;
var I: Integer;
begin
  Value := Trim(Value);
  if Value='' then Value := '0';
  for I := 1 to Length(Value) do
    if Value[I] in [',','.'] then Value[I] := DecimalSeparator;
  try
    Result := StrToFloat(Value);
  except
    Result := 0.0;
  end;{try}
end;{StrToFloatEx}
//����������� ����� AutoCAD 2004 DXF
function ConvertAutoCADText(const Text: String): String;
var
  Ind0,Ind1,Ind2: Integer;
  S,AText: String;
begin
  Result := '';
  try
    AText := Trim(Text);
    //������ ��� �������� ������
    while Pos('{',AText)<>0 do
      Delete(AText,Pos('{',AText),1);
    while Pos('}',AText)<>0 do
      Delete(AText,Pos('}',AText),1);
    repeat
      //������ ����� ������� ���������� ������� Return � Font
      Ind0 := Pos('\P',AText);
      Ind1 := Pos('\f',AText);
      if Ind0=1 then
      begin
        Result := Result+#13;
        Delete(AText,Ind0,2);
      end{if}
      else
      if Ind1=1 then Delete(AText,Ind1,2);
      if AText<>'' then
      begin
        //������ ����� �������� ��������� Ind2
        Ind0 := Pos('\P',AText);
        Ind1 := Pos('\f',AText);
        if (Ind0>0)OR(Ind1>0)then
        begin
          if Ind0>0 then Ind2 := Ind0 else Ind2 := Ind1;
          if (Ind0>0)and(Ind1>0)and(Ind1<Ind2) then Ind2 := Ind1;
          S := Copy(AText,1,Ind2-1);
          Delete(AText,1,Ind2-1);
        end{if}
        else
        begin
          S := AText; AText := '';
        end;{else}
        while Pos('|',S)<>0 do
          Delete(S,1,Pos('|',S));
        while Pos('\',S)<>0 do
          Delete(S,1,Pos('\',S));
        while Pos(';',S)<>0 do
          Delete(S,1,Pos(';',S));
        Result := Result+S;
      end;{if}
    until AText='';
  except
    Result := '?';
    esaMsgError(Format('������ ����������� ������ "%s" ������� AutoCAD 2004 DXF.'+#13+
                    '����� ��� ������� �� "?".',[Text]));
  end;{try}
end;{ConvertAutoCADText}
//�������� ������ ���������� �� Caption
function CaptionToStr(ACaption: string): string;
begin
  while Pos('&',ACaption)>0 do
    System.Delete(ACaption,Pos('&',ACaption),1);
  Result := ACaption;
end;{CaptionToStr}

//VII. ��������� ��� ������ � ��������� �� ----------------------------------------------------
//�������� ��� �������� �� ���������� ��������� � ������� ��
function CanCloseModifiedQuery(var Query: TADOQuery; Name: string): boolean;
begin
  Result := true;
  if Query.Active and(Query.State in [dsEdit,dsInsert])then
  case esaMsgQuestionYNC('��������� ��������� � ������� '''+Name+'''?')of
    IDYES: Query.Post;
    IDNO : Query.Cancel;
    IDCANCEL : Result := false;
  end;{case}
end;{CanCloseModifiedQuery}

//VIII. ��������� ��� ������ � TDBGrid --------------------------------------------------------
//���������� AutoWidth � ������� ������� � �������� ��������
procedure FitColumnByIndex(var Grid: TDBGrid; const Index: Integer);
var I,AutoWidth: Integer;
begin
  with Grid do
  begin
    AutoWidth := 0;
    for I := 0 to Columns.Count-1 do
      if I<>Index
      then AutoWidth := AutoWidth+Columns[I].Width;
    Columns[Index].Width := Grid.ClientRect.Right-AutoWidth-Columns.Count-20;
  end;{with}
end;{FitColumnByIndex}
//������ Right's �������� Grid'� � �������� � ������ �� ������
procedure UpdateColumnRights(const AGrid: TDBGrid; var AColWidths: TIntegerDynArray);
var I: Integer;
begin
  with AGrid do
  begin
    if Columns.Count=0 then Exit;
    AColWidths[0] := (2+12)+Columns[0].Width;
    for I := 1 to Columns.Count-1 do
      AColWidths[I] := (AColWidths[I-1]+1)+Columns[I].Width;
  end;{with}
end;{UpdateColumnRights}
procedure DrawGridCell(ACanvas: TCanvas;ALeft,ATop,ARight,ABottom: Integer; Captions: array of string);
var
  ATextTop,ATextHeight,ACount,I: Integer;
begin
  with ACanvas do
  if ALeft<ARight then
  begin
    Pen.Color := clDkGray;
    MoveTo(ALeft,ABottom); LineTo(ARight,ABottom); LineTo(ARight,ATop);
    Pen.Color := clWhite;
    MoveTo(ALeft,ABottom); LineTo(ALeft,ATop);     LineTo(ARight,ATop);
    ACount := High(Captions)-Low(Captions)+1;
    if ACount>0 then
    begin
      ATextHeight := TextHeight('S');
      ATextTop := ATop+(((ABottom-ATop+1)-ACount*ATextHeight-(ACount-1)*5)div 2);
      for I := 0 to ACount-1 do
        TextOut((ARight+ALeft-TextWidth(Captions[I]))div 2,
                ATextTop+I*(ATextHeight+5),
                Captions[I]);
    end;{if}
  end;{with}
end;{DrawGridCell}
procedure DrawGridTitle(var APaintBox: TPaintBox; var AGrid: TDBGrid;
                       const AMaxRowCount: Integer; AColWidths: TIntegerDynArray);
var
  Cvs: TCanvas;
  I: Integer;
  ASize: TPoint;
begin
  Cvs := APaintBox.Canvas;
  with Cvs do
  begin
    ASize := Point(APaintBox.Width-3,APaintBox.Height);
    Pen.Color := clBtnFace;
    Brush.Color := clBtnFace;
    Rectangle(0,0,APaintBox.Width,APaintBox.Height);
    Pen.Color := clDkGray;
    MoveTo(0,ASize.Y);
    LineTo(0,0);
    LineTo(ASize.X,0);
    LineTo(ASize.X,ASize.Y);
    with AGrid do
    begin
      //���������
      DrawGridCell(Cvs,2,1,13,AMaxRowCount*hCell,[]);
      //������ ���������
      with Columns[Columns.Count-1] do
        DrawGridCell(Cvs,AColWidths[Columns.Count-1]+1,1,Grid.Width-3,AMaxRowCount*hCell,[]);
      //��������� ��������
      for I := 0 to Columns.Count-1 do
        with Columns[I] do
          DrawGridCell(Cvs,AColWidths[I]-Width,
                   (AMaxRowCount-1)*hCell+1,AColWidths[I],
                   AMaxRowCount*hCell,[IntToStr(I+1)]);
    end;{with}
  end;{with}
end;{DrawGridTitle}
//������������ ������ DBGrid'�
procedure DrawDBGridColumnCell(var ADBGrid: TDBGrid;
                               const Rect: TRect;
                               const DataCol: Integer;
                               const Column: TColumn;
                               const State: TGridDrawState);
begin
  with ADBGrid do
  begin
    if Column.ReadOnly then
    begin
      Canvas.Brush.Color := clLtGrayEx;
      Canvas.Font.Color := clWindowText;
    end;{if}
    if gdFocused in State then
    begin
      Canvas.Brush.Color := clActiveCaption;
      Canvas.Font.Color := clWindow;
    end;{if}
    DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;{with}
end;{dbgAutoEnginesDrawDBGridColumnCell}
//����� ������� ��� Boolean ���� DBGrid'a
procedure DrawDBGridTick(const ACanvas: TCanvas; const ARect: TRect; const AValue: Boolean);
var
  ACell: TRect;
  ACenter: TPoint;
begin
  with ACanvas,ACell do
  begin
    FillRect(ARect);
    ACenter := Point((ARect.Left+ARect.Right)div 2,(ARect.Top+ARect.Bottom)div 2);
    ACell := Types.Rect(ACenter.X-6,ACenter.Y-6,ACenter.X+6,ACenter.Y+6);
    //����� ��������� checkbox'a
    Pen.Color := clGrayEx;  //������
    MoveTo(Left,Bottom-1); LineTo(Left,Top); LineTo(Right,Top);
    Pen.Color := clLightGrayEx;  //����� �������
    MoveTo(Left+1,Bottom-1);LineTo(Right-1,Bottom-1);LineTo(Right-1,Top);
    Pen.Color := clDarkGrayEx;  //����� ������
    MoveTo(Left+1,Bottom-2);LineTo(Left+1,Top+1);LineTo(Right-1,Top+1);
    //����� ������� checkbox'a
    if AValue then
    begin
      Pen.Color := clBlack;
      MoveTo(Left+3,Top+5); LineTo(Left+5,Top+7); LineTo(Left+10,Top+2);
      MoveTo(Left+3,Top+6); LineTo(Left+5,Top+8); LineTo(Left+10,Top+3);
      MoveTo(Left+3,Top+7); LineTo(Left+5,Top+9); LineTo(Left+10,Top+4);
    end;{if}
  end{if}
end;{DrawDBGridTick}

//IX. ��������� ������������ �������� ����� ������ �� ��������� ��������� ---------------------
//�������� �������� FloatField'a: Field.AsFloat > AMin
function IsFloatFieldMoreMin(AField: TField; const AMin: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := AField.AsFloat>AMin;
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� ������ %f.',[AField.DisplayLabel,AMin]));
end;{IsFloatFieldMoreMin}
//�������� �������� FloatField'a: Field.AsFloat >= AMin
function IsFloatFieldMoreEqualMin(AField: TField; const AMin: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := AField.AsFloat>=AMin;
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� �� ������ %f.',[AField.DisplayLabel,AMin]));
end;{IsFloatFieldMoreEqualMin}
//�������� �������� FloatField'a: Field.AsFloat in [AMin,AMax]  � ��������� 0.1 
function IsFloatFieldInRange1(AField: TField; const AMin,AMax: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := InRange(Round(AField.AsFloat*10),Round(AMin*10),Round(AMax*10));
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� � [%.1f, %.1f].',[AField.DisplayLabel,AMin,AMax]));
end;{IsFloatFieldInRange1}
//�������� �������� FloatField'a: Field.AsFloat in [AMin,AMax]  � ��������� 0.01
function IsFloatFieldInRange2(AField: TField; const AMin,AMax: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := InRange(Round(AField.AsFloat*100),Round(AMin*100),Round(AMax*100));
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� � [%.2f, %.2f].',[AField.DisplayLabel,AMin,AMax]));
end;{IsFloatFieldInRange2}
//�������� �������� FloatField'a: Field.AsFloat in [AMin,AMax]  � ��������� 0.001 
function IsFloatFieldInRange3(AField: TField; const AMin,AMax: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := InRange(Round(AField.AsFloat*1000),Round(AMin*1000),Round(AMax*1000));
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� � [%.3f, %.3f].',[AField.DisplayLabel,AMin,AMax]));
end;{IsFloatFieldInRange3}
//�������� �������� IntegerField'a: Field.AsInteger > AMin
function IsIntegerFieldMoreMin(AField: TField; const AMin: Integer): Boolean;
begin
  if AField.Value=null then AField.AsInteger := 0;
  Result := AField.AsInteger>AMin;
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� ������ %d.',[AField.DisplayLabel,AMin]));
end;{IsIntegerFieldMoreMin}
//�������� �������� IntegerField'a: Field.AsInteger >= AMin
function IsIntegerFieldMoreEqualMin(AField: TField; const AMin: Integer): Boolean;
begin
  if AField.Value=null then AField.AsInteger := 0;
  Result := AField.AsInteger>=AMin;
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� �� ������ %d.',[AField.DisplayLabel,AMin]));
end;{IsIntegerFieldMoreEqualMin}
//�������� �������� IntegerField'a: Field.AsInteger in [AMin,AMax]  � ��������� 0.1
function IsIntegerFieldInRange(AField: TField; const AMin,AMax: Integer): Boolean;
begin
  if AField.Value=null then AField.AsInteger := 0;
  Result := InRange(AField.AsInteger,AMin,AMax);
  if not Result
  then esaMsgError(Format('�������� ���� "%s" ������ ���� � [%d, %d].',[AField.DisplayLabel,AMin,AMax]));
end;{IsIntegerFieldInRange}



//X. ��������� ������������ �������� �����(� ��������� �������) ��������� ��������� -----------
//�������� ������������ ����� �������� �����(� ��������� �������) ��������� ���������
function CheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Integer;
                       const AIsBlankAllowed: Boolean): Boolean;
begin
  Result := true;
  try
    if not(AIsBlankAllowed and(AValue='')) then StrToInt(AValue);
  except
    Result := false; esaMsgError(Format(EInvalidIntegerValue,[AValue,APrompt]));
  end;{try}
  if Result and(AValue<>'')and(not InRange(StrToInt(AValue),AMin,AMax))then
  begin
    Result := false; esaMsgError(Format(EInvalidIntegerValueEx,[AValue,APrompt,AMin,AMax]));
  end;{if}
end;{CheckStrValue}
//�������� ������������ ������������ �������� �����(� ��������� �������) ��������� ���������
function CheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Single;
                       const AIsBlankAllowed: Boolean): Boolean;
begin
  Result := true;
  try
    if not(AIsBlankAllowed and(AValue='')) then StrToFloat(AValue);
  except
    Result := false; esaMsgError(Format(EInvalidSingleValue,[AValue,APrompt]));
  end;{try}
  if Result and(AValue<>'')and(not InRange(StrToFloat(AValue),AMin,AMax))then
  begin
    Result := false; esaMsgError(Format(EInvalidSingleValueEx,[AValue,APrompt,AMin,AMax]));
  end;{if}
end;{CheckStrValue}

//XI. ��������� ������������ �������� ����� TEdit'� ��������� ��������� -----------------------
//�������� ������������ ������������ �������� ���� TEdit ��������� ���������
function CheckEditValue(var AEdit: TEdit;
                        APrompt,AMask: String;
                        ADefault,AMin,AMax: Single): Boolean;overload;
const sError='������������ �������� ���� ''%s'' %.2f. ���������� ��������: [%.2f..%.2f].';
var AValue: Single;
begin
  Result := false;
  AEdit.Text := Trim(AEdit.Text);
  try
    AValue := StrToFloat(AEdit.Text);
    if AMax<AMin then AMax := MaxSingle;
    if not InRange(AValue,AMin,AMax) then
    begin
      APrompt := CaptionToStr(APrompt);
      esaMsgError(Format(sError,[APrompt,AValue,AMin,AMax]));
      AEdit.Text := FormatFloat(AMask,ADefault);
      AEdit.SetFocus;
    end{if}
    else Result := true;
  except
    esaMsgError(Format(EInvalidSingleValue,[AEdit.Text,APrompt]));
    AEdit.Text := FormatFloat(AMask,ADefault);
    AEdit.SetFocus;
  end;{try}
end;{CheckEditValue}
//�������� ������������ ����� �������� ���� TEdit ��������� ���������
function CheckEditValue(var AEdit: TEdit; APrompt: String; ADefault,AMin,AMax: Integer): Boolean;
var AValue: Integer;
begin
  Result := false;
  AEdit.Text := Trim(AEdit.Text);
  try
    AValue := StrToInt(AEdit.Text);
    if AMax<AMin then AMax := MaxInt;
    if not InRange(AValue,AMin,AMax) then
    begin
      APrompt := CaptionToStr(APrompt);
      esaMsgError(Format(EInvalidIntegerValueEx,[IntToStr(AValue),APrompt,AMin,AMax]));
      AEdit.Text := IntToStr(ADefault);
      AEdit.SetFocus;
    end{if}
    else Result := true;
  except
    esaMsgError(Format(EInvalidIntegerValue,[AEdit.Text,APrompt]));
    AEdit.Text := IntToStr(ADefault);
    AEdit.SetFocus;
  end;{try}
end;{CheckEditValue}

//XIII. ��������� ��������� �������� ������� ������ -------------------------------------------
//�������� ������������ ����� ������.����� �� OnKeyPress
procedure CheckFloatValueOnKeyPress(const Text: String; var Key: Char);
begin
  if Key in ['.',','] then Key := DecimalSeparator;
  if (not(Key in ['-','0'..'9',DecimalSeparator,#8]))OR
     ((Key=DecimalSeparator)and(Pos(DecimalSeparator,Text)>0))then
  begin
    SysUtils.Beep;
    Key := #0;
  end;{if}
end;{CheckFloatValueOnKeyPress}
//�������� ������������ ����� ������ ����� �� OnKeyPress
procedure CheckIntValueOnKeyPress(var Key: Char);
begin
  if not(Key in ['0'..'9',#8])then
  begin
    SysUtils.Beep;
    Key := #0;
  end;{if}
end;{CheckIntValueOnKeyPress}

//XIV. ��������� �������� ����������� ---------------------------------------------------------
//������ ���������� ����
function CreateDialogForm(const ACaption: String; const AWidth,AHeight: Integer): TForm;
begin
  Result := TForm.Create(nil);
  try
    Result.Width := AWidth;
    Result.Height := AHeight;
    Result.Caption := ACaption;
    Result.BorderStyle := bsDialog;
    Result.Position := poScreenCenter;
  except
    Result.Free;
    Result := nil;
  end;{try}
end;{CreateDialogForm}
//������������ �������� � LabeledEdit
procedure SetLabeledEditProperties(var ALabeledEdit: TLabeledEdit;
                                   const AParent: TWinControl;
                                   const APrompt,AText: String;
                                   const ALeft,ATop,AWidth: Integer;
                                   const AMaxLength: Integer;
                                   const AAnchors: TAnchors);
begin
  ALabeledEdit.Parent := AParent;
  ALabeledEdit.Left := ALeft;
  ALabeledEdit.Top := ATop;
  ALabeledEdit.Width := AWidth;
  ALabeledEdit.Anchors := AAnchors;
  ALabeledEdit.EditLabel.Caption := APrompt;
  ALabeledEdit.Text := AText;
  ALabeledEdit.MaxLength := AMaxLength;
end;{SetLabeledEditProperties}
//������������ �������� � TButton
procedure SetButtonProperties(const AButton: TButton;
                              const AParent: TWinControl;
                              const APosition: TPoint;
                              const ACaption: String;
                              const ADefault,ACancel: Boolean;
                              const AModalResult: TModalResult);
begin
  AButton.Parent := AParent;
  AButton.Left := APosition.X;
  AButton.Top := APosition.Y;
  AButton.Width := 72;
  AButton.Caption := ACaption;
  AButton.Default := ADefault;
  AButton.Cancel := ACancel;
  AButton.ModalResult := AModalResult;
end;{SetButtonProperties}
//������������ �������� � TLabel
procedure SetLabelProperties(const ALabel: TLabel;
                             const AParent: TWinControl;
                             const APosition: TPoint;
                             const ACaption: String);
begin
  ALabel.Parent := AParent;
  ALabel.Left := APosition.X;
  ALabel.Top := APosition.Y;
  ALabel.Caption := ACaption;
end;{SetLabelProperties}
//������ ProgressBar
function CreateProgressBar(const AOwner : TComponent;
                           const AParent: TWinControl;
                           const APosition: TPoint;
                           const AWidth: Integer): TProgressBar;
begin
  Result := TProgressBar.Create(AOwner);
  Result.Parent := AParent;
  Result.Left := APosition.X;
  Result.Top := APosition.Y;
  Result.Width := AWidth;
end;{CreateProgressBar}

//XV ��������� "������-������" ----------------------------------------------------------------
//������ �� ���������� ��������� ��� ��������� ��������� ����� (Result*.ESA)
procedure DeleteResultFiles;
var
  AFileName: String;
  ASeachRec: TSearchRec;
  AFileAttrs: Integer;
begin
  AFileName := ExtractFilePath(Application.ExeName)+'Result*.ESA';
  AFileAttrs := faAnyFile;
  if FindFirst(AFileName, AFileAttrs, ASeachRec) = 0 then
  begin
    repeat
      if (ASeachRec.Attr and AFileAttrs) = ASeachRec.Attr
      then DeleteFile(ASeachRec.Name);
    until FindNext(ASeachRec) <> 0;
  end;{if}
end;{DeleteResultFiles}
end.
