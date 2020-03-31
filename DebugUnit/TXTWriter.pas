unit TXTWriter;

interface
uses
  SysUtils;
type
  TWriter = class
  public
    constructor Create();
    class procedure WriteToTXT(input: string);
  end;

implementation

constructor TWriter.Create;
begin
  inherited;
end;

class procedure TWriter.WriteToTXT(input: string);
const
  _tempDir= '\Temp\';
  _tempFile= 'test.txt';
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
