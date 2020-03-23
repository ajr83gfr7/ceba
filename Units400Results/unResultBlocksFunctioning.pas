unit unResultBlocksFunctioning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, DbChart,
  ComCtrls, TeePrevi, Grids, DBGrids, DBGridEh, DB, ADODB;

type
  TfmResultBlocksFunctioning = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    btPrint: TButton;
    TabControl: TTabControl;
    dbchTSpecific: TDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    quSpecO_LM: TADOQuery;
    quSpecO_LMLsm: TIntegerField;
    quSpecO_LMValue: TFloatField;
    quSpecO_UM: TADOQuery;
    quSpecO_UMLsm: TIntegerField;
    quSpecO_UMValue: TFloatField;
    quSpecO_LS: TADOQuery;
    quSpecO_US: TADOQuery;
    quSpecO_USLsm: TIntegerField;
    quSpecO_USValue: TFloatField;
    quSpecO_LSLsm: TIntegerField;
    quSpecO_LSValue: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  fmResultBlocksFunctioning: TfmResultBlocksFunctioning;

implementation

uses unDM;

{$R *.dfm}

procedure TfmResultBlocksFunctioning.FormCreate(Sender: TObject);
var
  I:integer;
  SpecOccup_L,SpecOccup_U:double;

begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  TabControl.TabIndex := 0;
  TabControlChange(nil);

  quSpecO_LM.Open;
  quSpecO_UM.Open;
  quSpecO_LS.Open;
  quSpecO_US.Open;
  i:=1;
  while (not  quSpecO_LM.Eof)  and (not quSpecO_UM.Eof) and  (not quSpecO_LS.Eof)  and (not quSpecO_US.Eof)  do
  begin
    SpecOccup_L := 100*(quSpecO_LMValue.Value+quSpecO_LSValue.Value)/quSpecO_LMLsm.Value;
    SpecOccup_U := 100*(quSpecO_UMValue.Value+quSpecO_USValue.Value)/quSpecO_UMLsm.Value;
    Series1.AddXY(i, SpecOccup_L);
    Series2.AddXY(i, SpecOccup_U);
    Series3.AddXY(i, SpecOccup_L+SpecOccup_U);

    quSpecO_LM.Next;
    quSpecO_UM.Next;
    quSpecO_LS.Next;
    quSpecO_US.Next;
    inc(i);
   // ShowMessage();
  end;
end;{FormCreate}

procedure TfmResultBlocksFunctioning.btPrintClick(Sender: TObject);
begin
  ChartPreview(fmResultBlocksFunctioning, dbchTSpecific);
end;{btPrintClick}

procedure TfmResultBlocksFunctioning.TabControlChange(Sender: TObject);
begin
  dbchTSpecific.Title.Text[1] := Format('(%s)',[TabControl.Tabs[TabControl.TabIndex]]);
  dbchTSpecific.Series[0].Active := TabControl.TabIndex=0;
  dbchTSpecific.Series[1].Active := TabControl.TabIndex=1;
  dbchTSpecific.Series[2].Active := TabControl.TabIndex=2;
end;{TabControlChange}

procedure TfmResultBlocksFunctioning.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  quSpecO_LM.Close;
  quSpecO_UM.Close;
  quSpecO_LS.Close;
  quSpecO_US.Close;
end;

end.
