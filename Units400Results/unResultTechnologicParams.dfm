object fmResultTechnologicParams: TfmResultTechnologicParams
  Left = 767
  Top = 321
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' '#1079#1072' '#1087#1077#1088#1080#1086#1076
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
    object btClose: TButton
      Left = 704
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 2
    end
    object btExcel: TButton
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Caption = #1074' Excel'
      TabOrder = 1
      Visible = False
    end
    object btShift: TButton
      Left = 16
      Top = 7
      Width = 120
      Height = 25
      Caption = #1057#1084#1077#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'...'
      TabOrder = 0
      OnClick = btShiftClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 521
    ActivePage = tsRocks
    Align = alClient
    TabOrder = 1
    object tsAutos: TTabSheet
      Caption = #1056#1072#1089#1093#1086#1076' '#1090#1086#1087#1083#1080#1074#1072' '#1080' '#1096#1080#1085
      object Splitter0: TSplitter
        Left = 0
        Top = 129
        Width = 776
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object dbgAutos: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 129
        Align = alTop
        DataSource = dsResultAutos
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Id_DumpModel'
            Footers = <>
            MaxWidth = 64
            MinWidth = 64
            Title.Caption = #1052#1086#1076#1077#1083#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074'|'#1050#1086#1076
          end
          item
            EditButtons = <>
            FieldName = 'DumpModel'
            Footers = <>
            MinWidth = 600
            Title.Caption = #1052#1086#1076#1077#1083#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074'|'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 600
          end>
      end
      object dbgAutoParams: TDBGridEh
        Left = 0
        Top = 132
        Width = 776
        Height = 361
        Align = alClient
        DataSource = dsResultAutoParams
        DefaultDrawing = False
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        OnDrawColumnCell = dbgAutoParamsDrawColumnCell
        Columns = <
          item
            EditButtons = <>
            FieldName = 'RecordName'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            MinWidth = 320
            Width = 320
          end
          item
            EditButtons = <>
            FieldName = 'Value'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Value1'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Value2'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Width = 73
          end>
      end
    end
    object tsRocks: TTabSheet
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 129
        Width = 776
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object dbgRocks: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 129
        Align = alTop
        DataSource = dsResultRocks
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Id_Rock'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1050#1086#1076
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'Rock'
            Footers = <>
            MinWidth = 560
            Title.Caption = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 560
          end>
      end
      object dbgRockParams: TDBGridEh
        Left = 0
        Top = 132
        Width = 776
        Height = 361
        Align = alClient
        DataSource = dsResultRockParams
        DefaultDrawing = False
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        OnDrawColumnCell = dbgAutoParamsDrawColumnCell
        Columns = <
          item
            EditButtons = <>
            FieldName = 'RecordName'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            MinWidth = 320
            Width = 320
          end
          item
            EditButtons = <>
            FieldName = 'AValue'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Value1'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Value2'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Width = 73
          end>
      end
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
    Left = 24
    Top = 424
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
    Left = 24
    Top = 472
  end
  object quResultAutos: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT DISTINCT Id_DumpModel,DumpModel'
      'FROM _ResultTechnologicAutoParams'
      'WHERE Id_ResultShift=:Id_ResultShift'
      'ORDER BY Id_DumpModel')
    Left = 144
    Top = 424
    object quResultAutosId_DumpModel: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_DumpModel'
    end
    object quResultAutosDumpModel: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'DumpModel'
      Size = 50
    end
  end
  object dsResultAutos: TDataSource
    DataSet = quResultAutos
    Left = 144
    Top = 472
  end
  object quResultAutoParams: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultAutoParamsCalcFields
    DataSource = dsResultAutos
    Parameters = <
      item
        Name = 'Id_DumpModel'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultTechnologicAutoParams'
      'WHERE Id_DumpModel=:Id_DumpModel'
      'ORDER BY RecordNo')
    Left = 272
    Top = 424
    object quResultAutoParamsId_ResultTechnologicAutoParam: TAutoIncField
      FieldName = 'Id_ResultTechnologicAutoParam'
      ReadOnly = True
    end
    object quResultAutoParamsId_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultAutoParamsIsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultAutoParamsRecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultAutoParamsRecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultAutoParamsName: TWideStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object quResultAutoParamsValue: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
      DisplayFormat = '# ### ##0.000'
    end
    object quResultAutoParamsValue1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      DisplayFormat = '# ### ##0.000'
      Calculated = True
    end
    object quResultAutoParamsValue2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      DisplayFormat = '# ### ##0.000'
      Calculated = True
    end
  end
  object dsResultAutoParams: TDataSource
    DataSet = quResultAutoParams
    Left = 272
    Top = 472
  end
  object quResultRocks: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT DISTINCT Id_Rock, Rock'
      'FROM _ResultTechnologicRockParams'
      'WHERE Id_ResultShift=:Id_ResultShift'
      'ORDER BY Id_Rock')
    Left = 464
    Top = 416
    object quResultRocksId_Rock: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_Rock'
    end
    object quResultRocksRock: TWideStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Rock'
      Size = 50
    end
  end
  object dsResultRocks: TDataSource
    DataSet = quResultRocks
    Left = 464
    Top = 464
  end
  object quResultRockParams: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultRockParamsCalcFields
    DataSource = dsResultRocks
    Parameters = <
      item
        Name = 'Id_Rock'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT Id_Rock, Value as AValue, RecordName, Name, RecordNo '
      'FROM _ResultTechnologicRockParams '
      'WHERE Id_Rock=:Id_Rock '
      'ORDER BY RecordName')
    Left = 584
    Top = 416
    object quResultRockParamsId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quResultRockParamsRecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object WideStringField1: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object WideStringField2: TWideStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object FloatField1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'AValue'
      DisplayFormat = '# ### ##0.000'
    end
    object FloatField2: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      DisplayFormat = '# ### ##0.000'
      Calculated = True
    end
    object FloatField3: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      DisplayFormat = '# ### ##0.000'
      Calculated = True
    end
  end
  object dsResultRockParams: TDataSource
    DataSet = quResultRockParams
    Left = 584
    Top = 464
  end
end
