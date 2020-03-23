object fmResultShiftUnLoadingPunkts: TfmResultShiftUnLoadingPunkts
  Left = 222
  Top = 66
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103' '#1087#1086' '#1087#1091#1085#1082#1090#1072#1084' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnClient: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 522
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl: TPageControl
      Left = 0
      Top = 120
      Width = 784
      Height = 402
      ActivePage = tsEvents
      Align = alClient
      TabOrder = 0
      object tsEvents: TTabSheet
        Caption = #1057#1086#1073#1099#1090#1080#1103
        object dbgUnloadingPunktEvents: TDBGridEh
          Left = 0
          Top = 0
          Width = 776
          Height = 374
          Align = alClient
          DataSource = dsResultShiftUnloadingPunktEvents
          DefaultDrawing = False
          Flat = False
          FooterColor = clYellow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          MinAutoFitWidth = 30
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = dbgUnloadingPunktEventsDrawColumnCell
          Columns = <
            item
              EditButtons = <>
              FieldName = 'Kind'
              Footers = <>
              MaxWidth = 80
              MinWidth = 80
              Title.Orientation = tohVertical
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'Tmin'
              Footers = <>
              MaxWidth = 64
              MinWidth = 64
              Title.Orientation = tohVertical
            end
            item
              EditButtons = <>
              FieldName = 'Rock'
              Footers = <>
              MinWidth = 120
              Title.Orientation = tohVertical
              Width = 120
            end
            item
              EditButtons = <>
              FieldName = 'RockIsMineralWealth'
              Footers = <>
              MaxWidth = 64
              MinWidth = 64
              Title.Orientation = tohVertical
            end
            item
              EditButtons = <>
              FieldName = 'RockVm3'
              Footers = <>
              MaxWidth = 120
              MinWidth = 80
              Title.Orientation = tohVertical
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'RockQtn'
              Footers = <>
              MaxWidth = 120
              MinWidth = 80
              Title.Orientation = tohVertical
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'DumpModel'
              Footers = <>
              MinWidth = 120
              Title.Orientation = tohVertical
              Width = 120
            end
            item
              EditButtons = <>
              FieldName = 'DumpNo'
              Footers = <>
              MaxWidth = 64
              MinWidth = 64
              Title.Orientation = tohVertical
            end>
        end
      end
      object tsRocks: TTabSheet
        Caption = #1043#1086#1088#1085#1099#1077' '#1087#1086#1088#1086#1076#1099
        ImageIndex = 1
        object dbgResultShiftUnloadingPunktRocks: TDBGridEh
          Left = 0
          Top = 0
          Width = 776
          Height = 374
          Align = alClient
          DataSource = dsResultShiftUnloadingPunktRocks
          Flat = False
          FooterColor = clYellow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -11
          FooterFont.Name = 'MS Sans Serif'
          FooterFont.Style = []
          MinAutoFitWidth = 30
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              EditButtons = <>
              FieldName = 'Rock'
              Footers = <>
              MinWidth = 120
              Width = 120
            end
            item
              EditButtons = <>
              FieldName = 'RockIsMineralWealth'
              Footers = <>
              MaxWidth = 80
              MinWidth = 80
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'UnloadingAutosCount'
              Footers = <>
              MaxWidth = 96
              MinWidth = 96
              Width = 96
            end
            item
              EditButtons = <>
              FieldName = 'RockVm3'
              Footers = <>
              MaxWidth = 120
              MinWidth = 80
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'RockQtn'
              Footers = <>
              MaxWidth = 120
              MinWidth = 80
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'Content'
              Footers = <>
              MaxWidth = 80
              MinWidth = 80
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'DContent'
              Footers = <>
              MaxWidth = 80
              MinWidth = 80
              Width = 80
            end>
        end
      end
    end
    object dbgUnloadingPunkts: TDBGridEh
      Left = 0
      Top = 0
      Width = 784
      Height = 120
      Align = alTop
      DataSource = dsResultShiftUnloadingPunkts
      Flat = False
      FooterColor = clYellow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      MinAutoFitWidth = 30
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          EditButtons = <>
          FieldName = 'Id_ResultShiftUnloadingPunkt'
          Footers = <>
          MaxWidth = 40
          MinWidth = 40
          Title.Caption = #1055#1091#1085#1082#1090' '#1088#1072#1079#1075#1088#1091#1079#1082#1080'|'#1050#1086#1076
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'Kind'
          Footers = <>
          MinWidth = 56
          Title.Caption = #1055#1091#1085#1082#1090' '#1088#1072#1079#1075#1088#1091#1079#1082#1080'|'#1058#1080#1087
          Width = 189
        end
        item
          EditButtons = <>
          FieldName = 'Horizont'
          Footers = <>
          MaxWidth = 64
          MinWidth = 64
          Title.Caption = #1055#1091#1085#1082#1090' '#1088#1072#1079#1075#1088#1091#1079#1082#1080'|'#1043#1086#1088#1080#1079#1086#1085#1090', '#1084
        end
        item
          EditButtons = <>
          FieldName = 'UnloadingAutosCount'
          Footers = <>
          MaxWidth = 96
          MinWidth = 96
          Width = 96
        end
        item
          EditButtons = <>
          FieldName = 'RockVm3'
          Footers = <>
          MaxWidth = 120
          MinWidth = 80
          Title.Caption = #1056#1072#1079#1075#1088#1091#1078#1077#1085#1085#1072#1103' '#1075#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1054#1073#1098#1077#1084' V, '#1084'3'
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'RockQtn'
          Footers = <>
          MaxWidth = 120
          MinWidth = 80
          Title.Caption = #1056#1072#1079#1075#1088#1091#1078#1077#1085#1085#1072#1103' '#1075#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1042#1077#1089' Q, '#1090
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'UsingTmin'
          Footers = <>
          MaxWidth = 64
          MinWidth = 64
        end
        item
          EditButtons = <>
          FieldName = 'UsingCoef'
          Footers = <>
          MaxWidth = 72
          MinWidth = 72
          Width = 72
        end
        item
          EditButtons = <>
          FieldName = 'BunkerRatio'
          Footers = <>
          MaxWidth = 80
          MinWidth = 80
          Width = 80
        end>
    end
  end
  object pnBtns: TPanel
    Left = 0
    Top = 522
    Width = 784
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      784
      40)
    object btClose: TButton
      Left = 704
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btExcel: TButton
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Caption = #1074' Excel'
      TabOrder = 2
      Visible = False
      OnClick = btExcelClick
    end
    object btShift: TButton
      Left = 16
      Top = 7
      Width = 120
      Height = 25
      Caption = #1057#1084#1077#1085#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'...'
      TabOrder = 0
      OnClick = btShiftClick
    end
  end
  object quResultShifts: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftsCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShifts')
    Left = 488
    Top = 8
    object quResultShiftsId_ResultShift: TAutoIncField
      DisplayLabel = #1050#1086#1076' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099
      DisplayWidth = 10
      FieldName = 'Id_ResultShift'
      ReadOnly = True
    end
    object quResultShiftsId_Openpit: TIntegerField
      DisplayLabel = #1050#1086#1076' '#1072#1074#1090#1086#1090#1088#1072#1089#1089#1099
      DisplayWidth = 10
      FieldName = 'Id_Openpit'
    end
    object quResultShiftsShiftNaryadTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1077'), '#1084#1080#1085
      DisplayWidth = 10
      FieldName = 'ShiftNaryadTmin'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsShiftPlanNaryadTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1074' '#1085#1072#1088#1103#1076#1077', '#1084#1080#1085
      FieldKind = fkCalculated
      FieldName = 'ShiftPlanNaryadTmin'
      DisplayFormat = '0.0#'
      Calculated = True
    end
    object quResultShiftsShiftPeresmenkaTmin: TIntegerField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1087#1077#1088#1077#1089#1084#1077#1085#1082#1080', '#1084#1080#1085
      FieldName = 'ShiftPeresmenkaTmin'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsShiftTmin: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1081' '#1089#1084#1077#1085#1099', '#1084#1080#1085
      DisplayWidth = 20
      FieldName = 'ShiftTmin'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsShiftKweek: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1088#1077#1076#1085#1077#1085#1077#1076#1077#1083#1100#1085#1086#1081' '#1089#1084#1077#1085#1099
      FieldName = 'ShiftKweek'
      DisplayFormat = '0.00'
    end
    object quResultShiftsPeriodKshift: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1074#1086#1076#1072' '#1089#1084#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1074' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      DisplayWidth = 30
      FieldName = 'PeriodKshift'
      DisplayFormat = '0.00'
    end
    object quResultShiftsPeriodTday: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1087#1077#1088#1080#1086#1076#1072', '#1076#1085#1080
      DisplayWidth = 10
      FieldName = 'PeriodTday'
      DisplayFormat = '0.0#'
    end
    object quResultShiftsDollarCtg: TFloatField
      DisplayLabel = #1050#1091#1088#1089' 1 '#1076#1086#1083#1083#1072#1088#1072' '#1057#1064#1040', '#1090#1077#1085#1075#1077
      FieldName = 'DollarCtg'
      DisplayFormat = '0.00'
      EditFormat = '0'
    end
    object quResultShiftsResultStrippingCoef: TFloatField
      FieldName = 'ResultStrippingCoef'
    end
  end
  object dsResultShifts: TDataSource
    DataSet = quResultShifts
    Left = 488
    Top = 56
  end
  object quResultShiftUnloadingPunkts: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftUnloadingPunktsCalcFields
    DataSource = dsResultShifts
    Parameters = <
      item
        Name = 'Id_ResultShift'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '1'
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftUnloadingPunkts'
      'WHERE Id_ResultShift=:Id_ResultShift')
    Left = 152
    Top = 408
    object quResultShiftUnloadingPunktsId_ResultShift: TIntegerField
      FieldName = 'Id_ResultShift'
    end
    object quResultShiftUnloadingPunktsId_UnloadingPunkt: TIntegerField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_UnloadingPunkt'
    end
    object quResultShiftUnloadingPunktsId_ResultShiftUnloadingPunkt: TAutoIncField
      DisplayLabel = #1050#1086#1076
      FieldName = 'Id_ResultShiftUnloadingPunkt'
      ReadOnly = True
    end
    object quResultShiftUnloadingPunktsKind: TWordField
      DisplayLabel = #1055#1091#1085#1082#1090' '#1088#1072#1079#1075#1088#1091#1079#1082#1080
      FieldName = 'Kind'
      OnGetText = quResultShiftUnloadingPunktsKindGetText
    end
    object quResultShiftUnloadingPunktsHorizont: TFloatField
      DisplayLabel = #1043#1086#1088#1080#1079#1086#1085#1090', '#1084
      FieldName = 'Horizont'
      DisplayFormat = '+# ### ##0.0;-# ### ##0.0;+0.0;'
    end
    object quResultShiftUnloadingPunktsMaxV1000m3: TFloatField
      DisplayLabel = #1045#1084#1082#1086#1089#1090#1100' '#1087#1088#1080#1077#1084#1085#1086#1075#1086' '#1073#1091#1085#1082#1077#1088#1072', '#1090#1099#1089'.'#1084'3'
      FieldName = 'MaxV1000m3'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultShiftUnloadingPunktsUnloadingAutosCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1079#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      FieldName = 'UnloadingAutosCount'
    end
    object quResultShiftUnloadingPunktsUnloadingTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1088#1072#1079#1075#1088#1091#1079#1082#1080', '#1084#1080#1085
      FieldName = 'UnloadingTmin'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultShiftUnloadingPunktsManeuvrTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1084#1072#1085#1077#1074#1088#1072' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074', '#1084#1080#1085
      FieldName = 'ManeuvrTmin'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultShiftUnloadingPunktsRockVm3: TFloatField
      DisplayLabel = 'V, '#1084'3'
      FieldName = 'RockVm3'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultShiftUnloadingPunktsRockQtn: TFloatField
      DisplayLabel = 'Q, '#1090
      FieldName = 'RockQtn'
      DisplayFormat = '# ### ### ##0.00'
    end
    object quResultShiftUnloadingPunktsUsingTmin: TFloatField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1079#1072#1085#1103#1090#1086#1089#1090#1080', '#1084#1080#1085
      FieldKind = fkCalculated
      FieldName = 'UsingTmin'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultShiftUnloadingPunktsUsingCoef: TFloatField
      DisplayLabel = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090' '#1079#1072#1085#1103#1090#1086#1089#1090#1080
      FieldKind = fkCalculated
      FieldName = 'UsingCoef'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
    object quResultShiftUnloadingPunktsBunkerRatio: TFloatField
      DisplayLabel = #1057#1090#1077#1087#1077#1085#1100' '#1079#1072#1087#1086#1083#1085#1077#1085#1085#1086#1089#1090#1080' '#1073#1091#1085#1082#1077#1088#1072', %'
      FieldKind = fkCalculated
      FieldName = 'BunkerRatio'
      DisplayFormat = '# ### ### ##0.00'
      Calculated = True
    end
  end
  object dsResultShiftUnloadingPunkts: TDataSource
    DataSet = quResultShiftUnloadingPunkts
    Left = 152
    Top = 456
  end
  object quResultShiftUnloadingPunktEvents: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    DataSource = dsResultShiftUnloadingPunkts
    Parameters = <
      item
        Name = 'Id_ResultShiftUnloadingPunkt'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftUnloadingPunktEvents'
      'WHERE Id_ResultShiftUnloadingPunkt=:Id_ResultShiftUnloadingPunkt'
      'ORDER BY Id_ResultShiftUnloadingPunktEvent')
    Left = 328
    Top = 408
    object quResultShiftUnloadingPunktEventsId_ResultShiftUnLoadingPunktEvent: TAutoIncField
      FieldName = 'Id_ResultShiftUnLoadingPunktEvent'
      ReadOnly = True
    end
    object quResultShiftUnloadingPunktEventsId_ResultShiftUnloadingPunkt: TIntegerField
      FieldName = 'Id_ResultShiftUnloadingPunkt'
    end
    object quResultShiftUnloadingPunktEventsKind: TWordField
      DisplayLabel = #1057#1086#1073#1099#1090#1080#1077
      FieldName = 'Kind'
      OnGetText = quResultShiftUnloadingPunktEventsKindGetText
    end
    object quResultShiftUnloadingPunktEventsTmin: TFloatField
      DisplayLabel = 'T, '#1084#1080#1085
      FieldName = 'Tmin'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftUnloadingPunktEventsId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quResultShiftUnloadingPunktEventsRock: TWideStringField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Rock'
      Size = 50
    end
    object quResultShiftUnloadingPunktEventsRockIsMineralWealth: TBooleanField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1055#1086#1083#1077#1079#1085#1086#1077' '#1080#1089#1082#1086#1087#1072#1077#1084#1086#1077'?'
      FieldName = 'RockIsMineralWealth'
    end
    object quResultShiftUnloadingPunktEventsRockVm3: TFloatField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|V, '#1084'3'
      FieldName = 'RockVm3'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftUnloadingPunktEventsRockQtn: TFloatField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|Q, '#1090
      FieldName = 'RockQtn'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftUnloadingPunktEventsId_DumpModel: TIntegerField
      DisplayLabel = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083'|'#1050#1086#1076
      FieldName = 'Id_DumpModel'
    end
    object quResultShiftUnloadingPunktEventsDumpModel: TWideStringField
      DisplayLabel = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083'|'#1052#1086#1076#1077#1083#1100
      FieldName = 'DumpModel'
      Size = 50
    end
    object quResultShiftUnloadingPunktEventsDumpNo: TIntegerField
      DisplayLabel = #1040#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083'|'#1043#1072#1088#1072#1078#1085#1099#1081' '#1085#1086#1084#1077#1088
      FieldName = 'DumpNo'
      DisplayFormat = '00'
    end
  end
  object dsResultShiftUnloadingPunktEvents: TDataSource
    DataSet = quResultShiftUnloadingPunktEvents
    Left = 328
    Top = 456
  end
  object quResultShiftUnloadingPunktRocks: TADOQuery
    Connection = fmDM.ADOConnection
    CursorType = ctStatic
    OnCalcFields = quResultShiftUnloadingPunktRocksCalcFields
    DataSource = dsResultShiftUnloadingPunkts
    Parameters = <
      item
        Name = 'Id_ResultShiftUnloadingPunkt'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM _ResultShiftUnloadingPunktRocks'
      'WHERE Id_ResultShiftUnloadingPunkt=:Id_ResultShiftUnloadingPunkt')
    Left = 584
    Top = 408
    object quResultShiftUnloadingPunktRocksId_ResultShiftUnloadingPunktRock: TAutoIncField
      FieldName = 'Id_ResultShiftUnloadingPunktRock'
      ReadOnly = True
    end
    object quResultShiftUnloadingPunktRocksId_ResultShiftUnloadingPunkt: TIntegerField
      FieldName = 'Id_ResultShiftUnloadingPunkt'
    end
    object quResultShiftUnloadingPunktRocksId_Rock: TIntegerField
      FieldName = 'Id_Rock'
    end
    object quResultShiftUnloadingPunktRocksRock: TWideStringField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      FieldName = 'Rock'
      Size = 50
    end
    object quResultShiftUnloadingPunktRocksRockIsMineralWealth: TBooleanField
      DisplayLabel = #1043#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1055#1086#1083#1077#1079#1085#1086#1077' '#1080#1089#1082#1086#1087#1072#1077#1084#1086#1077'?'
      FieldName = 'RockIsMineralWealth'
    end
    object quResultShiftUnloadingPunktRocksUnloadingAutosCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1079#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1072#1074#1090#1086#1089#1072#1084#1086#1089#1074#1072#1083#1086#1074
      FieldName = 'UnloadingAutosCount'
    end
    object quResultShiftUnloadingPunktRocksRockVm3: TFloatField
      DisplayLabel = #1056#1072#1079#1075#1088#1091#1078#1077#1085#1085#1072#1103' '#1075#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1054#1073#1098#1077#1084' V, '#1084'3'
      FieldName = 'RockVm3'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftUnloadingPunktRocksRockQtn: TFloatField
      DisplayLabel = #1056#1072#1079#1075#1088#1091#1078#1077#1085#1085#1072#1103' '#1075#1086#1088#1085#1072#1103' '#1084#1072#1089#1089#1072'|'#1042#1077#1089' Q, '#1090
      FieldName = 'RockQtn'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftUnloadingPunktRocksRequiredContent: TFloatField
      FieldName = 'RequiredContent'
      DisplayFormat = '# ### ##0.00'
    end
    object quResultShiftUnloadingPunktRocksContent: TFloatField
      DisplayLabel = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077', %'
      FieldName = 'Content'
      DisplayFormat = '# ### ##0.00;# ### ##0.00;-;'
    end
    object quResultShiftUnloadingPunktRocksDContent: TFloatField
      DisplayLabel = #1054#1090#1082#1083#1086#1085#1077#1085#1080#1077' '#1086#1090' '#1087#1083#1072#1085#1086#1074#1086#1075#1086' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1103', %'
      FieldKind = fkCalculated
      FieldName = 'DContent'
      DisplayFormat = '+# ### ##0.00;# ### ##0.00;-;'
      Calculated = True
    end
  end
  object dsResultShiftUnloadingPunktRocks: TDataSource
    DataSet = quResultShiftUnloadingPunktRocks
    Left = 584
    Top = 456
  end
end
