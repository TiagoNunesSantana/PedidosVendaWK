unit uUtil;

interface

uses IniFiles, SysUtils;

type
  TUtil = class
  private
    FDatabase,
    FUsername,
    FPassword,
    FServer,
    FPort,
    FTools: string;
    constructor CreateFromIni(const FileName: string);
  public
    constructor Create(const FileName: string);
    property Database: string read FDatabase;
    property Username: string read FUsername;
    property Password: string read FPassword;
    property Server: string read FServer;
    property Port: string read FPort;
    property Tools: string read FTools;
  end;

var
  util: TUtil;

implementation

uses
  Dialogs;

{ TUtil }

constructor TUtil.Create(const FileName: string);
begin
  CreateFromIni(FileName);
end;

constructor TUtil.CreateFromIni(const FileName: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FileName);
  try
    FDatabase := Ini.ReadString('Acesso', 'Database', '');
    FUsername := Ini.ReadString('Acesso', 'Username', '');
    FPassword := Ini.ReadString('Acesso', 'Password', '');
    FServer := Ini.ReadString('Acesso', 'Server', '');
    FPort := Ini.ReadString('Acesso', 'Port', '');
    FTools := Ini.ReadString('Acesso', 'Tools', '');
  finally
    Ini.Free;
  end;
end;

end.
