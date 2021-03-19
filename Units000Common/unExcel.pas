unit unExcel;

interface
uses
  ComObj, ActiveX, Variants, Windows, Messages, SysUtils, Classes;

const
  ExcelApp = 'Excel.Application';
  //exp
  xlCSV = 6;
  xlExcel8 = 56;
  xlHtml =44;
  xlOpenDocumentSpreadsheet = 60;
  xlOpenXMLWorkbook = 51;
  //border
  xlDiagonalDown = 5;
  xlDiagonalUp = 6;
  xlEdgeBottom = 9;
  xlEdgeLeft = 7;
  xlEdgeRight = 10;
  xlEdgeTop = 8;
  xlInsideHorizontal = 12;
  xlInsideVertical = 11;

resourcestring
  rsEInvalidSheetIndex = '����� �� ������ ������ ��� WorkBooks. ��������� ����� ��������';
  rsEInvalidSheetActivate = '��������� ����� ��������� � �������';
  rsESaveActiveSheet = '������ ���������� ��������� ����� �����';

type
  TExcelDoc = class
  private
    function StopExcel:boolean;
    function Close: boolean;
    function CheckExcelInstall:boolean;
    function CheckExcelRun: boolean;
    function RunExcel(DisableAlerts:boolean=true; Visible: boolean=false): boolean;
    function AddWorkBook(AutoRun:boolean=true):boolean;
    function ActivateSheet(WBIndex: integer; SheetName: string): boolean;
    procedure SetVisible(visible: boolean);
    function GetVisible(): boolean;
  protected
    document: OleVariant;
  public
    constructor Create;
    destructor Destroy; override;
    function SaveWorkBook(FileName:TFileName; WBIndex:integer):boolean;
    procedure SaveDocumentAs(const AFileName: TFileName; AFileFormat: integer=xlExcel8);
    //
    procedure SetData(sg: Variant; colcount, rowcount: integer); Virtual; Abstract;
    //procedure SetTitle(colcount: integer); Virtual; Abstract;
    property Visible: boolean read GetVisible write SetVisible;
  end;

implementation
//https://yandex.kz/turbo?utm_source=turbo_turbo&text=https%3A%2F%2Fwww.webdelphi.ru%2Fexcel-v-delphi%2F

uses
  TXTWriter;

  (*
//write to Excel
procedure TForm16.WriteData;
var i,j: integer;
    FData: Variant;
    Sheet,Range: Variant;
begin
//������� ���������� ������
  FData:=VarArrayCreate([1,StringGrid1.RowCount,1,StringGrid1.ColCount],varVariant);
//��������� ������ ������� �� StringGrid
  for i:=1 to VarArrayHighBound(FData,1) do
    for j:=1 to VarArrayHighBound(FData,2) do
      FData[i,j]:=StringGrid1.Cells[J-1,I-1];
{���������� ������ ���� �����}
//��������� �����
  ExcelApp.Workbooks.Open(edFile.Text);
//����������
  Sheet:=ExcelApp.ActiveWorkBook.Sheets[2];
  Sheet.Activate;
//�������� �������� ��� ������� ������
  Range:=Sheet.Range[Sheet.Cells[1,1],
                     Sheet.Cells[VarArrayHighBound(FData,1),
                                 VarArrayHighBound(FData,2)]];
//��������� ������
  Range.Value:=FData;
//���������� ���� Excel
  ExcelApp.Visible:=True;
end;
*)

{ TExcelDoc }

//������������ ���� ������� �����
function TExcelDoc.ActivateSheet(WBIndex: integer;
  SheetName: string): boolean;
var
  i: integer;
begin
  Result := false;
  if WBIndex > document.WorkBooks.Count then
    raise Exception.Create(rsEInvalidSheetIndex);
  try
    for i := 1 to document.WorkBooks[WBIndex].Sheets.Count do
      if AnsiLowerCase(document.WorkBooks[WBIndex].Sheets.Item[i].Name)
        = AnsiLowerCase(SheetName) then
      begin
        document.WorkBooks[WBIndex].Sheets.Item[i].Activate;
        Result := true;
        break;
      end;
  except
    raise Exception.Create(rsEInvalidSheetActivate);
  end;
end;

//������� ������ ������� �����
function TExcelDoc.AddWorkBook(AutoRun: boolean): boolean;
begin
  Result := CheckExcelRun;
  if (not Result) and (AutoRun) then
  begin
    RunExcel;
    Result := CheckExcelRun;
  end;
  if Result then
    if document.WorkBooks.Count = 0 then
      document.WorkBooks.Add;
end;

//���������, ���������� �� Excel
function TExcelDoc.CheckExcelInstall: boolean;
var
  ClassID: TCLSID;
begin
  Result:=CLSIDFromProgID(PWideChar(WideString(ExcelApp)), ClassID) = S_OK;
end;

//����������, ������� �� Excel, � �������� �� ���� ������
function TExcelDoc.CheckExcelRun: boolean;
begin
  try
    document:=GetActiveOleObject(ExcelApp);
    Result:=True;
  except
    Result:=false;
  end;
end;

function TExcelDoc.Close: boolean;
var
  i:integer;
begin
  try
    //for i:=1 to document.WorkBooks.Count do
    //  document.WorkBooks.Item[i].Close;
    document.ActiveWorkBook.Close(SaveChanges:= False);

    Result:= True;
  except
    Result:= False;
  end;
end;

constructor TExcelDoc.Create;
begin
  RunExcel;
  AddWorkBook;
end;

destructor TExcelDoc.Destroy;
begin
  Close;
  StopExcel;

  inherited;
end;

//��������� Excel
function TExcelDoc.RunExcel(DisableAlerts, Visible: boolean): boolean;
begin
  try
//��������� ���������� �� Excel
    if CheckExcelInstall then
      begin
        document:=CreateOleObject(ExcelApp);
//����������/�� ���������� ��������� ��������� Excel (����� �� ����������)
        document.Application.EnableEvents:=DisableAlerts;
        document.Visible:=Visible;
        Result:=true;
      end
    else
      begin
        MessageBox(0,'���������� MS Excel �� ������������ �� ���� ����������','������',MB_OK+MB_ICONERROR);
        Result:=false;
      end;
  except
    Result:=false;
  end;
end;

//���������� ��������
procedure TExcelDoc.SaveDocumentAs(const AFileName: TFileName;
  AFileFormat: integer);
begin
 try
   document.ActiveWorkBook.ActiveSheet.SaveAs(AFileName, AFileFormat);
  except
    raise Exception.Create(rsESaveActiveSheet);
  end;
end;

//��������� ������� �����
function TExcelDoc.SaveWorkBook(FileName: TFileName;
  WBIndex: integer): boolean;
begin
  try
    document.WorkBooks.Item[WBIndex].SaveAs(FileName);
    if document.WorkBooks.Item[WBIndex].Saved then
      Result:=true
    else
      Result:=false;
  except
    Result:=false;
  end;
end;

procedure TExcelDoc.SetVisible(visible: boolean);
begin
  document.visible:= visible;
end;

function TExcelDoc.GetVisible: boolean;
begin
  Result:= document.visible;
end;

function TExcelDoc.StopExcel: boolean;
begin
  try
    if document.Visible then
      document.Visible:=false;
    document.Quit;
    document:= Unassigned;
    Result:=True;
  except
    Result:=false;
  end;
end;

end.
