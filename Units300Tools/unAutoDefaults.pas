unit unAutoDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask, Spin;

type
  TfmAutoDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    lbCost: TLabel;
    lbAutos: TLabel;
    dblcbAutos: TDBLookupComboBox;
    lbFactTonnage: TLabel;
    lbAmortizationRate: TLabel;
    lbTransmissionKPD: TLabel;
    edCost: TEdit;
    edFactTonnage: TEdit;
    edAmortizationRate: TEdit;
    edTransmissionKPD: TEdit;
    lbEngineKPD: TLabel;
    edEngineKPD: TEdit;
    lbTyreCost: TLabel;
    edTyreCost: TEdit;
    lbAYear: TLabel;
    seAYear: TSpinEdit;
    chbWorkState: TCheckBox;
    edTyresRaceRate: TEdit;
    lbTyresRaceRate: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edCostKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;{TfmDeportAutoDefaults}

var
  fmAutoDefaults: TfmAutoDefaults;

//Диалоговое окно значений по умолчанию списочного парка автосамосвалов
procedure esaShowAutoDefaultsDlg(const AHelpKeyword: String);
implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию списочного парка автосамосвалов
procedure esaShowAutoDefaultsDlg(const AHelpKeyword: String);
begin
  fmAutoDefaults := TfmAutoDefaults.Create(nil);
  try
    fmAutoDefaults.HelpKeyword := AHelpKeyword;
    fmAutoDefaults.ShowModal;
  finally
    fmAutoDefaults.Free;
  end;{try}
end;{esaShowAutoDefaultsDlg}
procedure TfmAutoDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  fmDM.quAutos.Locate('Id_Auto',DefaultParams.DeportAutoId_Auto,[]);
  dblcbAutos.KeyValue := fmDM.quAutosId_Auto.AsInteger;
  seAYear.Value := DefaultParams.DeportAutoAYear;
  chbWorkState.Checked := DefaultParams.DeportAutoWorkState;
  edCost.Text := FormatFloat('0.##',DefaultParams.DeportAutoCost);
  edFactTonnage.Text := FormatFloat('0.##',DefaultParams.DeportAutoFactTonnage);
  edAmortizationRate.Text := FormatFloat('0.####',DefaultParams.DeportAutoAmortizationRate);
  edTransmissionKPD.Text := FormatFloat('0.##',DefaultParams.DeportAutoTransmissionKPD);
  edEngineKPD.Text := FormatFloat('0.###',DefaultParams.DeportAutoEngineKPD);
  edTyreCost.Text := FormatFloat('0.##',DefaultParams.DeportAutoTyreCost);
  edTyresRaceRate.Text := FormatFloat('0.##',DefaultParams.DeportAutoTyresRaceRate);
end;{FormCreate}

procedure TfmAutoDefaults.btOkClick(Sender: TObject);
begin
  if (seAYear.Text<>'')and
     CheckEditValue(edCost,lbCost.Caption,'0.##',DefaultParams.DeportAutoCost,1.0,-1.0) and
     CheckEditValue(edFactTonnage,lbFactTonnage.Caption,'0.##',DefaultParams.DeportAutoFactTonnage,1.0,-1.0) and
     CheckEditValue(edAmortizationRate,lbAmortizationRate.Caption,'0.####',DefaultParams.DeportAutoAmortizationRate,0.0001,-1.0) and
     CheckEditValue(edTransmissionKPD,lbTransmissionKPD.Caption,'0.##',DefaultParams.DeportAutoTransmissionKPD,0.1,1.0) and
     CheckEditValue(edTyreCost,lbTyreCost.Caption,'0.##',DefaultParams.DeportAutoTyreCost,1.0,-1.0)and
     CheckEditValue(edTyresRaceRate,lbTyresRaceRate.Caption,'0.##',DefaultParams.DeportAutoTyresRaceRate,1.0,-1.0)and
     CheckEditValue(edEngineKPD,lbEngineKPD.Caption,'0.###',DefaultParams.DeportAutoEngineKPD,0.1,1.0)then
  begin
    DefaultParams.DeportAutoId_Auto := fmDM.quAutosId_Auto.AsInteger;
    DefaultParams.DeportAutoAYear := seAYear.Value;
    DefaultParams.DeportAutoWorkState := chbWorkState.Checked;
    DefaultParams.DeportAutoCost := StrToFloat(edCost.Text);
    DefaultParams.DeportAutoFactTonnage := StrToFloat(edFactTonnage.Text);
    DefaultParams.DeportAutoAmortizationRate := StrToFloat(edAmortizationRate.Text);
    DefaultParams.DeportAutoTransmissionKPD := StrToFloat(edTransmissionKPD.Text);
    DefaultParams.DeportAutoEngineKPD := StrToFloat(edEngineKPD.Text);
    DefaultParams.DeportAutoTyreCost := StrToFloat(edTyreCost.Text);
    DefaultParams.DeportAutoTyresRaceRate := StrToFloat(edTyresRaceRate.Text);
    ModalResult := mrOk;
  end;{if}
end;{btOkClick}

procedure TfmAutoDefaults.edCostKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckFloatValueOnKeyPress(TEdit(Sender).Text, Key);
end;{edCostKeyPress}

end.
