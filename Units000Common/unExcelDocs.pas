unit unExcelDocs;

interface
uses
  ComObj, ActiveX, Variants, Windows, Messages, SysUtils, Classes,
  unExcel;

efecrtParam = Record
  name: string;
  value: variant
end;
TParam = class
  name: string;
private
  function GetName: string;
public
  property Name read GetName:string;
end;

TStrParam = class(TParam)
  value: string;
private
  function GetValue: string;
public
  property Value read GetValue:string;
end;

TIntParam = class(TParam)
  value: integer;
private
  function GetValue: integer;
public
  property Value read GetValue:integer;
end;

implementation

//Основные показатели эффективности
//Дата формирования:date
//-------------------------------------
//| Параметр | Варианты моделирования |
//-------------------------------------
//|          | 0 to countOfVariants   |
//-------------------------------------
//| Данные с CEBEDAN                  |
//-------------------------------------
//|          |                        |
//-------------------------------------
//| Входные данные                    |
//-------------------------------------
//|          |                        |
//-------------------------------------
//| Выходные данные                   |
//-------------------------------------
//|          |                        |
//-------------------------------------

function getTitle(colCounts: integer):Variant;
//var
//  FData: Variant;
//begin
//  //создаем вариантный массив
//  FData:=VarArrayCreate([1,StringGrid1.RowCount,1,StringGrid1.ColCount],varVariant);
//  Result:= FData;
var  MyRange: OLEVariant;
     Cell_1, Cell_2: OLEVariant;
begin
  //Cell_1:=MyExcel.ActiveWorkBook.ActiveSheet.Cells[1,1];
  //Cell_2:=MyExcel.ActiveWorkBook.ActiveSheet.Cells[5,3];
  //MyRange:=MyExcel.ActiveWorkBook.ActiveSheet.Range[Cell_1, Cell_2]
end;

end.
