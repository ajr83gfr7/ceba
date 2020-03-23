object fmResultBlocksPowerConsuming: TfmResultBlocksPowerConsuming
  Left = 203
  Top = 157
  Width = 868
  Height = 616
  HelpType = htKeyword
  HelpKeyword = 'ResultBlocks'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1069#1085#1077#1088#1075#1086#1077#1084#1082#1086#1089#1090#1100' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1086#1074' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
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
    Top = 522
    Width = 850
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      850
      49)
    object btClose: TButton
      Left = 888
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
    Width = 850
    Height = 522
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      #1043#1088#1091#1079#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      #1055#1086#1088#1086#1078#1085#1103#1082#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      #1054#1073#1097#1077#1077)
    TabIndex = 0
    OnChange = TabControlChange
    object dbchGxSpecific: TDBChart
      Left = 4
      Top = 27
      Width = 842
      Height = 491
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
        #1069#1085#1077#1088#1075#1086#1077#1084#1082#1086#1089#1090#1100' '#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1086#1074' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
        '('#1043#1088#1091#1079#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077')')
      LeftAxis.Title.Caption = #1059#1076#1077#1083#1100#1085#1099#1081' '#1088#1072#1089#1093#1086#1076' '#1090#1086#1087#1083#1080#1074#1072', '#1083'/'#1084
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
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        XValues.ValueSource = 'Id_ResultShiftBlock'
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
      end
      object Series2: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
        SeriesColor = clRed
        XValues.DateTime = False
        XValues.Name = 'X'
        XValues.Multiplier = 1.000000000000000000
        XValues.Order = loAscending
        XValues.ValueSource = 'Id_ResultShiftBlock'
        YValues.DateTime = False
        YValues.Name = 'Bar'
        YValues.Multiplier = 1.000000000000000000
        YValues.Order = loNone
        YValues.ValueSource = 'Value'
      end
      object Series3: TBarSeries
        Marks.ArrowLength = 20
        Marks.Visible = True
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
        YValues.ValueSource = 'GxSpecific0'
      end
    end
  end
  object dsSpecE: TDataSource
    DataSet = quSpecE_L
    Left = 284
    Top = 83
  end
  object quSpecE_L: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (RecordNo=303)and(Kind=1)'
      'ORDER BY Id_ResultShiftBlock')
    Left = 180
    Top = 83
    object quSpecE_LLsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quSpecE_LValue: TFloatField
      FieldName = 'Value'
    end
  end
  object quSpecE_U: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftBlockReports'
      'WHERE (RecordNo=304)and(Kind=1)'
      'ORDER BY Id_ResultShiftBlock')
    Left = 236
    Top = 179
    object quSpecE_ULsm: TIntegerField
      FieldName = 'Lsm'
    end
    object quSpecE_UValue: TFloatField
      FieldName = 'Value'
    end
  end
end
