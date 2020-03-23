unit esaInputValueDlgs;
{
Елубаев С.А.
SuleymenE@mail.ru
Алматы, 2007/10/26
---------------------------------------------------------------------------------------------------------
1. Диалоговое окно ввода одиночного текстового значения (2007/10/26)
2. Диалоговое окно ввода одиночного целого значения (2007/10/26)
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TfmInputValueDlgKind = (ivdkTextValue,ivdkIntegerValue);
  TfmInputValueDlg = class(TForm)
    ledValue: TLabeledEdit;
    btOk    : TButton;
    btCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ledValueKeyPress(Sender: TObject; var Key: Char);
    procedure btOkClick(Sender: TObject);
  private
    FAllowBlank: Boolean;              //Разрешение ввода пустого значения
    FKind      : TfmInputValueDlgKind; //Тип диалогового окна
    FMin       : Integer;              //Минимальное значение целого числа
    FMax       : Integer;              //Максимальное значение целого числа
  protected
    property AllowBlank: Boolean read FAllowBlank;
    property Kind      : TfmInputValueDlgKind read FKind;
  public
  end;{TfmInputValueDlg}

var
  fmInputValueDlg: TfmInputValueDlg;

//Диалоговое окно ввода одиночного текстового значения
function esaShowInputValueDlg(const ACaption,APrompt: String; //Заголовок формы, окна ввода
                              var   Value           : String; //Значение
                              const AMaxLength      : Word;   //Максимальная длина значения
                              const AAllowBlank     : Boolean = False): Boolean; overload; //Разрешение ввода пустого значения
//Диалоговое окно ввода одиночного целого значения
function esaShowInputValueDlg(const ACaption,APrompt: String;  //Заголовок формы, окна ввода
                              var   Value           : Integer; //Значение
                              const AMin,AMax       : Integer): Boolean; overload; //Максимальная длина значения
implementation

uses esaMessages, esaMath, Math, esaDialogs;

{$R *.dfm}
//Диалоговое окно ввода одиночного текстового значения
function esaShowInputValueDlg(const ACaption,APrompt: String; //Заголовок формы, окна ввода
                              var   Value           : String; //Значение
                              const AMaxLength      : Word;   //Максимальная длина значения
                              const AAllowBlank     : Boolean = False): Boolean; //Разрешение ввода пустого значения
begin
  Result := False;
  fmInputValueDlg := TfmInputValueDlg.Create(nil);
  try
    fmInputValueDlg.FKind                      := ivdkTextValue;
    fmInputValueDlg.Caption                    := ACaption;
    fmInputValueDlg.ledValue.EditLabel.Caption := APrompt;
    fmInputValueDlg.ledValue.MaxLength         := AMaxLength;
    fmInputValueDlg.ledValue.Text              := Value;
    fmInputValueDlg.FAllowBlank                := AAllowBlank;
    if fmInputValueDlg.ShowModal= mrOk then
    begin
      Value  := fmInputValueDlg.ledValue.Text;
      Result := True;
    end;{if}
  finally
    fmInputValueDlg.Free;
  end;{try}
end;{esaShowInputValueDlg}
//Диалоговое окно ввода одиночного целого значения
function esaShowInputValueDlg(const ACaption,APrompt: String;  //Заголовок формы, окна ввода
                              var   Value           : Integer; //Значение
                              const AMin,AMax       : Integer): Boolean;//Максимальная длина значения
begin
  Result := False;
  fmInputValueDlg := TfmInputValueDlg.Create(nil);
  try
    fmInputValueDlg.FKind                      := ivdkIntegerValue;
    fmInputValueDlg.Caption                    := ACaption;
    fmInputValueDlg.ledValue.EditLabel.Caption := APrompt;
    fmInputValueDlg.FAllowBlank                := False;
    fmInputValueDlg.FMin                       := AMin;
    fmInputValueDlg.FMax                       := AMax;
    fmInputValueDlg.ledValue.Text              := IntToStr(Value);
    if fmInputValueDlg.ShowModal= mrOk then
    begin
      Value  := StrToInt(fmInputValueDlg.ledValue.Text);
      Result := True;
    end;{if}
  finally
    fmInputValueDlg.Free;
  end;{try}
end;{esaShowInputValueDlg}

procedure TfmInputValueDlg.FormCreate(Sender: TObject);
begin
  FAllowBlank := False;
  FKind       := ivdkIntegerValue;
  FMin        := 0; 
  FMax        := 0; 
end;{FormCreate}

procedure TfmInputValueDlg.ledValueKeyPress(Sender: TObject; var Key: Char);
begin
  if (Kind=ivdkIntegerValue)and(not(Key in ['0'..'9',#8])) then
  begin
    Beep;
    Key := #0;
  end;{if}
end;{ledValueKeyPress}

procedure TfmInputValueDlg.btOkClick(Sender: TObject);
var
  Value : Integer;
  AError: String;
begin
  ledValue.Text := Trim(ledValue.Text);
  if ((Kind=ivdkIntegerValue)or((Kind=ivdkTextValue)and(not AllowBlank)))AND(ledValue.Text='') //значение введено?
  then esaMsgError(EesaInvalidValue,[ledValue.EditLabel.Caption])else
  if (Kind=ivdkIntegerValue)and(not esaStrToInt(ledValue.Text,Value,AError))                   //целочисленное значение корректно?
  then esaMsgError(AError)else
  if (Kind=ivdkIntegerValue)and(FMin<=FMax)and(FMin>0)and(not InRange(Value,FMin,FMax))        //целочисленное значение в диапазоне?
  then esaMsgError(EesaInvalidIntegerValueRange,[Value,FMin,FMax])           
  else ModalResult := mrOk;
end;{btOkClick}

end.
