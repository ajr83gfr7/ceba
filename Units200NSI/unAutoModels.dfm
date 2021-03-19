object fmAutoModels: TfmAutoModels
  Left = 711
  Top = 62
  Width = 800
  Height = 600
  HelpType = htKeyword
  ActiveControl = dbgAutos
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1058#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1082#1072#1088#1100#1077#1088#1085#1099#1093' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
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
  object pnAutos: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 562
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pbAutos: TPaintBox
      Left = 0
      Top = 17
      Width = 377
      Height = 36
      Align = alTop
      OnPaint = pbAutosPaint
    end
    object sttAutos: TStaticText
      Left = 0
      Top = 0
      Width = 377
      Height = 17
      Align = alTop
      Alignment = taCenter
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = #1052#1086#1076#1077'&'#1083#1080
      FocusControl = dbgAutos
      TabOrder = 0
    end
    object dbgAutos: TDBGrid
      Left = 0
      Top = 53
      Width = 377
      Height = 509
      Align = alClient
      DataSource = fmDM.dsAutos
      Options = [dgIndicator, dgColLines, dgRowLines, dgRowSelect]
      PopupMenu = pmAutos
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
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'StrQtn'
          Width = 40
          Visible = True
        end>
    end
  end
  object PageControl: TPageControl
    Left = 377
    Top = 0
    Width = 407
    Height = 562
    ActivePage = tsFK
    Align = alRight
    TabOrder = 1
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object tsTotal: TTabSheet
      Caption = '&'#1054#1073#1097#1077#1077
      PopupMenu = pmAutos
      DesignSize = (
        399
        534)
      object lbBodySpace: TLabel
        Left = 16
        Top = 8
        Width = 170
        Height = 13
        Caption = #1054'&'#1073#1098#1077#1084' '#1082#1091#1079#1086#1074#1072', '#1082#1091#1073'.'#1084'. '#1089' "'#1096#1072#1087#1082#1086#1081'"'
        FocusControl = dbeBodySpace
      end
      object lbTonnage: TLabel
        Left = 16
        Top = 32
        Width = 111
        Height = 13
        Caption = #1043#1088#1091#1079#1086#1087#1086#1076'&'#1098#1077#1084#1085#1086#1089#1090#1100', '#1090'.'
        FocusControl = dbeTonnage
      end
      object lbTransmissionKind: TLabel
        Left = 16
        Top = 176
        Width = 89
        Height = 13
        Caption = #1042#1080#1076' '#1090'&'#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
      end
      object lbTr: TLabel
        Left = 16
        Top = 224
        Width = 112
        Height = 13
        Caption = #1042#1088#1077#1084#1103' '#1088#1072'&'#1079#1075#1088#1091#1079#1082#1080', '#1089#1077#1082
        FocusControl = dbeTr
      end
      object lbP: TLabel
        Left = 16
        Top = 56
        Width = 44
        Height = 13
        Caption = '&'#1052#1072#1089#1089#1072', '#1090
        FocusControl = dbeP
      end
      object lbRmin: TLabel
        Left = 16
        Top = 248
        Width = 178
        Height = 13
        Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1088#1072#1076#1080#1091#1089' &'#1087#1086#1074#1086#1088#1086#1090#1072', '#1084'.'
        FocusControl = dbeRmin
      end
      object lbTyresCount: TLabel
        Left = 16
        Top = 272
        Width = 82
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' &'#1096#1080#1085
        FocusControl = dbeTyresCount
      end
      object lbLength: TLabel
        Left = 16
        Top = 296
        Width = 50
        Height = 13
        Caption = #1044#1083'&'#1080#1085#1072', '#1084'.'
        FocusControl = dbeLength
      end
      object lbWidth: TLabel
        Left = 16
        Top = 320
        Width = 56
        Height = 13
        Caption = '&'#1064#1080#1088#1080#1085#1072', '#1084'.'
        FocusControl = dbeWidth
      end
      object lbHeight: TLabel
        Left = 16
        Top = 344
        Width = 55
        Height = 13
        Caption = '&'#1042#1099#1089#1086#1090#1072', '#1084'.'
        FocusControl = dbeHeight
      end
      object lbTransmissionKPD: TLabel
        Left = 16
        Top = 200
        Width = 94
        Height = 13
        Caption = '&'#1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080
        FocusControl = dbeTransmissionKPD
      end
      object lbEngines: TLabel
        Left = 16
        Top = 128
        Width = 55
        Height = 13
        Caption = '&'#1044#1074#1080#1075#1072#1090#1077#1083#1100
        FocusControl = dblcbEngines
      end
      object lbF: TLabel
        Left = 16
        Top = 80
        Width = 173
        Height = 13
        Caption = '&'#1055#1083#1086#1097#1072#1076#1100' '#1083#1086#1073#1086#1074#1086#1075#1086' '#1089#1077#1095#1077#1085#1080#1103', '#1082#1074'.'#1084'.'
        FocusControl = dbeF
      end
      object lbRo: TLabel
        Left = 16
        Top = 104
        Width = 145
        Height = 13
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' &'#1086#1073#1090#1077#1082#1072#1077#1084#1086#1089#1090#1080
        FocusControl = dbeRo
      end
      object lbEngineNmax: TLabel
        Left = 16
        Top = 152
        Width = 204
        Height = 13
        Caption = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103', '#1082#1042#1090
        FocusControl = dbeEngineNmax
      end
      object dbeBodySpace: TDBEdit
        Left = 241
        Top = 8
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'BodySpace'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 0
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeTonnage: TDBEdit
        Left = 241
        Top = 32
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'Tonnage'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 1
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeTr: TDBEdit
        Left = 241
        Top = 224
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 't_r'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 9
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeP: TDBEdit
        Left = 241
        Top = 56
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'P'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 2
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeRmin: TDBEdit
        Left = 241
        Top = 248
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'Rmin'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 10
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeTyresCount: TDBEdit
        Left = 241
        Top = 272
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'TyresCount'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 11
      end
      object dbeLength: TDBEdit
        Left = 241
        Top = 296
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'ALength'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 12
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeWidth: TDBEdit
        Left = 241
        Top = 320
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'AWidth'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 13
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeHeight: TDBEdit
        Left = 241
        Top = 344
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'AHeight'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 14
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeTransmissionKPD: TDBEdit
        Left = 241
        Top = 200
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'TransmissionKPD'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 8
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbcbTransmissionKind: TDBComboBox
        Left = 241
        Top = 176
        Width = 144
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        DataField = 'TransmissionKind'
        DataSource = fmDM.dsAutos
        ItemHeight = 13
        Items.Strings = (
          #1043#1052
          #1069#1052)
        PopupMenu = pmAutos
        TabOrder = 7
      end
      object dblcbEngines: TDBLookupComboBox
        Left = 241
        Top = 128
        Width = 144
        Height = 21
        Anchors = [akTop, akRight]
        DataField = 'Id_Engine'
        DataSource = fmDM.dsAutos
        KeyField = 'Id_Engine'
        ListField = 'Name'
        ListSource = fmDM.dsAutoEngines
        PopupMenu = pmAutos
        TabOrder = 5
      end
      object dbeF: TDBEdit
        Left = 241
        Top = 80
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'F'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 3
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeRo: TDBEdit
        Left = 241
        Top = 104
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'Ro'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        TabOrder = 4
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbeEngineNmax: TDBEdit
        Left = 241
        Top = 152
        Width = 144
        Height = 24
        Anchors = [akTop, akRight]
        Color = clBtnFace
        DataField = 'EngineNmax'
        DataSource = fmDM.dsAutos
        PopupMenu = pmAutos
        ReadOnly = True
        TabOrder = 6
        OnKeyPress = dbeBodySpaceKeyPress
      end
      object dbmNote: TDBMemo
        Left = 16
        Top = 400
        Width = 368
        Height = 128
        DataField = 'Note'
        DataSource = fmDM.dsAutos
        TabOrder = 15
      end
    end
    object tsFK: TTabSheet
      Caption = #1058#1103#1075#1086#1074#1099#1077' '#1093#1072#1088#1072#1082'&'#1090#1077#1088#1080#1089#1090#1080#1082#1080
      ImageIndex = 1
      object pbFks: TPaintBox
        Left = 0
        Top = 0
        Width = 399
        Height = 36
        Align = alTop
        OnPaint = pbFksPaint
      end
      object dbgFks: TDBGrid
        Left = 0
        Top = 36
        Width = 399
        Height = 498
        Align = alClient
        DataSource = fmDM.dsAutoFks
        DefaultDrawing = False
        Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs]
        PopupMenu = pmFks
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = dbgFksDrawColumnCell
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
            FieldName = 'V'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Fk'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'kg'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end>
      end
    end
    object tsGraph: TTabSheet
      Caption = '&'#1043#1088#1072#1092#1080#1082
      ImageIndex = 2
      object dbchFks: TDBChart
        Left = 0
        Top = 0
        Width = 400
        Height = 545
        AllowPanning = pmNone
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Foot.Font.Charset = DEFAULT_CHARSET
        Foot.Font.Color = clBlack
        Foot.Font.Height = -11
        Foot.Font.Name = 'Arial'
        Foot.Font.Style = [fsBold]
        Foot.Text.Strings = (
          #1057#1082#1086#1088#1086#1089#1090#1100' V, '#1082#1084'/'#1095)
        PrintProportional = False
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -13
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          #1058#1103#1075#1086#1074#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080)
        ClipPoints = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Ticks.Color = clBlack
        LeftAxis.Title.Caption = #1057#1080#1083#1072' '#1090#1103#1075#1080' Fk, '#1082#1053
        LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
        LeftAxis.Title.Font.Color = clBlack
        LeftAxis.Title.Font.Height = -11
        LeftAxis.Title.Font.Name = 'Arial'
        LeftAxis.Title.Font.Style = [fsBold]
        Legend.LegendStyle = lsSeries
        Legend.Visible = False
        TopAxis.Title.Caption = #1058#1103#1075#1086#1074#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        View3D = False
        View3DOptions.Elevation = 360
        Align = alClient
        BevelOuter = bvNone
        PopupMenu = pmChart
        TabOrder = 0
        object Series1: TFastLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          DataSource = fmDM.quAutoFks
          SeriesColor = clRed
          Title = 'Series'
          LinePen.Color = clRed
          LinePen.Width = 2
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          XValues.ValueSource = 'V'
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
          YValues.ValueSource = 'Fk'
        end
      end
    end
  end
  object pmChart: TPopupMenu
    Left = 312
    Top = 104
    object pmiChartSaveAs: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' &'#1082#1072#1082'...'
      OnClick = pmiChartSaveAsClick
    end
    object pmiChartPrint: TMenuItem
      Caption = '&'#1055#1077#1095#1072#1090#1100'...'
      ShortCut = 16464
      OnClick = pmiChartPrintClick
    end
  end
  object pmAutos: TPopupMenu
    OnPopup = pmAutosPopup
    Left = 368
    Top = 64
    object pmiAutoAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiAutoAddClick
    end
    object pmiAutoEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 16453
      OnClick = pmiAutoEditClick
    end
    object pmiAutoDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
      OnClick = pmiAutoDeleteClick
    end
    object pmiAutoDeleteAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      OnClick = pmiAutoDeleteAllClick
    end
    object pmiAutoSep1: TMenuItem
      Caption = '-'
    end
    object pmiAutoUp: TMenuItem
      Caption = #1042#1074#1077#1088'&'#1093
      ShortCut = 8277
      OnClick = pmiAutoUpClick
    end
    object pmiAutoDown: TMenuItem
      Caption = #1042#1085#1080'&'#1079
      ShortCut = 8260
      OnClick = pmiAutoDownClick
    end
    object pmiAutoSep2: TMenuItem
      Caption = '-'
    end
    object pmiAutoDefault: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' &'#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnClick = pmiAutoDefaultClick
    end
    object pmiAutoSep3: TMenuItem
      Caption = '-'
    end
    object pmiAutoDefaultsDlg: TMenuItem
      Caption = '&'#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102'...'
      OnClick = pmiAutoDefaultsDlgClick
    end
    object pmiAutoSep4: TMenuItem
      Caption = '-'
    end
    object pmiExcelParams: TMenuItem
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1074#1099#1074#1086#1076#1072' '#1074' Excel'
      object pmiExcelParamsPrintFkTable: TMenuItem
        Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1090#1103#1075#1086#1074#1099#1093' '#1079#1085#1072#1095#1077#1085#1080#1081
        OnClick = pmiExcelParamsPrintFkTableClick
      end
      object pmiExcelParamsInDollar: TMenuItem
        Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1089#1090#1086#1080#1084#1086#1089#1090#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1074' '#1076#1086#1083#1083#1072#1088#1072#1093' '#1057#1064#1040
        OnClick = pmiExcelParamsInDollarClick
      end
    end
    object pmiAutoExcel: TMenuItem
      Caption = #1074' E&xcel'
      OnClick = pmiAutoExcelClick
    end
  end
  object pmFks: TPopupMenu
    OnPopup = pmFksPopup
    Left = 280
    Top = 48
    object pmiFksAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiFksAddClick
    end
    object pmiFksEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 16453
      OnClick = pmiFksEditClick
    end
    object pmiFksDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
      OnClick = pmiFksDeleteClick
    end
    object pmiFksDeleteAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      OnClick = pmiFksDeleteAllClick
    end
    object pmiFksSep1: TMenuItem
      Caption = '-'
    end
    object pmiFksImportFrom: TMenuItem
      Caption = #1048#1084#1087#1086#1088#1090'..'
      OnClick = pmiFksImportFromClick
    end
  end
end
