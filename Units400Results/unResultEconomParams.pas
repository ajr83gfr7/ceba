unit unResultEconomParams;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrls, DB, ADODB, ComCtrls, Grids,
  DBGridEh;//, GridsEh;

type
  TfmResultEconomParams = class(TForm)
    quResultShifts: TADOQuery;
    quResultShiftsId_ResultShift: TAutoIncField;
    quResultShiftsId_Openpit: TIntegerField;
    quResultShiftsShiftNaryadTmin: TFloatField;
    quResultShiftsShiftPlanNaryadTmin: TFloatField;
    quResultShiftsShiftPeresmenkaTmin: TIntegerField;
    quResultShiftsShiftTmin: TIntegerField;
    quResultShiftsShiftKweek: TFloatField;
    quResultShiftsPeriodKshift: TFloatField;
    quResultShiftsPeriodTday: TIntegerField;
    dsResultShifts: TDataSource;
    pnBtns: TPanel;
    btCancel: TButton;
    quResultShiftsDollarCtg: TFloatField;
    quResultShiftsExpensesYearC1000tg: TIntegerField;
    btDistribution: TButton;
    quResultEconomReports: TADOQuery;
    dsResultEconomReports: TDataSource;
    quResultEconomReportsId_ResultEconomReport: TAutoIncField;
    quResultEconomReportsId_ResultShift: TIntegerField;
    quResultEconomReportsIsChangeable: TBooleanField;
    quResultEconomReportsRecordNo: TIntegerField;
    quResultEconomReportsRecordName: TWideStringField;
    quResultEconomReportsName: TWideStringField;
    quResultEconomReportsValue: TFloatField;
    quResultEconomReportsValue1: TFloatField;
    quResultEconomReportsValue2: TFloatField;
    pnClient: TPanel;
    dbeDollarCtg: TDBEdit;
    cbMeasure: TComboBox;
    lbDollarCtg: TLabel;
    lbMeasure: TLabel;
    dbgResultEconomReports: TDBGridEh;
    quResultEconomReportsValue3: TFloatField;
    btExcel: TButton;
    btShift: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure quResultEconomReportsCalcFields(DataSet: TDataSet);
    procedure btDistributionClick(Sender: TObject);
    procedure cbMeasureChange(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure dbgResultEconomReportsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
  private
  end;

var
  fmResultEconomParams: TfmResultEconomParams;

//Диалоговое окно результатов моделирования по экономическим показателям
procedure esaShowResultEconomParamsDlg();
implementation

uses unDM, unResultEconomParamsDistributation, esaConstants, ComObj, Excel2000,
  unResultShift;

{$R *.dfm}

//Диалоговое окно результатов моделирования по экономическим показателям
procedure esaShowResultEconomParamsDlg();
begin
  fmResultEconomParams := TfmResultEconomParams.Create(nil);
  try
    fmResultEconomParams.ShowModal;
  finally
    fmResultEconomParams.Free;
  end;
end;

procedure TfmResultEconomParams.FormCreate(Sender: TObject);
begin
  quResultShifts.Open;
  quResultEconomReports.Open;
  cbMeasureChange(nil);
end;
procedure TfmResultEconomParams.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultEconomReports.Close;
  quResultShifts.Close;
end;

procedure TfmResultEconomParams.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;
procedure TfmResultEconomParams.quResultEconomReportsCalcFields(DataSet: TDataSet);
var AValue,AKoef: double;  shiftValue: double;
  val2, val3: double;
  _shiftKweek, _periodKshift: double;
begin
  if not(Dataset.FieldByName('Value').IsNull) then
  begin
    if (cbMeasure.ItemIndex=0)or(quResultShiftsDollarCtg.AsFloat<1.0)or
      (Dataset.FieldByName('RecordNo').AsInteger=CesaEconomRockVm3.No)or
      (Dataset.FieldByName('RecordNo').AsInteger=CesaEconomRockQtn.No)
    then AKoef := 1.0
    else AKoef := quResultShiftsDollarCtg.AsFloat;
    AValue := Dataset.FieldByName('Value').AsFloat/AKoef;
    Dataset.FieldByName('Value1').AsFloat := AValue;
    Dataset.FieldByName('Value2').AsFloat := AValue;
    Dataset.FieldByName('Value3').AsFloat := AValue;

    _shiftKweek:= quResultShiftsShiftKweek.AsFloat;
    _periodKshift:= quResultShiftsPeriodKshift.AsFloat;

    if Dataset.FieldByName('IsChangeable').AsBoolean then
    begin
      if (Dataset.FieldByName('RecordNo').AsInteger <> 103) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 203) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 403) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 302)then
        val2:= AValue * quResultShiftsShiftKweek.AsFloat;

      if (Dataset.FieldByName('RecordNo').AsInteger <> 103) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 203) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 403) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 302)then
//        val3:= AValue * quResultShiftsShiftKweek.AsFloat * 2 * 270
//        val3:= AValue * _shiftKweek * _periodKshift
        val3:= AValue * _periodKshift
      else
//        val3:= AValue * 2 * 270;
        val3:= AValue * _periodKshift;
      if (Dataset.FieldByName('RecordNo').AsInteger <> 401) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 402) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 403) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 404) then
        val3:= val3 / 1000;

      Dataset.FieldByName('Value2').AsFloat:= val2;
      Dataset.FieldByName('Value3').AsFloat:= val3;
    end;
  end;
end;

procedure TfmResultEconomParams.btDistributionClick(Sender: TObject);
begin
  esaShowResultEconomParamsDistributation(quResultShiftsId_ResultShift.AsInteger);
end;

procedure TfmResultEconomParams.cbMeasureChange(Sender: TObject);
begin
  quResultEconomReports.Refresh;
end;

procedure TfmResultEconomParams.btExcelClick(Sender: TObject);
var
  XL     : Variant; //Microsoft Excel
  ABook  : Variant; //Рабочая книга Excel
  ARange,ASheet: Variant;
  ARow   : Integer;
begin
  XL := CreateOLEObject('Excel.Application');
  try
    Screen.Cursor := crHourGlass;
    XL.Visible := False;
    ABook := XL.WorkBooks.Add;
    while ABook.Sheets.Count<6 do
      ABook.WorkSheets.Add;
    //Лист 1 -------------------------------------------------------------------
    ASheet := ABook.WorkSheets[1];
    ASheet.Select;
    ASheet.Name := 'Экономические';
    quResultEconomReports.DisableControls;
    ASheet.Range['A1','A1'].Value := Caption;
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgResultEconomReports.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgResultEconomReports.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgResultEconomReports.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultEconomReports.Columns[3].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultEconomReports.Columns[4].Title.Caption;
    ARow := 3;
    if quResultEconomReports.RecordCount>0 then
    begin
      quResultEconomReports.First;
      while not quResultEconomReports.Eof do
      begin
        ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultEconomReportsRecordName.AsString;
        ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultEconomReportsName.AsString;
        if quResultEconomReportsRecordNo.AsInteger mod 100 <> 0 then
        begin
          ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultEconomReportsValue.AsFloat;
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultEconomReportsValue1.AsFloat;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultEconomReportsValue2.AsFloat;
          end
          else ASheet.Range['A'+IntToStr(ARow),'B'+IntToStr(ARow)].Font.Bold := True;
        quResultEconomReports.Next;
        Inc(ARow);
      end;
      quResultEconomReports.First;
    end
    else Inc(ARow);
    if ARow=3 then
      Inc(ARow);
    ARange := ASheet.Range['A1','E'+IntToStr(ARow-1)];
    ASheet.Range['A1','E2'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','E2'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','E2'].WrapText := True;
    ASheet.Range['A1','E1'].Font.Bold := True;
    ASheet.Range['A1','E1'].Merge;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:2'].RowHeight := 37.5;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:A'].ColumnWidth :=  5.0;
    ASheet.Columns['B:B'].ColumnWidth := 65.0;
    ASheet.Columns['C:E'].ColumnWidth := 15.0;
    ASheet.PageSetup.LeftMargin   := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.RightMargin  := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.TopMargin    := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.BottomMargin := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.Orientation  := xlLandscape
  finally
    XL.Visible := True;
    quResultEconomReports.EnableControls;
    XL := Unassigned;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmResultEconomParams.dbgResultEconomReportsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.Dataset.FieldByName('RecordNo').AsInteger mod 100 = 0 then
    TDBGridEh(Sender).Canvas.Font.Style := [fsBold];
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmResultEconomParams.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;

end.
