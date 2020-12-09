object fmResultShiftExcavators: TfmResultShiftExcavators
  Left = 185
  Top = 85
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1086' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072#1084
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
    Top = 522
    Width = 784
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      784
      40)
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
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Caption = #1074' Excel'
      TabOrder = 2
      OnClick = btExcelClick
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
    Height = 522
    ActivePage = tsResultShiftExcavatorsReport3
    Align = alClient
    TabOrder = 1
    object tsResultShiftExcavatorsReport1: TTabSheet
      Caption = #1055#1086' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072#1084
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 0
        Top = 128
        Width = 776
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object dbgResultShiftExcavatorReport1: TDBGridEh
        Left = 0
        Top = 133
        Width = 776
        Height = 361
        Align = alClient
        DataSource = dsResultShiftExcavatorReport1
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
        OnDrawColumnCell = dbgResultShiftExcavatorReport1DrawColumnCell
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
          end
          item
            EditButtons = <>
            FieldName = 'Value1'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
          end
          item
            EditButtons = <>
            FieldName = 'Value2'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
          end>
      end
      object dbgExcavators1: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 128
        Align = alTop
        DataSource = dsResultShiftExcavators
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
            FieldName = 'Id_ResultShiftExcavator'
            Footers = <>
            MaxWidth = 64
            MinWidth = 40
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
            FieldName = 'DumpTsec'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = 'T '#1088#1072#1073'. '#1094#1080#1082#1083#1072', '#1089#1077#1082
            Title.Hint = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077' '#1074#1088#1077#1084#1103' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1094#1080#1082#1083#1072', '#1089#1077#1082
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
            FieldName = 'DumpMaxVm3'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Hint = #1054#1073#1098#1077#1084' '#1082#1086#1074#1096#1072', '#1084'3'
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
          end
          item
            EditButtons = <>
            FieldName = 'DumpEngineKPD'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1044#1074#1080#1075#1072#1090#1077#1083#1100'|'#1050#1055#1044
            Title.Hint = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpEngineKIM'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1044#1074#1080#1075#1072#1090#1077#1083#1100'|'#1050#1048#1052
            Title.Hint = #1050#1048#1052' '#1076#1074#1080#1075#1072#1090#1077#1083#1103' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'DumpMaterialsMonthC1000tg'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089'|'#1084#1072#1090#1077#1088#1080#1072#1083#1099
            Title.Hint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
          end
          item
            EditButtons = <>
            FieldName = 'DumpUnAccountedMonthC1000tg'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089'|'#1085#1077#1091#1095#1090#1077#1085#1085#1099#1077
            Title.Hint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1085#1077#1091#1095#1090#1077#1085#1085#1099#1077', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
          end
          item
            EditButtons = <>
            FieldName = 'Id_LoadingPunkt'
            Footers = <>
            MaxWidth = 40
            MinWidth = 40
            Title.Caption = #1055#1091#1085#1082#1090' '#1087#1086#1075#1088#1091#1079#1082#1080'|'#1050#1086#1076
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'Horizont'
            Footers = <>
            MaxWidth = 80
            MinWidth = 80
            Title.Caption = #1055#1091#1085#1082#1090' '#1087#1086#1075#1088#1091#1079#1082#1080'|'#1043#1086#1088#1080#1079#1086#1085#1090', '#1084
            Width = 80
          end>
      end
    end
    object tsResultShiftExcavatorsReport2: TTabSheet
      Caption = #1055#1086' '#1084#1086#1076#1077#1083#1103#1084' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074
      ImageIndex = 2
      object Splitter2: TSplitter
        Left = 0
        Top = 129
        Width = 776
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object dbgExcavators2: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 129
        Align = alTop
        DataSource = dsResultShiftExcavatorModels
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
      object dbgResultShiftExcavatorReport2: TDBGridEh
        Left = 0
        Top = 134
        Width = 776
        Height = 362
        Align = alClient
        DataSource = dsResultShiftExcavatorReport2
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
        OnDrawColumnCell = dbgResultShiftExcavatorReport1DrawColumnCell
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
          end
          item
            EditButtons = <>
            FieldName = 'Value1'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
          end
          item
            EditButtons = <>
            FieldName = 'Value2'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
            Title.Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
          end>
      end
    end
    object tsResultShiftExcavatorsReport3: TTabSheet
      Caption = #1055#1086' '#1074#1089#1077#1084' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072#1084
      ImageIndex = 3
      object dbgResultShiftExcavatorReport3: TDBGridEh
        Left = 0
        Top = 0
        Width = 776
        Height = 494
        Align = alClient
        DataSource = dsResultShiftExcavatorReport3
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
        OnDrawColumnCell = dbgResultShiftExcavatorReport1DrawColumnCell
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
          end
          item
            EditButtons = <>
            FieldName = 'Value1'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
          end
          item
            EditButtons = <>
            FieldName = 'Value2'
            Footers = <>
            MaxWidth = 120
            MinWidth = 64
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
    Left = 144
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
    Left = 144
    Top = 264
  end
  object quResultShiftExcavators: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftExcavators'
      'WHERE Id_ResultShift=:Id_ResultShift')
    Left = 144
    Top = 320
    object quResultShiftExcavatorsId_ResultShiftExcavator: TAutoIncField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_ResultShiftExcavator'
      ReadOnly = True
    end
    object quResultShiftExcavatorsId_ResultShift: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1089#1084#1077#1085#1099
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftExcavatorsId_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftExcavatorsDumpModel: TWideStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1100
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftExcavatorsDumpNo: TIntegerField
      DisplayLabel = #1043#1072#1088#1072#1078'. '#1085#1086#1084#1077#1088
      FieldName = 'DumpNo'
      DisplayFormat = '00'
    end
    object quResultShiftExcavatorsDumpYear: TIntegerField
      DisplayLabel = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072
      FieldName = 'DumpYear'
      DisplayFormat = '0000'
    end
    object quResultShiftExcavatorsDumpTsec: TFloatField
      FieldName = 'DumpTsec'
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsDumpMaxNkVt: TFloatField
      DisplayLabel = 'N '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
      FieldName = 'DumpMaxNkVt'
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsDumpMaxVm3: TFloatField
      DefaultExpression = '0.0'
      DisplayLabel = 'V '#1082#1086#1074#1096#1072', '#1084'3'
      FieldName = 'DumpMaxVm3'
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsDumpC1000tg: TFloatField
      DisplayLabel = 'C, '#1090#1099#1089'.'#1090#1075
      FieldName = 'DumpC1000tg'
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsDumpEngineKIM: TFloatField
      DisplayLabel = #1050#1048#1052' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldName = 'DumpEngineKIM'
      DisplayFormat = '0.000'
    end
    object quResultShiftExcavatorsDumpEngineKPD: TFloatField
      DisplayLabel = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
      FieldName = 'DumpEngineKPD'
      DisplayFormat = '0.000'
    end
    object quResultShiftExcavatorsDumpMaterialsMonthC1000tg: TFloatField
      DisplayLabel = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
      FieldName = 'DumpMaterialsMonthC1000tg'
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsDumpUnAccountedMonthC1000tg: TFloatField
      DisplayLabel = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1085#1077#1091#1095#1090#1077#1085#1085#1099#1077', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
      FieldName = 'DumpUnAccountedMonthC1000tg'
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsId_LoadingPunkt: TAutoIncField
      DisplayLabel = #1050#1086#1076' '#1087#1091#1085#1082#1090#1072' '#1087#1086#1075#1088#1091#1079#1082#1080
      FieldName = 'Id_LoadingPunkt'
      ReadOnly = True
    end
    object quResultShiftExcavatorsHorizont: TFloatField
      DisplayLabel = #1043#1086#1088#1080#1079#1086#1085#1090', '#1084
      FieldName = 'Horizont'
      OnGetText = quResultShiftExcavatorsHorizontGetText
      DisplayFormat = '0.0'
    end
    object quResultShiftExcavatorsDumpWorkState: TBooleanField
      FieldName = 'DumpWorkState'
    end
  end
  object dsResultShiftExcavators: TDataSource
    DataSet = quResultShiftExcavators
    Left = 144
    Top = 368
  end
  object quResultShiftExcavatorReport1: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftExcavatorReport1CalcFields
    DataSource = dsResultShiftExcavators
    Parameters = <
      item
        Name = 'Id_ResultShiftExcavator'
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
      
        'WHERE (Id_ResultShiftExcavator=:Id_ResultShiftExcavator)and(Kind' +
        '=1)'
      'ORDER BY RecordNo')
    Left = 336
    Top = 408
    object quResultShiftExcavatorReport1Id_ResultShiftExcavatorReport: TAutoIncField
      FieldName = 'Id_ResultShiftExcavatorReport'
      ReadOnly = True
    end
    object quResultShiftExcavatorReport1Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftExcavatorReport1Id_ResultShiftExcavator: TIntegerField
      FieldName = 'Id_ResultShiftExcavator'
    end
    object quResultShiftExcavatorReport1Id_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftExcavatorReport1DumpModel: TWideStringField
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftExcavatorReport1Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftExcavatorReport1IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftExcavatorReport1RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftExcavatorReport1RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftExcavatorReport1Name: TStringField
      DisplayLabel = #1055#1072#1088#1072#1084#1077#1090#1088
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftExcavatorReport1Value: TFloatField
      DisplayLabel = #1047#1072' '#1089#1084#1077#1085#1091
      FieldName = 'Value'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      DisplayFormat = '0.000'
    end
    object quResultShiftExcavatorReport1Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      DisplayFormat = '0.000'
      Calculated = True
    end
    object quResultShiftExcavatorReport1Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      DisplayFormat = '0.000'
      Calculated = True
    end
  end
  object dsResultShiftExcavatorReport1: TDataSource
    DataSet = quResultShiftExcavatorReport1
    Left = 336
    Top = 456
  end
  object quResultShiftExcavatorModels: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftFixedChar
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      
        'SELECT DISTINCT (RSE.Id_DumpModel) AS Id_DumpModel, RSE.DumpMode' +
        'l'
      'FROM _ResultShiftExcavators AS RSE'
      'WHERE RSE.Id_ResultShift=:Id_ResultShift')
    Left = 520
    Top = 304
    object quResultShiftExcavatorModelsId_DumpModel: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftExcavatorModelsDumpModel: TWideStringField
      DisplayLabel = #1052#1086#1076#1077#1083#1100' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
      FieldName = 'DumpModel'
      Size = 50
    end
  end
  object dsResultShiftExcavatorModels: TDataSource
    DataSet = quResultShiftExcavatorModels
    Left = 520
    Top = 352
  end
  object quResultShiftExcavatorReport2: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftExcavatorReport1CalcFields
    DataSource = dsResultShiftExcavatorModels
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
      'FROM _ResultShiftExcavatorReports'
      'WHERE (Id_DumpModel=:Id_DumpModel)and(Kind=2)'
      'ORDER BY RecordNo')
    Left = 536
    Top = 408
    object quResultShiftExcavatorReport2Id_ResultShiftExcavatorReport: TAutoIncField
      FieldName = 'Id_ResultShiftExcavatorReport'
      ReadOnly = True
    end
    object quResultShiftExcavatorReport2Id_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftExcavatorReport2Id_ResultShiftExcavator: TIntegerField
      FieldName = 'Id_ResultShiftExcavator'
    end
    object quResultShiftExcavatorReport2Id_DumpModel: TIntegerField
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftExcavatorReport2DumpModel: TWideStringField
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftExcavatorReport2Kind: TWordField
      FieldName = 'Kind'
    end
    object quResultShiftExcavatorReport2IsChangeable: TBooleanField
      FieldName = 'IsChangeable'
    end
    object quResultShiftExcavatorReport2RecordNo: TIntegerField
      FieldName = 'RecordNo'
    end
    object quResultShiftExcavatorReport2RecordName: TWideStringField
      DisplayLabel = #8470
      FieldName = 'RecordName'
      Size = 10
    end
    object quResultShiftExcavatorReport2Name: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object quResultShiftExcavatorReport2Value: TFloatField
      FieldName = 'Value'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
    end
    object quResultShiftExcavatorReport2Value1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Value1'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      Calculated = True
    end
    object quResultShiftExcavatorReport2Value2: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Value2'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      Calculated = True
    end
  end
  object dsResultShiftExcavatorReport2: TDataSource
    DataSet = quResultShiftExcavatorReport2
    Left = 536
    Top = 456
  end
  object quResultShiftExcavatorReport3: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftExcavatorReport1CalcFields
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
    Left = 680
    Top = 352
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
      OnGetText = quResultShiftExcavatorReport1ValueGetText
    end
    object quResultShiftExcavatorReport3Value1: TFloatField
      DisplayLabel = #1047#1072' '#1089#1088#1077#1076#1085#1077'- '#1085#1077#1076#1077#1083#1100#1085#1091#1102' '#1089#1084#1077#1085#1091
      FieldKind = fkCalculated
      FieldName = 'Value1'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      Calculated = True
    end
    object quResultShiftExcavatorReport3Value2: TFloatField
      DisplayLabel = #1047#1072' '#1087#1077#1088#1080#1086#1076
      FieldKind = fkCalculated
      FieldName = 'Value2'
      OnGetText = quResultShiftExcavatorReport1ValueGetText
      Calculated = True
    end
  end
  object dsResultShiftExcavatorReport3: TDataSource
    DataSet = quResultShiftExcavatorReport3
    Left = 680
    Top = 400
  end
end
