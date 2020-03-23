object fmUnLoadingPunktDefaults: TfmUnLoadingPunktDefaults
  Left = 572
  Top = 204
  HelpType = htKeyword
  HelpKeyword = 'UnLoadingPunkts'
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
  ClientHeight = 429
  ClientWidth = 392
  Color = clBtnFace
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
  object lbNote: TLabel
    Left = 64
    Top = 16
    Width = 292
    Height = 26
    Caption = 
      #1047#1076#1077#1089#1100' '#1091#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1102#1090#1089#1103' '#1079#1085#1072#1095#1077#1085#1080#1103', '#1082#1086#1090#1086#1088#1099#1077' '#1079#1072#1076#1072#1102#1090#1089#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '#1085#1086 +
      #1074#1086#1081' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
    WordWrap = True
  end
  object Bevel: TBevel
    Left = 16
    Top = 64
    Width = 360
    Height = 5
    Shape = bsTopLine
  end
  object Image: TImage
    Left = 16
    Top = 14
    Width = 32
    Height = 32
    Picture.Data = {
      07544269746D6170F6000000424DF60000000000000076000000280000001000
      000010000000010004000000000080000000120B0000120B0000100000000000
      0000000000000000800000800000008080008000000080008000808000007F7F
      7F00BFBFBF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00DDDDDDD0DDDDDDDDDDDDDD000DDDDDDDDDDDDD080DDDDDDDDDBDDB000BDD
      BDDDDDDBBB0B0BBBDDDDDDDBBB0F0BBBDDDDDDBBB0F7F0BBBDDDDDBB0FB7BF0B
      BDDDBBBB0BF7FB0BBBBDDDBB0FBFBF0BBDDDDDBBB0FBF0BBBDDDDDDBBB000BBB
      DDDDDDDBBBBBBBBBDDDDDDBDDBBBBBDDBDDDDDDDDDDBDDDDDDDDDDDDDDDBDDDD
      DDDD}
    Stretch = True
    Transparent = True
  end
  object lbInitialV1000m3: TLabel
    Left = 16
    Top = 128
    Width = 216
    Height = 13
    Caption = #1054#1073#1098#1077#1084' '#1087#1086#1088#1086#1076#1099' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072', '#1090#1099#1089'.'#1084'3'
    FocusControl = edInitialV1000m3
  end
  object lbInitialContent: TLabel
    Left = 16
    Top = 104
    Width = 167
    Height = 13
    Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1089#1084#1077#1085#1099', %'
    FocusControl = edInitialContent
  end
  object lbRequiredContent: TLabel
    Left = 16
    Top = 80
    Width = 135
    Height = 13
    Caption = #1058#1088#1077#1073#1091#1077#1084#1086#1077' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
    FocusControl = edRequiredContent
  end
  object pnBtns: TPanel
    Left = 0
    Top = 388
    Width = 392
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btOk: TButton
      Left = 216
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      OnClick = btOkClick
    end
    object btClose: TButton
      Left = 304
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edRequiredContent: TEdit
    Left = 256
    Top = 80
    Width = 120
    Height = 21
    TabOrder = 1
    Text = '0'
    OnKeyPress = edRequiredContentKeyPress
  end
  object edInitialContent: TEdit
    Left = 256
    Top = 104
    Width = 120
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edInitialV1000m3: TEdit
    Left = 256
    Top = 128
    Width = 120
    Height = 21
    TabOrder = 3
    Text = '0'
  end
end
