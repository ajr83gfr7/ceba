unit unAutoModelDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask;

type
  TfmAutoModelDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    lbBodySpace: TLabel;
    lbTonnage: TLabel;
    lbP: TLabel;
    lbEngines: TLabel;
    dblcbEngines: TDBLookupComboBox;
    lbTransmissionKind: TLabel;
    lbTransmissionKPD: TLabel;
    lbTr: TLabel;
    lbRmin: TLabel;
    lbTyresCount: TLabel;
    lbLength: TLabel;
    lbWidth: TLabel;
    lbHeight: TLabel;
    edBodySpace: TEdit;
    edTonnage: TEdit;
    edP: TEdit;
    edTransmissionKPD: TEdit;
    edTr: TEdit;
    edRmin: TEdit;
    edTyresCount: TEdit;
    edLength: TEdit;
    edWidth: TEdit;
    edHeight: TEdit;
    cbTransmissionKind: TComboBox;
    lbF: TLabel;
    edF: TEdit;
    lbRo: TLabel;
    edRo: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edBodySpaceKeyPress(Sender: TObject; var Key: Char);
    procedure edTyresCountKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;{TfmAutoEngineDefaults}

var
  fmAutoModelDefaults: TfmAutoModelDefaults;

//Диалоговое окно значений по умолчанию моделей автосамосвала
function esaShowAutoModelDefaultsDlg(const AHelpKeyword: String): Boolean;

implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию моделей автосамосвала
function esaShowAutoModelDefaultsDlg(const AHelpKeyword: String): Boolean;
begin
  fmAutoModelDefaults := TfmAutoModelDefaults.Create(nil);
  try
    fmAutoModelDefaults.HelpKeyword := AHelpKeyword;
    Result := fmAutoModelDefaults.ShowModal=mrOk;
  finally
    fmAutoModelDefaults.Free;
  end;{try}
end;{esaShowAutoModelDefaultsDlg}


procedure TfmAutoModelDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  edBodySpace.Text := FormatFloat('0.##',DefaultParams.AutoBodySpace);
  edTonnage.Text := FormatFloat('0.##',DefaultParams.AutoTonnage);
  edP.Text := FormatFloat('0.##',DefaultParams.AutoP);
  edF.Text := FormatFloat('0.##',DefaultParams.AutoF);
  edRo.Text := FormatFloat('0.##',DefaultParams.AutoRo);
  fmDM.quAutoEngines.Locate('',DefaultParams.AutoId_Engine,[]);
  dblcbEngines.KeyValue := fmDM.quAutoEnginesId_Engine.AsInteger;
  cbTransmissionKind.ItemIndex := Integer(DefaultParams.AutoTransmissionKind);
  edTransmissionKPD.Text := FormatFloat('0.##',DefaultParams.AutoTransmissionKPD);
  edTr.Text := FormatFloat('0.##',DefaultParams.Autot_r);
  edRmin.Text := FormatFloat('0.##',DefaultParams.AutoRmin);
  edTyresCount.Text := IntToStr(DefaultParams.AutoTyresCount);
  edLength.Text := FormatFloat('0.##',DefaultParams.AutoLength);
  edWidth.Text := FormatFloat('0.##',DefaultParams.AutoWidth);
  edHeight.Text := FormatFloat('0.##',DefaultParams.AutoHeight);
end;{FormCreate}

procedure TfmAutoModelDefaults.btOkClick(Sender: TObject);
begin
  if CheckEditValue(edBodySpace,lbBodySpace.Caption,'0.##',DefaultParams.AutoBodySpace,1.0,-1.0) and
     CheckEditValue(edTonnage,lbTonnage.Caption,'0.##',DefaultParams.AutoTonnage,1.0,-1.0) and
     CheckEditValue(edP,lbP.Caption,'0.##',DefaultParams.AutoP,1.0,-1.0) and
     CheckEditValue(edF,lbF.Caption,'0.##',DefaultParams.AutoF,1.0,-1.0) and
     CheckEditValue(edRo,lbRo.Caption,'0.##',DefaultParams.AutoRo,0.0,1.0) and
     CheckEditValue(edTransmissionKPD,lbTransmissionKPD.Caption,'0.##',DefaultParams.AutoTransmissionKPD,0.0,1.0) and
     CheckEditValue(edtr,lbtr.Caption,'0.##',DefaultParams.Autot_r,1.0,-1.0) and
     CheckEditValue(edRmin,lbRmin.Caption,'0.##',DefaultParams.AutoRmin,1.0,-1.0) and
     CheckEditValue(edTyresCount,lbTyresCount.Caption,DefaultParams.AutoTyresCount,1,-1) and
     CheckEditValue(edLength,lbLength.Caption,'0.##',DefaultParams.AutoLength,1.0,-1.0) and
     CheckEditValue(edWidth,lbWidth.Caption,'0.##',DefaultParams.AutoWidth,1.0,-1.0) and
     CheckEditValue(edHeight,lbHeight.Caption,'0.##',DefaultParams.AutoHeight,1.0,-1.0)then
  begin
    DefaultParams.AutoBodySpace := StrToFloat(edBodySpace.Text);
    DefaultParams.AutoTonnage := StrToFloat(edTonnage.Text);
    DefaultParams.AutoP := StrToFloat(edP.Text);
    DefaultParams.AutoF := StrToFloat(edF.Text);
    DefaultParams.AutoRo := StrToFloat(edRo.Text);
    DefaultParams.AutoId_Engine := cbTransmissionKind.ItemIndex;
    DefaultParams.AutoTransmissionKind := TAutoTransmissionKind(fmDM.quAutoEnginesId_Engine.AsInteger);
    DefaultParams.AutoTransmissionKPD := StrToFloat(edTransmissionKPD.Text);
    DefaultParams.AutoT_r := StrToFloat(edTr.Text);
    DefaultParams.AutoRmin := StrToFloat(edRmin.Text);
    DefaultParams.AutoTyresCount := StrToInt(edTyresCount.Text);
    DefaultParams.AutoLength := StrToFloat(edLength.Text);
    DefaultParams.AutoWidth := StrToFloat(edWidth.Text);
    DefaultParams.AutoHeight := StrToFloat(edHeight.Text);
    ModalResult := mrOk;
  end;{if}
end;{btOkClick}

procedure TfmAutoModelDefaults.edBodySpaceKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckFloatValueOnKeyPress(TEdit(Sender).Text, Key);
end;{edBodySpaceKeyPress}

procedure TfmAutoModelDefaults.edTyresCountKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckIntValueOnKeyPress(Key);
end;{edTyresCountKeyPress}

end.
