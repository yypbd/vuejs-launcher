unit Project.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormProject = class(TForm)
    Panel1: TPanel;
    EditName: TEdit;
    Panel2: TPanel;
    EditPath: TEdit;
    ButtonSelectPath: TButton;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    Panel3: TPanel;
    ComboBoxFrameworkType: TComboBox;
    procedure ButtonSelectPathClick(Sender: TObject);
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
//   FormProject: TFormProject;

implementation

uses
  FileCtrl,
  DataStore.Project;

{$R *.dfm}

procedure TFormProject.BitBtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormProject.BitBtnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormProject.ButtonSelectPathClick(Sender: TObject);
var
  Directory: string;
begin
  Directory := EditPath.Text;
  if SelectDirectory( '', '', Directory ) then
  begin
    EditPath.Text := Directory;
  end;
end;

procedure TFormProject.DoCreate;
var
  I: TFrameworkType;
begin
  inherited;

  for I := Low(TFrameworkTypeStr) to High(TFrameworkTypeStr) do
  begin
    ComboBoxFrameworkType.Items.Add( TFrameworkTypeStr[I] );
  end;
end;

end.
