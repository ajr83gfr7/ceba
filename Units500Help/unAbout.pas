unit unAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmAbout = class(TForm)
    pnClient: TPanel;
    lbTitle: TLabel;
    lbTopTitle: TLabel;
    lbCopyRight: TLabel;
    lbEnterpriseRegistration: TLabel;
    lbVersion: TLabel;
    lbEnterprise: TLabel;
    lbEnterpriseEMail: TLabel;
    Label1: TLabel;
    btOk: TButton;
    pnIcon: TPanel;
    imAuto: TImage;
    lbAuthor: TLabel;
    Timer: TTimer;
    tmAuthor: TTimer;
    Label2: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbEnterpriseEMailMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure tmAuthorTimer(Sender: TObject);
    procedure imAutoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imAutoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FIsSplash: Boolean;
    procedure SetIsSplash(const Value: Boolean);
  public
    property IsSplash: Boolean read FIsSplash write SetIsSplash;
  end;{TfmAbout}

var
  fmAbout: TfmAbout;

//Диалоговое окно "О программе"
function esaShowAboutDlg(): Boolean;
//Диалоговое окно заставки
function esaShowSplashDlg(): Boolean;
implementation

{$R *.DFM}

//Диалоговое окно "О программе"
function esaShowAboutDlg(): Boolean;
begin
  fmAbout := TfmAbout.Create(nil);
  try
    Result := fmAbout.ShowModal=mrOk;
  finally
    FreeAndNil(fmAbout);
  end;{try}
end;{esaShowAboutDlg}
//Диалоговое окно заставки
function esaShowSplashDlg(): Boolean;
begin
  Result := True;
  fmAbout := TfmAbout.Create(nil);
  try
    fmAbout.IsSplash := True;
    fmAbout.Show;
    fmAbout.Refresh;
  finally
  end;{try}
end;{esaShowAboutDlg}

procedure TfmAbout.SetIsSplash(const Value: Boolean);
begin
  FIsSplash := Value;
  btOk.Visible := not Value;
  if IsSplash then BorderStyle := bsNone else BorderStyle := bsDialog;
end;{SetIsSplash}

procedure TfmAbout.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := false;
  Close;
end;{TimerTimer}

procedure TfmAbout.FormCreate(Sender: TObject);
begin
  FIsSplash := false;
  tmAuthor.Enabled := false;
  lbAuthor.Visible := false;
end;{FormCreate}

procedure TfmAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FIsSplash then
  begin
    Timer.Enabled := false;
    Close;
  end;{if}
end;{FormKeyDown}

procedure TfmAbout.FormShow(Sender: TObject);
begin
  Timer.Enabled := FIsSplash;
end;{FormShow}

procedure TfmAbout.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if FIsSplash then
  begin
    Timer.Enabled := false;
    Close;
  end;{if}
end;{FormMouseDown}

procedure TfmAbout.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Cursor := crDefault;
end;{FormMouseMove}

procedure TfmAbout.lbEnterpriseEMailMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Cursor := crHandPoint;
end;{lbEnterpriseEMailMouseMove}

procedure TfmAbout.tmAuthorTimer(Sender: TObject);
begin
  lbAuthor.Top := lbAuthor.Top-4;
  if lbAuthor.Top<=-32 then lbAuthor.Top := lbAuthor.Parent.Height+4;
end;{tmAuthorTimer}

procedure TfmAbout.imAutoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft,ssRight] then
  begin
    tmAuthor.Enabled := true;
    lbAuthor.Top := lbAuthor.Parent.Height+4;
    lbAuthor.Visible := true;
  end;{if}
end;{imAutoMouseDown}

procedure TfmAbout.imAutoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  tmAuthor.Enabled := false;
  lbAuthor.Top := lbAuthor.Parent.Height+4;
  lbAuthor.Visible := false;
end;{imAutoMouseUp}

end.
