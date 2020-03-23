object fmVariantGraphics: TfmVariantGraphics
  Left = 717
  Top = 231
  Width = 1144
  Height = 890
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1043#1088#1072#1092#1080#1082#1080' '#1074#1072#1088#1080#1072#1085#1090#1086#1074' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object pnBtns: TPanel
    Left = 0
    Top = 795
    Width = 1126
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1126
      50)
    object btPrint: TButton
      Left = 20
      Top = 10
      Width = 88
      Height = 31
      Caption = #1055#1077#1095#1072#1090#1100'..'
      TabOrder = 0
    end
    object btSaveAs: TButton
      Left = 118
      Top = 10
      Width = 128
      Height = 31
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'..'
      TabOrder = 1
    end
    object btClose: TButton
      Left = 1164
      Top = 10
      Width = 89
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Default = True
      ModalResult = 2
      TabOrder = 2
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1126
    Height = 795
    ActivePage = tsUdCtg
    Align = alClient
    TabOrder = 1
    object tsUdCtg: TTabSheet
      Caption = 'I'
      object DBChart0: TDBChart
        Left = 0
        Top = 0
        Width = 1118
        Height = 764
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        LeftWall.Color = 11445073
        MarginBottom = 5
        MarginLeft = 5
        MarginRight = 5
        MarginTop = 5
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -20
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          #1059#1076#1077#1083#1100#1085#1099#1077' '#1090#1077#1082#1091#1097#1080#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1077#1076#1080#1085#1080#1094#1091' '#1075#1086#1088#1085#1086#1081' '#1084#1072#1089#1089#1099)
        BottomAxis.Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
        BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
        BottomAxis.Title.Font.Color = clBlack
        BottomAxis.Title.Font.Height = -11
        BottomAxis.Title.Font.Name = 'Arial'
        BottomAxis.Title.Font.Style = [fsBold]
        Chart3DPercent = 25
        LeftAxis.AxisValuesFormat = '#,##0.#'
        LeftAxis.StartPosition = 10.000000000000000000
        LeftAxis.Title.Caption = #1059#1076#1077#1083#1100#1085#1099#1077' '#1090#1077#1082#1091#1097#1080#1077' '#1079#1072#1090#1088#1072#1090#1099', '#1090#1075'/'#1084'3('#1090')'
        LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
        LeftAxis.Title.Font.Color = clBlack
        LeftAxis.Title.Font.Height = -11
        LeftAxis.Title.Font.Name = 'Arial'
        LeftAxis.Title.Font.Style = [fsBold]
        Legend.Visible = False
        View3DOptions.Elevation = 342
        View3DOptions.Perspective = 20
        View3DOptions.Zoom = 97
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Series1: TBarSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = True
          DataSource = quVariants
          SeriesColor = 16744576
          Title = #1059#1076#1077#1083#1100#1085#1099#1077' '#1090#1077#1082#1091#1097#1080#1077' '#1079#1072#1090#1088#1072#1090#1099', '#1090#1075'/'#1084'3'
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          XValues.ValueSource = 'SortIndex'
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'EconomUdCtg_m3'
        end
      end
    end
    object tsRockRatio: TTabSheet
      Caption = 'II'
      ImageIndex = 1
      object DBChart1: TDBChart
        Left = 0
        Top = 0
        Width = 1118
        Height = 764
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        MarginBottom = 5
        MarginLeft = 5
        MarginRight = 5
        MarginTop = 5
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -20
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          #1057#1090#1077#1087#1077#1085#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1087#1083#1072#1085#1072)
        BottomAxis.Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
        BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
        BottomAxis.Title.Font.Color = clBlack
        BottomAxis.Title.Font.Height = -11
        BottomAxis.Title.Font.Name = 'Arial'
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.AxisValuesFormat = '#,##0.#'
        LeftAxis.StartPosition = 10.000000000000000000
        LeftAxis.Title.Caption = #1057#1090#1077#1087#1077#1085#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1087#1083#1072#1085#1072', %'
        LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
        LeftAxis.Title.Font.Color = clBlack
        LeftAxis.Title.Font.Height = -11
        LeftAxis.Title.Font.Name = 'Arial'
        LeftAxis.Title.Font.Style = [fsBold]
        Legend.Visible = False
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object LineSeries1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = clRed
          Title = #1057#1090#1077#1087#1077#1085#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1087#1083#1072#1085#1072', %'
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'ExcavatorsRockRatio'
        end
      end
    end
    object tsCtg: TTabSheet
      Caption = 'III'
      ImageIndex = 2
      object DBChart2: TDBChart
        Left = 0
        Top = 0
        Width = 1118
        Height = 764
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        MarginBottom = 5
        MarginLeft = 5
        MarginRight = 5
        MarginTop = 5
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -20
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          #1057#1091#1084#1084#1072#1088#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1087#1086' '#1043#1058#1050)
        BottomAxis.Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
        BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
        BottomAxis.Title.Font.Color = clBlack
        BottomAxis.Title.Font.Height = -11
        BottomAxis.Title.Font.Name = 'Arial'
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.AxisValuesFormat = '#,##0.#'
        LeftAxis.StartPosition = 10.000000000000000000
        LeftAxis.EndPosition = 95.000000000000000000
        LeftAxis.Title.Caption = #1047#1072#1090#1088#1072#1090#1099', '#1090#1075
        LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
        LeftAxis.Title.Font.Color = clBlack
        LeftAxis.Title.Font.Height = -11
        LeftAxis.Title.Font.Name = 'Arial'
        LeftAxis.Title.Font.Style = [fsBold]
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Series4: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = clRed
          Title = #1069#1082#1089#1087#1083#1091#1090#1072#1094#1080#1086#1085#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'EconomExploatationCtg'
        end
        object Series5: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = clBlue
          Title = #1055#1086#1089#1090#1086#1103#1085#1085#1099#1077' '#1080' '#1085#1077#1091#1095#1090#1077#1085#1085#1099#1077' '#1088#1072#1089#1093#1086#1076#1099
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'EconomExpensesCtg'
        end
        object Series3: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = 8453888
          Title = #1040#1084#1086#1088#1090#1080#1079#1072#1094#1080#1086#1085#1085#1099#1077' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1103
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'EconomAmortizationCtg'
        end
        object LineSeries2: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = clMaroon
          Title = #1057#1091#1084#1084#1072#1088#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1087#1086' '#1043#1058#1050
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'EconomCtg'
        end
      end
    end
    object tsUsingCoef: TTabSheet
      Caption = 'IV'
      ImageIndex = 3
      object DBChart3: TDBChart
        Left = 0
        Top = 0
        Width = 1118
        Height = 764
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        MarginBottom = 5
        MarginLeft = 5
        MarginRight = 5
        MarginTop = 5
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -20
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          #1057#1090#1077#1087#1077#1085#1100' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1075#1086#1088#1085#1086'-'#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1086#1075#1086' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103)
        BottomAxis.Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
        BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
        BottomAxis.Title.Font.Color = clBlack
        BottomAxis.Title.Font.Height = -11
        BottomAxis.Title.Font.Name = 'Arial'
        BottomAxis.Title.Font.Style = [fsBold]
        LeftAxis.StartPosition = 10.000000000000000000
        LeftAxis.EndPosition = 95.000000000000000000
        LeftAxis.Title.Caption = #1057#1090#1077#1087#1077#1085#1100' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103
        LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
        LeftAxis.Title.Font.Color = clBlack
        LeftAxis.Title.Font.Height = -11
        LeftAxis.Title.Font.Name = 'Arial'
        LeftAxis.Title.Font.Style = [fsBold]
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object LineSeries3: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = clRed
          Title = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'AutosAvgTimeUsingCoef'
        end
        object LineSeries4: TLineSeries
          Marks.ArrowLength = 8
          Marks.Style = smsValue
          Marks.Visible = False
          DataSource = quVariants
          SeriesColor = clBlue
          Title = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
          ValueFormat = '#,##0.#'
          XLabelsSource = 'AutosAutosCount0'
          Pointer.HorizSize = 2
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 2
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'ExcavatorsUsingTimeCoef'
        end
      end
    end
    object tsNEE: TTabSheet
      Caption = #1059#1069#1069
      ImageIndex = 4
      object DBChart4: TDBChart
        Left = 0
        Top = 0
        Width = 1118
        Height = 764
        AnimatedZoom = True
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        MarginTop = 5
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -20
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          #1059#1089#1083#1086#1074#1085#1099#1081' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1080#1081' '#1101#1092#1092#1077#1082#1090
          '')
        BottomAxis.StartPosition = 2.000000000000000000
        BottomAxis.EndPosition = 98.000000000000000000
        BottomAxis.Title.Caption = #1042#1072#1088#1080#1072#1085#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
        LeftAxis.ExactDateTime = False
        LeftAxis.StartPosition = 10.000000000000000000
        LeftAxis.EndPosition = 90.000000000000000000
        LeftAxis.Title.Caption = #1059#1069#1069', '#1084#1083#1085'.'#1090#1077#1085#1075#1077
        Legend.Visible = False
        TopAxis.StartPosition = 2.000000000000000000
        TopAxis.EndPosition = 98.000000000000000000
        View3D = False
        Align = alClient
        TabOrder = 0
        object Series6: TLineSeries
          Marks.ArrowLength = 20
          Marks.Style = smsValue
          Marks.Visible = True
          DataSource = quVariants
          SeriesColor = clRed
          XLabelsSource = 'SortIndex'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          XValues.ValueSource = 'SortIndex'
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'NominalEconomicEffectCtg'
        end
      end
    end
  end
  object dsVaraints: TDataSource
    Left = 252
    Top = 107
  end
  object quVariants: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Filter = 'IsPrint=True'
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultVariants'
      'ORDER BY SortIndex')
    Left = 556
    Top = 99
    object quVariantsId_ResultVariant: TAutoIncField
      FieldName = 'Id_ResultVariant'
      ReadOnly = True
    end
    object quVariantsSortIndex: TIntegerField
      DisplayLabel = #8470
      FieldName = 'SortIndex'
    end
    object quVariantsIsPrint: TBooleanField
      DisplayLabel = #1042#1099#1076#1077#1083#1077#1085#1080#1077
      FieldName = 'IsPrint'
    end
    object quVariantsVariant: TWideStringField
      DisplayLabel = #1042#1072#1088#1080#1072#1085#1090
      FieldName = 'Variant'
      Size = 100
    end
    object quVariantsVariantDate: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'VariantDate'
    end
    object quVariantsPeriodTday: TFloatField
      DisplayLabel = #1087#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1087#1077#1088#1080#1086#1076#1072', '#1076#1085#1080
      FieldName = 'PeriodTday'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsPeriodKshift: TFloatField
      DisplayLabel = #1050#1087#1077#1088#1080#1086#1076#1072
      FieldName = 'PeriodKshift'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsShiftTmin: TFloatField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1089#1084#1077#1085#1099', '#1084#1080#1085
      FieldName = 'ShiftTmin'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsShiftTurnoverTmin: TFloatField
      DisplayLabel = #1055#1077#1088#1077#1089#1084#1077#1085#1082#1072', '#1084#1080#1085
      FieldName = 'ShiftTurnoverTmin'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsShiftNaryadTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077', '#1084#1080#1085
      FieldKind = fkCalculated
      FieldName = 'ShiftNaryadTmin'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsShiftNaryadFactTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077' ('#1092#1072#1082#1090'.), '#1084#1080#1085
      FieldName = 'ShiftNaryadFactTmin'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsShiftKweek: TFloatField
      DisplayLabel = 'K'#1089#1084#1077#1085'.'#1087#1086#1082'.'
      FieldName = 'ShiftKweek'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsDollarCtg: TFloatField
      DisplayLabel = #1050#1091#1088#1089' '#1076#1086#1083#1083#1072#1088#1072', '#1090#1075
      FieldName = 'DollarCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutos: TWideStringField
      DisplayLabel = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099
      FieldName = 'Autos'
      Size = 255
    end
    object quVariantsAutosAutosCount0: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' '#1074' '#1088#1072#1073#1086#1095#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080
      FieldName = 'AutosAutosCount0'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsAutosAutosCount1: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' '#1074' '#1085#1077#1088#1072#1073#1086#1095#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080
      FieldName = 'AutosAutosCount1'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsAutosAutosCount: TStringField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      FieldKind = fkCalculated
      FieldName = 'AutosAutosCount'
      Size = 50
      Calculated = True
    end
    object quVariantsAutosTripsCountNulled: TFloatField
      FieldName = 'AutosTripsCountNulled'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsAutosTripsCountLoading: TFloatField
      FieldName = 'AutosTripsCountLoading'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsAutosTripsCountUnLoading: TFloatField
      FieldName = 'AutosTripsCountUnLoading'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsAutosRockVm3: TFloatField
      FieldName = 'AutosRockVm3'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosRockQtn: TFloatField
      FieldName = 'AutosRockQtn'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosSkm: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosSkm'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quVariantsAutosSkmNulled: TFloatField
      FieldName = 'AutosSkmNulled'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosSkmLoading: TFloatField
      FieldName = 'AutosSkmLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosSkmUnLoading: TFloatField
      FieldName = 'AutosSkmUnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosLoadingWAvgSkm: TFloatField
      FieldName = 'AutosLoadingWAvgSkm'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosLoadingAvgSkm: TFloatField
      FieldName = 'AutosLoadingAvgSkm'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWAvgHm: TFloatField
      FieldName = 'AutosWAvgHm'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosShiftAvgSkm: TFloatField
      FieldName = 'AutosShiftAvgSkm'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosShiftAvgSkm_reis: TFloatField
      FieldName = 'AutosShiftAvgSkm_reis'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosAvgVkmhNulled: TFloatField
      FieldName = 'AutosAvgVkmhNulled'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosAvgVkmhLoading: TFloatField
      FieldName = 'AutosAvgVkmhLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosAvgVkmhUnLoading: TFloatField
      FieldName = 'AutosAvgVkmhUnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosAvgTechVkmh: TFloatField
      FieldName = 'AutosAvgTechVkmh'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosGx: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosGx'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quVariantsAutosGxWork: TFloatField
      FieldName = 'AutosGxWork'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosGxWaiting: TFloatField
      FieldName = 'AutosGxWaiting'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosDirGx: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosDirGx'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsAutosGxNulled: TFloatField
      FieldName = 'AutosGxNulled'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosGxLoading: TFloatField
      FieldName = 'AutosGxLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosGxUnLoading: TFloatField
      FieldName = 'AutosGxUnLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosUdGx_gr_tkm: TFloatField
      FieldName = 'AutosUdGx_gr_tkm'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosGxCtg: TFloatField
      FieldName = 'AutosGxCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosTmin: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosTmin'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quVariantsAutosTminMoving: TFloatField
      FieldName = 'AutosTminMoving'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosTminWaiting: TFloatField
      FieldName = 'AutosTminWaiting'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosTminManevr: TFloatField
      FieldName = 'AutosTminManevr'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosTminOnLoading: TFloatField
      FieldName = 'AutosTminOnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosTminOnUnLoading: TFloatField
      FieldName = 'AutosTminOnUnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosDirTmin: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosDirTmin'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quVariantsAutosTminNulled: TFloatField
      FieldName = 'AutosTminNulled'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosTminLoading: TFloatField
      FieldName = 'AutosTminLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosTminUnLoading: TFloatField
      FieldName = 'AutosTminUnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosReysAvgTminNulled: TFloatField
      FieldName = 'AutosReysAvgTminNulled'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosReysAvgTminLoading: TFloatField
      FieldName = 'AutosReysAvgTminLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosReysAvgTminUnLoading: TFloatField
      FieldName = 'AutosReysAvgTminUnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsAutosAvgTimeUsingCoef: TFloatField
      FieldName = 'AutosAvgTimeUsingCoef'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosTyresCount: TFloatField
      FieldName = 'AutosTyresCount'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsAutosTyresSkm: TFloatField
      FieldName = 'AutosTyresSkm'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosUsedTyresCount: TFloatField
      FieldName = 'AutosUsedTyresCount'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosTyresCtg: TFloatField
      FieldName = 'AutosTyresCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWorkCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosWorkCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsAutosWorkSumGxCtg: TFloatField
      FieldName = 'AutosWorkSumGxCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWorkSumTyresCtg: TFloatField
      FieldName = 'AutosWorkSumTyresCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWorkSparesCtg: TFloatField
      FieldName = 'AutosWorkSparesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWorkMaterialsCtg: TFloatField
      FieldName = 'AutosWorkMaterialsCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWorkMaintenancesCtg: TFloatField
      FieldName = 'AutosWorkMaintenancesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWorkSalariesCtg: TFloatField
      FieldName = 'AutosWorkSalariesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWaitingCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosWaitingCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsAutosWaitingSumGxCtg: TFloatField
      FieldName = 'AutosWaitingSumGxCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWaitingSparesCtg: TFloatField
      FieldName = 'AutosWaitingSparesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWaitingMaterialsCtg: TFloatField
      FieldName = 'AutosWaitingMaterialsCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWaitingMaintenancesCtg: TFloatField
      FieldName = 'AutosWaitingMaintenancesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosWaitingSalariesCtg: TFloatField
      FieldName = 'AutosWaitingSalariesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosAmortizationCtg: TFloatField
      FieldName = 'AutosAmortizationCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsAutosCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AutosCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsBlocksBlocksCount: TFloatField
      FieldName = 'BlocksBlocksCount'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksLm: TFloatField
      FieldName = 'BlocksLm'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsBlocksRockVm3: TFloatField
      FieldName = 'BlocksRockVm3'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsBlocksRockQtn: TFloatField
      FieldName = 'BlocksRockQtn'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsBlocksAutosCount: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksAutosCount'
      DisplayFormat = '# ### ### ##0'
      Calculated = True
    end
    object quVariantsBlocksAutosCountNulled: TFloatField
      FieldName = 'BlocksAutosCountNulled'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksAutosCountLoading: TFloatField
      FieldName = 'BlocksAutosCountLoading'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksAutosCountUnLoading: TFloatField
      FieldName = 'BlocksAutosCountUnLoading'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksWaitingsCount: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksWaitingsCount'
      DisplayFormat = '# ### ### ##0'
      Calculated = True
    end
    object quVariantsBlocksWaitingsCountNulled: TFloatField
      FieldName = 'BlocksWaitingsCountNulled'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksWaitingsCountLoading: TFloatField
      FieldName = 'BlocksWaitingsCountLoading'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksWaitingsCountUnLoading: TFloatField
      FieldName = 'BlocksWaitingsCountUnLoading'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsBlocksAvgVkmh: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksAvgVkmh'
      DisplayFormat = '# ### ### ##0.0'
      Calculated = True
    end
    object quVariantsBlocksAvgVkmhNulled: TFloatField
      FieldName = 'BlocksAvgVkmhNulled'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsBlocksAvgVkmhLoading: TFloatField
      FieldName = 'BlocksAvgVkmhLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsBlocksAvgVkmhUnLoading: TFloatField
      FieldName = 'BlocksAvgVkmhUnLoading'
      DisplayFormat = '# ### ### ##0.0'
    end
    object quVariantsBlocksMovingAvgTmin: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksMovingAvgTmin'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsBlocksMovingAvgTminNulled: TFloatField
      FieldName = 'BlocksMovingAvgTminNulled'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksMovingAvgTminLoading: TFloatField
      FieldName = 'BlocksMovingAvgTminLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksMovingAvgTminUnLoading: TFloatField
      FieldName = 'BlocksMovingAvgTminUnLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksWaitingAvgTmin: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksWaitingAvgTmin'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsBlocksWaitingAvgTminNulled: TFloatField
      FieldName = 'BlocksWaitingAvgTminNulled'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksWaitingAvgTminLoading: TFloatField
      FieldName = 'BlocksWaitingAvgTminLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksWaitingAvgTminUnLoading: TFloatField
      FieldName = 'BlocksWaitingAvgTminUnLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksEmploymentCoef: TFloatField
      FieldName = 'BlocksEmploymentCoef'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksGx: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksGx'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsBlocksGxNulled: TFloatField
      FieldName = 'BlocksGxNulled'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksGxLoading: TFloatField
      FieldName = 'BlocksGxLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksGxUnLoading: TFloatField
      FieldName = 'BlocksGxUnLoading'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksUdGx_l_m: TFloatField
      FieldName = 'BlocksUdGx_l_m'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksRepairCtg: TFloatField
      FieldName = 'BlocksRepairCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksAmortizationCtg: TFloatField
      FieldName = 'BlocksAmortizationCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsBlocksCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'BlocksCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsExcavators: TWideStringField
      DisplayLabel = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
      FieldName = 'Excavators'
      Size = 255
    end
    object quVariantsExcavatorsExcavatorsCount0: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074' '#1074' '#1088#1072#1073#1086#1095#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080
      FieldName = 'ExcavatorsExcavatorsCount0'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsExcavatorsExcavatorsCount1: TFloatField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074' '#1074' '#1085#1077#1088#1072#1073#1086#1095#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080
      FieldName = 'ExcavatorsExcavatorsCount1'
      DisplayFormat = '# ### ### ##0'
    end
    object quVariantsExcavatorsExcavatorsCount: TStringField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsExcavatorsCount'
      Size = 50
      Calculated = True
    end
    object quVariantsExcavatorsAutosCount: TFloatField
      FieldName = 'ExcavatorsAutosCount'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsRockVm3: TFloatField
      FieldName = 'ExcavatorsRockVm3'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsRockQtn: TFloatField
      FieldName = 'ExcavatorsRockQtn'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsPlanRockVm3: TFloatField
      FieldName = 'ExcavatorsPlanRockVm3'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsPlanRockQtn: TFloatField
      FieldName = 'ExcavatorsPlanRockQtn'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsRockRatio: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsRockRatio'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsExcavatorsGx: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsGx'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsExcavatorsGxWork: TFloatField
      FieldName = 'ExcavatorsGxWork'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsGxWaiting: TFloatField
      FieldName = 'ExcavatorsGxWaiting'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsTmin: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsTmin'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsExcavatorsTminWork: TFloatField
      FieldName = 'ExcavatorsTminWork'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsTminWaiting: TFloatField
      FieldName = 'ExcavatorsTminWaiting'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsTminManevr: TFloatField
      FieldName = 'ExcavatorsTminManevr'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsUsingPunktCoef: TFloatField
      FieldName = 'ExcavatorsUsingPunktCoef'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsUsingTimeCoef: TFloatField
      FieldName = 'ExcavatorsUsingTimeCoef'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWorkCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsWorkCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsExcavatorsWorkSumGxCtg: TFloatField
      FieldName = 'ExcavatorsWorkSumGxCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWorkMaterialsCtg: TFloatField
      FieldName = 'ExcavatorsWorkMaterialsCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWorkUnAccountedCtg: TFloatField
      FieldName = 'ExcavatorsWorkUnAccountedCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWorkSalariesCtg: TFloatField
      FieldName = 'ExcavatorsWorkSalariesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWaitingCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsWaitingCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsExcavatorsWaitingSumGxCtg: TFloatField
      FieldName = 'ExcavatorsWaitingSumGxCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWaitingMaterialsCtg: TFloatField
      FieldName = 'ExcavatorsWaitingMaterialsCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWaitingUnAccountedCtg: TFloatField
      FieldName = 'ExcavatorsWaitingUnAccountedCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsWaitingSalariesCtg: TFloatField
      FieldName = 'ExcavatorsWaitingSalariesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsAmortizationCtg: TFloatField
      FieldName = 'ExcavatorsAmortizationCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsExcavatorsCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExcavatorsCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomExpensesCtg: TFloatField
      FieldName = 'EconomExpensesCtg'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quVariantsEconomExploatationCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomExploatationCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomAmortizationCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomAmortizationCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomCtg'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomUdExploatationCtg_m3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomUdExploatationCtg_m3'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomUdAmortizationCtg_m3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomUdAmortizationCtg_m3'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomUdExploatationCtg_tn: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomUdExploatationCtg_tn'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomUdAmortizationCtg_tn: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomUdAmortizationCtg_tn'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomUdCtg_m3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomUdCtg_m3'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsEconomUdCtg_tn: TFloatField
      FieldKind = fkCalculated
      FieldName = 'EconomUdCtg_tn'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quVariantsIsBaseVariant: TBooleanField
      FieldName = 'IsBaseVariant'
    end
    object quVariantsProductOutPutPercent: TFloatField
      FieldName = 'ProductOutPutPercent'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsProductPriceCtg: TFloatField
      FieldName = 'ProductPriceCtg'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsMTWorkByScheduleCtg: TFloatField
      FieldName = 'MTWorkByScheduleCtg'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsServiceExpensesCtg: TFloatField
      FieldName = 'ServiceExpensesCtg'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsTruckCostCtg: TFloatField
      FieldName = 'TruckCostCtg'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsBaseVariantExpenesCtg: TFloatField
      FieldName = 'BaseVariantExpenesCtg'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsPlannedRockVolumeCm: TFloatField
      FieldKind = fkCalculated
      FieldName = 'PlannedRockVolumeCm'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsProfit: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ProfitCtg'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsExpenses: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ExpensesCtg'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsCurrOreVm3: TFloatField
      FieldName = 'CurrOreVm3'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsCurrOreQtn: TFloatField
      FieldName = 'CurrOreQtn'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsCurrStrippingQtn: TFloatField
      FieldName = 'CurrStrippingQtn'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsCurrStrippingVm3: TFloatField
      FieldName = 'CurrStrippingVm3'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsVgm: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Vgm'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsSelicTM3: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SelicTM3'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsNomEconomicEffectCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'NominalEconomicEffectCtg'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsBaseVariantCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'NomBaseVariantCtg'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsRelativeEconomicEffectCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'RelativeEconomicEffectCtg'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsVOEconomicEffectCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'VOEconomicEffectCtg'
      DisplayFormat = '# ### ### ##0.000'
      Calculated = True
    end
    object quVariantsPeriodTdayL: TStringField
      FieldKind = fkCalculated
      FieldName = 'PeriodTdayL'
      Size = 80
      Calculated = True
    end
    object quVariantsKs: TFloatField
      FieldName = 'Ks'
      DisplayFormat = '# ### ### ##0.000'
    end
    object quVariantsCAutosTyresCtg: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CAutosTyresCtg'
      Calculated = True
    end
  end
end
