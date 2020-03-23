object fmExcavatorDefaults: TfmExcavatorDefaults
  Left = 608
  Top = 93
  HelpType = htKeyword
  HelpKeyword = 'DeportExcavators'
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
  ClientHeight = 528
  ClientWidth = 482
  Color = clBtnFace
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
  object lbNote: TLabel
    Left = 79
    Top = 20
    Width = 355
    Height = 32
    Caption = 
      #1047#1076#1077#1089#1100' '#1091#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1102#1090#1089#1103' '#1079#1085#1072#1095#1077#1085#1080#1103', '#1082#1086#1090#1086#1088#1099#1077' '#1079#1072#1076#1072#1102#1090#1089#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '#1085#1086 +
      #1074#1086#1081' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
    WordWrap = True
  end
  object Bevel: TBevel
    Left = 20
    Top = 79
    Width = 443
    Height = 6
    Shape = bsTopLine
  end
  object Image: TImage
    Left = 20
    Top = 17
    Width = 39
    Height = 40
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
    Left = 20
    Top = 197
    Width = 117
    Height = 16
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100', '#1090#1099#1089'.'#1090#1085
    FocusControl = edCost
  end
  object lbExcavators: TLabel
    Left = 20
    Top = 108
    Width = 129
    Height = 16
    Caption = '&'#1052#1072#1088#1082#1072' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072
    FocusControl = dblcbExcavators
  end
  object lbFactCycleTime: TLabel
    Left = 20
    Top = 226
    Width = 185
    Height = 16
    Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077' '#1074#1088#1077#1084#1103' '#1094#1080#1082#1083#1072', '#1089
    FocusControl = edFactCycleTime
  end
  object lbAddCostMaterials: TLabel
    Left = 20
    Top = 286
    Width = 151
    Height = 16
    Caption = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
    FocusControl = edAddCostMaterials
  end
  object lbAddCostUnAccounted: TLabel
    Left = 20
    Top = 315
    Width = 139
    Height = 16
    Caption = #1047#1072#1090#1088#1072#1090#1099' '#1085#1077#1091#1095#1090#1077#1085#1085#1099#1077
    FocusControl = edAddCostUnAccounted
  end
  object lbEngineKIM: TLabel
    Left = 20
    Top = 374
    Width = 296
    Height = 16
    Caption = #1050#1086#1101#1092'-'#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1084#1086#1097#1085#1086#1089#1090#1080' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
    FocusControl = edEngineKIM
  end
  object lbEngineKPD: TLabel
    Left = 20
    Top = 404
    Width = 98
    Height = 16
    Caption = #1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103
    FocusControl = edEngineKPD
  end
  object lbEYear: TLabel
    Left = 20
    Top = 138
    Width = 81
    Height = 16
    Caption = #1043#1086#1076' '#1074#1099#1087#1091#1089#1082#1072
    FocusControl = seEYear
  end
  object Bevel1: TBevel
    Left = 20
    Top = 266
    Width = 444
    Height = 6
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 30
    Top = 256
    Width = 328
    Height = 16
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089
  end
  object Bevel2: TBevel
    Left = 20
    Top = 354
    Width = 444
    Height = 7
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 30
    Top = 345
    Width = 343
    Height = 16
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1076#1074#1080#1075#1072#1090#1077#1083#1102
  end
  object lbSENAmortizationRate: TLabel
    Left = 21
    Top = 431
    Width = 189
    Height = 16
    Caption = #1043#1086#1076#1086#1074#1072#1103' '#1085#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
    FocusControl = edEngineKPD
  end
  object pnBtns: TPanel
    Left = 0
    Top = 478
    Width = 482
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btOk: TButton
      Left = 266
      Top = 10
      Width = 92
      Height = 31
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      OnClick = btOkClick
    end
    object btClose: TButton
      Left = 374
      Top = 10
      Width = 92
      Height = 31
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dblcbExcavators: TDBLookupComboBox
    Left = 315
    Top = 108
    Width = 148
    Height = 24
    KeyField = 'Id_Excavator'
    ListField = 'Name'
    ListSource = fmDM.dsExcavators
    TabOrder = 1
  end
  object edCost: TEdit
    Left = 315
    Top = 197
    Width = 148
    Height = 21
    TabOrder = 2
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edFactCycleTime: TEdit
    Left = 315
    Top = 226
    Width = 148
    Height = 21
    TabOrder = 3
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edAddCostMaterials: TEdit
    Left = 315
    Top = 286
    Width = 148
    Height = 21
    TabOrder = 4
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edAddCostUnAccounted: TEdit
    Left = 315
    Top = 315
    Width = 148
    Height = 21
    TabOrder = 5
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edEngineKIM: TEdit
    Left = 315
    Top = 374
    Width = 148
    Height = 21
    TabOrder = 6
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object edEngineKPD: TEdit
    Left = 315
    Top = 404
    Width = 148
    Height = 21
    TabOrder = 7
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
  object seEYear: TSpinEdit
    Left = 315
    Top = 138
    Width = 149
    Height = 26
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object chbWorkState: TCheckBox
    Left = 20
    Top = 167
    Width = 444
    Height = 21
    Alignment = taLeftJustify
    Caption = #1042' '#1088#1072#1073#1086#1095#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080'?'
    TabOrder = 9
  end
  object edSENAmortizationRate: TEdit
    Left = 315
    Top = 434
    Width = 148
    Height = 21
    TabOrder = 10
    Text = '0'
    OnKeyPress = edCostKeyPress
  end
end
