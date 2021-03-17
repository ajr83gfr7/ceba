{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
program CebadanAuto;



uses
  Forms,
  SysUtils,
  unOpenpitEditor in 'Units300Tools\unOpenpitEditor.pas' {fmOpenpitEditor},
  esaDBDefaultParams in 'Units000Common\esaDBDefaultParams.pas',
  esaDBNavigators in 'Units000Common\esaDBNavigators.pas',
  esaGLScene2D in 'Units000Common\esaGLScene2D.pas',
  unDM in 'unDM.pas' {fmDM: TDataModule},
  Globals in 'Units000Common\Globals.pas',
  unOpenpitTools in 'Units300Tools\unOpenpitTools.pas' {fmOpenpitTools},
  unRun in 'Units400Results\unRun.pas' {fmRun},
  ExcelEditors in 'Units000Common\ExcelEditors.pas',
  unMain in 'unMain.pas' {fmMain},
  unOpenpitCreate in 'Units100File\unOpenpitCreate.pas' {fmOpenpitCreate},
  unAutoModelEngineDefaults in 'Units200NSI\unAutoModelEngineDefaults.pas' {fmAutoModelEngineDefaults},
  unAutoModelEngines in 'Units200NSI\unAutoModelEngines.pas' {fmAutoModelEngines},
  unAutoModelDefaults in 'Units200NSI\unAutoModelDefaults.pas' {fmAutoModelDefaults},
  unAutoModels in 'Units200NSI\unAutoModels.pas' {fmAutoModels},
  unExcavatorModelEngineDefaults in 'Units200NSI\unExcavatorModelEngineDefaults.pas' {fmExcavatorModelEngineDefaults},
  unExcavatorModelEngines in 'Units200NSI\unExcavatorModelEngines.pas' {fmExcavatorModelEngines},
  unExcavatorModelDefaults in 'Units200NSI\unExcavatorModelDefaults.pas' {fmExcavatorModelDefaults},
  unExcavatorModels in 'Units200NSI\unExcavatorModels.pas' {fmExcavatorModels},
  unRoadCoats in 'Units200NSI\unRoadCoats.pas' {fmRoadCoats},
  unAutoDefaults in 'Units300Tools\unAutoDefaults.pas' {fmAutoDefaults},
  unAutos in 'Units300Tools\unAutos.pas' {fmAutos},
  unExcavatorDefaults in 'Units300Tools\unExcavatorDefaults.pas' {fmExcavatorDefaults},
  unExcavators in 'Units300Tools\unExcavators.pas' {fmExcavators},
  unRockDefaults in 'Units300Tools\unRockDefaults.pas' {fmRockDefaults},
  unRocks in 'Units300Tools\unRocks.pas' {fmRocks},
  unOpenpitBound in 'Units300Tools\unOpenpitBound.pas' {fmOpenpitBound},
  esaDBOpenpitObjects in 'Units000Common\esaDBOpenpitObjects.pas',
  esaOpenGL2D in 'Units000Common\esaOpenGL2D.pas',
  esaDBOpenpitUklons in 'Units000Common\esaDBOpenpitUklons.pas' {fmOpenpitUklons},
  unUnLoadingPunkts in 'Units300Tools\unUnLoadingPunkts.pas' {fmUnLoadingPunkts},
  unUnLoadingPunktDefaults in 'Units300Tools\unUnLoadingPunktDefaults.pas' {fmUnLoadingPunktDefaults},
  unProductivity in 'Units300Tools\unProductivity.pas' {fmProductivity},
  unProductivityDefaults in 'Units300Tools\unProductivityDefaults.pas' {fmProductivityDefaults},
  unAutoPlacing in 'Units300Tools\unAutoPlacing.pas' {fmAutoPlacing},
  unAdditionalParams in 'Units300Tools\unAdditionalParams.pas' {fmAdditionalParams},
  esaRunObjects in 'Units000Common\esaRunObjects.pas',
  esaAydarTest in 'Units000Common\esaAydarTest.pas' {fmAydarTest},
  unResultGraphView in 'Units400Results\unResultGraphView.pas' {fmResultGraphView},
  unAbout in 'Units500Help\unAbout.pas' {fmAbout},
  unOpenpitView3D in 'Units300Tools\unOpenpitView3D.pas' {fmOpenpitView3D},
  esaGLSceneOpenpitObjects in 'Units000Common\esaGLSceneOpenpitObjects.pas',
  esaModelingResults in 'esaModelingResults.pas',
  unResultShiftProductionCapacities in 'Units400Results\unResultShiftProductionCapacities.pas' {fmResultShiftProductionCapacities},
  esaExcelEditors in 'Units000Common\esaExcelEditors.pas',
  unResultShiftBlocks in 'Units400Results\unResultShiftBlocks.pas' {fmResultShiftBlocks},
  unResultShiftAutos in 'Units400Results\unResultShiftAutos.pas' {fmResultShiftAutos},
  unResultShiftExcavators in 'Units400Results\unResultShiftExcavators.pas' {fmResultShiftExcavators},
  unResultShiftProportionality in 'Units400Results\unResultShiftProportionality.pas' {fmResultShiftProportionality},
  unResultEconomParams in 'Units400Results\unResultEconomParams.pas' {fmResultEconomParams},
  unResultEconomParamsDistributation in 'Units400Results\unResultEconomParamsDistributation.pas' {fmResultEconomParamsDistributation},
  esaConstants in 'Units000Common\esaConstants.pas',
  unResultShiftUnLoadingPunkts in 'Units400Results\unResultShiftUnLoadingPunkts.pas' {fmResultShiftUnLoadingPunkts},
  unResultTechnologicParams in 'Units400Results\unResultTechnologicParams.pas' {fmResultTechnologicParams},
  esaResultVariants in 'Units000Common\esaResultVariants.pas',
  unVariants in 'Units400Results\unVariants.pas' {fmVariants},
  unVariantGraphics in 'Units400Results\unVariantGraphics.pas' {fmVariantGraphics},
  esaGlobals in 'Units000Common\esaGlobals.pas',
  esaMessages in 'Units000Common\esaMessages.pas',
  esaDialogs in 'Units000Common\esaDialogs.pas',
  esaInputValueDlgs in 'Units000Common\esaInputValueDlgs.pas' {fmInputValueDlg},
  esaMath in 'Units000Common\esaMath.pas',
  esaDb in 'Units000Common\esaDb.pas',
  unResultShift in 'Units400Results\unResultShift.pas' {fmResultShift},
  JRO_TLB in '..\Program Files\Borland\Delphi7\Imports\JRO_TLB.pas',
  StartFromAdis in 'StartFromAdis.pas' {Form1},
  TXTWriter in 'DebugUnit\TXTWriter.pas',
  unResultAutoSpeeds in 'Units400Results\unResultAutoSpeeds.pas' {fmResultAutoSpeeds},
  unResultBlocksFunctioning in 'Units400Results\unResultBlocksFunctioning.pas' {fmResultBlocksFunctioning},
  unResultBlocksPowerConsuming in 'Units400Results\unResultBlocksPowerConsuming.pas' {fmResultBlocksPowerConsuming},
  unDialogAddEconomParams in 'AddEconomParams\unDialogAddEconomParams.pas' {fmDialogAddEconomParams},
  unResultAddEconomParams in 'AddEconomParams\unResultAddEconomParams.pas' {fmResultAddEconomParams},
  unResultEconomEffect in 'Units400Results\unResultEconomEffect.pas' {fmResultEconomEffect},
  unExcel in 'Units000Common\unExcel.pas',
  unResultEconomEffect_Excel in 'Units400Results\unResultEconomEffect_Excel.pas',
  unResultEconomEffect_Data in 'Units400Results\unResultEconomEffect_Data.pas',
  unResultEconomEffect_Const in 'Units400Results\unResultEconomEffect_Const.pas',
  EconomicModule in 'Units000Common\EconomicModule.pas',
  EconomicResultVariant in 'Units400Results\EconomicResultVariant.pas',
  unResultEconomParams_Excel in 'Units400Results\unResultEconomParams_Excel.pas';

begin
  Application.Initialize;
  Application.HelpFile := 'CebadanAuto.HLP';
  Application.Title := 'Программно-функциональный комплекс "Cebadan-Auto, II"';
  esaShowSplashDlg();
  Application.CreateForm(TfmDM, fmDM);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmResultShift, fmResultShift);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfmResultEconomEffect, fmResultEconomEffect);
  Application.Run;
  FreeAndNil(fmAbout);
end.

