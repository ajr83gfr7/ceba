object fmOpenpitCreate: TfmOpenpitCreate
  Left = 288
  Top = 108
  HelpType = htKeyword
  HelpKeyword = 'File'
  HelpContext = 600
  ActiveControl = edName
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077
  ClientHeight = 265
  ClientWidth = 592
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
  object pnBtns: TPanel
    Left = 0
    Top = 224
    Width = 592
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btOk: TButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btOkClick
    end
    object btCancel: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
    object btMore: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #1041#1086#1083#1100#1096#1077' >>'
      TabOrder = 2
      OnClick = btMoreClick
    end
  end
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 104
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lbName: TLabel
      Left = 16
      Top = 16
      Width = 76
      Height = 13
      Caption = '&'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FocusControl = edName
    end
    object lbDateCreate: TLabel
      Left = 16
      Top = 40
      Width = 77
      Height = 13
      Caption = '&'#1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      FocusControl = edDateCreate
    end
    object lbNote: TLabel
      Left = 16
      Top = 64
      Width = 63
      Height = 13
      Caption = '&'#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      FocusControl = edNote
    end
    object edName: TEdit
      Left = 112
      Top = 16
      Width = 464
      Height = 21
      TabOrder = 0
    end
    object edDateCreate: TEdit
      Left = 112
      Top = 40
      Width = 464
      Height = 21
      Color = clBtnFace
      MaxLength = 50
      ReadOnly = True
      TabOrder = 1
    end
    object edNote: TEdit
      Left = 112
      Top = 64
      Width = 464
      Height = 21
      MaxLength = 200
      TabOrder = 2
    end
  end
  object dbgOpenpits: TDBGrid
    Left = 0
    Top = 104
    Width = 592
    Height = 120
    Align = alClient
    Color = clBtnFace
    DataSource = fmDM.dsOpenpits
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'No'
        Title.Alignment = taCenter
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Name'
        Title.Alignment = taCenter
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DateCreate'
        Title.Alignment = taCenter
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Note'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end>
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 368
    Top = 152
  end
end
