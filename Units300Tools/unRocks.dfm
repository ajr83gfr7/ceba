object fmRocks: TfmRocks
  Left = 320
  Top = 117
  Width = 600
  Height = 400
  HelpType = htKeyword
  HelpKeyword = 'Rocks'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1058#1080#1087#1099' '#1076#1086#1073#1099#1074#1072#1077#1084#1086#1081' '#1075#1086#1088#1085#1086#1081' '#1087#1086#1088#1086#1076#1099
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
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pbRocks: TPaintBox
    Left = 0
    Top = 0
    Width = 584
    Height = 54
    Align = alTop
    OnPaint = pbRocksPaint
  end
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
    object btClose: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
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
  object dbgRocks: TDBGrid
    Left = 0
    Top = 54
    Width = 584
    Height = 269
    Align = alClient
    DataSource = fmDM.dsRocks
    DefaultDrawing = False
    Options = [dgEditing, dgAlwaysShowEditor, dgIndicator, dgColLines, dgRowLines]
    PopupMenu = pmRocks
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = dbgRocksColEnter
    OnDrawColumnCell = dbgRocksDrawColumnCell
    OnDblClick = dbgRocksDblClick
    OnKeyPress = dbgRocksKeyPress
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
        FieldName = 'Name'
        ReadOnly = True
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IsMineralWealth'
        PickList.Strings = (
          #1055#1086#1083#1077#1079#1085#1086#1077' '#1080#1089#1082#1086#1087#1072#1077#1084#1086#1077
          #1055#1091#1089#1090#1072#1103' '#1087#1086#1088#1086#1076#1072)
        Width = 160
        Visible = True
      end>
  end
  object pmRocks: TPopupMenu
    OnPopup = pmRocksPopup
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
      Caption = #1042#1074#1077#1088'&'#1093
      ShortCut = 8277
      OnClick = pmiUpClick
    end
    object pmiDown: TMenuItem
      Caption = #1042#1085#1080'&'#1079
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
end
