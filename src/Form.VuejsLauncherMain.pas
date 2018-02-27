unit Form.VuejsLauncherMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFormVuejsLauncherMain = class(TForm)
  private
    { Private declarations }
  protected
    procedure DoCreate; override;
  public
    { Public declarations }
  end;

var
  FormVuejsLauncherMain: TFormVuejsLauncherMain;

implementation

{$R *.dfm}

{ TFormVuejsLauncherMain }

procedure TFormVuejsLauncherMain.DoCreate;
begin
  inherited;

  Caption := Application.Title;
end;

end.
