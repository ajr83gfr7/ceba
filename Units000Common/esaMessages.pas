unit esaMessages;

interface
const
  SesaOperationAdd             = 'Добавить';
  SesaOperationEdit            = 'Изменить';
  //Common
  SesaChangesSavingConfirm     = 'Сохранить изменения в таблице ''%s''?';
  EesaFileNotFound             = 'Не найден файл ''%s''.';
  SesaDeleteConfirm            = 'При удалении данной записи будут потеряны все данные, связанные с ней.'+#13#10+'Удалить "%s"?';
  SesaDeleteAllConfirm         = 'При удалении записей будут потеряны все данные, связанные с ними.'+#13#10+'Удалить все записи?';
  SesaDefaultConfirm           = 'Установить значения данной записи как значения по умолчанию?';
  EesaInvalidRimpullFormat     = 'Ошибка чтения файла тяговых характеристик автосамосвала ''%s''.'#13#10' - %s.';
  EesaInvalidIndex             = 'Неверное значение индекса %d. Допустимый диапазон: [0..%d].';
  //Invalid Values
  EesaInvalidValue             = 'Не введено значение обязательного поля ''%s''.';
  EesaInvalidCharacter         = 'Недопустимый символ ''%s'' в значении ''%s''.';
  EesaInvalidIntegerValueRange = 'Неверное целочисленное значение ''%d''. Допустимый диапазон: %d..%d.';
  EesaInvalidIntegerFieldValue = 'Неверное значение %d поля ''%s''. Допустимый диапазон: %d..%d.';
  EesaInvalidIntegerField      = 'Ошибка проверки значения целочисленного поля.'+#13#10+' - %s.';
  EesaInvalidFloatFieldValue1  = 'Неверное значение %.1f поля ''%s''. Допустимый диапазон: %.1f..%.1f.';
  EesaInvalidFloatFieldValue2  = 'Неверное значение %.2f поля ''%s''. Допустимый диапазон: %.2f..%.2f.';
  EesaInvalidFloatFieldValue3  = 'Неверное значение %.3f поля ''%s''. Допустимый диапазон: %.3f..%.3f.';
  EesaInvalidFloatFieldValue4  = 'Неверное значение %.4f поля ''%s''. Допустимый диапазон: %.4f..%.4f.';
  EesaInvalidFloatField        = 'Ошибка проверки значения целочисленного поля.'+#13#10+' - %s.';
  //AutoEngines
  EesaAutoEnginesEmpty         = 'Нет данных по двигателям автосамосвалов.';
  //AutoModels
  EesaAutoModelsEmpty          = 'Нет данных по моделям автосамосвалов.';
  EesaAutoModelsDuplicateName  = 'Модель автосамосвала с наименованием ''%s'' уже существует.';
  //Autos
  EesaAutosDuplicateParkNo     = 'Автосамосвал с гаражным номером ''%d'' уже существует.';
  SesaAutoParkNo               = 'Гаражный номер';
  EesaInvalidDeleteAutos       = 'Ошибка выполнения операции удаления автосамосвала(ов) списочного парка.'+#13#10+' - %s.';
  EesaInvalidMoveUpAuto        = 'Ошибка выполнения операции перемещения вверх автосамосвала списочного парка.'+#13#10+' - %s.';
  EesaInvalidMoveDnAuto        = 'Ошибка выполнения операции перемещения вниз автосамосвала списочного парка.'+#13#10+' - %s.';
  EesaInvalidCloneAutos        = 'Ошибка клонирования автосамосвала списочного парка.'+#13#10+' - %s.';
  //Шаблоны для функции Format
  EesaInvalidSingleValue       = 'Неверное вещественное значение "%s" для поля "%s".';
  EesaInvalidSingleValueEx     = 'Неверное вещественное значение "%s" для поля "%s". Допустимый диапазон: [%f..%f].';
  EesaInvalidIntegerValue      = 'Неверное целое значение "%s" для поля "%s".';
  EesaInvalidIntegerValueEx    = 'Неверное целое значение "%s" для поля "%s". Допустимый диапазон: [%d..%d].';

implementation

end.
