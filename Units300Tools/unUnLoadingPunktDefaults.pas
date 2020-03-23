unit unUnLoadingPunktDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask;

type
  TfmUnLoadingPunktDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    edRequiredContent: TEdit;
    edInitialContent: TEdit;
    edInitialV1000m3: TEdit;
    lbInitialV1000m3: TLabel;
    lbInitialContent: TLabel;
    lbRequiredContent: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edRequiredContentKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;{TfmExcavatorEngineDefaults}

var
  fmUnLoadingPunktDefaults: TfmUnLoadingPunktDefaults;

//Диалоговое окно значений по умолчанию пунктов разгрузки
function esaShowUnLoadingPunktDefaultsDlg(const AHelpKeyword: String): Boolean;
implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию пунктов разгрузки
function esaShowUnLoadingPunktDefaultsDlg(const AHelpKeyword: String): Boolean;
begin
  fmUnLoadingPunktDefaults := TfmUnLoadingPunktDefaults.Create(nil);
  try
    fmUnLoadingPunktDefaults.HelpKeyword := AHelpKeyword;
    Result := fmUnLoadingPunktDefaults.ShowModal=mrOk;
  finally
    fmUnLoadingPunktDefaults.Free;
  end;{try}
end;{esaShowUnLoadingPunktDefaultsDlg}

procedure TfmUnLoadingPunktDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  edRequiredContent.Text := FormatFloat('0.0',DefaultParams.UnLoadingPunktRockRequiredContent);
  edInitialContent.Text := FormatFloat('0.0',DefaultParams.UnLoadingPunktRockInitialContent);
  edInitialV1000m3.Text := FormatFloat('0.00',DefaultParams.UnLoadingPunktRockInitialV1000m3);
end;{FormCreate}

procedure TfmUnLoadingPunktDefaults.btOkClick(Sender: TObject);
begin
  if CheckEditValue(edRequiredContent,lbRequiredContent.Caption,'0.0',DefaultParams.UnLoadingPunktRockRequiredContent,0.0,100.0) and
     CheckEditValue(edInitialContent,lbInitialContent.Caption,'0.0',DefaultParams.UnLoadingPunktRockInitialContent,0.0,100.0) and
     CheckEditValue(edInitialV1000m3,lbInitialV1000m3.Caption,'0.00',DefaultParams.UnLoadingPunktRockInitialV1000m3,0.1,-1.0) then
  begin
    DefaultParams.UnLoadingPunktRockRequiredContent := StrToFloat(edRequiredContent.Text);
    DefaultParams.UnLoadingPunktRockInitialContent := StrToFloat(edInitialContent.Text);
    DefaultParams.UnLoadingPunktRockInitialV1000m3 := StrToFloat(edInitialV1000m3.Text);
    ModalResult := mrOk;
  end;{if}
end;{btOkClick}

procedure TfmUnLoadingPunktDefaults.edRequiredContentKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Sender Is TEdit then CheckFloatValueOnKeyPress((Sender As TEdit).Text,Key);
end;{edRequiredContentKeyPress}

end.
