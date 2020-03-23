unit unResultAutoSpeeds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, Series, DB, ADODB,
  DbChart;

type
  TfmResultAutoSpeeds = class(TForm)
    Splitter1: TSplitter;
    chrVkmh: TChart;
    
    chrWkH: TChart;

    pnBtns: TPanel;
    btPrint: TButton;
    btClose: TButton;
    Series1: TLineSeries;
    Series2: TLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btPrintClick(Sender: TObject);
  private
    procedure ClearAutoSpeeds;
  public
    procedure LoadFromFile(const AAutoIndex: Integer);
  end;{TfmResultAutoSpeeds}

var
  fmResultAutoSpeeds: TfmResultAutoSpeeds;

implementation

uses Globals, esaModelingResults, TeePrevi;

{$R *.dfm}

procedure TfmResultAutoSpeeds.ClearAutoSpeeds;
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
end;{ClearAutoSpeeds}
procedure TfmResultAutoSpeeds.FormCreate(Sender: TObject);
begin
  ClearAutoSpeeds;
end;{FormCreate}
procedure TfmResultAutoSpeeds.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClearAutoSpeeds;
end;{FormClose}

procedure TfmResultAutoSpeeds.LoadFromFile(const AAutoIndex: Integer);
var
  AFileHandle    : Integer;    //ƒескриптор файла
  AResultItem    : PResultItem;//”казатель на ResultItem
  AAuto          : RResultAuto;//”казатель на ResultAuto
  I,ACount       : Integer;
  AResultItems   : TList;
  APath          : String;//
begin
  Series1.Clear;
  Series2.Clear;
  //Check all files' existing -----------------------------------------------------------------
  APath := ExtractFilePath(Application.ExeName);
  if not FileExists(APath+'ResultItems.esa')then Exit;
  if not FileExists(APath+'ResultAutos.esa')then Exit;
  Screen.Cursor := crHourGlass;
  //ResultItems -------------------------------------------------------------------------------
  AResultItems := TList.Create;
  AFileHandle := FileOpen(APath+'ResultItems.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultItem;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      New(AResultItem);
      FileRead(AFileHandle,AResultItem^,SizeResultItem);
      AResultItems.Add(AResultItem);
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  //ResultAutos -------------------------------------------------------------------------------
  AFileHandle := FileOpen(APath+'ResultAutos.esa',fmOpenRead);
  try
    ACount := FileSeek(AFileHandle,0,2) div SizeResultAuto;
    FileSeek(AFileHandle,0,0);
    for I := 0 to ACount-1 do
    begin
      FileRead(AFileHandle,AAuto,SizeResultAuto);
      if AAuto.AutoIndex=AAutoIndex then
      begin
       Series1.AddXY(PResultItem(AResultItems[AAuto.ResultItemIndex])^.dTsec/60,AAuto.Vkmh);
       Series2.AddXY(PResultItem(AResultItems[AAuto.ResultItemIndex])^.dTsec/60,abs(AAuto.W)*0.001);
      end;{if}
    end;{for}
  finally
    FileClose(AFileHandle);
  end;{try}
  ClearList(AResultItems);
  AResultItems.Free;
  Screen.Cursor := crDefault;
end;{LoadFromFile}

procedure TfmResultAutoSpeeds.btPrintClick(Sender: TObject);
begin
  ChartPreview(fmResultAutoSpeeds, chrVkmh);
  ChartPreview(fmResultAutoSpeeds, chrWkH);
end;{btPrintClick}

end.
