object fmAydarTest: TfmAydarTest
  Left = 100
  Top = 51
  Width = 800
  Height = 600
  Caption = #1058#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1088#1072#1089#1095#1077#1090#1086#1074' '#1040#1081#1076#1072#1088#1072
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
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 564
    ActivePage = tsParams
    Align = alClient
    TabOrder = 0
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object tsParams: TTabSheet
      Caption = '&Params'
      DesignSize = (
        776
        536)
      object gbAuto: TGroupBox
        Left = 16
        Top = 216
        Width = 408
        Height = 248
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'AutoParams'
        TabOrder = 0
        DesignSize = (
          408
          248)
        object lbAuto: TLabel
          Left = 16
          Top = 24
          Width = 22
          Height = 13
          Caption = 'Auto'
          FocusControl = dblcbAuto
        end
        object lbKPDnom: TLabel
          Left = 16
          Top = 184
          Width = 42
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'KPDnom'
          FocusControl = dbeKPDnom
        end
        object lbP: TLabel
          Left = 16
          Top = 208
          Width = 22
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'P, tn'
          FocusControl = dbeP
        end
        object lbQ: TLabel
          Left = 208
          Top = 208
          Width = 23
          Height = 13
          Anchors = [akRight, akBottom]
          Caption = 'Q, tn'
          FocusControl = edQ
        end
        object lbKPDfact: TLabel
          Left = 208
          Top = 184
          Width = 40
          Height = 13
          Anchors = [akRight, akBottom]
          Caption = 'KPDfact'
          FocusControl = edKPDfact
        end
        object dblcbAuto: TDBLookupComboBox
          Left = 72
          Top = 24
          Width = 312
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          KeyField = 'Id_Auto'
          ListField = 'Name'
          ListSource = fmDM.dsAutos
          TabOrder = 0
        end
        object dbeKPDnom: TDBEdit
          Left = 72
          Top = 184
          Width = 120
          Height = 21
          Anchors = [akLeft, akBottom]
          Color = clBtnFace
          DataField = 'TransmissionKPD'
          DataSource = fmDM.dsAutos
          ReadOnly = True
          TabOrder = 1
        end
        object dbeP: TDBEdit
          Left = 72
          Top = 208
          Width = 120
          Height = 21
          Anchors = [akLeft, akBottom]
          Color = clBtnFace
          DataField = 'P'
          DataSource = fmDM.dsAutos
          ReadOnly = True
          TabOrder = 2
        end
        object edKPDfact: TEdit
          Left = 264
          Top = 184
          Width = 120
          Height = 21
          Anchors = [akRight, akBottom]
          TabOrder = 3
          Text = 'edKPDfact'
          OnKeyPress = edKPDfactKeyPress
        end
        object edQ: TEdit
          Left = 264
          Top = 208
          Width = 120
          Height = 21
          Anchors = [akRight, akBottom]
          TabOrder = 4
          Text = 'edQ'
          OnKeyPress = edKPDfactKeyPress
        end
        object dbgFks: TDBGrid
          Left = 16
          Top = 56
          Width = 368
          Height = 120
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = fmDM.dsAutoFks
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 5
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
              FieldName = 'V'
              Title.Alignment = taCenter
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Fk'
              Title.Alignment = taCenter
              Width = 96
              Visible = True
            end>
        end
      end
      object gbRoadCoats: TGroupBox
        Left = 16
        Top = 16
        Width = 408
        Height = 192
        Anchors = [akLeft, akTop, akRight]
        Caption = 'RoadCoatParams'
        TabOrder = 1
        DesignSize = (
          408
          192)
        object lbRoadCoats: TLabel
          Left = 16
          Top = 24
          Width = 48
          Height = 13
          Caption = 'RoadCoat'
          FocusControl = dblcbRoadCoats
        end
        object dblcbRoadCoats: TDBLookupComboBox
          Left = 72
          Top = 24
          Width = 312
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          KeyField = 'Id_RoadCoat'
          ListField = 'Name'
          ListSource = fmDM.dsRoadCoats
          TabOrder = 0
        end
        object dbgRoadCoats: TDBGrid
          Left = 16
          Top = 56
          Width = 368
          Height = 120
          Anchors = [akLeft, akTop, akRight]
          DataSource = fmDM.dsRoadCoatUSKs
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 1
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
              FieldName = 'P'
              Title.Alignment = taCenter
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ValueMin'
              Title.Alignment = taCenter
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ValueMax'
              Title.Alignment = taCenter
              Width = 96
              Visible = True
            end>
        end
      end
      object gbParams: TGroupBox
        Left = 440
        Top = 16
        Width = 328
        Height = 448
        Anchors = [akTop, akRight, akBottom]
        Caption = 'Params'
        TabOrder = 2
        DesignSize = (
          328
          448)
        object StringGrid: TStringGrid
          Left = 16
          Top = 24
          Width = 296
          Height = 408
          Anchors = [akLeft, akTop, akBottom]
          ColCount = 3
          DefaultRowHeight = 20
          RowCount = 11
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
          TabOrder = 0
          OnKeyDown = StringGridKeyDown
          OnKeyPress = StringGridKeyPress
        end
      end
    end
    object tsGraphik: TTabSheet
      Caption = '&Graphik'
      ImageIndex = 1
      object PaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 784
        Height = 545
        Align = alClient
        OnPaint = PaintBoxPaint
      end
    end
  end
end
