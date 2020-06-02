unit unResultShiftProportionality;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, Mask, DBCtrls, Grids, DBGridEh,
  ComCtrls;

type
  TfmResultShiftProportionality = class(TForm)
    pnBtns: TPanel;
    btCancel: TButton;
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
    TabControl: TTabControl;
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
    ledUsingRatio0: TLabeledEdit;
    ledUsingRatio1: TLabeledEdit;
    ledWaitingTmin0: TLabeledEdit;
    ledWaitingTmin1: TLabeledEdit;
    ledProportionality0: TLabeledEdit;
    ledProportionality1: TLabeledEdit;
    quResultShiftsDollarCtg: TFloatField;
    btShift: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure quResultShiftAutoReport3CalcFields(DataSet: TDataSet);
    procedure TabControlChange(Sender: TObject);
    procedure dbgResultShiftsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
  private
  public
  end;{fmResultShiftProportionality}

var
  fmResultShiftProportionality: TfmResultShiftProportionality;

//Диалоговое окно результатов моделирования по коэффициенту пропорциональности
procedure esaShowResultShiftProportionalityDlg();
implementation

uses unResultShift;

{$R *.dfm}

//Диалоговое окно результатов моделирования по коэффициенту пропорциональности
procedure esaShowResultShiftProportionalityDlg();
begin
  fmResultShiftProportionality := TfmResultShiftProportionality.Create(nil);
  try
    fmResultShiftProportionality.ShowModal;
  finally
    fmResultShiftProportionality.Free;
  end;{try}
end;{esaShowResultShiftProportionalityDlg}

procedure TfmResultShiftProportionality.FormCreate(Sender: TObject);
begin
  quResultShifts.Open;
  quResultShiftAutoReport3.Open;
  quResultShiftExcavatorReport3.Open;
  TabControlChange(nil);
end;{FormCreate}
procedure TfmResultShiftProportionality.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultShiftAutoReport3.Close;
  quResultShiftExcavatorReport3.Close;
  quResultShifts.Close;
end;{FormClose}

procedure TfmResultShiftProportionality.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;{quResultShiftsCalcFields}

procedure TfmResultShiftProportionality.quResultShiftAutoReport3CalcFields(DataSet: TDataSet);
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


procedure TfmResultShiftProportionality.TabControlChange(Sender: TObject);
var
  AWaitingTmin0,AWaitingTmin1        : Single; //Время простоя авто/экскаватора, мин
  AUsingRatio0,AUsingRatio1          : Single; //Коэф-нт использ-ния раб.времени авто/экскаватора, мин
  AProportionality0,AProportionality1: Single; //Коэф-нт пропорциональности авто/экскаватора, мин
begin

 {

  if (Tn>0.0)and(N>0)
    then quResultProportionalityCoefAutoCoef.AsFloat :=
          (quResultProportionalityCoefAutoTwork.AsFloat+
           quResultProportionalityCoefAutoTloading.AsFloat+
           quResultProportionalityCoefAutoTunloading.AsFloat+
           quResultProportionalityCoefAutoTmaneuver.AsFloat)/Tn/N
    else quResultProportionalityCoefAutoCoef.AsFloat := 0.0;

 }
  AWaitingTmin0     := 0.0;
  AWaitingTmin1     := 0.0;
  AUsingRatio0      := 0.0;
  AUsingRatio1      := 0.0;
  AProportionality0 := 0.0;
  AProportionality1 := 0.0;
  if quResultShiftAutoReport3.Active then
  begin
    if quResultShiftAutoReport3.Locate('RecordNo',303,[]) then
    case TabControl.TabIndex of
      0: AWaitingTmin0 := quResultShiftAutoReport3Value.AsFloat;
      1: AWaitingTmin0 := quResultShiftAutoReport3Value1.AsFloat;
      2: AWaitingTmin0 := quResultShiftAutoReport3Value2.AsFloat;
    end;{case}
    {SEE}
    if quResultShiftAutoReport3.Locate('RecordNo',315,[]) then     //old  if quResultShiftAutoReport3.Locate('RecordNo',308,[]) then
    case TabControl.TabIndex of
      0: AUsingRatio0  := quResultShiftAutoReport3Value.AsFloat;
      1: AUsingRatio0  := quResultShiftAutoReport3Value1.AsFloat;
      2: AUsingRatio0  := quResultShiftAutoReport3Value2.AsFloat;
    end;{case}
  end;{if}
  if quResultShiftExcavatorReport3.Active then
  begin
    if quResultShiftExcavatorReport3.Locate('RecordNo',303,[]) then
    case TabControl.TabIndex of
      0: AWaitingTmin1 := quResultShiftExcavatorReport3Value.AsFloat;
      1: AWaitingTmin1 := quResultShiftExcavatorReport3Value1.AsFloat;
      2: AWaitingTmin1 := quResultShiftExcavatorReport3Value2.AsFloat;
    end;{case}
    if quResultShiftExcavatorReport3.Locate('RecordNo',306,[]) then
    case TabControl.TabIndex of
      0: AUsingRatio1  := quResultShiftExcavatorReport3Value.AsFloat;
      1: AUsingRatio1  := quResultShiftExcavatorReport3Value1.AsFloat;
      2: AUsingRatio1  := quResultShiftExcavatorReport3Value2.AsFloat;
    end;{case}
  end;{if}
  if AUsingRatio0>0.0 then AProportionality0 := AUsingRatio1/AUsingRatio0;
  if AWaitingTmin0>0.0 then AProportionality1 := AWaitingTmin1/AWaitingTmin0;
  ledUsingRatio0.Text      := Format('%.4f',[AUsingRatio0]);
  ledUsingRatio1.Text      := Format('%.4f',[AUsingRatio1]);
  ledWaitingTmin0.Text     := Format('%.4f',[AWaitingTmin0]);
  ledWaitingTmin1.Text     := Format('%.4f',[AWaitingTmin1]);
  ledProportionality0.Text := Format('%.4f',[AProportionality0]);
  ledProportionality1.Text := Format('%.4f',[AProportionality1]);
end;{TabControlChange}

procedure TfmResultShiftProportionality.dbgResultShiftsDrawColumnCell(
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

procedure TfmResultShiftProportionality.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;{btShiftClick}

end.
