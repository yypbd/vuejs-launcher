unit AppConfig;

interface

uses
  Windows, SysUtils, IniFiles, Registry;

type
  TAppConfig = class
  private
    FAppName: string;

    procedure SetAppName(const Value: string); virtual;
    function GetBooleanValue(Section, Name: string): Boolean; virtual; abstract;
    function GetDateTimeValue(Section, Name: string): TDateTime; virtual; abstract;
    function GetIntegerValue(Section, Name: string): Integer; virtual; abstract;
    function GetStringValue(Section, Name: string): string; virtual; abstract;
    procedure SetBooleanValue(Section, Name: string; const Value: Boolean); virtual; abstract;
    procedure SetDateTimeValue(Section, Name: string; const Value: TDateTime); virtual; abstract;
    procedure SetIntegerValue(Section, Name: string; const Value: Integer); virtual; abstract;
    procedure SetStringValue(Section, Name: string; const Value: string); virtual; abstract;
  public
    property AppName: string read FAppName write SetAppName;
    property Bool[Section, Name: string]: Boolean read GetBooleanValue write SetBooleanValue;
    property DateTime[Section, Name: string]: TDateTime read GetDateTimeValue write SetDateTimeValue;
    property Int[Section, Name: string]: Integer read GetIntegerValue write SetIntegerValue;
    property Str[Section, Name: string]: string read GetStringValue write SetStringValue;
  end;

  TAppConfigIni = class(TAppConfig)
  private
    FIni: TIniFile;

    procedure SetAppName(const Value: string); override;
    function GetBooleanValue(Section, Name: string): Boolean; override;
    function GetDateTimeValue(Section, Name: string): TDateTime; override;
    function GetIntegerValue(Section, Name: string): Integer; override;
    function GetStringValue(Section, Name: string): string; override;
    procedure SetBooleanValue(Section, Name: string; const Value: Boolean); override;
    procedure SetDateTimeValue(Section, Name: string; const Value: TDateTime); override;
    procedure SetIntegerValue(Section, Name: string; const Value: Integer); override;
    procedure SetStringValue(Section, Name: string; const Value: string); override;
    function GetSpecialFolderPath(const ACSIDL: Word): String;
    function AppDataPath: string;
  public
    destructor Destroy; override;
    procedure UpdateIni;
  end;

  TAppConfigReg = class(TAppConfig)
  private
    FReg: TRegistry;
    FRegPath: string;

    procedure SetAppName(const Value: string); override;
    function GetBooleanValue(Section, Name: string): Boolean; override;
    function GetDateTimeValue(Section, Name: string): TDateTime; override;
    function GetIntegerValue(Section, Name: string): Integer; override;
    function GetStringValue(Section, Name: string): string; override;
    procedure SetBooleanValue(Section, Name: string; const Value: Boolean); override;
    procedure SetDateTimeValue(Section, Name: string; const Value: TDateTime); override;
    procedure SetIntegerValue(Section, Name: string; const Value: Integer); override;
    procedure SetStringValue(Section, Name: string; const Value: string); override;
    procedure OpenSection(const ASection: string);
  public
    destructor Destroy; override;
  end;

var
  AppCfgIni: TAppConfigIni;
  AppCfgReg: TAppConfigReg;

implementation

uses
  ShlObj;

{ TAppConfigIni }

function TAppConfigIni.AppDataPath: string;
begin
  Result := GetSpecialFolderPath(CSIDL_APPDATA) + FAppName + '\';
end;

destructor TAppConfigIni.Destroy;
begin
  if Assigned(FIni) then FIni.Free;

  inherited;
end;

function TAppConfigIni.GetBooleanValue(Section, Name: string): Boolean;
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  Result := FIni.ReadBool( Section, Name, False );
end;

function TAppConfigIni.GetDateTimeValue(Section, Name: string): TDateTime;
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  Result := FIni.ReadDateTime( Section, Name, 0 );
end;

function TAppConfigIni.GetIntegerValue(Section, Name: string): Integer;
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  Result := FIni.ReadInteger( Section, Name, 0 );
end;

function TAppConfigIni.GetSpecialFolderPath(const ACSIDL: Word): String;
var
  pidl: PItemIDList;
  hRes: HRESULT;
  Success: Boolean;
  RealPath: array[0..MAX_PATH] of Char;
begin
  Result := '';

  hRes := SHGetSpecialFolderLocation(0, ACSIDL, pidl); // 이부분에서 수정할것. 필요에 맞게

  if hRes = NO_ERROR then
  begin
    Success := SHGetPathFromIDList( pidl, RealPath );
    if Success then
      Result := IncludeTrailingPathDelimiter( RealPath );
  end;
end;

function TAppConfigIni.GetStringValue(Section, Name: string): string;
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  Result := FIni.ReadString( Section, Name, '' );
end;

procedure TAppConfigIni.SetAppName(const Value: string);
begin
  inherited;

  if Assigned(FIni) then
  begin
    FreeAndNil( FIni );
  end;

  if FAppName <> '' then
  begin
    ForceDirectories( AppDataPath );
    FIni := TIniFile.Create( AppDataPath + 'Config.ini' );
  end;
end;

procedure TAppConfigIni.SetBooleanValue(Section, Name: string;
  const Value: Boolean);
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  FIni.WriteBool( Section, Name, Value );
end;

procedure TAppConfigIni.SetDateTimeValue(Section, Name: string;
  const Value: TDateTime);
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  FIni.WriteDateTime( Section, Name, Value );
end;

procedure TAppConfigIni.SetIntegerValue(Section, Name: string;
  const Value: Integer);
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  FIni.WriteInteger( Section, Name, Value );
end;

procedure TAppConfigIni.SetStringValue(Section, Name: string;
  const Value: string);
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  FIni.WriteString( Section, Name, Value );
end;

procedure TAppConfigIni.UpdateIni;
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  FIni.UpdateFile;
end;

{ TAppConfigReg }

destructor TAppConfigReg.Destroy;
begin
  if Assigned(FReg) then FReg.Free;

  inherited;
end;

function TAppConfigReg.GetBooleanValue(Section, Name: string): Boolean;
begin
  OpenSection( Section );
  Result := FReg.ReadBool( Name );
end;

function TAppConfigReg.GetDateTimeValue(Section, Name: string): TDateTime;
begin
  OpenSection( Section );
  Result := FReg.ReadDateTime( Name );
end;

function TAppConfigReg.GetIntegerValue(Section, Name: string): Integer;
begin
  OpenSection( Section );
  Result := FReg.ReadInteger( Name );
end;

function TAppConfigReg.GetStringValue(Section, Name: string): string;
begin
  OpenSection( Section );
  Result := FReg.ReadString( Name );
end;

procedure TAppConfigReg.OpenSection(const ASection: string);
begin
  if FAppName = '' then raise Exception.Create('AppName is missing!');
  FReg.OpenKey( FRegPath + '\' + ASection, True );
end;

procedure TAppConfigReg.SetAppName(const Value: string);
begin
  inherited;

  if Assigned(FReg) then
  begin
    FreeAndNil( FReg );
  end;

  if FAppName <> '' then
  begin
    FReg := TRegistry.Create;
    FReg.RootKey := HKEY_CURRENT_USER;
    FReg.LazyWrite := False;
    FRegPath := '\Software\' + FAppName + '\Config';
  end;
end;

procedure TAppConfigReg.SetBooleanValue(Section, Name: string;
  const Value: Boolean);
begin
  OpenSection( Section );
  FReg.WriteBool( Name, Value );
end;

procedure TAppConfigReg.SetDateTimeValue(Section, Name: string;
  const Value: TDateTime);
begin
  OpenSection( Section );
  FReg.WriteDateTime( Name, Value );
end;

procedure TAppConfigReg.SetIntegerValue(Section, Name: string;
  const Value: Integer);
begin
  OpenSection( Section );
  FReg.WriteInteger( Name, Value );
end;

procedure TAppConfigReg.SetStringValue(Section, Name: string;
  const Value: string);
begin
  OpenSection( Section );
  FReg.WriteString( Name, Value );
end;

{ TAppConfig }

procedure TAppConfig.SetAppName(const Value: string);
begin
  FAppName := Value;
end;

initialization
  AppCfgIni := TAppConfigIni.Create;
  AppCfgReg := TAppConfigReg.Create;

finalization
  AppCfgIni.Free;
  AppCfgReg.Free;

end.
