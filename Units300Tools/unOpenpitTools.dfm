object fmOpenpitTools: TfmOpenpitTools
  Left = 309
  Top = 107
  HelpType = htKeyword
  HelpKeyword = 'Openpit'
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 613
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnBtns: TPanel
    Left = 0
    Top = 572
    Width = 520
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      520
      41)
    object btOk: TButton
      Left = 255
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      Default = True
      TabOrder = 0
      OnClick = btOkClick
    end
    object btCancel: TButton
      Left = 335
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
    object btApply: TButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Enabled = False
      TabOrder = 2
      OnClick = btOkClick
    end
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 520
    Height = 572
    ActivePage = tsDefault
    Align = alClient
    TabOrder = 1
    OnChange = pcMainChange
    object tsDefault: TTabSheet
      Caption = '&'#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      ImageIndex = 1
      object gbDefaultPoints: TGroupBox
        Left = 16
        Top = 8
        Width = 480
        Height = 64
        Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1085#1099#1077' '#1090#1086#1095#1082#1080
        TabOrder = 0
        object lbDefaultPointsZ: TLabel
          Left = 16
          Top = 24
          Width = 151
          Height = 13
          Caption = '&'#1042#1099#1089#1086#1090#1072' '#1093#1072#1088#1072#1082#1090#1077#1088#1085#1099#1093' '#1090#1086#1095#1077#1082', '#1084
          FocusControl = edDefaultPointsZ
        end
        object edDefaultPointsZ: TEdit
          Left = 328
          Top = 24
          Width = 136
          Height = 21
          TabOrder = 0
        end
      end
      object gbDefaultBlocks: TGroupBox
        Left = 16
        Top = 72
        Width = 480
        Height = 192
        Caption = #1041#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1080
        TabOrder = 1
        object lbDefaultBlocksStripCount: TLabel
          Left = 16
          Top = 24
          Width = 145
          Height = 13
          Caption = '&'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1083#1086#1089' '#1076#1074#1080#1078#1077#1085#1080#1103
          FocusControl = seDefaultBlocksStripCount
        end
        object lbDefaultBlocksStripWidth: TLabel
          Left = 16
          Top = 48
          Width = 147
          Height = 13
          Caption = '&'#1064#1080#1088#1080#1085#1072' '#1087#1086#1083#1086#1089#1099' '#1076#1074#1080#1078#1077#1085#1080#1103', '#1084
          FocusControl = edDefaultBlocksStripWidth
        end
        object lbDefaultBlocksVmax0: TLabel
          Left = 16
          Top = 72
          Width = 184
          Height = 13
          Caption = '&'#1044#1086#1087#1091#1089#1082#1072#1077#1084#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100' ('#1075#1088#1091#1079'.), '#1082#1084'/'#1095
          FocusControl = edDefaultBlocksVmax0
        end
        object lbDefaultBlocksType: TLabel
          Left = 16
          Top = 120
          Width = 88
          Height = 13
          Caption = #1058#1080#1087' &'#1073#1083#1086#1082'-'#1091#1095#1072#1089#1090#1082#1072
        end
        object lbDefaultBlocksRoadCoat: TLabel
          Left = 16
          Top = 144
          Width = 105
          Height = 13
          Caption = #1044#1086#1088#1086'&'#1078#1085#1086#1077' '#1087#1086#1082#1088#1099#1090#1080#1077
          FocusControl = dblcbDefaultBlocksRoadCoat
        end
        object lbDefaultBlocksVmax1: TLabel
          Left = 16
          Top = 96
          Width = 194
          Height = 13
          Caption = '&'#1044#1086#1087#1091#1089#1082#1072#1077#1084#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100' ('#1087#1086#1088#1086#1078'.), '#1082#1084'/'#1095
          FocusControl = edDefaultBlocksVmax1
        end
        object edDefaultBlocksStripWidth: TEdit
          Left = 328
          Top = 48
          Width = 136
          Height = 21
          TabOrder = 0
          Text = '12,5'
        end
        object edDefaultBlocksVmax0: TEdit
          Left = 328
          Top = 72
          Width = 136
          Height = 21
          TabOrder = 1
        end
        object cbDefaultBlocksType: TComboBox
          Left = 328
          Top = 120
          Width = 136
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          Items.Strings = (
            #1059#1095#1072#1089#1090#1086#1082' '#1076#1074#1080#1078#1077#1085#1080#1103
            #1057#1098#1077#1079#1076
            #1059#1095#1072#1089#1090#1086#1082' '#1076#1083#1103' '#1084#1072#1085#1077#1074#1088#1072)
        end
        object dblcbDefaultBlocksRoadCoat: TDBLookupComboBox
          Left = 16
          Top = 160
          Width = 448
          Height = 21
          KeyField = 'Id_RoadCoat'
          ListField = 'Name'
          ListSource = fmDM.dsRoadCoats
          TabOrder = 3
        end
        object seDefaultBlocksStripCount: TSpinEdit
          Left = 328
          Top = 24
          Width = 136
          Height = 22
          EditorEnabled = False
          MaxValue = 2
          MinValue = 1
          TabOrder = 4
          Value = 2
        end
        object edDefaultBlocksVmax1: TEdit
          Left = 328
          Top = 96
          Width = 136
          Height = 21
          TabOrder = 5
        end
      end
      object gbDefaultLoadingPunkts: TGroupBox
        Left = 16
        Top = 264
        Width = 480
        Height = 104
        Caption = #1055#1091#1085#1082#1090#1099' '#1087#1086#1075#1088#1091#1079#1082#1080
        TabOrder = 2
        object lbDefaultLoadingPunktsRock: TLabel
          Left = 16
          Top = 20
          Width = 144
          Height = 13
          Caption = #1044#1086#1073#1099#1074#1072#1077#1084#1072#1103' '#1075#1086#1088#1085#1072#1103' '#1087#1086#1088#1086#1076#1072
          FocusControl = dblcbDefaultLoadingPunktsRock
        end
        object lbDefaultLoadingPunktsContent: TLabel
          Left = 16
          Top = 48
          Width = 77
          Height = 13
          Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
          FocusControl = edDefaultLoadingPunktsContent
        end
        object lbDefaultLoadingPunktsPlannedV1000m3: TLabel
          Left = 16
          Top = 72
          Width = 203
          Height = 13
          Caption = #1055#1083#1072#1085#1080#1088#1091#1077#1084#1099#1081' '#1086#1073#1098#1077#1084' '#1085#1072' '#1087#1077#1088#1080#1086#1076', '#1090#1099#1089'.'#1084'3'
          FocusControl = edDefaultLoadingPunktsPlannedV1000m3
        end
        object dblcbDefaultLoadingPunktsRock: TDBLookupComboBox
          Left = 328
          Top = 24
          Width = 136
          Height = 21
          KeyField = 'Id_Rock'
          ListField = 'Name'
          ListSource = fmDM.dsRocks
          TabOrder = 0
        end
        object edDefaultLoadingPunktsContent: TEdit
          Left = 328
          Top = 48
          Width = 136
          Height = 21
          TabOrder = 1
        end
        object edDefaultLoadingPunktsPlannedV1000m3: TEdit
          Left = 328
          Top = 72
          Width = 136
          Height = 21
          TabOrder = 2
        end
      end
      object gbDefaultUnLoadingPunkts: TGroupBox
        Left = 16
        Top = 368
        Width = 480
        Height = 176
        Caption = #1055#1091#1085#1082#1090#1099' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
        TabOrder = 3
        object lbDefaultUnLoadingPunktsMaxV1000m3: TLabel
          Left = 16
          Top = 24
          Width = 188
          Height = 13
          Caption = #1025#1084#1082#1086#1089#1090#1100' '#1087#1088#1080#1077#1084#1085#1086#1075#1086' '#1073#1091#1085#1082#1077#1088#1072', '#1090#1099#1089'.'#1084'3'
          FocusControl = edDefaultUnLoadingPunktsMaxV1000m3
        end
        object lbDefaultUnLoadingPunktsAutoMaxCount: TLabel
          Left = 16
          Top = 48
          Width = 307
          Height = 13
          Caption = #1063#1080#1089#1083#1086' '#1072#1074#1090#1086', '#1082#1086#1090#1086#1088#1099#1093' '#1084#1086#1078#1085#1086' '#1088#1072#1079#1084#1077#1089#1090#1080#1090#1100' '#1074' '#1087#1091#1085#1082#1090#1077' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
          FocusControl = seDefaultUnLoadingPunktsAutoMaxCount
        end
        object lbDefaultUnLoadingPunktsKind: TLabel
          Left = 16
          Top = 72
          Width = 111
          Height = 13
          Caption = #1058#1080#1087' '#1087#1091#1085#1082#1090#1072' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
        end
        object lbDefaultUnLoadingPunktsRequiredContent: TLabel
          Left = 16
          Top = 96
          Width = 135
          Height = 13
          Caption = #1058#1088#1077#1073#1091#1077#1084#1086#1077' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
          FocusControl = edDefaultUnLoadingPunktsRequiredContent
        end
        object lbDefaultUnLoadingPunktsInitialContent: TLabel
          Left = 16
          Top = 120
          Width = 167
          Height = 13
          Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1089#1084#1077#1085#1099', %'
          FocusControl = edDefaultUnLoadingPunktsInitialContent
        end
        object lbDefaultUnLoadingPunktsInitialV1000m3: TLabel
          Left = 16
          Top = 144
          Width = 193
          Height = 13
          Caption = #1054#1073#1098#1077#1084' '#1043#1052' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072', '#1090#1099#1089'.'#1084'3'
          FocusControl = edDefaultUnLoadingPunktsInitialV1000m3
        end
        object edDefaultUnLoadingPunktsMaxV1000m3: TEdit
          Left = 328
          Top = 24
          Width = 136
          Height = 21
          TabOrder = 0
        end
        object seDefaultUnLoadingPunktsAutoMaxCount: TSpinEdit
          Left = 328
          Top = 48
          Width = 136
          Height = 22
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 2
        end
        object cbDefaultUnLoadingPunktsKind: TComboBox
          Left = 328
          Top = 72
          Width = 136
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = #1060#1072#1073#1088#1080#1082#1072
          Items.Strings = (
            #1060#1072#1073#1088#1080#1082#1072
            #1055#1077#1088#1077#1075#1088#1091#1079#1086#1095#1085#1099#1081' '#1089#1082#1083#1072#1076
            #1054#1090#1074#1072#1083)
        end
        object edDefaultUnLoadingPunktsRequiredContent: TEdit
          Left = 328
          Top = 96
          Width = 136
          Height = 21
          TabOrder = 3
        end
        object edDefaultUnLoadingPunktsInitialContent: TEdit
          Left = 328
          Top = 120
          Width = 136
          Height = 21
          TabOrder = 4
        end
        object edDefaultUnLoadingPunktsInitialV1000m3: TEdit
          Left = 328
          Top = 144
          Width = 136
          Height = 21
          TabOrder = 5
        end
      end
    end
    object tsDisigner: TTabSheet
      Caption = '&'#1044#1080#1079#1072#1081#1085#1077#1088
      object grbDisignerGrid: TGroupBox
        Left = 16
        Top = 8
        Width = 480
        Height = 128
        Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1085#1072#1103' '#1089#1077#1090#1082#1072
        TabOrder = 0
        object lbDisignerGridStep: TLabel
          Left = 16
          Top = 24
          Width = 140
          Height = 13
          Caption = '&'#1064#1072#1075' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1085#1086#1081' '#1089#1077#1090#1082#1080', '#1084
        end
        object pbDisignerGrid: TPaintBox
          Left = 240
          Top = 24
          Width = 224
          Height = 85
          Color = clBlack
          ParentColor = False
        end
        object lbDisignerGridStyle: TLabel
          Left = 16
          Top = 72
          Width = 100
          Height = 13
          Caption = #1057#1090#1080#1083#1100' '#1086#1090#1086#1073#1088#1072'&'#1078#1077#1085#1080#1103
          FocusControl = cbDisignerGridStyle
        end
        object seDisignerGridStep: TSpinEdit
          Tag = 200
          Left = 168
          Top = 24
          Width = 56
          Height = 22
          EditorEnabled = False
          Increment = 10
          MaxValue = 1000
          MinValue = 50
          TabOrder = 0
          Value = 1000
          OnChange = seDisignerGridStepChange
        end
        object chbDisignerGridMarks: TCheckBox
          Left = 14
          Top = 48
          Width = 208
          Height = 17
          Alignment = taLeftJustify
          Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1077' &'#1086#1090#1084#1077#1090#1082#1080
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = seDisignerGridStepChange
        end
        object cbDisignerGridStyle: TComboBox
          Left = 16
          Top = 88
          Width = 208
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 2
          Text = #1058#1086#1095#1082#1080
          OnChange = seDisignerGridStepChange
          Items.Strings = (
            #1053#1077#1090#1091
            #1058#1086#1095#1082#1080
            #1050#1088#1077#1089#1090#1080#1082#1080
            #1057#1077#1090#1082#1072)
        end
      end
      object gbDisigner: TGroupBox
        Left = 16
        Top = 144
        Width = 480
        Height = 176
        Caption = #1069#1083#1077#1084#1077#1085#1090#1099' '#1082#1072#1088#1100#1077#1088#1072
        TabOrder = 1
        object lbDisignerRadius: TLabel
          Left = 240
          Top = 48
          Width = 55
          Height = 13
          Caption = #1056#1072#1076#1080#1091'&'#1089', pxl'
          FocusControl = seDisignerRadius
        end
        object lbDisignerColor: TLabel
          Left = 240
          Top = 24
          Width = 25
          Height = 13
          Caption = '&'#1062#1074#1077#1090
          FocusControl = clbDisignerColor
        end
        object lsbDisigner: TListBox
          Left = 16
          Top = 24
          Width = 208
          Height = 136
          ItemHeight = 13
          Items.Strings = (
            #1061#1072#1088#1072#1082#1090#1077#1088#1085#1099#1077' '#1090#1086#1095#1082#1080
            #1059#1095#1072#1089#1090#1082#1080' '#1076#1074#1080#1078#1077#1085#1080#1103
            #1057#1098#1077#1079#1076#1099
            #1059#1095#1072#1089#1090#1082#1080' '#1076#1083#1103' '#1084#1072#1085#1077#1074#1088#1072
            #1055#1077#1088#1077#1082#1088#1077#1089#1090#1082#1080
            #1052#1072#1088#1096#1088#1091#1090#1099' '#1076#1074#1080#1078#1077#1085#1080#1103
            #1055#1091#1085#1082#1090#1099' '#1087#1086#1075#1088#1091#1079#1082#1080
            #1055#1091#1085#1082#1090#1099' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
            #1055#1091#1085#1082#1090#1099' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080)
          TabOrder = 0
          OnClick = lsbDisignerClick
          OnKeyDown = lsbDisignerKeyDown
        end
        object seDisignerRadius: TSpinEdit
          Left = 352
          Top = 48
          Width = 112
          Height = 22
          EditorEnabled = False
          MaxValue = 20
          MinValue = 1
          TabOrder = 1
          Value = 5
          OnChange = clbDisignerColorChange
        end
        object clbDisignerColor: TColorBox
          Left = 352
          Top = 24
          Width = 112
          Height = 22
          Selected = clNavy
          Style = [cbStandardColors]
          ItemHeight = 16
          TabOrder = 2
          OnChange = clbDisignerColorChange
        end
        object rgDisignerStyle: TRadioGroup
          Left = 240
          Top = 72
          Width = 224
          Height = 88
          Caption = #1057#1090#1080#1083#1100' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103
          Items.Strings = (
            'qwqw'
            'qweqw'
            'wqeqw'
            'eqweqwe')
          TabOrder = 3
          OnClick = clbDisignerColorChange
        end
      end
    end
  end
end
