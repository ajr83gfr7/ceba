unit unAdditionalParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Spin, Mask, DBCtrls, Types, Grids,
  DBGrids, Db, ADODB, Menus, ExcelEditors;

type
  TfmAdditionalParams = class(TForm)
    pnBtns: TPanel;
    PageControl: TPageControl;
    tsTotal: TTabSheet;
    lbTotalKurs: TLabel;
    lbTotalExpenses: TLabel;
    lbTotalSalaryCoef: TLabel;
    gbTotalShiftUsingCoef: TGroupBox;
    lbTotalShiftUsingCoefNormal: TLabel;
    lbTotalShiftUsingCoefExplosion: TLabel;
    lbTotalShiftUsingCoefExplosionCount: TLabel;
    tsExcavs: TTabSheet;
    tsAutos: TTabSheet;
    tsRoads: TTabSheet;
    bvTotal: TBevel;
    gbExcavsSalary: TGroupBox;
    gbExcavsWorkRezim: TGroupBox;
    lbExcavsSalaryMashinist: TLabel;
    lbExcavsSalaryAssistant: TLabel;
    lbExcavsSalaryPlus0: TLabel;
    lbExcavsSalaryPlus1: TLabel;
    lbExcavsWorkRezimWorkShiftsCount: TLabel;
    lbExcavsWorkRezimWorkShiftDuration: TLabel;
    gbExcavsEnergyCost: TGroupBox;
    gbExcavsAmortazationNorm: TGroupBox;
    lbTotalShiftUsingCoefDayShift: TLabel;
    gbAutosSalary: TGroupBox;
    lbAutosSalary: TLabel;
    lbAutosSalaryPlus: TLabel;
    gbAutosWorkRezim: TGroupBox;
    lbAutosWorkRezimWorkShiftsCount: TLabel;
    lbAutosWorkRezimWorkShiftDuration: TLabel;
    pcAutos: TPageControl;
    tsAutosFuel: TTabSheet;
    tsAutosOtherAccounts: TTabSheet;
    gbAutosFuelCost: TGroupBox;
    lbAutosFuelCostWinter: TLabel;
    lbAutosFuelCostSummer: TLabel;
    lbAutosWinterMonthCount: TLabel;
    lbAutosFuelCostTarif: TLabel;
    dbedTotalKurs: TDBEdit;
    dbedTotalExpenses: TDBEdit;
    dbedTotalSalaryCoef: TDBEdit;
    dbedTotalShiftUsingCoefNormal: TDBEdit;
    dbedTotalShiftUsingCoefDayShift: TDBEdit;
    dbedTotalShiftUsingCoefExplosion: TDBEdit;
    dbedTotalShiftUsingCoefExplosionCount: TDBEdit;
    dbedExcavsSalaryMashinist0: TDBEdit;
    dbedExcavsSalaryMashinist1: TDBEdit;
    dbedExcavsSalaryAssistant0: TDBEdit;
    dbedExcavsSalaryAssistant1: TDBEdit;
    dbedExcavsWorkRezimWorkShiftsCount: TDBEdit;
    dbedExcavsWorkRezimWorkShiftDuration: TDBEdit;
    dbedExcavsEnergyCost: TDBEdit;
    dbedExcavsAmortazationNorm: TDBEdit;
    dbedAutosSalary0: TDBEdit;
    dbedAutosSalary1: TDBEdit;
    dbedAutosWorkRezimWorkShiftsCount: TDBEdit;
    dbedAutosWorkRezimWorkShiftDuration: TDBEdit;
    dbedAutosFuelCostWinter: TDBEdit;
    dbedAutosFuelCostSummer: TDBEdit;
    dbedAutosWinterMonthCount: TDBEdit;
    dbcbAutosFuelCostTarif: TDBComboBox;
    pbAutos: TPaintBox;
    dbgAutos: TDBGrid;
    pbRoads: TPaintBox;
    dbgRoads: TDBGrid;
    btClose: TButton;
    pmAutos: TPopupMenu;
    pmiAutosDefault: TMenuItem;
    pmiAutosSep1: TMenuItem;
    pmiAutosExcel: TMenuItem;
    pmiAutosSep2: TMenuItem;
    pmiAutosPrint: TMenuItem;
    pmRoads: TPopupMenu;
    pmiRoadsDefault: TMenuItem;
    pmiRoadsSep1: TMenuItem;
    pmiRoadsExcel: TMenuItem;
    pmiRoadsSep2: TMenuItem;
    pmiRoadsPrint: TMenuItem;
    tsWorkRegime: TTabSheet;
    gbAccording: TGroupBox;
    lsbAutos: TListBox;
    lbAutos: TLabel;
    lsbExcavs: TListBox;
    lbExcavs: TLabel;
    lbAccording: TLabel;
    btAdd: TButton;
    btDelete: TButton;
    dbllbAutoExcavAccordances: TDBLookupListBox;
    dbrgAutosWorkRegime: TDBRadioGroup;
    dbcbIsStrippingCoefUsing: TDBCheckBox;
    lbExcavsShiftTurnoverTime: TLabel;
    dbedExcavsShiftTurnoverTime: TDBEdit;
    lbAutosShiftTurnoverTime: TLabel;
    dbedAutosShiftTurnoverTime: TDBEdit;
    btDeleteAll: TButton;
    btExcel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbAutosPaint(Sender: TObject);
    procedure dbgAutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pbRoadsPaint(Sender: TObject);
    procedure pmiAutosDefaultClick(Sender: TObject);
    procedure pmiAutosExcelClick(Sender: TObject);
    procedure pmiAutosPrintClick(Sender: TObject);
    procedure pmAutosPopup(Sender: TObject);
    procedure pmiRoadsDefaultClick(Sender: TObject);
    procedure pmiRoadsExcelClick(Sender: TObject);
    procedure pmiRoadsPrintClick(Sender: TObject);
    procedure pmRoadsPopup(Sender: TObject);
    procedure lsbExcavsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsbExcavsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lsbAutosDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lsbAutosDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsbAutosEnter(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure dbedTotalKursKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure btDeleteAllClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FAutoColWidths: TIntegerDynArray;
    FRoadColWidths: TIntegerDynArray;
    AHelpKeyWord: String;
    procedure UpdateAutoOtherAccounts;
    procedure UpdateAutoExcavAccordances;
    procedure DoAutosBeforePost(DataSet: TDataSet);
    procedure DoCancel(DataSet: TDataSet);
    procedure UpdateRoadOtherAccounts;
    procedure DoRoadsBeforePost(DataSet: TDataSet);
    procedure DoParamsBeforePost(DataSet: TDataSet);
    procedure PrintAutosOtherParams(var XL: TExcelEditor);
    procedure PrintAutosParams(var XL: TExcelEditor);
    procedure PrintExcavsParams(var XL: TExcelEditor);
    procedure PrintTotalParams(var XL: TExcelEditor);
    procedure PrintRoadParams(var XL: TExcelEditor);
  public
  end;{TfmAdditionalParams}

var
  fmAdditionalParams: TfmAdditionalParams;

//Диалоговое окно дополнительных параметров
function esaShowAdditionalParamsDlg(const APageIndex: Byte): Boolean;
implementation

uses unDM, Globals, esaDBDefaultParams, Math;

{$R *.dfm}

//Диалоговое окно дополнительных параметров
function esaShowAdditionalParamsDlg(const APageIndex: Byte): Boolean;
begin
  fmAdditionalParams := TfmAdditionalParams.Create(nil);
  try
    fmAdditionalParams.PageControl.ActivePageIndex := EnsureRange(APageIndex,0,fmAdditionalParams.PageControl.PageCount-1);
    Result := fmAdditionalParams.ShowModal=mrOk;
  finally
    fmAdditionalParams.Free;
  end;{try}
end;{esaShowAdditionalParamsDlg}

procedure TfmAdditionalParams.FormCreate(Sender: TObject);
begin
  AHelpKeyword := Copy(Name,3,Length(Name)-2);
  PageControl.ActivePageIndex := 0;
  PageControlChange(Sender);
  pcAutos.ActivePageIndex := 0;
  SetLength(FAutoColWidths,dbgAutos.Columns.Count);
  dbgRoads.Options := [dgEditing,dgIndicator,dgColLines,dgRowLines];
  SetLength(FRoadColWidths,dbgRoads.Columns.Count);
  dbgAutos.Options := [dgEditing,dgIndicator,dgColLines,dgRowLines];
  with fmDM do
  begin
    quExcavatorEngines.Open;
    quExcavators.Open;
    quAutoEngines.Open;
    quAutos.Open;
    quAutoOtherAccounts.Open;
    UpdateAutoOtherAccounts;
    quRoadCoats.Open;
    quRoadOtherAccounts.Open;
    UpdateRoadOtherAccounts;

    quAutoOtherAccounts.BeforeInsert := DoCancel;
    quAutoOtherAccounts.BeforeDelete := DoCancel;
    quAutoOtherAccounts.BeforePost := DoAutosBeforePost;

    quRoadOtherAccounts.BeforeInsert := DoCancel;
    quRoadOtherAccounts.BeforeDelete := DoCancel;
    quRoadOtherAccounts.BeforePost := DoRoadsBeforePost;

    quOpenpits.BeforePost := DoParamsBeforePost;
    quAutoExcavAccordances.Open;
    UpdateAutoExcavAccordances;
    dbllbAutoExcavAccordances.KeyValue := quAutoExcavAccordancesId_AutoExcavAccordance.AsInteger;
  end;{with}
end;{FormCreate}
procedure TfmAdditionalParams.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with fmDM do
  begin
    quAutoOtherAccounts.Close;
    quAutos.Close;
    quAutoEngines.Close;
    quAutoOtherAccounts.BeforeInsert := nil;
    quAutoOtherAccounts.BeforeDelete := nil;
    quAutoOtherAccounts.BeforePost := nil;
    quOpenpits.BeforePost := nil;
    quRoadOtherAccounts.Close;
    quRoadCoats.Close;
    quRoadOtherAccounts.BeforeInsert := nil;
    quRoadOtherAccounts.BeforeDelete := nil;
    quRoadOtherAccounts.BeforePost := nil;
    quExcavators.Close;
    quExcavatorEngines.Close;
    quAutoExcavAccordances.Close;
  end;{with}
end;{FormClose}
procedure TfmAdditionalParams.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := CanCloseModifiedQuery(fmDM.quOpenpits,'Дополнительные параметры')and
              CanCloseModifiedQuery(fmDM.quAutoOtherAccounts,'Дополнительные параметры по автосамосвалам')and
              CanCloseModifiedQuery(fmDM.quRoadOtherAccounts,'Дополнительные параметры по автодороге');
end;{FormCloseQuery}
procedure TfmAdditionalParams.FormResize(Sender: TObject);
begin
  FitColumnByIndex(dbgAutos,1);
  UpdateColumnRights(dbgAutos,FAutoColWidths);
  FitColumnByIndex(dbgRoads,1);
  UpdateColumnRights(dbgRoads,FRoadColWidths);
end;{FormResize}

procedure TfmAdditionalParams.pbAutosPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbAutos.Canvas;
  DrawGridTitle(pbAutos,dbgAutos,5,FAutoColWidths);
  with dbgAutos do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FAutoColWidths[0]-Width,1,FAutoColWidths[0],4*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FAutoColWidths[0]+1,1,FAutoColWidths[1],4*hCell,['Наименование']);
    with Columns[2] do
      DrawGridCell(Cvs,FAutoColWidths[1]+1,1,FAutoColWidths[3],2*hCell,['Прочие затраты,','в % к затратам на топливо']);
    with Columns[2] do
      DrawGridCell(Cvs,FAutoColWidths[1]+1,2*hCell+1,FAutoColWidths[2],4*hCell,['Запасные части', 'и материалы']);
    with Columns[3] do
      DrawGridCell(Cvs,FAutoColWidths[2]+1,2*hCell+1,FAutoColWidths[3],4*hCell,['Смазочные','материалы']);
    with Columns[4] do
      DrawGridCell(Cvs,FAutoColWidths[3]+1,1,FAutoColWidths[4],4*hCell,['Содержание','ремонтного','персонала,','тыс.тенге/мес']);
  end;{with}
end;{pbAutosFuel1Paint}

procedure TfmAdditionalParams.DoCancel(DataSet: TDataSet);
begin
  Abort;
end;{DoCancel}
procedure TfmAdditionalParams.DoAutosBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  if not IsFloatFieldMoreMin(DataSet.FieldByName('Spares'),0.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('GreasingSubstance'),0.0) then Abort
  else
  if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('MaintenanceCost'),0.0) then Abort;
end;{DoAutosBeforePost}

procedure TfmAdditionalParams.UpdateAutoOtherAccounts;
begin
  with fmDM do
  begin
    quDeportAutos.Open;
    while not quDeportAutos.Eof do
    begin
      if not quAutoOtherAccounts.Locate('Id_Auto',quDeportAutosId_Auto.AsInteger,[])then
      begin
        quAutoOtherAccounts.Append;
        quAutoOtherAccountsId_Auto.AsInteger := quDeportAutosId_Auto.AsInteger;
        quAutoOtherAccountsSpares.AsFloat := DefaultParams.ParamsAutosSpares;
        quAutoOtherAccountsGreasingSubstance.AsFloat := DefaultParams.ParamsAutosGreasingSubstance;
        quAutoOtherAccountsMaintenanceCost.AsFloat := DefaultParams.ParamsAutosMaintenanceCost;
        quAutoOtherAccounts.Post;
      end;{if}
      quDeportAutos.Next;
    end;{while}
    quDeportAutos.Close;
    quAutoOtherAccounts.First;
  end;{with}
end;{UpdateAutoOtherAccounts}
procedure TfmAdditionalParams.UpdateAutoExcavAccordances;
begin
  with fmDM do
  begin
    quDeportAutos.Open;
    quDeportExcavators.Open;
    quAutoExcavAccordances.First;
    while not quAutoExcavAccordances.Eof do
    begin
      if (not quAutos.Locate('Id_Auto',quAutoExcavAccordancesId_Auto.AsInteger,[]))OR
         (not quExcavators.Locate('Id_Excavator',quAutoExcavAccordancesId_Excavator.AsInteger,[]))
      then quAutoExcavAccordances.Delete
      else quAutoExcavAccordances.Next;
    end;{while}
    quAutoExcavAccordances.Requery;
    quDeportAutos.Close;
    quDeportExcavators.Close;
    with TADOQuery.Create(nil) do
    try
      Connection := ADOConnection;
      SQL.Text := 'SELECT DISTINCT(DA.Id_Auto),A.Name '+
                  'FROM OpenpitDeportAutos DA,Autos A '+
                  'WHERE (Id_Openpit='+quOpenpitsId_Openpit.AsString+')and(A.Id_Auto=DA.Id_Auto)';
      Open;
      while not EOF do
      begin
        lsbAutos.Items.Add(FieldByName('Name').AsString);
        Next;
      end;{while}
      Close;
      SQL.Text := 'SELECT DISTINCT(DE.Id_Excavator),E.Name '+
                  'FROM OpenpitDeportExcavators DE,Excavators E '+
                  'WHERE (Id_Openpit='+quOpenpitsId_Openpit.AsString+')and(E.Id_Excavator=DE.Id_Excavator)';
      Open;
      while not EOF do
      begin
        lsbExcavs.Items.Add(FieldByName('Name').AsString);
        Next;
      end;{while}
      Close;
    finally
      Free;
    end;{try}
    btAdd.Enabled := (lsbAutos.Count>0)and(lsbExcavs.Count>0);
    btDelete.Enabled := quAutoExcavAccordances.RecordCount>0;
    btDeleteAll.Enabled := btDelete.Enabled;
    if lsbAutos.Count>0 then lsbAutos.ItemIndex := 0;
    if lsbExcavs.Count>0 then lsbExcavs.ItemIndex := 0;
  end;{with}
end;{UpdateAutoExcavAccordances}
procedure TfmAdditionalParams.DoRoadsBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  if not IsFloatFieldMoreMin(DataSet.FieldByName('BuildingCosts'),0.0) then Abort
  else
  if not IsFloatFieldInRange1(DataSet.FieldByName('AmortizationNorm'),0.0,1.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('KeepingCosts'),0.0) then Abort
end;{DoRoadsBeforePost}

procedure TfmAdditionalParams.UpdateRoadOtherAccounts;
begin
  with fmDM do
  begin
    quRoadCoats.First;
    while not quRoadCoats.Eof do
    begin
      if not quRoadOtherAccounts.Locate('Id_RoadCoat',quRoadCoatsId_RoadCoat.AsInteger,[])then
      begin
        quRoadOtherAccounts.Append;
        quRoadOtherAccountsId_RoadCoat.AsInteger := quRoadCoatsId_RoadCoat.AsInteger;
        quRoadOtherAccountsBuildingCosts.AsFloat := DefaultParams.ParamsRoadsBuildingCosts;
        quRoadOtherAccountsKeepingCosts.AsFloat := DefaultParams.ParamsRoadsKeepingCosts;
        quRoadOtherAccountsAmortizationNorm.AsFloat := DefaultParams.ParamsRoadsAmortizationNorm;
        quRoadOtherAccounts.Post;
      end;{if}
      quRoadCoats.Next;
    end;{while}
    quRoadOtherAccounts.First;
  end;{with}
end;{UpdateRoadOtherAccounts}

procedure TfmAdditionalParams.dbgAutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Column.ReadOnly and (not(gdFocused in State))
  then TDBGrid(Sender).Canvas.Brush.Color :=  clLtGrayEx;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;{dbgAutosDrawColumnCell}

procedure TfmAdditionalParams.DoParamsBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  if not IsFloatFieldMoreMin(DataSet.FieldByName('TotalKurs'),0.0) then Abort
  else
  if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('TotalExpenses'),0.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('TotalSalaryCoef'),0.0) then Abort
  else
  if not IsFloatFieldInRange1(Dataset.FieldByName('TotalShiftUsingCoefNormal'),0,1)then Abort
  else
  if not IsFloatFieldInRange1(Dataset.FieldByName('TotalShiftUsingCoefDayShift'),0,1)then Abort
  else
  if not IsFloatFieldInRange1(Dataset.FieldByName('TotalShiftUsingCoefExplosion'),0,1)then Abort
  else
  if not IsIntegerFieldMoreEqualMin(Dataset.FieldByName('TotalShiftUsingCoefExplosionCount'),0)then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('ExcavsSalaryMashinist0'),0.0) then Abort
  else
  if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('ExcavsSalaryMashinist1'),0.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('ExcavsSalaryAssistant0'),0.0) then Abort
  else
  if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('ExcavsSalaryAssistant1'),0.0) then Abort
  else
  if not IsIntegerFieldMoreMin(Dataset.FieldByName('ExcavsWorkShiftsCount'),0)then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('ExcavsWorkShiftDuration'),0.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('ExcavsEnergyCost'),0.0) then Abort
  else
  if not IsFloatFieldInRange1(Dataset.FieldByName('ExcavsAmortazationNorm'),0,1)then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('AutosSalary0'),0.0) then Abort
  else
  if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('AutosSalary1'),0.0) then Abort
  else
  if not IsIntegerFieldMoreMin(Dataset.FieldByName('AutosWorkShiftsCount'),0)then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('AutosWorkShiftDuration'),0.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('AutosFuelCostWinter'),0.0) then Abort
  else
  if not IsFloatFieldMoreMin(DataSet.FieldByName('AutosFuelCostSummer'),0.0) then Abort
  else
  if not IsIntegerFieldInRange(Dataset.FieldByName('AutosWinterMonthCount'),0,12)then Abort
  else
  if not IsIntegerFieldInRange(Dataset.FieldByName('AutosFuelCostTarif'),0,2)then Abort
  else
  if not IsIntegerFieldMoreEqualMin(Dataset.FieldByName('AutosShiftTurnoverTime'),0)then Abort
  else
  if not IsIntegerFieldMoreEqualMin(Dataset.FieldByName('ExcavsShiftTurnoverTime'),0)then Abort
end;{DoParamsBeforePost}

procedure TfmAdditionalParams.pbRoadsPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbRoads.Canvas;
  DrawGridTitle(pbRoads,dbgRoads,4,FRoadColWidths);
  with dbgRoads do
  begin
    //остальные ячейки
    with Columns[0] do
      DrawGridCell(Cvs,FRoadColWidths[0]-Width,1,FRoadColWidths[0],3*hCell,['№']);
    with Columns[1] do
      DrawGridCell(Cvs,FRoadColWidths[0]+1,1,FRoadColWidths[1],3*hCell,['Дорожное покрытие']);
    with Columns[2] do
      DrawGridCell(Cvs,FRoadColWidths[1]+1,1,FRoadColWidths[2],3*hCell,['Затраты на','сооружение','1 км, тыс.тенге']);
    with Columns[3] do
      DrawGridCell(Cvs,FRoadColWidths[2]+1,1,FRoadColWidths[3],3*hCell,['Норма','амортизации']);
    with Columns[4] do
      DrawGridCell(Cvs,FRoadColWidths[3]+1,1,FRoadColWidths[4],3*hCell,['Содержание','1 км дороги,','тыс.тенге/год']);
  end;{with}
end;{pbRoadsPaint}

procedure TfmAdditionalParams.pmiAutosDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.ParamsAutosSpares := fmDM.quAutoOtherAccountsSpares.AsFloat;
    DefaultParams.ParamsAutosGreasingSubstance := fmDM.quAutoOtherAccountsGreasingSubstance.AsFloat;
    DefaultParams.ParamsAutosMaintenanceCost := fmDM.quAutoOtherAccountsMaintenanceCost.AsFloat;
  end;{if}
end;{pmiAutosDefaultClick}
procedure TfmAdditionalParams.pmiAutosExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  I,ACount: Integer;
begin
  Xl := TExcelEditor.Create;
  try
    //Заголовок
    Xl.TitleCell[1,1,5,1] := tsAutosOtherAccounts.Caption;
    XL.TitleCell[2,1,1,3] := '№';
    XL.TitleCell[2,2,1,3] := 'Наименование';
    XL.TitleCell[2,3,2,2] := 'Прочие затраты, в % к затратам на топливо';
    XL.TitleCell[4,3,1,2] := 'Запасные части и материалы';
    XL.TitleCell[4,4,1,2] := 'Смазочные материалы';
    XL.TitleCell[2,5,1,3] := 'Содержание ремонтного персонала, тыс.тенге/мес';
    for I := 1 to 5 do
      XL.IntegerCells[5,I] := I;
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 5;
    XL.ColumnWidths[2,1] := 20;
    XL.ColumnWidths[3,3] := 12;
    //Данные
    with fmDM do
    begin
      ACount := quAutoOtherAccounts.RecordCount;
      if ACount=0 then Inc(ACount);
      quAutoOtherAccounts.First;
      while not quAutoOtherAccounts.Eof do
      begin
        XL.IntegerCells[quAutoOtherAccounts.RecNo+5,1] := quAutoOtherAccounts.RecNo;
        XL.StringCells[quAutoOtherAccounts.RecNo+5,2] := quAutoOtherAccountsName.AsString;
        XL.FloatCells[quAutoOtherAccounts.RecNo+5,3] := quAutoOtherAccountsSpares.AsFloat;
        XL.FloatCells[quAutoOtherAccounts.RecNo+5,4] := quAutoOtherAccountsGreasingSubstance.AsFloat;
        XL.FloatCells[quAutoOtherAccounts.RecNo+5,5] := quAutoOtherAccountsMaintenanceCost.AsFloat;
        quAutoOtherAccounts.Next;
      end;{while}
      quAutoOtherAccounts.First;
      XL.Cells[6,3,3,ACount].NumberFormat := nfFloat00;
    end;{with}
    //Подножие
    XL.TitleCell[ACount+6,1,4,1] := 'Итого:';
    XL.Cells[ACount+6,1,4,1].HorizontalAlignment := haLeft;
    XL.Cells[ACount+6,1,5,1].Font.Style := [xlfsBold];
    XL.StringCells[ACount+6,5] := '=SUM(R[-1]C:R[-'+IntToStr(ACount)+']C)';
    //финализация
    XL.Cells[2,1,5,ACount+5].Frame := [feTotal];
    Xl.Zoom := 100;
  finally
    Xl.Free;
  end;{try}
end;{pmiAutosExcelClick}
procedure TfmAdditionalParams.pmiAutosPrintClick(Sender: TObject);
begin
end;{pmiAutosPrintClick}
procedure TfmAdditionalParams.pmAutosPopup(Sender: TObject);
begin
  pmiAutosDefault.Enabled := fmDM.quAutoOtherAccounts.RecordCount>0;
end;{pmAutosPopup}

procedure TfmAdditionalParams.pmiRoadsDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(EDefaultConfirm)then
  begin
    DefaultParams.ParamsRoadsBuildingCosts := fmDM.quRoadOtherAccountsBuildingCosts.AsFloat;
    DefaultParams.ParamsRoadsKeepingCosts := fmDM.quRoadOtherAccountsKeepingCosts.AsFloat;
    DefaultParams.ParamsRoadsAmortizationNorm := fmDM.quRoadOtherAccountsAmortizationNorm.AsFloat;
  end;{if}
end;{pmiRoadsDefaultClick}
procedure TfmAdditionalParams.pmiRoadsExcelClick(Sender: TObject);
var
  XL: TExcelEditor;
  ACount: Integer;
begin
  Xl := TExcelEditor.Create;
  try
    //Заголовок
    Xl.TitleCell[1,1,5,1] := 'Дополнительные показатели по автодороге';
    XL.RangeTitleOn(2,1,['№','Дорожное покрытие','Затраты на сооружение, тыс.тенге',
                         'Норма амортизации','Содержание, тыс.тенге/год']);
    //Ширина столбцов
    XL.ColumnWidths[1,1] := 5;
    XL.ColumnWidths[2,1] := 50;
    XL.ColumnWidths[3,3] := 10;
    //Данные
    with fmDM do
    begin
      ACount := quRoadOtherAccounts.RecordCount;
      if ACount=0 then Inc(ACount);
      quRoadOtherAccounts.First;
      while not quRoadOtherAccounts.Eof do
      begin
        XL.IntegerCells[quRoadOtherAccounts.RecNo+3,1] := quRoadOtherAccounts.RecNo;
        XL.StringCells[quRoadOtherAccounts.RecNo+3,2] := quRoadOtherAccountsRoadCoat.AsString;
        XL.FloatCells[quRoadOtherAccounts.RecNo+3,3] := quRoadOtherAccountsBuildingCosts.AsFloat;
        XL.FloatCells[quRoadOtherAccounts.RecNo+3,4] := quRoadOtherAccountsAmortizationNorm.AsFloat;
        XL.FloatCells[quRoadOtherAccounts.RecNo+3,5] := quRoadOtherAccountsKeepingCosts.AsFloat;
        quRoadOtherAccounts.Next;
      end;{while}
      quRoadOtherAccounts.First;
      XL.Cells[4,3,3,ACount].NumberFormat := nfFloat00;
    end;{with}
    //Подножие
    XL.TitleCell[ACount+4,1,2,1] := 'Итого:';
    XL.Cells[ACount+4,1,2,1].HorizontalAlignment := haLeft;
    XL.Cells[ACount+4,1,5,1].Font.Style := [xlfsBold];
    XL.StringCells[ACount+4,3] := '=SUM(R[-1]C:R[-'+IntToStr(ACount)+']C)';
    XL.StringCells[ACount+4,5] := '=SUM(R[-1]C:R[-'+IntToStr(ACount)+']C)';
    //финализация
    XL.Cells[2,1,5,ACount+3].Frame := [feTotal];
    Xl.Zoom := 100;
  finally
    Xl.Free;
  end;{try}
end;{pmiRoadsExcelClick}
procedure TfmAdditionalParams.pmiRoadsPrintClick(Sender: TObject);
begin
end;{pmiRoadsPrintClick}
procedure TfmAdditionalParams.pmRoadsPopup(Sender: TObject);
begin
  pmiRoadsDefault.Enabled := fmDM.quRoadOtherAccounts.RecordCount>0;
end;{pmRoadsPopup}

procedure TfmAdditionalParams.lsbExcavsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source=lsbAutos)and(lsbAutos.Count>0)and(lsbExcavs.Count>0);
end;{lsbExcavsDragOver}
procedure TfmAdditionalParams.lsbExcavsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AIndex: Integer;
  sAuto,sExcav,sAccording: String;
  AIsExist: Boolean;
begin
  if (Source=lsbAutos)and(lsbAutos.Count>0)and(lsbExcavs.Count>0) then
  with fmDM do
  begin
    AIndex := lsbExcavs.ItemAtPos(Point(X,Y),true);
    if AIndex=-1 then AIndex := lsbExcavs.Count-1;
    lsbExcavs.ItemIndex := AIndex;
    sAuto := lsbAutos.Items[lsbAutos.ItemIndex];
    sExcav := lsbExcavs.Items[lsbExcavs.ItemIndex];
    sAccording := sAuto+' - '+sExcav;
    AIsExist := false;
    quAutoExcavAccordances.First;
    while not quAutoExcavAccordances.Eof do
    begin
      if quAutoExcavAccordancesTotalName.AsString=sAccording then
      begin
        AIsExist := true; esaMsgError('Сочетание "'+sAccording+'" уже существует.'); Break;
      end;{if}
      quAutoExcavAccordances.Next;
    end;{while}
    if not AIsExist then
    if quAutos.Locate('Name',sAuto,[])and quExcavators.Locate('Name',sExcav,[])then
    begin
      quAutoExcavAccordances.Append;
      quAutoExcavAccordancesId_Auto.AsInteger := quAutosId_Auto.AsInteger;
      quAutoExcavAccordancesId_Excavator.AsInteger := quExcavatorsId_Excavator.AsInteger;
      quAutoExcavAccordances.Post;
      quAutoExcavAccordances.Requery;
      quAutoExcavAccordances.Last;
    end;{else}
    btDelete.Enabled := quAutoExcavAccordances.RecordCount>0;
    btDeleteAll.Enabled := btDelete.Enabled;
  end;{if}
end;{lsbExcavsDragDrop}

procedure TfmAdditionalParams.lsbAutosDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AIndex: Integer;
  sAuto,sExcav,sAccording: String;
  AIsExist: Boolean;
begin
  if (Source=lsbExcavs)and(lsbAutos.Count>0)and(lsbExcavs.Count>0) then
  with fmDM do
  begin
    AIndex := lsbAutos.ItemAtPos(Point(X,Y),true);
    if AIndex=-1 then AIndex := lsbAutos.Count-1;
    lsbAutos.ItemIndex := AIndex;
    sAuto := lsbAutos.Items[lsbAutos.ItemIndex];
    sExcav := lsbExcavs.Items[lsbExcavs.ItemIndex];
    sAccording := sAuto+' - '+sExcav;
    AIsExist := false;
    quAutoExcavAccordances.First;
    while not quAutoExcavAccordances.Eof do
    begin
      if quAutoExcavAccordancesTotalName.AsString=sAccording then
      begin
        AIsExist := true; esaMsgError('Сочетание "'+sAccording+'" уже существует.'); Break;
      end;{if}
      quAutoExcavAccordances.Next;
    end;{while}
    if not AIsExist then
    if quAutos.Locate('Name',sAuto,[])and quExcavators.Locate('Name',sExcav,[])then
    begin
      quAutoExcavAccordances.Append;
      quAutoExcavAccordancesId_Auto.AsInteger := quAutosId_Auto.AsInteger;
      quAutoExcavAccordancesId_Excavator.AsInteger := quExcavatorsId_Excavator.AsInteger;
      quAutoExcavAccordances.Post;
      quAutoExcavAccordances.Requery;
      quAutoExcavAccordances.Last;
    end;{else}
    btDelete.Enabled := quAutoExcavAccordances.RecordCount>0;
    btDeleteAll.Enabled := btDelete.Enabled;
  end;{if}
end;{lsbAutosDragDrop}
procedure TfmAdditionalParams.lsbAutosDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source=lsbExcavs)and(lsbAutos.Count>0)and(lsbExcavs.Count>0);
end;{lsbAutosDragOver}

procedure TfmAdditionalParams.lsbAutosEnter(Sender: TObject);
begin
end;{lsbAutosEnter}

procedure TfmAdditionalParams.btAddClick(Sender: TObject);
var
  sAuto,sExcav,sAccording: String;
  AIsExist: Boolean;
begin
  if (lsbAutos.Count>0)and(lsbExcavs.Count>0)then
  with fmDM do
  begin
    if lsbAutos.ItemIndex=-1 then lsbAutos.ItemIndex := 0;
    if lsbExcavs.ItemIndex=-1 then lsbExcavs.ItemIndex := 0;
    sAuto := lsbAutos.Items[lsbAutos.ItemIndex];
    sExcav := lsbExcavs.Items[lsbExcavs.ItemIndex];
    sAccording := sAuto+' - '+sExcav;
    AIsExist := false;
    quAutoExcavAccordances.First;
    while not quAutoExcavAccordances.Eof do
    begin
      if quAutoExcavAccordancesTotalName.AsString=sAccording then
      begin
        AIsExist := true; esaMsgError('Сочетание "'+sAccording+'" уже существует.'); Break;
      end;{if}
      quAutoExcavAccordances.Next;
    end;{while}
    if not AIsExist then
    if quAutos.Locate('Name',sAuto,[])and quExcavators.Locate('Name',sExcav,[])then
    begin
      quAutoExcavAccordances.Append;
      quAutoExcavAccordancesId_Auto.AsInteger := quAutosId_Auto.AsInteger;
      quAutoExcavAccordancesId_Excavator.AsInteger := quExcavatorsId_Excavator.AsInteger;
      quAutoExcavAccordances.Post;
      quAutoExcavAccordances.Requery;
      quAutoExcavAccordances.Last;
    end;{else}
    btDelete.Enabled := quAutoExcavAccordances.RecordCount>0;
    btDeleteAll.Enabled := btDelete.Enabled;
  end;{if}
end;{btAddClick}

procedure TfmAdditionalParams.btDeleteClick(Sender: TObject);
begin
  with fmDM do
  if quAutoExcavAccordances.RecordCount>0 then
  begin
    quAutoExcavAccordances.Tag := quAutoExcavAccordances.RecNo;
    quAutoExcavAccordances.Delete;
    quAutoExcavAccordances.Requery;
    if quAutoExcavAccordances.Tag>quAutoExcavAccordances.RecordCount
    then quAutoExcavAccordances.Last
    else quAutoExcavAccordances.MoveBy(quAutoExcavAccordances.Tag-1);
    btDelete.Enabled := quAutoExcavAccordances.RecordCount>0;
    btDeleteAll.Enabled := btDelete.Enabled;
  end;{if}
end;{btDeleteClick}

procedure TfmAdditionalParams.dbedTotalKursKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['.',','] then Key := DecimalSeparator;
end;{dbedTotalKursKeyPress}

procedure TfmAdditionalParams.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
const
  ACaptions: array[0..2]of string=
  ('Дополнительные параметры',
   'Дополнительные параметры по автосамосвалам',
   'Дополнительные параметры по автодороге');
begin
  AllowChange :=
    CanCloseModifiedQuery(fmDM.quOpenpits,ACaptions[0])and
    CanCloseModifiedQuery(fmDM.quAutoOtherAccounts,ACaptions[1])and
    CanCloseModifiedQuery(fmDM.quRoadOtherAccounts,ACaptions[2]);
end;{PageControlChanging}

procedure TfmAdditionalParams.btDeleteAllClick(Sender: TObject);
begin
  with fmDM do
  if quAutoExcavAccordances.RecordCount>0 then
  begin
    quAutoExcavAccordances.First;
    while not quAutoExcavAccordances.Eof do
      quAutoExcavAccordances.Delete;
    quAutoExcavAccordances.Requery;
    btDelete.Enabled := quAutoExcavAccordances.RecordCount>0;
    btDeleteAll.Enabled := btDelete.Enabled;
  end;{if}
end;{btDeleteAllClick}

procedure TfmAdditionalParams.PrintTotalParams(var XL: TExcelEditor);
begin
  //Общие дополнительные параметры-------------------------------------------------------------
  XL.TitleCell[1,1, 9,1] := 'I. Общие дополнительные параметры';
  XL.Cells[1,1,9,1].Font.Style := [xlfsBold];
  XL.Cells[1,1,9,1].Font.Size := 10;
  XL.Cells[2,1,9,8].NumberFormat := nfFloat00;
  XL.TitleCell[ 2,1, 8,1] := CaptionToStr(lbTotalKurs.Caption);
  XL.TitleCell[ 3,1, 8,1] := CaptionToStr(lbTotalExpenses.Caption);
  XL.TitleCell[ 4,1, 8,1] := CaptionToStr(lbTotalSalaryCoef.Caption);
  XL.Cells[2,1,8,3].HorizontalAlignment := haLeft;
  XL.TitleCell[ 5,1, 9,1] := CaptionToStr(gbTotalShiftUsingCoef.Caption);
  XL.TitleCell[ 6,1, 8,1] := CaptionToStr(lbTotalShiftUsingCoefNormal.Caption);
  XL.TitleCell[ 7,1, 8,1] := CaptionToStr(lbTotalShiftUsingCoefDayShift.Caption);
  XL.TitleCell[ 8,1, 8,1] := CaptionToStr(lbTotalShiftUsingCoefExplosion.Caption);
  XL.TitleCell[ 9,1, 8,1] := CaptionToStr(lbTotalShiftUsingCoefExplosionCount.Caption);
  XL.Cells[6,1,8,4].HorizontalAlignment := haLeft;
  with fmDM do
  begin
    XL.FloatCells[ 2, 9] := quOpenpitsTotalKurs.AsFloat;
    XL.FloatCells[ 3, 9] := quOpenpitsTotalExpenses.AsFloat;
    XL.FloatCells[ 4, 9] := quOpenpitsTotalSalaryCoef.AsFloat;
    XL.FloatCells[ 6, 9] := quOpenpitsTotalShiftUsingCoefNormal.AsFloat;
    XL.FloatCells[ 7, 9] := quOpenpitsTotalShiftUsingCoefDayShift.AsFloat;
    XL.FloatCells[ 8, 9] := quOpenpitsTotalShiftUsingCoefExplosion.AsFloat;
    XL.FloatCells[ 9, 9] := quOpenpitsTotalShiftUsingCoefExplosionCount.AsFloat;
  end;{with}
  XL.Cells[6,1,9,4].Frame := [feTotal];
  XL.Cells[6,1,9,3].Frame := [feTotal,feBottomBold];
end;{PrintTotalParams}
procedure TfmAdditionalParams.PrintExcavsParams(var XL: TExcelEditor);
begin
  //Дополнительные параметры по экскаваторам---------------------------------------------------
  XL.TitleCell[11,1, 9,1] := 'II. Дополнительные параметры по экскаваторам';
  XL.Cells[11,1,9,1].Font.Style := [xlfsBold];
  XL.Cells[11,1,9,1].Font.Size := 10;
  XL.Cells[12,9,1,9].NumberFormat := nfFloat00;
  XL.TitleCell[12,1, 9,1] := CaptionToStr(gbExcavsSalary.Caption);
  XL.TitleCell[13,1, 8,1] := CaptionToStr(lbExcavsSalaryMashinist.Caption);
  XL.TitleCell[14,1, 8,1] := CaptionToStr(lbExcavsSalaryAssistant.Caption);
  XL.TitleCell[15,1, 9,1] := CaptionToStr(gbExcavsWorkRezim.Caption);
  XL.TitleCell[16,1, 8,1] := CaptionToStr(lbExcavsWorkRezimWorkShiftsCount.Caption);
  XL.TitleCell[17,1, 8,1] := CaptionToStr(lbExcavsWorkRezimWorkShiftDuration.Caption);
  XL.TitleCell[18,1, 8,1] := CaptionToStr(lbExcavsShiftTurnoverTime.Caption);
  XL.TitleCell[19,1, 8,1] := CaptionToStr(gbExcavsEnergyCost.Caption);
  XL.TitleCell[20,1, 8,1] := CaptionToStr(gbExcavsAmortazationNorm.Caption);
  XL.Cells[13,1,8,2].HorizontalAlignment := haLeft;
  XL.Cells[16,1,8,3].HorizontalAlignment := haLeft;
  XL.Cells[19,1,8,2].HorizontalAlignment := haLeft;
  with fmDM do
  begin
    XL.FloatCells[13,9] := quOpenpitsExcavsSalaryMashinist0.AsFloat+
                           quOpenpitsExcavsSalaryMashinist1.AsFloat;
    XL.FloatCells[14,9] := quOpenpitsExcavsSalaryAssistant0.AsFloat+
                           quOpenpitsExcavsSalaryAssistant1.AsFloat;
    XL.FloatCells[16,9] := quOpenpitsExcavsWorkShiftsCount.AsFloat;
    XL.FloatCells[17,9] := quOpenpitsExcavsWorkShiftDuration.AsFloat;
    XL.FloatCells[18,9] := quOpenpitsExcavsShiftTurnoverTime.AsFloat;
    XL.FloatCells[19,9] := quOpenpitsExcavsEnergyCost.AsFloat;
    XL.FloatCells[20,9] := quOpenpitsExcavsAmortazationNorm.AsFloat;
  end;{with}
  XL.Cells[13,1,9,2].Frame := [feTotal];
  XL.Cells[16,1,9,3].Frame := [feTotal];
end;{PrintExcavsParams}
procedure TfmAdditionalParams.PrintAutosParams(var XL: TExcelEditor);
begin
  //Дополнительные параметры по автосамосвалам-------------------------------------------------
  XL.TitleCell[22,1, 9,1] := 'III. Дополнительные параметры по автосамосвалам';
  XL.Cells[22,1,9,1].Font.Style := [xlfsBold];
  XL.Cells[22,1,9,1].Font.Size := 10;
  XL.Cells[23,9,1,12].NumberFormat := nfFloat00;
  XL.TitleCell[23,1,9,1] := CaptionToStr(gbAutosSalary.Caption);
  XL.TitleCell[24,1,8,1] := CaptionToStr(lbAutosSalary.Caption);
  XL.TitleCell[25,1,8,1] := CaptionToStr(lbAutosSalaryPlus.Caption);
  XL.TitleCell[26,1,9,1] := CaptionToStr(gbAutosWorkRezim.Caption);
  XL.TitleCell[27,1,8,1] := CaptionToStr(lbAutosWorkRezimWorkShiftsCount.Caption);
  XL.TitleCell[28,1,8,1] := CaptionToStr(lbAutosWorkRezimWorkShiftDuration.Caption);
  XL.TitleCell[29,1,8,1] := CaptionToStr(lbAutosShiftTurnoverTime.Caption);

  XL.TitleCell[31,1,9,1] := CaptionToStr(tsAutosFuel.Caption);
  XL.TitleCell[32,1,9,1] := CaptionToStr(gbAutosFuelCost.Caption);
  XL.TitleCell[33,1,8,1] := CaptionToStr(lbAutosFuelCostWinter.Caption);
  XL.TitleCell[34,1,8,1] := CaptionToStr(lbAutosFuelCostSummer.Caption);
  XL.TitleCell[35,1,8,1] := CaptionToStr(lbAutosWinterMonthCount.Caption);
  XL.TitleCell[36,1,7,1] := CaptionToStr(lbAutosFuelCostTarif.Caption);
  XL.Cells[24,1,8,2].HorizontalAlignment := haLeft;
  XL.Cells[27,1,8,3].HorizontalAlignment := haLeft;
  XL.Cells[33,1,8,4].HorizontalAlignment := haLeft;
  XL.Cells[31,1,9,1].Font.Style := [xlfsBold];
  with fmDM do
  begin
    XL.FloatCells[24,9] := quOpenpitsAutosSalary0.AsFloat;
    XL.FloatCells[25,9] := quOpenpitsAutosSalary1.AsFloat;
    XL.FloatCells[27,9] := quOpenpitsAutosWorkShiftsCount.AsFloat;
    XL.FloatCells[28,9] := quOpenpitsAutosWorkShiftDuration.AsFloat;
    XL.FloatCells[29,9] := quOpenpitsAutosShiftTurnoverTime.AsFloat;
    XL.FloatCells[33,9] := quOpenpitsAutosFuelCostWinter.AsFloat;
    XL.FloatCells[34,9] := quOpenpitsAutosFuelCostSummer.AsFloat;
    XL.FloatCells[35,9] := quOpenpitsAutosWinterMonthCount.AsFloat;
    XL.TitleCell[36,8,2,1] := dbcbAutosFuelCostTarif.Items[quOpenpitsAutosFuelCostTarif.AsInteger];
  end;{with}
  XL.Cells[24,1,9,2].Frame := [feTotal];
  XL.Cells[27,1,9,3].Frame := [feTotal];
  XL.Cells[33,1,9,2].Frame := [feTotal];
end;{PrintAutosParams}
procedure TfmAdditionalParams.PrintAutosOtherParams(var XL: TExcelEditor);
var ACount: Integer;
begin
  //Прочие затраты по моделям автосамосвалов---------------------------------------------------
  XL.TitleCell[38,1, 9,1] := 'Прочие затраты по моделям автосамосвалов';
  XL.Cells[38,1,9,1].Font.Style := [xlfsBold];
  XL.TitleCell[39,1,1,4] := '№';
  XL.TitleCell[39,2,2,4] := 'Модель';
  XL.TitleCell[39,4,4,2] := 'Прочие затраты, в % к затратам на топливо';
  XL.TitleCell[41,4,2,2] := 'Запасные части и материалы';
  XL.TitleCell[41,6,2,2] := 'Смазочные материалы';
  XL.TitleCell[39,8,2,4] := 'Содержание ремонтного персонала, тыс.тенге/мес';
  XL.TitleCell[43,1,1,1] := '1';
  XL.TitleCell[43,2,2,1] := '2';
  XL.TitleCell[43,4,2,1] := '3';
  XL.TitleCell[43,6,2,1] := '4';
  XL.TitleCell[43,8,2,1] := '5';
  XL.TitleCell[44,2,2,1] := '';
  XL.TitleCell[44,4,2,1] := '';
  XL.TitleCell[44,6,2,1] := '';
  XL.TitleCell[44,8,2,1] := '';
  with fmDM do
  begin
    if quAutoOtherAccounts.RecordCount>0
    then ACount := quAutoOtherAccounts.RecordCount
    else ACount := 1;
    XL.Cells[39,1,9,5+ACount].Frame := [feTotal];
    XL.Cells[44,2,8,ACount].NumberFormat := nfFloat00;
    quAutoOtherAccounts.First;
    while not quAutoOtherAccounts.EOF do
    begin
      XL.IntegerCells[43+quAutoOtherAccounts.RecNo,1] := quAutoOtherAccounts.RecNo;
      XL.StringCells[43+quAutoOtherAccounts.RecNo,2] := quAutoOtherAccountsName.AsString;
      XL.FloatCells[43+quAutoOtherAccounts.RecNo,4] := quAutoOtherAccountsSpares.AsFloat;
      XL.FloatCells[43+quAutoOtherAccounts.RecNo,6] := quAutoOtherAccountsGreasingSubstance.AsFloat;
      XL.FloatCells[43+quAutoOtherAccounts.RecNo,8] := quAutoOtherAccountsMaintenanceCost.AsFloat;
      XL.Cells[43+quAutoOtherAccounts.RecNo,2,2,1].MergeCells := True;
      XL.Cells[43+quAutoOtherAccounts.RecNo,4,2,1].MergeCells := True;
      XL.Cells[43+quAutoOtherAccounts.RecNo,6,2,1].MergeCells := True;
      XL.Cells[43+quAutoOtherAccounts.RecNo,8,2,1].MergeCells := True;
      quAutoOtherAccounts.Next;
    end;{while}
    quAutoOtherAccounts.First;
  end;{with}
end;{PrintAutosOtherParams}
procedure TfmAdditionalParams.PrintRoadParams(var XL: TExcelEditor);
var ACount,ARow: Integer;
begin
  //Дополнительные параметры по автотрассе-----------------------------------------------------
  XL.TitleCell[1,1, 9,1] := 'IV. Дополнительные параметры по автотрассе';
  XL.Cells[1,1,9,1].Font.Style := [xlfsBold];
  XL.TitleCell[2,1,1,5] := '№';
  XL.TitleCell[2,2,5,5] := 'Дорожное покрытие';
  XL.TitleCell[2,7,1,5] := 'Затраты на соору-жение, тыс.тенге /год';
  XL.TitleCell[2,8,1,5] := 'Норма аморти-зации';
  XL.TitleCell[2,9,1,5] := 'Содер-жание, тыс.тенге /год';
  XL.TitleCell[7,1,1,1] := '1';
  XL.TitleCell[7,2,5,1] := '2';
  XL.TitleCell[7,7,1,1] := '3';
  XL.TitleCell[7,8,1,1] := '4';
  XL.TitleCell[7,9,1,1] := '5';
  with fmDM do
  begin
    if quRoadOtherAccounts.RecordCount>0
    then ACount := quRoadOtherAccounts.RecordCount
    else ACount := 1;
    XL.Cells[2,1,9,6+ACount].Frame := [feTotal];
    XL.Cells[8,3,7,ACount].NumberFormat := nfFloat00;
    XL.TitleCell[8,2,5,1] := '';
    quRoadOtherAccounts.First;
    while not quRoadOtherAccounts.EOF do
    begin
      XL.IntegerCells[7+quRoadOtherAccounts.RecNo,1] := quRoadOtherAccounts.RecNo;
      XL.StringCells[7+quRoadOtherAccounts.RecNo,2] := quRoadOtherAccountsRoadCoat.AsString;
      XL.FloatCells[7+quRoadOtherAccounts.RecNo,7] := quRoadOtherAccountsBuildingCosts.AsFloat;
      XL.FloatCells[7+quRoadOtherAccounts.RecNo,8] := quRoadOtherAccountsAmortizationNorm.AsFloat;
      XL.FloatCells[7+quRoadOtherAccounts.RecNo,9] := quRoadOtherAccountsKeepingCosts.AsFloat;
      XL.Cells[7+quRoadOtherAccounts.RecNo,2,5,1].MergeCells := True;
      quRoadOtherAccounts.Next;
    end;{while}
    quRoadOtherAccounts.First;
  end;{with}
  //Режим работы автосамосвалов----------------------------------------------------------------
  ARow := ACount+8;
  XL.TitleCell[ARow+1,1, 9,1] := 'V. Режим работы автосамосвалов';
  XL.Cells[ARow+1,1,9,1].Font.Style := [xlfsBold];
  XL.TitleCell[ARow+2,1,9,1] := CaptionToStr(dbrgAutosWorkRegime.Caption);
  XL.TitleCell[ARow+3,1,8,1] := CaptionToStr(dbrgAutosWorkRegime.Items[0]);
  XL.TitleCell[ARow+4,1,8,1] := CaptionToStr(dbrgAutosWorkRegime.Items[1]);
  XL.TitleCell[ARow+5,1,8,1] := CaptionToStr(dbcbIsStrippingCoefUsing.Caption);
  XL.Cells[ARow+3,1,8,3].HorizontalAlignment := haLeft;
  XL.Cells[ARow+3,1,9,3].Frame := [feTotal];
  XL.Cells[ARow+3,1,9,2].Frame := [feTotal,feBottomBold];
  with fmDM do
  begin
    if quOpenpitsWorkRegimeKind.AsInteger=0
    then XL.TitleCell[ARow+3,9,1,1] := '+'
    else XL.TitleCell[ARow+3,9,1,1] := '-';
    if quOpenpitsWorkRegimeKind.AsInteger=1
    then XL.TitleCell[ARow+4,9,1,1] := '+'
    else XL.TitleCell[ARow+4,9,1,1] := '-';
    if quOpenpitsWorkRegimeIsStrippingCoefUsing.AsBoolean
    then XL.TitleCell[ARow+5,9,1,1] := '+'
    else XL.TitleCell[ARow+5,9,1,1] := '-';
  end;{with}
  ARow := ARow+6;

  with fmDM do
  begin
    if quAutoExcavAccordances.RecordCount>0
    then ACount := quAutoExcavAccordances.RecordCount
    else ACount := 1;
    XL.TitleCell[ARow+1,1,9,1] := 'Соответствие типов автосамосвалов типам экскаваторов';
    XL.TitleCell[ARow+2,1,4,1] := 'Автосамосвалы';
    XL.TitleCell[ARow+2,5,1,1] := '-';
    XL.TitleCell[ARow+2,6,4,1] := 'Экскаваторы';
    XL.TitleCell[ARow+3,1,4,1] := '1';
    XL.TitleCell[ARow+3,5,1,1] := '2';
    XL.TitleCell[ARow+3,6,4,1] := '3';
    XL.Cells[ARow+2,1,9,2+ACount].Frame := [feTotal];
    XL.TitleCell[ARow+4,1,4,1] := '';
    XL.TitleCell[ARow+4,5,1,1] := '';
    XL.TitleCell[ARow+4,6,4,1] := '';
    quAutoExcavAccordances.First;
    while not quAutoExcavAccordances.EOF do
    begin
      XL.TitleCell[ARow+3+quAutoExcavAccordances.RecNo,1,4,1] := quAutoExcavAccordancesAuto.AsString;
      XL.TitleCell[ARow+3+quAutoExcavAccordances.RecNo,5,1,1] := '->';
      XL.TitleCell[ARow+3+quAutoExcavAccordances.RecNo,6,4,1] := quAutoExcavAccordancesExcavator.AsString;
      quAutoExcavAccordances.Next;
    end;{while}
    quAutoExcavAccordances.First;
  end;{with}
end;{PrintRoadParams}
procedure TfmAdditionalParams.btExcelClick(Sender: TObject);
var XL: TExcelEditor;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 2;
    XL.SheetName := 'PartI';
    PrintTotalParams(XL);
    PrintExcavsParams(XL);
    PrintAutosParams(XL);
    PrintAutosOtherParams(XL);
    XL.Zoom := 100;
    XL.ActiveSheetIndex := 1;
    XL.SheetName := 'PartII';
    XL.Zoom := 50;
    PrintRoadParams(XL);
    XL.Zoom := 100;
    XL.ActiveSheetIndex := 0;
  finally
    XL.Free;
  end;{try}
end;{btExcelClick}

procedure TfmAdditionalParams.PageControlChange(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    0: HelpKeyword := AHelpKeyWord;
    1: HelpKeyword := 'Excavator'+AHelpKeyWord;
    2: HelpKeyword := 'Auto'+AHelpKeyWord;
    3: HelpKeyword := 'AutoRoad'+AHelpKeyWord;
    4: HelpKeyword := 'AutoRegime'+AHelpKeyWord;
  end;{case}
end;{PageControlChange}

procedure TfmAdditionalParams.FormShow(Sender: TObject);
begin
  PageControlChange(Sender);
end;{FormShow}

end.
