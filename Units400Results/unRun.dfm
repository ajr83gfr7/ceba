object fmRun: TfmRun
  Left = 696
  Top = 512
  HelpType = htKeyword
  HelpKeyword = 'Start'
  ActiveControl = dbcbShiftDuration
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 361
  ClientWidth = 601
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    601
    361)
  PixelsPerInch = 120
  TextHeight = 16
  object lbShiftDuration: TLabel
    Left = 20
    Top = 20
    Width = 225
    Height = 16
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' &'#1089#1084#1077#1085#1099', '#1084#1080#1085
    FocusControl = dbcbShiftDuration
  end
  object lbPeriodDuration: TLabel
    Left = 20
    Top = 49
    Width = 437
    Height = 16
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1089#1089#1084#1072#1090#1088#1080#1074#1072#1077#1084#1086#1075#1086' &'#1087#1077#1088#1080#1086#1076#1072' '#1074#1088#1077#1084#1077#1085#1080', '#1076#1085#1080
    FocusControl = dbcbPeriodDuration
  end
  object lbAnimationTimeScale: TLabel
    Left = 20
    Top = 108
    Width = 217
    Height = 16
    Caption = '&'#1052#1072#1089#1096#1090#1072#1073' '#1074#1088#1077#1084#1077#1085#1080' '#1072#1085#1080#1084#1072#1094#1080#1080', 1'#1093
    FocusControl = dbedAnimationTimeScale
  end
  object Bevel: TBevel
    Left = 0
    Top = 308
    Width = 601
    Height = 2
    Align = alBottom
    Shape = bsTopLine
  end
  object pnBtns: TPanel
    Left = 0
    Top = 310
    Width = 601
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      601
      51)
    object btOk: TButton
      Left = 384
      Top = 10
      Width = 92
      Height = 31
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      OnClick = btOkClick
    end
    object btCancel: TButton
      Left = 492
      Top = 10
      Width = 93
      Height = 31
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dbcbPeriodDuration: TDBEdit
    Left = 433
    Top = 49
    Width = 148
    Height = 24
    Anchors = [akTop, akRight]
    DataField = 'ParamsPeriodDuration'
    DataSource = fmDM.dsOpenpits
    TabOrder = 1
  end
  object dbcbShiftDuration: TDBComboBox
    Left = 433
    Top = 20
    Width = 148
    Height = 24
    Style = csDropDownList
    Anchors = [akTop, akRight]
    DataField = 'ParamsShiftDuration'
    DataSource = fmDM.dsOpenpits
    ItemHeight = 16
    Items.Strings = (
      '60'
      '120'
      '180'
      '240'
      '300'
      '360'
      '420'
      '480'
      '540'
      '600'
      '660'
      '720')
    TabOrder = 0
  end
  object dbcbIsAccumulateData: TDBCheckBox
    Left = 20
    Top = 79
    Width = 561
    Height = 21
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Caption = '&'#1053#1072#1082#1072#1087#1083#1080#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
    DataField = 'ParamsIsAccumulateData'
    DataSource = fmDM.dsOpenpits
    TabOrder = 2
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbedAnimationTimeScale: TDBEdit
    Left = 433
    Top = 108
    Width = 149
    Height = 24
    Anchors = [akTop, akRight]
    DataField = 'ParamsAnimationTimeScale'
    DataSource = fmDM.dsOpenpits
    TabOrder = 3
  end
end
