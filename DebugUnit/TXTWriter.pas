unit TXTWriter;

interface
uses
  SysUtils, Globals;
type
  TWriter = class
  public
    constructor Create();
    class procedure WriteToTXT(input: string; _tempFile: string = 'test.txt');
    class function GetAutoState(state: TAutoState): string;
    class function GetAutoDirection(dir: TAutoDirection): string;
//    class function GetAutoEventKind(dir: TesaResultAutoEventKind): string;
  end;

implementation

constructor TWriter.Create;
begin
  inherited;
end;

class function TWriter.GetAutoDirection(dir: TAutoDirection): string;
begin
  //TAutoDirection=(adLoading,adUnLoading,adFromSP,adToSP,adUnknown);
  case dir of
    adLoading: Result:= 'adLoading';
    adUnLoading: Result:= 'adUnLoading';
    adFromSP: Result:= 'adFromSP';
    adToSP: Result:= 'adToSP';
    adUnknown: Result:= 'adUnknown';
  else Result:= 'adUnknown';
  end;
end;

class function TWriter.GetAutoState(state: TAutoState):string;
begin
  //  TAutoState=(asMovingFk,asMovingHh,asMovingBt,asWaiting,asAbort,asUnWorked,asDone);
  case state of
    asMovingFk: Result:= 'asMovingFk';
    asMovingHh: Result:= 'asMovingHh';
    asMovingBt: Result:= 'asMovingBt';
    asWaiting: Result:= 'asWaiting';
    asAbort: Result:= 'asAbort';
    asUnWorked: Result:= 'asUnWorked';
    asDone: Result:= 'asDone';
  else Result:= 'asUnknown';
  end;
end;

class procedure TWriter.WriteToTXT(input: string; _tempFile: string = 'test.txt');
const
  _tempDir= '\Temp\';
var
  _file: TextFile;
  _fileName: string;
  _currentDir: string;
begin
  if( not DirectoryExists('Temp') )then
    CreateDir('Temp');
  _currentDir:= GetCurrentDir + _tempDir;
  _fileName:= _currentDir + _tempFile;

  AssignFile(_file, _fileName);
  if not FileExists(_fileName) then
  begin
    Rewrite(_file);
    Writeln(_file, 'File Created : ' + datetimetostr(now));
    CloseFile(_file);
  end;
  Append(_file);
  //
  Writeln(_file, input);
  CloseFile(_file);
end;

end.
