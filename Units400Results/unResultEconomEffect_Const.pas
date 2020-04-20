unit unResultEconomEffect_Const;

interface
resourcestring
  WORKFLOW_OF_SHIHT = 'Производительность ГТСК по ГМ за смену, тыс.м3.';
  WORKFLOW_OF_YEAR = 'Производительность ГТСК по ГМ за год, тыс.м3.';
  WEIGHT_OF_ORE = 'Объемный вес руды, т/м3';
  TIMEFLOW_OF_SHIHT = 'Продолжительность смены, мин';
  COST_OF_GTK = 'Затраты по горно-транспортному комплексу, тг';
  COST_OF_M3 = 'Удельные текущие затраты на 1 м3 по ГМ, тг/м3';
  CASH_EMPLOEE = 'ЗП машинистов и водителей, тыс.тг/мес.';
  KOEF_OF_ROCK = 'Коэффициент вскрыши Кв, т/т, м3/м3';
  KOEF_SHIHTCHANGE = 'Коэф. перехода сменных показателей на период';
  KOEF_PUNKT_BUZY = 'Коэффициент занятости пункта';
  KOEF_AUTOUSE = 'Коэффициент использования автосамосвалов';
  COUNT_EXCV_ON_LOAD = 'Число экскаваторов на погрузке, шт.';
  RASHOD_OF_ELECTRIC = 'Расход электроэнергии, кВт';
  COST_OF_ELECTRIC_1KV = 'Стоимость 1 кВт электроэнергии, тг';
  SUMCOST_OF_EXCV = 'Суммарные затраты по экскаваторам, тг';

  COUNT_OF_UNLOAD_PUNKT = 'Число пунктов выгрузки, шт ';
  SUMCOST_OF_ROAD = 'Суммарные затраты по автотрассе, тг';
  LENGTH_OF_ROAD = 'Общая протяженность автотрассы, км';
  COST_OF_ROAD_SUPPORT = 'Затраты на поддержание 1 км. дорог за период, тыс.тг';
  COUNT_OF_AUTOS = 'Рабочий парк автосамосвалов, шт';
  KPD_AUTO_TRANSMISSION = 'КПД автосамосвалов трансмиссии, %';
  RASHOD_TYRES = 'Удельный расход шин, шт/м3';
  COST_OF_1TYRE = 'Стоимость одной шины, тыс.тг';
  COST_ON_TYRES = 'Затраты на шины, тыс.тн/период';
  COST_ON_1GSM = 'Стоимость 1 литра топлива, тг';
  RASHOD_GSM = 'Удельный расход топлива, г/ткм';
  RASHOD_GSM_FOR_LITER = 'Расход топлива, л';
  SUMCOST_OF_AUTOS = 'Суммарные затраты по автосамосвалам, тг';
  OSTAT_COST = 'Остаточная стоим. оборуд. (экс и а/с), тыс.тг';

  PRODUCT_FROM_1TONNA = 'Выход продукта из одной тонны руды, %';
  PRICE_FOR_1TONNA = 'Цена одной тонны продукта, тыс.тг';
  COST_GTR = 'Стоимость ГТР по плану, млн.тг';
  COST_FOR_AUTO = 'Стоимость приобретаемого автосамосвала, тыс.тг';
  COST_FOR_SERVICE = 'Затраты на сервисное обслуживание, тыс.тг';
  COST_FOR_BASE_VARIANT = 'Затраты по базовому варианту, млн.тг';
  PLANNED_VALUE = 'Запланированный объем ГМ за период, тыс.м3';

  PROFIT = 'Прибыль, млн.тг';
  COSTS = 'Затраты, млн.тг';
  USLOVN_ECONOMIC_EFFECT = 'Условный экономический эффект, млн.тг';
  BASE_VARIANT = 'Базовый вариант, млн.тг';
  OTNOSIT_ECONOMIC_EFFECT = 'Относительный экономический эффект, млн.тг';
  VALUED_ECONOMIC_EFFECT = 'Объемно ориентированный условный ЭЭ, млн.тг';

  FORM_VARIABLES = 'Показатели ЭАК';
  VARIANTS_TITLE = 'Варианты моделирования';
  VARIANT_VARIABLES = 'Основные показатели эффективности ЭАК';
  CEBADAN_VARIABLES = 'Данные с CEBADAN';
  INPUT_VARIABLES = 'Входные данные';
  OUTPUT_VARIABLES = 'Выходные данные';
  _OUTPUT = 'Вывод';
  SET_AS_BASE = 'Установить как'+#13#10+'базовый вариант';
  _SET = 'Установить';
  GET_BASE_DATA = 'Получить данные'+#13#10+'базового варианта';
  _GET = 'Получить';
  ENTER_DATA = 'Ввести'+#13#10+'данные';
  _ENTER = 'Ввести';
  TO_CALC = 'Расчитать'+#13#10+'данные';
  _CALC = 'Расчитать';
  _PRINT_EXCEL = '..в Excel';  

  NAME_OF_VARIANT = 'Наименование варианта';
  DATE_OF_VARIANT = 'Дата создания варианта';

  GRID_TITLE = 'Основные показатели эффективности.';
  GRID_DATE = 'Дата создания: %s';
  GRID_PARAM = 'Параметр';
  GRID_VARIANTS = 'Варианты моделирования';
  GRID_INPUT = 'Входные даные';

  SAVE_REPORT = 'Сохранить сравнительный отчет';

  // SQL
  SELECT_ALL_VARIANTS = 'SELECT Id_ResultVariant, Variant, VariantDate FROM _ResultVariants';
  SELECT_ALL_FROM_RESULT_VARIANT = 'SELECT * ' +
                                   'FROM _ResultVariants';
  SELECT_FROM_RESULT_VARIANT = 'SELECT * ' +
                               'FROM _ResultVariants ' +
                               'WHERE (Id_ResultVariant = :IdVariant)';
  SELECT_OPENPIT_BY_NAME = 'SELECT Id_Openpit FROM Openpits WHERE (Name = :OpenpitName)';
  SELECT_TRANSMISSION_KPD = 'SELECT SUM(TransmissionKPD) AS result FROM OpenpitDeportAutos WHERE Id_Openpit=:Id_Openpit';
  SELECT_COST_OF_EQUIPMENT = 'SELECT SUM(qost) AS result FROM (' +
                             'SELECT SUM(cost) AS qost FROM OpenpitDeportAutos WHERE Id_Openpit=:Id_Openpit ' +
                             'UNION ' +
                             'SELECT SUM(cost) AS qost FROM OpenpitDeportExcavators WHERE Id_Openpit=:Id_Openpit)';
  SELECT_COUNT_OF_UNLOADING_PUNKTS = 'SELECT COUNT(*) AS result FROM OpenpitUnLoadingPunkts WHERE Id_Openpit=:Id_Openpit';
  SELECT_PLAN_ROCKS = 'SELECT SUM(PlannedV1000m3) AS result ' +
                      'FROM OpenpitLoadingPunktRocks ' +
                      'WHERE Id_LoadingPunkt in (SELECT Id_LoadingPunkt ' +
                                                'FROM OpenpitLoadingPunkts ' +
                                                'WHERE Id_Openpit=:Id_Openpit)';
  UPDATE_PLAN_ROCKS = 'UPDATE _ResultVariants ' +
                      'SET PlannedRockVolumeCm=:PlannedRockVolumeCm ' +
                      'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  SELECT_BALANCE_AUTOS = 'SELECT SUM(DumpC1000tg)/COUNT(*) as result ' +
                         'FROM _ResultShiftAutos';
  UPDATE_BALANCE_AUTOS = 'UPDATE _ResultVariants ' +
                         'SET TruckCostCtg=:TruckCostCtg ' +
                         'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  SELECT_BASE_VARIANT = 'SELECT ProductOutPutPercent, ProductPriceCtg, ' +
                               'MTWorkByScheduleCtg, TruckCostCtg, ' +
                               'ServiceExpensesCtg, BaseVariantExpenesCtg, ' +
                               'PlannedRockVolumeCm ' +
                               ',Id_ResultVariant ' +
                        'FROM _ResultVariants ' +
                        'WHERE IsBaseVariant=True';
  UPDATE_CURRENT_INPUT_VALUES = 'UPDATE _ResultVariants ' +
                                'SET ProductOutPutPercent=:ProductOutPutPercent, ' +
                                'ProductPriceCtg=:ProductPriceCtg, ' +
                                'MTWorkByScheduleCtg=:MTWorkByScheduleCtg, ' +
                                'TruckCostCtg=:TruckCostCtg, ' +
                                'ServiceExpensesCtg=:ServiceExpensesCtg, ' +
                                'BaseVariantExpenesCtg=:BaseVariantExpenesCtg, ' +
                                'PlannedRockVolumeCm=:PlannedRockVolumeCm ' +
                                'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  UPDATE_VARIANTS_TO_OFF = 'UPDATE _ResultVariants SET IsBaseVariant=False';
  UPDATE_NEW_BASE_VARIANT = 'UPDATE _ResultVariants SET IsBaseVariant=True WHERE Id_ResultVariant=:NewId_ResultVariant';
  SELECT_COST_GTR_OF_BASE = 'SELECT ServiceExpensesCtg ' +
                            'FROM _ResultVariants ' +
                            'WHERE Id_ResultVariant=(SELECT Id_ResultVariant ' +
                                                    'FROM _ResultVariants ' +
                                                    'WHERE IsBaseVariant=True)';
  UPDATE_COST_GTR_OF_BASE = 'UPDATE _ResultVariants ' +
                            'SET BaseVariantExpenesCtg=:BaseVariantExpenesCtg ' +
                            'WHERE (Id_ResultVariant=:Id_ResultVariant)';
  UPDATE_RESULT_BY_TONNE_OF_ORE = 'UPDATE _ResultVariants ' +
                                  'SET ProductOutPutPercent=:ProductOutPutPercent ' +
                                  'WHERE (Id_ResultVariant=:Id_ResultVariant)';

const
  WIDTH_VARIANT_NAME = 200;


implementation

end.
