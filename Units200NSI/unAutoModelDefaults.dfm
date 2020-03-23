object fmAutoModelDefaults: TfmAutoModelDefaults
  Left = 104
  Top = 27
  HelpType = htKeyword
  HelpKeyword = 'Autos'
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
  ClientHeight = 453
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
  object lbBodySpace: TLabel
    Left = 16
    Top = 72
    Width = 110
    Height = 13
    Caption = #1054'&'#1073#1098#1077#1084' '#1082#1091#1079#1086#1074#1072', '#1082#1091#1073'.'#1084'.'
    FocusControl = edBodySpace
  end
  object lbTonnage: TLabel
    Left = 16
    Top = 96
    Width = 111
    Height = 13
    Caption = #1043#1088#1091#1079#1086#1087#1086#1076'&'#1098#1077#1084#1085#1086#1089#1090#1100', '#1090'.'
    FocusControl = edTonnage
  end
  object lbP: TLabel
    Left = 16
    Top = 120
    Width = 44
    Height = 13
    Caption = '&'#1052#1072#1089#1089#1072', '#1090
    FocusControl = edP
  end
  object lbEngines: TLabel
    Left = 16
    Top = 192
    Width = 55
    Height = 13
    Caption = '&'#1044#1074#1080#1075#1072#1090#1077#1083#1100
    FocusControl = dblcbEngines
  end
  object lbTransmissionKind: TLabel
    Left = 16
    Top = 216
    Width = 89
    Height = 13
    Caption = #1042#1080#1076' '#1090'&'#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
    FocusControl = cbTransmissionKind
  end
  object lbTransmissionKPD: TLabel
    Left = 16
    Top = 240
    Width = 94
    Height = 13
    Caption = '&'#1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
    FocusControl = edTransmissionKPD
  end
  object lbTr: TLabel
    Left = 16
    Top = 264
    Width = 112
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1088#1072'&'#1079#1075#1088#1091#1079#1082#1080', '#1089#1077#1082
    FocusControl = edTr
  end
  object lbRmin: TLabel
    Left = 16
    Top = 288
    Width = 178
    Height = 13
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1088#1072#1076#1080#1091#1089' &'#1087#1086#1074#1086#1088#1086#1090#1072', '#1084'.'
    FocusControl = edRmin
  end
  object lbTyresCount: TLabel
    Left = 16
    Top = 312
    Width = 82
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' &'#1096#1080#1085
    FocusControl = edTyresCount
  end
  object lbLength: TLabel
    Left = 16
    Top = 336
    Width = 50
    Height = 13
    Caption = #1044#1083'&'#1080#1085#1072', '#1084'.'
    FocusControl = edLength
  end
  object lbWidth: TLabel
    Left = 16
    Top = 360
    Width = 56
    Height = 13
    Caption = '&'#1064#1080#1088#1080#1085#1072', '#1084'.'
    FocusControl = edWidth
  end
  object lbHeight: TLabel
    Left = 16
    Top = 384
    Width = 55
    Height = 13
    Caption = '&'#1042#1099#1089#1086#1090#1072', '#1084'.'
    FocusControl = edHeight
  end
  object lbF: TLabel
    Left = 16
    Top = 144
    Width = 173
    Height = 13
    Caption = '&'#1055#1083#1086#1097#1072#1076#1100' '#1083#1086#1073#1086#1074#1086#1075#1086' '#1089#1077#1095#1077#1085#1080#1103', '#1082#1074'.'#1084'.'
    FocusControl = edF
  end
  object lbRo: TLabel
    Left = 16
    Top = 168
    Width = 126
    Height = 13
    Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' &'#1086#1073#1090#1077#1082#1072#1085#1080#1103
    FocusControl = edRo
  end
  object pnBtns: TPanel
    Left = 0
    Top = 412
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
  object dblcbEngines: TDBLookupComboBox
    Left = 256
    Top = 192
    Width = 120
    Height = 21
    KeyField = 'Id_Engine'
    ListField = 'Name'
    ListSource = fmDM.dsAutoEngines
    TabOrder = 1
  end
  object edBodySpace: TEdit
    Left = 256
    Top = 72
    Width = 120
    Height = 21
    TabOrder = 2
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edTonnage: TEdit
    Left = 256
    Top = 96
    Width = 120
    Height = 21
    TabOrder = 3
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edP: TEdit
    Left = 256
    Top = 120
    Width = 120
    Height = 21
    TabOrder = 4
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edTransmissionKPD: TEdit
    Left = 256
    Top = 240
    Width = 120
    Height = 21
    TabOrder = 7
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edTr: TEdit
    Left = 256
    Top = 264
    Width = 120
    Height = 21
    TabOrder = 8
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edRmin: TEdit
    Left = 256
    Top = 288
    Width = 120
    Height = 21
    TabOrder = 9
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edTyresCount: TEdit
    Left = 256
    Top = 312
    Width = 120
    Height = 21
    TabOrder = 10
    Text = '0'
    OnKeyPress = edTyresCountKeyPress
  end
  object edLength: TEdit
    Left = 256
    Top = 336
    Width = 120
    Height = 21
    TabOrder = 11
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edWidth: TEdit
    Left = 256
    Top = 360
    Width = 120
    Height = 21
    TabOrder = 12
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edHeight: TEdit
    Left = 256
    Top = 384
    Width = 120
    Height = 21
    TabOrder = 13
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object cbTransmissionKind: TComboBox
    Left = 256
    Top = 216
    Width = 120
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 14
    Items.Strings = (
      #1043#1052
      #1069#1052)
  end
  object edF: TEdit
    Left = 256
    Top = 144
    Width = 120
    Height = 21
    TabOrder = 5
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
  object edRo: TEdit
    Left = 256
    Top = 168
    Width = 120
    Height = 21
    TabOrder = 6
    Text = '0'
    OnKeyPress = edBodySpaceKeyPress
  end
end
