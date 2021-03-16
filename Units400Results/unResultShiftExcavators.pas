unit unResultShiftExcavators;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, DBLookupEh, DB, ADODB,
  Grids, DBGridEh, DBSumLst, ComCtrls, Excel2000;//, GridsEh;

type
  TfmResultShiftExcavators = class(TForm)
    quResultShifts: TADOQuery;
    quResultShiftsId_ResultShift: TAutoIncField;
    quResultShiftsId_Openpit: TIntegerField;
    quResultShiftsShiftNaryadTmin: TFloatField;
    quResultShiftsShiftTmin: TIntegerField;
    quResultShiftsPeriodKshift: TFloatField;
    quResultShiftsPeriodTday: TIntegerField;
    dsResultShifts: TDataSource;
    pnBtns: TPanel;
    quResultShiftExcavators: TADOQuery;
    dsResultShiftExcavators: TDataSource;
    quResultShiftExcavatorReport1: TADOQuery;
    dsResultShiftExcavatorReport1: TDataSource;
    PageControl: TPageControl;
    tsResultShiftExcavatorsReport1: TTabSheet;
    dbgResultShiftExcavatorReport1: TDBGridEh;
    tsResultShiftExcavatorsReport2: TTabSheet;
    tsResultShiftExcavatorsReport3: TTabSheet;
    quResultShiftExcavatorReport1RecordNo: TIntegerField;
    quResultShiftExcavatorReport1Value: TFloatField;
    quResultShiftExcavatorReport1Name: TStringField;
    quResultShiftExcavatorReport1Value1: TFloatField;
    quResultShiftExcavatorReport1Value2: TFloatField;
    Splitter1: TSplitter;
    quResultShiftsShiftPeresmenkaTmin: TIntegerField;
    quResultShiftsShiftPlanNaryadTmin: TFloatField;
    quResultShiftsShiftKweek: TFloatField;
    quResultShiftExcavatorModels: TADOQuery;
    dsResultShiftExcavatorModels: TDataSource;
    quResultShiftExcavatorModelsId_DumpModel: TIntegerField;
    quResultShiftExcavatorModelsDumpModel: TWideStringField;
    dbgExcavators2: TDBGridEh;
    Splitter2: TSplitter;
    dbgResultShiftExcavatorReport2: TDBGridEh;
    quResultShiftExcavatorReport2: TADOQuery;
    dsResultShiftExcavatorReport2: TDataSource;
    quResultShiftExcavatorReport2Id_DumpModel: TIntegerField;
    quResultShiftExcavatorReport2DumpModel: TWideStringField;
    quResultShiftExcavatorReport2Value: TFloatField;
    quResultShiftExcavatorReport2Value1: TFloatField;
    quResultShiftExcavatorReport2Value2: TFloatField;
    quResultShiftExcavatorReport3: TADOQuery;
    dsResultShiftExcavatorReport3: TDataSource;
    quResultShiftExcavatorReport3Id_ResultShift: TIntegerField;
    quResultShiftExcavatorReport3Id_DumpModel: TIntegerField;
    quResultShiftExcavatorReport3DumpModel: TWideStringField;
    quResultShiftExcavatorReport3Kind: TWordField;
    quResultShiftExcavatorReport3Value: TFloatField;
    quResultShiftExcavatorReport3Value1: TFloatField;
    quResultShiftExcavatorReport3Value2: TFloatField;
    dbgResultShiftExcavatorReport3: TDBGridEh;
    btClose: TButton;
    btExcel: TButton;
    quResultShiftExcavatorsId_ResultShiftExcavator: TAutoIncField;
    quResultShiftExcavatorsId_ResultShift: TIntegerField;
    quResultShiftExcavatorsId_DumpModel: TIntegerField;
    quResultShiftExcavatorsDumpModel: TWideStringField;
    quResultShiftExcavatorsDumpMaxNkVt: TFloatField;
    quResultShiftExcavatorsDumpNo: TIntegerField;
    quResultShiftExcavatorsDumpYear: TIntegerField;
    quResultShiftExcavatorsDumpTsec: TFloatField;
    quResultShiftExcavatorsDumpMaxVm3: TFloatField;
    quResultShiftExcavatorsDumpC1000tg: TFloatField;
    quResultShiftExcavatorsDumpEngineKIM: TFloatField;
    quResultShiftExcavatorsDumpEngineKPD: TFloatField;
    quResultShiftExcavatorsDumpMaterialsMonthC1000tg: TFloatField;
    quResultShiftExcavatorsDumpUnAccountedMonthC1000tg: TFloatField;
    quResultShiftExcavatorsId_LoadingPunkt: TAutoIncField;
    quResultShiftExcavatorsHorizont: TFloatField;
    dbgExcavators1: TDBGridEh;
    quResultShiftExcavatorReport1Id_ResultShiftExcavatorReport: TAutoIncField;
    quResultShiftExcavatorReport1Id_ResultShift: TIntegerField;
    quResultShiftExcavatorReport1Id_ResultShiftExcavator: TIntegerField;
    quResultShiftExcavatorReport1Id_DumpModel: TIntegerField;
    quResultShiftExcavatorReport1DumpModel: TWideStringField;
    quResultShiftExcavatorReport1Kind: TWordField;
    quResultShiftExcavatorReport2Id_ResultShiftExcavatorReport: TAutoIncField;
    quResultShiftExcavatorReport2Id_ResultShift: TIntegerField;
    quResultShiftExcavatorReport2Id_ResultShiftExcavator: TIntegerField;
    quResultShiftExcavatorReport2Kind: TWordField;
    quResultShiftExcavatorReport3Id_ResultShiftExcavatorReport: TAutoIncField;
    quResultShiftExcavatorReport3Id_ResultShiftExcavator: TIntegerField;
    quResultShiftExcavatorReport1IsChangeable: TBooleanField;
    quResultShiftExcavatorReport1RecordName: TWideStringField;
    quResultShiftExcavatorReport2IsChangeable: TBooleanField;
    quResultShiftExcavatorReport2RecordNo: TIntegerField;
    quResultShiftExcavatorReport2RecordName: TWideStringField;
    quResultShiftExcavatorReport2Name: TWideStringField;
    quResultShiftExcavatorReport3IsChangeable: TBooleanField;
    quResultShiftExcavatorReport3RecordNo: TIntegerField;
    quResultShiftExcavatorReport3RecordName: TWideStringField;
    quResultShiftExcavatorReport3Name: TWideStringField;
    quResultShiftsDollarCtg: TFloatField;
    quResultShiftExcavatorsDumpWorkState: TBooleanField;
    btShift: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftExcavatorEventsKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftExcavatorReport1CalcFields(DataSet: TDataSet);
    procedure quResultShiftExcavatorReport1ValueGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftExcavatorsHorizontGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure btExcelClick(Sender: TObject);
    procedure dbgResultShiftExcavatorReport1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
  private
  public
    procedure xlDrawPrintSetup(XL,ASheet: Variant; const AIsPortrait: Boolean);
    procedure xlDrawShift(XL,ASheet: Variant);
    procedure xlDrawExcavatorsReport1(XL,ASheet: Variant);
    procedure xlDrawExcavatorsReport2(XL,ASheet: Variant);
    procedure xlDrawExcavatorsReport3(XL,ASheet: Variant);
  public
  end;{TfmResultShiftExcavators}

var
  fmResultShiftExcavators: TfmResultShiftExcavators;

//Диалоговое окно результатов моделирования по экскаваторам
procedure esaShowResultShiftExcavatorsDlg();
implementation

uses unDM, ComObj, Math, unResultShift;

{$R *.dfm}

const
  cNo             = 0;
  
//Диалоговое окно результатов моделирования по экскаваторам
procedure esaShowResultShiftExcavatorsDlg();
begin
  fmResultShiftExcavators := TfmResultShiftExcavators.Create(nil);
  try
    fmResultShiftExcavators.ShowModal;
  finally
    fmResultShiftExcavators.Free;
  end;{try}
end;{esaShowResultShiftExcavatorsDlg}
procedure TfmResultShiftExcavators.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  quResultShifts.Open;
  quResultShiftExcavators.Open;
  quResultShiftExcavatorModels.Open;
  quResultShiftExcavatorReport1.Open;
  quResultShiftExcavatorReport2.Open;
  quResultShiftExcavatorReport3.Open;
end;{FormCreate}

procedure TfmResultShiftExcavators.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultShiftExcavatorReport3.Close;
  quResultShiftExcavatorReport2.Close;
  quResultShiftExcavatorReport1.Close;
  quResultShiftExcavatorModels.Close;
  quResultShiftExcavators.Close;
  quResultShifts.Close;
end;{FormClose}


procedure TfmResultShiftExcavators.quResultShiftExcavatorEventsKindGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  case Sender.AsInteger of
    1: Text := 'Погрузка';
    2: Text := 'Простой';
    3: Text := 'Маневры';
  end;{case}
end;{quResultShiftExcavatorEventsKindGetText}
procedure TfmResultShiftExcavators.quResultShiftExcavatorReport1CalcFields(DataSet: TDataSet);
const
  SUM_COSTS_OF_EXCVS = 'SELECT ' +
                       ' WorkValue.Value as WorkCost, ' +
                       ' WaitValue.Value as WaitCost, ' +
                       ' AmorValue.Value as AmorCost ' +
                       'FROM ' +
                       ' (SELECT Value FROM _ResultShiftExcavatorReports WHERE Kind=3 AND RecordNo=401) as WorkValue, ' +
                       ' (SELECT Value FROM _ResultShiftExcavatorReports WHERE Kind=3 AND RecordNo=406) as WaitValue, ' +
                       ' (SELECT Value FROM _ResultShiftExcavatorReports WHERE Kind=3 AND RecordNo=411) as AmorValue';
var
  _value: double;
  _shiftKweek, _periodKshift: double;
  //
  _qry: TADOQuery;
  _WorkCost, _WaitCost, _AmorCost: double;
  _WorkCost_avg, _WaitCost_avg, _AmorCost_avg: double;
  _WorkCost_period, _WaitCost_period, _AmorCost_period: double;
  _Cost_sum, _Cost_arg_sum, _Cost_period_sum: double;
begin
  if not(Dataset.FieldByName('Value').IsNull) then
  begin
    _value:= Dataset.FieldByName('Value').AsFloat;
    _shiftKweek:= quResultShiftsShiftKweek.AsFloat;
    _periodKshift:= quResultShiftsPeriodKshift.AsFloat;
    if Dataset.FieldByName('IsChangeable').AsBoolean then
    begin
      if (Dataset.FieldByName('RecordNo').AsInteger = 411) then
      begin
        Dataset.FieldByName('Value1').AsFloat:= _value;
        Dataset.FieldByName('Value2').AsFloat := _value * 2 * 365;
      end
      else if (Dataset.FieldByName('RecordNo').AsInteger = 412) then
      begin
        _qry:= TADOQuery.Create(nil);
        _qry.Connection:= fmDM.ADOConnection;
        _qry.SQL.Text:= SUM_COSTS_OF_EXCVS;
        _qry.Open;
        try
          _WorkCost:= _qry.FieldByName('WorkCost').AsFloat;
          _WaitCost:= _qry.FieldByName('WaitCost').AsFloat;
          _AmorCost:= _qry.FieldByName('AmorCost').AsFloat;
          //
          _WorkCost_avg:= _WorkCost * _shiftKweek;
          _WaitCost_avg:= _WaitCost * _shiftKweek;
          _AmorCost_avg:= _AmorCost;
          //
          _WorkCost_period:= _WorkCost * _periodKshift;
          _WaitCost_period:= _WaitCost * _periodKshift;
          _AmorCost_period:= _AmorCost * 2 * 365;
          //
          _Cost_sum:= _WorkCost + _WaitCost + _AmorCost;
          _Cost_arg_sum:= _WorkCost_avg + _WaitCost_avg + _AmorCost_avg;
          _Cost_period_sum:= _WorkCost_period + _WaitCost_period + _AmorCost_period;
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
        Dataset.FieldByName('Value2').AsFloat := _value * _periodKshift;
      end;
    end
    else
    begin
      Dataset.FieldByName('Value1').AsFloat := _value * 1.0;
      Dataset.FieldByName('Value2').AsFloat := _value * 1.0;
    end;
  end;
//begin
//  if not(Dataset.FieldByName('Value').IsNull) then
//  if Dataset.FieldByName('IsChangeable').AsBoolean then
//  begin
//    Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('Value').AsFloat*quResultShiftsShiftKweek.AsFloat;
//    Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('Value').AsFloat*quResultShiftsPeriodKshift.AsFloat;
//  end{if}
//  else
//  begin
//    Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('Value').AsFloat*1.0;
//    Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('Value').AsFloat*1.0;
//  end;{else}
end;{quResultShiftExcavatorReport1CalcFields}
procedure TfmResultShiftExcavators.quResultShiftExcavatorReport1ValueGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then Text := ''
  else
  if Sender.AsFloat>0.0
  then Text := FormatFloat('# ### ### ##0.00',Sender.AsFloat)
  else Text := '-';
end;{quResultShiftExcavatorReport1ResultGetText}


procedure TfmResultShiftExcavators.quResultShiftExcavatorsHorizontGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then Text := '' else
    if Sender.AsFloat<0 then Text := Sender.AsString else Text := '+'+Sender.AsString;
end;{quResultShiftExcavatorsHorizontGetText}

procedure TfmResultShiftExcavators.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;{quResultShiftsCalcFields}

procedure TfmResultShiftExcavators.xlDrawPrintSetup(XL,ASheet: Variant; const AIsPortrait: Boolean);
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
procedure TfmResultShiftExcavators.xlDrawShift(XL,ASheet: Variant);
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
procedure TfmResultShiftExcavators.xlDrawExcavatorsReport1(XL,ASheet: Variant);
var
  ARange: Variant;
  ARow  : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Детальная информация';
  try
    quResultShiftExcavatorReport1.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по экскаваторам (детальная)';
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgExcavators1.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgExcavators1.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgExcavators1.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftExcavatorReport1.Columns[0].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftExcavatorReport1.Columns[1].Title.Caption;
    ASheet.Range['F2','F2'].Value := dbgResultShiftExcavatorReport1.Columns[2].Title.Caption;
    ASheet.Range['G2','G2'].Value := dbgResultShiftExcavatorReport1.Columns[3].Title.Caption;
    ASheet.Range['H2','H2'].Value := dbgResultShiftExcavatorReport1.Columns[4].Title.Caption;
    ARow := 3;
    quResultShiftExcavators.First;
    while not quResultShiftExcavators.Eof do
    begin
      ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftExcavatorsId_ResultShiftExcavator.AsInteger;
      ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftExcavatorsDumpModel.AsString;
      ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftExcavatorsDumpNo.AsInteger;
      quResultShiftExcavatorReport1.Last;
      if quResultShiftExcavatorReport1.RecordCount>0 then
      begin
        quResultShiftExcavatorReport1.First;
        while not quResultShiftExcavatorReport1.Eof do
        begin
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftExcavatorReport1RecordName.AsString;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftExcavatorReport1Name.AsString;
          if quResultShiftExcavatorReport1RecordNo.AsInteger mod 100 <> 0 then
          begin
            ASheet.Range['F'+IntToStr(ARow),'F'+IntToStr(ARow)].Value := quResultShiftExcavatorReport1Value.AsFloat;
            ASheet.Range['G'+IntToStr(ARow),'G'+IntToStr(ARow)].Value := quResultShiftExcavatorReport1Value1.AsFloat;
            ASheet.Range['H'+IntToStr(ARow),'H'+IntToStr(ARow)].Value := quResultShiftExcavatorReport1Value2.AsFloat;
          end{if}
          else ASheet.Range['D'+IntToStr(ARow),'E'+IntToStr(ARow)].Font.Bold := True;
          quResultShiftExcavatorReport1.Next;
          Inc(ARow);
        end;{while}
      end{if}
      else Inc(ARow);
      quResultShiftExcavators.Next;
    end;{while}
    quResultShiftExcavators.First;
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
    quResultShiftExcavatorReport1.EnableControls;
  end;{try}
end;{xlDrawExcavatorsReport1}
procedure TfmResultShiftExcavators.xlDrawExcavatorsReport2(XL,ASheet: Variant);
var
  ARange      : Variant;
  ARow        : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'По моделям экскаваторов';
  try
    quResultShiftExcavatorReport2.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по экскаваторам (по моделям)';
    //Шапка
    ASheet.Range['A2','A2'].Value := '№';
    ASheet.Range['B2','B2'].Value := dbgExcavators2.Columns[0].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgExcavators2.Columns[1].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftExcavatorReport2.Columns[0].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftExcavatorReport2.Columns[1].Title.Caption;
    ASheet.Range['F2','F2'].Value := dbgResultShiftExcavatorReport2.Columns[2].Title.Caption;
    ASheet.Range['G2','G2'].Value := dbgResultShiftExcavatorReport2.Columns[3].Title.Caption;
    ASheet.Range['H2','H2'].Value := dbgResultShiftExcavatorReport2.Columns[4].Title.Caption;
    ARow := 3;
    quResultShiftExcavatorModels.First;
    while not quResultShiftExcavatorModels.Eof do
    begin
      ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftExcavatorModels.RecNo;
      ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftExcavatorModelsId_DumpModel.AsInteger;
      ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftExcavatorModelsDumpModel.AsString;
      quResultShiftExcavatorReport2.Last;
      if quResultShiftExcavatorReport2.RecordCount>0 then
      begin
        quResultShiftExcavatorReport2.First;
        while not quResultShiftExcavatorReport2.Eof do
        begin
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftExcavatorReport2RecordName.AsString;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftExcavatorReport2Name.AsString;
          if quResultShiftExcavatorReport2RecordNo.AsInteger mod 100 <> 0 then
          begin
            ASheet.Range['F'+IntToStr(ARow),'F'+IntToStr(ARow)].Value := quResultShiftExcavatorReport2Value.AsFloat;
            ASheet.Range['G'+IntToStr(ARow),'G'+IntToStr(ARow)].Value := quResultShiftExcavatorReport2Value1.AsFloat;
            ASheet.Range['H'+IntToStr(ARow),'H'+IntToStr(ARow)].Value := quResultShiftExcavatorReport2Value2.AsFloat;
          end{if}
          else ASheet.Range['D'+IntToStr(ARow),'E'+IntToStr(ARow)].Font.Bold := True;
          quResultShiftExcavatorReport2.Next;
          Inc(ARow);
        end;{while}
      end{if}
      else Inc(ARow);
      quResultShiftExcavatorModels.Next;
    end;{while}
    quResultShiftExcavatorModels.First;
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
    quResultShiftExcavatorReport2.EnableControls;
  end;{try}
end;{xlDrawExcavatorsReport2}
procedure TfmResultShiftExcavators.xlDrawExcavatorsReport3(XL,ASheet: Variant);
var
  ARange      : Variant;
  ARow        : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Суммарная информация';
  try
    quResultShiftExcavatorReport3.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по экскаваторам (суммарная)';
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgResultShiftExcavatorReport3.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgResultShiftExcavatorReport3.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgResultShiftExcavatorReport3.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftExcavatorReport3.Columns[3].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftExcavatorReport3.Columns[4].Title.Caption;
    ARow := 3;
    if quResultShiftExcavatorReport3.RecordCount>0 then
    begin
      quResultShiftExcavatorReport3.First;
      while not quResultShiftExcavatorReport3.Eof do
      begin
        ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftExcavatorReport3RecordName.AsString;
        ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftExcavatorReport3Name.AsString;
        if quResultShiftExcavatorReport3RecordNo.AsInteger mod 100 <> 0 then
        begin
          ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftExcavatorReport3Value.AsFloat;
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftExcavatorReport3Value1.AsFloat;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftExcavatorReport3Value2.AsFloat;
          end{if}
          else ASheet.Range['A'+IntToStr(ARow),'B'+IntToStr(ARow)].Font.Bold := True;
        quResultShiftExcavatorReport3.Next;
        Inc(ARow);
      end;{while}
      quResultShiftExcavatorReport3.First;
    end{if}
    else Inc(ARow);
    if ARow=3 then Inc(ARow);
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
    quResultShiftExcavatorReport3.EnableControls;
  end;{try}
end;{xlDrawExcavatorsReport3}
procedure TfmResultShiftExcavators.btExcelClick(Sender: TObject);
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
      0: xlDrawExcavatorsReport1(XL,ABook.WorkSheets[2]);
      1: xlDrawExcavatorsReport2(XL,ABook.WorkSheets[2]);
      2: xlDrawExcavatorsReport3(XL,ABook.WorkSheets[2]);
    end;{case}
    ABook.WorkSheets[1].Select;
    XL.Visible := True;
  finally
    XL := Unassigned;
    Screen.Cursor := crDefault;
  end;{try}
end;{btExcelClick}

procedure TfmResultShiftExcavators.dbgResultShiftExcavatorReport1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.Dataset.FieldByName('RecordNo').AsInteger mod 100 = 0
  then TDBGridEh(Sender).Canvas.Font.Style := [fsBold];
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;{dbgResultShiftExcavatorReport1DrawColumnCell}

procedure TfmResultShiftExcavators.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;{btShiftClick}

end.

