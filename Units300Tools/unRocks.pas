unit unRocks;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs,
  types;

type
  TfmRocks = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    pmRocks: TPopupMenu;
    pmiAdd: TMenuItem;
    pmiEdit: TMenuItem;
    pmiDelete: TMenuItem;
    pmiDeleteAll: TMenuItem;
    pmiSep1: TMenuItem;
    pmiExcel: TMenuItem;
    pmiSep3: TMenuItem;
    pbRocks: TPaintBox;
    dbgRocks: TDBGrid;
    pmiDefault: TMenuItem;
    pmiSep2: TMenuItem;
    pmiDefaultsDlg: TMenuItem;
    btExcel: TButton;
    pmiSep4: TMenuItem;
    pmiUp: TMenuItem;
    pmiDown: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbRocksPaint(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmRocksPopup(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure dbgRocksColEnter(Sender: TObject);
    procedure dbgRocksKeyPress(Sender: TObject; var Key: Char);
    procedure dbgRocksDblClick(Sender: TObject);
    procedure dbgRocksDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
  end;{TfmAutos}

var
  fmRocks: TfmRocks;

//Диалоговое окно горной массы
procedure esaShowRocksDlg();
implementation

uses unDM, Globals, ADODb, Math, ExcelEditors, unRockDefaults;

{$R *.dfm}

//Диалоговое окно горной массы
procedure esaShowRocksDlg();
begin
  fmRocks := TfmRocks.Create(nil);
  try
    fmRocks.ShowModal;
  finally
    fmRocks.Free;
  end;{try}
end;{esaShowRocksDlg}

procedure TfmRocks.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  SetLength(FColWidths,dbgRocks.Columns.Count);
  dbgRocks.Options := [dgEditing,dgIndicator,dgColLines,dgRowLines,dgTabs];
  FName := '';
  with fmDM do
  begin
    quRocks.BeforeDelete := DoBeforeDelete;
    quRocks.BeforeInsert := DoBeforeInsert;
    quRocks.BeforePost := DoBeforePost;
    quRocks.AfterDelete := DoAfterDelete;
    quRocks.AfterInsert := DoAfterInsert;
    quRocks.AfterPost := DoAfterPost;
    quRocks.Open;
  end;{with}
end;{FormCreate}
procedure TfmRocks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quRocks.Close;
    quRocks.AfterScroll := nil;
    quRocks.BeforeDelete := nil;
    quRocks.BeforeInsert := nil;
    quRocks.BeforePost := nil;
    quRocks.AfterDelete := nil;
    quRocks.AfterInsert := nil;
    quRocks.AfterPost := nil;
  end;{with}
  FColWidths := nil;
end;{FormClose}
procedure TfmRocks.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quRocks,'Типы горной породы');
end;{FormCloseQuery}
procedure TfmRocks.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgRocks,1);
  UpdateColumnRights(dbgRocks,FColWidths);
end;{FormResize}
procedure TfmRocks.pbRocksPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbRocks.Canvas;
  DrawGridTitle(pbRocks,dbgRocks,3,FColWidths);
  with dbgRocks do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],2*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[0]+1,1,FColWidths[1],2*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[1]+1,1,FColWidths[2],2*hCell,['Признак полезного','ископаемого']);
  end;{with}
end;{pbRocksPaint}

procedure TfmRocks.DoBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('Name').AsString]))
  then Abort;
end;{DoBeforeDelete}
procedure TfmRocks.DoBeforeInsert(DataSet: TDataSet);
begin
  FSortIndex := Dataset.RecordCount+1;
  FName := '';
  if InputName('Добавить','Наименование',FName,Dataset.FieldByName('Name').Size)then
  begin
    if DataSet.Locate('Name',FName,[]) then
    begin
      esaMsgError(Format(EDuplicateObj,['Данный тип горной породы',FName]));
      FName := '';
      Abort;
    end;{if}
  end{if}
  else Abort;
end;{DoBeforeInsert}
procedure TfmRocks.DoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if (Dataset.State=dsInsert)and(FName<>'') then
    begin
      DataSet.FieldByName('Name').AsString := FName;
    end;{if}
  end;{if}
end;{DoBeforePost}
procedure TfmRocks.DoAfterDelete(DataSet: TDataSet);
var Id_Rock, ASortIndex: Integer;
begin
  Id_Rock := Dataset.FieldByName('Id_Rock').AsInteger;
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
  Dataset.Locate('Id_Rock',Id_Rock,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbRocks.Invalidate;
end;{DoAfterDelete}
procedure TfmRocks.DoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FName<>'') then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldByName('Name').AsString := FName;
    Dataset.FieldByName('IsMineralWealth').AsBoolean := DefaultParams.RockIsMineralWealth;
  end;{if}
end;{DoAfterInsert}
procedure TfmRocks.DoAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbRocks.Invalidate;
end;{DoAfterPost}
procedure TfmRocks.pmiAddClick(Sender: TObject);
begin
  fmDM.quRocks.Append;
end;{pmiRockAddClick}
procedure TfmRocks.pmiEditClick(Sender: TObject);
begin
  with fmDM do
  begin
    FName := quRocksName.AsString;
    if InputName('Изменить','Наименование',FName,quRocksName.Size)then
    begin
      if quRocks.Locate('Name',FName,[])
      then esaMsgError(Format(EDuplicateObj,['Данный тип горной породы',FName]))
      else
      begin
        quRocks.Edit;
        quRocksName.AsString := FName;
      end;{else}
    end;{if}
    FName := '';
  end;{with}
end;{pmiRockEditClick}
procedure TfmRocks.pmiDeleteClick(Sender: TObject);
begin
  fmDM.quRocks.Delete;
end;{pmiRockDeleteClick}
procedure TfmRocks.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quRocks.AfterDelete := nil;
    quRocks.BeforeDelete := nil;
    quRocks.DisableControls;
    quRocks.Requery;
    while not quRocks.Eof do
      quRocks.Delete;
    quRocks.Requery;
    quRocks.EnableControls;
    FormResize(Self);
    pbRocks.Invalidate;
    quRocks.AfterDelete := DoAfterDelete;
    quRocks.BeforeDelete := DoBeforeDelete;
  end;{with}
end;{pmiRockDeleteAllClick}
procedure TfmRocks.pmiExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  ACount: Integer;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1;
    //Заголовок
    XL.TitleCell[1,1,3,1] := Caption;
    //Шапка
    XL.RangeTitleOn(2,1,['№','Наименование','Признак полезного ископаемоего']);
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 3.0;
    XL.ColumnWidths[2,1] := 30.0;
    XL.ColumnWidths[3,1] := 20.0;
    if fmDM.quRocks.RecordCount=0
    then ACount := 1
    else ACount := fmDM.quRocks.RecordCount;
    XL.Cells[2,1,3,ACount+2].Frame := [feTotal];
    XL.Cells[4,3,1,ACount+2].HorizontalAlignment := haCenter;
    //Данные
    with fmDM do
    begin
      quRocks.First;
      while not quRocks.Eof do
      begin
        XL.IntegerCells[quRocks.RecNo+3, 1] := quRocksSortIndex.AsInteger;
        XL.StringCells [quRocks.RecNo+3, 2] := quRocksName.AsString;
        if quRocksIsMineralWealth.AsBoolean
        then XL.StringCells[quRocks.RecNo+3,3] := '+';
        quRocks.Next;
      end;{while}
      quRocks.First;
    end;{with}
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiRockExcelClick}
procedure TfmRocks.pmRocksPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiAdd.Enabled := true;
    pmiEdit.Enabled := pmiAdd.Enabled and(quRocks.RecordCount>0)and
                      (not (quRocks.State in [dsEdit,dsInsert]));
    pmiUp.Enabled := pmiEdit.Enabled and(quRocks.RecNo>1);
    pmiDown.Enabled := pmiEdit.Enabled and(quRocks.RecNo<quRocks.RecordCount);
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiAdd.Enabled;
  end;{with}
end;{pmRocksPopup}

procedure TfmRocks.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.RockIsMineralWealth := fmDM.quRocksIsMineralWealth.AsBoolean;
  end;{if}
end;{pmiDefaultClick}
procedure TfmRocks.pmiDefaultsDlgClick(Sender: TObject);
begin
  esaShowRockDefaultsDlg(HelpKeyword);
end;{pmiDefaultsDlgClick}
procedure TfmRocks.dbgRocksColEnter(Sender: TObject);
begin
  if dbgRocks.Columns[dbgRocks.SelectedIndex].Field=fmDM.quRocksIsMineralWealth
  then dbgRocks.Tag := 1
  else dbgRocks.Tag := 0;
end;{dbgRocksColEnter}

procedure TfmRocks.dbgRocksKeyPress(Sender: TObject; var Key: Char);
begin
  if dbgRocks.Tag>0 then
  begin
    Key := #0;
    if not (fmDM.quRocks.State in [dsEdit,dsInsert])then fmDM.quRocks.Edit;
    fmDM.quRocksIsMineralWealth.AsBoolean := not fmDM.quRocksIsMineralWealth.AsBoolean;
  end;{if}
end;{dbgRocksKeyPress}

procedure TfmRocks.dbgRocksDblClick(Sender: TObject);
var Key: Char;
begin
  dbgRocksKeyPress(Sender,Key);
end;{dbgRocksDblClick}

procedure TfmRocks.dbgRocksDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DrawDBGridColumnCell(dbgRocks,Rect,DataCol,Column,State);
end;{dbgRocksDrawColumnCell}


procedure TfmRocks.pmiUpClick(Sender: TObject);
var Id_Rock: Integer;
begin
  with fmDM do
  if (not(quRocks.State in [dsEdit,dsInsert]))and(quRocks.RecNo>1) then
  begin
    quRocks.DisableControls;
    FSortIndex  := quRocksSortIndex.AsInteger;
    Id_Rock := quRocksId_Rock.AsInteger;
    quRocks.Prior;
    quRocks.Edit;
    quRocksSortIndex.AsInteger := FSortIndex;
    quRocks.Post;
    quRocks.Locate('Id_Rock',Id_Rock,[]);
    quRocks.Edit;
    quRocksSortIndex.AsInteger := FSortIndex-1;
    quRocks.Post;
    quRocks.Requery;
    quRocks.Locate('Id_Rock',Id_Rock,[]);
    quRocks.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmRocks.pmiDownClick(Sender: TObject);
var Id_Rock: Integer;
begin
  with fmDM do
  if (not(quRocks.State in [dsEdit,dsInsert]))and
     (quRocks.RecNo<quRocks.RecordCount) then
  begin
    quRocks.DisableControls;
    FSortIndex  := quRocksSortIndex.AsInteger;
    Id_Rock := quRocksId_Rock.AsInteger;
    quRocks.Next;
    quRocks.Edit;
    quRocksSortIndex.AsInteger := FSortIndex;
    quRocks.Post;
    quRocks.Locate('Id_Rock',Id_Rock,[]);
    quRocks.Edit;
    quRocksSortIndex.AsInteger := FSortIndex+1;
    quRocks.Post;
    quRocks.Requery;
    quRocks.Locate('Id_Rock',Id_Rock,[]);
    quRocks.EnableControls;
  end;{if}
end;{pmiDownClick}

end.
