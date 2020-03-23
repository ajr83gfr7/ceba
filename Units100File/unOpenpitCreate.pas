unit unOpenpitCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids;

type
  TfmOpenpitCreate = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btCancel: TButton;
    pnClient: TPanel;
    lbName: TLabel;
    lbDateCreate: TLabel;
    edName: TEdit;
    edDateCreate: TEdit;
    edNote: TEdit;
    lbNote: TLabel;
    Timer: TTimer;
    btMore: TButton;
    dbgOpenpits: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btMoreClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
    FIsSelect: Boolean;
    procedure UpdateView;
    procedure SetIsSelect(Value: Boolean);
  public
    property IsSelect: Boolean read FIsSelect write SetIsSelect;
  end;{TfmOpenpitNew}

var
  fmOpenpitCreate: TfmOpenpitCreate;

//Диалоговое окно создания карьера
function esaShowNewOpenpitDlg(): Boolean;
//Диалоговое окно открытия карьера
function esaShowOpenOpenpitDlg(): Boolean;

implementation

uses unDM, Globals, DB, esaDBDefaultParams;

{$R *.dfm}

//Диалоговое окно создания карьера
function esaShowNewOpenpitDlg(): Boolean;
begin
  fmOpenpitCreate := TfmOpenpitCreate.Create(nil);
  try
    fmOpenpitCreate.SetIsSelect(False);
    fmDM.quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]);
    Result := fmOpenpitCreate.ShowModal=mrOk;
    fmDM.quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]);
  finally
    fmOpenpitCreate.Free;
  end;{try}
end;{esaShowNewOpenpitDlg}

//Диалоговое окно открытия карьера
function esaShowOpenOpenpitDlg(): Boolean;
begin
  fmOpenpitCreate := TfmOpenpitCreate.Create(nil);
  try
    fmOpenpitCreate.SetIsSelect(True);
    fmDM.quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]);
    Result := fmOpenpitCreate.ShowModal=mrOk;
    fmDM.quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]);
  finally
    fmOpenpitCreate.Free;
  end;{try}
end;{esaShowOpenOpenpitDlg}

procedure TfmOpenpitCreate.FormCreate(Sender: TObject);
begin
  HelpKeyword := 'OpenpitFile';
  TimerTimer(Self);
  btMore.Tag := 1;
  UpdateView;
  IsSelect := False;
end;{FormCreate}
procedure TfmOpenpitCreate.TimerTimer(Sender: TObject);
begin
  edDateCreate.Text := DateTimeToStr(Now);
end;{TimerTimer}

procedure TfmOpenpitCreate.UpdateView;
begin
  case btMore.Tag of
    0: begin
      dbgOpenpits.Visible := false;
      ClientHeight := 104+1+pnBtns.Height;
      btMore.Caption := 'Больше >>';
    end;{More}
    1: begin
      btMore.Caption := 'Меньше <<';
      ClientHeight := 104+pnBtns.Height+120;
      dbgOpenpits.Visible := true;
    end;{More}
  end;{case}
end;{UpdateView}

procedure TfmOpenpitCreate.btMoreClick(Sender: TObject);
begin
  if btMore.Tag=0 then btMore.Tag := 1 else btMore.Tag := 0;
  UpdateView;
end;{btMoreClick}

procedure TfmOpenpitCreate.btOkClick(Sender: TObject);
begin
  with fmDM do
  if not IsSelect then
  begin
    edName.Text := Trim(edName.Text);
    edNote.Text := Trim(edNote.Text);
    if quOpenpits.Locate('Name',edName.Text,[])
    then esaMsgError(Format(EDuplicateObj,['Карьер',edName.Text]))
    else
    with DefaultParams do
    begin
      quOpenpits.Append;
      quOpenpitsName.AsString := edName.Text;
      quOpenpitsDateCreate.AsDateTime := Now;
      quOpenpitsNote.AsString := edNote.Text;
      quOpenpitsMinX.AsFloat := 0.0;
      quOpenpitsMinY.AsFloat := 0.0;
      quOpenpitsMinZ.AsFloat := 0.0;
      quOpenpitsMaxX.AsFloat := 5000.0;
      quOpenpitsMaxY.AsFloat := 5000.0;
      quOpenpitsMaxZ.AsFloat := 500.0;
      quOpenpitsTotalKurs.AsFloat := ParamsTotalKurs;
      quOpenpitsTotalExpenses.AsFloat := ParamsTotalExpenses;
      quOpenpitsTotalSalaryCoef.AsFloat := ParamsTotalSalaryCoef;
      quOpenpitsTotalShiftUsingCoefNormal.AsFloat := ParamsTotalShiftUsingCoefNormal;
      quOpenpitsTotalShiftUsingCoefDayShift.AsFloat := ParamsTotalShiftUsingCoefDayShift;
      quOpenpitsTotalShiftUsingCoefExplosion.AsFloat := ParamsTotalShiftUsingCoefExplosion;
      quOpenpitsTotalShiftUsingCoefExplosionCount.AsInteger := ParamsTotalShiftUsingCoefExplosionCount;
      quOpenpitsExcavsSalaryMashinist0.AsFloat := ParamsExcavsSalaryMashinist0;
      quOpenpitsExcavsSalaryMashinist1.AsFloat := ParamsExcavsSalaryMashinist1;
      quOpenpitsExcavsSalaryAssistant0.AsFloat := ParamsExcavsSalaryAssistant0;
      quOpenpitsExcavsSalaryAssistant1.AsFloat := ParamsExcavsSalaryAssistant1;
      quOpenpitsExcavsWorkShiftsCount.AsInteger := ParamsExcavsWorkShiftsCount;
      quOpenpitsExcavsWorkShiftDuration.AsFloat := ParamsExcavsWorkShiftDuration;
      quOpenpitsExcavsEnergyCost.AsFloat := ParamsExcavsEnergyCost;
      quOpenpitsExcavsAmortazationNorm.AsFloat := ParamsExcavsAmortazationNorm;
      quOpenpitsAutosSalary0.AsFloat := ParamsAutosSalary0;
      quOpenpitsAutosSalary1.AsFloat := ParamsAutosSalary1;
      quOpenpitsAutosWorkShiftsCount.AsInteger := ParamsAutosWorkShiftsCount;
      quOpenpitsAutosWorkShiftDuration.AsFloat := ParamsAutosWorkShiftDuration;
      quOpenpitsAutosFuelCostWinter.AsFloat := ParamsAutosFuelCostWinter;
      quOpenpitsAutosFuelCostSummer.AsFloat := ParamsAutosFuelCostSummer;
      quOpenpitsAutosWinterMonthCount.AsInteger := ParamsAutosWinterMonthCount;
      quOpenpitsAutosFuelCostTarif.AsInteger := Integer(ParamsAutosFuelCostTarif);

      quOpenpitsWorkRegimeKind.AsInteger := Integer(ParamsWorkRegimeKind);
      quOpenpitsWorkRegimeIsStrippingCoefUsing.AsBoolean := ParamsWorkRegimeIsStrippingCoefUsing;
      quOpenpitsParamsShiftDuration.AsInteger := ModelingParamsShiftDuration;
      quOpenpitsParamsPeriodDuration.AsInteger := ModelingParamsPeriodDuration;

      quOpenpitsAutosShiftTurnoverTime.AsInteger := ParamsAutosShiftTurnoverTime;
      quOpenpitsExcavsShiftTurnoverTime.AsInteger := ParamsExcavsShiftTurnoverTime;
      quOpenpitsParamsShiftDuration.AsInteger := ModelingParamsShiftDuration;
      quOpenpitsParamsPeriodDuration.AsInteger := ModelingParamsPeriodDuration;
      quOpenpitsParamsIsAccumulateData.AsBoolean := ModelingParamsIsAccumulateData;
      quOpenpitsParamsAnimationTimeScale.AsInteger := ModelingParamsAnimationTimeScale;
      quOpenpits.Post;
      DefaultParams.OpenpitId_Openpit := quOpenpitsId_Openpit.AsInteger;
      quOpenpits.Requery;
      quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]);
      ModalResult := mrOk;
    end;{else}
  end{if}
  else
  if quOpenpits.RecordCount>0 then
  begin
    DefaultParams.OpenpitId_Openpit := quOpenpitsId_Openpit.AsInteger;
    quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]);
    ModalResult := mrOk;
  end;{else}
end;{btOkClick}

procedure TfmOpenpitCreate.SetIsSelect(Value: Boolean);
begin
  if FIsSelect<>Value then
  begin
    FIsSelect := Value;
    pnClient.Visible := not IsSelect;
    dbgOpenpits.Visible := IsSelect;
    btMore.Visible := not IsSelect;
    case IsSelect of
      true: begin
        Caption := 'Открыть';
        dbgOpenpits.Color := clWindow;
        btOk.Enabled := fmDM.quOpenpits.RecordCount>0;
        ActiveControl := dbgOpenpits;
        dbgOpenpits.OnDblClick := btOkClick;
      end;{для выбора}
      false: begin
        Caption := 'Создать';
        dbgOpenpits.Color := clBtnFace;
        ActiveControl := edName;
        dbgOpenpits.OnDblClick := nil;
      end;{для создания}
    end;{case}
    btOk.Caption := Caption;
  end;{if}
end;{SetIsSelect}

end.
