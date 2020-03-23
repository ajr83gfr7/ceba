object fmUnLoadingPunkts: TfmUnLoadingPunkts
  Left = 322
  Top = 136
  Width = 600
  Height = 480
  HelpType = htKeyword
  HelpKeyword = 'UnLoadingPunkts'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1091#1085#1082#1090#1099' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
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
  object lbUnLoadingPunkts: TLabel
    Left = 0
    Top = 0
    Width = 584
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = #1055#1091#1085#1082#1090#1099' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
  end
  object pnBtns: TPanel
    Left = 0
    Top = 403
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
  object Panel: TPanel
    Left = 0
    Top = 13
    Width = 584
    Height = 390
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel'
    TabOrder = 1
    object pbUnLoadingPunktRocks: TPaintBox
      Left = 0
      Top = 120
      Width = 584
      Height = 54
      Align = alTop
      OnPaint = pbUnLoadingPunktRocksPaint
    end
    object dbgUnLoadingPunktRocks: TDBGrid
      Left = 0
      Top = 174
      Width = 584
      Height = 216
      Align = alClient
      DataSource = fmDM.dsUnLoadingPunktRocks
      DefaultDrawing = False
      PopupMenu = pmRocks
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbgUnLoadingPunktRocksDrawColumnCell
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
          FieldName = 'RequiredContent'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'InitialContent'
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'InitialV1000m3'
          Width = 96
          Visible = True
        end>
    end
    object dbgUnLoadingPunkts: TDBGrid
      Left = 0
      Top = 0
      Width = 584
      Height = 120
      Align = alTop
      DataSource = fmDM.dsUnLoadingPunkts
      Options = [dgColumnResize, dgTabs, dgRowSelect]
      PopupMenu = pmPunkts
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'SortIndex'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotalName'
          Width = 500
          Visible = True
        end>
    end
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
  object pmPunkts: TPopupMenu
    Left = 160
    Top = 104
    object pmiPunktsExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiExcelClick
    end
  end
end
