unit unExcavators;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs,
  types;

type
  TfmExcavators = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    pmDeportExcavators: TPopupMenu;
    pmiAdd: TMenuItem;
    pmiEdit: TMenuItem;
    pmiDelete: TMenuItem;
    pmiDeleteAll: TMenuItem;
    pmiSep1: TMenuItem;
    pmiDefault: TMenuItem;
    pmiSep3: TMenuItem;
    pmiExcel: TMenuItem;
    pmiSep4: TMenuItem;
    pbDeportExcavators: TPaintBox;
    dbgDeportExcavators: TDBGrid;
    pmiDefaultsDlg: TMenuItem;
    btExcel: TButton;
    pmiSep2: TMenuItem;
    pmiUp: TMenuItem;
    pmiDown: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbDeportExcavatorsPaint(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmDeportExcavatorsPopup(Sender: TObject);
    procedure dbgDeportExcavatorsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDeportExcavatorsKeyPress(Sender: TObject; var Key: Char);
    procedure pmiDefaultsDlgClick(Sender: TObject);
    procedure pmiUpClick(Sender: TObject);
    procedure pmiDownClick(Sender: TObject);
    procedure dbgDeportExcavatorsColEnter(Sender: TObject);
  private
    FSortIndex: Integer;         //Порядковый номер 
    FParkNo   : Integer;         //Гаражный номер
    FColWidths: TIntegerDynArray;//Ширина столбцов таблицы
    procedure DoAfterDelete(DataSet: TDataSet);
    procedure DoAfterInsert(DataSet: TDataSet);
    procedure DoAfterPost(DataSet: TDataSet);
    procedure DoBeforeDelete(DataSet: TDataSet);
    procedure DoBeforeInsert(DataSet: TDataSet);
    procedure DoBeforePost(DataSet: TDataSet);

  public
  end;{TfmAutos}

var
  fmExcavators: TfmExcavators;

//Диалоговое окно экскаваторов списочного парка
procedure esaShowExcavatorsDlg();
implementation

uses unDM, Globals, ADODb, Math, ExcelEditors, unExcavatorDefaults,
  esaDBDefaultParams;

{$R *.dfm}

//Диалоговое окно экскаваторов списочного парка
procedure esaShowExcavatorsDlg();
begin
  fmExcavators := TfmExcavators.Create(nil);
  try
    fmExcavators.ShowModal;
  finally
    fmExcavators.Free;
  end;{try}
end;{esaShowExcavatorsDlg}

procedure TfmExcavators.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  SetLength(FColWidths,dbgDeportExcavators.Columns.Count);
  dbgDeportExcavators.Options := [dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines,dgTabs];
  FParkNo := 0;
  with fmDM do
  begin
    quExcavatorEngines.Open;
    if quExcavatorEngines.RecordCount=0
    then raise Exception.Create(EEmptyExcavatorEngines);
    quExcavators.Open;
    if quExcavators.RecordCount=0
    then raise Exception.Create(EEmptyExcavators);

    if not quExcavators.Locate('Id_Excavator',DefaultParams.DeportExcId_Excavator,[])
    then DefaultParams.DeportExcId_Excavator := quExcavatorsId_Excavator.AsInteger;
    quExcavatorEngines.First;
    quDeportExcavators.BeforeDelete := DoBeforeDelete;
    quDeportExcavators.BeforeInsert := DoBeforeInsert;
    quDeportExcavators.BeforePost := DoBeforePost;
    quDeportExcavators.AfterDelete := DoAfterDelete;
    quDeportExcavators.AfterInsert := DoAfterInsert;
    quDeportExcavators.AfterPost := DoAfterPost;
    quDeportExcavators.Open;
  end;{with}
end;{FormCreate}
procedure TfmExcavators.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quDeportExcavators.Close;
    quExcavators.Close;
    quExcavatorEngines.Close;
    quDeportExcavators.BeforeDelete := nil;
    quDeportExcavators.BeforeInsert := nil;
    quDeportExcavators.BeforePost := nil;
    quDeportExcavators.AfterDelete := nil;
    quDeportExcavators.AfterInsert := nil;
    quDeportExcavators.AfterPost := nil;
  end;{with}
  FColWidths := nil;
end;{FormClose}
procedure TfmExcavators.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quDeportExcavators,Caption);
end;{FormCloseQuery}
procedure TfmExcavators.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgDeportExcavators,1);
  UpdateColumnRights(dbgDeportExcavators,FColWidths);
end;{FormResize}
procedure TfmExcavators.pbDeportExcavatorsPaint(Sender: TObject);
var
  Cvs: TCanvas;
begin
  Cvs := pbDeportExcavators.Canvas;
  DrawGridTitle(pbDeportExcavators,dbgDeportExcavators,6,FColWidths);
  with dbgDeportExcavators do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],5*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[0]+1,1,FColWidths[1],5*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[1]+1,1,FColWidths[2],5*hCell,['Номер','в','парке']);
    with Columns[3] do
      DrawGridCell(Cvs,FColWidths[2]+1,1,FColWidths[3],5*hCell,['Год', 'ввода в','эксплу-','атацию']);
    with Columns[4] do
      DrawGridCell(Cvs,FColWidths[3]+1,1,FColWidths[4],5*hCell,['Рабочее','состояние']);
    with Columns[5] do
      DrawGridCell(Cvs,FColWidths[4]+1,1,FColWidths[5],5*hCell,['Факти-','ческое','время',
                                                            'цикла,','сек']);
    with Columns[6] do
      DrawGridCell(Cvs,FColWidths[5]+1,1,FColWidths[6],5*hCell,['Балансовая','стоимость,','тыс.тн']);
    with Columns[7] do
      DrawGridCell(Cvs,FColWidths[6]+1,1,FColWidths[10],hCell,['Дополнительные данные']);
    with Columns[7] do
      DrawGridCell(Cvs,FColWidths[6]+1,hCell+1,FColWidths[8],2*hCell,['стоимостные, тыс.тн/мес']);
    with Columns[6] do
      DrawGridCell(Cvs,FColWidths[6]+1,1+2*hCell,FColWidths[7],5*hCell,['Затраты на','материалы']);
    with Columns[7] do
      DrawGridCell(Cvs,FColWidths[7]+1,1+2*hCell,FColWidths[8],5*hCell,['Неучтенные','расходы']);
    with Columns[9] do
      DrawGridCell(Cvs,FColWidths[8]+1,hCell+1,FColWidths[10],2*hCell,['по двигателю']);
    with Columns[8] do
      DrawGridCell(Cvs,FColWidths[8]+1,1+2*hCell,FColWidths[9],5*hCell,['Коэффициент',
                                                                    'использования','мощности']);
    with Columns[9] do
      DrawGridCell(Cvs,FColWidths[9]+1,1+2*hCell,FColWidths[10],5*hCell,['КПД']);
    with Columns[10] do
      DrawGridCell(Cvs,FColWidths[10]+1,1,FColWidths[11],5*hCell,['Годовая','норма','амортизации']);
  end;{with}
end;{pbDeportExcavatorsPaint}

procedure TfmExcavators.DoBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('TotalName').AsString]))
  then Abort
  else
  begin
    //перед удалением экскаватора, убираю их с пунтов погрузки
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE OpenpitLoadingPunkts SET Id_DeportExcavator=Null '+
                  'WHERE Id_DeportExcavator='+
                  fmDM.quDeportExcavatorsId_DeportExcavator.AsString;
      ExecSQL;
    finally
      Free;
    end;{try}
  end;{else}
end;{DoBeforeDelete}
procedure TfmExcavators.DoBeforeInsert(DataSet: TDataSet);
var
  sNo: String;
  IsOk: Boolean;
begin
  FSortIndex := Dataset.RecordCount+1;
  FParkNo := 0;
  sNo := '';
  IsOk := true;
  if InputName('Добавить','Номер в парке',sNo,Dataset.FieldByName('ParkNo').Size)then
  begin
    try
      FParkNo := StrToInt(sNo);
      if DataSet.Locate('ParkNo',FParkNo,[]) then
      begin
        esaMsgError(Format(EDuplicateObj,['Данный номер экскаватора',IntToStr(FParkNo)]));
        FParkNo := 0;
        IsOk := false;
        Abort;
      end;{if}
    except
      if IsOk then esaMsgError(Format(EInvalidIntegerValue,[sNo,'Номер в парке']));
      Abort;
    end;{try}
  end{if}
  else Abort;
end;{DoBeforeInsert}
procedure TfmExcavators.DoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if Dataset.FieldbyName('WorkState').Value=null then
      Dataset.FieldbyName('WorkState').AsBoolean := true;
    if Dataset.FieldbyName('Id_Excavator').Value=null then
      Dataset.FieldbyName('Id_Excavator').AsInteger := DefaultParams.DeportExcId_Excavator;

    if (not IsIntegerFieldMoreEqualMin(DataSet.FieldByName('EYear'),1950))OR
       (not IsFloatFieldMoreEqualMin(DataSet.FieldByName('Cost'),0.0))OR
       (not IsFloatFieldMoreEqualMin(DataSet.FieldByName('FactCycleTime'),1.0))OR
       (not IsFloatFieldMoreEqualMin(DataSet.FieldByName('AddCostMaterials'),0.0))OR
       (not IsFloatFieldMoreEqualMin(DataSet.FieldByName('AddCostUnAccounted'),0.0))OR
       (not IsFloatFieldInRange2(DataSet.FieldByName('EngineKIM'),0.25,0.35))OR
//       (not IsFloatFieldInRange3(DataSet.FieldByName('EngineKPD'),0.936,0.948))
       (not IsFloatFieldInRange3(DataSet.FieldByName('EngineKPD'),0.4,0.948)) OR
       (not IsFloatFieldInRange3(DataSet.FieldByName('SENAmortizationRate'),0.000,0.999))
    then Abort
    else
    begin
      if (Dataset.State in [dsInsert,dsEdit])and(FParkNo>0)
      then DataSet.FieldByName('ParkNo').AsInteger := FParkNo;
      if not DataSet.FieldByName('WorkState').AsBoolean then
      with TADOQuery.Create(Nil) do
      try
        Connection := fmDM.ADOConnection;
        SQL.Text := 'UPDATE OpenpitLoadingPunkts SET Id_DeportExcavator=Null '+
                    'WHERE Id_DeportExcavator='+
                    DataSet.FieldByName('Id_DeportExcavator').AsString;
        ExecSQL;
      finally
        Free;
      end;{try}
    end;{else}
  end;{if}
end;{DoBeforePost}
procedure TfmExcavators.DoAfterDelete(DataSet: TDataSet);
var Id_DeportExcavator, ASortIndex: Integer;
begin
  Id_DeportExcavator := Dataset.FieldByName('Id_DeportExcavator').AsInteger;
  Dataset.DisableControls;
  TADOQuery(Dataset).Requery;
  ASortIndex := 0;
  while not Dataset.Eof do
  begin
    Inc(ASortIndex);
    Dataset.Edit;
    Dataset.FieldByName('SortIndex').AsInteger := ASortIndex;
    Dataset.Post;
    DataSet.Next;
  end;{while}
  TADOQuery(Dataset).Requery;
  Dataset.Locate('Id_DeportExcavator',Id_DeportExcavator,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbDeportExcavators.Invalidate;
end;{DoAfterDelete}
procedure TfmExcavators.DoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FParkNo>0) then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldbyName('ParkNo').AsInteger := FParkNo;
    Dataset.FieldbyName('Id_Excavator').AsInteger := DefaultParams.DeportExcId_Excavator;
    Dataset.FieldbyName('EYear').AsInteger := DefaultParams.DeportExcEYear;
    Dataset.FieldbyName('WorkState').AsBoolean := DefaultParams.DeportExcWorkState;
    Dataset.FieldbyName('Cost').AsFloat := DefaultParams.DeportExcCost;
    Dataset.FieldbyName('FactCycleTime').AsFloat := DefaultParams.DeportExcFactCycleTime;
    Dataset.FieldbyName('AddCostMaterials').AsFloat := DefaultParams.DeportExcAddCostMaterials;
    Dataset.FieldbyName('AddCostUnAccounted').AsFloat := DefaultParams.DeportExcAddCostUnAccounted;
    Dataset.FieldbyName('EngineKIM').AsFloat := DefaultParams.DeportExcEngineKIM;
    Dataset.FieldbyName('EngineKPD').AsFloat := DefaultParams.DeportExcEngineKPD;
    Dataset.FieldByName('SENAmortizationRate').AsFloat := DefaultParams.DeportSENExcAmortizationRate;
  end;{if}
end;{DoAfterInsert}
procedure TfmExcavators.DoAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbDeportExcavators.Invalidate;
end;{DoAfterPost}
procedure TfmExcavators.pmiAddClick(Sender: TObject);
begin
  fmDM.quDeportExcavators.Append;
end;{pmiExcavatorAddClick}
procedure TfmExcavators.pmiEditClick(Sender: TObject);
var sNo: String;
begin
  FParkNo := 0;
  sNo := '';
  with fmDM do
  begin
    FParkNo := quDeportExcavatorsParkNo.AsInteger;
    sNo := IntToStr(FParkNo);
    if InputName('Изменить','Номер в парке',sNo,quDeportExcavatorsParkNo.Size)then
    begin
      try
        FParkNo := StrToInt(sNo);
        if fmDM.quDeportExcavators.Locate('ParkNo',FParkNo,[])
        then esaMsgError(Format(EDuplicateObj,['Данный номер экскаватора',IntToStr(FParkNo)]))
        else
        begin
          quDeportExcavators.Edit;
          quDeportExcavatorsParkNo.AsInteger := FParkNo;
        end;{else}
      except
        esaMsgError(Format(EInvalidIntegerValue,[sNo,'Номер в парке']));
        Abort;
      end;{try}
    end;{if}
    FParkNo := 0;
  end;{with}
end;{pmiExcavatorEditClick}
procedure TfmExcavators.pmiDeleteClick(Sender: TObject);
begin
  fmDM.quDeportExcavators.Delete;
end;{pmiExcavatorDeleteClick}
procedure TfmExcavators.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quDeportExcavators.Requery;
    //перед удалением экскаватора, убираю их с пунтов погрузки
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE OpenpitLoadingPunkts SET Id_DeportExcavator=Null WHERE Id_Openpit='+
                  fmDM.quOpenpitsId_Openpit.AsString;
      ExecSQL;
      SQL.Text := 'DELETE FROM OpenpitDeportExcavators WHERE Id_Openpit='+
                  fmDM.quOpenpitsId_Openpit.AsString;
      ExecSQL;
    finally
      Free;
    end;{try}
    quDeportExcavators.Requery;
    FormResize(Self);
    pbDeportExcavators.Invalidate;
  end;{with}
end;{pmiExcavatorDeleteAllClick}
procedure TfmExcavators.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.DeportExcId_Excavator := fmDM.quDeportExcavatorsId_Excavator.AsInteger;
    DefaultParams.DeportExcEYear := fmDM.quDeportExcavatorsEYear.AsInteger;
    DefaultParams.DeportExcWorkState := fmDM.quDeportExcavatorsWorkState.AsBoolean;
    DefaultParams.DeportExcCost := fmDM.quDeportExcavatorsCost.AsFloat;
    DefaultParams.DeportExcFactCycleTime := fmDM.quDeportExcavatorsFactCycleTime.AsFloat;
    DefaultParams.DeportExcAddCostMaterials := fmDM.quDeportExcavatorsAddCostMaterials.AsFloat;
    DefaultParams.DeportExcAddCostUnAccounted := fmDM.quDeportExcavatorsAddCostUnAccounted.AsFloat;
    DefaultParams.DeportExcEngineKIM := fmDM.quDeportExcavatorsEngineKIM.AsFloat;
    DefaultParams.DeportExcEngineKPD := fmDM.quDeportExcavatorsEngineKPD.AsFloat;
  end;{if}
end;{pmiExcavatorDefaultClick}
procedure TfmExcavators.pmiDefaultsDlgClick(Sender: TObject);
begin
  esaShowExcavatorDefaultsDlg(HelpKeyword);
end;{pmiDefaultsDlgClick}
procedure TfmExcavators.pmiExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  I,ACount: Integer;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1;
    //Заголовок
    XL.TitleCell[1,1,11,1] := Caption;
    //Шапка
    XL.TitleCell[2, 1,1,6] := '№';
    XL.TitleCell[2, 2,1,6] := 'Наименование';
    XL.TitleCell[2, 3,1,6] := 'Номер в парке';
    XL.TitleCell[2, 4,1,6] := 'Год ввода в эксплуа-тацию';
    XL.TitleCell[2, 5,1,6] := 'Раб. состо-яние';
    XL.TitleCell[2, 6,1,6] := 'Балансовая стоимость, тыс.тн.';
    XL.TitleCell[2, 7,1,6] := 'Факти-ческое время цикла, сек';
    XL.TitleCell[2, 8,4,1] := 'Дополнительные данные';
    XL.TitleCell[3, 8,2,2] := 'Стоимостные, тыс.тн/мес';
    XL.TitleCell[5, 8,1,3] := 'Затраты на ма-териалы';
    XL.TitleCell[5, 9,1,3] := 'Неучтен-ные расходы';
    XL.TitleCell[3,10,2,2] := 'Технические по двигателю';
    XL.TitleCell[5,10,1,3] := 'Коэффициент использования мощности';
    XL.TitleCell[5,11,1,3] := 'КПД';
    for I := 1 to 11 do
      XL.TitleCell[8,I,1,1] := IntToStr(I);
    //Ширина столбцов
    XL.ColumnWidths[ 1,1] :=  3.0;
    XL.ColumnWidths[ 2,1] := 12.0;
    XL.ColumnWidths[ 3,5] :=  5.0;
    XL.ColumnWidths[ 4,1] :=  6.0;
    XL.ColumnWidths[ 6,1] :=  9.0;
    XL.ColumnWidths[ 8,2] :=  7.0;
    XL.ColumnWidths[10,1] := 12.0;
    XL.ColumnWidths[11,1] :=  4.0;
    //Форматы
    if fmDM.quDeportExcavators.RecordCount=0
    then ACount := 1
    else ACount := fmDM.quDeportExcavators.RecordCount;
    XL.Cells[2,1,11,ACount+7].Frame := [feTotal];
    XL.Cells[9,5,6,ACount+7].NumberFormat := nfFloat00;
    XL.Cells[9,3,1,ACount+7].NumberFormat := nfInt00;
    XL.Cells[9,5,1,ACount+7].HorizontalAlignment := haCenter;
    //Данные
    with fmDM do
    begin
      quDeportExcavators.First;
      while not quDeportExcavators.Eof do
      begin
        XL.IntegerCells[quDeportExcavators.RecNo+8, 1] := quDeportExcavatorsSortIndex.AsInteger;
        XL.StringCells [quDeportExcavators.RecNo+8, 2] := quDeportExcavatorsName.AsString;
        XL.IntegerCells[quDeportExcavators.RecNo+8, 3] := quDeportExcavatorsParkNo.AsInteger;
        XL.FloatCells  [quDeportExcavators.RecNo+8, 4] := quDeportExcavatorsEYear.AsInteger;
        if quDeportExcavatorsWorkState.AsBoolean
        then XL.StringCells [quDeportExcavators.RecNo+8, 5] := '+';
        XL.FloatCells  [quDeportExcavators.RecNo+8, 6] := quDeportExcavatorsCost.AsFloat;
        XL.FloatCells  [quDeportExcavators.RecNo+8, 7] := quDeportExcavatorsFactCycleTime.AsFloat;
        XL.FloatCells  [quDeportExcavators.RecNo+8, 8] := quDeportExcavatorsAddCostMaterials.AsFloat;
        XL.FloatCells  [quDeportExcavators.RecNo+8, 9] := quDeportExcavatorsAddCostUnAccounted.AsFloat;
        XL.FloatCells  [quDeportExcavators.RecNo+8,10] := quDeportExcavatorsEngineKIM.AsFloat;
        XL.FloatCells  [quDeportExcavators.RecNo+8,11] := quDeportExcavatorsEngineKPD.AsFloat;
        quDeportExcavators.Next;
      end;{while}
      quDeportExcavators.First;
    end;{with}
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiExcavatorExcelClick}
procedure TfmExcavators.pmDeportExcavatorsPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiAdd.Enabled := quDeportExcavators.Active;
    pmiEdit.Enabled := pmiAdd.Enabled and(quDeportExcavators.RecordCount>0)and
                      (not (quDeportExcavators.State in [dsEdit,dsInsert]));
    pmiUp.Enabled := pmiEdit.Enabled and(quDeportExcavators.RecNo>1);
    pmiDown.Enabled := pmiEdit.Enabled and(quDeportExcavators.RecNo<quDeportExcavators.RecordCount);
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiDefault.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiEdit.Enabled;
  end;{with}
end;{pmExcavatorsPopup}

procedure TfmExcavators.dbgDeportExcavatorsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Column.Field=fmDM.quDeportExcavatorsWorkState
  then DrawDBGridTick(dbgDeportExcavators.Canvas,Rect,Column.Field.AsBoolean)
  else DrawDBGridColumnCell(dbgDeportExcavators,Rect, DataCol,Column,State);
end;{dbgDeportExcavatorsDrawColumnCell}
procedure TfmExcavators.dbgDeportExcavatorsKeyPress(Sender: TObject; var Key: Char);
begin
  if dbgDeportExcavators.Tag>0 then
  begin
    Key := #0;
    if not (fmDM.quDeportExcavators.State in [dsEdit,dsInsert])then fmDM.quDeportExcavators.Edit;
    fmDM.quDeportExcavatorsWorkState.AsBoolean := not fmDM.quDeportExcavatorsWorkState.AsBoolean;
  end;{if}
end;{dbgDeportExcavatorsKeyPress}
procedure TfmExcavators.dbgDeportExcavatorsColEnter(Sender: TObject);
begin
  if dbgDeportExcavators.Columns[dbgDeportExcavators.SelectedIndex].Field=fmDM.quDeportExcavatorsWorkState
  then dbgDeportExcavators.Tag := 1
  else dbgDeportExcavators.Tag := 0;
end;{dbgDeportExcavatorsColEnter}


procedure TfmExcavators.pmiUpClick(Sender: TObject);
var Id_DeportExcavator: Integer;
begin
  with fmDM do
  if (not(quDeportExcavators.State in [dsEdit,dsInsert]))and(quDeportExcavators.RecNo>1) then
  begin
    quDeportExcavators.DisableControls;
    FSortIndex  := quDeportExcavatorsSortIndex.AsInteger;
    Id_DeportExcavator := quDeportExcavatorsId_DeportExcavator.AsInteger;
    quDeportExcavators.Prior;
    quDeportExcavators.Edit;
    quDeportExcavatorsSortIndex.AsInteger := FSortIndex;
    quDeportExcavators.Post;
    quDeportExcavators.Locate('Id_DeportExcavator',Id_DeportExcavator,[]);
    quDeportExcavators.Edit;
    quDeportExcavatorsSortIndex.AsInteger := FSortIndex-1;
    quDeportExcavators.Post;
    quDeportExcavators.Requery;
    quDeportExcavators.Locate('Id_DeportExcavator',Id_DeportExcavator,[]);
    quDeportExcavators.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmExcavators.pmiDownClick(Sender: TObject);
var Id_DeportExcavator: Integer;
begin
  with fmDM do
  if (not(quDeportExcavators.State in [dsEdit,dsInsert]))and
     (quDeportExcavators.RecNo<quDeportExcavators.RecordCount) then
  begin
    quDeportExcavators.DisableControls;
    FSortIndex  := quDeportExcavatorsSortIndex.AsInteger;
    Id_DeportExcavator := quDeportExcavatorsId_DeportExcavator.AsInteger;
    quDeportExcavators.Next;
    quDeportExcavators.Edit;
    quDeportExcavatorsSortIndex.AsInteger := FSortIndex;
    quDeportExcavators.Post;
    quDeportExcavators.Locate('Id_DeportExcavator',Id_DeportExcavator,[]);
    quDeportExcavators.Edit;
    quDeportExcavatorsSortIndex.AsInteger := FSortIndex+1;
    quDeportExcavators.Post;
    quDeportExcavators.Requery;
    quDeportExcavators.Locate('Id_DeportExcavator',Id_DeportExcavator,[]);
    quDeportExcavators.EnableControls;
  end;{if}
end;{pmiDownClick}


end.
