program VuejsLauncher;

uses
  EMemLeaks,
  Vcl.Forms,
  Form.VuejsLauncherMain in 'Form.VuejsLauncherMain.pas' {FormVuejsLauncherMain},
  AppConfig in 'Config\AppConfig.pas',
  Cmd.Executor in 'Cmd\Cmd.Executor.pas',
  DataStore.Project in 'DataStore\DataStore.Project.pas',
  Form.Project in 'Form\Form.Project.pas' {FormProject},
  Cmd.Runner in 'Cmd\Cmd.Runner.pas',
  Form.Settings in 'Form\Form.Settings.pas' {FormSettings};

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
