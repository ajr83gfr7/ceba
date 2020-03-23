object fmResultBlocksFunctioning: TfmResultBlocksFunctioning
  Left = 642
  Top = 271
  Width = 1080
  Height = 707
  HelpType = htKeyword
  HelpKeyword = 'ResultBlocks'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1047#1072#1075#1088#1091#1078#1077#1085#1085#1086#1089#1090#1100' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1086#1074' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object pnBtns: TPanel
    Left = 0
    Top = 612
    Width = 1062
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1062
      50)
    object btClose: TButton
      Left = 1122
      Top = 10
      Width = 93
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
    object btPrint: TButton
      Left = 20
      Top = 10
      Width = 92
      Height = 31
      Caption = #1055#1077#1095#1072#1090#1100'...'
      TabOrder = 1
      OnClick = btPrintClick
    end
  end
  object TabControl: TTabControl
    Left = 0
    Top = 0
    Width = 1062
    Height = 612
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      #1043#1088#1091#1079#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      #1055#1086#1088#1086#1078#1085#1103#1082#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      #1054#1073#1097#1077#1077)
    TabIndex = 0
    OnChange = TabControlChange
    object dbchTSpecific: TDBChart
      Left = 4
      Top = 27
      Width = 1054
      Height = 581
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      Foot.Font.Charset = DEFAULT_CHARSET
      Foot.Font.Color = clBlack
      Foot.Font.Height = -11
      Foot.Font.Name = 'Arial'
      Foot.Font.Style = [fsBold]
      Foot.Text.Strings = (
        #1041#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1080)
      Title.Text.Strings = (
        #1047#1072#1075#1088#1091#1078#1077#1085#1085#1086#1089#1090#1100' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1086#1074' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
        '('#1043#1088#1091#1079#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077')')
      LeftAxis.Title.Caption = #1059#1076#1077#1083#1100#1085#1099#1081' '#1079#1072#1085#1103#1090#1086#1089#1090#1100', '#1084#1080#1085'/'#1084
      LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
      LeftAxis.Title.Font.Color = clBlack
      LeftAxis.Title.Font.Height = -11
      LeftAxis.Title.Font.Name = 'Arial'
      LeftAxis.Title.Font.Style = [fsBold]
      Legend.Visible = False
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Series1: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
        DataSource = fmDM.quResultBlocksDetail
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        XValues.ValueSource = 'No'
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
        YValues.ValueSource = 'TSpecificLoading0'
      end
      object Series2: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
        DataSource = fmDM.quResultBlocksDetail
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        XValues.ValueSource = 'No'
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
        YValues.ValueSource = 'TSpecificUnLoading0'
      end
      object Series3: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
        DataSource = fmDM.quResultBlocksDetail
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        XValues.ValueSource = 'No'
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
        YValues.ValueSource = 'TSpecific0'
      end
    end
  end
  object quSpecO_LM: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (RecordNo=203)and(Kind=1)'
      'ORDER BY Id_ResultShiftBlock')
    Left = 180
    Top = 91
    object quSpecO_LMLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quSpecO_LMValue: TFloatField
      FieldName = 'Value'
    end
  end
  object quSpecO_UM: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (RecordNo=204)and(Kind=1)'
      'ORDER BY Id_ResultShiftBlock')
    Left = 252
    Top = 91
    object quSpecO_UMLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quSpecO_UMValue: TFloatField
      FieldName = 'Value'
    end
  end
  object quSpecO_LS: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (RecordNo=207)and(Kind=1)'
      'ORDER BY Id_ResultShiftBlock')
    Left = 196
    Top = 139
    object quSpecO_LSLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quSpecO_LSValue: TFloatField
      FieldName = 'Value'
    end
  end
  object quSpecO_US: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (RecordNo=208)and(Kind=1)'
      'ORDER BY Id_ResultShiftBlock')
    Left = 268
    Top = 139
    object quSpecO_USLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quSpecO_USValue: TFloatField
      FieldName = 'Value'
    end
  end
end
