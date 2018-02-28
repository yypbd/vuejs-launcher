unit Form.VuejsLauncherMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.UITypes, DataStore.Project, Vcl.Menus;

type
  TFormVuejsLauncherMain = class(TForm)
    BitBtnConfig: TBitBtn;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    ListViewProject: TListView;
    Panel2: TPanel;
    BitBtnProjectAdd: TBitBtn;
    BitBtnProjectUpdate: TBitBtn;
    BitBtnProjectDelete: TBitBtn;
    procedure BitBtnConfigClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtnProjectAddClick(Sender: TObject);
    procedure BitBtnProjectUpdateClick(Sender: TObject);
    procedure BitBtnProjectDeleteClick(Sender: TObject);
    procedure ListViewProjectDblClick(Sender: TObject);
  private
    { Private declarations }
    FProjectList: TProjectList;

    procedure ShowProjectList;
    procedure AddProjectItem( const AProjectItem: TProjectItem );
    procedure UpdateProjectItem( const AProjectItem: TProjectItem );

    function GetProjectListPath: string;
  protected
    procedure DoCreate; override;
    procedure DoDestroy; override;

  public
    { Public declarations }
  end;

var
  FormVuejsLauncherMain: TFormVuejsLauncherMain;

implementation

uses
  Config.Form, AppConfig, Cmd.Runner, Project.Form;

{$R *.dfm}

{ TFormVuejsLauncherMain }

procedure TFormVuejsLauncherMain.AddProjectItem(
  const AProjectItem: TProjectItem);
var
  ListItem: TListItem;
begin
  ListItem := ListViewProject.Items.Add;
  ListItem.Caption := AProjectItem.Name;
  ListItem.SubItems.Add( AProjectItem.Path );
  ListItem.SubItems.Add( TFrameworkTypeStr[AProjectItem.FrameworkType] );
end;

procedure TFormVuejsLauncherMain.BitBtn1Click(Sender: TObject);
begin
  // D:\devel\proto\www
  // vuejs_exam01

  {
  if DirectoryExists('D:\devel\proto\www\vuejs_exam01') then
  begin
    TCmdExecutor.Run( True, ['cd "D:\devel\proto\www\vuejs_exam01"', 'D:',
                             'npm run dev'
                            ] );
  end
  else
  begin
    TCmdExecutor.Run( True, ['npm install --global vue-cli',
                             'cd "D:\devel\proto\www"', 'D:',
                             'vue init webpack vuejs_exam01',
                             'cd vuejs_exam01',
                             'npm install',
                             'npm run dev'
                            ] );
  end;
  }
end;

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

procedure TFormVuejsLauncherMain.BitBtnProjectAddClick(Sender: TObject);
var
  FormProject: TFormProject;
  ProjectItem: TProjectItem;
begin
  FormProject := TFormProject.Create(nil);
  try
    FormProject.Caption := 'Add project';
    FormProject.EditName.Text := '';
    FormProject.EditPath.Text := '';
    FormProject.ComboBoxFrameworkType.ItemIndex := 0;

    if FormProject.ShowModal = mrOk then
    begin
      if (FormProject.EditName.Text <> '') and DirectoryExists(FormProject.EditPath.Text) then
      begin
        ProjectItem.Name := FormProject.EditName.Text;
        ProjectItem.Path := IncludeTrailingPathDelimiter(FormProject.EditPath.Text);
        ProjectItem.FrameworkType := TFrameworkType(FormProject.ComboBoxFrameworkType.ItemIndex);
        FProjectList.Add( ProjectItem );

        AddProjectItem( ProjectItem );
      end;
    end;
  finally
    FormProject.Free;
  end;
end;

procedure TFormVuejsLauncherMain.BitBtnProjectDeleteClick(Sender: TObject);
begin
  if ListViewProject.Selected = nil then
    Exit;

  if MessageDlg('Delete selected item?', mtConfirmation, mbOKCancel, 0) = mrOk then
  begin
    FProjectList.Delete( ListViewProject.Selected.Index );
    ListViewProject.Selected.Delete;
  end;
end;

procedure TFormVuejsLauncherMain.BitBtnProjectUpdateClick(Sender: TObject);
var
  FormProject: TFormProject;
  ProjectItem: TProjectItem;
begin
  if ListViewProject.Selected = nil then
    Exit;

  FormProject := TFormProject.Create(nil);
  try
    FormProject.Caption := 'Update project';
    FormProject.EditName.Text := FProjectList.Items[ListViewProject.Selected.Index].Name;
    FormProject.EditPath.Text := FProjectList.Items[ListViewProject.Selected.Index].Path;
    FormProject.ComboBoxFrameworkType.ItemIndex := Ord(FProjectList.Items[ListViewProject.Selected.Index].FrameworkType);

    if FormProject.ShowModal = mrOk then
    begin
      if (FormProject.EditName.Text <> '') and DirectoryExists(FormProject.EditPath.Text) then
      begin
        ProjectItem.Name := FormProject.EditName.Text;
        ProjectItem.Path := IncludeTrailingPathDelimiter(FormProject.EditPath.Text);
        ProjectItem.FrameworkType := TFrameworkType(FormProject.ComboBoxFrameworkType.ItemIndex);
        FProjectList.Items[ListViewProject.Selected.Index] := ProjectItem;

        UpdateProjectItem( ProjectItem );
      end;
    end;
  finally
    FormProject.Free;
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

  FProjectList := TProjectList.Create;
  TProjectListHelper.LoadFromFile( FProjectList, GetProjectListPath );

  ShowProjectList;
end;

procedure TFormVuejsLauncherMain.DoDestroy;
begin
  inherited;

  TProjectListHelper.SaveToFile( FProjectList, GetProjectListPath );
  FProjectList.Free;
end;

function TFormVuejsLauncherMain.GetProjectListPath: string;
begin
  Result := AppCfgIni.AppDataPath + 'Project.dat';
end;

procedure TFormVuejsLauncherMain.ListViewProjectDblClick(Sender: TObject);
var
  ProjectItem: TProjectItem;
begin
  if ListViewProject.Selected = nil then
    Exit;

  ProjectItem := FProjectList.Items[ListViewProject.Selected.Index];

  case ProjectItem.FrameworkType of
    ftVuejs:
    begin
      TCmdVuejs.Run( ProjectItem.Name, ProjectItem.Path );
    end;
    ftNuxtjs:
    begin
      TCmdNuxtjs.Run( ProjectItem.Name, ProjectItem.Path );
    end;
  end;
end;

procedure TFormVuejsLauncherMain.ShowProjectList;
var
  I: Integer;
begin
  for I := 0 to FProjectList.Count - 1 do
  begin
    AddProjectItem( FProjectList.Items[I] );
  end;
end;

procedure TFormVuejsLauncherMain.UpdateProjectItem(
  const AProjectItem: TProjectItem);
var
  ListItem: TListItem;
begin
  ListItem := ListViewProject.Selected;
  ListItem.Caption := AProjectItem.Name;
  ListItem.SubItems.Strings[0] := AProjectItem.Path;
  ListItem.SubItems.Strings[1] := TFrameworkTypeStr[AProjectItem.FrameworkType];
end;

end.
