object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pedidos de Vendas'
  ClientHeight = 442
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 423
    Width = 604
    Height = 19
    Panels = <>
    ExplicitTop = 405
    ExplicitWidth = 594
  end
  object dbgPedido: TDBGrid
    Left = 0
    Top = 97
    Width = 604
    Height = 287
    Align = alClient
    DataSource = dmDataQuery.dsPedidos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = dbgPedidoKeyDown
    OnKeyPress = dbgPedidoKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'codProduto'
        Title.Caption = 'Cod. Produto'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descri'#231#227'o do Produto'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'qtdProduto'
        Title.Caption = 'Qtd. Produto'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valorProduto'
        Title.Caption = 'Valor'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 384
    Width = 604
    Height = 39
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 366
    ExplicitWidth = 594
    object dbtVlTotalProduto: TDBText
      Left = 464
      Top = 13
      Width = 105
      Height = 17
      Alignment = taRightJustify
      DataField = 'VlTotalProduto'
      DataSource = dmDataQuery.dsPedidos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object btnGravarPedido: TBitBtn
      Left = 17
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravarPedidoClick
    end
    object btnConsultarPedido: TBitBtn
      Left = 120
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Consultar Pedido'
      TabOrder = 1
      Visible = False
      OnClick = btnConsultarPedidoClick
    end
    object btnCancelarPedido: TBitBtn
      Left = 223
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Cancelar Pedido'
      Enabled = False
      TabOrder = 2
      Visible = False
      OnClick = btnCancelarPedidoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 97
    Align = alTop
    Caption = 'codProduto'
    TabOrder = 3
    ExplicitTop = -6
    object Label2: TLabel
      Left = 144
      Top = 15
      Width = 165
      Height = 15
      Caption = 'C'#243'digo e Descri'#231#227'o do Produto'
    end
    object Label4: TLabel
      Left = 446
      Top = 15
      Width = 69
      Height = 15
      Caption = 'Qtd. Produto'
    end
    object Label5: TLabel
      Left = 521
      Top = 15
      Width = 26
      Height = 15
      Caption = 'Valor'
    end
    object Label6: TLabel
      Left = 382
      Top = 15
      Width = 58
      Height = 15
      Caption = 'Vl. Unit'#225'rio'
    end
    object Cliente: TLabel
      Left = 16
      Top = 15
      Width = 37
      Height = 15
      Caption = 'Cliente'
    end
    object dbValorTotalProduto: TDBEdit
      Left = 521
      Top = 36
      Width = 65
      Height = 23
      Color = cl3DLight
      DataField = 'valorProduto'
      DataSource = dmDataQuery.dsPedidos
      Enabled = False
      TabOrder = 0
      OnKeyPress = dbValorTotalProdutoKeyPress
    end
    object dblCodProduto: TDBLookupComboBox
      Left = 144
      Top = 36
      Width = 232
      Height = 23
      DataField = 'codProduto'
      DataSource = dmDataQuery.dsPedidos
      KeyField = 'codigo'
      ListField = 'coddescProduto'
      ListSource = dmDataQuery.dsProdutos
      TabOrder = 2
    end
    object dbVlUnitario: TDBEdit
      Left = 382
      Top = 36
      Width = 58
      Height = 23
      DataField = 'precovenda'
      DataSource = dmDataQuery.dsProdutos
      TabOrder = 3
      OnKeyPress = dbVlUnitarioKeyPress
    end
    object btnIncluir: TBitBtn
      Left = 17
      Top = 65
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 6
      OnClick = btnIncluirClick
    end
    object dbQtdProduto: TDBEdit
      Left = 446
      Top = 36
      Width = 69
      Height = 23
      DataField = 'qtdProduto'
      DataSource = dmDataQuery.dsPedidos
      TabOrder = 4
      OnExit = dbQtdProdutoExit
      OnKeyPress = dbQtdProdutoKeyPress
    end
    object btnSalvar: TBitBtn
      Left = 511
      Top = 65
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = btnSalvarClick
    end
    object dblCliente: TDBLookupComboBox
      Left = 16
      Top = 36
      Width = 122
      Height = 23
      DataField = 'codCliente'
      DataSource = dmDataQuery.dsPedidos
      KeyField = 'codigo'
      ListField = 'nome'
      ListSource = dmDataQuery.dsCliente
      TabOrder = 1
    end
  end
end
