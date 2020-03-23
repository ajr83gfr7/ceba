object fmAutoDefaults: TfmAutoDefaults
  Left = 572
  Top = 204
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
  object lbCost: TLabel
    Left = 16
    Top = 160
    Width = 94
    Height = 13
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100', '#1090#1099#1089'.'#1090#1085
    FocusControl = edCost
  end
  object lbAutos: TLabel
    Left = 16
    Top = 88
    Width = 115
    Height = 13
    Caption = '&'#1052#1072#1088#1082#1072' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
    FocusControl = dblcbAutos
  end
  object lbFactTonnage: TLabel
    Left = 16
    Top = 184
    Width = 179
    Height = 13
    Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1075#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100', '#1090
    FocusControl = edFactTonnage
  end
  object lbAmortizationRate: TLabel
    Left = 16
    Top = 208
    Width = 167
    Height = 13
    Caption = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080' '#1085#1072' 1 '#1090#1099#1089'.'#1082#1084
    FocusControl = edAmortizationRate
  end
  object lbTransmissionKPD: TLabel
    Left = 16
    Top = 232
    Width = 94
    Height = 13
    Caption = #1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
    FocusControl = edTransmissionKPD
  end
  object lbEngineKPD: TLabel
    Left = 16
    Top = 256
    Width = 79
    Height = 13
    Caption = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
    FocusControl = edEngineKPD
  end
  object lbTyreCost: TLabel
    Left = 16
    Top = 280
    Width = 134
    Height = 13
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' 1 '#1096#1080#1085#1099', '#1090#1099#1089'.'#1090#1085
    FocusControl = edTyreCost
  end
  object lbAYear: TLabel
    Left = 16
    Top = 112
    Width = 64
    Height = 13
    Caption = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072
    FocusControl = seAYear
  end
  object lbTyresRaceRate: TLabel
    Left = 16
    Top = 304
    Width = 146
    Height = 13
    Caption = #1053#1086#1088#1084#1072' '#1087#1088#1086#1073#1077#1075#1072' '#1096#1080#1085', '#1090#1099#1089'.'#1082#1084'.'
    FocusControl = edTyresRaceRate
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
  object dblcbAutos: TDBLookupComboBox
    Left = 256
    Top = 88
    Width = 120
    Height = 21
    KeyField = 'Id_Auto'
    ListField = 'Name'
    ListSource = fmDM.dsAutos
    TabOrder = 1
  end
  object edCost: TEdit
    Left = 256
    Top = 160
    Width = 120
    Height = 21
    TabOrder = 2
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edFactTonnage: TEdit
    Left = 256
    Top = 184
    Width = 120
    Height = 21
    TabOrder = 3
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edAmortizationRate: TEdit
    Left = 256
    Top = 208
    Width = 120
    Height = 21
    TabOrder = 4
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edTransmissionKPD: TEdit
    Left = 256
    Top = 232
    Width = 120
    Height = 21
    TabOrder = 5
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edEngineKPD: TEdit
    Left = 256
    Top = 256
    Width = 120
    Height = 21
    TabOrder = 6
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edTyreCost: TEdit
    Left = 256
    Top = 280
    Width = 120
    Height = 21
    TabOrder = 7
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object seAYear: TSpinEdit
    Left = 256
    Top = 112
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object chbWorkState: TCheckBox
    Left = 16
    Top = 136
    Width = 361
    Height = 17
    Alignment = taLeftJustify
    Caption = #1042' '#1088#1072#1073#1086#1095#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080'?'
    TabOrder = 9
  end
  object edTyresRaceRate: TEdit
    Left = 256
    Top = 304
    Width = 120
    Height = 21
    TabOrder = 10
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
end
