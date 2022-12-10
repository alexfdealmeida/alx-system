object dmCompilacaoRemota: TdmCompilacaoRemota
  OldCreateOrder = False
  Height = 203
  Width = 213
  object cdsRequisicoes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRequisicoes'
    Left = 88
    Top = 120
    object cdsRequisicoesCODI_REQ: TIntegerField
      FieldName = 'CODI_REQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsRequisicoesCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsRequisicoesBRAN_REQ: TStringField
      FieldName = 'BRAN_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsRequisicoesDIRE_REQ: TStringField
      FieldName = 'DIRE_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object cdsRequisicoesDATA_REQ: TDateField
      FieldName = 'DATA_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsRequisicoesHORA_REQ: TTimeField
      FieldName = 'HORA_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsRequisicoesSITU_REQ: TStringField
      FieldName = 'SITU_REQ'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object cdsRequisicoesSTAT_REQ: TStringField
      FieldName = 'STAT_REQ'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsRequisicoesRESP_REQ: TStringField
      FieldName = 'RESP_REQ'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsRequisicoesNOME_USU: TStringField
      FieldName = 'NOME_USU'
      ProviderFlags = []
      Size = 100
    end
  end
  object sqqRequisicoes: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select REQ.CODI_REQ,'
      '       REQ.CODI_USU,'
      '       REQ.BRAN_REQ,'
      '       REQ.DIRE_REQ,'
      '       REQ.DATA_REQ,'
      '       REQ.HORA_REQ,'
      '       REQ.SITU_REQ,'
      '       REQ.STAT_REQ,'
      '       REQ.RESP_REQ,'
      '       USU.NOME_USU '
      'from REQUISICAO REQ '
      'inner join USUARIO USU on (USU.CODI_USU = REQ.CODI_USU)')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 88
    Top = 8
    object sqqRequisicoesCODI_REQ: TIntegerField
      FieldName = 'CODI_REQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqRequisicoesCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqRequisicoesBRAN_REQ: TStringField
      FieldName = 'BRAN_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqRequisicoesDIRE_REQ: TStringField
      FieldName = 'DIRE_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object sqqRequisicoesDATA_REQ: TDateField
      FieldName = 'DATA_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqRequisicoesHORA_REQ: TTimeField
      FieldName = 'HORA_REQ'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqRequisicoesSITU_REQ: TStringField
      FieldName = 'SITU_REQ'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object sqqRequisicoesSTAT_REQ: TStringField
      FieldName = 'STAT_REQ'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqRequisicoesRESP_REQ: TStringField
      FieldName = 'RESP_REQ'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqRequisicoesNOME_USU: TStringField
      FieldName = 'NOME_USU'
      ProviderFlags = []
      Size = 100
    end
  end
  object dspRequisicoes: TDataSetProvider
    DataSet = sqqRequisicoes
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 64
  end
end
