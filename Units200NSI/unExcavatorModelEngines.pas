unit unExcavatorModelEngines;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB, Menus, types;

type
  TfmExcavatorModelEngines = class(TForm)
    PaintBox: TPaintBox;
    dbgExcavatorEngines: TDBGrid;
    pnBtns: TPanel;
    btClose: TButton;
    pmExcavatorEngines: TPopupMenu;
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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure dbgExcavatorEnginesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure pmExcavatorEnginesPopup(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmiDefaultsDlgClick(Sender: TObject);
    procedure pmiUpClick(Sender: TObject);
    procedure pmiDownClick(Sender: TObject);
  private
    FSortIndex: Integer;         //Порядковый номер
    FName     : String;          //Уникальное название
    FColWidths: TIntegerDynArray;//Ширина столбцов таблицы 
    procedure DoAfterDelete(DataSet: TDataSet);
    procedure DoAfterInsert(DataSet: TDataSet);
    procedure DoAfterPost(DataSet: TDataSet);
    procedure DoBeforeDelete(DataSet: TDataSet);
    procedure DoBeforeInsert(DataSet: TDataSet);
    procedure DoBeforePost(DataSet: TDataSet);
  public
  end;{TfmExcavatorEngines}

var
  fmExcavatorModelEngines: TfmExcavatorModelEngines;

//Диалоговое окно моделей двигателя экскаватора
function esaShowExcavatorModelEnginesDlg(): Boolean;
implementation

uses unDM, Globals, ADODb, ComObj, Excel2000, ExcelEditors, unExcavatorModelEngineDefaults;

{$R *.dfm}

//Диалоговое окно моделей двигателя экскаватора
function esaShowExcavatorModelEnginesDlg(): Boolean;
begin
  fmExcavatorModelEngines := TfmExcavatorModelEngines.Create(nil);
  try
    Result := fmExcavatorModelEngines.ShowModal=mrOk;
  finally
    fmExcavatorModelEngines.Free;
  end;{try}
end;{esaShowExcavatorModelEnginesDlg}

procedure TfmExcavatorModelEngines.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  dbgExcavatorEngines.Options := [dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines,dgTabs];
  SetLength(FColWidths,dbgExcavatorEngines.Columns.Count);
  FName := '';
  with fmDM do
  begin
    quExcavatorEngines.BeforeDelete := DoBeforeDelete;
    quExcavatorEngines.BeforeInsert := DoBeforeInsert;
    quExcavatorEngines.BeforePost := DoBeforePost;
    quExcavatorEngines.AfterDelete := DoAfterDelete;
    quExcavatorEngines.AfterInsert := DoAfterInsert;
    quExcavatorEngines.AfterPost := DoAfterPost;
    quExcavatorEngines.Open;
  end;{with}
end;{FormCreate}
procedure TfmExcavatorModelEngines.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with fmDM do
  begin
    quExcavatorEngines.BeforeDelete := nil;
    quExcavatorEngines.BeforeInsert := nil;
    quExcavatorEngines.BeforePost := nil;
    quExcavatorEngines.AfterDelete := nil;
    quExcavatorEngines.AfterInsert := nil;
    quExcavatorEngines.AfterPost := nil;
    quExcavatorEngines.Close;
  end;{with}
  FColWidths := nil;
end;{FormClose}
procedure TfmExcavatorModelEngines.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quExcavatorEngines,'Марки двигателей экскаваторов');
end;{FormCloseQuery}
procedure TfmExcavatorModelEngines.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgExcavatorEngines,1);
  UpdateColumnRights(dbgExcavatorEngines,FColWidths);
end;{FormResize}

procedure TfmExcavatorModelEngines.PaintBoxPaint(Sender: TObject);
var
  Cvs: TCanvas;
begin
  Cvs := PaintBox.Canvas;
  DrawGridTitle(PaintBox,dbgExcavatorEngines,4,FColWidths);
  with dbgExcavatorEngines do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],3*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[1]-Width,1,FColWidths[1],3*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[2]-Width,1,FColWidths[2],3*hCell,['Максимальная','мощность',
                                                                'двигателя, кВт']);
  end;{with}
end;{PaintBoxPaint}

procedure TfmExcavatorModelEngines.DoBeforeDelete(DataSet: TDataSet);
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
                  ' WHERE Id_Excavator in'+
                  '(SELECT Id_Excavator '+
                  ' FROM Excavators '+
                  ' WHERE Id_Engine='+fmDM.quExcavatorEnginesId_Engine.AsString+'))';
      ExecSQL;
    finally
      Free;
    end;{try}
end;{DoBeforeDelete}
procedure TfmExcavatorModelEngines.DoBeforeInsert(DataSet: TDataSet);
begin
  FName := '';
  FSortIndex := Dataset.RecordCount+1;
  if InputName('Добавить','Наименование',FName,Dataset.FieldByName('Name').Size)then
  begin
    if DataSet.Locate('Name',FName,[]) then
    begin
      esaMsgError(Format(EDuplicateObj,['Данная модель двигателя',FName]));
      FName := '';
      Abort;
    end;{if}
  end{if}
  else Abort;
end;{DoBeforeInsert}
procedure TfmExcavatorModelEngines.DoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if not IsFloatFieldMoreMin(DataSet.FieldByName('Nmax'),1.0)then Abort
    else
    if (Dataset.State=dsInsert)and(FName<>'') then
    begin
      DataSet.FieldByName('Name').AsString := FName;
    end;{if}
  end;{if}
end;{DoBeforePost}
procedure TfmExcavatorModelEngines.DoAfterDelete(DataSet: TDataSet);
var Id_ExcavatorEngine, ASortIndex: Integer;
begin
  Id_ExcavatorEngine := Dataset.FieldByName('Id_Engine').AsInteger;
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
  Dataset.Locate('Id_Engine',Id_ExcavatorEngine,[]);
  Dataset.EnableControls;
  FormResize(Self);
  PaintBox.Invalidate;
end;{DoAfterDelete}
procedure TfmExcavatorModelEngines.DoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FName<>'') then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldbyName('Name').AsString := FName;
    Dataset.FieldbyName('Nmax').AsFloat := DefaultParams.ExcavatorEngineNmax;
  end;{if}
end;{DoAfterInsert}
procedure TfmExcavatorModelEngines.DoAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  PaintBox.Invalidate;
end;{DoAfterPost}
procedure TfmExcavatorModelEngines.dbgExcavatorEnginesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DrawDBGridColumnCell(dbgExcavatorEngines,Rect,DataCol,Column,State);
end;{dbgExcavatorEnginesDrawColumnCell}

procedure TfmExcavatorModelEngines.pmExcavatorEnginesPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiEdit.Enabled := (quExcavatorEngines.RecordCount>0)and
                       (not (quExcavatorEngines.State in [dsEdit,dsInsert]));
    pmiUp.Enabled := pmiEdit.Enabled and(quExcavatorEngines.RecNo>1);
    pmiDown.Enabled := pmiEdit.Enabled and(quExcavatorEngines.RecNo<quExcavatorEngines.RecordCount);
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiDefault.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiEdit.Enabled;
  end;{with}
end;{pmExcavatorEnginesPopup}
procedure TfmExcavatorModelEngines.pmiAddClick(Sender: TObject);
begin
  fmDm.quExcavatorEngines.Append;
end;{pmiAddClick}
procedure TfmExcavatorModelEngines.pmiEditClick(Sender: TObject);
begin
  with fmDM do
  begin
    FName := quExcavatorEnginesName.AsString;
    if InputName('Изменить','Наименование',FName,quExcavatorEnginesName.Size)then
    begin
      if quExcavatorEngines.Locate('Name',FName,[])
      then esaMsgError(Format(EDuplicateObj,['Данная модель двигателя',FName]))
      else
      begin
        quExcavatorEngines.Edit;
        quExcavatorEnginesName.AsString := FName;
      end;{else}
    end;{if}
    FName := '';
  end;{with}
end;{pmiEditClick}
procedure TfmExcavatorModelEngines.pmiDeleteClick(Sender: TObject);
begin
  fmDm.quExcavatorEngines.Delete;
end;{pmiDeleteClick}
procedure TfmExcavatorModelEngines.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quExcavatorEngines.Requery;
    //перед удалением экскаватора, убираю их с пунтов погрузки
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := 'UPDATE OpenpitLoadingPunkts SET Id_DeportExcavator=Null WHERE Id_Openpit='+
                  fmDM.quOpenpitsId_Openpit.AsString;
      ExecSQL;
      SQL.Text := 'DELETE FROM OpenpitDeportEngines';
      ExecSQL;
    finally
      Free;
    end;{try}
    quExcavatorEngines.Requery;
    FormResize(Self);
    PaintBox.Invalidate;
    quExcavatorEngines.BeforeDelete := DoBeforeDelete;
    quExcavatorEngines.AfterDelete := DoAfterDelete;
  end;{with}
end;{pmiDeleteAllClick}
procedure TfmExcavatorModelEngines.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)
  then DefaultParams.ExcavatorEngineNmax := fmDM.quExcavatorEnginesNmax.AsFloat;
end;{pmiDefaultClick}
procedure TfmExcavatorModelEngines.pmiDefaultsDlgClick(Sender: TObject);
begin
  esaShowExcavatorModelEngineDefaultsDlg(HelpKeyword);
end;{pmiDefaultsDlgClick}
procedure TfmExcavatorModelEngines.pmiExcelClick(Sender: TObject);
var
  XL    : TExcelEditor;
  ACount: Integer;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1;
    XL.TitleCell[1,1,3,1] := Caption;
    XL.RangeTitleOn(2,1,['№','Наименование', 'Максимальная мощность двигателя, кВт']);
    XL.ColumnWidths[1,1] := 5.0;
    XL.ColumnWidths[2,1] := 60.0;
    XL.ColumnWidths[3,1] := 11.0;
    if fmDM.quExcavatorEngines.RecordCount=0
    then ACount := 1
    else ACount := fmDM.quExcavatorEngines.RecordCount;
    XL.Cells[2,1,3,ACount+2].Frame := [feTotal];
    with fmDM do
    begin
      quExcavatorEngines.First;
      while not quExcavatorEngines.Eof do
      begin
        XL.IntegerCells[quExcavatorEngines.RecNo+3,1] := quExcavatorEnginesSortIndex.AsInteger;
        XL.StringCells[quExcavatorEngines.RecNo+3,2] := quExcavatorEnginesName.AsString;
        XL.StringCells[quExcavatorEngines.RecNo+3,3] := quExcavatorEnginesNmax.AsString;
        quExcavatorEngines.Next;
      end;{while}
      quExcavatorEngines.First;
    end;{with}
    XL.Cells[4,3,1,ACount+2].NumberFormat := nfFloat00;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiExcelClick}

procedure TfmExcavatorModelEngines.pmiUpClick(Sender: TObject);
var Id_ExcavatorEngine: Integer;
begin
  with fmDM do
  if (not(quExcavatorEngines.State in [dsEdit,dsInsert]))and(quExcavatorEngines.RecNo>1) then
  begin
    quExcavatorEngines.DisableControls;
    FSortIndex  := quExcavatorEnginesSortIndex.AsInteger;
    Id_ExcavatorEngine := quExcavatorEnginesId_Engine.AsInteger;
    quExcavatorEngines.Prior;
    quExcavatorEngines.Edit;
    quExcavatorEnginesSortIndex.AsInteger := FSortIndex;
    quExcavatorEngines.Post;
    quExcavatorEngines.Locate('Id_Engine',Id_ExcavatorEngine,[]);
    quExcavatorEngines.Edit;
    quExcavatorEnginesSortIndex.AsInteger := FSortIndex-1;
    quExcavatorEngines.Post;
    quExcavatorEngines.Requery;
    quExcavatorEngines.Locate('Id_Engine',Id_ExcavatorEngine,[]);
    quExcavatorEngines.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmExcavatorModelEngines.pmiDownClick(Sender: TObject);
var Id_ExcavatorEngine: Integer;
begin
  with fmDM do
  if (not(quExcavatorEngines.State in [dsEdit,dsInsert]))and
     (quExcavatorEngines.RecNo<quExcavatorEngines.RecordCount) then
  begin
    quExcavatorEngines.DisableControls;
    FSortIndex  := quExcavatorEnginesSortIndex.AsInteger;
    Id_ExcavatorEngine := quExcavatorEnginesId_Engine.AsInteger;
    quExcavatorEngines.Next;
    quExcavatorEngines.Edit;
    quExcavatorEnginesSortIndex.AsInteger := FSortIndex;
    quExcavatorEngines.Post;
    quExcavatorEngines.Locate('Id_Engine',Id_ExcavatorEngine,[]);
    quExcavatorEngines.Edit;
    quExcavatorEnginesSortIndex.AsInteger := FSortIndex+1;
    quExcavatorEngines.Post;
    quExcavatorEngines.Requery;
    quExcavatorEngines.Locate('Id_Engine',Id_ExcavatorEngine,[]);
    quExcavatorEngines.EnableControls;
  end;{if}
end;{pmiDownClick}

end.
