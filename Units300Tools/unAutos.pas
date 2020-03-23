unit unAutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ComCtrls, Menus, Db;//, GridsEh;

type
  TfmAutos = class(TForm)
    dbgAutos           : TDBGridEh;
    pmAutos            : TPopupMenu;
    pmiAutosAdd        : TMenuItem;
    pmiAutosEdit       : TMenuItem;
    pmiAutosDelete     : TMenuItem;
    pmiAutosDeleteAll  : TMenuItem;
    pmiAutosSep1       : TMenuItem;
    pmiAutosClone      : TMenuItem;
    pmiAutosSep2       : TMenuItem;
    pmiAutosUp         : TMenuItem;
    pmiAutosDown       : TMenuItem;
    pmiAutosSep3       : TMenuItem;
    pmiAutosDefault    : TMenuItem;
    pmiAutosDefaults   : TMenuItem;
    pmiSep4            : TMenuItem;
    pmiAutosExcel      : TMenuItem;
    pmiSep5: TMenuItem;
    pmiAutosExport: TMenuItem;
    pmiAutosImport: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pmAutosPopup(Sender: TObject);
    procedure pmiAutosAddClick(Sender: TObject);
    procedure pmiAutosEditClick(Sender: TObject);
    procedure pmiAutosDeleteClick(Sender: TObject);
    procedure pmiAutosDeleteAllClick(Sender: TObject);
    procedure pmiAutosCloneClick(Sender: TObject);
    procedure pmiAutosUpClick(Sender: TObject);
    procedure pmiAutosDownClick(Sender: TObject);
    procedure pmiAutosDefaultClick(Sender: TObject);
    procedure pmiAutosDefaultsClick(Sender: TObject);
    procedure pmiAutosExcelClick(Sender: TObject);
    procedure pmiAutosExportClick(Sender: TObject);
    procedure pmiAutosImportClick(Sender: TObject);
  private
    FSortIndex: Integer; //Порядковый номер
    FParkNo   : Integer; //Гаражный номер
    //Обработка событий
    procedure DoAfterInsert(DataSet: TDataSet);
    procedure DoAfterPost(DataSet: TDataSet);
    procedure DoBeforeDelete(DataSet: TDataSet);
    procedure DoBeforeInsert(DataSet: TDataSet);
    procedure DoBeforePost(DataSet: TDataSet);
    procedure DoDataChange(Sender: TObject; Field: TField);
  protected
    property SortIndex: Integer read FSortIndex; 
    property ParkNo   : Integer read FParkNo; 
  end;{TfmAutos}

var
  fmAutos: TfmAutos;

//Диалоговое окно автосамосвалов списочного парка
procedure esaShowAutosDlg();
implementation

uses unDM, esaMessages, ADODb, esaInputValueDlgs, esaDialogs, esaDb,
  unAutoDefaults, esaExcelEditors, Math;

{$R *.dfm}
//Диалоговое окно автосамосвалов списочного парка
procedure esaShowAutosDlg();
begin
  fmAutos := TfmAutos.Create(nil);
  try
    fmAutos.ShowModal;
  finally
    fmAutos.Free;
  end;{try}
end;{esaShowAutosDlg}

procedure TfmAutos.DoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(ParkNo>0) then
  begin
    Dataset.FieldByName('SortIndex').AsInteger      := SortIndex;
    Dataset.FieldByName('ParkNo').AsInteger         := ParkNo;
    Dataset.FieldByName('Id_Auto').AsInteger        := DefaultParams.DeportAutoId_Auto;
    Dataset.FieldByName('AYear').AsInteger          := DefaultParams.DeportAutoAYear;
    Dataset.FieldByName('WorkState').AsBoolean      := DefaultParams.DeportAutoWorkState;
    Dataset.FieldByName('FactTonnage').AsFloat      := DefaultParams.DeportAutoFactTonnage;
    Dataset.FieldByName('Cost').AsFloat             := DefaultParams.DeportAutoCost;
    Dataset.FieldByName('AmortizationRate').AsFloat := DefaultParams.DeportAutoAmortizationRate;
    Dataset.FieldByName('TransmissionKPD').AsFloat  := DefaultParams.DeportAutoTransmissionKPD;
    Dataset.FieldByName('EngineKPD').AsFloat        := DefaultParams.DeportAutoEngineKPD;
    Dataset.FieldByName('TyreCost').AsFloat         := DefaultParams.DeportAutoTyreCost;
    Dataset.FieldByName('TyresRaceRate').AsFloat    := DefaultParams.DeportAutoTyresRaceRate;
  end;{if}
end;{DoAfterInsert}
procedure TfmAutos.DoAfterPost(DataSet: TDataSet);
begin
  esaRequeryDataSet(DataSet);
end;{DoAfterPost}
procedure TfmAutos.DoBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;{DoBeforeDelete}
procedure TfmAutos.DoBeforeInsert(DataSet: TDataSet);
var
  Value : Integer;
  AError: String;
  Result: Boolean;
begin
  FSortIndex := Dataset.RecordCount+1;
  FParkNo    := 0;
  AError     := '';
  Result     := False;
  if stpGetValue(fmDM.Query,'MaxParkNo',SQL_GET_AUTOS_MAX_PARKNO,[fmDM.quOpenpitsId_Openpit.AsInteger],Value,AError)then
  begin//Определили максимальный гаражный номер
    Inc(Value);
    if esaShowInputValueDlg(SesaOperationAdd,SesaAutoParkNo,Value,1,MaxInt) then 
    if DataSet.Locate('ParkNo',Value,[])
    then AError := Format(EesaAutosDuplicateParkNo,[Value])
    else Result := True;
  end;{if}
  if AError<>'' then esaMsgError(AError);
  if Result then FParkNo := Value else Abort;
end;{DoBeforeInsert}
procedure TfmAutos.DoBeforePost(DataSet: TDataSet);
var
  AId_ShiftPunkt: Integer;
  AError        : String;
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    //Проверка заполненности полей
    if Dataset.FieldbyName('WorkState').IsNull
    then Dataset.FieldbyName('WorkState').AsBoolean := True;
    if Dataset.FieldbyName('Id_Auto').IsNull
    then Dataset.FieldbyName('Id_Auto').AsInteger := DefaultParams.DeportAutoId_Auto;
    //Проверка значений полей
    if (not esaIntegerFieldValueIn(DataSet.FieldByName('AYear'),1950,MaxInt,AError))OR
       (not esaIntegerFieldValueIn(DataSet.FieldByName('ParkNo'),1,MaxInt,AError))OR
       (not esaFloatFieldValueIn2(DataSet.FieldByName('Cost'),0.01,MaxInt,AError))OR
       (not esaFloatFieldValueIn1(DataSet.FieldByName('FactTonnage'),1.0,MaxInt,AError))OR
       (not esaFloatFieldValueIn4(DataSet.FieldByName('AmortizationRate'),0.0001,MaxInt,AError))OR
       (not esaFloatFieldValueIn1(DataSet.FieldByName('TransmissionKPD'),0.1,1.0,AError))OR
       (not esaFloatFieldValueIn1(DataSet.FieldByName('EngineKPD'),0.1,1.0,AError))OR
       (not esaFloatFieldValueIn2(DataSet.FieldByName('TyreCost'),1.00,MaxInt,AError))OR
       (not esaFloatFieldValueIn1(DataSet.FieldByName('TyresRaceRate'),1.0,MaxInt,AError))then
    begin
      esaMsgError(AError); Abort;
    end;{if}
    //Проверка полей "Гаражный номер", "Пункт погрузки", "Маршрут" при добавлении новой записи
    if (Dataset.State=dsInsert)and(ParkNo>0) then
    begin
      DataSet.FieldByName('ParkNo').AsInteger := ParkNo;
      stpGetValue(fmDM.Query,'Id_ShiftPunkt',SQL_GET_SHIFTPUNKTS_ID_SHIFTPUNKT,[fmDM.quOpenpitsId_Openpit.AsInteger],AId_ShiftPunkt,AError);
      if AId_ShiftPunkt>0
      then DataSet.FieldByName('Id_ShiftPunkt').AsInteger := AId_ShiftPunkt
      else DataSet.FieldByName('Id_ShiftPunkt').Clear;
      DataSet.FieldByName('Id_Course').Clear;
    end;{if}
  end;{if}
end;{DoBeforePost}
procedure TfmAutos.DoDataChange(Sender: TObject; Field: TField);
begin
  dbgAutos.Columns[1].Footers[0].Value := '';
  dbgAutos.Columns[0].Footers[1].Value := '';
  if fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0) then
  begin
    dbgAutos.Columns[1].Footers[0].Value := Format('%s (%.1f т)',[fmDM.quDeportAutosName.AsString,fmDM.quDeportAutosNetQtn.AsFloat]);
    dbgAutos.Columns[0].Footers[1].Value := Format('%d',[fmDM.quDeportAutos.RecordCount]);
  end;{if}
end;{DoDataChange}

procedure TfmAutos.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy('fmDeportAutos',3,Length('fmDeportAutos')-2);
  OpenDialog.InitialDir := ExtractFileDir(Application.ExeName);
  SaveDialog.InitialDir := ExtractFileDir(Application.ExeName);
  FParkNo    := 0;
  FSortIndex := 0;
  with fmDM do
  begin
    quAutoEngines.Open;
    if quAutoEngines.RecordCount=0
    then raise Exception.Create(EesaAutoEnginesEmpty);
    quAutos.Open;
    if quAutos.RecordCount=0
    then raise Exception.Create(EesaAutoModelsEmpty);
    if not quAutos.Locate('Id_Auto',DefaultParams.DeportAutoId_Auto,[])
    then DefaultParams.DeportAutoId_Auto := quAutosId_Auto.AsInteger;
    quAutoEngines.First;
    quDeportAutos.BeforeDelete := DoBeforeDelete;
    quDeportAutos.BeforeInsert := DoBeforeInsert;
    quDeportAutos.BeforePost   := DoBeforePost;
    quDeportAutos.AfterInsert  := DoAfterInsert;
    quDeportAutos.AfterPost    := DoAfterPost;
    dsDeportAutos.OnDataChange := DoDataChange;
    quDeportAutos.Open;
  end;{with}
end;{FormCreate}
procedure TfmAutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quDeportAutos.Close;
    quAutos.Close;
    quAutoEngines.Close;
    quDeportAutos.BeforeDelete := nil;
    quDeportAutos.BeforeInsert := nil;
    quDeportAutos.BeforePost   := nil;
    quDeportAutos.AfterInsert  := nil;
    quDeportAutos.AfterPost    := nil;
    dsDeportAutos.OnDataChange := nil;
  end;{with}
end;{FormClose}
procedure TfmAutos.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := esaCanCloseModifiedQuery(fmDM.quDeportAutos,Caption);
end;{FormCloseQuery}

procedure TfmAutos.pmAutosPopup(Sender: TObject);
begin
  pmiAutosAdd.Enabled       := fmDM.quDeportAutos.Active;
  pmiAutosEdit.Enabled      := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0);
  pmiAutosDelete.Enabled    := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0);
  pmiAutosDeleteAll.Enabled := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0);
  pmiAutosClone.Enabled     := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0);
  pmiAutosUp.Enabled        := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0)and(fmDM.quDeportAutosSortIndex.AsInteger>1);
  pmiAutosDown.Enabled      := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0)and(fmDM.quDeportAutosSortIndex.AsInteger<fmDM.quDeportAutos.RecordCount);
  pmiAutosDefault.Enabled   := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0);
  pmiAutosDefaults.Enabled  := fmDM.quDeportAutos.Active;
  pmiAutosExcel.Enabled     := fmDM.quDeportAutos.Active;
  pmiAutosExport.Enabled    := fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0);
  pmiAutosImport.Enabled    := fmDM.quDeportAutos.Active;
end;{pmAutosPopup}
procedure TfmAutos.pmiAutosAddClick(Sender: TObject);
begin
  fmDM.quDeportAutos.Append;
end;{pmiAutosAddClick}
procedure TfmAutos.pmiAutosEditClick(Sender: TObject);
var
  AError  : String;
  Result  : Boolean;
begin
  Result  := False;
  FParkNo := fmDM.quDeportAutosParkNo.AsInteger;
  AError  := '';
  if esaShowInputValueDlg(SesaOperationEdit,SesaAutoParkNo,FParkNo,1,MaxInt)then
  begin
    if fmDM.quDeportAutos.Locate('ParkNo',FParkNo,[])
    then AError := Format(EesaAutosDuplicateParkNo,[ParkNo])
    else
    begin
      fmDM.quDeportAutos.Edit;
      fmDM.quDeportAutosParkNo.AsInteger := ParkNo;
      Result := True;
    end;{else}
  end;{if}
  FParkNo := 0;
  if AError<>'' then esaMsgError(AError);
  if not Result then Abort;
end;{pmiAutosEditClick}
procedure TfmAutos.pmiAutosDeleteClick(Sender: TObject);
var AError: String;
begin
  if esaMsgQuestionYN(SesaDeleteConfirm,[fmDM.quDeportAutosTotalName.AsString]) then//Delete
  if stpAUTOS_DELETE(fmDM.Query,fmDM.quOpenpitsId_Openpit.AsInteger,fmDM.quDeportAutosId_DeportAuto.AsInteger,fmDM.quDeportAutosSortIndex.AsInteger,AError)
  then DoAfterPost(fmDM.quDeportAutos)
  else esaMsgError(AError);
end;{pmiAutosDeleteClick}
procedure TfmAutos.pmiAutosDeleteAllClick(Sender: TObject);
var AError: String;
begin
  if esaMsgQuestionYN(SesaDeleteAllConfirm) then //DeleteAll
  if stpAUTOS_DELETE_ALL(fmDM.Query,fmDM.quDeportAutosId_Openpit.AsInteger,AError)
  then DoAfterPost(fmDM.quDeportAutos)
  else esaMsgError(AError);
end;{pmiAutosDeleteAllClick}
procedure TfmAutos.pmiAutosCloneClick(Sender: TObject);
var
  AError  : String;
  AId_Openpit,ASortIndex,AId_ShiftPunkt: Integer;
begin
  ASortIndex  := fmDM.quDeportAutosSortIndex.AsInteger;
  AId_Openpit := fmDM.quOpenpitsId_Openpit.AsInteger;
  if not stpGetValue(fmDM.Query,'Id_ShiftPunkt',SQL_GET_SHIFTPUNKTS_ID_SHIFTPUNKT,[AId_Openpit],AId_ShiftPunkt,AError)
  then esaMsgError(AError)else
  if not stpGetValue(fmDM.Query,'MaxParkNo',SQL_GET_AUTOS_MAX_PARKNO,[AId_Openpit],FParkNo,AError)
  then esaMsgError(AError)else
  if not stpGetValue(fmDM.Query,'MaxSortIndex',SQL_GET_AUTOS_MAX_SORTINDEX,[AId_Openpit],ASortIndex,AError)
  then esaMsgError(AError)else
  begin
     DefaultParams.SaveAutoParams(fmDM.quDeportAutosId_Auto.AsInteger,
                                  fmDM.quDeportAutosAYear.AsInteger,
                                  fmDM.quDeportAutosWorkState.AsBoolean,
                                  fmDM.quDeportAutosFactTonnage.AsFloat,
                                  fmDM.quDeportAutosCost.AsFloat,
                                  fmDM.quDeportAutosAmortizationRate.AsFloat,
                                  fmDM.quDeportAutosTransmissionKPD.AsFloat,
                                  fmDM.quDeportAutosEngineKPD.AsFloat,
                                  fmDM.quDeportAutosTyreCost.AsFloat,
                                  fmDM.quDeportAutosTyresRaceRate.AsFloat);
     if not stpAUTOS_CLONE(fmDM.Query,fmDM.quOpenpitsId_Openpit.AsInteger,
                    fmDM.quDeportAutosId_Auto.AsInteger,
                    ASortIndex+1,ParkNo+1,
                    fmDM.quDeportAutosAYear.AsInteger,
                    fmDM.quDeportAutosWorkState.AsBoolean,
                    fmDM.quDeportAutosFactTonnage.AsFloat,
                    fmDM.quDeportAutosCost.AsFloat,
                    fmDM.quDeportAutosAmortizationRate.AsFloat,
                    fmDM.quDeportAutosTransmissionKPD.AsFloat,
                    fmDM.quDeportAutosEngineKPD.AsFloat,
                    fmDM.quDeportAutosTyreCost.AsFloat,
                    fmDM.quDeportAutosTyresRaceRate.AsFloat,
                    AId_ShiftPunkt,
                    AError) then esaMsgError(AError)
     else esaRequeryDataSet(fmDM.quDeportAutos,'SortIndex',ASortIndex+1);
  end;{Clone}
end;{pmiAutosCloneClick}
procedure TfmAutos.pmiAutosUpClick(Sender: TObject);
var
  AError                         : String;
  AId_Openpit,AId_Auto,ASortIndex: Integer;
begin
  ASortIndex  := fmDM.quDeportAutosSortIndex.AsInteger;
  AId_Openpit := fmDM.quOpenpitsId_Openpit.AsInteger;
  AId_Auto    := fmDM.quDeportAutosId_DeportAuto.AsInteger;
  if stpAUTOS_MOVEUP(fmDM.Query,AId_Openpit,AId_Auto,ASortIndex,AError) //MoveUp
  then esaRequeryDataSet(fmDM.quDeportAutos,'Id_DeportAuto',AId_Auto)
  else esaMsgError(AError);
end;{pmiAutosUpClick}
procedure TfmAutos.pmiAutosDownClick(Sender: TObject);
var
  AError                         : String;
  AId_Openpit,AId_Auto,ASortIndex: Integer;
begin
  ASortIndex  := fmDM.quDeportAutosSortIndex.AsInteger;
  AId_Openpit := fmDM.quOpenpitsId_Openpit.AsInteger;
  AId_Auto    := fmDM.quDeportAutosId_DeportAuto.AsInteger;
  if stpAUTOS_MOVEDOWN(fmDM.Query,AId_Openpit,AId_Auto,ASortIndex,AError) //MoveDown
  then esaRequeryDataSet(fmDM.quDeportAutos,'Id_DeportAuto',AId_Auto)
  else esaMsgError(AError);
end;{pmiAutosDownClick}
procedure TfmAutos.pmiAutosDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(SesaDefaultConfirm) then
  DefaultParams.SaveAutoParams(fmDM.quDeportAutosId_Auto.AsInteger,
                               fmDM.quDeportAutosAYear.AsInteger,
                               fmDM.quDeportAutosWorkState.AsBoolean,
                               fmDM.quDeportAutosFactTonnage.AsFloat,
                               fmDM.quDeportAutosCost.AsFloat,
                               fmDM.quDeportAutosAmortizationRate.AsFloat,
                               fmDM.quDeportAutosTransmissionKPD.AsFloat,
                               fmDM.quDeportAutosEngineKPD.AsFloat,
                               fmDM.quDeportAutosTyreCost.AsFloat,
                               fmDM.quDeportAutosTyresRaceRate.AsFloat);
end;{pmiAutosDefaultClick}
procedure TfmAutos.pmiAutosDefaultsClick(Sender: TObject);
begin
  esaShowAutoDefaultsDlg(HelpKeyword);
end;{pmiAutosDefaultsClick}
procedure TfmAutos.pmiAutosExcelClick(Sender: TObject);
const
  WORKSTATE       : array[Boolean] of String = ('','''+');
  TRANSMISSIONKIND: array[0..1] of String = ('ГМ','ЭМ');
var
  XL      : TesaExcelEditor;
  AId_Auto,ACount: Integer;
  ARow    : Integer;
begin
  AId_Auto := fmDM.quDeportAutosId_DeportAuto.AsInteger;
  ACount   := Max(1,fmDM.quDeportAutos.RecordCount);
  XL := TesaExcelEditor.Create();
  try
    //initialization
    Xl.Visible          := True;
    XL.SheetCount       := 1;
    XL.ActiveSheetIndex := 0;
    XL.SheetName        := 'Автосамосвалы';
    //Title
    XL.Cell [ 1, 1].AsString        := Caption;
    XL.Cells[ 1, 1,26,1].MergeCells := True;
    //Table Title
    XL.Cells[ 2, 3,1,6].Orientation := 90;
    XL.Cells[ 2, 6,4,6].Orientation := 90;
    XL.Cells[ 2,16,2,6].Orientation := 90;
    XL.Cells[ 3,18,3,5].Orientation := 90;
    XL.Cell [ 2, 1].AsString        := '№';
    XL.Cell [ 2, 2].AsString        := 'Модель';
    XL.Cell [ 2, 3].AsString        := 'Гаражный номер';
    XL.Cell [ 2, 4].AsString        := 'Грузо-подъем-ность, т';
    XL.Cell [ 8, 4].AsString        := 'ном.';
    XL.Cell [ 8, 5].AsString        := 'факт.';
    XL.Cell [ 2, 6].AsString        := 'Объем кузова "с шапкой" (2:1), м3';
    XL.Cell [ 2, 7].AsString        := 'Масса порожнего автосамосвала, т';
    XL.Cell [ 2, 8].AsString        := 'Год выпуска';
    XL.Cell [ 2, 9].AsString        := 'Рабочее состояние';
    XL.Cell [ 2,10].AsString        := 'Двигатель';
    XL.Cell [ 7,10].AsString        := 'Модель';
    XL.Cell [ 7,11].AsString        := 'N, кВт';
    XL.Cell [ 8,11].AsString        := 'номин.';
    XL.Cell [ 7,12].AsString        := 'КПД';
    XL.Cell [ 8,12].AsString        := 'факт.';
    XL.Cell [ 2,13].AsString        := 'Трансмиссия';
    XL.Cell [ 7,13].AsString        := 'Тип';
    XL.Cell [ 7,14].AsString        := 'КПД';
    XL.Cell [ 8,14].AsString        := 'ном.';
    XL.Cell [ 8,15].AsString        := 'факт.';
    XL.Cell [ 2,16].AsString        := 'Время разгрузки, сек';
    XL.Cell [ 2,17].AsString        := 'Минимальный ра-диус поворота, м';
    XL.Cell [ 2,18].AsString        := 'Шины';
    XL.Cell [ 3,18].AsString        := 'Количество';
    XL.Cell [ 3,19].AsString        := 'Cтоимость одной шины, тыс.тг';
    XL.Cell [ 3,20].AsString        := 'R аморт., тыс.км';
    XL.Cell [ 2,21].AsString        := 'Балансовая стоимость, тыс.тг';
    XL.Cell [ 8,21].AsString        := 'номин.';
    XL.Cell [ 8,22].AsString        := 'факт.';
    XL.Cell [ 2,23].AsString        := 'Амортизация';
    XL.Cell [ 8,23].AsString        := 'Тип';
    XL.Cell [ 8,24].AsString        := 'R аморт.';
    XL.Cell [ 2,25].AsString        := 'Габариты, м';
    XL.Cell [ 8,25].AsString        := 'L';
    XL.Cell [ 8,26].AsString        := 'W';
    XL.Cell [ 8,27].AsString        := 'H';
    XL.Cells[ 2, 1,1,7].MergeCells  := True;
    XL.Cells[ 2, 2,1,7].MergeCells  := True;
    XL.Cells[ 2, 3,1,7].MergeCells  := True;
    XL.Cells[ 2, 4,2,6].MergeCells  := True;
    XL.Cells[ 2, 6,1,7].MergeCells  := True;
    XL.Cells[ 2, 7,1,7].MergeCells  := True;
    XL.Cells[ 2, 8,1,7].MergeCells  := True;
    XL.Cells[ 2, 9,1,7].MergeCells  := True;
    XL.Cells[ 2,10,3,5].MergeCells  := True;
    XL.Cells[ 7,10,1,2].MergeCells  := True;
    XL.Cells[ 2,13,3,5].MergeCells  := True;
    XL.Cells[ 7,13,1,2].MergeCells  := True;
    XL.Cells[ 7,14,2,1].MergeCells  := True;
    XL.Cells[ 2,16,1,7].MergeCells  := True;
    XL.Cells[ 2,17,1,7].MergeCells  := True;
    XL.Cells[ 2,18,3,1].MergeCells  := True;
    XL.Cells[ 3,18,1,6].MergeCells  := True;
    XL.Cells[ 3,19,1,6].MergeCells  := True;
    XL.Cells[ 3,20,1,6].MergeCells  := True;
    XL.Cells[ 2,21,2,6].MergeCells  := True;
    XL.Cells[ 2,23,2,6].MergeCells  := True;
    XL.Cells[ 2,25,3,6].MergeCells  := True;
    XL.Cells[ 2,1,27,8].VerticalAlignment   := vaCenter;
    XL.Cells[ 2,1,27,8].HorizontalAlignment := haCenter;
    XL.Cells[ 2,1,27,8].WrapText            := True;
    ARow := 9;
    XL.SetNumericRow(ARow,1,27);
    //Frame
    XL.Cells[ 2, 1,27,ARow-1+ACount].Frame := [feTotal];
    //Data
    fmDM.quDeportAutos.First;
    while not fmDM.quDeportAutos.Eof do
    begin
      Inc(ARow);
      XL.Cell[ARow, 1].AsInteger := fmDM.quDeportAutosSortIndex.AsInteger;
      XL.Cell[ARow, 2].AsString  := fmDM.quDeportAutosName.AsString;
      XL.Cell[ARow, 3].AsInteger := fmDM.quDeportAutosSortIndex.AsInteger;
      XL.Cell[ARow, 4].AsFloat   := fmDM.quDeportAutosNetQtn.AsFloat;
      XL.Cell[ARow, 5].AsFloat   := fmDM.quDeportAutosFactTonnage.AsFloat;
      XL.Cell[ARow, 6].AsFloat   := fmDM.quDeportAutosBodyHeapVm3.AsFloat;
      XL.Cell[ARow, 7].AsFloat   := fmDM.quDeportAutosNetPtn.AsFloat;
      XL.Cell[ARow, 8].AsInteger := fmDM.quDeportAutosAYear.AsInteger;
      XL.Cell[ARow, 9].AsText    := WORKSTATE[fmDM.quDeportAutosWorkState.AsBoolean];
      XL.Cell[ARow,10].AsString  := fmDM.quDeportAutosEngine.AsString;
      XL.Cell[ARow,11].AsFloat   := fmDM.quDeportAutosEngineNetNkvt.AsFloat;
      XL.Cell[ARow,12].AsFloat   := fmDM.quDeportAutosEngineKPD.AsFloat;
      XL.Cell[ARow,13].AsString  := TRANSMISSIONKIND[fmDM.quDeportAutosTransmissionKind.AsInteger];
      XL.Cell[ARow,14].AsFloat   := fmDM.quDeportAutosTransmissionNetKPD.AsFloat;
      XL.Cell[ARow,15].AsFloat   := fmDM.quDeportAutosTransmissionKPD.AsFloat;
      XL.Cell[ARow,16].AsFloat   := fmDM.quDeportAutosNetUnloadingTsec.AsFloat;
      XL.Cell[ARow,17].AsFloat   := fmDM.quDeportAutosNetRm.AsFloat;
      XL.Cell[ARow,18].AsInteger := fmDM.quDeportAutosNetTyresCount.AsInteger;
      XL.Cell[ARow,19].AsFloat   := fmDM.quDeportAutosTyreCost.AsFloat;
      XL.Cell[ARow,20].AsFloat   := fmDM.quDeportAutosTyresRaceRate.AsFloat;
      XL.Cell[ARow,21].AsFloat   := fmDM.quDeportAutosNetBalanceC1000tg.AsFloat;
      XL.Cell[ARow,22].AsFloat   := fmDM.quDeportAutosCost.AsFloat;
      if fmDM.quDeportAutosAmortizationKind.AsInteger=0
      then XL.Cell[ARow,23].AsString  := 'годовая' else
      if fmDM.quDeportAutosAmortizationKind.AsInteger=1
      then XL.Cell[ARow,23].AsString  := 'на тыс.км';
      XL.Cell[ARow,24].AsFloat   := fmDM.quDeportAutosAmortizationRate.AsFloat;
      XL.Cell[ARow,25].AsFloat   := fmDM.quDeportAutosLm.AsFloat;
      XL.Cell[ARow,26].AsFloat   := fmDM.quDeportAutosWm.AsFloat;
      XL.Cell[ARow,27].AsFloat   := fmDM.quDeportAutosHm.AsFloat;
      fmDM.quDeportAutos.Next;
    end;{while}
    //columns.width
    XL.ColumnWidths[ 1, 1] :=  3.0;
    XL.ColumnWidths[ 2, 1] := 15.0;
    XL.ColumnWidths[ 3, 1] :=  3.0;
    XL.ColumnWidths[ 4, 5] :=  4.0;
    XL.ColumnWidths[ 9, 1] :=  3.0;
    XL.ColumnWidths[10, 1] := 20.0;
    XL.ColumnWidths[11, 1] :=  6.0;
    XL.ColumnWidths[12, 6] :=  4.0;
    XL.ColumnWidths[13, 1] :=  3.0;
    XL.ColumnWidths[18, 1] :=  3.0;
    XL.ColumnWidths[19, 1] :=  8.0;
    XL.ColumnWidths[20, 8] :=  4.0;
    XL.ColumnWidths[21, 2] :=  8.0;
    XL.ColumnWidths[23, 1] :=  8.0;
    XL.ColumnWidths[24, 1] :=  5.0;
    XL.RowHeights  [ 2, 8] := 11.25;
    //NumberFormat
    XL.Cells[10, 3,1,ACount].NumberFormat := nfInt00;
    XL.Cells[10, 4,4,ACount].NumberFormat := nfFloat0;
    XL.Cells[10,11,1,ACount].NumberFormat := nfFloat0;
    XL.Cells[10,12,1,ACount].NumberFormat := nfFloat00;
    XL.Cells[10,14,2,ACount].NumberFormat := nfFloat00;
    XL.Cells[10,16,2,ACount].NumberFormat := nfFloat0;
    XL.Cells[10,19,1,ACount].NumberFormat := nfFloat00;
    XL.Cells[10,20,1,ACount].NumberFormat := nfFloat0;
    XL.Cells[10,21,2,ACount].NumberFormat := nfFloat00;
    XL.Cells[10,24,1,ACount].NumberFormat := nfFloat0000;
    XL.Cells[10,25,3,ACount].NumberFormat := nfFloat0;
    //finalization
    XL.SetPageSetupMargines(Rect(10,10,10,10));
    XL.SetPageSetupOrientation(xlpoLandscape);
    XL.SetPageSetupHeader('&8CEBADAN-AUTO, III','&8'+Caption,'&8&D',5);
    XL.SetPageSetupFooter('','&8&P из &N','',5);
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
  fmDM.quDeportAutos.Locate('Id_DeportAuto',AId_Auto,[]);
end;{pmiAutosExcelClick}
type
  ResaAuto=record
    SortIndex                  : Integer; //Порядковый номер
    Id_AutoModel               : Integer; //Код модели
    AutoModel                  : String[200];  //Модель
    ParkNo                     : Integer; //Гаражный номер
    AutoYear                   : Integer; //Год выпуска
    WorkState                  : Boolean; //Рабочее состояние
    FactQtn                    : Single;  //Фактическая грузоподъемность, т
    FactEngineKPD              : Single;  //Фактический КПД двигателя, ед
    FactTransmissionKPD        : Single;  //Фактический КПД трансмиссии, ед
    TyresCost1000tg            : Single;  //Стоимость шины, тыс.тг
    TyresAmortization1000km    : Single;  //Пробег шин, тыс.км
    Cost1000tg                 : Single;  //Стоимость, тыс.тг
    AmortizationKind           : Byte;    //Тип амортизации
    AmortizationRate           : Single;  //Норма амортизации, ед
    Id_Course                  : Integer; //Код маршрута
    Course                     : String[200];  //Маршрут
    Id_ShiftPunkt              : Integer; //Код пункта пересменки
    ShiftPunkt                 : String[200];  //Пункт пересменки
  end;{ResaAuto}
procedure TfmAutos.pmiAutosExportClick(Sender: TObject);
var
  f    : Integer;
  AAuto: ResaAuto;
begin
  if not DirectoryExists(ExtractFileDir(SaveDialog.FileName))
  then SaveDialog.InitialDir := ExtractFileDir(Application.ExeName);
  SaveDialog.FileName := '';
  if fmDM.quDeportAutos.Active and (fmDM.quDeportAutos.RecordCount>0) then
  if SaveDialog.Execute then
  begin
    f := FileCreate(SaveDialog.FileName);
    try
      fmDM.quDeportAutos.First;
      while not fmDM.quDeportAutos.Eof do
      begin
        AAuto.SortIndex               := fmDM.quDeportAutosSortIndex.AsInteger;
        AAuto.Id_AutoModel            := fmDM.quDeportAutosId_Auto.AsInteger;
        AAuto.AutoModel               := fmDM.quDeportAutosName.AsString;
        AAuto.ParkNo                  := fmDM.quDeportAutosParkNo.AsInteger;
        AAuto.AutoYear                := fmDM.quDeportAutosAYear.AsInteger;
        AAuto.WorkState               := fmDM.quDeportAutosWorkState.AsBoolean;
        AAuto.FactQtn                 := fmDM.quDeportAutosFactTonnage.AsFloat;
        AAuto.FactEngineKPD           := fmDM.quDeportAutosEngineKPD.AsFloat;
        AAuto.FactTransmissionKPD     := fmDM.quDeportAutosTransmissionKPD.AsFloat;
        AAuto.TyresCost1000tg         := fmDM.quDeportAutosTyreCost.AsFloat;
        AAuto.TyresAmortization1000km := fmDM.quDeportAutosTyresRaceRate.AsFloat;
        AAuto.Cost1000tg              := fmDM.quDeportAutosCost.AsFloat;
        AAuto.AmortizationKind        := fmDM.quDeportAutosAmortizationKind.AsInteger;
        AAuto.AmortizationRate        := fmDM.quDeportAutosAmortizationRate.AsFloat;
        AAuto.Id_Course               := fmDM.quDeportAutosId_Course.AsInteger;
        AAuto.Course                  := fmDM.quDeportAutosCourse.AsString;
        AAuto.Id_ShiftPunkt           := fmDM.quDeportAutosId_ShiftPunkt.AsInteger;
        AAuto.ShiftPunkt              := fmDM.quDeportAutosShiftPunkt.AsString;
        FileWrite(f,AAuto,SizeOf(ResaAuto));
        fmDM.quDeportAutos.Next;
      end;{while}
    finally
      FileClose(f);
    end;{try}
  end;{if}
end;{pmiExportClick}
procedure TfmAutos.pmiAutosImportClick(Sender: TObject);
  //
  function _CheckFieldID(const ATable,AField: String; const Value: Integer): Boolean;
  begin
    Result := False;
    if Value>0 then
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := Format('SELECT * FROM %s WHERE %s = %d',[ATable,AField,Value]);
      Open;
      Result := RecordCount>0;
      Close;
    finally
      Free;
    end;{try}
  end;{_CheckFieldID}
var
  f,n,I : Integer;
  AAuto: ResaAuto;
begin
  if not DirectoryExists(ExtractFileDir(OpenDialog.FileName))
  then OpenDialog.InitialDir := ExtractFileDir(Application.ExeName);
  OpenDialog.FileName := '';
  if fmDM.ADOConnection.Connected then
  if esaMsgQuestionYN('Произвести импорт списочного парка автосамосвалов?'+#13+'Текущий списочный парк будет потерян.')then
  if OpenDialog.Execute then
  begin
    fmDM.quDeportAutos.Close;
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'DELETE FROM OpenpitDeportAutos WHERE Id_Openpit='+fmDM.quOpenpitsId_Openpit.AsString;
      ExecSQL;
      SQL.Text := 'SELECT * FROM OpenpitDeportAutos WHERE Id_Openpit='+fmDM.quOpenpitsId_Openpit.AsString;
      Open;
      f := FileOpen(OpenDialog.FileName,fmOpenRead);
      try
        n := FileSeek(f,0,2) div SizeOf(ResaAuto);
        FileSeek(f,0,0);
        for I := 0 to n-1 do
        begin
          FileRead(f,AAuto,SizeOf(ResaAuto));
          Append;
          FieldByName('Id_Openpit').AsInteger       := fmDM.quOpenpitsId_Openpit.AsInteger;
          FieldByName('SortIndex').AsInteger        := AAuto.SortIndex;
          if _CheckFieldID('Autos','Id_Auto',AAuto.Id_AutoModel)
          then FieldByName('Id_Auto').AsInteger     := AAuto.Id_AutoModel
          else FieldByName('Id_Auto').Clear;
          FieldByName('ParkNo').AsInteger           := AAuto.ParkNo;
          FieldByName('AYear').AsInteger            := AAuto.AutoYear;
          FieldByName('WorkState').AsBoolean        := AAuto.WorkState;
          FieldByName('FactTonnage').AsFloat        := AAuto.FactQtn;
          FieldByName('EngineKPD').AsFloat          := AAuto.FactEngineKPD;
          FieldByName('TransmissionKPD').AsFloat    := AAuto.FactTransmissionKPD;
          FieldByName('TyreCost').AsFloat           := AAuto.TyresCost1000tg;
          FieldByName('TyresRaceRate').AsFloat      := AAuto.TyresAmortization1000km;
          FieldByName('Cost').AsFloat               := AAuto.Cost1000tg;
          FieldByName('AmortizationKind').AsInteger := AAuto.AmortizationKind;
          FieldByName('AmortizationRate').AsFloat   := AAuto.AmortizationRate;
          if _CheckFieldID('OpenpitCourses','Id_Course',AAuto.Id_Course) then
          begin
            FieldByName('Id_Course').AsInteger      := AAuto.Id_Course;
            FieldByName('Course').AsString          := AAuto.Course;
          end{if}
          else
          begin
            FieldByName('Id_Course').Clear;
            FieldByName('Course').Clear;
          end;{else}
          if _CheckFieldID('OpenpitShiftPunkts','Id_ShiftPunkt',AAuto.Id_ShiftPunkt) then
          begin
            FieldByName('Id_ShiftPunkt').AsInteger      := AAuto.Id_ShiftPunkt;
            FieldByName('ShiftPunkt').AsString          := AAuto.ShiftPunkt;
          end{if}
          else
          begin
            FieldByName('Id_ShiftPunkt').Clear;
            FieldByName('ShiftPunkt').Clear;
          end;{else}
          Post;
        end;{for}
      finally
        FileClose(f);
      end;{try}
      Close;
    finally
      Free;
    end;{try}
    fmDM.quDeportAutos.Open;
  end;{if}
end;{pmiImportClick}

end.
