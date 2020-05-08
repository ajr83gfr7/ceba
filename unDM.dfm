object fmDM: TfmDM
  OldCreateOrder = False
  Left = 654
  Top = 102
  Height = 748
  Width = 993
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=Cebad' +
      'anAuto.mdb;Mode=Share Deny None;Persist Security Info=False;Jet ' +
      'OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Da' +
      'tabase Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Lo' +
      'cking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Globa' +
      'l Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLE' +
      'DB:Create System Database=False;Jet OLEDB:Encrypt Database=False' +
      ';Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact ' +
      'Without Replica Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 664
    Top = 648
  end
  object quAutoEngines: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM AutoEngines'
      'ORDER BY SortIndex')
    Left = 40
    Top = 19
    object quAutoEnginesId_Engine: TAutoIncField
      FieldName = 'Id_Engine'
      ReadOnly = True
    end
    object quAutoEnginesSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quAutoEnginesName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Name'
      Size = 50
    end
    object quAutoEnginesNmax: TFloatField
      DisplayLabel = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
      FieldName = 'Nmax'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
  end
  object dsAutoEngines: TDataSource
    DataSet = quAutoEngines
    Left = 40
    Top = 67
  end
  object quAutos: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quAutosCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Autos'
      'ORDER BY SortIndex')
    Left = 40
    Top = 115
    object quAutosId_Auto: TAutoIncField
      FieldName = 'Id_Auto'
      ReadOnly = True
    end
    object quAutosSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quAutosName: TWideStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
      FieldName = 'Name'
      Size = 50
    end
    object quAutosBodySpace: TFloatField
      DisplayLabel = #1054#1073#1098#1077#1084' '#1082#1091#1079#1086#1074#1072', '#1084'.'#1082#1091#1073'.'
      FieldName = 'BodySpace'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosTonnage: TFloatField
      DisplayLabel = #1043#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100', '#1090
      FieldName = 'Tonnage'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosStrQtn: TStringField
      DisplayLabel = #1043#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100', '#1090
      FieldKind = fkCalculated
      FieldName = 'StrQtn'
      Size = 10
      Calculated = True
    end
    object quAutosP: TFloatField
      DisplayLabel = #1052#1072#1089#1089#1072' '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1103', '#1090'.'
      FieldName = 'P'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosF: TFloatField
      DisplayLabel = #1055#1083#1086#1097#1072#1076#1100' '#1083#1086#1073#1086#1074#1086#1081' '#1087#1086#1074#1077#1088#1093#1085#1086#1089#1090#1080', '#1082#1074'.'#1084'.'
      FieldName = 'F'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosRo: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1086#1073#1090#1077#1082#1072#1077#1084#1086#1089#1090#1080
      FieldName = 'Ro'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosTransmissionKind: TIntegerField
      DisplayLabel = #1058#1088#1072#1085#1089#1084#1080#1089#1089#1080#1103
      FieldName = 'TransmissionKind'
      OnGetText = quAutosTransmissionKindGetText
      OnSetText = quAutosTransmissionKindSetText
    end
    object quAutosTransmissionKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
      FieldName = 'TransmissionKPD'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutost_r: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1088#1072#1079#1075#1088#1091#1079#1082#1080', '#1089
      FieldName = 't_r'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosRmin: TFloatField
      DisplayLabel = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1088#1072#1076#1080#1091#1089' '#1087#1086#1074#1086#1088#1086#1090#1072', '#1084
      FieldName = 'Rmin'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosTyresCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1096#1080#1085
      FieldName = 'TyresCount'
    end
    object quAutosALength: TFloatField
      DisplayLabel = #1044#1083#1080#1085#1072', '#1084
      FieldName = 'ALength'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosAWidth: TFloatField
      DisplayLabel = #1064#1080#1088#1080#1085#1072', '#1084
      FieldName = 'AWidth'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosAHeight: TFloatField
      DisplayLabel = #1042#1099#1089#1086#1090#1072', '#1084
      FieldName = 'AHeight'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutosId_Engine: TIntegerField
      FieldName = 'Id_Engine'
    end
    object quAutosEngineName: TStringField
      DisplayLabel = #1052#1072#1088#1082#1072' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldKind = fkLookup
      FieldName = 'EngineName'
      LookupDataSet = quAutoEngines
      LookupKeyFields = 'Id_Engine'
      LookupResultField = 'Name'
      KeyFields = 'Id_Engine'
      ReadOnly = True
      Size = 50
      Lookup = True
    end
    object quAutosEngineNmax: TFloatField
      DisplayLabel = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
      FieldKind = fkLookup
      FieldName = 'EngineNmax'
      LookupDataSet = quAutoEngines
      LookupKeyFields = 'Id_Engine'
      LookupResultField = 'Nmax'
      KeyFields = 'Id_Engine'
      ReadOnly = True
      DisplayFormat = '#,###,##0.00'
      Lookup = True
    end
    object quAutosNote: TMemoField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FieldName = 'Note'
      BlobType = ftMemo
    end
    object quAutosBalanceC1000tg: TFloatField
      FieldName = 'BalanceC1000tg'
    end
  end
  object dsAutos: TDataSource
    DataSet = quAutos
    Left = 40
    Top = 164
  end
  object quDeportAutos: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quDeportAutosCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 116
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitDeportAutos'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex')
    Left = 160
    Top = 19
    object quDeportAutosId_DeportAuto: TAutoIncField
      FieldName = 'Id_DeportAuto'
      ReadOnly = True
    end
    object quDeportAutosSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quDeportAutosId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quDeportAutosId_Auto: TIntegerField
      FieldName = 'Id_Auto'
    end
    object quDeportAutosParkNo: TIntegerField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1074' '#1087#1072#1088#1082#1077
      FieldName = 'ParkNo'
      DisplayFormat = '00'
      EditFormat = '0'
    end
    object quDeportAutosAYear: TIntegerField
      DisplayLabel = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072
      FieldName = 'AYear'
      DisplayFormat = '0000'
    end
    object quDeportAutosFactTonnage: TFloatField
      DisplayLabel = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1075#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100', '#1090
      FieldName = 'FactTonnage'
      DisplayFormat = '0.0'
    end
    object quDeportAutosWorkState: TBooleanField
      DisplayLabel = #1056#1072#1073#1086#1095#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
      FieldName = 'WorkState'
      OnGetText = quDeportExcavatorsWorkStateGetText
    end
    object quDeportAutosCost: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100', '#1090#1099#1089'.'#1090#1085'.'
      FieldName = 'Cost'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quDeportAutosAmortizationKind: TIntegerField
      FieldName = 'AmortizationKind'
      OnGetText = quDeportAutosAmortizationKindGetText
      OnSetText = quDeportAutosAmortizationKindSetText
    end
    object quDeportAutosAmortizationRate: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'AmortizationRate'
      DisplayFormat = '0.0000'
    end
    object quDeportAutosTransmissionKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
      FieldName = 'TransmissionKPD'
      DisplayFormat = '0.00'
    end
    object quDeportAutosEngineKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldName = 'EngineKPD'
      DisplayFormat = '0.00'
    end
    object quDeportAutosTyreCost: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' 1 '#1096#1080#1085#1099', '#1090#1099#1089'.'#1090#1085
      FieldName = 'TyreCost'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quDeportAutosName: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Name'
      KeyFields = 'Id_Auto'
      Size = 50
      Lookup = True
    end
    object quDeportAutosTotalName: TStringField
      FieldKind = fkCalculated
      FieldName = 'TotalName'
      Size = 50
      Calculated = True
    end
    object quDeportAutosTyresRaceRate: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1087#1088#1086#1073#1077#1075#1072' '#1096#1080#1085' '#1085#1072' 1000 '#1082#1084
      FieldName = 'TyresRaceRate'
      DisplayFormat = '0.00'
    end
    object quDeportAutosId_ShiftPunkt: TIntegerField
      FieldName = 'Id_ShiftPunkt'
    end
    object quDeportAutosId_Course: TIntegerField
      FieldName = 'Id_Course'
    end
    object quDeportAutosShiftPunkt: TWideStringField
      DisplayLabel = #1055#1091#1085#1082#1090' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080
      FieldName = 'ShiftPunkt'
      Size = 50
    end
    object quDeportAutosCourse: TWideStringField
      DisplayLabel = #1052#1072#1088#1096#1088#1091#1090' '#1076#1074#1080#1078#1077#1085#1080#1103
      DisplayWidth = 100
      FieldName = 'Course'
      Size = 100
    end
    object quDeportAutosNetQtn: TFloatField
      FieldKind = fkLookup
      FieldName = 'NetQtn'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Tonnage'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.0'
      Lookup = True
    end
    object quDeportAutosNetPtn: TFloatField
      FieldKind = fkLookup
      FieldName = 'NetPtn'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'P'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.0'
      Lookup = True
    end
    object quDeportAutosTransmissionKind: TIntegerField
      FieldKind = fkLookup
      FieldName = 'TransmissionKind'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'TransmissionKind'
      KeyFields = 'Id_Auto'
      OnGetText = quAutosTransmissionKindGetText
      Lookup = True
    end
    object quDeportAutosTransmissionNetKPD: TFloatField
      FieldKind = fkLookup
      FieldName = 'TransmissionNetKPD'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'TransmissionKPD'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.00'
      Lookup = True
    end
    object quDeportAutosNetUnloadingTsec: TFloatField
      FieldKind = fkLookup
      FieldName = 'NetUnloadingTsec'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 't_r'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.0'
      Lookup = True
    end
    object quDeportAutosNetRm: TFloatField
      FieldKind = fkLookup
      FieldName = 'NetRm'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Rmin'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.0'
      Lookup = True
    end
    object quDeportAutosNetTyresCount: TIntegerField
      FieldKind = fkLookup
      FieldName = 'NetTyresCount'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'TyresCount'
      KeyFields = 'Id_Auto'
      Lookup = True
    end
    object quDeportAutosEngine: TStringField
      FieldKind = fkLookup
      FieldName = 'Engine'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'EngineName'
      KeyFields = 'Id_Auto'
      Size = 50
      Lookup = True
    end
    object quDeportAutosEngineNetNkvt: TFloatField
      FieldKind = fkLookup
      FieldName = 'EngineNetNkvt'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'EngineNmax'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.0'
      Lookup = True
    end
    object quDeportAutosNetBalanceC1000tg: TFloatField
      FieldKind = fkLookup
      FieldName = 'NetBalanceC1000tg'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'BalanceC1000tg'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.00'
      Lookup = True
    end
    object quDeportAutosLm: TFloatField
      FieldKind = fkLookup
      FieldName = 'Lm'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'ALength'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.00'
      Lookup = True
    end
    object quDeportAutosWm: TFloatField
      FieldKind = fkLookup
      FieldName = 'Wm'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'AWidth'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.00'
      Lookup = True
    end
    object quDeportAutosHm: TFloatField
      FieldKind = fkLookup
      FieldName = 'Hm'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'AHeight'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.00'
      Lookup = True
    end
    object quDeportAutosBodyHeapVm3: TFloatField
      FieldKind = fkLookup
      FieldName = 'BodyHeapVm3'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'BodySpace'
      KeyFields = 'Id_Auto'
      DisplayFormat = '# ### ### ##0.0'
      Lookup = True
    end
  end
  object dsDeportAutos: TDataSource
    DataSet = quDeportAutos
    Left = 160
    Top = 67
  end
  object quAutoFks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quAutoFksCalcFields
    DataSource = dsAutos
    Parameters = <
      item
        Name = 'Id_Auto'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM AutoFks'
      'WHERE Id_Auto=:Id_Auto'
      'ORDER BY V')
    Left = 40
    Top = 212
    object quAutoFksId_FK: TAutoIncField
      FieldName = 'Id_FK'
      ReadOnly = True
    end
    object quAutoFksId_Auto: TIntegerField
      FieldName = 'Id_Auto'
    end
    object quAutoFksNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quAutoFksV: TFloatField
      DisplayLabel = #1057#1082#1086#1088#1086#1089#1090#1100' V, '#1082#1084'/'#1095
      FieldName = 'V'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quAutoFksFk: TFloatField
      DisplayLabel = #1057#1080#1083#1072' '#1090#1103#1075#1080' Fk, '#1082#1053
      FieldName = 'Fk'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
  end
  object dsAutoFks: TDataSource
    DataSet = quAutoFks
    Left = 40
    Top = 260
  end
  object quExcavatorEngines: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM ExcavatorEngines'
      'ORDER BY SortIndex')
    Left = 40
    Top = 309
    object quExcavatorEnginesId_Engine: TAutoIncField
      FieldName = 'Id_Engine'
      ReadOnly = True
    end
    object quExcavatorEnginesSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quExcavatorEnginesName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 10
      FieldName = 'Name'
      Size = 50
    end
    object quExcavatorEnginesNmax: TFloatField
      DisplayLabel = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
      FieldName = 'Nmax'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
  end
  object dsExcavatorEngines: TDataSource
    DataSet = quExcavatorEngines
    Left = 40
    Top = 357
  end
  object quExcavators: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Excavators'
      'ORDER BY SortIndex')
    Left = 40
    Top = 406
    object quExcavatorsId_Excavator: TAutoIncField
      FieldName = 'Id_Excavator'
      ReadOnly = True
    end
    object quExcavatorsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quExcavatorsName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Name'
      Size = 50
    end
    object quExcavatorsBucketCapacity: TFloatField
      DisplayLabel = #1045#1084#1082#1086#1089#1090#1100' '#1082#1086#1074#1096#1072', '#1082#1091#1073'.'#1084'.'
      FieldName = 'BucketCapacity'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quExcavatorsCycleTime: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1094#1080#1082#1083#1072', '#1089
      FieldName = 'CycleTime'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quExcavatorsId_Engine: TIntegerField
      FieldName = 'Id_Engine'
    end
    object quExcavatorsELength: TFloatField
      DisplayLabel = #1044#1083#1080#1085#1072', '#1084
      FieldName = 'ELength'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quExcavatorsEWidth: TFloatField
      DisplayLabel = #1064#1080#1088#1080#1085#1072', '#1084
      FieldName = 'EWidth'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quExcavatorsEHeight: TFloatField
      DisplayLabel = #1042#1099#1089#1086#1090#1072', '#1084
      FieldName = 'EHeight'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quExcavatorsEngineName: TStringField
      DisplayLabel = #1044#1074#1080#1075#1072#1090#1077#1083#1100
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'EngineName'
      LookupDataSet = quExcavatorEngines
      LookupKeyFields = 'Id_Engine'
      LookupResultField = 'Name'
      KeyFields = 'Id_Engine'
      Size = 50
      Lookup = True
    end
    object quExcavatorsEngineNmax: TFloatField
      DisplayLabel = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
      FieldKind = fkLookup
      FieldName = 'EngineNmax'
      LookupDataSet = quExcavatorEngines
      LookupKeyFields = 'Id_Engine'
      LookupResultField = 'Nmax'
      KeyFields = 'Id_Engine'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
      Lookup = True
    end
    object quExcavatorsNote: TMemoField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FieldName = 'Note'
      BlobType = ftMemo
    end
  end
  object dsExcavators: TDataSource
    DataSet = quExcavators
    Left = 40
    Top = 454
  end
  object quOpenpits: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quOpenpitsCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM Openpits')
    Left = 408
    Top = 19
    object quOpenpitsId_Openpit: TAutoIncField
      FieldName = 'Id_Openpit'
      ReadOnly = True
    end
    object quOpenpitsNo: TIntegerField
      DisplayLabel = #8470
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quOpenpitsName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 210
      FieldName = 'Name'
      Size = 50
    end
    object quOpenpitsDateCreate: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      DisplayWidth = 112
      FieldName = 'DateCreate'
    end
    object quOpenpitsNote: TWideStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      DisplayWidth = 200
      FieldName = 'Note'
      Size = 200
    end
    object quOpenpitsTotalKurs: TFloatField
      DisplayLabel = #1050#1091#1088#1089' '#1076#1086#1083#1083#1072#1088#1072', '#1090#1077#1085#1075#1077
      FieldName = 'TotalKurs'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsTotalExpenses: TFloatField
      DisplayLabel = #1042#1077#1083#1080#1095#1080#1085#1072' '#1087#1086#1089#1090#1086#1103#1085#1085#1099#1093' '#1080' '#1085#1077#1091#1095#1090#1077#1085#1085#1099#1093' '#1088#1072#1089#1093#1086#1076#1086#1074', '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1075#1086#1076
      FieldName = 'TotalExpenses'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsTotalSalaryCoef: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1091#1095#1077#1090#1072' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1081' '#1080#1079' '#1092#1086#1085#1076#1072' '#1079#1072#1088#1072#1073#1086#1090#1085#1086#1081' '#1087#1083#1072#1090#1099
      FieldName = 'TotalSalaryCoef'
      DisplayFormat = '# ### ##0.0000'
      EditFormat = '0.0000'
    end
    object quOpenpitsTotalShiftUsingCoefNormal: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1084#1077#1085#1099' '#1074' '#1085#1086#1088#1084#1072#1083#1100#1085#1099#1093' '#1091#1089#1083#1086#1074#1080#1103#1093
      FieldName = 'TotalShiftUsingCoefNormal'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsTotalShiftUsingCoefDayShift: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1084#1077#1085#1099' '#1076#1085#1077#1074#1085#1099#1093' '#1089#1084#1077#1085
      FieldName = 'TotalShiftUsingCoefDayShift'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsTotalShiftUsingCoefExplosion: TFloatField
      DisplayLabel = 
        #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1084#1077#1085#1099' '#1074' '#1076#1077#1085#1100' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072' '#1074#1079#1088#1099 +
        #1074#1086#1074
      FieldName = 'TotalShiftUsingCoefExplosion'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsTotalShiftUsingCoefExplosionCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1079#1088#1099#1074#1086#1074' '#1074' '#1085#1077#1076#1077#1083#1102
      FieldName = 'TotalShiftUsingCoefExplosionCount'
    end
    object quOpenpitsExcavsSalaryMashinist0: TFloatField
      DisplayLabel = #1054#1087#1083#1072#1090#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' ('#1086#1089#1085#1086#1074#1085#1072#1103'), '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089'.'
      FieldName = 'ExcavsSalaryMashinist0'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsExcavsSalaryMashinist1: TFloatField
      DisplayLabel = #1054#1087#1083#1072#1090#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' ('#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103'), '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089'.'
      FieldName = 'ExcavsSalaryMashinist1'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsExcavsSalaryAssistant0: TFloatField
      DisplayLabel = #1054#1087#1083#1072#1090#1072' '#1087#1086#1084#1086#1097#1085#1080#1082#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' ('#1086#1089#1085#1086#1074#1085#1072#1103'), '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089'.'
      FieldName = 'ExcavsSalaryAssistant0'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsExcavsSalaryAssistant1: TFloatField
      DisplayLabel = #1054#1087#1083#1072#1090#1072' '#1087#1086#1084#1086#1097#1085#1080#1082#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' ('#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103'), '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089'.'
      FieldName = 'ExcavsSalaryAssistant1'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsExcavsWorkShiftsCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1073#1086#1095#1080#1093' '#1089#1084#1077#1085' '#1074' '#1084#1077#1089#1103#1094
      FieldName = 'ExcavsWorkShiftsCount'
    end
    object quOpenpitsExcavsWorkShiftDuration: TFloatField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099', '#1095#1072#1089
      FieldName = 'ExcavsWorkShiftDuration'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsExcavsShiftTurnoverTime: TIntegerField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
      FieldName = 'ExcavsShiftTurnoverTime'
    end
    object quOpenpitsExcavsEnergyCost: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1101#1083#1077#1082#1090#1088#1086#1101#1085#1077#1088#1075#1080#1080', '#1090#1077#1085#1075#1077'/'#1082#1042#1090'*'#1095#1072#1089
      FieldName = 'ExcavsEnergyCost'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsExcavsAmortazationNorm: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'ExcavsAmortazationNorm'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsAutosSalary0: TFloatField
      DisplayLabel = #1054#1087#1083#1072#1090#1072' '#1074#1086#1076#1080#1090#1077#1083#1103' ('#1086#1089#1085#1086#1074#1085#1072#1103'), '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089'.'
      FieldName = 'AutosSalary0'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsAutosSalary1: TFloatField
      DisplayLabel = #1054#1087#1083#1072#1090#1072' '#1074#1086#1076#1080#1090#1077#1083#1103' ('#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103'), '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089'.'
      FieldName = 'AutosSalary1'
      DisplayFormat = '# ### ##0.000'
      EditFormat = '0.000'
    end
    object quOpenpitsAutosWorkShiftsCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1073#1086#1095#1080#1093' '#1089#1084#1077#1085' '#1074' '#1084#1077#1089#1103#1094
      FieldName = 'AutosWorkShiftsCount'
    end
    object quOpenpitsAutosWorkShiftDuration: TFloatField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099', '#1095#1072#1089
      FieldName = 'AutosWorkShiftDuration'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsAutosShiftTurnoverTime: TIntegerField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
      FieldName = 'AutosShiftTurnoverTime'
    end
    object quOpenpitsAutosFuelCostWinter: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1086#1087#1083#1080#1074#1072' "'#1047#1080#1084#1085#1077#1077'", '#1090#1077#1085#1075#1077'/'#1083#1080#1090#1088
      FieldName = 'AutosFuelCostWinter'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsAutosFuelCostSummer: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1086#1087#1083#1080#1074#1072' "'#1051#1077#1090#1085#1077#1077'", '#1090#1077#1085#1075#1077'/'#1083#1080#1090#1088
      FieldName = 'AutosFuelCostSummer'
      DisplayFormat = '# ### ##0.00'
      EditFormat = '0.00'
    end
    object quOpenpitsAutosWinterMonthCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1080#1084#1085#1080#1093' '#1084#1077#1089#1103#1094#1077#1074' '#1074' '#1075#1086#1076#1091
      FieldName = 'AutosWinterMonthCount'
    end
    object quOpenpitsAutosFuelCostTarif: TIntegerField
      DisplayLabel = #1059#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1090#1086#1087#1083#1080#1074#1072
      FieldName = 'AutosFuelCostTarif'
      OnGetText = quOpenpitsAutosFuelCostTarifGetText
      OnSetText = quOpenpitsAutosFuelCostTarifSetText
    end
    object quOpenpitsWorkRegimeKind: TIntegerField
      DisplayLabel = 
        #1055#1088#1080#1079#1085#1072#1082' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1087#1086#1088#1086#1078#1085#1080#1093' '#1072#1074#1090#1086' '#1087#1088#1080' '#1086#1090#1082#1088#1099#1090#1086#1084' '#1094#1080#1082#1083#1077': 0-'#1091#1089#1088#1077#1076#1085 +
        #1077#1085#1080#1077' '#1082#1072#1095#1077#1089#1090#1074#1072', 1-'#1088#1072#1074#1085#1086#1084#1077#1088#1085#1086#1077' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1086' '#1055#1055
      FieldName = 'WorkRegimeKind'
      OnGetText = quOpenpitsWorkRegimeKindGetText
      OnSetText = quOpenpitsWorkRegimeKindSetText
    end
    object quOpenpitsWorkRegimeIsStrippingCoefUsing: TBooleanField
      DisplayLabel = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1074#1089#1082#1088#1099#1096#1080'?'
      FieldName = 'WorkRegimeIsStrippingCoefUsing'
    end
    object quOpenpitsParamsShiftDuration: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1089#1084#1077#1085#1099', '#1084#1080#1085
      FieldName = 'ParamsShiftDuration'
    end
    object quOpenpitsParamsPeriodDuration: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1089#1089#1084#1072#1090#1088#1080#1074#1072#1077#1084#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072', '#1076#1085#1080
      FieldName = 'ParamsPeriodDuration'
    end
    object quOpenpitsParamsIsAccumulateData: TBooleanField
      DisplayLabel = #1053#1072#1082#1072#1087#1083#1080#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077'?'
      FieldName = 'ParamsIsAccumulateData'
    end
    object quOpenpitsParamsAnimationTimeScale: TIntegerField
      DisplayLabel = #1052#1072#1089#1096#1090#1072#1073' '#1074#1088#1077#1084#1077#1085#1080' '#1072#1085#1080#1084#1072#1094#1080#1080', 1'#1093
      FieldName = 'ParamsAnimationTimeScale'
    end
    object quOpenpitsMinX: TFloatField
      FieldName = 'MinX'
      DisplayFormat = '0.000'
      EditFormat = '0'
    end
    object quOpenpitsMinY: TFloatField
      FieldName = 'MinY'
      DisplayFormat = '0.000'
      EditFormat = '0'
    end
    object quOpenpitsMinZ: TFloatField
      FieldName = 'MinZ'
      DisplayFormat = '0.000'
      EditFormat = '0'
    end
    object quOpenpitsMaxX: TFloatField
      FieldName = 'MaxX'
      DisplayFormat = '0.000'
      EditFormat = '0'
    end
    object quOpenpitsMaxY: TFloatField
      FieldName = 'MaxY'
      DisplayFormat = '0.000'
      EditFormat = '0'
    end
    object quOpenpitsMaxZ: TFloatField
      FieldName = 'MaxZ'
      DisplayFormat = '0.000'
      EditFormat = '0'
    end
    object quOpenpitsResultStrippingCoef: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1074#1089#1082#1088#1099#1096#1080
      FieldName = 'ResultStrippingCoef'
      DisplayFormat = '0.00'
    end
    object quOpenpitsResultTnaryadSec: TIntegerField
      DisplayLabel = 'T'#1074' '#1085#1072#1088#1103#1076#1077', '#1089#1077#1082
      FieldName = 'ResultTnaryadSec'
    end
    object quOpenpitsResultPeriodCoef: TFloatField
      FieldName = 'ResultPeriodCoef'
    end
  end
  object dsOpenpits: TDataSource
    DataSet = quOpenpits
    Left = 408
    Top = 67
  end
  object quPoints: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitPoints'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY Id_Point')
    Left = 408
    Top = 115
    object quPointsId_Point: TAutoIncField
      FieldName = 'Id_Point'
      ReadOnly = True
    end
    object quPointsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quPointsX: TFloatField
      FieldName = 'X'
    end
    object quPointsY: TFloatField
      FieldName = 'Y'
    end
    object quPointsZ: TFloatField
      FieldName = 'Z'
    end
  end
  object dsPoints: TDataSource
    DataSet = quPoints
    Left = 408
    Top = 164
  end
  object quRoadCoats: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM RoadCoats'
      'ORDER BY SortIndex')
    Left = 40
    Top = 502
    object quRoadCoatsId_RoadCoat: TAutoIncField
      DisplayWidth = 5
      FieldName = 'Id_RoadCoat'
      ReadOnly = True
    end
    object quRoadCoatsName: TWideStringField
      DisplayWidth = 120
      FieldName = 'Name'
      Size = 100
    end
    object quRoadCoatsSortIndex: TIntegerField
      DisplayLabel = #8470
      DisplayWidth = 12
      FieldName = 'SortIndex'
    end
    object quRoadCoatsShortName: TWideStringField
      DisplayLabel = #1057#1086#1082#1088#1072#1097#1077#1085#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'ShortName'
    end
  end
  object dsRoadCoats: TDataSource
    DataSet = quRoadCoats
    Left = 40
    Top = 551
  end
  object quRoadCoatUSKs: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quRoadCoatUSKsCalcFields
    DataSource = dsRoadCoats
    Parameters = <
      item
        Name = 'Id_RoadCoat'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM RoadCoatUSKs'
      'WHERE Id_RoadCoat=:Id_RoadCoat'
      'ORDER BY P')
    Left = 40
    Top = 599
    object quRoadCoatUSKsId_USK: TAutoIncField
      FieldName = 'Id_USK'
      ReadOnly = True
    end
    object quRoadCoatUSKsId_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quRoadCoatUSKsNo: TIntegerField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quRoadCoatUSKsP: TFloatField
      DisplayLabel = 'P, '#1090
      FieldName = 'P'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quRoadCoatUSKsValueMin: TFloatField
      DisplayLabel = #1052#1080#1085'.'#1079#1085#1072#1095#1077#1085#1080#1077
      FieldName = 'ValueMin'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quRoadCoatUSKsValueMax: TFloatField
      DisplayLabel = #1052#1072#1082#1089'.'#1079#1085#1072#1095#1077#1085#1080#1077
      FieldName = 'ValueMax'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quRoadCoatUSKsValue: TFloatField
      DisplayLabel = #1057#1088#1077#1076#1085#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      FieldKind = fkCalculated
      FieldName = 'Value'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
      Calculated = True
    end
  end
  object dsRoadCoatUSKs: TDataSource
    DataSet = quRoadCoatUSKs
    Left = 40
    Top = 648
  end
  object quBlocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitBlocks'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 408
    Top = 212
    object quBlocksId_Block: TAutoIncField
      FieldName = 'Id_Block'
      ReadOnly = True
    end
    object quBlocksId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quBlocksStripCount: TWordField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1083#1086#1089
      FieldName = 'StripCount'
    end
    object quBlocksStripWidth: TFloatField
      DisplayLabel = #1064#1080#1088#1080#1085#1072' '#1087#1086#1083#1086#1089#1099', '#1084
      FieldName = 'StripWidth'
      DisplayFormat = '0.0'
    end
    object quBlocksId_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quBlocksRoadCoat: TStringField
      DisplayLabel = #1058#1080#1087' '#1076#1086#1088#1086#1078#1085#1086#1075#1086' '#1087#1086#1082#1088#1099#1090#1080#1103
      FieldKind = fkLookup
      FieldName = 'RoadCoat'
      LookupDataSet = quRoadCoats
      LookupKeyFields = 'Id_RoadCoat'
      LookupResultField = 'Name'
      KeyFields = 'Id_RoadCoat'
      Size = 100
      Lookup = True
    end
    object quBlocksLoadingVmax: TFloatField
      DisplayLabel = #1044#1086#1087#1091#1089#1082#1072#1077#1084#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100' ('#1075#1088#1091#1079'.), '#1082#1084'/'#1095
      FieldName = 'LoadingVmax'
      DisplayFormat = '0.0'
    end
    object quBlocksUnLoadingVmax: TFloatField
      DisplayLabel = #1044#1086#1087#1091#1089#1082#1072#1077#1084#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100' ('#1087#1086#1088#1086#1078#1085'.), '#1082#1084'/'#1095
      FieldName = 'UnLoadingVmax'
      DisplayFormat = '0.0'
    end
    object quBlocksKind: TWordField
      FieldName = 'Kind'
    end
  end
  object dsBlocks: TDataSource
    DataSet = quBlocks
    Left = 408
    Top = 260
  end
  object quBlockPoints: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsBlocks
    Parameters = <
      item
        Name = 'Id_Block'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitBlockPoints'
      'WHERE Id_Block=:Id_Block')
    Left = 408
    Top = 309
    object quBlockPointsId_BlockPoint: TAutoIncField
      FieldName = 'Id_BlockPoint'
      ReadOnly = True
    end
    object quBlockPointsId_Block: TIntegerField
      FieldName = 'Id_Block'
    end
    object quBlockPointsId_Point: TIntegerField
      FieldName = 'Id_Point'
    end
    object quBlockPointsX: TFloatField
      FieldKind = fkLookup
      FieldName = 'X'
      LookupDataSet = quPoints
      LookupKeyFields = 'Id_Point'
      LookupResultField = 'X'
      KeyFields = 'Id_Point'
      DisplayFormat = '0.000'
      Lookup = True
    end
    object quBlockPointsY: TFloatField
      FieldKind = fkLookup
      FieldName = 'Y'
      LookupDataSet = quPoints
      LookupKeyFields = 'Id_Point'
      LookupResultField = 'Y'
      KeyFields = 'Id_Point'
      DisplayFormat = '0.000'
      Lookup = True
    end
    object quBlockPointsZ: TFloatField
      FieldKind = fkLookup
      FieldName = 'Z'
      LookupDataSet = quPoints
      LookupKeyFields = 'Id_Point'
      LookupResultField = 'Z'
      KeyFields = 'Id_Point'
      DisplayFormat = '0.000'
      Lookup = True
    end
  end
  object dsBlockPoints: TDataSource
    DataSet = quBlockPoints
    Left = 408
    Top = 357
  end
  object quRocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitRocks'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex')
    Left = 408
    Top = 406
    object quRocksId_Rock: TAutoIncField
      FieldName = 'Id_Rock'
      ReadOnly = True
    end
    object quRocksId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quRocksName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1075#1086#1088#1085#1086#1081' '#1087#1086#1088#1086#1076#1099
      FieldName = 'Name'
      Size = 50
    end
    object quRocksIsMineralWealth: TBooleanField
      DisplayLabel = #1055#1088#1080#1079#1085#1072#1082' '#1087#1086#1083#1077#1079#1085#1086#1075#1086' '#1080#1089#1082#1086#1087#1072#1077#1084#1086#1075#1086
      FieldName = 'IsMineralWealth'
      OnGetText = quRocksIsMineralWealthGetText
      OnSetText = quRocksIsMineralWealthSetText
    end
    object quRocksSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
  end
  object dsRocks: TDataSource
    DataSet = quRocks
    Left = 408
    Top = 454
  end
  object quDeportExcavators: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quDeportExcavatorsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitDeportExcavators'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex')
    Left = 160
    Top = 115
    object quDeportExcavatorsId_DeportExcavator: TAutoIncField
      FieldName = 'Id_DeportExcavator'
      ReadOnly = True
    end
    object quDeportExcavatorsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quDeportExcavatorsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quDeportExcavatorsId_Excavator: TIntegerField
      FieldName = 'Id_Excavator'
    end
    object quDeportExcavatorsParkNo: TIntegerField
      DisplayLabel = #8470
      FieldName = 'ParkNo'
      DisplayFormat = '00'
      EditFormat = '0'
    end
    object quDeportExcavatorsEYear: TIntegerField
      DisplayLabel = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072
      FieldName = 'EYear'
    end
    object quDeportExcavatorsWorkState: TBooleanField
      DisplayLabel = #1056#1072#1073#1086#1095#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077'?'
      DisplayWidth = 10
      FieldName = 'WorkState'
      OnGetText = quDeportExcavatorsWorkStateGetText
    end
    object quDeportExcavatorsCost: TFloatField
      DisplayLabel = #1057#1090#1086#1080#1084#1086#1089#1090#1100', '#1090#1099#1089'.'#1090#1085
      FieldName = 'Cost'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quDeportExcavatorsFactCycleTime: TFloatField
      DisplayLabel = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077' '#1074#1088#1077#1084#1103' '#1094#1080#1082#1083#1072', '#1089
      FieldName = 'FactCycleTime'
      DisplayFormat = '0.00'
    end
    object quDeportExcavatorsAddCostMaterials: TFloatField
      DisplayLabel = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
      FieldName = 'AddCostMaterials'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quDeportExcavatorsAddCostUnAccounted: TFloatField
      DisplayLabel = #1047#1072#1090#1088#1072#1090#1099' '#1085#1077#1091#1095#1090#1077#1085#1085#1099#1077', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
      FieldName = 'AddCostUnAccounted'
      DisplayFormat = '#,###,##0.00'
      EditFormat = '0.00'
    end
    object quDeportExcavatorsEngineKIM: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1084#1086#1097#1085#1086#1089#1090#1080' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldName = 'EngineKIM'
      DisplayFormat = '0.00'
    end
    object quDeportExcavatorsEngineKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldName = 'EngineKPD'
      DisplayFormat = '0.000'
    end
    object quDeportExcavatorsName: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quExcavators
      LookupKeyFields = 'Id_Excavator'
      LookupResultField = 'Name'
      KeyFields = 'Id_Excavator'
      Size = 50
      Lookup = True
    end
    object quDeportExcavatorsTotalName: TStringField
      FieldKind = fkCalculated
      FieldName = 'TotalName'
      Size = 50
      Calculated = True
    end
    object quDeportExcavatorsSENAmortizationRate: TFloatField
      DisplayLabel = #1043#1086#1076#1086#1074#1072#1103' '#1085#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'SENAmortizationRate'
      DisplayFormat = '0.0000'
    end
  end
  object dsDeportExcavators: TDataSource
    DataSet = quDeportExcavators
    Left = 160
    Top = 164
  end
  object quLoadingPunkts: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quLoadingPunktsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitLoadingPunkts'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex')
    Left = 296
    Top = 120
    object quLoadingPunktsId_LoadingPunkt: TAutoIncField
      FieldName = 'Id_LoadingPunkt'
      ReadOnly = True
    end
    object quLoadingPunktsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quLoadingPunktsId_Point: TIntegerField
      FieldName = 'Id_Point'
    end
    object quLoadingPunktsId_DeportExcavator: TIntegerField
      FieldName = 'Id_DeportExcavator'
    end
    object quLoadingPunktsDeportExcavator: TStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1100' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
      FieldKind = fkLookup
      FieldName = 'DeportExcavator'
      LookupDataSet = quDeportExcavators
      LookupKeyFields = 'Id_DeportExcavator'
      LookupResultField = 'TotalName'
      KeyFields = 'Id_DeportExcavator'
      Size = 50
      Lookup = True
    end
    object quLoadingPunktsTotalName: TStringField
      FieldKind = fkCalculated
      FieldName = 'TotalName'
      Size = 50
      Calculated = True
    end
    object quLoadingPunktsZ: TFloatField
      FieldKind = fkLookup
      FieldName = 'Z'
      LookupDataSet = quPoints
      LookupKeyFields = 'Id_Point'
      LookupResultField = 'Z'
      KeyFields = 'Id_Point'
      DisplayFormat = '0.###'
      Lookup = True
    end
    object quLoadingPunktsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quLoadingPunktsGrnt: TStringField
      FieldKind = fkCalculated
      FieldName = 'Grnt'
      Size = 10
      Calculated = True
    end
  end
  object dsLoadingPunkts: TDataSource
    DataSet = quLoadingPunkts
    Left = 296
    Top = 164
  end
  object quUnLoadingPunkts: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quUnLoadingPunktsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitUnLoadingPunkts'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex')
    Left = 296
    Top = 309
    object quUnLoadingPunktsId_UnloadingPunkt: TAutoIncField
      FieldName = 'Id_UnloadingPunkt'
      ReadOnly = True
    end
    object quUnLoadingPunktsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quUnLoadingPunktsId_Point: TIntegerField
      FieldName = 'Id_Point'
    end
    object quUnLoadingPunktsMaxV1000m3: TFloatField
      DisplayLabel = #1045#1084#1082#1086#1089#1090#1100' '#1087#1088#1080#1077#1084#1085#1086#1075#1086' '#1073#1091#1085#1082#1077#1088#1072', '#1090#1099#1089'.'#1084'3'
      FieldName = 'MaxV1000m3'
      DisplayFormat = '#,##0.000'
      EditFormat = '0'
    end
    object quUnLoadingPunktsAutoMaxCount: TIntegerField
      DisplayLabel = #1063#1080#1089#1083#1086' '#1072#1074#1090#1086', '#1082'-'#1093' '#1084#1086#1078#1085#1086' '#1088#1072#1079#1084#1077#1089#1090#1080#1090#1100' '#1085#1072' '#1087#1091#1085#1082#1090#1077
      FieldName = 'AutoMaxCount'
    end
    object quUnLoadingPunktsKind: TWordField
      DisplayLabel = #1058#1080#1087' '#1087#1091#1085#1082#1090#1072' '#1088#1072#1079#1075#1088#1091#1079#1082#1080': 0-'#1092#1072#1073#1088#1080#1082#1072', 1-'#1087#1077#1088#1077#1075#1088#1091#1079#1086#1095#1085#1099#1081' '#1089#1082#1083#1072#1076', 2-'#1086#1090#1074#1072#1083
      FieldName = 'Kind'
    end
    object quUnLoadingPunktsSKind: TStringField
      DisplayLabel = #1058#1080#1087' '#1087#1091#1085#1082#1090#1072' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
      FieldKind = fkCalculated
      FieldName = 'SKind'
      Size = 50
      Calculated = True
    end
    object quUnLoadingPunktsZ: TFloatField
      FieldKind = fkLookup
      FieldName = 'Z'
      LookupDataSet = quPoints
      LookupKeyFields = 'Id_Point'
      LookupResultField = 'Z'
      KeyFields = 'Id_Point'
      DisplayFormat = '0.###'
      Lookup = True
    end
    object quUnLoadingPunktsTotalName: TStringField
      FieldKind = fkCalculated
      FieldName = 'TotalName'
      Size = 100
      Calculated = True
    end
    object quUnLoadingPunktsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
  end
  object dsUnLoadingPunkts: TDataSource
    DataSet = quUnLoadingPunkts
    Left = 296
    Top = 357
  end
  object quUnLoadingPunktRocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsUnLoadingPunkts
    Parameters = <
      item
        Name = 'Id_UnLoadingPunkt'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitUnLoadingPunktRocks'
      'WHERE Id_UnLoadingPunkt=:Id_UnLoadingPunkt'
      'ORDER BY SortIndex')
    Left = 296
    Top = 405
    object quUnLoadingPunktRocksId_UnLoadingPunktRock: TAutoIncField
      FieldName = 'Id_UnLoadingPunktRock'
      ReadOnly = True
    end
    object quUnLoadingPunktRocksId_UnLoadingPunkt: TIntegerField
      FieldName = 'Id_UnLoadingPunkt'
    end
    object quUnLoadingPunktRocksId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quUnLoadingPunktRocksRequiredContent: TFloatField
      DisplayLabel = #1058#1088#1077#1073#1091#1077#1084#1086#1077' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
      FieldName = 'RequiredContent'
      DisplayFormat = '0.0'
    end
    object quUnLoadingPunktRocksInitialContent: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1089#1084#1077#1085#1099', %'
      FieldName = 'InitialContent'
      DisplayFormat = '0.0'
    end
    object quUnLoadingPunktRocksInitialV1000m3: TFloatField
      DisplayLabel = #1054#1073#1098#1077#1084' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1089#1084#1077#1085#1099', '#1090#1099#1089'.'#1084'3'
      FieldName = 'InitialV1000m3'
      DisplayFormat = '#,##0.000'
    end
    object quUnLoadingPunktRocksRock: TStringField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1087#1086#1088#1086#1076#1072
      FieldKind = fkLookup
      FieldName = 'Rock'
      LookupDataSet = quRocks
      LookupKeyFields = 'Id_Rock'
      LookupResultField = 'Name'
      KeyFields = 'Id_Rock'
      Size = 50
      Lookup = True
    end
    object quUnLoadingPunktRocksIsMineralWealth: TBooleanField
      FieldKind = fkLookup
      FieldName = 'IsMineralWealth'
      LookupDataSet = quRocks
      LookupKeyFields = 'Id_Rock'
      LookupResultField = 'IsMineralWealth'
      KeyFields = 'Id_Rock'
      Lookup = True
    end
    object quUnLoadingPunktRocksSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
  end
  object dsUnLoadingPunktRocks: TDataSource
    DataSet = quUnLoadingPunktRocks
    Left = 296
    Top = 454
  end
  object quShiftPunkts: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quShiftPunktsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitShiftPunkts'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 296
    Top = 502
    object quShiftPunktsId_ShiftPunkt: TAutoIncField
      FieldName = 'Id_ShiftPunkt'
      ReadOnly = True
    end
    object quShiftPunktsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quShiftPunktsId_Point: TIntegerField
      FieldName = 'Id_Point'
    end
    object quShiftPunktsZ: TFloatField
      FieldKind = fkLookup
      FieldName = 'Z'
      LookupDataSet = quPoints
      LookupKeyFields = 'Id_Point'
      LookupResultField = 'Z'
      KeyFields = 'Id_Point'
      Lookup = True
    end
    object quShiftPunktsNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quShiftPunktsName: TStringField
      FieldKind = fkCalculated
      FieldName = 'Name'
      Size = 50
      Calculated = True
    end
  end
  object dsShiftPunkts: TDataSource
    DataSet = quShiftPunkts
    Left = 296
    Top = 551
  end
  object quCourses: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quOpenpitsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitCourses'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 408
    Top = 502
    object quCoursesId_Course: TAutoIncField
      FieldName = 'Id_Course'
      ReadOnly = True
    end
    object quCoursesId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quCoursesId_Point0: TIntegerField
      FieldName = 'Id_Point0'
    end
    object quCoursesId_Point1: TIntegerField
      FieldName = 'Id_Point1'
    end
    object quCoursesNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quCoursesKind: TIntegerField
      FieldName = 'Kind'
    end
  end
  object dsCourse: TDataSource
    DataSet = quCourses
    Left = 408
    Top = 551
  end
  object quCourseBlocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsCourse
    Parameters = <
      item
        Name = 'Id_Course'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitCourseBlocks'
      'WHERE Id_Course=:Id_Course')
    Left = 408
    Top = 599
    object quCourseBlocksId_CourseBlock: TAutoIncField
      FieldName = 'Id_CourseBlock'
      ReadOnly = True
    end
    object quCourseBlocksId_Course: TIntegerField
      FieldName = 'Id_Course'
    end
    object quCourseBlocksId_Block: TIntegerField
      FieldName = 'Id_Block'
    end
  end
  object dsCourseBlocks: TDataSource
    DataSet = quCourseBlocks
    Left = 408
    Top = 648
  end
  object quLoadingPunktRocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quLoadingPunktRocksCalcFields
    DataSource = dsLoadingPunkts
    Parameters = <
      item
        Name = 'Id_LoadingPunkt'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT R.*'
      'FROM OpenpitLoadingPunktRocks R'
      'WHERE R.Id_LoadingPunkt=:Id_LoadingPunkt'
      'ORDER BY R.SortIndex')
    Left = 296
    Top = 212
    object quLoadingPunktRocksId_LoadingPunktRock: TAutoIncField
      FieldName = 'Id_LoadingPunktRock'
      ReadOnly = True
    end
    object quLoadingPunktRocksId_LoadingPunkt: TIntegerField
      FieldName = 'Id_LoadingPunkt'
    end
    object quLoadingPunktRocksId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quLoadingPunktRocksRock: TStringField
      DisplayLabel = #1058#1080#1087' '#1075#1086#1088#1085#1086#1081' '#1087#1086#1088#1086#1076#1099
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Rock'
      LookupDataSet = quRocks
      LookupKeyFields = 'Id_Rock'
      LookupResultField = 'Name'
      KeyFields = 'Id_Rock'
      Size = 50
      Lookup = True
    end
    object quLoadingPunktRocksIsMineralWealth: TBooleanField
      DisplayLabel = #1055#1086#1083#1077#1079#1085#1086#1077' '#1080#1089#1082#1086#1087#1072#1077#1084#1086#1077'?'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'IsMineralWealth'
      LookupDataSet = quRocks
      LookupKeyFields = 'Id_Rock'
      LookupResultField = 'IsMineralWealth'
      KeyFields = 'Id_Rock'
      OnGetText = quLoadingPunktRocksIsMineralWealthGetText
      Lookup = True
    end
    object quLoadingPunktRocksDensityInBlock: TFloatField
      DisplayLabel = #1055#1083#1086#1090#1085#1086#1089#1090#1100' '#1074' '#1094#1077#1083#1080#1082#1077', '#1090'/'#1082#1091#1073'.'#1084
      FieldName = 'DensityInBlock'
      DisplayFormat = '0.00'
    end
    object quLoadingPunktRocksShatteringCoef: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1088#1072#1079#1088#1099#1093#1083#1077#1085#1080#1103
      FieldName = 'ShatteringCoef'
      DisplayFormat = '0.000'
    end
    object quLoadingPunktRocksContent: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
      DisplayWidth = 10
      FieldName = 'Content'
      DisplayFormat = '0.00'
    end
    object quLoadingPunktRocksPlannedV1000m3: TFloatField
      DisplayLabel = #1055#1083#1072#1085#1080#1088#1091#1077#1084#1099#1081' '#1086#1073#1098#1077#1084' '#1043#1052' '#1085#1072' '#1087#1077#1088#1080#1086#1076', '#1090#1099#1089'.'#1082#1091#1073'.'#1084'.'
      DisplayWidth = 10
      FieldName = 'PlannedV1000m3'
      DisplayFormat = '#,###,##0.000'
      EditFormat = '0.000'
    end
    object quLoadingPunktRocksPlannedQ1000tn: TFloatField
      DisplayLabel = #1055#1083#1072#1085#1080#1088#1091#1077#1084#1072#1103' '#1084#1072#1089#1089#1072' '#1043#1052' '#1085#1072' '#1087#1077#1088#1080#1086#1076', '#1090#1099#1089'.'#1090
      FieldKind = fkCalculated
      FieldName = 'PlannedQ1000tn'
      DisplayFormat = '#,###,##0.000'
      EditFormat = '0.00'
      Calculated = True
    end
    object quLoadingPunktRocksSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
  end
  object dsLoadingPunktRocks: TDataSource
    DataSet = quLoadingPunktRocks
    Left = 296
    Top = 260
  end
  object quRockProductivity: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quLoadingPunktRocksCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitLoadingPunktRocks'
      'WHERE Id_LoadingPunkt in '
      '(SELECT Id_LoadingPunkt'
      'FROM OpenpitLoadingPunkts'
      'WHERE Id_Openpit=:Id_Openpit'
      ')')
    Left = 296
    Top = 19
    object quRockProductivityId_LoadingPunktRock: TAutoIncField
      FieldName = 'Id_LoadingPunktRock'
      ReadOnly = True
    end
    object quRockProductivityId_LoadingPunkt: TIntegerField
      FieldName = 'Id_LoadingPunkt'
    end
    object quRockProductivityNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quRockProductivityId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quRockProductivityIsMineralWealth: TBooleanField
      FieldKind = fkLookup
      FieldName = 'IsMineralWealth'
      LookupDataSet = quRocks
      LookupKeyFields = 'Id_Rock'
      LookupResultField = 'IsMineralWealth'
      KeyFields = 'Id_Rock'
      Lookup = True
    end
    object quRockProductivityDensityInBlock: TFloatField
      FieldName = 'DensityInBlock'
      DisplayFormat = '0.00'
    end
    object quRockProductivityShatteringCoef: TFloatField
      FieldName = 'ShatteringCoef'
      DisplayFormat = '0.00'
    end
    object quRockProductivityContent: TFloatField
      FieldName = 'Content'
      DisplayFormat = '0.00'
    end
    object quRockProductivityPlannedV1000m3: TFloatField
      FieldName = 'PlannedV1000m3'
      DisplayFormat = '0.000'
    end
    object quRockProductivityPlannedQ1000tn: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PlannedQ1000tn'
      DisplayFormat = '0.000'
      Calculated = True
    end
  end
  object dsRockProductivity: TDataSource
    DataSet = quRockProductivity
    Left = 296
    Top = 67
  end
  object quAutoOtherAccounts: TADOQuery
    Connection = ADOConnection
    OnCalcFields = quAutoOtherAccountsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitAutoOtherAccounts'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 160
    Top = 212
    object quAutoOtherAccountsId_AutoOtherAccount: TAutoIncField
      FieldName = 'Id_AutoOtherAccount'
      ReadOnly = True
    end
    object quAutoOtherAccountsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quAutoOtherAccountsId_Auto: TIntegerField
      FieldName = 'Id_Auto'
    end
    object quAutoOtherAccountsSpares: TFloatField
      DisplayLabel = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1079#1072#1087#1095#1072#1089#1090#1080' '#1080' '#1084#1072#1090#1077#1088#1080#1072#1083#1099', % '#1082' '#1079#1072#1090#1088#1072#1090#1072#1084' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086
      FieldName = 'Spares'
      DisplayFormat = '#,###,##0.00'
    end
    object quAutoOtherAccountsGreasingSubstance: TFloatField
      DisplayLabel = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1089#1084#1072#1079#1086#1095#1085#1099#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099', % '#1082' '#1079#1072#1090#1088#1072#1090#1072#1084' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086
      FieldName = 'GreasingSubstance'
      DisplayFormat = '#,###,##0.00'
    end
    object quAutoOtherAccountsMaintenanceCost: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1088#1077#1084#1086#1085#1090#1085#1086#1075#1086' '#1087#1077#1088#1089#1086#1085#1072#1083#1072', '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1084#1077#1089
      FieldName = 'MaintenanceCost'
      DisplayFormat = '#,###,##0.00'
    end
    object quAutoOtherAccountsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'SortIndex'
      Calculated = True
    end
    object quAutoOtherAccountsName: TStringField
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Name'
      KeyFields = 'Id_Auto'
      Size = 50
      Lookup = True
    end
  end
  object dsAutoOtherAccounts: TDataSource
    DataSet = quAutoOtherAccounts
    Left = 160
    Top = 260
  end
  object quRoadOtherAccounts: TADOQuery
    Connection = ADOConnection
    OnCalcFields = quAutoOtherAccountsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitRoadOtherAccounts'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 160
    Top = 405
    object quRoadOtherAccountsId_RoadOtherAccount: TAutoIncField
      FieldName = 'Id_RoadOtherAccount'
      ReadOnly = True
    end
    object quRoadOtherAccountsId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quRoadOtherAccountsId_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quRoadOtherAccountsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'SortIndex'
      Calculated = True
    end
    object quRoadOtherAccountsRoadCoat: TStringField
      FieldKind = fkLookup
      FieldName = 'RoadCoat'
      LookupDataSet = quRoadCoats
      LookupKeyFields = 'Id_RoadCoat'
      LookupResultField = 'Name'
      KeyFields = 'Id_RoadCoat'
      Size = 100
      Lookup = True
    end
    object quRoadOtherAccountsBuildingCosts: TFloatField
      DisplayLabel = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1089#1086#1086#1088#1091#1078#1077#1085#1080#1077', '#1090#1099#1089'.'#1090#1077#1085#1075#1077
      FieldName = 'BuildingCosts'
      DisplayFormat = '#,###,##0.00'
    end
    object quRoadOtherAccountsKeepingCosts: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077', '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1075#1086#1076
      FieldName = 'KeepingCosts'
      DisplayFormat = '#,###,##0.00'
    end
    object quRoadOtherAccountsAmortizationNorm: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'AmortizationNorm'
      DisplayFormat = '#,###,##0.00'
    end
  end
  object dsRoadOtherAccounts: TDataSource
    DataSet = quRoadOtherAccounts
    Left = 160
    Top = 454
  end
  object quAutoExcavAccordances: TADOQuery
    Connection = ADOConnection
    OnCalcFields = quAutoExcavAccordancesCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM OpenpitAutoExcavAccordances'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 160
    Top = 309
    object quAutoExcavAccordancesId_AutoExcavAccordance: TAutoIncField
      FieldName = 'Id_AutoExcavAccordance'
      ReadOnly = True
    end
    object quAutoExcavAccordancesId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quAutoExcavAccordancesId_Auto: TIntegerField
      FieldName = 'Id_Auto'
    end
    object quAutoExcavAccordancesId_Excavator: TIntegerField
      FieldName = 'Id_Excavator'
    end
    object quAutoExcavAccordancesAuto: TStringField
      FieldKind = fkLookup
      FieldName = 'Auto'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Name'
      KeyFields = 'Id_Auto'
      Size = 50
      Lookup = True
    end
    object quAutoExcavAccordancesExcavator: TStringField
      FieldKind = fkLookup
      FieldName = 'Excavator'
      LookupDataSet = quExcavators
      LookupKeyFields = 'Id_Excavator'
      LookupResultField = 'Name'
      KeyFields = 'Id_Excavator'
      Size = 50
      Lookup = True
    end
    object quAutoExcavAccordancesTotalName: TStringField
      FieldKind = fkCalculated
      FieldName = 'TotalName'
      Size = 100
      Calculated = True
    end
  end
  object dsAutoExcavAccordances: TDataSource
    DataSet = quAutoExcavAccordances
    Left = 160
    Top = 357
  end
  object quResultAutosDetail: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultAutosDetailCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  RA.Id_DeportAuto,'
      '  DA.Id_Auto,'
      '  DA.ParkNo,'
      '  DA.TyresRaceRate AS TyresRaceRate0,'
      '  1 AS Count0,'
      '  RA.TripsCount AS TripsCount0,'
      '  RA.DoubleTripsCount AS DoubleTripsCount0,'
      '  RA.RockVm3 AS RockVm30,'
      '  RA.RockQtn AS RockQtn0,'
      '  RA.Race AS Race0,'
      '  RA.TransDistanceSummary AS TransDistanceSummary0,'
      '  RA.TransDistanceWAvg AS TransDistanceWAvg0,'
      '  RA.LiftingHeightWAvg AS LiftingHeightWAvg0,'
      '  RA.ShiftRaceAvg AS ShiftRaceAvg0,'
      '  RA.ShiftTripRaceAvg AS ShiftTripRaceAvg0,'
      '  RA.Vavg AS Vavg0,'
      '  RA.Vteh AS Vteh0,'
      '  RA.Gx AS Gx0,'
      '  RA.GxWork AS GxWork0,'
      '  RA.GxWaiting AS GxWaiting0,'
      '  RA.GxLoading AS GxLoading0,'
      '  RA.GxUnloading AS GxUnloading0,'
      '  RA.GxFromSP AS GxFromSP0, '
      '  RA.GxToSP AS GxToSP0, '
      '  RA.GxSpecific AS GxSpecific0, '
      '  RA.TimesWork AS TimesWork0, '
      '  RA.TimesWaiting AS TimesWaiting0,'
      '  RA.TimesManeuver AS TimesManeuver0, '
      '  RA.TimesLoading AS TimesLoading0, '
      '  RA.TimesUnloading AS TimesUnloading0, '
      '  RA.TripTimeAvg AS TripTimeAvg0, '
      '  RA.WorkTimeUsingRatio AS WorkTimeUsingRatio0, '
      '  RA.TyresRaceAvg1000km AS TyresRaceAvg1000km0, '
      '  RA.TyresAllowedCount AS TyresAllowedCount0, '
      '  RA.TyresCosts AS TyresCosts0, '
      '  RA.CostsWork AS CostsWork0, '
      '  RA.CostsWaiting AS CostsWaiting0, '
      '  RA.CostsAmortization AS CostsAmortization0, '
      '  RA.CostsSummary AS CostsSummary0'
      'FROM ResultAutos RA, OpenpitDeportAutos DA'
      'WHERE'
      '  (DA.Id_DeportAuto=RA.Id_DeportAuto)and'
      '  (RA.Id_DeportAuto in'
      '('
      'SELECT Id_DeportAuto'
      'FROM OpenpitDeportAutos'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex'
      '))')
    Left = 512
    Top = 19
    object quResultAutosDetailId_Auto: TIntegerField
      FieldName = 'Id_Auto'
    end
    object quResultAutosDetailParkNo: TIntegerField
      FieldName = 'ParkNo'
    end
    object quResultAutosDetailTyresRaceRate0: TFloatField
      FieldName = 'TyresRaceRate0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailCount0: TIntegerField
      FieldName = 'Count0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTripsCount0: TIntegerField
      FieldName = 'TripsCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailDoubleTripsCount0: TIntegerField
      FieldName = 'DoubleTripsCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailRace0: TFloatField
      FieldName = 'Race0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTransDistanceSummary0: TFloatField
      FieldName = 'TransDistanceSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTransDistanceWAvg0: TFloatField
      FieldName = 'TransDistanceWAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailLiftingHeightWAvg0: TFloatField
      FieldName = 'LiftingHeightWAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailShiftRaceAvg0: TFloatField
      FieldName = 'ShiftRaceAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailShiftTripRaceAvg0: TFloatField
      FieldName = 'ShiftTripRaceAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailVavg0: TFloatField
      FieldName = 'Vavg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailVteh0: TFloatField
      FieldName = 'Vteh0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGx0: TFloatField
      FieldName = 'Gx0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxWork0: TFloatField
      FieldName = 'GxWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxWaiting0: TFloatField
      FieldName = 'GxWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxLoading0: TFloatField
      FieldName = 'GxLoading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxUnloading0: TFloatField
      FieldName = 'GxUnloading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxFromSP0: TFloatField
      FieldName = 'GxFromSP0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxToSP0: TFloatField
      FieldName = 'GxToSP0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailGxSpecific0: TFloatField
      FieldName = 'GxSpecific0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTimesWork0: TFloatField
      FieldName = 'TimesWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTimesWaiting0: TFloatField
      FieldName = 'TimesWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTimesManeuver0: TFloatField
      FieldName = 'TimesManeuver0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTimesLoading0: TFloatField
      FieldName = 'TimesLoading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTimesUnloading0: TFloatField
      FieldName = 'TimesUnloading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTripTimeAvg0: TFloatField
      FieldName = 'TripTimeAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailWorkTimeUsingRatio0: TFloatField
      FieldName = 'WorkTimeUsingRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTyresRaceAvg1000km0: TFloatField
      FieldName = 'TyresRaceAvg1000km0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTyresAllowedCount0: TFloatField
      FieldName = 'TyresAllowedCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailTyresCosts0: TFloatField
      FieldName = 'TyresCosts0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailCostsWork0: TFloatField
      FieldName = 'CostsWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailCostsWaiting0: TFloatField
      FieldName = 'CostsWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailCostsSummary0: TFloatField
      FieldName = 'CostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosDetailAutoName: TStringField
      FieldKind = fkLookup
      FieldName = 'AutoName'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Name'
      KeyFields = 'Id_Auto'
      Size = 50
      Lookup = True
    end
    object quResultAutosDetailNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quResultAutosDetailName: TStringField
      DisplayLabel = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099
      FieldKind = fkCalculated
      FieldName = 'Name'
      Size = 50
      Calculated = True
    end
    object quResultAutosDetailId_DeportAuto: TIntegerField
      FieldName = 'Id_DeportAuto'
    end
  end
  object dsResultAutos: TDataSource
    DataSet = quResultAutosDetail
    Left = 512
    Top = 67
  end
  object dsResultLoadingPunkts: TDataSource
    DataSet = quResultLoadingPunktsDetail
    Left = 664
    Top = 67
  end
  object quResultAutosModels: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  DISTINCT(DA.Id_Auto),'
      '  COUNT(*) AS Count0,'
      '  0 AS TyresRaceRate0,'
      '  SUM(RA.TripsCount) AS TripsCount0,'
      '  SUM(RA.DoubleTripsCount) AS DoubleTripsCount0,'
      '  SUM(RA.RockVm3) AS RockVm30,'
      '  SUM(RA.RockQtn) AS RockQtn0,'
      '  SUM(RA.Race) AS Race0,'
      '  SUM(RA.TransDistanceSummary) AS TransDistanceSummary0,'
      '  SUM(RA.TransDistanceWAvg)/Count0 AS TransDistanceWAvg0,'
      '  SUM(RA.LiftingHeightWAvg)/Count0 AS LiftingHeightWAvg0,'
      '  SUM(RA.ShiftRaceAvg)/Count0 AS ShiftRaceAvg0,'
      '  SUM(RA.ShiftTripRaceAvg)/Count0 AS ShiftTripRaceAvg0,'
      '  SUM(RA.Vavg)/Count0 AS Vavg0,'
      '  SUM(RA.Vteh)/Count0 AS Vteh0,'
      '  SUM(RA.Gx) AS Gx0,'
      '  SUM(RA.GxWork) AS GxWork0, '
      '  SUM(RA.GxWaiting) AS GxWaiting0, '
      '  SUM(RA.GxLoading) AS GxLoading0, '
      '  SUM(RA.GxUnloading) AS GxUnloading0, '
      '  SUM(RA.GxFromSP) AS GxFromSP0, '
      '  SUM(RA.GxToSP) AS GxToSP0, '
      '  SUM(RA.GxSpecific)/Count0 AS GxSpecific0, '
      '  SUM(RA.TimesWork) AS TimesWork0, '
      '  SUM(RA.TimesWaiting) AS TimesWaiting0, '
      '  SUM(RA.TimesManeuver) AS TimesManeuver0, '
      '  SUM(RA.TimesLoading) AS TimesLoading0, '
      '  SUM(RA.TimesUnloading) AS TimesUnloading0, '
      '  SUM(RA.TripTimeAvg)/Count0 AS TripTimeAvg0, '
      '  SUM(RA.WorkTimeUsingRatio)/Count0 AS WorkTimeUsingRatio0, '
      '  SUM(RA.TyresRaceAvg1000km)/Count0 AS TyresRaceAvg1000km0, '
      '  SUM(RA.TyresAllowedCount) AS TyresAllowedCount0, '
      '  SUM(RA.TyresCosts) AS TyresCosts0, '
      '  SUM(RA.CostsWork) AS CostsWork0, '
      '  SUM(RA.CostsWaiting) AS CostsWaiting0, '
      '  SUM(RA.CostsAmortization) AS CostsAmortization0, '
      '  SUM(RA.CostsSummary) AS CostsSummary0'
      'FROM ResultAutos RA, OpenpitDeportAutos DA'
      'WHERE'
      '  (DA.Id_DeportAuto=RA.Id_DeportAuto)AND'
      '  (RA.Id_DeportAuto in'
      '('
      'SELECT Id_DeportAuto'
      'FROM OpenpitDeportAutos'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex))'
      'GROUP BY DA.Id_Auto')
    Left = 512
    Top = 115
    object quResultAutosModelsId_Auto: TIntegerField
      FieldName = 'Id_Auto'
    end
    object quResultAutosModelsTyresRaceRate0: TIntegerField
      FieldName = 'TyresRaceRate0'
      DisplayFormat = '#'
    end
    object quResultAutosModelsCount0: TIntegerField
      FieldName = 'Count0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTripsCount0: TFloatField
      FieldName = 'TripsCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsDoubleTripsCount0: TFloatField
      FieldName = 'DoubleTripsCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsRace0: TFloatField
      FieldName = 'Race0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTransDistanceSummary0: TFloatField
      FieldName = 'TransDistanceSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTransDistanceWAvg0: TFloatField
      FieldName = 'TransDistanceWAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsLiftingHeightWAvg0: TFloatField
      FieldName = 'LiftingHeightWAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsShiftRaceAvg0: TFloatField
      FieldName = 'ShiftRaceAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsShiftTripRaceAvg0: TFloatField
      FieldName = 'ShiftTripRaceAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsVavg0: TFloatField
      FieldName = 'Vavg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsVteh0: TFloatField
      FieldName = 'Vteh0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGx0: TFloatField
      FieldName = 'Gx0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxWork0: TFloatField
      FieldName = 'GxWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxWaiting0: TFloatField
      FieldName = 'GxWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxLoading0: TFloatField
      FieldName = 'GxLoading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxUnloading0: TFloatField
      FieldName = 'GxUnloading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxFromSP0: TFloatField
      FieldName = 'GxFromSP0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxToSP0: TFloatField
      FieldName = 'GxToSP0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsGxSpecific0: TFloatField
      FieldName = 'GxSpecific0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTimesWork0: TFloatField
      FieldName = 'TimesWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTimesWaiting0: TFloatField
      FieldName = 'TimesWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTimesManeuver0: TFloatField
      FieldName = 'TimesManeuver0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTimesLoading0: TFloatField
      FieldName = 'TimesLoading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTimesUnloading0: TFloatField
      FieldName = 'TimesUnloading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTripTimeAvg0: TFloatField
      FieldName = 'TripTimeAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsWorkTimeUsingRatio0: TFloatField
      FieldName = 'WorkTimeUsingRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTyresRaceAvg1000km0: TFloatField
      FieldName = 'TyresRaceAvg1000km0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTyresAllowedCount0: TFloatField
      FieldName = 'TyresAllowedCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsTyresCosts0: TFloatField
      FieldName = 'TyresCosts0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsCostsWork0: TFloatField
      FieldName = 'CostsWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsCostsWaiting0: TFloatField
      FieldName = 'CostsWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsCostsSummary0: TFloatField
      FieldName = 'CostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosModelsNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quResultAutosModelsName: TStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1080
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quAutos
      LookupKeyFields = 'Id_Auto'
      LookupResultField = 'Name'
      KeyFields = 'Id_Auto'
      Size = 50
      Lookup = True
    end
  end
  object quResultAutosSummary: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  0 AS TyresRaceRate0,'
      '  COUNT(*) AS Count0,'
      '  SUM(TripsCount) AS TripsCount0,'
      '  SUM(DoubleTripsCount) AS DoubleTripsCount0,'
      '  SUM(RockVm3) AS RockVm30,'
      '  SUM(RockQtn) AS RockQtn0,'
      '  SUM(Race) AS Race0,'
      '  SUM(TransDistanceSummary) AS TransDistanceSummary0,'
      '  SUM(TransDistanceWAvg)/Count0 AS TransDistanceWAvg0,'
      '  SUM(LiftingHeightWAvg)/Count0 AS LiftingHeightWAvg0,'
      '  SUM(ShiftRaceAvg)/Count0 AS ShiftRaceAvg0,'
      '  SUM(ShiftTripRaceAvg)/Count0 AS ShiftTripRaceAvg0,'
      '  SUM(Vavg)/Count0 AS Vavg0,'
      '  SUM(Vteh)/Count0 AS Vteh0,'
      '  SUM(Gx) AS Gx0,'
      '  SUM(GxWork) AS GxWork0, '
      '  SUM(GxWaiting) AS GxWaiting0,'
      '  SUM(GxLoading) AS GxLoading0, '
      '  SUM(GxUnloading) AS GxUnloading0, '
      '  SUM(GxFromSP) AS GxFromSP0, '
      '  SUM(GxToSP) AS GxToSP0, '
      '  SUM(GxSpecific)/Count0 AS GxSpecific0, '
      '  SUM(TimesWork) AS TimesWork0, '
      '  SUM(TimesWaiting) AS TimesWaiting0, '
      '  SUM(TimesManeuver) AS TimesManeuver0, '
      '  SUM(TimesLoading) AS TimesLoading0, '
      '  SUM(TimesUnloading) AS TimesUnloading0, '
      '  SUM(TripTimeAvg)/Count0 AS TripTimeAvg0, '
      '  SUM(WorkTimeUsingRatio)/Count0 AS WorkTimeUsingRatio0, '
      '  SUM(TyresRaceAvg1000km)/Count0 AS TyresRaceAvg1000km0, '
      '  SUM(TyresAllowedCount) AS TyresAllowedCount0, '
      '  SUM(TyresCosts) AS TyresCosts0, '
      '  SUM(CostsWork) AS CostsWork0, '
      '  SUM(CostsWaiting) AS CostsWaiting0, '
      '  SUM(CostsAmortization) AS CostsAmortization0, '
      '  SUM(CostsSummary) AS CostsSummary0'
      'FROM ResultAutos'
      'WHERE '
      '(Id_DeportAuto in'
      '('
      'SELECT Id_DeportAuto'
      'FROM OpenpitDeportAutos'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex'
      '))'
      '')
    Left = 512
    Top = 164
    object quResultAutosSummaryTyresRaceRate0: TIntegerField
      FieldName = 'TyresRaceRate0'
      ReadOnly = True
      DisplayFormat = '#'
    end
    object quResultAutosSummaryCount0: TIntegerField
      FieldName = 'Count0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTripsCount0: TFloatField
      FieldName = 'TripsCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryDoubleTripsCount0: TFloatField
      FieldName = 'DoubleTripsCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryRace0: TFloatField
      FieldName = 'Race0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTransDistanceSummary0: TFloatField
      FieldName = 'TransDistanceSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTransDistanceWAvg0: TFloatField
      FieldName = 'TransDistanceWAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryLiftingHeightWAvg0: TFloatField
      FieldName = 'LiftingHeightWAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryShiftRaceAvg0: TFloatField
      FieldName = 'ShiftRaceAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryShiftTripRaceAvg0: TFloatField
      FieldName = 'ShiftTripRaceAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryVavg0: TFloatField
      FieldName = 'Vavg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryVteh0: TFloatField
      FieldName = 'Vteh0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGx0: TFloatField
      FieldName = 'Gx0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxWork0: TFloatField
      FieldName = 'GxWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxWaiting0: TFloatField
      FieldName = 'GxWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxLoading0: TFloatField
      FieldName = 'GxLoading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxUnloading0: TFloatField
      FieldName = 'GxUnloading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxFromSP0: TFloatField
      FieldName = 'GxFromSP0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxToSP0: TFloatField
      FieldName = 'GxToSP0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryGxSpecific0: TFloatField
      FieldName = 'GxSpecific0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTimesWork0: TFloatField
      FieldName = 'TimesWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTimesWaiting0: TFloatField
      FieldName = 'TimesWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTimesManeuver0: TFloatField
      FieldName = 'TimesManeuver0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTimesLoading0: TFloatField
      FieldName = 'TimesLoading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTimesUnloading0: TFloatField
      FieldName = 'TimesUnloading0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTripTimeAvg0: TFloatField
      FieldName = 'TripTimeAvg0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryWorkTimeUsingRatio0: TFloatField
      FieldName = 'WorkTimeUsingRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTyresRaceAvg1000km0: TFloatField
      FieldName = 'TyresRaceAvg1000km0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTyresAllowedCount0: TFloatField
      FieldName = 'TyresAllowedCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryTyresCosts0: TFloatField
      FieldName = 'TyresCosts0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryCostsWork0: TFloatField
      FieldName = 'CostsWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryCostsWaiting0: TFloatField
      FieldName = 'CostsWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultAutosSummaryCostsSummary0: TFloatField
      FieldName = 'CostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
  end
  object quResultLoadingPunktsDetail: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultLoadingPunktsDetailCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  DE.Id_Excavator,'
      '  LP.Id_LoadingPunkt,'
      '  DE.ParkNo,'
      '  OP.Z as Grnt,'
      '  1 AS Count0,'
      '  RE.LoadingAutosCount AS LoadingAutosCount0,'
      '  RE.RockVm3 AS RockVm30,'
      '  RE.RockQtn AS RockQtn0,'
      '  RE.PlaneDegree AS PlaneDegree0,'
      '  RE.EmploymentRatio AS EmploymentRatio0,'
      '  RE.TimesWork AS TimesWork0,'
      '  RE.TimesWaiting AS TimesWaiting0,'
      '  RE.TimesManeuver AS TimesManeuver0,'
      '  RE.WorkTimeUsingRatio AS WorkTimeUsingRatio0,'
      '  RE.Gx AS Gx0,'
      '  RE.CostsWork AS CostsWork0,'
      '  RE.CostsWaiting AS CostsWaiting0,'
      '  RE.CostsAmortization AS CostsAmortization0,'
      '  RE.CostsSummary AS CostsSummary0'
      'FROM ResultLoadingPunkts RE, OpenpitLoadingPunkts LP,'
      '     OpenpitDeportExcavators DE, OpenpitPoints OP'
      'WHERE'
      '  (LP.Id_LoadingPunkt=RE.Id_LoadingPunkt)and '
      '  (DE.Id_DeportExcavator=LP.Id_DeportExcavator)and'
      '  (OP.Id_Point=LP.Id_Point)and'
      '  (RE.Id_LoadingPunkt in'
      '('
      'SELECT Id_LoadingPunkt'
      'FROM OpenpitLoadingPunkts'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex'
      '))')
    Left = 664
    Top = 19
    object quResultLoadingPunktsDetailId_LoadingPunkt: TAutoIncField
      FieldName = 'Id_LoadingPunkt'
      ReadOnly = True
    end
    object quResultLoadingPunktsDetailId_Excavator: TIntegerField
      FieldName = 'Id_Excavator'
    end
    object quResultLoadingPunktsDetailParkNo: TIntegerField
      FieldName = 'ParkNo'
    end
    object quResultLoadingPunktsDetailCount0: TIntegerField
      FieldName = 'Count0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailLoadingAutosCount0: TIntegerField
      FieldName = 'LoadingAutosCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailPlaneDegree0: TFloatField
      FieldName = 'PlaneDegree0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailEmploymentRatio0: TFloatField
      FieldName = 'EmploymentRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailTimesWork0: TFloatField
      FieldName = 'TimesWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailTimesWaiting0: TFloatField
      FieldName = 'TimesWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailTimesManeuver0: TFloatField
      FieldName = 'TimesManeuver0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailWorkTimeUsingRatio0: TFloatField
      FieldName = 'WorkTimeUsingRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailGx0: TFloatField
      FieldName = 'Gx0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailCostsWork0: TFloatField
      FieldName = 'CostsWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailCostsWaiting0: TFloatField
      FieldName = 'CostsWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailCostsSummary0: TFloatField
      FieldName = 'CostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsDetailNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quResultLoadingPunktsDetailExcavatorName: TStringField
      DisplayLabel = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
      FieldKind = fkLookup
      FieldName = 'ExcavatorName'
      LookupDataSet = quExcavators
      LookupKeyFields = 'Id_Excavator'
      LookupResultField = 'Name'
      KeyFields = 'Id_Excavator'
      Size = 50
      Lookup = True
    end
    object quResultLoadingPunktsDetailName: TStringField
      DisplayLabel = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
      FieldKind = fkCalculated
      FieldName = 'Name'
      Size = 50
      Calculated = True
    end
    object quResultLoadingPunktsDetailGrnt: TFloatField
      DisplayLabel = #1043#1086#1088#1080#1079#1086#1085#1090
      FieldName = 'Grnt'
      DisplayFormat = '0.0'
    end
  end
  object quResultLoadingPunktsSummary: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  0 AS Id_LoadingPunkt,'
      '  COUNT(*) AS Count0,'
      '  Sum(RE.LoadingAutosCount) AS LoadingAutosCount0,'
      '  Sum(RE.RockVm3) AS RockVm30,'
      '  Sum(RE.RockQtn) AS RockQtn0,'
      '  Sum(RE.PlaneDegree)/Count0 AS PlaneDegree0,'
      '  Sum(RE.EmploymentRatio)/Count0 AS EmploymentRatio0,'
      '  Sum(RE.TimesWork) AS TimesWork0,'
      '  Sum(RE.TimesWaiting) AS TimesWaiting0,'
      '  Sum(RE.TimesManeuver) AS TimesManeuver0,'
      '  Sum(RE.WorkTimeUsingRatio)/Count0 AS WorkTimeUsingRatio0,'
      '  Sum(RE.Gx) AS Gx0,'
      '  Sum(RE.CostsWork) AS CostsWork0,'
      '  Sum(RE.CostsWaiting) AS CostsWaiting0,'
      '  Sum(RE.CostsAmortization) AS CostsAmortization0,'
      '  Sum(RE.CostsSummary) AS CostsSummary0'
      'FROM ResultLoadingPunkts RE'
      'WHERE'
      '  (RE.Id_LoadingPunkt in'
      '(SELECT Id_LoadingPunkt'
      'FROM OpenpitLoadingPunkts'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex))'
      '')
    Left = 664
    Top = 163
    object quResultLoadingPunktsSummaryId_LoadingPunkt: TIntegerField
      FieldName = 'Id_LoadingPunkt'
      ReadOnly = True
    end
    object quResultLoadingPunktsSummaryCount0: TIntegerField
      FieldName = 'Count0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryLoadingAutosCount0: TFloatField
      FieldName = 'LoadingAutosCount0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryPlaneDegree0: TFloatField
      FieldName = 'PlaneDegree0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryEmploymentRatio0: TFloatField
      FieldName = 'EmploymentRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryTimesWork0: TFloatField
      FieldName = 'TimesWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryTimesWaiting0: TFloatField
      FieldName = 'TimesWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryTimesManeuver0: TFloatField
      FieldName = 'TimesManeuver0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryWorkTimeUsingRatio0: TFloatField
      FieldName = 'WorkTimeUsingRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryGx0: TFloatField
      FieldName = 'Gx0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryCostsWork0: TFloatField
      FieldName = 'CostsWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryCostsWaiting0: TFloatField
      FieldName = 'CostsWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsSummaryCostsSummary0: TFloatField
      FieldName = 'CostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
  end
  object quResultLoadingPunktRocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsResultLoadingPunkts
    Parameters = <
      item
        Name = 'Id_LoadingPunkt'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT LPR.Id_LoadingPunkt, LPR.SortIndex,LPR.Id_Rock, R.Name'
      'FROM OpenpitLoadingPunktRocks LPR, OpenpitRocks R'
      'WHERE'
      '  (LPR.Id_LoadingPunkt=:Id_LoadingPunkt)AND'
      '  (R.Id_Rock=LPR.Id_Rock)'
      'ORDER BY LPR.SortIndex')
    Left = 664
    Top = 212
    object quResultLoadingPunktRocksId_LoadingPunkt: TIntegerField
      FieldName = 'Id_LoadingPunkt'
    end
    object quResultLoadingPunktRocksId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quResultLoadingPunktRocksName: TWideStringField
      DisplayLabel = #1044#1086#1073#1099#1074#1072#1077#1084#1072#1103' '#1075#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072
      FieldName = 'Name'
      Size = 50
    end
    object quResultLoadingPunktRocksSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
  end
  object quResultAutoSpeeds: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM ResultAutoSpeeds')
    Left = 512
    Top = 212
    object quResultAutoSpeedsTsec: TIntegerField
      DisplayLabel = 'T, '#1089#1077#1082
      FieldName = 'Tsec'
    end
    object quResultAutoSpeedsV: TFloatField
      DisplayLabel = 'V, '#1082#1084'/'#1095
      FieldName = 'V'
      DisplayFormat = '0.00'
    end
    object quResultAutoSpeedsW: TFloatField
      DisplayLabel = 'W, kH'
      FieldName = 'W'
      DisplayFormat = '0.00'
    end
  end
  object dsResultAutoSpeeds: TDataSource
    DataSet = quResultAutoSpeeds
    Left = 512
    Top = 260
  end
  object quResultLoadingPunktsModels: TADOQuery
    Connection = ADOConnection
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  DISTINCT(DE.Id_Excavator),'
      '  0 AS Id_LoadingPunkt,'
      '  COUNT(*) AS Count0,'
      '  Sum(RE.LoadingAutosCount) AS LoadingAutosCount0,'
      '  Sum(RE.RockVm3) AS RockVm30,'
      '  Sum(RE.RockQtn) AS RockQtn0,'
      '  Sum(RE.PlaneDegree)/Count0 AS PlaneDegree0,'
      '  Sum(RE.EmploymentRatio)/Count0 AS EmploymentRatio0,'
      '  Sum(RE.TimesWork) AS TimesWork0,'
      '  Sum(RE.TimesWaiting) AS TimesWaiting0,'
      '  Sum(RE.TimesManeuver) AS TimesManeuver0,'
      '  Sum(RE.WorkTimeUsingRatio)/Count0 AS WorkTimeUsingRatio0,'
      '  Sum(RE.Gx) AS Gx0,'
      '  Sum(RE.CostsWork) AS CostsWork0,'
      '  Sum(RE.CostsWaiting) AS CostsWaiting0,'
      '  Sum(RE.CostsAmortization) AS CostsAmortization0,'
      '  Sum(RE.CostsSummary) AS CostsSummary0'
      'FROM ResultLoadingPunkts RE, OpenpitDeportExcavators DE'
      'WHERE'
      '  (DE.Id_DeportExcavator=RE.Id_DeportExcavator)AND'
      '  (RE.Id_DeportExcavator in'
      '('
      'SELECT Id_DeportExcavator'
      'FROM OpenpitDeportExcavators'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex'
      '))'
      'GROUP BY DE.Id_Excavator')
    Left = 664
    Top = 115
    object quResultLoadingPunktsModelsId_Excavator: TIntegerField
      FieldName = 'Id_Excavator'
    end
    object quResultLoadingPunktsModelsId_LoadingPunkt: TIntegerField
      FieldName = 'Id_LoadingPunkt'
    end
    object quResultLoadingPunktsModelsCount0: TIntegerField
      FieldName = 'Count0'
    end
    object quResultLoadingPunktsModelsLoadingAutosCount0: TFloatField
      FieldName = 'LoadingAutosCount0'
    end
    object quResultLoadingPunktsModelsRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsPlaneDegree0: TFloatField
      FieldName = 'PlaneDegree0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsEmploymentRatio0: TFloatField
      FieldName = 'EmploymentRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsTimesWork0: TFloatField
      FieldName = 'TimesWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsTimesWaiting0: TFloatField
      FieldName = 'TimesWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsTimesManeuver0: TFloatField
      FieldName = 'TimesManeuver0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsWorkTimeUsingRatio0: TFloatField
      FieldName = 'WorkTimeUsingRatio0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsGx0: TFloatField
      FieldName = 'Gx0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsCostsWork0: TFloatField
      FieldName = 'CostsWork0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsCostsWaiting0: TFloatField
      FieldName = 'CostsWaiting0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsCostsSummary0: TFloatField
      FieldName = 'CostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultLoadingPunktsModelsName: TStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1080' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quExcavators
      LookupKeyFields = 'Id_Excavator'
      LookupResultField = 'Name'
      KeyFields = 'Id_Excavator'
      Size = 50
      Lookup = True
    end
    object quResultLoadingPunktsModelsNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
  end
  object dsResultLoadingPunktRocks: TDataSource
    DataSet = quResultLoadingPunktRocks
    Left = 664
    Top = 260
  end
  object quResultBlocksDetail: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultBlocksDetailCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  RB.Id_Block,'
      '  OB.Id_RoadCoat,'
      '  1 AS Count0,'
      '  RB.BLength AS BLength0,'
      '  RB.RockVm3 AS RockVm30,'
      '  RB.RockQtn AS RockQtn0,'
      '  RB.GxLoading AS GxLoading0,'
      '  RB.GxUnLoading AS GxUnLoading0,'
      '  (GxLoading0+GxUnLoading0)AS GX0,'
      '  (GxLoading0/BLength0) AS GxSpecificLoading0,'
      '  (GxUnLoading0/BLength0) AS GxSpecificUnLoading0,'
      '  RB.GxSpecific AS GxSpecific0,'
      '  RB.TMovingLoading AS TMovingLoading0,'
      '  RB.TMovingUnLoading AS TMovingUnLoading0,'
      '  (TMovingLoading0+TMovingUnLoading0)AS TMoving0,'
      '  RB.TWaitingLoading AS TWaitingLoading0,'
      '  RB.TWaitingUnLoading AS TWaitingUnLoading0,'
      '  (TWaitingLoading0+TWaitingUnLoading0)AS TWaiting0,'
      
        '  ((TMovingUnLoading0+TWaitingUnLoading0)/BLength0) AS TSpecific' +
        'UnLoading0,'
      
        '  ((TMovingLoading0+TWaitingLoading0)/BLength0) AS TSpecificLoad' +
        'ing0,'
      '  ((TMovingLoading0+TWaitingLoading0+'
      
        '     TMovingUnLoading0+TWaitingUnLoading0)/BLength0) AS TSpecifi' +
        'c0,'
      '  RB.EmploymentRatio AS EmploymentRatio0,'
      '  RB.VMovingLoading AS VMovingLoading0,'
      '  RB.VMovingUnLoading AS VMovingUnLoading0,'
      '  (VMovingLoading0+VMovingUnLoading0)/2 AS VMoving0,'
      '  RB.AutoCountLoading AS AutoCountLoading0,'
      '  RB.AutoCountUnLoading AS AutoCountUnLoading0,'
      '  (AutoCountLoading0+AutoCountUnLoading0)AS AutoCount0,'
      '  RB.WaitingCountLoading AS WaitingCountLoading0,'
      '  RB.WaitingCountUnLoading AS WaitingCountUnLoading0,'
      '  (WaitingCountLoading0+WaitingCountUnLoading0)AS WaitingCount0,'
      '  RB.CostsRepair AS CostsRepair0,'
      '  RB.CostsAmortization AS CostsAmortization0,'
      '  RB.CostsBuilding AS CostsBuilding0,'
      '  (CostsRepair0+CostsAmortization0)AS Costs0'
      'FROM ResultBlocks RB, OpenpitBlocks OB'
      'WHERE'
      '  (OB.Id_Block=RB.Id_Block)and'
      '  (RB.Id_Block in'
      '('
      'SELECT Id_Block'
      'FROM OpenpitBlocks'
      'WHERE Id_Openpit=:Id_Openpit'
      '))'
      '')
    Left = 512
    Top = 309
    object quResultBlocksDetailId_Block: TIntegerField
      FieldName = 'Id_Block'
    end
    object quResultBlocksDetailId_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quResultBlocksDetailCount0: TIntegerField
      FieldName = 'Count0'
      ReadOnly = True
    end
    object quResultBlocksDetailBLength0: TFloatField
      FieldName = 'BLength0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailGxLoading0: TFloatField
      FieldName = 'GxLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailGxUnLoading0: TFloatField
      FieldName = 'GxUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailGX0: TFloatField
      FieldName = 'GX0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailGxSpecific0: TFloatField
      FieldName = 'GxSpecific0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTMovingLoading0: TFloatField
      FieldName = 'TMovingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTMovingUnLoading0: TFloatField
      FieldName = 'TMovingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTMoving0: TFloatField
      FieldName = 'TMoving0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTWaitingLoading0: TFloatField
      FieldName = 'TWaitingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTWaitingUnLoading0: TFloatField
      FieldName = 'TWaitingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTWaiting0: TFloatField
      FieldName = 'TWaiting0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailEmploymentRatio0: TFloatField
      FieldName = 'EmploymentRatio0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailVMovingLoading0: TFloatField
      FieldName = 'VMovingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailVMovingUnLoading0: TFloatField
      FieldName = 'VMovingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailVMoving0: TFloatField
      FieldName = 'VMoving0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailAutoCountLoading0: TIntegerField
      FieldName = 'AutoCountLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksDetailAutoCountUnLoading0: TIntegerField
      FieldName = 'AutoCountUnLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksDetailAutoCount0: TIntegerField
      FieldName = 'AutoCount0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksDetailWaitingCountLoading0: TIntegerField
      FieldName = 'WaitingCountLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksDetailWaitingCountUnLoading0: TIntegerField
      FieldName = 'WaitingCountUnLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksDetailWaitingCount0: TIntegerField
      FieldName = 'WaitingCount0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksDetailCostsRepair0: TFloatField
      FieldName = 'CostsRepair0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksDetailCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksDetailCostsBuilding0: TFloatField
      FieldName = 'CostsBuilding0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksDetailCosts0: TFloatField
      FieldName = 'Costs0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksDetailNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quResultBlocksDetailShortName: TStringField
      DisplayLabel = #1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077
      FieldKind = fkLookup
      FieldName = 'ShortName'
      LookupDataSet = quRoadCoats
      LookupKeyFields = 'Id_RoadCoat'
      LookupResultField = 'ShortName'
      KeyFields = 'Id_RoadCoat'
      Size = 100
      Lookup = True
    end
    object quResultBlocksDetailRate: TFloatField
      DisplayLabel = #1044#1086#1083#1103' '#1074' '#1086#1073#1097#1077#1081' '#1087#1088#1086#1090#1103#1078#1077#1085#1085#1086#1089#1090#1080', %'
      FieldKind = fkCalculated
      FieldName = 'Rate'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quResultBlocksDetailGxSpecificLoading0: TFloatField
      FieldName = 'GxSpecificLoading0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailGxSpecificUnLoading0: TFloatField
      FieldName = 'GxSpecificUnLoading0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTSpecificUnLoading0: TFloatField
      FieldName = 'TSpecificUnLoading0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTSpecificLoading0: TFloatField
      FieldName = 'TSpecificLoading0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailTSpecific0: TFloatField
      FieldName = 'TSpecific0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksDetailName: TStringField
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quRoadCoats
      LookupKeyFields = 'Id_RoadCoat'
      LookupResultField = 'Name'
      KeyFields = 'Id_RoadCoat'
      Size = 100
      Lookup = True
    end
  end
  object dsResultBlocks: TDataSource
    DataSet = quResultBlocksDetail
    Left = 512
    Top = 357
  end
  object quResultBlocksModels: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultBlocksDetailCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  DISTINCT(OB.Id_RoadCoat),'
      '  COUNT(*) AS Count0,'
      '  SUM(RB.BLength) AS BLength0,'
      '  SUM(RB.RockVm3) AS RockVm30,'
      '  SUM(RB.RockQtn) AS RockQtn0,'
      '  SUM(RB.GxLoading) AS GxLoading0,'
      '  SUM(RB.GxUnLoading) AS GxUnLoading0,'
      '  (GxLoading0+GxUnLoading0)AS GX0,'
      '  SUM(RB.GxSpecific)/Count0 AS GxSpecific0,'
      '  (GxLoading0/BLength0) AS GxSpecificLoading0,'
      '  (GxUnLoading0/BLength0) AS GxSpecificUnLoading0,'
      '  SUM(RB.TMovingLoading) AS TMovingLoading0,'
      '  SUM(RB.TMovingUnLoading) AS TMovingUnLoading0,'
      '  (TMovingLoading0+TMovingUnLoading0)AS TMoving0,'
      '  SUM(RB.TWaitingLoading) AS TWaitingLoading0,'
      '  SUM(RB.TWaitingUnLoading) AS TWaitingUnLoading0,'
      '  (TWaitingLoading0+TWaitingUnLoading0)AS TWaiting0,'
      '  SUM(RB.EmploymentRatio)/Count0 AS EmploymentRatio0,'
      '  SUM(RB.VMovingLoading)/Count0 AS VMovingLoading0,'
      '  SUM(RB.VMovingUnLoading)/Count0 AS VMovingUnLoading0,'
      '  (VMovingLoading0+VMovingUnLoading0)/2 AS VMoving0,'
      '  SUM(RB.AutoCountLoading) AS AutoCountLoading0,'
      '  SUM(RB.AutoCountUnLoading) AS AutoCountUnLoading0,'
      '  (AutoCountLoading0+AutoCountUnLoading0)AS AutoCount0,'
      '  SUM(RB.WaitingCountLoading) AS WaitingCountLoading0,'
      '  SUM(RB.WaitingCountUnLoading) AS WaitingCountUnLoading0,'
      '  (WaitingCountLoading0+WaitingCountUnLoading0)AS WaitingCount0,'
      '  SUM(RB.CostsRepair) AS CostsRepair0,'
      '  SUM(RB.CostsAmortization) AS CostsAmortization0,'
      '  SUM(RB.CostsBuilding) AS CostsBuilding0,'
      '  (CostsRepair0+CostsAmortization0)AS Costs0'
      'FROM ResultBlocks RB, OpenpitBlocks OB'
      'WHERE'
      '  (OB.Id_Block=RB.Id_Block)and'
      '  (RB.Id_Block in'
      '('
      'SELECT Id_Block'
      'FROM OpenpitBlocks'
      'WHERE Id_Openpit=:Id_Openpit'
      '))'
      'GROUP BY OB.Id_RoadCoat')
    Left = 512
    Top = 405
    object quResultBlocksModelsId_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quResultBlocksModelsCount0: TIntegerField
      FieldName = 'Count0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsBLength0: TFloatField
      FieldName = 'BLength0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsGxLoading0: TFloatField
      FieldName = 'GxLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsGxUnLoading0: TFloatField
      FieldName = 'GxUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsGX0: TFloatField
      FieldName = 'GX0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsGxSpecific0: TFloatField
      FieldName = 'GxSpecific0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsTMovingLoading0: TFloatField
      FieldName = 'TMovingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsTMovingUnLoading0: TFloatField
      FieldName = 'TMovingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsTMoving0: TFloatField
      FieldName = 'TMoving0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsTWaitingLoading0: TFloatField
      FieldName = 'TWaitingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsTWaitingUnLoading0: TFloatField
      FieldName = 'TWaitingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsTWaiting0: TFloatField
      FieldName = 'TWaiting0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsEmploymentRatio0: TFloatField
      FieldName = 'EmploymentRatio0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsVMovingLoading0: TFloatField
      FieldName = 'VMovingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsVMovingUnLoading0: TFloatField
      FieldName = 'VMovingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsVMoving0: TFloatField
      FieldName = 'VMoving0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsAutoCountLoading0: TFloatField
      FieldName = 'AutoCountLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsAutoCountUnLoading0: TFloatField
      FieldName = 'AutoCountUnLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsAutoCount0: TFloatField
      FieldName = 'AutoCount0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsWaitingCountLoading0: TFloatField
      FieldName = 'WaitingCountLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsWaitingCountUnLoading0: TFloatField
      FieldName = 'WaitingCountUnLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsWaitingCount0: TFloatField
      FieldName = 'WaitingCount0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksModelsCostsRepair0: TFloatField
      FieldName = 'CostsRepair0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksModelsCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksModelsCostsBuilding0: TFloatField
      FieldName = 'CostsBuilding0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksModelsCosts0: TFloatField
      FieldName = 'Costs0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksModelsNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quResultBlocksModelsShortName: TStringField
      DisplayLabel = #1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077
      FieldKind = fkLookup
      FieldName = 'ShortName'
      LookupDataSet = quRoadCoats
      LookupKeyFields = 'Id_RoadCoat'
      LookupResultField = 'ShortName'
      KeyFields = 'Id_RoadCoat'
      Size = 100
      Lookup = True
    end
    object quResultBlocksModelsRate: TFloatField
      DisplayLabel = #1044#1086#1083#1103' '#1074' '#1086#1073#1097#1077#1081' '#1087#1088#1086#1090#1103#1078#1077#1085#1085#1086#1089#1090#1080', %'
      FieldKind = fkCalculated
      FieldName = 'Rate'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quResultBlocksModelsGxSpecificLoading0: TFloatField
      FieldName = 'GxSpecificLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsGxSpecificUnLoading0: TFloatField
      FieldName = 'GxSpecificUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksModelsName: TStringField
      FieldKind = fkLookup
      FieldName = 'Name'
      LookupDataSet = quRoadCoats
      LookupKeyFields = 'Id_RoadCoat'
      LookupResultField = 'Name'
      KeyFields = 'Id_RoadCoat'
      Size = 100
      Lookup = True
    end
  end
  object quResultBlocksSummary: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  COUNT(*) AS Count0,'
      '  SUM(RB.BLength) AS BLength0,'
      '  SUM(RB.RockVm3) AS RockVm30,'
      '  SUM(RB.RockQtn) AS RockQtn0,'
      '  SUM(RB.GxLoading) AS GxLoading0,'
      '  SUM(RB.GxUnLoading) AS GxUnLoading0,'
      '  (GxLoading0+GxUnLoading0)AS GX0,'
      '  SUM(RB.GxSpecific)/Count0 AS GxSpecific0,'
      '  SUM(RB.TMovingLoading) AS TMovingLoading0,'
      '  SUM(RB.TMovingUnLoading) AS TMovingUnLoading0,'
      '  (TMovingLoading0+TMovingUnLoading0)AS TMoving0,'
      '  SUM(RB.TWaitingLoading) AS TWaitingLoading0,'
      '  SUM(RB.TWaitingUnLoading) AS TWaitingUnLoading0,'
      '  (TWaitingLoading0+TWaitingUnLoading0)AS TWaiting0,'
      '  SUM(RB.EmploymentRatio)/Count0 AS EmploymentRatio0,'
      '  SUM(RB.VMovingLoading)/Count0 AS VMovingLoading0,'
      '  SUM(RB.VMovingUnLoading)/Count0 AS VMovingUnLoading0,'
      '  (VMovingLoading0+VMovingUnLoading0)/2 AS VMoving0,'
      '  SUM(RB.AutoCountLoading) AS AutoCountLoading0,'
      '  SUM(RB.AutoCountUnLoading) AS AutoCountUnLoading0,'
      '  (AutoCountLoading0+AutoCountUnLoading0)AS AutoCount0,'
      '  SUM(RB.WaitingCountLoading) AS WaitingCountLoading0,'
      '  SUM(RB.WaitingCountUnLoading) AS WaitingCountUnLoading0,'
      '  (WaitingCountLoading0+WaitingCountUnLoading0)AS WaitingCount0,'
      '  SUM(RB.CostsRepair) AS CostsRepair0,'
      '  SUM(RB.CostsAmortization) AS CostsAmortization0,'
      '  SUM(RB.CostsBuilding) AS CostsBuilding0,'
      '  (CostsRepair0+CostsAmortization0)AS Costs0'
      'FROM ResultBlocks RB, OpenpitBlocks OB'
      'WHERE'
      '  (OB.Id_Block=RB.Id_Block)and'
      '  (RB.Id_Block in'
      '('
      'SELECT Id_Block'
      'FROM OpenpitBlocks'
      'WHERE Id_Openpit=:Id_Openpit'
      '))')
    Left = 512
    Top = 454
    object quResultBlocksSummaryCount0: TIntegerField
      FieldName = 'Count0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryBLength0: TFloatField
      FieldName = 'BLength0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryRockVm30: TFloatField
      FieldName = 'RockVm30'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryRockQtn0: TFloatField
      FieldName = 'RockQtn0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryGxLoading0: TFloatField
      FieldName = 'GxLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryGxUnLoading0: TFloatField
      FieldName = 'GxUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryGX0: TFloatField
      FieldName = 'GX0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryGxSpecific0: TFloatField
      FieldName = 'GxSpecific0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryTMovingLoading0: TFloatField
      FieldName = 'TMovingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryTMovingUnLoading0: TFloatField
      FieldName = 'TMovingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryTMoving0: TFloatField
      FieldName = 'TMoving0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryTWaitingLoading0: TFloatField
      FieldName = 'TWaitingLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryTWaitingUnLoading0: TFloatField
      FieldName = 'TWaitingUnLoading0'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryTWaiting0: TFloatField
      FieldName = 'TWaiting0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryEmploymentRatio0: TFloatField
      FieldName = 'EmploymentRatio0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryVMovingLoading0: TFloatField
      FieldName = 'VMovingLoading0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryVMovingUnLoading0: TFloatField
      FieldName = 'VMovingUnLoading0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryVMoving0: TFloatField
      FieldName = 'VMoving0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.0'
    end
    object quResultBlocksSummaryAutoCountLoading0: TFloatField
      FieldName = 'AutoCountLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryAutoCountUnLoading0: TFloatField
      FieldName = 'AutoCountUnLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryAutoCount0: TFloatField
      FieldName = 'AutoCount0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryWaitingCountLoading0: TFloatField
      FieldName = 'WaitingCountLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryWaitingCountUnLoading0: TFloatField
      FieldName = 'WaitingCountUnLoading0'
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryWaitingCount0: TFloatField
      FieldName = 'WaitingCount0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0'
    end
    object quResultBlocksSummaryCostsRepair0: TFloatField
      FieldName = 'CostsRepair0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksSummaryCostsAmortization0: TFloatField
      FieldName = 'CostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksSummaryCostsBuilding0: TFloatField
      FieldName = 'CostsBuilding0'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultBlocksSummaryCosts0: TFloatField
      FieldName = 'Costs0'
      ReadOnly = True
      DisplayFormat = '# ### ### ##0.00'
    end
  end
  object quResultUnLoadingPunkts: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultUnLoadingPunktsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      '  RUP.Id_UnLoadingPunkt,'
      '  RUP.EmploymentTime,'
      '  RUP.EmploymentRatio,'
      '  OUP.MaxV1000m3,'
      '  OUP.Kind,'
      '  OP.Z,'
      '  SUM(RUPR.UnLoadingAutosCount)AS UnLoadingAutosCount,'
      '  SUM(RUPR.RockVm3)AS RockVm3,  '
      '  SUM(RUPR.RockQtn)AS RockQtn'
      
        'FROM ResultUnLoadingPunkts RUP, ResultUnLoadingPunktRocks RUPR, ' +
        'OpenpitUnLoadingPunkts OUP, OpenpitPoints OP'
      'WHERE '
      '  (RUP.Id_UnLoadingPunkt in'
      '  (SELECT Id_UnLoadingPunkt'
      '   FROM OpenpitUnLoadingPunkts'
      '   WHERE Id_Openpit=:Id_Openpit'
      '   ORDER BY SortIndex))AND'
      '  (RUPR.Id_UnLoadingPunkt=RUP.Id_UnLoadingPunkt)AND'
      '  (OUP.Id_UnLoadingPunkt=RUP.Id_UnLoadingPunkt)AND'
      '  (OP.Id_Point=OUP.Id_Point)'
      
        'GROUP BY RUP.Id_UnLoadingPunkt, RUP.EmploymentTime,RUP.Employmen' +
        'tRatio,OUP.MaxV1000m3,OUP.Kind,OP.Z')
    Left = 664
    Top = 308
    object quResultUnLoadingPunktsId_UnLoadingPunkt: TIntegerField
      FieldName = 'Id_UnLoadingPunkt'
    end
    object quResultUnLoadingPunktsUnLoadingAutosCount: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1079#1075#1088#1091#1079#1080#1074#1096#1080#1093#1089#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      FieldName = 'UnLoadingAutosCount'
    end
    object quResultUnLoadingPunktsRockVm3: TFloatField
      DisplayLabel = #1054#1073#1098#1077#1084' '#1088#1072#1079#1075#1088#1091#1078#1077#1085#1085#1086#1081' '#1075#1086#1088#1085#1086#1081' '#1084#1072#1089#1089#1099', '#1084'3'
      FieldName = 'RockVm3'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultUnLoadingPunktsRockQtn: TFloatField
      DisplayLabel = #1042#1077#1089' '#1088#1072#1079#1075#1088#1091#1078#1077#1085#1085#1086#1081' '#1075#1086#1088#1085#1086#1081' '#1084#1072#1089#1089#1099', '#1090'.'
      FieldName = 'RockQtn'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultUnLoadingPunktsKind: TWordField
      DisplayLabel = #1058#1080#1087' '#1087#1091#1085#1082#1090#1072' '#1087#1086#1075#1088#1091#1079#1082#1080
      FieldName = 'Kind'
    end
    object quResultUnLoadingPunktsEmploymentRatio: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1079#1072#1085#1103#1090#1086#1089#1090#1080
      FieldName = 'EmploymentRatio'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultUnLoadingPunktsEmploymentTime: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1079#1072#1085#1103#1090#1086#1089#1090#1080', '#1084#1080#1085
      FieldName = 'EmploymentTime'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultUnLoadingPunktsMaxV1000m3: TFloatField
      DisplayLabel = #1045#1084#1082#1086#1089#1090#1100' '#1073#1091#1085#1082#1077#1088#1072', '#1090#1099#1089'.'#1084'3'
      FieldName = 'MaxV1000m3'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultUnLoadingPunktsZ: TFloatField
      DisplayLabel = #1043#1086#1088#1080#1079#1086#1085#1090', '#1084
      FieldName = 'Z'
      DisplayFormat = '# ### ##0.#'
    end
    object quResultUnLoadingPunktsBunkerRatio: TFloatField
      DisplayLabel = #1057#1090#1077#1087#1077#1085#1100' '#1079#1072#1087#1086#1083#1085#1077#1085#1085#1086#1089#1090#1080' '#1073#1091#1085#1082#1077#1088#1072', %'
      FieldKind = fkCalculated
      FieldName = 'BunkerRatio'
      DisplayFormat = '# ### ##0.00'
      Calculated = True
    end
    object quResultUnLoadingPunktsNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
    object quResultUnLoadingPunktsName: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldKind = fkCalculated
      FieldName = 'Name'
      Size = 50
      Calculated = True
    end
  end
  object dsResultUnLoadingPunkts: TDataSource
    DataSet = quResultUnLoadingPunkts
    Left = 664
    Top = 357
  end
  object quResultUnLoadingPunktRocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultUnLoadingPunktRocksCalcFields
    DataSource = dsResultUnLoadingPunkts
    Parameters = <
      item
        Name = 'Id_UnLoadingPunkt'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT RUPR.*, '
      '               OUPR.RequiredContent,'
      '               R.Name'
      'FROM '
      '  ResultUnLoadingPunktRocks RUPR, '
      '  OpenpitUnLoadingPunktRocks OUPR,'
      '  OpenpitRocks R'
      'WHERE '
      '  (RUPR.Id_UnLoadingPunkt=:Id_UnLoadingPunkt)AND'
      '  (OUPR.Id_UnLoadingPunktRock=RUPR.Id_UnLoadingPunktRock)AND'
      '  (R.Id_Rock=OUPR.Id_Rock)')
    Left = 664
    Top = 404
    object quResultUnLoadingPunktRocksId_UnLoadingPunktRock: TIntegerField
      FieldName = 'Id_UnLoadingPunktRock'
    end
    object quResultUnLoadingPunktRocksId_UnLoadingPunkt: TIntegerField
      FieldName = 'Id_UnLoadingPunkt'
    end
    object quResultUnLoadingPunktRocksUnLoadingAutosCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1079#1075#1088#1091#1079#1080#1074#1096#1080#1093#1089#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      FieldName = 'UnLoadingAutosCount'
    end
    object quResultUnLoadingPunktRocksRockVm3: TFloatField
      DisplayLabel = #1054#1073#1098#1077#1084' '#1088#1072#1079#1075#1088#1091#1078#1077#1085#1085#1086#1081' '#1075#1086#1088#1085#1086#1081' '#1084#1072#1089#1089#1099', '#1084'3'
      FieldName = 'RockVm3'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultUnLoadingPunktRocksRockQtn: TFloatField
      DisplayLabel = #1042#1077#1089' '#1088#1072#1079#1075#1088#1091#1078#1077#1085#1085#1086#1081' '#1075#1086#1088#1085#1086#1081' '#1084#1072#1089#1089#1099', '#1090
      FieldName = 'RockQtn'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultUnLoadingPunktRocksContent: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
      FieldName = 'Content'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultUnLoadingPunktRocksRequiredContent: TFloatField
      DisplayLabel = #1058#1088#1077#1073#1091#1077#1084#1086#1077' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
      FieldName = 'RequiredContent'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultUnLoadingPunktRocksDContent: TFloatField
      DisplayLabel = #1054#1090#1082#1083#1086#1085#1077#1085#1080#1077' '#1086#1090' '#1087#1083#1072#1085#1086#1074#1086#1075#1086' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1103', %'
      FieldKind = fkCalculated
      FieldName = 'DContent'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultUnLoadingPunktRocksName: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Name'
      Size = 50
    end
    object quResultUnLoadingPunktRocksNo: TIntegerField
      DisplayLabel = #8470
      FieldKind = fkCalculated
      FieldName = 'No'
      Calculated = True
    end
  end
  object dsResultUnLoadingPunktRocks: TDataSource
    DataSet = quResultUnLoadingPunktRocks
    Left = 664
    Top = 453
  end
  object quResultEconomBlocks: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultEconomBlocksCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT'
      '  SUM(RB.CostsRepair) AS CostsRepair,'
      '  SUM(RB.CostsAmortization) AS CostsAmortization'
      'FROM ResultBlocks RB'
      'WHERE'
      '  (RB.Id_Block in'
      '('
      'SELECT Id_Block'
      'FROM OpenpitBlocks'
      'WHERE Id_Openpit=:Id_Openpit'
      '))')
    Left = 664
    Top = 599
    object quResultEconomBlocksCostsRepair: TFloatField
      FieldName = 'CostsRepair'
    end
    object quResultEconomBlocksCostsAmortization: TFloatField
      FieldName = 'CostsAmortization'
    end
    object quResultEconomBlocksCostsSummary: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CostsSummary'
      Calculated = True
    end
  end
  object quResultEconomUnLoadingPunkts: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT '
      '  RUP.Id_UnLoadingPunkt,'
      '  SUM(RUPR.RockVm3)AS RockVm3,  '
      '  SUM(RUPR.RockQtn)AS RockQtn'
      'FROM ResultUnLoadingPunkts RUP, ResultUnLoadingPunktRocks RUPR'
      'WHERE '
      '  (RUP.Id_UnLoadingPunkt in'
      '  (SELECT Id_UnLoadingPunkt'
      '   FROM OpenpitUnLoadingPunkts'
      '   WHERE Id_Openpit=:Id_Openpit'
      '   ORDER BY SortIndex))AND'
      '  (RUPR.Id_UnLoadingPunkt=RUP.Id_UnLoadingPunkt)'
      'GROUP BY RUP.Id_UnLoadingPunkt')
    Left = 512
    Top = 599
    object quResultEconomUnLoadingPunktsId_UnLoadingPunkt: TIntegerField
      FieldName = 'Id_UnLoadingPunkt'
    end
    object quResultEconomUnLoadingPunktsRockVm3: TFloatField
      FieldName = 'RockVm3'
    end
    object quResultEconomUnLoadingPunktsRockQtn: TFloatField
      FieldName = 'RockQtn'
    end
  end
  object quResultEconomLoadingPunkts: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT'
      '  Sum(RE.CostsWork) AS CostsWork,'
      '  Sum(RE.CostsWaiting) AS CostsWaiting,'
      '  Sum(RE.CostsAmortization) AS CostsAmortization,'
      '  Sum(RE.CostsSummary) AS CostsSummary'
      'FROM ResultLoadingPunkts RE'
      'WHERE'
      '  (RE.Id_LoadingPunkt in'
      '(SELECT Id_LoadingPunkt'
      'FROM OpenpitLoadingPunkts'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex))'
      '')
    Left = 664
    Top = 551
    object quResultEconomLoadingPunktsCostsWork: TFloatField
      FieldName = 'CostsWork'
    end
    object quResultEconomLoadingPunktsCostsWaiting: TFloatField
      FieldName = 'CostsWaiting'
    end
    object quResultEconomLoadingPunktsCostsAmortization: TFloatField
      FieldName = 'CostsAmortization'
    end
    object quResultEconomLoadingPunktsCostsSummary: TFloatField
      FieldName = 'CostsSummary'
    end
  end
  object quResultEconomAutos: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT'
      '  SUM(TyresCosts) AS TyresCosts, '
      '  SUM(CostsWork) AS CostsWork, '
      '  SUM(CostsWaiting) AS CostsWaiting, '
      '  SUM(CostsAmortization) AS CostsAmortization, '
      '  SUM(CostsSummary) AS CostsSummary'
      'FROM ResultAutos'
      'WHERE '
      '(Id_DeportAuto in'
      '('
      'SELECT Id_DeportAuto'
      'FROM OpenpitDeportAutos'
      'WHERE Id_Openpit=:Id_Openpit'
      'ORDER BY SortIndex'
      '))'
      '')
    Left = 664
    Top = 502
    object quResultEconomAutosTyresCosts: TFloatField
      FieldName = 'TyresCosts'
    end
    object quResultEconomAutosCostsWork: TFloatField
      FieldName = 'CostsWork'
    end
    object quResultEconomAutosCostsWaiting: TFloatField
      FieldName = 'CostsWaiting'
    end
    object quResultEconomAutosCostsAmortization: TFloatField
      FieldName = 'CostsAmortization'
    end
    object quResultEconomAutosCostsSummary: TFloatField
      FieldName = 'CostsSummary'
    end
  end
  object quResultEconomParams: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultEconomParamsCalcFields
    DataSource = dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM Openpits'
      'WHERE Id_Openpit=:Id_Openpit')
    Left = 512
    Top = 502
    object quResultEconomParamsId_Openpit: TAutoIncField
      FieldName = 'Id_Openpit'
      ReadOnly = True
    end
    object quResultEconomParamsTotalKurs: TFloatField
      FieldName = 'TotalKurs'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultEconomParamsTotalExpenses: TFloatField
      FieldName = 'TotalExpenses'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultEconomParamsTotalExpensesUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalExpensesUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsBlocksCostsRepair: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCostsRepair'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsBlocksCostsRepairUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCostsRepairUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsBlocksCostsAmortization: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCostsAmortization'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsBlocksCostsAmortizationUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCostsAmortizationUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsBlocksCostsSummary: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCostsSummary'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsBlocksCostsSummaryUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCostsSummaryUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsWork: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsWork'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsWorkUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsWorkUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsWaiting: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsWaiting'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsWaitingUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsWaitingUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsAmortization: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsAmortization'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsAmortizationUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsAmortizationUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsSummary: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsSummary'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsExcavsCostsSummaryUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavsCostsSummaryUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsWork: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsWork'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsWorkUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsWorkUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsWaiting: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsWaiting'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsWaitingUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsWaitingUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsAmortization: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsAmortization'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsAmortizationUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsAmortizationUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsSummary: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsSummary'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsAutosCostsSummaryUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCostsSummaryUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalCostsSummary: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalCostsSummary'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalCostsSummaryUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalCostsSummaryUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalCostsAmortization: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalCostsAmortization'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalCostsAmortizationUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalCostsAmortizationUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalCostsExpenses: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalCostsExpenses'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalCostsExpensesUSD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalCostsExpensesUSD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsRockVm3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'RockVm3'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsRockQtn: TFloatField
      FieldKind = fkCalculated
      FieldName = 'RockQtn'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsSummary0: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsSummary0'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsSummary0USD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsSummary0USD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsSummary1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsSummary1'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsSummary1USD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsSummary1USD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsAmortization0: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsAmortization0'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsAmortization0USD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsAmortization0USD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsAmortization1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsAmortization1'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsAmortization1USD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsAmortization1USD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsCurrent0: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsCurrent0'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsCurrent0USD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsCurrent0USD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsCurrent1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsCurrent1'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsTotalUdCostsCurrent1USD: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalUdCostsCurrent1USD'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultEconomParamsResultTnaryadSec: TIntegerField
      FieldName = 'ResultTnaryadSec'
    end
  end
  object dsResultEconomParams: TDataSource
    DataSet = quResultEconomParams
    Left = 512
    Top = 551
  end
  object quResultEconomParamsDistribution: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultEconomParamsDistributionCalcFields
    Parameters = <
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Id_Openpit'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  0 As Id,'
      '  "'#1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099'" AS Article,'
      '  SUM(RLP.CostsWork+RLP.CostsWaiting)AS CostsExpluatation,'
      '  SUM(RLP.CostsAmortization)AS CostsAmortization,'
      
        '  SUM(RLP.CostsWork+RLP.CostsWaiting+RLP.CostsAmortization)AS Co' +
        'stsSummary'
      'FROM ResultLoadingPunkts RLP'
      
        'WHERE RLP.Id_LoadingPunkt in (SELECT Id_LoadingPunkt FROM Openpi' +
        'tLoadingPunkts WHERE Id_Openpit=:Id_Openpit)'
      'UNION'
      'SELECT'
      '  1 As Id,'
      '  "'#1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099'" AS Article,'
      '  SUM(RA.CostsWork+RA.CostsWaiting)AS CostsExpluatation,'
      '  SUM(RA.CostsAmortization)AS CostsAmortization,'
      
        '  SUM(RA.CostsWork+RA.CostsWaiting+RA.CostsAmortization)AS Costs' +
        'Summary'
      'FROM ResultAutos RA'
      
        'WHERE RA.Id_DeportAuto in (SELECT Id_DeportAuto FROM OpenpitDepo' +
        'rtAutos WHERE Id_Openpit=:Id_Openpit)'
      'UNION'
      'SELECT'
      '  2 As Id,'
      '  "'#1040#1074#1090#1086#1090#1088#1072#1089#1089#1072'" AS Article,'
      '  SUM(RB.CostsRepair)AS CostsExpluatation,'
      '  SUM(RB.CostsAmortization)AS CostsAmortization,'
      '  SUM(RB.CostsRepair+RB.CostsAmortization)AS CostsSummary'
      'FROM ResultBlocks RB'
      
        'WHERE RB.Id_Block in (SELECT Id_Block FROM OpenpitBlocks WHERE I' +
        'd_Openpit=:Id_Openpit)'
      'UNION'
      'SELECT'
      '  3 As Id,'
      '  "'#1055#1088#1086#1095#1080#1077'" AS Article,'
      
        '  (ParamsShiftDuration*TotalExpenses*1000/(365*24*60))AS CostsEx' +
        'pluatation,'
      '  NULL AS CostsAmortization,'
      
        '  (ParamsShiftDuration*TotalExpenses*1000/(365*24*60)) AS CostsS' +
        'ummary'
      'FROM Openpits O'
      'WHERE O.Id_Openpit=:Id_Openpit'
      '')
    Left = 160
    Top = 502
    object quResultEconomParamsDistributionId: TIntegerField
      DisplayLabel = #8470
      FieldName = 'Id'
    end
    object quResultEconomParamsDistributionArticle: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Article'
      Size = 255
    end
    object quResultEconomParamsDistributionCostsExpluatation: TFloatField
      DisplayLabel = #1069#1082#1089#1087#1083#1091#1090#1072#1094#1080#1086#1085#1085#1099#1077', '#1090#1075
      FieldName = 'CostsExpluatation'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultEconomParamsDistributionCostsAmortization: TFloatField
      DisplayLabel = #1040#1084#1086#1088#1090#1080#1079#1072#1094#1080#1086#1085#1085#1099#1077', '#1090#1075
      FieldName = 'CostsAmortization'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultEconomParamsDistributionCostsSummary: TFloatField
      DisplayLabel = #1057#1091#1084#1084#1072#1088#1085#1099#1077', '#1090#1075
      FieldName = 'CostsSummary'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultEconomParamsDistributionName: TStringField
      FieldKind = fkCalculated
      FieldName = 'Name'
      Calculated = True
    end
  end
  object dsResultEconomParamsDistribution: TDataSource
    DataSet = quResultEconomParamsDistribution
    Left = 160
    Top = 552
  end
  object quResultUnLoadingPunktContents: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM ResultUnLoadingPunktContents')
    Left = 296
    Top = 604
    object quResultUnLoadingPunktContentsTsec: TIntegerField
      FieldName = 'Tsec'
    end
    object quResultUnLoadingPunktContentsC: TFloatField
      FieldName = 'C'
    end
  end
  object dsResultUnLoadingPunktContents: TDataSource
    DataSet = quResultUnLoadingPunktContents
    Left = 296
    Top = 652
  end
  object Query: TADOQuery
    Connection = ADOConnection
    Parameters = <>
    Left = 512
    Top = 648
  end
  object quAdisCourses: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    Left = 808
    Top = 32
  end
  object quAdisPoints: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    Left = 808
    Top = 88
  end
  object ADOSebadan: TADOCommand
    Connection = ADOConnection
    Parameters = <>
    Left = 808
    Top = 144
  end
end
