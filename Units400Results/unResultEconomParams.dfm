�
 TFMRESULTECONOMPARAMS 0�  TPF0TfmResultEconomParamsfmResultEconomParamsLeftTopHelpType	htKeywordHelpKeywordResultEconomicBorderIconsbiSystemMenu
biMaximize BorderStylebsDialogCaptionJ   Экономические результаты моделированияClientHeight=ClientWidthColor	clBtnFaceConstraints.MinHeightXConstraints.MinWidth Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPanelpnBtnsLeft TopWidthHeight)AlignalBottom
BevelOuterbvNoneTabOrder 
DesignSize)  TButtonbtCancelLeft�TopWidthHHeightAnchorsakTopakRight Cancel	Caption   0:@KBLModalResultTabOrder  TButtonbtDistributionLeft� TopWidth� HeightCaption*   Распределение затрат...TabOrderOnClickbtDistributionClick  TButtonbtExcelLeft8TopWidthKHeightCaption   в ExcelTabOrderOnClickbtExcelClick  TButtonbtShiftLeftTopWidthxHeightCaption$   Сменные параметры...TabOrder OnClickbtShiftClick   TPanelpnClientLeft Top WidthHeightAlignalClient
BevelOuterbvNoneTabOrder
DesignSize  TLabellbDollarCtgLeft(TopWidth_HeightAnchorsakTopakRight Caption   Курс доллара СШАFocusControldbeDollarCtg  TLabel	lbMeasureLeft Top(WidthfHeightAnchorsakTopakRight Caption!   Единица измерения  TDBEditdbeDollarCtgLeft�TopWidthxHeightAnchorsakTopakRight Color	clBtnFace	DataField	DollarCtg
DataSourcedsResultShiftsReadOnly	TabOrder   	TComboBox	cbMeasureLeft�Top(WidthxHeightStylecsDropDownListAnchorsakTopakRight 
ItemHeight	ItemIndex TabOrderText   B5=35OnChangecbMeasureChangeItems.Strings
   тенге   доллар США   	TDBGridEhdbgResultEconomReportsLeft TopPWidthHeight�AlignalBottomAnchorsakLeftakTopakRightakBottom 
DataSourcedsResultEconomReportsDefaultDrawingFlatFooterColorclYellowFooterFont.CharsetDEFAULT_CHARSETFooterFont.ColorclWindowTextFooterFont.Height�FooterFont.NameMS Sans SerifFooterFont.Style MinAutoFitWidthOptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabs ReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style VTitleMarginOnDrawColumnCell$dbgResultEconomReportsDrawColumnCellColumns	AlignmenttaRightJustifyEditButtons 	FieldName
RecordNameFooters MaxWidthMinWidthWidth EditButtons 	FieldNameNameFooters MinWidthhWidth� EditButtons 	FieldNameValue1Footers MaxWidthxMinWidthPTitle.Caption   За смену, тыс.WidthP EditButtons 	FieldNameValue2Footers MaxWidthxMinWidthPTitle.Caption9   За средне- недельную смену, тыс.WidthP EditButtons 	FieldNameValue3Footers MaxWidthxMinWidthPTitle.Caption   За период, тыс.WidthP     	TADOQueryquResultShifts
ConnectionfmDM.ADOConnection
CursorTypectStaticOnCalcFieldsquResultShiftsCalcFields
Parameters SQL.StringsSELECT *FROM _ResultShifts Left� Top TAutoIncFieldquResultShiftsId_ResultShiftDisplayLabel    Код рабочей сменыDisplayWidth
	FieldNameId_ResultShiftReadOnly	  TIntegerFieldquResultShiftsId_OpenpitDisplayLabel   Код автотрассыDisplayWidth
	FieldName
Id_Openpit  TFloatFieldquResultShiftsShiftNaryadTminDisplayLabel;   Время в наряде (фактическое), минDisplayWidth
	FieldNameShiftNaryadTminDisplayFormat0.0#  TFloatField!quResultShiftsShiftPlanNaryadTminDisplayLabel"   Время в наряде, мин	FieldKindfkCalculated	FieldNameShiftPlanNaryadTminDisplayFormat0.0#
Calculated	  TIntegerField!quResultShiftsShiftPeresmenkaTminDisplayLabel'   Время пересменки, мин	FieldNameShiftPeresmenkaTminDisplayFormat0.0#  TIntegerFieldquResultShiftsShiftTminDisplayLabelD   Продолжительность рабочей смены, минDisplayWidth	FieldName	ShiftTminDisplayFormat0.0#  TFloatFieldquResultShiftsShiftKweekDisplayLabel{   Коэффициент использования рабочего времени средненедельной смены	FieldName
ShiftKweekDisplayFormat0.00  TIntegerFieldquResultShiftsPeriodTdayDisplayLabel9   Продолжительность периода, дниDisplayWidth
	FieldName
PeriodTdayDisplayFormat0.0#  TFloatFieldquResultShiftsPeriodKshiftDisplayLabels   Коэффициент перевода сменных параметров в параметры за периодDisplayWidth	FieldNamePeriodKshiftDisplayFormat0.00  TFloatFieldquResultShiftsDollarCtgDisplayLabel,   Курс 1 доллара США, тенге	FieldName	DollarCtgDisplayFormat0.00
EditFormat0  TIntegerField!quResultShiftsExpensesYearC1000tgDisplayLabel^   Величина постоянных и неучтенных затрат, тыс.тг/год	FieldNameExpensesYearC1000tgDisplayFormat0.00   TDataSourcedsResultShiftsDataSetquResultShiftsLeft� Top8  	TADOQueryquResultEconomReports
ConnectionfmDM.ADOConnection
CursorTypectStaticOnCalcFieldsquResultEconomReportsCalcFields
DataSourcedsResultShifts
ParametersNameId_ResultShift
Attributes
paNullable DataTypeftWideStringNumericScale� 	Precision� Size�Value1  SQL.StringsSELECT *FROM _ResultEconomReports$WHERE Id_ResultShift=:Id_ResultShiftORDER BY RecordNo Left� Top TAutoIncField*quResultEconomReportsId_ResultEconomReport	FieldNameId_ResultEconomReportReadOnly	  TIntegerField#quResultEconomReportsId_ResultShift	FieldNameId_ResultShift  TBooleanField!quResultEconomReportsIsChangeable	FieldNameIsChangeable  TIntegerFieldquResultEconomReportsRecordNo	FieldNameRecordNo  TWideStringFieldquResultEconomReportsRecordNameDisplayLabel   !	FieldName
RecordNameSize
  TWideStringFieldquResultEconomReportsNameDisplayLabel	   0@0<5B@K	FieldNameNameSize�   TFloatFieldquResultEconomReportsValueDisplayLabel   За смену	FieldNameValueDisplayFormat# ### ### ##0.00  TFloatFieldquResultEconomReportsValue1DisplayLabel   За смену	FieldKindfkCalculated	FieldNameValue1DisplayFormat# ### ### ##0.00
Calculated	  TFloatFieldquResultEconomReportsValue2DisplayLabel0   За средне- недельную смену	FieldKindfkCalculated	FieldNameValue2DisplayFormat# ### ### ##0.00
Calculated	  TFloatFieldquResultEconomReportsValue3DisplayLabel   За период	FieldKindfkCalculated	FieldNameValue3DisplayFormat# ### ### ##0.00
Calculated	   TDataSourcedsResultEconomReportsDataSetquResultEconomReportsLeft� Top8   