unit unResultShift;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Grids, DBGridEh, StdCtrls, Mask, DBCtrls;

type
  TfmResultShift = class(TForm)
    pnBtns: TPanel;
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
    lbId_ResultShift: TLabel;
    dbeId_ResultShift: TDBEdit;
    lbId_Openpit: TLabel;
    dbeId_Openpit: TDBEdit;
    lbShiftNaryadTmin: TLabel;
    dbeShiftNaryadTmin: TDBEdit;
    lbShiftPlanNaryadTmin: TLabel;
    dbeShiftPlanNaryadTmin: TDBEdit;
    lbShiftPeresmenkaTmin: TLabel;
    dbeShiftPeresmenkaTmin: TDBEdit;
    lbShiftTmin: TLabel;
    dbeShiftTmin: TDBEdit;
    lbShiftKweek: TLabel;
    dbeShiftKweek: TDBEdit;
    lbPeriodKshift: TLabel;
    dbePeriodKshift: TDBEdit;
    lbPeriodTday: TLabel;
    dbePeriodTday: TDBEdit;
    lbDollarCtg: TLabel;
    dbeDollarCtg: TDBEdit;
    btOk: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
  private
  public
  end;{TfmResultShift}

var
  fmResultShift: TfmResultShift;

//Диалоговое окно параметров рабочей смены
function esaShowResultShiftDlg(): Boolean;
implementation

uses unDM;

{$R *.dfm}
//Диалоговое окно параметров рабочей смены
function esaShowResultShiftDlg(): Boolean;
begin
  fmResultShift := TfmResultShift.Create(nil);
  try
    Result := fmResultShift.ShowModal=mrOk;
  finally
    fmResultShift.Free;
  end;{try}
end;{esaShowResultShiftDlg}

procedure TfmResultShift.FormCreate(Sender: TObject);
begin
  quResultShifts.Open;
end;{FormCreate}
procedure TfmResultShift.FormDestroy(Sender: TObject);
begin
  quResultShifts.Close;
end;{FormDestroy}

procedure TfmResultShift.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;{quResultShiftsCalcFields}

end.
