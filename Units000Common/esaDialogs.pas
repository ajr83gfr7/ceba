unit esaDialogs;
{
Елубаев С.А.
SuleymenE@mail.ru
Алматы, 2007/10/26
---------------------------------------------------------------------------------------------------------
1. Пользовательские сообщения: об ошибке, информативные, подтверждение действия (2007/10/26)
2. Диалоговые окна ввода одиночного текстового/целого значения (2007/10/26)
}
interface
resourcestring
  //Заголовки пользовательских сообщений ----------------------------------------------------------------
  SesaMsgErrorTitle       = 'Ошибка';
  SesaMsgInformationTitle = 'Информация';
  SesaMsgQuestionTitle    = 'Подтверждение';
type
  TesaMsgQuestionKind = (mqkYes,mqkNo,mqkCancel);

//I. Пользовательские сообщения -------------------------------------------------------------------------
//Сообщение об ошибке
procedure esaMsgError(const AMsg: String); overload;
procedure esaMsgError(const AFormat: String; const AArgs: array of const); overload;
//Сообщение подтверждения Yes/No
function esaMsgQuestionYN(const AMsg: String): Boolean; overload;
function esaMsgQuestionYN(const AFormat: String; const AArgs: array of const): Boolean; overload;
//Сообщение подтверждения Yes/No/Cancel
function esaMsgQuestionYNC(const AMsg: String): TesaMsgQuestionKind; overload;
function esaMsgQuestionYNC(const AFormat: String; const AArgs: array of const): TesaMsgQuestionKind; overload;
//Сообщение об информации
procedure esaMsgInformation(const AMsg: String); overload;
procedure esaMsgInformation(const AFormat: String; const AArgs: array of const); overload;

implementation
uses
  Forms, SysUtils, Windows;

//I. Пользовательские сообщения -------------------------------------------------------------------------
//Сообщение об ошибке
procedure esaMsgError(const AMsg: String);
begin
  Application.MessageBox(PChar(AMsg),PChar(SesaMsgErrorTitle),MB_ICONERROR);
end;{esaMsgError}
procedure esaMsgError(const AFormat: String; const AArgs: array of const);
begin
  esaMsgError(Format(AFormat,AArgs));
end;{esaMsgError}
//Сообщение подтверждения Yes/No
function esaMsgQuestionYN(const AMsg: String): Boolean;
begin
  Result := Application.MessageBox(PChar(AMsg),PChar(SesaMsgQuestionTitle),
                                   MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2)=IDYES;
end;{esaMsgQuestionYN}
function esaMsgQuestionYN(const AFormat: String; const AArgs: array of const): Boolean;
begin
  Result := esaMsgQuestionYN(Format(AFormat,AArgs));
end;{esaMsgQuestionYN}
//Сообщение подтверждения Yes/No/Cancel
function esaMsgQuestionYNC(const AMsg: String): TesaMsgQuestionKind;
begin
  case Application.MessageBox(PChar(AMsg),PChar(SesaMsgQuestionTitle),MB_ICONQUESTION+MB_YESNOCANCEL+MB_DEFBUTTON1) of
    IDYES: Result := mqkYes;
    IDNO : Result := mqkNo;
    else   Result := mqkCancel;
  end;{case}
end;{esaMsgQuestionYNC}
function esaMsgQuestionYNC(const AFormat: String; const AArgs: array of const): TesaMsgQuestionKind;
begin
  Result := esaMsgQuestionYNC(Format(AFormat,AArgs));
end;{esaMsgQuestionYNC}
//Сообщение об информации
procedure esaMsgInformation(const AMsg: String);
begin
  SysUtils.Beep;
  Application.MessageBox(PChar(AMsg),PChar(SesaMsgInformationTitle),MB_ICONINFORMATION);
end;{esaMsgInformation}
procedure esaMsgInformation(const AFormat: String; const AArgs: array of const);
begin
  esaMsgInformation(Format(AFormat,AArgs));
end;{esaMsgInformation}

end.
