unit unExcavatorModelDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask;

type
  TfmExcavatorModelDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    lbBucketCapacity: TLabel;
    lbCycleTime: TLabel;
    lbEngines: TLabel;
    dblcbEngines: TDBLookupComboBox;
    lbLength: TLabel;
    lbWidth: TLabel;
    lbHeight: TLabel;
    edBucketCapacity: TEdit;
    edCycleTime: TEdit;
    edLength: TEdit;
    edWidth: TEdit;
    edHeight: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edBucketCapacityKeyPress(Sender: TObject; var Key: Char);
    procedure edTyresCountKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;{TfmExcavatorEngineDefaults}

var
  fmExcavatorModelDefaults: TfmExcavatorModelDefaults;

//Диалоговое окно значений по умолчанию моделей экскаватора
function esaShowExcavatorModelDefaultsDlg(const AHelpKeyword: String): Boolean;
implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию моделей экскаватора
function esaShowExcavatorModelDefaultsDlg(const AHelpKeyword: String): Boolean;
begin
  fmExcavatorModelDefaults := TfmExcavatorModelDefaults.Create(nil);
  try
    fmExcavatorModelDefaults.HelpKeyword := AHelpKeyword;
    Result := fmExcavatorModelDefaults.ShowModal=mrOk;
  finally
    fmExcavatorModelDefaults.Free;
  end;{try}
end;{esaShowExcavatorModelDefaultsDlg}

procedure TfmExcavatorModelDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  edBucketCapacity.Text := FormatFloat('0.##',DefaultParams.ExcavatorBucketCapacity);
  edCycleTime.Text := FormatFloat('0.##',DefaultParams.ExcavatorCycleTime);
  fmDM.quExcavatorEngines.Locate('Id_Engine',DefaultParams.ExcavatorId_Engine,[]);
  dblcbEngines.KeyValue := fmDM.quExcavatorEnginesId_Engine.AsInteger;
  edLength.Text := FormatFloat('0.##',DefaultParams.ExcavatorLength);
  edWidth.Text := FormatFloat('0.##',DefaultParams.ExcavatorWidth);
  edHeight.Text := FormatFloat('0.##',DefaultParams.ExcavatorHeight);
end;{FormCreate}

procedure TfmExcavatorModelDefaults.btOkClick(Sender: TObject);
begin
  if CheckEditValue(edBucketCapacity,lbBucketCapacity.Caption,'0.##',DefaultParams.ExcavatorBucketCapacity,1.0,-1.0) and
     CheckEditValue(edCycleTime,lbCycleTime.Caption,'0.##',DefaultParams.ExcavatorCycleTime,1.0,-1.0) and
     CheckEditValue(edLength,lbLength.Caption,'0.##',DefaultParams.ExcavatorLength,1.0,-1.0) and
     CheckEditValue(edWidth,lbWidth.Caption,'0.##',DefaultParams.ExcavatorWidth,1.0,-1.0) and
     CheckEditValue(edHeight,lbHeight.Caption,'0.##',DefaultParams.ExcavatorHeight,1.0,-1.0)then
  begin
    DefaultParams.ExcavatorBucketCapacity := StrToFloat(edBucketCapacity.Text);
    DefaultParams.ExcavatorCycleTime := StrToFloat(edCycleTime.Text);
    DefaultParams.ExcavatorId_Engine := fmDM.quExcavatorEnginesId_Engine.AsInteger;
    DefaultParams.ExcavatorLength := StrToFloat(edLength.Text);
    DefaultParams.ExcavatorWidth := StrToFloat(edWidth.Text);
    DefaultParams.ExcavatorHeight := StrToFloat(edHeight.Text);
    ModalResult := mrOk;
  end;{if}
end;{btOkClick}

procedure TfmExcavatorModelDefaults.edBucketCapacityKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckFloatValueOnKeyPress(TEdit(Sender).Text, Key);
end;{edBucketCapacityKeyPress}

procedure TfmExcavatorModelDefaults.edTyresCountKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckIntValueOnKeyPress(Key);
end;{edTyresCountKeyPress}

end.
