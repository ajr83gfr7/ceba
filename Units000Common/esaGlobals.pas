unit esaGlobals;

interface
uses ADODb, DBGrids, Types, Graphics, ExtCtrls, Grids, Forms, Controls, StdCtrls, Classes, ComCtrls, Db;
const
  hCell=18;
  //Допонительные цвета
  clLtGrayEx    = 15790320; //RGB(240,240,240);
  clLightGrayEx = 13160660;
  clGrayEx      = 8421504;
  clDarkGrayEx  = 4210752;
type
  //Тип трансмиссии
  TesaAutoTransmissionKind=(atkGM,atkEM);
  //Тип учета тарифа стоимости топлива
  TesaAutoFuelCostTarifKind = (fctWinter,fctSummer,fctAverage);
  //Тип признака распределения порожних автосамосвалов при открытом цикле
  TesaAutosWorkRegimeKind = (wrQualityAveraging,wrEqualDistrubation);
  //Данные по зарплате
  ResaSalary = record
    Ctg                     : Single;                  //Оплата труда, тг
    Ctg0                    : Single;                  // - основная
    Ctg1                    : Single;                  // - дополнительная
  end;{ResaSalary}
  
  //Значения по направлениям движения
  ResaDirectionValue = record
    Nulled   : Single; //по нулевому направлению
    Loading  : Single; //по грузовому направлению
    UnLoading: Single; //по порожнякову направлению
  end;{ResaDirectionValue}

  //Значения дроби
  ResaDrobValue = record
    Num: Single; //числитель
    Den: Single; //знаменатель
  end;{ResaDrobValue}

  //Значения по работе и простою
  ResaWorkValue = record
    Work   : Single; //в работе
    Waiting: Single; //в простое
  end;{ResaWorkValue}

  //Значение времени, мин
  ResaTmin = record
    Moving           : Single; //Время в движении, мин
    Waiting          : Single; //Время в простое, мин
    Manevr           : Single; //Время в маневре, мин
    OnLoading        : Single; //Время под погрузкой, мин
    OnUnLoading      : Single; //Время под разгрузкой, мин
  end;{ResaTmin}

  //Данные периода моделирования
  ResaPeriod = record
    Tday                    : Cardinal;                //Продолжительность периода моделирования, дни
    Kshift                  : Single;                  //Коэффициент перевода сменных параметров * Тпериода, дни * Количество смен в сутках
    AnimationTsec           : Cardinal;                //Шаг моделирования, сек
  end;{ResaPeriod}
  //Коэффициент использования времени смены
  TesaShiftExplosion = 0..7;
  ResaShiftTimeUsing = record
    Kweek                   : Single;                  //Коэффициент использования времени смены
    Coef0                   : Single;                  // - в номальных условиях
    Coef1                   : Single;                  // - дневных смен
    Coef2                   : Single;                  // - в день производства взрывных смен
    Coef3                   : TesaShiftExplosion;      //Количество взрывов в неделю
  end;{ResaShiftTimeUsing}
  //Данные рабочей смены
  ResaShift = record
    Tmin                    : Cardinal;                //Продолжительность рабочей смены, мин
    NaryadTmin              : Single;                  // - время в наряде (факт.)
    NaryadPlanTmin          : Cardinal;                // - время в наряде
    TurnoverTmin            : Byte;                    // - время пересменки
    ShiftTimeUsingCoef      : ResaShiftTimeUsing;      //Коэффициент использования времени смены
  end;{ResaShift}
  //Диз.топливо
  ResaAutoFuel = record
    Ctg                     : Single;                    //Стоимость топлива, тг/л
    SummerCtg               : Single;                    // - "Зимнее"
    WinterCtg               : Single;                    // - "Летнее"
    WinterMonthsCount       : Byte;                      //Количество зимних месяцев
    Tarif                   : TesaAutoFuelCostTarifKind; //Учет тарифа стоимости топлива
  end;{ResaAutoFuel}
  //Данные дополнительные
  ResaCommon = record
    DollarCtg               : Single;                  //Курс доларра, тг
    YearExpensesCtg         : Single;                  //Постоянные и неучтенные расходы, тг/год
    SalaryCoef              : Single;                  //Коэффициент учета отчислений из фонда заработной платы
    StrippingCoefUsing      : Boolean;                 //Признак учета коэффициента вскрыши
    AutoWorkRegime          : TesaAutosWorkRegimeKind; //Признак распределения порожних автосамосвалов при открытом цикле
    AutoDriverSalary        : ResaSalary;              //Оплата труда водителя автосамосвала, тг/мес
    AutoFuel                : ResaAutoFuel;            //Стоимость диз.топлива
    ExcavatorMashinistSalary: ResaSalary;              //Оплата труда машиниста экскаватора, тг/мес
    ExcavatorAssistantSalary: ResaSalary;              //Оплата труда помощника машиниста экскаватора, тг/мес
    ExcavatorFuelCtg        : Single;                  //Стоимость 1 кВт*ч электроэнергии экскаватора, тг/л
    ExcavatorAmortizationR  : Single;                  //Норма амортизации в год
    CurrStrippingCoef       : Single;                  //коэфицент вскрыши
    PeriodCoef              : Single;                 // сменный коэффициент
    CurrOreQtn              : Single;//Масса добытой руды, т
    CurrOreVm3              : Single;//Объем добытой руды, m3
    CurrStrippingQtn        : Single;//Масса добытой вскрыши, т
    CurrStrippingVm3        : Single;//Объем добытой вскрыши, m3

  end;{ResaCommon}
  //Объем горной массы
  ResaRockVolume=record
    Vm3: Single; //Объем горной массы, м3
    Qtn: Single; //Объем горной массы, т
    Qua:  Single; //качество горной массы
    Excv: Single; {dwd}
  end;{ResaRockVolume}
  RRockVolume=record
    Vm3: Single; //Объем горной массы, м3
    Qtn: Single; //Объем горной массы, т
    Qua:  Single; //качество горной массы
  end;

  //Данные по автосамосвалам
  ResaAutos = record
    //Автосамосвалы
    Models                  : String;    //Модели
    //Количественные показатели автосамосвалов
    AutosCount              : Cardinal;  //Количество автосамосвалов
    TripsN                  : Cardinal;  //Количество рейсов
    LoadingTripsN           : Cardinal;  // - в грузовом направлении
    UnLoadingTripsN         : Cardinal;  // - в порожняковом направлении
    NullTripsN              : Cardinal;  // - в нулевом направлении
    RockVolume              : ResaRockVolume;//Объем перевезенной горной массы, м3
    Skm                     : Single;    //Общий пробег, км
    LoadingSkm              : Single;    // - в грузовом направлении (Растояние транспортирования)
    UnLoadingSkm            : Single;    // - в порожняковом направлении
    NullSkm                 : Single;    // - в нулевом направлении
    WAvgLoadingSkm          : Single;    //Средневзвешенное растояние транспортирования, км
    AvgLoadingSkm           : Single;    //Среднее растояние транспортирования, км
    WAvgHm                  : Single;    //Средневзвешенная высота подъема горной массы, м
    AvgShiftSkm             : Single;    //Среднесменный пробег одного автосамосвала, км
    AvgShiftSkm_reis        : Single;    //Среднесменный пробег одного автосамосвала, км/рейс
    AvgVkmh                 : Single;    //Средняя скорость движения, км/ч
    AvgLoadingVkmh          : Single;    // - в грузовом направлении
    AvgUnLoadingVkmh        : Single;    // - в порожняковом направлении
    AvgNullVkmh             : Single;    // - в нулевом направлении
    AvgTechVkmh             : Single;    //Среднетехническая скорость движения, км/ч
    AvgLoadingTechVkmh      : Single;    // - в грузовом направлении
    AvgUnLoadingTechVkmh    : Single;    // - в порожняковом направлении
    AvgNullTechVkmh         : Single;    // - в нулевом направлении
    //Расход топлива автосамосвалов
    Gx                      : Single;    //Общий расход топлива, л
    WorkGx                  : Single;    // - в работе
    WaitingGx               : Single;    // - в простое
    LoadingGx               : Single;    // - в грузовом направлении
    UnLoadingGx             : Single;    // - в порожняковом направлении
    NullGx                  : Single;    // - в нулевом направлении
    UdGx_gr_tkm             : Single;    //Удельный расход топлива, г/ткм
    GxCtg                   : Single;    //Затраты на топливо, тг
    //Время автосамосвалов
    Tmin                    : Single;    //Общее время, мин
    MovingTmin              : Single;    // - в движении
    WaitingTmin             : Single;    // - в простое
    ManevrTmin              : Single;    // - в маневре
    LoadingPunktTmin        : Single;    // - под погрузкой
    UnLoadingPunktTmin      : Single;    // - под разгрузкой
    AvgShiftTmin            : Single;    //Среднее время рейса, мин
    AvgTimeUsingCoef        : Single;    //Средний коэффициент использования рабочего времени
    //Шины автосамосвалов
    TyresN                  : Cardinal;  //Количество шин автосамосвалов
    TyreCtg                 : Single;    //Стоимость шин, тг
    TyresSkm                : Single;    //Средний пробег шин, тыс.км
    UsedTyresN              : Single;    //Количество израсходованных шин, шт
    TyresCtg                : Single;    //Затраты на шины, тг
    //Стоимостные параметры автосамосвалов
    Salary                  : ResaSalary;//Оплата труда водителей, тг
    Ctg                     : Single;    //Суммарные затраты, тг
    WorkCtg                 : Single;    // - в состоянии работы
    WaitingCtg              : Single;    // - в состоянии простоя
    AmortizationCtg         : Single;    // - Величина амортизационных затрат
  end;{ResaAutos}
  //Данные по экскаваторам
  ResaExcavators = record
  end;{ResaExcavators}

  
  //Формат тяговых характеристик
  ResaRimpullFormat = record
    V100kmh: Integer; //Скорость, 100*км/ч
    Fk100kH: Integer; //Сила тяги, 100*кH
  end;{ResaRimpullFormat}
  TesaRimpullFormatArray = array of ResaRimpullFormat; 
  ResaRimpull = record
    Items: TesaRimpullFormatArray;
    Count: Integer;
  end;{ResaRimpull}
  
//-------------------------------------------------------------------------------------------------------
//Summary
function esaSummary(const AValue: ResaDirectionValue): Single; overload;
function esaSummary(const AValue: ResaWorkValue): Single; overload;
function esaSummary(const AValue: ResaTmin): Single; overload;
//Sum
function esaSum(const AValue0,AValue1: ResaWorkValue): ResaWorkValue; overload;
function esaSum(const AValue0,AValue1: ResaDirectionValue): ResaDirectionValue; overload;
function esaSum(const AValue0,AValue1: ResaDrobValue): ResaDrobValue; overload;
function esaSum(const AValue: ResaDrobValue; const ANum,ADen: Single): ResaDrobValue; overload;
function esaSum(const AValue0,AValue1: ResaTmin): ResaTmin; overload;
function esaSum(const AVolume0,AVolume1: ResaRockVolume): ResaRockVolume; overload;
//WorkValue
function esaWorkValue(): ResaWorkValue;overload;
function esaWorkValue(const AWork,AWaiting: Single): ResaWorkValue;overload;
//DrobValue
function esaDrobValue(): ResaDrobValue; overload;
function esaDrobValue(const ANum,ADen: Single): ResaDrobValue; overload;
function esaDrob(const ANum,ADen: Single): Single; overload;
function esaDrob(const ADrob: ResaDrobValue): Single; overload;
//DirectionValue
function esaDirectionValue(): ResaDirectionValue;
//Tmin
function esaTmin(): ResaTmin;
//Period
function esaPeriod(): ResaPeriod; overload;
function esaPeriod(const ATday,AAnimationTsec,AShiftTmin: Cardinal; const AShiftKweek: Single): ResaPeriod;overload;
//ShiftTimeUsing
function esaShiftTimeUsing(): ResaShiftTimeUsing; overload;
function esaShiftTimeUsing(const ACoef0,ACoef1,ACoef2: Single; const ACoef3: TesaShiftExplosion; const AShiftTmin: Cardinal): ResaShiftTimeUsing; overload;
//Shift
function esaShift(): ResaShift; overload;
function esaShift(const ATimeUsingCoef0,ATimeUsingCoef1,ATimeUsingCoef2: Single; const ATimeUsingCoef3: TesaShiftExplosion; const ATmin,ATurnoverTmin: Cardinal): ResaShift;overload;
//AutoFuelCostTarif
function esaAutoFuel(const ASummerCtg,AWinterCtg: Single; const AWinterMonthsCount: Byte; const ATarif: TesaAutoFuelCostTarifKind): ResaAutoFuel;
//Common
function esaCommon(): ResaCommon;
//Salary
function esaSalary(): ResaSalary; overload;
function esaSalary(const ACtg0,ACtg1: Single): ResaSalary; overload;
//Autos
function esaAutos(): ResaAutos;
//Excavators
function esaExcavators(): ResaExcavators;
//RockVolume
function esaRockVolume(): ResaRockVolume; overload;
function esaRockVolume(const AVm3,AQtn: Single): ResaRockVolume; overload;
//Сообщение об ошибке
procedure esaMsgError(Msg: String); overload;
procedure esaMsgError(const AFormat: String; const AArgs: array of const);overload;
//Сообщение подтверждения Yes/No
function esaMsgQuestionYN(Msg: String): Boolean;overload;
function esaMsgQuestionYN(const AFormat: String; const AArgs: array of const): Boolean;overload;
//Сообщение подтверждения Yes/No/Cancel
function esaMsgQuestionYNC(Msg: String): Integer;overload;
function esaMsgQuestionYNC(const AFormat: String; const AArgs: array of const): Integer;overload;
//Сообщение об информации
procedure esaMsgInformation(Msg: String);overload;
procedure esaMsgInformation(const AFormat: String; const AArgs: array of const);overload;
//Проверка при закрытии на сохранение изменений в таблице БД
function esaCanCloseModifiedQuery(AQuery: TADOQuery; const ATableName: String): boolean;
//Импорт тяговых характеристик из файла Rimpull Format
function esaImportRimpullFrom(const AFileName: String;
                              var   ARimpull : ResaRimpull;
                              var   AError   : String): Boolean;

//VIII. Процедуры для работы с TDBGrid --------------------------------------------------------
//Выполнение AutoWidth с помощью столбца с заданным индексом
procedure esaFitColumnByIndex(var Grid: TDBGrid; const Index: Integer);
//Нахожу Right's столбцов Grid'а в пикселях с учетом их ширины
procedure esaUpdateColumnRights(const AGrid: TDBGrid; var AColWidths: TIntegerDynArray);
//Прорисовываю ячейку Grid'а
procedure esaDrawGridCell(ACanvas: TCanvas;ALeft,ATop,ARight,ABottom: Integer; Captions: array of string);
//Прорисовываю шапку Grid'а
procedure esaDrawGridTitle(var APaintBox: TPaintBox; var AGrid: TDBGrid;
                        const AMaxRowCount: Integer; AColWidths: TIntegerDynArray);
//Прорисовываю ячейку DBGrid'а
procedure esaDrawDBGridColumnCell(var ADBGrid: TDBGrid;
                               const Rect: TRect;
                               const DataCol: Integer;
                               const Column: TColumn;
                               const State: TGridDrawState);
//Рисую галочку для Boolean поля DBGrid'a
procedure esaDrawDBGridTick(const ACanvas: TCanvas; const ARect: TRect; const AValue: Boolean);
//IV. Процедуры для ввода некоторых значений --------------------------------------------------
//Ввод текстового значения
function esaInputName(const ACaption,APrompt: string;
                   var AValue: string;
                   const AMaxLength: Word;
                   const AAllowBlank: boolean = false): boolean;
//Ввод текстового значения в поле таблицы БД
function esaInputNameEx(const ACaption,APrompt,AFieldName: string;
                     const AQuery: TADOQuery;
                     var AValue: String;
                     const AAllowBlank: boolean = false): boolean;

//XIV. Процедуры создания компонентов ---------------------------------------------------------
//Создаю диалоговое окно
function esaCreateDialogForm(const ACaption: String; const AWidth,AHeight: Integer): TForm;
//Устанавливаю свойства в LabeledEdit
procedure esaSetLabeledEditProperties(var ALabeledEdit: TLabeledEdit;
                                   const AParent: TWinControl;
                                   const APrompt,AText: String;
                                   const ALeft,ATop,AWidth: Integer;
                                   const AMaxLength: Integer;
                                   const AAnchors: TAnchors);
//Устанавливаю свойства в TButton
procedure esaSetButtonProperties(const AButton: TButton;
                              const AParent: TWinControl;
                              const APosition: TPoint;
                              const ACaption: String;
                              const ADefault,ACancel: Boolean;
                              const AModalResult: TModalResult);
//Устанавливаю свойства в TLabel
procedure esaSetLabelProperties(const ALabel: TLabel;
                             const AParent: TWinControl;
                             const APosition: TPoint;
                             const ACaption: String);
//Создаю ProgressBar
function esaCreateProgressBar(const AOwner : TComponent;
                           const AParent: TWinControl;
                           const APosition: TPoint;
                           const AWidth: Integer): TProgressBar;

//IX. Процедуры соответствия значений полей таблиц БД заданному диапазону ---------------------
//Проверка значения FloatField'a: Field.AsFloat > AMin
function IsFloatFieldMoreMin(AField: TField; const AMin: Single): Boolean;
//Проверка значения FloatField'a: Field.AsFloat >= AMin
function IsFloatFieldMoreEqualMin(AField: TField; const AMin: Single): Boolean;
//Проверка значения FloatField'a: Field.AsFloat in [AMin,AMax]  с точностью 0.1
function IsFloatFieldInRange1(AField: TField; const AMin,AMax: Single): Boolean;
//Проверка значения FloatField'a: Field.AsFloat in [AMin,AMax]  с точностью 0.01
function IsFloatFieldInRange2(AField: TField; const AMin,AMax: Single): Boolean;
//Проверка значения FloatField'a: Field.AsFloat in [AMin,AMax]  с точностью 0.001
function IsFloatFieldInRange3(AField: TField; const AMin,AMax: Single): Boolean;
//Проверка значения IntegerField'a: Field.AsInteger > AMin
function IsIntegerFieldMoreMin(AField: TField; const AMin: Integer): Boolean;
//Проверка значения IntegerField'a: Field.AsInteger >= AMin
function IsIntegerFieldMoreEqualMin(AField: TField; const AMin: Integer): Boolean;
//Проверка значения IntegerField'a: Field.AsInteger in [AMin,AMax]  
function IsIntegerFieldInRange(AField: TField; const AMin,AMax: Integer): Boolean;
//X. Процедуры соответствия значений полей(в текстовом формате) заданному диапазону -----------
//Проверка соответствия целых значений полей(в текстовом формате) заданному диапазону
function esaCheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Integer;
                       const AIsBlankAllowed: Boolean): Boolean;overload;
//Проверка соответствия вещественных значений полей(в текстовом формате) заданному диапазону
function esaCheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Single;
                       const AIsBlankAllowed: Boolean): Boolean;overload;


implementation
uses Math, SysUtils, Windows, esaMessages, Variants;
//-------------------------------------------------------------------------------------------------------
//esaSummary
function esaSummary(const AValue: ResaDirectionValue): Single;
begin
  Result:= AValue.Loading + AValue.UnLoading + AValue.Nulled;
end;
function esaSummary(const AValue: ResaWorkValue): Single;
begin
  Result := AValue.Work+AValue.Waiting;
end;{esaSummary}
function esaSummary(const AValue: ResaTmin): Single;
begin
  Result := AValue.Moving+AValue.Waiting+AValue.Manevr+AValue.OnLoading+AValue.OnUnLoading;
end;{esaSummary}
//esaSum
function esaSum(const AValue0,AValue1: ResaWorkValue): ResaWorkValue;
begin
  Result.Work    := AValue0.Work+AValue1.Work;
  Result.Waiting := AValue0.Waiting+AValue1.Waiting;
end;{esaSum}
function esaSum(const AValue0,AValue1: ResaDirectionValue): ResaDirectionValue;
begin
  Result.Nulled    := AValue0.Nulled+AValue1.Nulled;
  Result.Loading   := AValue0.Loading+AValue1.Loading;
  Result.UnLoading := AValue0.UnLoading+AValue1.UnLoading;
end;{esaSum}
function esaSum(const AValue0,AValue1: ResaDrobValue): ResaDrobValue;
begin
  Result.Num := AValue0.Num+AValue1.Num;
  Result.Den := AValue0.Den+AValue1.Den;
end;{esaSum}
function esaSum(const AValue: ResaDrobValue; const ANum,ADen: Single): ResaDrobValue;
begin
  Result.Num := AValue.Num+ANum;
  Result.Den := AValue.Den+ADen;
end;{esaSum}
function esaSum(const AValue0,AValue1: ResaTmin): ResaTmin;
begin
  Result.Moving      := AValue0.Moving+AValue1.Moving;
  Result.Waiting     := AValue0.Waiting+AValue1.Waiting;
  Result.Manevr      := AValue0.Manevr+AValue1.Manevr;
  Result.OnLoading   := AValue0.OnLoading+AValue1.OnLoading;
  Result.OnUnLoading := AValue0.OnUnLoading+AValue1.OnUnLoading;
end;{esaSum}
function esaSum(const AVolume0,AVolume1: ResaRockVolume): ResaRockVolume;
begin
  Result.Vm3 := AVolume0.Vm3+AVolume1.Vm3;
  Result.Qtn := AVolume0.Qtn+AVolume1.Qtn;
end;{esaSum}
//WorkValue
function esaWorkValue(): ResaWorkValue;
begin
  Result.Work    := 0.0;
  Result.Waiting := 0.0;
end;{esaWorkValue}
function esaWorkValue(const AWork,AWaiting: Single): ResaWorkValue;
begin
  Result.Work    := AWork;
  Result.Waiting := AWaiting;
end;{esaWorkValue}
//DrobValue
function esaDrobValue(): ResaDrobValue;
begin
  Result.Num := 0.0;
  Result.Den := 0.0;
end;{esaDrobValue}
function esaDrobValue(const ANum,ADen: Single): ResaDrobValue;
begin
  Result.Num := ANum;
  Result.Den := ADen;
end;{esaDrobValue}
function esaDrob(const ANum, ADen: Single): Single; overload;
begin
  if ADen > 0.0 then
    Result := ANum / ADen
  else
    Result := 0.0;
end;
function esaDrob(const ADrob: ResaDrobValue): Single; overload;
begin
 Result := esaDrob(ADrob.Num,ADrob.Den);
end;{esaDrob}
//DirectionValue
function esaDirectionValue(): ResaDirectionValue;
begin
  Result.Nulled    := 0.0;
  Result.Loading   := 0.0;
  Result.UnLoading := 0.0;
end;{esaDirectionValue}
//Tmin
function esaTmin(): ResaTmin;
begin
  Result.Moving      := 0.0;
  Result.Waiting     := 0.0;
  Result.Manevr      := 0.0;
  Result.OnLoading   := 0.0;
  Result.OnUnLoading := 0.0;
end;{esaTmin}
//Period
function esaPeriod(): ResaPeriod;
begin
  Result.Tday                := 0;
  Result.Kshift              := 0.0;
  Result.AnimationTsec       := 0;
end;{esaPeriod}
function esaPeriod(const ATday,AAnimationTsec,AShiftTmin: Cardinal; const AShiftKweek: Single): ResaPeriod;
begin
  Result.Tday          := ATday;
  Result.AnimationTsec := AAnimationTsec;
  if AShiftTmin>0
  then Result.Kshift   := (Result.Tday/7 * 7*24*60/AShiftTmin * AShiftKweek)
  else Result.Kshift   := 0.0;
end;{esaPeriod}
//Shift
function esaShift(): ResaShift;
begin
  Result.Tmin                := 0;
  Result.NaryadTmin          := 0.0;
  Result.NaryadPlanTmin      := 0;
  Result.TurnoverTmin        := 0;
  Result.ShiftTimeUsingCoef  := esaShiftTimeUsing();
end;{esaShift}
//ShiftTimeUsing
function esaShiftTimeUsing(): ResaShiftTimeUsing;
begin
  Result.Kweek := 0.0;
  Result.Coef0 := 0.0;
  Result.Coef1 := 0.0;
  Result.Coef2 := 0.0;
  Result.Coef3 := 0;
end;{esaShiftTimeUsing}
function esaShiftTimeUsing(const ACoef0,ACoef1,ACoef2: Single; const ACoef3: TesaShiftExplosion; const AShiftTmin: Cardinal): ResaShiftTimeUsing;
var
  AShiftsCountInWeek: Cardinal;//Количество рабочих смен в неделе
  n2,n1,n0          : Cardinal;//Количество взрывных/дневных/ночных смен в неделе
begin
  Result := esaShiftTimeUsing();
  if (AShiftTmin>0)and(ACoef0>0.0)and(ACoef1>0.0)and(ACoef2>0.0) then
  begin
    Result.Coef0 := ACoef0;
    Result.Coef1 := ACoef1;
    Result.Coef2 := ACoef2;
    Result.Coef3 := ACoef3;
    //Расчет коэффициента сменных параметров
    AShiftsCountInWeek := Max(1,Round(7*24*60/AShiftTmin));
    n2 := ACoef3;                     //взрывные смены
    n1 := Max(0,5-n2);                //дневные смены = 5 рабочих дней - взрывные дни
    n0 := AShiftsCountInWeek-n2-n1;   //дневные смены = количество смен в неделе - взрывные и дневные смены
    Result.Kweek := (n0*ACoef0+n1*ACoef1+n2*ACoef2)/AShiftsCountInWeek;
  end;
end;
//Shift
function esaShift(const ATimeUsingCoef0,ATimeUsingCoef1,ATimeUsingCoef2: Single; const ATimeUsingCoef3: TesaShiftExplosion; const ATmin,ATurnoverTmin: Cardinal): ResaShift;
begin
  Result                    := esaShift();
  Result.Tmin               := ATmin;
  Result.TurnoverTmin       := ATurnoverTmin;
  if Result.Tmin>Result.TurnoverTmin then
  begin
    Result.NaryadTmin       := Result.Tmin-Result.TurnoverTmin;
    Result.NaryadPlanTmin   := Result.Tmin-Result.TurnoverTmin;
  end;{if}
  Result.ShiftTimeUsingCoef := esaShiftTimeUsing(ATimeUsingCoef0,ATimeUsingCoef1,ATimeUsingCoef2,ATimeUsingCoef3,ATmin);
end;{esaShift}
//AutoFuel
function esaAutoFuel(const ASummerCtg,AWinterCtg: Single; const AWinterMonthsCount: Byte; const ATarif: TesaAutoFuelCostTarifKind): ResaAutoFuel;
begin
  Result.SummerCtg         := ASummerCtg;
  Result.WinterCtg         := AWinterCtg;
  Result.WinterMonthsCount := AWinterMonthsCount;
  Result.Tarif             := ATarif;
  case Result.Tarif of
    fctWinter : Result.Ctg := Result.WinterCtg;
    fctSummer : Result.Ctg := Result.SummerCtg;
    else        Result.Ctg := (Result.WinterCtg*Result.WinterMonthsCount+
                               Result.SummerCtg*(12-Result.WinterMonthsCount))/12;
  end;{case}
end;{esaAutoFuel}
//Common
function esaCommon(): ResaCommon;
begin
  Result.DollarCtg                := 0.0;
  Result.YearExpensesCtg          := 0.0;
  Result.SalaryCoef               := 0.0;
  Result.AutoWorkRegime           := wrQualityAveraging;
  Result.StrippingCoefUsing       := False;
  Result.AutoDriverSalary         := esaSalary();
  Result.AutoFuel                 := esaAutoFuel(0.0,0.0,0,fctAverage);
  Result.ExcavatorMashinistSalary := esaSalary();
  Result.ExcavatorAssistantSalary := esaSalary();
  Result.ExcavatorFuelCtg         := 0.0;
  Result.ExcavatorAmortizationR   := 0.0;
end;{esaCommon}
//Salary
function esaSalary(): ResaSalary;
begin
  Result := esaSalary(0.0,0.0);
end;{esaSalary}
//Salary
function esaSalary(const ACtg0,ACtg1: Single): ResaSalary;
begin
  Result.Ctg0 := ACtg0;
  Result.Ctg1 := ACtg1;
  Result.Ctg  := Result.Ctg0 + Result.Ctg1;
end;{esaSalary}
//Autos
function esaAutos(): ResaAutos;
begin
  //Автосамосвалы
  Result.Models              := '';
  //Количественные показатели автосамосвалов
  Result.AutosCount          := 0;
  Result.TripsN              := 0;
  Result.LoadingTripsN       := 0;
  Result.UnLoadingTripsN     := 0;
  Result.NullTripsN          := 0;
  Result.RockVolume          := esaRockVolume();
  Result.Skm                 := 0.0;
  Result.LoadingSkm          := 0.0;
  Result.UnLoadingSkm        := 0.0;
  Result.NullSkm             := 0.0;
  Result.WAvgLoadingSkm      := 0.0;
  Result.AvgLoadingSkm       := 0.0;
  Result.WAvgHm              := 0.0;
  Result.AvgShiftSkm         := 0.0;
  Result.AvgShiftSkm_reis    := 0.0;
  Result.AvgVkmh             := 0.0;
  Result.AvgLoadingVkmh      := 0.0;
  Result.AvgUnLoadingVkmh    := 0.0;
  Result.AvgNullVkmh         := 0.0;
  Result.AvgTechVkmh         := 0.0;
  Result.AvgLoadingTechVkmh  := 0.0;
  Result.AvgUnLoadingTechVkmh:= 0.0;
  Result.AvgNullTechVkmh     := 0.0;
  //Расход топлива автосамосвалов
  Result.Gx                  := 0.0;
  Result.WorkGx              := 0.0;
  Result.WaitingGx           := 0.0;
  Result.LoadingGx           := 0.0;
  Result.UnLoadingGx         := 0.0;
  Result.NullGx              := 0.0;
  Result.UdGx_gr_tkm         := 0.0;
  Result.GxCtg               := 0.0;
  //Время автосамосвалов
  Result.Tmin                := 0.0;
  Result.MovingTmin          := 0.0;
  Result.WaitingTmin         := 0.0;
  Result.ManevrTmin          := 0.0;
  Result.LoadingPunktTmin    := 0.0;
  Result.UnLoadingPunktTmin  := 0.0;
  Result.AvgShiftTmin        := 0.0;
  Result.AvgTimeUsingCoef    := 0.0;
  //Шины автосамосвалов
  Result.TyresN              := 0;
  Result.TyreCtg             := 0.0;
  Result.TyresSkm            := 0.0;
  Result.UsedTyresN          := 0.0;
  Result.TyresCtg            := 0.0;
  //Стоимостные параметры автосамосвалов
  Result.Salary              := esaSalary();
  Result.Ctg                 := 0.0;
  Result.WorkCtg             := 0.0;
  Result.WaitingCtg          := 0.0;
  Result.AmortizationCtg     := 0.0;
end;{esaAutos}
//Excavators
function esaExcavators(): ResaExcavators;
begin
end;{esaExcavators}
//RockVolume
function esaRockVolume(): ResaRockVolume;
begin
  Result.Vm3 := 0.0;
  Result.Qtn := 0.0;
  Result.Qua := 0.0;
  Result.Excv := 0.0;{dwd}

end;{esaRockVolume}
function esaRockVolume(const AVm3,AQtn: Single): ResaRockVolume;
begin
  Result.Vm3 := AVm3;
  Result.Qtn := AQtn;
end;{esaRockVolume}

//Сообщение об ошибке
procedure esaMsgError(Msg: String);
begin
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'.')then Msg := Msg+'.';
  Application.MessageBox(PChar(Msg),'Ошибка',MB_ICONERROR);
end;{esaMsgError}
procedure esaMsgError(const AFormat: String; const AArgs: array of const);
begin
  esaMsgError(Format(AFormat,AArgs));
end;{esaMsgError}
//Сообщение подтверждения Yes/No
function esaMsgQuestionYN(Msg: String): Boolean;
begin
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'?')then Msg := Msg+'?';
  Result := Application.MessageBox(PChar(Msg),'Подтверждение',
                                   MB_ICONQUESTION+MB_YESNO+MB_DEFBUTTON2)=IDYES;
end;{esaMsgQuestionYN}
function esaMsgQuestionYN(const AFormat: String; const AArgs: array of const): Boolean;
begin
  Result := esaMsgQuestionYN(Format(AFormat,AArgs));
end;{esaMsgQuestionYN}
//Сообщение подтверждения Yes/No/Cancel
function esaMsgQuestionYNC(Msg: String): Integer;
begin
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'?')then Msg := Msg+'?';
  Result := Application.MessageBox(PChar(Msg),'Подтверждение',MB_ICONQUESTION+MB_YESNOCANCEL+MB_DEFBUTTON1);
end;{esaMsgQuestionYNC}
function esaMsgQuestionYNC(const AFormat: String; const AArgs: array of const): Integer;
begin
  Result := esaMsgQuestionYNC(Format(AFormat,AArgs));
end;{esaMsgQuestionYNC}
//Сообщение об информации
procedure esaMsgInformation(Msg: String);
begin
  SysUtils.Beep;
  if (Length(Msg)>1)and(Msg[Length(Msg)]<>'.')then Msg := Msg+'.';
  Application.MessageBox(PChar(Msg),'Информация',MB_ICONINFORMATION);
end;{esaMsgInformation}
procedure esaMsgInformation(const AFormat: String; const AArgs: array of const);
begin
  esaMsgInformation(Format(AFormat,AArgs));
end;{esaMsgInformation}
//Проверка при закрытии на сохранение изменений в таблице БД
function esaCanCloseModifiedQuery(AQuery: TADOQuery; const ATableName: String): boolean;
begin
  Result := True;
  if AQuery.Active and(AQuery.State in [dsEdit,dsInsert])then
  case esaMsgQuestionYNC(SesaChangesSavingConfirm,[ATableName])of
    IDYES   : AQuery.Post;
    IDNO    : AQuery.Cancel;
    IDCANCEL: Result := False;
  end;{case}
end;{esaCanCloseModifiedQuery}

//Импорт тяговых характеристик из файла Rimpull Format
function esaImportRimpullFrom(const AFileName: String;
                              var   ARimpull : ResaRimpull;
                              var   AError   : String): Boolean;
var
  f: TextFile;
  S: String;
  N: Integer;
begin
  Result := False;
  AError := '';
  try
    ARimpull.Items := nil;
    ARimpull.Count := 0;
    AssignFile(f,AFileName);
    Reset(f);
    ReadLn(f,N);
    SetLength(ARimpull.Items,N);
    N := 0;
    while not EOF(f) do
    begin
      Inc(N);
      ReadLn(f,S);
      ARimpull.Items[N-1].V100kmh := StrToInt(Copy(S,1,Pos(';',S)-1));
      ARimpull.Items[N-1].Fk100kH := StrToInt(Copy(S,Pos(';',S)+1,Length(S)-Pos(';',S)));
    end;{while}
    CloseFile(f);
    ARimpull.Count := Length(ARimpull.Items);
    Result := True;
  except
    on E: Exception do AError := Format(EesaFileNotFound,[E.Message]);
  end;{try}
end;{esaImportRimpullFrom}
//VIII. Процедуры для работы с TDBGrid --------------------------------------------------------
//Выполнение AutoWidth с помощью столбца с заданным индексом
procedure esaFitColumnByIndex(var Grid: TDBGrid; const Index: Integer);
var I,AutoWidth: Integer;
begin
  with Grid do
  begin
    AutoWidth := 0;
    for I := 0 to Columns.Count-1 do
      if I<>Index
      then AutoWidth := AutoWidth+Columns[I].Width;
    Columns[Index].Width := Grid.ClientRect.Right-AutoWidth-Columns.Count-20;
  end;{with}
end;{FitColumnByIndex}
//Нахожу Right's столбцов Grid'а в пикселях с учетом их ширины
procedure esaUpdateColumnRights(const AGrid: TDBGrid; var AColWidths: TIntegerDynArray);
var I: Integer;
begin
  with AGrid do
  begin
    if Columns.Count=0 then Exit;
    AColWidths[0] := (2+12)+Columns[0].Width;
    for I := 1 to Columns.Count-1 do
      AColWidths[I] := (AColWidths[I-1]+1)+Columns[I].Width;
  end;{with}
end;{UpdateColumnRights}
procedure esaDrawGridCell(ACanvas: TCanvas;ALeft,ATop,ARight,ABottom: Integer; Captions: array of string);
var
  ATextTop,ATextHeight,ACount,I: Integer;
begin
  with ACanvas do
  if ALeft<ARight then
  begin
    Pen.Color := clDkGray;
    MoveTo(ALeft,ABottom); LineTo(ARight,ABottom); LineTo(ARight,ATop);
    Pen.Color := clWhite;
    MoveTo(ALeft,ABottom); LineTo(ALeft,ATop);     LineTo(ARight,ATop);
    ACount := High(Captions)-Low(Captions)+1;
    if ACount>0 then
    begin
      ATextHeight := TextHeight('S');
      ATextTop := ATop+(((ABottom-ATop+1)-ACount*ATextHeight-(ACount-1)*5)div 2);
      for I := 0 to ACount-1 do
        TextOut((ARight+ALeft-TextWidth(Captions[I]))div 2,
                ATextTop+I*(ATextHeight+5),
                Captions[I]);
    end;{if}
  end;{with}
end;{DrawGridCell}
procedure esaDrawGridTitle(var APaintBox: TPaintBox; var AGrid: TDBGrid;
                       const AMaxRowCount: Integer; AColWidths: TIntegerDynArray);
var
  Cvs: TCanvas;
  I: Integer;
  ASize: TPoint;
begin
  Cvs := APaintBox.Canvas;
  with Cvs do
  begin
    ASize := Point(APaintBox.Width-3,APaintBox.Height);
    Pen.Color := clBtnFace;
    Brush.Color := clBtnFace;
    Rectangle(0,0,APaintBox.Width,APaintBox.Height);
    Pen.Color := clDkGray;
    MoveTo(0,ASize.Y);
    LineTo(0,0);
    LineTo(ASize.X,0);
    LineTo(ASize.X,ASize.Y);
    with AGrid do
    begin
      //индикатор
      esaDrawGridCell(Cvs,2,1,13,AMaxRowCount*hCell,[]);
      //полоса прокрутки
      with Columns[Columns.Count-1] do
        esaDrawGridCell(Cvs,AColWidths[Columns.Count-1]+1,1,Grid.Width-3,AMaxRowCount*hCell,[]);
      //нумерация столбцов
      for I := 0 to Columns.Count-1 do
        with Columns[I] do
          esaDrawGridCell(Cvs,AColWidths[I]-Width,
                   (AMaxRowCount-1)*hCell+1,AColWidths[I],
                   AMaxRowCount*hCell,[IntToStr(I+1)]);
    end;{with}
  end;{with}
end;{DrawGridTitle}
//Прорисовываю ячейку DBGrid'а
procedure esaDrawDBGridColumnCell(var ADBGrid: TDBGrid;
                               const Rect: TRect;
                               const DataCol: Integer;
                               const Column: TColumn;
                               const State: TGridDrawState);
begin
  with ADBGrid do
  begin
    if Column.ReadOnly then
    begin
      Canvas.Brush.Color := clLtGrayEx;
      Canvas.Font.Color := clWindowText;
    end;{if}
    if gdFocused in State then
    begin
      Canvas.Brush.Color := clActiveCaption;
      Canvas.Font.Color := clWindow;
    end;{if}
    DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;{with}
end;{dbgAutoEnginesDrawDBGridColumnCell}
//Рисую галочку для Boolean поля DBGrid'a
procedure esaDrawDBGridTick(const ACanvas: TCanvas; const ARect: TRect; const AValue: Boolean);
var
  ACell: TRect;
  ACenter: TPoint;
begin
  with ACanvas,ACell do
  begin
    FillRect(ARect);
    ACenter := Point((ARect.Left+ARect.Right)div 2,(ARect.Top+ARect.Bottom)div 2);
    ACell := Types.Rect(ACenter.X-6,ACenter.Y-6,ACenter.X+6,ACenter.Y+6);
    //рисую квадратик checkbox'a
    Pen.Color := clGrayEx;  //темный
    MoveTo(Left,Bottom-1); LineTo(Left,Top); LineTo(Right,Top);
    Pen.Color := clLightGrayEx;  //самый светлый
    MoveTo(Left+1,Bottom-1);LineTo(Right-1,Bottom-1);LineTo(Right-1,Top);
    Pen.Color := clDarkGrayEx;  //самый темный
    MoveTo(Left+1,Bottom-2);LineTo(Left+1,Top+1);LineTo(Right-1,Top+1);
    //рисую галочку checkbox'a
    if AValue then
    begin
      Pen.Color := clBlack;
      MoveTo(Left+3,Top+5); LineTo(Left+5,Top+7); LineTo(Left+10,Top+2);
      MoveTo(Left+3,Top+6); LineTo(Left+5,Top+8); LineTo(Left+10,Top+3);
      MoveTo(Left+3,Top+7); LineTo(Left+5,Top+9); LineTo(Left+10,Top+4);
    end;{if}
  end{if}
end;{esaDrawDBGridTick}
//IV. Процедуры для ввода некоторых значений --------------------------------------------------
//Ввод текстового значения 
function esaInputName(const ACaption,APrompt: string;
                   var AValue: string;
                   const AMaxLength: Word;
                   const AAllowBlank: boolean = false): boolean;
var
  fmDlg: TForm;
  ledName: TLabeledEdit;
  btOk,btCancel: TButton;
begin
  AValue := Trim(AValue);
  if (AMaxLength>0)and(Length(AValue)>AMaxLength) then SetLength(AValue,AMaxLength);
  fmDlg := esaCreateDialogForm(ACaption,400,128);
  try
    ledName := TLabeledEdit.Create(fmDlg);
    esaSetLabeledEditProperties(ledName,fmDlg,APrompt,AValue,16,24,368,AMaxLength,[akLeft,akTop,akRight]);
    btOk := TButton.Create(fmDlg);
    esaSetButtonProperties(btOk,fmDlg,Point(224,64),'Ok',true,false,mrOk);
    btCancel := TButton.Create(fmDlg);
    esaSetButtonProperties(btCancel,fmDlg,Point(304,64),'Отмена',false,true,mrCancel);
    repeat
      Result := fmDlg.ShowModal=mrOk;
      ledName.Text := Trim(ledName.Text);
      if (not AAllowBlank)and(ledName.Text='')and Result
      then esaMsgError('Не введено значение "'+APrompt+'".');
    until ((not AAllowBlank)and(ledName.Text<>''))OR AAllowBlank OR (not Result);
    AValue := ledName.Text;
    if (AMaxLength>0)and(Length(AValue)>AMaxLength) then SetLength(AValue,AMaxLength);
  finally
    fmDlg.Free;
  end;{try}
end;{InputName}
//Ввод текстового значения в поле таблицы БД
function esaInputNameEx(const ACaption,APrompt,AFieldName: string;
                     const AQuery: TADOQuery;
                     var AValue: String;
                     const AAllowBlank: boolean = false): boolean;
var
  fmDlg: TForm;
  cbName: TComboBox;
  btOk,btCancel: TButton;
  lbName: TLabel;
begin
  fmDlg := esaCreateDialogForm(ACaption,400,128);
  try
    lbName := TLabel.Create(fmDlg);
    esaSetLabelProperties(lbName,fmDlg,Point(16,8),APrompt);
    cbName := TComboBox.Create(fmDlg);
    with cbName do
    begin
      Parent := fmDlg; Left := 16; Top := 24; Width := 368;
      Anchors := [akLeft,akTop,akRight];
      Style := csDropDownList;
      if AAllowBlank then cbName.Items.Add('');
      AQuery.First;
      while not AQuery.Eof do
      begin
        cbName.Items.Add(AQuery.FieldByName(AFieldName).AsString);
        AQuery.Next;
      end;{while}
      if cbName.Items.Count>0 then cbName.ItemIndex := cbName.Items.IndexOf(AValue);
      if cbName.ItemIndex=-1 then cbName.ItemIndex := 0;
    end;{with}
    btOk := TButton.Create(fmDlg);
    esaSetButtonProperties(btOk,fmDlg,Point(224,64),'Ok',true,false,mrOk);
    btCancel := TButton.Create(fmDlg);
    esaSetButtonProperties(btCancel,fmDlg,Point(304,64),'Отмена',false,true,mrCancel);
    Result := fmDlg.ShowModal=mrOk;
    if Result then AValue := cbName.Text;
  finally
    fmDlg.Free;
  end;{try}
end;{InputNameEx}
//XIV. Процедуры создания компонентов ---------------------------------------------------------
//Создаю диалоговое окно
function esaCreateDialogForm(const ACaption: String; const AWidth,AHeight: Integer): TForm;
begin
  Result := TForm.Create(nil);
  try
    Result.Width := AWidth;
    Result.Height := AHeight;
    Result.Caption := ACaption;
    Result.BorderStyle := bsDialog;
    Result.Position := poScreenCenter;
  except
    Result.Free;
    Result := nil;
  end;{try}
end;{CreateDialogForm}
//Устанавливаю свойства в LabeledEdit
procedure esaSetLabeledEditProperties(var ALabeledEdit: TLabeledEdit;
                                   const AParent: TWinControl;
                                   const APrompt,AText: String;
                                   const ALeft,ATop,AWidth: Integer;
                                   const AMaxLength: Integer;
                                   const AAnchors: TAnchors);
begin
  ALabeledEdit.Parent := AParent;
  ALabeledEdit.Left := ALeft;
  ALabeledEdit.Top := ATop;
  ALabeledEdit.Width := AWidth;
  ALabeledEdit.Anchors := AAnchors;
  ALabeledEdit.EditLabel.Caption := APrompt;
  ALabeledEdit.Text := AText;
  ALabeledEdit.MaxLength := AMaxLength;
end;{SetLabeledEditProperties}
//Устанавливаю свойства в TButton
procedure esaSetButtonProperties(const AButton: TButton;
                              const AParent: TWinControl;
                              const APosition: TPoint;
                              const ACaption: String;
                              const ADefault,ACancel: Boolean;
                              const AModalResult: TModalResult);
begin
  AButton.Parent := AParent;
  AButton.Left := APosition.X;
  AButton.Top := APosition.Y;
  AButton.Width := 72;
  AButton.Caption := ACaption;
  AButton.Default := ADefault;
  AButton.Cancel := ACancel;
  AButton.ModalResult := AModalResult;
end;{SetButtonProperties}
//Устанавливаю свойства в TLabel
procedure esaSetLabelProperties(const ALabel: TLabel;
                             const AParent: TWinControl;
                             const APosition: TPoint;
                             const ACaption: String);
begin
  ALabel.Parent := AParent;
  ALabel.Left := APosition.X;
  ALabel.Top := APosition.Y;
  ALabel.Caption := ACaption;
end;{SetLabelProperties}
//Создаю ProgressBar
function esaCreateProgressBar(const AOwner : TComponent;
                           const AParent: TWinControl;
                           const APosition: TPoint;
                           const AWidth: Integer): TProgressBar;
begin
  Result := TProgressBar.Create(AOwner);
  Result.Parent := AParent;
  Result.Left := APosition.X;
  Result.Top := APosition.Y;
  Result.Width := AWidth;
end;{CreateProgressBar}
//IX. Процедуры соответствия значений полей таблиц БД заданному диапазону ---------------------
//Проверка значения FloatField'a: Field.AsFloat > AMin
function IsFloatFieldMoreMin(AField: TField; const AMin: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := AField.AsFloat>AMin;
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть больше %f.',[AField.DisplayLabel,AMin]));
end;{IsFloatFieldMoreMin}
//Проверка значения FloatField'a: Field.AsFloat >= AMin
function IsFloatFieldMoreEqualMin(AField: TField; const AMin: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := AField.AsFloat>=AMin;
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть не меньше %f.',[AField.DisplayLabel,AMin]));
end;{IsFloatFieldMoreEqualMin}
//Проверка значения FloatField'a: Field.AsFloat in [AMin,AMax]  с точностью 0.1 
function IsFloatFieldInRange1(AField: TField; const AMin,AMax: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := InRange(Round(AField.AsFloat*10),Round(AMin*10),Round(AMax*10));
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть в [%.1f, %.1f].',[AField.DisplayLabel,AMin,AMax]));
end;{IsFloatFieldInRange1}
//Проверка значения FloatField'a: Field.AsFloat in [AMin,AMax]  с точностью 0.01
function IsFloatFieldInRange2(AField: TField; const AMin,AMax: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := InRange(Round(AField.AsFloat*100),Round(AMin*100),Round(AMax*100));
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть в [%.2f, %.2f].',[AField.DisplayLabel,AMin,AMax]));
end;{IsFloatFieldInRange2}
//Проверка значения FloatField'a: Field.AsFloat in [AMin,AMax]  с точностью 0.001 
function IsFloatFieldInRange3(AField: TField; const AMin,AMax: Single): Boolean;
begin
  if AField.Value=null then AField.AsFloat := 0.0;
  Result := InRange(Round(AField.AsFloat*1000),Round(AMin*1000),Round(AMax*1000));
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть в [%.3f, %.3f].',[AField.DisplayLabel,AMin,AMax]));
end;{IsFloatFieldInRange3}
//Проверка значения IntegerField'a: Field.AsInteger > AMin
function IsIntegerFieldMoreMin(AField: TField; const AMin: Integer): Boolean;
begin
  if AField.Value=null then AField.AsInteger := 0;
  Result := AField.AsInteger>AMin;
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть больше %d.',[AField.DisplayLabel,AMin]));
end;{IsIntegerFieldMoreMin}
//Проверка значения IntegerField'a: Field.AsInteger >= AMin
function IsIntegerFieldMoreEqualMin(AField: TField; const AMin: Integer): Boolean;
begin
  if AField.Value=null then AField.AsInteger := 0;
  Result := AField.AsInteger>=AMin;
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть не меньше %d.',[AField.DisplayLabel,AMin]));
end;{IsIntegerFieldMoreEqualMin}
//Проверка значения IntegerField'a: Field.AsInteger in [AMin,AMax]  с точностью 0.1
function IsIntegerFieldInRange(AField: TField; const AMin,AMax: Integer): Boolean;
begin
  if AField.Value=null then AField.AsInteger := 0;
  Result := InRange(AField.AsInteger,AMin,AMax);
  if not Result
  then esaMsgError(Format('Значение поля "%s" должно быть в [%d, %d].',[AField.DisplayLabel,AMin,AMax]));
end;{IsIntegerFieldInRange}



//X. Процедуры соответствия значений полей(в текстовом формате) заданному диапазону -----------
//Проверка соответствия целых значений полей(в текстовом формате) заданному диапазону
function esaCheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Integer;
                       const AIsBlankAllowed: Boolean): Boolean;
begin
  Result := true;
  try
    if not(AIsBlankAllowed and(AValue='')) then StrToInt(AValue);
  except
    Result := false; esaMsgError(Format(EesaInvalidIntegerValue,[AValue,APrompt]));
  end;{try}
  if Result and(AValue<>'')and(not InRange(StrToInt(AValue),AMin,AMax))then
  begin
    Result := false; esaMsgError(Format(EesaInvalidIntegerValueEx,[AValue,APrompt,AMin,AMax]));
  end;{if}
end;{CheckStrValue}
//Проверка соответствия вещественных значений полей(в текстовом формате) заданному диапазону
function esaCheckStrValue(const AValue,APrompt: String;
                       const AMin,AMax: Single;
                       const AIsBlankAllowed: Boolean): Boolean;
begin
  Result := true;
  try
    if not(AIsBlankAllowed and(AValue='')) then StrToFloat(AValue);
  except
    Result := false; esaMsgError(Format(EesaInvalidSingleValue,[AValue,APrompt]));
  end;{try}
  if Result and(AValue<>'')and(not InRange(StrToFloat(AValue),AMin,AMax))then
  begin
    Result := false; esaMsgError(Format(EesaInvalidSingleValueEx,[AValue,APrompt,AMin,AMax]));
  end;{if}
end;{CheckStrValue}


end.
