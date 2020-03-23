unit unResultShiftProductionCapacities;

interface
{ TODO -oСулеймен -c18/09/2007 : 4. Переделать fmResultShiftProductionCapacities в соотстветствие с  ResultEconomParams }
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, DbChart,
  Mask, DBCtrls, DB, ADODB, Grids, DBGrids, DBGridEh, ComCtrls, TeeFunci;

type
  TfmResultShiftProductionCapacities = class(TForm)
    pnBtns: TPanel;
    btExcel: TButton;
    btCancel: TButton;
    quFactValues: TADOQuery;
    quMaxValues: TADOQuery;
    quFactValuesId_Openpit: TIntegerField;
    quFactValuesKperiod: TFloatField;
    quFactValuesTnaryadMin: TFloatField;
    quFactValuesNworked: TIntegerField;
    quFactValuesVm3: TFloatField;
    quFactValuesTrabMin: TFloatField;
    quMaxValuesId_Openpit: TIntegerField;
    quMaxValuesKperiod: TFloatField;
    quMaxValuesTnaryadMin: TFloatField;
    quMaxValuesNworked: TIntegerField;
    quMaxValuesVm3: TFloatField;
    quMaxValuesTrabMin: TFloatField;
    quFactValuesV1000000m3: TFloatField;
    quMaxValuesV1000000m3: TFloatField;
    quFactValuesName: TWideStringField;
    quFactValuesSName: TStringField;
    quMaxValuesName: TWideStringField;
    quMaxValuesSName: TStringField;
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
    TabControl: TTabControl;
    Chart: TChart;
    csFactValues: TBarSeries;
    csMaxValues: TBarSeries;
    quResultShiftAutoReport3: TADOQuery;
    quResultShiftAutoReport3Id_ResultShiftAutoReport: TAutoIncField;
    quResultShiftAutoReport3Id_ResultShift: TIntegerField;
    quResultShiftAutoReport3Id_ResultShiftAuto: TIntegerField;
    quResultShiftAutoReport3Id_DumpModel: TIntegerField;
    quResultShiftAutoReport3DumpModel: TWideStringField;
    quResultShiftAutoReport3Kind: TWordField;
    quResultShiftAutoReport3IsChangeable: TBooleanField;
    quResultShiftAutoReport3RecordNo: TIntegerField;
    quResultShiftAutoReport3RecordName: TWideStringField;
    quResultShiftAutoReport3Name: TWideStringField;
    quResultShiftAutoReport3Value: TFloatField;
    quResultShiftAutoReport3Value1: TFloatField;
    quResultShiftAutoReport3Value2: TFloatField;
    dsResultShiftAutoReport3: TDataSource;
    quResultShiftExcavatorReport3: TADOQuery;
    quResultShiftExcavatorReport3Id_ResultShiftExcavatorReport: TAutoIncField;
    quResultShiftExcavatorReport3Id_ResultShift: TIntegerField;
    quResultShiftExcavatorReport3Id_ResultShiftExcavator: TIntegerField;
    quResultShiftExcavatorReport3Id_DumpModel: TIntegerField;
    quResultShiftExcavatorReport3DumpModel: TWideStringField;
    quResultShiftExcavatorReport3Kind: TWordField;
    quResultShiftExcavatorReport3IsChangeable: TBooleanField;
    quResultShiftExcavatorReport3RecordNo: TIntegerField;
    quResultShiftExcavatorReport3RecordName: TWideStringField;
    quResultShiftExcavatorReport3Name: TWideStringField;
    quResultShiftExcavatorReport3Value: TFloatField;
    quResultShiftExcavatorReport3Value1: TFloatField;
    quResultShiftExcavatorReport3Value2: TFloatField;
    dsResultShiftExcavatorReport3: TDataSource;
    quResultShiftsDollarCtg: TFloatField;
    btShift: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExcelClick(Sender: TObject);
    procedure dbgResultShiftsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure TabControlChange(Sender: TObject);
    procedure quResultShiftAutoReport3CalcFields(DataSet: TDataSet);
    procedure btShiftClick(Sender: TObject);
  private
  public
  end;{TfmResultsProductionCapacities}

var
  fmResultShiftProductionCapacities: TfmResultShiftProductionCapacities;

//Диалоговое окно результатов моделирования по производственной мощности
procedure esaShowResultShiftProductionCapacitiesDlg();
implementation

{$R *.dfm}
uses TeePrevi, unDM, unResultShift;
//Диалоговое окно результатов моделирования по производственной мощности
procedure esaShowResultShiftProductionCapacitiesDlg();
begin
  fmResultShiftProductionCapacities := TfmResultShiftProductionCapacities.Create(nil);
  try
    fmResultShiftProductionCapacities.ShowModal;
  finally
    fmResultShiftProductionCapacities.Free;
  end;{try}
end;{esaShowResultShiftProductionCapacitiesDlg}

procedure TfmResultShiftProductionCapacities.FormCreate(Sender: TObject);
begin
  quResultShifts.Open;
  quResultShiftAutoReport3.Open;
  quResultShiftExcavatorReport3.Open;
  TabControlChange(nil);
end;{FormCreate}
procedure TfmResultShiftProductionCapacities.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultShiftAutoReport3.Close;
  quResultShiftExcavatorReport3.Close;
  quResultShifts.Close;
end;{FormClose}

procedure TfmResultShiftProductionCapacities.btExcelClick(Sender: TObject);
begin
  ChartPreview(fmResultShiftProductionCapacities,Chart);
end;{btExcelClick}

procedure TfmResultShiftProductionCapacities.dbgResultShiftsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  with Sender As TDBGridEh do
  begin
    Canvas.Font.Color := clWindowText;
    //Выделение строки ---------------------------------------------------------
    if (gdSelected in State)or(gdFocused in State) then Canvas.Brush.Color := $FFFFBB;
    //Прорисовка ячейки --------------------------------------------------------
    if (Column.Field.DataType=ftBoolean)and Column.Field.IsNull
    then Canvas.FillRect(Rect) //Null
    else DefaultDrawColumnCell(Rect, DataCol, Column, State);
    //Контур фокуса ------------------------------------------------------------
    if gdFocused in State then Canvas.DrawFocusRect(Rect);
  end;{with}
end;{dbgResultShiftsDrawColumnCell}

procedure TfmResultShiftProductionCapacities.quResultShiftAutoReport3CalcFields(
  DataSet: TDataSet);
begin
  if not(Dataset.FieldByName('Value').IsNull) then
  if Dataset.FieldByName('IsChangeable').AsBoolean then
  begin
    Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('Value').AsFloat*quResultShiftsShiftKweek.AsFloat;
    Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('Value').AsFloat*quResultShiftsPeriodKshift.AsFloat;
  end{if}
  else
  begin
    Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('Value').AsFloat*1.0;
    Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('Value').AsFloat*1.0;
  end;{else}
end;{quResultShiftAutoReport1CalcFields}

procedure TfmResultShiftProductionCapacities.TabControlChange(Sender: TObject);
var
  ATmin0,ATmin1              : Single; //Время общее авто/экскаватора, мин
  AWaitingTmin0,AWaitingTmin1: Single; //Время простоя авто/экскаватора, мин
  AVm30,AVm31                : Single; //Vгм авто/экскаватора, м3
begin
  AWaitingTmin0     := 0.0;
  AWaitingTmin1     := 0.0;
  ATmin0            := 0.0;
  ATmin1            := 0.0;
  AVm30             := 0.0;
  AVm31             := 0.0;
  if quResultShiftAutoReport3.Active then
  begin
    if quResultShiftAutoReport3.Locate('RecordNo',301,[]) then
    case TabControl.TabIndex of
      0: ATmin0 := quResultShiftAutoReport3Value.AsFloat;
      1: ATmin0 := quResultShiftAutoReport3Value1.AsFloat;
      2: ATmin0 := quResultShiftAutoReport3Value2.AsFloat;
    end;{case}
    if quResultShiftAutoReport3.Locate('RecordNo',303,[]) then
    case TabControl.TabIndex of
      0: AWaitingTmin0 := quResultShiftAutoReport3Value.AsFloat;
      1: AWaitingTmin0 := quResultShiftAutoReport3Value1.AsFloat;
      2: AWaitingTmin0 := quResultShiftAutoReport3Value2.AsFloat;
    end;{case}
    if quResultShiftAutoReport3.Locate('RecordNo',104,[]) then
    case TabControl.TabIndex of
      0: AVm30  := quResultShiftAutoReport3Value.AsFloat;
      1: AVm30  := quResultShiftAutoReport3Value1.AsFloat;
      2: AVm30  := quResultShiftAutoReport3Value2.AsFloat;
    end;{case}
  end;{if}
  if quResultShiftExcavatorReport3.Active then
  begin
    if quResultShiftExcavatorReport3.Locate('RecordNo',301,[]) then
    case TabControl.TabIndex of
      0: ATmin1 := quResultShiftExcavatorReport3Value.AsFloat;
      1: ATmin1 := quResultShiftExcavatorReport3Value1.AsFloat;
      2: ATmin1 := quResultShiftExcavatorReport3Value2.AsFloat;
    end;{case}
    if quResultShiftExcavatorReport3.Locate('RecordNo',303,[]) then
    case TabControl.TabIndex of
      0: AWaitingTmin1 := quResultShiftExcavatorReport3Value.AsFloat;
      1: AWaitingTmin1 := quResultShiftExcavatorReport3Value1.AsFloat;
      2: AWaitingTmin1 := quResultShiftExcavatorReport3Value2.AsFloat;
    end;{case}
    if quResultShiftExcavatorReport3.Locate('RecordNo',104,[]) then
    case TabControl.TabIndex of
      0: AVm31  := quResultShiftExcavatorReport3Value.AsFloat;
      1: AVm31  := quResultShiftExcavatorReport3Value1.AsFloat;
      2: AVm31  := quResultShiftExcavatorReport3Value2.AsFloat;
    end;{case}
  end;{if}

  csFactValues.Clear;
  csFactValues.AddXY(1,AVm30);//'Автосамосвалы'
  csFactValues.AddXY(2,AVm31);//'Экскаваторы'
  csMaxValues.Clear;
  if ATmin0-AWaitingTmin0>0.0
  then csMaxValues.AddXY(1,AVm30*ATmin0/(ATmin0-AWaitingTmin0))//'Автосамосвалы'
  else csMaxValues.AddXY(1,0.0);//'Автосамосвалы'
  if ATmin1-AWaitingTmin1>0.0
  then csMaxValues.AddXY(2,AVm31*ATmin1/(ATmin1-AWaitingTmin1))//'Экскаваторы'
  else csMaxValues.AddXY(2,0.0);//'Экскаваторы'
end;{TabControlChange}

procedure TfmResultShiftProductionCapacities.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;{btShiftClick}

end.
