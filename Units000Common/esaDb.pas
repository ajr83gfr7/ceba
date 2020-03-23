unit esaDb;
{
Елубаев С.А.
SuleymenE@mail.ru
Алматы, 2007/10/27
---------------------------------------------------------------------------------------------------------
1. Запросы к ТБД (2007/10/27)
2. Процедуры работы с ТБД (2007/10/27)
}

interface
uses ADODb, Db;
const
  SQL_GET_AUTOS_MAX_PARKNO          = 'SELECT MAX(ParkNo) AS MaxParkNo FROM OpenpitDeportAutos WHERE Id_Openpit=%d';
  SQL_GET_AUTOS_MAX_SORTINDEX       = 'SELECT MAX(SortIndex) AS MaxSortIndex FROM OpenpitDeportAutos WHERE Id_Openpit=%d';
  SQL_GET_SHIFTPUNKTS_ID_SHIFTPUNKT = 'SELECT Id_ShiftPunkt FROM OpenpitShiftPunkts WHERE Id_Openpit=%d ORDER BY SortIndex';
  SQL_DELETE_ALL_AUTOS              = 'DELETE FROM OpenpitDeportAutos WHERE Id_Openpit=%d';
  SQL_DELETE_AUTO                   = 'DELETE FROM OpenpitDeportAutos WHERE Id_DeportAuto=%d';
  SQL_MOVEUP_NEXT_AUTOS             = 'UPDATE OpenpitDeportAutos SET SortIndex=SortIndex-1 WHERE (Id_Openpit=%d)and(SortIndex>1)and(SortIndex>%d)';

  SQL_MOVEDN_PRIOR_AUTO             = 'UPDATE OpenpitDeportAutos SET SortIndex=SortIndex+1 WHERE (Id_Openpit=%d)and(SortIndex=%d-1)';
  SQL_MOVEUP_AUTO                   = 'UPDATE OpenpitDeportAutos SET SortIndex=SortIndex-1 WHERE (SortIndex>1)and(Id_DeportAuto=%d)';

  SQL_MOVEUP_NEXT_AUTO              = 'UPDATE OpenpitDeportAutos SET SortIndex=SortIndex-1 WHERE (Id_Openpit=%d)and(SortIndex>1)and(SortIndex=%d+1)';
  SQL_MOVEDN_AUTO                   = 'UPDATE OpenpitDeportAutos SET SortIndex=SortIndex+1 WHERE Id_DeportAuto=%d';
  SQL_CLONE_AUTO                    = 'INSERT INTO OpenpitDeportAutos'+
                                      '(Id_Openpit,Id_Auto,Id_ShiftPunkt,Id_Course,SortIndex,ParkNo,AYear,WorkState,FactTonnage,Cost,AmortizationRate,TransmissionKPD,EngineKPD,TyreCost,TyresRaceRate)'+
                                      'VALUES (%d,%d,%d,NULL,%d,%d,%d,%s,%d/100000,%d/100000,%d/100000,%d/100000,%d/100000,%d/100000,%d/100000)';
//I. Процедуры работы с ТБД -----------------------------------------------------------------------------
//Проверка при закрытии на сохранение изменений в таблице БД
function esaCanCloseModifiedQuery(AQuery: TADOQuery; const ATable: String): Boolean;
//Проверка принадлежности значения целочисленного поля диапазону
function esaIntegerFieldValueIn(AField: TField; const AMin,AMax: Integer; var AError: String): Boolean;
//Проверка принадлежности значения вещественного поля диапазону
function esaFloatFieldValueIn1(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
function esaFloatFieldValueIn2(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
function esaFloatFieldValueIn3(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
function esaFloatFieldValueIn4(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
//Обновление Query
procedure esaRequeryDataSet(ADataSet: TDataSet); overload;
procedure esaRequeryDataSet(ADataSet: TDataSet; const AField: String; const AFieldValue: Integer); overload;
//II. Запросы к ТБД -------------------------------------------------------------------------------------
function stpSelect(AQuery: TADOQuery; const ASQL: String; var AError: String): Boolean; overload;
function stpSelect(AQuery: TADOQuery; const ASQLFormat: String; const ASQLArgs: array of const; var AError: String): Boolean; overload;
function stpGetValue(AQuery: TADOQuery; const AField,ASQLFormat: String; const ASQLArgs: array of const; var Value: Integer; var AError: String): Boolean; overload;
function stpExec(AQuery: TADOQuery; const ASQL: String; var AError: String): Boolean; overload;
function stpExec(AQuery: TADOQuery; const ASQLFormat: String; const ASQLArgs: array of const; var AError: String): Boolean; overload;
function stpAUTOS_DELETE(AQuery: TADOQuery; const AId_Openpit,AId_Auto,ASortIndex: Integer; var AError: String): Boolean;
function stpAUTOS_DELETE_ALL(AQuery: TADOQuery; const AId_Openpit: Integer; var AError: String): Boolean;
function stpAUTOS_MOVEUP(AQuery: TADOQuery; const AId_Openpit,AId_Auto,ASortIndex: Integer; var AError: String): Boolean;
function stpAUTOS_MOVEDOWN(AQuery: TADOQuery; const AId_Openpit,AId_Auto,ASortIndex: Integer; var AError: String): Boolean;
//Клонирование автосамосвала списочного парка
function stpAUTOS_CLONE(AQuery: TADOQuery;
  const AId_Openpit,AId_AutoModel: Integer;
  const ASortIndex,AParkNo       : Integer;
  const AYear                    : Integer;
  const AWorkState               : Boolean;
  const AQtn,ABalanceC1000tg     : Single;
  const AAmortizationR1000km     : Single;
  const ATransmissionKPD         : Single;
  const AEngineKPD               : Single;
  const ATyreC1000tg             : Single;
  const ATyresAmortizationR1000km: Single;
  const AId_ShiftPunkt           : Integer;
  var   AError                   : String): Boolean;
implementation
uses SysUtils, esaDialogs, esaMessages, Math;

//I. Процедуры работы с ТБД -----------------------------------------------------------------------------
//Проверка при закрытии на сохранение изменений в таблице БД
function esaCanCloseModifiedQuery(AQuery: TADOQuery; const ATable: String): Boolean;
begin
  Result := True;
  if AQuery.Active and(AQuery.State in [dsEdit,dsInsert])then
  case esaMsgQuestionYNC(SesaChangesSavingConfirm,[ATable])of
    mqkYes   : AQuery.Post;
    mqkNo    : AQuery.Cancel;
    mqkCancel: Result := False;
  end;{case}
end;{esaCanCloseModifiedQuery}
//Проверка принадлежности значения целочисленного поля диапазону
function esaIntegerFieldValueIn(AField: TField; const AMin,AMax: Integer; var AError: String): Boolean;
begin
  Result := False;
  AError := '';
  try
    if AField.IsNull then AField.AsInteger := 0;
    Result := InRange(AField.AsInteger,AMin,AMax);
    if not Result
    then AError := Format(EesaInvalidIntegerFieldValue,[AField.AsInteger,AField.DisplayLabel,AMin,AMax]);
  except
    on E: Exception do AError := Format(EesaInvalidIntegerField,[E.Message]);
  end;{try}
end;{esaIntegerFieldValueIn}
//Проверка принадлежности значения вещественного поля диапазону
function esaFloatFieldValueIn1(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
begin
  Result := False;
  AError := '';
  try
    if AField.IsNull then AField.AsFloat := 0.0;
    Result := InRange(Round(10*AField.AsFloat),Round(10*AMin),Round(10*AMax));
    if not Result
    then AError := Format(EesaInvalidFloatFieldValue1,[AField.AsFloat,AField.DisplayLabel,AMin,AMax]);
  except
    on E: Exception do AError := Format(EesaInvalidFloatField,[E.Message]);
  end;{try}
end;{esaFloatFieldValueIn1}
function esaFloatFieldValueIn2(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
begin
  Result := False;
  AError := '';
  try
    if AField.IsNull then AField.AsFloat := 0.0;
    Result := InRange(Round(100*AField.AsFloat),Round(100*AMin),Round(100*AMax));
    if not Result
    then AError := Format(EesaInvalidFloatFieldValue2,[AField.AsFloat,AField.DisplayLabel,AMin,AMax]);
  except
    on E: Exception do AError := Format(EesaInvalidFloatField,[E.Message]);
  end;{try}
end;{esaFloatFieldValueIn2}
function esaFloatFieldValueIn3(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
begin
  Result := False;
  AError := '';
  try
    if AField.IsNull then AField.AsFloat := 0.0;
    Result := InRange(Round(1000*AField.AsFloat),Round(1000*AMin),Round(1000*AMax));
    if not Result
    then AError := Format(EesaInvalidFloatFieldValue3,[AField.AsFloat,AField.DisplayLabel,AMin,AMax]);
  except
    on E: Exception do AError := Format(EesaInvalidFloatField,[E.Message]);
  end;{try}
end;{esaFloatFieldValueIn3}
function esaFloatFieldValueIn4(AField: TField; const AMin,AMax: Single; var AError: String): Boolean;
begin
  Result := False;
  AError := '';
  try
    if AField.IsNull then AField.AsFloat := 0.0;
    Result := InRange(Round(10000*AField.AsFloat),Round(10000*AMin),Round(10000*AMax));
    if not Result
    then AError := Format(EesaInvalidFloatFieldValue4,[AField.AsFloat,AField.DisplayLabel,AMin,AMax]);
  except
    on E: Exception do AError := Format(EesaInvalidFloatField,[E.Message]);
  end;{try}
end;{esaFloatFieldValueIn4}
//Обновление Query
procedure esaRequeryDataSet(ADataSet: TDataSet);
var ARecNo: Integer;
begin
  ARecNo := ADataset.RecNo;
  TADOQuery(ADataset).Requery;
  ADataset.MoveBy(ARecNo-1);
end;{esaRequeryDataSet}
procedure esaRequeryDataSet(ADataSet: TDataSet; const AField: String; const AFieldValue: Integer);
begin
  esaRequeryDataSet(ADataSet);
  ADataSet.Locate(AField,AFieldValue,[]);
end;{esaRequeryDataSet}
//II. Запросы к ТБД -------------------------------------------------------------------------------------
function stpSelect(AQuery: TADOQuery; const ASQL: String; var AError: String): Boolean;
begin
  Result := False;
  try
    AQuery.SQL.Text := ASQL;
    AQuery.Open;
    Result := True;
  except
    on E: Exception do AError := E.Message
  end;{try}
end;{stpSelect}
function stpSelect(AQuery: TADOQuery; const ASQLFormat: String; const ASQLArgs: array of const; var AError: String): Boolean; 
begin
  Result := stpSelect(AQuery,Format(ASQLFormat,ASQLArgs),AError);
end;{stpSelect}
function stpGetValue(AQuery: TADOQuery; const AField,ASQLFormat: String; const ASQLArgs: array of const; var Value: Integer; var AError: String): Boolean; 
begin
  Value := 0;
  Result := stpSelect(AQuery,ASQLFormat,ASQLArgs,AError);
  if Result then
  begin
    if AQuery.RecordCount>0
    then Value := AQuery.FieldByName(AField).AsInteger;
    AQuery.Close;
  end;{if}
end;{stpGetValue}
function stpExec(AQuery: TADOQuery; const ASQL: String; var AError: String): Boolean; 
begin
  Result := False;
  try
    AQuery.SQL.Text := ASQL;
    AQuery.ExecSQL;
    Result := True;
  except
    on E: Exception do AError := E.Message
  end;{try}
end;{stpExec}
function stpExec(AQuery: TADOQuery; const ASQLFormat: String; const ASQLArgs: array of const; var AError: String): Boolean; 
begin
  Result := stpExec(AQuery,Format(ASQLFormat,ASQLArgs),AError);
end;{stpExec}
function stpAUTOS_DELETE(AQuery: TADOQuery; const AId_Openpit,AId_Auto,ASortIndex: Integer; var AError: String): Boolean;
begin
  AError := '';
  Result := False;
  try
    AQuery.Connection.BeginTrans;
    if stpExec(AQuery,SQL_MOVEUP_NEXT_AUTOS,[AId_Openpit,ASortIndex],AError)and
       stpExec(AQuery,SQL_DELETE_AUTO,[AId_Auto],AError)then
    begin
      AQuery.Connection.CommitTrans;
      Result := True;
    end{if}
    else AQuery.Connection.RollbackTrans;
  except
    on E: Exception do AError := E.Message;
  end;{try}
  if (not Result)and(AError<>'')then AError := Format(EesaInvalidDeleteAutos,[AError]);
end;{stpAUTOS_DELETE} 
function stpAUTOS_DELETE_ALL(AQuery: TADOQuery; const AId_Openpit: Integer; var AError: String): Boolean;
begin
  AError := '';
  Result := False;
  try
    AQuery.Connection.BeginTrans;
    if stpExec(AQuery,SQL_DELETE_ALL_AUTOS,[AId_Openpit],AError)then
    begin
      AQuery.Connection.CommitTrans;
      Result := True;
    end{if}
    else AQuery.Connection.RollbackTrans;
  except
    on E: Exception do AError := E.Message;
  end;{try}
  if (not Result)and(AError<>'')then AError := Format(EesaInvalidDeleteAutos,[AError]);
end;{stpAUTOS_DELETE_ALL}
function stpAUTOS_MOVEUP(AQuery: TADOQuery; const AId_Openpit,AId_Auto,ASortIndex: Integer; var AError: String): Boolean;
begin
  AError := '';
  Result := False;
  try
    AQuery.Connection.BeginTrans;
    if stpExec(AQuery,SQL_MOVEDN_PRIOR_AUTO,[AId_Openpit,ASortIndex],AError)AND
       stpExec(AQuery,SQL_MOVEUP_AUTO,[AId_Auto],AError)then
    begin
      AQuery.Connection.CommitTrans;
      Result := True;
    end{if}
    else AQuery.Connection.RollbackTrans;
  except
    on E: Exception do AError := E.Message;
  end;{try}
  if (not Result)and(AError<>'')then AError := Format(EesaInvalidMoveUpAuto,[AError]);
end;{stpAUTOS_MOVEUP}
function stpAUTOS_MOVEDOWN(AQuery: TADOQuery; const AId_Openpit,AId_Auto,ASortIndex: Integer; var AError: String): Boolean;
begin
  AError := '';
  Result := False;
  try
    AQuery.Connection.BeginTrans;
    if stpExec(AQuery,SQL_MOVEUP_NEXT_AUTO,[AId_Openpit,ASortIndex],AError)AND
       stpExec(AQuery,SQL_MOVEDN_AUTO,[AId_Auto],AError)then
    begin
      AQuery.Connection.CommitTrans;
      Result := True;
    end{if}
    else AQuery.Connection.RollbackTrans;
  except
    on E: Exception do AError := E.Message;
  end;{try}
  if (not Result)and(AError<>'')then AError := Format(EesaInvalidMoveDnAuto,[AError]);
end;{stpAUTOS_MOVEDOWN}
//Клонирование автосамосвала списочного парка
function stpAUTOS_CLONE(AQuery: TADOQuery;
  const AId_Openpit,AId_AutoModel: Integer;
  const ASortIndex,AParkNo       : Integer;
  const AYear                    : Integer;
  const AWorkState               : Boolean;
  const AQtn,ABalanceC1000tg     : Single;
  const AAmortizationR1000km     : Single;
  const ATransmissionKPD         : Single;
  const AEngineKPD               : Single;
  const ATyreC1000tg             : Single;
  const ATyresAmortizationR1000km: Single;
  const AId_ShiftPunkt           : Integer;
  var   AError                   : String): Boolean;
const
  WORKSTATE: array[Boolean] of String = ('FALSE','TRUE');
begin
  AError := '';
  Result := False;
  try
    if stpExec(AQuery,SQL_CLONE_AUTO,[AId_Openpit,
               AId_AutoModel,
               AId_ShiftPunkt,
               ASortIndex,
               AParkNo,
               AYear,
               WORKSTATE[AWorkState],
               Round(1E5*AQtn),
               Round(1E5*ABalanceC1000tg),
               Round(1E5*AAmortizationR1000km),
               Round(1E5*ATransmissionKPD),
               Round(1E5*AEngineKPD),
               Round(1E5*ATyreC1000tg),
               Round(1E5*ATyresAmortizationR1000km)],AError)
    then Result := True;
  except
    on E: Exception do AError := E.Message;
  end;{try}
  if (not Result)and(AError<>'')then AError := Format(EesaInvalidCloneAutos,[AError]);
end;{SaveAutoParams}

end.
