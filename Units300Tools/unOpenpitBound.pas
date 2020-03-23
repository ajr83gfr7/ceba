unit unOpenpitBound;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Globals;

type
  TfmOpenpitBound = class(TForm)
    gbPointsBound: TGroupBox;
    ledPointsMinX: TLabeledEdit;
    ledPointsMaxX: TLabeledEdit;
    ledPointsMinY: TLabeledEdit;
    ledPointsMaxY: TLabeledEdit;
    ledPointsMinZ: TLabeledEdit;
    ledPointsMaxZ: TLabeledEdit;
    gbBound: TGroupBox;
    ledMinX: TLabeledEdit;
    ledMaxX: TLabeledEdit;
    ledMinY: TLabeledEdit;
    ledMaxY: TLabeledEdit;
    ledMinZ: TLabeledEdit;
    ledMaxZ: TLabeledEdit;
    btOk: TButton;
    btCancel: TButton;
    procedure ledMinXKeyPress(Sender: TObject; var Key: Char);
    procedure ledMinXKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btOkClick(Sender: TObject);
  private
    FPointsBound: RBound3D;
    FOpenpitBound: RBound3D;
    procedure SetPointsBound(const Value: RBound3D);
    procedure SetOpenpitBound(const Value: RBound3D);
  public         
    property PointsBound: RBound3D read FPointsBound write SetPointsBound;
    property OpenpitBound: RBound3D read FOpenpitBound write SetOpenpitBound;
  end;{TfmOpenpitBound}

var
  fmOpenpitBound: TfmOpenpitBound;

//Диалоговое окно графического редактора
function esaShowOpenpitBoundDlg(const AHelpKeyword: String; const bPoints: RBound3D; var bOpenpit: RBound3D): Boolean;
implementation

{$R *.dfm}

//Диалоговое окно графического редактора
function esaShowOpenpitBoundDlg(const AHelpKeyword: String; const bPoints: RBound3D; var bOpenpit: RBound3D): Boolean;
begin
  Result := False;
  fmOpenpitBound := TfmOpenpitBound.Create(nil);
  try
    fmOpenpitBound.HelpKeyword  := AHelpKeyword+'Points';
    fmOpenpitBound.OpenpitBound := bOpenpit;
    fmOpenpitBound.PointsBound  := bPoints;
    if fmOpenpitBound.ShowModal=mrOk then
    begin
      Result := True;
      bOpenpit := fmOpenpitBound.OpenpitBound;
    end;{if}
  finally
    fmOpenpitBound.Free;
  end;{try}
end;{esaShowOpenpitBoundDlg}

procedure TfmOpenpitBound.ledMinXKeyPress(Sender: TObject; var Key: Char);
begin
  if Sender is TLabeledEdit then CheckFloatValueOnKeyPress(TLabeledEdit(Sender).Text,Key);
end;{ledMinXKeyPress}

procedure TfmOpenpitBound.ledMinXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Sender is TLabeledEdit then
  if Key=VK_RETURN then FindNextControl(TLabeledEdit(Sender),true,false,false).SetFocus;
end;{ledMinXKeyDown}

function CheckFloatValue(var ledBox: TLabeledEdit; var Value: Single): Boolean;
begin
  Result := true;
  try
    Value := StrToFloat(ledBox.Text);
  except
    Result := false;
    ledBox.SetFocus; ledBox.SelectAll;
    esaMsgError(Format('Неверное значение ''%s'' поля ''%s''.',[ledBox.Text,ledBox.EditLabel.Caption]));
  end;{try}
end;{CheckFloatValue}

procedure TfmOpenpitBound.btOkClick(Sender: TObject);
var ABound: RBound3D;
begin
  if CheckFloatValue(ledMinX,ABound.MinX)then
  if CheckFloatValue(ledMinY,ABound.MinY)then
  if CheckFloatValue(ledMinZ,ABound.MinZ)then
  if CheckFloatValue(ledMaxX,ABound.MaxX)then
  if CheckFloatValue(ledMaxY,ABound.MaxY)then
  if CheckFloatValue(ledMaxZ,ABound.MaxZ)then
  begin
    if (ABound.MinX<ABound.MaxX)and
       (ABound.MinY<ABound.MaxY)and
       (ABound.MinZ<ABound.MaxZ)then
    begin
      FOpenpitBound := ABound;
      ModalResult := mrOk
    end
    else esaMsgError('Значения Xmin, Ymin, Zmin должны быть меньше значений Xmax, Ymax, Zmax.');
  end;{if}
end;{btOkClick}

procedure TfmOpenpitBound.SetOpenpitBound(const Value: RBound3D);
begin
  FOpenpitBound := Value;
  ledMinX.Text := FormatFloat('0.000',FOpenpitBound.MinX);
  ledMinY.Text := FormatFloat('0.000',FOpenpitBound.MinY);
  ledMinZ.Text := FormatFloat('0.000',FOpenpitBound.MinZ);
  ledMaxX.Text := FormatFloat('0.000',FOpenpitBound.MaxX);
  ledMaxY.Text := FormatFloat('0.000',FOpenpitBound.MaxY);
  ledMaxZ.Text := FormatFloat('0.000',FOpenpitBound.MaxZ);
end;{SetOpenpitBound}
procedure TfmOpenpitBound.SetPointsBound(const Value: RBound3D);
begin
  FPointsBound := Value;
  ledPointsMinX.Text := FormatFloat('0.000',FPointsBound.MinX);
  ledPointsMinY.Text := FormatFloat('0.000',FPointsBound.MinY);
  ledPointsMinZ.Text := FormatFloat('0.000',FPointsBound.MinZ);
  ledPointsMaxX.Text := FormatFloat('0.000',FPointsBound.MaxX);
  ledPointsMaxY.Text := FormatFloat('0.000',FPointsBound.MaxY);
  ledPointsMaxZ.Text := FormatFloat('0.000',FPointsBound.MaxZ);
end;{SetPointsBound}

end.
