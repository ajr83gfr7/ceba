unit esaConstants;
{
Модуль констант заголовков выходных параметров результатов моделирования
Елубаев С.А.
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
  //Количественные показатели
  CesaAutosQuantity             : ResaKeyParams = (No:100; IsChangeable:False; Key:'Количественные показатели');
  CesaAutosAutosCount           : ResaKeyParams = (No:101; IsChangeable:False; Key:'Количество автосамосвалов');
  CesaAutosTripsCount           : ResaKeyParams = (No:102; IsChangeable:True;  Key:'Количество рейсов');
  CesaAutosTripsCountNulled     : ResaKeyParams = (No:103; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaAutosTripsCountLoading    : ResaKeyParams = (No:104; IsChangeable:True;  Key:' - в грузовом направлении');
  CesaAutosTripsCountUnLoading  : ResaKeyParams = (No:105; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaAutosRock                 : ResaKeyParams = (No:106; IsChangeable:False; Key:'Перевезенная горная масса');
  CesaAutosRockVm3              : ResaKeyParams = (No:107; IsChangeable:True;  Key:' - Объем, м3');
  CesaAutosRockQtn              : ResaKeyParams = (No:108; IsChangeable:True;  Key:' - Вес, т');
  CesaAutosSkm                  : ResaKeyParams = (No:109; IsChangeable:True;  Key:'Пробег, км');
  CesaAutosSkmNulled            : ResaKeyParams = (No:110; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaAutosSkmLoading           : ResaKeyParams = (No:111; IsChangeable:True;  Key:' - в грузовом направлении (Растояние транспортирования)');
  CesaAutosSkmUnLoading         : ResaKeyParams = (No:112; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaAutosLoadingSkm           : ResaKeyParams = (No:113; IsChangeable:True;  Key:'Растояние транспортирования, км');
  CesaAutosLoadingWAvgSkm       : ResaKeyParams = (No:114; IsChangeable:False; Key:' - Средневзвешенное');
  CesaAutosLoadingAvgSkm        : ResaKeyParams = (No:115; IsChangeable:False; Key:' - Среднее');
  CesaAutosWAvgHm               : ResaKeyParams = (No:116; IsChangeable:False; Key:'Средневзвешенная высота подъема горной массы, м');
  CesaAutosShiftAvgSkm1          : ResaKeyParams = (No:117; IsChangeable:False; Key:'Среднесменный пробег одного автосамосвала, км');
  CesaAutosShiftAvgSkm_reis     : ResaKeyParams = (No:118; IsChangeable:False; Key:'Среднесменный пробег одного автосамосвала, км/рейс');
  CesaAutosAvgVkmh              : ResaKeyParams = (No:119; IsChangeable:False; Key:'Средняя скорость движения, км/ч');
  CesaAutosAvgVkmhNulled        : ResaKeyParams = (No:120; IsChangeable:False; Key:' - в нулевом направлении');
  CesaAutosAvgVkmhLoading       : ResaKeyParams = (No:121; IsChangeable:False; Key:' - в грузовом направлении');
  CesaAutosAvgVkmhUnLoading     : ResaKeyParams = (No:122; IsChangeable:False; Key:' - в порожняковом направлении');
  CesaAutosAvgTechVkmh          : ResaKeyParams = (No:123; IsChangeable:False; Key:'Среднетехническая скорость движения, км/ч');
  //Расход топлива
  CesaAutosFuel                 : ResaKeyParams = (No:200; IsChangeable:False; Key:'Показатели расхода топлива');
  CesaAutosGx                   : ResaKeyParams = (No:201; IsChangeable:True;  Key:'Общий расход топлива, л');
  CesaAutosGxWork               : ResaKeyParams = (No:202; IsChangeable:True;  Key:' - в работе, л');
  CesaAutosGxWaiting            : ResaKeyParams = (No:203; IsChangeable:True;  Key:' - в простое, л');
  CesaAutosDirGx                : ResaKeyParams = (No:204; IsChangeable:True;  Key:'Общий расход топлива по направлениям, л');
  CesaAutosGxNulled             : ResaKeyParams = (No:205; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaAutosGxLoading            : ResaKeyParams = (No:206; IsChangeable:True;  Key:' - в грузовом направлении');
  CesaAutosGxUnLoading          : ResaKeyParams = (No:207; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaAutosUdGx_gr_tkm          : ResaKeyParams = (No:208; IsChangeable:False; Key:'Удельный расход топлива, г/ткм');
  CesaAutosGxCtg                : ResaKeyParams = (No:209; IsChangeable:True;  Key:'Затраты на топливо, тг');
  //Время
  CesaAutosWorkTime             : ResaKeyParams = (No:300; IsChangeable:False; Key:'Показатели использования рабочего времени');
  CesaAutosTmin                 : ResaKeyParams = (No:301; IsChangeable:True;  Key:'Общее время, мин');
  CesaAutosTminMoving           : ResaKeyParams = (No:302; IsChangeable:True;  Key:' - в движении');
  CesaAutosTminWaiting          : ResaKeyParams = (No:303; IsChangeable:True;  Key:' - в простое');
  CesaAutosTminManevr           : ResaKeyParams = (No:304; IsChangeable:True;  Key:' - в маневре');
  CesaAutosTminOnLoading        : ResaKeyParams = (No:305; IsChangeable:True;  Key:' - под погрузкой');
  CesaAutosTminOnUnLoading      : ResaKeyParams = (No:306; IsChangeable:True;  Key:' - под разгрузкой');
  CesaAutosDirTmin              : ResaKeyParams = (No:307; IsChangeable:True;  Key:'Общее время по направлениям, мин');
  CesaAutosTminNulled           : ResaKeyParams = (No:308; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaAutosTminLoading          : ResaKeyParams = (No:309; IsChangeable:True;  Key:' - в грузовом направлении');
  CesaAutosTminUnLoading        : ResaKeyParams = (No:310; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaAutosReysAvgTmin          : ResaKeyParams = (No:311; IsChangeable:False; Key:'Среднее время рейса, мин');
  CesaAutosReysAvgTminNulled    : ResaKeyParams = (No:312; IsChangeable:False; Key:' - в нулевом направлении');
  CesaAutosReysAvgTminLoading   : ResaKeyParams = (No:313; IsChangeable:False; Key:' - в грузовом направлении');
  CesaAutosReysAvgTminUnLoading : ResaKeyParams = (No:314; IsChangeable:False; Key:' - в порожняковом направлении');
  CesaAutosAvgTimeUsingCoef     : ResaKeyParams = (No:315; IsChangeable:False; Key:'Средний коэффициент использования рабочего времени');
  //Шины
  CesaAutosTyres                : ResaKeyParams = (No:400; IsChangeable:False; Key:'Показатели расхода шин');
  CesaAutosTyresCount           : ResaKeyParams = (No:401; IsChangeable:False; Key:'Количество шин автосамосвала');
  CesaAutosTyresAmortizationR1000km: ResaKeyParams = (No:402; IsChangeable:False; Key:'Норма пробега шин, тыс.км');
  CesaAutosTyreC1000tg          : ResaKeyParams = (No:403; IsChangeable:False; Key:'Стоимость 1й шины, тыс.тг');
  CesaAutosTyresS1000km         : ResaKeyParams = (No:404; IsChangeable:True;  Key:'Средний пробег шин, тыс.км');
  CesaAutosUsedTyresCount       : ResaKeyParams = (No:405; IsChangeable:True;  Key:'Количество израсходованных шин, шт');
  CesaAutosTyresCtg             : ResaKeyParams = (No:406; IsChangeable:True;  Key:'Затраты на шины, тг');
  //Стоимостные параметры
  CesaAutosCosts                   : ResaKeyParams = (No:500; IsChangeable:False; Key:'Суммарные показатели');
  CesaAutosWorkCtg                 : ResaKeyParams = (No:501; IsChangeable:True;  Key:'Затраты в состоянии работы, тг');
  CesaAutosWorkSumGxCtg            : ResaKeyParams = (No:502; IsChangeable:True;  Key:' - топливо');
  CesaAutosWorkSumTyresCtg         : ResaKeyParams = (No:503; IsChangeable:True;  Key:' - шины');
  CesaAutosWorkSparesCtg           : ResaKeyParams = (No:504; IsChangeable:True;  Key:' - запчасти и материалы');
  CesaAutosWorkMaterialsCtg        : ResaKeyParams = (No:505; IsChangeable:True;  Key:' - смазочные материалы');
  CesaAutosWorkMaintenancesCtg     : ResaKeyParams = (No:506; IsChangeable:True;  Key:' - содержание ремонтного персонала');
  CesaAutosWorkSalariesCtg         : ResaKeyParams = (No:507; IsChangeable:True;  Key:' - заработная плата');
  CesaAutosWaitingCtg              : ResaKeyParams = (No:508; IsChangeable:True;  Key:'Затраты в состоянии простоя, тг');
  CesaAutosWaitingSumGxCtg         : ResaKeyParams = (No:509; IsChangeable:True;  Key:' - топливо');
  CesaAutosWaitingSparesCtg        : ResaKeyParams = (No:510; IsChangeable:True;  Key:' - запчасти и материалы');
  CesaAutosWaitingMaterialsCtg     : ResaKeyParams = (No:511; IsChangeable:True;  Key:' - смазочные материалы');
  CesaAutosWaitingMaintenancesCtg  : ResaKeyParams = (No:512; IsChangeable:True;  Key:' - содержание ремонтного персонала');
  CesaAutosWaitingSalariesCtg      : ResaKeyParams = (No:513; IsChangeable:True;  Key:' - заработная плата');
  CesaAutosAmortizationCtg         : ResaKeyParams = (No:514; IsChangeable:True;  Key:'Величина амортизационных затрат, тг');
  CesaAutosCtg                     : ResaKeyParams = (No:515; IsChangeable:True;  Key:'Суммарные затраты, тг');

  //Количественные показатели
  CesaExcavsQuantity            : ResaKeyParams = (No:100; IsChangeable:False; Key:'Количественные показатели');
  CesaExcavsExcavatorsCount     : ResaKeyParams = (No:101; IsChangeable:False; Key:'Количество экскаваторов');
  CesaExcavsLoadingAutosCount   : ResaKeyParams = (No:102; IsChangeable:True;  Key:'Количество погруженных автосамосвалов');
  CesaExcavsRockPlanVm3         : ResaKeyParams = (No:103; IsChangeable:True;  Key:'Плановый объем горной массы, м3');
  CesaExcavsRockVm3             : ResaKeyParams = (No:104; IsChangeable:True;  Key:'Объем погруженой горной массы, м3');
  CesaExcavsRockQtn             : ResaKeyParams = (No:105; IsChangeable:True;  Key:'Вес погруженой горной массы, т');
  CesaExcavsPlanRockRatio       : ResaKeyParams = (No:106; IsChangeable:False; Key:'Степень выполнения плана, %');
  //Расход топлива
  CesaExcavsFuel                : ResaKeyParams = (No:200; IsChangeable:False; Key:'Показатели расхода топлива');
  CesaExcavsGx                  : ResaKeyParams = (No:201; IsChangeable:True;  Key:'Общий расход электроэнергии, кВт');
  CesaExcavsGxWork              : ResaKeyParams = (No:202; IsChangeable:True;  Key:' - в работе');
  CesaExcavsGxWaiting           : ResaKeyParams = (No:203; IsChangeable:True;  Key:' - в простое');
  //Время
  CesaExcavsTime                : ResaKeyParams = (No:300; IsChangeable:False; Key:'Показатели использования рабочего времени');
  CesaExcavsTmin                : ResaKeyParams = (No:301; IsChangeable:True;  Key:'Общее время, мин');
  CesaExcavsTminWork            : ResaKeyParams = (No:302; IsChangeable:True;  Key:'Время в работе, мин');
  CesaExcavsTminWaiting         : ResaKeyParams = (No:303; IsChangeable:True;  Key:'Время в простое, мин');
  CesaExcavsTminManevr          : ResaKeyParams = (No:304; IsChangeable:True;  Key:'Время в маневре, мин');
  CesaExcavsUsingPunktCoef      : ResaKeyParams = (No:305; IsChangeable:False; Key:'Коэффициент занятости пунктов погрузки');
  CesaExcavsUsingTimeCoef       : ResaKeyParams = (No:306; IsChangeable:False; Key:'Коэффициент использования рабочего времени');
  //Стоимостные параметры
  CesaExcavsCosts                  : ResaKeyParams = (No:400; IsChangeable:False; Key:'Суммарные показатели');
  CesaExcavsWorkCtg                : ResaKeyParams = (No:401; IsChangeable:True;  Key:'Затраты в работе, тг');
  CesaExcavsWorkSumGxCtg           : ResaKeyParams = (No:402; IsChangeable:True;  Key:' - электроэнергия');
  CesaExcavsWorkMaterialsCtg       : ResaKeyParams = (No:403; IsChangeable:True;  Key:' - материалы');
  CesaExcavsWorkUnAccountedCtg     : ResaKeyParams = (No:404; IsChangeable:True;  Key:' - неучтенные расходы');
  CesaExcavsWorkSalariesCtg        : ResaKeyParams = (No:405; IsChangeable:True;  Key:' - заработная плата');
  CesaExcavsWaitingCtg             : ResaKeyParams = (No:406; IsChangeable:True;  Key:'Затраты в простое, тг (+маневры)');
  CesaExcavsWaitingSumGxCtg        : ResaKeyParams = (No:407; IsChangeable:True;  Key:' - электроэнергия');
  CesaExcavsWaitingMaterialsCtg    : ResaKeyParams = (No:408; IsChangeable:True;  Key:' - материалы');
  CesaExcavsWaitingUnAccountedCtg  : ResaKeyParams = (No:409; IsChangeable:True;  Key:' - неучтенные расходы');
  CesaExcavsWaitingSalariesCtg     : ResaKeyParams = (No:410; IsChangeable:True;  Key:' - заработная плата');
  CesaExcavsAmortizationCtg        : ResaKeyParams = (No:411; IsChangeable:True;  Key:'Величина амортизационных затрат, тг');
  CesaExcavsCtg                    : ResaKeyParams = (No:412; IsChangeable:True;  Key:'Суммарные затраты, тг');

  //Количественные показатели
  CesaBlocksQuantity               : ResaKeyParams = (No:100; IsChangeable:False; Key:'Количественные показатели');
  CesaBlocksBlocksCount            : ResaKeyParams = (No:101; IsChangeable:False; Key:'Количество блок-участков');
  CesaBlocksLm                     : ResaKeyParams = (No:102; IsChangeable:False; Key:'Длина, м');
  CesaBlocksRock                   : ResaKeyParams = (No:103; IsChangeable:False; Key:'Перевезенная горная масса, м3');
  CesaBlocksRockVm3                : ResaKeyParams = (No:104; IsChangeable:True;  Key:' - Объем, м3');
  CesaBlocksRockQtn                : ResaKeyParams = (No:105; IsChangeable:True;  Key:' - Вес, т');
  CesaBlocksAutosCount             : ResaKeyParams = (No:106; IsChangeable:True;  Key:'Количество прошедших автосамосвалов');
  CesaBlocksAutosCountNulled       : ResaKeyParams = (No:107; IsChangeable:True;  Key:'  - в нулевом направлении');
  CesaBlocksAutosCountLoading      : ResaKeyParams = (No:108; IsChangeable:True;  Key:'  - в грузовом направлении');
  CesaBlocksAutosCountUnLoading    : ResaKeyParams = (No:109; IsChangeable:True;  Key:'  - в порожняковом направлении');
  CesaBlocksWaitingsCount          : ResaKeyParams = (No:110; IsChangeable:True;  Key:'Количество простоев прошедших автосамосвалов');
  CesaBlocksWaitingsCountNulled    : ResaKeyParams = (No:111; IsChangeable:True;  Key:'  - в нулевом направлении');
  CesaBlocksWaitingsCountLoading   : ResaKeyParams = (No:112; IsChangeable:True;  Key:'  - в грузовом направлении');
  CesaBlocksWaitingsCountUnLoading : ResaKeyParams = (No:113; IsChangeable:True;  Key:'  - в порожняковом направлении');
  CesaBlocksAvgVkmh                : ResaKeyParams = (No:114; IsChangeable:False; Key:'Средняя скорость движения прошедших автосамосвалов, км/ч');
  CesaBlocksAvgVkmhNulled          : ResaKeyParams = (No:115; IsChangeable:False; Key:'  - в нулевом направлении');
  CesaBlocksAvgVkmhLoading         : ResaKeyParams = (No:116; IsChangeable:False; Key:'  - в грузовом направлении');
  CesaBlocksAvgVkmhUnLoading       : ResaKeyParams = (No:117; IsChangeable:False; Key:'  - в порожняковом направлении');
  //Показатели использования рабочего времени
  CesaBlocksTime                   : ResaKeyParams = (No:200; IsChangeable:False; Key:'Показатели использования рабочего времени');
  CesaBlocksMovingAvgTmin          : ResaKeyParams = (No:201; IsChangeable:False; Key:'Среднее время движения прошедших автосамосвалов, мин');
  CesaBlocksMovingAvgTminNulled    : ResaKeyParams = (No:202; IsChangeable:False; Key:'  - в нулевом направлении');
  CesaBlocksMovingAvgTminLoading   : ResaKeyParams = (No:203; IsChangeable:False; Key:'  - в грузовом направлении');
  CesaBlocksMovingAvgTminUnLoading : ResaKeyParams = (No:204; IsChangeable:False; Key:'  - в порожняковом направлении');
  CesaBlocksWaitingAvgTmin         : ResaKeyParams = (No:205; IsChangeable:False; Key:'Среднее время простоев прошедших автосамосвалов, мин');
  CesaBlocksWaitingAvgTminNulled   : ResaKeyParams = (No:206; IsChangeable:True;  Key:'  - в нулевом направлении');
  CesaBlocksWaitingAvgTminLoading  : ResaKeyParams = (No:207; IsChangeable:False; Key:'  - в грузовом направлении');
  CesaBlocksWaitingAvgTminUnLoadung: ResaKeyParams = (No:208; IsChangeable:False; Key:'  - в порожняковом направлении');
  CesaBlocksEmploymentCoef         : ResaKeyParams = (No:209; IsChangeable:False; Key:'Коэффициент занятости');
  //Показатели расхода топлива
  CesaBlocksFuel                   : ResaKeyParams = (No:300; IsChangeable:False; Key:'Показатели расхода топлива');
  CesaBlocksGx                     : ResaKeyParams = (No:301; IsChangeable:True;  Key:'Расход топлива прошедших автосамосвалов, л');
  CesaBlocksGxNulled               : ResaKeyParams = (No:302; IsChangeable:True;  Key:'  - в нулевом направлении');
  CesaBlocksGxLoading              : ResaKeyParams = (No:303; IsChangeable:True;  Key:'  - в грузовом направлении');
  CesaBlocksGxUnLoading            : ResaKeyParams = (No:304; IsChangeable:True;  Key:'  - в порожняковом направлении');
  CesaBlocksUdGx_l_m               : ResaKeyParams = (No:305; IsChangeable:False; Key:'Удельный расход топлива, л/м');
  //Стоимостные параметры
  CesaBlocksCosts                  : ResaKeyParams = (No:400; IsChangeable:False; Key:'Стоимостные показатели');
  CesaBlocksRepairCtg              : ResaKeyParams = (No:401; IsChangeable:True;  Key:'Затраты на поддержание, тг');
  CesaBlocksAmortizationCtg        : ResaKeyParams = (No:402; IsChangeable:True;  Key:'Амортизационные отчисления, тг');
  CesaBlocksBuildingCtg            : ResaKeyParams = (No:403; IsChangeable:True;  Key:'Затраты на строительство, тг');
  CesaBlocksCtg                    : ResaKeyParams = (No:404; IsChangeable:True;  Key:'Суммарные затраты, тг');

  CesaEconomAutos               : ResaKeyParams = (No:100; IsChangeable:False; Key:'Затраты по автосамосвалам');
  CesaEconomWorkCtg0            : ResaKeyParams = (No:101; IsChangeable:True;  Key:'Затраты в работе');
  CesaEconomWaitingCtg0         : ResaKeyParams = (No:102; IsChangeable:True;  Key:'Затраты в простое');
  CesaEconomAmortizationCtg0    : ResaKeyParams = (No:103; IsChangeable:True;  Key:'Амортизационные отчисления');
  CesaEconomCtg0                : ResaKeyParams = (No:104; IsChangeable:True;  Key:'Суммарные затраты');
  CesaEconomExcavs              : ResaKeyParams = (No:200; IsChangeable:False; Key:'Затраты по экскаваторам');
  CesaEconomWorkCtg1            : ResaKeyParams = (No:201; IsChangeable:True;  Key:'Затраты в работе');
  CesaEconomWaitingCtg1         : ResaKeyParams = (No:202; IsChangeable:True;  Key:'Затраты в простое');
  CesaEconomAmortizationCtg1    : ResaKeyParams = (No:203; IsChangeable:True;  Key:'Амортизационные отчисления');
  CesaEconomCtg1                : ResaKeyParams = (No:204; IsChangeable:True;  Key:'Суммарные затраты');
  CesaEconomBlocks              : ResaKeyParams = (No:300; IsChangeable:False; Key:'Затраты по блок-участкам');
  CesaEconomRepairCtg2          : ResaKeyParams = (No:301; IsChangeable:True;  Key:'Затраты на поддержание');
  CesaEconomAmortizationCtg2    : ResaKeyParams = (No:302; IsChangeable:True;  Key:'Амортизационные отчисления');
  CesaEconomCtg2                : ResaKeyParams = (No:303; IsChangeable:True;  Key:'Суммарные затраты');
  CesaEconomSummary             : ResaKeyParams = (No:400; IsChangeable:False; Key:'Суммарные показатели');
  CesaEconomCtg                 : ResaKeyParams = (No:401; IsChangeable:True;  Key:'Затраты по горно-транспортному комплексу');
  CesaEconomExpluationCtg       : ResaKeyParams = (No:402; IsChangeable:True;  Key:'  Эксплутационные затраты');
  CesaEconomAmortizationCtg     : ResaKeyParams = (No:403; IsChangeable:True;  Key:'  Амортизационные отчисления');
  CesaEconomExpensesCtg         : ResaKeyParams = (No:404; IsChangeable:True;  Key:'  Постоянные и неучтенные расходы');
  CesaEconomRockVm3             : ResaKeyParams = (No:405; IsChangeable:True;  Key:'Производительность комплекса по горной массе, м3');
  CesaEconomRockQtn             : ResaKeyParams = (No:406; IsChangeable:True;  Key:'Производительность комплекса по горной массе, т');
  CesaEconomUdExpluationCtgm3   : ResaKeyParams = (No:407; IsChangeable:False; Key:'Удельные эксплутационные затраты на единицу горной массы (на 1 м3)');
  CesaEconomUdExpluationCtgtn   : ResaKeyParams = (No:408; IsChangeable:False; Key:'Удельные эксплутационные затраты на единицу горной массы (на 1 т)');
  CesaEconomUdAmortizationCtgm3 : ResaKeyParams = (No:409; IsChangeable:False; Key:'Удельные амортизационные затраты на единицу горной массы (на 1 м3)');
  CesaEconomUdAmortizationCtgtn : ResaKeyParams = (No:410; IsChangeable:False; Key:'Удельные амортизационные затраты на единицу горной массы (на 1 т)');
  CesaEconomUdCtgm3             : ResaKeyParams = (No:411; IsChangeable:False; Key:'Удельные текущие затраты на единицу горной массы (на 1 м3)');
  CesaEconomUdCtgtn             : ResaKeyParams = (No:412; IsChangeable:False; Key:'Удельные текущие затраты на единицу горной массы (на 1 т)');

  //===================================== В А Р И А Н Т =================================================
  //Вариант
  CesaVariant                          : ResaKeyParams = (No:1100; IsChangeable:False; Key:'Вариант моделирования');
  CesaVariantName                      : ResaKeyParams = (No:1101; IsChangeable:False; Key:'Наименование');
  CesaVariantDate                      : ResaKeyParams = (No:1102; IsChangeable:False; Key:'Дата моделирования');
  //Смена
  CesaVariantShift                     : ResaKeyParams = (No:2100; IsChangeable:False; Key:'Параметры рабочей смены');
  CesaVariantPeriodTday                : ResaKeyParams = (No:2101; IsChangeable:False; Key:'Продолжительность периода моделирования, дни');
  CesaVariantShiftTmin                 : ResaKeyParams = (No:2102; IsChangeable:False; Key:'Продолжительность рабочей смены, мин');
  CesaVariantShiftNaryadTmin           : ResaKeyParams = (No:2103; IsChangeable:False; Key:' - время в наряде (факт.)');
  CesaVariantShiftNaryadPlanTmin       : ResaKeyParams = (No:2104; IsChangeable:False; Key:' - время в наряде');
  CesaVariantShiftPeresmenkaTmin       : ResaKeyParams = (No:2105; IsChangeable:False; Key:' - время пересменки');
  CesaVariantShiftKweek                : ResaKeyParams = (No:2106; IsChangeable:False; Key:'Коэффициент перевода сменных параметров');
  CesaVariantPeriodKshift              : ResaKeyParams = (No:2107; IsChangeable:False; Key:'Коэффициент перевода сменных параметров * Тпериода, дни * Количество смен в сутках');
  //Дополнительные показатели
  CesaVariantCommon                    : ResaKeyParams = (No:3000; IsChangeable:False; Key:'Общие показатели');
  CesaVariantCommonDollarCtg           : ResaKeyParams = (No:3101; IsChangeable:False; Key:'Курс доларра, тг');
  CesaVariantCommonExpensesCtg         : ResaKeyParams = (No:3102; IsChangeable:False; Key:'Постоянные и неучтенные расходы, тг/год');
  CesaVariantCommonSalaryCoef          : ResaKeyParams = (No:3103; IsChangeable:False; Key:'Коэффициент учета отчислений из фонда заработной платы');
  CesaVariantCommonShiftTimeUsingCoef  : ResaKeyParams = (No:3104; IsChangeable:False; Key:'Коэффициент использования времени смены');
  CesaVariantCommonShiftTimeUsingCoef0 : ResaKeyParams = (No:3105; IsChangeable:False; Key:' - в номальных условиях');
  CesaVariantCommonShiftTimeUsingCoef1 : ResaKeyParams = (No:3106; IsChangeable:False; Key:' - дневных смен');
  CesaVariantCommonShiftTimeUsingCoef2 : ResaKeyParams = (No:3107; IsChangeable:False; Key:' - в день производства взрывных смен');
  CesaVariantCommonShiftTimeUsingCoef3 : ResaKeyParams = (No:3108; IsChangeable:False; Key:'Количество взрывов в неделю');
  CesaVariantCommonWorkRegimeKind      : ResaKeyParams = (No:3109; IsChangeable:False; Key:'Признак распределения порожних автосамосвалов при открытом цикле');
  CesaVariantCommonUsingStrippingCoef  : ResaKeyParams = (No:3110; IsChangeable:False; Key:'Признак учета коэффициента вскрыши');
  //Автосамосвалы
  CesaVariantAutos                     : ResaKeyParams = (No:4000; IsChangeable:False; Key:'Автосамосвалы');
  CesaVariantAutosModels               : ResaKeyParams = (No:4001; IsChangeable:False; Key:'Модели');
  //Количественные показатели автосамосвалов
  CesaVariantAutosQuantity             : ResaKeyParams = (No:4100; IsChangeable:False; Key:'Количественные показатели автосамосвалов');
  CesaVariantAutosAutosCount           : ResaKeyParams = (No:4101; IsChangeable:False; Key:'Количество автосамосвалов');
  CesaVariantAutosTripsN               : ResaKeyParams = (No:4102; IsChangeable:True;  Key:'Количество рейсов');
  CesaVariantAutosLoadingTripsN        : ResaKeyParams = (No:4103; IsChangeable:True;  Key:' - в грузовом направлении');
  CesaVariantAutosUnLoadingTripsN      : ResaKeyParams = (No:4104; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaVariantAutosNullTripsN           : ResaKeyParams = (No:4105; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaVariantAutosRockVm3              : ResaKeyParams = (No:4106; IsChangeable:True;  Key:'Объем перевезенной горной массы, м3');
  CesaVariantAutosRockQtn              : ResaKeyParams = (No:4107; IsChangeable:True;  Key:'Вес перевезенной горной массы, т');
  CesaVariantAutosSkm                  : ResaKeyParams = (No:4108; IsChangeable:True;  Key:'Общий пробег, км');
  CesaVariantAutosLoadingSkm           : ResaKeyParams = (No:4109; IsChangeable:True;  Key:' - в грузовом направлении (Растояние транспортирования)');
  CesaVariantAutosUnLoadingSkm         : ResaKeyParams = (No:4110; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaVariantAutosNullSkm              : ResaKeyParams = (No:4111; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaVariantAutosWAvgLoadingSkm       : ResaKeyParams = (No:4112; IsChangeable:False; Key:'Средневзвешенное растояние транспортирования, км');
  CesaVariantAutosAvgLoadingSkm        : ResaKeyParams = (No:4113; IsChangeable:False; Key:'Среднее растояние транспортирования, км');
  CesaVariantAutosWAvgHm               : ResaKeyParams = (No:4114; IsChangeable:False; Key:'Средневзвешенная высота подъема горной массы, м');
  CesaVariantAutosAvgShiftSkm          : ResaKeyParams = (No:4115; IsChangeable:False; Key:'Среднесменный пробег одного автосамосвала, км');
  CesaVariantAutosAvgShiftSkm_reis     : ResaKeyParams = (No:4116; IsChangeable:False; Key:'Среднесменный пробег одного автосамосвала, км/рейс');
  CesaVariantAutosAvgVkmh              : ResaKeyParams = (No:4117; IsChangeable:False; Key:'Средняя скорость движения, км/ч');
  CesaVariantAutosAvgLoadingVkmh       : ResaKeyParams = (No:4118; IsChangeable:False; Key:' - в грузовом направлении');
  CesaVariantAutosAvgUnLoadingVkmh     : ResaKeyParams = (No:4119; IsChangeable:False; Key:' - в порожняковом направлении');
  CesaVariantAutosAvgNullVkmh          : ResaKeyParams = (No:4120; IsChangeable:False; Key:' - в нулевом направлении');
  CesaVariantAutosAvgTechVkmh          : ResaKeyParams = (No:4121; IsChangeable:False; Key:'Среднетехническая скорость движения, км/ч');
  CesaVariantAutosAvgLoadingTechVkmh   : ResaKeyParams = (No:4122; IsChangeable:False; Key:' - в грузовом направлении');
  CesaVariantAutosAvgUnLoadingTechVkmh : ResaKeyParams = (No:4123; IsChangeable:False; Key:' - в порожняковом направлении');
  CesaVariantAutosAvgNullTechVkmh      : ResaKeyParams = (No:4124; IsChangeable:False; Key:' - в нулевом направлении');
  //Расход топлива автосамосвалов
  CesaVariantAutosFuel                 : ResaKeyParams = (No:4200; IsChangeable:False; Key:'Показатели расхода топлива автосамосвалов');
  CesaVariantAutosFuelCtg              : ResaKeyParams = (No:4201; IsChangeable:False; Key:'Стоимость топлива, тг/л');
  CesaVariantAutosFuelCtgSummer        : ResaKeyParams = (No:4202; IsChangeable:False; Key:' - "Зимнее"');
  CesaVariantAutosFuelCtgWinter        : ResaKeyParams = (No:4203; IsChangeable:False; Key:' - "Летнее"');
  CesaVariantAutosWinterMonthsCount    : ResaKeyParams = (No:4204; IsChangeable:False; Key:'Количество зимних месяцев');
  CesaVariantAutosFuelCostTarifIndex   : ResaKeyParams = (No:4205; IsChangeable:False; Key:'Учет тарифа стоимости топлива');
  CesaVariantAutosGx0                  : ResaKeyParams = (No:4206; IsChangeable:True;  Key:'Общий расход топлива, л');
  CesaVariantAutosWorkGx               : ResaKeyParams = (No:4207; IsChangeable:True;  Key:' - в работе');
  CesaVariantAutosWaitingGx            : ResaKeyParams = (No:4208; IsChangeable:True;  Key:' - в простое');
  CesaVariantAutosGx1                  : ResaKeyParams = (No:4209; IsChangeable:True;  Key:'Общий расход топлива, л');
  CesaVariantAutosLoadingGx            : ResaKeyParams = (No:4210; IsChangeable:True;  Key:' - в грузовом направлении');
  CesaVariantAutosUnLoadingGx          : ResaKeyParams = (No:4211; IsChangeable:True;  Key:' - в порожняковом направлении');
  CesaVariantAutosNullGx               : ResaKeyParams = (No:4212; IsChangeable:True;  Key:' - в нулевом направлении');
  CesaVariantAutosUdGx_gr_tkm          : ResaKeyParams = (No:4213; IsChangeable:False; Key:'Удельный расход топлива, г/ткм');
  CesaVariantAutosGxCtg                : ResaKeyParams = (No:4214; IsChangeable:True;  Key:'Затраты на топливо, тг');
  //Время автосамосвалов
  CesaVariantAutosWorkTime             : ResaKeyParams = (No:4300; IsChangeable:False; Key:'Показатели использования рабочего времени автосамосвалов');
  CesaVariantAutosTmin                 : ResaKeyParams = (No:4301; IsChangeable:True;  Key:'Общее время, мин');
  CesaVariantAutosMovingTmin           : ResaKeyParams = (No:4302; IsChangeable:True;  Key:' - в движении');
  CesaVariantAutosWaitingTmin          : ResaKeyParams = (No:4303; IsChangeable:True;  Key:' - в простое');
  CesaVariantAutosManevrTmin           : ResaKeyParams = (No:4304; IsChangeable:True;  Key:' - в маневре');
  CesaVariantAutosLoadingPunktTmin     : ResaKeyParams = (No:4305; IsChangeable:True;  Key:' - под погрузкой');
  CesaVariantAutosUnLoadingPunktTmin   : ResaKeyParams = (No:4306; IsChangeable:True;  Key:' - под разгрузкой');
  CesaVariantAutosAvgShiftTmin         : ResaKeyParams = (No:4307; IsChangeable:False; Key:'Среднее время рейса, мин');
  CesaVariantAutosAvgTimeUsingCoef     : ResaKeyParams = (No:4308; IsChangeable:False; Key:'Средний коэффициент использования рабочего времени');
  //Шины автосамосвалов
  CesaVariantAutosTyres                : ResaKeyParams = (No:4400; IsChangeable:False; Key:'Показатели расхода шин автосамосвалов');
  CesaVariantAutosTyresN               : ResaKeyParams = (No:4401; IsChangeable:False; Key:'Количество шин автосамосвалов');
  CesaVariantAutosTyreCtg              : ResaKeyParams = (No:4402; IsChangeable:False; Key:'Стоимость шин, тг');
  CesaVariantAutosTyresSkm             : ResaKeyParams = (No:4403; IsChangeable:True;  Key:'Средний пробег шин, тыс.км');
  CesaVariantAutosUsedTyresN           : ResaKeyParams = (No:4404; IsChangeable:True;  Key:'Количество израсходованных шин, шт');
  CesaVariantAutosTyresCtg             : ResaKeyParams = (No:4405; IsChangeable:True;  Key:'Затраты на шины, тг');
  //Стоимостные параметры автосамосвалов
  CesaVariantAutosCosts                : ResaKeyParams = (No:4500; IsChangeable:False; Key:'Суммарные показатели автосамосвалов');
  CesaVariantAutosSalaryCtg            : ResaKeyParams = (No:4501; IsChangeable:True;  Key:'Оплата труда водителей, тг');
  CesaVariantAutosSalaryCtg0           : ResaKeyParams = (No:4502; IsChangeable:True;  Key:' - основная');
  CesaVariantAutosSalaryCtg1           : ResaKeyParams = (No:4503; IsChangeable:True;  Key:' - дополнительная');
  CesaVariantAutosCtg                  : ResaKeyParams = (No:4504; IsChangeable:True;  Key:'Суммарные затраты, тг');
  CesaVariantAutosWorkCtg              : ResaKeyParams = (No:4505; IsChangeable:True;  Key:' - в состоянии работы');
  CesaVariantAutosWaitingCtg           : ResaKeyParams = (No:4506; IsChangeable:True;  Key:' - в состоянии простоя');
  CesaVariantAutosAmortizationCtg      : ResaKeyParams = (No:4507; IsChangeable:True;  Key:' - Величина амортизационных затрат');

implementation
end.
