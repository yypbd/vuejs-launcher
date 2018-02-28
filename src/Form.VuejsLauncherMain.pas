unit Form.VuejsLauncherMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.UITypes, DataStore.Project, Vcl.Menus, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, PngImage, Vcl.ImgList;

type
  TFormVuejsLauncherMain = class(TForm)
    PopupMenuProject: TPopupMenu;
    MenuItemRevealinExplorer: TMenuItem;
    MenuItemOpeninCommandprompt: TMenuItem;
    MenuItemOpenNodejsCommandprompt: TMenuItem;
    MainMenu: TMainMenu;
    MenuItemFile: TMenuItem;
    MenuItemFileExit: TMenuItem;
    MenuItemProject: TMenuItem;
    MenuItemProjectAdd: TMenuItem;
    MenuItemProjectUpdate: TMenuItem;
    MenuItemProjectDelete: TMenuItem;
    MenuItemTools: TMenuItem;
    MenuItemToolsSettings: TMenuItem;
    ActionList: TActionList;
    ActionFileExit: TAction;
    ActionProjectAdd: TAction;
    ActionProjectUpdate: TAction;
    ActionProjectDelete: TAction;
    ActionToolsSettings: TAction;
    ToolBar: TToolBar;
    ToolButtonProjectAdd: TToolButton;
    ToolButtonProjectUpdate: TToolButton;
    ToolButtonProjectDelete: TToolButton;
    ToolButtonSep02: TToolButton;
    ToolButtonToolsSettings: TToolButton;
    ImageListAction: TImageList;
    ListViewProject: TListView;
    ActionProjectRun: TAction;
    ToolButtonProjectRun: TToolButton;
    ToolButtonSep01: TToolButton;
    procedure ListViewProjectDblClick(Sender: TObject);
    procedure ListViewProjectContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure MenuItemRevealinExplorerClick(Sender: TObject);
    procedure MenuItemOpeninCommandpromptClick(Sender: TObject);
    procedure MenuItemOpenNodejsCommandpromptClick(Sender: TObject);
    procedure ActionFileExitExecute(Sender: TObject);
    procedure ActionToolsSettingsExecute(Sender: TObject);
    procedure ActionProjectAddExecute(Sender: TObject);
    procedure ActionProjectUpdateExecute(Sender: TObject);
    procedure ActionProjectDeleteExecute(Sender: TObject);
    procedure ActionProjectRunExecute(Sender: TObject);
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
  Form.Settings, AppConfig, Cmd.Executor, Cmd.Runner, Project.Form;

{$R *.dfm}

{ TFormVuejsLauncherMain }

procedure TFormVuejsLauncherMain.ActionFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormVuejsLauncherMain.ActionProjectAddExecute(Sender: TObject);
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

procedure TFormVuejsLauncherMain.ActionProjectDeleteExecute(Sender: TObject);
begin
  if ListViewProject.Selected = nil then
    Exit;

  if MessageDlg('Delete selected item?', mtConfirmation, mbOKCancel, 0) = mrOk then
  begin
    FProjectList.Delete( ListViewProject.Selected.Index );
    ListViewProject.Selected.Delete;
  end;
end;

procedure TFormVuejsLauncherMain.ActionProjectRunExecute(Sender: TObject);
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

procedure TFormVuejsLauncherMain.ActionProjectUpdateExecute(Sender: TObject);
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

procedure TFormVuejsLauncherMain.ActionToolsSettingsExecute(Sender: TObject);
var
  FormSettings: TFormSettings;
begin
  FormSettings := TFormSettings.Create( nil );
  try
    if FormSettings.ShowModal = mrOk then
    begin
    end;
  finally
    FormSettings.Free;
  end;
end;

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

procedure TFormVuejsLauncherMain.ListViewProjectContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  ListItem: TListItem;
begin
  ListItem := ListViewProject.GetItemAt( MousePos.X, MousePos.Y );

  if ListItem <> nil then
  begin
    MousePos := ListViewProject.ClientToScreen( MousePos );
    PopupMenuProject.Popup( MousePos.X, MousePos.Y );
  end;
end;

procedure TFormVuejsLauncherMain.ListViewProjectDblClick(Sender: TObject);
begin
  ActionProjectRun.Execute;
end;

procedure TFormVuejsLauncherMain.MenuItemOpeninCommandpromptClick(
  Sender: TObject);
var
  ProjectItem: TProjectItem;
begin
  if ListViewProject.Selected = nil then
    Exit;

  ProjectItem := FProjectList.Items[ListViewProject.Selected.Index];
  TCmdExecutor.OpeninCommandprompt( ProjectItem );
end;

procedure TFormVuejsLauncherMain.MenuItemOpenNodejsCommandpromptClick(
  Sender: TObject);
var
  ProjectItem: TProjectItem;
begin
  if ListViewProject.Selected = nil then
    Exit;

  ProjectItem := FProjectList.Items[ListViewProject.Selected.Index];
  TCmdExecutor.OpenNodejsCommandprompt( ProjectItem );
end;

procedure TFormVuejsLauncherMain.MenuItemRevealinExplorerClick(Sender: TObject);
var
  ProjectItem: TProjectItem;
begin
  if ListViewProject.Selected = nil then
    Exit;

  ProjectItem := FProjectList.Items[ListViewProject.Selected.Index];
  TCmdExecutor.OpenExplorer( ProjectItem );
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
