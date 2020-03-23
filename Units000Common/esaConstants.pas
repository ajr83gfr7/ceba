unit esaConstants;
{
������ �������� ���������� �������� ���������� ����������� �������������
������� �.�.
18/09/2007
}
interface
type
  ResaKeyParams = record
    No : Integer;
    IsChangeable: Boolean;
    Key: String;
  end;{ResaKeyParams}
const
  //�������������� ����������
  CesaAutosQuantity             : ResaKeyParams = (No:100; IsChangeable:False; Key:'�������������� ����������');
  CesaAutosAutosCount           : ResaKeyParams = (No:101; IsChangeable:False; Key:'���������� ��������������');
  CesaAutosTripsCount           : ResaKeyParams = (No:102; IsChangeable:True;  Key:'���������� ������');
  CesaAutosTripsCountNulled     : ResaKeyParams = (No:103; IsChangeable:True;  Key:' - � ������� �����������');
  CesaAutosTripsCountLoading    : ResaKeyParams = (No:104; IsChangeable:True;  Key:' - � �������� �����������');
  CesaAutosTripsCountUnLoading  : ResaKeyParams = (No:105; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaAutosRock                 : ResaKeyParams = (No:106; IsChangeable:False; Key:'������������ ������ �����');
  CesaAutosRockVm3              : ResaKeyParams = (No:107; IsChangeable:True;  Key:' - �����, �3');
  CesaAutosRockQtn              : ResaKeyParams = (No:108; IsChangeable:True;  Key:' - ���, �');
  CesaAutosSkm                  : ResaKeyParams = (No:109; IsChangeable:True;  Key:'������, ��');
  CesaAutosSkmNulled            : ResaKeyParams = (No:110; IsChangeable:True;  Key:' - � ������� �����������');
  CesaAutosSkmLoading           : ResaKeyParams = (No:111; IsChangeable:True;  Key:' - � �������� ����������� (��������� �����������������)');
  CesaAutosSkmUnLoading         : ResaKeyParams = (No:112; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaAutosLoadingSkm           : ResaKeyParams = (No:113; IsChangeable:True;  Key:'��������� �����������������, ��');
  CesaAutosLoadingWAvgSkm       : ResaKeyParams = (No:114; IsChangeable:False; Key:' - ����������������');
  CesaAutosLoadingAvgSkm        : ResaKeyParams = (No:115; IsChangeable:False; Key:' - �������');
  CesaAutosWAvgHm               : ResaKeyParams = (No:116; IsChangeable:False; Key:'���������������� ������ ������� ������ �����, �');
  CesaAutosShiftAvgSkm1          : ResaKeyParams = (No:117; IsChangeable:False; Key:'������������� ������ ������ �������������, ��');
  CesaAutosShiftAvgSkm_reis     : ResaKeyParams = (No:118; IsChangeable:False; Key:'������������� ������ ������ �������������, ��/����');
  CesaAutosAvgVkmh              : ResaKeyParams = (No:119; IsChangeable:False; Key:'������� �������� ��������, ��/�');
  CesaAutosAvgVkmhNulled        : ResaKeyParams = (No:120; IsChangeable:False; Key:' - � ������� �����������');
  CesaAutosAvgVkmhLoading       : ResaKeyParams = (No:121; IsChangeable:False; Key:' - � �������� �����������');
  CesaAutosAvgVkmhUnLoading     : ResaKeyParams = (No:122; IsChangeable:False; Key:' - � ������������ �����������');
  CesaAutosAvgTechVkmh          : ResaKeyParams = (No:123; IsChangeable:False; Key:'����������������� �������� ��������, ��/�');
  //������ �������
  CesaAutosFuel                 : ResaKeyParams = (No:200; IsChangeable:False; Key:'���������� ������� �������');
  CesaAutosGx                   : ResaKeyParams = (No:201; IsChangeable:True;  Key:'����� ������ �������, �');
  CesaAutosGxWork               : ResaKeyParams = (No:202; IsChangeable:True;  Key:' - � ������, �');
  CesaAutosGxWaiting            : ResaKeyParams = (No:203; IsChangeable:True;  Key:' - � �������, �');
  CesaAutosDirGx                : ResaKeyParams = (No:204; IsChangeable:True;  Key:'����� ������ ������� �� ������������, �');
  CesaAutosGxNulled             : ResaKeyParams = (No:205; IsChangeable:True;  Key:' - � ������� �����������');
  CesaAutosGxLoading            : ResaKeyParams = (No:206; IsChangeable:True;  Key:' - � �������� �����������');
  CesaAutosGxUnLoading          : ResaKeyParams = (No:207; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaAutosUdGx_gr_tkm          : ResaKeyParams = (No:208; IsChangeable:False; Key:'�������� ������ �������, �/���');
  CesaAutosGxCtg                : ResaKeyParams = (No:209; IsChangeable:True;  Key:'������� �� �������, ��');
  //�����
  CesaAutosWorkTime             : ResaKeyParams = (No:300; IsChangeable:False; Key:'���������� ������������� �������� �������');
  CesaAutosTmin                 : ResaKeyParams = (No:301; IsChangeable:True;  Key:'����� �����, ���');
  CesaAutosTminMoving           : ResaKeyParams = (No:302; IsChangeable:True;  Key:' - � ��������');
  CesaAutosTminWaiting          : ResaKeyParams = (No:303; IsChangeable:True;  Key:' - � �������');
  CesaAutosTminManevr           : ResaKeyParams = (No:304; IsChangeable:True;  Key:' - � �������');
  CesaAutosTminOnLoading        : ResaKeyParams = (No:305; IsChangeable:True;  Key:' - ��� ���������');
  CesaAutosTminOnUnLoading      : ResaKeyParams = (No:306; IsChangeable:True;  Key:' - ��� ����������');
  CesaAutosDirTmin              : ResaKeyParams = (No:307; IsChangeable:True;  Key:'����� ����� �� ������������, ���');
  CesaAutosTminNulled           : ResaKeyParams = (No:308; IsChangeable:True;  Key:' - � ������� �����������');
  CesaAutosTminLoading          : ResaKeyParams = (No:309; IsChangeable:True;  Key:' - � �������� �����������');
  CesaAutosTminUnLoading        : ResaKeyParams = (No:310; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaAutosReysAvgTmin          : ResaKeyParams = (No:311; IsChangeable:False; Key:'������� ����� �����, ���');
  CesaAutosReysAvgTminNulled    : ResaKeyParams = (No:312; IsChangeable:False; Key:' - � ������� �����������');
  CesaAutosReysAvgTminLoading   : ResaKeyParams = (No:313; IsChangeable:False; Key:' - � �������� �����������');
  CesaAutosReysAvgTminUnLoading : ResaKeyParams = (No:314; IsChangeable:False; Key:' - � ������������ �����������');
  CesaAutosAvgTimeUsingCoef     : ResaKeyParams = (No:315; IsChangeable:False; Key:'������� ����������� ������������� �������� �������');
  //����
  CesaAutosTyres                : ResaKeyParams = (No:400; IsChangeable:False; Key:'���������� ������� ���');
  CesaAutosTyresCount           : ResaKeyParams = (No:401; IsChangeable:False; Key:'���������� ��� �������������');
  CesaAutosTyresAmortizationR1000km: ResaKeyParams = (No:402; IsChangeable:False; Key:'����� ������� ���, ���.��');
  CesaAutosTyreC1000tg          : ResaKeyParams = (No:403; IsChangeable:False; Key:'��������� 1� ����, ���.��');
  CesaAutosTyresS1000km         : ResaKeyParams = (No:404; IsChangeable:True;  Key:'������� ������ ���, ���.��');
  CesaAutosUsedTyresCount       : ResaKeyParams = (No:405; IsChangeable:True;  Key:'���������� ��������������� ���, ��');
  CesaAutosTyresCtg             : ResaKeyParams = (No:406; IsChangeable:True;  Key:'������� �� ����, ��');
  //����������� ���������
  CesaAutosCosts                   : ResaKeyParams = (No:500; IsChangeable:False; Key:'��������� ����������');
  CesaAutosWorkCtg                 : ResaKeyParams = (No:501; IsChangeable:True;  Key:'������� � ��������� ������, ��');
  CesaAutosWorkSumGxCtg            : ResaKeyParams = (No:502; IsChangeable:True;  Key:' - �������');
  CesaAutosWorkSumTyresCtg         : ResaKeyParams = (No:503; IsChangeable:True;  Key:' - ����');
  CesaAutosWorkSparesCtg           : ResaKeyParams = (No:504; IsChangeable:True;  Key:' - �������� � ���������');
  CesaAutosWorkMaterialsCtg        : ResaKeyParams = (No:505; IsChangeable:True;  Key:' - ��������� ���������');
  CesaAutosWorkMaintenancesCtg     : ResaKeyParams = (No:506; IsChangeable:True;  Key:' - ���������� ���������� ���������');
  CesaAutosWorkSalariesCtg         : ResaKeyParams = (No:507; IsChangeable:True;  Key:' - ���������� �����');
  CesaAutosWaitingCtg              : ResaKeyParams = (No:508; IsChangeable:True;  Key:'������� � ��������� �������, ��');
  CesaAutosWaitingSumGxCtg         : ResaKeyParams = (No:509; IsChangeable:True;  Key:' - �������');
  CesaAutosWaitingSparesCtg        : ResaKeyParams = (No:510; IsChangeable:True;  Key:' - �������� � ���������');
  CesaAutosWaitingMaterialsCtg     : ResaKeyParams = (No:511; IsChangeable:True;  Key:' - ��������� ���������');
  CesaAutosWaitingMaintenancesCtg  : ResaKeyParams = (No:512; IsChangeable:True;  Key:' - ���������� ���������� ���������');
  CesaAutosWaitingSalariesCtg      : ResaKeyParams = (No:513; IsChangeable:True;  Key:' - ���������� �����');
  CesaAutosAmortizationCtg         : ResaKeyParams = (No:514; IsChangeable:True;  Key:'�������� ��������������� ������, ��');
  CesaAutosCtg                     : ResaKeyParams = (No:515; IsChangeable:True;  Key:'��������� �������, ��');

  //�������������� ����������
  CesaExcavsQuantity            : ResaKeyParams = (No:100; IsChangeable:False; Key:'�������������� ����������');
  CesaExcavsExcavatorsCount     : ResaKeyParams = (No:101; IsChangeable:False; Key:'���������� ������������');
  CesaExcavsLoadingAutosCount   : ResaKeyParams = (No:102; IsChangeable:True;  Key:'���������� ����������� ��������������');
  CesaExcavsRockPlanVm3         : ResaKeyParams = (No:103; IsChangeable:True;  Key:'�������� ����� ������ �����, �3');
  CesaExcavsRockVm3             : ResaKeyParams = (No:104; IsChangeable:True;  Key:'����� ���������� ������ �����, �3');
  CesaExcavsRockQtn             : ResaKeyParams = (No:105; IsChangeable:True;  Key:'��� ���������� ������ �����, �');
  CesaExcavsPlanRockRatio       : ResaKeyParams = (No:106; IsChangeable:False; Key:'������� ���������� �����, %');
  //������ �������
  CesaExcavsFuel                : ResaKeyParams = (No:200; IsChangeable:False; Key:'���������� ������� �������');
  CesaExcavsGx                  : ResaKeyParams = (No:201; IsChangeable:True;  Key:'����� ������ ��������������, ���');
  CesaExcavsGxWork              : ResaKeyParams = (No:202; IsChangeable:True;  Key:' - � ������');
  CesaExcavsGxWaiting           : ResaKeyParams = (No:203; IsChangeable:True;  Key:' - � �������');
  //�����
  CesaExcavsTime                : ResaKeyParams = (No:300; IsChangeable:False; Key:'���������� ������������� �������� �������');
  CesaExcavsTmin                : ResaKeyParams = (No:301; IsChangeable:True;  Key:'����� �����, ���');
  CesaExcavsTminWork            : ResaKeyParams = (No:302; IsChangeable:True;  Key:'����� � ������, ���');
  CesaExcavsTminWaiting         : ResaKeyParams = (No:303; IsChangeable:True;  Key:'����� � �������, ���');
  CesaExcavsTminManevr          : ResaKeyParams = (No:304; IsChangeable:True;  Key:'����� � �������, ���');
  CesaExcavsUsingPunktCoef      : ResaKeyParams = (No:305; IsChangeable:False; Key:'����������� ��������� ������� ��������');
  CesaExcavsUsingTimeCoef       : ResaKeyParams = (No:306; IsChangeable:False; Key:'����������� ������������� �������� �������');
  //����������� ���������
  CesaExcavsCosts                  : ResaKeyParams = (No:400; IsChangeable:False; Key:'��������� ����������');
  CesaExcavsWorkCtg                : ResaKeyParams = (No:401; IsChangeable:True;  Key:'������� � ������, ��');
  CesaExcavsWorkSumGxCtg           : ResaKeyParams = (No:402; IsChangeable:True;  Key:' - ��������������');
  CesaExcavsWorkMaterialsCtg       : ResaKeyParams = (No:403; IsChangeable:True;  Key:' - ���������');
  CesaExcavsWorkUnAccountedCtg     : ResaKeyParams = (No:404; IsChangeable:True;  Key:' - ���������� �������');
  CesaExcavsWorkSalariesCtg        : ResaKeyParams = (No:405; IsChangeable:True;  Key:' - ���������� �����');
  CesaExcavsWaitingCtg             : ResaKeyParams = (No:406; IsChangeable:True;  Key:'������� � �������, �� (+�������)');
  CesaExcavsWaitingSumGxCtg        : ResaKeyParams = (No:407; IsChangeable:True;  Key:' - ��������������');
  CesaExcavsWaitingMaterialsCtg    : ResaKeyParams = (No:408; IsChangeable:True;  Key:' - ���������');
  CesaExcavsWaitingUnAccountedCtg  : ResaKeyParams = (No:409; IsChangeable:True;  Key:' - ���������� �������');
  CesaExcavsWaitingSalariesCtg     : ResaKeyParams = (No:410; IsChangeable:True;  Key:' - ���������� �����');
  CesaExcavsAmortizationCtg        : ResaKeyParams = (No:411; IsChangeable:True;  Key:'�������� ��������������� ������, ��');
  CesaExcavsCtg                    : ResaKeyParams = (No:412; IsChangeable:True;  Key:'��������� �������, ��');

  //�������������� ����������
  CesaBlocksQuantity               : ResaKeyParams = (No:100; IsChangeable:False; Key:'�������������� ����������');
  CesaBlocksBlocksCount            : ResaKeyParams = (No:101; IsChangeable:False; Key:'���������� ����-��������');
  CesaBlocksLm                     : ResaKeyParams = (No:102; IsChangeable:False; Key:'�����, �');
  CesaBlocksRock                   : ResaKeyParams = (No:103; IsChangeable:False; Key:'������������ ������ �����, �3');
  CesaBlocksRockVm3                : ResaKeyParams = (No:104; IsChangeable:True;  Key:' - �����, �3');
  CesaBlocksRockQtn                : ResaKeyParams = (No:105; IsChangeable:True;  Key:' - ���, �');
  CesaBlocksAutosCount             : ResaKeyParams = (No:106; IsChangeable:True;  Key:'���������� ��������� ��������������');
  CesaBlocksAutosCountNulled       : ResaKeyParams = (No:107; IsChangeable:True;  Key:'  - � ������� �����������');
  CesaBlocksAutosCountLoading      : ResaKeyParams = (No:108; IsChangeable:True;  Key:'  - � �������� �����������');
  CesaBlocksAutosCountUnLoading    : ResaKeyParams = (No:109; IsChangeable:True;  Key:'  - � ������������ �����������');
  CesaBlocksWaitingsCount          : ResaKeyParams = (No:110; IsChangeable:True;  Key:'���������� �������� ��������� ��������������');
  CesaBlocksWaitingsCountNulled    : ResaKeyParams = (No:111; IsChangeable:True;  Key:'  - � ������� �����������');
  CesaBlocksWaitingsCountLoading   : ResaKeyParams = (No:112; IsChangeable:True;  Key:'  - � �������� �����������');
  CesaBlocksWaitingsCountUnLoading : ResaKeyParams = (No:113; IsChangeable:True;  Key:'  - � ������������ �����������');
  CesaBlocksAvgVkmh                : ResaKeyParams = (No:114; IsChangeable:False; Key:'������� �������� �������� ��������� ��������������, ��/�');
  CesaBlocksAvgVkmhNulled          : ResaKeyParams = (No:115; IsChangeable:False; Key:'  - � ������� �����������');
  CesaBlocksAvgVkmhLoading         : ResaKeyParams = (No:116; IsChangeable:False; Key:'  - � �������� �����������');
  CesaBlocksAvgVkmhUnLoading       : ResaKeyParams = (No:117; IsChangeable:False; Key:'  - � ������������ �����������');
  //���������� ������������� �������� �������
  CesaBlocksTime                   : ResaKeyParams = (No:200; IsChangeable:False; Key:'���������� ������������� �������� �������');
  CesaBlocksMovingAvgTmin          : ResaKeyParams = (No:201; IsChangeable:False; Key:'������� ����� �������� ��������� ��������������, ���');
  CesaBlocksMovingAvgTminNulled    : ResaKeyParams = (No:202; IsChangeable:False; Key:'  - � ������� �����������');
  CesaBlocksMovingAvgTminLoading   : ResaKeyParams = (No:203; IsChangeable:False; Key:'  - � �������� �����������');
  CesaBlocksMovingAvgTminUnLoading : ResaKeyParams = (No:204; IsChangeable:False; Key:'  - � ������������ �����������');
  CesaBlocksWaitingAvgTmin         : ResaKeyParams = (No:205; IsChangeable:False; Key:'������� ����� �������� ��������� ��������������, ���');
  CesaBlocksWaitingAvgTminNulled   : ResaKeyParams = (No:206; IsChangeable:True;  Key:'  - � ������� �����������');
  CesaBlocksWaitingAvgTminLoading  : ResaKeyParams = (No:207; IsChangeable:False; Key:'  - � �������� �����������');
  CesaBlocksWaitingAvgTminUnLoadung: ResaKeyParams = (No:208; IsChangeable:False; Key:'  - � ������������ �����������');
  CesaBlocksEmploymentCoef         : ResaKeyParams = (No:209; IsChangeable:False; Key:'����������� ���������');
  //���������� ������� �������
  CesaBlocksFuel                   : ResaKeyParams = (No:300; IsChangeable:False; Key:'���������� ������� �������');
  CesaBlocksGx                     : ResaKeyParams = (No:301; IsChangeable:True;  Key:'������ ������� ��������� ��������������, �');
  CesaBlocksGxNulled               : ResaKeyParams = (No:302; IsChangeable:True;  Key:'  - � ������� �����������');
  CesaBlocksGxLoading              : ResaKeyParams = (No:303; IsChangeable:True;  Key:'  - � �������� �����������');
  CesaBlocksGxUnLoading            : ResaKeyParams = (No:304; IsChangeable:True;  Key:'  - � ������������ �����������');
  CesaBlocksUdGx_l_m               : ResaKeyParams = (No:305; IsChangeable:False; Key:'�������� ������ �������, �/�');
  //����������� ���������
  CesaBlocksCosts                  : ResaKeyParams = (No:400; IsChangeable:False; Key:'����������� ����������');
  CesaBlocksRepairCtg              : ResaKeyParams = (No:401; IsChangeable:True;  Key:'������� �� �����������, ��');
  CesaBlocksAmortizationCtg        : ResaKeyParams = (No:402; IsChangeable:True;  Key:'��������������� ����������, ��');
  CesaBlocksBuildingCtg            : ResaKeyParams = (No:403; IsChangeable:True;  Key:'������� �� �������������, ��');
  CesaBlocksCtg                    : ResaKeyParams = (No:404; IsChangeable:True;  Key:'��������� �������, ��');

  CesaEconomAutos               : ResaKeyParams = (No:100; IsChangeable:False; Key:'������� �� ��������������');
  CesaEconomWorkCtg0            : ResaKeyParams = (No:101; IsChangeable:True;  Key:'������� � ������');
  CesaEconomWaitingCtg0         : ResaKeyParams = (No:102; IsChangeable:True;  Key:'������� � �������');
  CesaEconomAmortizationCtg0    : ResaKeyParams = (No:103; IsChangeable:True;  Key:'��������������� ����������');
  CesaEconomCtg0                : ResaKeyParams = (No:104; IsChangeable:True;  Key:'��������� �������');
  CesaEconomExcavs              : ResaKeyParams = (No:200; IsChangeable:False; Key:'������� �� ������������');
  CesaEconomWorkCtg1            : ResaKeyParams = (No:201; IsChangeable:True;  Key:'������� � ������');
  CesaEconomWaitingCtg1         : ResaKeyParams = (No:202; IsChangeable:True;  Key:'������� � �������');
  CesaEconomAmortizationCtg1    : ResaKeyParams = (No:203; IsChangeable:True;  Key:'��������������� ����������');
  CesaEconomCtg1                : ResaKeyParams = (No:204; IsChangeable:True;  Key:'��������� �������');
  CesaEconomBlocks              : ResaKeyParams = (No:300; IsChangeable:False; Key:'������� �� ����-��������');
  CesaEconomRepairCtg2          : ResaKeyParams = (No:301; IsChangeable:True;  Key:'������� �� �����������');
  CesaEconomAmortizationCtg2    : ResaKeyParams = (No:302; IsChangeable:True;  Key:'��������������� ����������');
  CesaEconomCtg2                : ResaKeyParams = (No:303; IsChangeable:True;  Key:'��������� �������');
  CesaEconomSummary             : ResaKeyParams = (No:400; IsChangeable:False; Key:'��������� ����������');
  CesaEconomCtg                 : ResaKeyParams = (No:401; IsChangeable:True;  Key:'������� �� �����-������������� ���������');
  CesaEconomExpluationCtg       : ResaKeyParams = (No:402; IsChangeable:True;  Key:'  ��������������� �������');
  CesaEconomAmortizationCtg     : ResaKeyParams = (No:403; IsChangeable:True;  Key:'  ��������������� ����������');
  CesaEconomExpensesCtg         : ResaKeyParams = (No:404; IsChangeable:True;  Key:'  ���������� � ���������� �������');
  CesaEconomRockVm3             : ResaKeyParams = (No:405; IsChangeable:True;  Key:'������������������ ��������� �� ������ �����, �3');
  CesaEconomRockQtn             : ResaKeyParams = (No:406; IsChangeable:True;  Key:'������������������ ��������� �� ������ �����, �');
  CesaEconomUdExpluationCtgm3   : ResaKeyParams = (No:407; IsChangeable:False; Key:'�������� ��������������� ������� �� ������� ������ ����� (�� 1 �3)');
  CesaEconomUdExpluationCtgtn   : ResaKeyParams = (No:408; IsChangeable:False; Key:'�������� ��������������� ������� �� ������� ������ ����� (�� 1 �)');
  CesaEconomUdAmortizationCtgm3 : ResaKeyParams = (No:409; IsChangeable:False; Key:'�������� ��������������� ������� �� ������� ������ ����� (�� 1 �3)');
  CesaEconomUdAmortizationCtgtn : ResaKeyParams = (No:410; IsChangeable:False; Key:'�������� ��������������� ������� �� ������� ������ ����� (�� 1 �)');
  CesaEconomUdCtgm3             : ResaKeyParams = (No:411; IsChangeable:False; Key:'�������� ������� ������� �� ������� ������ ����� (�� 1 �3)');
  CesaEconomUdCtgtn             : ResaKeyParams = (No:412; IsChangeable:False; Key:'�������� ������� ������� �� ������� ������ ����� (�� 1 �)');

  //===================================== � � � � � � � =================================================
  //�������
  CesaVariant                          : ResaKeyParams = (No:1100; IsChangeable:False; Key:'������� �������������');
  CesaVariantName                      : ResaKeyParams = (No:1101; IsChangeable:False; Key:'������������');
  CesaVariantDate                      : ResaKeyParams = (No:1102; IsChangeable:False; Key:'���� �������������');
  //�����
  CesaVariantShift                     : ResaKeyParams = (No:2100; IsChangeable:False; Key:'��������� ������� �����');
  CesaVariantPeriodTday                : ResaKeyParams = (No:2101; IsChangeable:False; Key:'����������������� ������� �������������, ���');
  CesaVariantShiftTmin                 : ResaKeyParams = (No:2102; IsChangeable:False; Key:'����������������� ������� �����, ���');
  CesaVariantShiftNaryadTmin           : ResaKeyParams = (No:2103; IsChangeable:False; Key:' - ����� � ������ (����.)');
  CesaVariantShiftNaryadPlanTmin       : ResaKeyParams = (No:2104; IsChangeable:False; Key:' - ����� � ������');
  CesaVariantShiftPeresmenkaTmin       : ResaKeyParams = (No:2105; IsChangeable:False; Key:' - ����� ����������');
  CesaVariantShiftKweek                : ResaKeyParams = (No:2106; IsChangeable:False; Key:'����������� �������� ������� ����������');
  CesaVariantPeriodKshift              : ResaKeyParams = (No:2107; IsChangeable:False; Key:'����������� �������� ������� ���������� * ��������, ��� * ���������� ���� � ������');
  //�������������� ����������
  CesaVariantCommon                    : ResaKeyParams = (No:3000; IsChangeable:False; Key:'����� ����������');
  CesaVariantCommonDollarCtg           : ResaKeyParams = (No:3101; IsChangeable:False; Key:'���� �������, ��');
  CesaVariantCommonExpensesCtg         : ResaKeyParams = (No:3102; IsChangeable:False; Key:'���������� � ���������� �������, ��/���');
  CesaVariantCommonSalaryCoef          : ResaKeyParams = (No:3103; IsChangeable:False; Key:'����������� ����� ���������� �� ����� ���������� �����');
  CesaVariantCommonShiftTimeUsingCoef  : ResaKeyParams = (No:3104; IsChangeable:False; Key:'����������� ������������� ������� �����');
  CesaVariantCommonShiftTimeUsingCoef0 : ResaKeyParams = (No:3105; IsChangeable:False; Key:' - � ��������� ��������');
  CesaVariantCommonShiftTimeUsingCoef1 : ResaKeyParams = (No:3106; IsChangeable:False; Key:' - ������� ����');
  CesaVariantCommonShiftTimeUsingCoef2 : ResaKeyParams = (No:3107; IsChangeable:False; Key:' - � ���� ������������ �������� ����');
  CesaVariantCommonShiftTimeUsingCoef3 : ResaKeyParams = (No:3108; IsChangeable:False; Key:'���������� ������� � ������');
  CesaVariantCommonWorkRegimeKind      : ResaKeyParams = (No:3109; IsChangeable:False; Key:'������� ������������� �������� �������������� ��� �������� �����');
  CesaVariantCommonUsingStrippingCoef  : ResaKeyParams = (No:3110; IsChangeable:False; Key:'������� ����� ������������ �������');
  //�������������
  CesaVariantAutos                     : ResaKeyParams = (No:4000; IsChangeable:False; Key:'�������������');
  CesaVariantAutosModels               : ResaKeyParams = (No:4001; IsChangeable:False; Key:'������');
  //�������������� ���������� ��������������
  CesaVariantAutosQuantity             : ResaKeyParams = (No:4100; IsChangeable:False; Key:'�������������� ���������� ��������������');
  CesaVariantAutosAutosCount           : ResaKeyParams = (No:4101; IsChangeable:False; Key:'���������� ��������������');
  CesaVariantAutosTripsN               : ResaKeyParams = (No:4102; IsChangeable:True;  Key:'���������� ������');
  CesaVariantAutosLoadingTripsN        : ResaKeyParams = (No:4103; IsChangeable:True;  Key:' - � �������� �����������');
  CesaVariantAutosUnLoadingTripsN      : ResaKeyParams = (No:4104; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaVariantAutosNullTripsN           : ResaKeyParams = (No:4105; IsChangeable:True;  Key:' - � ������� �����������');
  CesaVariantAutosRockVm3              : ResaKeyParams = (No:4106; IsChangeable:True;  Key:'����� ������������ ������ �����, �3');
  CesaVariantAutosRockQtn              : ResaKeyParams = (No:4107; IsChangeable:True;  Key:'��� ������������ ������ �����, �');
  CesaVariantAutosSkm                  : ResaKeyParams = (No:4108; IsChangeable:True;  Key:'����� ������, ��');
  CesaVariantAutosLoadingSkm           : ResaKeyParams = (No:4109; IsChangeable:True;  Key:' - � �������� ����������� (��������� �����������������)');
  CesaVariantAutosUnLoadingSkm         : ResaKeyParams = (No:4110; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaVariantAutosNullSkm              : ResaKeyParams = (No:4111; IsChangeable:True;  Key:' - � ������� �����������');
  CesaVariantAutosWAvgLoadingSkm       : ResaKeyParams = (No:4112; IsChangeable:False; Key:'���������������� ��������� �����������������, ��');
  CesaVariantAutosAvgLoadingSkm        : ResaKeyParams = (No:4113; IsChangeable:False; Key:'������� ��������� �����������������, ��');
  CesaVariantAutosWAvgHm               : ResaKeyParams = (No:4114; IsChangeable:False; Key:'���������������� ������ ������� ������ �����, �');
  CesaVariantAutosAvgShiftSkm          : ResaKeyParams = (No:4115; IsChangeable:False; Key:'������������� ������ ������ �������������, ��');
  CesaVariantAutosAvgShiftSkm_reis     : ResaKeyParams = (No:4116; IsChangeable:False; Key:'������������� ������ ������ �������������, ��/����');
  CesaVariantAutosAvgVkmh              : ResaKeyParams = (No:4117; IsChangeable:False; Key:'������� �������� ��������, ��/�');
  CesaVariantAutosAvgLoadingVkmh       : ResaKeyParams = (No:4118; IsChangeable:False; Key:' - � �������� �����������');
  CesaVariantAutosAvgUnLoadingVkmh     : ResaKeyParams = (No:4119; IsChangeable:False; Key:' - � ������������ �����������');
  CesaVariantAutosAvgNullVkmh          : ResaKeyParams = (No:4120; IsChangeable:False; Key:' - � ������� �����������');
  CesaVariantAutosAvgTechVkmh          : ResaKeyParams = (No:4121; IsChangeable:False; Key:'����������������� �������� ��������, ��/�');
  CesaVariantAutosAvgLoadingTechVkmh   : ResaKeyParams = (No:4122; IsChangeable:False; Key:' - � �������� �����������');
  CesaVariantAutosAvgUnLoadingTechVkmh : ResaKeyParams = (No:4123; IsChangeable:False; Key:' - � ������������ �����������');
  CesaVariantAutosAvgNullTechVkmh      : ResaKeyParams = (No:4124; IsChangeable:False; Key:' - � ������� �����������');
  //������ ������� ��������������
  CesaVariantAutosFuel                 : ResaKeyParams = (No:4200; IsChangeable:False; Key:'���������� ������� ������� ��������������');
  CesaVariantAutosFuelCtg              : ResaKeyParams = (No:4201; IsChangeable:False; Key:'��������� �������, ��/�');
  CesaVariantAutosFuelCtgSummer        : ResaKeyParams = (No:4202; IsChangeable:False; Key:' - "������"');
  CesaVariantAutosFuelCtgWinter        : ResaKeyParams = (No:4203; IsChangeable:False; Key:' - "������"');
  CesaVariantAutosWinterMonthsCount    : ResaKeyParams = (No:4204; IsChangeable:False; Key:'���������� ������ �������');
  CesaVariantAutosFuelCostTarifIndex   : ResaKeyParams = (No:4205; IsChangeable:False; Key:'���� ������ ��������� �������');
  CesaVariantAutosGx0                  : ResaKeyParams = (No:4206; IsChangeable:True;  Key:'����� ������ �������, �');
  CesaVariantAutosWorkGx               : ResaKeyParams = (No:4207; IsChangeable:True;  Key:' - � ������');
  CesaVariantAutosWaitingGx            : ResaKeyParams = (No:4208; IsChangeable:True;  Key:' - � �������');
  CesaVariantAutosGx1                  : ResaKeyParams = (No:4209; IsChangeable:True;  Key:'����� ������ �������, �');
  CesaVariantAutosLoadingGx            : ResaKeyParams = (No:4210; IsChangeable:True;  Key:' - � �������� �����������');
  CesaVariantAutosUnLoadingGx          : ResaKeyParams = (No:4211; IsChangeable:True;  Key:' - � ������������ �����������');
  CesaVariantAutosNullGx               : ResaKeyParams = (No:4212; IsChangeable:True;  Key:' - � ������� �����������');
  CesaVariantAutosUdGx_gr_tkm          : ResaKeyParams = (No:4213; IsChangeable:False; Key:'�������� ������ �������, �/���');
  CesaVariantAutosGxCtg                : ResaKeyParams = (No:4214; IsChangeable:True;  Key:'������� �� �������, ��');
  //����� ��������������
  CesaVariantAutosWorkTime             : ResaKeyParams = (No:4300; IsChangeable:False; Key:'���������� ������������� �������� ������� ��������������');
  CesaVariantAutosTmin                 : ResaKeyParams = (No:4301; IsChangeable:True;  Key:'����� �����, ���');
  CesaVariantAutosMovingTmin           : ResaKeyParams = (No:4302; IsChangeable:True;  Key:' - � ��������');
  CesaVariantAutosWaitingTmin          : ResaKeyParams = (No:4303; IsChangeable:True;  Key:' - � �������');
  CesaVariantAutosManevrTmin           : ResaKeyParams = (No:4304; IsChangeable:True;  Key:' - � �������');
  CesaVariantAutosLoadingPunktTmin     : ResaKeyParams = (No:4305; IsChangeable:True;  Key:' - ��� ���������');
  CesaVariantAutosUnLoadingPunktTmin   : ResaKeyParams = (No:4306; IsChangeable:True;  Key:' - ��� ����������');
  CesaVariantAutosAvgShiftTmin         : ResaKeyParams = (No:4307; IsChangeable:False; Key:'������� ����� �����, ���');
  CesaVariantAutosAvgTimeUsingCoef     : ResaKeyParams = (No:4308; IsChangeable:False; Key:'������� ����������� ������������� �������� �������');
  //���� ��������������
  CesaVariantAutosTyres                : ResaKeyParams = (No:4400; IsChangeable:False; Key:'���������� ������� ��� ��������������');
  CesaVariantAutosTyresN               : ResaKeyParams = (No:4401; IsChangeable:False; Key:'���������� ��� ��������������');
  CesaVariantAutosTyreCtg              : ResaKeyParams = (No:4402; IsChangeable:False; Key:'��������� ���, ��');
  CesaVariantAutosTyresSkm             : ResaKeyParams = (No:4403; IsChangeable:True;  Key:'������� ������ ���, ���.��');
  CesaVariantAutosUsedTyresN           : ResaKeyParams = (No:4404; IsChangeable:True;  Key:'���������� ��������������� ���, ��');
  CesaVariantAutosTyresCtg             : ResaKeyParams = (No:4405; IsChangeable:True;  Key:'������� �� ����, ��');
  //����������� ��������� ��������������
  CesaVariantAutosCosts                : ResaKeyParams = (No:4500; IsChangeable:False; Key:'��������� ���������� ��������������');
  CesaVariantAutosSalaryCtg            : ResaKeyParams = (No:4501; IsChangeable:True;  Key:'������ ����� ���������, ��');
  CesaVariantAutosSalaryCtg0           : ResaKeyParams = (No:4502; IsChangeable:True;  Key:' - ��������');
  CesaVariantAutosSalaryCtg1           : ResaKeyParams = (No:4503; IsChangeable:True;  Key:' - ��������������');
  CesaVariantAutosCtg                  : ResaKeyParams = (No:4504; IsChangeable:True;  Key:'��������� �������, ��');
  CesaVariantAutosWorkCtg              : ResaKeyParams = (No:4505; IsChangeable:True;  Key:' - � ��������� ������');
  CesaVariantAutosWaitingCtg           : ResaKeyParams = (No:4506; IsChangeable:True;  Key:' - � ��������� �������');
  CesaVariantAutosAmortizationCtg      : ResaKeyParams = (No:4507; IsChangeable:True;  Key:' - �������� ��������������� ������');

implementation
end.
