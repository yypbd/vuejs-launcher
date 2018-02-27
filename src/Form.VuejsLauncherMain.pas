unit Form.VuejsLauncherMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormVuejsLauncherMain = class(TForm)
    BitBtnConfig: TBitBtn;
    procedure BitBtnConfigClick(Sender: TObject);
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

uses
  Config.Form, AppConfig;

{$R *.dfm}

{ TFormVuejsLauncherMain }

procedure TFormVuejsLauncherMain.BitBtnConfigClick(Sender: TObject);
var
  FormConfig: TFormConfig;
begin
  FormConfig := TFormConfig.Create( nil );
  try
    if FormConfig.ShowModal = mrOk then
    begin
    end;
  finally
    FormConfig.Free;
  end;
end;

procedure TFormVuejsLauncherMain.DoCreate;
begin
  inherited;

  Caption := Application.Title;

  AppCfgIni.AppName := 'yypbd\vuejs-launcher';

  // node.js commandline batch file
  // C:\Windows\System32\cmd.exe /k "C:\Program Files\nodejs\nodevars.bat"
  if AppCfgIni.Str['path', 'nodevars'] = '' then
    AppCfgIni.Str['path', 'nodevars'] := 'C:\Program Files\nodejs\nodevars.bat';
end;

end.
