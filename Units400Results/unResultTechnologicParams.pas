unit unResultTechnologicParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, Grids, DBGridEh, ComCtrls;//,GridsEh;

type
  TfmResultTechnologicParams = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    btExcel: TButton;
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
    quResultShiftsDollarCtg: TFloatField;
    dsResultShifts: TDataSource;
    PageControl: TPageControl;
    tsAutos: TTabSheet;
    tsRocks: TTabSheet;
    quResultAutos: TADOQuery;
    dsResultAutos: TDataSource;
    dbgAutos: TDBGridEh;
    Splitter0: TSplitter;
    quResultAutoParams: TADOQuery;
    quResultAutoParamsId_DumpModel: TIntegerField;
    quResultAutoParamsIsChangeable: TBooleanField;
    quResultAutoParamsRecordNo: TIntegerField;
    quResultAutoParamsRecordName: TWideStringField;
    quResultAutoParamsName: TWideStringField;
    quResultAutoParamsValue: TFloatField;
    quResultAutoParamsValue1: TFloatField;
    quResultAutoParamsValue2: TFloatField;
    dsResultAutoParams: TDataSource;
    quResultAutosId_DumpModel: TIntegerField;
    quResultAutosDumpModel: TWideStringField;
    quResultAutoParamsId_ResultTechnologicAutoParam: TAutoIncField;
    dbgAutoParams: TDBGridEh;
    quResultRocks: TADOQuery;
    dsResultRocks: TDataSource;
    quResultRocksId_Rock: TIntegerField;
    quResultRocksRock: TWideStringField;
//    quResultRocksIsChangeable: TBooleanField;
    dbgRocks: TDBGridEh;
    Splitter1: TSplitter;
    quResultRockParams: TADOQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    dsResultRockParams: TDataSource;
    quResultRockParamsId_Rock: TIntegerField;
    dbgRockParams: TDBGridEh;
    btShift: TButton;
    quResultRockParamsRecordNo: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure quResultAutoParamsCalcFields(DataSet: TDataSet);
    procedure dbgAutoParamsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
    procedure quResultRockParamsCalcFields(DataSet: TDataSet);
  private
    procedure SetFooter();
  public
  end;{TfmResultTechnologicParams}

var
  fmResultTechnologicParams: TfmResultTechnologicParams;

//Диалоговое окно технологических параметров моделирования за период
procedure esaShowResultTechnologicParams();
implementation

uses unResultShift;

{$R *.dfm}

//Диалоговое окно технологических параметров моделирования за период
procedure esaShowResultTechnologicParams();
begin
  fmResultTechnologicParams := TfmResultTechnologicParams.Create(nil);
  try
    fmResultTechnologicParams.ShowModal;
  finally
    fmResultTechnologicParams.Free;
  end;{try}
end;

procedure TfmResultTechnologicParams.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  quResultShifts.Open;
  quResultAutos.Open;
  quResultAutoParams.Open;
  quResultRocks.Open;
  quResultRockParams.Open;

  SetFooter;
end;
procedure TfmResultTechnologicParams.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultRockParams.Close;
  quResultRocks.Close;
  quResultAutoParams.Close;
  quResultAutos.Close;
  quResultShifts.Close;
end;

procedure TfmResultTechnologicParams.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;

procedure TfmResultTechnologicParams.quResultAutoParamsCalcFields(DataSet: TDataSet);
begin
  if not(Dataset.FieldByName('Value').IsNull) then
    if Dataset.FieldByName('IsChangeable').AsBoolean then
    begin
      Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('Value').AsFloat *
                                               quResultShiftsShiftKweek.AsFloat;
      Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('Value').AsFloat *
                                               quResultShiftsPeriodKshift.AsFloat;
    end
    else
    begin
      Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('Value').AsFloat*1.0;
      Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('Value').AsFloat*1.0;
    end;
end;

procedure TfmResultTechnologicParams.dbgAutoParamsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.Dataset.FieldByName('RecordNo').AsInteger mod 100 = 0 then
    TDBGridEh(Sender).Canvas.Font.Style := [fsBold];
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfmResultTechnologicParams.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;

procedure TfmResultTechnologicParams.SetFooter;
begin
//  dbgRocks.Columns[1].Footer.ValueType:= fvtStaticText;
//  dbgRocks.Columns[1].Footer.Value:= 'Общее производство ГТСК.';
end;

procedure TfmResultTechnologicParams.quResultRockParamsCalcFields(
  DataSet: TDataSet);
var
  dbl: double;
begin
  if not(Dataset.FieldByName('AValue').IsNull) then
//    if Dataset.FieldByName('IsChangeable').AsBoolean then
    if Dataset.FieldByName('RecordName').AsInteger <> 4 then
    begin
      dbl:= Dataset.FieldByName('AValue').AsFloat;
      dbl:= quResultShiftsShiftKweek.AsFloat;
      dbl:= Dataset.FieldByName('AValue').AsFloat * quResultShiftsShiftKweek.AsFloat;
      Dataset.FieldByName('Value1').AsFloat := (Dataset.FieldByName('AValue').AsFloat /
                                               quResultShiftsPeriodKshift.AsFloat) *
                                               quResultShiftsShiftKweek.AsFloat;
      Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('AValue').AsFloat /
                                               quResultShiftsPeriodKshift.AsFloat;
    end
    else
    begin
      Dataset.FieldByName('Value1').AsFloat := Dataset.FieldByName('AValue').AsFloat*1.0;
      Dataset.FieldByName('Value2').AsFloat := Dataset.FieldByName('AValue').AsFloat*1.0;
    end;
end;

end.
