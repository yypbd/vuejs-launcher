unit Form.Project;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormProject = class(TForm)
    PanelName: TPanel;
    EditName: TEdit;
    PanelPath: TPanel;
    EditPath: TEdit;
    ButtonSelectPath: TButton;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    PanelFramework: TPanel;
    ComboBoxFrameworkType: TComboBox;
    ShapeSep: TShape;
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
  {$WARN UNIT_PLATFORM OFF}
  FileCtrl,
  {$WARN UNIT_PLATFORM ON}
  DataStore.Project;

{$R *.dfm}

procedure TFormProject.BitBtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormProject.BitBtnOkClick(Sender: TObject);
begin
  if EditName.Text = '' then
  begin
    ShowMessage( 'Name is empty.' );
    EditName.SetFocus;
    Exit;
  end;

  if EditPath.Text = '' then
  begin
    ShowMessage( 'Path is empty.' );
    EditPath.SetFocus;
    Exit;
  end;

  if not System.SysUtils.DirectoryExists(EditPath.Text) then
  begin
    ShowMessage( 'Path is not exists.' );
    EditPath.SetFocus;
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TFormProject.ButtonSelectPathClick(Sender: TObject);
var
  Directory: string;
begin
  Directory := EditPath.Text;
  if SelectDirectory( '', '', Directory ) then
  begin
    if FileExists( IncludeTrailingPathDelimiter(Directory) + 'package.json' ) then
    begin
      EditName.Text := ExtractFileName( Directory );
      EditPath.Text := ExtractFilePath( Directory );

      if DirectoryExists( IncludeTrailingPathDelimiter(Directory) + '.nuxt' ) then
      begin
        ComboBoxFrameworkType.ItemIndex := Ord(ftNuxtjs);
      end;
    end
    else
    begin
      EditPath.Text := Directory;
    end;
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
