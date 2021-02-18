unit unResultShiftBlocks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, DBLookupEh, DB, ADODB,
  Grids, DBGridEh, DBSumLst, ComCtrls, Excel2000, DBGrids, TeEngine,
  Series, TeeProcs, Chart, DbChart;//, GridsEh;

type
  TfmResultShiftBlocks = class(TForm)
    quResultShifts: TADOQuery;
    quResultShiftsId_ResultShift: TAutoIncField;
    quResultShiftsId_Openpit: TIntegerField;
    quResultShiftsShiftNaryadTmin: TFloatField;
    quResultShiftsShiftTmin: TIntegerField;
    quResultShiftsPeriodKshift: TFloatField;
    quResultShiftsPeriodTday: TIntegerField;
    dsResultShifts: TDataSource;
    pnBtns: TPanel;
    quResultShiftBlocks: TADOQuery;
    dsResultShiftBlocks: TDataSource;
    quResultShiftBlockReport1: TADOQuery;
    dsResultShiftBlockReport1: TDataSource;
    PageControl: TPageControl;
    tsResultShiftBlocksReport1: TTabSheet;
    dbgResultShiftBlockReport1: TDBGridEh;
    tsResultShiftBlocksReport2: TTabSheet;
    tsResultShiftBlocksReport3: TTabSheet;
    quResultShiftBlockReport1RecordNo: TIntegerField;
    quResultShiftBlockReport1Value: TFloatField;
    quResultShiftBlockReport1Name: TStringField;
    quResultShiftBlockReport1Value1: TFloatField;
    quResultShiftBlockReport1Value2: TFloatField;
    Splitter1: TSplitter;
    quResultShiftsShiftPeresmenkaTmin: TIntegerField;
    quResultShiftsShiftPlanNaryadTmin: TFloatField;
    quResultShiftsShiftKweek: TFloatField;
    quResultShiftBlockModels: TADOQuery;
    dsResultShiftBlockModels: TDataSource;
    quResultShiftBlockModelsId_RoadCoat: TIntegerField;
    quResultShiftBlockModelsRoadCoat: TWideStringField;
    dbgBlocks2: TDBGridEh;
    Splitter2: TSplitter;
    dbgResultShiftBlockReport2: TDBGridEh;
    quResultShiftBlockReport2: TADOQuery;
    dsResultShiftBlockReport2: TDataSource;
    quResultShiftBlockReport2Id_RoadCoat: TIntegerField;
    quResultShiftBlockReport2RoadCoat: TWideStringField;
    quResultShiftBlockReport2Value: TFloatField;
    quResultShiftBlockReport2Value1: TFloatField;
    quResultShiftBlockReport2Value2: TFloatField;
    quResultShiftBlockReport3: TADOQuery;
    dsResultShiftBlockReport3: TDataSource;
    quResultShiftBlockReport3Id_ResultShift: TIntegerField;
    quResultShiftBlockReport3Id_RoadCoat: TIntegerField;
    quResultShiftBlockReport3RoadCoat: TWideStringField;
    quResultShiftBlockReport3Kind: TWordField;
    quResultShiftBlockReport3Value: TFloatField;
    quResultShiftBlockReport3Value1: TFloatField;
    quResultShiftBlockReport3Value2: TFloatField;
    dbgResultShiftBlockReport3: TDBGridEh;
    btClose: TButton;
    btExcel: TButton;
    quResultShiftBlockReport1Id_ResultShiftBlockReport: TAutoIncField;
    quResultShiftBlockReport1Id_ResultShift: TIntegerField;
    quResultShiftBlockReport1Id_ResultShiftBlock: TIntegerField;
    quResultShiftBlockReport1Id_RoadCoat: TIntegerField;
    quResultShiftBlockReport1RoadCoat: TWideStringField;
    quResultShiftBlockReport1Kind: TWordField;
    quResultShiftBlockReport2Id_ResultShiftBlockReport: TAutoIncField;
    quResultShiftBlockReport2Id_ResultShift: TIntegerField;
    quResultShiftBlockReport2Id_ResultShiftBlock: TIntegerField;
    quResultShiftBlockReport2Kind: TWordField;
    quResultShiftBlockReport3Id_ResultShiftBlockReport: TAutoIncField;
    quResultShiftBlockReport3Id_ResultShiftBlock: TIntegerField;
    quResultShiftBlockReport1IsChangeable: TBooleanField;
    quResultShiftBlockReport1RecordName: TWideStringField;
    quResultShiftBlockReport2IsChangeable: TBooleanField;
    quResultShiftBlockReport2RecordNo: TIntegerField;
    quResultShiftBlockReport2RecordName: TWideStringField;
    quResultShiftBlockReport2Name: TWideStringField;
    quResultShiftBlockReport3IsChangeable: TBooleanField;
    quResultShiftBlockReport3RecordNo: TIntegerField;
    quResultShiftBlockReport3RecordName: TWideStringField;
    quResultShiftBlockReport3Name: TWideStringField;
    quResultShiftBlocksId_ResultShiftBlock: TAutoIncField;
    quResultShiftBlocksId_ResultShift: TIntegerField;
    quResultShiftBlocksId_Block: TIntegerField;
    quResultShiftBlocksId_RoadCoat: TIntegerField;
    quResultShiftBlocksRoadCoat: TWideStringField;
    quResultShiftBlocksBuildingC1000tg: TFloatField;
    quResultShiftBlocksKeepingYearC1000tg: TFloatField;
    quResultShiftBlocksAmortizationR: TFloatField;
    quResultShiftBlockLengths: TADOQuery;
    quResultShiftBlockLengthsTotalLm: TFloatField;
    quResultShiftBlocksLengthRatio: TFloatField;
    quResultShiftBlockModelsLengthRatio: TFloatField;
    dbgBlocks1: TDBGridEh;
    quResultShiftsDollarCtg: TFloatField;
    quResultShiftBlocksLsm: TIntegerField;
    quResultShiftBlocksLm: TFloatField;
    quResultShiftBlockModelsLsm: TIntegerField;
    quResultShiftBlockModelsLm: TFloatField;
    btShift: TButton;
    btPowerConsuming: TButton;
    btRoadFunction: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftBlockReport1CalcFields(DataSet: TDataSet);
    procedure dbgResultShiftBlockEventsDrawFooterCell(Sender: TObject;
      DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
      State: TGridDrawState);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure btExcelClick(Sender: TObject);
    procedure quResultShiftBlocksCalcFields(DataSet: TDataSet);
    procedure dbgResultShiftBlockReport1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
    procedure btPowerConsumingClick(Sender: TObject);
    procedure btRoadFunctionClick(Sender: TObject);
  private
  public
    procedure xlDrawPrintSetup(XL,ASheet: Variant; const AIsPortrait: Boolean);
    procedure xlDrawShift(XL,ASheet: Variant);
    procedure xlDrawBlocks(XL,ASheet: Variant);
    procedure xlDrawBlocksReport1(XL,ASheet: Variant);
    procedure xlDrawBlocksReport2(XL,ASheet: Variant);
    procedure xlDrawBlocksReport3(XL,ASheet: Variant);
  public
  end;{TfmResultShiftBlocks}

var
  fmResultShiftBlocks: TfmResultShiftBlocks;

//Диалоговое окно результатов моделирования по блок-участкам
procedure esaShowResultShiftBlocksDlg();
implementation

uses unDM, ComObj, Math, unResultShift, unResultBlocksPowerConsuming,
  unResultBlocksFunctioning;

{$R *.dfm}

const
  cNo             = 0;

//Диалоговое окно результатов моделирования по блок-участкам
procedure esaShowResultShiftBlocksDlg();
begin
  fmResultShiftBlocks := TfmResultShiftBlocks.Create(nil);
  try
    fmResultShiftBlocks.ShowModal;
  finally
    fmResultShiftBlocks.Free;
  end;{try}
end;{esaShowResultShiftBlocksDlg}

procedure TfmResultShiftBlocks.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  quResultShifts.Open;
  quResultShiftBlockLengths.Open;
  quResultShiftBlocks.Open;
  quResultShiftBlockModels.Open;
  quResultShiftBlockReport1.Open;
  quResultShiftBlockReport2.Open;
  quResultShiftBlockReport3.Open;
end;{FormCreate}

procedure TfmResultShiftBlocks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultShiftBlockReport3.Close;
  quResultShiftBlockReport2.Close;
  quResultShiftBlockReport1.Close;
  quResultShiftBlockModels.Close;
  quResultShiftBlocks.Close;
  quResultShiftBlockLengths.Close;
  quResultShifts.Close;
end;{FormClose}


procedure TfmResultShiftBlocks.quResultShiftBlockReport1CalcFields(DataSet: TDataSet);
const
  SUM_COSTS_OF_BLOKS = 'SELECT ' +
                       ' WorkValue.Value as WorkCost, ' +
                       ' AmorValue.Value as AmorCost ' +
                       'FROM ' +
                       ' (SELECT Value FROM _ResultShiftBlockReports WHERE Kind=3 AND RecordNo=401) as WorkValue, ' +
                       ' (SELECT Value FROM _ResultShiftBlockReports WHERE Kind=3 AND RecordNo=402) as AmorValue';
var
  _value: double;
  _shiftKweek, _periodKshift: double;
  //
  _qry: TADOQuery;
  _WorkCost, _AmorCost: double;
  _WorkCost_avg, _AmorCost_avg: double;
  _WorkCost_period, _AmorCost_period: double;
  _Cost_sum, _Cost_arg_sum, _Cost_period_sum: double;
begin
  if not(Dataset.FieldByName('Value').IsNull) then
  begin
    _value:= Dataset.FieldByName('Value').AsFloat;
    _shiftKweek:= quResultShiftsShiftKweek.AsFloat;
    _periodKshift:= quResultShiftsPeriodKshift.AsFloat;
    if Dataset.FieldByName('IsChangeable').AsBoolean then
    begin
      if (Dataset.FieldByName('RecordNo').AsInteger = 402) then
      begin
        Dataset.FieldByName('Value1').AsFloat:= _value;
        Dataset.FieldByName('Value2').AsFloat := _value * 2 * 365;
      end
      else if (Dataset.FieldByName('RecordNo').AsInteger = 404) then
      begin
        _qry:= TADOQuery.Create(nil);
        _qry.Connection:= fmDM.ADOConnection;
        _qry.SQL.Text:= SUM_COSTS_OF_BLOKS;
        _qry.Open;
        try
          _WorkCost:= _qry.FieldByName('WorkCost').AsFloat;
          _AmorCost:= _qry.FieldByName('AmorCost').AsFloat;
          //
          _WorkCost_avg:= _WorkCost * _shiftKweek;
          _AmorCost_avg:= _AmorCost;
          //
          _WorkCost_period:= _WorkCost_avg * _periodKshift;
          _AmorCost_period:= _AmorCost_avg * 2 * 365;
          //
          _Cost_sum:= _WorkCost + _AmorCost;
          _Cost_arg_sum:= _WorkCost_avg + _AmorCost_avg;
          _Cost_period_sum:= _WorkCost_period + _AmorCost_period;
          //
          Dataset.FieldByName('Value').AsFloat:= _Cost_sum;
          Dataset.FieldByName('Value1').AsFloat:= _Cost_arg_sum;
          Dataset.FieldByName('Value2').AsFloat:= _Cost_period_sum;
        finally
          _qry.Close;
          _qry.Free;
        end;
      end
      else
      begin
        Dataset.FieldByName('Value1').AsFloat:= _value * _shiftKweek;
        Dataset.FieldByName('Value2').AsFloat := (_value * _shiftKweek) * _periodKshift;
      end;
    end
    else
    begin
      Dataset.FieldByName('Value1').AsFloat := _value * 1.0;
      Dataset.FieldByName('Value2').AsFloat := _value * 1.0;
    end;
  end;
end;
procedure TfmResultShiftBlocks.dbgResultShiftBlockEventsDrawFooterCell(
  Sender: TObject; DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
  State: TGridDrawState);
begin
  (Sender As TDBGridEh).DefaultDrawFooterCell(Rect, DataCol, Row, Column, State);
end;

procedure TfmResultShiftBlocks.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat:=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;

procedure TfmResultShiftBlocks.xlDrawPrintSetup(XL,ASheet: Variant; const AIsPortrait: Boolean);
begin
  try
    ASheet.PageSetup.LeftMargin   := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.RightMargin  := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.TopMargin    := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.BottomMargin := XL.InchesToPoints(0.39370);
    if AIsPortrait
    then ASheet.PageSetup.Orientation  := xlPortrait
    else ASheet.PageSetup.Orientation  := xlLandscape;
  finally
  end;{try}
end;{xlDrawPrintSetup}
procedure TfmResultShiftBlocks.xlDrawShift(XL,ASheet: Variant);
var
  AGrid       : Variant;
  ARange      : Variant;
  ACols,ARows : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Рабочая смена';
  ACols := 3;
  ARows := 10;
  AGrid := VarArrayCreate([0,ARows-1,0,ACols-1],varVariant);
  try
    AGrid[0,0] := 'Параметры рабочей смены';
    AGrid[1,0] := quResultShiftsId_ResultShift.DisplayLabel;
    AGrid[2,0] := quResultShiftsId_Openpit.DisplayLabel;
    AGrid[3,0] := quResultShiftsShiftNaryadTmin.DisplayLabel;
    AGrid[4,0] := quResultShiftsShiftPlanNaryadTmin.DisplayLabel;
    AGrid[5,0] := quResultShiftsShiftPeresmenkaTmin.DisplayLabel;
    AGrid[6,0] := quResultShiftsShiftTmin.DisplayLabel;
    AGrid[7,0] := quResultShiftsShiftKweek.DisplayLabel;
    AGrid[8,0] := quResultShiftsPeriodKshift.DisplayLabel;
    AGrid[9,0] := quResultShiftsPeriodTday.DisplayLabel;

    AGrid[1,1] := quResultShiftsId_ResultShift.AsInteger;
    AGrid[2,1] := quResultShiftsId_Openpit.AsInteger;
    AGrid[3,1] := quResultShiftsShiftNaryadTmin.AsFloat;
    AGrid[4,1] := quResultShiftsShiftPlanNaryadTmin.AsFloat;
    AGrid[5,1] := quResultShiftsShiftPeresmenkaTmin.AsFloat;
    AGrid[6,1] := quResultShiftsShiftTmin.AsFloat;
    AGrid[7,1] := quResultShiftsShiftKweek.AsFloat;
    AGrid[8,1] := quResultShiftsPeriodKshift.AsFloat;
    AGrid[9,1] := quResultShiftsPeriodTday.AsFloat;
    ASheet.Range['A1','B1'].Merge;
    ASheet.Range['A1','B1'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','B1'].Font.Bold := True;
    ARange := ASheet.Range['A1','B'+IntToStr(ARows)];
    ARange.Value := AGrid;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:A'].ColumnWidth := 95.0;
    ASheet.Columns['B:B'].ColumnWidth := 8.0;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    xlDrawPrintSetup(XL,ASheet,True);
  finally
    AGrid := Unassigned;
  end;{try}
end;{xlDrawShift}
procedure TfmResultShiftBlocks.xlDrawBlocks(XL,ASheet: Variant);
var
  AGrid       : Variant;
  ARange      : Variant;
  ACols,ARows : Integer;
  ARow        : Integer;
  sCol        : Char;
begin
  ASheet.Select;
  ASheet.Name := 'Блок участки';
  ACols := 14;
  ARows := 3+Max(1,quResultShiftBlocks.RecordCount);
  AGrid := VarArrayCreate([0,ARows-1,0,ACols-1],varVariant);
  try
    AGrid[0,0] := 'Блок участки автотрассы';
    //Шапка
    AGrid[1,0] := dbgBlocks1.Columns[0].Title.Caption;
    AGrid[1,1] := dbgBlocks1.Columns[1].Title.Caption;
    AGrid[1,2] := dbgBlocks1.Columns[2].Title.Caption;
    AGrid[1,3] := 'Дорожное покрытие';
    AGrid[2,3] := 'Код';
    AGrid[2,4] := 'Дорожное покрытие';
    AGrid[1,5] := 'Затраты на 1 км автодороги на';
    AGrid[2,5] := 'сооружение, тыс.тенге';
    AGrid[2,6] := 'содержание, тыс.тенге/год';
    AGrid[1,7] := 'Норма амортизации';
    ARow := 3;
    quResultShiftBlocks.First;
    while not quResultShiftBlocks.Eof do
    begin
      AGrid[ARow, 0] := quResultShiftBlocksId_ResultShiftBlock.AsInteger;
      AGrid[ARow, 1] := quResultShiftBlocksLm.AsFloat;
      AGrid[ARow, 2] := quResultShiftBlocksLengthRatio.AsInteger;
      AGrid[ARow, 3] := quResultShiftBlocksId_RoadCoat.AsInteger;
      AGrid[ARow, 4] := quResultShiftBlocksRoadCoat.AsString;
      AGrid[ARow, 5] := quResultShiftBlocksBuildingC1000tg.AsFloat;
      AGrid[ARow, 6] := quResultShiftBlocksKeepingYearC1000tg.AsFloat;
      AGrid[ARow, 7] := quResultShiftBlocksAmortizationR.AsFloat;
      Inc(ARow);
      quResultShiftBlocks.Next;
    end;{while}
    ARange := ASheet.Range['A1','H'+IntToStr(ARows)];
    ARange.Value := AGrid;
    ASheet.Range['A1','H1'].Merge;
    for sCol := 'A' to 'H' do
      if sCol in ['A'..'C','H'] then ASheet.Range[sCol+'2',sCol+'3'].Merge;
    ASheet.Range['D2','E2'].Merge;
    ASheet.Range['F2','G2'].Merge;
    ASheet.Range['A1','H3'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','H3'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','H3'].WrapText := True;
    ASheet.Columns['A:H'].ColumnWidth := 8.0;

    ASheet.Columns['A:A'].ColumnWidth := 5.0;
    ASheet.Columns['B:B'].ColumnWidth := 10.0;
    ASheet.Columns['C:C'].ColumnWidth := 8.0;
    ASheet.Columns['D:D'].ColumnWidth := 5.0;
    ASheet.Columns['E:E'].ColumnWidth := 25.0;
    ASheet.Columns['F:F'].ColumnWidth := 12.0;
    ASheet.Columns['G:G'].ColumnWidth := 13.0;
    ASheet.Columns['H:H'].ColumnWidth := 13.0;
    ASheet.Range['A1','H1'].Font.Bold := True;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:3'].RowHeight := 25.0;
    xlDrawPrintSetup(XL,ASheet,True);
  finally
    AGrid := Unassigned;
  end;{try}
end;{xlDrawBlocks}
procedure TfmResultShiftBlocks.xlDrawBlocksReport1(XL,ASheet: Variant);
var
  ARange: Variant;
  ARow  : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Детальная информация';
  try
    quResultShiftBlockReport1.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по блок-участкам (детальная)';
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgBlocks1.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgBlocks1.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgBlocks1.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftBlockReport1.Columns[0].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftBlockReport1.Columns[1].Title.Caption;
    ASheet.Range['F2','F2'].Value := dbgResultShiftBlockReport1.Columns[2].Title.Caption;
    ASheet.Range['G2','G2'].Value := dbgResultShiftBlockReport1.Columns[3].Title.Caption;
    ASheet.Range['H2','H2'].Value := dbgResultShiftBlockReport1.Columns[4].Title.Caption;
    ARow := 3;
    quResultShiftBlocks.First;
    while not quResultShiftBlocks.Eof do
    begin
      ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftBlocksId_ResultShiftBlock.AsInteger;
      ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftBlocksLm.AsFloat;
      ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftBlocksLengthRatio.AsFloat;
      quResultShiftBlockReport1.Last;
      if quResultShiftBlockReport1.RecordCount>0 then
      begin
        quResultShiftBlockReport1.First;
        while not quResultShiftBlockReport1.Eof do
        begin
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftBlockReport1RecordName.AsString;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftBlockReport1Name.AsString;
          if quResultShiftBlockReport1RecordNo.AsInteger mod 100 <> 0 then
          begin
            ASheet.Range['F'+IntToStr(ARow),'F'+IntToStr(ARow)].Value := quResultShiftBlockReport1Value.AsFloat;
            ASheet.Range['G'+IntToStr(ARow),'G'+IntToStr(ARow)].Value := quResultShiftBlockReport1Value1.AsFloat;
            ASheet.Range['H'+IntToStr(ARow),'H'+IntToStr(ARow)].Value := quResultShiftBlockReport1Value2.AsFloat;
          end{if}
          else ASheet.Range['D'+IntToStr(ARow),'E'+IntToStr(ARow)].Font.Bold := True;
          quResultShiftBlockReport1.Next;
          Inc(ARow);
        end;{while}
      end{if}
      else Inc(ARow);
      quResultShiftBlocks.Next;
    end;{while}
    quResultShiftBlocks.First;
    if ARow=3 then Inc(ARow);
    ARange := ASheet.Range['A1','H'+IntToStr(ARow-1)];
    ASheet.Range['A1','H2'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','H2'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','H2'].WrapText := True;
    ASheet.Range['A1','H1'].Font.Bold := True;
    ASheet.Range['A1','H1'].Merge;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:2'].RowHeight := 37.5;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:D'].ColumnWidth :=  5.0;
    ASheet.Columns['B:B'].ColumnWidth := 20.0;
    ASheet.Columns['C:C'].ColumnWidth :=  8.0;
    ASheet.Columns['E:E'].ColumnWidth := 60.0;
    ASheet.Columns['F:H'].ColumnWidth := 15.0;
    xlDrawPrintSetup(XL,ASheet,False);
  finally
    quResultShiftBlockReport1.EnableControls;
  end;{try}
end;{xlDrawBlocksReport1}
procedure TfmResultShiftBlocks.xlDrawBlocksReport2(XL,ASheet: Variant);
var
  ARange      : Variant;
  ARow        : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'По дорожным покрытиям';
  try
    quResultShiftBlockReport2.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по блок-участкам (по дорожным покрытиям)';
    //Шапка
    ASheet.Range['A2','A2'].Value := '№';
    ASheet.Range['B2','B2'].Value := dbgBlocks2.Columns[0].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgBlocks2.Columns[1].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftBlockReport2.Columns[0].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftBlockReport2.Columns[1].Title.Caption;
    ASheet.Range['F2','F2'].Value := dbgResultShiftBlockReport2.Columns[2].Title.Caption;
    ASheet.Range['G2','G2'].Value := dbgResultShiftBlockReport2.Columns[3].Title.Caption;
    ASheet.Range['H2','H2'].Value := dbgResultShiftBlockReport2.Columns[4].Title.Caption;
    ARow := 3;
    quResultShiftBlockModels.First;
    while not quResultShiftBlockModels.Eof do
    begin
      ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftBlockModels.RecNo;
      ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftBlockModelsRoadCoat.AsString;
      ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftBlockModelsLengthRatio.AsFloat;
      quResultShiftBlockReport2.Last;
      if quResultShiftBlockReport2.RecordCount>0 then
      begin
        quResultShiftBlockReport2.First;
        while not quResultShiftBlockReport2.Eof do
        begin
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftBlockReport2RecordName.AsString;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftBlockReport2Name.AsString;
          if quResultShiftBlockReport2RecordNo.AsInteger mod 100 <> 0 then
          begin
            ASheet.Range['F'+IntToStr(ARow),'F'+IntToStr(ARow)].Value := quResultShiftBlockReport2Value.AsFloat;
            ASheet.Range['G'+IntToStr(ARow),'G'+IntToStr(ARow)].Value := quResultShiftBlockReport2Value1.AsFloat;
            ASheet.Range['H'+IntToStr(ARow),'H'+IntToStr(ARow)].Value := quResultShiftBlockReport2Value2.AsFloat;
          end{if}
          else ASheet.Range['D'+IntToStr(ARow),'E'+IntToStr(ARow)].Font.Bold := True;
          quResultShiftBlockReport2.Next;
          Inc(ARow);
        end;{while}
      end{if}
      else Inc(ARow);
      quResultShiftBlockModels.Next;
    end;{while}
    quResultShiftBlockModels.First;
    if ARow=3 then Inc(ARow);
    ARange := ASheet.Range['A1','H'+IntToStr(ARow-1)];
    ASheet.Range['A1','H2'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','H2'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','H2'].WrapText := True;
    ASheet.Range['A1','H1'].Font.Bold := True;
    ASheet.Range['A1','H1'].Merge;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:2'].RowHeight := 37.5;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:D'].ColumnWidth :=  5.0;
    ASheet.Columns['C:C'].ColumnWidth := 20.0;
    ASheet.Columns['E:E'].ColumnWidth := 60.0;
    ASheet.Columns['F:H'].ColumnWidth := 15.0;
    xlDrawPrintSetup(XL,ASheet,False);
  finally
    quResultShiftBlockReport2.EnableControls;
  end;{try}
end;{xlDrawBlocksReport2}
procedure TfmResultShiftBlocks.xlDrawBlocksReport3(XL,ASheet: Variant);
var
  ARange      : Variant;
  ARow        : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Суммарная информация';
  try
    quResultShiftBlockReport3.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по блок-участкам (суммарная)';
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgResultShiftBlockReport3.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgResultShiftBlockReport3.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgResultShiftBlockReport3.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftBlockReport3.Columns[3].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftBlockReport3.Columns[4].Title.Caption;
    ARow := 3;
    if quResultShiftBlockReport3.RecordCount>0 then
    begin
      quResultShiftBlockReport3.First;
      while not quResultShiftBlockReport3.Eof do
      begin
        ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftBlockReport3RecordName.AsString;
        ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftBlockReport3Name.AsString;
        if quResultShiftBlockReport3RecordNo.AsInteger mod 100 <> 0 then
        begin
          ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftBlockReport3Value.AsFloat;
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftBlockReport3Value1.AsFloat;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftBlockReport3Value2.AsFloat;
          end{if}
          else ASheet.Range['A'+IntToStr(ARow),'B'+IntToStr(ARow)].Font.Bold := True;
        quResultShiftBlockReport3.Next;
        Inc(ARow);
      end;{while}
      quResultShiftBlockReport3.First;
    end
    else
      Inc(ARow);
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
    ASheet.Columns['B:B'].ColumnWidth :=100.0;
    ASheet.Columns['C:E'].ColumnWidth := 15.0;
    xlDrawPrintSetup(XL,ASheet,False);
  finally
    quResultShiftBlockReport3.EnableControls;
  end;
end;
procedure TfmResultShiftBlocks.btExcelClick(Sender: TObject);
var
  XL    : Variant; //Microsoft Excel
  ABook : Variant; //Рабочая книга Excel
begin
  XL := CreateOLEObject('Excel.Application');
  try
    Screen.Cursor := crHourGlass;
    XL.Visible := False;
    ABook := XL.WorkBooks.Add;
    while ABook.Sheets.Count<2 do
      ABook.WorkSheets.Add;
    //Лист 1 -------------------------------------------------------------------
    xlDrawShift(XL,ABook.WorkSheets[1]);
    case PageControl.ActivePageIndex of
      0: xlDrawBlocksReport1(XL,ABook.WorkSheets[2]);
      1: xlDrawBlocksReport2(XL,ABook.WorkSheets[2]);
      2: xlDrawBlocksReport3(XL,ABook.WorkSheets[2]);
    end;{case}
    ABook.WorkSheets[1].Select;
    XL.Visible := True;
  finally
    XL := Unassigned;
    Screen.Cursor := crDefault;
  end;{try}
end;{btExcelClick}

procedure TfmResultShiftBlocks.quResultShiftBlocksCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('Lm').AsFloat := Dataset.FieldByName('Lsm').AsInteger*0.01;
  if quResultShiftBlockLengthsTotalLm.AsFloat<=0.0 then
    Dataset.FieldByName('LengthRatio').Clear
  else
    Dataset.FieldByName('LengthRatio').AsFloat:= 100 * 0.01 * Dataset.FieldByName('Lsm').AsFloat / quResultShiftBlockLengthsTotalLm.AsFloat;
end;


procedure TfmResultShiftBlocks.dbgResultShiftBlockReport1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.Dataset.FieldByName('RecordNo').AsInteger mod 100 = 0 then
    TDBGridEh(Sender).Canvas.Font.Style := [fsBold];
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmResultShiftBlocks.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;{btShiftClick}

 
procedure TfmResultShiftBlocks.btPowerConsumingClick(Sender: TObject);
begin
  fmResultBlocksPowerConsuming := TfmResultBlocksPowerConsuming.Create(nil);
  try
    fmResultBlocksPowerConsuming.HelpKeyword := HelpKeyword;
    fmResultBlocksPowerConsuming.Width := Width;
    fmResultBlocksPowerConsuming.Height := Height;
    fmResultBlocksPowerConsuming.ShowModal;
  finally
    fmResultBlocksPowerConsuming.Free;
  end;{try}
end;  {btPowerConsumingClick}

procedure TfmResultShiftBlocks.btRoadFunctionClick(Sender: TObject);
begin
  fmResultBlocksFunctioning := TfmResultBlocksFunctioning.Create(nil);
  try
    fmResultBlocksFunctioning.HelpKeyword := HelpKeyword;
    fmResultBlocksFunctioning.Width := Width;
    fmResultBlocksFunctioning.Height := Height;
    fmResultBlocksFunctioning.ShowModal;
  finally
    fmResultBlocksFunctioning.Free;
  end;{try}
end; {btPowerConsumingClick}

end.

