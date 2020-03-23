unit unExcavatorDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask, Spin;

type
  TfmExcavatorDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    lbCost: TLabel;
    lbExcavators: TLabel;
    dblcbExcavators: TDBLookupComboBox;
    lbFactCycleTime: TLabel;
    lbAddCostMaterials: TLabel;
    lbAddCostUnAccounted: TLabel;
    edCost: TEdit;
    edFactCycleTime: TEdit;
    edAddCostMaterials: TEdit;
    edAddCostUnAccounted: TEdit;
    lbEngineKIM: TLabel;
    edEngineKIM: TEdit;
    lbEngineKPD: TLabel;
    edEngineKPD: TEdit;
    lbEYear: TLabel;
    seEYear: TSpinEdit;
    chbWorkState: TCheckBox;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    edSENAmortizationRate: TEdit;
    lbSENAmortizationRate: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edCostKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;{TfmExcavatorEngineDefaults}

var
  fmExcavatorDefaults: TfmExcavatorDefaults;

//Диалоговое окно значений по умолчанию списочного парка экскаваторов
procedure esaShowExcavatorDefaultsDlg(const AHelpKeyword: String);
implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию списочного парка экскаваторов
procedure esaShowExcavatorDefaultsDlg(const AHelpKeyword: String);
begin
  fmExcavatorDefaults := TfmExcavatorDefaults.Create(nil);
  try
    fmExcavatorDefaults.HelpKeyword := AHelpKeyword;
    fmExcavatorDefaults.ShowModal;
  finally
    fmExcavatorDefaults.Free;
  end;{try}
end;{esaShowExcavatorDefaultsDlg}
procedure TfmExcavatorDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  fmDM.quExcavators.Locate('Id_Excavator',DefaultParams.DeportExcId_Excavator,[]);
  dblcbExcavators.KeyValue := fmDM.quExcavatorsId_Excavator.AsInteger;
  seEYear.Value := DefaultParams.DeportExcEYear;
  chbWorkState.Checked := DefaultParams.DeportExcWorkState;
  edCost.Text := FormatFloat('0.##',DefaultParams.DeportExcCost);
  edFactCycleTime.Text := FormatFloat('0.##',DefaultParams.DeportExcFactCycleTime);
  edAddCostMaterials.Text := FormatFloat('0.##',DefaultParams.DeportExcAddCostMaterials);
  edAddCostUnAccounted.Text := FormatFloat('0.##',DefaultParams.DeportExcAddCostUnAccounted);
  edEngineKIM.Text := FormatFloat('0.##',DefaultParams.DeportExcEngineKIM);
  edEngineKPD.Text := FormatFloat('0.###',DefaultParams.DeportExcEngineKPD);
  edSENAmortizationRate.Text := FormatFloat('0.####',DefaultParams.DeportSENExcAmortizationRate);
end;{FormCreate}

procedure TfmExcavatorDefaults.btOkClick(Sender: TObject);
begin
  if (seEYear.Text<>'')and
     CheckEditValue(edCost,lbCost.Caption,'0.##',DefaultParams.DeportExcCost,1.0,-1.0) and
     CheckEditValue(edFactCycleTime,lbFactCycleTime.Caption,'0.##',DefaultParams.DeportExcFactCycleTime,1.0,-1.0) and
     CheckEditValue(edAddCostMaterials,lbAddCostMaterials.Caption,'0.##',DefaultParams.DeportExcAddCostMaterials,0.0,-1.0) and
     CheckEditValue(edAddCostUnAccounted,lbAddCostUnAccounted.Caption,'0.##',DefaultParams.DeportExcAddCostUnAccounted,0.0,-1.0) and
     CheckEditValue(edEngineKIM,lbEngineKIM.Caption,'0.##',DefaultParams.DeportExcEngineKIM,0.25,0.35)and
     CheckEditValue(edEngineKPD,lbEngineKPD.Caption,'0.###',DefaultParams.DeportExcEngineKPD,0.936,0.948) and
     CheckEditValue(edSENAmortizationRate,lbSENAmortizationRate.Caption,'0.####',DefaultParams.DeportSENExcAmortizationRate,0.0001,-1.0) then
  begin
    DefaultParams.DeportExcId_Excavator := fmDM.quExcavatorsId_Excavator.AsInteger;
    DefaultParams.DeportExcEYear := seEYear.Value;
    DefaultParams.DeportExcWorkState := chbWorkState.Checked;
    DefaultParams.DeportExcCost := StrToFloat(edCost.Text);
    DefaultParams.DeportExcFactCycleTime := StrToFloat(edFactCycleTime.Text);
    DefaultParams.DeportExcAddCostMaterials := StrToFloat(edAddCostMaterials.Text);
    DefaultParams.DeportExcAddCostUnAccounted := StrToFloat(edAddCostUnAccounted.Text);
    DefaultParams.DeportExcEngineKIM := StrToFloat(edEngineKIM.Text);
    DefaultParams.DeportExcEngineKPD := StrToFloat(edEngineKPD.Text);
    ModalResult := mrOk;
  end;{if}
end;{btOkClick}

procedure TfmExcavatorDefaults.edCostKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckFloatValueOnKeyPress(TEdit(Sender).Text, Key);
end;{edCostKeyPress}

end.
