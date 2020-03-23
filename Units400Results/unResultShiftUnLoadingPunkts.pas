unit unResultShiftUnLoadingPunkts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, ExtCtrls, StdCtrls, ComCtrls;//,GridsEh;

type
  TfmResultShiftUnLoadingPunkts = class(TForm)
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
    pnClient: TPanel;
    pnBtns: TPanel;
    btClose: TButton;
    btExcel: TButton;
    quResultShiftsResultStrippingCoef: TFloatField;
    quResultShiftUnloadingPunkts: TADOQuery;
    dsResultShiftUnloadingPunkts: TDataSource;
    quResultShiftUnloadingPunktsId_ResultShiftUnloadingPunkt: TAutoIncField;
    quResultShiftUnloadingPunktsId_ResultShift: TIntegerField;
    quResultShiftUnloadingPunktsId_UnloadingPunkt: TIntegerField;
    quResultShiftUnloadingPunktsHorizont: TFloatField;
    quResultShiftUnloadingPunktsKind: TWordField;
    quResultShiftUnloadingPunktsUnloadingAutosCount: TIntegerField;
    quResultShiftUnloadingPunktsUnloadingTmin: TFloatField;
    quResultShiftUnloadingPunktsManeuvrTmin: TFloatField;
    quResultShiftUnloadingPunktsRockVm3: TFloatField;
    quResultShiftUnloadingPunktsRockQtn: TFloatField;
    quResultShiftUnloadingPunktsMaxV1000m3: TFloatField;
    PageControl: TPageControl;
    tsEvents: TTabSheet;
    tsRocks: TTabSheet;
    quResultShiftUnloadingPunktsUsingTmin: TFloatField;
    quResultShiftUnloadingPunktsUsingCoef: TFloatField;
    quResultShiftUnloadingPunktsBunkerRatio: TFloatField;
    quResultShiftUnloadingPunktEvents: TADOQuery;
    dsResultShiftUnloadingPunktEvents: TDataSource;
    quResultShiftUnloadingPunktEventsId_ResultShiftUnLoadingPunktEvent: TAutoIncField;
    quResultShiftUnloadingPunktEventsId_ResultShiftUnloadingPunkt: TIntegerField;
    quResultShiftUnloadingPunktEventsKind: TWordField;
    quResultShiftUnloadingPunktEventsTmin: TFloatField;
    quResultShiftUnloadingPunktEventsId_Rock: TIntegerField;
    quResultShiftUnloadingPunktEventsRock: TWideStringField;
    quResultShiftUnloadingPunktEventsRockIsMineralWealth: TBooleanField;
    quResultShiftUnloadingPunktEventsRockVm3: TFloatField;
    quResultShiftUnloadingPunktEventsRockQtn: TFloatField;
    quResultShiftUnloadingPunktEventsId_DumpModel: TIntegerField;
    quResultShiftUnloadingPunktEventsDumpModel: TWideStringField;
    quResultShiftUnloadingPunktEventsDumpNo: TIntegerField;
    dbgUnloadingPunkts: TDBGridEh;
    dbgUnloadingPunktEvents: TDBGridEh;
    quResultShiftUnloadingPunktRocks: TADOQuery;
    dsResultShiftUnloadingPunktRocks: TDataSource;
    quResultShiftUnloadingPunktRocksId_ResultShiftUnloadingPunktRock: TAutoIncField;
    quResultShiftUnloadingPunktRocksId_ResultShiftUnloadingPunkt: TIntegerField;
    quResultShiftUnloadingPunktRocksUnloadingAutosCount: TIntegerField;
    quResultShiftUnloadingPunktRocksRockVm3: TFloatField;
    quResultShiftUnloadingPunktRocksRockQtn: TFloatField;
    quResultShiftUnloadingPunktRocksId_Rock: TIntegerField;
    quResultShiftUnloadingPunktRocksRock: TWideStringField;
    quResultShiftUnloadingPunktRocksRockIsMineralWealth: TBooleanField;
    quResultShiftUnloadingPunktRocksRequiredContent: TFloatField;
    quResultShiftUnloadingPunktRocksContent: TFloatField;
    quResultShiftUnloadingPunktRocksDContent: TFloatField;
    dbgResultShiftUnloadingPunktRocks: TDBGridEh;
    btShift: TButton;
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftUnloadingPunktsKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftUnloadingPunktsCalcFields(DataSet: TDataSet);
    procedure quResultShiftUnloadingPunktEventsKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftUnloadingPunktRocksCalcFields(
      DataSet: TDataSet);
    procedure dbgUnloadingPunktEventsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
  private
  public
  end;{TfmResultShiftUnLoadingPunkts}

var
  fmResultShiftUnLoadingPunkts: TfmResultShiftUnLoadingPunkts;

//Диалоговое окно результатов моделирование по пунктам разгрузки
procedure esaShowResultShiftUnLoadingPunktsDlg();
implementation

uses unResultShift;

{$R *.dfm}

//Диалоговое окно результатов моделирование по пунктам разгрузки
procedure esaShowResultShiftUnLoadingPunktsDlg();
begin
  fmResultShiftUnLoadingPunkts := TfmResultShiftUnLoadingPunkts.Create(nil);
  try
    fmResultShiftUnLoadingPunkts.ShowModal;
  finally
    fmResultShiftUnLoadingPunkts.Free;
  end;{try}
end;{esaShowResultShiftUnLoadingPunktsDlg}

procedure TfmResultShiftUnLoadingPunkts.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;{quResultShiftsCalcFields}

procedure TfmResultShiftUnLoadingPunkts.FormCreate(Sender: TObject);
begin
  PageControl.TabIndex := 0;
  quResultShifts.Open;
  quResultShiftUnloadingPunkts.Open;
  quResultShiftUnloadingPunktEvents.Open;
  quResultShiftUnloadingPunktRocks.Open;
end;{FormCreate}
procedure TfmResultShiftUnLoadingPunkts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultShiftUnloadingPunktRocks.Close;
  quResultShiftUnloadingPunktEvents.Close;
  quResultShiftUnloadingPunkts.Close;
  quResultShifts.Close;
end;{FormClose}

procedure TfmResultShiftUnLoadingPunkts.quResultShiftUnloadingPunktsKindGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  case Sender.AsInteger of
    0: Text := 'Горно-обогатительная фабрика';
    1: Text := 'Перегрузочный склад';
    2: Text := 'Отвал';
  end;{case}
end;{quResultShiftUnloadingPunktsKindGetText}

procedure TfmResultShiftUnLoadingPunkts.quResultShiftUnloadingPunktsCalcFields(DataSet: TDataSet);
begin
  quResultShiftUnloadingPunktsUsingTmin.AsFloat := quResultShiftUnloadingPunktsManeuvrTmin.AsFloat+
    quResultShiftUnloadingPunktsUnloadingTmin.AsFloat;

  if quResultShiftsShiftTmin.AsInteger>0
  then quResultShiftUnloadingPunktsUsingCoef.AsFloat :=
    quResultShiftUnloadingPunktsUsingTmin.AsFloat/quResultShiftsShiftTmin.AsInteger;
  if quResultShiftUnloadingPunktsMaxV1000m3.AsFloat>=0.0001 then
  quResultShiftUnloadingPunktsBunkerRatio.AsFloat :=
    100*quResultShiftUnloadingPunktsRockVm3.AsFloat/(1000*quResultShiftUnloadingPunktsMaxV1000m3.AsFloat);
end;{quResultShiftUnloadingPunktsCalcFields}

procedure TfmResultShiftUnLoadingPunkts.quResultShiftUnloadingPunktEventsKindGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  case Sender.AsInteger of
    1: Text := 'Погрузка';
    2: Text := 'Простой';
    3: Text := 'Маневры';
  end;{case}
end;{quResultShiftUnloadingPunktEventsKindGetText}

procedure TfmResultShiftUnLoadingPunkts.quResultShiftUnloadingPunktRocksCalcFields(DataSet: TDataSet);
begin
  quResultShiftUnloadingPunktRocksDContent.AsFloat :=
    quResultShiftUnloadingPunktRocksRequiredContent.AsFloat -
    quResultShiftUnloadingPunktRocksContent.AsFloat;
end;{quResultShiftUnloadingPunktRocksCalcFields}

procedure TfmResultShiftUnLoadingPunkts.dbgUnloadingPunktEventsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if (Column.Field=quResultShiftUnloadingPunktEventsKind)and
     (Column.Field.AsString='1') then TDBGridEh(Sender).Canvas.Font.Style := [fsBold];
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;{dbgUnloadingPunktEventsDrawColumnCell}

procedure TfmResultShiftUnLoadingPunkts.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;{btShiftClick}

procedure TfmResultShiftUnLoadingPunkts.btExcelClick(Sender: TObject);
begin

end;{btExcelClick}

end.
