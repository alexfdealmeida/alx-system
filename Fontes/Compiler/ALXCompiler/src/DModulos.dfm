object dmModulos: TdmModulos
  OldCreateOrder = False
  Height = 154
  Width = 251
  object sqqModulos: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select MOD.CODI_MOD,'
      '       MOD.DESC_MOD,'
      '       MOD.WANT_MOD,'
      '       MOD.DATE_MOD,'
      '       MOD.COMP_MOD,'
      '       MOD.CODI_USU,'
      '       MOD.LAST_MOD,'
      '       MOD.AUTO_MOD,'
      '       MOD.DULT_MOD,'
      '       MOD.VULT_MOD '
      'from MODULO MOD '
      'where (MOD.CODI_USU = :CODI_USU)'
      'order by MOD.WANT_MOD')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 80
    object sqqModulosCODI_MOD: TIntegerField
      FieldName = 'CODI_MOD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqModulosDESC_MOD: TStringField
      FieldName = 'DESC_MOD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqModulosWANT_MOD: TStringField
      FieldName = 'WANT_MOD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object sqqModulosDATE_MOD: TSQLTimeStampField
      FieldName = 'DATE_MOD'
      ProviderFlags = [pfInUpdate]
    end
    object sqqModulosCOMP_MOD: TIntegerField
      FieldName = 'COMP_MOD'
      ProviderFlags = [pfInUpdate]
    end
    object sqqModulosCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqqModulosLAST_MOD: TStringField
      FieldName = 'LAST_MOD'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqModulosAUTO_MOD: TStringField
      FieldName = 'AUTO_MOD'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqModulosDULT_MOD: TSQLTimeStampField
      FieldName = 'DULT_MOD'
      ProviderFlags = [pfInUpdate]
    end
    object sqqModulosVULT_MOD: TStringField
      FieldName = 'VULT_MOD'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
  end
  object dspModulos: TDataSetProvider
    DataSet = sqqModulos
    UpdateMode = upWhereKeyOnly
    Left = 80
    Top = 48
  end
  object cdsModulos: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    ProviderName = 'dspModulos'
    AfterOpen = cdsModulosAfterOpen
    BeforePost = cdsModulosBeforePost
    Left = 80
    Top = 96
    object cdsModulosCODI_MOD: TIntegerField
      FieldName = 'CODI_MOD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsModulosDESC_MOD: TStringField
      FieldName = 'DESC_MOD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsModulosWANT_MOD: TStringField
      FieldName = 'WANT_MOD'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object cdsModulosSELECIONA: TBooleanField
      FieldKind = fkInternalCalc
      FieldName = 'SELECIONA'
    end
    object cdsModulosDATE_MOD: TSQLTimeStampField
      FieldName = 'DATE_MOD'
      ProviderFlags = [pfInUpdate]
    end
    object cdsModulosDATE_TMP: TSQLTimeStampField
      FieldKind = fkInternalCalc
      FieldName = 'DATE_TMP'
    end
    object cdsModulosSTATUS: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'STATUS'
      Size = 1
    end
    object cdsModulosCOMP_MOD: TIntegerField
      FieldName = 'COMP_MOD'
      ProviderFlags = [pfInUpdate]
    end
    object cdsModulosCOMP_TMP: TIntegerField
      FieldKind = fkInternalCalc
      FieldName = 'COMP_TMP'
    end
    object cdsModulosCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsModulosLAST_MOD: TStringField
      FieldName = 'LAST_MOD'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsModulosAUTO_MOD: TStringField
      FieldName = 'AUTO_MOD'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsModulosDULT_MOD: TSQLTimeStampField
      FieldName = 'DULT_MOD'
      ProviderFlags = [pfInUpdate]
    end
    object cdsModulosDULT_TMP: TSQLTimeStampField
      FieldKind = fkInternalCalc
      FieldName = 'DULT_TMP'
    end
    object cdsModulosVULT_MOD: TStringField
      FieldName = 'VULT_MOD'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsModulosVULT_TMP: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'VULT_TMP'
      Size = 100
    end
  end
  object sqqAux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 176
  end
  object dspAux: TDataSetProvider
    DataSet = sqqAux
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 176
    Top = 48
  end
  object cdsAux: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspAux'
    Left = 176
    Top = 96
  end
end
