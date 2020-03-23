unit unResultAddEconomParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, DB, ADODB, ExtCtrls, Grids, DBGrids, Math;

type
  TfmResultAddEconomParams = class(TForm)
    gbStarting: TGroupBox;
    lbRocksV1000m3: TLabel;
    lbShiftExcavators: TLabel;
    lbCountUnloadingPunkts: TLabel;
    lbShiftAutos: TLabel;
    lbSalary: TLabel;
    lbSelic: TLabel;
    lbAVGTransKPD: TLabel;
    lbOstat: TLabel;
    lbBLength: TLabel;
    lbZatrat: TLabel;
    lbElec: TLabel;
    lbElectr: TLabel;
    lbUdelGx: TLabel;
    lbStoiGx: TLabel;
    lbUdelTyres: TLabel;
    lbStoiTyres: TLabel;
    lbUdelQtn: TLabel;
    lbProizPeriod: TLabel;
    lbKVskry: TLabel;
    gbResult: TGroupBox;
    lbUsEcom: TLabel;
    lbOtnoEconom: TLabel;
    lbOriUsEco: TLabel;
    quAddEconomy: TADOQuery;
    dsAddEconomy: TDataSource;
    edOriUsEcom: TEdit;
    edOtnoEcom: TEdit;
    edUsEcom: TEdit;
    edRocksVm3: TEdit;
    edAVGTransKPD: TEdit;
    edCountUnLodingPunkts: TEdit;
    edBLength: TEdit;
    edElec: TEdit;
    edKVsry: TEdit;
    lbSTyres: TLabel;
    edShiftAutos: TEdit;
    edShiftExcavators: TEdit;
    edSelic: TEdit;
    edSalary: TEdit;
    quCoef: TADOQuery;
    dsCoef: TDataSource;
    quCoefProductivity: TFloatField;
    quCoefRecordNO: TIntegerField;
    edOstat: TEdit;
    edZatrat: TEdit;
    edElectr: TEdit;
    edUdelGx: TEdit;
    edStoiGx: TEdit;
    edUdelTyres: TEdit;
    edStoiTyre: TEdit;
    edSTyres: TEdit;
    edUdelQtn: TEdit;
    edProizPeriod: TEdit;
    quAddEconomyRecordNo: TIntegerField;
    quAddEconomySF: TFloatField;
    quAddEconomyAVGTransKPD: TFloatField;
    dsResultAddEconomParams: TDataSource;
    pnBts: TPanel;
    lbCountVar: TLabel;
    lbName: TLabel;
    edName: TEdit;
    edRecNo: TEdit;
    lbCount: TLabel;
    btDelete: TButton;
    btExcel: TButton;
    lbResultPeriodCoef: TLabel;
    edResultPeriodCoef: TEdit;
    edParamsShiftDuration: TEdit;
    lbParamsShiftDuration: TLabel;
    lbPribil: TLabel;
    edPribil: TEdit;
    edRashot: TEdit;
    lbRashot: TLabel;
    edBaseVari: TEdit;
    lbBaseVari: TLabel;
    gbInput: TGroupBox;
    lbProduk: TLabel;
    edProduk: TEdit;
    lbSenaProduk: TLabel;
    lbStoiGTR: TLabel;
    lbStoiPrib: TLabel;
    lbZatSer: TLabel;
    lbBaseVar: TLabel;
    lbQtnGM: TLabel;
    edQtnGM: TEdit;
    edBaseVar: TEdit;
    edZatSer: TEdit;
    edStoiPrib: TEdit;
    edStoiGTR: TEdit;
    edSenaProd: TEdit;
    quResultAddEconomParams: TADOQuery;
    quResultAddEconomParamsName: TWideStringField;
    quResultAddEconomParamsRocksVm3: TFloatField;
    quResultAddEconomParamsShiftExcavators: TIntegerField;
    quResultAddEconomParamsCountUnLodingPunkts: TIntegerField;
    quResultAddEconomParamsShiftAutos: TIntegerField;
    quResultAddEconomParamsSalary: TFloatField;
    quResultAddEconomParamsSelic: TFloatField;
    quResultAddEconomParamsAVGTransKPD: TFloatField;
    quResultAddEconomParamsOstat: TFloatField;
    quResultAddEconomParamsBLength: TFloatField;
    quResultAddEconomParamsZatrat: TFloatField;
    quResultAddEconomParamsElectr: TFloatField;
    quResultAddEconomParamsUdelGx: TFloatField;
    quResultAddEconomParamsStoiGx: TFloatField;
    quResultAddEconomParamsUdelTyres: TFloatField;
    quResultAddEconomParamsStoiTyre: TFloatField;
    quResultAddEconomParamsSTyres: TFloatField;
    quResultAddEconomParamsUdelQtn: TFloatField;
    quResultAddEconomParamsProizPeriod: TFloatField;
    quResultAddEconomParamsKVsry: TFloatField;
    quResultAddEconomParamsProduk: TFloatField;
    quResultAddEconomParamsSenaProd: TFloatField;
    quResultAddEconomParamsStoiGTR: TFloatField;
    quResultAddEconomParamsStoiPrib: TFloatField;
    quResultAddEconomParamsZatSer: TFloatField;
    quResultAddEconomParamsBaseVar: TFloatField;
    quResultAddEconomParamsQtnGM: TFloatField;
    quResultAddEconomParamsResultPeriodCoef: TFloatField;
    quResultAddEconomParamsParamsShiftDuration: TIntegerField;
    quResultAddEconomParamsId_ResultAddEconomParam: TAutoIncField;
    btNext: TButton;
    btPrior: TButton;
    btSave: TButton;
    quResultAddEconomParamsUsEcom: TFloatField;
    quResultAddEconomParamsSortIndex: TIntegerField;
    btBase: TButton;
    quResultAddEconomParamsEmploymentRatio: TFloatField;
    pnBtns: TPanel;
    btCalc: TButton;
    btClose: TButton;
    lbEmploymentRatio: TLabel;
    edEmploymentRatio: TEdit;
    lbWorkTimeUsingRatio: TLabel;
    edWorkTimeUsingRatio: TEdit;
    quResultAddEconomParamsWorkTimeUsingRatio: TFloatField;
    lbExcavsCostsSummary: TLabel;
    edExcavsCostsSummary: TEdit;
    quResultAddEconomParamsExcavsCostsSummary: TFloatField;
    lbAutosCostsSummary: TLabel;
    edAutosCostsSummary: TEdit;
    lbBlocksCostsSummary: TLabel;
    edBlocksCostsSummary: TEdit;
    quResultAddEconomParamsAutosCostsSummary: TFloatField;
    quResultAddEconomParamsBlocksCostsSummary: TFloatField;
    lbTotalCostsSummary: TLabel;
    edTotalCostsSummary: TEdit;
    lbGx: TLabel;
    edGx: TEdit;
    quResultAddEconomParamsTotalCostsSummary: TFloatField;
    quResultAddEconomParamsGx: TFloatField;
    quResultAddEconomParamsElec: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure edRocksVm3Exit(Sender: TObject);
    procedure edRocksVm3KeyPress(Sender: TObject; var Key: Char);
    procedure btDeleteClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btCalcClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btPriorClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btBaseClick(Sender: TObject);

  private

  public
    function SaveToDB(Add: Boolean): Boolean;
  end;

var
  fmResultAddEconomParams: TfmResultAddEconomParams;

implementation

uses unDM, Globals, esaExcelEditors, unDialogAddEconomParams;

{$R *.dfm}

procedure LoadValue;
var AId_AddEconomParam: Integer;
begin
  with fmResultAddEconomParams do
  if quResultAddEconomParams.Active then
  begin
    lbCount.Caption := 'из '+IntToStr(quResultAddEconomParams.RecordCount);
    edRecNo.Text := IntToStr(quResultAddEconomParamsSortIndex.AsInteger);
    edName.Text := quResultAddEconomParamsName.AsString;
    if quResultAddEconomParams.RecNo=1 then edName.Font.Color := clRed
    else edName.Font.Color := clBlack;
    AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;

    quResultAddEconomParams.First;
    edBaseVari.Text := Format('%.6f',[quResultAddEconomParamsUsEcom.AsFloat]);
    quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);

    edResultPeriodCoef.Text := Format('%.3f',[quResultAddEconomParamsResultPeriodCoef.AsFloat]);
    edRocksVm3.Text := Format('%.3f',[quResultAddEconomParamsRocksVm3.AsFloat]);
    edShiftExcavators.Text := quResultAddEconomParamsShiftExcavators.AsString;
    edCountUnLodingPunkts.Text := quResultAddEconomParamsCountUnLodingPunkts.AsString;
    edShiftAutos.Text := quResultAddEconomParamsShiftAutos.AsString;
    edSalary.Text := Format('%.3f',[quResultAddEconomParamsSalary.AsFloat]);
    edSelic.Text := Format('%.3f',[quResultAddEconomParamsSelic.AsFloat]);
    //edSelic0.Text := Format('%.3f',[quResultAddEconomParamsSelic0.AsFloat]);
    edAVGTransKPD.Text := Format('%.3f',[quResultAddEconomParamsAVGTransKPD.AsFloat]);
    edOstat.Text := Format('%.3f',[quResultAddEconomParamsOstat.AsFloat]);
    edBLength.Text := Format('%.3f',[quResultAddEconomParamsBLength.AsFloat]);
    edZatrat.Text := Format('%.3f',[quResultAddEconomParamsZatrat.AsFloat]);
    //edYklon.Text := Format('%.3f',[quResultAddEconomParamsYklon.AsFloat]);
    edElec.Text := Format('%.3f',[quResultAddEconomParamsElec.AsFloat]);
    edElectr.Text := Format('%.3f',[quResultAddEconomParamsElectr.AsFloat]);
    edUdelGx.Text := Format('%.3f',[quResultAddEconomParamsUdelGx.AsFloat]);
    edStoiGx.Text := Format('%.3f',[quResultAddEconomParamsStoiGx.AsFloat]);
    edUdelTyres.Text := Format('%.3f',[quResultAddEconomParamsUdelTyres.AsFloat]);
    edStoiTyre.Text := Format('%.3f',[quResultAddEconomParamsStoiTyre.AsFloat]);
    edSTyres.Text := Format('%.3f',[quResultAddEconomParamsSTyres.AsFloat]);
    edUdelQtn.Text := Format('%.3f',[quResultAddEconomParamsUdelQtn.AsFloat]);
    edProizPeriod.Text := Format('%.3f',[quResultAddEconomParamsProizPeriod.AsFloat]);
    edKVsry.Text := Format('%.3f',[quResultAddEconomParamsKVsry.AsFloat]);
    edProduk.Text := Format('%.3f',[quResultAddEconomParamsProduk.AsFloat]);
    edSenaProd.Text := Format('%.3f',[quResultAddEconomParamsSenaProd.AsFloat]);
    edStoiGTR.Text := Format('%.3f',[quResultAddEconomParamsStoiGTR.AsFloat]);
    edStoiPrib.Text := Format('%.3f',[quResultAddEconomParamsStoiPrib.AsFloat]);
    edZatSer.Text := Format('%.3f',[quResultAddEconomParamsZatSer.AsFloat]);
    edBaseVar.Text := Format('%.3f',[quResultAddEconomParamsBaseVar.AsFloat]);
    edQtnGM.Text := Format('%.3f',[quResultAddEconomParamsQtnGM.AsFloat]);
    edResultPeriodCoef.Text := Format('%.3f',[quResultAddEconomParamsResultPeriodCoef.asFloat]);
    edParamsShiftDuration.Text := Format('%.3f',[quResultAddEconomParamsParamsShiftDuration.asFloat]);
    edEmploymentRatio.Text := Format('%.2f',[quResultAddEconomParamsEmploymentRatio.asFloat]);
    edWorkTimeUsingRatio.Text := Format('%.2f',[quResultAddEconomParamsWorkTimeUsingRatio.AsFloat]);
    edExcavsCostsSummary.Text := Format('%.2f',[quResultAddEconomParamsExcavsCostsSummary.AsFloat]);
    edAutosCostsSummary.Text := Format('%.2f',[quResultAddEconomParamsAutosCostsSummary.AsFloat]);
    edBlocksCostsSummary.Text := Format('%.2f',[quResultAddEconomParamsBlocksCostsSummary.AsFloat]);
    edTotalCostsSummary.Text := Format('%.2f',[quResultAddEconomParamsTotalCostsSummary.AsFloat]);
    edGx.Text := Format('%.2f',[quResultAddEconomParamsGx.AsFloat]);
    btCalc.Click;
  end;{if}
end;{LoadValue}

function TfmResultAddEconomParams.SaveToDB(Add: Boolean): Boolean;
var AId_AddEconomParam: Integer;
begin
  Result := False;
  with fmResultAddEconomParams do
  if quResultAddEconomParams.Active then
  begin
    if Add then
    begin
      quResultAddEconomParams.Append;
      quResultAddEconomParamsName.AsString := edName.Text;
      quResultAddEconomParamsSortIndex.AsInteger := quResultAddEconomParams.RecordCount+1;
    end{if}
    else quResultAddEconomParams.Edit;
    quResultAddEconomParamsUsEcom.AsFloat := StrToFloat(edUsEcom.Text);
    quResultAddEconomParamsRocksVm3.AsFloat := StrToFloat(edRocksVm3.Text);
    quResultAddEconomParamsShiftExcavators.AsFloat := StrToFloat(edShiftExcavators.Text);
    quResultAddEconomParamsCountUnLodingPunkts.AsInteger := StrToInt(edCountUnLodingPunkts.Text);
    quResultAddEconomParamsShiftAutos.AsFloat := StrToFloat(edShiftAutos.Text);
    quResultAddEconomParamsSalary.AsFloat := StrToFloat(edSalary.Text);
    quResultAddEconomParamsSelic.AsFloat := StrToFloat(edSelic.Text);
    //quResultAddEconomParamsSelic0.AsFloat := StrToFloat(edSelic0.Text);
    quResultAddEconomParamsAVGTransKPD.AsFloat := StrToFloat(edAVGTransKPD.Text);
    quResultAddEconomParamsOstat.AsFloat := StrToFloat(edOstat.Text);
    quResultAddEconomParamsBLength.AsFloat := StrToFloat(edBLength.Text);
    quResultAddEconomParamsZatrat.AsFloat := StrToFloat(edZatrat.Text);
    //quResultAddEconomParamsYklon.AsFloat := StrToFloat(edYklon.Text);
    quResultAddEconomParamsElec.AsFloat := StrToFloat(edElec.Text);
    quResultAddEconomParamsElectr.AsFloat := StrToFloat(edElectr.Text);
    quResultAddEconomParamsUdelGx.AsFloat := StrToFloat(edUdelGx.Text);
    quResultAddEconomParamsStoiGx.AsFloat := StrToFloat(edStoiGx.Text);
    quResultAddEconomParamsUdelTyres.AsFloat := StrToFloat(edUdelTyres.Text);
    quResultAddEconomParamsStoiTyre.AsFloat := StrToFloat(edStoiTyre.Text);
    quResultAddEconomParamsSTyres.AsFloat := StrToFloat(edSTyres.Text);
    quResultAddEconomParamsUdelQtn.AsFloat := StrToFloat(edUdelQtn.Text);
    quResultAddEconomParamsProizPeriod.AsFloat := StrToFloat(edProizPeriod.Text);
    quResultAddEconomParamsKVsry.AsFloat := StrToFloat(edKVsry.Text);
    quResultAddEconomParamsProduk.AsFloat := StrToFloat(edProduk.Text);
    quResultAddEconomParamsSenaProd.AsFloat := StrToFloat(edSenaProd.Text);
    quResultAddEconomParamsStoiGTR.AsFloat := StrToFloat(edStoiGTR.Text);
    quResultAddEconomParamsStoiPrib.AsFloat := StrToFloat(edStoiPrib.Text);
    quResultAddEconomParamsZatSer.AsFloat := StrToFloat(edZatSer.Text);
    quResultAddEconomParamsBaseVar.AsFloat := StrToFloat(edBaseVar.Text);
    quResultAddEconomParamsQtnGM.AsFloat := StrToFloat(edQtnGM.Text);
    quResultAddEconomParamsResultPeriodCoef.asFloat := StrToFloat(edResultPeriodCoef.Text);
    quResultAddEconomParamsParamsShiftDuration.asFloat := StrToFloat(edParamsShiftDuration.Text);

    quResultAddEconomParamsEmploymentRatio.asFloat := StrToFloat(edEmploymentRatio.Text);
    quResultAddEconomParamsWorkTimeUsingRatio.AsFloat := StrToFloat(edWorkTimeUsingRatio.Text);
    quResultAddEconomParamsExcavsCostsSummary.AsFloat := StrToFloat(edExcavsCostsSummary.Text);
    quResultAddEconomParamsAutosCostsSummary.AsFloat := StrToFloat(edAutosCostsSummary.Text);
    quResultAddEconomParamsBlocksCostsSummary.AsFloat := StrToFloat(edBlocksCostsSummary.Text);
    quResultAddEconomParamsTotalCostsSummary.AsFloat := StrToFloat(edTotalCostsSummary.Text);
    quResultAddEconomParamsGx.AsFloat := StrToFloat(edGx.Text);

    quResultAddEconomParams.Post;
    AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;
    quResultAddEconomParams.Requery;
    quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);
    Result := True;
  end;{if}
end;{SaveToDB}

procedure InputValue(KeyField: String;KeyValue: Single);
begin
  with fmResultAddEconomParams do
  if quResultAddEconomParams.Active then
  with quResultAddEconomParams do
  begin
    Edit;
    FieldByName(KeyField).AsFloat := KeyValue;
    Post;
  end;{with}
end;{InputValue}

procedure TfmResultAddEconomParams.FormCreate(Sender: TObject);
var I: Integer;
    Cost: Single;
    FProductivityMineralWealthQ1000tn: Single;//I?iecaiaeoaeuiinou ?oau, oun.o
    FProductivityStrippingQ1000tn    : Single;//I?iecaiaeoaeuiinou ane?uoe, oun.o
    CountShifts                      : Single;//Eiee?anoai niai a caaaiiii ia?eiaa
    Salary                           : Single;//CI iaoeienoia, iiiiuieeia iaoeienoia e aiaeoaeae  
begin
  with fmDM do
  begin
    quOpenpits.Open;
    quUnLoadingPunkts.Open;
    quResultBlocksSummary.Open;
    quResultLoadingPunktsSummary.Open;
    quResultAutosSummary.Open;
    quResultAutosSummary.Open;
    quResultEconomBlocks.Open;
    quResultEconomLoadingPunkts.Open;
    quResultEconomAutos.Open;
    quResultEconomUnLoadingPunkts.Open;
    quResultEconomParams.Open;
    quRockProductivity.Open;

    quResultBlocksSummary.Open;
    quResultAutosSummary.Open;
    quResultEconomParams.Open;

    for I := 0 to quAddEconomy.Parameters.Count-1 do
    begin
      if quAddEconomy.Parameters[I].Name='Id_Openpit'
      then quAddEconomy.Parameters[I].Value := quOpenpitsId_Openpit.AsInteger
      else
      if quAddEconomy.Parameters[I].Name='Id_UnLoadingPunkt'
      then quAddEconomy.Parameters[I].Value := quUnLoadingPunktsId_UnloadingPunkt.AsInteger
      else quAddEconomy.Parameters[I].Value := 0;
    end;{for}
    edBLength.Text := Format('%.3f',[quResultBlocksSummaryBLength0.AsFloat/1000]);
    edZatrat.Text := Format('%.3f',[quResultBlocksSummaryCostsRepair0.AsFloat/1000]);
    edElectr.Text := Format('%.3f',[quOpenpitsExcavsEnergyCost.AsFloat]);
    edUdelGx.Text := Format('%.3f',[quResultAutosSummaryGxSpecific0.AsFloat]);
    edStoiGx.Text := Format('%.3f',[quOpenpitsAutosFuelCostWinter.AsFloat]);
    edSTyres.Text := Format('%.3f',[quResultAutosSummaryTyresCosts0.AsFloat]);
    edUdelQtn.Text := Format('%.3f',[quResultEconomParamsTotalUdCostsCurrent0.AsFloat]);
//Eiyooeoeaio ane?uoe--------------------------------------------------------------------------
    FProductivityMineralWealthQ1000tn := 0.0;
    FProductivityStrippingQ1000tn := 0.0;
    quRockProductivity.First;
    while not quRockProductivity.Eof do
    begin
      if quRockProductivityIsMineralWealth.AsBoolean
      then FProductivityMineralWealthQ1000tn := FProductivityMineralWealthQ1000tn+
                                                quRockProductivityPlannedQ1000tn.AsFloat
      else FProductivityStrippingQ1000tn := FProductivityStrippingQ1000tn+
                                            quRockProductivityPlannedQ1000tn.AsFloat;
      quRockProductivity.Next;
    end;{while}
    edKVsry.Text := Format('%.3f',[FProductivityStrippingQ1000tn/FProductivityMineralWealthQ1000tn]);
  end;{with}
  quAddEconomy.Open;
  quCoef.Open;
  quResultAddEconomParams.Open;

  if quAddEconomy.Locate('RecordNo',1,[]) then
  begin
    edShiftAutos.Text := quAddEconomySF.AsString;
    edAVGTransKPD.Text := Format('%.3f',[quAddEconomyAVGTransKPD.AsFloat]);
  end;{if}
  if quAddEconomy.Locate('RecordNo',2,[])
  then edShiftExcavators.Text := quAddEconomySF.AsString;
  if quAddEconomy.Locate('RecordNo',3,[])
  then edSelic.Text := Format('%.3f',[quAddEconomySF.AsFloat]);
  {
  if quAddEconomy.Locate('RecordNo',4,[])
  then edSelic0.Text := Format('%.3f',[quAddEconomySF.AsFloat]);}

  if quAddEconomy.Locate('RecordNo',5,[])
  then edRocksVm3.Text := Format('%.3f',[quAddEconomySF.AsFloat/1000]);
  if quAddEconomy.Locate('RecordNo',6,[])
  then edCountUnLodingPunkts.Text := quAddEconomySF.AsString;
  if quAddEconomy.Locate('RecordNo',7,[])then
  begin
    Cost := quAddEconomySF.AsFloat;
    edStoiTyre.Text := Format('%.3f',[quAddEconomyAVGTransKPD.AsFloat]);
    if quAddEconomy.Locate('RecordNo',8,[])then
    begin
      edOstat.Text := Format('%.3f',[Cost+quAddEconomySF.AsFloat]);
    end;{if}
  end;{if}
  edElec.Text := Format('%.3f',[fmDM.quResultLoadingPunktsSummaryGx0.AsFloat]);
  edUdelTyres.Text := Format('%.3f',[fmDM.quResultAutosSummaryTyresAllowedCount0.AsFloat/
                                     StrToFloat(edRocksVm3.Text)]);
  CountShifts := (1440/fmDM.quOpenpitsParamsShiftDuration.AsInteger)*365;
  edProizPeriod.Text := Format('%.3f',[(StrToFloat(edRocksVm3.Text)*
                                       fmDM.quOpenpitsResultPeriodCoef.AsFloat*CountShifts)]);
  with fmDM do
  begin
    Salary := (quOpenpitsAutosSalary0.AsFloat*StrToInt(edShiftAutos.Text))+
              (quOpenpitsAutosSalary1.AsFloat*StrToInt(edShiftAutos.Text))+
              (quOpenpitsExcavsSalaryMashinist0.AsFloat*StrToInt(edShiftExcavators.Text))+
              (quOpenpitsExcavsSalaryMashinist1.AsFloat*StrToInt(edShiftExcavators.Text))+
              (quOpenpitsExcavsSalaryAssistant0.AsFloat*StrToInt(edShiftExcavators.Text))+
              (quOpenpitsExcavsSalaryAssistant1.AsFloat*StrToInt(edShiftExcavators.Text));
    edSalary.Text := Format('%.3f',[Salary]);
    edResultPeriodCoef.Text := Format('%.3f',[quOpenpitsResultPeriodCoef.asFloat]);
    edParamsShiftDuration.Text := Format('%.3f',[quOpenpitsParamsShiftDuration.asFloat]);

    edEmploymentRatio.Text := Format('%.2f',[quResultLoadingPunktsSummaryEmploymentRatio0.AsFloat]);
    edWorkTimeUsingRatio.Text := Format('%.3f',[quResultAutosSummaryWorkTimeUsingRatio0.AsFloat]);
    edExcavsCostsSummary.Text := Format('%.2f',[quResultEconomParamsExcavsCostsSummary.AsFloat]);
    edAutosCostsSummary.Text := Format('%.2f',[quResultEconomParamsAutosCostsSummary.AsFloat]);
    edBlocksCostsSummary.Text := Format('%.2f',[quResultEconomParamsBlocksCostsSummary.AsFloat]);
    edTotalCostsSummary.Text := Format('%.2f',[quResultEconomParamsTotalCostsSummary.AsFloat]);
    edGx.Text := Format('%.2f',[quResultAutosSummaryGx0.AsFloat]);
  end;{with}
end;{FormCreate}

procedure TfmResultAddEconomParams.edRocksVm3Exit(Sender: TObject);
begin
  if TEdit(Sender).Text='' then TEdit(Sender).Text := '0';
end;{edRockVm3Exit}

procedure TfmResultAddEconomParams.edRocksVm3KeyPress(Sender: TObject;
  var Key: Char);
begin
  TEdit(Sender).Text := Trim(TEdit(Sender).Text);
  if (Key in ['.',',']) then  Key := DecimalSeparator;
  if (not (Key in ['0'..'9',#8,DecimalSeparator]))OR
     ((Key=DecimalSeparator)AND(Pos(DecimalSeparator,TEdit(Sender).Text)<>0))then
  begin
    Key := #0;
    Beep;
  end;{if}
end;{edRockVm3KeyPress}

procedure TfmResultAddEconomParams.btDeleteClick(Sender: TObject);
var AId_AddEconomParam,ASortIndex: Integer;
begin
  if quResultAddEconomParams.RecordCount>0 then
  if Application.MessageBox(PChar('Вы действительно хотите удалить вариант '''+
                            quResultAddEconomParamsName.AsString+''''+'?'),
                            'Подтверждение',MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2)=IDYES
  then begin
    quResultAddEconomParams.Delete;
    AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;
    quResultAddEconomParams.DisableControls;
    quResultAddEconomParams.Requery;
    ASortIndex := 0;
    while not quResultAddEconomParams.Eof do
    begin
      Inc(ASortIndex);
      quResultAddEconomParams.Edit;
      quResultAddEconomParamsSortIndex.AsInteger := ASortIndex;
      quResultAddEconomParams.Post;
      quResultAddEconomParams.Next;
    end;{while}
    quResultAddEconomParams.Requery;
    quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);
    quResultAddEconomParams.EnableControls;
    LoadValue;
  end;{if}
end;{btDeleteClick}

procedure TfmResultAddEconomParams.btExcelClick(Sender: TObject);
var
  XL         : TesaExcelEditor;
  ACol,r,c,w,AId_AddEconomParam: Integer;
begin
  AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;
  XL := TesaExcelEditor.Create;
  try
    XL.Visible := True;
    XL.ActiveSheetIndex := 0;
    c := 0;
    r := 3;
    w := Max(11,quResultAddEconomParams.RecordCount);
    //Устанавливаю ширину столбцов ------------------------------------------------------------
    XL.ColumnWidths[1,1] := 42;
    XL.RowHeights[r,1] := 80;
    XL.RowHeights[5,35] := 11.25;
    //Печатаю шапку "Данные с CEBEDAN"---------------------------------------------------------
    XL.Cells[1,2,w-1,1].AsText := Caption;
    XL.Cells[2,2,w-1,1].AsText := 'Данные с CEBEDAN';
    XL.Cells[r,c+1,1,1].AsText := quResultAddEconomParamsName.DisplayLabel;
    XL.Cells[r+2,c+1,1,1].AsText := quResultAddEconomParamsRocksVm3.DisplayLabel;
    XL.Cells[r+3,c+1,1,1].AsText := quResultAddEconomParamsProizPeriod.DisplayLabel;
    XL.Cells[r+4,c+1,1,1].AsText := quResultAddEconomParamsSelic.DisplayLabel;
    //XL.Cells[r+5,c+1,1,1].AsText := quResultAddEconomParamsSelic0.DisplayLabel;
    XL.Cells[r+5,c+1,1,1].AsText := quResultAddEconomParamsParamsShiftDuration.DisplayLabel;
    //XL.Cells[r+7,c+1,1,1].AsText := quResultAddEconomParamsYklon.DisplayLabel;
    XL.Cells[r+6,c+1,1,1].AsText := quResultAddEconomParamsTotalCostsSummary.DisplayLabel;
    XL.Cells[r+7,c+1,1,1].AsText := quResultAddEconomParamsUdelQtn.DisplayLabel;
    XL.Cells[r+8,c+1,1,1].AsText := quResultAddEconomParamsSalary.DisplayLabel;
    XL.Cells[r+9,c+1,1,1].AsText := quResultAddEconomParamsKVsry.DisplayLabel;
    XL.Cells[r+10,c+1,1,1].AsText := quResultAddEconomParamsResultPeriodCoef.DisplayLabel;
    XL.Cells[r+11,c+1,1,1].AsText := quResultAddEconomParamsEmploymentRatio.DisplayLabel;
    XL.Cells[r+12,c+1,1,1].AsText := quResultAddEconomParamsWorkTimeUsingRatio.DisplayLabel;
    XL.Cells[r+13,c+1,1,1].AsText := quResultAddEconomParamsShiftExcavators.DisplayLabel;
    XL.Cells[r+14,c+1,1,1].AsText := quResultAddEconomParamsElec.DisplayLabel;
    XL.Cells[r+15,c+1,1,1].AsText := quResultAddEconomParamsElectr.DisplayLabel;
    XL.Cells[r+16,c+1,1,1].AsText := quResultAddEconomParamsExcavsCostsSummary.DisplayLabel;
    XL.Cells[r+17,c+1,1,1].AsText := quResultAddEconomParamsCountUnLodingPunkts.DisplayLabel;
    XL.Cells[r+18,c+1,1,1].AsText := quResultAddEconomParamsBlocksCostsSummary.DisplayLabel;
    XL.Cells[r+19,c+1,1,1].AsText := quResultAddEconomParamsBLength.DisplayLabel;
    XL.Cells[r+20,c+1,1,1].AsText := quResultAddEconomParamsZatrat.DisplayLabel;
    XL.Cells[r+21,c+1,1,1].AsText := quResultAddEconomParamsShiftAutos.DisplayLabel;
    XL.Cells[r+22,c+1,1,1].AsText := quResultAddEconomParamsAVGTransKPD.DisplayLabel;
    XL.Cells[r+23,c+1,1,1].AsText := quResultAddEconomParamsUdelTyres.DisplayLabel;
    XL.Cells[r+24,c+1,1,1].AsText := quResultAddEconomParamsStoiTyre.DisplayLabel;
    XL.Cells[r+25,c+1,1,1].AsText := quResultAddEconomParamsSTyres.DisplayLabel;
    XL.Cells[r+26,c+1,1,1].AsText := quResultAddEconomParamsStoiGx.DisplayLabel;
    XL.Cells[r+27,c+1,1,1].AsText := quResultAddEconomParamsUdelGx.DisplayLabel;
    XL.Cells[r+28,c+1,1,1].AsText := quResultAddEconomParamsGx.DisplayLabel;
    XL.Cells[r+29,c+1,1,1].AsText := quResultAddEconomParamsAutosCostsSummary.DisplayLabel;
    XL.Cells[r+30,c+1,1,1].AsText := quResultAddEconomParamsOstat.DisplayLabel;
    XL.SetNumericRow(r+1,1,w);
    r := 6;
    //Печатаю шапку "Входные данные"-----------------------------------------------------------
    XL.Cells[r+28,2,w-1,1].AsText := 'Входные данные';
    XL.Cells[r+29,1,1,1].AsText := quResultAddEconomParamsProduk.DisplayName;
    XL.Cells[r+30,1,1,1].AsText := quResultAddEconomParamsSenaProd.DisplayName;
    XL.Cells[r+31,1,1,1].AsText := quResultAddEconomParamsStoiGTR.DisplayName;
    XL.Cells[r+32,1,1,1].AsText := quResultAddEconomParamsStoiPrib.DisplayName;
    XL.Cells[r+33,1,1,1].AsText := quResultAddEconomParamsZatSer.DisplayName;
    XL.Cells[r+34,1,1,1].AsText := quResultAddEconomParamsBaseVar.DisplayName;
    XL.Cells[r+35,1,1,1].AsText := quResultAddEconomParamsQtnGM.DisplayName;
    //Печатаю шапку "Выходные данные"-----------------------------------------------------------
    XL.Cells[r+36,2,w-1,1].AsText := 'Выходные данные';
    XL.Cells[r+37,1,1,1].AsText := 'Прибыль, млн.тг';
    XL.Cells[r+38,1,1,1].AsText := 'Затраты, млн.тг';
    XL.Cells[r+39,1,1,1].AsText := 'Условно экономический эффект, млн.тг';
    XL.Cells[r+40,1,1,1].AsText := 'Базовый вариант, млн.тг';
    XL.Cells[r+41,1,1,1].AsText := 'Относительный экономический эффект, млн.тг';
    XL.Cells[r+42,1,1,1].AsText := 'Объемно ориентированный условный ЭЭ, млн.тг';
    //r := 3;
    //Печатаю данные "Данные с CEBEDAN"--------------------------------------------------------
    ACol := 2;
    quResultAddEconomParams.First;
    while not quResultAddEconomParams.Eof do
    begin
      XL.Cell[3,ACol].AsString := quResultAddEconomParamsName.AsString;
      XL.Cell[5,ACol].AsFloat := quResultAddEconomParamsRocksVm3.AsFloat;
      XL.Cell[6,ACol].AsFloat := quResultAddEconomParamsProizPeriod.AsFloat;
      XL.Cell[7,ACol].AsFloat := quResultAddEconomParamsSelic.AsFloat;
      //XL.Cell[8,ACol].AsFloat := quResultAddEconomParamsSelic0.AsFloat;
      XL.Cell[8,ACol].AsFloat := quResultAddEconomParamsParamsShiftDuration.AsFloat;
      //XL.Cell[10,ACol].AsFloat := quResultAddEconomParamsYklon.AsFloat;
      XL.Cell[9,ACol].AsFloat := quResultAddEconomParamsTotalCostsSummary.AsFloat;
      XL.Cell[10,ACol].AsFloat := quResultAddEconomParamsUdelQtn.AsFloat;
      XL.Cell[11,ACol].AsFloat := quResultAddEconomParamsSalary.AsFloat;
      XL.Cell[12,ACol].AsFloat := quResultAddEconomParamsKVsry.AsFloat;
      XL.Cell[13,ACol].AsFloat := quResultAddEconomParamsResultPeriodCoef.AsFloat;
      XL.Cell[14,ACol].AsFloat := quResultAddEconomParamsEmploymentRatio.AsFloat;
      XL.Cell[15,ACol].AsFloat := quResultAddEconomParamsWorkTimeUsingRatio.AsFloat;
      XL.Cell[16,ACol].AsFloat := quResultAddEconomParamsShiftExcavators.AsFloat;
      XL.Cell[17,ACol].AsFloat := quResultAddEconomParamsElec.AsFloat;
      XL.Cell[18,ACol].AsFloat := quResultAddEconomParamsElectr.AsFloat;
      XL.Cell[19,ACol].AsFloat := quResultAddEconomParamsExcavsCostsSummary.AsFloat;
      XL.Cell[20,ACol].AsFloat := quResultAddEconomParamsCountUnLodingPunkts.AsFloat;
      XL.Cell[21,ACol].AsFloat := quResultAddEconomParamsBlocksCostsSummary.AsFloat;
      XL.Cell[22,ACol].AsFloat := quResultAddEconomParamsBLength.AsFloat;
      XL.Cell[23,ACol].AsFloat := quResultAddEconomParamsZatrat.AsFloat;
      XL.Cell[24,ACol].AsFloat := quResultAddEconomParamsShiftAutos.AsFloat;
      XL.Cell[25,ACol].AsFloat := quResultAddEconomParamsAVGTransKPD.AsFloat;
      XL.Cell[26,ACol].AsFloat := quResultAddEconomParamsUdelTyres.AsFloat;
      XL.Cell[27,ACol].AsFloat := quResultAddEconomParamsStoiTyre.AsFloat;
      XL.Cell[28,ACol].AsFloat := quResultAddEconomParamsSTyres.AsFloat;
      XL.Cell[29,ACol].AsFloat := quResultAddEconomParamsStoiGx.AsFloat;
      XL.Cell[30,ACol].AsFloat := quResultAddEconomParamsUdelGx.AsFloat;
      XL.Cell[31,ACol].AsFloat := quResultAddEconomParamsGx.AsFloat;
      XL.Cell[32,ACol].AsFloat := quResultAddEconomParamsAutosCostsSummary.AsFloat;
      XL.Cell[33,ACol].AsFloat := quResultAddEconomParamsOstat.AsFloat;
      Inc(ACol);
      quResultAddEconomParams.Next;
    end;{while}

    //Печатаю данные "Входные данные"----------------------------------------------------------
    ACol := 2;
    quResultAddEconomParams.First;
    while not quResultAddEconomParams.Eof do
    begin
      XL.Cell[35,ACol].AsString := quResultAddEconomParamsProduk.AsString;
      XL.Cell[36,ACol].AsString := quResultAddEconomParamsSenaProd.AsString;
      XL.Cell[37,ACol].AsString := quResultAddEconomParamsStoiGTR.AsString;
      XL.Cell[38,ACol].AsString := quResultAddEconomParamsStoiPrib.AsString;
      XL.Cell[39,ACol].AsString := quResultAddEconomParamsZatSer.AsString;
      XL.Cell[40,ACol].AsString := quResultAddEconomParamsBaseVar.AsString;
      XL.Cell[41,ACol].AsString := quResultAddEconomParamsQtnGM.AsString;
      Inc(ACol);
      quResultAddEconomParams.Next;
    end;{while}
    //Печатаю данные "Выходные данные"---------------------------------------------------------
    quResultAddEconomParams.First;
    LoadValue;
    for ACol := 2 to quResultAddEconomParams.RecordCount+1 do
    begin
      XL.Cell[43,ACol].AsFloat := StrToFloat(edPribil.Text);
      XL.Cell[44,ACol].AsFloat := StrToFloat(edRashot.Text);
      XL.Cell[45,ACol].AsFloat := StrToFloat(edUsEcom.Text);
      XL.Cell[46,ACol].AsFloat := StrToFloat(edBaseVari.Text);
      XL.Cell[47,ACol].AsFloat := StrToFloat(edOtnoEcom.Text);
      XL.Cell[48,ACol].AsFloat := StrToFloat(edOriUsEcom.Text);
      quResultAddEconomParams.Next;
      LoadValue;
    end;{for}   
    //Печатаю рамку, устанавливаю формат ячеек-------------------------------------------------
    XL.Cells[5,2,w,46].NumberFormat := nfFloat000;
    //XL.Cells[6,2,w,2].NumberFormat := nfInt0;
    //XL.Cells[27,2,w-1,1].NumberFormat := nfInt0;
    XL.Cells[1,1,w+1,48].Frame := [feTotal];
    XL.Cells[1,2,w,1].Font.Style := [xlfsBold];
    XL.Cells[34,1,w,1].Font.Style := [xlfsBold];
    XL.Cells[42,1,w,1].Font.Style := [xlfsBold];
    XL.Cells[1,1,w,1].Font.Size := 14;
    XL.Cells[2,1,w,1].Font.Size := 10;
    {XL.Cells[36,2,w,1].Font.Size := 10;
    XL.Cells[44,2,w,1].Font.Size := 10;}
    XL.Cells[3,c+2,w,1].HorizontalAlignment := haCenter;
    XL.Cells[5,1,1,46].HorizontalAlignment := haLeft;
    XL.Cells[29,2,w,1].HorizontalAlignment := haRight;
    XL.Cells[3,c+2,w,1].Orientation := 90;
    //Устанавливаю параметры страницы при печати ----------------------------------------------
    XL.SetPageSetupOrientation(xlpoLandscape);         //Формат листа
    XL.SetPageSetupMargines(Rect(10,10,10,10));       //Отступы полей
    //Верхние колонтитулы с заданным отступом--------------------------------------------------
    XL.SetPageSetupHeader(DateToStr(Now),'CEBEDAN, ИГД им.Д.А.Кунаева','Стр. &P из &N',1);
    //Печатаю сквозные строки/столбцы на каждой странице---------------------------------------
    XL.SetPageSetupPrintTitleRows(4,1);
    XL.SetPageSetupPrintTitleColumns(1,1);
    XL.Zoom := 100;
  finally
    XL.Free;
  end;{try}
  quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);
end;{btExcelClick}

function GetFloat(Value: Double;Index: Integer): Double;
var Str: String;
begin
  Str := Format('%.'+IntToStr(Index)+'f',[Value]);
  Result := StrToFloat(Str);
end;{GetFloat}

procedure TfmResultAddEconomParams.btCalcClick(Sender: TObject);
var RocksVm3,Selic,STyres,UdelQtn,KVsry,Vn,OriUsEco : Double;
    Vgm,Bn,Cn,Cstro,Crem,UsEco: Double;
    AId_AddEconomParam: Integer;
begin
  {Прочие текущие расходы связанные с приобретением шин и т.д., млн.тенге}
  STyres := StrToFloat(edSTyres.Text);
  {Удельные текущие затраты по горной массе, тенге}
  UdelQtn := StrToFloat(edUdelQtn.Text);
  {Коэффициент вскрыши, т/т}
  KVsry := StrToFloat(edKVsry.Text);
  quAddEconomy.Open;
  quCoef.Open;
  {Показатель плотности руды, т/м3}
  Selic := StrToFloat(edSelic.Text);
  RocksVm3 := GetFloat(StrToFloat(edRocksVm3.Text)*1000,3);
  {Годовой объем извлекаемой горной массы, получаемый по результатам моделирования, тыс.м3}
  Vgm := GetFloat(((1440/StrToFloat(edParamsShiftDuration.Text))*365*StrToFloat(edResultPeriodCoef.Text))*RocksVm3,3);
  {Показатель выхода продукта с 1 тонны руды, %}
  Bn := GetFloat(StrToFloat(edProduk.Text),3);
  {Цена на 1 тонну продукта на рынке сбыта, тыс.тенге}
  Cn := GetFloat(StrToFloat(edSenaProd.Text)*1000,3);
  {Прочие дополнительные единовременные расходы на строительство автодорог и железнодорожных
  путей, приобретение нового оборудования, строительство дополнительных съездов и т.д., млн.тенге}
  Cstro := GetFloat(StrToFloat(edStoiPrib.Text)*1000,3);
  {Сумма затрат связанная с текущими ремонтами автосамосвалов}
  Crem := GetFloat(StrToFloat(edZatSer.Text)*1000,3);
  {Прибыль, млн.тг}
  edPribil.Text := Format('%.6f',[((Vgm*Selic*Bn*Cn)/((1+KVsry)*100))/1000000]);
  {Затраты, млн.тг}
  edRashot.Text := Format('%.6f',[(Vgm*UdelQtn+STyres+Cstro+Crem)/1000000]);
  {Условный экономический эффект, млн.тг}
  UsEco := (Vgm*Selic*Bn*Cn)/((1+KVsry)*100)-(Vgm*UdelQtn+STyres+Cstro+Crem);
  edUsEcom.Text := Format('%.6f',[UsEco/1000000]);
  {Относительный экономический эффект, млн.тг}
  AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;
  quResultAddEconomParams.First;
  edOtnoEcom.Text := Format('%.6f',[(quResultAddEconomParamsUsEcom.AsFloat-StrToFloat(edUsEcom.Text))]);
  quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);
  {Объем горной массы запланированный к извлечению в рассматриваемом периоде, тыс.м3}
  Vn := StrToFloat(edQtnGM.Text)*1000;
  {Объемно ориентированный условный экономический эффект, млн.тг}
  OriUsEco := Vn*UdelQtn+Vn*(STyres/Vgm)+Cstro+Crem;
  edOriUsEcom.Text := Format('%.6f',[OriUsEco/1000000]);
end;{btCalcClick}

procedure TfmResultAddEconomParams.FormDestroy(Sender: TObject);
begin
  with fmDM do
  begin
    quResultEconomParams.Close;
    quResultAutosSummary.Close;
    quResultBlocksSummary.Close;
    quResultAddEconomParams.Close;
    quCoef.Close;
    quAddEconomy.Close;
    quRockProductivity.Close;
    quResultEconomUnLoadingPunkts.Close;
    quResultEconomParams.Close;
    quResultEconomBlocks.Close;
    quResultEconomLoadingPunkts.Close;
    quResultEconomAutos.Close;
    quUnLoadingPunkts.Close;
    quResultBlocksSummary.Close;
    quResultLoadingPunktsSummary.Close;
    quResultAutosSummary.Close;
    quResultAutosSummary.Close;
  end;{with}
end;{FormDestroy}

procedure TfmResultAddEconomParams.FormShow(Sender: TObject);
begin
  btCalc.Click;
  if fmResultAddEconomParams.edName.Tag=99 then SaveToDB(False)
  else SaveToDB(True);
  LoadValue;
end;{FormShow}

procedure TfmResultAddEconomParams.btNextClick(Sender: TObject);
begin
  quResultAddEconomParams.Next;
  LoadValue;
end;{btNextClick}

procedure TfmResultAddEconomParams.btPriorClick(Sender: TObject);
begin
  quResultAddEconomParams.Prior;
  LoadValue;
end;{btPriorClick}

procedure TfmResultAddEconomParams.btSaveClick(Sender: TObject);
var AId_AddEconomParam: Integer;
begin
  AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;
  if Application.MessageBox(PChar('Сохранить изменения в варианте '''+quResultAddEconomParamsName.AsString+'''?'),
                            'Подтверждение',MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON1)=IDYES
  then
  begin
    if Trim(edName.Text)=''
    then Application.MessageBox('Не введено значение поля "Наименование".','Ошибка',MB_ICONERROR)
    else
    if (quResultAddEconomParams.Locate('Name',edName.Text,[]))AND
       (quResultAddEconomParamsId_ResultAddEconomParam.AsInteger<>AId_AddEconomParam)
    then begin
      Application.MessageBox(PChar('Вариант с наименованием '''+edName.Text+''' уже существует.'),'Ошибка',MB_ICONERROR);
      quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);
      If edName.CanFocus then edName.SetFocus; 
    end{if}
    else begin
      quResultAddEconomParams.Edit;
      quResultAddEconomParamsName.AsString := edName.Text;
      quResultAddEconomParams.Post;
      SaveToDB(False);
    end;{else}
  end;{if}
end;{btSaveClick}

procedure TfmResultAddEconomParams.btBaseClick(Sender: TObject);
var AId_AddEconomParam,FSortIndex: Integer;
begin
  if Application.MessageBox(PChar('Установить вариант '''+edName.Text+''' как базовый'+'?'),
                            'Подтверждение',MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON1)=IDYES
  then
  begin
    FSortIndex := quResultAddEconomParamsSortIndex.AsInteger;
    AId_AddEconomParam := quResultAddEconomParamsId_ResultAddEconomParam.AsInteger;
    quResultAddEconomParams.First;
    quResultAddEconomParams.Edit;
    quResultAddEconomParamsSortIndex.AsInteger := FSortIndex;
    quResultAddEconomParams.Post;
    quResultAddEconomParams.Locate('Id_ResultAddEconomParam',AId_AddEconomParam,[]);
    quResultAddEconomParams.Edit;
    quResultAddEconomParamsSortIndex.AsInteger := 1;
    quResultAddEconomParams.Post;
    quResultAddEconomParams.Requery;
    quResultAddEconomParams.First;
    LoadValue;
  end;{if}
end;{btBaseClick}

end.


