unit uDataBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, Data.DBXMySQL, Data.SqlExpr, IniFiles, Forms;

type
  TdmDataBase = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDataBase: TdmDataBase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses uUtil, Dialogs;

procedure TdmDataBase.DataModuleCreate(Sender: TObject);
var
  _arqIni: TIniFile;
begin
  try
    util := TUtil.Create(ExtractFilePath(Application.ExeName)+'Configuracao.ini');
    with FDPhysMySQLDriverLink do
    begin
       VendorLib := util.Tools;
    end;
    with FDConnection do
    begin
      Connected := False;
      Params.Clear;
      Params.Values['DriverID']  := 'MySQL';
      Params.Values['Server'] := Util.Server;
      Params.Values['Database'] := Util.Database;
      Params.Values['User_name'] := Util.Username;
      Params.Values['Password'] := Util.Password;
      Connected := True;
    end;
  except
      ShowMessage('Ocorreu uma Falha na configuração no Banco MySQL!');
  end;
end;

procedure TdmDataBase.DataModuleDestroy(Sender: TObject);
begin
  util.Free;
end;

end.
