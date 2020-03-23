unit unResultBlocksPowerConsuming;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TeEngine, Series, TeeProcs, Chart,
  DbChart, TeePrevi, DB, ADODB, Grids, DBGrids;
type
  TfmResultBlocksPowerConsuming = class(TForm)
    pnBtns: TPanel;
    btClose: TButton;
    btPrint: TButton;
    TabControl: TTabControl;
    dbchGxSpecific: TDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    dsSpecE: TDataSource;
    quSpecE_L: TADOQuery;
    quSpecE_U: TADOQuery;
    quSpecE_LLsm: TIntegerField;
    quSpecE_LValue: TFloatField;
    quSpecE_ULsm: TIntegerField;
    quSpecE_UValue: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  fmResultBlocksPowerConsuming: TfmResultBlocksPowerConsuming;

implementation

uses unDM;

{$R *.dfm}

procedure TfmResultBlocksPowerConsuming.FormCreate(Sender: TObject);
var i:integer;
    SpecGx_L,SpecGx_U:Double;
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  TabControl.TabIndex := 0;
  TabControlChange(nil);
  quSpecE_L.Open;
  quSpecE_U.Open;


  i:=1;
  while (not quSpecE_L.Eof)  and (not quSpecE_U.Eof) do
  begin
    SpecGx_L := 100* quSpecE_LValue.Value/quSpecE_LLsm.Value;
    SpecGx_U := 100*  quSpecE_UValue.Value/quSpecE_ULsm.Value;
    Series1.AddXY(i, SpecGx_L);
    Series2.AddXY(i, SpecGx_U);
    Series3.AddXY(i, SpecGx_L+SpecGx_U);


    quSpecE_L.Next;
    quSpecE_U.Next;
    inc(i);
   // ShowMessage();
  end;

end;{FormCreate}

procedure TfmResultBlocksPowerConsuming.btPrintClick(Sender: TObject);
begin
  ChartPreview(fmResultBlocksPowerConsuming, dbchGxSpecific);
end;{btPrintClick}

procedure TfmResultBlocksPowerConsuming.TabControlChange(Sender: TObject);
begin
  dbchGxSpecific.Title.Text[1] := Format('(%s)',[TabControl.Tabs[TabControl.TabIndex]]);
  dbchGxSpecific.Series[0].Active := TabControl.TabIndex=0;
  dbchGxSpecific.Series[1].Active := TabControl.TabIndex=1;
  dbchGxSpecific.Series[2].Active := TabControl.TabIndex=2;
end;{TabControlChange}

procedure TfmResultBlocksPowerConsuming.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  quSpecE_L.Close;
  quSpecE_U.Close
end;

end.
