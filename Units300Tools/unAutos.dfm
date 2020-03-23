object fmAutos: TfmAutos
  Left = 117
  Top = 178
  Width = 800
  Height = 400
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1087#1080#1089#1086#1095#1085#1099#1081' '#1087#1072#1088#1082' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgAutos: TDBGridEh
    Left = 0
    Top = 0
    Width = 784
    Height = 362
    Align = alClient
    DataSource = fmDM.dsDeportAutos
    Flat = False
    FooterColor = clYellow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    FooterRowCount = 2
    MinAutoFitWidth = 30
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    ParentShowHint = False
    PopupMenu = pmAutos
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        EditButtons = <>
        FieldName = 'SortIndex'
        Footers = <
          item
            FieldName = 'SortIndex'
            ValueType = fvtFieldValue
          end
          item
            ValueType = fvtStaticText
          end>
        MaxWidth = 30
        MinWidth = 30
        Title.Hint = #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' '#1085#1086#1084#1077#1088
        Width = 30
      end
      item
        DropDownShowTitles = True
        DropDownSizing = True
        EditButtons = <>
        FieldName = 'Name'
        Footers = <
          item
            ValueType = fvtStaticText
          end>
        LookupDisplayFields = 'Name;Tonnage;BodySpace'
        MinWidth = 64
        Title.Caption = #1052#1086#1076#1077#1083#1100
        Title.Hint = #1052#1086#1076#1077#1083#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'ParkNo'
        Footers = <
          item
            FieldName = 'ParkNo'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 24
        MinWidth = 24
        ReadOnly = True
        Title.Caption = #1043#1072#1088#1072#1078#1085#1099#1081' '#1085#1086#1084#1077#1088
        Title.Hint = #1043#1072#1088#1072#1078#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
        Title.Orientation = tohVertical
        Width = 24
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'NetQtn'
        Footers = <
          item
            FieldName = 'NetQtn'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        ReadOnly = True
        Title.Caption = #1043#1088#1091#1079#1086'- '#1087#1086#1076#1098#1077#1084'- '#1085#1086#1089#1090#1100' Q, '#1090'|'#1085#1086#1084'.'
        Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1072#1103' '#1075#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090
        Width = 32
      end
      item
        EditButtons = <>
        FieldName = 'FactTonnage'
        Footers = <
          item
            FieldName = 'FactTonnage'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        Title.Caption = #1043#1088#1091#1079#1086'- '#1087#1086#1076#1098#1077#1084'- '#1085#1086#1089#1090#1100' Q, '#1090'|'#1092#1072#1082#1090'.'
        Title.Hint = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1075#1088#1091#1079#1086#1087#1086#1076#1098#1077#1084#1085#1086#1089#1090#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090
        Width = 32
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'BodyHeapVm3'
        Footers = <
          item
            FieldName = 'BodyHeapVm3'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 40
        MinWidth = 40
        ReadOnly = True
        Title.Caption = 'V'#1082#1091#1079#1086#1074#1072', '#1084'3 (2:1)'
        Title.Hint = #1054#1073#1098#1077#1084' '#1082#1091#1079#1086#1074#1072' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072' "'#1089' '#1096#1072#1087#1082#1086#1081'", '#1084'3'
        Title.Orientation = tohVertical
        Width = 40
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'NetPtn'
        Footers = <
          item
            FieldName = 'NetPtn'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        ReadOnly = True
        Title.Caption = 'P '#1087#1086#1088#1086#1078'.'#1072#1074#1090#1086', '#1090
        Title.Hint = #1052#1072#1089#1089#1072' '#1087#1086#1088#1086#1078#1085#1077#1075#1086' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090
        Title.Orientation = tohVertical
        Width = 32
      end
      item
        EditButtons = <>
        FieldName = 'AYear'
        Footers = <
          item
            FieldName = 'AYear'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        Title.Hint = #1043#1086#1076' '#1074#1074#1086#1076#1072' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072' '#1074' '#1101#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1102
        Title.Orientation = tohVertical
        Width = 32
      end
      item
        EditButtons = <>
        FieldName = 'WorkState'
        Footers = <
          item
            FieldName = 'WorkState'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 24
        MinWidth = 24
        Title.Hint = #1056#1072#1073#1086#1095#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
        Title.Orientation = tohVertical
        Width = 24
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'EngineNetNkvt'
        Footers = <
          item
            FieldName = 'EngineNetNkvt'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 40
        MinWidth = 40
        ReadOnly = True
        Title.Caption = #1044#1074#1080#1075#1072#1090#1077#1083#1100'|N, '#1082#1042#1090'|'#1085#1086#1084#1080#1085'.'
        Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1072#1103' '#1084#1086#1097#1085#1086#1089#1090#1100' '#1076#1074#1080#1075#1072#1090#1077#1083#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1082#1042#1090
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'EngineKPD'
        Footers = <
          item
            FieldName = 'EngineKPD'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        Title.Caption = #1044#1074#1080#1075#1072#1090#1077#1083#1100'|'#1050#1055#1044'|'#1092#1072#1082#1090'.'
        Title.Hint = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081' '#1050#1055#1044' '#1076#1074#1080#1075#1072#1090#1077#1083#1103' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
        Width = 32
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'TransmissionKind'
        Footers = <
          item
            FieldName = 'TransmissionKind'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        ReadOnly = True
        Title.Caption = #1058#1088#1072#1085#1089#1084#1080#1089#1089#1080#1103'|'#1058#1080#1087
        Title.Hint = #1058#1080#1087' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
        Width = 32
      end
      item
        Color = 15790320
        EditButtons = <>
        FieldName = 'TransmissionNetKPD'
        Footers = <
          item
            FieldName = 'TransmissionNetKPD'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        ReadOnly = True
        Title.Caption = #1058#1088#1072#1085#1089#1084#1080#1089#1089#1080#1103'|'#1050#1055#1044'|'#1085#1086#1084#1080#1085'.'
        Title.Hint = #1053#1086#1084#1080#1085#1072#1083#1100#1085#1099#1081' '#1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
        Width = 32
      end
      item
        EditButtons = <>
        FieldName = 'TransmissionKPD'
        Footers = <
          item
            FieldName = 'TransmissionKPD'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 32
        MinWidth = 32
        Title.Caption = #1058#1088#1072#1085#1089#1084#1080#1089#1089#1080#1103'|'#1050#1055#1044'|'#1092#1072#1082#1090'.'
        Title.Hint = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081' '#1050#1055#1044' '#1090#1088#1072#1085#1089#1084#1080#1089#1089#1080#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072
        Width = 32
      end
      item
        EditButtons = <>
        FieldName = 'TyreCost'
        Footers = <
          item
            FieldName = 'TyreCost'
            ValueType = fvtFieldValue
          end>
        MinWidth = 64
        Title.Caption = #1064#1080#1085#1099'|C, '#1090#1099#1089'.'#1090#1075
        Title.Hint = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1076#1085#1086#1081' '#1096#1080#1085#1099' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090#1099#1089'.'#1090#1075
      end
      item
        EditButtons = <>
        FieldName = 'TyresRaceRate'
        Footers = <
          item
            FieldName = 'TyresRaceRate'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 40
        MinWidth = 40
        Title.Caption = #1064#1080#1085#1099'|'#1055#1088#1086#1073#1077#1075' '#1096#1080#1085', '#1090#1099#1089'. '#1082#1084
        Title.Hint = #1053#1086#1088#1084#1072' '#1087#1088#1086#1073#1077#1075#1072' '#1096#1080#1085' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090#1099#1089'.'#1082#1084
        Width = 40
      end
      item
        EditButtons = <>
        FieldName = 'Cost'
        Footers = <
          item
            FieldName = 'Cost'
            ValueType = fvtFieldValue
          end>
        MinWidth = 64
        Title.Caption = #1041#1072#1083#1072#1085#1089#1086#1074#1072#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1100', '#1090#1099#1089'.'#1090#1075
        Title.Hint = #1041#1072#1083#1072#1085#1089#1086#1074#1072#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072', '#1090#1099#1089'.'#1090#1075
      end
      item
        EditButtons = <>
        FieldName = 'AmortizationKind'
        Footers = <>
        MaxWidth = 56
        MinWidth = 56
        PickList.Strings = (
          #1043#1086#1076#1086#1074#1072#1103' '#1085#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
          #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080' '#1085#1072' '#1090#1099#1089'.'#1082#1084)
        Title.Caption = #1040#1084#1086#1088#1090#1080#1079#1072#1094#1080#1103'|'#1058#1080#1087
        Title.Hint = 
          #1058#1080#1087' '#1088#1072#1089#1095#1077#1090#1072' '#1085#1086#1088#1084#1099' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080': 0-'#1087#1086' '#1074#1088#1077#1084#1077#1085#1080' ('#1075#1086#1076#1086#1074#1072#1103'), 1-'#1087#1086' '#1087#1088#1086#1073 +
          #1077#1075#1091' ('#1085#1072' '#1090#1099#1089'.'#1082#1084')'
        Width = 56
      end
      item
        EditButtons = <>
        FieldName = 'AmortizationRate'
        Footers = <
          item
            FieldName = 'AmortizationRate'
            ValueType = fvtFieldValue
          end>
        MaxWidth = 40
        MinWidth = 40
        Title.Caption = #1040#1084#1086#1088#1090#1080#1079#1072#1094#1080#1103'|R '#1072#1084#1086#1088#1090'.'
        Title.Hint = #1053#1086#1088#1084#1072' '#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072': '#1075#1086#1076#1086#1074#1072#1103'/'#1085#1072' 1000 '#1082#1084
        Width = 40
        WordWrap = True
      end>
  end
  object pmAutos: TPopupMenu
    OnPopup = pmAutosPopup
    Left = 280
    Top = 176
    object pmiAutosAdd: TMenuItem
      Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16449
      OnClick = pmiAutosAddClick
    end
    object pmiAutosEdit: TMenuItem
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 16453
      OnClick = pmiAutosEditClick
    end
    object pmiAutosDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16452
      OnClick = pmiAutosDeleteClick
    end
    object pmiAutosDeleteAll: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' &'#1074#1089#1077
      OnClick = pmiAutosDeleteAllClick
    end
    object pmiAutosSep1: TMenuItem
      Caption = '-'
    end
    object pmiAutosClone: TMenuItem
      Caption = #1050#1083#1086#1085#1080#1088#1086#1074#1072#1090#1100
      ShortCut = 16459
      OnClick = pmiAutosCloneClick
    end
    object pmiAutosSep2: TMenuItem
      Caption = '-'
    end
    object pmiAutosUp: TMenuItem
      Caption = #1042#1074#1077#1088'&'#1093
      ShortCut = 8277
      OnClick = pmiAutosUpClick
    end
    object pmiAutosDown: TMenuItem
      Caption = #1042#1085#1080'&'#1079
      ShortCut = 8260
      OnClick = pmiAutosDownClick
    end
    object pmiAutosSep3: TMenuItem
      Caption = '-'
    end
    object pmiAutosDefault: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' &'#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnClick = pmiAutosDefaultClick
    end
    object pmiAutosDefaults: TMenuItem
      Caption = '&'#1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102'...'
      OnClick = pmiAutosDefaultsClick
    end
    object pmiSep4: TMenuItem
      Caption = '-'
    end
    object pmiAutosExcel: TMenuItem
      Caption = #1074' E&xcel'
      ShortCut = 16464
      OnClick = pmiAutosExcelClick
    end
    object pmiSep5: TMenuItem
      Caption = '-'
    end
    object pmiAutosExport: TMenuItem
      Caption = #1069#1082#1087#1086#1088#1090'..'
      OnClick = pmiAutosExportClick
    end
    object pmiAutosImport: TMenuItem
      Caption = #1048#1084#1087#1086#1088#1090'..'
      OnClick = pmiAutosImportClick
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.oda'
    Filter = #1057#1087#1080#1089#1086#1095#1085#1099#1081' '#1087#1072#1088#1082' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' Openpit DeportAutos (*.oda)|*.oda'
    Left = 176
    Top = 160
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.oda'
    Filter = #1057#1087#1080#1089#1086#1095#1085#1099#1081' '#1087#1072#1088#1082' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' Openpit DeportAutos (*.oda)|*.oda'
    Left = 176
    Top = 216
  end
end
