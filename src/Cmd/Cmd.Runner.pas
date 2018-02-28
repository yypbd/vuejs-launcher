unit Cmd.Runner;

interface

uses
  System.SysUtils;

type
  TCmdVuejs = record
    class function Run( const AName, APath: string ): Boolean; static;
  end;

  TCmdNuxtjs = record
    class function Run( const AName, APath: string ): Boolean; static;
  end;

implementation

uses
  Cmd.Executor;

{ TCmdVuejs }

class function TCmdVuejs.Run(const AName, APath: string): Boolean;
var
  ProjectPath, DrivePath: string;
begin
  // https://vuejs.org/v2/guide/installation.html#CLI

  ProjectPath := APath + AName;
  DrivePath := ExtractFileDrive( APath );

  if DirectoryExists(ProjectPath) then
  begin
    TCmdExecutor.Run( True, ['cd "' + ProjectPath + '"', DrivePath,
                             'npm run dev'
                            ] );
  end
  else
  begin
    TCmdExecutor.Run( True, ['npm install --global vue-cli',
                             'cd "' + APath + '"', DrivePath,
                             'vue init webpack ' + AName,
                             'cd ' + AName,
                             'npm install',
                             'npm run dev'
                            ] );
  end;

  Result := True;
end;

{ TCmdNuxtjs }

class function TCmdNuxtjs.Run(const AName, APath: string): Boolean;
var
  ProjectPath, DrivePath: string;
begin
  // https://nuxtjs.org/guide/installation

  ProjectPath := APath + AName;
  DrivePath := ExtractFileDrive( APath );

  if DirectoryExists(ProjectPath) then
  begin
    TCmdExecutor.Run( True, ['cd "' + ProjectPath + '"', DrivePath,
                             'npm run dev'
                            ] );
  end
  else
  begin
    TCmdExecutor.Run( True, ['npm install -g vue-cli',
                             'cd "' + APath + '"', DrivePath,
                             'vue init nuxt-community/starter-template ' + AName,
                             'cd ' + AName,
                             'npm install',
                             'npm run dev'
    ] );
  end;

  Result := True;
end;

end.
