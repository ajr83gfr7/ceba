object fmResultShiftBlocks: TfmResultShiftBlocks
  Left = 541
  Top = 76
  Width = 800
  Height = 780
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1086' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1072#1084' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
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
    Top = 701
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
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 163
      Top = 8
      Width = 76
      Height = 25
      Caption = #1074' Excel'
      TabOrder = 2
      OnClick = btExcelClick
    end
    object btShift: TButton
      Left = 16
      Top = 7
      Width = 128
      Height = 25
      Caption = #1057#1084#1077#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'...'
      TabOrder = 0
      OnClick = btShiftClick
    end
    object btPowerConsuming: TButton
      Left = 273
      Top = 8
      Width = 111
      Height = 25
      Caption = #1069#1085#1077#1088#1075#1086#1077#1084#1082#1086#1089#1090#1100'... '
      TabOrder = 3
      OnClick = btPowerConsumingClick
    end
    object btRoadFunction: TButton
      Left = 397
      Top = 8
      Width = 111
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1078#1077#1085#1085#1086#1089#1090#1100'...'
      TabOrder = 4
      OnClick = btRoadFunctionClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 701
    ActivePage = tsResultShiftBlocksReport3
    Align = alClient
    TabOrder = 1
    object tsResultShiftBlocksReport1: TTabSheet
      Caption = #1055#1086' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1072#1084
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 128
        Width = 776
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object dbgResultShiftBlockReport1: TDBGridEh
        Left = 0
        Top = 133
        Width = 776
        Height = 540
        Align = alClient
        DataSource = dsResultShiftBlockReport1
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        OnDrawColumnCell = dbgResultShiftBlockReport1DrawColumnCell
        Columns = <
          item
            Alignment = taRightJustify
            EditButtons = <>
            FieldName = 'RecordName'
            Footers = <>
            MaxWidth = 30
            MinWidth = 30
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            MinWidth = 360
            Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
            Width = 360
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
            Width = 74
          end>
      end
      object dbgBlocks1: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 128
        Align = alTop
        DataSource = dsResultShiftBlocks
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
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
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Id_ResultShiftBlock'
            Footers = <>
            MaxWidth = 64
            MinWidth = 40
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'Lm'
            Footers = <>
            MaxWidth = 64
            MinWidth = 64
          end
          item
            EditButtons = <>
            FieldName = 'LengthRatio'
            Footers = <>
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Id_RoadCoat'
            Footers = <>
            MaxWidth = 64
            MinWidth = 40
            Title.Caption = #1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077'|'#1050#1086#1076
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'RoadCoat'
            Footer.FieldName = 'DumpNo'
            Footer.ValueType = fvtCount
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077'|'#1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077
            Title.Hint = #1043#1072#1088#1072#1078#1085#1099#1081' '#1085#1086#1084#1077#1088
            Title.ToolTips = True
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'BuildingC1000tg'
            Footers = <>
            MaxWidth = 160
            MinWidth = 80
            Title.Caption = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' 1 '#1082#1084' '#1072#1074#1090#1086#1076#1086#1088#1086#1075#1080'|'#1085#1072' '#1089#1086#1086#1088#1091#1078#1077#1085#1080#1077', '#1090#1099#1089'.'#1090#1077#1085#1075#1077
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'KeepingYearC1000tg'
            Footers = <>
            MaxWidth = 160
            MinWidth = 80
            Title.Caption = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' 1 '#1082#1084' '#1072#1074#1090#1086#1076#1086#1088#1086#1075#1080'|'#1085#1072' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077', '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1075#1086#1076
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'AmortizationR'
            Footers = <>
            MaxWidth = 80
            MinWidth = 80
            Width = 80
          end>
      end
    end
    object tsResultShiftBlocksReport2: TTabSheet
      Caption = #1055#1086' '#1076#1086#1088#1086#1078#1085#1099#1084' '#1087#1086#1082#1088#1099#1090#1080#1103#1084' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1086#1074
      ImageIndex = 2
      object Splitter2: TSplitter
        Left = 0
        Top = 129
        Width = 776
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object dbgBlocks2: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 129
        Align = alTop
        DataSource = dsResultShiftBlockModels
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
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
            FieldName = 'Id_RoadCoat'
            Footers = <>
            MaxWidth = 64
            MinWidth = 64
          end
          item
            EditButtons = <>
            FieldName = 'RoadCoat'
            Footers = <>
            MinWidth = 640
            Width = 640
          end>
      end
      object dbgResultShiftBlockReport2: TDBGridEh
        Left = 0
        Top = 134
        Width = 776
        Height = 539
        Align = alClient
        DataSource = dsResultShiftBlockReport2
        DefaultDrawing = False
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        OnDrawColumnCell = dbgResultShiftBlockReport1DrawColumnCell
        Columns = <
          item
            Alignment = taRightJustify
            EditButtons = <>
            FieldName = 'RecordName'
            Footers = <>
            MaxWidth = 30
            MinWidth = 30
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            MinWidth = 360
            Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
            Width = 360
          end
          item
            EditButtons = <>
            FieldName = 'Value'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1047#1072' '#1089#1084#1077#1085#1091
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Value1'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'Value2'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
            Width = 74
          end>
      end
    end
    object tsResultShiftBlocksReport3: TTabSheet
      Caption = #1055#1086' '#1074#1089#1077#1084' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1072#1084
      ImageIndex = 3
      object dbgResultShiftBlockReport3: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 673
        Align = alClient
        DataSource = dsResultShiftBlockReport3
        DefaultDrawing = False
        Flat = False
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        MinAutoFitWidth = 30
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        VTitleMargin = 2
        OnDrawColumnCell = dbgResultShiftBlockReport1DrawColumnCell
        Columns = <
          item
            Alignment = taRightJustify
            EditButtons = <>
            FieldName = 'RecordName'
            Footers = <>
            MaxWidth = 30
            MinWidth = 30
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            MinWidth = 360
            Title.Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
            Width = 360
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
            Width = 74
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
    Left = 160
    Top = 104
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
    Left = 160
    Top = 152
  end
  object quResultShiftBlocks: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftBlocksCalcFields
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlocks'
      'WHERE Id_ResultShift=:Id_ResultShift')
    Left = 144
    Top = 320
    object quResultShiftBlocksId_ResultShiftBlock: TAutoIncField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_ResultShiftBlock'
      ReadOnly = True
    end
    object quResultShiftBlocksId_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftBlocksId_Block: TIntegerField
      FieldName = 'Id_Block'
    end
    object quResultShiftBlocksId_RoadCoat: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_RoadCoat'
    end
    object quResultShiftBlocksRoadCoat: TWideStringField
      DisplayLabel = #1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077
      FieldName = 'RoadCoat'
      Size = 50
    end
    object quResultShiftBlocksBuildingC1000tg: TFloatField
      DisplayLabel = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1089#1086#1086#1088#1091#1078#1077#1085#1080#1077' 1 '#1082#1084' '#1072#1074#1090#1086#1076#1086#1088#1086#1075#1080', '#1090#1099#1089'.'#1090#1077#1085#1075#1077
      FieldName = 'BuildingC1000tg'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftBlocksKeepingYearC1000tg: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' 1 '#1082#1084' '#1072#1074#1090#1086#1076#1086#1088#1086#1075#1080', '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1075#1086#1076
      FieldName = 'KeepingYearC1000tg'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftBlocksAmortizationR: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'AmortizationR'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftBlocksLengthRatio: TFloatField
      DisplayLabel = #1044#1086#1083#1103', %'
      FieldKind = fkCalculated
      FieldName = 'LengthRatio'
      DisplayFormat = '# ### ##0.0'
      Calculated = True
    end
    object quResultShiftBlocksLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quResultShiftBlocksLm: TFloatField
      DisplayLabel = #1044#1083#1080#1085#1072', '#1084
      FieldKind = fkCalculated
      FieldName = 'Lm'
      DisplayFormat = '# ### ##0.0'
      Calculated = True
    end
  end
  object dsResultShiftBlocks: TDataSource
    DataSet = quResultShiftBlocks
    Left = 144
    Top = 368
  end
  object quResultShiftBlockReport1: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftBlockReport1CalcFields
    DataSource = dsResultShiftBlocks
    Parameters = <
      item
        Name = 'Id_ResultShiftBlock'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (Id_ResultShiftBlock=:Id_ResultShiftBlock)and(Kind=1)'
      'ORDER BY RecordNo')
    Left = 336
    Top = 408
    object quResultShiftBlockReport1Id_ResultShiftBlockReport: TAutoIncField
      FieldName = 'Id_ResultShiftBlockReport'
      ReadOnly = True
    end
    object quResultShiftBlockReport1Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftBlockReport1Id_ResultShiftBlock: TIntegerField
      FieldName = 'Id_ResultShiftBlock'
    end
    object quResultShiftBlockReport1Id_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quResultShiftBlockReport1RoadCoat: TWideStringField
      FieldName = 'RoadCoat'
      Size = 50
    end
    object quResultShiftBlockReport1Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftBlockReport1IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftBlockReport1RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftBlockReport1RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftBlockReport1Name: TStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftBlockReport1Value: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
    end
    object quResultShiftBlockReport1Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
    object quResultShiftBlockReport1Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
  end
  object dsResultShiftBlockReport1: TDataSource
    DataSet = quResultShiftBlockReport1
    Left = 336
    Top = 456
  end
  object quResultShiftBlockModels: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftBlocksCalcFields
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT DISTINCT Id_RoadCoat, RoadCoat, Lsm'
      'FROM _ResultShiftBlockReports'
      'WHERE (Id_ResultShift=:Id_ResultShift)and(Kind=2)')
    Left = 520
    Top = 304
    object quResultShiftBlockModelsId_RoadCoat: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_RoadCoat'
    end
    object quResultShiftBlockModelsRoadCoat: TWideStringField
      DisplayLabel = #1044#1086#1088#1086#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077
      FieldName = 'RoadCoat'
      Size = 50
    end
    object quResultShiftBlockModelsLengthRatio: TFloatField
      DisplayLabel = #1044#1086#1083#1103', %'
      FieldKind = fkCalculated
      FieldName = 'LengthRatio'
      DisplayFormat = '# ### ##0.0'
      Calculated = True
    end
    object quResultShiftBlockModelsLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quResultShiftBlockModelsLm: TFloatField
      DisplayLabel = #1044#1083#1080#1085#1072', '#1084
      FieldKind = fkCalculated
      FieldName = 'Lm'
      DisplayFormat = '# ### ##0.0'
      Calculated = True
    end
  end
  object dsResultShiftBlockModels: TDataSource
    DataSet = quResultShiftBlockModels
    Left = 520
    Top = 352
  end
  object quResultShiftBlockReport2: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftBlockReport1CalcFields
    DataSource = dsResultShiftBlockModels
    Parameters = <
      item
        Name = 'Id_RoadCoat'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '4'
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (Id_RoadCoat=:Id_RoadCoat)and(Kind=2)'
      'ORDER BY RecordNo')
    Left = 536
    Top = 408
    object quResultShiftBlockReport2Id_ResultShiftBlockReport: TAutoIncField
      FieldName = 'Id_ResultShiftBlockReport'
      ReadOnly = True
    end
    object quResultShiftBlockReport2Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftBlockReport2Id_ResultShiftBlock: TIntegerField
      FieldName = 'Id_ResultShiftBlock'
    end
    object quResultShiftBlockReport2Id_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quResultShiftBlockReport2RoadCoat: TWideStringField
      FieldName = 'RoadCoat'
      Size = 50
    end
    object quResultShiftBlockReport2Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftBlockReport2IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftBlockReport2RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftBlockReport2RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftBlockReport2Name: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftBlockReport2Value: TFloatField
      FieldName = 'Value'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
    end
    object quResultShiftBlockReport2Value1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Value1'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
    object quResultShiftBlockReport2Value2: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Value2'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
  end
  object dsResultShiftBlockReport2: TDataSource
    DataSet = quResultShiftBlockReport2
    Left = 536
    Top = 456
  end
  object quResultShiftBlockReport3: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftBlockReport1CalcFields
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
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (Id_ResultShift=:Id_ResultShift)and(Kind=3)'
      'ORDER BY RecordNo')
    Left = 680
    Top = 344
    object quResultShiftBlockReport3Id_ResultShiftBlockReport: TAutoIncField
      FieldName = 'Id_ResultShiftBlockReport'
      ReadOnly = True
    end
    object quResultShiftBlockReport3Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftBlockReport3Id_ResultShiftBlock: TIntegerField
      FieldName = 'Id_ResultShiftBlock'
    end
    object quResultShiftBlockReport3Id_RoadCoat: TIntegerField
      FieldName = 'Id_RoadCoat'
    end
    object quResultShiftBlockReport3RoadCoat: TWideStringField
      FieldName = 'RoadCoat'
      Size = 50
    end
    object quResultShiftBlockReport3Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftBlockReport3IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftBlockReport3RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftBlockReport3RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftBlockReport3Name: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftBlockReport3Value: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
    end
    object quResultShiftBlockReport3Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
    object quResultShiftBlockReport3Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
  end
  object dsResultShiftBlockReport3: TDataSource
    DataSet = quResultShiftBlockReport3
    Left = 680
    Top = 400
  end
  object quResultShiftBlockLengths: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = 1
      end>
    SQL.Strings = (
      'SELECT SUM(Lsm)/100 AS TotalLm'
      'FROM _ResultShiftBlocks'
      'WHERE Id_ResultShift=:Id_ResultShift')
    Left = 560
    Top = 184
    object quResultShiftBlockLengthsTotalLm: TFloatField
      FieldName = 'TotalLm'
    end
  end
end
