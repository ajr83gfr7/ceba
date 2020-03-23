unit unExcavatorModels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs,
  types;

type
  TfmExcavatorModels = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    pmExcavators: TPopupMenu;
    pmiAdd: TMenuItem;
    pmiEdit: TMenuItem;
    pmiDelete: TMenuItem;
    pmiDeleteAll: TMenuItem;
    pmiSep1: TMenuItem;
    pmiDefault: TMenuItem;
    pmiSep3: TMenuItem;
    pmiExcel: TMenuItem;
    pmiSep4: TMenuItem;
    pmiDefaultsDlg: TMenuItem;
    btExcel: TButton;
    pmiSep2: TMenuItem;
    pmiUp: TMenuItem;
    pmiDown: TMenuItem;
    pnClient: TPanel;
    pnRight: TPanel;
    pnData: TPanel;
    pbExcavators: TPaintBox;
    dbgExcavators: TDBGrid;
    dbmNote: TDBMemo;
    lbNote: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbExcavatorsPaint(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmExcavatorsPopup(Sender: TObject);
    procedure dbgExcavatorsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure pmiDefaultsDlgClick(Sender: TObject);
    procedure pmiUpClick(Sender: TObject);
    procedure pmiDownClick(Sender: TObject);
  private
    FSortIndex: Integer;         //Порядковый номер Excavator
    FName     : String;          //Уникальное название Excavator
    FColWidths: TIntegerDynArray;//Ширина столбцов таблицы Excavator
    procedure DoAfterDelete(DataSet: TDataSet);
    procedure DoAfterInsert(DataSet: TDataSet);
    procedure DoAfterPost(DataSet: TDataSet);
    procedure DoBeforeDelete(DataSet: TDataSet);
    procedure DoBeforeInsert(DataSet: TDataSet);
    procedure DoBeforePost(DataSet: TDataSet);
  public
  end;{TfmAutos}

var
  fmExcavatorModels: TfmExcavatorModels;

//Диалоговое окно моделей экскаваторов
procedure esaShowExcavatorModelsDlg();
implementation

uses unDM, Globals, ADODb, Math, ExcelEditors,
  unExcavatorModelDefaults, Printers;

{$R *.dfm}
//Диалоговое окно моделей экскаваторов
procedure esaShowExcavatorModelsDlg();
begin
  fmExcavatorModels := TfmExcavatorModels.Create(nil);
  try
    fmExcavatorModels.ShowModal;
  finally
    fmExcavatorModels.Free;
  end;{try}
end;{esaShowExcavatorModelsDlg}


procedure TfmExcavatorModels.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  SetLength(FColWidths,dbgExcavators.Columns.Count);
  dbgExcavators.Options := [dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines,dgTabs];
  FName := '';
  with fmDM do
  begin
    quExcavatorEngines.Open;
    if quExcavatorEngines.RecordCount=0
    then raise Exception.Create(EEmptyExcavatorEngines);
    if not quExcavatorEngines.Locate('Id_Engine',DefaultParams.ExcavatorId_Engine,[])
    then DefaultParams.ExcavatorId_Engine := quExcavatorEnginesId_Engine.AsInteger;
    quExcavatorEngines.First;
    quExcavators.BeforeDelete := DoBeforeDelete;
    quExcavators.BeforeInsert := DoBeforeInsert;
    quExcavators.BeforePost := DoBeforePost;
    quExcavators.AfterDelete := DoAfterDelete;
    quExcavators.AfterInsert := DoAfterInsert;
    quExcavators.AfterPost := DoAfterPost;
    quExcavators.Open;
  end;{with}
end;{FormCreate}
procedure TfmExcavatorModels.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quExcavators.Close;
    quExcavatorEngines.Close;
    quExcavators.BeforeDelete := nil;
    quExcavators.BeforeInsert := nil;
    quExcavators.BeforePost := nil;
    quExcavators.AfterDelete := nil;
    quExcavators.AfterInsert := nil;
    quExcavators.AfterPost := nil;
  end;{with}
  FColWidths := nil;
end;{FormClose}
procedure TfmExcavatorModels.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quExcavators,'Модели экскаваторов');
end;{FormCloseQuery}
procedure TfmExcavatorModels.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgExcavators,1);
  UpdateColumnRights(dbgExcavators,FColWidths);
end;{FormResize}
procedure TfmExcavatorModels.pbExcavatorsPaint(Sender: TObject);
var
  Cvs: TCanvas;
begin
  Cvs := pbExcavators.Canvas;
  DrawGridTitle(pbExcavators,dbgExcavators,4,FColWidths);
  with dbgExcavators do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],3*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[0]+1,1,FColWidths[1],3*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[1]+1,1,FColWidths[2],3*hCell,['Емкость', 'ковша,','м3']);
    with Columns[3] do
      DrawGridCell(Cvs,FColWidths[2]+1,1,FColWidths[3],3*hCell,['Время', 'цикла,','с']);
    with Columns[4] do
      DrawGridCell(Cvs,FColWidths[3]+1,1,FColWidths[4],3*hCell,['Двигатель']);
    with Columns[5] do
      DrawGridCell(Cvs,FColWidths[4]+1,1,FColWidths[5],3*hCell,['Максим.','N двиг,','кВт']);
    with Columns[6] do
      DrawGridCell(Cvs,FColWidths[5]+1,1,FColWidths[8],hCell,['Габариты']);
    with Columns[6] do
      DrawGridCell(Cvs,FColWidths[5]+1,hCell+1,FColWidths[6],3*hCell,['Длина,','м']);
    with Columns[7] do
      DrawGridCell(Cvs,FColWidths[6]+1,hCell+1,FColWidths[7],3*hCell,['Ширина,','м']);
    with Columns[8] do
      DrawGridCell(Cvs,FColWidths[7]+1,hCell+1,FColWidths[8],3*hCell,['Высота,','м']);
  //  with Columns[9] do
   //   DrawGridCell(Cvs,FColWidths[8]+1,1,FColWidths[9],3*hCell,['Балансовая','стоимость,','тыс.тг']);
  end;{with}
end;{pbExcavatorsPaint}

procedure TfmExcavatorModels.DoBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('Name').AsString]))
  then Abort
  else
    //перед удалением экскаватора, убираю их с пунтов погрузки
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE OpenpitLoadingPunkts '+
                  'SET Id_DeportExcavator=Null '+
                  'WHERE Id_DeportExcavator in '+
                  '(SELECT Id_DeportExcavator '+
                  ' FROM OpenpitDeportExcavators '+
                  ' WHERE Id_Excavator='+fmDM.quExcavatorsId_Excavator.AsString+')';
      ExecSQL;
    finally
      Free;
    end;{try}
end;{DoBeforeDelete}
procedure TfmExcavatorModels.DoBeforeInsert(DataSet: TDataSet);
begin
  FName := '';
  FSortIndex := Dataset.RecordCount+1;
  if InputName('Изменить','Наименование',FName,Dataset.FieldByName('Name').Size)then
  begin
    if DataSet.Locate('Name',FName,[]) then
    begin
      esaMsgError(Format(EDuplicateObj,['Данная модель экскаватора',FName]));
      FName := '';
      Abort;
    end;{if}
  end{if}
  else Abort;
end;{DoBeforeInsert}
procedure TfmExcavatorModels.DoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if Dataset.FieldbyName('Id_Engine').Value=null then
      Dataset.FieldbyName('Id_Engine').AsInteger := DefaultParams.ExcavatorId_Engine;

    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('BucketCapacity'),1.0)then Abort  
    else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('CycleTime'),1.0)then Abort  
    else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('ELength'),1.0)then Abort  
    else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('EWidth'),1.0)then Abort  
    else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('EHeight'),1.0)then Abort  
    else
    if (Dataset.State=dsInsert)and(FName<>'') then
    begin
      DataSet.FieldByName('Name').AsString := FName;
    end;{if}
  end;{if}
end;{DoBeforePost}
procedure TfmExcavatorModels.DoAfterDelete(DataSet: TDataSet);
var Id_Excavator, ASortIndex: Integer;
begin
  Id_Excavator := Dataset.FieldByName('Id_Excavator').AsInteger;
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
  Dataset.Locate('Id_Excavator',Id_Excavator,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbExcavators.Invalidate;
end;{DoAfterDelete}
procedure TfmExcavatorModels.DoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FName<>'') then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldbyName('Name').AsString := FName;
    Dataset.FieldbyName('BucketCapacity').AsFloat := DefaultParams.ExcavatorBucketCapacity;
    Dataset.FieldbyName('CycleTime').AsFloat := DefaultParams.ExcavatorCycleTime;
    Dataset.FieldbyName('ELength').AsFloat := DefaultParams.ExcavatorLength;
    Dataset.FieldbyName('EWidth').AsFloat := DefaultParams.ExcavatorWidth;
    Dataset.FieldbyName('EHeight').AsFloat := DefaultParams.ExcavatorHeight;
    if Dataset.FieldbyName('Id_Engine').Value=null then
      Dataset.FieldbyName('Id_Engine').AsInteger := DefaultParams.ExcavatorId_Engine;
  end;{if}
end;{DoAfterInsert}
procedure TfmExcavatorModels.DoAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbExcavators.Invalidate;
end;{DoAfterPost}
procedure TfmExcavatorModels.pmiAddClick(Sender: TObject);
begin
  fmDM.quExcavators.Append;
end;{pmiExcavatorAddClick}
procedure TfmExcavatorModels.pmiEditClick(Sender: TObject);
begin
  with fmDM do
  begin
    FName := quExcavatorsName.AsString;
    if InputName('Изменить','Наименование',FName,quExcavatorsName.Size)then
    begin
      if quExcavators.Locate('Name',FName,[])
      then esaMsgError(Format(EDuplicateObj,['Данная модель экскаватора',FName]))
      else
      begin
        quExcavators.Edit;
        quExcavatorsName.AsString := FName;
      end;{else}
    end;{if}
    FName := '';
  end;{with}
end;{pmiExcavatorEditClick}
procedure TfmExcavatorModels.pmiDeleteClick(Sender: TObject);
begin
  fmDM.quExcavators.Delete;
end;{pmiExcavatorDeleteClick}
procedure TfmExcavatorModels.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quExcavators.Requery;
    //перед удалением экскаватора, убираю их с пунтов погрузки
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE OpenpitLoadingPunkts SET Id_DeportExcavator=Null WHERE Id_Openpit='+
                  fmDM.quOpenpitsId_Openpit.AsString;
      ExecSQL;
      SQL.Text := 'DELETE FROM Excavators';
      ExecSQL;
    finally
      Free;
    end;{try}
    quExcavators.Requery;
    quExcavators.EnableControls;
    FormResize(Self);
    pbExcavators.Invalidate;
  end;{with}
end;{pmiExcavatorDeleteAllClick}
procedure TfmExcavatorModels.pmiUpClick(Sender: TObject);
var Id_Excavator: Integer;
begin
  with fmDM do
  if (not(quExcavators.State in [dsEdit,dsInsert]))and(quExcavators.RecNo>1) then
  begin
    quExcavators.DisableControls;
    FSortIndex  := quExcavatorsSortIndex.AsInteger;
    Id_Excavator := quExcavatorsId_Excavator.AsInteger;
    quExcavators.Prior;
    quExcavators.Edit;
    quExcavatorsSortIndex.AsInteger := FSortIndex;
    quExcavators.Post;
    quExcavators.Locate('Id_Excavator',Id_Excavator,[]);
    quExcavators.Edit;
    quExcavatorsSortIndex.AsInteger := FSortIndex-1;
    quExcavators.Post;
    quExcavators.Requery;
    quExcavators.Locate('Id_Excavator',Id_Excavator,[]);
    quExcavators.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmExcavatorModels.pmiDownClick(Sender: TObject);
var Id_Excavator: Integer;
begin
  with fmDM do
  if (not(quExcavators.State in [dsEdit,dsInsert]))and
     (quExcavators.RecNo<quExcavators.RecordCount) then
  begin
    quExcavators.DisableControls;
    FSortIndex  := quExcavatorsSortIndex.AsInteger;
    Id_Excavator := quExcavatorsId_Excavator.AsInteger;
    quExcavators.Next;
    quExcavators.Edit;
    quExcavatorsSortIndex.AsInteger := FSortIndex;
    quExcavators.Post;
    quExcavators.Locate('Id_Excavator',Id_Excavator,[]);
    quExcavators.Edit;
    quExcavatorsSortIndex.AsInteger := FSortIndex+1;
    quExcavators.Post;
    quExcavators.Requery;
    quExcavators.Locate('Id_Excavator',Id_Excavator,[]);
    quExcavators.EnableControls;
  end;{if}
end;{pmiDownClick}
procedure TfmExcavatorModels.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.ExcavatorBucketCapacity := fmDM.quExcavatorsBucketCapacity.AsFloat;
    DefaultParams.ExcavatorCycleTime := fmDM.quExcavatorsCycleTime.AsFloat;
    DefaultParams.ExcavatorId_Engine := fmDM.quExcavatorsId_Engine.AsInteger;
    DefaultParams.ExcavatorLength := fmDM.quExcavatorsELength.AsFloat;
    DefaultParams.ExcavatorWidth := fmDM.quExcavatorsEWidth.AsFloat;
    DefaultParams.ExcavatorHeight := fmDM.quExcavatorsEHeight.AsFloat;
  end;{if}
end;{pmiExcavatorDefaultClick}
procedure TfmExcavatorModels.pmiDefaultsDlgClick(Sender: TObject);
begin
  esaShowExcavatorModelDefaultsDlg(HelpKeyword);
end;{pmiDefaultsDlgClick}
procedure TfmExcavatorModels.pmiExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  ACount,I: Integer;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1;
    XL.SheetName := 'Excavators';
    //Шапка
    XL.ActiveSheetHeader('&8CEBADAN-AUTO, II','&8'+Caption,'&8&D');
    XL.ActiveSheetFooter('','&8&P из &N','');
    XL.Cells[1,1,10,1].Frame := [feTop];
    XL.TitleCell[1, 1,10,1]:= Caption;
    XL.Cells[1, 1,10,1].Font.Style := [xlfsBold];
    XL.TitleCell[2, 1,1,3] := '№';
    XL.TitleCell[2, 2,1,3] := 'Модель';
    XL.TitleCell[2, 3,1,3] := 'Емкость ковша, м.куб.';
    XL.TitleCell[2, 4,1,3] := 'Время цикла, т.';
    XL.TitleCell[2, 5,2,1] := 'Двигатель';
    XL.TitleCell[3, 5,1,2] := 'Модель';
    XL.TitleCell[3, 6,1,2] := 'Максимальная мощность, кВт';
    XL.TitleCell[2, 7,3,1] := 'Габариты, м';
    XL.TitleCell[3, 7,1,2] := 'Длина';
    XL.TitleCell[3, 8,1,2] := 'Ширина';
    XL.TitleCell[3, 9,1,2] := 'Высота';
    XL.TitleCell[2,10,1,3] := 'Балансовая стоимость, тыс.тг';
    XL.TitleCell[2,11,1,3] := 'Примечание';
    for I := 1 to 10 do
      XL.TitleCell[5,I,1,1] := IntToStr(I);
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 3.0;
    XL.ColumnWidths[2,1] := 19.0;
    XL.ColumnWidths[3,1] := 7.0;
    XL.ColumnWidths[4,6] := 6.0;
    XL.ColumnWidths[5,1] := 14.0;
    XL.ColumnWidths[6,1] := 11.0;
    XL.ColumnWidths[10,1]:= 10.0;
    XL.ColumnWidths[11,1]:= 40.0;
    ACount := Max(1,fmDM.quExcavators.RecordCount);
    //Рамка
    XL.Cells[2,1,10,ACount+4].Frame := [feTotal];
    //Числовые форматы
    XL.Cells[6,3,2,ACount+1].NumberFormat := nfFloat00;
    XL.Cells[6,6,9,ACount+1].NumberFormat := nfFloat00;
    //Данные
    with fmDM do
    begin
      quExcavators.First;
      while not quExcavators.Eof do
      begin
        XL.IntegerCells[quExcavators.RecNo+5, 1] := quExcavatorsSortIndex.AsInteger;
        XL.StringCells [quExcavators.RecNo+5, 2] := quExcavatorsName.AsString;
        XL.FloatCells  [quExcavators.RecNo+5, 3] := quExcavatorsBucketCapacity.AsFloat;
        XL.FloatCells  [quExcavators.RecNo+5, 4] := quExcavatorsCycleTime.AsFloat;
        XL.StringCells [quExcavators.RecNo+5, 5] := quExcavatorsEngineName.AsString;
        XL.FloatCells  [quExcavators.RecNo+5, 6] := quExcavatorsEngineNmax.AsFloat;
        XL.FloatCells  [quExcavators.RecNo+5, 7] := quExcavatorsELength.AsFloat;
        XL.FloatCells  [quExcavators.RecNo+5, 8] := quExcavatorsEWidth.AsFloat;
        XL.FloatCells  [quExcavators.RecNo+5, 9] := quExcavatorsEHeight.AsFloat;
       // XL.FloatCells  [quExcavators.RecNo+5,10] := quExcavatorsBalanceC1000tg.AsFloat;
        XL.StringCells [quExcavators.RecNo+5,11] := quExcavatorsNote.AsVariant;
        quExcavators.Next;
      end;{while}
      quExcavators.First;
    end;{with}
    XL.ActiveSheetPageSetup(10,10,10,10,5,5,poPortrait);
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiExcavatorExcelClick}
procedure TfmExcavatorModels.pmExcavatorsPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiAdd.Enabled := quExcavators.Active;
    pmiEdit.Enabled := pmiAdd.Enabled and(quExcavators.RecordCount>0)and
                       (not (quExcavators.State in [dsEdit,dsInsert]));
    pmiUp.Enabled := pmiEdit.Enabled and(quExcavators.RecNo>1);
    pmiDown.Enabled := pmiEdit.Enabled and(quExcavators.RecNo<quExcavators.RecordCount);
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiDefault.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiEdit.Enabled;
  end;{with}
end;{pmExcavatorsPopup}

procedure TfmExcavatorModels.dbgExcavatorsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DrawDBGridColumnCell(dbgExcavators,Rect,DataCol,Column,State);
end;{dbgExcavatorsDrawColumnCell}

end.
