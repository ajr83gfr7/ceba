unit unProductivity;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs,
  types;

type
  TfmProductivity = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    pmLoadingPunktsRocks: TPopupMenu;
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
    pnClient: TPanel;
    pbLoadingPunktRocks: TPaintBox;
    dbgLoadingPunktRocks: TDBGrid;
    pnProductivity: TPanel;
    lbProductivityMineralWealth: TLabel;
    sttProductivityMineralWealth: TStaticText;
    cbProductivityUnit: TComboBox;
    lbProductivityStripping: TLabel;
    sttProductivityStripping: TStaticText;
    sttProductivityRock: TStaticText;
    lbProductivityRock: TLabel;
    lbProductivityStrippingCoef: TLabel;
    edProductivityStrippingCoef: TEdit;
    cbProductivityStrippingCoefUnit: TComboBox;
    pmLoadingPunkts: TPopupMenu;
    pmiLoadingPunktsExcel: TMenuItem;
    dbgLoadingPunkts: TDBGrid;
    lbLoadingPunkts: TLabel;
    Bevel2: TBevel;
    pmiDefaultsDlg: TMenuItem;
    pmiUp: TMenuItem;
    pmiDown: TMenuItem;
    pmiSep4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pmiAddClick(Sender: TObject);
    procedure pmiEditClick(Sender: TObject);
    procedure pmiDeleteClick(Sender: TObject);
    procedure pmiDeleteAllClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmLoadingPunktsRocksPopup(Sender: TObject);
    procedure pmiDefaultClick(Sender: TObject);
    procedure pbLoadingPunktRocksPaint(Sender: TObject);
    procedure dbgLoadingPunktRocksDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgLoadingPunktsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cbProductivityUnitChange(Sender: TObject);
    procedure cbProductivityStrippingCoefUnitChange(Sender: TObject);
    procedure pmLoadingPunktsPopup(Sender: TObject);
    procedure pmiDefaultsDlgClick(Sender: TObject);
    procedure dbgLoadingPunktRocksKeyPress(Sender: TObject; var Key: Char);
    procedure pmiUpClick(Sender: TObject);
    procedure pmiDownClick(Sender: TObject);
  private
    FSortIndex: Integer;         //Порядковый номер 
    FId_Rock  : Integer;         //Уникальный код ГМ
    FColWidths: TIntegerDynArray;//Ширина столбцов таблицы
    FProductivityMineralWealthV1000m3: Single;//Производительность руды, тыс.м3
    FProductivityMineralWealthQ1000tn: Single;//Производительность руды, тыс.т
    FProductivityStrippingV1000m3    : Single;//Производительность вскрыши, тыс.м3
    FProductivityStrippingQ1000tn    : Single;//Производительность вскрыши, тыс.т
    FProductivityStrippingCoef       : Single;//Коэффициент вскрыши, т/т или м3/т
    procedure DoAfterScroll(DataSet: TDataSet);
    procedure DoLoadingPunktRocksAfterDelete(DataSet: TDataSet);
    procedure DoLoadingPunktRocksAfterInsert(DataSet: TDataSet);
    procedure DoLoadingPunktRocksAfterPost(DataSet: TDataSet);
    procedure DoLoadingPunktRocksBeforeDelete(DataSet: TDataSet);
    procedure DoLoadingPunktRocksBeforeInsert(DataSet: TDataSet);
    procedure DoLoadingPunktRocksBeforePost(DataSet: TDataSet);
    procedure UpdateProductivity;
  public
  end;{TfmAutos}

var
  fmProductivity: TfmProductivity;

//Диалоговое окно плановых производительности
function esaShowProductivityDlg(): Boolean;
implementation

uses unDM, Globals, ADODb, Math, ExcelEditors, unProductivityDefaults;

{$R *.dfm}
//Диалоговое окно плановых производительности
function esaShowProductivityDlg(): Boolean;
begin
  fmProductivity := TfmProductivity.Create(nil);
  try
    Result := fmProductivity.ShowModal=mrOk;
  finally
    fmProductivity.Free;
  end;{try}
end;{esaShowProductivityDlg}

procedure TfmProductivity.FormCreate(Sender: TObject);
var Msg: String;
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  Msg := '';
  dbgLoadingPunkts.Enabled := false;
  with fmDM do
  begin
    quPoints.Open;
    quRocks.Open;
    quLoadingPunkts.Open;
    quLoadingPunktRocks.Open;
    quRockProductivity.Open;
    dbgLoadingPunkts.Enabled := (quRocks.RecordCount>0)AND(quLoadingPunkts.RecordCount>0);
    if quRocks.RecordCount=0 then Msg := EEmptyRocks+CR;
    if quLoadingPunkts.RecordCount=0 then Msg := Msg+EEmptyLoadingPunkts;
    if Msg<>'' then esaMsgError(Msg);
  end;{with}
  //dbgLoadingPunktRocks-----------------------------------------------------------------------
  SetLength(FColWidths,dbgLoadingPunktRocks.Columns.Count);
  dbgLoadingPunktRocks.Options := [dgEditing,dgIndicator,dgColLines,dgRowLines,dgTabs];
  with fmDM do
  begin
    quLoadingPunkts.AfterScroll := DoAfterScroll;
    quLoadingPunktRocks.BeforeDelete := DoLoadingPunktRocksBeforeDelete;
    quLoadingPunktRocks.BeforeInsert := DoLoadingPunktRocksBeforeInsert;
    quLoadingPunktRocks.BeforePost := DoLoadingPunktRocksBeforePost;
    quLoadingPunktRocks.AfterDelete := DoLoadingPunktRocksAfterDelete;
    quLoadingPunktRocks.AfterInsert := DoLoadingPunktRocksAfterInsert;
    quLoadingPunktRocks.AfterPost := DoLoadingPunktRocksAfterPost;
  end;{with}
  FormResize(Self);
  UpdateProductivity;
end;{FormCreate}
procedure TfmProductivity.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quLoadingPunktRocks.Close;
    quLoadingPunkts.Close;
    quRocks.Close;
    quRockProductivity.Close;
    quPoints.Close;
    quLoadingPunkts.AfterScroll := nil;
    quLoadingPunktRocks.AfterScroll := nil;
    quLoadingPunktRocks.BeforeDelete := nil;
    quLoadingPunktRocks.BeforeInsert := nil;
    quLoadingPunktRocks.BeforePost := nil;
    quLoadingPunktRocks.AfterDelete := nil;
    quLoadingPunktRocks.AfterInsert := nil;
    quLoadingPunktRocks.AfterPost := nil;
  end;{with}
  FColWidths := nil;
end;{FormClose}
procedure TfmProductivity.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quLoadingPunktRocks,'Добываемая горная порода');
end;{FormCloseQuery}
procedure TfmProductivity.FormResize(Sender: TObject);
begin
  dbgLoadingPunkts.Columns[1].Width :=
    dbgLoadingPunkts.ClientWidth-dbgLoadingPunkts.Columns[2].Width-50;
  FitColumnByIndex(dbgLoadingPunktRocks,1);
  UpdateColumnRights(dbgLoadingPunktRocks,FColWidths);
end;{FormResize}
procedure TfmProductivity.pmiAddClick(Sender: TObject);
begin
  fmDM.quLoadingPunktRocks.Append;
end;{pmiRockAddClick}
procedure TfmProductivity.pmiEditClick(Sender: TObject);
var AName: String;
    AId_Rock: Integer;
begin
  with fmDM do
  if dbgLoadingPunktRocks.Enabled then
  begin
    AName := quLoadingPunktRocksRock.AsString;
    FId_Rock := quLoadingPunktRocksId_Rock.AsInteger;
    AId_Rock := quLoadingPunktRocksId_Rock.AsInteger;
    if InputNameEx('Изменить','Наименование','Name',quRocks,AName)then
    begin
      if quRocks.Locate('Name',AName,[])then
      begin
        FId_Rock := quRocksId_Rock.AsInteger;
        if quLoadingPunktRocks.Locate('Id_Rock',FId_Rock,[])
        then esaMsgError(Format(EDuplicateObj,['Данный тип горной породы',AName]))
        else
        begin
          quLoadingPunktRocks.Locate('Id_Rock',AId_Rock,[]);
          quLoadingPunktRocks.Edit;
          quLoadingPunktRocksId_Rock.AsInteger := FId_Rock;
        end;{else}
      end;{if}
    end;{if}
  end;{with}
  FId_Rock := 0;
end;{pmiRockEditClick}
procedure TfmProductivity.pmiDeleteClick(Sender: TObject);
begin
  fmDM.quLoadingPunktRocks.Delete;
end;{pmiRockDeleteClick}
procedure TfmProductivity.pmiDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDeleteAllConfirm)then
  with fmDM do
  begin
    quLoadingPunktRocks.AfterDelete := nil;
    quLoadingPunktRocks.BeforeDelete := nil;
    quLoadingPunktRocks.DisableControls;
    quLoadingPunktRocks.Requery;
    while not quLoadingPunktRocks.Eof do
      quLoadingPunktRocks.Delete;
    quLoadingPunktRocks.Requery;
    quLoadingPunktRocks.EnableControls;
    FormResize(Self);
    pbLoadingPunktRocks.Invalidate;
    quLoadingPunktRocks.AfterDelete := DoLoadingPunktRocksAfterDelete;
    quLoadingPunktRocks.BeforeDelete := DoLoadingPunktRocksBeforeDelete;
  end;{with}
end;{pmiRockDeleteAllClick}
procedure TfmProductivity.pmiUpClick(Sender: TObject);
var Id_LoadingPunktRock: Integer;
begin
  with fmDM do
  if (not(quLoadingPunktRocks.State in [dsEdit,dsInsert]))and(quLoadingPunktRocks.RecNo>1) then
  begin
    quLoadingPunktRocks.DisableControls;
    FSortIndex  := quLoadingPunktRocksSortIndex.AsInteger;
    Id_LoadingPunktRock := quLoadingPunktRocksId_LoadingPunktRock.AsInteger;
    quLoadingPunktRocks.Prior;
    quLoadingPunktRocks.Edit;
    quLoadingPunktRocksSortIndex.AsInteger := FSortIndex;
    quLoadingPunktRocks.Post;
    quLoadingPunktRocks.Locate('Id_LoadingPunktRock',Id_LoadingPunktRock,[]);
    quLoadingPunktRocks.Edit;
    quLoadingPunktRocksSortIndex.AsInteger := FSortIndex-1;
    quLoadingPunktRocks.Post;
    quLoadingPunktRocks.Requery;
    quLoadingPunktRocks.Locate('Id_LoadingPunktRock',Id_LoadingPunktRock,[]);
    quLoadingPunktRocks.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmProductivity.pmiDownClick(Sender: TObject);
var Id_LoadingPunktRock: Integer;
begin
  with fmDM do
  if (not(quLoadingPunktRocks.State in [dsEdit,dsInsert]))and
     (quLoadingPunktRocks.RecNo<quLoadingPunktRocks.RecordCount) then
  begin
    quLoadingPunktRocks.DisableControls;
    FSortIndex  := quLoadingPunktRocksSortIndex.AsInteger;
    Id_LoadingPunktRock := quLoadingPunktRocksId_LoadingPunktRock.AsInteger;
    quLoadingPunktRocks.Next;
    quLoadingPunktRocks.Edit;
    quLoadingPunktRocksSortIndex.AsInteger := FSortIndex;
    quLoadingPunktRocks.Post;
    quLoadingPunktRocks.Locate('Id_LoadingPunktRock',Id_LoadingPunktRock,[]);
    quLoadingPunktRocks.Edit;
    quLoadingPunktRocksSortIndex.AsInteger := FSortIndex+1;
    quLoadingPunktRocks.Post;
    quLoadingPunktRocks.Requery;
    quLoadingPunktRocks.Locate('Id_LoadingPunktRock',Id_LoadingPunktRock,[]);
    quLoadingPunktRocks.EnableControls;
  end;{if}
end;{pmiDownClick}
procedure TfmProductivity.pmiExcelClick(Sender: TObject);
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
    XL.TitleCell[1,1,7,1] := Caption;
    //Шапка
    XL.TitleCell[2,1,1,2] := '№';
    XL.TitleCell[2,2,1,2] := 'Горная масса';
    XL.TitleCell[2,3,1,2] := 'Плотность в целике, т/м3';
    XL.TitleCell[2,4,1,2] := 'Коэффициент разрыхления';
    XL.TitleCell[2,5,1,2] := 'Содержание, %';
    XL.TitleCell[2,6,2,1] := 'План на период';
    XL.TitleCell[3,6,1,1] := 'тыс.м3';
    XL.TitleCell[3,7,1,1] := 'тыс.т';
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 3.0;
    XL.ColumnWidths[2,1] := 20.0;
    XL.ColumnWidths[3,5] := 11.0;
    for I := 1 to 7 do
      XL.TitleCell[4,I,1,1] := IntToStr(I);
    //Данные
    Row := 4;
    with fmDM do
    begin
      sOre := ''; sStripping := ''; sRock := '';
      quLoadingPunkts.First;
      while not quLoadingPunkts.Eof do
      begin
        Inc(Row);
        XL.TitleCell[Row,1,7,1] := quLoadingPunktsSortIndex.AsString+'. '+
                                   quLoadingPunktsTotalName.AsString;
        XL.Cells[Row,1,7,1].HorizontalAlignment := haLeft;
        XL.Cells[Row,1,7,1].Font.Style := [xlfsBold];
        quLoadingPunktRocks.Last;
        quLoadingPunktRocks.First;
        if quLoadingPunktRocks.RecordCount=0 then Inc(Row);
        while not quLoadingPunktRocks.Eof do
        begin
          Inc(Row);
          XL.IntegerCells[Row, 1] := quLoadingPunktRocks.RecNo;
          XL.StringCells [Row, 2] := quLoadingPunktRocksRock.AsString;
          XL.FloatCells  [Row, 3] := quLoadingPunktRocksDensityInBlock.AsFloat;
          XL.FloatCells  [Row, 4] := quLoadingPunktRocksShatteringCoef.AsFloat;
          XL.FloatCells  [Row, 5] := quLoadingPunktRocksContent.AsFloat;
          XL.FloatCells  [Row, 6] := quLoadingPunktRocksPlannedV1000m3.AsFloat;
          XL.StringCells [Row, 7] := '=RC[-1]*RC[-4]';
          if quLoadingPunktRocksIsMineralWealth.AsBoolean
          then sOre := sOre+IntToStr(Row)+';'
          else sStripping := sStripping+IntToStr(Row)+';';
          sRock := sRock+IntToStr(Row)+';';
          quLoadingPunktRocks.Next;
        end;{while}
        quLoadingPunkts.Next;
      end;{while}
      quLoadingPunkts.First;
    end;{with}
    if Row=4 then Inc(Row);
    //Рамка и формат диапазона данных
    XL.Cells[2,1,7,Row].Frame := [feTotal];
    XL.Cells[5,3,5,Row+5].NumberFormat := nfFloat00;
    //Итого
    Inc(Row);
    XL.TitleCell[Row,1,5,1] := 'Итого:';
    XL.Cells[Row,1,5,1].HorizontalAlignment := haLeft;
    XL.Cells[Row,1,7,1].Font.Style := [xlfsBold];
    XL.StringCells[Row,6] := GetFormula(Row,sRock);
    XL.StringCells[Row,7] := GetFormula(Row,sRock);
    //Производительность
    XL.StringCells[Row+2,6] := 'тыс.м3';
    XL.StringCells[Row+2,7] := 'тыс.т';
    XL.StringCells[Row+3,2] := 'РУДА';
    XL.StringCells[Row+4,2] := 'ВСКРЫША';
    XL.StringCells[Row+5,2] := 'ГОРНАЯ МАССА';
    XL.StringCells[Row+3,6] := GetFormula(Row+3,sOre);
    XL.StringCells[Row+3,7] := GetFormula(Row+3,sOre);
    XL.StringCells[Row+4,6] := GetFormula(Row+4,sStripping);
    XL.StringCells[Row+4,7] := GetFormula(Row+4,sStripping);
    XL.StringCells[Row+5,6] := '=Sum(R[-1]C:R[-2]C)';
    XL.StringCells[Row+5,7] := '=Sum(R[-1]C:R[-2]C)';
    XL.StringCells[Row+8,2] := 'Коэффициент вскрыши';
    XL.StringCells[Row+7,6] := 'м3/т';
    XL.StringCells[Row+7,7] := 'т/т';
    XL.StringCells[Row+8,6] := '=IF(R[-5]C[1]>0,R[-4]C/R[-5]C[1],0)';
    XL.StringCells[Row+8,7] := '=IF(R[-5]C>0,R[-4]C/R[-5]C,0)';
    XL.Cells[Row+2,6,2,6].HorizontalAlignment := haRight;
    XL.Cells[Row+4,2,6,1].Frame := [feBottom,feBottomBold];
    XL.Cells[Row+3,6,2,3].NumberFormat := nfFloat000;
    XL.Cells[Row+8,6,2,1].NumberFormat := nfFloat000;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiRockExcelClick}
procedure TfmProductivity.pmLoadingPunktsRocksPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiAdd.Enabled := dbgLoadingPunkts.Enabled;
    pmiEdit.Enabled := pmiAdd.Enabled and(quLoadingPunktRocks.RecordCount>0)and
                       (not(quLoadingPunktRocks.State in [dsEdit,dsInsert]));
    pmiDelete.Enabled := pmiEdit.Enabled;
    pmiDeleteAll.Enabled := pmiEdit.Enabled;
    pmiDefault.Enabled := pmiEdit.Enabled;
    pmiExcel.Enabled := pmiEdit.Enabled;
    pmiUp.Enabled := pmiEdit.Enabled and (quLoadingPunktRocksSortIndex.AsInteger>1);
    pmiDown.Enabled := pmiEdit.Enabled and
      (quLoadingPunktRocksSortIndex.AsInteger<quLoadingPunktRocks.RecordCount);
  end;{with}
end;{pmRocksPopup}

procedure TfmProductivity.pmiDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.LoadingPunktRockDensityInBlock := fmDM.quLoadingPunktRocksDensityInBlock.AsFloat;
    DefaultParams.LoadingPunktRockShatteringCoef := fmDM.quLoadingPunktRocksShatteringCoef.AsFloat;
    DefaultParams.LoadingPunktRockContent := fmDM.quLoadingPunktRocksContent.AsFloat;
    DefaultParams.LoadingPunktRockPlannedV1000m3 := fmDM.quLoadingPunktRocksPlannedV1000m3.AsFloat;
  end;{if}
end;{pmiDefaultClick}
procedure TfmProductivity.pmiDefaultsDlgClick(Sender: TObject);
begin
  esaShowProductivityDefaultsDlg(HelpKeyword);
end;{pmiDefaultsDlgClick}
procedure TfmProductivity.DoLoadingPunktRocksBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN(Format(EDeleteConfirm,[Dataset.FieldByName('Rock').AsString]))
  then Abort;
end;{DoLoadingPunktRocksBeforeDelete}
procedure TfmProductivity.DoLoadingPunktRocksBeforeInsert(DataSet: TDataSet);
var AName: String;
begin
  if (fmDM.quRocks.RecordCount=0)or(not dbgLoadingPunkts.Enabled)then Abort;
  AName := '';
  FSortIndex := Dataset.RecordCount+1;
  FId_Rock := 0;
  with fmDM do
  if dbgLoadingPunktRocks.Enabled and
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
procedure TfmProductivity.DoLoadingPunktRocksBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if not IsFloatFieldMoreMin(DataSet.FieldByName('DensityInBlock'),0.0)then Abort
    else
    if not IsFloatFieldMoreMin(DataSet.FieldByName('ShatteringCoef'),0.0)then Abort
    else
    if Dataset.FieldByName('IsMineralWealth').AsBoolean and
       (not IsFloatFieldInRange1(DataSet.FieldByName('Content'),1.0,100.0))then Abort
    else
    if not IsFloatFieldMoreMin(DataSet.FieldByName('PlannedV1000m3'),0.0)then Abort
    else
    if Dataset.State in [dsInsert,dsEdit] then
    if Dataset.FieldByName('Id_Rock').AsInteger>0 then
    begin
      if not Dataset.FieldByName('IsMineralWealth').AsBoolean
      then DataSet.FieldByName('Content').AsFloat := 0.0;
    end{if}
    else
    begin
      esaMsgError('Не выбрана горная порода.');
      Abort;
    end;{else}
  end;{if}
end;{DoLoadingPunktRocksBeforePost}
procedure TfmProductivity.DoAfterScroll(DataSet: TDataSet);
begin
  FormResize(Self);
  pbLoadingPunktRocks.Invalidate;
end;{DoAfterScroll}
procedure TfmProductivity.DoLoadingPunktRocksAfterDelete(DataSet: TDataSet);
var Id_LoadingPunktRock, ASortIndex: Integer;
begin
  Id_LoadingPunktRock := Dataset.FieldByName('Id_LoadingPunktRock').AsInteger;
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
  Dataset.Locate('Id_LoadingPunktRock',Id_LoadingPunktRock,[]);
  Dataset.EnableControls;
  FormResize(Self);
  UpdateProductivity;
end;{DoLoadingPunktRocksAfterDelete}
procedure TfmProductivity.DoLoadingPunktRocksAfterInsert(DataSet: TDataSet);
begin
  if Dataset.State in [dsInsert] then
  if FId_Rock>0 then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FSortIndex;
    Dataset.FieldByName('Id_Rock').AsInteger := FId_Rock;
    Dataset.FieldByName('DensityInBlock').AsFloat := DefaultParams.LoadingPunktRockDensityInBlock;
    Dataset.FieldByName('ShatteringCoef').AsFloat := DefaultParams.LoadingPunktRockShatteringCoef;
    Dataset.FieldByName('Content').AsFloat := DefaultParams.LoadingPunktRockContent;
    Dataset.FieldByName('PlannedV1000m3').AsFloat := DefaultParams.LoadingPunktRockPlannedV1000m3;
  end;{if}
end;{DoLoadingPunktRocksAfterInsert}
procedure TfmProductivity.DoLoadingPunktRocksAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbLoadingPunktRocks.Invalidate;
  UpdateProductivity;
end;{DoLoadingPunktRocksAfterPost}
//Обновление производительности горной породы, коэф-та вскрыши
procedure TfmProductivity.UpdateProductivity;
begin
  FProductivityMineralWealthV1000m3 := 0.0;
  FProductivityMineralWealthQ1000tn := 0.0;
  FProductivityStrippingV1000m3 := 0.0;
  FProductivityStrippingQ1000tn := 0.0;
  with fmDM do
  begin
    quRockProductivity.Requery;
    quRockProductivity.First;
    while not quRockProductivity.Eof do
    begin
      if quRockProductivityIsMineralWealth.AsBoolean then
      begin
        FProductivityMineralWealthV1000m3 := FProductivityMineralWealthV1000m3+
                                             quRockProductivityPlannedV1000m3.AsFloat;
        FProductivityMineralWealthQ1000tn := FProductivityMineralWealthQ1000tn+
                                             quRockProductivityPlannedQ1000tn.AsFloat;
      end{if}
      else
      begin
        FProductivityStrippingV1000m3 := FProductivityStrippingV1000m3+
                                         quRockProductivityPlannedV1000m3.AsFloat;
        FProductivityStrippingQ1000tn := FProductivityStrippingQ1000tn+
                                         quRockProductivityPlannedQ1000tn.AsFloat;
      end;{else}
      quRockProductivity.Next;
    end;{while}
  end;{with}
  cbProductivityUnitChange(nil);
  cbProductivityStrippingCoefUnitChange(nil);
end;{UpdateProductivity}
procedure TfmProductivity.pbLoadingPunktRocksPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbLoadingPunktRocks.Canvas;
  DrawGridTitle(pbLoadingPunktRocks,dbgLoadingPunktRocks,3,FColWidths);
  with dbgLoadingPunktRocks do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],2*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[0]+1,1,FColWidths[1],2*hCell,['Горная масса']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[1]+1,1,FColWidths[2],2*hCell,['Плотность','в целике, т/м3']);
    with Columns[3] do
      DrawGridCell(Cvs,FColWidths[2]+1,1,FColWidths[3],2*hCell,['Коэффициент','разрыхления']);
    with Columns[4] do
      DrawGridCell(Cvs,FColWidths[3]+1,1,FColWidths[4],2*hCell,['Содержание,','%']);
    with Columns[5] do
      DrawGridCell(Cvs,FColWidths[4]+1,1,FColWidths[6],hCell,['План на период']);
    with Columns[5] do
      DrawGridCell(Cvs,FColWidths[4]+1,hCell+1,FColWidths[5],2*hCell,['тыс.куб.м.']);
    with Columns[6] do
      DrawGridCell(Cvs,FColWidths[5]+1,hCell+1,FColWidths[6],2*hCell,['тыс.тонн']);
  end;{with}
end;{pbLoadingPunktRocksPaint}

procedure TfmProductivity.dbgLoadingPunktRocksDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Column.ReadOnly and (not(gdFocused in State))
  then dbgLoadingPunktRocks.Canvas.Brush.Color :=  clLtGrayEx;
  dbgLoadingPunktRocks.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;{dbgLoadingPunktRocksDrawColumnCell}

procedure TfmProductivity.dbgLoadingPunktsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  with dbgLoadingPunkts do
  begin
    if gdSelected in State then
    begin
      Canvas.Brush.Color :=  clActiveCaption;
      Canvas.Font.Color :=  clWindow;
    end;{if}
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;{with}
end;

procedure TfmProductivity.cbProductivityUnitChange(Sender: TObject);
begin
  case cbProductivityUnit.ItemIndex of
    0: begin
      sttProductivityMineralWealth.Caption :=
        FormatFloat('#,##0.000',FProductivityMineralWealthQ1000tn);
      sttProductivityStripping.Caption :=
        FormatFloat('#,##0.000',FProductivityStrippingQ1000tn);
      sttProductivityRock.Caption :=
        FormatFloat('#,##0.000',FProductivityMineralWealthQ1000tn+FProductivityStrippingQ1000tn);
    end;{тыс.т.}
    1: begin
      sttProductivityMineralWealth.Caption :=
        FormatFloat('#,##0.000',FProductivityMineralWealthV1000m3);
      sttProductivityStripping.Caption :=
        FormatFloat('#,##0.000',FProductivityStrippingV1000m3);
      sttProductivityRock.Caption :=
        FormatFloat('#,##0.000',FProductivityMineralWealthV1000m3+FProductivityStrippingV1000m3);
    end;{тыс.м3.}
  end;{case}
end;{cbProductivityUnitChange}
procedure TfmProductivity.cbProductivityStrippingCoefUnitChange(Sender: TObject);
begin
  FProductivityStrippingCoef := 0.0;
  case cbProductivityStrippingCoefUnit.ItemIndex of
    0: if FProductivityMineralWealthQ1000tn>0.0 // в т/т
       then FProductivityStrippingCoef := FProductivityStrippingQ1000tn/
                                          FProductivityMineralWealthQ1000tn;
    1: if FProductivityMineralWealthQ1000tn>0.0 // в м3/т
       then FProductivityStrippingCoef := FProductivityStrippingV1000m3/
                                          FProductivityMineralWealthQ1000tn;
  end;{case}
  edProductivityStrippingCoef.Text := FormatFloat('#,##0.000',FProductivityStrippingCoef);
end;{cbStrippingCoefChange}

procedure TfmProductivity.pmLoadingPunktsPopup(Sender: TObject);
begin
  with fmDM do
  pmiLoadingPunktsExcel.Enabled := dbgLoadingPunktRocks.Enabled and
                                  (quLoadingPunktRocks.RecordCount>0)and
                                  (not(quLoadingPunktRocks.State in [dsEdit,dsInsert]));
end;{pmRocksPopup}


procedure TfmProductivity.dbgLoadingPunktRocksKeyPress(Sender: TObject; var Key: Char);
begin
  if (dbgLoadingPunktRocks.SelectedIndex in [2..5])and(Key in [',','.'])
  then Key := DecimalSeparator;
end;{dbgLoadingPunktRocksKeyPress}


end.
