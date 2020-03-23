unit esaAydarTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, StdCtrls, DBCtrls, Mask, Grids, DBGrids,
  ComCtrls, Spin;

type
  RSuleymen=record
    v0 : Single;//Скорость начальная, км/ч
    w0 : Single;//уд.сопротивление качению, кН/т
    w1 : Single;//уд.сопротивление качению, кН/т с поправкой на порожние авто
    w2 : Single;//уд.сопротивление качению, %
    Fk : Single;//сила тяги, кН
    i  : Single;//сопротивление от уклона, %
    Wk0: Single;//Суммарное сопротивление, уд.ед
    Wk1: Single;//Суммарное сопротивление, кН
    v1 : Single;//Скорость конечная, км/ч
    dT : Single;//Время движения, sec
  end;{RSuleymen}
  RAydar=record
    v0 : Single;//Скорость начальная, км/ч
    w0 : Single;//уд.сопротивление качению, кН/т
    w1 : Single;//уд.сопротивление качению, кН/т с поправкой на порожние авто
    w2 : Single;//уд.сопротивление качению, %
    Fk : Single;//сила тяги, кН
    i  : Single;//сопротивление от уклона, %
    Wk0: Single;//Суммарное сопротивление, уд.ед
    Wk1: Single;//Суммарное сопротивление, кН
    v1 : Single;//Скорость конечная, км/ч
    dT : Single;//Время движения, sec
  end;{RAydar}
  RItem=record
    L: Integer; //Длина, m
    i: Integer; //Уклон, o/oo
    S: Integer; //Текущий километраж, м
    T: Single;  //Время, затраченное на прохождение данного участка, мин
    Suleymen: RSuleymen;
    Aydar: RAydar;
  end;
  TfmAydarTest = class(TForm)
    PageControl: TPageControl;
    tsParams: TTabSheet;
    tsGraphik: TTabSheet;
    gbAuto: TGroupBox;
    lbAuto: TLabel;
    dblcbAuto: TDBLookupComboBox;
    dbeKPDnom: TDBEdit;
    lbKPDnom: TLabel;
    dbeP: TDBEdit;
    lbP: TLabel;
    lbQ: TLabel;
    lbKPDfact: TLabel;
    edKPDfact: TEdit;
    edQ: TEdit;
    gbRoadCoats: TGroupBox;
    lbRoadCoats: TLabel;
    dblcbRoadCoats: TDBLookupComboBox;
    dbgFks: TDBGrid;
    dbgRoadCoats: TDBGrid;
    PaintBox: TPaintBox;
    gbParams: TGroupBox;
    StringGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaintBoxPaint(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure edKPDfactKeyPress(Sender: TObject; var Key: Char);
  private
    FMinX,FMaxX: Integer;// m
    FMinV,FMaxV: Integer;// km/h
    FMinT,FMaxT: Integer;// sec
    FMinI,FMaxI: Integer;// o/oo
    FCount: Integer;
    FItems: array of RItem;
    procedure DrawSpeeds(const W,H: Integer; const ABound: TRect);
    procedure DrawProfil(const W,H: Integer; const ABound: TRect);
    procedure DefineSuleymen(KPDnom,KPDFact,P,Q: Single);
    function DefineFk(const V: Single): Single;
    function DefineW0_(const V,P,Q: Single): Single;
    function DefineSuleyW0_(const P: Single): Single;
    procedure DefineAydar(KPDnom, KPDFact, P, Q: Single);
  public
  end;{TfmAydarTest}

var
  fmAydarTest: TfmAydarTest;

implementation

uses unDM, Math, Types, Globals;

{$R *.dfm}

procedure TfmAydarTest.FormCreate(Sender: TObject);
var I: Integer;
begin
  with fmDM do
  begin
    quAutoEngines.Open;
    quAutos.Open;
    dblcbAuto.KeyValue := quAutosId_Auto.AsInteger;
    quAutoFks.Open;
    quRoadCoats.Open;
    quRoadCoatUSKs.Open;
    edKPDfact.Text := FormatFloat('0.00',0.71);
    edQ.Text := '0';
    dblcbRoadCoats.KeyValue := quRoadCoatsId_RoadCoat.AsInteger;
    PageControl.ActivePageIndex := 0;
    StringGrid.Cells[0,0] := '№';
    StringGrid.Cells[1,0] := 'L, м';
    StringGrid.Cells[2,0] := 'i, o/oo';
    for I := 1 to StringGrid.RowCount-1 do
    begin
      StringGrid.Cells[0,I] := IntToStr(I);
      StringGrid.Cells[1,I] := '100';
      StringGrid.Cells[2,I] := '0';
    end;{for}
  end;{with}
  FItems := nil;
  FCount := 0;
end;{FormCreate}

procedure TfmAydarTest.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with fmDM do
  begin
    quAutoFks.Close;
    quAutos.Close;
    quAutoEngines.Close;
    quRoadCoatUSKs.Close;
    quRoadCoats.Close;
  end;{with}
  FItems := nil;
  FCount := 0;
end;{FormClose}

procedure TfmAydarTest.FormResize(Sender: TObject);
begin
  StringGrid.DefaultColWidth := (StringGrid.ClientWidth-40)div StringGrid.ColCount;
end;{FormResize}
procedure TfmAydarTest.FormShow(Sender: TObject);
begin
  Align := alClient;
end;{FormShow}

procedure TfmAydarTest.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
  case StringGrid.Col of
    1: if not(Key in ['0'..'9',#8])
       then Key := #0;
    2: if not(Key in ['0'..'9',#8,'-'])
       then Key := #0;
  end;{case}
end;{StringGridKeyPress}

procedure TfmAydarTest.StringGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AIndex,I: Integer;
begin
  if (Shift=[])and(Key=VK_DOWN)and
     (StringGrid.Row=StringGrid.RowCount-1)and(StringGrid.RowCount<21)then
  begin
    StringGrid.RowCount := StringGrid.RowCount+1;
    StringGrid.Row := StringGrid.RowCount-1;
    StringGrid.Cells[0,StringGrid.Row] := IntToStr(StringGrid.RowCount-1);
    StringGrid.Cells[1,StringGrid.Row] := '100';
    StringGrid.Cells[2,StringGrid.Row] := '0';
  end;{if}
  if (Shift=[])and(Key=VK_RETURN)then
  if StringGrid.Col=1 then StringGrid.Col := 2
  else
  if StringGrid.Col=2 then
  begin
    StringGrid.Col := 1;
    if StringGrid.Row<StringGrid.RowCount-1
    then StringGrid.Row := StringGrid.Row+1
    else
    if StringGrid.RowCount<21 then
    begin
      StringGrid.RowCount := StringGrid.RowCount+1;
      StringGrid.Row := StringGrid.RowCount-1;
      StringGrid.Cells[0,StringGrid.Row] := IntToStr(StringGrid.RowCount-1);
      StringGrid.Cells[1,StringGrid.Row] := '100';
      StringGrid.Cells[2,StringGrid.Row] := '0';
    end;{if}
  end;{if}
  if (Shift=[ssCtrl])and(Key=VK_DELETE) then
  if StringGrid.RowCount>11 then
  begin
    AIndex := StringGrid.Row;
    if StringGrid.Row=StringGrid.RowCount-1 then StringGrid.Row := StringGrid.Row-1;
    for I := AIndex+1 to StringGrid.RowCount-1 do
    begin
      StringGrid.Cells[1,I-1] := StringGrid.Cells[1,I];
      StringGrid.Cells[2,I-1] := StringGrid.Cells[2,I];
    end;{for}
    StringGrid.RowCount := StringGrid.RowCount-1;
    for I := 1 to StringGrid.RowCount-1 do
      StringGrid.Cells[0,I] := IntToStr(I);
  end;{if}
end;{StringGridKeyDown}

procedure TfmAydarTest.PaintBoxPaint(Sender: TObject);
const Step=50;
var
  ABound: TRect;
  W,H: Integer;
begin
  W := PaintBox.Width;
  H := PaintBox.Height;
  with PaintBox.Canvas do
  begin
    Brush.Color := clBlack;
    Pen.Color := clWhite;
    Font.Color := clWhite;
    Font.Name := 'Courer New';
    Rectangle(0,0,W,H);
    //
    ABound := Rect(Step,Step,W-Step,3*(H div 4)-Step);
    DrawSpeeds(W,H,ABound);
    ABound := Rect(Step,3*(H div 4)+Step,W-Step,H-Step);
    DrawProfil(W,H,ABound);
  end;{with}
end;{PaintBoxPaint}
procedure TfmAydarTest.DrawSpeeds(const W,H: Integer; const ABound: TRect);
var
  I,X,Y: Integer;
  S: String;
begin
  with PaintBox.Canvas do
  begin
    Pen.Color := clWhite;
    Pen.Width := 1;
    Pen.Style := psSolid;
    //OX Ticks
    for I := 1 to FCount-1 do
    begin
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I].S-FMinX)/(FMaxX-FMinX));
      Y := ABound.Bottom;
      Pen.Color := clDkGray;
      Pen.Style := psDot;
      MoveTo(X,ABound.Top); LineTo(X,ABound.Bottom);
      Pen.Color := clWhite;
      Pen.Style := psSolid;
      MoveTo(X,Y-5); LineTo(X,Y+5);
      S := IntToStr(FItems[I].S);
      TextOut(X-(TextWidth(S)div 2),Y+10,S);
    end;{for}
    //OY Ticks
    Pen.Color := clWhite;
    Pen.Width := 1;
    Pen.Style := psSolid;
    for I := 1 to FMaxV div 10 do
    begin
      X := ABound.Left;
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(I*10-FMinV)/(FMaxV-FMinV)));
      MoveTo(X-5,Y); LineTo(X,Y);
      S := IntToStr(I*10);
      TextOut(X-TextWidth(S)-5,Y,S);
    end;{for}
    for I := 1 to FMaxT div 10 do
    begin
      X := ABound.Left;
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(I*10-FMinT)/(FMaxT-FMinT)));
      MoveTo(X,Y); LineTo(X+5,Y);
      S := IntToStr(I*10);
      TextOut(X+5,Y,S);
    end;{for}
    //Axes
    MoveTo(ABound.Left,ABound.Top);
    LineTo(ABound.Left,ABound.Bottom);
    LineTo(ABound.Right,ABound.Bottom);
    TextOut(ABound.Left-TextWidth('V, км/ч')-2,ABound.Top-2*TextHeight('V, км/ч'),'V, км/ч');
    TextOut(ABound.Right,ABound.Bottom+2*TextHeight('S, м'),'S, м');
    TextOut(ABound.Left+2,ABound.Top-2*TextHeight('T, сек'),'T, сек');
    //Suley------------------------------------------------------------------------------------
    Pen.Width := 1;
    Pen.Color := clRed;
    //Suley V
    Pen.Style := psSolid;
    for I := 1 to FCount-1 do
    begin
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I-1].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I].Suleymen.v0-FMinV)/(FMaxV-FMinV)));
      MoveTo(X,Y);
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I].Suleymen.v1-FMinV)/(FMaxV-FMinV)));
      LineTo(X,Y);
      TextOut(X,Y,FormatFloat('0.#',FItems[I].Suleymen.v1));
    end;{for}
    //Aydar------------------------------------------------------------------------------------
    Pen.Style := psDot;
    Pen.Color := clBlue;
    //Aydar dT
    for I := 1 to FCount-1 do
    begin
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I-1].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(0.0-FMinT)/(FMaxT-FMinT)));
      MoveTo(X,Y);
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I].Aydar.dT-FMinT)/(FMaxT-FMinT)));
      LineTo(X,Y);
      TextOut(X,Y,FormatFloat('0.#',FItems[I].Aydar.dT));
    end;{for}
    //Aydar V
    Pen.Color := clRed;
    for I := 1 to FCount-1 do
    begin
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I-1].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I].Aydar.v0-FMinV)/(FMaxV-FMinV)));
      MoveTo(X,Y);
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I].Aydar.v1-FMinV)/(FMaxV-FMinV)));
      LineTo(X,Y);
      TextOut(X,Y,FormatFloat('0.#',FItems[I].Aydar.v1));
    end;{for}
    //
    Pen.Style := psSolid;
    Pen.Width := 1;
    Pen.Color := clWhite;
  end;{with}
end;{DrawSpeeds}
procedure TfmAydarTest.DrawProfil(const W,H: Integer; const ABound: TRect);
var
  I,X,Y: Integer;
  S: String;
begin
  with PaintBox.Canvas do
  begin
    //OX Ticks
    Pen.Style := psDot;
    Pen.Color := clDkGray;
    for I := 1 to FCount-1 do
    begin
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I].S-FMinX)/(FMaxX-FMinX));
      MoveTo(X,ABound.Top); LineTo(X,ABound.Bottom);
    end;{for}
    Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(0-FMinI)/(FMaxI-FMinI)));
    MoveTo(ABound.Left,Y); LineTo(ABound.Right,Y);
    TextOut(ABound.Left-TextWidth('i, o/oo '),Y,'i, o/oo');
    Pen.Style := psSolid;
    MoveTo(ABound.Left,ABound.Top); LineTo(ABound.Right,ABound.Top);
    LineTo(ABound.Right,ABound.Bottom);LineTo(ABound.Left,ABound.Bottom);
    LineTo(ABound.Left,ABound.Top);
    
    Pen.Color := clWhite;
    Pen.Style := psSolid;
    for I := 1 to FCount-1 do
    begin
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I-1].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I-1].I-FMinI)/(FMaxI-FMinI)));
      MoveTo(X,Y);
      X := Round(ABound.Left+(ABound.Right-ABound.Left)*(FItems[I].S-FMinX)/(FMaxX-FMinX));
      Y := Round(ABound.Top+(ABound.Bottom-ABound.Top)*(1-(FItems[I].I-FMinI)/(FMaxI-FMinI)));
      LineTo(X,Y);
      S := IntToStr(FItems[I].I);
      TextOut(X-(TextWidth(S)div 2),Y+10,S);
    end;{for}
    //Axes
//    Rectangle(ABound.Left,ABound.Top,ABound.Right,ABound.Bottom);
  end;{with}
end;{DrawProfil}
procedure TfmAydarTest.PageControlChange(Sender: TObject);
var I: Integer;
begin
  if PageControl.ActivePageIndex=0 then Exit;
  FCount := StringGrid.RowCount;
  SetLength(FItems,FCount);
  FMinX := 0; FMaxX := 1000;
  FMinV := 0; FMaxV := 100;
  FMinT := 0; FMaxT := 10;
  FMinI := -10; FMaxI := 10;
  FItems[0].L := 0;
  FItems[0].i := 0;
  FItems[0].S := 0;
  FItems[0].Suleymen.v1 := 0;
  FItems[0].Aydar.v1 := 0;
  for I := 1 to FCount-1 do
  begin
    if StringGrid.Cells[1,I]='' then StringGrid.Cells[1,I] := '100';
    if StringGrid.Cells[2,I]='' then StringGrid.Cells[1,I] := '0';
    try
      FItems[I].L := StrToInt(StringGrid.Cells[1,I]);
    except
      StringGrid.Cells[1,I] := '100';
      FItems[I].L := 100;
    end;{try}
    try
      FItems[I].i := StrToInt(StringGrid.Cells[2,I]);
    except
      StringGrid.Cells[2,I] := '0';
      FItems[I].i := 0;
    end;{try}
    FItems[I].S := FItems[I-1].S+FItems[I].L;
    if FMaxX<FItems[I].S then FMaxX := FItems[I].S;
    if FMinI>FItems[I].i then FMinI := FItems[I].i;
    if FMaxI<FItems[I].i then FMaxI := FItems[I].i;
  end;{for}
  DefineSuleymen(fmDM.quAutosTransmissionKPD.AsFloat,StrToFloat(edKPDfact.Text),
                 fmDM.quAutosP.AsFloat,StrToFloat(edQ.Text));
  DefineAydar(fmDM.quAutosTransmissionKPD.AsFloat,StrToFloat(edKPDfact.Text),
              fmDM.quAutosP.AsFloat,StrToFloat(edQ.Text));
  for I := 1 to FCount-1 do
  begin
    if FMaxV<FItems[I].Suleymen.v1 then FMaxV := Round(FItems[I].Suleymen.v1);
    if FMaxV<FItems[I].Aydar.v1 then FMaxV := Round(FItems[I].Aydar.v1);
    if FMaxT<FItems[I].Aydar.dT then FMaxT := Round(FItems[I].Aydar.dT);
  end;{for}
  if FMaxT mod 10 <>0
  then FMaxT := FMaxT-(FMaxT mod 10)+10;
end;{PageControlChange}

procedure TfmAydarTest.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  Value: Single;
  I,J: Integer;
begin
  if PageControl.ActivePageIndex=0 then
  begin
    if fmDM.quAutoFks.RecordCount=0 then
    begin
      esaMsgError(Format('У авто "%s" не заданы тяговые характеристики',[fmDM.quAutosName.AsString]));
      dblcbAuto.SetFocus;
      AllowChange := false;
      Exit;
    end;{if}
    try
      Value := StrToFloat(edKPDfact.Text);
      if not InRange(Value,0.0,1.0)then raise Exception.Create('');
    except
      esaMsgError(Format('Неверное значение KPDfact ''%s''. Допустимый диапазон: [0..1]',[edKPDfact.Text]));
      edKPDfact.SetFocus;
      AllowChange := false;
      Exit;
    end;{try}
    try
      Value := StrToFloat(edQ.Text);
      if Value<0.0 then raise Exception.Create('');
    except
      esaMsgError(Format('Неверное значение Q ''%s''. Допустимый диапазон: [0..oo]',[edQ.Text]));
      edQ.SetFocus;
      AllowChange := false;
      Exit;
    end;{try}
    for I := 1 to StringGrid.RowCount-1 do
    begin
      try
        J := StrToInt(StringGrid.Cells[1,I]);
        if J<1 then raise Exception.Create('');
      except
        esaMsgError(Format('Неверное значение L ''%s''. Допустимый диапазон: [1..oo]',[StringGrid.Cells[1,I]]));
        StringGrid.SetFocus;
        StringGrid.Row := I;
        StringGrid.Col := 1;
        AllowChange := false;
        Exit;
      end;{try}
      try
        StrToInt(StringGrid.Cells[2,I]);
      except
        esaMsgError(Format('Неверное значение i ''%s''.',[StringGrid.Cells[2,I]]));
        StringGrid.SetFocus;
        StringGrid.Row := I;
        StringGrid.Col := 2;
        AllowChange := false;
        Exit;
      end;{try}
    end;{for}
  end;{if}
end;{PageControlChanging}

procedure TfmAydarTest.edKPDfactKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['.',','] then Key := DecimalSeparator;
  if not(Key in ['0'..'9',DecimalSeparator,#8])then Key := #0;
  if (Key=DecimalSeparator)and(Pos(DecimalSeparator,TEdit(Sender).Text)>0)
  then Key := #0;
end;{edKPDfactKeyPress}

function TfmAydarTest.DefineFk(const V: Single): Single;
var v0,v1,F0,F1: Single;
begin
  Result := 0.0;
  with fmDM do
  begin
    quAutoFks.First;
    v0 := quAutoFksV.AsFloat;
    F0 := quAutoFksFk.AsFloat;
    v1 := quAutoFksV.AsFloat;
    F1 := quAutoFksFk.AsFloat;
    quAutoFks.Next;
    while not quAutoFks.Eof do
    begin
      v1 := quAutoFksV.AsFloat;
      F1 := quAutoFksFk.AsFloat;
      if InRange(V,v0,v1) then
      begin
        Result := F0+(F1-F0)*(V-v0)/(v1-v0);
        Break;
      end;{if}
      v0 := v1;
      F0 := F1;
      quAutoFks.Next;
    end;{while}
    if (Result<0.001)and(V>v1)
    then Result := F1;
  end;{with}
end;{DefineFk}
function TfmAydarTest.DefineW0_(const V,P,Q: Single): Single;
var
  P0,P1,Value0,Value1,percent_minus: Single;
begin
  Value0 := 0.0;
  Value1 := 0.0;
  with fmDM do
  begin
    quRoadCoatUSKs.First;
    P0 := quRoadCoatUSKsP.AsFloat;
    quRoadCoatUSKs.Next;
    while not quRoadCoatUSKs.Eof do
    begin
      P1 := quRoadCoatUsksP.AsFloat;
      if InRange(P,P0,P1) then
      begin
        Value0 := quRoadCoatUSKsValueMin.AsFloat;//kH/т
        Value1 := quRoadCoatUSKsValueMax.AsFloat;//kH/т
        Break;
      end;{if}
      P0 := P1;
      quRoadCoatUsks.Next;
    end;{while}
  end;{with}
  // находим значение W0 в соответствии со скоростью движения
  // автосамосвала
  // уравнение прямой : |x2 - x1   y2 - y1|
  //                    |x  - x1   y  - y1| = 0
  //  (x2-x1)*(y-y1) - (y2-y1)*(x-x1) = 0
  // x1 = 15; x2 = 20 км/час
  // y1 = V1; y2 = V2 кг/т
  // ATrucks[NumberAuto].Speed
  Result := ((Value1-Value0)*(V-15.0) / (20.0-15.0) ) + Value0;
  // если автосамосвал порожний, то значение W0 увеличиваем на
  // 15-29% в зависимости от скорости
  // x1 = 15; x2 = 20 км/час
  // y1 = 15%; y2 = 29%
  // ATrucks[NumberAuto].Speed
  if Q <= 0.001 then
  begin
    percent_minus := ( (29.0-15.0)*(V-15.0) / (20.0-15.0) ) + 15.0;
    Result := Result + (percent_minus/100)*Result;
  end;{if}
  if Result <= 0 then Result := 1.0;
end;{DefineW0_}
function TfmAydarTest.DefineSuleyW0_(const P: Single): Single;
var P0,P1,Value0,Value1: Single;
begin
  Value0 := 0.0;
  Value1 := 0.0;
  with fmDM do
  begin
    quRoadCoatUSKs.First;
    P0 := quRoadCoatUSKsP.AsFloat;
    quRoadCoatUSKs.Next;
    while not quRoadCoatUSKs.Eof do
    begin
      P1 := quRoadCoatUsksP.AsFloat;
      if InRange(P,P0,P1) then
      begin
        Value0 := quRoadCoatUSKsValueMin.AsFloat;//H/kH
        Value1 := quRoadCoatUSKsValueMax.AsFloat;//H/kH
        Break;
      end;{if}
      P0 := P1;
      quRoadCoatUsks.Next;
    end;{while}
  end;{with}
  Result := (Value0+Value1)*0.5;
end;{DefineSuleyW0_}
procedure TfmAydarTest.DefineSuleymen(KPDnom,KPDFact,P,Q: Single);
const
  g=9.8;// ускорение свободного падения (м/c2)
var
  v0          : Single;//Скорость начальная, км/ч
  v1          : Single;//Скорость конечная, км/ч
  w0_         : Single;//Удельное сопротивление качения, Н/kH
  wi_         : Single;//удельное сопротивление от уклона, Н/kH
  Wk          : Single;//Суммарное сопротивление, kH
  Fk          : Single;//Сила тяги, kH
  a_          : Single;//Ускорение движения, м/c2
  A           : Single;//Ускорение движения, kм/ч2
  T           : Single;//Время проезда данного БУ, sec
  S           : Single;//Расстояние, km
  Pavto       : Single;//Вес авто, кН
  I: Integer;
begin
  if FCount<2 then Exit;
  FItems[0].Suleymen.v1 := 0.0;
  Pavto := (P+Q)*g; //Вес авто, кН = 1000 кг*м/c2 = т*м/c2
  for I := 1 to FCount-1 do
  begin
    S  := FItems[I].L*0.001;//km
    v0 := FItems[I-1].Suleymen.v1;
    //удельное сопротивление качению для груженных авто, H/kH
    w0_ := DefineSuleyW0_(P);
    //удельное сопротивление качению для порожних авто, H/kH
    if Q<1.0                         //увеличиваю на 20-25%
    then w0_ := w0_+w0_*((0.20+0.25)*0.5);
    //Удельное сопротивление от уклона, H/kH
    wi_ := FItems[I].i;
    //Полное сопротивление движению, kH
    Wk := ((w0_+wi_)*Pavto)*0.001;
    //Сила тяги, kН
    Fk := DefineFk(v0);
    Fk := Fk-Fk*(KPDnom-KPDfact);
    //Ускорение движение, м/c2
    a_ := (Fk-Wk)/(P+Q);// kH/т = 1000Н/1000кг = Н/кг = (кг*m/c2)/кг = м/c2
    //Ускорение движение, км/ч2 = 0.001*м/(3600c)2
//    A := a_*(3600*3600*0.001);
    A := a_*112;
    //dV/dT=A -> (v1-v0)/(dS/((v0+v1)/2))=A -> (v1^2-v0^2)/2dS=A -> v1^2=v0^2+2*dS*A
    if v0*v0+2*S*A>0.0
    then v1 := sqrt(v0*v0+2*S*A)
    else v1 := 0.0;
    T := 3600*S/(0.5*(V0+V1));//3600*km/km/h=3600h=sec
    FItems[I].Suleymen.v0 := v0;         //Скорость начальная, км/ч
    FItems[I].Suleymen.w0 := w0_;        //уд.сопротивление качению, кН/т
    FItems[I].Suleymen.Fk := Fk;         //сила тяги, кН
    FItems[I].Suleymen.i  := wi_;        //сопротивление от уклона, %
    FItems[I].Suleymen.v1 := v1;         //Скорость конечная, км/ч
    FItems[I].Suleymen.dT := T;          //Время движения, sec
  end;{for}
end;{DefineSuleymen}

procedure TfmAydarTest.DefineAydar(KPDnom,KPDFact,P,Q: Single);
const
  g=9.8;// ускорение свободного падения (м/c2)
  dT=1;//sec
var
  dS          : Single;//Расстояние, которое авто проезжает за dT сек с v0 до v1, m
  v0          : Single;//Скорость начальная, км/ч
  v1          : Single;//Скорость конечная, км/ч
  w0          : Single;//Полное сопротивление качения, %
  Fk          : Single;//Сила тяги, kH
  Uklon       : Single;//Сопротивление от уклона, %
  SumSoprotiv : Single;//Суммарное сопротивление, в уд.единицах
  Wk          : Single;//Суммарное сопротивление, kH
  T           : Single;//Время проезда данного БУ, sec
  S           : Single;//Расстояние, которое авто проезжает за T сек с v0 до v1, m
  I: Integer;
begin
  if FCount<2 then Exit;
  FItems[0].Aydar.v1 := 0.0;
  for I := 1 to FCount-1 do
  begin
    S  := FItems[I].L;
    v0 := FItems[I-1].Aydar.v1;
    w0 := DefineW0_(v0,P,Q);//kH/т
    w0 := w0*0.1;//в %
    Fk := DefineFk(v0);
    Fk := Fk-Fk*(KPDnom-KPDfact);
    Uklon := FItems[I].i/10;//в процентах: 1% = o/oo*0.1
    SumSoprotiv := (w0+Uklon)*0.01;//в уд.единицах
    Wk := g*(P+Q)*SumSoprotiv;//kH
    v1 := v0+(dT*(Fk-Wk)/(P+Q))*3.6;//км/ч
    dS := (v0+v1)*0.5*1000/3600*dT;//м
    if dS>0.0
    then T := dT*S/dS//сек
    else T := 0.0;
    FItems[I].Aydar.v0 := v0;         //Скорость начальная, км/ч
    FItems[I].Aydar.w0 := w0*10;      //уд.сопротивление качению, кН/т
    FItems[I].Aydar.w1 := w0;         //уд.сопротивление качению, %
    FItems[I].Aydar.Fk := Fk;         //сила тяги, кН
    FItems[I].Aydar.i  := Uklon;      //сопротивление от уклона, %
    FItems[I].Aydar.Wk0:= SumSoprotiv;//Суммарное сопротивление, уд.ед;
    FItems[I].Aydar.Wk1:= Wk;         //Суммарное сопротивление, кН
    FItems[I].Aydar.v1 := v1;         //Скорость конечная, км/ч
    FItems[I].Aydar.dT := T;          //Время движения, sec
  end;{for}
end;{DefineAydar}
end.

