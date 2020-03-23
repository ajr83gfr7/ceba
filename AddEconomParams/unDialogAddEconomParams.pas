unit unDialogAddEconomParams;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids;

type
  TfmDialogAddEconomParams = class(TForm)
    pnGrid: TPanel;
    pnSelect: TPanel;
    lbVariants: TLabel;
    dbgAddEconomParams: TDBGrid;
    ledName: TLabeledEdit;
    Panel1: TPanel;
    rgSelect: TRadioGroup;
    btOk: TButton;
    btCancel: TButton;
    procedure rgSelectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDialogAddEconomParams: TfmDialogAddEconomParams;

implementation

uses unResultAddEconomParams;

{$R *.dfm}

procedure TfmDialogAddEconomParams.rgSelectClick(Sender: TObject);
begin
  dbgAddEconomParams.Enabled := rgSelect.ItemIndex = 0;
  ledName.Enabled := rgSelect.ItemIndex = 1;
end;{rgSelectClick}

end.
