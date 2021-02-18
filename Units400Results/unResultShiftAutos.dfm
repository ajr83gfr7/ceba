object fmResultShiftAutos: TfmResultShiftAutos
  Left = 887
  Top = 166
  Width = 800
  Height = 789
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072#1084
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
    Top = 710
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
      Left = 157
      Top = 8
      Width = 75
      Height = 25
      Caption = #1074' Excel'
      TabOrder = 2
      OnClick = btExcelClick
    end
    object btShift: TButton
      Left = 16
      Top = 8
      Width = 128
      Height = 25
      Caption = #1057#1084#1077#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'...'
      TabOrder = 0
      OnClick = btShiftClick
    end
    object btSpeedTime: TButton
      Left = 260
      Top = 8
      Width = 124
      Height = 25
      Caption = #1043#1088#1072#1092#1080#1082' '#1089#1082#1086#1088#1086#1089#1090#1080'...'
      TabOrder = 3
      OnClick = btSpeedTimeClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 710
    ActivePage = tsResultShiftAutosReport3
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    object tsResultShiftAutosReport1: TTabSheet
      Caption = #1055#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072#1084
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 202
        Width = 776
        Height = 6
        Cursor = crVSplit
        Align = alTop
      end
      object dbgResultShiftAutoReport1: TDBGridEh
        Left = 0
        Top = 208
        Width = 776
        Height = 474
        Align = alClient
        DataSource = dsResultShiftAutoReport1
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
        OnDrawColumnCell = dbgResultShiftAutoReport1DrawColumnCell
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
      object dbgAutos1: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 202
        Align = alTop
        DataSource = dsResultShiftAutos
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
            FieldName = 'Id_ResultShiftAuto'
            Footers = <>
            MaxWidth = 64
            MinWidth = 40
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'DumpModel'
            Footers = <>
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'DumpNo'
            Footer.Alignment = taLeftJustify
            Footer.FieldName = 'DumpNo'
            Footer.ValueType = fvtCount
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Hint = #1043#1072#1088#1072#1078#1085#1099#1081' '#1085#1086#1084#1077#1088
            Title.ToolTips = True
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpWorkState'
            Footers = <>
            MaxWidth = 32
            MinWidth = 32
            Title.Caption = #1056#1072#1073'. '#1089#1086#1089'- '#1090#1086#1103'- '#1085#1080#1077
            Width = 32
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'DumpYear'
            Footers = <>
            MaxWidth = 48
            MinWidth = 48
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'DumpPtn'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Hint = #1052#1072#1089#1089#1072' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpQtn'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Hint = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1075#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100', '#1090
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpMaxTsec'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = 'T '#1088#1072#1079#1075#1088', '#1089#1077#1082
            Title.Hint = #1042#1088#1077#1084#1103' '#1088#1072#1079#1075#1088#1091#1079#1082#1080', '#1089#1077#1082
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpMaxNkVt'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = 'N '#1076#1074#1080#1075', '#1082#1042#1090
            Title.Hint = #1052#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpC1000tg'
            Footers = <>
            MaxWidth = 80
            MinWidth = 64
            Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100'|C, '#1090#1099#1089'.'#1090#1075
            Title.Hint = #1054#1089#1090#1072#1090#1086#1095#1085#1072#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090#1099#1089'.'#1090#1075
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'DumpAmortizationR1000km'
            Footers = <>
            MaxWidth = 72
            MinWidth = 72
            Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100'|'#1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080' '#1085#1072' 1000 '#1082#1084
            Title.Hint = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072' '#1085#1072' 1000 '#1082#1084
            Title.ToolTips = True
            ToolTips = True
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'DumpTyresN'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1064#1080#1085#1099'|'#1050#1086#1083'-'#1074#1086
            Title.Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1096#1080#1085
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpTyreC1000tg'
            Footers = <>
            MaxWidth = 80
            MinWidth = 64
            Title.Caption = #1064#1080#1085#1099'|C, '#1090#1099#1089'.'#1090#1075
            Title.Hint = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1096#1080#1085#1099', '#1090#1099#1089'.'#1090#1075
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'DumpTyresAmortizationR1000km'
            Footers = <>
            MaxWidth = 72
            MinWidth = 72
            Title.Caption = #1064#1080#1085#1099'|'#1053#1086#1088#1084#1072' '#1087#1088#1086#1073#1077#1075#1072' '#1096#1080#1085', '#1090#1099#1089'.'#1082#1084
            Title.Hint = #1053#1086#1088#1084#1072' '#1087#1088#1086#1073#1077#1075#1072' '#1096#1080#1085' '#1085#1072' 1000 '#1082#1084
            Title.ToolTips = True
            ToolTips = True
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'DumpTransmissionKPD'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1050#1055#1044'|'#1090#1088#1072#1085#1089'- '#1084#1080#1089'- '#1089#1080#1080
            Title.Hint = #1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpEngineKPD'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1050#1055#1044'|'#1076#1074#1080#1075#1072'- '#1090#1077#1083#1103
            Title.Hint = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
            Width = 40
          end>
      end
    end
    object tsResultShiftAutosReport2: TTabSheet
      Caption = #1055#1086' '#1084#1086#1076#1077#1083#1103#1084' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      ImageIndex = 2
      object Splitter2: TSplitter
        Left = 0
        Top = 129
        Width = 776
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object dbgAutos2: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 129
        Align = alTop
        DataSource = dsResultShiftAutoModels
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
            FieldName = 'Id_DumpModel'
            Footers = <>
            MaxWidth = 64
            MinWidth = 64
          end
          item
            EditButtons = <>
            FieldName = 'DumpModel'
            Footers = <>
            MinWidth = 640
            Width = 640
          end>
      end
      object dbgResultShiftAutoReport2: TDBGridEh
        Left = 0
        Top = 134
        Width = 776
        Height = 548
        Align = alClient
        DataSource = dsResultShiftAutoReport2
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
        OnDrawColumnCell = dbgResultShiftAutoReport1DrawColumnCell
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
    object tsResultShiftAutosReport3: TTabSheet
      Caption = #1055#1086' '#1074#1089#1077#1084' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072#1084
      ImageIndex = 3
      object dbgResultShiftAutoReport3: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 682
        Align = alClient
        DataSource = dsResultShiftAutoReport3
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
        OnDrawColumnCell = dbgResultShiftAutoReport1DrawColumnCell
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
    Left = 256
    Top = 216
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
    Left = 256
    Top = 264
  end
  object quResultShiftAutos: TADOQuery
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
      'SELECT *'
      'FROM _ResultShiftAutos'
      'WHERE Id_ResultShift=:Id_ResultShift'
      'ORDER BY Id_ResultShiftAuto')
    Left = 256
    Top = 320
    object quResultShiftAutosId_ResultShiftAuto: TAutoIncField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_ResultShiftAuto'
      ReadOnly = True
    end
    object quResultShiftAutosId_ResultShift: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1089#1084#1077#1085#1099
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftAutosId_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftAutosDumpModel: TWideStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1100
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftAutosDumpNo: TIntegerField
      DisplayLabel = #1043#1072#1088#1072#1078'. '#1085#1086#1084#1077#1088
      FieldName = 'DumpNo'
      DisplayFormat = '00'
    end
    object quResultShiftAutosDumpYear: TIntegerField
      DisplayLabel = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072
      FieldName = 'DumpYear'
    end
    object quResultShiftAutosDumpPtn: TFloatField
      DisplayLabel = 'P, '#1090
      FieldName = 'DumpPtn'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpQtn: TFloatField
      DisplayLabel = 'Q, '#1090
      FieldName = 'DumpQtn'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpMaxTsec: TFloatField
      DisplayLabel = 'T '#1088#1072#1079#1075#1088#1091#1079#1082#1080', '#1089#1077#1082
      FieldName = 'DumpMaxTsec'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpMaxNkVt: TFloatField
      DisplayLabel = 'N '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
      FieldName = 'DumpMaxNkVt'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpC1000tg: TFloatField
      DisplayLabel = 'C, '#1090#1099#1089'.'#1090#1075
      FieldName = 'DumpC1000tg'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpAmortizationKind: TIntegerField
      DisplayLabel = #1058#1080#1087' '#1085#1086#1088#1084#1099' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'DumpAmortizationKind'
      OnGetText = quResultShiftAutosDumpAmortizationKindGetText
    end
    object quResultShiftAutosDumpAmortizationRate: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
      FieldName = 'DumpAmortizationRate'
      DisplayFormat = '0.0000'
    end
    object quResultShiftAutosDumpTyresN: TIntegerField
      DisplayLabel = 'N '#1096#1080#1085
      FieldName = 'DumpTyresN'
    end
    object quResultShiftAutosDumpTyreC1000tg: TFloatField
      DisplayLabel = 'C '#1096#1080#1085#1099', '#1090#1099#1089'.'#1090#1075
      FieldName = 'DumpTyreC1000tg'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpTyresAmortizationR1000km: TFloatField
      DisplayLabel = #1053#1086#1088#1084#1072' '#1087#1088#1086#1073#1077#1075#1072', '#1090#1099#1089'.'#1082#1084
      FieldName = 'DumpTyresAmortizationR1000km'
      DisplayFormat = '0.0'
    end
    object quResultShiftAutosDumpTransmissionKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
      FieldName = 'DumpTransmissionKPD'
      DisplayFormat = '0.000'
    end
    object quResultShiftAutosDumpEngineKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldName = 'DumpEngineKPD'
      DisplayFormat = '0.000'
    end
    object quResultShiftAutosDumpWorkState: TBooleanField
      DisplayLabel = #1056#1072#1073#1086#1095#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
      FieldName = 'DumpWorkState'
    end
  end
  object dsResultShiftAutos: TDataSource
    DataSet = quResultShiftAutos
    Left = 256
    Top = 368
  end
  object quResultShiftAutoReport1: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftAutoReport1CalcFields
    DataSource = dsResultShiftAutos
    Parameters = <
      item
        Name = 'Id_ResultShiftAuto'
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
      'WHERE (Id_ResultShiftAuto=:Id_ResultShiftAuto)and(Kind=1)'
      'ORDER BY RecordNo')
    Left = 400
    Top = 408
    object quResultShiftAutoReport1Id_ResultShiftAutoReport: TAutoIncField
      FieldName = 'Id_ResultShiftAutoReport'
      ReadOnly = True
    end
    object quResultShiftAutoReport1Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftAutoReport1Id_ResultShiftAuto: TIntegerField
      FieldName = 'Id_ResultShiftAuto'
    end
    object quResultShiftAutoReport1Id_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftAutoReport1DumpModel: TWideStringField
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftAutoReport1Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftAutoReport1IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftAutoReport1RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftAutoReport1RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftAutoReport1Name: TWideStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftAutoReport1Value: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
      OnGetText = quResultShiftAutoReport1ValueGetText
      DisplayFormat = '0.000'
    end
    object quResultShiftAutoReport1Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      OnGetText = quResultShiftAutoReport1ValueGetText
      DisplayFormat = '0.000'
      Calculated = True
    end
    object quResultShiftAutoReport1Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      OnGetText = quResultShiftAutoReport1ValueGetText
      DisplayFormat = '0.000'
      Calculated = True
    end
  end
  object dsResultShiftAutoReport1: TDataSource
    DataSet = quResultShiftAutoReport1
    Left = 400
    Top = 456
  end
  object quResultShiftAutoModels: TADOQuery
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
        Value = Null
      end>
    SQL.Strings = (
      'SELECT DISTINCT (RSA.Id_DumpModel) AS Id_DumpModel, '
      'RSA.DumpModel'
      'FROM _ResultShiftAutos AS RSA'
      'WHERE RSA.Id_ResultShift=:Id_ResultShift')
    Left = 520
    Top = 304
    object quResultShiftAutoModelsId_DumpModel: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftAutoModelsDumpModel: TWideStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
      FieldName = 'DumpModel'
      Size = 50
    end
  end
  object dsResultShiftAutoModels: TDataSource
    DataSet = quResultShiftAutoModels
    Left = 520
    Top = 352
  end
  object quResultShiftAutoReport2: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftAutoReport1CalcFields
    DataSource = dsResultShiftAutoModels
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
      'FROM _ResultShiftAutoReports'
      'WHERE (Id_DumpModel=:Id_DumpModel)and(Kind=2)'
      'ORDER BY RecordNo')
    Left = 536
    Top = 408
    object quResultShiftAutoReport2Id_ResultShiftAutoReport: TAutoIncField
      FieldName = 'Id_ResultShiftAutoReport'
      ReadOnly = True
    end
    object quResultShiftAutoReport2Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftAutoReport2Id_ResultShiftAuto: TIntegerField
      FieldName = 'Id_ResultShiftAuto'
    end
    object quResultShiftAutoReport2Id_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftAutoReport2DumpModel: TWideStringField
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftAutoReport2Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftAutoReport2IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftAutoReport2RecordNo: TIntegerField
      DisplayLabel = #8470
      FieldName = 'RecordNo'
    end
    object quResultShiftAutoReport2RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftAutoReport2Name: TWideStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftAutoReport2Value: TFloatField
      FieldName = 'Value'
      OnGetText = quResultShiftAutoReport1ValueGetText
    end
    object quResultShiftAutoReport2Value1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Value1'
      OnGetText = quResultShiftAutoReport1ValueGetText
      Calculated = True
    end
    object quResultShiftAutoReport2Value2: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Value2'
      OnGetText = quResultShiftAutoReport1ValueGetText
      Calculated = True
    end
  end
  object dsResultShiftAutoReport2: TDataSource
    DataSet = quResultShiftAutoReport2
    Left = 536
    Top = 456
  end
  object quResultShiftAutoReport3: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftAutoReport1CalcFields
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
    Left = 680
    Top = 352
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
      OnGetText = quResultShiftAutoReport1ValueGetText
    end
    object quResultShiftAutoReport3Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      OnGetText = quResultShiftAutoReport1ValueGetText
      Calculated = True
    end
    object quResultShiftAutoReport3Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      OnGetText = quResultShiftAutoReport1ValueGetText
      Calculated = True
    end
  end
  object dsResultShiftAutoReport3: TDataSource
    DataSet = quResultShiftAutoReport3
    Left = 680
    Top = 400
  end
end
