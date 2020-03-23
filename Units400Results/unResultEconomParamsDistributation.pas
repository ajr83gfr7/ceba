unit unResultEconomParamsDistributation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TeeProcs, TeEngine, Chart, Series,
  DB, ADODB, DbChart;

type
  TfmResultEconomParamsDistributation = class(TForm)
    pnBtns: TPanel;
    btCancel: TButton;
    TabControl: TTabControl;
    Chart: TChart;
    Series1: TPieSeries;
    btPrint: TButton;
    Series2: TPieSeries;
    Series3: TPieSeries;
    procedure FormCreate(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
  private
  public
  end;{TfmResultEconomParamsDistributation}

var
  fmResultEconomParamsDistributation: TfmResultEconomParamsDistributation;

//Диалоговое окно распределения затрат
procedure esaShowResultEconomParamsDistributation(const AId_Shift: Integer);
implementation

{$R *.dfm}
uses TeePrevi, unDM;

//Диалоговое окно распределения затрат
procedure esaShowResultEconomParamsDistributation(const AId_Shift: Integer);
begin
  fmResultEconomParamsDistributation := TfmResultEconomParamsDistributation.Create(nil);
  try
    with TADOQuery.Create(nil) do
    try
      Connection := fmDM.ADOConnection;
      SQL.Text := Format('SELECT * FROM _ResultEconomDistributation WHERE Id_ResultShift=%d ORDER BY SeriaNo,RecordNo',[AId_Shift]);
      Open;
      while not EOF do
      begin
        case FieldByName('SeriaNo').AsInteger of
          1: fmResultEconomParamsDistributation.Series1.Add(FieldByName('Value').AsFloat,FieldByName('Name').AsString);
          2: fmResultEconomParamsDistributation.Series2.Add(FieldByName('Value').AsFloat,FieldByName('Name').AsString);
          3: fmResultEconomParamsDistributation.Series3.Add(FieldByName('Value').AsFloat,FieldByName('Name').AsString);
        end;{case}
        Next;
      end;{while}
      Close;
    finally
      Free;
    end;{try}
    fmResultEconomParamsDistributation.ShowModal;
  finally
    fmResultEconomParamsDistributation.Free;
  end;{try}
end;{esaShowResultEconomParamsDistributation}

procedure TfmResultEconomParamsDistributation.FormCreate(Sender: TObject);
begin
  TabControl.TabIndex := 0;
end;{FormCreate}

procedure TfmResultEconomParamsDistributation.TabControlChange(Sender: TObject);
begin
  Chart.Series[0].Active := TabControl.TabIndex=0;
  Chart.Series[1].Active := TabControl.TabIndex=1;
  Chart.Series[2].Active := TabControl.TabIndex=2;
  Chart.Title.Text.Clear;
  case TabControl.TabIndex of
    0: Chart.Title.Text.Add('Распределение эксплуатационных затрат');
    1: Chart.Title.Text.Add('Распределение амортизационных затрат');
    2: Chart.Title.Text.Add('Распределение суммарных затрат');
  end;{case}
  Chart.AxisVisible := false;
  Chart.View3DWalls := false;
end;{TabControlChange}

procedure TfmResultEconomParamsDistributation.btPrintClick(Sender: TObject);
begin
  ChartPreview(fmResultEconomParamsDistributation, Chart);
end;{btPrintClick}

end.
