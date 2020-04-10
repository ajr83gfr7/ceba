unit unMain;
interface
uses Classes, ActnList, StdCtrls, Controls, ComCtrls, Forms, Menus,
  ExtCtrls,Windows, Grids, ValEdit, TeEngine, Series, TeeProcs, Chart,startFromAdis,
  jpeg;
type        //test
  TfmMain = class(TForm)
    StatusBar: TStatusBar;

    ActionList: TActionList;
    actFile: TAction;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileSaveAs: TAction;
    actFileDelete: TAction;
    actFileExit: TAction;
    actNSI: TAction;
    actNSIAutoModelEngines: TAction;
    actNSIAutoModels: TAction;
    actNSIExcavatorModelEngines: TAction;
    actNSIExcavatorModels: TAction;
    actNSIRoadCoats: TAction;
    actTools: TAction;
    actToolsAutos: TAction;
    actToolsExcavators: TAction;
    actToolsRocks: TAction;
    actToolsEditor: TAction;
    actToolsProductivity: TAction;
    actToolsUnLoadingPunkts: TAction;
    actToolsAutosPlacing: TAction;
    actToolsAdditionalWorkRegime: TAction;
    actRun: TAction;
    actRunStart: TAction;
    actResultGraph: TAction;
    actHelp: TAction;
    actHelpContent: TAction;
    actHelpAbout: TAction;

    MainMenu: TMainMenu;
    mmiFile: TMenuItem;
    mmiFileNew: TMenuItem;
    mmiFileOpen: TMenuItem;
    mmiFileSep1: TMenuItem;
    mmiFileSaveAs: TMenuItem;
    mmiFileDelete: TMenuItem;
    mmiFileSep2: TMenuItem;
    mmiFileExit: TMenuItem;

    mmiNSI: TMenuItem;
    mmiNSIAutoModelEngines: TMenuItem;
    mmiNSIAutoModels: TMenuItem;
    mmiNSISep1: TMenuItem;
    mmiNSIExcavatorModelEngines: TMenuItem;
    mmiNSIExcavatorModels: TMenuItem;
    mmiNSISep2: TMenuItem;
    mmiNSIRoadCoats: TMenuItem;
    mmiTools: TMenuItem;
    mmiToolsAutos: TMenuItem;
    mmiToolsExcavators: TMenuItem;
    mmiToolsSep1: TMenuItem;
    mmiToolsRocks: TMenuItem;
    mmiToolsSep2: TMenuItem;
    mmiToolsEditor: TMenuItem;
    mmiToolsSep3: TMenuItem;
    mmiToolsProductivity: TMenuItem;
    mmiToolsUnLoadingPunkts: TMenuItem;
    mmiToolsAutosPlacing: TMenuItem;
    mmiToolsSep4: TMenuItem;

    mmiRun: TMenuItem;
    mmiRunStart: TMenuItem;
    mmiRunSep1: TMenuItem;
    mmiResultGraph: TMenuItem;

    mmiHelp: TMenuItem;
    mmiHelpContent: TMenuItem;
    mmiHelpSep1: TMenuItem;
    mmiHelpAbout: TMenuItem;
    actToolsAdditionalParamsTotal: TAction;
    mmiToolsAdditionalParamsTotal: TMenuItem;
    actToolsAdditionalParamsExcavs: TAction;
    actToolsAdditionalParamsAutos: TAction;
    actToolsAdditionalParamsRoads: TAction;
    mmiToolsAdditionalParamsExcavs: TMenuItem;
    mmiToolsAdditionalParamsAutos: TMenuItem;
    mmiToolsAdditionalParamsRoads: TMenuItem;
    mmiToolsSep5: TMenuItem;
    mmiToolsAdditionalWorkRegime: TMenuItem;
    mmiRunSep4: TMenuItem;
    mmiResultShiftAutos: TMenuItem;
    mmiResultShiftExcavators: TMenuItem;
    mmiResultShiftBlocks: TMenuItem;
    mmiResultShiftUnLoadingPunkts: TMenuItem;
    mmiResultShiftProportionality: TMenuItem;
    mmiResultShiftProductionCapacities: TMenuItem;
    mmiRunSep3: TMenuItem;
    actResultShiftAutos: TAction;
    actResultShiftExcavators: TAction;
    actResultShiftBlocks: TAction;
    actResultShiftUnLoadingPunkts: TAction;
    actResultShiftProportionality: TAction;
    actResultShiftProductionCapacities: TAction;
    actResultEconomParams: TAction;
    actResultPeriodParams: TAction;
    mmiResultEconomParams: TMenuItem;
    mmiResultPeriodParams: TMenuItem;
    actResultVariants: TAction;
    mmiRunSep5: TMenuItem;
    mmiResultVariants: TMenuItem;
    mmiRunSep2: TMenuItem;
    mmiRunSep6: TMenuItem;
    imgEmblem: TImage;
    mmiResultEconomEffect: TMenuItem;
    actResultEconomEffect: TAction;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actFileExecute(Sender: TObject);
    procedure actNSIExecute(Sender: TObject);
    procedure actToolsExecute(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    //Is openpit active?
    function IsActive(const ACheckRecordCount: Boolean = False): Boolean;
    //Delete openpit
    function Delete(): Boolean;
    //add new panel
    procedure AddPanels();
  public
  end;{TfmMain}

var
  fmMain: TfmMain;

implementation

uses Graphics, SysUtils, unDM, unAutoModelEngines, Globals, unAutoModels, unExcavatorModelEngines,
  unExcavatorModels, unRoadCoats, unOpenpitEditor, unRocks, unExcavators,
  unAutos, unOpenpitCreate, DB, DBGrids, unRun, esaDBDefaultParams,
  unProductivity, unUnLoadingPunkts, unAutoPlacing,
  unAdditionalParams, esaRunObjects, unResultGraphView,
  unAbout, unResultEconomParams,
  unResultShiftAutos, ADODb,
  unResultShiftExcavators, unResultShiftBlocks,
  unResultShiftProportionality, unResultShiftProductionCapacities,
  unResultShiftUnLoadingPunkts,
  unResultTechnologicParams, unVariants,
  unResultEconomEffect,
  TXTWriter, unDialogAddEconomParams;

{$R *.dfm}

//Is openpit active?
function TfmMain.IsActive(const ACheckRecordCount: Boolean = False): Boolean;
begin
  Result := Assigned(fmDM) and (fmDM.quOpenpits.Active);
  if ACheckRecordCount then Result := Result and (fmDM.quOpenpits.RecordCount>0);
end;{IsActive}

//Delete openpit
function TfmMain.Delete(): Boolean;
var AName: String;
begin
  Result := False;
  AName := fmDM.quOpenpitsName.AsString;
  if IsActive(True) then
  if esaMsgQuestionYN('Удалить все данные по проекту "'+AName+'"?')then
  if esaMsgQuestionYN('Вы уверены ???')then
  begin
    fmDM.quOpenpits.Delete;
    fmDM.quOpenpits.Requery;
    fmDM.quOpenpits.First;
    DefaultParams.OpenpitId_Openpit := fmDM.quOpenpitsId_Openpit.AsInteger;
    Caption := Format('%s [%s]',[Application.Title,AName]);
    esaMsgInformatin(Format('Проект "%s" удален.',[AName]));
    Result := True;
  end;{if}
end;{Delete}

procedure PrintEmblem(img: TImage);
var
  _currentDir: string;
  _fileName: string;
begin
  if(DirectoryExists('Images'))then
  begin
    _currentDir:= GetCurrentDir + '\Images\';
    _fileName:= _currentDir + 'emb02.jpg';
    if(FileExists(_fileName))then
    begin
      img.Align:= alClient;
      img.Picture.LoadFromFile(_fileName);
    end;
  end;
end;
procedure TfmMain.AddPanels();
const
  PANELHEIGHT: integer = 89;
  PANELWIDTH: integer = 89;
  PANELBORDER: integer = 10;
var
  _height: integer;
  _width: integer;

  _left: integer;
  _top: integer;

  _button: TButton;
begin
  _height:= fmMain.Height;
  _width:= fmMain.Width;

  _left:= 0;
  _top:= 0;

  //add Modeling -> Start
  _button:= TButton.Create(fmMain);
  _button.Parent:= fmMain;

  _button.Left:= _left + PANELBORDER;
  _button.Top:= _top + PANELBORDER;
  _button.Width:= PANELWIDTH;
  _button.Height:= PANELHEIGHT;
  _left:= _left + PANELBORDER + PANELWIDTH;

  _button.Action:= fmMain.actRunStart;
  _button.Tag:= 410;

  //add Modeling -> Graphic View
  _button:= TButton.Create(fmMain);
  _button.Parent:= fmMain;

  _button.Left:= _left + PANELBORDER;
  _button.Top:= _top + PANELBORDER;
  _button.Width:= PANELWIDTH;
  _button.Height:= PANELHEIGHT;
  _left:= _left + PANELBORDER + PANELWIDTH;

  _button.Action:= fmMain.actResultGraph;
  _button.Tag:= 420;
  _button.Caption:= fmMain.actResultGraph.Caption;
  SetWindowLong(_button.Handle,
                GWL_STYLE,
                GetWindowLong(_button.Handle, GWL_STYLE) or BS_MULTILINE);
  StringReplace(_button.Caption, ' ', #13#10, [rfReplaceAll]);

end;

procedure PrintToFile(input: string);
begin
  TWriter.WriteToTXT(input);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Caption               := Application.Title;
  Application.HintColor := clYellow;
  Application.HelpFile  := ChangeFileExt(Application.ExeName,'.HLP');

  PrintEmblem(imgEmblem);
  AddPanels();

  DefaultParams := TDBDefaultParams.Create;
  //PrintToFile(FloatToStr(DefaultParams.AutoBodySpace));

  with fmDM do
  begin
    if ADOConnection.Connected then
    begin
      ADOConnection.Close;
      esaMsgError('ADOConnection открыт.');
    end;
    ADOConnection.ConnectionString := Format(EDBParams,[ChangeFileExt(Application.ExeName,'.mdb')]);
    try
      ADOConnection.Open;
      //Очищаю выходные данные -------------------------------------------------
      with TADOQuery.Create(nil) do
      try
        Connection := ADOConnection;
        SQL.Text := 'DELETE FROM _ResultShifts';
        ExecSQL;
      finally
        Free;
      end;
      //Паковка БД -------------------------------------------------------------
      ADOConnection.Close;
      esaPackMicrosoftAccess1997_2000Database(ChangeFileExt(Application.ExeName,'.mdb'),'','');
      ADOConnection.Open;
    except
      raise Exception.Create(Format(EDBNotFound,[ChangeFileExt(Application.ExeName,'.mdb')]));
    end;
    quOpenpits.Open;
    if not quOpenpits.Locate('Id_Openpit',DefaultParams.OpenpitId_Openpit,[]) then
      DefaultParams.OpenpitId_Openpit := quOpenpitsId_Openpit.AsInteger;
    Self.Caption := Format('%s [%s]',[Application.Title,quOpenpitsName.AsString]);
  end;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
end;{FormCloseQuery}
procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DefaultParams.Free;
  DefaultParams := nil;
  fmDM.quOpenpits.Close;
  fmDM.ADOConnection.Close;
  //Удаляю по завершении программы все временные расчетные файлы (Result*.ESA)
  DeleteResultFiles;
end;{FormClose}

procedure TfmMain.actFileExecute(Sender: TObject);
begin
  if Sender Is TAction then
  case (Sender As TAction).Tag of
    100: begin
      actFileNew.Enabled    := IsActive;
      actFileOpen.Enabled   := IsActive(True);
      actFileSaveAs.Visible := False;
      actFileDelete.Enabled := IsActive(True);
      actFileExit.Enabled   := True;
    end;{OnPopup}
    110: if esaShowNewOpenpitDlg()
    then Caption := Format('%s [%s]',[Application.Title,fmDM.quOpenpitsName.AsString]);
    111: if esaShowOpenOpenpitDlg()
    then Caption := Format('%s [%s]',[Application.Title,fmDM.quOpenpitsName.AsString]);
    120: ;//SaveAs
    121: Delete();
    130: Close;
  end;{case}
end;{actFileExecute}
procedure TfmMain.actNSIExecute(Sender: TObject);
begin
  if Sender Is TAction then
  case (Sender As TAction).Tag of
    200: begin
      actNSIAutoModelEngines.Enabled      := IsActive;
      actNSIAutoModels.Enabled            := IsActive;
      actNSIExcavatorModelEngines.Enabled := IsActive;
      actNSIExcavatorModels.Enabled       := IsActive;
      actNSIRoadCoats.Enabled             := IsActive;
    end;{OnPopup}
    210: esaShowAutoModelEnginesDlg();
    211: esaShowAutoModelsDlg();
    220: esaShowExcavatorModelEnginesDlg();
    221: esaShowExcavatorModelsDlg();
    230: esaShowRoadCoatsDlg();
  end;{case}
end;{actNSIExecute}
procedure TfmMain.actToolsExecute(Sender: TObject);
begin
  if Sender Is TAction then
  case (Sender As TAction).Tag of
    300: begin
      actToolsAutos.Enabled                  := IsActive(True);
      actToolsExcavators.Enabled             := actToolsAutos.Enabled;
      actToolsRocks.Enabled                  := actToolsAutos.Enabled;
      actToolsEditor.Enabled                 := actToolsAutos.Enabled;
      actToolsProductivity.Enabled           := actToolsAutos.Enabled;
      actToolsUnLoadingPunkts.Enabled        := actToolsAutos.Enabled;
      actToolsAutosPlacing.Enabled           := actToolsAutos.Enabled;
      actToolsAdditionalWorkRegime.Enabled   := actToolsAutos.Enabled;
      actToolsAdditionalParamsTotal.Enabled  := actToolsAutos.Enabled;
      actToolsAdditionalParamsExcavs.Enabled := actToolsAutos.Enabled;
      actToolsAdditionalParamsAutos.Enabled  := actToolsAutos.Enabled;
      actToolsAdditionalParamsRoads.Enabled  := actToolsAutos.Enabled;
    end;{OnPopup}
    310: esaShowAutosDlg();
    311: esaShowExcavatorsDlg();
    320: esaShowRocksDlg();
    330: esaShowOpenpitEditorDlg();
    340: esaShowProductivityDlg();
    341: esaShowUnLoadingPunktsDlg();
    342: esaShowAutoPlacingDlg();
    350: esaShowAdditionalParamsDlg(0);
    351: esaShowAdditionalParamsDlg(1);
    352: esaShowAdditionalParamsDlg(2);
    353: esaShowAdditionalParamsDlg(3);
    354: esaShowAdditionalParamsDlg(4);
  end;{case}
end;{actToolsExecute}
procedure TfmMain.actRunExecute(Sender: TObject);
var AId_Openpit: Integer;
begin
  if Sender Is TAction then
  case (Sender As TAction).Tag of
    400: begin
      actRunStart.Enabled                        := IsActive(True);
      actResultGraph.Enabled                     := IsActive(True);
      actResultShiftAutos.Enabled                := IsActive(True);
      actResultShiftExcavators.Enabled           := IsActive(True);
      actResultShiftBlocks.Enabled               := IsActive(True);
      actResultShiftUnLoadingPunkts.Enabled      := IsActive(True);
      actResultShiftProportionality.Enabled      := IsActive(True);
      actResultShiftProductionCapacities.Enabled := IsActive(True);
      actResultEconomParams.Enabled              := IsActive(True);
      actResultPeriodParams.Enabled              := IsActive(True);
      actResultVariants.Enabled                  := IsActive(True);
    end;{OnPopup}
    410: if esaShowRunDlg() then
    begin
      AId_Openpit := fmDM.quOpenpitsId_Openpit.AsInteger;
      esaShowDispatcherDlg(fmMain, fmDM.ADOConnection, AId_Openpit);
      fmDM.quOpenpits.Requery;
      fmDM.quOpenpits.Locate('Id_Openpit',AId_Openpit,[]);
    end;{Run}
    420: esaShowResultGraphDlg();
    430: esaShowResultShiftAutosDlg();
    431: esaShowResultShiftExcavatorsDlg();
    432: esaShowResultShiftBlocksDlg();
    433: esaShowResultShiftUnLoadingPunktsDlg();
    440: esaShowResultShiftProportionalityDlg();
    441: esaShowResultShiftProductionCapacitiesDlg();
    450: esaShowResultEconomParamsDlg();
    460: esaShowResultTechnologicParams();
    470: esaShowVariantsDlg();
    480: esaShowResultEconomEffect();
  end;{case}
end;{actRunExecute}
procedure TfmMain.actHelpExecute(Sender: TObject);
begin
  if Sender Is TAction then
  case (Sender As TAction).Tag of
    500: begin
      actHelpContent.Enabled := True;
      actHelpAbout.Enabled   := True;
    end;{OnPopup}
    510: Application.HelpCommand(HELP_CONTENTS, 0);
    520: esaShowAboutDlg();
  end;{case}
end;{actHelpExecute}

procedure TfmMain.Button1Click(Sender: TObject);
begin
  startFromAdis.Form1.ShowModal;
end;

end.
