program VuejsLauncher;

uses
  EMemLeaks,
  Vcl.Forms,
  Form.VuejsLauncherMain in 'Form.VuejsLauncherMain.pas' {FormVuejsLauncherMain},
  Config.Form in 'Config\Config.Form.pas' {FormConfig},
  AppConfig in 'Config\AppConfig.pas',
  Cmd.Executor in 'Cmd\Cmd.Executor.pas',
  DataStore.Project in 'DataStore\DataStore.Project.pas',
  Project.Form in 'Form\Project.Form.pas' {FormProject},
  Cmd.Runner in 'Cmd\Cmd.Runner.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Vue.js Launcher';
  Application.CreateForm(TFormVuejsLauncherMain, FormVuejsLauncherMain);
  Application.Run;
end.
