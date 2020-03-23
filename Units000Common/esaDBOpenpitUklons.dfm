object fmOpenpitUklons: TfmOpenpitUklons
  Left = 192
  Top = 107
  Width = 800
  Height = 400
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1059#1082#1083#1086#1085#1099
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 784
    Height = 364
    Align = alClient
    ColCount = 11
    DefaultRowHeight = 16
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    PopupMenu = pmUklons
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pmUklons: TPopupMenu
    OnPopup = pmUklonsPopup
    Left = 192
    Top = 96
    object pmiUklonsExcel: TMenuItem
      Caption = #1074' Excel..'
      ShortCut = 16464
      OnClick = pmiUklonsExcelClick
    end
  end
end
