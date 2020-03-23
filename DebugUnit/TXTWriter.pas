unit TXTWriter;

interface
uses
  SysUtils;
type
  TWriter = class
  public
    class procedure WriteToTXT(input: string);
  end;       

implementation

  class procedure TWriter.WriteToTXT(input: string);
  var
    _file:TextFile;
    _fileName: string;
    _currentDir: string;
  begin
    if( not DirectoryExists('Temp') )then
      CreateDir('Temp');
    _currentDir:= GetCurrentDir + '\Temp\';
    _fileName:= _currentDir + 'test.txt';
    
    AssignFile(_file, _fileName);
    if not FileExists(_fileName) then
    begin
      Rewrite(_file);
      CloseFile(_file);
    end;
    Append(_file);
    Writeln(_file, input);
    CloseFile(_file);
  end;

end.
