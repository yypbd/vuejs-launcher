unit Cmd.WebBrowser;

interface

uses
  Winapi.Windows, System.SysUtils;

type
  TCmdWebBrowser = record
  public
    class procedure OpenVuejs; static;
    class procedure OpenNuxtjs; static;
    class procedure OpenCustomPort(APort: Word); static;

    class procedure OpenWebSite(const AUrl: string); static;
  end;

implementation

uses
  ShellAPI;

{ TCmdWebBrowser }

class procedure TCmdWebBrowser.OpenCustomPort(APort: Word);
var
  Url: string;
begin
  Url := Format('http://localhost:%d', [APort]);

  OpenWebSite(Url);
end;

class procedure TCmdWebBrowser.OpenNuxtjs;
begin
  OpenCustomPort( 3000 );
end;

class procedure TCmdWebBrowser.OpenVuejs;
begin
  OpenCustomPort( 8080 );
end;

class procedure TCmdWebBrowser.OpenWebSite(const AUrl: string);
begin
  ShellExecute(0, 'open', PChar(AUrl), '', '', SW_SHOW);
end;

end.
