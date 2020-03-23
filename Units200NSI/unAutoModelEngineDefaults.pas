unit unAutoModelEngineDefaults;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;
type
  TfmAutoModelEngineDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    ledNmax: TLabeledEdit;
    Image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ledNmaxKeyPress(Sender: TObject; var Key: Char);
    procedure btOkClick(Sender: TObject);
  private
  public
  end;{TfmAutoEngineDefaults}
var
  fmAutoModelEngineDefaults: TfmAutoModelEngineDefaults;

//Диалоговое окно значений по умолчанию моделей двигателя автосамосвала
function esaShowAutoModelEngineDefaultsDlg(const AHelpKeyword: String): Boolean;

implementation
uses unDM, Globals;
{$R *.dfm}

//Диалоговое окно значений по умолчанию моделей двигателя автосамосвала
function esaShowAutoModelEngineDefaultsDlg(const AHelpKeyword: String): Boolean;
begin
  fmAutoModelEngineDefaults := TfmAutoModelEngineDefaults.Create(nil);
  try
    fmAutoModelEngineDefaults.HelpKeyword := AHelpKeyword;
    Result := fmAutoModelEngineDefaults.ShowModal=mrOk;
  finally
    fmAutoModelEngineDefaults.Free;
  end;{try}
end;{esaShowAutoModelEngineDefaultsDlg}

procedure TfmAutoModelEngineDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  ledNmax.Text := FormatFloat('0.0',DefaultParams.AutoEngineNmax);
end;{FormCreate}
procedure TfmAutoModelEngineDefaults.ledNmaxKeyPress(Sender: TObject; var Key: Char);
begin
  CheckFloatValueOnKeyPress(ledNmax.Text, Key);
end;{ledNmaxKeyPress}
procedure TfmAutoModelEngineDefaults.btOkClick(Sender: TObject);
var Value: Single;
begin
  ledNmax.Text := Trim(ledNmax.Text);
  try
    Value := StrToFloat(ledNmax.Text);
    if Value>=1.0 then
    begin
      DefaultParams.AutoEngineNmax := Value;
      ModalResult := mrOk;
    end{if}
    else
    begin
      esaMsgError('Значение поля '''+CaptionToStr(ledNmax.EditLabel.Caption)+
               ''' должно быть не меньше 1.0.');
      ledNmax.Text := FormatFloat('0.0',DefaultParams.AutoEngineNmax);
      ledNmax.SetFocus;
    end;{else}
  except
    esaMsgError(Format(EInvalidSingleValue,[ledNmax.Text,CaptionToStr(ledNmax.EditLabel.Caption)]));
    ledNmax.Text := FormatFloat('0.0',DefaultParams.AutoEngineNmax);
    ledNmax.SetFocus;
  end;{try}
end;{btOkClick}
end.
