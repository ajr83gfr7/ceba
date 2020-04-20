unit unResultEconomEffect_Data;

interface
uses
  Classes;

type
  TTypeOfParams = (StrParam, IntParam, FloatParam);
  TCatOfParams = (CatSebadan, CatInput, CatOutput);

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
    _items: TList; //of TParam
//    function _getItem(index: integer): TParam;
//    procedure _setItem(index: integer; item: TParam);
    function _getItemByName(index: string): TParam;
    procedure _setItemByName(index: string; item: TParam);
    function _getDataByName(index: string): string;
    function _getSebadanItems: TList;
    function _getInputItems: TList;
    function _getOutputItems: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(param: TParam);
//    property Items[index: integer]: TParam read _getItem write _setItem;
    property Names[index: string]: TParam read _getItemByName write _setItemByName;
    property ValueOf[index: string]: string read _getDataByName;    
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
(*
function TEffectParams._getItem(index: integer): TParam;
begin
  Result:= _items[index];
end;

procedure TEffectParams._setItem(index: integer; item: TParam);
begin
  _items.Add(item);
end;
*)

constructor TEffectParams.Create;
begin
  _items:= TList.Create();
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
begin
  Result:= '';
  for i:= 0 to _items.Count - 1 do
    if TParam(_items[i]).Name = index then
    begin
      case TParam(_items[i])._type of
        StrParam: Result:= TStrParam(_items[i]).Value;
        IntParam: Result:= Format('%d',[TIntParam(_items[i]).Value]);
        FloatParam: Result:= Format('%.3f',[TFloatParam(_items[i]).Value]);
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
end;

end.
