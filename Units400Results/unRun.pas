unit unRun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Types, DB,
  Mask;

type
  TfmRun = class(TForm)
    pnBtns: TPanel;
    lbShiftDuration: TLabel;
    lbPeriodDuration: TLabel;
    lbAnimationTimeScale: TLabel;
    dbcbPeriodDuration: TDBEdit;
    dbcbShiftDuration: TDBComboBox;
    dbcbIsAccumulateData: TDBCheckBox;
    dbedAnimationTimeScale: TDBEdit;
    btOk: TButton;
    Bevel: TBevel;
    btCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btOkClick(Sender: TObject);
  private
    procedure DoBeforePost(DataSet: TDataSet);
  public
  end;{TfmRun}

var
  fmRun: TfmRun;

//Диалоговое окно моделирования
function esaShowRunDlg(): Boolean;
implementation

uses unDM, Globals, Math, ADODb, esaDBDefaultParams;
{$R *.dfm}

//Диалоговое окно моделирования
function esaShowRunDlg(): Boolean;
begin
  fmRun := TfmRun.Create(nil);
  try
    Result := fmRun.ShowModal=mrOk;
  finally
    fmRun.Free;
  end;{try}
end;{esaShowRunDlg}

procedure TfmRun.FormCreate(Sender: TObject);
begin
  HelpKeyword := 'RunStart';
  with fmDM do
  begin
    quOpenpits.BeforePost := DoBeforePost;
  end;
end;
procedure TfmRun.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quOpenpits.BeforePost := nil;
  end;
end;
procedure TfmRun.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quOpenpits,Caption);
end;
procedure TfmRun.DoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit] then
    if not IsIntegerFieldMoreMin(Dataset.FieldByName('ParamsShiftDuration'),0)then
      Abort
    else
      if not IsIntegerFieldMoreMin(Dataset.FieldByName('ParamsPeriodDuration'),0)then
        Abort
      else
        if not IsIntegerFieldMoreMin(Dataset.FieldByName('ParamsAnimationTimeScale'),0)then
          Abort
end;
procedure TfmRun.btOkClick(Sender: TObject);
begin

  with fmDM do
  begin
    if quOpenpits.State in [dsEdit,dsInsert]then
      quOpenpits.Post;
    DefaultParams.ModelingParamsShiftDuration := quOpenpitsParamsShiftDuration.AsInteger;
    DefaultParams.ModelingParamsPeriodDuration := quOpenpitsParamsPeriodDuration.AsInteger;
    DefaultParams.ModelingParamsIsAccumulateData := quOpenpitsParamsIsAccumulateData.AsBoolean;
    DefaultParams.ModelingParamsAnimationTimeScale := quOpenpitsParamsAnimationTimeScale.AsInteger;
    ModalResult := mrOk;
  end;
end;{btOkClick}

end.
