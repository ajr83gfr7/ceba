unit unResultEconomEffect_Data;

interface
uses
  Classes, Grids;

type
  TTypeOfParams = (StrParam, IntParam, FloatParam);
  TCatOfParams = (CatBase, CatSebadan, CatInput, CatOutput);

  TParam = class
  protected
    _name: string;
    _type: TTypeOfParams;
    _category: TCatOfParams;
    _tag: integer;
  private
    function _getName: string;
    function _isStrParam: boolean;
    function _isIntParam: boolean;
  public
    constructor Create(name: string; category: TCatOfParams);
    property Name: string read _getName;
    property IsStrParam: boolean read _isStrParam;
    property IsIntParam: boolean read _isIntParam;
    property Category: TCatOfParams read _category;
    property Tag: integer read _tag;
  end;

  TStrParam = class(TParam)
  protected
    _value: string;
  private
    function _getValue: string;
    procedure _setValue(value: string);
  public
    constructor Create(name: string; value: string; category: TCatOfParams);
    property Value: string read _getValue write _setValue;
  end;

  TIntParam = class(TParam)
  protected
    _value: integer;
  private
    function _getValue: integer;
    procedure _setValue(value: integer);
  public
    constructor Create(name: string; value: integer; category: TCatOfParams);
    property Value: integer read _getValue write _setValue;
  end;

  TFloatParam = class(TParam)
  protected
    _value: double;
  private
    function _getValue: double;
    procedure _setValue(value: double);
  public
    constructor Create(name: string; value: double; category: TCatOfParams);
    property Value: double read _getValue write _setValue;
  end;

  TEffectParams = class
  protected
    _name: String;
    _date: String;
    _id: integer;
    _openpitId: integer;
    _items: TList; //of TParam
    _count: integer;
    function _getItemByName(index: string): TParam;
    procedure _setItemByName(index: string; item: TParam);
    function _getDataByName(index: string): string;
    function _getValue(index: string): double;
    function _getSebadanItems: TList;
    function _getInputItems: TList;
    function _getOutputItems: TList;
  public
    constructor Create(AName: string; AId:integer; AOpenpitId: integer; ADate:string);
    destructor Destroy; override;
    procedure Clear;
    procedure Add(param: TParam);
    property Count: integer read _count;
    property Name: string read _name;
    property Id: integer read _id;
    property OpenpitId: integer read _openpitId;
    property Date: string read _date;
    property Names[index: string]: TParam read _getItemByName write _setItemByName;
    property ValueOf[index: string]: string read _getDataByName;
    property Value[index: string]: double read _getValue;
    property CebadanItems: TList read _getSebadanItems;
    property InputItems: TList read _getInputItems;
    property OutputItems: TList read _getOutputItems;
  end;

implementation
uses
  SysUtils;
{ TParam }

constructor TParam.Create(name: string; category: TCatOfParams);
begin
  _name:= name;
  _category:= category;
  inc(_tag);
end;

function TParam._getName: string;
begin
  Result:= _name;
end;

function TParam._isIntParam: boolean;
begin
  Result:= _type = IntParam;
end;

function TParam._isStrParam: boolean;
begin
  Result:= _type = StrParam;
end;

{ TStrParam }

constructor TStrParam.Create(name, value: string; category: TCatOfParams);
begin
  inherited Create(name, category);

  _value:= value;
  _type:= StrParam;
end;

function TStrParam._getValue: string;
begin
  Result:= _value;
end;

procedure TStrParam._setValue(value: string);
begin
  _value:= value;
end;

{ TFloatParam }

function TFloatParam._getValue: double;
begin
  Result:= _value;
end;

procedure TFloatParam._setValue(value: double);
begin
  _value:= value;
end;

constructor TFloatParam.Create(name: string; value: double;
  category: TCatOfParams);
begin
  inherited Create(name, category);

  _value:= value;
  _type:= FloatParam;
end;

{ TIntParam }

constructor TIntParam.Create(name: string; value: integer; category: TCatOfParams);
begin
  inherited Create(name, category);

  _value:= value;
  _type:= IntParam;
end;

function TIntParam._getValue: integer;
begin
  Result:= _value;
end;

procedure TIntParam._setValue(value: integer);
begin
  _value:= value;
end;

{ TEffectParams }

constructor TEffectParams.Create(AName: string; AId:integer; AOpenpitId: integer; ADate:string);
begin
  _name:= AName;
  _id:= AId;
  _openpitId:= AOpenpitId;
  _date:= ADate;
  _items:= TList.Create();
  _count:= 0;
end;

destructor TEffectParams.Destroy;
begin
  _items.Free;

  inherited;
end;

function TEffectParams._getSebadanItems: TList;
var
  i:integer;
begin
  Result:= TList.Create;
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Category = CatSebadan then
      Result.Add(_items[i]);
end;

function TEffectParams._getInputItems: TList;
var
  i:integer;
begin
  Result:= TList.Create;
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Category = CatInput then
      Result.Add(_items[i]);
end;

function TEffectParams._getOutputItems: TList;
var
  i:integer;
begin
  Result:= TList.Create;
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Category = CatOutput then
      Result.Add(_items[i]);
end;

function TEffectParams._getItemByName(index: string): TParam;
var
  i: integer;
begin
  Result:= Nil;
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Name = index then
    begin
      Result:= _items[i];
      Break;
    end;
end;

function TEffectParams._getDataByName(index: string): string;
var
  i: integer;

  function _str(str: string): string; overload;
  var
    i: integer;
  begin
    for i:= 0 to length(str) do
      if str[i] = ',' then str[i]:= '.';

    Result:= str;
  end;
begin
  Result:= '';
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Name = index then
    begin
      case TParam(_items[i])._type of
        StrParam: Result:= TStrParam(_items[i]).Value;
        IntParam: Result:= _str(Format('%d',[TIntParam(_items[i]).Value]));
        FloatParam: Result:= _str(Format('%.3f',[TFloatParam(_items[i]).Value]));
      end;
      Break;
    end;
end;

procedure TEffectParams._setItemByName(index: string; item: TParam);
var
  i: integer;
begin
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Name = index then
    begin
      _items[i]:= item;
      Break;
    end;
end;

procedure TEffectParams.Clear;
begin
  _items.Clear();
end;

procedure TEffectParams.Add(param: TParam);
begin
  _items.Add(param);
  _count:= _count + 1;
end;

function TEffectParams._getValue(index: string): double;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Name = index then
    begin
      case TParam(_items[i])._type of
//        IntParam: Result:= Double(TIntParam(_items[i]).Value);
        FloatParam: Result:= TFloatParam(_items[i]).Value;
      end;
      Break;
    end;
end;

end.
