unit Cmd.Executor;

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils;

type
  TCmdExecutor = record
    class procedure Run( ARemainAfterRun: Boolean; const ACmds: array of String ); static;
  end;

implementation

uses
  System.StrUtils,
  ShellAPI, AppConfig;

{ TCmdExecutor }

class procedure TCmdExecutor.Run(ARemainAfterRun: Boolean; const ACmds: array of String);
var
  CmdString: string;
  SB: TStringBuilder;
  I: Integer;
begin
  // ShellExecute(0, 'open', 'cmd.exe', PChar('/c "copy /Y file1.txt file2.txt&&copy /Y file2.txt file3.txt"'), nil, SW_SHOW);
  // ShellExecute(0, 'open', 'cmd.exe', PChar('/K ""' + AppCfgIni.Str['path', 'nodevars'] + '"&&cd d:\&&d:"'), nil, SW_SHOW);
  // ShellExecute(0, 'open', 'cmd.exe', PChar('/K ""' + AppCfgIni.Str['path', 'nodevars'] + '"&&cd d:\"'), nil, SW_SHOW);

  SB := TStringBuilder.Create;
  try
    SB.Append( IfThen( ARemainAfterRun, '/K ', '/C ' ) );

    SB.Append('"');
    SB.Append('"');
    SB.Append(AppCfgIni.Str['path', 'nodevars']);
    SB.Append('"');

    for I := Low(ACmds) to High(ACmds) do
    begin
      SB.Append( '&&' );
      SB.Append(ACmds[I]);
    end;

    SB.Append('"');

    CmdString := SB.ToString;
  finally
    SB.Free;
  end;

  ShellExecute(0, 'open', 'cmd.exe', PChar(CmdString), nil, SW_SHOW);
end;

end.
