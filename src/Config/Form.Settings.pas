unit Form.Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormSettings = class(TForm)
    Panel1: TPanel;
    EditNodevars: TEdit;
    ButtonSelectNodevars: TButton;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    procedure ButtonSelectNodevarsClick(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoCreate; override;
  public
    { Public declarations }
  end;

// var
//   FormConfig: TFormConfig;

implementation

{$R *.dfm}

uses
  AppConfig;

{ TFormConfig }

procedure TFormSettings.BitBtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormSettings.BitBtnOkClick(Sender: TObject);
begin
  if FileExists(EditNodevars.Text) and (LowerCase(ExtractFileExt(EditNodevars.Text)) = '.bat') then
  begin
    AppCfgIni.Str['path', 'nodevars'] := EditNodevars.Text;
  end;

  ModalResult := mrOk;
end;

procedure TFormSettings.ButtonSelectNodevarsClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create( nil );
  try
    OpenDialog.DefaultExt := '.bat';
    OpenDialog.InitialDir := ExtractFilePath( EditNodevars.Text );
    OpenDialog.Filter := 'Batch File|*.bat';
    if OpenDialog.Execute then
    begin
      EditNodevars.Text := OpenDialog.FileName;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TFormSettings.DoCreate;
begin
  inherited;

  Caption := 'Vuejs Launcher Config';

  EditNodevars.Text := AppCfgIni.Str['path', 'nodevars'];
end;

end.
