unit unUnLoadingPunkts;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs,
  types;

type
  TfmUnLoadingPunkts = class(TForm)
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
    btExcel: TButton;
    pmiDefault: TMenuItem;
    pmiSep2: TMenuItem;
    Panel: TPanel;
    pbUnLoadingPunktRocks: TPaintBox;
    dbgUnLoadingPunktRocks: TDBGrid;
    pmiDefaultsDlg: TMenuItem;
    pmPunkts: TPopupMenu;
    pmiPunktsExcel: TMenuItem;
    lbUnLoadingPunkts: TLabel;
    dbgUnLoadingPunkts: TDBGrid;
    pmiSep4: TMenuItem;
    pmiUp: TMenuItem;
    pmiDown: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmRocksPopup(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure pbUnLoadingPunktRocksPaint(Sender: TObject);
    procedure dbgUnLoadingPunktRocksDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgUnLoadingPunktsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pmiDefaultsDlgClick(Sender: TObject);
    procedure pmiUpClick(Sender: TObject);
    procedure pmiDownClick(Sender: TObject);
  private
    FSortIndex : Integer;         //Порядковый номер
    FId_Rock   : Integer;         //Уникальный код ГМ
    FColWidths1: TIntegerDynArray;//Ширина столбцов таблицы
    FColWidths2: TIntegerDynArray;//Ширина столбцов таблицы
    procedure DoLoadingPunktsAfterScroll(DataSet: TDataSet);
    procedure DoLoadingPunktRocksAfterDelete(DataSet: TDataSet);
    procedure DoLoadingPunktRocksAfterInsert(DataSet: TDataSet);
    procedure DoLoadingPunktRocksAfterPost(DataSet: TDataSet);
    procedure DoLoadingPunktRocksBeforeDelete(DataSet: TDataSet);
    procedure DoLoadingPunktRocksBeforeInsert(DataSet: TDataSet);
    procedure DoLoadingPunktRocksBeforePost(DataSet: TDataSet);
  public
  end;{TfmAutos}

var
  fmUnLoadingPunkts: TfmUnLoadingPunkts;

//Диалоговое окно пунктов разгрузки
function esaShowUnLoadingPunktsDlg(): Boolean;
implementation

uses unDM, Globals, ADODb, Math, ExcelEditors, esaDBDefaultParams, unUnLoadingPunktDefaults;

{$R *.dfm}
//Диалоговое окно пунктов разгрузки
function esaShowUnLoadingPunktsDlg(): Boolean;
begin
  fmUnLoadingPunkts := TfmUnLoadingPunkts.Create(nil);
  try
    Result := fmUnLoadingPunkts.ShowModal=mrOk;
  finally
    fmUnLoadingPunkts.Free;
  end;{try}
end;{esaShowUnLoadingPunktsDlg}
procedure TfmUnLoadingPunkts.FormCreate(Sender: TObject);
var Msg: String;
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  Msg := '';
  dbgUnLoadingPunkts.Options := [dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgRowSelect];
  dbgUnLoadingPunkts.Enabled := false;
  with fmDM do
  begin
    quPoints.Open;
    quRocks.Open;
    quUnLoadingPunkts.Open;
    quUnLoadingPunktRocks.Open;
    quRockProductivity.Open;
    dbgUnLoadingPunkts.Enabled := (quRocks.RecordCount>0)AND(quUnLoadingPunkts.RecordCount>0);
    if quRocks.RecordCount=0 then Msg := EEmptyRocks+CR;
    if quUnLoadingPunkts.RecordCount=0 then Msg := Msg+EEmptyUnLoadingPunkts;
    if Msg<>'' then esaMsgError(Msg);
  end;{with}
  //dbgLoadingPunktRocks-----------------------------------------------------------------------
  SetLength(FColWidths1,dbgUnLoadingPunkts.Columns.Count);
  SetLength(FColWidths2,dbgUnLoadingPunktRocks.Columns.Count);
  dbgUnLoadingPunktRocks.Options := [dgEditing,dgIndicator,dgColLines,dgRowLines,dgTabs];
  with fmDM do
  begin
    quUnLoadingPunkts.AfterScroll := DoLoadingPunktsAfterScroll;
    quUnLoadingPunktRocks.BeforeDelete := DoLoadingPunktRocksBeforeDelete;
    quUnLoadingPunktRocks.BeforeInsert := DoLoadingPunktRocksBeforeInsert;
    quUnLoadingPunktRocks.BeforePost := DoLoadingPunktRocksBeforePost;
    quUnLoadingPunktRocks.AfterDelete := DoLoadingPunktRocksAfterDelete;
    quUnLoadingPunktRocks.AfterInsert := DoLoadingPunktRocksAfterInsert;
    quUnLoadingPunktRocks.AfterPost := DoLoadingPunktRocksAfterPost;
  end;{with}
  FormResize(Self);
end;{FormCreate}
procedure TfmUnLoadingPunkts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quUnLoadingPunktRocks.Close;
    quUnLoadingPunkts.Close;
    quRocks.Close;
    quRockProductivity.Close;
    quPoints.Close;
    quUnLoadingPunkts.AfterScroll := nil;
    quUnLoadingPunktRocks.AfterScroll := nil;
    quUnLoadingPunktRocks.BeforeDelete := nil;
    quUnLoadingPunktRocks.BeforeInsert := nil;
    quUnLoadingPunktRocks.BeforePost := nil;
    quUnLoadingPunktRocks.AfterDelete := nil;
    quUnLoadingPunktRocks.AfterInsert := nil;
    quUnLoadingPunktRocks.AfterPost := nil;
  end;{with}
  FColWidths1 := nil;
  FColWidths2 := nil;
end;{FormClose}
procedure TfmUnLoadingPunkts.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quUnLoadingPunktRocks,'Рзагружаемые горные породы');
end;{FormCloseQuery}
procedure TfmUnLoadingPunkts.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgUnLoadingPunkts,1);
  UpdateColumnRights(dbgUnLoadingPunkts,FColWidths1);
  FitColumnByIndex(dbgUnLoadingPunktRocks,1);
  UpdateColumnRights(dbgUnLoadingPunktRocks,FColWidths2);
end;{FormResize}
procedure TfmUnLoadingPunkts.pmiAddClick(Sender: TObject);
begin
  fmDM.quUnLoadingPunktRocks.Append;
end;{pmiRockAddClick}
procedure TfmUnLoadingPunkts.pmiEditClick(Sender: TObject);
var AName: String;
    AId_Rock: Integer;
begin
  with fmDM do
  if dbgUnLoadingPunktRocks.Enabled then
  begin
    AName := quUnLoadingPunktRocksRock.AsString;
    FId_Rock := quUnLoadingPunktRocksId_Rock.AsInteger;
    AId_Rock := quUnLoadingPunktRocksId_Rock.AsInteger;
    if InputNameEx('Изменить','Наименование','Name',quRocks,AName)then
    begin
      if quRocks.Locate('Name',AName,[])then
      begin
        FId_Rock := quRocksId_Rock.AsInteger;
        if quUnLoadingPunktRocks.Locate('Id_Rock',FId_Rock,[])
        then esaMsgError(Format(EDuplicateObj,['Данный тип горной породы',AName]))
        else
        begin
          quUnLoadingPunktRocks.Locate('Id_Rock',AId_Rock,[]);
          quUnLoadingPunktRocks.Edit;
          quUnLoadingPunktRocksId_Rock.AsInteger := FId_Rock;
        end;{else}
      end;{if}
    end;{if}
  end;{with}
  FId_Rock := 0;
end;{pmiRockEditClick}
procedure TfmUnLoadingPunkts.pmiDeleteClick(Sender: TObject);
begin
  fmDM.quUnLoadingPunktRocks.Delete;
end;{pmiRockDeleteClick}
procedure TfmUnLoadingPunkts.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quUnLoadingPunktRocks.AfterDelete := nil;
    quUnLoadingPunktRocks.BeforeDelete := nil;
    quUnLoadingPunktRocks.DisableControls;
    quUnLoadingPunktRocks.Requery;
    while not quUnLoadingPunktRocks.Eof do
      quUnLoadingPunktRocks.Delete;
    quUnLoadingPunktRocks.Requery;
    quUnLoadingPunktRocks.EnableControls;
    FormResize(Self);
    pbUnLoadingPunktRocks.Invalidate;
    quUnLoadingPunktRocks.AfterDelete := DoLoadingPunktRocksAfterDelete;
    quUnLoadingPunktRocks.BeforeDelete := DoLoadingPunktRocksBeforeDelete;
  end;{with}
end;{pmiRockDeleteAllClick}
procedure TfmUnLoadingPunkts.pmiExcelClick(Sender: TObject);
  function GetFormula(const ARow: Integer; ARows: String): String;
  var AInd: Integer;
  begin
    Result := '';
    while ARows<>'' do
    begin
      AInd := Pos(';',ARows);
      Result := Result+Format('R[-%d]C+',[ARow-StrToInt(Copy(ARows,1,AInd-1))]);
      Delete(ARows,1,AInd);
    end;{while}
    if Result<>'' then Result := '='+Copy(Result,1,Length(Result)-1);
  end;{GetFormula}
var
  XL: TExcelEditor;
  Row,I: Integer;
  sOre,sStripping,sRock: String;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1;
    //Заголовок
    XL.TitleCell[1,1,5,1] := Caption;
    //Шапка
    XL.TitleCell[2,1,1,2] := '№';
    XL.TitleCell[2,2,1,2] := 'Горная масса';
    XL.TitleCell[2,3,1,2] := 'Требуемое содержание, %';
    XL.TitleCell[2,4,2,1] := 'На начало периода';
    XL.TitleCell[3,4,1,1] := 'Содержание, %';
    XL.TitleCell[3,5,1,1] := 'Объем, тыс.м3';
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 3.0;
    XL.ColumnWidths[2,1] := 20.0;
    XL.ColumnWidths[3,3] := 11.0;
    for I := 1 to 5 do
      XL.TitleCell[4,I,1,1] := IntToStr(I);
    //Данные
    Row := 4;
    with fmDM do
    begin
      sOre := ''; sStripping := ''; sRock := '';
      quUnLoadingPunkts.First;
      while not quUnLoadingPunkts.Eof do
      begin
        Inc(Row);
        XL.TitleCell[Row,1,5,1] := quUnLoadingPunktsSortIndex.AsString+'. '+
                                   quUnLoadingPunktsTotalName.AsString;
        XL.Cells[Row,1,5,1].HorizontalAlignment := haLeft;
        XL.Cells[Row,1,5,1].Font.Style := [xlfsBold];
        quUnLoadingPunktRocks.Last;
        quUnLoadingPunktRocks.First;
        if quUnLoadingPunktRocks.RecordCount=0 then Inc(Row);
        while not quUnLoadingPunktRocks.Eof do
        begin
          Inc(Row);
          XL.IntegerCells[Row, 1] := quUnLoadingPunktRocks.RecNo;
          XL.StringCells [Row, 2] := quUnLoadingPunktRocksRock.AsString;
          XL.FloatCells  [Row, 3] := quUnLoadingPunktRocksRequiredContent.AsFloat;
          XL.FloatCells  [Row, 4] := quUnLoadingPunktRocksInitialContent.AsFloat;
          XL.FloatCells  [Row, 5] := quUnLoadingPunktRocksInitialV1000m3.AsFloat;
          if quUnLoadingPunktRocksIsMineralWealth.AsBoolean
          then sOre := sOre+IntToStr(Row)+';'
          else sStripping := sStripping+IntToStr(Row)+';';
          sRock := sRock+IntToStr(Row)+';';
          quUnLoadingPunktRocks.Next;
        end;{while}
        quUnLoadingPunkts.Next;
      end;{while}
      quUnLoadingPunkts.First;
    end;{with}
    if Row=4 then Inc(Row);
    //Рамка и формат диапазона данных
    XL.Cells[2,1,5,Row-1].Frame := [feTotal];
    XL.Cells[5,3,3,Row-1].NumberFormat := nfFloat00;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiRockExcelClick}
procedure TfmUnLoadingPunkts.pmRocksPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiAdd.Enabled := dbgUnLoadingPunkts.Enabled;
    pmiEdit.Enabled := pmiAdd.Enabled and(quUnLoadingPunktRocks.RecordCount>0)and
                       (not(quUnLoadingPunktRocks.State in [dsEdit,dsInsert]));
    pmiUp.Enabled := pmiEdit.Enabled and(quUnLoadingPunktRocks.RecNo>1);
    pmiDown.Enabled := pmiEdit.Enabled and(quUnLoadingPunktRocks.RecNo<quUnLoadingPunktRocks.RecordCount);
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiDefault.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiEdit.Enabled;
  end;{with}
end;{pmRocksPopup}

procedure TfmUnLoadingPunkts.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.UnLoadingPunktRockRequiredContent :=
      fmDM.quUnLoadingPunktRocksRequiredContent.AsFloat;
    DefaultParams.UnLoadingPunktRockInitialContent :=
      fmDM.quUnLoadingPunktRocksInitialContent.AsFloat;
    DefaultParams.UnLoadingPunktRockInitialV1000m3 :=
      fmDM.quUnLoadingPunktRocksInitialV1000m3.AsFloat;
  end;{if}
end;{pmiDefaultClick}

procedure TfmUnLoadingPunkts.pmiDefaultsDlgClick(Sender: TObject);
begin
  esaShowUnLoadingPunktDefaultsDlg(HelpKeyword);
end;{pmiDefaultsDlgClick}

procedure TfmUnLoadingPunkts.DoLoadingPunktRocksBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('Rock').AsString]))
  then Abort;
end;{DoLoadingPunktRocksBeforeDelete}
procedure TfmUnLoadingPunkts.DoLoadingPunktRocksBeforeInsert(DataSet: TDataSet);
var AName: String;
begin
  FSortIndex := Dataset.RecordCount+1;
  AName := '';
  FId_Rock := 0;
  with fmDM do
  if dbgUnLoadingPunktRocks.Enabled and
     InputNameEx('Добавить','Наименование','Name',quRocks,AName)then
  begin
    if quRocks.Locate('Name',AName,[]) then
    begin
      FId_Rock := quRocksId_Rock.AsInteger;
      if DataSet.Locate('Id_Rock',FId_Rock,[])then
      begin
        esaMsgError(Format(EDuplicateObj,['Данный тип горной породы',AName]));
        FId_Rock := 0;
        Abort;
      end;{if}
    end{if}
    else Abort;
  end{if}
  else Abort;
end;{DoLoadingPunktRocksBeforeInsert}
procedure TfmUnLoadingPunkts.DoLoadingPunktRocksBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if (not IsFloatFieldInRange1(DataSet.FieldByName('InitialContent'),0.0,100.0))and
       Dataset.FieldByName('IsMineralWealth').AsBoolean then Abort
    else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('InitialV1000m3'),0.0)then Abort
    else
    if Dataset.FieldByName('IsMineralWealth').AsBoolean and
       (not IsFloatFieldInRange1(DataSet.FieldByName('RequiredContent'),1.0,100.0))then Abort
    else
    if Dataset.State in [dsInsert,dsEdit] then
    if Dataset.FieldByName('Id_Rock').AsInteger>0 then
    begin
      if not Dataset.FieldByName('IsMineralWealth').AsBoolean
      then DataSet.FieldByName('RequiredContent').AsFloat := 0.0;
    end{if}
    else
    begin
      esaMsgError('Не выбрана горная порода.');
      Abort;
    end;{else}
  end;{if}
end;{DoLoadingPunktRocksBeforePost}
procedure TfmUnLoadingPunkts.DoLoadingPunktsAfterScroll(DataSet: TDataSet);
begin
  FormResize(Self);
  pbUnLoadingPunktRocks.Invalidate;
end;{DoLoadingPunktsAfterScroll}
procedure TfmUnLoadingPunkts.DoLoadingPunktRocksAfterDelete(DataSet: TDataSet);
var Id_UnLoadingPunktRock, ASortIndex: Integer;
begin
  Id_UnLoadingPunktRock := Dataset.FieldByName('Id_UnLoadingPunktRock').AsInteger;
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
  Dataset.Locate('Id_UnLoadingPunktRock',Id_UnLoadingPunktRock,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbUnLoadingPunktRocks.Invalidate;
end;{DoLoadingPunktRocksAfterDelete}
procedure TfmUnLoadingPunkts.DoLoadingPunktRocksAfterInsert(DataSet: TDataSet);
begin
  if Dataset.State in [dsInsert] then
  if FId_Rock>0 then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldByName('Id_Rock').AsInteger := FId_Rock;
    Dataset.FieldByName('InitialContent').AsFloat := DefaultParams.UnLoadingPunktRockInitialContent;
    Dataset.FieldByName('InitialV1000m3').AsFloat := DefaultParams.UnLoadingPunktRockInitialV1000m3;
    Dataset.FieldByName('RequiredContent').AsFloat := DefaultParams.UnLoadingPunktRockRequiredContent;
  end;{if}
end;{DoLoadingPunktRocksAfterInsert}
procedure TfmUnLoadingPunkts.DoLoadingPunktRocksAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbUnLoadingPunktRocks.Invalidate;
end;{DoLoadingPunktRocksAfterPost}
procedure TfmUnLoadingPunkts.pbUnLoadingPunktRocksPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbUnLoadingPunktRocks.Canvas;
  DrawGridTitle(pbUnLoadingPunktRocks,dbgUnLoadingPunktRocks,3,FColWidths2);
  with dbgUnLoadingPunktRocks do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths2[0]-Width,1,FColWidths2[0],2*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths2[0]+1,1,FColWidths2[1],2*hCell,['Горная масса']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths2[1]+1,1,FColWidths2[2],2*hCell,['Требуемое','содержание, %']);
    with Columns[4] do
      DrawGridCell(Cvs,FColWidths2[2]+1,1,FColWidths2[4],hCell,['На начало периода']);
    with Columns[3] do
      DrawGridCell(Cvs,FColWidths2[2]+1,1+hCell,FColWidths2[3],2*hCell,['Содержание, %']);
    with Columns[4] do
      DrawGridCell(Cvs,FColWidths2[3]+1,1+hCell,FColWidths2[4],2*hCell,['Объем, тыс.м3']);
  end;{with}
end;{pbUnLoadingPunktRocksPaint}

procedure TfmUnLoadingPunkts.dbgUnLoadingPunktRocksDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Column.ReadOnly and (not(gdFocused in State))
  then dbgUnLoadingPunktRocks.Canvas.Brush.Color :=  clLtGrayEx;
  dbgUnLoadingPunktRocks.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;{dbgUnLoadingPunktRocksDrawColumnCell}

procedure TfmUnLoadingPunkts.dbgUnLoadingPunktsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgUnLoadingPunkts do
  begin
    if gdSelected in State then
    begin
      Canvas.Brush.Color :=  clActiveCaption;
      Canvas.Font.Color  :=  clWindow;
    end;{if}
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;{with}
end;{dbgUnLoadingPunktsDrawColumnCell}

procedure TfmUnLoadingPunkts.pmiUpClick(Sender: TObject);
var Id_UnLoadingPunktRock: Integer;
begin
  with fmDM do
  if (not(quUnLoadingPunktRocks.State in [dsEdit,dsInsert]))and(quUnLoadingPunktRocks.RecNo>1) then
  begin
    quUnLoadingPunktRocks.DisableControls;
    FSortIndex  := quUnLoadingPunktRocksSortIndex.AsInteger;
    Id_UnLoadingPunktRock := quUnLoadingPunktRocksId_UnLoadingPunktRock.AsInteger;
    quUnLoadingPunktRocks.Prior;
    quUnLoadingPunktRocks.Edit;
    quUnLoadingPunktRocksSortIndex.AsInteger := FSortIndex;
    quUnLoadingPunktRocks.Post;
    quUnLoadingPunktRocks.Locate('Id_UnLoadingPunktRock',Id_UnLoadingPunktRock,[]);
    quUnLoadingPunktRocks.Edit;
    quUnLoadingPunktRocksSortIndex.AsInteger := FSortIndex-1;
    quUnLoadingPunktRocks.Post;
    quUnLoadingPunktRocks.Requery;
    quUnLoadingPunktRocks.Locate('Id_UnLoadingPunktRock',Id_UnLoadingPunktRock,[]);
    quUnLoadingPunktRocks.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmUnLoadingPunkts.pmiDownClick(Sender: TObject);
var Id_UnLoadingPunktRock: Integer;
begin
  with fmDM do
  if (not(quUnLoadingPunktRocks.State in [dsEdit,dsInsert]))and
     (quUnLoadingPunktRocks.RecNo<quUnLoadingPunktRocks.RecordCount) then
  begin
    quUnLoadingPunktRocks.DisableControls;
    FSortIndex  := quUnLoadingPunktRocksSortIndex.AsInteger;
    Id_UnLoadingPunktRock := quUnLoadingPunktRocksId_UnLoadingPunktRock.AsInteger;
    quUnLoadingPunktRocks.Next;
    quUnLoadingPunktRocks.Edit;
    quUnLoadingPunktRocksSortIndex.AsInteger := FSortIndex;
    quUnLoadingPunktRocks.Post;
    quUnLoadingPunktRocks.Locate('Id_UnLoadingPunktRock',Id_UnLoadingPunktRock,[]);
    quUnLoadingPunktRocks.Edit;
    quUnLoadingPunktRocksSortIndex.AsInteger := FSortIndex+1;
    quUnLoadingPunktRocks.Post;
    quUnLoadingPunktRocks.Requery;
    quUnLoadingPunktRocks.Locate('Id_UnLoadingPunktRock',Id_UnLoadingPunktRock,[]);
    quUnLoadingPunktRocks.EnableControls;
  end;{if}
end;{pmiDownClick}

end.
