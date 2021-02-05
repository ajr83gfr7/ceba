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
    quResultEconomReportsValue3: TFloatField;
    btExcel: TButton;
    btShift: TButton;
    sgData: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure quResultEconomReportsCalcFields(DataSet: TDataSet);
    procedure btDistributionClick(Sender: TObject);
    procedure cbMeasureChange(Sender: TObject);
    procedure dbgResultEconomReportsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure sgView();
    procedure fetchData();
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

procedure TfmResultEconomParams.FormShow(Sender: TObject);
begin
  sgView();
  fetchData();
end;

procedure TfmResultEconomParams.sgView;
var
  form_width: integer;
  number_col, data_cols, param_col, value_col: integer;
begin
  form_width:= sgData.Width;
  number_col:= 25;
  data_cols:= form_width - 25;
  param_col:= ROUND(data_cols * 0.5);
  value_col:= ROUND((data_cols - param_col - 20) / 3);

  sgData.ColWidths[0]:= number_col;
  sgData.ColWidths[1]:= param_col;
  sgData.ColWidths[2]:= value_col;
  sgData.ColWidths[3]:= value_col;
  sgData.ColWidths[4]:= value_col;

  sgData.RowCount:= 28;
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
    //todo: amortzation
    if Dataset.FieldByName('IsChangeable').AsBoolean then
    begin
      // set value 2
      if (Dataset.FieldByName('RecordNo').AsInteger <> 103) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 203) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 403) and
//         (Dataset.FieldByName('RecordNo').AsInteger <> 301) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 302)then
        val2:= AValue * _shiftKweek
      else
        val2:= AValue;

      // set value 3
      if (Dataset.FieldByName('RecordNo').AsInteger <> 103) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 203) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 403) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 301) and
         (Dataset.FieldByName('RecordNo').AsInteger <> 302)then
        val3:= AValue * _periodKshift
      else
        if (Dataset.FieldByName('RecordNo').AsInteger = 103) or
           (Dataset.FieldByName('RecordNo').AsInteger = 203) or
           (Dataset.FieldByName('RecordNo').AsInteger = 403) or
           (Dataset.FieldByName('RecordNo').AsInteger = 301) or
           (Dataset.FieldByName('RecordNo').AsInteger = 302) then
          val3:= AValue * _shiftKweek * 2 * 365
        else
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

procedure TfmResultEconomParams.fetchData;
var
  _shiftKweek, _periodKshift: double;

  _cost_auto_work_value: double;
  _cost_auto_wait_value: double;
  _cost_auto_amort_value: double;
  _cost_auto_sum_value: double;
  _cost_auto_sum_avg_value: double;
  _cost_auto_sum_period_value: double;

  _cost_excv_work_value: double;
  _cost_excv_wait_value: double;
  _cost_excv_amort_value: double;
  _cost_excv_sum_value: double;
  _cost_excv_sum_avg_value: double;
  _cost_excv_sum_period_value: double;

  _cost_block_support_value: double;
  _cost_block_amort_value: double;
  _cost_block_sum_value: double;
  _cost_block_sum_avg_value: double;
  _cost_block_sum_period_value: double;

  _cost_GTK_total: double;
  _cost_GTK_avg_total: double;
  _cost_GTK_period_total: double;
  _cost_expluatation: double;
  _cost_amortization: double;
  _cost_addition: double;
  _cost_productivity_m3: double;
  _cost_productivity_tn: double;

  _cost_expluatation_per_week,
  _cost_amortization_per_week,
  _cost_addition_per_week,
  _cost_expluatation_per_period,
  _cost_amortization_per_period,
  _cost_addition_per_period: double;
begin
  _shiftKweek:= quResultShiftsShiftKweek.AsFloat;
  _periodKshift:= quResultShiftsPeriodKshift.AsFloat;
  while not (quResultEconomReports.Eof) do
  begin
    case quResultEconomReports.FieldByName('RecordNo').AsInteger of
      100: begin
        sgData.Cells[0,1]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,1]:= quResultEconomReports.FieldByName('Name').AsString;
      end;
      101: begin
        sgData.Cells[0,2]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,2]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_auto_work_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,2]:= floattostr(_cost_auto_work_value);
        sgData.Cells[3,2]:= floattostr(_cost_auto_work_value * _shiftKweek);
        sgData.Cells[4,2]:= floattostr(_cost_auto_work_value * _periodKshift);
      end;
      102: begin
        sgData.Cells[0,3]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,3]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_auto_wait_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,3]:= floattostr(_cost_auto_wait_value);
        sgData.Cells[3,3]:= floattostr(_cost_auto_wait_value * _shiftKweek);
        sgData.Cells[4,3]:= floattostr(_cost_auto_wait_value * _periodKshift);
      end;
      103: begin
        sgData.Cells[0,4]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,4]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_auto_amort_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,4]:= floattostr(_cost_auto_amort_value);
        sgData.Cells[3,4]:= floattostr(_cost_auto_amort_value);
        sgData.Cells[4,4]:= floattostr(_cost_auto_amort_value * _periodKshift);
      end;
      104: begin
        sgData.Cells[0,5]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,5]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_auto_sum_value:= _cost_auto_work_value + _cost_auto_wait_value + _cost_auto_amort_value;
        sgData.Cells[2,5]:= floattostr(_cost_auto_sum_value);
        _cost_auto_sum_avg_value:= _cost_auto_work_value * _shiftKweek +
                                   _cost_auto_wait_value * _shiftKweek +
                                   _cost_auto_amort_value;
        sgData.Cells[3,5]:= floattostr(_cost_auto_sum_avg_value);
        _cost_auto_sum_period_value:= _cost_auto_work_value * _periodKshift +
                                      _cost_auto_wait_value * _periodKshift +
                                      _cost_auto_amort_value * _periodKshift;
        sgData.Cells[4,5]:= floattostr(_cost_auto_sum_period_value);
      end;

      200: begin
        sgData.Cells[0,6]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,6]:= quResultEconomReports.FieldByName('Name').AsString;
      end;
      201: begin
        sgData.Cells[0,7]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,7]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_excv_work_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,7]:= floattostr(_cost_excv_work_value);
        sgData.Cells[3,7]:= floattostr(_cost_excv_work_value * _shiftKweek);
        sgData.Cells[4,7]:= floattostr(_cost_excv_work_value * _periodKshift);
      end;
      202: begin
        sgData.Cells[0,8]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,8]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_excv_wait_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,8]:= floattostr(_cost_excv_wait_value);
        sgData.Cells[3,8]:= floattostr(_cost_excv_wait_value * _shiftKweek);
        sgData.Cells[4,8]:= floattostr(_cost_excv_wait_value * _periodKshift);
      end;
      203: begin
        sgData.Cells[0,9]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,9]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_excv_amort_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,9]:= floattostr(_cost_excv_amort_value);
        sgData.Cells[3,9]:= floattostr(_cost_excv_amort_value);
        sgData.Cells[4,9]:= floattostr(_cost_excv_amort_value * _periodKshift);
      end;
      204: begin
        sgData.Cells[0,10]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,10]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_excv_sum_value:= _cost_excv_work_value + _cost_excv_wait_value + _cost_excv_amort_value;
        sgData.Cells[2,10]:= floattostr(_cost_excv_sum_value);
        _cost_excv_sum_avg_value:= _cost_excv_work_value * _shiftKweek +
                                   _cost_excv_wait_value * _shiftKweek +
                                   _cost_excv_amort_value;
        sgData.Cells[3,10]:= floattostr(_cost_excv_sum_avg_value);
        _cost_excv_sum_period_value:= _cost_excv_work_value * _periodKshift +
                                      _cost_excv_wait_value * _periodKshift +
                                      _cost_excv_amort_value * _periodKshift;
        sgData.Cells[4,10]:= floattostr(_cost_excv_sum_period_value);
      end;

      300: begin
        sgData.Cells[0,11]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,11]:= quResultEconomReports.FieldByName('Name').AsString;
      end;
      301: begin
        sgData.Cells[0,12]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,12]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_block_support_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,12]:= floattostr(_cost_block_support_value);
        sgData.Cells[3,12]:= floattostr(_cost_block_support_value * _shiftKweek);
        sgData.Cells[4,12]:= floattostr(_cost_block_support_value * _periodKshift);
      end;
      302: begin
        sgData.Cells[0,13]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,13]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_block_amort_value:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,13]:= floattostr(_cost_block_amort_value);
        sgData.Cells[3,13]:= floattostr(_cost_block_amort_value);
        sgData.Cells[4,13]:= floattostr(_cost_block_amort_value * _periodKshift);
      end;
      303: begin
        sgData.Cells[0,14]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,14]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_block_sum_value:= _cost_block_support_value + _cost_block_amort_value;
        sgData.Cells[2,14]:= floattostr(_cost_block_sum_value);
        _cost_block_sum_avg_value:= _cost_block_support_value * _shiftKweek +
                                    _cost_block_amort_value;
        sgData.Cells[3,14]:= floattostr(_cost_block_sum_avg_value);
        _cost_block_sum_period_value:= _cost_block_support_value * _periodKshift +
                                      _cost_block_amort_value * _periodKshift;
        sgData.Cells[4,14]:= floattostr(_cost_block_sum_period_value);
      end;

      400: begin
        sgData.Cells[0,15]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,15]:= quResultEconomReports.FieldByName('Name').AsString;
      end;
      401: begin
        sgData.Cells[0,16]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,16]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_GTK_total:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,16]:= floattostr(_cost_GTK_total);
        _cost_GTK_avg_total:= _cost_expluatation_per_week +
                              _cost_amortization_per_week +
                              _cost_addition_per_week;
        sgData.Cells[3,16]:= floattostr(_cost_GTK_avg_total);
        _cost_GTK_period_total:= _cost_expluatation_per_period +
                                 _cost_amortization_per_period +
                                 _cost_addition_per_period;
        sgData.Cells[4,16]:= floattostr(_cost_GTK_period_total);
      end;
      402: begin
        sgData.Cells[0,17]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,17]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_expluatation:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,17]:= floattostr(_cost_expluatation);
        _cost_expluatation_per_week:= _cost_expluatation * _shiftKweek;
        sgData.Cells[3,17]:= floattostr(_cost_expluatation_per_week);
        _cost_expluatation_per_period:= _cost_expluatation * _periodKshift;
        sgData.Cells[4,17]:= floattostr(_cost_expluatation_per_period);
      end;
      403: begin
        sgData.Cells[0,18]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,18]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_amortization:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,18]:= floattostr(_cost_amortization);
        _cost_amortization_per_week:= _cost_amortization;
        sgData.Cells[3,18]:= floattostr(_cost_amortization);
        _cost_amortization_per_period:= _cost_amortization * _periodKshift;
        sgData.Cells[4,18]:= floattostr(_cost_amortization * _periodKshift);
      end;
      404: begin
        sgData.Cells[0,19]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,19]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_addition:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,19]:= floattostr(_cost_addition);
        _cost_addition_per_week:= _cost_addition * _shiftKweek;
        sgData.Cells[3,19]:= floattostr(_cost_addition_per_week);
        _cost_addition_per_period:= _cost_addition * _periodKshift;
        sgData.Cells[4,19]:= floattostr(_cost_addition_per_period);
      end;
      405: begin
        sgData.Cells[0,20]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,20]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,20]:= floattostr(_cost_productivity_m3);
        sgData.Cells[3,20]:= floattostr(_cost_productivity_m3 * _shiftKweek);
        sgData.Cells[4,20]:= floattostr(_cost_productivity_m3 * _periodKshift);
      end;
      406: begin
        sgData.Cells[0,21]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,21]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_tn:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,21]:= floattostr(_cost_productivity_tn);
        sgData.Cells[3,21]:= floattostr(_cost_productivity_tn * _shiftKweek);
        sgData.Cells[4,21]:= floattostr(_cost_productivity_tn * _periodKshift);
      end;
      407: begin
        sgData.Cells[0,22]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,22]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,22]:= floattostr(_cost_productivity_m3);
        sgData.Cells[3,22]:= floattostr(_cost_productivity_m3 * _shiftKweek);
        sgData.Cells[4,22]:= floattostr(_cost_productivity_m3 * _periodKshift);
      end;
      408: begin
        sgData.Cells[0,23]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,23]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,23]:= floattostr(_cost_productivity_m3);
        sgData.Cells[3,23]:= floattostr(_cost_productivity_m3 * _shiftKweek);
        sgData.Cells[4,23]:= floattostr(_cost_productivity_m3 * _periodKshift);
      end;
      409: begin
        sgData.Cells[0,24]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,24]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,24]:= floattostr(_cost_productivity_m3);
        sgData.Cells[3,24]:= floattostr(_cost_productivity_m3 * _shiftKweek);
        sgData.Cells[4,24]:= floattostr(_cost_productivity_m3 * _periodKshift);
      end;
      410: begin
        sgData.Cells[0,25]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,25]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,25]:= floattostr(_cost_productivity_m3);
        sgData.Cells[3,25]:= floattostr(_cost_productivity_m3 * _shiftKweek);
        sgData.Cells[4,25]:= floattostr(_cost_productivity_m3 * _periodKshift);
      end;
      411: begin
        sgData.Cells[0,26]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,26]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,26]:= floattostr(_cost_GTK_total * 1000 / _cost_productivity_m3);
        sgData.Cells[3,26]:= floattostr(_cost_GTK_avg_total * 1000 / (_cost_productivity_m3 * _shiftKweek));
        sgData.Cells[4,26]:= floattostr(_cost_GTK_period_total * 1000 / (_cost_productivity_m3 * _periodKshift));
      end;
      412: begin
        sgData.Cells[0,27]:= quResultEconomReports.FieldByName('RecordName').AsString;
        sgData.Cells[1,27]:= quResultEconomReports.FieldByName('Name').AsString;
        _cost_productivity_m3:= quResultEconomReports.FieldByName('Value').AsFloat;
        sgData.Cells[2,27]:= floattostr(_cost_GTK_total * 1000 / _cost_productivity_tn);
        sgData.Cells[3,27]:= floattostr(_cost_GTK_avg_total * 1000 / (_cost_productivity_tn * _shiftKweek));
        sgData.Cells[4,27]:= floattostr(_cost_GTK_period_total * 1000 / (_cost_productivity_tn * _periodKshift));
      end;
    end;
    quResultEconomReports.Next;
  end;

  begin
    sgData.Cells[2,16]:= floattostr(_cost_GTK_total);
    _cost_GTK_avg_total:= _cost_expluatation_per_week +
                          _cost_amortization_per_week +
                          _cost_addition_per_week;
    sgData.Cells[3,16]:= floattostr(_cost_GTK_avg_total);
    _cost_GTK_period_total:= _cost_expluatation_per_period +
                             _cost_amortization_per_period +
                             _cost_addition_per_period;
    sgData.Cells[4,16]:= floattostr(_cost_GTK_period_total);

    sgData.Cells[2,26]:= floattostr(_cost_GTK_total * 1000 / _cost_productivity_m3);
    sgData.Cells[3,26]:= floattostr(_cost_GTK_avg_total * 1000 / (_cost_productivity_m3 * _shiftKweek));
    sgData.Cells[4,26]:= floattostr(_cost_GTK_period_total * 1000 / (_cost_productivity_m3 * _periodKshift));

    sgData.Cells[2,27]:= floattostr(_cost_GTK_total * 1000 / _cost_productivity_tn);
    sgData.Cells[3,27]:= floattostr(_cost_GTK_avg_total * 1000 / (_cost_productivity_tn * _shiftKweek));
    sgData.Cells[4,27]:= floattostr(_cost_GTK_period_total * 1000 / (_cost_productivity_tn * _periodKshift));
  end;

end;

end.
