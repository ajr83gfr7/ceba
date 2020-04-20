unit unResultEconomEffect_Const;

interface
resourcestring
  WORKFLOW_OF_SHIHT = '������������������ ���� �� �� �� �����, ���.�3.';
  WORKFLOW_OF_YEAR = '������������������ ���� �� �� �� ���, ���.�3.';
  WEIGHT_OF_ORE = '�������� ��� ����, �/�3';
  TIMEFLOW_OF_SHIHT = '����������������� �����, ���';
  COST_OF_GTK = '������� �� �����-������������� ���������, ��';
  COST_OF_M3 = '�������� ������� ������� �� 1 �3 �� ��, ��/�3';
  CASH_EMPLOEE = '�� ���������� � ���������, ���.��/���.';
  KOEF_OF_ROCK = '����������� ������� ��, �/�, �3/�3';
  KOEF_SHIHTCHANGE = '����. �������� ������� ����������� �� ������';
  KOEF_PUNKT_BUZY = '����������� ��������� ������';
  KOEF_AUTOUSE = '����������� ������������� ��������������';
  COUNT_EXCV_ON_LOAD = '����� ������������ �� ��������, ��.';
  RASHOD_OF_ELECTRIC = '������ ��������������, ���';
  COST_OF_ELECTRIC_1KV = '��������� 1 ��� ��������������, ��';
  SUMCOST_OF_EXCV = '��������� ������� �� ������������, ��';

  COUNT_OF_UNLOAD_PUNKT = '����� ������� ��������, �� ';
  SUMCOST_OF_ROAD = '��������� ������� �� ����������, ��';
  LENGTH_OF_ROAD = '����� ������������� ����������, ��';
  COST_OF_ROAD_SUPPORT = '������� �� ����������� 1 ��. ����� �� ������, ���.��';
  COUNT_OF_AUTOS = '������� ���� ��������������, ��';
  KPD_AUTO_TRANSMISSION = '��� �������������� �����������, %';
  RASHOD_TYRES = '�������� ������ ���, ��/�3';
  COST_OF_1TYRE = '��������� ����� ����, ���.��';
  COST_ON_TYRES = '������� �� ����, ���.��/������';
  COST_ON_1GSM = '��������� 1 ����� �������, ��';
  RASHOD_GSM = '�������� ������ �������, �/���';
  RASHOD_GSM_FOR_LITER = '������ �������, �';
  SUMCOST_OF_AUTOS = '��������� ������� �� ��������������, ��';
  OSTAT_COST = '���������� �����. ������. (��� � �/�), ���.��';

  PRODUCT_FROM_1TONNA = '����� �������� �� ����� ����� ����, %';
  PRICE_FOR_1TONNA = '���� ����� ����� ��������, ���.��';
  COST_GTR = '��������� ��� �� �����, ���.��';
  COST_FOR_AUTO = '��������� �������������� �������������, ���.��';
  COST_FOR_SERVICE = '������� �� ��������� ������������, ���.��';
  COST_FOR_BASE_VARIANT = '������� �� �������� ��������, ���.��';
  PLANNED_VALUE = '��������������� ����� �� �� ������, ���.�3';

  PROFIT = '�������, ���.��';
  COSTS = '�������, ���.��';
  USLOVN_ECONOMIC_EFFECT = '�������� ������������� ������, ���.��';
  BASE_VARIANT = '������� �������, ���.��';
  OTNOSIT_ECONOMIC_EFFECT = '������������� ������������� ������, ���.��';
  VALUED_ECONOMIC_EFFECT = '������� ��������������� �������� ��, ���.��';

  FORM_VARIABLES = '���������� ���';
  VARIANTS_TITLE = '�������� �������������';
  VARIANT_VARIABLES = '�������� ���������� ������������� ���';
  CEBADAN_VARIABLES = '������ � CEBADAN';
  INPUT_VARIABLES = '������� ������';
  OUTPUT_VARIABLES = '�������� ������';
  _OUTPUT = '�����';
  SET_AS_BASE = '���������� ���'+#13#10+'������� �������';
  _SET = '����������';
  GET_BASE_DATA = '�������� ������'+#13#10+'�������� ��������';
  _GET = '��������';
  ENTER_DATA = '������'+#13#10+'������';
  _ENTER = '������';
  TO_CALC = '���������'+#13#10+'������';
  _CALC = '���������';
  _PRINT_EXCEL = '..� Excel';  

  NAME_OF_VARIANT = '������������ ��������';
  DATE_OF_VARIANT = '���� �������� ��������';

  GRID_TITLE = '�������� ���������� �������������.';
  GRID_DATE = '���� ��������: %s';
  GRID_PARAM = '��������';
  GRID_VARIANTS = '�������� �������������';
  GRID_INPUT = '������� �����';

  SAVE_REPORT = '��������� ������������� �����';

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
