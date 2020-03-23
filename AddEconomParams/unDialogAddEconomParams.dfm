object fmDialogAddEconomParams: TfmDialogAddEconomParams
  Left = 239
  Top = 103
  BorderStyle = bsDialog
  Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 373
  ClientWidth = 592
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnGrid: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 240
    Align = alLeft
    TabOrder = 0
    object lbVariants: TLabel
      Left = 1
      Top = 1
      Width = 290
      Height = 16
      Align = alTop
      Caption = #1042#1072#1088#1080#1072#1085#1090#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dbgAddEconomParams: TDBGrid
      Left = 1
      Top = 17
      Width = 290
      Height = 222
      Align = alClient
      DataSource = fmResultAddEconomParams.dsResultAddEconomParams
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Name'
          Width = 271
          Visible = True
        end>
    end
  end
  object pnSelect: TPanel
    Left = 292
    Top = 0
    Width = 300
    Height = 240
    Align = alRight
    TabOrder = 1
    object ledName: TLabeledEdit
      Left = 24
      Top = 24
      Width = 216
      Height = 21
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Enabled = False
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 592
    Height = 133
    Align = alBottom
    TabOrder = 2
    object rgSelect: TRadioGroup
      Left = 16
      Top = 16
      Width = 560
      Height = 64
      Caption = #1057#1087#1086#1089#1086#1073' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1072#1088#1080#1072#1085#1090#1086#1074
      ItemIndex = 0
      Items.Strings = (
        #1079#1072#1084#1077#1085#1080#1090#1100' '#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1081' '#1074#1072#1088#1080#1072#1085#1090
        #1085#1086#1074#1099#1081' '#1074#1072#1088#1080#1072#1085#1090)
      TabOrder = 0
      OnClick = rgSelectClick
    end
    object btOk: TButton
      Left = 416
      Top = 96
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object btCancel: TButton
      Left = 504
      Top = 96
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 2
    end
  end
end
