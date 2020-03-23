object fmResultShift: TfmResultShift
  Left = 844
  Top = 144
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099
  ClientHeight = 394
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object lbId_ResultShift: TLabel
    Left = 20
    Top = 12
    Width = 132
    Height = 16
    Caption = #1050#1086#1076' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099
    FocusControl = dbeId_ResultShift
  end
  object lbId_Openpit: TLabel
    Left = 20
    Top = 41
    Width = 110
    Height = 16
    Caption = #1050#1086#1076' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
    FocusControl = dbeId_Openpit
  end
  object lbShiftNaryadTmin: TLabel
    Left = 20
    Top = 73
    Width = 244
    Height = 16
    Caption = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077'), '#1084#1080#1085
    FocusControl = dbeShiftNaryadTmin
  end
  object lbShiftPlanNaryadTmin: TLabel
    Left = 20
    Top = 110
    Width = 141
    Height = 16
    Caption = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077', '#1084#1080#1085
    FocusControl = dbeShiftPlanNaryadTmin
  end
  object lbShiftPeresmenkaTmin: TLabel
    Left = 20
    Top = 140
    Width = 163
    Height = 16
    Caption = #1042#1088#1077#1084#1103' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
    FocusControl = dbeShiftPeresmenkaTmin
  end
  object lbShiftTmin: TLabel
    Left = 20
    Top = 169
    Width = 285
    Height = 16
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099', '#1084#1080#1085
    FocusControl = dbeShiftTmin
  end
  object lbShiftKweek: TLabel
    Left = 20
    Top = 201
    Width = 325
    Height = 16
    AutoSize = False
    Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1074#1086#1076#1072' '#1089#1084#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
    FocusControl = dbeShiftKweek
  end
  object lbPeriodKshift: TLabel
    Left = 20
    Top = 268
    Width = 295
    Height = 32
    AutoSize = False
    Caption = 
      #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1074#1086#1076#1072' '#1089#1084#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' * '#1058' '#1087#1077#1088#1080#1086#1076#1072','#1076#1085#1080' * '#1050#1086#1083#1080#1095#1077 +
      #1089#1090#1074#1086' '#1089#1084#1077#1085' '#1074' '#1089#1091#1090#1082#1072#1093
    FocusControl = dbePeriodKshift
    WordWrap = True
  end
  object lbPeriodTday: TLabel
    Left = 20
    Top = 238
    Width = 237
    Height = 16
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1087#1077#1088#1080#1086#1076#1072', '#1076#1085#1080
    FocusControl = dbePeriodTday
  end
  object lbDollarCtg: TLabel
    Left = 20
    Top = 299
    Width = 181
    Height = 16
    Caption = #1050#1091#1088#1089' 1 '#1076#1086#1083#1083#1072#1088#1072' '#1057#1064#1040', '#1090#1077#1085#1075#1077
    FocusControl = dbeDollarCtg
  end
  object pnBtns: TPanel
    Left = 0
    Top = 344
    Width = 556
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btOk: TButton
      Left = 414
      Top = 10
      Width = 88
      Height = 31
      Cancel = True
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object dbeId_ResultShift: TDBEdit
    Left = 360
    Top = 12
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'Id_ResultShift'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 1
  end
  object dbeId_Openpit: TDBEdit
    Left = 360
    Top = 41
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'Id_Openpit'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 2
  end
  object dbeShiftNaryadTmin: TDBEdit
    Left = 360
    Top = 73
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'ShiftNaryadTmin'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 3
  end
  object dbeShiftPlanNaryadTmin: TDBEdit
    Left = 360
    Top = 110
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'ShiftPlanNaryadTmin'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 4
  end
  object dbeShiftPeresmenkaTmin: TDBEdit
    Left = 360
    Top = 140
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'ShiftPeresmenkaTmin'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 5
  end
  object dbeShiftTmin: TDBEdit
    Left = 360
    Top = 169
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'ShiftTmin'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 6
  end
  object dbeShiftKweek: TDBEdit
    Left = 360
    Top = 201
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'ShiftKweek'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 7
  end
  object dbePeriodKshift: TDBEdit
    Left = 360
    Top = 268
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'PeriodKshift'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 9
  end
  object dbePeriodTday: TDBEdit
    Left = 360
    Top = 238
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'PeriodTday'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 8
  end
  object dbeDollarCtg: TDBEdit
    Left = 360
    Top = 299
    Width = 177
    Height = 24
    Color = clBtnFace
    DataField = 'DollarCtg'
    DataSource = dsResultShifts
    ReadOnly = True
    TabOrder = 10
  end
  object quResultShifts: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftsCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShifts')
    Left = 32
    Top = 152
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
    Left = 32
    Top = 200
  end
end
