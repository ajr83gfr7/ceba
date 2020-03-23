object fmRoadCoats: TfmRoadCoats
  Left = 227
  Top = 176
  Width = 600
  Height = 400
  HelpType = htKeyword
  HelpKeyword = 'Roads'
  ActiveControl = dbgRoadCoats
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1058#1080#1087#1099' '#1076#1086#1088#1086#1078#1085#1086#1075#1086' '#1087#1086#1082#1088#1099#1090#1080#1103
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
  object Splitter: TSplitter
    Left = 0
    Top = 160
    Width = 584
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object pnBtns: TPanel
    Left = 0
    Top = 323
    Width = 584
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MinHeight = 41
    Constraints.MinWidth = 41
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
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042' Excel...'
      TabOrder = 0
      OnClick = pmiRoadCoatExcelClick
    end
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 160
    Align = alTop
    Caption = 'pnTop'
    Constraints.MinHeight = 100
    TabOrder = 1
    object pbRoadCoats: TPaintBox
      Left = 1
      Top = 1
      Width = 582
      Height = 54
      Align = alTop
      OnPaint = pbRoadCoatsPaint
    end
    object dbgRoadCoats: TDBGrid
      Left = 1
      Top = 55
      Width = 582
      Height = 104
      Align = alClient
      DataSource = fmDM.dsRoadCoats
      DefaultDrawing = False
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines]
      PopupMenu = pmRoadCoats
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbgUSKsDrawColumnCell
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
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ShortName'
          Width = 120
          Visible = True
        end>
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 165
    Width = 584
    Height = 158
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    Constraints.MinHeight = 100
    TabOrder = 2
    object pbUSKs: TPaintBox
      Left = 0
      Top = 0
      Width = 584
      Height = 72
      Align = alTop
      OnPaint = pbUSKsPaint
    end
    object dbgUSKs: TDBGrid
      Left = 0
      Top = 72
      Width = 584
      Height = 86
      Align = alClient
      DataSource = fmDM.dsRoadCoatUSKs
      DefaultDrawing = False
      PopupMenu = pmUSKs
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbgUSKsDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'No'
          ReadOnly = True
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P'
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValueMin'
          Width = 144
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValueMax'
          Width = 144
          Visible = True
        end>
    end
  end
  object pmRoadCoats: TPopupMenu
    OnPopup = pmRoadCoatsPopup
    Left = 368
    Top = 64
    object pmiRoadCoatAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiRoadCoatAddClick
    end
    object pmiRoadCoatEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 16453
      OnClick = pmiRoadCoatEditClick
    end
    object pmiRoadCoatDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
      OnClick = pmiRoadCoatDeleteClick
    end
    object pmiRoadCoatDeleteAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      OnClick = pmiRoadCoatDeleteAllClick
    end
    object pmiRoadCoatSep1: TMenuItem
      Caption = '-'
    end
    object pmiRoadCoatUp: TMenuItem
      Caption = #1042#1074#1077#1088'&'#1093
      ShortCut = 8277
      OnClick = pmiRoadCoatUpClick
    end
    object pmiRoadCoatDown: TMenuItem
      Caption = #1042#1085#1080'&'#1079
      ShortCut = 8260
      OnClick = pmiRoadCoatDownClick
    end
    object pmiRoadCoatSep2: TMenuItem
      Caption = '-'
    end
    object pmiRoadCoatExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiRoadCoatExcelClick
    end
  end
  object pmUSKs: TPopupMenu
    OnPopup = pmUSKsPopup
    Left = 256
    Top = 128
    object pmiUSKAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiUSKAddClick
    end
    object pmiUSKEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 16453
      OnClick = pmiUSKEditClick
    end
    object pmiUSKDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
      OnClick = pmiUSKDeleteClick
    end
    object pmiUSKDeleteAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      OnClick = pmiUSKDeleteAllClick
    end
    object pmiUSKSep1: TMenuItem
      Caption = '-'
    end
    object pmiUSKExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiRoadCoatExcelClick
    end
  end
end
