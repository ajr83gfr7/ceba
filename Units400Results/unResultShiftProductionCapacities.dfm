object fmResultShiftProductionCapacities: TfmResultShiftProductionCapacities
  Left = 543
  Top = 206
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnBtns: TPanel
    Left = 0
    Top = 521
    Width = 784
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      784
      41)
    object btExcel: TButton
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100'...'
      TabOrder = 1
      OnClick = btExcelClick
    end
    object btCancel: TButton
      Left = 704
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 2
    end
    object btShift: TButton
      Left = 16
      Top = 8
      Width = 120
      Height = 25
      Caption = #1057#1084#1077#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'...'
      TabOrder = 0
      OnClick = btShiftClick
    end
  end
  object TabControl: TTabControl
    Left = 0
    Top = 0
    Width = 784
    Height = 521
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      #1047#1072' '#1089#1084#1077#1085#1091
      #1047#1072' '#1089#1088#1077#1076#1085#1077#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      #1047#1072' '#1087#1077#1088#1080#1086#1076)
    TabIndex = 0
    OnChange = TabControlChange
    object Chart: TChart
      Left = 4
      Top = 24
      Width = 776
      Height = 493
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clBlue
      Title.Font.Height = -13
      Title.Font.Name = 'Arial'
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100)
      BottomAxis.LabelStyle = talText
      LeftAxis.Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100', '#1084'3'
      LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
      LeftAxis.Title.Font.Color = clBlack
      LeftAxis.Title.Font.Height = -11
      LeftAxis.Title.Font.Name = 'Arial'
      LeftAxis.Title.Font.Style = [fsBold]
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      object csFactValues: TBarSeries
        Marks.ArrowLength = 20
        Marks.Style = smsValue
        Marks.Visible = True
        SeriesColor = clRed
        Title = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
      object csMaxValues: TBarSeries
        Marks.ArrowLength = 20
        Marks.Style = smsValue
        Marks.Visible = True
        SeriesColor = clGreen
        Title = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
      end
    end
  end
  object quFactValues: TADOQuery
    Connection = fmDM.ADOConnection
    DataSource = fmDM.dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit0'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Id_Openpit1'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  O1.Id_Openpit,'
      '  O1.ResultPeriodCoef AS Kperiod,'
      '  (O1.ResultTnaryadSec/60) AS TnaryadMin,'
      '  O1.ResultWorkedExcavatorCount AS Nworked,'
      '  "'#1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099'" AS Name,'
      '  Sum(RLP.RockVm3) AS Vm3,'
      '  Sum(RLP.TimesWork+RLP.TimesManeuver) AS TrabMin'
      'FROM Openpits O1, ResultLoadingPunkts RLP'
      'WHERE'
      '  (O1.Id_Openpit=:Id_Openpit0) AND'
      '  (RLP.Id_DeportExcavator In (SELECT Id_DeportExcavator'
      '                              FROM OpenpitDeportExcavators'
      '                              WHERE Id_Openpit=O1.Id_Openpit))'
      
        'GROUP BY O1.Id_Openpit, O1.ResultPeriodCoef, O1.ResultTnaryadSec' +
        ', O1.ResultWorkedExcavatorCount'
      'UNION'
      'SELECT'
      '  O2.Id_Openpit,'
      '  O2.ResultPeriodCoef AS Kperiod,'
      '  (O2.ResultTnaryadSec/60) AS TnaryadMin,'
      '  O2.ResultWorkedAutoCount AS Nworked,'
      '  "'#1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099'" AS Name,'
      '  Sum(RA.RockVm3) AS Vm3,'
      
        '  Sum(RA.TimesWork+RA.TimesLoading+RA.TimesUnLoading+RA.TimesMan' +
        'euver) AS TrabMin'
      'FROM Openpits O2, ResultAutos RA'
      'WHERE'
      '  (O2.Id_Openpit=:Id_Openpit1) AND'
      '  (RA.Id_DeportAuto In (SELECT Id_DeportAuto'
      '                        FROM OpenpitDeportAutos'
      '                        WHERE Id_Openpit=O2.Id_Openpit))'
      
        'GROUP BY O2.Id_Openpit, O2.ResultPeriodCoef, O2.ResultTnaryadSec' +
        ', O2.ResultWorkedAutoCount')
    Left = 208
    Top = 48
    object quFactValuesId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quFactValuesKperiod: TFloatField
      FieldName = 'Kperiod'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quFactValuesTnaryadMin: TFloatField
      FieldName = 'TnaryadMin'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quFactValuesNworked: TIntegerField
      FieldName = 'Nworked'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quFactValuesVm3: TFloatField
      FieldName = 'Vm3'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quFactValuesTrabMin: TFloatField
      FieldName = 'TrabMin'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quFactValuesV1000000m3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'V1000000m3'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quFactValuesName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object quFactValuesSName: TStringField
      FieldKind = fkCalculated
      FieldName = 'SName'
      Size = 15
      Calculated = True
    end
  end
  object quMaxValues: TADOQuery
    Connection = fmDM.ADOConnection
    DataSource = fmDM.dsOpenpits
    Parameters = <
      item
        Name = 'Id_Openpit0'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Id_Openpit1'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  O1.Id_Openpit,'
      '  O1.ResultPeriodCoef AS Kperiod,'
      '  (O1.ResultTnaryadSec/60) AS TnaryadMin,'
      '  O1.ResultWorkedExcavatorCount AS Nworked,'
      '  "'#1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099'" AS Name,'
      '  Sum(RLP.RockVm3) AS Vm3,'
      '  Sum(RLP.TimesWork+RLP.TimesManeuver) AS TrabMin'
      'FROM Openpits O1, ResultLoadingPunkts RLP'
      'WHERE'
      '  (O1.Id_Openpit=:Id_Openpit0) AND'
      '  (RLP.Id_DeportExcavator In (SELECT Id_DeportExcavator'
      '                              FROM OpenpitDeportExcavators'
      '                              WHERE Id_Openpit=O1.Id_Openpit))'
      
        'GROUP BY O1.Id_Openpit, O1.ResultPeriodCoef, O1.ResultTnaryadSec' +
        ', O1.ResultWorkedExcavatorCount'
      'UNION'
      'SELECT'
      '  O2.Id_Openpit,'
      '  O2.ResultPeriodCoef AS Kperiod,'
      '  (O2.ResultTnaryadSec/60) AS TnaryadMin,'
      '  O2.ResultWorkedAutoCount AS Nworked,'
      '  "'#1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099'" AS Name,'
      '  Sum(RA.RockVm3) AS Vm3,'
      
        '  Sum(RA.TimesWork+RA.TimesLoading+RA.TimesUnLoading+RA.TimesMan' +
        'euver) AS TrabMin'
      'FROM Openpits O2, ResultAutos RA'
      'WHERE'
      '  (O2.Id_Openpit=:Id_Openpit1) AND'
      '  (RA.Id_DeportAuto In (SELECT Id_DeportAuto'
      '                        FROM OpenpitDeportAutos'
      '                        WHERE Id_Openpit=O2.Id_Openpit))'
      
        'GROUP BY O2.Id_Openpit, O2.ResultPeriodCoef, O2.ResultTnaryadSec' +
        ', O2.ResultWorkedAutoCount')
    Left = 392
    Top = 48
    object quMaxValuesId_Openpit: TIntegerField
      FieldName = 'Id_Openpit'
    end
    object quMaxValuesKperiod: TFloatField
      FieldName = 'Kperiod'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quMaxValuesTnaryadMin: TFloatField
      FieldName = 'TnaryadMin'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quMaxValuesNworked: TIntegerField
      FieldName = 'Nworked'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quMaxValuesVm3: TFloatField
      FieldName = 'Vm3'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quMaxValuesTrabMin: TFloatField
      FieldName = 'TrabMin'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quMaxValuesV1000000m3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'V1000000m3'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quMaxValuesName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object quMaxValuesSName: TStringField
      FieldKind = fkCalculated
      FieldName = 'SName'
      Size = 15
      Calculated = True
    end
  end
  object quResultShifts: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShifts')
    Left = 304
    Top = 344
    object quResultShiftsId_ResultShift: TAutoIncField
      DisplayLabel = #1050#1086#1076' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099
      DisplayWidth = 10
      FieldName = 'Id_ResultShift'
      ReadOnly = True
    end
    object quResultShiftsId_Openpit: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
      DisplayWidth = 10
      FieldName = 'Id_Openpit'
    end
    object quResultShiftsShiftNaryadTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077'), '#1084#1080#1085
      DisplayWidth = 10
      FieldName = 'ShiftNaryadTmin'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsShiftPlanNaryadTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077', '#1084#1080#1085
      FieldKind = fkCalculated
      FieldName = 'ShiftPlanNaryadTmin'
      DisplayFormat = '0.0#'
      Calculated = True
    end
    object quResultShiftsShiftPeresmenkaTmin: TIntegerField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
      FieldName = 'ShiftPeresmenkaTmin'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsShiftTmin: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099', '#1084#1080#1085
      DisplayWidth = 20
      FieldName = 'ShiftTmin'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsShiftKweek: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1088#1077#1076#1085#1077#1085#1077#1076#1077#1083#1100#1085#1086#1081' '#1089#1084#1077#1085#1099
      FieldName = 'ShiftKweek'
      DisplayFormat = '0.00'
    end
    object quResultShiftsPeriodKshift: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1074#1086#1076#1072' '#1089#1084#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1074' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      DisplayWidth = 30
      FieldName = 'PeriodKshift'
      DisplayFormat = '0.00'
    end
    object quResultShiftsPeriodTday: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1087#1077#1088#1080#1086#1076#1072', '#1076#1085#1080
      DisplayWidth = 10
      FieldName = 'PeriodTday'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsDollarCtg: TFloatField
      DisplayLabel = #1050#1091#1088#1089' 1 '#1076#1086#1083#1083#1072#1088#1072' '#1057#1064#1040', '#1090#1077#1085#1075#1077
      FieldName = 'DollarCtg'
      DisplayFormat = '0.00'
      EditFormat = '0'
    end
  end
  object dsResultShifts: TDataSource
    DataSet = quResultShifts
    OnStateChange = TabControlChange
    Left = 304
    Top = 392
  end
  object quResultShiftAutoReport3: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftAutoReport3CalcFields
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftAutoReports'
      'WHERE (Id_ResultShift=:Id_ResultShift)and(Kind=3)')
    Left = 456
    Top = 336
    object quResultShiftAutoReport3Id_ResultShiftAutoReport: TAutoIncField
      FieldName = 'Id_ResultShiftAutoReport'
      ReadOnly = True
    end
    object quResultShiftAutoReport3Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftAutoReport3Id_ResultShiftAuto: TIntegerField
      FieldName = 'Id_ResultShiftAuto'
    end
    object quResultShiftAutoReport3Id_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftAutoReport3DumpModel: TWideStringField
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftAutoReport3Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftAutoReport3IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftAutoReport3RecordNo: TIntegerField
      DisplayLabel = #8470
      FieldName = 'RecordNo'
    end
    object quResultShiftAutoReport3RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftAutoReport3Name: TWideStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftAutoReport3Value: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
    end
    object quResultShiftAutoReport3Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      Calculated = True
    end
    object quResultShiftAutoReport3Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      Calculated = True
    end
  end
  object dsResultShiftAutoReport3: TDataSource
    DataSet = quResultShiftAutoReport3
    Left = 456
    Top = 384
  end
  object quResultShiftExcavatorReport3: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftAutoReport3CalcFields
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftExcavatorReports'
      'WHERE (Id_ResultShift=:Id_ResultShift)and(Kind=3)')
    Left = 632
    Top = 336
    object quResultShiftExcavatorReport3Id_ResultShiftExcavatorReport: TAutoIncField
      FieldName = 'Id_ResultShiftExcavatorReport'
      ReadOnly = True
    end
    object quResultShiftExcavatorReport3Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftExcavatorReport3Id_ResultShiftExcavator: TIntegerField
      FieldName = 'Id_ResultShiftExcavator'
    end
    object quResultShiftExcavatorReport3Id_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftExcavatorReport3DumpModel: TWideStringField
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftExcavatorReport3Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftExcavatorReport3IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftExcavatorReport3RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftExcavatorReport3RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftExcavatorReport3Name: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftExcavatorReport3Value: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
    end
    object quResultShiftExcavatorReport3Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      Calculated = True
    end
    object quResultShiftExcavatorReport3Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      Calculated = True
    end
  end
  object dsResultShiftExcavatorReport3: TDataSource
    DataSet = quResultShiftExcavatorReport3
    Left = 632
    Top = 384
  end
end
