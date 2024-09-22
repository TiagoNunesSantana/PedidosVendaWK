object dmDataQuery: TdmDataQuery
  Height = 410
  Width = 939
  PixelsPerInch = 144
  object qryPedidos: TFDQuery
    Connection = dmDataBase.FDConnection
    SQL.Strings = (
      'select distinct '
      'p.codCliente,'
      'p.codProduto,'
      'p.qtdProduto,'
      'p.valorProduto,'
      'p.numeropedido,'
      'pd.descricao,'
      'pd.precovenda'
      'from pedidos p'
      'left join pedidosprodutos pp on pp.codproduto=p.codproduto'
      'inner join clientes c on c.codigo=p.codCliente'
      'inner join produtos pd on pd.codigo=p.codProduto'
      'where p.numeropedido = :numeropedido'
      'order by p.codProduto')
    Left = 72
    Top = 36
    ParamData = <
      item
        Name = 'NUMEROPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <
      item
        DataType = ftInteger
        Name = 'numeropedido'
        ParamType = ptOutput
      end>
    ProviderName = 'dspPedidos'
    Left = 72
    Top = 208
    object cdsPedidoscodCliente: TIntegerField
      FieldName = 'codCliente'
      Origin = 'codCliente'
      Required = True
    end
    object cdsPedidoscodProduto: TIntegerField
      FieldName = 'codProduto'
      Origin = 'codProduto'
      Required = True
    end
    object cdsPedidosqtdProduto: TIntegerField
      FieldName = 'qtdProduto'
      Origin = 'qtdProduto'
      Required = True
    end
    object cdsPedidosvalorProduto: TSingleField
      FieldName = 'valorProduto'
      Origin = 'valorProduto'
      Required = True
      DisplayFormat = 'R$ #,###0.00'
    end
    object cdsPedidosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object cdsPedidosprecovenda: TSingleField
      FieldName = 'precovenda'
      Origin = 'precovenda'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = 'R$ #,###0.00'
    end
    object cdsPedidosnumeropedido: TIntegerField
      FieldName = 'numeropedido'
      Origin = 'numeropedido'
      Required = True
    end
    object cdsPedidosVlTotalProduto: TAggregateField
      FieldName = 'VlTotalProduto'
      Active = True
      currency = True
      DisplayName = ''
      DisplayFormat = 'Total   R$ #,###0.00'
      Expression = 'SUM(valorProduto)'
    end
  end
  object dspPedidos: TDataSetProvider
    DataSet = qryPedidos
    Constraints = False
    Left = 72
    Top = 120
  end
  object dspProduto: TDataSetProvider
    DataSet = qryProduto
    Constraints = False
    Left = 204
    Top = 120
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProduto'
    Left = 204
    Top = 204
    object cdsProdutocoddescProduto: TStringField
      FieldName = 'coddescProduto'
      Origin = 'coddescProduto'
      ProviderFlags = []
      ReadOnly = True
      Size = 114
    end
    object cdsProdutoprecovenda: TSingleField
      FieldName = 'precovenda'
      Origin = 'precovenda'
      Required = True
      DisplayFormat = 'R$ #,###0.00'
    end
    object cdsProdutocodigo: TAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
  end
  object qryProduto: TFDQuery
    Connection = dmDataBase.FDConnection
    SQL.Strings = (
      'select '
      'p.codigo,'
      
        'concat(p.codigo, " - ", p.descricao) as coddescProduto,p.precove' +
        'nda'
      'from produtos p')
    Left = 204
    Top = 36
  end
  object dsProdutos: TDataSource
    DataSet = cdsProduto
    Left = 204
    Top = 288
  end
  object dsPedidos: TDataSource
    DataSet = cdsPedidos
    Left = 72
    Top = 288
  end
  object qryCliente: TFDQuery
    Connection = dmDataBase.FDConnection
    SQL.Strings = (
      'select '
      'c.codigo,'
      'c.nome,'
      'c.cidade,'
      'c.estado'
      'from '
      'Clientes c')
    Left = 336
    Top = 36
  end
  object dspCliente: TDataSetProvider
    DataSet = qryCliente
    Constraints = False
    Left = 336
    Top = 120
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliente'
    Left = 336
    Top = 204
    object cdsClientecodigo: TAutoIncField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsClientenome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 45
    end
    object cdsClientecidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
      Size = 45
    end
    object cdsClienteestado: TStringField
      FieldName = 'estado'
      Origin = 'estado'
      Required = True
      Size = 45
    end
  end
  object dsCliente: TDataSource
    DataSet = cdsCliente
    Left = 336
    Top = 288
  end
end
