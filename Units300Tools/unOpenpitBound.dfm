object fmOpenpitBound: TfmOpenpitBound
  Left = 483
  Top = 282
  HelpType = htKeyword
  HelpKeyword = 'Openpit'
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1090#1091#1088' '#1082#1072#1088#1100#1077#1088#1072
  ClientHeight = 333
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gbPointsBound: TGroupBox
    Left = 16
    Top = 16
    Width = 432
    Height = 128
    Caption = #1050#1086#1085#1090#1091#1088' '#1093#1072#1088#1072#1082#1090#1077#1088#1085#1099#1093' '#1090#1086#1095#1077#1082
    Enabled = False
    TabOrder = 0
    object ledPointsMinX: TLabeledEdit
      Left = 80
      Top = 24
      Width = 120
      Height = 21
      Color = clBtnFace
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'X min, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 0
    end
    object ledPointsMaxX: TLabeledEdit
      Left = 288
      Top = 24
      Width = 120
      Height = 21
      Color = clBtnFace
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'X max, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 1
    end
    object ledPointsMinY: TLabeledEdit
      Left = 80
      Top = 56
      Width = 120
      Height = 21
      Color = clBtnFace
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Y min, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 2
    end
    object ledPointsMaxY: TLabeledEdit
      Left = 288
      Top = 56
      Width = 120
      Height = 21
      Color = clBtnFace
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'Y max, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 3
    end
    object ledPointsMinZ: TLabeledEdit
      Left = 80
      Top = 88
      Width = 120
      Height = 21
      Color = clBtnFace
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Z min, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 4
    end
    object ledPointsMaxZ: TLabeledEdit
      Left = 288
      Top = 88
      Width = 120
      Height = 21
      Color = clBtnFace
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'Z max, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 5
    end
  end
  object gbBound: TGroupBox
    Left = 16
    Top = 152
    Width = 432
    Height = 128
    Caption = #1050#1086#1085#1090#1091#1088' '#1082#1072#1088#1100#1077#1088#1072
    TabOrder = 1
    object ledMinX: TLabeledEdit
      Left = 80
      Top = 24
      Width = 120
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'X min, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 0
      OnKeyDown = ledMinXKeyDown
      OnKeyPress = ledMinXKeyPress
    end
    object ledMaxX: TLabeledEdit
      Left = 288
      Top = 24
      Width = 120
      Height = 21
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'X max, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 1
      OnKeyDown = ledMinXKeyDown
      OnKeyPress = ledMinXKeyPress
    end
    object ledMinY: TLabeledEdit
      Left = 80
      Top = 56
      Width = 120
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Y min, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 2
      OnKeyDown = ledMinXKeyDown
      OnKeyPress = ledMinXKeyPress
    end
    object ledMaxY: TLabeledEdit
      Left = 288
      Top = 56
      Width = 120
      Height = 21
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'Y max, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 3
      OnKeyDown = ledMinXKeyDown
      OnKeyPress = ledMinXKeyPress
    end
    object ledMinZ: TLabeledEdit
      Left = 80
      Top = 88
      Width = 120
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Z min, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 4
      OnKeyDown = ledMinXKeyDown
      OnKeyPress = ledMinXKeyPress
    end
    object ledMaxZ: TLabeledEdit
      Left = 288
      Top = 88
      Width = 120
      Height = 21
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = 'Z max, '#1084
      LabelPosition = lpLeft
      LabelSpacing = 24
      TabOrder = 5
      OnKeyDown = ledMinXKeyDown
      OnKeyPress = ledMinXKeyPress
    end
  end
  object btOk: TButton
    Left = 151
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 239
    Top = 296
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
