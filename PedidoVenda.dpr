program PedidoVenda;

uses
  Vcl.Forms,
  uPedido in 'uPedido.pas' {frmPedido},
  uDataBase in 'uDataBase.pas' {dmDataBase: TDataModule},
  uDataQuery in 'uDataQuery.pas' {dmDataQuery: TDataModule},
  uUtil in 'uUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.CreateForm(TdmDataBase, dmDataBase);
  Application.CreateForm(TdmDataQuery, dmDataQuery);
  Application.Run;
end.
