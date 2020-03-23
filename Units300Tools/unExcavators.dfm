object fmExcavators: TfmExcavators
  Left = 321
  Top = 140
  Width = 1321
  Height = 634
  HelpType = htKeyword
  HelpKeyword = 'DeportExcavators'
  ActiveControl = dbgDeportExcavators
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1087#1080#1089#1086#1095#1085#1099#1081' '#1087#1072#1088#1082' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 720
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
  OnResize = FormResize
  PixelsPerInch = 120
  TextHeight = 16
  object pbDeportExcavators: TPaintBox
    Left = 0
    Top = 0
    Width = 1303
    Height = 133
    Align = alTop
    OnPaint = pbDeportExcavatorsPaint
  end
  object pnBtns: TPanel
    Left = 0
    Top = 539
    Width = 1303
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1303
      50)
    object btClose: TButton
      Left = 1369
      Top = 10
      Width = 92
      Height = 31
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 20
      Top = 10
      Width = 88
      Height = 31
      Caption = #1074' Excel...'
      TabOrder = 0
      OnClick = pmiExcelClick
    end
  end
  object dbgDeportExcavators: TDBGrid
    Left = 0
    Top = 133
    Width = 1303
    Height = 406
    Align = alClient
    DataSource = fmDM.dsDeportExcavators
    DefaultDrawing = False
    PopupMenu = pmDeportExcavators
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColEnter = dbgDeportExcavatorsColEnter
    OnDrawColumnCell = dbgDeportExcavatorsDrawColumnCell
    OnKeyPress = dbgDeportExcavatorsKeyPress
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
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ParkNo'
        ReadOnly = True
        Title.Caption = #8470' '#1074' '#1087#1072#1088#1082#1077
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EYear'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WorkState'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FactCycleTime'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cost'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AddCostMaterials'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AddCostUnAccounted'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EngineKIM'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EngineKPD'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SENAmortizationRate'
        Width = 60
        Visible = True
      end>
  end
  object pmDeportExcavators: TPopupMenu
    OnPopup = pmDeportExcavatorsPopup
    Left = 184
    Top = 24
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
    object pmiDefaultsDlg: TMenuItem
      Caption = '&'#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102'...'
      OnClick = pmiDefaultsDlgClick
    end
    object pmiSep4: TMenuItem
      Caption = '-'
    end
    object pmiExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiExcelClick
    end
  end
end
