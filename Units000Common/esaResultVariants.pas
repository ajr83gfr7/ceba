unit esaResultVariants;

interface
uses
  ADODb, esaGlobals;
type
  //��������� ������������� -----------------------------------------------------------------------------
  TesaResultVariant = class
  private
    FId_ResultVariant: Integer;//��� �������� �������������
    FQuery           : TADOQuery;
    FPlanRatio       : Single;    //������� ���������� ����� �� ����, %
    FUdCtg_m3        : Single;    //�������� ������� ������� �� ����, ��/�3
    FUdCtg_tn        : Single;    //�������� ������� ������� �� ����, ��/�
    FPlannedRockVolumeCm        : Single;    //������������ ����� ������ �����, ���. �3 (SEE)
  protected
    property Query: TADOQuery read FQuery;
  public
    property Id_ResultVariant: Integer read FId_ResultVariant;
    //�����������
    constructor Create(const AConnection: TADOConnection); virtual;
    destructor Destroy; override;
    //���������� ��������
    procedure Append(const AOpenpit: String; const AShift: ResaShift; const APeriod: ResaPeriod; const ACommon: ResaCommon);
    //���������� ���������� �� ��������������
    procedure SaveAutos(
      const AAutos              : String;             //�������������
      const AAutosCount0        : Integer;            //���������� �������������� � ������� ���������
      const AAutosCount1        : Integer;            //���������� �������������� � ��������� ���������
      const ATripsCount         : ResaDirectionValue; //���������� ������ �� ������������ ��������
      const ARockVolume         : ResaRockVolume;     //�����/��� ������������ ��, �3/�
      const ASmetr              : ResaDirectionValue; //������ �� ������������ ��������, �
      const AWAvgSkmLoading     : ResaDrobValue;      //���������������� ���������� �����������������,��*� //���� ��� ������� � ���������� ��������!
      const AWAvgHm             : ResaDrobValue;      //������� ������ �������, �
      const AAvgVkmh            : ResaDrobValue;      //������� ��������, ��/�
      const AAvgVkmhNulled      : ResaDrobValue;      //������� �������� � ������� �����������
      const AAvgVkmhLoading     : ResaDrobValue;      //������� �������� � �������� �����������
      const AAvgVkmhUnLoading   : ResaDrobValue;      //������� �������� � ������������ �����������
      const AGx                 : ResaWorkValue;      //������ �������, � (� ������,� �������)
      const ADirGx              : ResaDirectionValue; //������ ������� �� ������������, �
      const AUdGx_gr_tkm        : Single;             //������� ������ �������, �/���
      const ALoadingSkmRockQtn  : Single;             //�����������, ���
      const ATsec               : ResaTmin;           //�����, ���
      const ADirTsec            : ResaDirectionValue; //����� �� ������������, ���
      const ATyresCount         : Single;             //���������� ���
      const AUsedTyresCount     : Single;             //���������� ��������������� ���
      const ASumTyresCtg        : Single;             //������� �� ����, ��
      const ASumGxCtg           : ResaWorkValue;      //������� �� ������� � ������ � �������, ��
      const ASumExploatationCtg : ResaWorkValue;      //������� ���������������� (� ������ � �������), ��
      const ASumSparesGxCtg     : ResaWorkValue;      // - ������� �� �������� ��� �������������, ��/�����
      const ASumMaterialsGxCtg  : ResaWorkValue;      // - ������� �� ��������� ��������� ��� �������������, ��/�����
      const ASumMaintenanceCtg  : ResaWorkValue;      // - ������� �� ���������� ���������� ��������� ��� �������������, ��/�����
      const ASumSalaryCtg       : ResaWorkValue;      // - ������� �� �������� ��� �������������, ��/�����
      const ASumAmortizationCtg : Single);            //�������� ��������������� ������, ��
    //���������� ���������� �� ������������
    procedure SaveExcavators(
      const AExcavators             : String;         //�����������
      const AExcavatorsCount0       : Integer;        //���������� ������������ � ������� ���������
      const AExcavatorsCount1       : Integer;        //���������� ������������ � ��������� ���������
      const AAutosCount             : Single;         //���������� ����������� ��������������
      const ARockVolume             : ResaRockVolume; //����� ���������� ��, �3
      const APlanRockVolume         : ResaRockVolume; //�������� ����� �� �� �����, �3
      const ASumGx                  : ResaWorkValue;  //������ ��������������, ���*�
      const ASumTmin                : ResaTmin;       //�����, ��� (� ������,�������,��� ��������)
      const ASumExploatationCtg     : ResaWorkValue;  //������� ���������������� (� ������ � �������), ��
      const ASumGxCtg               : ResaWorkValue;      // - ������� �� ��������������, ��/�����
      const ASumMaterialsGxCtg      : ResaWorkValue;      // - ������� �� ���������, ��/�����
      const ASumUnAccountedCtg      : ResaWorkValue;      // - ������� ����������, ��/�����
      const ASumSalaryCtg           : ResaWorkValue;      // - ������� �� ��������, ��/�����
      const ASumAmortizationCtg     : Single);        //�������� ��������������� ������, ��
    //���������� ���������� �� ����-��������
    procedure SaveBlocks(
      const ABlocksCount               : Integer;           //���������� ����-��������
      const ALsm                       : Integer;           //�����, c�
      const ARockVolume                : ResaRockVolume;    //����� ������������ ������ �����
      const AAutosCount                : ResaDirectionValue;//���������� ��������������
      const AWaitingsCount             : ResaDirectionValue;//���������� �������� ��������������
      const AAvgVkmhNulled             : ResaDrobValue;     //������� �������� �������� �������������� � ������� �����������, ��/�
      const AAvgVkmhLoading            : ResaDrobValue;     //������� �������� �������� �������������� � �������� �����������, ��/�
      const AAvgVkmhUnLoading          : ResaDrobValue;     //������� �������� �������� �������������� � ������������ �����������, ��/�
      const AMovingAvgTminNulled       : ResaDrobValue;     //������� ����� �������� �������������� � ������� �����������, ���
      const AMovingAvgTminLoading      : ResaDrobValue;     //������� ����� �������� �������������� � �������� �����������, ���
      const AMovingAvgTminUnLoading    : ResaDrobValue;     //������� ����� �������� �������������� � ������������ �����������, ���
      const AWaitingAvgTminNulled      : ResaDrobValue;     //������� ����� �������� �������������� � ������� �����������, ���
      const AWaitingAvgTminLoading     : ResaDrobValue;     //������� ����� �������� �������������� � �������� �����������, ���
      const AWaitingAvgTminUnLoading   : ResaDrobValue;     //������� ����� �������� �������������� � ������������ �����������, ���
      const AEmploymentCoef            : Single;
      const AGx                        : ResaDirectionValue;//������ ������� �������������� �� ������������, �
      const AUdGx_l_m                  : Single;
      const ARepairCtg                 : Single;            //������� �� �����������, ��
      const AAmortizationCtg           : Single);           //��������������� ����������, ��
    //���������� ���������� �������������
    procedure SaveEconomParams(const AExpensesCtg: Single);//���������� � ���������� �������,��
    procedure UpdateProductivity();
  end;{TesaResultVariant}

implementation
uses SysUtils,unDM;

//��������� ������������� -------------------------------------------------------------------------------
//�����������
constructor TesaResultVariant.Create(const AConnection: TADOConnection);
begin
  inherited Create;
  FId_ResultVariant := 0;
  FUdCtg_m3 := 0.0;
  FUdCtg_tn := 0.0;
  FPlanRatio:= 0.0;
  FQuery := TADOQuery.Create(nil);
  Query.Connection := AConnection;
  Query.SQL.Text   := 'SELECT * FROM _ResultVariants ORDER BY SortIndex';
  Query.Open;
end;{Create}
destructor TesaResultVariant.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;{Destroy}
//���������� ��������
procedure TesaResultVariant.Append( const AOpenpit: String;
                                    const AShift: ResaShift;
                                    const APeriod: ResaPeriod;
                                    const ACommon: ResaCommon);
var ASortIndex: Integer;
begin
  UpdateProductivity();
  if not Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    ASortIndex := Query.RecordCount+1;
    Query.Append;
    Query.FieldByName('SortIndex').AsInteger       := ASortIndex;
    Query.FieldByName('VariantDate').AsFloat       := Now;
    Query.FieldByName('IsPrint').AsBoolean         := True;
  end{if}
  else Query.Edit;
  Query.FieldByName('Variant').AsString            := AOpenpit;
  Query.FieldByName('PeriodTday').AsFloat          := APeriod.Tday;
  Query.FieldByName('PeriodKshift').AsFloat        := APeriod.Kshift;
  Query.FieldByName('ShiftTmin').AsFloat           := AShift.Tmin;
  Query.FieldByName('ShiftNaryadFactTmin').AsFloat := AShift.NaryadTmin;
  Query.FieldByName('ShiftTurnoverTmin').AsFloat   := AShift.TurnoverTmin;
  Query.FieldByName('ShiftKweek').AsFloat          := AShift.ShiftTimeUsingCoef.Kweek;
  Query.FieldByName('DollarCtg').AsFloat           := ACommon.DollarCtg;
  //@SEE added
  Query.FieldByName('CurrOreQtn').AsFloat          := ACommon.CurrOreQtn;
  Query.FieldByName('CurrOreVm3').AsFloat          := ACommon.CurrOreVm3;
  Query.FieldByName('CurrStrippingQtn').AsFloat    := ACommon.CurrStrippingQtn;
  Query.FieldByName('CurrStrippingVm3').AsFloat    := ACommon.CurrStrippingVm3;
  Query.FieldByName('Ks').AsFloat                  := ACommon.CurrStrippingCoef;
  Query.Post;

  FId_ResultVariant := Query.FieldByName('Id_ResultVariant').AsInteger;
  Query.Requery;
end;{Append}
//���������� ���������� �� ��������������
procedure TesaResultVariant.SaveAutos(
  const AAutos              : String;             //�������������
  const AAutosCount0        : Integer;            //���������� �������������� � ������� ���������
  const AAutosCount1        : Integer;            //���������� �������������� � ��������� ���������
  const ATripsCount         : ResaDirectionValue; //���������� ������ �� ������������ ��������
  const ARockVolume         : ResaRockVolume;     //�����/��� ������������ ��, �3/�
  const ASmetr              : ResaDirectionValue; //������ �� ������������ ��������, �
  const AWAvgSkmLoading     : ResaDrobValue;      //���������������� ���������� �����������������,��*� //���� ��� ������� � ���������� ��������!
  const AWAvgHm             : ResaDrobValue;      //������� ������ �������, �
  const AAvgVkmh            : ResaDrobValue;      //������� ��������, ��/�
  const AAvgVkmhNulled      : ResaDrobValue;      //������� �������� � ������� �����������
  const AAvgVkmhLoading     : ResaDrobValue;      //������� �������� � �������� �����������
  const AAvgVkmhUnLoading   : ResaDrobValue;      //������� �������� � ������������ �����������
  const AGx                 : ResaWorkValue;      //������ �������, � (� ������,� �������)
  const ADirGx              : ResaDirectionValue; //������ ������� �� ������������, �
  const AUdGx_gr_tkm        : Single;             //������� ������ �������, �/���
  const ALoadingSkmRockQtn  : Single;             //�����������, ���
  const ATsec               : ResaTmin;           //�����, ���
  const ADirTsec            : ResaDirectionValue; //����� �� ������������, ���
  const ATyresCount         : Single;             //���������� ���
  const AUsedTyresCount     : Single;             //���������� ��������������� ���
  const ASumTyresCtg        : Single;             //������� �� ����, ��
  const ASumGxCtg           : ResaWorkValue;      //������� �� ������� � ������ � �������, ��
  const ASumExploatationCtg : ResaWorkValue;      //������� ���������������� (� ������ � �������), �� 
  const ASumSparesGxCtg     : ResaWorkValue;      // - ������� �� �������� ��� �������������, ��/�����
  const ASumMaterialsGxCtg  : ResaWorkValue;      // - ������� �� ��������� ��������� ��� �������������, ��/�����
  const ASumMaintenanceCtg  : ResaWorkValue;      // - ������� �� ���������� ���������� ��������� ��� �������������, ��/�����
  const ASumSalaryCtg       : ResaWorkValue;      // - ������� �� �������� ��� �������������, ��/�����
  const ASumAmortizationCtg : Single);            //�������� ��������������� ������, ��
begin
  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('Autos').AsString                      := AAutos;
    Query.FieldByName('AutosAutosCount0').AsFloat            := AAutosCount0;
    Query.FieldByName('AutosAutosCount1').AsFloat            := AAutosCount1;
    Query.FieldByName('AutosTripsCountNulled').AsFloat       := ATripsCount.Nulled;
    Query.FieldByName('AutosTripsCountLoading').AsFloat      := ATripsCount.Loading;
    Query.FieldByName('AutosTripsCountUnLoading').AsFloat    := ATripsCount.UnLoading;
    Query.FieldByName('AutosRockVm3').AsFloat                := ARockVolume.Vm3;
    Query.FieldByName('AutosRockQtn').AsFloat                := ARockVolume.Qtn;
    Query.FieldByName('AutosSkmNulled').AsFloat              := ASmetr.Nulled*0.001;
    Query.FieldByName('AutosSkmLoading').AsFloat             := ASmetr.Loading*0.001;
    Query.FieldByName('AutosSkmUnLoading').AsFloat           := ASmetr.UnLoading*0.001;
    Query.FieldByName('AutosLoadingWAvgSkm').AsFloat         := esaDrob(AWAvgSkmLoading.Num,AWAvgSkmLoading.Den);
    Query.FieldByName('AutosLoadingAvgSkm').AsFloat          := esaDrob(ASmetr.Loading*0.001,ATripsCount.Loading);
    Query.FieldByName('AutosWAvgHm').AsFloat                 := esaDrob(AWAvgHm.Num,AWAvgHm.Den);
    Query.FieldByName('AutosShiftAvgSkm').AsFloat            := esaDrob(esaSummary(ASmetr)*0.001,AAutosCount0);
    Query.FieldByName('AutosShiftAvgSkm_reis').AsFloat       := esaDrob(esaSummary(ASmetr)*0.001,esaSummary(ATripsCount));
    Query.FieldByName('AutosAvgVkmhNulled').AsFloat          := esaDrob(AAvgVkmhNulled.Num,AAvgVkmhNulled.Den);
    Query.FieldByName('AutosAvgVkmhLoading').AsFloat         := esaDrob(AAvgVkmhLoading.Num,AAvgVkmhLoading.Den);
    Query.FieldByName('AutosAvgVkmhUnLoading').AsFloat       := esaDrob(AAvgVkmhUnLoading.Num,AAvgVkmhUnLoading.Den);
    Query.FieldByName('AutosAvgTechVkmh').AsFloat            := esaDrob(3.6*esaSummary(ASmetr),esaSummary(ATsec)-ATsec.Waiting);
    Query.FieldByName('AutosGxWork').AsFloat                 := AGx.Work;
    Query.FieldByName('AutosGxWaiting').AsFloat              := AGx.Waiting;
    Query.FieldByName('AutosGxNulled').AsFloat               := ADirGx.Nulled;
    Query.FieldByName('AutosGxLoading').AsFloat              := ADirGx.Loading;
    Query.FieldByName('AutosGxUnLoading').AsFloat            := ADirGx.UnLoading;
    Query.FieldByName('AutosUdGx_gr_tkm').AsFloat            := AUdGx_gr_tkm;
    Query.FieldByName('AutosGxCtg').AsFloat                  := esaSummary(ASumGxCtg);
    Query.FieldByName('AutosTminMoving').AsFloat             := ATsec.Moving/60;
    Query.FieldByName('AutosTminWaiting').AsFloat            := ATsec.Waiting/60;
    Query.FieldByName('AutosTminManevr').AsFloat             := ATsec.Manevr/60;
    Query.FieldByName('AutosTminOnLoading').AsFloat          := ATsec.OnLoading/60;
    Query.FieldByName('AutosTminOnUnLoading').AsFloat        := ATsec.OnUnLoading/60;
    Query.FieldByName('AutosTminNulled').AsFloat             := ADirTsec.Nulled/60;
    Query.FieldByName('AutosTminLoading').AsFloat            := ADirTsec.Loading/60;
    Query.FieldByName('AutosTminUnLoading').AsFloat          := ADirTsec.UnLoading/60;
    Query.FieldByName('AutosReysAvgTminNulled').AsFloat      := esaDrob(ADirTsec.Nulled,60*ATripsCount.Nulled);
    Query.FieldByName('AutosReysAvgTminLoading').AsFloat     := esaDrob(ADirTsec.Loading,60*ATripsCount.Loading);
    Query.FieldByName('AutosReysAvgTminUnLoading').AsFloat   := esaDrob(ADirTsec.UnLoading,60*ATripsCount.UnLoading);
    Query.FieldByName('AutosAvgTimeUsingCoef').AsFloat       := esaDrob(esaSummary(ATsec)-ATsec.Waiting,esaSummary(ATsec));
    Query.FieldByName('AutosTyresCount').AsFloat             := ATyresCount;
    Query.FieldByName('AutosTyresSkm').AsFloat               := esaSummary(ASmetr)*(1E-3);
    Query.FieldByName('AutosUsedTyresCount').AsFloat         := AUsedTyresCount;
    Query.FieldByName('AutosTyresCtg').AsFloat               := ASumTyresCtg;
    Query.FieldByName('AutosWorkSumGxCtg').AsFloat           := ASumGxCtg.Work;
    Query.FieldByName('AutosWorkSumTyresCtg').AsFloat        := ASumTyresCtg;
    Query.FieldByName('AutosWorkSparesCtg').AsFloat          := ASumSparesGxCtg.Work;
    Query.FieldByName('AutosWorkMaterialsCtg').AsFloat       := ASumMaterialsGxCtg.Work;
    Query.FieldByName('AutosWorkMaintenancesCtg').AsFloat    := ASumMaintenanceCtg.Work;
    Query.FieldByName('AutosWorkSalariesCtg').AsFloat        := ASumSalaryCtg.Work;
    Query.FieldByName('AutosWaitingSumGxCtg').AsFloat        := ASumGxCtg.Waiting;
    Query.FieldByName('AutosWaitingSparesCtg').AsFloat       := ASumSparesGxCtg.Waiting;
    Query.FieldByName('AutosWaitingMaterialsCtg').AsFloat    := ASumMaterialsGxCtg.Waiting;
    Query.FieldByName('AutosWaitingMaintenancesCtg').AsFloat := ASumMaintenanceCtg.Waiting;
    Query.FieldByName('AutosWaitingSalariesCtg').AsFloat     := ASumSalaryCtg.Waiting;
    Query.FieldByName('AutosAmortizationCtg').AsFloat        := ASumAmortizationCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveAutos}
//���������� ���������� �� ������������
procedure TesaResultVariant.SaveExcavators(
  const AExcavators             : String;         //�����������
  const AExcavatorsCount0       : Integer;        //���������� ������������ � ������� ���������
  const AExcavatorsCount1       : Integer;        //���������� ������������ � ��������� ���������
  const AAutosCount             : Single;         //���������� ����������� ��������������
  const ARockVolume             : ResaRockVolume; //����� ���������� ��, �3
  const APlanRockVolume         : ResaRockVolume; //�������� ����� �� �� �����, �3
  const ASumGx                  : ResaWorkValue;  //������ ��������������, ���*�
  const ASumTmin                : ResaTmin;       //�����, ��� (� ������,�������,��� ��������)
  const ASumExploatationCtg     : ResaWorkValue;  //������� ���������������� (� ������ � �������), ��
  const ASumGxCtg               : ResaWorkValue;      // - ������� �� ��������������, ��/�����
  const ASumMaterialsGxCtg      : ResaWorkValue;      // - ������� �� ���������, ��/�����
  const ASumUnAccountedCtg      : ResaWorkValue;      // - ������� ����������, ��/�����
  const ASumSalaryCtg           : ResaWorkValue;      // - ������� �� ��������, ��/�����
  const ASumAmortizationCtg     : Single);        //�������� ��������������� ������, ��
begin
  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('Excavators').AsString                      := AExcavators;
    Query.FieldByName('ExcavatorsExcavatorsCount0').AsFloat       := AExcavatorsCount0;
    Query.FieldByName('ExcavatorsExcavatorsCount1').AsFloat       := AExcavatorsCount1;
    Query.FieldByName('ExcavatorsAutosCount').AsFloat             := AAutosCount;
    Query.FieldByName('ExcavatorsRockVm3').AsFloat                := ARockVolume.Vm3;
    Query.FieldByName('ExcavatorsRockQtn').AsFloat                := ARockVolume.Qtn;
    Query.FieldByName('ExcavatorsPlanRockVm3').AsFloat            := APlanRockVolume.Vm3;
    Query.FieldByName('ExcavatorsPlanRockQtn').AsFloat            := APlanRockVolume.Qtn;

    Query.FieldByName('ExcavatorsGxWork').AsFloat                 := ASumGx.Work;
    Query.FieldByName('ExcavatorsGxWaiting').AsFloat              := ASumGx.Waiting;

    Query.FieldByName('ExcavatorsTminWork').AsFloat               := ASumTmin.OnLoading;
    Query.FieldByName('ExcavatorsTminWaiting').AsFloat            := ASumTmin.Waiting;
    Query.FieldByName('ExcavatorsTminManevr').AsFloat             := ASumTmin.Manevr;
    Query.FieldByName('ExcavatorsUsingPunktCoef').AsFloat         := esaDrob(ASumTmin.OnLoading+ASumTmin.Manevr,esaSummary(ASumTmin));
    Query.FieldByName('ExcavatorsUsingTimeCoef').AsFloat          := esaDrob(ASumTmin.OnLoading,esaSummary(ASumTmin));

    Query.FieldByName('ExcavatorsWorkSumGxCtg').AsFloat           := ASumGxCtg.Work;
    Query.FieldByName('ExcavatorsWorkMaterialsCtg').AsFloat       := ASumMaterialsGxCtg.Work;
    Query.FieldByName('ExcavatorsWorkUnAccountedCtg').AsFloat     := ASumUnAccountedCtg.Work;
    Query.FieldByName('ExcavatorsWorkSalariesCtg').AsFloat        := ASumSalaryCtg.Work;
    Query.FieldByName('ExcavatorsWaitingSumGxCtg').AsFloat        := ASumGxCtg.Waiting;
    Query.FieldByName('ExcavatorsWaitingMaterialsCtg').AsFloat    := ASumMaterialsGxCtg.Waiting;
    Query.FieldByName('ExcavatorsWaitingUnAccountedCtg').AsFloat  := ASumUnAccountedCtg.Waiting;
    Query.FieldByName('ExcavatorsWaitingSalariesCtg').AsFloat     := ASumSalaryCtg.Waiting;
    Query.FieldByName('ExcavatorsAmortizationCtg').AsFloat        := ASumAmortizationCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveExcavators}
//���������� ���������� �� ����-��������
procedure TesaResultVariant.SaveBlocks(
  const ABlocksCount               : Integer;           //���������� ����-��������
  const ALsm                       : Integer;           //�����, c�
  const ARockVolume                : ResaRockVolume;    //����� ������������ ������ �����
  const AAutosCount                : ResaDirectionValue;//���������� ��������������
  const AWaitingsCount             : ResaDirectionValue;//���������� �������� ��������������
  const AAvgVkmhNulled             : ResaDrobValue;     //������� �������� �������� �������������� � ������� �����������, ��/�
  const AAvgVkmhLoading            : ResaDrobValue;     //������� �������� �������� �������������� � �������� �����������, ��/�
  const AAvgVkmhUnLoading          : ResaDrobValue;     //������� �������� �������� �������������� � ������������ �����������, ��/�
  const AMovingAvgTminNulled       : ResaDrobValue;     //������� ����� �������� �������������� � ������� �����������, ���
  const AMovingAvgTminLoading      : ResaDrobValue;     //������� ����� �������� �������������� � �������� �����������, ���
  const AMovingAvgTminUnLoading    : ResaDrobValue;     //������� ����� �������� �������������� � ������������ �����������, ���
  const AWaitingAvgTminNulled      : ResaDrobValue;     //������� ����� �������� �������������� � ������� �����������, ���
  const AWaitingAvgTminLoading     : ResaDrobValue;     //������� ����� �������� �������������� � �������� �����������, ���
  const AWaitingAvgTminUnLoading   : ResaDrobValue;     //������� ����� �������� �������������� � ������������ �����������, ���
  const AEmploymentCoef            : Single;
  const AGx                        : ResaDirectionValue;//������ ������� �������������� �� ������������, �
  const AUdGx_l_m                  : Single;
  const ARepairCtg                 : Single;            //������� �� �����������, ��
  const AAmortizationCtg           : Single);           //��������������� ����������, ��
begin


  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('BlocksBlocksCount').AsFloat            := ABlocksCount;
    Query.FieldByName('BlocksLm').AsFloat                     := ALsm*0.01;
    Query.FieldByName('BlocksRockVm3').AsFloat                := ARockVolume.Vm3;
    Query.FieldByName('BlocksRockQtn').AsFloat                := ARockVolume.Qtn;
    Query.FieldByName('BlocksAutosCountNulled').AsFloat       := AAutosCount.Nulled;
    Query.FieldByName('BlocksAutosCountLoading').AsFloat      := AAutosCount.Loading;
    Query.FieldByName('BlocksAutosCountUnLoading').AsFloat    := AAutosCount.UnLoading;
    Query.FieldByName('BlocksWaitingsCountNulled').AsFloat    := AWaitingsCount.Nulled;
    Query.FieldByName('BlocksWaitingsCountLoading').AsFloat   := AWaitingsCount.Loading;
    Query.FieldByName('BlocksWaitingsCountUnLoading').AsFloat := AWaitingsCount.UnLoading;
    Query.FieldByName('BlocksAvgVkmhNulled').AsFloat          := esaDrob(AAvgVkmhNulled.Num,AAvgVkmhNulled.Den);
    Query.FieldByName('BlocksAvgVkmhLoading').AsFloat         := esaDrob(AAvgVkmhLoading.Num,AAvgVkmhLoading.Den);
    Query.FieldByName('BlocksAvgVkmhUnLoading').AsFloat       := esaDrob(AAvgVkmhUnLoading.Num,AAvgVkmhUnLoading.Den);

    Query.FieldByName('BlocksMovingAvgTminNulled').AsFloat    := esaDrob(AMovingAvgTminNulled.Num,AMovingAvgTminNulled.Den);
    Query.FieldByName('BlocksMovingAvgTminLoading').AsFloat   := esaDrob(AMovingAvgTminLoading.Num,AMovingAvgTminLoading.Den);
    Query.FieldByName('BlocksMovingAvgTminUnLoading').AsFloat := esaDrob(AMovingAvgTminUnLoading.Num,AMovingAvgTminUnLoading.Den);
    Query.FieldByName('BlocksWaitingAvgTminNulled').AsFloat   := esaDrob(AWaitingAvgTminNulled.Num,AWaitingAvgTminNulled.Den);
    Query.FieldByName('BlocksWaitingAvgTminLoading').AsFloat  := esaDrob(AWaitingAvgTminLoading.Num,AWaitingAvgTminLoading.Den);
    Query.FieldByName('BlocksWaitingAvgTminUnLoading').AsFloat:= esaDrob(AWaitingAvgTminUnLoading.Num,AWaitingAvgTminUnLoading.Den);
    Query.FieldByName('BlocksEmploymentCoef').AsFloat         := AEmploymentCoef;

    Query.FieldByName('BlocksGxNulled').AsFloat               := AGx.Nulled;
    Query.FieldByName('BlocksGxLoading').AsFloat              := AGx.Loading;
    Query.FieldByName('BlocksGxUnLoading').AsFloat            := AGx.UnLoading;
    Query.FieldByName('BlocksUdGx_l_m').AsFloat               := AUdGx_l_m;
    Query.FieldByName('BlocksRepairCtg').AsFloat              := ARepairCtg;
    Query.FieldByName('BlocksAmortizationCtg').AsFloat        := AAmortizationCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveBlocks}
//���������� ���������� �������������
procedure TesaResultVariant.SaveEconomParams(const AExpensesCtg: Single);//���������� � ���������� �������,��
begin
  if Query.Locate('Id_ResultVariant',Id_ResultVariant,[]) then
  begin
    Query.Edit;
    Query.FieldByName('EconomExpensesCtg').AsFloat := AExpensesCtg;
    Query.Post;
    Query.Requery;
  end;{if}
end;{SaveEconomParams}


//���������� ������������������ ������ ������, ����-�� �������
procedure TesaResultVariant.UpdateProductivity();
var
  FProductivityMineralWealthV1000m3 :single;
  FProductivityMineralWealthQ1000tn :single;
  FProductivityStrippingV1000m3 :single;
  FProductivityStrippingQ1000tn :single;
begin
  FProductivityMineralWealthV1000m3 := 0.0;
  FProductivityMineralWealthQ1000tn := 0.0;
  FProductivityStrippingV1000m3 := 0.0;
  FProductivityStrippingQ1000tn := 0.0;
  FPlannedRockVolumeCm := 0.0;
  with fmDM do
  begin
    quRockProductivity.Open;
    quRockProductivity.Requery;
    quRockProductivity.First;
    while not quRockProductivity.Eof do
    begin
      if quRockProductivityIsMineralWealth.AsBoolean then
      begin
        FProductivityMineralWealthV1000m3 := FProductivityMineralWealthV1000m3+
                                             quRockProductivityPlannedV1000m3.AsFloat;
        FProductivityMineralWealthQ1000tn := FProductivityMineralWealthQ1000tn+
                                             quRockProductivityPlannedQ1000tn.AsFloat;
      end{if}
      else
      begin
        FProductivityStrippingV1000m3 := FProductivityStrippingV1000m3+
                                         quRockProductivityPlannedV1000m3.AsFloat;
        FProductivityStrippingQ1000tn := FProductivityStrippingQ1000tn+
                                         quRockProductivityPlannedQ1000tn.AsFloat;
      end;{else}
      quRockProductivity.Next;
    end;{while}
     quRockProductivity.Close;
  end;{with}

  FPlannedRockVolumeCm := FProductivityMineralWealthV1000m3+ FProductivityStrippingV1000m3;

end;{UpdateProductivity}
end.
