object DmTicket: TDmTicket
  OldCreateOrder = False
  Height = 363
  Width = 423
  object sqqTicket: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_TIC'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select T.*'
      'from TICKET T'
      'where T.CODI_TIC =:CODI_TIC')
    SQLConnection = dmPrincipal.sqcPrincipal
    Left = 56
    Top = 72
    object sqqTicketCODI_TIC: TIntegerField
      FieldName = 'CODI_TIC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqqTicketDESC_TIC: TStringField
      FieldName = 'DESC_TIC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 2000
    end
  end
  object dspTicket: TDataSetProvider
    DataSet = sqqTicket
    BeforeUpdateRecord = dspTicketBeforeUpdateRecord
    Left = 168
    Top = 72
  end
  object cdsTicket: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_TIC'
        ParamType = ptInput
      end>
    ProviderName = 'dspTicket'
    Left = 280
    Top = 72
    object cdsTicketCODI_TIC: TIntegerField
      FieldName = 'CODI_TIC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsTicketDESC_TIC: TStringField
      FieldName = 'DESC_TIC'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 2000
    end
    object cdsTicketsqqValidacao: TDataSetField
      FieldName = 'sqqValidacao'
    end
  end
  object sqqValidacao: TSQLQuery
    DataSource = dtsTicket
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_TIC'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select V.*, D.NOME_DES, D.EMAI_DES '
      'from VALIDACAO V'
      'left join DESENVOLVEDOR D on (V.CODI_DES = D.CODI_DES)'
      'where V.CODI_TIC =:CODI_TIC'
      'order by V.CODI_VAL')
    SQLConnection = dmPrincipal.sqcPrincipal
    Left = 56
    Top = 184
    object sqqValidacaoCODI_VAL: TIntegerField
      FieldName = 'CODI_VAL'
      Required = True
    end
    object sqqValidacaoREVISION: TStringField
      FieldName = 'REVISION'
      Required = True
      Size = 40
    end
    object sqqValidacaoSITU_VAL: TStringField
      FieldName = 'SITU_VAL'
      FixedChar = True
      Size = 1
    end
    object sqqValidacaoCODI_DES: TIntegerField
      FieldName = 'CODI_DES'
    end
    object sqqValidacaoCODI_TIC: TIntegerField
      FieldName = 'CODI_TIC'
      Required = True
    end
    object sqqValidacaoNOME_DES: TStringField
      FieldName = 'NOME_DES'
      ProviderFlags = []
      Size = 50
    end
    object sqqValidacaoEMAI_DES: TStringField
      FieldName = 'EMAI_DES'
      ProviderFlags = []
      Size = 50
    end
    object sqqValidacaoDESC_VAL: TMemoField
      FieldName = 'DESC_VAL'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object sqqValidacaoUSUA_VAL: TIntegerField
      FieldName = 'USUA_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoCPAD_VAL: TIntegerField
      FieldName = 'CPAD_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoLOGI_VAL: TIntegerField
      FieldName = 'LOGI_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoIMPA_VAL: TIntegerField
      FieldName = 'IMPA_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoEMAI_VAL: TIntegerField
      FieldName = 'EMAI_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoREDU_VAL: TIntegerField
      FieldName = 'REDU_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoFIND_VAL: TIntegerField
      FieldName = 'FIND_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object sqqValidacaoEMIS_VAL: TDateField
      FieldName = 'EMIS_VAL'
    end
  end
  object dtsTicket: TDataSource
    DataSet = sqqTicket
    Left = 56
    Top = 128
  end
  object cdsValidacao: TClientDataSet
    Aggregates = <>
    DataSetField = cdsTicketsqqValidacao
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_TIC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODI_VAL'
        ParamType = ptInput
      end>
    OnNewRecord = cdsValidacaoNewRecord
    Left = 280
    Top = 144
    object cdsValidacaoCODI_VAL: TIntegerField
      FieldName = 'CODI_VAL'
      Required = True
    end
    object cdsValidacaoREVISION: TStringField
      FieldName = 'REVISION'
      Required = True
      Size = 40
    end
    object cdsValidacaoSITU_VAL: TStringField
      FieldName = 'SITU_VAL'
      FixedChar = True
      Size = 1
    end
    object cdsValidacaoCODI_DES: TIntegerField
      FieldName = 'CODI_DES'
    end
    object cdsValidacaoCODI_TIC: TIntegerField
      FieldName = 'CODI_TIC'
      Required = True
    end
    object cdsValidacaoNOME_DES: TStringField
      FieldName = 'NOME_DES'
      ProviderFlags = []
      Size = 50
    end
    object cdsValidacaoEMAI_DES: TStringField
      FieldName = 'EMAI_DES'
      ProviderFlags = []
      Size = 50
    end
    object cdsValidacaoDESC_VAL: TMemoField
      FieldName = 'DESC_VAL'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
      Size = 1
    end
    object cdsValidacaoUSUA_VAL: TIntegerField
      FieldName = 'USUA_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoCPAD_VAL: TIntegerField
      FieldName = 'CPAD_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoLOGI_VAL: TIntegerField
      FieldName = 'LOGI_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoIMPA_VAL: TIntegerField
      FieldName = 'IMPA_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoEMAI_VAL: TIntegerField
      FieldName = 'EMAI_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoREDU_VAL: TIntegerField
      FieldName = 'REDU_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoFIND_VAL: TIntegerField
      FieldName = 'FIND_VAL'
      ProviderFlags = [pfInUpdate]
    end
    object cdsValidacaoEMIS_VAL: TDateField
      FieldName = 'EMIS_VAL'
    end
  end
end
