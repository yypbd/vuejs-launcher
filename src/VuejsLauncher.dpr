program VuejsLauncher;

uses
  EMemLeaks,
  Vcl.Forms,
  Form.VuejsLauncherMain in 'Form.VuejsLauncherMain.pas' {FormVuejsLauncherMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Vue.js Launcher';
  Application.CreateForm(TFormVuejsLauncherMain, FormVuejsLauncherMain);
  Application.Run;
end.
