object fmProductivity: TfmProductivity
  Left = 267
  Top = 24
  Width = 600
  Height = 480
  HelpType = htKeyword
  HelpKeyword = 'LoadinPunkts'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 
    #1055#1083#1072#1085#1086#1074#1072#1103' '#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1085#1072' '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1087#1086' '#1087#1091#1085#1082#1090#1072#1084' '#1087#1086#1075 +
    #1088#1091#1079#1082#1080
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 341
    Width = 584
    Height = 5
    Align = alBottom
    Shape = bsTopLine
  end
  object pnBtns: TPanel
    Left = 0
    Top = 402
    Width = 584
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      584
      40)
    object btClose: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
    object btExcel: TButton
      Left = 16
      Top = 8
      Width = 72
      Height = 25
      Caption = #1074' Excel...'
      TabOrder = 1
      OnClick = pmiExcelClick
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 341
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 1
    object pbLoadingPunktRocks: TPaintBox
      Left = 0
      Top = 192
      Width = 584
      Height = 55
      Align = alTop
      OnPaint = pbLoadingPunktRocksPaint
    end
    object lbLoadingPunkts: TLabel
      Left = 0
      Top = 0
      Width = 584
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = #1055#1091#1085#1082#1090#1099' &'#1087#1086#1075#1088#1091#1079#1082#1080
    end
    object dbgLoadingPunktRocks: TDBGrid
      Left = 0
      Top = 247
      Width = 584
      Height = 108
      Align = alTop
      Ctl3D = True
      DataSource = fmDM.dsLoadingPunktRocks
      DefaultDrawing = False
      ParentCtl3D = False
      PopupMenu = pmLoadingPunktsRocks
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbgLoadingPunktRocksDrawColumnCell
      OnKeyPress = dbgLoadingPunktRocksKeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'SortIndex'
          ReadOnly = True
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Rock'
          ReadOnly = True
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DensityInBlock'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ShatteringCoef'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Content'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PlannedV1000m3'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PlannedQ1000tn'
          ReadOnly = True
          Width = 70
          Visible = True
        end>
    end
    object dbgLoadingPunkts: TDBGrid
      Left = 0
      Top = 13
      Width = 584
      Height = 179
      Align = alTop
      Ctl3D = True
      DataSource = fmDM.dsLoadingPunkts
      DefaultDrawing = False
      Options = [dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
      ParentCtl3D = False
      PopupMenu = pmLoadingPunkts
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbgLoadingPunktsDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'SortIndex'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DeportExcavator'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Grnt'
          Width = 100
          Visible = True
        end>
    end
  end
  object pnProductivity: TPanel
    Left = 0
    Top = 346
    Width = 584
    Height = 56
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 2
    object lbProductivityMineralWealth: TLabel
      Left = 8
      Top = 8
      Width = 24
      Height = 13
      Caption = #1056#1091#1076#1072
    end
    object lbProductivityStripping: TLabel
      Left = 112
      Top = 8
      Width = 47
      Height = 13
      Caption = #1042#1089#1082#1088#1099#1096#1072
    end
    object lbProductivityRock: TLabel
      Left = 216
      Top = 8
      Width = 71
      Height = 13
      Caption = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072
    end
    object lbProductivityStrippingCoef: TLabel
      Left = 416
      Top = 8
      Width = 119
      Height = 13
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1074#1089#1082#1088#1099#1096#1080
    end
    object sttProductivityMineralWealth: TStaticText
      Left = 8
      Top = 24
      Width = 96
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkTile
      Caption = '0,000'
      TabOrder = 0
    end
    object cbProductivityUnit: TComboBox
      Left = 320
      Top = 24
      Width = 64
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 1
      Text = #1090#1099#1089'.'#1084'3'
      OnChange = cbProductivityUnitChange
      Items.Strings = (
        #1090#1099#1089'.'#1090
        #1090#1099#1089'.'#1084'3')
    end
    object sttProductivityStripping: TStaticText
      Left = 112
      Top = 24
      Width = 96
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkTile
      Caption = '0,000'
      TabOrder = 2
    end
    object sttProductivityRock: TStaticText
      Left = 216
      Top = 24
      Width = 96
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkTile
      Caption = '0,000'
      TabOrder = 3
    end
    object edProductivityStrippingCoef: TEdit
      Left = 416
      Top = 24
      Width = 96
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 4
      Text = '0,000'
    end
    object cbProductivityStrippingCoefUnit: TComboBox
      Left = 520
      Top = 24
      Width = 48
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 5
      Text = #1090'/'#1090
      OnChange = cbProductivityStrippingCoefUnitChange
      Items.Strings = (
        #1090'/'#1090
        #1084'3/'#1090)
    end
  end
  object pmLoadingPunktsRocks: TPopupMenu
    OnPopup = pmLoadingPunktsRocksPopup
    Left = 368
    Top = 64
    object pmiAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiAddClick
    end
    object pmiEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 16453
      OnClick = pmiEditClick
    end
    object pmiDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
      OnClick = pmiDeleteClick
    end
    object pmiDeleteAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      OnClick = pmiDeleteAllClick
    end
    object pmiSep1: TMenuItem
      Caption = '-'
    end
    object pmiUp: TMenuItem
      Caption = #1042#1074#1077#1088#1093
      ShortCut = 8277
      OnClick = pmiUpClick
    end
    object pmiDown: TMenuItem
      Caption = #1042#1085#1080#1079
      ShortCut = 8260
      OnClick = pmiDownClick
    end
    object pmiSep4: TMenuItem
      Caption = '-'
    end
    object pmiDefault: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' &'#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnClick = pmiDefaultClick
    end
    object pmiSep2: TMenuItem
      Caption = '-'
    end
    object pmiDefaultsDlg: TMenuItem
      Caption = '&'#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102'...'
      OnClick = pmiDefaultsDlgClick
    end
    object pmiSep3: TMenuItem
      Caption = '-'
    end
    object pmiExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiExcelClick
    end
  end
  object pmLoadingPunkts: TPopupMenu
    OnPopup = pmLoadingPunktsPopup
    Left = 224
    Top = 64
    object pmiLoadingPunktsExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiExcelClick
    end
  end
end
