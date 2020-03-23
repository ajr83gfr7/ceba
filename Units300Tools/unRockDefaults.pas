unit unRockDefaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Mask;

type
  TfmRockDefaults = class(TForm)
    pnBtns: TPanel;
    btOk: TButton;
    btClose: TButton;
    lbNote: TLabel;
    Bevel: TBevel;
    Image: TImage;
    chbIsMineralWealth: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
  private
  public
  end;{TfmExcavatorEngineDefaults}

var
  fmRockDefaults: TfmRockDefaults;

//Диалоговое окно значений по умолчанию горной массы
procedure esaShowRockDefaultsDlg(const AHelpKeyword: String);
implementation

uses unDM, Globals;

{$R *.dfm}

//Диалоговое окно значений по умолчанию горной массы
procedure esaShowRockDefaultsDlg(const AHelpKeyword: String);
begin
  fmRockDefaults := TfmRockDefaults.Create(nil);
  try
    fmRockDefaults.HelpKeyword := AHelpKeyword;
    fmRockDefaults.ShowModal;
  finally
    fmRockDefaults.Free;
  end;{try}
end;{esaShowRockDefaultsDlg}
procedure TfmRockDefaults.FormCreate(Sender: TObject);
begin
  HelpKeyword := Copy(Name,3,Length(Name)-2);
  chbIsMineralWealth.Checked := DefaultParams.RockIsMineralWealth;
end;{FormCreate}

procedure TfmRockDefaults.btOkClick(Sender: TObject);
begin
  DefaultParams.RockIsMineralWealth := chbIsMineralWealth.Checked;
  ModalResult := mrOk;
end;{btOkClick}

end.
