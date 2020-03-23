object fmResultAutoSpeeds: TfmResultAutoSpeeds
  Left = 634
  Top = 193
  Width = 832
  Height = 731
  HelpType = htKeyword
  HelpKeyword = 'ResultAutos'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1082#1086#1088#1086#1089#1090#1100', '#1074#1088#1077#1084#1103' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1072#1074#1090#1086' '#1087#1086' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1077
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
  object Splitter1: TSplitter
    Left = 0
    Top = 457
    Width = 814
    Height = 16
    Cursor = crVSplit
    Align = alTop
  end
  object chrVkmh: TChart
    Left = 0
    Top = 0
    Width = 814
    Height = 457
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1057#1082#1086#1088#1086#1089#1090#1100' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072)
    BottomAxis.Title.Caption = 'T, '#1084#1080#1085
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -11
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    LeftAxis.StartPosition = 10.000000000000000000
    LeftAxis.Title.Caption = 'V, '#1082#1084'/'#1095
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsBold]
    Legend.Visible = False
    View3D = False
    Align = alTop
    TabOrder = 0
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object chrWkH: TChart
    Left = 0
    Top = 473
    Width = 814
    Height = 164
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      #1055#1086#1083#1085#1086#1077' '#1089#1086#1087#1088#1086#1090#1080#1074#1083#1077#1085#1080#1077' '#1076#1074#1080#1078#1077#1085#1080#1102)
    BottomAxis.Title.Caption = 'T, '#1084#1080#1085
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -11
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    LeftAxis.StartPosition = 10.000000000000000000
    LeftAxis.Title.Caption = 'W, '#1082'H'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsBold]
    Legend.Visible = False
    View3D = False
    Align = alClient
    TabOrder = 1
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object pnBtns: TPanel
    Left = 0
    Top = 637
    Width = 814
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      814
      49)
    object btPrint: TButton
      Left = 20
      Top = 10
      Width = 92
      Height = 31
      Caption = #1055#1077#1095#1072#1090#1100'...'
      TabOrder = 0
      OnClick = btPrintClick
    end
    object btClose: TButton
      Left = 855
      Top = 10
      Width = 92
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
end
