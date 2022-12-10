object dmDiretivas: TdmDiretivas
  OldCreateOrder = False
  Height = 158
  Width = 215
  object sqqDiretivas: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select DTV.CODI_DTV,'
      '       DTV.CODI_USU,'
      '       DTV.DIRE_DTV,'
      '       DTV.DESC_DTV,'
      '       DTV.GLOB_DTV,'
      '       DTV.SITU_DTV,'
      '       DTV.AUTO_DTV '
      'from DIRETIVA DTV'
      'where (DTV.CODI_USU = :CODI_USU) /*filtro*/ and'
      '           (DTV.GLOB_DTV = '#39'S'#39') and'
      '           (DTV.SITU_DTV <> '#39'S'#39')')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 88
    Top = 8
    object sqqDiretivasCODI_DTV: TIntegerField
      FieldName = 'CODI_DTV'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqDiretivasCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqqDiretivasDIRE_DTV: TStringField
      FieldName = 'DIRE_DTV'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqDiretivasDESC_DTV: TStringField
      FieldName = 'DESC_DTV'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object sqqDiretivasGLOB_DTV: TStringField
      FieldName = 'GLOB_DTV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqDiretivasSITU_DTV: TStringField
      FieldName = 'SITU_DTV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqDiretivasAUTO_DTV: TStringField
      FieldName = 'AUTO_DTV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object dspDiretivas: TDataSetProvider
    DataSet = sqqDiretivas
    Options = [poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 56
  end
  object cdsDiretivas: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    ProviderName = 'dspDiretivas'
    AfterOpen = cdsDiretivasAfterOpen
    BeforePost = cdsDiretivasBeforePost
    OnNewRecord = cdsDiretivasNewRecord
    Left = 88
    Top = 104
    object cdsDiretivasCODI_DTV: TIntegerField
      FieldName = 'CODI_DTV'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsDiretivasCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsDiretivasDIRE_DTV: TStringField
      DisplayLabel = 'Nome da diretiva'
      DisplayWidth = 250
      FieldName = 'DIRE_DTV'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsDiretivasDESC_DTV: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 350
      FieldName = 'DESC_DTV'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object cdsDiretivasGLOB_DTV: TStringField
      DisplayLabel = 'Global'
      DisplayWidth = 50
      FieldName = 'GLOB_DTV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsDiretivasSITU_DTV: TStringField
      DisplayLabel = 'Inativa'
      DisplayWidth = 50
      FieldName = 'SITU_DTV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsDiretivasSELECIONA: TBooleanField
      FieldKind = fkInternalCalc
      FieldName = 'SELECIONA'
    end
    object cdsDiretivasAUTO_DTV: TStringField
      FieldName = 'AUTO_DTV'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
end
