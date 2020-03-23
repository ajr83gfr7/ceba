unit unProductivityDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask;

type
  TfmProductivityDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    edDensityInBlock: TEdit;
    edShatteringCoef: TEdit;
    edContent: TEdit;
    lbContent: TLabel;
    lbShatteringCoef: TLabel;
    lbDensityInBlock: TLabel;
    lbPlannedV1000m3: TLabel;
    edPlannedV1000m3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edPlannedV1000m3KeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;{TfmExcavatorEngineDefaults}

var
  fmProductivityDefaults: TfmProductivityDefaults;

//Диалоговое окно значений по умолчанию плановых объемов
function esaShowProductivityDefaultsDlg(const AHelpKeyword: String): Boolean;
implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию плановых объемов
function esaShowProductivityDefaultsDlg(const AHelpKeyword: String): Boolean;
begin
  fmProductivityDefaults := TfmProductivityDefaults.Create(nil);
  try
    fmProductivityDefaults.HelpKeyword := AHelpKeyword;
    Result := fmProductivityDefaults.ShowModal=mrOk;
  finally
    fmProductivityDefaults.Free;
  end;{try}
end;{esaShowProductivityDefaultsDlg}

procedure TfmProductivityDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  edDensityInBlock.Text := FormatFloat('0.00',DefaultParams.LoadingPunktRockDensityInBlock);
  edShatteringCoef.Text := FormatFloat('0.00',DefaultParams.LoadingPunktRockShatteringCoef);
  edContent.Text := FormatFloat('0.0',DefaultParams.LoadingPunktRockContent);
  edPlannedV1000m3.Text := FormatFloat('0.0',DefaultParams.LoadingPunktRockPlannedV1000m3);
end;{FormCreate}

procedure TfmProductivityDefaults.btOkClick(Sender: TObject);
begin
  if CheckEditValue(edDensityInBlock,lbDensityInBlock.Caption,'0.00',DefaultParams.LoadingPunktRockDensityInBlock,0.1,-1.0) and
     CheckEditValue(edShatteringCoef,lbShatteringCoef.Caption,'0.00',DefaultParams.LoadingPunktRockShatteringCoef,0.1,-1.0) and
     CheckEditValue(edContent,lbContent.Caption,'0.00',DefaultParams.LoadingPunktRockContent,1.0,100.0) and
     CheckEditValue(edPlannedV1000m3,lbPlannedV1000m3.Caption,'0.00',DefaultParams.LoadingPunktRockPlannedV1000m3,0.1,-1.0) then
  begin
    DefaultParams.LoadingPunktRockDensityInBlock := StrToFloat(edDensityInBlock.Text);
    DefaultParams.LoadingPunktRockShatteringCoef := StrToFloat(edShatteringCoef.Text);
    DefaultParams.LoadingPunktRockContent := StrToFloat(edContent.Text);
    DefaultParams.LoadingPunktRockPlannedV1000m3 := StrToFloat(edPlannedV1000m3.Text);
    ModalResult := mrOk;
  end;{if}
end;{btOkClick}

procedure TfmProductivityDefaults.edPlannedV1000m3KeyPress(Sender: TObject; var Key: Char);
begin
  if Sender Is TEdit then CheckFloatValueOnKeyPress((Sender As TEdit).Text,Key);
end;{edPlannedVm3KeyPress}

end.
