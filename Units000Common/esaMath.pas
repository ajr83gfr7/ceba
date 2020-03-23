unit esaMath;
{
������� �.�.
SuleymenE@mail.ru
������, 2007/10/26
---------------------------------------------------------------------------------------------------------
������ ������ � ��������� ����������, � �������������� ����������
}

interface
//I. ������� �������� � ������������� �������� ----------------------------------------------------------
//������� �������� ���������� �������� � �������������
function esaStrToInt(const S: String; const AMin,AMax: Integer; var Value: Integer; var AError: String): Boolean; overload;
function esaStrToInt(const S: String; var Value: Integer; var AError: String): Boolean; overload;
implementation
uses esaMessages, SysUtils, Math;

//I. ������� �������� � ������������� �������� ----------------------------------------------------------
//������� �������� ���������� �������� � �������������
function esaStrToInt(const S: String; const AMin,AMax: Integer; var Value: Integer; var AError: String): Boolean;
begin
  Result := False;
  if esaStrToInt(S,Value,AError) then //���������� ������������� ��������
  if (AMin<=AMax)and(0<AMax)and(not InRange(Value,AMin,AMax))
  then AError := Format(EesaInvalidIntegerValueRange,[Value,AMin,AMax])
  else Result := True;
end;{esaStrToInt}
function esaStrToInt(const S: String; var Value: Integer; var AError: String): Boolean;
var AErrorCode: Integer;
begin
  Val(S,Value,AErrorCode);
  Result := AErrorCode=0;
  if not Result then
  if S<>''
  then AError := Format(EesaInvalidCharacter,[S[AErrorCode],S])
  else AError := Format(EesaInvalidCharacter,['',S]);
end;{esaStrToInt}

end.
