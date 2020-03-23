unit unExcavatorModelEngineDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfmExcavatorModelEngineDefaults = class(TForm)
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
  end;{TfmExcavatorEngineDefaults}

var
  fmExcavatorModelEngineDefaults: TfmExcavatorModelEngineDefaults;

//Диалоговое окно значений по умолчанию моделей двигателя экскаватора
function esaShowExcavatorModelEngineDefaultsDlg(const AHelpKeyword: String): Boolean;
implementation

uses unDM, Globals;

{$R *.dfm}
//Диалоговое окно значений по умолчанию моделей двигателя экскаватора
function esaShowExcavatorModelEngineDefaultsDlg(const AHelpKeyword: String): Boolean;
begin
  fmExcavatorModelEngineDefaults := TfmExcavatorModelEngineDefaults.Create(nil);
  try
    fmExcavatorModelEngineDefaults.HelpKeyword := AHelpKeyword;
    Result := fmExcavatorModelEngineDefaults.ShowModal=mrOk;
  finally
    fmExcavatorModelEngineDefaults.Free;
  end;{try}
end;{esaShowExcavatorModelEngineDefaultsDlg}

procedure TfmExcavatorModelEngineDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  ledNmax.Text := FormatFloat('0.0',DefaultParams.ExcavatorEngineNmax);
end;{FormCreate}

procedure TfmExcavatorModelEngineDefaults.ledNmaxKeyPress(Sender: TObject;
  var Key: Char);
begin
  CheckFloatValueOnKeyPress(ledNmax.Text, Key);
end;{ledNmaxKeyPress}

procedure TfmExcavatorModelEngineDefaults.btOkClick(Sender: TObject);
var
  Value: Single;
begin
  ledNmax.Text := Trim(ledNmax.Text);
  try
    Value := StrToFloat(ledNmax.Text);
    if Value>=1.0 then
    begin
      DefaultParams.ExcavatorEngineNmax := Value;
      ModalResult := mrOk;
    end{if}
    else
    begin
      esaMsgError('Значение поля '''+CaptionToStr(ledNmax.EditLabel.Caption)+''' должно быть не меньше 1.0.');
      ledNmax.Text := FormatFloat('0.0',DefaultParams.ExcavatorEngineNmax);
      ledNmax.SetFocus;
    end;{else}
  except
    esaMsgError(Format('Введено неверное вещественное число ''%s''.',[ledNmax.Text]));
    ledNmax.Text := FormatFloat('0.0',DefaultParams.ExcavatorEngineNmax);
    ledNmax.SetFocus;
  end;{try}
end;{btOkClick}

end.
