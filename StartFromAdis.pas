unit StartFromAdis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, esaOpenGL2D, esaDBNavigators, ActnList, ImgList,
  ComCtrls, ToolWin, ExtCtrls, Menus, Globals, StdCtrls, esaDBOpenpitObjects,
  UnDM, unOpenpitEditor,Types;


type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin


    Undm.fmDM.quAdisCourses.SQL.Text := 'Select Point1, Point2 from NewAdisCourses;';
    Undm.fmDM.quAdisCourses.Active := True;
  while Undm.fmDM.quAdisCourses.Eof = False  do
  begin
  //esaShowOpenpitEditorDlg;
//  fmOpenpitEditor.FOpenpit.Courses.Add(23,123);
 // fmOpenpitEditor.FOpenpit.Courses.Add(123,123120);
  //undm.fmDM.quAdisCourses.Fields.Fields[0].Value, undm.fmDM.quAdisCourses.Fields.Fields[1].Value);
   Undm.fmDM.quAdisCourses.Next;
  end;
end;

end.
