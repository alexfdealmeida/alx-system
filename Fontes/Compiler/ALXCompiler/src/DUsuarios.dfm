object dmUsuarios: TdmUsuarios
  OldCreateOrder = False
  Height = 164
  Width = 215
  object sqqUsuarios: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select USU.CODI_USU,'
      '          USU.NOME_USU,'
      '          USU.LOGI_USU,'
      '          USU.SENH_USU,'
      '          USU.ONLI_USU,'
      '          USU.ADMI_USU '
      'from USUARIO USU '
      'order by USU.NOME_USU')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 80
    Top = 8
    object sqqUsuariosCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqUsuariosNOME_USU: TStringField
      FieldName = 'NOME_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object sqqUsuariosLOGI_USU: TStringField
      FieldName = 'LOGI_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqUsuariosSENH_USU: TStringField
      FieldName = 'SENH_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqUsuariosONLI_USU: TStringField
      FieldName = 'ONLI_USU'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqUsuariosADMI_USU: TStringField
      FieldName = 'ADMI_USU'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object dspUsuarios: TDataSetProvider
    DataSet = sqqUsuarios
    Options = [poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 80
    Top = 56
  end
  object cdsUsuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuarios'
    Left = 80
    Top = 104
    object cdsUsuariosCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsUsuariosNOME_USU: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 450
      FieldName = 'NOME_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
    object cdsUsuariosLOGI_USU: TStringField
      DisplayLabel = 'Login'
      DisplayWidth = 300
      FieldName = 'LOGI_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsUsuariosSENH_USU: TStringField
      FieldName = 'SENH_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsUsuariosONLI_USU: TStringField
      FieldName = 'ONLI_USU'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsUsuariosENVIAR: TBooleanField
      FieldKind = fkInternalCalc
      FieldName = 'ENVIAR'
    end
    object cdsUsuariosADMI_USU: TStringField
      FieldName = 'ADMI_USU'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
end
