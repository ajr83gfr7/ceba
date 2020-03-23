unit unAutoPlacing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, Grids, DBGrids, Types, DB, ADODb;

type
  RItem=record
    Id: Integer;
    Name: String;
  end;
  PItem=^RItem;
  TfmAutoPlacing = class(TForm)
    pbDeportAutos: TPaintBox;
    dbgDeportAutos: TDBGrid;
    pnBtns: TPanel;
    btClose: TButton;
    pmDeportAutos: TPopupMenu;
    pmiShiftPunkts: TMenuItem;
    pmiSep1: TMenuItem;
    pmiExcel: TMenuItem;
    pmiCourses: TMenuItem;
    btExcel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbDeportAutosPaint(Sender: TObject);
    procedure pmiShiftPunktsClick(Sender: TObject);
    procedure pmiExcelClick(Sender: TObject);
    procedure pmiCoursesClick(Sender: TObject);
    procedure DoCancel(Dataset: TDataset);
  private
    FColWidths  : TIntegerDynArray;
    FCourses    : TList;
    FShiftPunkts: TList;
    function GetSelectedRecords: String;
    procedure UpdateShifPunktNo_CourseNo;
  public
  end;{TfmDeportAutoPlacing}

var
  fmAutoPlacing: TfmAutoPlacing;

//Диалоговое окно растановки автосамосвалов
function esaShowAutoPlacingDlg(): Boolean;
implementation

uses unDM, Globals, ExcelEditors;

{$R *.dfm}
//Диалоговое окно растановки автосамосвалов
function esaShowAutoPlacingDlg(): Boolean;
begin
  fmAutoPlacing := TfmAutoPlacing.Create(nil);
  try
    Result := fmAutoPlacing.ShowModal=mrOk;
  finally
    fmAutoPlacing.Free;
  end;{try}
end;{esaShowAutoPlacingDlg}

procedure TfmAutoPlacing.UpdateShifPunktNo_CourseNo;
var
  AItem: PItem;
  S0,S1: String;
  I: Integer;
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  with fmDM do
  begin
    //FShiftPunkts, FCourse -------------------------------------------------------------------
    quPoints.Open;
    quShiftPunkts.Open;
    quExcavatorEngines.Open;
    quExcavators.Open;
    quDeportExcavators.Open;
    quLoadingPunkts.Open;
    quUnLoadingPunkts.Open;
    //ShiftPunkts
    while not quShiftPunkts.Eof do
    begin
      New(AItem);
      AItem^.Id := quShiftPunktsId_ShiftPunkt.AsInteger;
      AItem^.Name := quShiftPunktsName.AsString;
      FShiftPunkts.Add(AItem);
      quShiftPunkts.Next;
    end;{while}
    //Courses
    quCourses.Open;
    while not quCourses.Eof do
    begin
      if quCoursesKind.AsInteger=0 then
      begin
        New(AItem);
        AItem^.Id := quCoursesId_Course.AsInteger;
        if quLoadingPunkts.Locate('Id_Point',quCoursesId_Point0.AsInteger,[])
        then S0 := quLoadingPunktsTotalName.AsString
        else S0 := '';
        if quUnLoadingPunkts.Locate('Id_Point',quCoursesId_Point1.AsInteger,[])
        then S1 := quUnLoadingPunktsTotalName.AsString
        else S1 := '';
        if (S0<>'')and(S1<>'')
        then AItem^.Name := Format('№%.2d [%s] -> [%s]',[quCoursesNo.AsInteger,S0,S1])
        else AItem^.Name := Format('№%.2d ?',[quCoursesNo.AsInteger]);
        FCourses.Add(AItem);
      end;{if}
      quCourses.Next;
    end;{while}
    quCourses.Close;
    quPoints.Close;
    quShiftPunkts.Close;
    quPoints.Close;
    quShiftPunkts.Close;
    quUnLoadingPunkts.Close;
    quLoadingPunkts.Close;
    quDeportExcavators.Close;
    quExcavators.Close;
    quExcavatorEngines.Close;
    
    //DeportAutos -----------------------------------------------------------------------------
    quDeportAutos.First;
    while not quDeportAutos.Eof do
    begin
      S0 := '';
      for I := 0 to FShiftPunkts.Count-1 do
      if quDeportAutosId_ShiftPunkt.AsInteger=PItem(FShiftPunkts[I])^.Id then
      begin
        S0 := PItem(FShiftPunkts[I])^.Name; Break;
      end;{for}
      S1 := '';
      for I := 0 to FCourses.Count-1 do
      if quDeportAutosId_Course.AsInteger=PItem(FCourses[I])^.Id then
      begin
        S1 := PItem(FCourses[I])^.Name; Break;
      end;{for}
      quDeportAutos.Edit;
      if S0<>''
      then quDeportAutosShiftPunkt.AsString := S0
      else quDeportAutosShiftPunkt.AsVariant := null;
      if S1<>''
      then quDeportAutosCourse.AsString := S1
      else quDeportAutosCourse.AsVariant := null;
      quDeportAutos.Post;
      quDeportAutos.Next;
    end;{while}
    quDeportAutos.Requery;
  end;{with}
end;{UpdateShifPunktNo_CourseNo}
procedure TfmAutoPlacing.FormCreate(Sender: TObject);
begin
  FCourses := TList.Create;
  FShiftPunkts := TList.Create;
  dbgDeportAutos.Options := [dgIndicator,dgColLines,dgRowLines,dgRowSelect,dgMultiSelect];
  SetLength(FColWidths,dbgDeportAutos.Columns.Count);
  with fmDM do
  begin
    quAutoEngines.Open;
    quAutos.Open;
    quDeportAutos.Open;
    UpdateShifPunktNo_CourseNo;

    quDeportAutos.BeforeDelete := DoCancel;
    quDeportAutos.BeforeInsert := DoCancel;
  end;{with}
end;{FormCreate}
procedure TfmAutoPlacing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quDeportAutos.Close;
    quAutos.Close;
    quAutoEngines.Close;
    quDeportAutos.BeforeDelete := nil;
    quDeportAutos.BeforeInsert := nil;
  end;{with}
  FColWidths := nil;
  ClearList(FCourses);
  FCourses.Free;
  ClearList(FShiftPunkts);
  FShiftPunkts.Free;
end;{FormClose}
procedure TfmAutoPlacing.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quDeportAutos,Caption);
end;{FormCloseQuery}
procedure TfmAutoPlacing.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgDeportAutos,1);
  UpdateColumnRights(dbgDeportAutos,FColWidths);
end;{FormResize}

procedure TfmAutoPlacing.pbDeportAutosPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbDeportAutos.Canvas;
  DrawGridTitle(pbDeportAutos,dbgDeportAutos,3,FColWidths);
  with dbgDeportAutos do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FColWidths[0]-Width,1,FColWidths[0],2*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FColWidths[0]+1,1,FColWidths[1],2*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FColWidths[1]+1,1,FColWidths[2],2*hCell,['Рабочее','состояние']);
    with Columns[3] do
      DrawGridCell(Cvs,FColWidths[2]+1,1,FColWidths[3],2*hCell,['Пункт','пересменки']);
    with Columns[4] do
      DrawGridCell(Cvs,FColWidths[3]+1,1,FColWidths[4],2*hCell,['Маршрут','движения']);
  end;{with}
end;{pbDeportAutosPaint}

//Возвращает Список кодов выделенных автосамосвалов списочного парка
function TfmAutoPlacing.GetSelectedRecords: String;
var
  I: Integer;
  ADataset: TDataSet;
begin
  //quDeportAutos.RecordCount>0!!!
  Result := ',';
  with fmDM do
  begin
    //Нахожу список кодов выделенных записи
    if dbgDeportAutos.SelectedRows.Count>0 then
    begin
      ADataset := dbgDeportAutos.DataSource.DataSet;
      for I := 0 to dbgDeportAutos.SelectedRows.Count-1 do
      begin
        ADataset.GotoBookmark(Pointer(dbgDeportAutos.SelectedRows.Items[I]));
        Result := Result+ADataset.FieldByName('Id_DeportAuto').AsString+',';
      end;{for}
    end;{if}
    //Если кода текущей записи нет в списке, то добавляю его
    if Pos(','+quDeportAutosId_DeportAuto.AsString+',',Result)=0
    then Result := Result+quDeportAutosId_DeportAuto.AsString+',';
    //Убираю начальную и конечную запятую
    Result := Copy(Result,2,Length(Result)-2);
  end;{with}
end;{GetSelectedRecords}
//Ввод текстового значения в поле таблицы БД
function InputItem(const ACaption,APrompt: string;
                   const AList: TList;
                   var   AValue: String;
                   const AAllowBlank: boolean = false): boolean;
var
  fmDlg        : TForm;
  cbName       : TComboBox;
  btOk,btCancel: TButton;
  lbName       : TLabel;
  I            : Integer;  
begin
  fmDlg := CreateDialogForm(ACaption,400,128);
  try
    lbName := TLabel.Create(fmDlg);
    SetLabelProperties(lbName,fmDlg,Point(16,8),APrompt);
    cbName := TComboBox.Create(fmDlg);
    with cbName do
    begin
      Parent := fmDlg; Left := 16; Top := 24; Width := 368;
      Anchors := [akLeft,akTop,akRight];
      Style := csDropDownList;
      if AAllowBlank then cbName.Items.Add('');
      for I := 0 to AList.Count-1 do
        cbName.Items.Add(PItem(AList[I])^.Name);
      if cbName.Items.Count>0 then cbName.ItemIndex := cbName.Items.IndexOf(AValue);
      if cbName.ItemIndex=-1 then cbName.ItemIndex := 0;
    end;{with}
    btOk := TButton.Create(fmDlg);
    SetButtonProperties(btOk,fmDlg,Point(224,64),'Ok',true,false,mrOk);
    btCancel := TButton.Create(fmDlg);
    SetButtonProperties(btCancel,fmDlg,Point(304,64),'Отмена',false,true,mrCancel);
    Result := fmDlg.ShowModal=mrOk;
    if Result then AValue := cbName.Text;
  finally
    fmDlg.Free;
  end;{try}
end;{InputItem}
procedure TfmAutoPlacing.pmiShiftPunktsClick(Sender: TObject);
var
  sId_DeportAutos : String; //Список кодов выделенных записей sId_DeportAutos=',8,..,45,..,9,'
  ShiftPunkt      : String;//Номер общего пункта погрузки
  AId_Auto        : Integer;
  AId_ShiftPunkt,I: Integer;
begin
  with fmDM do
  begin
    if quDeportAutos.RecordCount=0 then Exit;
    AId_Auto := quDeportAutosId_DeportAuto.AsInteger;
    sId_DeportAutos := GetSelectedRecords;
    if sId_DeportAutos='' then Exit;//на всякий пожарный
    ShiftPunkt := quDeportAutosShiftPunkt.AsString;
    if InputItem('Пункты пересменки','Номер пункта пересменки',FShiftPunkts,ShiftPunkt)then
    begin
      AId_ShiftPunkt := 0;
      for I := 0 to FShiftPunkts.Count-1 do
      if PItem(FShiftPunkts[I])^.Name=ShiftPunkt then
      begin
        AId_ShiftPunkt := PItem(FShiftPunkts[I])^.Id; Break;
      end;{for}
      with TADOQuery.Create(nil) do
      try
        Connection := ADOConnection;
        if AId_ShiftPunkt>0
        then SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_ShiftPunkt='+
                          IntToStr(AId_ShiftPunkt)+','+
                         'ShiftPunkt='''+ShiftPunkt+''' '+
                         'WHERE (Id_DeportAuto in ('+sId_DeportAutos+'))AND WorkState'
        else SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_ShiftPunkt=NULL,ShiftPunkt=Null '+
                         'WHERE Id_DeportAuto in ('+sId_DeportAutos+')';
        ExecSQL;
      finally
        Free;
      end;{try}
      quDeportAutos.Requery;
      quDeportAutos.Locate('Id_DeportAuto',AId_Auto,[]);
    end;{if}
  end;{with}
end;{pmiShiftPunktsClick}
procedure TfmAutoPlacing.pmiCoursesClick(Sender: TObject);
var
  sId_DeportAutos : String; //Список кодов выделенных записей sId_DeportAutos=',8,..,45,..,9,'
  Course      : String;//Номер общего пункта погрузки
  AId_Auto        : Integer;
  AId_Course,I: Integer;
begin
  with fmDM do
  begin
    if quDeportAutos.RecordCount=0 then Exit;
    AId_Auto := quDeportAutosId_DeportAuto.AsInteger;
    sId_DeportAutos := GetSelectedRecords;
    if sId_DeportAutos='' then Exit;//на всякий пожарный
    Course := quDeportAutosCourse.AsString;
    if InputItem('Пункты пересменки','Номер пункта пересменки',FCourses,Course,true)then
    begin
      AId_Course := 0;
      for I := 0 to FCourses.Count-1 do
      if PItem(FCourses[I])^.Name=Course then
      begin
        AId_Course := PItem(FCourses[I])^.Id; Break;
      end;{for}
      with TADOQuery.Create(nil) do
      try
        Connection := ADOConnection;
        if AId_Course>0
        then SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_Course='+
                          IntToStr(AId_Course)+','+
                         'Course='''+Course+''' '+
                         'WHERE (Id_DeportAuto in ('+sId_DeportAutos+'))AND WorkState'
        else SQL.Text := 'UPDATE OpenpitDeportAutos SET Id_Course=NULL,Course=Null '+
                         'WHERE Id_DeportAuto in ('+sId_DeportAutos+')';
        ExecSQL;
      finally
        Free;
      end;{try}
      quDeportAutos.Requery;
      quDeportAutos.Locate('Id_DeportAuto',AId_Auto,[]);
    end;{if}
  end;{with}
end;{pmiCoursesClick}
procedure TfmAutoPlacing.pmiExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  ACount: Integer;
begin
  XL := TExcelEditor.Create;
  with fmDM do
  try
    XL.SheetCount := 1;
    XL.TitleCell[1,1,5,1] := Caption;
    XL.RangeTitleOn(2,1,['№',
                         'Наименование',
                         'Рабочее состояние',
                         'Пункт пересменки',
                         'Маршрут движения']);
    XL.ColumnWidths[1,1] := 3;
    XL.ColumnWidths[2,1] := 20;
    XL.ColumnWidths[3,1] := 8;
    XL.ColumnWidths[4,1] := 15;
    XL.ColumnWidths[5,1] := 50;
    if quDeportAutos.RecordCount=0
    then ACount := 1
    else ACount := quDeportAutos.RecordCount;
    quDeportAutos.First;
    while not quDeportAutos.Eof do
    begin
      XL.IntegerCells[quDeportAutos.RecNo+3,1] := quDeportAutosSortIndex.AsInteger;
      XL.StringCells [quDeportAutos.RecNo+3,2] := quDeportAutosTotalName.AsString;
      if quDeportAutosWorkState.AsBoolean
      then XL.StringCells [quDeportAutos.RecNo+3,3] := '+';
      XL.StringCells [quDeportAutos.RecNo+3,4] := quDeportAutosShiftPunkt.AsString;
      XL.StringCells [quDeportAutos.RecNo+3,5] := quDeportAutosCourse.AsString;
      quDeportAutos.Next;
    end;{while}
    quDeportAutos.First;
    XL.Cells[2,1,5,ACount+2].Frame := [feTotal];
    XL.Cells[4,2,4,ACount].HorizontalAlignment := haLeft;
    XL.Cells[4,3,1,ACount].HorizontalAlignment := haCenter;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiExcelClick}
procedure TfmAutoPlacing.DoCancel(Dataset: TDataset);
begin
  Abort;
end;{DoCancel}

end.
