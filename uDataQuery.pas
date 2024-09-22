unit uDataQuery;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.Provider,
  Datasnap.DBClient, Data.FMTBcd, Data.SqlExpr;

type
  TdmDataQuery = class(TDataModule)
    qryPedidos: TFDQuery;
    cdsPedidos: TClientDataSet;
    dspPedidos: TDataSetProvider;
    dspProduto: TDataSetProvider;
    cdsProduto: TClientDataSet;
    qryProduto: TFDQuery;
    dsProdutos: TDataSource;
    dsPedidos: TDataSource;
    cdsProdutocoddescProduto: TStringField;
    cdsProdutoprecovenda: TSingleField;
    cdsProdutocodigo: TAutoIncField;
    qryCliente: TFDQuery;
    dspCliente: TDataSetProvider;
    cdsCliente: TClientDataSet;
    cdsClientecodigo: TAutoIncField;
    cdsClientenome: TStringField;
    cdsClientecidade: TStringField;
    cdsClienteestado: TStringField;
    cdsPedidosVlTotalProduto: TAggregateField;
    dsCliente: TDataSource;
    cdsPedidoscodCliente: TIntegerField;
    cdsPedidoscodProduto: TIntegerField;
    cdsPedidosqtdProduto: TIntegerField;
    cdsPedidosvalorProduto: TSingleField;
    cdsPedidosdescricao: TStringField;
    cdsPedidosprecovenda: TSingleField;
    cdsPedidosnumeropedido: TIntegerField;
  private
    procedure UpdateNumeroPedido(aNumeroPedido: integer);
  public
    function InsertDadosGerais(aCodcliente: Integer; aValortotal: string): string;
    function InsertPedidosProdutos(aNumeroPedido, aCodproduto, aQuantidade:Integer; aValorunitario, aValortotal: Double): string;
    function CancelarPedido(aNumeroPedido: integer): string;
  end;

var
  dmDataQuery: TdmDataQuery;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDataBase, uUtil;

{$R *.dfm}

function TdmDataQuery.InsertPedidosProdutos(aNumeroPedido, aCodproduto, aQuantidade:Integer; aValorunitario, aValortotal: Double): string;
var
   sSQL: String;
   _qry: TFDQuery;
begin
  try
    _qry  := TFDQuery.Create(nil);
    sSQL := 'INSERT INTO `testetecnico`.`pedidosprodutos`'+
            '(`numeropedido`,'+
            '`codproduto`,'+
            '`quantidade`,'+
            '`valorunitario`,'+
            '`valortotal`)'+
            ' VALUES '+
            '(:numeropedido,'+
            ':codproduto,'+
            ':quantidade,'+
            ':valorunitario,'+
            ':valortotal);';
    _qry.Connection := dmDataBase.FDConnection;
    _qry.SQL.Text := sSQL;
    _qry.ParamByName('numeropedido').AsInteger := aNumeroPedido;
    _qry.ParamByName('codproduto').AsInteger := aCodproduto;
    _qry.ParamByName('quantidade').AsInteger := aQuantidade;
    _qry.ParamByName('valorunitario').AsFloat := aValorunitario;
    _qry.ParamByName('valortotal').AsFloat := aValortotal;
    _qry.ExecSQL;
    Result := '1';
  except on E: Exception do
    Result := '0';
  end;
end;

function TdmDataQuery.InsertDadosGerais(aCodcliente: Integer; aValortotal: string): string;
var
   sSQL, sDataEmissao: String;
   iNumeroPedido: Integer;
   _qry: TFDQuery;
begin
  try
    iNumeroPedido := 0;
    _qry  := TFDQuery.Create(nil);
    _qry.Connection := dmDataBase.FDConnection;
    _qry.SQL.Text := 'select case when count(*)=0 then 1 else max(numeropedido)+1 end as ultnumeropedido from pedidosprodutos';
    _qry.Open;
    iNumeroPedido := _qry.FieldByName('ultnumeropedido').AsInteger;
    UpdateNumeroPedido(iNumeroPedido);
    cdsPedidos.First;
    while not(cdsPedidos.Eof) do
    begin
      InsertPedidosProdutos(iNumeroPedido,
                            cdsPedidos.FieldByName('codProduto').AsInteger,
                            cdsPedidos.FieldByName('qtdProduto').AsInteger,
                            cdsPedidos.FieldByName('valorProduto').AsFloat,
                            cdsPedidos.FieldByName('VlTotalProduto').Value);
      cdsPedidos.Next;
    end;
    _qry.Close;
    _qry.SQL.Clear;
    sDataEmissao := FormatDateTime('dd/mm/yyyy', Now);
    sSQL := 'INSERT INTO `testetecnico`.`dadosgerais`'+
            '(`numeropedido`,'+
            '`dataemissao`,'+
            '`codcliente`,'+
            '`valortotal`)'+
            ' VALUES '+
            '(:numeropedido,'+
            ':dataemissao,'+
            ':codcliente,'+
            ':valortotal);';
    _qry.SQL.Text := sSQL;
    _qry.ParamByName('numeropedido').AsInteger := iNumeroPedido;
    _qry.ParamByName('dataemissao').AsDate := StrToDate(sDataEmissao);
    _qry.ParamByName('codcliente').AsInteger := aCodcliente;
    _qry.ParamByName('valortotal').AsFloat := StrToFloat(aValortotal);
    _qry.ExecSQL;
    Result := PChar('Pedido '+IntToStr(iNumeroPedido)+' gravado com sucesso.');
  except on E: Exception do
    Result := 'Erro: ' + E.Message;
  end;
end;

procedure TdmDataQuery.UpdateNumeroPedido(aNumeroPedido: integer);
var
   _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  _qry.Connection := dmDataBase.FDConnection;
  _qry.SQL.Text := 'update pedidos set numeropedido=:numeropedido where numeropedido=0';
  _qry.Params.ParamByName('numeropedido').AsInteger := aNumeroPedido;
  _qry.ExecSQL;
end;

function TdmDataQuery.CancelarPedido(aNumeroPedido: integer): string;
var
  _qry: TFDQuery;
begin
  try
    _qry := TFDQuery.Create(nil);
    _qry.Connection := dmDataBase.FDConnection;
    _qry.SQL.Text := 'delete from pedidos where numeropedido=:numeropedido';
    _qry.Params.ParamByName('numeropedido').AsInteger := aNumeroPedido;
    _qry.ExecSQL;
    _qry.SQL.Clear;
    _qry.SQL.Text := 'delete from pedidosprodutos where numeropedido=:numeropedido';
    _qry.Params.ParamByName('numeropedido').AsInteger := aNumeroPedido;
    _qry.ExecSQL;
    _qry.SQL.Clear;
    _qry.SQL.Text := 'delete from dadosgerais where numeropedido=:numeropedido';
    _qry.Params.ParamByName('numeropedido').AsInteger := aNumeroPedido;
    _qry.ExecSQL;
    Result := PChar('Pedido '+IntToStr(aNumeroPedido)+' cancelado com sucesso.');
  except on E: Exception do
    Result := 'Erro: ' + E.Message;
  end;
end;

end.
