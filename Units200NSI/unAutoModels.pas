unit unAutoModels;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBCtrls, ComCtrls, Mask,
  TeeProcs, TeEngine, Chart, DbChart, Series, TeePrevi, Menus, ExtDlgs, types,
  ExcelEditors;
const
  BUTTONSELECT = 'Выбрать';
  BUTTONCHANGE = 'Изменить';
  BUTTONSAVE = 'Сохранить';
  TITLE_NO = '№';
  TITLE_V = 'Скорость, км/ч';
  TITLE_F = 'Сила тяги, Н';
  TITLE_M = 'Сила тяги, кгс';
type
  TfmAutoModels = class(TForm)
    pnAutos: TPanel;
    sttAutos: TStaticText;
    PageControl: TPageControl;
    tsTotal: TTabSheet;
    tsFK: TTabSheet;
    tsGraph: TTabSheet;
    lbBodySpace: TLabel;
    lbTonnage: TLabel;
    lbTransmissionKind: TLabel;
    lbTr: TLabel;
    lbP: TLabel;
    lbRmin: TLabel;
    lbTyresCount: TLabel;
    lbLength: TLabel;
    lbWidth: TLabel;
    lbHeight: TLabel;
    dbeBodySpace: TDBEdit;
    dbeTonnage: TDBEdit;
    dbeTr: TDBEdit;
    dbeP: TDBEdit;
    dbeRmin: TDBEdit;
    dbeTyresCount: TDBEdit;
    dbeLength: TDBEdit;
    dbeWidth: TDBEdit;
    dbeHeight: TDBEdit;
    lbTransmissionKPD: TLabel;
    dbeTransmissionKPD: TDBEdit;
    dbgAutos: TDBGrid;
    dbcbTransmissionKind: TDBComboBox;
    pbAutos: TPaintBox;
    lbEngines: TLabel;
    dblcbEngines: TDBLookupComboBox;
    dbchFks: TDBChart;
    Series1: TFastLineSeries;
    pmChart: TPopupMenu;
    pmiChartSaveAs: TMenuItem;
    pmiChartPrint: TMenuItem;
    pmAutos: TPopupMenu;
    pmiAutoAdd: TMenuItem;
    pmiAutoEdit: TMenuItem;
    pmiAutoDelete: TMenuItem;
    pmiAutoDeleteAll: TMenuItem;
    pmiAutoSep1: TMenuItem;
    pmiAutoDefault: TMenuItem;
    pmiAutoSep3: TMenuItem;
    pmiAutoExcel: TMenuItem;
    pmiAutoSep4: TMenuItem;
    pmFks: TPopupMenu;
    pmiFksAdd: TMenuItem;
    pmiFksEdit: TMenuItem;
    pmiFksDelete: TMenuItem;
    pmiFksDeleteAll: TMenuItem;
    dbeF: TDBEdit;
    lbF: TLabel;
    lbRo: TLabel;
    dbeRo: TDBEdit;
    pmiAutoDefaultsDlg: TMenuItem;
    pmiAutoUp: TMenuItem;
    pmiAutoDown: TMenuItem;
    pmiAutoSep2: TMenuItem;
    dbeEngineNmax: TDBEdit;
    lbEngineNmax: TLabel;
    pmiExcelParams: TMenuItem;
    pmiExcelParamsPrintFkTable: TMenuItem;
    pmiExcelParamsInDollar: TMenuItem;
    pmiFksSep1: TMenuItem;
    pmiFksImportFrom: TMenuItem;
    dbmNote: TDBMemo;
    Panel1: TPanel;
    Button1: TButton;
    sgFk: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure pbAutosPaint(Sender: TObject);
    procedure pbFksPaint(Sender: TObject);
    procedure pmiChartSaveAsClick(Sender: TObject);
    procedure pmiChartPrintClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure pmiAutoAddClick(Sender: TObject);
    procedure pmiAutoEditClick(Sender: TObject);
    procedure pmiAutoDeleteClick(Sender: TObject);
    procedure pmiAutoDeleteAllClick(Sender: TObject);
    procedure pmiAutoDefaultClick(Sender: TObject);
    procedure pmiAutoExcelClick(Sender: TObject);
    procedure pmiAutoDefaultsDlgClick(Sender: TObject);
    procedure pmiAutoUpClick(Sender: TObject);
    procedure pmiAutoDownClick(Sender: TObject);
    procedure pmiExcelParamsPrintFkTableClick(Sender: TObject);
    procedure pmiExcelParamsInDollarClick(Sender: TObject);
    procedure pmAutosPopup(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure pmFksPopup(Sender: TObject);
    procedure pmiFksAddClick(Sender: TObject);
    procedure pmiFksEditClick(Sender: TObject);
    procedure pmiFksDeleteClick(Sender: TObject);
    procedure pmiFksDeleteAllClick(Sender: TObject);
    procedure pmiFksImportFromClick(Sender: TObject);
    procedure dbeBodySpaceKeyPress(Sender: TObject; var Key: Char);
    procedure dbgFksDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure sgFkDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure sgFkKeyPress(Sender: TObject; var Key: Char);
    procedure sgFkKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgFkSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure dbgAutosCellClick(Column: TColumn);
    procedure dbgAutosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FAutoSortIndex: Integer;         //Порядковый номер Auto
    FAutoName     : String;          //Уникальное название Auto
    FAutoColWidths: TIntegerDynArray;//Ширина столбцов таблицы Auto
    FFkColWidths  : TIntegerDynArray;//Ширина столбцов таблицы Fk
    FCol: integer;
    FRow: integer;
    procedure DoAutoAfterScroll(DataSet: TDataSet);
    procedure DoAutoAfterDelete(DataSet: TDataSet);
    procedure DoAutoAfterInsert(DataSet: TDataSet);
    procedure DoAutoAfterPost(DataSet: TDataSet);
    procedure DoAutoBeforeDelete(DataSet: TDataSet);
    procedure DoAutoBeforeInsert(DataSet: TDataSet);
    procedure DoAutoBeforePost(DataSet: TDataSet);

    procedure DoFkAfterDelete(DataSet: TDataSet);
    procedure DoFkAfterPost(DataSet: TDataSet);
    procedure DoFkBeforeDelete(DataSet: TDataSet);
    procedure DoFkBeforePost(DataSet: TDataSet);
    procedure PrintAutoFks(XL: TExcelEditor);
    procedure PrintAutoModels(XL: TExcelEditor);
    procedure string_grid_view();
    procedure fetch_data_to_string_grid(id_auto: integer);
    procedure string_grid_recalc(col, row: integer);
  public
  end;{TfmAutos}
var
  fmAutoModels: TfmAutoModels;
//Диалоговое окно моделей автосамосвалов
procedure esaShowAutoModelsDlg();
implementation
uses unDM, ADODb, unAutoModelDefaults, Math, Printers, esaMessages, esaGlobals;
{$R *.dfm}

//Диалоговое окно моделей автосамосвалов
procedure esaShowAutoModelsDlg();
begin
  fmAutoModels:= TfmAutoModels.Create(nil);
  try
    fmAutoModels.ShowModal;
  finally
    fmAutoModels.Free;
  end;
end;

procedure TfmAutoModels.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  PageControl.ActivePageIndex := 0;
//  dbgFks.Options := [dgEditing,dgAlwaysShowEditor,dgIndicator,dgColLines,dgRowLines,dgTabs];

  SetLength(FAutoColWidths,dbgAutos.Columns.Count);
//  SetLength(FFkColWidths,dbgFks.Columns.Count);
  FAutoName := '';

  with fmDM do
  begin
    quAutoEngines.Open;
    if quAutoEngines.RecordCount=0 then
      raise Exception.Create(EesaAutoEnginesEmpty);
    if not quAutoEngines.Locate('Id_Engine',DefaultParams.AutoId_Engine,[]) then
      DefaultParams.AutoId_Engine := quAutoEnginesId_Engine.AsInteger;
    quAutoEngines.First;
    quAutos.BeforeDelete := DoAutoBeforeDelete;
    quAutos.BeforeInsert := DoAutoBeforeInsert;
    quAutos.BeforePost := DoAutoBeforePost;
    quAutos.AfterDelete := DoAutoAfterDelete;
    quAutos.AfterInsert := DoAutoAfterInsert;
    quAutos.AfterPost := DoAutoAfterPost;
    quAutos.AfterScroll := DoAutoAfterScroll;
    quAutos.Open;

    quAutoFks.BeforeDelete := DoFkBeforeDelete;
    quAutoFks.AfterDelete := DoFkAfterDelete;
    quAutoFks.AfterPost := DoFkAfterPost;
    quAutoFks.BeforePost := DoFkBeforePost;
    quAutoFks.Open;
  end;
  string_grid_view();
  fetch_data_to_string_grid(dbgAutos.SelectedField.AsInteger);
  Button1.Caption:= BUTTONSAVE;
  Button1.Enabled:= False;
end;
procedure TfmAutoModels.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with fmDM do
  begin
    quAutoFks.Close;
    quAutos.Close;
    quAutoEngines.Close;
    quAutos.AfterScroll := nil;
    quAutos.BeforeDelete := nil;
    quAutos.BeforeInsert := nil;
    quAutos.BeforePost := nil;
    quAutos.AfterDelete := nil;
    quAutos.AfterInsert := nil;
    quAutos.AfterPost := nil;

    quAutoFks.BeforeDelete := nil;
    quAutoFks.AfterDelete := nil;
    quAutoFks.AfterPost := nil;
    quAutoFks.BeforePost := nil;
  end;{with}
  FAutoColWidths := nil;
  FFkColWidths := nil;
end;{FormClose}
procedure TfmAutoModels.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := esaCanCloseModifiedQuery(fmDM.quAutos,'Модели автосамосвалов')and
              esaCanCloseModifiedQuery(fmDM.quAutoFks,'Тяговые характеристики');
end;{FormCloseQuery}
procedure TfmAutoModels.FormResize(Sender: TObject);
begin
  esaFitColumnByIndex(dbgAutos,1);
  esaUpdateColumnRights(dbgAutos,FAutoColWidths);
//  esaFitColumnByIndex(dbgFks,1);
//  esaUpdateColumnRights(dbgFks,FFkColWidths);
end;{FormResize}
procedure TfmAutoModels.pbAutosPaint(Sender: TObject);
var Cvs: TCanvas;
begin
  Cvs := pbAutos.Canvas;
  esaDrawGridTitle(pbAutos,dbgAutos,2,FAutoColWidths);
  with dbgAutos do
  begin
    with Columns[0] do
      esaDrawGridCell(Cvs,FAutoColWidths[0]-Width,1,FAutoColWidths[0],hCell,['№']);
    with Columns[1] do
      esaDrawGridCell(Cvs,FAutoColWidths[1]-Width,1,FAutoColWidths[1],hCell,['Наименование']);
    with Columns[2] do
      esaDrawGridCell(Cvs,FAutoColWidths[2]-Width,1,FAutoColWidths[2],hCell,['Q,т']);
  end;{with}
end;{pbAutosPaint}
procedure TfmAutoModels.DoAutoBeforeDelete(DataSet: TDataSet);
begin
  if PageControl.ActivePageIndex<>0 then Abort;
  if not esaMsgQuestionYN(Format(SesaDeleteConfirm,[Dataset.FieldByName('Name').AsString]))
  then Abort;
end;{DoAutoBeforeDelete}
procedure TfmAutoModels.DoAutoBeforeInsert(DataSet: TDataSet);
begin
  if PageControl.ActivePageIndex<>0 then Abort;
  FAutoName := '';
  FAutoSortIndex := Dataset.RecordCount+1;
  if esaInputName('Добавить','Наименование',FAutoName,Dataset.FieldByName('Name').Size)then
  begin
    if DataSet.Locate('Name',FAutoName,[]) then
    begin
      esaMsgError(EesaAutoModelsDuplicateName,[FAutoName]);
      FAutoName := '';
      Abort;
    end;{if}
  end{if}
  else Abort;
end;{DoAutoBeforeInsert}
procedure TfmAutoModels.DoAutoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if Dataset.FieldByName('TransmissionKind').Value=null
    then Dataset.FieldByName('TransmissionKind').AsInteger := 0;
    if Dataset.FieldByName('Id_Engine').Value=null
    then Dataset.FieldByName('Id_Engine').AsInteger := DefaultParams.AutoId_Engine;
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('BodySpace'),1.0)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('Tonnage'),1.0)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('P'),1.0)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('F'),1.0)then Abort else
    if not IsFloatFieldInRange2(DataSet.FieldByName('Ro'),0.0,1.0)then Abort else
    if not IsFloatFieldInRange2(DataSet.FieldByName('TransmissionKPD'),0.0,1.0)then Abort else
    if not IsFloatFieldMoreMin(DataSet.FieldByName('t_r'),0.0)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('Rmin'),0.0)then Abort else
    if not IsIntegerFieldMoreEqualMin(DataSet.FieldByName('TyresCount'),1)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('ALength'),1.0)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('AWidth'),1.0)then Abort else
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('AHeight'),1.0)then Abort else
    if (Dataset.State=dsInsert)and(FAutoName<>'')
    then DataSet.FieldByName('Name').AsString := FAutoName;
  end;{if}
end;{DoAutoBeforePost}
procedure TfmAutoModels.DoAutoAfterScroll(DataSet: TDataSet);
begin
  if PageControl.ActivePageIndex=2 then
  begin
    if fmDM.quAutos.RecordCount=0
    then dbchFks.Title.Text[0] := 'Тяговые характеристики'
    else dbchFks.Title.Text[0] := Format('Тяговые характеристики %s (%.1fт)',[fmDM.quAutosName.AsString,fmDM.quAutosTonnage.AsFloat]);
    dbchFks.RefreshData;
  end;{if}
  if PageControl.ActivePageIndex=1 then
  begin
//    esaFitColumnByIndex(dbgFks,1);
//    esaUpdateColumnRights(dbgFks,FFkColWidths);
//    pbFks.Invalidate;
  end;{if}
end;{DoAutoAfterScroll}
procedure TfmAutoModels.DoAutoAfterDelete(DataSet: TDataSet);
var Id_Auto, ASortIndex: Integer;
begin
  Id_Auto := Dataset.FieldByName('Id_Auto').AsInteger;
  Dataset.DisableControls;
  TADOQuery(Dataset).Requery;
  ASortIndex := 0;
  while not Dataset.Eof do
  begin
    Inc(ASortIndex);
    Dataset.Edit;
    Dataset.FieldByName('SortIndex').AsInteger := ASortIndex;
    Dataset.Post;
    DataSet.Next;
  end;{while}
  TADOQuery(Dataset).Requery;
  Dataset.Locate('Id_Auto',Id_Auto,[]);
  Dataset.EnableControls;
  FormResize(Self);
  pbAutos.Invalidate;
end;{DoAutoAfterDelete}
procedure TfmAutoModels.DoAutoAfterInsert(DataSet: TDataSet);
begin
  if (Dataset.State in [dsInsert])and(FAutoName<>'') then
  begin
    Dataset.FieldbyName('SortIndex').AsInteger := FAutoSortIndex;
    Dataset.FieldbyName('Name').AsString := FAutoName;
    Dataset.FieldbyName('BodySpace').AsFloat := DefaultParams.AutoBodySpace;
    Dataset.FieldbyName('Tonnage').AsFloat := DefaultParams.AutoTonnage;
    Dataset.FieldbyName('P').AsFloat := DefaultParams.AutoP;
    Dataset.FieldbyName('F').AsFloat := DefaultParams.AutoF;
    Dataset.FieldbyName('Ro').AsFloat := DefaultParams.AutoRo;
    Dataset.FieldbyName('TransmissionKPD').AsFloat := DefaultParams.AutoTransmissionKPD;
    Dataset.FieldbyName('t_r').AsFloat := DefaultParams.Autot_r;
    Dataset.FieldbyName('Rmin').AsFloat := DefaultParams.AutoRmin;
    Dataset.FieldbyName('TyresCount').AsInteger := DefaultParams.AutoTyresCount;
    Dataset.FieldbyName('ALength').AsFloat := DefaultParams.AutoLength;
    Dataset.FieldbyName('AWidth').AsFloat := DefaultParams.AutoWidth;
    Dataset.FieldbyName('AHeight').AsFloat := DefaultParams.AutoHeight;
    if Dataset.FieldbyName('TransmissionKind').Value=null then
      Dataset.FieldbyName('TransmissionKind').AsInteger := Integer(DefaultParams.AutoTransmissionKind);
    if Dataset.FieldbyName('Id_Engine').Value=null then
      Dataset.FieldbyName('Id_Engine').AsInteger := DefaultParams.AutoId_Engine;
  end;{if}
end;{DoAutoAfterInsert}
procedure TfmAutoModels.DoAutoAfterPost(DataSet: TDataSet);
var RecNo: Integer;
begin
  RecNo := Dataset.RecNo;
  TADOQuery(Dataset).Requery;
  Dataset.MoveBy(RecNo-1);
  FormResize(Self);
  pbAutos.Invalidate;
end;{DoAutoAfterPost}
procedure TfmAutoModels.pbFksPaint(Sender: TObject);
var Cvs: TCanvas;
begin
//  Cvs := pbFks.Canvas;
//  esaDrawGridTitle(pbFks,dbgFks,2,FFkColWidths);
//  with dbgFks do
//  begin
//    //остальные ячейки
//    with Columns[0] do
//      esaDrawGridCell(Cvs,FFkColWidths[0]-Width,1,FFkColWidths[0],hCell,['№']);
//    with Columns[1] do
//      esaDrawGridCell(Cvs,FFkColWidths[0]+1,1,FFkColWidths[1],hCell,['Скорость V, км/ч']);
//    with Columns[2] do
//      esaDrawGridCell(Cvs,FFkColWidths[1]+1,1,FFkColWidths[2],hCell,['Сила тяги Fk, кН']);
//    with Columns[3] do
//      esaDrawGridCell(Cvs,FFkColWidths[2]+1,1,FFkColWidths[3],hCell,['Масса, кg']);
//  end;{with}
end;

procedure TfmAutoModels.pmiChartSaveAsClick(Sender: TObject);
var IsExist: Boolean;
begin
  with TSavePictureDialog.Create(Self) do
  try
    InitialDir := ExtractFileDir(Application.ExeName);
    Filter := 'BMP-файлы|*.bmp';
    DefaultExt := '.bmp';
    if Execute then
    begin
      IsExist := FileExists(FileName);
      if (not IsExist)OR
         (IsExist and esaMsgQuestionYN('Файл '''+FileName+''' уже существует. Переписать?'))
      then dbchFks.SaveToBitmapFile(FileName);
    end;{if}
  finally
    Free;
  end;{try}
end;{pmiChartSaveAsClick}

procedure TfmAutoModels.pmiChartPrintClick(Sender: TObject);
begin
  ChartPreview(fmAutoModels, dbchFks);
end;{pmiChartPrintPreviewClick}

procedure TfmAutoModels.PageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := esaCanCloseModifiedQuery(fmDM.quAutos,'Модели автосамосвалов')and
                 esaCanCloseModifiedQuery(fmDM.quAutoFks,'Тяговые характеристики');
end;{PageControlChanging}
procedure TfmAutoModels.PageControlChange(Sender: TObject);
begin
  if fmDM.quAutos.Active then
  if PageControl.ActivePageIndex=2 then
  begin
    if fmDM.quAutos.RecordCount=0
    then dbchFks.Title.Text[0] := 'Тяговые характеристики'
    else dbchFks.Title.Text[0] := Format('Тяговые характеристики %s (%.1fт)',[fmDM.quAutosName.AsString,fmDM.quAutosTonnage.AsFloat]);
    dbchFks.RefreshData;
  end;{if}
end;{PageControlChange}

procedure TfmAutoModels.pmiAutoAddClick(Sender: TObject);
begin
  fmDM.quAutos.Append;
end;{pmiAutoAddClick}
procedure TfmAutoModels.pmiAutoEditClick(Sender: TObject);
begin
  with fmDM do
  begin
    FAutoName := quAutosName.AsString;
    if esaInputName('Изменить','Наименование',FAutoName,quAutosName.Size)then
    begin
      if quAutos.Locate('Name',FAutoName,[])
      then esaMsgError(EesaAutoModelsDuplicateName,[FAutoName])
      else
      begin
        quAutos.Edit;
        quAutosName.AsString := FAutoName;
      end;{else}
    end;{if}
    FAutoName := '';
  end;{with}
end;{pmiAutoEditClick}
procedure TfmAutoModels.pmiAutoDeleteClick(Sender: TObject);
begin
  fmDM.quAutos.Delete;
end;{pmiAutoDeleteClick}
procedure TfmAutoModels.pmiAutoDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(SesaDeleteAllConfirm)then
  with fmDM do
  begin
    quAutos.AfterDelete := nil;
    quAutos.BeforeDelete := nil;
    quAutos.DisableControls;
    quAutos.Requery;
    while not quAutos.Eof do
      quAutos.Delete;
    quAutos.Requery;
    quAutos.EnableControls;
    FormResize(Self);
    pbAutos.Invalidate;
    quAutos.AfterDelete := DoAutoAfterDelete;
    quAutos.BeforeDelete := DoAutoBeforeDelete;
  end;{with}
end;{pmiAutoDeleteAllClick}
procedure TfmAutoModels.pmiAutoUpClick(Sender: TObject);
var Id_Auto: Integer;
begin
  with fmDM do
  if (not(quAutos.State in [dsEdit,dsInsert]))and(quAutos.RecNo>1) then
  begin
    quAutos.DisableControls;
    FAutoSortIndex  := quAutosSortIndex.AsInteger;
    Id_Auto := quAutosId_Auto.AsInteger;
    quAutos.Prior;
    quAutos.Edit;
    quAutosSortIndex.AsInteger := FAutoSortIndex;
    quAutos.Post;
    quAutos.Locate('Id_Auto',Id_Auto,[]);
    quAutos.Edit;
    quAutosSortIndex.AsInteger := FAutoSortIndex-1;
    quAutos.Post;
    quAutos.Requery;
    quAutos.Locate('Id_Auto',Id_Auto,[]);
    quAutos.EnableControls;
  end;{if}
end;{pmiUpClick}
procedure TfmAutoModels.pmiAutoDownClick(Sender: TObject);
var Id_Auto: Integer;
begin
  with fmDM do
  if (not(quAutos.State in [dsEdit,dsInsert]))and(quAutos.RecNo<quAutos.RecordCount) then
  begin
    quAutos.DisableControls;
    FAutoSortIndex  := quAutosSortIndex.AsInteger;
    Id_Auto := quAutosId_Auto.AsInteger;
    quAutos.Next;
    quAutos.Edit;
    quAutosSortIndex.AsInteger := FAutoSortIndex;
    quAutos.Post;
    quAutos.Locate('Id_Auto',Id_Auto,[]);
    quAutos.Edit;
    quAutosSortIndex.AsInteger := FAutoSortIndex+1;
    quAutos.Post;
    quAutos.Requery;
    quAutos.Locate('Id_Auto',Id_Auto,[]);
    quAutos.EnableControls;
  end;{if}
end;{pmiAutoDownClick}
procedure TfmAutoModels.pmiExcelParamsPrintFkTableClick(Sender: TObject);
begin
  pmiExcelParamsPrintFkTable.Checked := not pmiExcelParamsPrintFkTable.Checked;
end;{pmiExcelParamsPrintFkTableClick}
procedure TfmAutoModels.pmiExcelParamsInDollarClick(Sender: TObject);
begin
  pmiExcelParamsInDollar.Checked := not pmiExcelParamsInDollar.Checked;
end;{pmiExcelParamsInDollarClick}
procedure TfmAutoModels.pmiAutoDefaultClick(Sender: TObject);
begin
  if esaMsgQuestionYN(SesaDefaultConfirm)then
  begin
    DefaultParams.AutoBodySpace := fmDM.quAutosBodySpace.AsFloat;
    DefaultParams.AutoTonnage := fmDM.quAutosTonnage.AsFloat;
    DefaultParams.AutoP := fmDM.quAutosP.AsFloat;
    DefaultParams.AutoF := fmDM.quAutosF.AsFloat;
    DefaultParams.AutoTransmissionKindAsByte := fmDM.quAutosTransmissionKind.AsInteger;
    DefaultParams.AutoTransmissionKPD := fmDM.quAutosTransmissionKPD.AsFloat;
    DefaultParams.AutoId_Engine := fmDM.quAutosId_Engine.AsInteger;
    DefaultParams.AutoT_r := fmDM.quAutost_r.AsFloat;
    DefaultParams.AutoRmin := fmDM.quAutosRmin.AsFloat;
    DefaultParams.AutoTyresCount := fmDM.quAutosTyresCount.AsInteger;
    DefaultParams.AutoLength := fmDM.quAutosALength.AsFloat;
    DefaultParams.AutoWidth := fmDM.quAutosAWidth.AsFloat;
    DefaultParams.AutoHeight := fmDM.quAutosAHeight.AsFloat;
  end;{if}
end;{pmiAutoDefaultClick}
procedure TfmAutoModels.pmiAutoDefaultsDlgClick(Sender: TObject);
begin
  esaShowAutoModelDefaultsDlg(HelpKeyword);
end;{pmiAutoDefaultsDlgClick}
procedure TfmAutoModels.PrintAutoModels(XL: TExcelEditor);
var
  ACount,I: Integer;
begin
  //
  XL.SheetName := 'Autos';
  ACount := Max(1,fmDM.quAutos.RecordCount);
  XL.ActiveSheetHeader('&8CEBADAN-AUTO, II','&8'+Caption,'&8&D');
  XL.ActiveSheetFooter('','&8&P из &N','');
  XL.Cells[1,1,19,1].Frame := [feTop];
  //Заголовок
  XL.TitleCell[1,1,19,1] := Caption;
  XL.Cells[1,1,19,1].Font.Style := [xlfsBold];
  //Шапка
  XL.TitleCell[2, 1,1,2] := '№';
  XL.TitleCell[2, 2,1,2] := 'Модель';
  XL.TitleCell[2, 3,1,2] := 'Объем кузова, м3';
  XL.TitleCell[2, 4,1,2] := 'Грузо-подъем-ность, т.';
  XL.TitleCell[2, 5,1,2] := 'Масса, т.';
  XL.TitleCell[2, 6,1,2] := 'Площадь лобового сечения, кв.м.';
  XL.TitleCell[2, 7,1,2] := 'Коэффи-циент обтекае-мости';
  XL.TitleCell[2, 8,1,2] := 'Время разгруз-ки, сек.';
  XL.TitleCell[2, 9,1,2] := 'Миним. радиус поворо-та, м.';
  XL.TitleCell[2,10,1,2] := 'Коли-чество шин';
  XL.TitleCell[2,11,2,1] := 'Двигатель';
  XL.TitleCell[3,11,1,1] := 'Модель';
  XL.TitleCell[3,12,1,1] := 'Макси-мальная мощность, кВт';
  XL.TitleCell[2,13,2,1] := 'Трансмиссия';
  XL.TitleCell[3,13,1,1] := 'Наиме-нова-ние';
  XL.TitleCell[3,14,1,1] := 'КПД';
  XL.TitleCell[2,15,3,1] := 'Габариты, м';
  XL.TitleCell[3,15,1,1] := 'Длина';
  XL.TitleCell[3,16,1,1] := 'Шири-на';
  XL.TitleCell[3,17,1,1] := 'Высо-та';
  XL.TitleCell[2,18,1,2] := 'Тяго-вые характе-ристики';
  if not pmiExcelParamsInDollar.Checked then
  XL.TitleCell[2,19,1,2] := 'Балансовая стоимость, тыс.тг'
  else
 // XL.TitleCell[2,19,1,2] := 'Балансовая стоимость, тыс.$';
  XL.TitleCell[2,20,1,2] := 'Примечание';
  for I := 1 to 20 do
    XL.TitleCell[4,I,1,1] := IntToStr(I);
  //Ширина столбцов
  XL.ColumnWidths[ 1,1] :=  3.0;
  XL.ColumnWidths[ 2,1] := 17.0;
  XL.ColumnWidths[ 3,3] :=  6.0;
  XL.ColumnWidths[ 6,2] :=  7.0;
  XL.ColumnWidths[ 8,3] :=  6.0;
  XL.ColumnWidths[11,1] := 10.0;
  XL.ColumnWidths[12,1] :=  8.0;
  XL.ColumnWidths[13,1] :=  5.0;
  XL.ColumnWidths[14,4] :=  5.0;
  XL.ColumnWidths[18,1] :=  6.0;
  XL.ColumnWidths[19,1] :=  9.0;
  XL.ColumnWidths[20,1] := 40.0;
  //рамка
  XL.Cells[2,1,20,ACount+3].Frame := [feTotal];
  //Шаблоны для численных столбцов
  XL.Cells[5,3,17,ACount+3].NumberFormat := nfFloat00;
  XL.Cells[5,10,1,ACount+3].NumberFormat := nfInt0;
  XL.Cells[5,19,1,ACount+3].NumberFormat := nfFloat000;
  //Данные
  with fmDM do
  begin
    quAutos.First;
    while not quAutos.Eof do
    begin
      XL.IntegerCells[quAutos.RecNo+4, 1] := quAutosSortIndex.AsInteger;
      XL.StringCells [quAutos.RecNo+4, 2] := quAutosName.AsString;
      XL.FloatCells  [quAutos.RecNo+4, 3] := quAutosBodySpace.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4, 4] := quAutosTonnage.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4, 5] := quAutosP.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4, 6] := quAutosF.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4, 7] := quAutosRo.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4, 8] := quAutost_r.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4, 9] := quAutosRmin.AsFloat;
      XL.IntegerCells[quAutos.RecNo+4,10] := quAutosTyresCount.AsInteger;
      XL.StringCells [quAutos.RecNo+4,11] := quAutosEngineName.AsString;
      XL.FloatCells  [quAutos.RecNo+4,12] := quAutosEngineNmax.AsFloat;
      if not quAutosTransmissionKind.IsNull then
      if quAutosTransmissionKind.AsInteger=0
      then XL.StringCells[quAutos.RecNo+4,13] := 'ГМ'
      else
      if quAutosTransmissionKind.AsInteger=1
      then XL.StringCells[quAutos.RecNo+4,13] := 'ЭМ';
      XL.FloatCells  [quAutos.RecNo+4,14] := quAutosTransmissionKPD.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4,15] := quAutosALength.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4,16] := quAutosAWidth.AsFloat;
      XL.FloatCells  [quAutos.RecNo+4,17] := quAutosAHeight.AsFloat;
      XL.StringCells [quAutos.RecNo+4,18] := Format('ТХ-%.3d',[quAutos.RecNo]);
      if not pmiExcelParamsInDollar.Checked then
       // XL.FloatCells  [quAutos.RecNo+4,19]  := fmDM.quAutosBalanceC1000tg.AsFloat
      else
        if fmDM.quOpenpitsTotalKurs.AsFloat>0.0 then
        //  XL.FloatCells  [quAutos.RecNo+4,19]:= fmDM.quAutosBalanceC1000tg.AsFloat/fmDM.quOpenpitsTotalKurs.AsFloat
        else
          XL.FloatCells  [quAutos.RecNo+4,19]:= 0.0;
      XL.StringCells  [quAutos.RecNo+4,20]  := fmDM.quAutosNote.AsVariant;
      quAutoFks.Refresh;
      if quAutoFks.RecordCount=0 then
      begin
        XL.Cells[quAutos.RecNo+4,18,1,1].Font.StrikeThrough := True;
        XL.Cells[quAutos.RecNo+4,18,1,1].Font.Style := [xlfsBold];
      end;{if}
      quAutos.Next;
    end;{while}
    quAutos.First;
  end;{with}
  XL.ActiveSheetPageSetup(10,10,10,10,5,5,poLandscape);
end;{PrintAutoModels}
//
procedure TfmAutoModels.PrintAutoFks(XL: TExcelEditor);
var
  ATop,I: Integer;
  AFileName: String;
begin
  if fmDM.quAutos.RecordCount>0 then
  begin
    AFileName := ChangeFileExt(Application.ExeName,'.bmp');
    XL.ActiveSheetIndex := 0;
    fmDM.quAutos.First;
    while not fmDM.quAutos.EOF do
    begin
      //Страница
      XL.ActiveSheetIndex                         := XL.ActiveSheetIndex+1;
      XL.SheetName                                := Format('ТХ-%.3d',[XL.ActiveSheetIndex]);
      XL.Cells[1,1,10,1].Frame                    := [feTop];
      XL.ActiveSheetHeader('&8CEBADAN-AUTO, II',Format('&8Характеристики карьерного автосамосвала %s',[fmDM.quAutosName.AsString]),'&8&D');
      XL.ActiveSheetFooter('','&8&P из &N','');
      //Технические характеристики ----------------------------------------------------------------------
      //Заголовок технических характеристик
      XL.TitleCell[1,1,6,1]                       := 'Технические характеристики карьерного автосамосвала';
      XL.TitleCell[2,1,6,1]                       := Format('%s (%.1fт)',[fmDM.quAutosName.AsString,fmDM.quAutosTonnage.AsFloat]);
      XL.Cells[1,1,6,2].Font.Style                := [xlfsBold];
      XL.ColumnWidths[1,18]                       := 8.0;
      //Шапка технических характеристик
      ATop := 3;
      XL.TitleCell[ATop+ 0,1,4,1]                 := 'Характеристика';
      XL.TitleCell[ATop+ 0,5,2,1]                 := 'Значение';
      XL.TitleCell[ATop+ 1,1,4,1]                 := 'Модель';
      XL.TitleCell[ATop+ 2,1,4,1]                 := 'Объем кузова, м3';
      XL.TitleCell[ATop+ 3,1,4,1]                 := 'Грузоподъемность, т.';
      XL.TitleCell[ATop+ 4,1,4,1]                 := 'Масса порожнего автосамосвала, т.';
      XL.TitleCell[ATop+ 5,1,4,1]                 := 'Время разгрузки, сек.';
      XL.TitleCell[ATop+ 6,1,4,1]                 := 'Минимальный радиус поворота, м.';
      XL.TitleCell[ATop+ 7,1,4,1]                 := 'Количество шин';
      XL.TitleCell[ATop+ 8,1,4,1]                 := 'Двигатель';
      XL.TitleCell[ATop+ 9,1,4,1]                 := 'Максимальная мощность двигателя, кВт';
      XL.TitleCell[ATop+10,1,4,1]                 := 'Трансмиссия';
      XL.TitleCell[ATop+11,1,4,1]                 := 'КПД трансмиссии';
      XL.TitleCell[ATop+12,1,4,1]                 := 'Длина, м';
      XL.TitleCell[ATop+13,1,4,1]                 := 'Ширина, м';
      XL.TitleCell[ATop+14,1,4,1]                 := 'Высота, м';
      if pmiExcelParamsInDollar.Checked then
        XL.TitleCell[ATop+15,1,4,1]               := 'Балансовая стоимость, тыс.$'
      else 
        XL.TitleCell[ATop+15,1,4,1]               := 'Балансовая стоимость, тыс.тг';
      XL.Cells[ATop+1,1,4,15].HorizontalAlignment := haLeft;
      //Значения технических характеристик
      for I := ATop+1 to ATop+15 do
      begin
        XL.Cells[I,1,4,1].HorizontalAlignment     := haLeft;
        XL.Cells[I,5,2,1].MergeCells              := True;
      end;{for}
      XL.Cells[ATop+ 1,5,2,15].NumberFormat       := nfFloat00;
      XL.Cells[ATop+15,5,2, 1].NumberFormat       := nfFloat000;
      XL.Cells[ATop+ 1,5,2, 1].NumberFormat       := nfInt0;
      XL.Cells[ATop+ 7,5,2, 1].NumberFormat       := nfInt0;
      XL.StringCells [ATop+ 1,5]                  := fmDM.quAutosName.AsString;
      XL.FloatCells  [ATop+ 2,5]                  := fmDM.quAutosBodySpace.AsFloat;
      XL.FloatCells  [ATop+ 3,5]                  := fmDM.quAutosTonnage.AsFloat;
      XL.FloatCells  [ATop+ 4,5]                  := fmDM.quAutosP.AsFloat;
      XL.FloatCells  [ATop+ 5,5]                  := fmDM.quAutost_r.AsFloat;
      XL.FloatCells  [ATop+ 6,5]                  := fmDM.quAutosRmin.AsFloat;
      XL.IntegerCells[ATop+ 7,5]                  := fmDM.quAutosTyresCount.AsInteger;
      XL.StringCells [ATop+ 8,5]                  := fmDM.quAutosEngineName.AsString;
      XL.FloatCells  [ATop+ 9,5]                  := fmDM.quAutosEngineNmax.AsFloat;
      if not fmDM.quAutosTransmissionKind.IsNull then
      if fmDM.quAutosTransmissionKind.AsInteger=1
      then XL.StringCells[ATop+10,5]              := 'ЭМ'
      else 
      if fmDM.quAutosTransmissionKind.AsInteger=0
      then XL.StringCells[ATop+10,5]              := 'ГМ';
      XL.FloatCells[ATop+11,5]                    := fmDM.quAutosTransmissionKPD.AsFloat;
      XL.FloatCells[ATop+12,5]                    := fmDM.quAutosALength.AsFloat;
      XL.FloatCells[ATop+13,5]                    := fmDM.quAutosAWidth.AsFloat;
      XL.FloatCells[ATop+14,5]                    := fmDM.quAutosAHeight.AsFloat;
      if not pmiExcelParamsInDollar.Checked then
     //   XL.FloatCells[ATop+15,5]                  := fmDM.quAutosBalanceC1000tg.AsFloat
      else
        if fmDM.quOpenpitsTotalKurs.AsFloat>0.0 then
        //  XL.FloatCells[ATop+15,5]                := fmDM.quAutosBalanceC1000tg.AsFloat/fmDM.quOpenpitsTotalKurs.AsFloat
        else
          XL.FloatCells[ATop+15,5]                := 0.0;
      XL.Cells[ATop+ 1,1,4,15].Frame              := [feRight];
      XL.Cells[ATop+15,1,4, 1].Frame              := [feRight,feBottom];
      XL.Cells[ATop+15,5,2, 1].Frame              := [feLeft,feBottom];
      XL.Cells[ATop+ 0,1,4, 1].Frame              := [feRight,feTop,feBottom];
      XL.Cells[ATop+ 0,5,2, 1].Frame              := [feLeft,feTop,feBottom];
      //Тяговые характеристики --------------------------------------------------------------------------
      fmDM.quAutoFks.Refresh;
      if pmiExcelParamsPrintFkTable.Checked then
      begin
        //Заголовок тяговых характеристик
        XL.TitleCell[1,8,3,1]                       := 'Тяговые характеристики';
        XL.TitleCell[2,8,3,1]                       := Format('%s (%.1fт)',[fmDM.quAutosName.AsString,fmDM.quAutosTonnage.AsFloat]);
        XL.Cells[1,8,3,2].Font.Style                := [xlfsBold];
        //Шапка тяговых характеристик
        ATop := 3;
        XL.TitleCell[ATop+ 0, 8,1,1]                := '№';
        XL.TitleCell[ATop+ 0, 9,1,1]                := 'V, км/ч';
        XL.TitleCell[ATop+ 0,10,1,1]                := 'Fk, kH';
        XL.Cells[ATop+ 1,8,1,Max(1,fmDM.quAutoFks.RecordCount)].NumberFormat := nfInt0;
        XL.Cells[ATop+ 1,9,2,Max(1,fmDM.quAutoFks.RecordCount)].NumberFormat := nfFloat00;
        XL.Cells[ATop+ 1,9,1,Max(1,fmDM.quAutoFks.RecordCount)].Frame        := [feLeft,feRight];
        XL.Cells[ATop+ Max(1,fmDM.quAutoFks.RecordCount),8,1,1].Frame        := [feRight,feBottom];
        XL.Cells[ATop+ Max(1,fmDM.quAutoFks.RecordCount),9,1,1].Frame        := [feRight,feLeft,feBottom];
        XL.Cells[ATop+ Max(1,fmDM.quAutoFks.RecordCount),10,1,1].Frame       := [feLeft,feBottom];
        XL.Cells[ATop+ 0,8,1,1].Frame                                        := [feRight,feTop,feBottom];
        XL.Cells[ATop+ 0,9,1,1].Frame                                        := [feRight,feLeft,feTop,feBottom];
        XL.Cells[ATop+ 0,10,1,1].Frame                                       := [feLeft,feTop,feBottom];
        //Значения тяговых характеристик
        while not fmDM.quAutoFks.Eof do
        begin
          Inc(ATop);
          XL.IntegerCells[ATop, 8]                  := fmDM.quAutoFks.RecNo;
          XL.FloatCells  [ATop, 9]                  := fmDM.quAutoFksV.AsFloat;
          XL.FloatCells  [ATop,10]                  := fmDM.quAutoFksFk.AsFloat;
          fmDM.quAutoFks.Next;
        end;{while}
      end;{if}
      //Параметры страницы ------------------------------------------------------------------------------
      XL.ActiveSheetPageSetup(10,10,10,10,5,5);
      //Картинка
      dbchFks.Title.Text[0] := Format('Тяговые характеристики %s (%.1fт)',[fmDM.quAutosName.AsString,fmDM.quAutosTonnage.AsFloat]);
      dbchFks.RefreshData;
      dbchFks.SaveToBitmapFile(AFileName);
      XL.LoadPictureFromFile(AFileName,0.0,280.0);
      DeleteFile(AFileName);
      fmDM.quAutos.Next;
    end;{while}
  end;{if}
end;{PrintAutoFks}
procedure TfmAutoModels.pmiAutoExcelClick(Sender: TObject);
var XL: TExcelEditor;
begin
  XL := TExcelEditor.Create;
  try
    XL.SheetCount := 1+fmDM.quAutos.RecordCount;
    PrintAutoModels(XL);
    PrintAutoFks(XL);
    XL.ActiveSheetIndex := 0;
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
end;{pmiAutoExcelClick}
procedure TfmAutoModels.pmAutosPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiAutoAdd.Enabled := (PageControl.ActivePageIndex=0)and(quAutos.Active);
    pmiAutoEdit.Enabled := pmiAutoAdd.Enabled and(quAutos.RecordCount>0)and
                          (not (quAutos.State in [dsEdit,dsInsert]));
    pmiAutoUp.Enabled := pmiAutoEdit.Enabled and(quAutos.RecNo>1);
    pmiAutoDown.Enabled := pmiAutoEdit.Enabled and(quAutos.RecNo<quAutos.RecordCount);
    pmiAutoDelete.Enabled := pmiAutoEdit.Enabled;
    pmiAutoDeleteAll.Enabled := pmiAutoEdit.Enabled;
    pmiAutoDefault.Enabled := pmiAutoEdit.Enabled;
    pmiAutoExcel.Enabled := pmiAutoEdit.Enabled;
  end;{with}
end;{pmAutosPopup}

procedure TfmAutoModels.DoFkBeforeDelete(DataSet: TDataSet);
begin
  if not esaMsgQuestionYN('Удалить запись №'+IntToStr(Dataset.RecNo)+'?')
  then Abort
  else Dataset.Tag := Dataset.RecNo;
end;{DoFkBeforeDelete}
procedure TfmAutoModels.DoFkAfterDelete(DataSet: TDataSet);
var No: Integer;
begin
  Dataset.DisableControls;
  TADOQuery(Dataset).Requery;
  No := DataSet.Tag;
  if No>Dataset.RecordCount then No := Dataset.RecordCount;
  Dataset.MoveBy(No-1);
  DataSet.Tag := 0;
  Dataset.EnableControls;
  FormResize(Self);
//  pbFks.Invalidate;
end;{DoFkAfterDelete}
procedure TfmAutoModels.DoFkAfterPost(DataSet: TDataSet);
var Id_Fk: Integer;
begin
  if Dataset.Tag>0 then Exit;
  Id_Fk := DataSet.FieldByName('Id_Fk').AsInteger;
  Dataset.DisableControls;
  TADOQuery(Dataset).Requery;
  Dataset.Locate('Id_Fk',Id_Fk,[]);
  Dataset.EnableControls;
  FormResize(Self);
//  pbFks.Invalidate;
end;{DoFkAfterPost}
procedure TfmAutoModels.DoFkBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsInsert,dsEdit]then
  begin
    if not IsFloatFieldMoreEqualMin(DataSet.FieldByName('V'),0.0) then Abort
    else
    if not IsFloatFieldMoreMin(DataSet.FieldByName('Fk'),0.0) then Abort
  end;{if}
end;{DoFkBeforePost}


procedure TfmAutoModels.pmFksPopup(Sender: TObject);
begin
  with fmDM do
  begin
    pmiFksAdd.Enabled       := quAutos.Active and quAutoFks.Active;
    pmiFksEdit.Enabled      := pmiFksAdd.Enabled and(quAutoFks.RecordCount>0)and
                               (not (quAutoFks.State in [dsEdit,dsInsert]));
    pmiFksDelete.Enabled    := pmiFksEdit.Enabled;
    pmiFksDeleteAll.Enabled := pmiFksEdit.Enabled;
    pmiFksImportFrom.Enabled:= pmiFksAdd.Enabled and(quAutos.RecordCount>0)and
                               (not (quAutoFks.State in [dsEdit,dsInsert]));
  end;{with}
end;{pmFksPopup}
procedure TfmAutoModels.pmiFksAddClick(Sender: TObject);
begin
  fmDM.quAutoFks.Append;
end;{pmiFksAddClick}
procedure TfmAutoModels.pmiFksEditClick(Sender: TObject);
begin
  fmDM.quAutoFks.Edit;
end;{pmiFksEditClick}
procedure TfmAutoModels.pmiFksDeleteClick(Sender: TObject);
begin
  fmDM.quAutoFks.Delete;
end;{pmiFksDeleteClick}
procedure TfmAutoModels.pmiFksDeleteAllClick(Sender: TObject);
begin
  if esaMsgQuestionYN(SesaDeleteAllConfirm)then
  with fmDM do
  begin
    quAutoFks.AfterDelete := nil;
    quAutoFks.BeforeDelete := nil;
    quAutoFks.DisableControls;
    quAutoFks.Requery;
    while not quAutoFks.Eof do
      quAutoFks.Delete;
    quAutoFks.Requery;
    quAutoFks.EnableControls;
    quAutoFks.AfterDelete := DoAutoAfterDelete;
    quAutoFks.BeforeDelete := DoAutoBeforeDelete;
    FormResize(Self);
//    pbFks.Invalidate;
  end;{with}
end;{pmiFksDeleteAllClick}
procedure TfmAutoModels.pmiFksImportFromClick(Sender: TObject);
var
  ARimpull: ResaRimpull;
  I       : Integer;
  AError  : String;
begin
  with TOpenDialog.Create(nil) do
  try
    InitialDir := ExtractFileDir(Application.ExeName);
    DefaultExt := '.rpf';
    Filter     := 'Файлы тяговых характеристик Rimpull Format (*.rpf)|*.rpf';
    if Execute then
    if not esaImportRimpullFrom(FileName,ARimpull,AError)
    then esaMsgError(AError) else
    try
      for I := 0 to ARimpull.Count-1 do
      begin
        fmDM.quAutoFks.Append;
        fmDM.quAutoFksId_Auto.AsInteger := fmDM.quAutosId_Auto.AsInteger;
        fmDM.quAutoFksV.AsFloat         := ARimpull.Items[I].V100kmh*0.01;
        fmDM.quAutoFksFk.AsFloat        := ARimpull.Items[I].Fk100kH*0.01;
        fmDM.quAutoFks.Post;
      end;{for}
    finally
      ARimpull.Items := nil;
    end;{try}
  finally
    Free;
  end;{try}
end;{pmiFksImportFromClick}

procedure TfmAutoModels.dbeBodySpaceKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['.',','] then Key := DecimalSeparator;
end;{dbeBodySpaceKeyPress}
procedure TfmAutoModels.dbgFksDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
//  esaDrawDBGridColumnCell(dbgFks,Rect,DataCol,Column,State);
end;

procedure TfmAutoModels.string_grid_view;
var
  form_width: integer;
  number_col, data_cols, value_col: integer;
begin
  form_width:= tsFk.Width;
  number_col:= 25;
  data_cols:= form_width - 30;
  value_col:= ROUND((data_cols - 20) / 3);

  sgFk.ColWidths[0]:= number_col;
  sgFk.ColWidths[1]:= value_col;
  sgFk.ColWidths[2]:= value_col;
  sgFk.ColWidths[3]:= value_col;

  sgFk.Cells[0,0]:= TITLE_NO;
  sgFk.Cells[1,0]:= TITLE_V;
  sgFk.Cells[2,0]:= TITLE_F;
  sgFk.Cells[3,0]:= TITLE_M;

  sgFk.ColCount:= 4;
end;

procedure TfmAutoModels.fetch_data_to_string_grid(id_auto: integer);
var
  row, col: integer;
begin
  row:= 0;
  col:= 1;
  with fmDM.quAutoFks do
    try
      Close;
      Parameters.ParamByName('Id_Auto').Value:= id_auto;
      Open;
      sgFk.RowCount:= RecordCount + 1;
      while not Eof do
      begin
        sgFk.Cells[row, col]:= FieldByName('No').AsString;
        sgFk.Cells[row+1, col]:= FormatFloat(',0.00', FieldByName('V').AsFloat);
        sgFk.Cells[row+2, col]:= FormatFloat(',0.00', FieldByName('Fk').AsFloat);
        sgFk.Cells[row+3, col]:= FormatFloat(',0.00', FieldByName('kg').AsFloat);
        col:= col+1;
        Next();
      end;
    finally
      //Close();
    end;
end;

procedure TfmAutoModels.sgFkDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  s: string;
  savedAlign: word;
begin
  s:= sgFk.Cells[ACol, ARow];
  savedAlign:= SetTextAlign(sgFk.Canvas.Handle, TA_CENTER);
  if (ACol = 0) or (ARow = 0)then
    sgFk.Canvas.Font.Style:= [fsBold];
  sgFk.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top + 2, s);

  SetTextAlign(sgFk.Canvas.Handle, savedAlign);
  if (ACol <> 0) then
    sgFk.RowHeights[ARow]:= 15;
end;

procedure TfmAutoModels.Button1Click(Sender: TObject);
var
  col, row: integer;
begin
  TButton(Sender).Enabled:= False;
  row:= 0;
  col:= 0;
  with fmDM.quAutoFks do
    try
      if not Active then
        Open;
      First;

      while not Eof do
      begin
        row:= row+1;

        Edit;
        FieldByName('Fk').AsFloat:= strtofloat(sgFk.Cells[col+2, row]);
        Post;
        Next;
      end;
    finally
//      Close();
    end;
end;

procedure TfmAutoModels.sgFkKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', DecimalSeparator]) then begin
    Key := #0;
  end;
end;

procedure TfmAutoModels.string_grid_recalc(col, row: integer);
var
  mc2, kg, Hk: double;
begin
  mc2:= 9.80665;
  if col = 2 then //Hk
  begin
    Hk:= strtofloat(sgFk.Cells[col, row]);
    kg:= Hk / mc2;
    sgFk.Cells[col+1, row]:= FormatFloat(',0.00', kg);
  end
  else
    if col = 3 then //kg
    begin
      kg:= strtofloat(sgFk.Cells[col, row]);
      Hk:= kg * mc2;
      sgFk.Cells[col-1, row]:= FormatFloat(',0.00', Hk);
    end;
end;

procedure TfmAutoModels.sgFkKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if Key = VK_RETURN then
  if (ord(Key) in [VK_RETURN, VK_UP, VK_DOWN, VK_RIGHT, VK_LEFT]) then
  begin
    string_grid_recalc(FCol, FRow);

    Button1.Enabled:= True;
    Button1.SetFocus;
  end;
end;

procedure TfmAutoModels.sgFkSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin;
  FCol:= ACol;
  FRow:= ARow;
end;
procedure TfmAutoModels.dbgAutosCellClick(Column: TColumn);
begin
  fetch_data_to_string_grid(dbgAutos.SelectedField.AsInteger);
end;

procedure TfmAutoModels.dbgAutosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key) in [VK_UP, VK_DOWN, VK_RIGHT, VK_LEFT]) then
    fetch_data_to_string_grid(dbgAutos.SelectedField.AsInteger);
end;

end.
