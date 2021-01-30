unit unResultShiftAutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, DBLookupEh, DB, ADODB,
  Grids, DBGridEh, DBSumLst, ComCtrls, Excel2000;//, GridsEh;

type
  TfmResultShiftAutos = class(TForm)
    quResultShifts: TADOQuery;
    quResultShiftsId_ResultShift: TAutoIncField;
    quResultShiftsId_Openpit: TIntegerField;
    quResultShiftsShiftNaryadTmin: TFloatField;
    quResultShiftsShiftTmin: TIntegerField;
    quResultShiftsPeriodKshift: TFloatField;
    quResultShiftsPeriodTday: TIntegerField;
    dsResultShifts: TDataSource;
    pnBtns: TPanel;
    quResultShiftAutos: TADOQuery;
    quResultShiftAutosId_ResultShiftAuto: TAutoIncField;
    quResultShiftAutosId_ResultShift: TIntegerField;
    quResultShiftAutosId_DumpModel: TIntegerField;
    quResultShiftAutosDumpModel: TWideStringField;
    quResultShiftAutosDumpMaxTsec: TFloatField;
    quResultShiftAutosDumpMaxNkVt: TFloatField;
    quResultShiftAutosDumpNo: TIntegerField;
    quResultShiftAutosDumpYear: TIntegerField;
    quResultShiftAutosDumpPtn: TFloatField;
    quResultShiftAutosDumpQtn: TFloatField;
    quResultShiftAutosDumpC1000tg: TFloatField;
    quResultShiftAutosDumpAmortizationRate: TFloatField;
    quResultShiftAutosDumpTyresN: TIntegerField;
    quResultShiftAutosDumpTyreC1000tg: TFloatField;
    quResultShiftAutosDumpTyresAmortizationR1000km: TFloatField;
    dsResultShiftAutos: TDataSource;
    quResultShiftAutoReport1: TADOQuery;
    dsResultShiftAutoReport1: TDataSource;
    PageControl: TPageControl;
    tsResultShiftAutosReport1: TTabSheet;
    dbgResultShiftAutoReport1: TDBGridEh;
    tsResultShiftAutosReport2: TTabSheet;
    tsResultShiftAutosReport3: TTabSheet;
    quResultShiftAutoReport1Id_ResultShiftAuto: TIntegerField;
    quResultShiftAutoReport1RecordNo: TIntegerField;
    quResultShiftAutoReport1Value: TFloatField;
    quResultShiftAutoReport1Value1: TFloatField;
    quResultShiftAutoReport1Value2: TFloatField;
    quResultShiftAutosDumpTransmissionKPD: TFloatField;
    quResultShiftAutosDumpEngineKPD: TFloatField;
    Splitter1: TSplitter;
    dbgAutos1: TDBGridEh;
    quResultShiftsShiftPeresmenkaTmin: TIntegerField;
    quResultShiftsShiftPlanNaryadTmin: TFloatField;
    quResultShiftsShiftKweek: TFloatField;
    quResultShiftAutoModels: TADOQuery;
    dsResultShiftAutoModels: TDataSource;
    quResultShiftAutoModelsId_DumpModel: TIntegerField;
    quResultShiftAutoModelsDumpModel: TWideStringField;
    dbgAutos2: TDBGridEh;
    Splitter2: TSplitter;
    dbgResultShiftAutoReport2: TDBGridEh;
    quResultShiftAutoReport2: TADOQuery;
    dsResultShiftAutoReport2: TDataSource;
    quResultShiftAutoReport2Id_DumpModel: TIntegerField;
    quResultShiftAutoReport2DumpModel: TWideStringField;
    quResultShiftAutoReport2RecordNo: TIntegerField;
    quResultShiftAutoReport2Value: TFloatField;
    quResultShiftAutoReport2Value1: TFloatField;
    quResultShiftAutoReport2Value2: TFloatField;
    quResultShiftAutoReport3: TADOQuery;
    dsResultShiftAutoReport3: TDataSource;
    quResultShiftAutoReport3Id_ResultShift: TIntegerField;
    quResultShiftAutoReport3Id_ResultShiftAuto: TIntegerField;
    quResultShiftAutoReport3Id_DumpModel: TIntegerField;
    quResultShiftAutoReport3DumpModel: TWideStringField;
    quResultShiftAutoReport3Kind: TWordField;
    quResultShiftAutoReport3RecordNo: TIntegerField;
    quResultShiftAutoReport3Value: TFloatField;
    quResultShiftAutoReport3Value1: TFloatField;
    quResultShiftAutoReport3Value2: TFloatField;
    dbgResultShiftAutoReport3: TDBGridEh;
    btClose: TButton;
    btExcel: TButton;
    quResultShiftAutoReport1Id_ResultShiftAutoReport: TAutoIncField;
    quResultShiftAutoReport1Id_DumpModel: TIntegerField;
    quResultShiftAutoReport1DumpModel: TWideStringField;
    quResultShiftAutoReport1Kind: TWordField;
    quResultShiftAutoReport1Id_ResultShift: TIntegerField;
    quResultShiftAutoReport2Id_ResultShiftAutoReport: TAutoIncField;
    quResultShiftAutoReport2Id_ResultShift: TIntegerField;
    quResultShiftAutoReport2Id_ResultShiftAuto: TIntegerField;
    quResultShiftAutoReport2Kind: TWordField;
    quResultShiftAutoReport3Id_ResultShiftAutoReport: TAutoIncField;
    quResultShiftAutoReport1IsChangeable: TBooleanField;
    quResultShiftAutoReport1RecordName: TWideStringField;
    quResultShiftAutoReport1Name: TWideStringField;
    quResultShiftAutoReport2IsChangeable: TBooleanField;
    quResultShiftAutoReport2RecordName: TWideStringField;
    quResultShiftAutoReport2Name: TWideStringField;
    quResultShiftAutoReport3IsChangeable: TBooleanField;
    quResultShiftAutoReport3RecordName: TWideStringField;
    quResultShiftAutoReport3Name: TWideStringField;
    quResultShiftsDollarCtg: TFloatField;
    quResultShiftAutosDumpAmortizationKind: TIntegerField;
    quResultShiftAutosDumpWorkState: TBooleanField;
    btShift: TButton;
    btSpeedTime: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quResultShiftAutoEventsKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftAutoEventsDirectionGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftAutoReport1CalcFields(DataSet: TDataSet);
    procedure quResultShiftAutoReport1ValueGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftAutoEventsHorizont0GetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quResultShiftsCalcFields(DataSet: TDataSet);
    procedure btExcelClick(Sender: TObject);
    procedure quResultShiftAutosDumpAmortizationKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure dbgResultShiftAutoReport1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure btShiftClick(Sender: TObject);
    procedure btSpeedTimeClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
  public
    procedure xlDrawPrintSetup(XL,ASheet: Variant; const AIsPortrait: Boolean);
    procedure xlDrawShift(XL,ASheet: Variant);
    procedure xlDrawAutosReport1(XL,ASheet: Variant);
    procedure xlDrawAutosReport2(XL,ASheet: Variant);
    procedure xlDrawAutosReport3(XL,ASheet: Variant);
  public
  end;{TfmResultShiftAutos}

var
  fmResultShiftAutos: TfmResultShiftAutos;
  Index_of_First:integer;

//Диалоговое окно результатов моделирования по автосамосвалам
procedure esaShowResultShiftAutosDlg();
implementation

uses unDM, ComObj, Math, unResultShift, unResultAutoSpeeds;

{$R *.dfm}

const
  cNo             = 0;

//Диалоговое окно результатов моделирования по автосамосвалам
procedure esaShowResultShiftAutosDlg();
begin
  fmResultShiftAutos := TfmResultShiftAutos.Create(nil);
  try
    fmResultShiftAutos.ShowModal;
  finally
    fmResultShiftAutos.Free;
  end;{try}
end;{esaShowResultShiftAutosDlg}
procedure TfmResultShiftAutos.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := 0;
  quResultShifts.Open;
  quResultShiftAutos.Open;
  quResultShiftAutoModels.Open;
  quResultShiftAutoReport1.Open;
  quResultShiftAutoReport2.Open;
  quResultShiftAutoReport3.Open;
  Index_of_First:= quResultShiftAutosId_ResultShiftAuto.AsInteger;
end;{FormCreate}

procedure TfmResultShiftAutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  quResultShiftAutoReport3.Close;
  quResultShiftAutoReport2.Close;
  quResultShiftAutoReport1.Close;
  quResultShiftAutoModels.Close;
  quResultShiftAutos.Close;
  quResultShifts.Close;
end;{FormClose}


procedure TfmResultShiftAutos.quResultShiftAutoEventsKindGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  case Sender.AsInteger of
    1: Text := 'Погрузка';
    2: Text := 'Разгрузка';
    3: Text := 'Простой';
    4: Text := 'Движение';
    5: Text := 'Маневры';
    6: Text := 'Пересменка';
    7: Text := 'Авария';
  end;{case}
end;{quResultShiftAutoEventsKindGetText}
procedure TfmResultShiftAutos.quResultShiftAutoEventsDirectionGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  case Sender.AsInteger of
    1: Text := 'Грузовое';
    2: Text := 'Порожняк.';
    3: Text := 'Нулевое';
  end;{case}
end;{quResultShiftAutoEventsDirectionGetText}
procedure TfmResultShiftAutos.quResultShiftAutoReport1CalcFields(DataSet: TDataSet);
var
  _value: double;
  _shiftKweek, _periodKshift: double;
begin
  if not(Dataset.FieldByName('Value').IsNull) then
  begin
    _value:= Dataset.FieldByName('Value').AsFloat;
    _shiftKweek:= quResultShiftsShiftKweek.AsFloat;
    _periodKshift:= quResultShiftsPeriodKshift.AsFloat;
    if Dataset.FieldByName('IsChangeable').AsBoolean then
    begin
      if (Dataset.FieldByName('RecordNo').AsInteger = 514) then
      begin
        Dataset.FieldByName('Value1').AsFloat:= _value;
        Dataset.FieldByName('Value2').AsFloat := _value * 2 * 365;
      end
      else
      begin
        Dataset.FieldByName('Value1').AsFloat:= _value * _shiftKweek;
        Dataset.FieldByName('Value2').AsFloat := _value * _periodKshift;
      end;
    end
    else
    begin
      Dataset.FieldByName('Value1').AsFloat := _value * 1.0;
      Dataset.FieldByName('Value2').AsFloat := _value * 1.0;
    end;
  end;
//begin
//  if not(Dataset.FieldByName('Value').IsNull) then
//    if Dataset.FieldByName('IsChangeable').AsBoolean then
//    begin
//      Dataset.FieldByName('Value1').AsFloat:= Dataset.FieldByName('Value').AsFloat * quResultShiftsShiftKweek.AsFloat;
//      Dataset.FieldByName('Value2').AsFloat:= Dataset.FieldByName('Value').AsFloat * quResultShiftsPeriodKshift.AsFloat;
//    end
//    else
//    begin
//      Dataset.FieldByName('Value1').AsFloat:= Dataset.FieldByName('Value').AsFloat * 1.0;
//      Dataset.FieldByName('Value2').AsFloat:= Dataset.FieldByName('Value').AsFloat * 1.0;
//    end;
end;{quResultShiftAutoReport1CalcFields}
procedure TfmResultShiftAutos.quResultShiftAutoReport1ValueGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then Text := ''
  else
  if Sender.AsFloat>0.0
  then Text := FormatFloat('# ### ### ##0.00',Sender.AsFloat)
  else Text := '-';
end;{quResultShiftAutoReport1ResultGetText}


procedure TfmResultShiftAutos.quResultShiftAutoEventsHorizont0GetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then Text := '' else
    if Sender.AsFloat<0 then Text := Sender.AsString else Text := '+'+Sender.AsString;
end;{quResultShiftAutoEventsHorizont0GetText}

procedure TfmResultShiftAutos.quResultShiftsCalcFields(DataSet: TDataSet);
begin
  quResultShiftsShiftPlanNaryadTmin.AsFloat :=
    quResultShiftsShiftTmin.AsFloat - quResultShiftsShiftPeresmenkaTmin.AsFloat;
end;{quResultShiftsCalcFields}

procedure TfmResultShiftAutos.xlDrawPrintSetup(XL,ASheet: Variant; const AIsPortrait: Boolean);
begin
  try
    ASheet.PageSetup.LeftMargin   := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.RightMargin  := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.TopMargin    := XL.InchesToPoints(0.39370);
    ASheet.PageSetup.BottomMargin := XL.InchesToPoints(0.39370);
    if AIsPortrait
    then ASheet.PageSetup.Orientation  := xlPortrait
    else ASheet.PageSetup.Orientation  := xlLandscape;
  finally
  end;{try}
end;{xlDrawPrintSetup}
procedure TfmResultShiftAutos.xlDrawShift(XL,ASheet: Variant);
var
  AGrid       : Variant;
  ARange      : Variant;
  ACols,ARows : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Рабочая смена';
  ACols := 3;
  ARows := 10;
  AGrid := VarArrayCreate([0,ARows-1,0,ACols-1],varVariant);
  try
    AGrid[0,0] := 'Параметры рабочей смены';
    AGrid[1,0] := quResultShiftsId_ResultShift.DisplayLabel;
    AGrid[2,0] := quResultShiftsId_Openpit.DisplayLabel;
    AGrid[3,0] := quResultShiftsShiftNaryadTmin.DisplayLabel;
    AGrid[4,0] := quResultShiftsShiftPlanNaryadTmin.DisplayLabel;
    AGrid[5,0] := quResultShiftsShiftPeresmenkaTmin.DisplayLabel;
    AGrid[6,0] := quResultShiftsShiftTmin.DisplayLabel;
    AGrid[7,0] := quResultShiftsShiftKweek.DisplayLabel;
    AGrid[8,0] := quResultShiftsPeriodKshift.DisplayLabel;
    AGrid[9,0] := quResultShiftsPeriodTday.DisplayLabel;

    AGrid[1,1] := quResultShiftsId_ResultShift.AsInteger;
    AGrid[2,1] := quResultShiftsId_Openpit.AsInteger;
    AGrid[3,1] := quResultShiftsShiftNaryadTmin.AsFloat;
    AGrid[4,1] := quResultShiftsShiftPlanNaryadTmin.AsFloat;
    AGrid[5,1] := quResultShiftsShiftPeresmenkaTmin.AsFloat;
    AGrid[6,1] := quResultShiftsShiftTmin.AsFloat;
    AGrid[7,1] := quResultShiftsShiftKweek.AsFloat;
    AGrid[8,1] := quResultShiftsPeriodKshift.AsFloat;
    AGrid[9,1] := quResultShiftsPeriodTday.AsFloat;
    ASheet.Range['A1','B1'].Merge;
    ASheet.Range['A1','B1'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','B1'].Font.Bold := True;
    ARange := ASheet.Range['A1','B'+IntToStr(ARows)];
    ARange.Value := AGrid;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:A'].ColumnWidth := 95.0;
    ASheet.Columns['B:B'].ColumnWidth := 8.0;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    xlDrawPrintSetup(XL,ASheet,True);
  finally
    AGrid := Unassigned;
  end;{try}
end;{xlDrawShift}
procedure TfmResultShiftAutos.xlDrawAutosReport1(XL,ASheet: Variant);
var
  ARange: Variant;
  ARow  : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Детальная информация';
  try
    quResultShiftAutoReport1.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по автосамосвалам (детальная)';
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgAutos1.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgAutos1.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgAutos1.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftAutoReport1.Columns[0].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftAutoReport1.Columns[1].Title.Caption;
    ASheet.Range['F2','F2'].Value := dbgResultShiftAutoReport1.Columns[2].Title.Caption;
    ASheet.Range['G2','G2'].Value := dbgResultShiftAutoReport1.Columns[3].Title.Caption;
    ASheet.Range['H2','H2'].Value := dbgResultShiftAutoReport1.Columns[4].Title.Caption;
    ARow := 3;
    quResultShiftAutos.First;
    while not quResultShiftAutos.Eof do
    begin
      ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftAutosId_ResultShiftAuto.AsInteger;
      ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftAutosDumpModel.AsString;
      ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftAutosDumpNo.AsInteger;
      quResultShiftAutoReport1.Last;
      if quResultShiftAutoReport1.RecordCount>0 then
      begin
        quResultShiftAutoReport1.First;
        while not quResultShiftAutoReport1.Eof do
        begin
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftAutoReport1RecordName.AsString;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftAutoReport1Name.AsString;
          if quResultShiftAutoReport1RecordNo.AsInteger mod 100 <> 0 then
          begin
            ASheet.Range['F'+IntToStr(ARow),'F'+IntToStr(ARow)].Value := quResultShiftAutoReport1Value.AsFloat;
            ASheet.Range['G'+IntToStr(ARow),'G'+IntToStr(ARow)].Value := quResultShiftAutoReport1Value1.AsFloat;
            ASheet.Range['H'+IntToStr(ARow),'H'+IntToStr(ARow)].Value := quResultShiftAutoReport1Value2.AsFloat;
          end{if}
          else ASheet.Range['D'+IntToStr(ARow),'E'+IntToStr(ARow)].Font.Bold := True;
          quResultShiftAutoReport1.Next;
          Inc(ARow);
        end;{while}
      end{if}
      else Inc(ARow);
      quResultShiftAutos.Next;
    end;{while}
    quResultShiftAutos.First;
    if ARow=3 then Inc(ARow);
    ARange := ASheet.Range['A1','H'+IntToStr(ARow-1)];
    ASheet.Range['A1','H2'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','H2'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','H2'].WrapText := True;
    ASheet.Range['A1','H1'].Font.Bold := True;
    ASheet.Range['A1','H1'].Merge;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:2'].RowHeight := 37.5;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:D'].ColumnWidth :=  5.0;
    ASheet.Columns['B:B'].ColumnWidth := 20.0;
    ASheet.Columns['C:C'].ColumnWidth :=  8.0;
    ASheet.Columns['E:E'].ColumnWidth := 60.0;
    ASheet.Columns['F:H'].ColumnWidth := 15.0;
    xlDrawPrintSetup(XL,ASheet,False);
  finally
    quResultShiftAutoReport1.EnableControls;
  end;{try}
end;{xlDrawAutosReport1}
procedure TfmResultShiftAutos.xlDrawAutosReport2(XL,ASheet: Variant);
var
  ARange      : Variant;
  ARow        : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'По моделям автосамосвалов';
  try
    quResultShiftAutoReport2.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по автосамосвалам (по моделям)';
    //Шапка
    ASheet.Range['A2','A2'].Value := '№';
    ASheet.Range['B2','B2'].Value := dbgAutos2.Columns[0].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgAutos2.Columns[1].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftAutoReport2.Columns[0].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftAutoReport2.Columns[1].Title.Caption;
    ASheet.Range['F2','F2'].Value := dbgResultShiftAutoReport2.Columns[2].Title.Caption;
    ASheet.Range['G2','G2'].Value := dbgResultShiftAutoReport2.Columns[3].Title.Caption;
    ASheet.Range['H2','H2'].Value := dbgResultShiftAutoReport2.Columns[4].Title.Caption;
    ARow := 3;
    quResultShiftAutoModels.First;
    while not quResultShiftAutoModels.Eof do
    begin
      ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftAutoModels.RecNo;
      ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftAutoModelsId_DumpModel.AsInteger;
      ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftAutoModelsDumpModel.AsString;
      quResultShiftAutoReport2.Last;
      if quResultShiftAutoReport2.RecordCount>0 then
      begin
        quResultShiftAutoReport2.First;
        while not quResultShiftAutoReport2.Eof do
        begin
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftAutoReport2RecordName.AsString;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftAutoReport2Name.AsString;
          if quResultShiftAutoReport2RecordNo.AsInteger mod 100 <> 0 then
          begin
            ASheet.Range['F'+IntToStr(ARow),'F'+IntToStr(ARow)].Value := quResultShiftAutoReport2Value.AsFloat;
            ASheet.Range['G'+IntToStr(ARow),'G'+IntToStr(ARow)].Value := quResultShiftAutoReport2Value1.AsFloat;
            ASheet.Range['H'+IntToStr(ARow),'H'+IntToStr(ARow)].Value := quResultShiftAutoReport2Value2.AsFloat;
          end{if}
          else ASheet.Range['D'+IntToStr(ARow),'E'+IntToStr(ARow)].Font.Bold := True;
          quResultShiftAutoReport2.Next;
          Inc(ARow);
        end;{while}
      end{if}
      else Inc(ARow);
      quResultShiftAutoModels.Next;
    end;{while}
    quResultShiftAutoModels.First;
    if ARow=3 then Inc(ARow);
    ARange := ASheet.Range['A1','H'+IntToStr(ARow-1)];
    ASheet.Range['A1','H2'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','H2'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','H2'].WrapText := True;
    ASheet.Range['A1','H1'].Font.Bold := True;
    ASheet.Range['A1','H1'].Merge;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:2'].RowHeight := 37.5;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:D'].ColumnWidth :=  5.0;
    ASheet.Columns['C:C'].ColumnWidth := 20.0;
    ASheet.Columns['E:E'].ColumnWidth := 60.0;
    ASheet.Columns['F:H'].ColumnWidth := 15.0;
    xlDrawPrintSetup(XL,ASheet,False);
  finally
    quResultShiftAutoReport2.EnableControls;
  end;{try}
end;{xlDrawAutosReport2}
procedure TfmResultShiftAutos.xlDrawAutosReport3(XL,ASheet: Variant);
var
  ARange      : Variant;
  ARow        : Integer;
begin
  ASheet.Select;
  ASheet.Name := 'Суммарная информация';
  try
    quResultShiftAutoReport3.DisableControls;
    ASheet.Range['A1','A1'].Value := 'Результаты моделирования по автосамосвалам (суммарная)';
    //Шапка
    ASheet.Range['A2','A2'].Value := dbgResultShiftAutoReport3.Columns[0].Title.Caption;
    ASheet.Range['B2','B2'].Value := dbgResultShiftAutoReport3.Columns[1].Title.Caption;
    ASheet.Range['C2','C2'].Value := dbgResultShiftAutoReport3.Columns[2].Title.Caption;
    ASheet.Range['D2','D2'].Value := dbgResultShiftAutoReport3.Columns[3].Title.Caption;
    ASheet.Range['E2','E2'].Value := dbgResultShiftAutoReport3.Columns[4].Title.Caption;
    ARow := 3;
    if quResultShiftAutoReport3.RecordCount>0 then
    begin
      quResultShiftAutoReport3.First;
      while not quResultShiftAutoReport3.Eof do
      begin
        ASheet.Range['A'+IntToStr(ARow),'A'+IntToStr(ARow)].Value := quResultShiftAutoReport3RecordName.AsString;
        ASheet.Range['B'+IntToStr(ARow),'B'+IntToStr(ARow)].Value := quResultShiftAutoReport3Name.AsString;
        if quResultShiftAutoReport3RecordNo.AsInteger mod 100 <> 0 then
        begin
          ASheet.Range['C'+IntToStr(ARow),'C'+IntToStr(ARow)].Value := quResultShiftAutoReport3Value.AsFloat;
          ASheet.Range['D'+IntToStr(ARow),'D'+IntToStr(ARow)].Value := quResultShiftAutoReport3Value1.AsFloat;
          ASheet.Range['E'+IntToStr(ARow),'E'+IntToStr(ARow)].Value := quResultShiftAutoReport3Value2.AsFloat;
          end{if}
          else ASheet.Range['A'+IntToStr(ARow),'B'+IntToStr(ARow)].Font.Bold := True;
        quResultShiftAutoReport3.Next;
        Inc(ARow);
      end;{while}
      quResultShiftAutoReport3.First;
    end{if}
    else Inc(ARow);
    if ARow=3 then Inc(ARow);
    ARange := ASheet.Range['A1','E'+IntToStr(ARow-1)];
    ASheet.Range['A1','E2'].HorizontalAlignment := xlCenter;
    ASheet.Range['A1','E2'].VerticalAlignment := xlCenter;
    ASheet.Range['A1','E2'].WrapText := True;
    ASheet.Range['A1','E1'].Font.Bold := True;
    ASheet.Range['A1','E1'].Merge;
    ASheet.Rows['1:'+IntToStr(256*256)].RowHeight := 12.5;
    ASheet.Rows['2:2'].RowHeight := 37.5;
    ARange.Borders.LineStyle := xlContinuous;
    ARange.Borders.Weight := xlThin;
    ASheet.Columns['A:A'].ColumnWidth :=  5.0;
    ASheet.Columns['B:B'].ColumnWidth :=100.0;
    ASheet.Columns['C:E'].ColumnWidth := 15.0;
    xlDrawPrintSetup(XL,ASheet,False);
  finally
    quResultShiftAutoReport3.EnableControls;
  end;{try}
end;{xlDrawAutosReport3}
procedure TfmResultShiftAutos.btExcelClick(Sender: TObject);
var
  XL    : Variant; //Microsoft Excel
  ABook : Variant; //Рабочая книга Excel
begin
  XL := CreateOLEObject('Excel.Application');
  try
    Screen.Cursor := crHourGlass;
    XL.Visible := False;
    ABook := XL.WorkBooks.Add;
    while ABook.Sheets.Count<2 do
      ABook.WorkSheets.Add;
    //Лист 1 -------------------------------------------------------------------
    xlDrawShift(XL,ABook.WorkSheets[1]);
    case PageControl.ActivePageIndex of
      0: xlDrawAutosReport1(XL,ABook.WorkSheets[2]);
      1: xlDrawAutosReport2(XL,ABook.WorkSheets[2]);
      2: xlDrawAutosReport3(XL,ABook.WorkSheets[2]);
    end;{case}
    ABook.WorkSheets[1].Select;
    XL.Visible := True;
  finally
    XL := Unassigned;
    Screen.Cursor := crDefault;
  end;{try}
end;{btExcelClick}

procedure TfmResultShiftAutos.quResultShiftAutosDumpAmortizationKindGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  case Sender.AsInteger of
    0: Text := 'годовая';
    1: Text := 'на тыс.км';
  end;{case}
end;{quResultShiftAutosDumpAmortizationKindGetText}

procedure TfmResultShiftAutos.dbgResultShiftAutoReport1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if TDBGridEh(Sender).DataSource.Dataset.FieldByName('RecordNo').AsInteger mod 100 = 0
  then TDBGridEh(Sender).Canvas.Font.Style := [fsBold];
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;{dbgResultShiftAutoReport1DrawColumnCell}

procedure TfmResultShiftAutos.btShiftClick(Sender: TObject);
begin
  esaShowResultShiftDlg();
end;{btShiftClick}

procedure TfmResultShiftAutos.btSpeedTimeClick(Sender: TObject);
begin
  fmResultAutoSpeeds := TfmResultAutoSpeeds.Create(nil);
  try
    fmResultAutoSpeeds.HelpKeyword := HelpKeyword;
    fmResultAutoSpeeds.Width := Width;
    fmResultAutoSpeeds.Height := Height;
    {SEE added code}
    fmResultAutoSpeeds.Caption := 'Скорость, время движения автосамосвала № '+
    quResultShiftAutosDumpNo.AsString+' по автотрассе';
    fmResultAutoSpeeds.LoadFromFile(quResultShiftAutosId_ResultShiftAuto.AsInteger-Index_of_First);

    fmResultAutoSpeeds.ShowModal;
  finally
    fmResultAutoSpeeds.Free;
  end;{try}
end; {btSpeedTimeClick}

procedure TfmResultShiftAutos.PageControlChange(Sender: TObject);
begin
   btSpeedTime.Enabled := PageControl.TabIndex = 0;
end;

end.
////////////////////////////////////

procedure TfmResultAutos.btSpeedTimeClick(Sender: TObject);
begin

end;{btSpeedTimeClick}

procedure TfmResultAutos.TabControlChange(Sender: TObject);
begin

