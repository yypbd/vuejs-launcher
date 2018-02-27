program VuejsLauncher;

uses
  EMemLeaks,
  Vcl.Forms,
  Form.VuejsLauncherMain in 'Form.VuejsLauncherMain.pas' {FormVuejsLauncherMain},
  Config.Form in 'Config\Config.Form.pas' {FormConfig},
  AppConfig in 'Config\AppConfig.pas',
  Cmd.Executor in 'Cmd\Cmd.Executor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Vue.js Launcher';
  Application.CreateForm(TFormVuejsLauncherMain, FormVuejsLauncherMain);
  Application.Run;
end.
