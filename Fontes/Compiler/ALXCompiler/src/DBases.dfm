object dmBases: TdmBases
  OldCreateOrder = False
  Height = 166
  Width = 215
  object sqqBases: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select BAS.CODI_BAS,'
      '       BAS.DESC_BAS,'
      '       BAS.TIPO_BAS,'
      '       BAS.DIRE_BAS,'
      '       BAS.SNAM_BAS,'
      '       BAS.SERV_BAS,'
      '       BAS.PORT_BAS,'
      '       BAS.CODI_USU  '
      'from BASES BAS '
      'where (BAS.CODI_USU = :CODI_USU) '
      'order by BAS.DESC_BAS')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 80
    Top = 8
    object sqqBasesCODI_BAS: TIntegerField
      FieldName = 'CODI_BAS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqBasesDESC_BAS: TStringField
      FieldName = 'DESC_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqBasesTIPO_BAS: TStringField
      FieldName = 'TIPO_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 2
    end
    object sqqBasesDIRE_BAS: TStringField
      FieldName = 'DIRE_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object sqqBasesSNAM_BAS: TStringField
      FieldName = 'SNAM_BAS'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object sqqBasesSERV_BAS: TStringField
      FieldName = 'SERV_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object sqqBasesPORT_BAS: TIntegerField
      FieldName = 'PORT_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqBasesCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object dspBases: TDataSetProvider
    DataSet = sqqBases
    UpdateMode = upWhereKeyOnly
    Left = 80
    Top = 56
  end
  object cdsBases: TClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    ProviderName = 'dspBases'
    BeforePost = cdsBasesBeforePost
    Left = 80
    Top = 104
    object cdsBasesCODI_BAS: TIntegerField
      FieldName = 'CODI_BAS'
    end
    object cdsBasesDESC_BAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 200
      FieldName = 'DESC_BAS'
      Required = True
      Size = 50
    end
    object cdsBasesTIPO_BAS: TStringField
      DisplayLabel = 'SGBD'
      DisplayWidth = 60
      FieldName = 'TIPO_BAS'
      Required = True
      OnGetText = cdsBasesTIPO_BASGetText
      FixedChar = True
      Size = 2
    end
    object cdsBasesDIRE_BAS: TStringField
      DisplayLabel = 'Diret'#243'rio / Schema'
      DisplayWidth = 360
      FieldName = 'DIRE_BAS'
      Required = True
      Size = 100
    end
    object cdsBasesSNAM_BAS: TStringField
      FieldName = 'SNAM_BAS'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object cdsBasesSERV_BAS: TStringField
      DisplayLabel = 'Servidor'
      DisplayWidth = 80
      FieldName = 'SERV_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object cdsBasesPORT_BAS: TIntegerField
      DisplayLabel = 'Porta'
      DisplayWidth = 46
      FieldName = 'PORT_BAS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsBasesCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
end
