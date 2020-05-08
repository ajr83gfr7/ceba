object fmResultEconomEffect: TfmResultEconomEffect
  Left = 759
  Top = 37
  Width = 1161
  Height = 690
  Caption = 'actLoadVariant'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 1145
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object gbxVariant: TGroupBox
    Left = 0
    Top = 3
    Width = 225
    Height = 649
    Align = alLeft
    Caption = 'gbxVariant'
    TabOrder = 0
    object dbgVariant: TDBGrid
      Left = 2
      Top = 15
      Width = 221
      Height = 394
      Align = alTop
      DataSource = dsVariants
      DefaultDrawing = False
      FixedColor = clWindow
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgVariantCellClick
      OnDrawColumnCell = dbgVariantDrawColumnCell
    end
    object pnlVariant: TPanel
      Left = 2
      Top = 465
      Width = 221
      Height = 182
      Align = alClient
      TabOrder = 1
      object Label47: TLabel
        Left = 16
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Label47'
      end
      object Label48: TLabel
        Left = 16
        Top = 56
        Width = 38
        Height = 13
        Caption = 'Label48'
      end
      object Label49: TLabel
        Left = 16
        Top = 144
        Width = 38
        Height = 13
        Caption = 'Label49'
      end
      object Label43: TLabel
        Left = 16
        Top = 88
        Width = 38
        Height = 13
        Caption = 'Label43'
      end
      object btnDelVariant: TButton
        Left = 128
        Top = 56
        Width = 75
        Height = 25
        Caption = 'btnDelVariant'
        TabOrder = 0
        OnClick = btnDelVariantClick
      end
      object btnSetBase: TButton
        Left = 128
        Top = 16
        Width = 75
        Height = 25
        Action = actSetBaseVariant
        TabOrder = 1
      end
      object btnPrintToExcel: TButton
        Left = 128
        Top = 144
        Width = 75
        Height = 25
        Caption = 'btnPrintToExcel'
        TabOrder = 2
        OnClick = btnPrintToExcelClick
      end
      object btnSetLikeBase: TButton
        Left = 128
        Top = 96
        Width = 75
        Height = 25
        Caption = 'btnSetLikeBase'
        TabOrder = 3
        OnClick = btnSetLikeBaseClick
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 409
      Width = 221
      Height = 56
      Align = alTop
      TabOrder = 2
      object Label44: TLabel
        Left = 96
        Top = 8
        Width = 38
        Height = 13
        Caption = 'Label44'
      end
      object Label50: TLabel
        Left = 96
        Top = 32
        Width = 38
        Height = 13
        Caption = 'Label50'
      end
      object Panel2: TPanel
        Left = 8
        Top = 8
        Width = 73
        Height = 17
        Color = clBlue
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 8
        Top = 32
        Width = 73
        Height = 17
        Color = clHighlight
        TabOrder = 1
      end
    end
  end
  object gbxValue: TGroupBox
    Left = 225
    Top = 3
    Width = 920
    Height = 649
    Align = alClient
    Caption = 'gbxValue'
    TabOrder = 1
    object gbxCebadan: TGroupBox
      Left = 2
      Top = 15
      Width = 916
      Height = 394
      Align = alTop
      Caption = 'gbxCebadan'
      TabOrder = 0
      object Label1: TLabel
        Left = 48
        Top = 24
        Width = 32
        Height = 13
        Caption = 'Label1'
      end
      object Label3: TLabel
        Left = 48
        Top = 72
        Width = 32
        Height = 13
        Caption = 'Label3'
      end
      object Label2: TLabel
        Left = 48
        Top = 48
        Width = 32
        Height = 13
        Caption = 'Label2'
      end
      object Label4: TLabel
        Left = 48
        Top = 96
        Width = 32
        Height = 13
        Caption = 'Label4'
      end
      object Label5: TLabel
        Left = 48
        Top = 120
        Width = 32
        Height = 13
        Caption = 'Label5'
      end
      object Label6: TLabel
        Left = 48
        Top = 144
        Width = 32
        Height = 13
        Caption = 'Label6'
      end
      object Label7: TLabel
        Left = 48
        Top = 168
        Width = 32
        Height = 13
        Caption = 'Label7'
      end
      object Label8: TLabel
        Left = 48
        Top = 192
        Width = 32
        Height = 13
        Caption = 'Label8'
      end
      object Label9: TLabel
        Left = 48
        Top = 216
        Width = 32
        Height = 13
        Caption = 'Label9'
      end
      object Label10: TLabel
        Left = 48
        Top = 240
        Width = 38
        Height = 13
        Caption = 'Label10'
        Visible = False
      end
      object Label11: TLabel
        Left = 48
        Top = 264
        Width = 38
        Height = 13
        Caption = 'Label11'
      end
      object Label12: TLabel
        Left = 48
        Top = 288
        Width = 38
        Height = 13
        Caption = 'Label12'
      end
      object Label13: TLabel
        Left = 48
        Top = 312
        Width = 38
        Height = 13
        Caption = 'Label13'
      end
      object Label14: TLabel
        Left = 48
        Top = 336
        Width = 38
        Height = 13
        Caption = 'Label14'
      end
      object Label15: TLabel
        Left = 48
        Top = 360
        Width = 38
        Height = 13
        Caption = 'Label15'
      end
      object Label16: TLabel
        Left = 504
        Top = 24
        Width = 38
        Height = 13
        Caption = 'Label16'
      end
      object Label17: TLabel
        Left = 504
        Top = 48
        Width = 38
        Height = 13
        Caption = 'Label17'
      end
      object Label18: TLabel
        Left = 504
        Top = 72
        Width = 38
        Height = 13
        Caption = 'Label18'
      end
      object Label19: TLabel
        Left = 504
        Top = 96
        Width = 38
        Height = 13
        Caption = 'Label19'
      end
      object Label20: TLabel
        Left = 504
        Top = 120
        Width = 38
        Height = 13
        Caption = 'Label20'
      end
      object Label21: TLabel
        Left = 504
        Top = 144
        Width = 38
        Height = 13
        Caption = 'Label21'
        Visible = False
      end
      object Label22: TLabel
        Left = 504
        Top = 168
        Width = 38
        Height = 13
        Caption = 'Label22'
      end
      object Label23: TLabel
        Left = 504
        Top = 192
        Width = 38
        Height = 13
        Caption = 'Label23'
      end
      object Label24: TLabel
        Left = 504
        Top = 216
        Width = 38
        Height = 13
        Caption = 'Label24'
      end
      object Label25: TLabel
        Left = 504
        Top = 240
        Width = 38
        Height = 13
        Caption = 'Label25'
      end
      object Label27: TLabel
        Left = 504
        Top = 288
        Width = 38
        Height = 13
        Caption = 'Label27'
      end
      object Label28: TLabel
        Left = 504
        Top = 312
        Width = 38
        Height = 13
        Caption = 'Label28'
      end
      object Label29: TLabel
        Left = 504
        Top = 336
        Width = 38
        Height = 13
        Caption = 'Label29'
        Visible = False
      end
      object Label26: TLabel
        Left = 504
        Top = 264
        Width = 38
        Height = 13
        Caption = 'Label26'
      end
      object edEmploymentRatio: TEdit
        Left = 328
        Top = 240
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'edEmploymentRatio'
        Visible = False
      end
      object edResultPeriodCoef: TEdit
        Left = 328
        Top = 216
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'edResultPeriodCoef'
      end
      object edKVsry: TEdit
        Left = 328
        Top = 192
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'edKVsry'
      end
      object edSalary: TEdit
        Left = 328
        Top = 168
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'edSalary'
      end
      object edUdelQtn: TEdit
        Left = 328
        Top = 144
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'edUdelQtn'
      end
      object edTotalCostsSummary: TEdit
        Left = 328
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'edTotalCostsSummary'
      end
      object edParamsShiftDuration: TEdit
        Left = 328
        Top = 96
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'edParamsShiftDuration'
      end
      object edSelic: TEdit
        Left = 328
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 7
        Text = 'edSelic'
      end
      object edProizPeriod: TEdit
        Left = 328
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 8
        Text = 'edProizPeriod'
      end
      object edRocksVm3: TEdit
        Left = 328
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 9
        Text = 'edRocksVm3'
      end
      object edWorkTimeUsingRatio: TEdit
        Left = 328
        Top = 264
        Width = 121
        Height = 21
        TabOrder = 10
        Text = 'edWorkTimeUsingRatio'
      end
      object edShiftExcavators: TEdit
        Left = 328
        Top = 288
        Width = 121
        Height = 21
        TabOrder = 11
        Text = 'edShiftExcavators'
      end
      object edElec: TEdit
        Left = 328
        Top = 312
        Width = 121
        Height = 21
        TabOrder = 12
        Text = 'edElec'
      end
      object edElectr: TEdit
        Left = 328
        Top = 336
        Width = 121
        Height = 21
        TabOrder = 13
        Text = 'edElectr'
      end
      object edExcavsCostsSummary: TEdit
        Left = 328
        Top = 360
        Width = 121
        Height = 21
        TabOrder = 14
        Text = 'edExcavsCostsSummary'
      end
      object edCountUnLodingPunkts: TEdit
        Left = 784
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 15
        Text = 'edCountUnLodingPunkts'
      end
      object edBlocksCostsSummary: TEdit
        Left = 784
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 16
        Text = 'edBlocksCostsSummary'
      end
      object edBLength: TEdit
        Left = 784
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 17
        Text = 'edBLength'
      end
      object edZatrat: TEdit
        Left = 784
        Top = 96
        Width = 121
        Height = 21
        TabOrder = 18
        Text = 'edZatrat'
      end
      object edShiftAutos: TEdit
        Left = 784
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 19
        Text = 'edShiftAutos'
      end
      object edStoiGx: TEdit
        Left = 784
        Top = 240
        Width = 121
        Height = 21
        TabOrder = 20
        Text = 'edStoiGx'
      end
      object edAVGTransKPD: TEdit
        Left = 784
        Top = 144
        Width = 121
        Height = 21
        TabOrder = 21
        Text = 'edAVGTransKPD'
        Visible = False
      end
      object edUdelTyres: TEdit
        Left = 784
        Top = 168
        Width = 121
        Height = 21
        TabOrder = 22
        Text = 'edUdelTyres'
      end
      object edStoiTyre: TEdit
        Left = 784
        Top = 192
        Width = 121
        Height = 21
        TabOrder = 23
        Text = 'edStoiTyre'
      end
      object edSTyres: TEdit
        Left = 784
        Top = 216
        Width = 121
        Height = 21
        TabOrder = 24
        Text = 'edSTyres'
      end
      object edUdelGx: TEdit
        Left = 784
        Top = 264
        Width = 121
        Height = 21
        TabOrder = 25
        Text = 'edUdelGx'
      end
      object edGx: TEdit
        Left = 784
        Top = 288
        Width = 121
        Height = 21
        TabOrder = 26
        Text = 'edGx'
      end
      object edAutosCostsSummary: TEdit
        Left = 784
        Top = 312
        Width = 121
        Height = 21
        TabOrder = 27
        Text = 'edAutosCostsSummary'
      end
      object edOstat: TEdit
        Left = 784
        Top = 336
        Width = 121
        Height = 21
        TabOrder = 28
        Text = 'edOstat'
        Visible = False
      end
    end
    object gbxInput: TGroupBox
      Left = 2
      Top = 409
      Width = 487
      Height = 238
      Align = alLeft
      Caption = 'gbxInput'
      TabOrder = 1
      object Label30: TLabel
        Left = 48
        Top = 24
        Width = 38
        Height = 13
        Caption = 'Label30'
      end
      object Label31: TLabel
        Left = 48
        Top = 48
        Width = 38
        Height = 13
        Caption = 'Label31'
      end
      object Label32: TLabel
        Left = 48
        Top = 72
        Width = 38
        Height = 13
        Caption = 'Label32'
      end
      object Label33: TLabel
        Left = 48
        Top = 96
        Width = 38
        Height = 13
        Caption = 'Label33'
      end
      object Label34: TLabel
        Left = 48
        Top = 120
        Width = 38
        Height = 13
        Caption = 'Label34'
      end
      object Label35: TLabel
        Left = 48
        Top = 144
        Width = 38
        Height = 13
        Caption = 'Label35'
      end
      object Label36: TLabel
        Left = 48
        Top = 168
        Width = 38
        Height = 13
        Caption = 'Label36'
      end
      object Label45: TLabel
        Left = 200
        Top = 200
        Width = 38
        Height = 13
        Caption = 'Label45'
      end
      object edProduk: TEdit
        Left = 328
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'edProduk'
      end
      object edQtnGM: TEdit
        Left = 328
        Top = 168
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'edQtnGM'
      end
      object edBaseVar: TEdit
        Left = 328
        Top = 144
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'edBaseVar'
      end
      object edZatSer: TEdit
        Left = 328
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'edZatSer'
      end
      object edStoiPrib: TEdit
        Left = 328
        Top = 96
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'edStoiPrib'
      end
      object edStoiGTR: TEdit
        Left = 328
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'edStoiGTR'
      end
      object edSenaProd: TEdit
        Left = 328
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'edSenaProd'
      end
      object btnEnter: TButton
        Left = 328
        Top = 200
        Width = 75
        Height = 25
        Caption = 'btnEnter'
        TabOrder = 7
        OnClick = btnEnterClick
      end
    end
    object gbxOutput: TGroupBox
      Left = 489
      Top = 409
      Width = 429
      Height = 238
      Align = alClient
      Caption = 'gbxOutput'
      TabOrder = 2
      object Label37: TLabel
        Left = 16
        Top = 24
        Width = 38
        Height = 13
        Caption = 'Label37'
      end
      object Label38: TLabel
        Left = 16
        Top = 48
        Width = 38
        Height = 13
        Caption = 'Label38'
      end
      object Label39: TLabel
        Left = 16
        Top = 72
        Width = 38
        Height = 13
        Caption = 'Label39'
      end
      object Label40: TLabel
        Left = 16
        Top = 96
        Width = 38
        Height = 13
        Caption = 'Label40'
      end
      object Label41: TLabel
        Left = 16
        Top = 120
        Width = 38
        Height = 13
        Caption = 'Label41'
      end
      object Label42: TLabel
        Left = 16
        Top = 144
        Width = 38
        Height = 13
        Caption = 'Label42'
      end
      object Label46: TLabel
        Left = 168
        Top = 200
        Width = 38
        Height = 13
        Caption = 'Label46'
      end
      object edPribil: TEdit
        Left = 296
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'edPribil'
      end
      object edOriUsEcom: TEdit
        Left = 296
        Top = 144
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'edOriUsEcom'
      end
      object edOtnoEcom: TEdit
        Left = 296
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'edOtnoEcom'
      end
      object edBaseVari: TEdit
        Left = 296
        Top = 96
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'edBaseVari'
      end
      object edUsEcom: TEdit
        Left = 296
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'edUsEcom'
      end
      object edRashot: TEdit
        Left = 296
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'edRashot'
      end
      object btnCalc: TButton
        Left = 296
        Top = 200
        Width = 75
        Height = 25
        Caption = 'btnCalc'
        TabOrder = 6
        OnClick = btnCalcClick
      end
    end
  end
  object qryVariants: TADOQuery
    Connection = fmDM.ADOConnection
    Parameters = <>
    Left = 376
    Top = 32
  end
  object dsVariants: TDataSource
    DataSet = qryVariants
    Left = 344
    Top = 32
  end
  object qryResultVariants: TADOQuery
    Connection = fmDM.ADOConnection
    Parameters = <>
    Left = 376
    Top = 164
  end
  object saveas: TSaveDialog
    Left = 411
    Top = 34
  end
  object ActionList1: TActionList
    Left = 475
    Top = 34
    object actSetBaseVariant: TAction
      Caption = 'actSetBaseVariant'
      OnExecute = actSetBaseVariantExecute
    end
    object actGetBaseVariant: TAction
      Caption = 'actGetBaseVariant'
    end
  end
end
