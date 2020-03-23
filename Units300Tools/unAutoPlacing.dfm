object fmAutoPlacing: TfmAutoPlacing
  Left = 240
  Top = 126
  Width = 700
  Height = 400
  HelpType = htKeyword
  HelpKeyword = 'AutoPlacing'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1072#1089#1089#1090#1072#1085#1086#1074#1082#1072' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' '#1089#1087#1080#1089#1086#1095#1085#1086#1075#1086' '#1087#1072#1088#1082#1072
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 700
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
  object pbDeportAutos: TPaintBox
    Left = 0
    Top = 0
    Width = 684
    Height = 54
    Align = alTop
    OnPaint = pbDeportAutosPaint
  end
  object dbgDeportAutos: TDBGrid
    Left = 0
    Top = 54
    Width = 684
    Height = 269
    Align = alClient
    DataSource = fmDM.dsDeportAutos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect]
    PopupMenu = pmDeportAutos
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
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
        FieldName = 'TotalName'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WorkState'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ShiftPunkt'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Course'
        Title.Alignment = taCenter
        Width = 320
        Visible = True
      end>
  end
  object pnBtns: TPanel
    Left = 0
    Top = 323
    Width = 684
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      684
      41)
    object btClose: TButton
      Left = 604
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 16
      Top = 8
      Width = 72
      Height = 25
      Caption = #1074' Excel...'
      TabOrder = 0
      OnClick = pmiExcelClick
    end
  end
  object pmDeportAutos: TPopupMenu
    Left = 184
    Top = 24
    object pmiShiftPunkts: TMenuItem
      Caption = #1055#1091#1085#1082#1090' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080'...'
      ShortCut = 16467
      OnClick = pmiShiftPunktsClick
    end
    object pmiCourses: TMenuItem
      Caption = #1052#1072#1088#1096#1088#1091#1090' '#1076#1074#1080#1078#1077#1085#1080#1103'...'
      ShortCut = 16451
      OnClick = pmiCoursesClick
    end
    object pmiSep1: TMenuItem
      Caption = '-'
    end
    object pmiExcel: TMenuItem
      Caption = #1074' Excel...'
      OnClick = pmiExcelClick
    end
  end
end
