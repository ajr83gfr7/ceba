unit unRoadCoats;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs,
  types;

type
  TfmRoadCoats = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    pmRoadCoats: TPopupMenu;
    pmiRoadCoatAdd: TMenuItem;
    pmiRoadCoatEdit: TMenuItem;
    pmiRoadCoatDelete: TMenuItem;
    pmiRoadCoatDeleteAll: TMenuItem;
    pmiRoadCoatSep1: TMenuItem;
    pmiRoadCoatExcel: TMenuItem;
    pnTop: TPanel;
    dbgRoadCoats: TDBGrid;
    pbRoadCoats: TPaintBox;
    pnClient: TPanel;
    Splitter: TSplitter;
    pbUSKs: TPaintBox;
    dbgUSKs: TDBGrid;
    pmUSKs: TPopupMenu;
    pmiUSKAdd: TMenuItem;
    pmiUSKEdit: TMenuItem;
    pmiUSKDelete: TMenuItem;
    pmiUSKDeleteAll: TMenuItem;
    pmiUSKSep1: TMenuItem;
    pmiUSKExcel: TMenuItem;
    btExcel: TButton;
    pmiRoadCoatSep2: TMenuItem;
    pmiRoadCoatUp: TMenuItem;
    pmiRoadCoatDown: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbRoadCoatsPaint(Sender: TObject);
    procedure pmiRoadCoatAddClick(Sender: TObject);
    procedure pmiRoadCoatEditClick(Sender: TObject);
    procedure pmiRoadCoatDeleteClick(Sender: TObject);
    procedure pmiRoadCoatDeleteAllClick(Sender: TObject);
    procedure pmiRoadCoatExcelClick(Sender: TObject);
    procedure pmRoadCoatsPopup(Sender: TObject);
    procedure pbUSKsPaint(Sender: TObject);
    procedure pmUSKsPopup(Sender: TObject);
    procedure pmiUSKAddClick(Sender: TObject);
    procedure pmiUSKEditClick(Sender: TObject);
    procedure pmiUSKDeleteClick(Sender: TObject);
    procedure pmiUSKDeleteAllClick(Sender: TObject);
    procedure dbgUSKsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pmiRoadCoatUpClick(Sender: TObject);
    procedure pmiRoadCoatDownClick(Sender: TObject);
  private
    FRoadCoatNo       : Integer;         //Порядковый номер RoadCoat
    FRoadCoatName     : String;          //Уникальное название RoadCoat
    FRoadCoatColWidths: TIntegerDynArray;//Ширина столбцов таблицы RoadCoat
    FUSKColWidths     : TIntegerDynArray;
    procedure DoRoadCoatAfterScroll(DataSet: TDataSet);
    procedure DoRoadCoatAfterDelete(DataSet: TDataSet);
    procedure DoRoadCoatAfterInsert(DataSet: TDataSet);
    procedure DoRoadCoatAfterPost(DataSet: TDataSet);
    procedure DoRoadCoatBeforeDelete(DataSet: TDataSet);
    procedure DoRoadCoatBeforeInsert(DataSet: TDataSet);
    procedure DoRoadCoatBeforePost(DataSet: TDataSet);

    procedure DoUSKAfterDelete(DataSet: TDataSet);
    procedure DoUSKAfterPost(DataSet: TDataSet);
    procedure DoUSKBeforeDelete(DataSet: TDataSet);
    procedure DoUSKBeforePost(DataSet: TDataSet);

  public
  end;{TfmAutos}

var
  fmRoadCoats: TfmRoadCoats;

//Диалоговое окно дорожных покрытий
function esaShowRoadCoatsDlg(): Boolean;
implementation

uses unDM, Globals, ADODb, Math, ExcelEditors;

{$R *.dfm}

//Диалоговое окно дорожных покрытий
function esaShowRoadCoatsDlg(): Boolean;
begin
  fmRoadCoats := TfmRoadCoats.Create(nil);
  try
    Result := fmRoadCoats.ShowModal=mrOk;
  finally
    fmRoadCoats.Free;
  end;{try}
end;{esaShowRoadCoatsDlg}

procedure TfmRoadCoats.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  SetLength(FRoadCoatColWidths,dbgRoadCoats.Columns.Count);
  SetLength(FUSKColWidths,dbgUSKs.Columns.Count);
  dbgRoadCoats.Options := [dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines];
  dbgUSKs.Options := [dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines,dgTabs];
  FRoadCoatName := '';
  with fmDM do
  begin
    quRoadCoats.AfterScroll := DoRoadCoatAfterScroll;
    quRoadCoats.BeforeDelete := DoRoadCoatBeforeDelete;
    quRoadCoats.BeforeInsert := DoRoadCoatBeforeInsert;
    quRoadCoats.BeforePost := DoRoadCoatBeforePost;
    quRoadCoats.AfterDelete := DoRoadCoatAfterDelete;
    quRoadCoats.AfterInsert := DoRoadCoatAfterInsert;
    quRoadCoats.AfterPost := DoRoadCoatAfterPost;
    quRoadCoats.Open;
    quRoadCoatUSKs.BeforeDelete := DoUSKBeforeDelete;
    quRoadCoatUSKs.BeforePost := DoUSKBeforePost;
    quRoadCoatUSKs.AfterDelete := DoUSKAfterDelete;
    quRoadCoatUSKs.AfterPost := DoUSKAfterPost;
    quRoadCoatUSKs.Open;
  end;{with}
end;{FormCreate}
procedure TfmRoadCoats.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quRoadCoatUSKs.Close;
    quRoadCoatUSKs.BeforeDelete := nil;
    quRoadCoatUSKs.BeforePost := nil;
    quRoadCoatUSKs.AfterDelete := nil;
    quRoadCoatUSKs.AfterPost := nil;
    quRoadCoats.Close;
    quRoadCoats.AfterScroll := nil;
    quRoadCoats.BeforeDelete := nil;
    quRoadCoats.BeforeInsert := nil;
    quRoadCoats.BeforePost := nil;
    quRoadCoats.AfterDelete := nil;
    quRoadCoats.AfterInsert := nil;
    quRoadCoats.AfterPost := nil;
  end;{with}
  FRoadCoatColWidths := nil;
  FUSKColWidths := nil;
end;{FormClose}
procedure TfmRoadCoats.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quRoadCoats,'Типы дорожного покрытия')and
              CanCloseModifiedQuery(fmDM.quRoadCoatUSKs,'Коэффициенты удельного сопротивления качению');
end;{FormCloseQuery}
procedure TfmRoadCoats.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgRoadCoats,1);
  UpdateColumnRights(dbgRoadCoats,FRoadCoatColWidths);
  FitColumnByIndex(dbgUSKs,1);
  UpdateColumnRights(dbgUSKs,FUSKColWidths);
end;{FormResize}
procedure TfmRoadCoats.pbRoadCoatsPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbRoadCoats.Canvas;
  DrawGridTitle(pbRoadCoats,dbgRoadCoats,3,FRoadCoatColWidths);
  with dbgRoadCoats do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FRoadCoatColWidths[0]-Width,1,FRoadCoatColWidths[0],2*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FRoadCoatColWidths[0]+1,1,FRoadCoatColWidths[1],2*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FRoadCoatColWidths[1]+1,1,FRoadCoatColWidths[2],2*hCell,['Сокращенное','наименование']);
  end;{with}
end;{pbRoadCoatsPaint}

procedure TfmRoadCoats.DoRoadCoatBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('Name').AsString]))
  then Abort;
end;{DoRoadCoatBeforeDelete}
procedure TfmRoadCoats.DoRoadCoatBeforeInsert(DataSet: TDataSet);
begin
  FRoadCoatName := '';
  FRoadCoatNo := Dataset.RecordCount+1;
  if InputName('Добавить','Наименование',FRoadCoatName,Dataset.FieldByName('Name').Size)then
  begin
    if DataSet.Locate('Name',FRoadCoatName,[]) then
    begin
      esaMsgError(Format(EDuplicateObj,['Данный тип дорожного покрытия',FRoadCoatName]));
      FRoadCoatName := '';
      Abort;
    end;{if}
  end{if}
  else Abort;
end;{DoRoadCoatBeforeInsert}
procedure TfmRoadCoats.DoRoadCoatBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if (Dataset.State=dsInsert)and(FRoadCoatName<>'') then
    begin
      DataSet.FieldByName('Name').AsString := FRoadCoatName;
    end;{if}
    if Dataset.FieldByName('ShortName').AsString='' then
    begin
      esaMsgError('Не заполнено поле "Сокращенное наименование"');
      Abort;
    end;{if}
  end;{if}
end;{DoRoadCoatBeforePost}
procedure TfmRoadCoats.DoRoadCoatAfterScroll(DataSet: TDataSet);
begin
  FitColumnByIndex(dbgUSKs,1);
  UpdateColumnRights(dbgUSKs,FUSKColWidths);
  pbUSKs.Invalidate;
end;{DoRoadCoatAfterScroll}
procedure TfmRoadCoats.DoRoadCoatAfterDelete(DataSet: TDataSet);
var Id_RoadCoat, ASortIndex: Integer;
begin
  Id_RoadCoat := Dataset.FieldByName('Id_RoadCoat').AsInteger;
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
  Dataset.Locate('Id_RoadCoat',Id_RoadCoat,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbRoadCoats.Invalidate;
end;{DoRoadCoatAfterDelete}
procedure TfmRoadCoats.DoRoadCoatAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FRoadCoatName<>'') then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FRoadCoatNo;
    Dataset.FieldByName('Name').AsString := FRoadCoatName;
  end;{if}
end;{DoRoadCoatAfterInsert}
procedure TfmRoadCoats.DoRoadCoatAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbRoadCoats.Invalidate;
end;{DoRoadCoatAfterPost}
procedure TfmRoadCoats.pmiRoadCoatAddClick(Sender: TObject);
begin
  fmDM.quRoadCoats.Append;
end;{pmiRoadCoatAddClick}
procedure TfmRoadCoats.pmiRoadCoatEditClick(Sender: TObject);
begin
  with fmDM do
  begin
    FRoadCoatName := quRoadCoatsName.AsString;
    if InputName('Изменить','Наименование',FRoadCoatName,quRoadCoatsName.Size)then
    begin
      if quRoadCoats.Locate('Name',FRoadCoatName,[])
      then esaMsgError(Format(EDuplicateObj,['Данный тип дорожного покрытия',FRoadCoatName]))
      else
      begin
        quRoadCoats.Edit;
        quRoadCoatsName.AsString := FRoadCoatName;
      end;{else}
    end;{if}
    FRoadCoatName := '';
  end;{with}
end;{pmiRoadCoatEditClick}
procedure TfmRoadCoats.pmiRoadCoatDeleteClick(Sender: TObject);
begin
  fmDM.quRoadCoats.Delete;
end;{pmiRoadCoatDeleteClick}
procedure TfmRoadCoats.pmiRoadCoatDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quRoadCoats.AfterDelete := nil;
    quRoadCoats.BeforeDelete := nil;
    quRoadCoats.DisableControls;
    quRoadCoats.Requery;
    while not quRoadCoats.Eof do
      quRoadCoats.Delete;
    quRoadCoats.Requery;
    quRoadCoats.EnableControls;
    FormResize(Self);
    pbRoadCoats.Invalidate;
    quRoadCoats.AfterDelete := DoRoadCoatAfterDelete;
    quRoadCoats.BeforeDelete := DoRoadCoatBeforeDelete;
  end;{with}
end;{pmiRoadCoatDeleteAllClick}
procedure TfmRoadCoats.pmiRoadCoatExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  Row,I: Integer;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1;
    //Заголовок
    XL.TitleCell[1,1,4,1] := Caption;
    //Шапка
    XL.TitleCell[2,1,1,2] := '№';
    XL.TitleCell[2,2,1,2] := 'Грузоподъемность автосамосвалов, т';
    XL.TitleCell[2,3,2,1] := 'Диапазон значений коэффициентов удельного сопротивления качению, кH/H';
    XL.TitleCell[3,3,1,1] := 'Минимальное значение';
    XL.TitleCell[3,4,1,1] := 'Максимальное значение';
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 3.0;
    XL.ColumnWidths[2,3] := 20.0;
    for I := 1 to 4 do
      XL.TitleCell[4,I,1,1] := IntToStr(I);
    XL.RowHeights[2,1] := 22.0;
    XL.RowHeights[3,1] := 11.25;
    Row := 4;
    with fmDM do
    begin
      quRoadCoats.First;
      while not quRoadCoats.Eof do
      begin
        Inc(Row);
        XL.TitleCell[Row,1,4,1] := quRoadCoatsSortIndex.AsString+'. '+quRoadCoatsName.AsString;
        XL.Cells[Row,1,4,1].HorizontalAlignment := haLeft;
        XL.Cells[Row,1,4,1].Font.Style := [xlfsBold];
        quRoadCoatUSKs.Last;
        quRoadCoatUSKs.First;
        if quRoadCoatUSKs.RecordCount=0 then Inc(Row);
        while not quRoadCoatUSKs.Eof do
        begin
          Inc(Row);
          XL.IntegerCells[Row, 1] := quRoadCoatUSKs.RecNo;
          XL.FloatCells  [Row, 2] := quRoadCoatUSKsP.AsFloat;
          XL.FloatCells  [Row, 3] := quRoadCoatUSKsValueMin.AsFloat;
          XL.FloatCells  [Row, 4] := quRoadCoatUSKsValueMax.AsFloat;
          quRoadCoatUSKs.Next;
        end;{while}
        quRoadCoats.Next;
      end;{while}
      quRoadCoats.First;
    end;{with}
    if Row=3 then Inc(Row);
    XL.Cells[2,1,4,Row-1].Frame := [feTotal];
    XL.Cells[5,2,3,Row-1].NumberFormat := nfFloat00;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiRoadCoatExcelClick}
procedure TfmRoadCoats.pmRoadCoatsPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiRoadCoatAdd.Enabled := not (quRoadCoatUSKs.State in [dsEdit,dsInsert]);
    pmiRoadCoatEdit.Enabled := pmiRoadCoatAdd.Enabled and(quRoadCoats.RecordCount>0)and
                              (not (quRoadCoats.State in [dsEdit,dsInsert]));
    pmiRoadCoatUp.Enabled := pmiRoadCoatEdit.Enabled and(quRoadCoats.RecNo>1);
    pmiRoadCoatDown.Enabled := pmiRoadCoatEdit.Enabled and(quRoadCoats.RecNo<quRoadCoats.RecordCount);
    pmiRoadCoatDelete.Enabled := pmiRoadCoatEdit.Enabled;
    pmiRoadCoatDeleteAll.Enabled := pmiRoadCoatEdit.Enabled;
    pmiRoadCoatExcel.Enabled := pmiRoadCoatAdd.Enabled;
  end;{with}
end;{pmRoadCoatsPopup}

procedure TfmRoadCoats.pbUSKsPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbUSKs.Canvas;
  DrawGridTitle(pbUSKs,dbgUSKs,4,FUSKColWidths);
  with dbgUSKs do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FUSKColWidths[0]-Width,1,FUSKColWidths[0],3*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FUSKColWidths[1]-Width,1,FUSKColWidths[1],3*hCell,
        ['Грузоподъемность ','автосамосвала, т.']);
    with Columns[2] do
      DrawGridCell(Cvs,FUSKColWidths[2]-Width,1,FUSKColWidths[3],2*hCell,
      ['Диапазон значений коэффицентов','удельного сопротивления качению, Н/кН']);
    with Columns[2] do
      DrawGridCell(Cvs,FUSKColWidths[2]-Width,2*hCell+1,FUSKColWidths[2],3*hCell,
      ['Минимальное значение']);
    with Columns[2] do
      DrawGridCell(Cvs,FUSKColWidths[3]-Width,2*hCell+1,FUSKColWidths[3],3*hCell,
      ['Максимальное значение']);
  end;{with}
end;{pbUSKsPaint}

procedure TfmRoadCoats.DoUSKBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN('Удалить запись №'+IntToStr(Dataset.RecNo)+'?')
  then Abort
  else Dataset.Tag := Dataset.RecNo;
end;{DoUSKBeforeDelete}
procedure TfmRoadCoats.DoUSKAfterDelete(DataSet: TDataSet);
var No: Integer;
begin
  Dataset.DisableControls;
  TADOQuery(Dataset).Requery;
  No := DataSet.Tag;
  if No>Dataset.RecordCount then No := Dataset.RecordCount;
  Dataset.MoveBy(No-1);
  DataSet.Tag := 0;
  Dataset.EnableControls;
  FormResize(Self);
  pbUSKs.Invalidate;
end;{DoUSKAfterDelete}
procedure TfmRoadCoats.DoUSKAfterPost(DataSet: TDataSet);
var Id_USK: Integer;
begin
  if Dataset.Tag>0 then Exit;
  Id_USK := DataSet.FieldByName('Id_USK').AsInteger;
  Dataset.DisableControls;
  TADOQuery(Dataset).Requery;
  Dataset.Locate('Id_USK',Id_USK,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbUSKs.Invalidate;
end;{DoUSKAfterPost}
procedure TfmRoadCoats.DoUSKBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('P'),0.0)then Abort
    else
    if not IsFloatFieldMoreMin(DataSet.FieldByName('ValueMin'),0.0)then Abort
    else
    if not IsFloatFieldMoreMin(DataSet.FieldByName('ValueMax'),0.0)then Abort
  end;{if}
end;{DoUSKBeforePost}

procedure TfmRoadCoats.pmUSKsPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiUSKAdd.Enabled       := not(quRoadCoats.State in [dsInsert,dsEdit]);
    pmiUSKEdit.Enabled      := pmiUSKAdd.Enabled and (quRoadCoatUSKs.RecordCount>0)and
                               (not (quRoadCoatUSKs.State in [dsEdit,dsInsert]));
    pmiUSKDelete.Enabled    := pmiUSKEdit.Enabled;
    pmiUSKDeleteAll.Enabled := pmiUSKEdit.Enabled;
    pmiUSKExcel.Enabled     := pmiUSKAdd.Enabled;
  end;{with}
end;{pmOUSDKsPopup}
procedure TfmRoadCoats.pmiUSKAddClick(Sender: TObject);
begin
  fmDM.quRoadCoatUSKs.Append;
end;{pmiOUSDKAddClick}
procedure TfmRoadCoats.pmiUSKEditClick(Sender: TObject);
begin
  fmDM.quRoadCoatUSKs.Edit;
end;{pmiOUSDKEditClick}
procedure TfmRoadCoats.pmiUSKDeleteClick(Sender: TObject);
begin
  fmDM.quRoadCoatUSKs.Delete;
end;{pmiOUSDKDeleteClick}
procedure TfmRoadCoats.pmiUSKDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quRoadCoatUSKs.AfterDelete := nil;
    quRoadCoatUSKs.BeforeDelete := nil;
    quRoadCoatUSKs.DisableControls;
    quRoadCoatUSKs.Requery;
    while not quRoadCoatUSKs.Eof do
      quRoadCoatUSKs.Delete;
    quRoadCoatUSKs.Requery;
    quRoadCoatUSKs.EnableControls;
    FormResize(Self);
    pbUSKs.Invalidate;
    quRoadCoatUSKs.AfterDelete := DoUSKAfterDelete;
    quRoadCoatUSKs.BeforeDelete := DoUSKBeforeDelete;
  end;{with}
end;{pmiOUSDKDeleteAllClick}

procedure TfmRoadCoats.dbgUSKsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Sender Is TDBGrid
  then DrawDBGridColumnCell(TDBGrid(Sender),Rect,DataCol,Column,State);
end;{dbgUSKsDrawColumnCell}

procedure TfmRoadCoats.pmiRoadCoatUpClick(Sender: TObject);
var Id_RoadCoat: Integer;
begin
  with fmDM do
  if (not(quRoadCoats.State in [dsEdit,dsInsert]))and(quRoadCoats.RecNo>1) then
  begin
    quRoadCoats.DisableControls;
    FRoadCoatNo  := quRoadCoatsSortIndex.AsInteger;
    Id_RoadCoat := quRoadCoatsId_RoadCoat.AsInteger;
    quRoadCoats.Prior;
    quRoadCoats.Edit;
    quRoadCoatsSortIndex.AsInteger := FRoadCoatNo;
    quRoadCoats.Post;
    quRoadCoats.Locate('Id_RoadCoat',Id_RoadCoat,[]);
    quRoadCoats.Edit;
    quRoadCoatsSortIndex.AsInteger := FRoadCoatNo-1;
    quRoadCoats.Post;
    quRoadCoats.Requery;
    quRoadCoats.Locate('Id_RoadCoat',Id_RoadCoat,[]);
    quRoadCoats.EnableControls;
  end;{if}
end;{pmiUpClick}

procedure TfmRoadCoats.pmiRoadCoatDownClick(Sender: TObject);
var Id_RoadCoat: Integer;
begin
  with fmDM do
  if (not(quRoadCoats.State in [dsEdit,dsInsert]))and
     (quRoadCoats.RecNo<quRoadCoats.RecordCount) then
  begin
    quRoadCoats.DisableControls;
    FRoadCoatNo  := quRoadCoatsSortIndex.AsInteger;
    Id_RoadCoat := quRoadCoatsId_RoadCoat.AsInteger;
    quRoadCoats.Next;
    quRoadCoats.Edit;
    quRoadCoatsSortIndex.AsInteger := FRoadCoatNo;
    quRoadCoats.Post;
    quRoadCoats.Locate('Id_RoadCoat',Id_RoadCoat,[]);
    quRoadCoats.Edit;
    quRoadCoatsSortIndex.AsInteger := FRoadCoatNo+1;
    quRoadCoats.Post;
    quRoadCoats.Requery;
    quRoadCoats.Locate('Id_RoadCoat',Id_RoadCoat,[]);
    quRoadCoats.EnableControls;
  end;{if}
end;{pmiRoadCoatDownClick}

end.
