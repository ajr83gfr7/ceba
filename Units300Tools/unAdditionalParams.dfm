object fmAdditionalParams: TfmAdditionalParams
  Left = 347
  Top = 150
  Width = 997
  Height = 593
  HelpType = htKeyword
  HelpKeyword = 'AddParams'
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
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
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object pnBtns: TPanel
    Left = 0
    Top = 498
    Width = 979
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      979
      50)
    object btClose: TButton
      Left = 1007
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
      Caption = #1074' Excel...'
      TabOrder = 0
      OnClick = btExcelClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 979
    Height = 498
    ActivePage = tsTotal
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object tsTotal: TTabSheet
      Caption = '&'#1054#1073#1097#1080#1077
      DesignSize = (
        971
        467)
      object lbTotalKurs: TLabel
        Left = 39
        Top = 20
        Width = 137
        Height = 16
        Caption = #1050#1091#1088#1089' &'#1076#1086#1083#1083#1072#1088#1072', '#1090#1077#1085#1075#1077
        FocusControl = dbedTotalKurs
      end
      object lbTotalExpenses: TLabel
        Left = 39
        Top = 49
        Width = 408
        Height = 16
        Caption = #1042#1077#1083#1080#1095#1080#1085#1072' '#1087#1086#1089#1090#1086#1103#1085#1085#1099#1093' '#1080' '#1085#1077#1095#1090#1077#1085#1085#1099#1093' &'#1088#1072#1089#1093#1086#1076#1086#1074', '#1090#1099#1089'.'#1090#1077#1085#1075#1077'/'#1075#1086#1076
        FocusControl = dbedTotalExpenses
      end
      object lbTotalSalaryCoef: TLabel
        Left = 39
        Top = 79
        Width = 430
        Height = 16
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1091#1095#1077#1090#1072' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1081' '#1080#1079' '#1092#1086#1085#1076#1072' &'#1079#1072#1088#1072#1073#1086#1090#1085#1086#1081' '#1087#1083#1072#1090#1099
        FocusControl = dbedTotalSalaryCoef
      end
      object gbTotalShiftUsingCoef: TGroupBox
        Left = 20
        Top = 167
        Width = 1076
        Height = 390
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1084#1077#1085#1099
        TabOrder = 3
        DesignSize = (
          1076
          390)
        object lbTotalShiftUsingCoefNormal: TLabel
          Left = 20
          Top = 30
          Width = 159
          Height = 16
          Caption = #1042' &'#1085#1086#1088#1084#1072#1083#1100#1085#1099#1093' '#1091#1089#1083#1086#1074#1080#1103#1093
          FocusControl = dbedTotalShiftUsingCoefNormal
        end
        object lbTotalShiftUsingCoefExplosion: TLabel
          Left = 20
          Top = 89
          Width = 259
          Height = 16
          Caption = #1042' '#1076#1077#1085#1100' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072' &'#1074#1079#1088#1099#1074#1085#1099#1093' '#1088#1072#1073#1086#1090
          FocusControl = dbedTotalShiftUsingCoefExplosion
        end
        object lbTotalShiftUsingCoefExplosionCount: TLabel
          Left = 20
          Top = 148
          Width = 207
          Height = 16
          Caption = '&'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074#1079#1088#1099#1074#1086#1074' '#1074' '#1085#1077#1076#1077#1083#1102
          FocusControl = dbedTotalShiftUsingCoefExplosionCount
        end
        object bvTotal: TBevel
          Left = 20
          Top = 130
          Width = 1038
          Height = 7
          Anchors = [akLeft, akTop, akRight]
          Shape = bsTopLine
        end
        object lbTotalShiftUsingCoefDayShift: TLabel
          Left = 20
          Top = 59
          Width = 95
          Height = 16
          Caption = '&'#1044#1085#1077#1074#1085#1099#1093' '#1089#1084#1077#1085
          FocusControl = dbedTotalShiftUsingCoefDayShift
        end
        object dbedTotalShiftUsingCoefNormal: TDBEdit
          Left = 565
          Top = 30
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'TotalShiftUsingCoefNormal'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedTotalShiftUsingCoefDayShift: TDBEdit
          Left = 565
          Top = 59
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'TotalShiftUsingCoefDayShift'
          DataSource = fmDM.dsOpenpits
          TabOrder = 1
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedTotalShiftUsingCoefExplosion: TDBEdit
          Left = 565
          Top = 89
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'TotalShiftUsingCoefExplosion'
          DataSource = fmDM.dsOpenpits
          TabOrder = 2
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedTotalShiftUsingCoefExplosionCount: TDBEdit
          Left = 565
          Top = 148
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'TotalShiftUsingCoefExplosionCount'
          DataSource = fmDM.dsOpenpits
          TabOrder = 3
        end
      end
      object dbedTotalKurs: TDBEdit
        Left = 577
        Top = 20
        Width = 147
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'TotalKurs'
        DataSource = fmDM.dsOpenpits
        TabOrder = 0
        OnKeyPress = dbedTotalKursKeyPress
      end
      object dbedTotalExpenses: TDBEdit
        Left = 577
        Top = 49
        Width = 149
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'TotalExpenses'
        DataSource = fmDM.dsOpenpits
        TabOrder = 1
        OnKeyPress = dbedTotalKursKeyPress
      end
      object dbedTotalSalaryCoef: TDBEdit
        Left = 577
        Top = 79
        Width = 147
        Height = 24
        Anchors = [akTop, akRight]
        DataField = 'TotalSalaryCoef'
        DataSource = fmDM.dsOpenpits
        TabOrder = 2
        OnKeyPress = dbedTotalKursKeyPress
      end
    end
    object tsExcavs: TTabSheet
      Caption = #1055#1086' &'#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1072#1084
      ImageIndex = 1
      DesignSize = (
        971
        467)
      object gbExcavsSalary: TGroupBox
        Left = 20
        Top = 20
        Width = 1076
        Height = 108
        Anchors = [akLeft, akTop, akRight]
        Caption = #1054#1087#1083#1072#1090#1072' '#1090#1088#1091#1076#1072' ('#1074' '#1084#1077#1089#1103#1094')'
        TabOrder = 0
        DesignSize = (
          1076
          108)
        object lbExcavsSalaryMashinist: TLabel
          Left = 20
          Top = 30
          Width = 156
          Height = 16
          Caption = '&'#1052#1072#1096#1080#1085#1080#1089#1090#1072', '#1090#1099#1089'.'#1090#1077#1085#1075#1077
          FocusControl = dbedExcavsSalaryMashinist0
        end
        object lbExcavsSalaryAssistant: TLabel
          Left = 20
          Top = 59
          Width = 239
          Height = 16
          Caption = '&'#1055#1086#1084#1086#1097#1085#1080#1082#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072', '#1090#1099#1089'.'#1090#1077#1085#1075#1077
          FocusControl = dbedExcavsSalaryAssistant0
        end
        object lbExcavsSalaryPlus0: TLabel
          Left = 767
          Top = 30
          Width = 14
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '+'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -23
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbExcavsSalaryPlus1: TLabel
          Left = 767
          Top = 57
          Width = 14
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '+'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -23
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dbedExcavsSalaryMashinist0: TDBEdit
          Left = 614
          Top = 30
          Width = 147
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsSalaryMashinist0'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedExcavsSalaryMashinist1: TDBEdit
          Left = 789
          Top = 30
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsSalaryMashinist1'
          DataSource = fmDM.dsOpenpits
          TabOrder = 1
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedExcavsSalaryAssistant0: TDBEdit
          Left = 612
          Top = 59
          Width = 147
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsSalaryAssistant0'
          DataSource = fmDM.dsOpenpits
          TabOrder = 2
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedExcavsSalaryAssistant1: TDBEdit
          Left = 789
          Top = 59
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsSalaryAssistant1'
          DataSource = fmDM.dsOpenpits
          TabOrder = 3
          OnKeyPress = dbedTotalKursKeyPress
        end
      end
      object gbExcavsWorkRezim: TGroupBox
        Left = 20
        Top = 138
        Width = 1076
        Height = 138
        Anchors = [akLeft, akTop, akRight]
        Caption = #1056#1077#1078#1080#1084' '#1088#1072#1073#1086#1090#1099
        TabOrder = 1
        DesignSize = (
          1076
          138)
        object lbExcavsWorkRezimWorkShiftsCount: TLabel
          Left = 20
          Top = 30
          Width = 232
          Height = 16
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' &'#1088#1072#1073#1086#1095#1080#1093' '#1089#1084#1077#1085' '#1074' '#1084#1077#1089#1103#1094
          FocusControl = dbedExcavsWorkRezimWorkShiftsCount
        end
        object lbExcavsWorkRezimWorkShiftDuration: TLabel
          Left = 20
          Top = 59
          Width = 280
          Height = 16
          Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' &'#1089#1084#1077#1085#1099', '#1095#1072#1089
          FocusControl = dbedExcavsWorkRezimWorkShiftDuration
        end
        object lbExcavsShiftTurnoverTime: TLabel
          Left = 20
          Top = 89
          Width = 163
          Height = 16
          Caption = #1042#1088#1077#1084#1103' &'#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
          FocusControl = dbedExcavsShiftTurnoverTime
        end
        object dbedExcavsWorkRezimWorkShiftsCount: TDBEdit
          Left = 789
          Top = 30
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsWorkShiftsCount'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
        end
        object dbedExcavsWorkRezimWorkShiftDuration: TDBEdit
          Left = 789
          Top = 59
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsWorkShiftDuration'
          DataSource = fmDM.dsOpenpits
          TabOrder = 1
        end
        object dbedExcavsShiftTurnoverTime: TDBEdit
          Left = 789
          Top = 89
          Width = 148
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsShiftTurnoverTime'
          DataSource = fmDM.dsOpenpits
          TabOrder = 2
          OnKeyPress = dbedTotalKursKeyPress
        end
      end
      object gbExcavsEnergyCost: TGroupBox
        Left = 20
        Top = 294
        Width = 727
        Height = 163
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' 1 &'#1082#1042#1090'*'#1095#1072#1089' '#1101#1083#1077#1082#1090#1088#1086#1101#1085#1077#1088#1075#1080#1080', '#1090#1077#1085#1075#1077
        TabOrder = 2
        DesignSize = (
          727
          163)
        object dbedExcavsEnergyCost: TDBEdit
          Left = 555
          Top = 30
          Width = 147
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsEnergyCost'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
          OnKeyPress = dbedTotalKursKeyPress
        end
      end
      object gbExcavsAmortazationNorm: TGroupBox
        Left = 758
        Top = 294
        Width = 227
        Height = 163
        Anchors = [akTop, akRight, akBottom]
        Caption = #1053#1086#1088#1084#1072' &'#1072#1084#1086#1088#1090#1080#1079#1072#1094#1080#1080
        TabOrder = 3
        DesignSize = (
          227
          163)
        object dbedExcavsAmortazationNorm: TDBEdit
          Left = 31
          Top = 30
          Width = 147
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'ExcavsAmortazationNorm'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
          OnKeyPress = dbedTotalKursKeyPress
        end
      end
    end
    object tsAutos: TTabSheet
      Caption = #1055#1086' &'#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1072#1084
      ImageIndex = 2
      DesignSize = (
        971
        467)
      object gbAutosSalary: TGroupBox
        Left = 10
        Top = 10
        Width = 266
        Height = 118
        Caption = #1054#1087#1083#1072#1090#1072' '#1090#1088#1091#1076#1072' '#1074#1086#1076#1080#1090#1077#1083#1103', '#1090#1099#1089'.'#1090#1085'/'#1084#1077#1089'.'
        TabOrder = 0
        DesignSize = (
          266
          118)
        object lbAutosSalary: TLabel
          Left = 10
          Top = 30
          Width = 65
          Height = 16
          Caption = #1054#1089#1085'&'#1086#1074#1085#1072#1103
          FocusControl = dbedAutosSalary0
        end
        object lbAutosSalaryPlus: TLabel
          Left = 10
          Top = 59
          Width = 116
          Height = 16
          Caption = '&'#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103
          FocusControl = dbedAutosSalary1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dbedAutosSalary0: TDBEdit
          Left = 138
          Top = 30
          Width = 108
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'AutosSalary0'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedAutosSalary1: TDBEdit
          Left = 138
          Top = 59
          Width = 108
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'AutosSalary1'
          DataSource = fmDM.dsOpenpits
          TabOrder = 1
          OnKeyPress = dbedTotalKursKeyPress
        end
      end
      object gbAutosWorkRezim: TGroupBox
        Left = 286
        Top = 10
        Width = 820
        Height = 118
        Anchors = [akLeft, akTop, akRight]
        Caption = #1056#1077#1078#1080#1084' '#1088#1072#1073#1086#1090#1099
        TabOrder = 1
        DesignSize = (
          820
          118)
        object lbAutosWorkRezimWorkShiftsCount: TLabel
          Left = 20
          Top = 20
          Width = 232
          Height = 16
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' &'#1088#1072#1073#1086#1095#1080#1093' '#1089#1084#1077#1085' '#1074' '#1084#1077#1089#1103#1094
          FocusControl = dbedAutosWorkRezimWorkShiftsCount
        end
        object lbAutosWorkRezimWorkShiftDuration: TLabel
          Left = 20
          Top = 49
          Width = 280
          Height = 16
          Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' &'#1089#1084#1077#1085#1099', '#1095#1072#1089
          FocusControl = dbedAutosWorkRezimWorkShiftDuration
        end
        object lbAutosShiftTurnoverTime: TLabel
          Left = 20
          Top = 79
          Width = 163
          Height = 16
          Caption = #1042#1088#1077#1084#1103' &'#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
          FocusControl = dbedAutosShiftTurnoverTime
        end
        object dbedAutosWorkRezimWorkShiftsCount: TDBEdit
          Left = 692
          Top = 20
          Width = 109
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'AutosWorkShiftsCount'
          DataSource = fmDM.dsOpenpits
          TabOrder = 0
        end
        object dbedAutosWorkRezimWorkShiftDuration: TDBEdit
          Left = 692
          Top = 49
          Width = 109
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'AutosWorkShiftDuration'
          DataSource = fmDM.dsOpenpits
          TabOrder = 1
          OnKeyPress = dbedTotalKursKeyPress
        end
        object dbedAutosShiftTurnoverTime: TDBEdit
          Left = 692
          Top = 79
          Width = 109
          Height = 24
          Anchors = [akTop, akRight]
          DataField = 'AutosShiftTurnoverTime'
          DataSource = fmDM.dsOpenpits
          TabOrder = 2
        end
      end
      object pcAutos: TPageControl
        Left = 0
        Top = 37
        Width = 971
        Height = 430
        ActivePage = tsAutosOtherAccounts
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 2
        object tsAutosFuel: TTabSheet
          Caption = #1047#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086
          DesignSize = (
            963
            399)
          object lbAutosWinterMonthCount: TLabel
            Left = 20
            Top = 118
            Width = 242
            Height = 16
            Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1080#1084#1085#1080#1093' '#1084#1077#1089#1103#1094#1077#1074' '#1074' '#1075#1086#1076#1091
            FocusControl = dbedAutosWinterMonthCount
          end
          object lbAutosFuelCostTarif: TLabel
            Left = 20
            Top = 148
            Width = 233
            Height = 16
            Caption = #1059#1095#1077#1090' '#1090#1072#1088#1080#1092#1072' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1090#1086#1087#1083#1080#1074#1072
            FocusControl = dbcbAutosFuelCostTarif
          end
          object gbAutosFuelCost: TGroupBox
            Left = 20
            Top = 20
            Width = 1066
            Height = 78
            Anchors = [akLeft, akTop, akRight]
            Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1080#1079#1077#1083#1100#1085#1086#1075#1086' '#1090#1086#1087#1083#1080#1074#1072', '#1090#1077#1085#1075#1077'/'#1083#1080#1090#1088
            TabOrder = 0
            DesignSize = (
              1066
              78)
            object lbAutosFuelCostWinter: TLabel
              Left = 20
              Top = 30
              Width = 62
              Height = 16
              Caption = '"&'#1047#1080#1084#1085#1077#1077'"'
              FocusControl = dbedAutosFuelCostWinter
            end
            object lbAutosFuelCostSummer: TLabel
              Left = 811
              Top = 30
              Width = 61
              Height = 16
              Anchors = [akTop, akRight]
              Caption = '"&'#1051#1077#1090#1085#1077#1077'"'
              FocusControl = dbedAutosFuelCostSummer
            end
            object dbedAutosFuelCostWinter: TDBEdit
              Left = 108
              Top = 30
              Width = 148
              Height = 21
              DataField = 'AutosFuelCostWinter'
              DataSource = fmDM.dsOpenpits
              TabOrder = 0
            end
            object dbedAutosFuelCostSummer: TDBEdit
              Left = 899
              Top = 30
              Width = 148
              Height = 21
              Anchors = [akTop, akRight]
              DataField = 'AutosFuelCostSummer'
              DataSource = fmDM.dsOpenpits
              TabOrder = 1
            end
          end
          object dbedAutosWinterMonthCount: TDBEdit
            Left = 909
            Top = 118
            Width = 177
            Height = 21
            Anchors = [akTop, akRight]
            DataField = 'AutosWinterMonthCount'
            DataSource = fmDM.dsOpenpits
            TabOrder = 1
          end
          object dbcbAutosFuelCostTarif: TDBComboBox
            Left = 909
            Top = 148
            Width = 177
            Height = 24
            Style = csDropDownList
            Anchors = [akTop, akRight]
            DataField = 'AutosFuelCostTarif'
            DataSource = fmDM.dsOpenpits
            DropDownCount = 3
            ItemHeight = 16
            Items.Strings = (
              #1087#1086' '#1079#1080#1084#1085#1077#1084#1091' '#1090#1072#1088#1080#1092#1091
              #1087#1086' '#1083#1077#1090#1085#1077#1084#1091' '#1090#1072#1088#1080#1092#1091
              #1087#1086' '#1089#1088#1077#1076#1085#1077#1084#1091' '#1079#1085#1072#1095#1077#1085#1080#1102)
            TabOrder = 2
          end
        end
        object tsAutosOtherAccounts: TTabSheet
          Caption = #1055#1088#1086#1095#1080#1077' '#1079#1072#1090#1088#1072#1090#1099' '#1087#1086' '#1084#1086#1076#1077#1083#1103#1084' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
          ImageIndex = 1
          object pbAutos: TPaintBox
            Left = 0
            Top = 0
            Width = 963
            Height = 110
            Align = alTop
            OnPaint = pbAutosPaint
          end
          object dbgAutos: TDBGrid
            Left = 0
            Top = 110
            Width = 963
            Height = 289
            Align = alClient
            DataSource = fmDM.dsAutoOtherAccounts
            DefaultDrawing = False
            Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines]
            PopupMenu = pmAutos
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDrawColumnCell = dbgAutosDrawColumnCell
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
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Spares'
                Width = 88
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'GreasingSubstance'
                Width = 88
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MaintenanceCost'
                Width = 88
                Visible = True
              end>
          end
        end
      end
    end
    object tsRoads: TTabSheet
      Caption = #1055#1086' '#1072#1074#1090#1086'&'#1090#1088#1072#1089#1089#1077
      ImageIndex = 3
      object pbRoads: TPaintBox
        Left = 0
        Top = 0
        Width = 971
        Height = 89
        Align = alTop
        OnPaint = pbRoadsPaint
      end
      object dbgRoads: TDBGrid
        Left = 0
        Top = 89
        Width = 971
        Height = 378
        Align = alClient
        DataSource = fmDM.dsRoadOtherAccounts
        DefaultDrawing = False
        PopupMenu = pmRoads
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = dbgAutosDrawColumnCell
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
            FieldName = 'RoadCoat'
            ReadOnly = True
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BuildingCosts'
            Width = 97
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AmortizationNorm'
            Width = 94
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'KeepingCosts'
            Width = 85
            Visible = True
          end>
      end
    end
    object tsWorkRegime: TTabSheet
      Caption = #1056#1077#1078#1080#1084' '#1088#1072#1073#1086#1090#1099' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      ImageIndex = 4
      DesignSize = (
        971
        467)
      object dbrgAutosWorkRegime: TDBRadioGroup
        Left = 10
        Top = 10
        Width = 1096
        Height = 108
        Anchors = [akLeft, akTop, akRight]
        Caption = 
          #1055#1088#1080#1079#1085#1072#1082' &'#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1087#1086#1088#1086#1078#1085#1080#1093' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' '#1087#1088#1080' '#1086#1090#1082#1088#1099#1090#1086#1084' '#1094#1080#1082#1083 +
          #1077' '#1088#1072#1073#1086#1090#1099
        DataField = 'WorkRegimeKind'
        DataSource = fmDM.dsOpenpits
        Items.Strings = (
          #1059#1089#1088#1077#1076#1085#1077#1085#1080#1077' '#1082#1072#1095#1077#1089#1090#1074#1072
          #1056#1072#1074#1085#1086#1084#1077#1088#1085#1086#1077' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1086' '#1087#1091#1085#1082#1090#1072#1084' '#1087#1086#1075#1088#1091#1079#1082#1080)
        TabOrder = 2
      end
      object gbAccording: TGroupBox
        Left = 10
        Top = 128
        Width = 1096
        Height = 419
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = #1057#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1077' '#1090#1080#1087#1086#1074' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074' '#1090#1080#1087#1072#1084' '#1101#1082#1089#1082#1072#1074#1072#1090#1086#1088#1086#1074
        TabOrder = 0
        DesignSize = (
          1096
          419)
        object lbAutos: TLabel
          Left = 20
          Top = 30
          Width = 109
          Height = 16
          Caption = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099
        end
        object lbExcavs: TLabel
          Left = 187
          Top = 30
          Width = 90
          Height = 16
          Caption = #1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
        end
        object lbAccording: TLabel
          Left = 463
          Top = 30
          Width = 209
          Height = 16
          Caption = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1099' - '#1069#1082#1089#1082#1072#1074#1072#1090#1086#1088#1099
        end
        object lsbAutos: TListBox
          Left = 20
          Top = 49
          Width = 147
          Height = 158
          DragMode = dmAutomatic
          ItemHeight = 16
          TabOrder = 0
          OnDragDrop = lsbAutosDragDrop
          OnDragOver = lsbAutosDragOver
          OnEnter = lsbAutosEnter
        end
        object lsbExcavs: TListBox
          Left = 187
          Top = 49
          Width = 148
          Height = 158
          DragMode = dmAutomatic
          ItemHeight = 16
          TabOrder = 1
          OnDragDrop = lsbExcavsDragDrop
          OnDragOver = lsbExcavsDragOver
          OnEnter = lsbAutosEnter
        end
        object btAdd: TButton
          Left = 354
          Top = 59
          Width = 89
          Height = 31
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 2
          OnClick = btAddClick
        end
        object btDelete: TButton
          Left = 354
          Top = 98
          Width = 89
          Height = 31
          Caption = #1059#1076#1072#1083#1080#1090#1100
          TabOrder = 3
          OnClick = btDeleteClick
        end
        object dbllbAutoExcavAccordances: TDBLookupListBox
          Left = 463
          Top = 49
          Width = 613
          Height = 132
          Anchors = [akLeft, akTop, akRight]
          KeyField = 'Id_AutoExcavAccordance'
          ListField = 'TotalName'
          ListSource = fmDM.dsAutoExcavAccordances
          TabOrder = 4
        end
        object btDeleteAll: TButton
          Left = 354
          Top = 138
          Width = 89
          Height = 31
          Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077
          TabOrder = 5
          OnClick = btDeleteAllClick
        end
      end
      object dbcbIsStrippingCoefUsing: TDBCheckBox
        Left = 830
        Top = 39
        Width = 246
        Height = 21
        Anchors = [akTop, akRight]
        Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1074#1089#1082#1088#1099#1096#1080
        DataField = 'WorkRegimeIsStrippingCoefUsing'
        DataSource = fmDM.dsOpenpits
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
  end
  object pmAutos: TPopupMenu
    OnPopup = pmAutosPopup
    Left = 192
    Top = 232
    object pmiAutosDefault: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnClick = pmiAutosDefaultClick
    end
    object pmiAutosSep1: TMenuItem
      Caption = '-'
    end
    object pmiAutosExcel: TMenuItem
      Caption = #1074' Excel'
      OnClick = pmiAutosExcelClick
    end
    object pmiAutosSep2: TMenuItem
      Caption = '-'
    end
    object pmiAutosPrint: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1100'...'
      OnClick = pmiAutosPrintClick
    end
  end
  object pmRoads: TPopupMenu
    OnPopup = pmRoadsPopup
    Left = 376
    Top = 232
    object pmiRoadsDefault: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnClick = pmiRoadsDefaultClick
    end
    object pmiRoadsSep1: TMenuItem
      Caption = '-'
    end
    object pmiRoadsExcel: TMenuItem
      Caption = #1074' Excel'
      OnClick = pmiRoadsExcelClick
    end
    object pmiRoadsSep2: TMenuItem
      Caption = '-'
    end
    object pmiRoadsPrint: TMenuItem
      Caption = #1055#1077#1095#1072#1090#1100'...'
      OnClick = pmiRoadsPrintClick
    end
  end
end
