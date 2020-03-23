unit unDM;

interface

uses
  SysUtils, Classes, DB, ADODB, Globals, esaDBDefaultParams;

type
  TfmDM = class(TDataModule)
    ADOConnection: TADOConnection;
    quAutoEngines: TADOQuery;
    dsAutoEngines: TDataSource;
    quAutoEnginesId_Engine: TAutoIncField;
    quAutoEnginesName: TWideStringField;
    quAutoEnginesNmax: TFloatField;
    quAutos: TADOQuery;
    dsAutos: TDataSource;
    quAutosId_Auto: TAutoIncField;
    quAutosName: TWideStringField;
    quAutosBodySpace: TFloatField;
    quAutosTonnage: TFloatField;
    quAutosTransmissionKind: TIntegerField;
    quAutosId_Engine: TIntegerField;
    quAutost_r: TFloatField;
    quAutosRmin: TFloatField;
    quAutosTyresCount: TIntegerField;
    quAutosALength: TFloatField;
    quAutosAWidth: TFloatField;
    quAutosAHeight: TFloatField;
    quAutosEngineName: TStringField;
    quAutosEngineNmax: TFloatField;
    quDeportAutos: TADOQuery;
    dsDeportAutos: TDataSource;
    quDeportAutosId_DeportAuto: TAutoIncField;
    quDeportAutosId_Auto: TIntegerField;
    quDeportAutosParkNo: TIntegerField;
    quDeportAutosAYear: TIntegerField;
    quDeportAutosFactTonnage: TFloatField;
    quDeportAutosWorkState: TBooleanField;
    quDeportAutosCost: TFloatField;
    quDeportAutosAmortizationRate: TFloatField;
    quDeportAutosTransmissionKPD: TFloatField;
    quDeportAutosEngineKPD: TFloatField;
    quDeportAutosTyreCost: TFloatField;
    quDeportAutosName: TStringField;
    quAutosP: TFloatField;
    quAutosTransmissionKPD: TFloatField;
    quAutoFks: TADOQuery;
    dsAutoFks: TDataSource;
    quAutoFksId_FK: TAutoIncField;
    quAutoFksId_Auto: TIntegerField;
    quAutoFksV: TFloatField;
    quAutoFksFk: TFloatField;
    quExcavatorEngines: TADOQuery;
    dsExcavatorEngines: TDataSource;
    quExcavatorEnginesId_Engine: TAutoIncField;
    quExcavatorEnginesName: TWideStringField;
    quExcavatorEnginesNmax: TFloatField;
    quExcavators: TADOQuery;
    dsExcavators: TDataSource;
    quExcavatorsId_Excavator: TAutoIncField;
    quExcavatorsName: TWideStringField;
    quExcavatorsBucketCapacity: TFloatField;
    quExcavatorsCycleTime: TFloatField;
    quExcavatorsId_Engine: TIntegerField;
    quExcavatorsEngineName: TStringField;
    quExcavatorsEngineNmax: TFloatField;
    quExcavatorsELength: TFloatField;
    quExcavatorsEWidth: TFloatField;
    quExcavatorsEHeight: TFloatField;
    quOpenpits: TADOQuery;
    dsOpenpits: TDataSource;
    quOpenpitsId_Openpit: TAutoIncField;
    quOpenpitsName: TWideStringField;
    quOpenpitsDateCreate: TDateTimeField;
    quOpenpitsNote: TWideStringField;
    quPoints: TADOQuery;
    dsPoints: TDataSource;
    quPointsId_Point: TAutoIncField;
    quPointsId_Openpit: TIntegerField;
    quAutosF: TFloatField;
    quRoadCoats: TADOQuery;
    dsRoadCoats: TDataSource;
    quRoadCoatsId_RoadCoat: TAutoIncField;
    quRoadCoatUSKs: TADOQuery;
    dsRoadCoatUSKs: TDataSource;
    quRoadCoatUSKsId_USK: TAutoIncField;
    quRoadCoatUSKsId_RoadCoat: TIntegerField;
    quRoadCoatUSKsP: TFloatField;
    quRoadCoatUSKsValueMin: TFloatField;
    quRoadCoatUSKsValueMax: TFloatField;
    quRoadCoatUSKsValue: TFloatField;
    quRoadCoatsName: TWideStringField;
    quAutosRo: TFloatField;
    quBlocks: TADOQuery;
    dsBlocks: TDataSource;
    quBlocksId_Block: TAutoIncField;
    quBlocksId_Openpit: TIntegerField;
    quBlocksStripCount: TWordField;
    quBlocksStripWidth: TFloatField;
    quBlocksId_RoadCoat: TIntegerField;
    quBlocksRoadCoat: TStringField;
    quBlockPoints: TADOQuery;
    dsBlockPoints: TDataSource;
    quBlockPointsId_BlockPoint: TAutoIncField;
    quBlockPointsId_Block: TIntegerField;
    quBlockPointsId_Point: TIntegerField;
    quBlockPointsX: TFloatField;
    quBlockPointsY: TFloatField;
    quBlockPointsZ: TFloatField;
    quPointsX: TFloatField;
    quPointsY: TFloatField;
    quPointsZ: TFloatField;
    quBlocksKind: TWordField;
    quRocks: TADOQuery;
    dsRocks: TDataSource;
    quRocksId_Rock: TAutoIncField;
    quRocksId_Openpit: TIntegerField;
    quRocksName: TWideStringField;
    quRocksIsMineralWealth: TBooleanField;
    quDeportAutosId_Openpit: TIntegerField;
    quDeportExcavators: TADOQuery;
    dsDeportExcavators: TDataSource;
    quDeportExcavatorsId_DeportExcavator: TAutoIncField;
    quDeportExcavatorsId_Openpit: TIntegerField;
    quDeportExcavatorsId_Excavator: TIntegerField;
    quDeportExcavatorsParkNo: TIntegerField;
    quDeportExcavatorsEYear: TIntegerField;
    quDeportExcavatorsWorkState: TBooleanField;
    quDeportExcavatorsCost: TFloatField;
    quDeportExcavatorsFactCycleTime: TFloatField;
    quDeportExcavatorsAddCostMaterials: TFloatField;
    quDeportExcavatorsAddCostUnAccounted: TFloatField;
    quDeportExcavatorsEngineKIM: TFloatField;
    quDeportExcavatorsEngineKPD: TFloatField;
    quDeportExcavatorsName: TStringField;
    quDeportExcavatorsTotalName: TStringField;
    quDeportAutosTotalName: TStringField;
    quDeportAutosTyresRaceRate: TFloatField;
    quLoadingPunkts: TADOQuery;
    dsLoadingPunkts: TDataSource;
    quLoadingPunktsId_LoadingPunkt: TAutoIncField;
    quLoadingPunktsId_Openpit: TIntegerField;
    quLoadingPunktsId_Point: TIntegerField;
    quLoadingPunktsId_DeportExcavator: TIntegerField;
    quLoadingPunktsDeportExcavator: TStringField;
    quUnLoadingPunkts: TADOQuery;
    dsUnLoadingPunkts: TDataSource;
    quUnLoadingPunktsId_UnloadingPunkt: TAutoIncField;
    quUnLoadingPunktsId_Openpit: TIntegerField;
    quUnLoadingPunktsId_Point: TIntegerField;
    quUnLoadingPunktRocks: TADOQuery;
    dsUnLoadingPunktRocks: TDataSource;
    quUnLoadingPunktRocksId_UnLoadingPunktRock: TAutoIncField;
    quUnLoadingPunktRocksId_UnLoadingPunkt: TIntegerField;
    quUnLoadingPunktRocksId_Rock: TIntegerField;
    quUnLoadingPunktRocksRequiredContent: TFloatField;
    quUnLoadingPunktRocksInitialContent: TFloatField;
    quUnLoadingPunktRocksInitialV1000m3: TFloatField;
    quUnLoadingPunktRocksRock: TStringField;
    quShiftPunkts: TADOQuery;
    dsShiftPunkts: TDataSource;
    quShiftPunktsId_ShiftPunkt: TAutoIncField;
    quShiftPunktsId_Openpit: TIntegerField;
    quShiftPunktsId_Point: TIntegerField;
    quCourses: TADOQuery;
    dsCourse: TDataSource;
    quCoursesId_Course: TAutoIncField;
    quCoursesId_Openpit: TIntegerField;
    quCoursesId_Point0: TIntegerField;
    quCoursesId_Point1: TIntegerField;
    quCourseBlocks: TADOQuery;
    dsCourseBlocks: TDataSource;
    quCourseBlocksId_CourseBlock: TAutoIncField;
    quCourseBlocksId_Course: TIntegerField;
    quCourseBlocksId_Block: TIntegerField;
    quOpenpitsNo: TIntegerField;
    quRoadCoatUSKsNo: TIntegerField;
    quUnLoadingPunktsMaxV1000m3: TFloatField;
    quUnLoadingPunktsAutoMaxCount: TIntegerField;
    quUnLoadingPunktsKind: TWordField;
    quLoadingPunktRocks: TADOQuery;
    quLoadingPunktRocksId_LoadingPunktRock: TAutoIncField;
    quLoadingPunktRocksId_LoadingPunkt: TIntegerField;
    quLoadingPunktRocksId_Rock: TIntegerField;
    quLoadingPunktRocksContent: TFloatField;
    quLoadingPunktRocksPlannedV1000m3: TFloatField;
    quLoadingPunktRocksRock: TStringField;
    quLoadingPunktRocksIsMineralWealth: TBooleanField;
    dsLoadingPunktRocks: TDataSource;
    quLoadingPunktRocksPlannedQ1000tn: TFloatField;
    quLoadingPunktsTotalName: TStringField;
    quLoadingPunktRocksDensityInBlock: TFloatField;
    quLoadingPunktRocksShatteringCoef: TFloatField;
    quRockProductivity: TADOQuery;
    dsRockProductivity: TDataSource;
    quRockProductivityId_LoadingPunktRock: TAutoIncField;
    quRockProductivityId_LoadingPunkt: TIntegerField;
    quRockProductivityId_Rock: TIntegerField;
    quRockProductivityDensityInBlock: TFloatField;
    quRockProductivityShatteringCoef: TFloatField;
    quRockProductivityContent: TFloatField;
    quRockProductivityPlannedV1000m3: TFloatField;
    quRockProductivityIsMineralWealth: TBooleanField;
    quRockProductivityNo: TIntegerField;
    quRockProductivityPlannedQ1000tn: TFloatField;
    quUnLoadingPunktsSKind: TStringField;
    quUnLoadingPunktRocksIsMineralWealth: TBooleanField;
    quDeportAutosId_ShiftPunkt: TIntegerField;
    quDeportAutosId_Course: TIntegerField;
    quShiftPunktsNo: TIntegerField;
    quCoursesNo: TIntegerField;
    quAutoOtherAccounts: TADOQuery;
    dsAutoOtherAccounts: TDataSource;
    quAutoOtherAccountsId_AutoOtherAccount: TAutoIncField;
    quAutoOtherAccountsId_Openpit: TIntegerField;
    quAutoOtherAccountsId_Auto: TIntegerField;
    quAutoOtherAccountsSpares: TFloatField;
    quAutoOtherAccountsGreasingSubstance: TFloatField;
    quAutoOtherAccountsMaintenanceCost: TFloatField;
    quAutoOtherAccountsSortIndex: TIntegerField;
    quAutoOtherAccountsName: TStringField;
    quRoadOtherAccounts: TADOQuery;
    dsRoadOtherAccounts: TDataSource;
    quRoadOtherAccountsId_RoadOtherAccount: TAutoIncField;
    quRoadOtherAccountsId_Openpit: TIntegerField;
    quRoadOtherAccountsId_RoadCoat: TIntegerField;
    quRoadOtherAccountsBuildingCosts: TFloatField;
    quRoadOtherAccountsKeepingCosts: TFloatField;
    quRoadOtherAccountsAmortizationNorm: TFloatField;
    quRoadOtherAccountsSortIndex: TIntegerField;
    quRoadOtherAccountsRoadCoat: TStringField;
    quAutoExcavAccordances: TADOQuery;
    quAutoExcavAccordancesId_AutoExcavAccordance: TAutoIncField;
    quAutoExcavAccordancesId_Openpit: TIntegerField;
    quAutoExcavAccordancesId_Auto: TIntegerField;
    quAutoExcavAccordancesId_Excavator: TIntegerField;
    quAutoExcavAccordancesAuto: TStringField;
    quAutoExcavAccordancesExcavator: TStringField;
    dsAutoExcavAccordances: TDataSource;
    quAutoExcavAccordancesTotalName: TStringField;
    quCoursesKind: TIntegerField;
    quOpenpitsTotalKurs: TFloatField;
    quOpenpitsTotalExpenses: TFloatField;
    quOpenpitsTotalSalaryCoef: TFloatField;
    quOpenpitsTotalShiftUsingCoefNormal: TFloatField;
    quOpenpitsTotalShiftUsingCoefDayShift: TFloatField;
    quOpenpitsTotalShiftUsingCoefExplosion: TFloatField;
    quOpenpitsTotalShiftUsingCoefExplosionCount: TIntegerField;
    quOpenpitsExcavsSalaryMashinist0: TFloatField;
    quOpenpitsExcavsSalaryMashinist1: TFloatField;
    quOpenpitsExcavsSalaryAssistant0: TFloatField;
    quOpenpitsExcavsSalaryAssistant1: TFloatField;
    quOpenpitsExcavsWorkShiftsCount: TIntegerField;
    quOpenpitsExcavsWorkShiftDuration: TFloatField;
    quOpenpitsExcavsShiftTurnoverTime: TIntegerField;
    quOpenpitsExcavsEnergyCost: TFloatField;
    quOpenpitsExcavsAmortazationNorm: TFloatField;
    quOpenpitsAutosSalary0: TFloatField;
    quOpenpitsAutosSalary1: TFloatField;
    quOpenpitsAutosWorkShiftsCount: TIntegerField;
    quOpenpitsAutosWorkShiftDuration: TFloatField;
    quOpenpitsAutosShiftTurnoverTime: TIntegerField;
    quOpenpitsAutosFuelCostWinter: TFloatField;
    quOpenpitsAutosFuelCostSummer: TFloatField;
    quOpenpitsAutosWinterMonthCount: TIntegerField;
    quOpenpitsAutosFuelCostTarif: TIntegerField;
    quOpenpitsWorkRegimeKind: TIntegerField;
    quOpenpitsWorkRegimeIsStrippingCoefUsing: TBooleanField;
    quOpenpitsParamsShiftDuration: TIntegerField;
    quOpenpitsParamsPeriodDuration: TIntegerField;
    quAutoFksNo: TIntegerField;
    quOpenpitsMinX: TFloatField;
    quOpenpitsMinY: TFloatField;
    quOpenpitsMinZ: TFloatField;
    quOpenpitsMaxX: TFloatField;
    quOpenpitsMaxY: TFloatField;
    quOpenpitsMaxZ: TFloatField;
    quResultAutosDetail: TADOQuery;
    dsResultAutos: TDataSource;
    dsResultLoadingPunkts: TDataSource;
    quResultAutosDetailId_Auto: TIntegerField;
    quResultAutosDetailParkNo: TIntegerField;
    quResultAutosDetailTyresRaceRate0: TFloatField;
    quResultAutosDetailCount0: TIntegerField;
    quResultAutosDetailTripsCount0: TIntegerField;
    quResultAutosDetailDoubleTripsCount0: TIntegerField;
    quResultAutosDetailRockVm30: TFloatField;
    quResultAutosDetailRockQtn0: TFloatField;
    quResultAutosDetailRace0: TFloatField;
    quResultAutosDetailTransDistanceSummary0: TFloatField;
    quResultAutosDetailTransDistanceWAvg0: TFloatField;
    quResultAutosDetailLiftingHeightWAvg0: TFloatField;
    quResultAutosDetailShiftRaceAvg0: TFloatField;
    quResultAutosDetailShiftTripRaceAvg0: TFloatField;
    quResultAutosDetailVavg0: TFloatField;
    quResultAutosDetailGx0: TFloatField;
    quResultAutosDetailGxWork0: TFloatField;
    quResultAutosDetailGxWaiting0: TFloatField;
    quResultAutosDetailGxLoading0: TFloatField;
    quResultAutosDetailGxUnloading0: TFloatField;
    quResultAutosDetailGxFromSP0: TFloatField;
    quResultAutosDetailGxToSP0: TFloatField;
    quResultAutosDetailGxSpecific0: TFloatField;
    quResultAutosDetailTimesWork0: TFloatField;
    quResultAutosDetailTimesWaiting0: TFloatField;
    quResultAutosDetailTimesManeuver0: TFloatField;
    quResultAutosDetailTimesLoading0: TFloatField;
    quResultAutosDetailTimesUnloading0: TFloatField;
    quResultAutosDetailTripTimeAvg0: TFloatField;
    quResultAutosDetailWorkTimeUsingRatio0: TFloatField;
    quResultAutosDetailTyresRaceAvg1000km0: TFloatField;
    quResultAutosDetailTyresAllowedCount0: TFloatField;
    quResultAutosDetailTyresCosts0: TFloatField;
    quResultAutosDetailCostsWork0: TFloatField;
    quResultAutosDetailCostsWaiting0: TFloatField;
    quResultAutosDetailCostsAmortization0: TFloatField;
    quResultAutosDetailCostsSummary0: TFloatField;
    quResultAutosDetailAutoName: TStringField;
    quResultAutosDetailName: TStringField;
    quResultAutosDetailNo: TIntegerField;
    quResultAutosModels: TADOQuery;
    quResultAutosSummary: TADOQuery;
    quResultAutosSummaryCount0: TIntegerField;
    quResultAutosSummaryTripsCount0: TFloatField;
    quResultAutosSummaryDoubleTripsCount0: TFloatField;
    quResultAutosSummaryRockVm30: TFloatField;
    quResultAutosSummaryRockQtn0: TFloatField;
    quResultAutosSummaryRace0: TFloatField;
    quResultAutosSummaryTransDistanceSummary0: TFloatField;
    quResultAutosSummaryTransDistanceWAvg0: TFloatField;
    quResultAutosSummaryLiftingHeightWAvg0: TFloatField;
    quResultAutosSummaryShiftRaceAvg0: TFloatField;
    quResultAutosSummaryShiftTripRaceAvg0: TFloatField;
    quResultAutosSummaryVavg0: TFloatField;
    quResultAutosSummaryGx0: TFloatField;
    quResultAutosSummaryGxWork0: TFloatField;
    quResultAutosSummaryGxWaiting0: TFloatField;
    quResultAutosSummaryGxLoading0: TFloatField;
    quResultAutosSummaryGxUnloading0: TFloatField;
    quResultAutosSummaryGxFromSP0: TFloatField;
    quResultAutosSummaryGxToSP0: TFloatField;
    quResultAutosSummaryGxSpecific0: TFloatField;
    quResultAutosSummaryTimesWork0: TFloatField;
    quResultAutosSummaryTimesWaiting0: TFloatField;
    quResultAutosSummaryTimesManeuver0: TFloatField;
    quResultAutosSummaryTimesLoading0: TFloatField;
    quResultAutosSummaryTimesUnloading0: TFloatField;
    quResultAutosSummaryTripTimeAvg0: TFloatField;
    quResultAutosSummaryWorkTimeUsingRatio0: TFloatField;
    quResultAutosSummaryTyresRaceAvg1000km0: TFloatField;
    quResultAutosSummaryTyresAllowedCount0: TFloatField;
    quResultAutosSummaryTyresCosts0: TFloatField;
    quResultAutosSummaryCostsWork0: TFloatField;
    quResultAutosSummaryCostsWaiting0: TFloatField;
    quResultAutosSummaryCostsAmortization0: TFloatField;
    quResultAutosSummaryCostsSummary0: TFloatField;
    quResultAutosModelsId_Auto: TIntegerField;
    quResultAutosModelsCount0: TIntegerField;
    quResultAutosModelsTripsCount0: TFloatField;
    quResultAutosModelsDoubleTripsCount0: TFloatField;
    quResultAutosModelsRockVm30: TFloatField;
    quResultAutosModelsRockQtn0: TFloatField;
    quResultAutosModelsRace0: TFloatField;
    quResultAutosModelsTransDistanceSummary0: TFloatField;
    quResultAutosModelsTransDistanceWAvg0: TFloatField;
    quResultAutosModelsLiftingHeightWAvg0: TFloatField;
    quResultAutosModelsShiftRaceAvg0: TFloatField;
    quResultAutosModelsShiftTripRaceAvg0: TFloatField;
    quResultAutosModelsVavg0: TFloatField;
    quResultAutosModelsGx0: TFloatField;
    quResultAutosModelsGxWork0: TFloatField;
    quResultAutosModelsGxWaiting0: TFloatField;
    quResultAutosModelsGxLoading0: TFloatField;
    quResultAutosModelsGxUnloading0: TFloatField;
    quResultAutosModelsGxFromSP0: TFloatField;
    quResultAutosModelsGxToSP0: TFloatField;
    quResultAutosModelsGxSpecific0: TFloatField;
    quResultAutosModelsTimesWork0: TFloatField;
    quResultAutosModelsTimesWaiting0: TFloatField;
    quResultAutosModelsTimesManeuver0: TFloatField;
    quResultAutosModelsTimesLoading0: TFloatField;
    quResultAutosModelsTimesUnloading0: TFloatField;
    quResultAutosModelsTripTimeAvg0: TFloatField;
    quResultAutosModelsWorkTimeUsingRatio0: TFloatField;
    quResultAutosModelsTyresRaceAvg1000km0: TFloatField;
    quResultAutosModelsTyresAllowedCount0: TFloatField;
    quResultAutosModelsTyresCosts0: TFloatField;
    quResultAutosModelsCostsWork0: TFloatField;
    quResultAutosModelsCostsWaiting0: TFloatField;
    quResultAutosModelsCostsAmortization0: TFloatField;
    quResultAutosModelsCostsSummary0: TFloatField;
    quResultAutosModelsNo: TIntegerField;
    quResultAutosModelsName: TStringField;
    quResultAutosSummaryTyresRaceRate0: TIntegerField;
    quResultAutosModelsTyresRaceRate0: TIntegerField;
    quResultLoadingPunktsDetail: TADOQuery;
    quResultLoadingPunktsDetailId_Excavator: TIntegerField;
    quResultLoadingPunktsDetailParkNo: TIntegerField;
    quResultLoadingPunktsDetailCount0: TIntegerField;
    quResultLoadingPunktsDetailLoadingAutosCount0: TIntegerField;
    quResultLoadingPunktsDetailRockVm30: TFloatField;
    quResultLoadingPunktsDetailRockQtn0: TFloatField;
    quResultLoadingPunktsDetailPlaneDegree0: TFloatField;
    quResultLoadingPunktsDetailEmploymentRatio0: TFloatField;
    quResultLoadingPunktsDetailTimesWork0: TFloatField;
    quResultLoadingPunktsDetailTimesWaiting0: TFloatField;
    quResultLoadingPunktsDetailTimesManeuver0: TFloatField;
    quResultLoadingPunktsDetailWorkTimeUsingRatio0: TFloatField;
    quResultLoadingPunktsDetailGx0: TFloatField;
    quResultLoadingPunktsDetailCostsWork0: TFloatField;
    quResultLoadingPunktsDetailCostsWaiting0: TFloatField;
    quResultLoadingPunktsDetailCostsAmortization0: TFloatField;
    quResultLoadingPunktsDetailCostsSummary0: TFloatField;
    quResultLoadingPunktsDetailExcavatorName: TStringField;
    quResultLoadingPunktsDetailNo: TIntegerField;
    quResultLoadingPunktsSummary: TADOQuery;
    quResultLoadingPunktsSummaryCount0: TIntegerField;
    quResultLoadingPunktsSummaryLoadingAutosCount0: TFloatField;
    quResultLoadingPunktsSummaryRockVm30: TFloatField;
    quResultLoadingPunktsSummaryRockQtn0: TFloatField;
    quResultLoadingPunktsSummaryPlaneDegree0: TFloatField;
    quResultLoadingPunktsSummaryEmploymentRatio0: TFloatField;
    quResultLoadingPunktsSummaryTimesWork0: TFloatField;
    quResultLoadingPunktsSummaryTimesWaiting0: TFloatField;
    quResultLoadingPunktsSummaryTimesManeuver0: TFloatField;
    quResultLoadingPunktsSummaryWorkTimeUsingRatio0: TFloatField;
    quResultLoadingPunktsSummaryGx0: TFloatField;
    quResultLoadingPunktsSummaryCostsWork0: TFloatField;
    quResultLoadingPunktsSummaryCostsWaiting0: TFloatField;
    quResultLoadingPunktsSummaryCostsAmortization0: TFloatField;
    quResultLoadingPunktsSummaryCostsSummary0: TFloatField;
    quResultLoadingPunktsDetailId_LoadingPunkt: TAutoIncField;
    quResultLoadingPunktRocks: TADOQuery;
    quResultLoadingPunktRocksId_LoadingPunkt: TIntegerField;
    quResultLoadingPunktRocksId_Rock: TIntegerField;
    quResultLoadingPunktRocksName: TWideStringField;
    quResultLoadingPunktsDetailName: TStringField;
    quResultAutosDetailVteh0: TFloatField;
    quResultAutosModelsVteh0: TFloatField;
    quResultAutosSummaryVteh0: TFloatField;
    quResultAutoSpeeds: TADOQuery;
    dsResultAutoSpeeds: TDataSource;
    quResultAutoSpeedsTsec: TIntegerField;
    quResultAutoSpeedsV: TFloatField;
    quResultAutoSpeedsW: TFloatField;
    quResultAutosDetailId_DeportAuto: TIntegerField;
    quResultLoadingPunktsModels: TADOQuery;
    quResultLoadingPunktsModelsId_Excavator: TIntegerField;
    quResultLoadingPunktsModelsCount0: TIntegerField;
    quResultLoadingPunktsModelsLoadingAutosCount0: TFloatField;
    quResultLoadingPunktsModelsRockVm30: TFloatField;
    quResultLoadingPunktsModelsRockQtn0: TFloatField;
    quResultLoadingPunktsModelsPlaneDegree0: TFloatField;
    quResultLoadingPunktsModelsEmploymentRatio0: TFloatField;
    quResultLoadingPunktsModelsTimesWork0: TFloatField;
    quResultLoadingPunktsModelsTimesWaiting0: TFloatField;
    quResultLoadingPunktsModelsTimesManeuver0: TFloatField;
    quResultLoadingPunktsModelsWorkTimeUsingRatio0: TFloatField;
    quResultLoadingPunktsModelsGx0: TFloatField;
    quResultLoadingPunktsModelsCostsWork0: TFloatField;
    quResultLoadingPunktsModelsCostsWaiting0: TFloatField;
    quResultLoadingPunktsModelsCostsAmortization0: TFloatField;
    quResultLoadingPunktsModelsCostsSummary0: TFloatField;
    quResultLoadingPunktsModelsName: TStringField;
    quResultLoadingPunktsModelsNo: TIntegerField;
    quResultLoadingPunktsModelsId_LoadingPunkt: TIntegerField;
    quResultLoadingPunktsSummaryId_LoadingPunkt: TIntegerField;
    dsResultLoadingPunktRocks: TDataSource;
    quResultBlocksDetail: TADOQuery;
    dsResultBlocks: TDataSource;
    quResultBlocksDetailId_Block: TIntegerField;
    quResultBlocksDetailId_RoadCoat: TIntegerField;
    quResultBlocksDetailCount0: TIntegerField;
    quResultBlocksDetailBLength0: TFloatField;
    quResultBlocksDetailRockVm30: TFloatField;
    quResultBlocksDetailRockQtn0: TFloatField;
    quResultBlocksDetailGxLoading0: TFloatField;
    quResultBlocksDetailGxUnLoading0: TFloatField;
    quResultBlocksDetailGX0: TFloatField;
    quResultBlocksDetailGxSpecific0: TFloatField;
    quResultBlocksDetailTMovingLoading0: TFloatField;
    quResultBlocksDetailTMovingUnLoading0: TFloatField;
    quResultBlocksDetailTMoving0: TFloatField;
    quResultBlocksDetailTWaitingLoading0: TFloatField;
    quResultBlocksDetailTWaitingUnLoading0: TFloatField;
    quResultBlocksDetailTWaiting0: TFloatField;
    quResultBlocksDetailEmploymentRatio0: TFloatField;
    quResultBlocksDetailVMovingLoading0: TFloatField;
    quResultBlocksDetailVMovingUnLoading0: TFloatField;
    quResultBlocksDetailVMoving0: TFloatField;
    quResultBlocksDetailAutoCountLoading0: TIntegerField;
    quResultBlocksDetailAutoCountUnLoading0: TIntegerField;
    quResultBlocksDetailAutoCount0: TIntegerField;
    quResultBlocksDetailWaitingCountLoading0: TIntegerField;
    quResultBlocksDetailWaitingCountUnLoading0: TIntegerField;
    quResultBlocksDetailWaitingCount0: TIntegerField;
    quResultBlocksDetailCostsRepair0: TFloatField;
    quResultBlocksDetailCostsAmortization0: TFloatField;
    quResultBlocksDetailCostsBuilding0: TFloatField;
    quResultBlocksDetailCosts0: TFloatField;
    quResultBlocksModels: TADOQuery;
    quResultBlocksModelsId_RoadCoat: TIntegerField;
    quResultBlocksModelsCount0: TIntegerField;
    quResultBlocksModelsBLength0: TFloatField;
    quResultBlocksModelsRockVm30: TFloatField;
    quResultBlocksModelsRockQtn0: TFloatField;
    quResultBlocksModelsGxLoading0: TFloatField;
    quResultBlocksModelsGxUnLoading0: TFloatField;
    quResultBlocksModelsGX0: TFloatField;
    quResultBlocksModelsGxSpecific0: TFloatField;
    quResultBlocksModelsTMovingLoading0: TFloatField;
    quResultBlocksModelsTMovingUnLoading0: TFloatField;
    quResultBlocksModelsTMoving0: TFloatField;
    quResultBlocksModelsTWaitingLoading0: TFloatField;
    quResultBlocksModelsTWaitingUnLoading0: TFloatField;
    quResultBlocksModelsTWaiting0: TFloatField;
    quResultBlocksModelsEmploymentRatio0: TFloatField;
    quResultBlocksModelsVMovingLoading0: TFloatField;
    quResultBlocksModelsVMovingUnLoading0: TFloatField;
    quResultBlocksModelsVMoving0: TFloatField;
    quResultBlocksModelsAutoCountLoading0: TFloatField;
    quResultBlocksModelsAutoCountUnLoading0: TFloatField;
    quResultBlocksModelsAutoCount0: TFloatField;
    quResultBlocksModelsWaitingCountLoading0: TFloatField;
    quResultBlocksModelsWaitingCountUnLoading0: TFloatField;
    quResultBlocksModelsWaitingCount0: TFloatField;
    quResultBlocksModelsCostsRepair0: TFloatField;
    quResultBlocksModelsCostsAmortization0: TFloatField;
    quResultBlocksModelsCostsBuilding0: TFloatField;
    quResultBlocksModelsCosts0: TFloatField;
    quResultBlocksSummary: TADOQuery;
    quResultBlocksSummaryCount0: TIntegerField;
    quResultBlocksSummaryBLength0: TFloatField;
    quResultBlocksSummaryRockVm30: TFloatField;
    quResultBlocksSummaryRockQtn0: TFloatField;
    quResultBlocksSummaryGxLoading0: TFloatField;
    quResultBlocksSummaryGxUnLoading0: TFloatField;
    quResultBlocksSummaryGX0: TFloatField;
    quResultBlocksSummaryGxSpecific0: TFloatField;
    quResultBlocksSummaryTMovingLoading0: TFloatField;
    quResultBlocksSummaryTMovingUnLoading0: TFloatField;
    quResultBlocksSummaryTMoving0: TFloatField;
    quResultBlocksSummaryTWaitingLoading0: TFloatField;
    quResultBlocksSummaryTWaitingUnLoading0: TFloatField;
    quResultBlocksSummaryTWaiting0: TFloatField;
    quResultBlocksSummaryEmploymentRatio0: TFloatField;
    quResultBlocksSummaryVMovingLoading0: TFloatField;
    quResultBlocksSummaryVMovingUnLoading0: TFloatField;
    quResultBlocksSummaryVMoving0: TFloatField;
    quResultBlocksSummaryAutoCountLoading0: TFloatField;
    quResultBlocksSummaryAutoCountUnLoading0: TFloatField;
    quResultBlocksSummaryAutoCount0: TFloatField;
    quResultBlocksSummaryWaitingCountLoading0: TFloatField;
    quResultBlocksSummaryWaitingCountUnLoading0: TFloatField;
    quResultBlocksSummaryWaitingCount0: TFloatField;
    quResultBlocksSummaryCostsRepair0: TFloatField;
    quResultBlocksSummaryCostsAmortization0: TFloatField;
    quResultBlocksSummaryCostsBuilding0: TFloatField;
    quResultBlocksSummaryCosts0: TFloatField;
    quResultBlocksDetailNo: TIntegerField;
    quResultBlocksDetailShortName: TStringField;
    quResultBlocksModelsNo: TIntegerField;
    quResultBlocksModelsShortName: TStringField;
    quResultBlocksModelsRate: TFloatField;
    quResultBlocksDetailRate: TFloatField;
    quResultBlocksDetailGxSpecificLoading0: TFloatField;
    quResultBlocksDetailGxSpecificUnLoading0: TFloatField;
    quResultBlocksModelsGxSpecificLoading0: TFloatField;
    quResultBlocksModelsGxSpecificUnLoading0: TFloatField;
    quResultBlocksDetailTSpecificUnLoading0: TFloatField;
    quResultBlocksDetailTSpecificLoading0: TFloatField;
    quResultBlocksDetailTSpecific0: TFloatField;
    quResultUnLoadingPunkts: TADOQuery;
    dsResultUnLoadingPunkts: TDataSource;
    quLoadingPunktsZ: TFloatField;
    quUnLoadingPunktsZ: TFloatField;
    quUnLoadingPunktsTotalName: TStringField;
    quOpenpitsParamsIsAccumulateData: TBooleanField;
    quOpenpitsParamsAnimationTimeScale: TIntegerField;
    quResultUnLoadingPunktsId_UnLoadingPunkt: TIntegerField;
    quResultUnLoadingPunktsEmploymentTime: TFloatField;
    quResultUnLoadingPunktsEmploymentRatio: TFloatField;
    quResultUnLoadingPunktsUnLoadingAutosCount: TFloatField;
    quResultUnLoadingPunktsRockVm3: TFloatField;
    quResultUnLoadingPunktsRockQtn: TFloatField;
    quResultUnLoadingPunktsMaxV1000m3: TFloatField;
    quResultUnLoadingPunktsBunkerRatio: TFloatField;
    quResultUnLoadingPunktsZ: TFloatField;
    quResultUnLoadingPunktsNo: TIntegerField;
    quResultUnLoadingPunktsName: TStringField;
    quResultUnLoadingPunktsKind: TWordField;
    quResultUnLoadingPunktRocks: TADOQuery;
    dsResultUnLoadingPunktRocks: TDataSource;
    quResultUnLoadingPunktRocksId_UnLoadingPunktRock: TIntegerField;
    quResultUnLoadingPunktRocksId_UnLoadingPunkt: TIntegerField;
    quResultUnLoadingPunktRocksUnLoadingAutosCount: TIntegerField;
    quResultUnLoadingPunktRocksRockVm3: TFloatField;
    quResultUnLoadingPunktRocksRockQtn: TFloatField;
    quResultUnLoadingPunktRocksContent: TFloatField;
    quResultUnLoadingPunktRocksRequiredContent: TFloatField;
    quResultUnLoadingPunktRocksDContent: TFloatField;
    quResultUnLoadingPunktRocksName: TWideStringField;
    quResultUnLoadingPunktRocksNo: TIntegerField;
    quOpenpitsResultStrippingCoef: TFloatField;
    quResultLoadingPunktsDetailGrnt: TFloatField;
    quResultEconomBlocks: TADOQuery;
    quResultEconomBlocksCostsRepair: TFloatField;
    quResultEconomBlocksCostsAmortization: TFloatField;
    quResultEconomBlocksCostsSummary: TFloatField;
    quResultEconomUnLoadingPunkts: TADOQuery;
    quResultEconomUnLoadingPunktsId_UnLoadingPunkt: TIntegerField;
    quResultEconomUnLoadingPunktsRockVm3: TFloatField;
    quResultEconomUnLoadingPunktsRockQtn: TFloatField;
    quResultEconomLoadingPunkts: TADOQuery;
    quResultEconomLoadingPunktsCostsWork: TFloatField;
    quResultEconomLoadingPunktsCostsWaiting: TFloatField;
    quResultEconomLoadingPunktsCostsAmortization: TFloatField;
    quResultEconomLoadingPunktsCostsSummary: TFloatField;
    quResultEconomAutos: TADOQuery;
    quResultEconomAutosTyresCosts: TFloatField;
    quResultEconomAutosCostsWork: TFloatField;
    quResultEconomAutosCostsWaiting: TFloatField;
    quResultEconomAutosCostsAmortization: TFloatField;
    quResultEconomAutosCostsSummary: TFloatField;
    quResultEconomParams: TADOQuery;
    quResultEconomParamsId_Openpit: TAutoIncField;
    quResultEconomParamsTotalKurs: TFloatField;
    quResultEconomParamsTotalExpenses: TFloatField;
    quResultEconomParamsTotalExpensesUSD: TFloatField;
    quResultEconomParamsBlocksCostsRepair: TFloatField;
    quResultEconomParamsBlocksCostsRepairUSD: TFloatField;
    quResultEconomParamsBlocksCostsAmortization: TFloatField;
    quResultEconomParamsBlocksCostsAmortizationUSD: TFloatField;
    quResultEconomParamsBlocksCostsSummary: TFloatField;
    quResultEconomParamsBlocksCostsSummaryUSD: TFloatField;
    quResultEconomParamsExcavsCostsWork: TFloatField;
    quResultEconomParamsExcavsCostsWorkUSD: TFloatField;
    quResultEconomParamsExcavsCostsWaiting: TFloatField;
    quResultEconomParamsExcavsCostsWaitingUSD: TFloatField;
    quResultEconomParamsExcavsCostsAmortization: TFloatField;
    quResultEconomParamsExcavsCostsAmortizationUSD: TFloatField;
    quResultEconomParamsExcavsCostsSummary: TFloatField;
    quResultEconomParamsExcavsCostsSummaryUSD: TFloatField;
    quResultEconomParamsAutosCostsWork: TFloatField;
    quResultEconomParamsAutosCostsWorkUSD: TFloatField;
    quResultEconomParamsAutosCostsWaiting: TFloatField;
    quResultEconomParamsAutosCostsWaitingUSD: TFloatField;
    quResultEconomParamsAutosCostsAmortization: TFloatField;
    quResultEconomParamsAutosCostsAmortizationUSD: TFloatField;
    quResultEconomParamsAutosCostsSummary: TFloatField;
    quResultEconomParamsAutosCostsSummaryUSD: TFloatField;
    quResultEconomParamsTotalCostsSummary: TFloatField;
    quResultEconomParamsTotalCostsSummaryUSD: TFloatField;
    quResultEconomParamsTotalCostsAmortization: TFloatField;
    quResultEconomParamsTotalCostsAmortizationUSD: TFloatField;
    quResultEconomParamsTotalCostsExpenses: TFloatField;
    quResultEconomParamsTotalCostsExpensesUSD: TFloatField;
    quResultEconomParamsRockVm3: TFloatField;
    quResultEconomParamsRockQtn: TFloatField;
    quResultEconomParamsTotalUdCostsSummary0: TFloatField;
    quResultEconomParamsTotalUdCostsSummary0USD: TFloatField;
    quResultEconomParamsTotalUdCostsSummary1: TFloatField;
    quResultEconomParamsTotalUdCostsSummary1USD: TFloatField;
    quResultEconomParamsTotalUdCostsAmortization0: TFloatField;
    quResultEconomParamsTotalUdCostsAmortization0USD: TFloatField;
    quResultEconomParamsTotalUdCostsAmortization1: TFloatField;
    quResultEconomParamsTotalUdCostsAmortization1USD: TFloatField;
    quResultEconomParamsTotalUdCostsCurrent0: TFloatField;
    quResultEconomParamsTotalUdCostsCurrent0USD: TFloatField;
    quResultEconomParamsTotalUdCostsCurrent1: TFloatField;
    quResultEconomParamsTotalUdCostsCurrent1USD: TFloatField;
    dsResultEconomParams: TDataSource;
    quResultEconomParamsDistribution: TADOQuery;
    dsResultEconomParamsDistribution: TDataSource;
    quResultEconomParamsDistributionId: TIntegerField;
    quResultEconomParamsDistributionCostsExpluatation: TFloatField;
    quResultEconomParamsDistributionCostsAmortization: TFloatField;
    quResultEconomParamsDistributionCostsSummary: TFloatField;
    quResultEconomParamsDistributionArticle: TWideStringField;
    quShiftPunktsName: TStringField;
    quShiftPunktsZ: TFloatField;
    quDeportAutosShiftPunkt: TWideStringField;
    quDeportAutosCourse: TWideStringField;
    quResultUnLoadingPunktContents: TADOQuery;
    dsResultUnLoadingPunktContents: TDataSource;
    quResultUnLoadingPunktContentsTsec: TIntegerField;
    quResultUnLoadingPunktContentsC: TFloatField;
    quAutoEnginesSortIndex: TIntegerField;
    quAutosSortIndex: TIntegerField;
    quExcavatorEnginesSortIndex: TIntegerField;
    quExcavatorsSortIndex: TIntegerField;
    quDeportAutosSortIndex: TIntegerField;
    quDeportExcavatorsSortIndex: TIntegerField;
    quRocksSortIndex: TIntegerField;
    quLoadingPunktsSortIndex: TIntegerField;
    quLoadingPunktRocksSortIndex: TIntegerField;
    quLoadingPunktsGrnt: TStringField;
    quUnLoadingPunktsSortIndex: TIntegerField;
    quUnLoadingPunktRocksSortIndex: TIntegerField;
    quResultLoadingPunktRocksSortIndex: TIntegerField;
    quRoadCoatsSortIndex: TIntegerField;
    quRoadCoatsShortName: TWideStringField;
    quResultBlocksDetailName: TStringField;
    quResultBlocksModelsName: TStringField;
    quOpenpitsResultTnaryadSec: TIntegerField;
    quResultEconomParamsResultTnaryadSec: TIntegerField;
    quOpenpitsResultPeriodCoef: TFloatField;
    quResultEconomParamsDistributionName: TStringField;
    quBlocksLoadingVmax: TFloatField;
    quBlocksUnLoadingVmax: TFloatField;
    quAutosStrQtn: TStringField;
    quDeportAutosNetPtn: TFloatField;
    quDeportAutosTransmissionNetKPD: TFloatField;
    quDeportAutosTransmissionKind: TIntegerField;
    quDeportAutosNetUnloadingTsec: TFloatField;
    quDeportAutosNetRm: TFloatField;
    quDeportAutosNetTyresCount: TIntegerField;
    quDeportAutosEngine: TStringField;
    quDeportAutosEngineNetNkvt: TFloatField;
    quDeportAutosNetBalanceC1000tg: TFloatField;
    quDeportAutosLm: TFloatField;
    quDeportAutosWm: TFloatField;
    quDeportAutosHm: TFloatField;
    quDeportAutosNetQtn: TFloatField;
    quDeportAutosBodyHeapVm3: TFloatField;
    Query: TADOQuery;
    quAutosNote: TMemoField;
    quExcavatorsNote: TMemoField;
    quDeportAutosAmortizationKind: TIntegerField;
    quAdisCourses: TADOQuery;
    quAdisPoints: TADOQuery;
    ADOSebadan: TADOCommand;
    quDeportExcavatorsSENAmortizationRate: TFloatField;
    quAutosBalanceC1000tg: TFloatField;
    procedure quAutosTransmissionKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quAutosTransmissionKindSetText(Sender: TField;
      const Text: String);
    procedure quRoadCoatUSKsCalcFields(DataSet: TDataSet);
    procedure quRocksIsMineralWealthGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quDeportExcavatorsCalcFields(DataSet: TDataSet);
    procedure quDeportExcavatorsWorkStateGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quUnLoadingPunktsKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quLoadingPunktRocksIsMineralWealthGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quLoadingPunktRocksCalcFields(DataSet: TDataSet);
    procedure quLoadingPunktsCalcFields(DataSet: TDataSet);
    procedure quRocksIsMineralWealthSetText(Sender: TField;
      const Text: String);
    procedure quUnLoadingPunktsCalcFields(DataSet: TDataSet);
    procedure quDeportAutosCalcFields(DataSet: TDataSet);
    procedure quOpenpitsAutosFuelCostTarifGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quOpenpitsAutosFuelCostTarifSetText(Sender: TField;
      const Text: String);
    procedure quAutoExcavAccordancesCalcFields(DataSet: TDataSet);
    procedure quOpenpitsWorkRegimeKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure quOpenpitsWorkRegimeKindSetText(Sender: TField;
      const Text: String);
    procedure quResultAutosDetailCalcFields(DataSet: TDataSet);
    procedure quResultLoadingPunktsDetailCalcFields(DataSet: TDataSet);
    procedure quResultBlocksDetailCalcFields(DataSet: TDataSet);
    procedure quResultUnLoadingPunktsCalcFields(DataSet: TDataSet);
    procedure quResultUnLoadingPunktRocksCalcFields(DataSet: TDataSet);
    procedure quResultEconomBlocksCalcFields(DataSet: TDataSet);
    procedure quResultEconomParamsCalcFields(DataSet: TDataSet);
    procedure quShiftPunktsCalcFields(DataSet: TDataSet);
    procedure quAutoOtherAccountsCalcFields(DataSet: TDataSet);
    procedure quOpenpitsCalcFields(DataSet: TDataSet);
    procedure quResultEconomParamsDistributionCalcFields(
      DataSet: TDataSet);
    procedure quAutoFksCalcFields(DataSet: TDataSet);
    procedure quAutosCalcFields(DataSet: TDataSet);
    procedure quDeportAutosAmortizationKindSetText(Sender: TField;
      const Text: String);
    procedure quDeportAutosAmortizationKindGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
  private
  
  public
  end;{TfmDM}

var
  fmDM: TfmDM;
  DefaultParams: TDBDefaultParams;
//Сжатие и восстановление базы данных MS Access 1997,2000 -------------------
function esaPackMicrosoftAccess1997_2000Database(const ASource: String; const ADest: String; const APassword: String): Boolean;
implementation

{$R *.dfm}
uses Variants, JRO_TLB, Math;

//Сжатие и восстановление базы данных MS Access 1997,2000 -------------------
//Важно:
// 1. Включить ссылку на модуль JRO_TLB в список используемых модулей.
// 2. Во время сжатия база данных должна быть закрыта.
// 3. Если компилятор ругается на модуль JRO_TLB, то должны быть выполнены следующие действия:
//    3.1. Зайти в "Среда Delphi -> Главное меню -> Project -> Import Type Library".
//    3.2. Выбрать в списке "Microsoft Jet and Replication Objects 2.1 Library".
//    3.3. Кликнуть по кнопке Install
//    3.4. Перекомпилировать Ваш проект
function esaPackMicrosoftAccess1997_2000Database(const ASource: String; const ADest: String; const APassword: String): Boolean;
const sProvider = 'Provider=Microsoft.Jet.OLEDB.4.0;';
var
  oJetEng          : JetEngine; //jet-
  ATemp            : String;    //Имя файла БД-адресата
  ASourceConnection: String;    //Строка соединения для БД-источника
  ADestConnection  : String;    //Строка соединения для БД-адресата
begin
  try
    if ADest<>''
    then ATemp := ADest
    else ATemp := ChangeFileExt(ASource,'.$$$');
    ASourceConnection   := sProvider + 'Data Source=' + ASource;
    ADestConnection     := sProvider + 'Data Source=' + ATemp;
    if APassword<>'' then//Если задан пароль
    begin
      ASourceConnection := ASourceConnection + ';Jet OLEDB:Database Password=' + APassword;
      ADestConnection   := ADestConnection + ';Jet OLEDB:Database Password=' + APassword;
    end;{if}
    DeleteFile(ATemp);
    oJetEng   := CoJetEngine.Create;
    oJetEng.CompactDatabase(ASourceConnection, ADestConnection);
    if ADest='' then //Если выходная БД не указана
    begin
      DeleteFile(PChar(ASource));
      RenameFile(PChar(ATemp),PChar(ASource));
    end;{if}
    Result    := True;
  finally
    oJetEng := nil;
  end;{try}
end;{esaPackMicrosoftAccess1997_2000Database}

procedure TfmDM.quAutosTransmissionKindGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.AsString <> '' then
  case Sender.AsInteger of
    0: Text := 'ГМ';
    1: Text := 'ЭМ';
    else Text := '';
  end{case}
  else Text := '';
end;{quAutosTransmissionKindGetText}
procedure TfmDM.quAutosTransmissionKindSetText(Sender: TField; const Text: String);
begin
  if Text='ГМ'
  then Sender.AsInteger := 0
  else
  if Text='ЭМ'
  then Sender.AsInteger := 1;
end;{quAutosTransmissionKindSetText}
procedure TfmDM.quRoadCoatUSKsCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  DataSet.FieldByName('Value').AsFloat := (DataSet.FieldByName('ValueMin').AsFloat+
                                           DataSet.FieldByName('ValueMax').AsFloat)*0.5;
end;{quRoadCoatUSKsCalcFields}
procedure TfmDM.quRocksIsMineralWealthGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.AsVariant=null
  then Text := ''
  else
    if Sender.AsBoolean
    then Text := 'Полезное ископаемое'
    else Text := 'Пустая порода';
end;{quRocksIsMineralWealthGetText}
procedure TfmDM.quRocksIsMineralWealthSetText(Sender: TField;
  const Text: String);
begin
  if Text=''
  then Sender.AsVariant := null
  else Sender.AsBoolean := Text='Полезное ископаемое';
end;{quRocksIsMineralWealthSetText}
procedure TfmDM.quDeportExcavatorsCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('TotalName').AsString :=
    Format('%s (№%0.2d)',
    [DataSet.FieldByName('Name').AsString,DataSet.FieldByName('ParkNo').AsInteger]);
end;{quDeportExcavatorsCalcFields}
procedure TfmDM.quDeportExcavatorsWorkStateGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.FieldName='WorkState' then
    if Sender.AsBoolean then Text := '+' else Text := '-';
end;{quDeportExcavatorsWorkStateGetText}
procedure TfmDM.quUnLoadingPunktsKindGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender=quUnLoadingPunktsKind then
    case Sender.AsInteger of
      0: Text := 'Фабрика';
      1: Text := 'Перегрузочный склад';
      2: Text := 'Отвал';
    else Text := '?';
    end;{case}
end;{quUnLoadingPunktsKindGetText}
procedure TfmDM.quLoadingPunktRocksIsMineralWealthGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.AsVariant=null then Text := ''
  else
  if Sender.AsBoolean then Text := 'Да' else Text := 'Нет';
end;{quLoadingPunktRocksIsMineralWealthGetText}
procedure TfmDM.quLoadingPunktRocksCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('PlannedQ1000tn').AsFloat :=
    Dataset.FieldByName('PlannedV1000m3').AsFloat*
    Dataset.FieldByName('DensityInBlock').AsFloat;
end;{quLoadingPunktRocksCalcFields}
procedure TfmDM.quLoadingPunktsCalcFields(DataSet: TDataSet);
begin
  if quLoadingPunktsZ.AsFloat<0.0
  then quLoadingPunktsGrnt.AsString := Format('%.1f м',[quLoadingPunktsZ.AsFloat])
  else quLoadingPunktsGrnt.AsString := Format('+%.1f м',[quLoadingPunktsZ.AsFloat]);
  quLoadingPunktsTotalName.AsString :=
    Format('%s (%s)',[quLoadingPunktsDeportExcavator.AsString,quLoadingPunktsGrnt.AsString]);
end;{quLoadingPunktsCalcFields}
procedure TfmDM.quUnLoadingPunktsCalcFields(DataSet: TDataSet);
begin
  case Dataset.FieldByName('Kind').AsInteger of
    0: Dataset.FieldByName('SKind').AsString := 'Фабрика';
    1: Dataset.FieldByName('SKind').AsString := 'П.Cклад';
    2: Dataset.FieldByName('SKind').AsString := 'Отвал  ';
  else Dataset.FieldByName('SKind').AsString := '';
  end;{case}
  if quUnLoadingPunktsZ.AsFloat<0.0
  then quUnLoadingPunktsTotalName.AsString :=
         Format('%s (%.1f м)',[quUnLoadingPunktsSKind.AsString,
                                   quUnLoadingPunktsZ.AsFloat])
  else quUnLoadingPunktsTotalName.AsString :=
         Format('%s (+%.1f м)',[quUnLoadingPunktsSKind.AsString,
                                    quUnLoadingPunktsZ.AsFloat]);
end;{quUnLoadingPunktsCalcFields}

procedure TfmDM.quDeportAutosCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('TotalName').AsString :=
    Format('%s (№%.2d)',[DataSet.FieldByName('Name').AsString,
                        DataSet.FieldByName('ParkNo').AsInteger]);
end;{quDeportAutosCalcFields}

procedure TfmDM.quAutoExcavAccordancesCalcFields(DataSet: TDataSet);
begin
  if (quAutoExcavAccordancesAuto.AsString<>'')and(quAutoExcavAccordancesExcavator.AsString<>'')
  then quAutoExcavAccordancesTotalName.AsString := quAutoExcavAccordancesAuto.AsString+' - '+
                                                   quAutoExcavAccordancesExcavator.AsString
  else quAutoExcavAccordancesTotalName.AsString := '';
end;

procedure TfmDM.quOpenpitsAutosFuelCostTarifGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  case Sender.AsInteger of
    0: Text := 'по зимнему тарифу';
    1: Text := 'по летнему тарифу';
  else Text := 'по среднему значению';
  end;{case}
end;{quOpenpitsAutosFuelCostTarifGetText}
procedure TfmDM.quOpenpitsAutosFuelCostTarifSetText(Sender: TField;
  const Text: String);
begin
  if Text='по зимнему тарифу'
  then Sender.AsInteger := 0
  else
  if Text='по летнему тарифу'
  then Sender.AsInteger := 1
  else Sender.AsInteger := 2;
end;{quOpenpitsAutosFuelCostTarifSetText}

procedure TfmDM.quOpenpitsWorkRegimeKindGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  case Sender.AsInteger of
    0: Text := 'Усреднение качества';
    1: Text := 'Равномерное распределение по пунктам погрузки';
  else Text := '';
  end;{case}
end;{quOpenpitsWorkRegimeKindGetText}

procedure TfmDM.quOpenpitsWorkRegimeKindSetText(Sender: TField;
  const Text: String);
begin
  if Text='Усреднение качества'
  then Sender.AsInteger := 0
  else
  if Text='Равномерное распределение по пунктам погрузки'
  then Sender.AsInteger := 1
  else Sender.AsVariant := Null;
end;

procedure TfmDM.quResultAutosDetailCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  DataSet.FieldByName('Name').AsString :=
    Format('%s (№%.2d)',
    [DataSet.FieldByName('AutoName').AsString,DataSet.FieldByName('ParkNo').AsInteger]);
end;{quResultAutosCalcFields}

procedure TfmDM.quResultLoadingPunktsDetailCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  DataSet.FieldByName('Name').AsString := DataSet.FieldByName('ExcavatorName').AsString+' (№'+
                                          DataSet.FieldByName('ParkNo').AsString+ ')';
end;{quResultExcavatorsDetailCalcFields}

procedure TfmDM.quResultBlocksDetailCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  if quResultBlocksSummary.Active and (quResultBlocksSummaryBLength0.AsFloat>0.0)
  then Dataset.FieldByName('Rate').AsFloat :=
    Dataset.FieldByName('BLength0').AsFloat/
    quResultBlocksSummaryBLength0.AsFloat*100
  else Dataset.FieldByName('Rate').AsFloat := 0.0;
end;{quResultBlocksDetailCalcFields}

procedure TfmDM.quResultUnLoadingPunktsCalcFields(DataSet: TDataSet);
var Z: Single;
begin
  Z := quResultUnLoadingPunktsZ.AsFloat;
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  case quResultUnLoadingPunktsKind.AsInteger of
    0: quResultUnLoadingPunktsName.AsString := Format('Фабрика Гор.%.1f м',[Z]);
    1: quResultUnLoadingPunktsName.AsString := Format('Перегрузочный склад Гор.%.1f м',[Z]);
    2: quResultUnLoadingPunktsName.AsString := Format('Отвал Гор.%.1f м',[Z]);
    else quResultUnLoadingPunktsName.AsString := '';
  end;{case}
  if quResultUnLoadingPunktsMaxV1000m3.AsFloat>0.0
  then quResultUnLoadingPunktsBunkerRatio.AsFloat :=
         quResultUnLoadingPunktsRockVm3.AsFloat/quResultUnLoadingPunktsMaxV1000m3.AsFloat
  else quResultUnLoadingPunktsBunkerRatio.AsFloat := 0.0;
end;{quResultUnLoadingPunktsCalcFields}

procedure TfmDM.quResultUnLoadingPunktRocksCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  quResultUnLoadingPunktRocksDContent.AsFloat :=
    quResultUnLoadingPunktRocksRequiredContent.AsFloat-
    quResultUnLoadingPunktRocksContent.AsFloat;
end;{quResultUnLoadingPunktRocksCalcFields}

procedure TfmDM.quResultEconomBlocksCalcFields(DataSet: TDataSet);
begin
  quResultEconomBlocksCostsSummary.AsFloat := quResultEconomBlocksCostsAmortization.AsFloat+
                                               quResultEconomBlocksCostsRepair.AsFloat;
end;{quResultEconomBlocksCalcFields}

procedure TfmDM.quResultEconomParamsCalcFields(DataSet: TDataSet);
var USD: Single;
begin
  USD := quResultEconomParamsTotalKurs.AsFloat;
  quResultEconomParamsBlocksCostsRepair.AsFloat := quResultEconomBlocksCostsRepair.AsFloat;
  quResultEconomParamsBlocksCostsAmortization.AsFloat := quResultEconomBlocksCostsAmortization.AsFloat;
  quResultEconomParamsBlocksCostsSummary.AsFloat := quResultEconomBlocksCostsSummary.AsFloat;
  quResultEconomParamsExcavsCostsWork.AsFloat := quResultEconomLoadingPunktsCostsWork.AsFloat;
  quResultEconomParamsExcavsCostsWaiting.AsFloat := quResultEconomLoadingPunktsCostsWaiting.AsFloat;
  quResultEconomParamsExcavsCostsAmortization.AsFloat := quResultEconomLoadingPunktsCostsAmortization.AsFloat;
  quResultEconomParamsExcavsCostsSummary.AsFloat := quResultEconomLoadingPunktsCostsSummary.AsFloat;
  quResultEconomParamsAutosCostsWork.AsFloat := quResultEconomAutosCostsWork.AsFloat;
  quResultEconomParamsAutosCostsWaiting.AsFloat := quResultEconomAutosCostsWaiting.AsFloat;
  quResultEconomParamsAutosCostsAmortization.AsFloat := quResultEconomAutosCostsAmortization.AsFloat;
  quResultEconomParamsAutosCostsSummary.AsFloat := quResultEconomAutosCostsSummary.AsFloat;

  quResultEconomParamsTotalCostsSummary.AsFloat      := quResultEconomParamsExcavsCostsWork.AsFloat+
                                                        quResultEconomParamsExcavsCostsWaiting.AsFloat+
                                                        quResultEconomParamsAutosCostsWork.AsFloat+
                                                        quResultEconomParamsAutosCostsWaiting.AsFloat+
                                                        quResultEconomParamsBlocksCostsRepair.AsFloat;
  quResultEconomParamsTotalCostsAmortization.AsFloat := quResultEconomParamsExcavsCostsAmortization.AsFloat+
                                                        quResultEconomParamsAutosCostsAmortization.AsFloat+
                                                        quResultEconomParamsBlocksCostsAmortization.AsFloat;
  quResultEconomParamsTotalCostsExpenses.AsFloat     := (quResultEconomParamsResultTnaryadSec.AsFloat/60)*
                                                         quResultEconomParamsTotalExpenses.AsFloat*1000/
                                                        (365*24*60);
  quResultEconomParamsRockVm3.AsFloat                := quResultEconomUnLoadingPunktsRockVm3.AsFloat;
  quResultEconomParamsRockQtn.AsFloat                := quResultEconomUnLoadingPunktsRockQtn.AsFloat;
  if quResultEconomParamsRockVm3.AsFloat>0.0 then
  begin
    quResultEconomParamsTotalUdCostsSummary0.AsFloat := (quResultEconomParamsTotalCostsSummary.AsFloat+
                                                         quResultEconomParamsTotalCostsExpenses.AsFloat)/
                                                         quResultEconomParamsRockVm3.AsFloat;
    quResultEconomParamsTotalUdCostsAmortization0.AsFloat := quResultEconomParamsTotalCostsAmortization.AsFloat/
                                                         quResultEconomParamsRockVm3.AsFloat;
    quResultEconomParamsTotalUdCostsCurrent0.AsFloat := (quResultEconomParamsTotalCostsSummary.AsFloat+
                                                         quResultEconomParamsTotalCostsAmortization.AsFloat+
                                                         quResultEconomParamsTotalCostsExpenses.AsFloat)/
                                                         quResultEconomParamsRockVm3.AsFloat;
  end;{if}
  if quResultEconomParamsRockQtn.AsFloat>0.0 then
  begin
    quResultEconomParamsTotalUdCostsSummary1.AsFloat := (quResultEconomParamsTotalCostsSummary.AsFloat+
                                                         quResultEconomParamsTotalCostsExpenses.AsFloat)/
                                                         quResultEconomParamsRockQtn.AsFloat;
    quResultEconomParamsTotalUdCostsAmortization1.AsFloat := quResultEconomParamsTotalCostsAmortization.AsFloat/
                                                         quResultEconomParamsRockQtn.AsFloat;
    quResultEconomParamsTotalUdCostsCurrent1.AsFloat := (quResultEconomParamsTotalCostsSummary.AsFloat+
                                                   quResultEconomParamsTotalCostsAmortization.AsFloat+
                                                   quResultEconomParamsTotalCostsExpenses.AsFloat)/
                                                   quResultEconomParamsRockQtn.AsFloat;
  end;{if}
  if USD>0.0 then
  begin
    quResultEconomParamsBlocksCostsRepairUSD.AsFloat := quResultEconomParamsBlocksCostsRepair.AsFloat/USD;
    quResultEconomParamsBlocksCostsAmortizationUSD.AsFloat := quResultEconomParamsBlocksCostsAmortization.AsFloat/USD;
    quResultEconomParamsBlocksCostsSummaryUSD.AsFloat := quResultEconomParamsBlocksCostsSummary.AsFloat/USD;
    quResultEconomParamsExcavsCostsWorkUSD.AsFloat := quResultEconomParamsExcavsCostsWork.AsFloat/USD;
    quResultEconomParamsExcavsCostsWaitingUSD.AsFloat := quResultEconomParamsExcavsCostsWaiting.AsFloat/USD;
    quResultEconomParamsExcavsCostsAmortizationUSD.AsFloat := quResultEconomParamsExcavsCostsAmortization.AsFloat/USD;
    quResultEconomParamsExcavsCostsSummaryUSD.AsFloat := quResultEconomParamsExcavsCostsSummary.AsFloat/USD;
    quResultEconomParamsAutosCostsWorkUSD.AsFloat := quResultEconomParamsAutosCostsWork.AsFloat/USD;
    quResultEconomParamsAutosCostsWaitingUSD.AsFloat := quResultEconomParamsAutosCostsWaiting.AsFloat/USD;
    quResultEconomParamsAutosCostsAmortizationUSD.AsFloat := quResultEconomParamsAutosCostsAmortization.AsFloat/USD;
    quResultEconomParamsAutosCostsSummaryUSD.AsFloat := quResultEconomParamsAutosCostsSummary.AsFloat/USD;
    quResultEconomParamsTotalCostsSummaryUSD.AsFloat := quResultEconomParamsTotalCostsSummary.AsFloat/USD;
    quResultEconomParamsTotalCostsAmortizationUSD.AsFloat := quResultEconomParamsTotalCostsAmortization.AsFloat/USD;
    quResultEconomParamsTotalCostsExpensesUSD.AsFloat := quResultEconomParamsTotalCostsExpenses.AsFloat/USD;
    quResultEconomParamsTotalUdCostsSummary0USD.AsFloat := quResultEconomParamsTotalUdCostsSummary0.AsFloat/USD;
    quResultEconomParamsTotalUdCostsAmortization0USD.AsFloat := quResultEconomParamsTotalUdCostsAmortization0.AsFloat/USD;
    quResultEconomParamsTotalUdCostsCurrent0USD.AsFloat := quResultEconomParamsTotalUdCostsCurrent0.AsFloat/USD;
    quResultEconomParamsTotalUdCostsSummary0USD.AsFloat := quResultEconomParamsTotalUdCostsSummary0.AsFloat/USD;
    quResultEconomParamsTotalUdCostsAmortization0USD.AsFloat := quResultEconomParamsTotalUdCostsAmortization0.AsFloat/USD;
    quResultEconomParamsTotalUdCostsCurrent0USD.AsFloat := quResultEconomParamsTotalUdCostsCurrent0.AsFloat/USD;
    quResultEconomParamsTotalUdCostsSummary1USD.AsFloat := quResultEconomParamsTotalUdCostsSummary1.AsFloat/USD;
    quResultEconomParamsTotalUdCostsAmortization1USD.AsFloat := quResultEconomParamsTotalUdCostsAmortization1.AsFloat/USD;
    quResultEconomParamsTotalUdCostsCurrent1USD.AsFloat := quResultEconomParamsTotalUdCostsCurrent1.AsFloat/USD;
    quResultEconomParamsTotalUdCostsSummary1USD.AsFloat := quResultEconomParamsTotalUdCostsSummary1.AsFloat/USD;
    quResultEconomParamsTotalUdCostsAmortization1USD.AsFloat := quResultEconomParamsTotalUdCostsAmortization1.AsFloat/USD;
    quResultEconomParamsTotalUdCostsCurrent1USD.AsFloat := quResultEconomParamsTotalUdCostsCurrent1.AsFloat/USD;
  end;{if}
end;{quResultEconomParamsCalcFields}

procedure TfmDM.quShiftPunktsCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
  if Dataset.FieldByName('Z').AsFloat<0.0
  then Dataset.FieldByName('Name').AsString :=
         Format('ППС №%d (%.1f)',[Dataset.FieldByName('No').AsInteger,
                                  Dataset.FieldByName('Z').AsFloat])
  else Dataset.FieldByName('Name').AsString :=
         Format('ППС №%d (+%.1f)',[Dataset.FieldByName('No').AsInteger,
                                   Dataset.FieldByName('Z').AsFloat]);
end;{quShiftPunktsCalcFields}

procedure TfmDM.quAutoOtherAccountsCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('SortIndex').AsInteger := abs(DataSet.RecNo);
end;{quAutoOtherAccountsCalcFields}

procedure TfmDM.quOpenpitsCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
end;{quOpenpitsCalcFields}

procedure TfmDM.quResultEconomParamsDistributionCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('Name').AsString := Dataset.FieldByName('Article').AsString;
end;{quResultEconomParamsDistributionCalcFields}

procedure TfmDM.quAutoFksCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('No').AsInteger := abs(Dataset.RecNo);
end;{quAutoFksCalcFields}

procedure TfmDM.quAutosCalcFields(DataSet: TDataSet);
begin
  if not quAutosTonnage.IsNull
  then quAutosStrQtn.AsString := FormatFloat('0.0 т',quAutosTonnage.AsFloat)
  else quAutosStrQtn.AsString := '';
end;{quAutosCalcFields}

procedure TfmDM.quDeportAutosAmortizationKindSetText(Sender: TField; const Text: String);
begin
  if (Text='0')or(Text='Годовая норма амортизации')or(Text='годовая')
  then Sender.AsInteger := 0 else
  if (Text='1')or(Text='Норма амортизации на тыс.км')or(Text='тыс.км')
  then Sender.AsInteger := 1
  else Sender.Clear;
end;{quDeportAutosAmortizationKindSetText}

procedure TfmDM.quDeportAutosAmortizationKindGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.AsString='0' then Text := 'годовая'else
  if Sender.AsString='1' then Text := 'тыс.км'
  else Text := '';
end;{quDeportAutosAmortizationKindGetText}

end.

