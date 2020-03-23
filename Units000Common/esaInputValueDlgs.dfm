object fmInputValueDlg: TfmInputValueDlg
  Left = 342
  Top = 55
  ActiveControl = ledValue
  BorderStyle = bsDialog
  Caption = 'Caption'
  ClientHeight = 93
  ClientWidth = 392
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
  object ledValue: TLabeledEdit
    Left = 16
    Top = 24
    Width = 360
    Height = 16
    BevelInner = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Prompt'
    TabOrder = 0
    OnKeyPress = ledValueKeyPress
  end
  object btOk: TButton
    Left = 224
    Top = 56
    Width = 72
    Height = 24
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btOkClick
  end
  object btCancel: TButton
    Left = 304
    Top = 56
    Width = 72
    Height = 24
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
