unit esaMessages;

interface
const
  SesaOperationAdd             = '��������';
  SesaOperationEdit            = '��������';
  //Common
  SesaChangesSavingConfirm     = '��������� ��������� � ������� ''%s''?';
  EesaFileNotFound             = '�� ������ ���� ''%s''.';
  SesaDeleteConfirm            = '��� �������� ������ ������ ����� �������� ��� ������, ��������� � ���.'+#13#10+'������� "%s"?';
  SesaDeleteAllConfirm         = '��� �������� ������� ����� �������� ��� ������, ��������� � ����.'+#13#10+'������� ��� ������?';
  SesaDefaultConfirm           = '���������� �������� ������ ������ ��� �������� �� ���������?';
  EesaInvalidRimpullFormat     = '������ ������ ����� ������� ������������� ������������� ''%s''.'#13#10' - %s.';
  EesaInvalidIndex             = '�������� �������� ������� %d. ���������� ��������: [0..%d].';
  //Invalid Values
  EesaInvalidValue             = '�� ������� �������� ������������� ���� ''%s''.';
  EesaInvalidCharacter         = '������������ ������ ''%s'' � �������� ''%s''.';
  EesaInvalidIntegerValueRange = '�������� ������������� �������� ''%d''. ���������� ��������: %d..%d.';
  EesaInvalidIntegerFieldValue = '�������� �������� %d ���� ''%s''. ���������� ��������: %d..%d.';
  EesaInvalidIntegerField      = '������ �������� �������� �������������� ����.'+#13#10+' - %s.';
  EesaInvalidFloatFieldValue1  = '�������� �������� %.1f ���� ''%s''. ���������� ��������: %.1f..%.1f.';
  EesaInvalidFloatFieldValue2  = '�������� �������� %.2f ���� ''%s''. ���������� ��������: %.2f..%.2f.';
  EesaInvalidFloatFieldValue3  = '�������� �������� %.3f ���� ''%s''. ���������� ��������: %.3f..%.3f.';
  EesaInvalidFloatFieldValue4  = '�������� �������� %.4f ���� ''%s''. ���������� ��������: %.4f..%.4f.';
  EesaInvalidFloatField        = '������ �������� �������� �������������� ����.'+#13#10+' - %s.';
  //AutoEngines
  EesaAutoEnginesEmpty         = '��� ������ �� ���������� ��������������.';
  //AutoModels
  EesaAutoModelsEmpty          = '��� ������ �� ������� ��������������.';
  EesaAutoModelsDuplicateName  = '������ ������������� � ������������� ''%s'' ��� ����������.';
  //Autos
  EesaAutosDuplicateParkNo     = '������������ � �������� ������� ''%d'' ��� ����������.';
  SesaAutoParkNo               = '�������� �����';
  EesaInvalidDeleteAutos       = '������ ���������� �������� �������� �������������(��) ���������� �����.'+#13#10+' - %s.';
  EesaInvalidMoveUpAuto        = '������ ���������� �������� ����������� ����� ������������� ���������� �����.'+#13#10+' - %s.';
  EesaInvalidMoveDnAuto        = '������ ���������� �������� ����������� ���� ������������� ���������� �����.'+#13#10+' - %s.';
  EesaInvalidCloneAutos        = '������ ������������ ������������� ���������� �����.'+#13#10+' - %s.';
  //������� ��� ������� Format
  EesaInvalidSingleValue       = '�������� ������������ �������� "%s" ��� ���� "%s".';
  EesaInvalidSingleValueEx     = '�������� ������������ �������� "%s" ��� ���� "%s". ���������� ��������: [%f..%f].';
  EesaInvalidIntegerValue      = '�������� ����� �������� "%s" ��� ���� "%s".';
  EesaInvalidIntegerValueEx    = '�������� ����� �������� "%s" ��� ���� "%s". ���������� ��������: [%d..%d].';

implementation

end.
