unit unAutoModelEngines;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB, Menus, types;
type
  TfmAutoModelEngines = class(TForm)
    PaintBox: TPaintBox;
    dbgAutoEngines: TDBGrid;
    pnBtns: TPanel;
    btClose: TButton;
    pmAutoEngines: TPopupMenu;
    pmiAdd: TMenuItem;
    pmiEdit: TMenuItem;
    pmiDelete: TMenuItem;
    pmiDeleteAll: TMenuItem;
    pmiSep1: TMenuItem;
    pmiDefault: TMenuItem;
    pmiSep3: TMenuItem;
    pmiExcel: TMenuItem;
    pmiSep4: TMenuItem;
    pmiChangeDefaults: TMenuItem;
    btExcel: TButton;
    pmiSep2: TMenuItem;
    pmiUp: TMenuItem;
    pmiDown: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure dbgAutoEnginesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure pmAutoEnginesPopup(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmiChangeDefaultsClick(Sender: TObject);
    procedure pmiUpClick(Sender: TObject);
    procedure pmiDownClick(Sender: TObject);
  private
    FSortIndex: Integer;         //Порядковый номер AutoEngine
    FName     : String;          //Уникальное название AutoEngine
    FColWidths: TIntegerDynArray;//Ширина столбцов таблицы AutoEngine
    procedure DoAfterDelete(DataSet: TDataSet);
    procedure DoAfterInsert(DataSet: TDataSet);
    procedure DoAfterPost(DataSet: TDataSet);
    procedure DoBeforeDelete(DataSet: TDataSet);
    procedure DoBeforeInsert(DataSet: TDataSet);
    procedure DoBeforePost(DataSet: TDataSet);
  public
  end;{TfmAutoEngines}
var
  fmAutoModelEngines: TfmAutoModelEngines;

//Диалоговое окно моделей двигателя автосамосвала
function esaShowAutoModelEnginesDlg(): Boolean;
implementation

uses unDM,Globals,ADODb,ComObj,Excel2000,ExcelEditors,unAutoModelEngineDefaults, Math;
{$R *.dfm}

//Диалоговое окно моделей двигателя автосамосвала
function esaShowAutoModelEnginesDlg(): Boolean;
begin
  fmAutoModelEngines := TfmAutoModelEngines.Create(nil);
  try
    Result := fmAutoModelEngines.ShowModal=mrOk;
  finally
    fmAutoModelEngines.Free;
  end;{try}
end;{esaShowAutoModelEnginesDlg}

procedure TfmAutoModelEngines.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  dbgAutoEngines.Options:=[dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines,dgTabs];

  SetLength(FColWidths,dbgAutoEngines.Columns.Count);
  FName := '';
  with fmDM do
  begin
    quAutoEngines.BeforeDelete := DoBeforeDelete;
    quAutoEngines.BeforeInsert := DoBeforeInsert;
    quAutoEngines.BeforePost := DoBeforePost;
    quAutoEngines.AfterDelete := DoAfterDelete;
    quAutoEngines.AfterInsert := DoAfterInsert;
    quAutoEngines.AfterPost := DoAfterPost;
    quAutoEngines.Open;
  end;{with}
end;{FormCreate}
procedure TfmAutoModelEngines.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quAutoEngines.Close;
    quAutoEngines.BeforeDelete := nil;
    quAutoEngines.BeforeInsert := nil;
    quAutoEngines.BeforePost := nil;
    quAutoEngines.AfterDelete := nil;
    quAutoEngines.AfterInsert := nil;
    quAutoEngines.AfterPost := nil;
  end;{with}
  FColWidths := nil;
end;{FormClose}
procedure TfmAutoModelEngines.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quAutoEngines,Caption);
end;{FormCloseQuery}
procedure TfmAutoModelEngines.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgAutoEngines,1);
  UpdateColumnRights(dbgAutoEngines, FColWidths);
end;{FormResize}
procedure TfmAutoModelEngines.PaintBoxPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := PaintBox.Canvas;
  DrawGridTitle(PaintBox,dbgAutoEngines,4,FColWidths);
  with dbgAutoEngines do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],3*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[1]-Width,1,FColWidths[1],3*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[2]-Width,1,FColWidths[2],3*hCell,
                   ['Максимальная','мощность','двигателя, кВт']);
  end;{with}
end;{PaintBoxPaint}
procedure TfmAutoModelEngines.DoBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('Name').AsString]))
  then Abort;
end;{DoBeforeDelete}
procedure TfmAutoModelEngines.DoBeforeInsert(DataSet: TDataSet);
begin
  FName := '';
  FSortIndex   := Dataset.RecordCount+1;
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
procedure TfmAutoModelEngines.DoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if not IsFloatFieldMoreMin(DataSet.FieldByName('Nmax'),1.0)then Abort
    else
      if (Dataset.State=dsInsert)and(FName<>'')
      then DataSet.FieldByName('Name').AsString := FName;
  end;{if}
end;{DoBeforePost}
procedure TfmAutoModelEngines.DoAfterDelete(DataSet: TDataSet);
var Id_AutoEngine, ASortIndex: Integer;
begin
  Id_AutoEngine := Dataset.FieldByName('Id_Engine').AsInteger;
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
  Dataset.Locate('Id_Engine',Id_AutoEngine,[]);
  Dataset.EnableControls;
  FormResize(Self);
  PaintBox.Invalidate;
end;{DoAfterDelete}
procedure TfmAutoModelEngines.DoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FName<>'') then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldbyName('Name').AsString := FName;
    Dataset.FieldbyName('Nmax').AsFloat := DefaultParams.AutoEngineNmax;
  end;{if}
end;{DoAfterInsert}
procedure TfmAutoModelEngines.DoAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  PaintBox.Invalidate;
end;{DoAfterPost}
procedure TfmAutoModelEngines.dbgAutoEnginesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  DrawDBGridColumnCell(dbgAutoEngines,Rect,DataCol,Column,State);
end;{dbgAutoEnginesDrawDBGridColumnCell}
procedure TfmAutoModelEngines.pmAutoEnginesPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiEdit.Enabled := (quAutoEngines.RecordCount>0)and
                       (not (quAutoEngines.State in [dsEdit,dsInsert]));
    pmiUp.Enabled := pmiEdit.Enabled and(quAutoEngines.RecNo>1);
    pmiDown.Enabled := pmiEdit.Enabled and(quAutoEngines.RecNo<quAutoEngines.RecordCount);
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiDefault.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiEdit.Enabled;
  end;{with}
end;{pmAutoEnginesPopup}
procedure TfmAutoModelEngines.pmiAddClick(Sender: TObject);
begin
  fmDm.quAutoEngines.Append;
end;{pmiAddClick}
procedure TfmAutoModelEngines.pmiEditClick(Sender: TObject);
begin
  with fmDM do
  begin
    FName := quAutoEnginesName.AsString;
    if InputName('Изменить','Наименование',FName,quAutoEnginesName.Size)then
    begin
      if quAutoEngines.Locate('Name',FName,[])
      then esaMsgError(Format(EDuplicateObj,['Данная модель двигателя',FName]))
      else
      begin
        quAutoEngines.Edit;
        quAutoEnginesName.AsString := FName;
      end;{else}
    end;{if}
    FName := '';
  end;{with}
end;{pmiEditClick}
procedure TfmAutoModelEngines.pmiDeleteClick(Sender: TObject);
begin
  fmDm.quAutoEngines.Delete;
end;{pmiDeleteClick}
procedure TfmAutoModelEngines.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quAutoEngines.AfterDelete := nil;
    quAutoEngines.BeforeDelete := nil;
    quAutoEngines.DisableControls;
    quAutoEngines.Requery;
    while not quAutoEngines.Eof do
      quAutoEngines.Delete;
    quAutoEngines.Requery;
    quAutoEngines.EnableControls;
    FormResize(Self);
    PaintBox.Invalidate;
    quAutoEngines.BeforeDelete := DoBeforeDelete;
    quAutoEngines.AfterDelete := DoAfterDelete;
  end;{with}
end;{pmiDeleteAllClick}
procedure TfmAutoModelEngines.pmiUpClick(Sender: TObject);
var Id_AutoEngine: Integer;
begin
  with fmDM do
  if (not(quAutoEngines.State in [dsEdit,dsInsert]))and(quAutoEngines.RecNo>1) then
  begin
    quAutoEngines.DisableControls;
    FSortIndex  := quAutoEnginesSortIndex.AsInteger;
    Id_AutoEngine := quAutoEnginesId_Engine.AsInteger;
    quAutoEngines.Prior;
    quAutoEngines.Edit;
    quAutoEnginesSortIndex.AsInteger := FSortIndex;
    quAutoEngines.Post;
    quAutoEngines.Locate('Id_Engine',Id_AutoEngine,[]);
    quAutoEngines.Edit;
    quAutoEnginesSortIndex.AsInteger := FSortIndex-1;
    quAutoEngines.Post;
    quAutoEngines.Requery;
    quAutoEngines.Locate('Id_Engine',Id_AutoEngine,[]);
    quAutoEngines.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmAutoModelEngines.pmiDownClick(Sender: TObject);
var Id_AutoEngine: Integer;
begin
  with fmDM do
  if (not(quAutoEngines.State in [dsEdit,dsInsert]))and
     (quAutoEngines.RecNo<quAutoEngines.RecordCount) then
  begin
    quAutoEngines.DisableControls;
    FSortIndex  := quAutoEnginesSortIndex.AsInteger;
    Id_AutoEngine := quAutoEnginesId_Engine.AsInteger;
    quAutoEngines.Next;
    quAutoEngines.Edit;
    quAutoEnginesSortIndex.AsInteger := FSortIndex;
    quAutoEngines.Post;
    quAutoEngines.Locate('Id_Engine',Id_AutoEngine,[]);
    quAutoEngines.Edit;
    quAutoEnginesSortIndex.AsInteger := FSortIndex+1;
    quAutoEngines.Post;
    quAutoEngines.Requery;
    quAutoEngines.Locate('Id_Engine',Id_AutoEngine,[]);
    quAutoEngines.EnableControls;
  end;{if}
end;{pmiDownClick}
procedure TfmAutoModelEngines.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)
  then DefaultParams.AutoEngineNmax := fmDM.quAutoEnginesNmax.AsFloat;
end;{pmiDefaultClick}
procedure TfmAutoModelEngines.pmiChangeDefaultsClick(Sender: TObject);
begin
  esaShowAutoModelEngineDefaultsDlg(HelpKeyword);
end;{pmiChangeDefaultsClick}
procedure TfmAutoModelEngines.pmiExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
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
    with fmDM do
    begin
      ACount := Max(1,quAutoEngines.RecordCount);
      XL.Cells[2,1,3,ACount+2].Frame := [feTotal];
      quAutoEngines.First;
      while not quAutoEngines.Eof do
      begin
        XL.IntegerCells[quAutoEngines.RecNo+3,1] := quAutoEnginesSortIndex.AsInteger;
        XL.StringCells [quAutoEngines.RecNo+3,2] := quAutoEnginesName.AsString;
        XL.FloatCells  [quAutoEngines.RecNo+3,3] := quAutoEnginesNmax.AsFloat;
        quAutoEngines.Next;
      end;{while}
      quAutoEngines.First;
    end;{with}
    XL.Cells[4,3,1,ACount+2].NumberFormat := nfFloat00;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiExcelClick}

end.

