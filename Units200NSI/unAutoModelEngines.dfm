object fmAutoModelEngines: TfmAutoModelEngines
  Left = 309
  Top = 107
  Width = 600
  Height = 400
  HelpType = htKeyword
  HelpKeyword = 'AutoEngines'
  ActiveControl = dbgAutoEngines
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1052#1072#1088#1082#1080' '#1076#1074#1080#1075#1072#1090#1077#1083#1077#1081' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 400
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
  object PaintBox: TPaintBox
    Left = 0
    Top = 0
    Width = 584
    Height = 72
    Align = alTop
    OnPaint = PaintBoxPaint
  end
  object dbgAutoEngines: TDBGrid
    Left = 0
    Top = 72
    Width = 584
    Height = 251
    Align = alClient
    DataSource = fmDM.dsAutoEngines
    DefaultDrawing = False
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
    PopupMenu = pmAutoEngines
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dbgAutoEnginesDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'SortIndex'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Name'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nmax'
        Title.Alignment = taCenter
        Width = 120
        Visible = True
      end>
  end
  object pnBtns: TPanel
    Left = 0
    Top = 323
    Width = 584
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      584
      41)
    object btClose: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 1
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042' Excel...'
      TabOrder = 0
      OnClick = pmiExcelClick
    end
  end
  object pmAutoEngines: TPopupMenu
    OnPopup = pmAutoEnginesPopup
    Left = 240
    Top = 120
    object pmiAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiAddClick
    end
    object pmiEdit: TMenuItem
      Caption = #1048#1079#1084#1077#1085'&'#1080#1090#1100
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
    object pmiSep2: TMenuItem
      Caption = '-'
    end
    object pmiDefault: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' &'#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnClick = pmiDefaultClick
    end
    object pmiSep3: TMenuItem
      Caption = '-'
    end
    object pmiChangeDefaults: TMenuItem
      Caption = '&'#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102'...'
      OnClick = pmiChangeDefaultsClick
    end
    object pmiSep4: TMenuItem
      Caption = '-'
    end
    object pmiExcel: TMenuItem
      Caption = #1074' E&xcel...'
      OnClick = pmiExcelClick
    end
  end
end
