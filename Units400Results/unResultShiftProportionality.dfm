object fmResultShiftProportionality: TfmResultShiftProportionality
  Left = 871
  Top = 165
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1086#1087#1086#1088#1094#1080#1086#1085#1072#1083#1100#1085#1086#1089#1090#1080
  ClientHeight = 276
  ClientWidth = 584
  Color = clBtnFace
  Constraints.MinHeight = 312
  Constraints.MinWidth = 600
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
    Top = 235
    Width = 584
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      584
      41)
    object btCancel: TButton
      Left = 488
      Top = 8
      Width = 72
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
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
    Width = 584
    Height = 235
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      #1047#1072' '#1089#1084#1077#1085#1091
      #1047#1072' '#1089#1088#1077#1076#1085#1077#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      #1047#1072' '#1087#1077#1088#1080#1086#1076)
    TabIndex = 0
    OnChange = TabControlChange
    object ledUsingRatio0: TLabeledEdit
      Left = 432
      Top = 40
      Width = 128
      Height = 24
      EditLabel.Width = 233
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 0
    end
    object ledUsingRatio1: TLabeledEdit
      Left = 432
      Top = 64
      Width = 128
      Height = 24
      EditLabel.Width = 219
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 1
    end
    object ledWaitingTmin0: TLabeledEdit
      Left = 432
      Top = 104
      Width = 128
      Height = 24
      EditLabel.Width = 185
      EditLabel.Height = 13
      EditLabel.Caption = #1042#1088#1077#1084#1103' '#1087#1088#1086#1089#1090#1086#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1084#1080#1085
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 2
    end
    object ledWaitingTmin1: TLabeledEdit
      Left = 432
      Top = 128
      Width = 128
      Height = 24
      EditLabel.Width = 171
      EditLabel.Height = 13
      EditLabel.Caption = #1042#1088#1077#1084#1103' '#1087#1088#1086#1089#1090#1086#1103' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072', '#1084#1080#1085
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 3
    end
    object ledProportionality0: TLabeledEdit
      Left = 432
      Top = 168
      Width = 128
      Height = 24
      EditLabel.Width = 418
      EditLabel.Height = 13
      EditLabel.Caption = 
        #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1086#1087#1086#1088#1094#1080#1086#1085#1072#1083#1100#1085#1086#1089#1090#1080' '#1086#1090#1085#1086#1089#1080#1090#1077#1083#1100#1085#1086' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1086#1074' '#1080#1089#1087#1086#1083#1100 +
        #1079#1086#1074#1072#1085#1080#1103
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 4
    end
    object ledProportionality1: TLabeledEdit
      Left = 432
      Top = 192
      Width = 128
      Height = 24
      EditLabel.Width = 350
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1086#1087#1086#1088#1094#1080#1086#1085#1072#1083#1100#1085#1086#1089#1090#1080' '#1086#1090#1085#1086#1089#1080#1090#1077#1083#1100#1085#1086' '#1074#1088#1077#1084#1077#1085#1080' '#1087#1088#1086#1089#1090#1086#1077#1074
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 5
    end
  end
  object quResultShifts: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftsCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShifts')
    Left = 72
    Top = 48
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
    Left = 72
    Top = 96
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
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftAutoReports'
      'WHERE (Id_ResultShift=:Id_ResultShift)and(Kind=3)'
      'ORDER BY RecordNo')
    Left = 192
    Top = 48
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
    Left = 192
    Top = 96
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
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftExcavatorReports'
      'WHERE (Id_ResultShift=:Id_ResultShift)and(Kind=3)'
      'ORDER BY RecordNo')
    Left = 368
    Top = 48
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
    Left = 368
    Top = 96
  end
end
