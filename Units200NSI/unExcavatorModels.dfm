object fmExcavatorModels: TfmExcavatorModels
  Left = 300
  Top = 363
  Width = 1226
  Height = 535
  HelpType = htKeyword
  HelpKeyword = 'Excavators'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 800
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
  object pnBtns: TPanel
    Left = 0
    Top = 440
    Width = 1208
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1208
      50)
    object btClose: TButton
      Left = 1292
      Top = 10
      Width = 93
      Height = 31
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 20
      Top = 10
      Width = 92
      Height = 31
      Caption = #1042' Excel...'
      TabOrder = 0
      OnClick = pmiExcelClick
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 1208
    Height = 440
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 1
    object pnRight: TPanel
      Left = 1060
      Top = 0
      Width = 148
      Height = 440
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnRight'
      TabOrder = 0
      object lbNote: TLabel
        Left = 0
        Top = 0
        Width = 148
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      end
      object dbmNote: TDBMemo
        Left = 0
        Top = 16
        Width = 148
        Height = 424
        Align = alClient
        DataField = 'Note'
        DataSource = fmDM.dsExcavators
        TabOrder = 0
      end
    end
    object pnData: TPanel
      Left = 0
      Top = 0
      Width = 1060
      Height = 440
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnData'
      TabOrder = 1
      object pbExcavators: TPaintBox
        Left = 0
        Top = 0
        Width = 1060
        Height = 89
        Align = alTop
        OnPaint = pbExcavatorsPaint
      end
      object dbgExcavators: TDBGrid
        Left = 0
        Top = 89
        Width = 1060
        Height = 351
        Align = alClient
        DataSource = fmDM.dsExcavators
        PopupMenu = pmExcavators
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = dbgExcavatorsDrawColumnCell
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
            FieldName = 'BucketCapacity'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CycleTime'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EngineName'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EngineNmax'
            ReadOnly = True
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ELength'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EWidth'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EHeight'
            Width = 56
            Visible = True
          end>
      end
    end
  end
  object pmExcavators: TPopupMenu
    OnPopup = pmExcavatorsPopup
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
