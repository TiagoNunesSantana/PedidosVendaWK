unit uPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmPedido = class(TForm)
    StatusBar1: TStatusBar;
    dbgPedido: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    dbValorTotalProduto: TDBEdit;
    dblCodProduto: TDBLookupComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbVlUnitario: TDBEdit;
    btnIncluir: TBitBtn;
    dbQtdProduto: TDBEdit;
    btnSalvar: TBitBtn;
    btnGravarPedido: TBitBtn;
    Cliente: TLabel;
    dblCliente: TDBLookupComboBox;
    dbtVlTotalProduto: TDBText;
    btnConsultarPedido: TBitBtn;
    btnCancelarPedido: TBitBtn;
    procedure dbVlUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure dbValorTotalProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbQtdProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure dbQtdProdutoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConsultarPedidoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
  private
    procedure EnableTrueFalse(bTrueFalse: Boolean);
    procedure OpenCloseClientDataSet(bOpenClose: Boolean);
    procedure VisibleTrueFalse(bTrueFalse: Boolean);
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;
  gsNumeroPedido: string;

implementation

{$R *.dfm}

uses uDataQuery, uUtil;

procedure TfrmPedido.EnableTrueFalse(bTrueFalse: Boolean);
begin
  if (bTrueFalse) then
  begin
    dblCliente.Enabled := True;
    dblCodProduto.Enabled := True;
    dbVlUnitario.Enabled := True;
    dbQtdProduto.Enabled := True;
    dbValorTotalProduto.Enabled := True;
    btnIncluir.Enabled := False;
    btnSalvar.Enabled := True;
    btnGravarPedido.Enabled := True;
  end else
  begin
    dblCliente.Enabled := False;
    dblCodProduto.Enabled := False;
    dbVlUnitario.Enabled := False;
    dbQtdProduto.Enabled := False;
    dbValorTotalProduto.Enabled := False;
    btnIncluir.Enabled := True;
    btnSalvar.Enabled := False;
    btnGravarPedido.Enabled := False;
  end;
end;

procedure TfrmPedido.OpenCloseClientDataSet(bOpenClose: Boolean);
begin
  if (bOpenClose) then
  begin
    dmDataQuery.cdsProduto.Active := True;
    dmDataQuery.cdsCliente.Active := True;
    dmDataQuery.cdsPedidos.Active := True;
  end else
  begin
    dmDataQuery.cdsProduto.Active := False;
    dmDataQuery.cdsCliente.Active := False;
    dmDataQuery.cdsPedidos.Active := False;
  end;
end;

procedure TfrmPedido.VisibleTrueFalse(bTrueFalse: Boolean);
begin
  if (bTrueFalse) then
  begin
    btnConsultarPedido.Visible := True;
    btnCancelarPedido.Visible := True;
  end else
  begin
    btnConsultarPedido.Visible := False;
    btnCancelarPedido.Visible := False;
  end;
end;

procedure TfrmPedido.btnCancelarPedidoClick(Sender: TObject);
var
  sNumeroPedido, sReturn: string;
  bOk: Boolean;
begin
  if MessageDlg('Deseja realmente Cancelar o Pedido.',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    bOk := InputQuery('Calcelar Pedido','Insira o número do Pedido:',sNumeroPedido);
    if (bOk) then
    begin
      sReturn := dmDataQuery.CancelarPedido(StrToInt(sNumeroPedido));
      Application.MessageBox(PChar(sReturn),'Pedidos de Vendas',MB_OK+MB_ICONEXCLAMATION);
      dmDataQuery.cdsPedidos.Refresh;
    end;
  end;
end;

procedure TfrmPedido.btnConsultarPedidoClick(Sender: TObject);
var
  sNumeroPedido, sMsg: string;
  bOk, bNumber: Boolean;
  i: Integer;
begin
  i := 0;
  repeat
    bOk := InputQuery('Consultar Pedido','Insira o número do Pedido:',sNumeroPedido);
    if (bOk) then
    begin
      dmDataQuery.cdsPedidos.Active := False;
      dmDataQuery.cdsPedidos.Params.ParamByName('numeropedido').AsInteger := StrToInt(sNumeroPedido);
      dmDataQuery.cdsPedidos.Active := True;
      if (dmDataQuery.cdsPedidos.IsEmpty) then
      begin
        sMsg := 'Não foi encontrado o numero do pedido informado.'+#13+'Deseja consultar outro Pedido ?';
        if (Application.MessageBox(PChar(sMsg),'Atenção',MB_YESNO+MB_ICONQUESTION)=IDNO) then i := 1;
      end else
      begin
        i := 1;
      end;
    end;
  until i > 0;
  btnCancelarPedido.Enabled := True;
  dmDataQuery.cdsProduto.Active := True;
  dmDataQuery.cdsCliente.Active := True;
  dmDataQuery.cdsPedidos.Active := True;
end;

procedure TfrmPedido.btnGravarPedidoClick(Sender: TObject);
var sReturn: string;
begin
  if not(dbgPedido.DataSource.DataSet.IsEmpty) then
  begin
    if (MessageDlg('Confirma os itens inserido no pedido ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      sReturn := dmDataQuery.InsertDadosGerais(
      dmDataQuery.cdsCliente.FieldByName('codigo').AsInteger,
      dmDataQuery.cdsPedidos.FieldByName('VlTotalProduto').AsString);
      Application.MessageBox(PChar(sReturn),'Pedidos de Vendas',MB_OK+MB_ICONEXCLAMATION);
      EnableTrueFalse(False);
      OpenCloseClientDataSet(False);
      VisibleTrueFalse(True);
    end;
  end;
end;

procedure TfrmPedido.btnIncluirClick(Sender: TObject);
begin
  EnableTrueFalse(True);
  dmDataQuery.cdsPedidos.Active := False;
  dmDataQuery.cdsPedidos.Params.ParamByName('numeropedido').AsInteger := 0;
  dmDataQuery.cdsPedidos.Active := True;
  dmDataQuery.cdsPedidos.Append;
  dblCliente.SetFocus;
  VisibleTrueFalse(False);
end;

procedure TfrmPedido.dbgPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
  begin
    with dmDataQuery do
    begin
      if MessageDlg('Deseja realmente Excluir o produto '''+dbgPedido.DataSource.DataSet.FieldByName('descricao').AsString+'''',
          mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
        cdsPedidos.Delete;
        cdsPedidos.ApplyUpdates(0);
        cdsPedidos.Refresh;
      end;
    end;
  end;
end;

procedure TfrmPedido.dbgPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) then
  begin
    EnableTrueFalse(True);
    OpenCloseClientDataSet(True);
    dmDataQuery.cdsPedidos.Edit;
    dblCliente.SetFocus;
    btnCancelarPedido.Enabled := False;
  end;
end;

procedure TfrmPedido.dbQtdProdutoExit(Sender: TObject);
begin
  with dmDataQuery do
  begin
    if (cdsPedidos.FieldByName('qtdProduto').AsInteger > 0) and
       (cdsProduto.FieldByName('precovenda').AsFloat > 0) then
    begin
      cdsPedidos.FieldByName('valorProduto').AsFloat :=
      cdsPedidos.FieldByName('qtdProduto').AsInteger*cdsProduto.FieldByName('precovenda').AsFloat;
    end;
  end;
end;

procedure TfrmPedido.dbQtdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in['0'..'9',#08]) then
    key:=#0;
end;

procedure TfrmPedido.dbValorTotalProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in['0'..'9',#08,',','.']) then
    key:=#0;
end;

procedure TfrmPedido.dbVlUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in['0'..'9',#08,',','.']) then
    key:=#0;
end;

procedure TfrmPedido.edtQtdProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in['0'..'9',#08]) then
    key:=#0;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  OpenCloseClientDataSet(False);
  EnableTrueFalse(False);
  VisibleTrueFalse(True);
end;

procedure TfrmPedido.btnSalvarClick(Sender: TObject);
begin
  try
    with dmDataQuery do
    begin
      cdsPedidos.FieldByName('numeropedido').AsInteger := 0;
      cdsPedidos.FieldByName('valorProduto').AsFloat :=
      cdsPedidos.FieldByName('qtdProduto').AsInteger*cdsProduto.FieldByName('precovenda').AsFloat;
      cdsPedidos.Post;
      cdsPedidos.ApplyUpdates(0);
      cdsPedidos.Refresh;
    end;
    EnableTrueFalse(False);
    VisibleTrueFalse(False);
    btnGravarPedido.Enabled := True;
  except on E: Exception do
    ShowMessage('Erro: ' + E.Message);
  end;
end;

end.
