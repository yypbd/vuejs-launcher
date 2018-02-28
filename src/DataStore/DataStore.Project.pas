unit DataStore.Project;

interface

uses
  Generics.Collections, System.SysUtils, System.Classes;

type
  TFrameworkType = ( ftVuejs, ftNuxtjs );

const
  TFrameworkTypeStr: array[TFrameworkType] of string = ('Vue.js', 'Nuxt.js');

type
  TProjectItem = record
    Name: string;
    Path: string;
    FrameworkType: TFrameworkType;
  end;

  TProjectList = TList<TProjectItem>;

  TProjectListHelper = record
    class procedure LoadFromFile(AProjectList: TProjectList; const AFileName: string); static;
    class procedure SaveToFile(AProjectList: TProjectList; const AFileName: string); static;
  end;

implementation

{ TProjectListHelper }

class procedure TProjectListHelper.LoadFromFile(AProjectList: TProjectList;
  const AFileName: string);
var
  SL: TStringList;
  SLLine: TStringList;
  I: Integer;
  ProjectItem: TProjectItem;
begin
  AProjectList.Clear;

  if not FileExists(AFileName) then
    Exit;

  SL := nil;
  SLLine := nil;

  try
    SL := TStringList.Create;
    SLLine := TStringList.Create;
    SLLine.Delimiter := #9;

    SL.LoadFromFile( AFileName );

    for I := 0 to SL.Count - 1 do
    begin
      SLLine.DelimitedText := SL.Strings[I];

      if SLLine.Count >= 3 then
      begin
        ProjectItem.Name := SLLine.Strings[0];
        ProjectItem.Path := SLLine.Strings[1];
        ProjectItem.FrameworkType := TFrameworkType(StrToIntDef(SLLine.Strings[2], 0));

        AProjectList.Add( ProjectItem );
      end;
    end;
  finally
    SL.Free;
    SLLine.Free;
  end;
end;

class procedure TProjectListHelper.SaveToFile(AProjectList: TProjectList;
  const AFileName: string);
var
  SL: TStringList;
  I: Integer;
begin
  ForceDirectories( ExtractFilePath(AFileName) );

  SL := TStringList.Create;
  try
    for I := 0 to AProjectList.Count - 1 do
    begin
      SL.Add( AProjectList.Items[I].Name + #9 + AProjectList.Items[I].Path + #9 + IntToStr(Ord(AProjectList.Items[I].FrameworkType)) )
    end;

    SL.SaveToFile( AFileName );
  finally
    SL.Free;
  end;
end;

end.
