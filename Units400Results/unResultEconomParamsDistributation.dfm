object fmResultEconomParamsDistributation: TfmResultEconomParamsDistributation
  Left = 286
  Top = 178
  Width = 600
  Height = 400
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1079#1072#1090#1088#1072#1090' '#1087#1086' '#1069#1040#1050' '#1079#1072' '#1087#1077#1088#1080#1086#1076
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnBtns: TPanel
    Left = 0
    Top = 323
    Width = 584
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      584
      41)
    object btCancel: TButton
      Left = 504
      Top = 8
      Width = 72
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 0
    end
    object btPrint: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100'...'
      TabOrder = 1
      OnClick = btPrintClick
    end
  end
  object TabControl: TTabControl
    Left = 0
    Top = 0
    Width = 584
    Height = 323
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      #1069#1082#1089#1087#1083#1091#1090#1072#1094#1080#1086#1085#1085#1099#1077
      #1040#1084#1086#1088#1090#1080#1079#1072#1094#1080#1086#1085#1085#1099#1077
      #1057#1091#1084#1084#1072#1088#1085#1099#1077)
    TabIndex = 0
    OnChange = TabControlChange
    object Chart: TChart
      Left = 4
      Top = 24
      Width = 576
      Height = 295
      BackWall.Brush.Color = clWhite
      BackWall.Color = clSilver
      BottomWall.Brush.Color = clWhite
      LeftWall.Brush.Color = clWhite
      MarginBottom = 10
      MarginLeft = 10
      MarginRight = 10
      MarginTop = 10
      Title.Font.Charset = DEFAULT_CHARSET
      Title.Font.Color = clBlue
      Title.Font.Height = -11
      Title.Font.Name = 'Arial'
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1101#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1086#1085#1085#1099#1093' '#1079#1072#1090#1088#1072#1090)
      BackColor = clSilver
      BottomAxis.Visible = False
      LeftAxis.Visible = False
      RightAxis.Visible = False
      TopAxis.Visible = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 0
      object Series1: TPieSeries
        Marks.ArrowLength = 8
        Marks.Style = smsPercent
        Marks.Visible = True
        SeriesColor = clRed
        ValueFormat = '#,##0.0#'
        OtherSlice.Text = 'Other'
        PieValues.DateTime = False
        PieValues.Name = 'Pie'
        PieValues.Multiplier = 1.000000000000000000
        PieValues.Order = loNone
      end
      object Series2: TPieSeries
        Active = False
        Marks.ArrowLength = 8
        Marks.Style = smsPercent
        Marks.Visible = True
        SeriesColor = clRed
        ValueFormat = '#,##0.0#'
        OtherSlice.Text = 'Other'
        PieValues.DateTime = False
        PieValues.Name = 'Pie'
        PieValues.Multiplier = 1.000000000000000000
        PieValues.Order = loNone
      end
      object Series3: TPieSeries
        Active = False
        Marks.ArrowLength = 8
        Marks.Style = smsPercent
        Marks.Visible = True
        SeriesColor = clRed
        ValueFormat = '#,##0.0#'
        OtherSlice.Text = 'Other'
        PieValues.DateTime = False
        PieValues.Name = 'Pie'
        PieValues.Multiplier = 1.000000000000000000
        PieValues.Order = loNone
      end
    end
  end
end
