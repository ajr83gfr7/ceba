unit esaInputValueDlgs;
{
������� �.�.
SuleymenE@mail.ru
������, 2007/10/26
---------------------------------------------------------------------------------------------------------
1. ���������� ���� ����� ���������� ���������� �������� (2007/10/26)
2. ���������� ���� ����� ���������� ������ �������� (2007/10/26)
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
    FAllowBlank: Boolean;              //���������� ����� ������� ��������
    FKind      : TfmInputValueDlgKind; //��� ����������� ����
    FMin       : Integer;              //����������� �������� ������ �����
    FMax       : Integer;              //������������ �������� ������ �����
  protected
    property AllowBlank: Boolean read FAllowBlank;
    property Kind      : TfmInputValueDlgKind read FKind;
  public
  end;{TfmInputValueDlg}

var
  fmInputValueDlg: TfmInputValueDlg;

//���������� ���� ����� ���������� ���������� ��������
function esaShowInputValueDlg(const ACaption,APrompt: String; //��������� �����, ���� �����
                              var   Value           : String; //��������
                              const AMaxLength      : Word;   //������������ ����� ��������
                              const AAllowBlank     : Boolean = False): Boolean; overload; //���������� ����� ������� ��������
//���������� ���� ����� ���������� ������ ��������
function esaShowInputValueDlg(const ACaption,APrompt: String;  //��������� �����, ���� �����
                              var   Value           : Integer; //��������
                              const AMin,AMax       : Integer): Boolean; overload; //������������ ����� ��������
implementation

uses esaMessages, esaMath, Math, esaDialogs;

{$R *.dfm}
//���������� ���� ����� ���������� ���������� ��������
function esaShowInputValueDlg(const ACaption,APrompt: String; //��������� �����, ���� �����
                              var   Value           : String; //��������
                              const AMaxLength      : Word;   //������������ ����� ��������
                              const AAllowBlank     : Boolean = False): Boolean; //���������� ����� ������� ��������
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
//���������� ���� ����� ���������� ������ ��������
function esaShowInputValueDlg(const ACaption,APrompt: String;  //��������� �����, ���� �����
                              var   Value           : Integer; //��������
                              const AMin,AMax       : Integer): Boolean;//������������ ����� ��������
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
  if ((Kind=ivdkIntegerValue)or((Kind=ivdkTextValue)and(not AllowBlank)))AND(ledValue.Text='') //�������� �������?
  then esaMsgError(EesaInvalidValue,[ledValue.EditLabel.Caption])else
  if (Kind=ivdkIntegerValue)and(not esaStrToInt(ledValue.Text,Value,AError))                   //������������� �������� ���������?
  then esaMsgError(AError)else
  if (Kind=ivdkIntegerValue)and(FMin<=FMax)and(FMin>0)and(not InRange(Value,FMin,FMax))        //������������� �������� � ���������?
  then esaMsgError(EesaInvalidIntegerValueRange,[Value,FMin,FMax])           
  else ModalResult := mrOk;
end;{btOkClick}

end.
