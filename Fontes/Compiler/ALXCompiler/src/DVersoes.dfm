object dmVersoes: TdmVersoes
  OldCreateOrder = False
  Height = 394
  Width = 328
  object sqqVersoes: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select VER.CODI_VER,'
      '       VER.DESC_VER,'
      '       VER.DEXE_VER,'
      '       VER.DZIP_VER,'
      '       VER.DFON_VER,       '
      '       VER.DGER_VER,'
      '       VER.DREV_VER,'
      '       VER.DCFG_VER,'
      '       VER.SITU_VER,'
      '       VER.VERS_VER,'
      '       VER.CODI_USU,'
      '       VER.COMP_VER,'
      '       VER.GVPD_VER,'
      '       VER.DTMP_VER,'
      '       VER.DELP_VER        '
      'from VERSAO VER '
      'where (VER.CODI_USU = :CODI_USU)'
      'order by VER.DESC_VER')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 160
    Top = 16
    object sqqVersoesCODI_VER: TIntegerField
      FieldName = 'CODI_VER'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqVersoesDESC_VER: TStringField
      FieldName = 'DESC_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object sqqVersoesDEXE_VER: TStringField
      FieldName = 'DEXE_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesDZIP_VER: TStringField
      FieldName = 'DZIP_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesDREV_VER: TStringField
      FieldName = 'DREV_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesDFON_VER: TStringField
      FieldName = 'DFON_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesDGER_VER: TStringField
      FieldName = 'DGER_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesDCFG_VER: TStringField
      FieldName = 'DCFG_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesSITU_VER: TStringField
      FieldName = 'SITU_VER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqVersoesVERS_VER: TStringField
      FieldName = 'VERS_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object sqqVersoesCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqqVersoesCOMP_VER: TStringField
      FieldName = 'COMP_VER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqVersoesGVPD_VER: TStringField
      FieldName = 'GVPD_VER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 3
    end
    object sqqVersoesDTMP_VER: TStringField
      FieldName = 'DTMP_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqVersoesDELP_VER: TStringField
      FieldName = 'DELP_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
  end
  object dspVersoes: TDataSetProvider
    DataSet = sqqVersoes
    Options = [poCascadeDeletes, poCascadeUpdates, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    BeforeUpdateRecord = dspVersoesBeforeUpdateRecord
    Left = 160
    Top = 64
  end
  object cdsVersoes: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    ProviderName = 'dspVersoes'
    BeforePost = cdsVersoesBeforePost
    OnNewRecord = cdsVersoesNewRecord
    BeforeApplyUpdates = cdsVersoesBeforeApplyUpdates
    Left = 160
    Top = 112
    object cdsVersoesCODI_VER: TIntegerField
      FieldName = 'CODI_VER'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsVersoesDESC_VER: TStringField
      FieldName = 'DESC_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsVersoesDEXE_VER: TStringField
      FieldName = 'DEXE_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesDZIP_VER: TStringField
      FieldName = 'DZIP_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesDREV_VER: TStringField
      FieldName = 'DREV_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesDFON_VER: TStringField
      FieldName = 'DFON_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesDGER_VER: TStringField
      FieldName = 'DGER_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesDCFG_VER: TStringField
      FieldName = 'DCFG_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesSITU_VER: TStringField
      FieldName = 'SITU_VER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsVersoesVERS_VER: TStringField
      FieldName = 'VERS_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 15
    end
    object cdsVersoesCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsVersoesCOMP_VER: TStringField
      FieldName = 'COMP_VER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsVersoesGVPD_VER: TStringField
      FieldName = 'GVPD_VER'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 3
    end
    object cdsVersoessqqLibraryPath: TDataSetField
      FieldName = 'sqqLibraryPath'
    end
    object cdsVersoesDTMP_VER: TStringField
      FieldName = 'DTMP_VER'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsVersoesDELP_VER: TStringField
      FieldName = 'DELP_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
      OnGetText = cdsVersoesDELP_VERGetText
      FixedChar = True
      Size = 3
    end
  end
  object dtsLinkVersoes: TDataSource
    DataSet = sqqVersoes
    Left = 160
    Top = 168
  end
  object sqqLibraryPath: TSQLQuery
    DataSource = dtsLinkVersoes
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_VER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select LIB.CODI_LIB, '
      '       LIB.CODI_VER, '
      '       LIB.CODI_USU, '
      '       LIB.INDI_LIB, '
      '       LIB.DESC_LIB '
      'from LIBRARY LIB '
      'where (LIB.CODI_VER = :CODI_VER) and'
      '      (LIB.CODI_USU = :CODI_USU) '
      'order by LIB.INDI_LIB ')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 240
    Top = 216
    object sqqLibraryPathCODI_LIB: TIntegerField
      FieldName = 'CODI_LIB'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqqLibraryPathCODI_VER: TIntegerField
      FieldName = 'CODI_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqLibraryPathCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqLibraryPathINDI_LIB: TIntegerField
      FieldName = 'INDI_LIB'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object sqqLibraryPathDESC_LIB: TStringField
      FieldName = 'DESC_LIB'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
  end
  object cdsLibraryPath: TClientDataSet
    Aggregates = <>
    DataSetField = cdsVersoessqqLibraryPath
    Params = <>
    BeforePost = cdsLibraryPathBeforePost
    OnNewRecord = cdsLibraryPathNewRecord
    Left = 240
    Top = 264
    object cdsLibraryPathCODI_LIB: TIntegerField
      FieldName = 'CODI_LIB'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsLibraryPathCODI_VER: TIntegerField
      FieldName = 'CODI_VER'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsLibraryPathCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsLibraryPathINDI_LIB: TIntegerField
      DisplayLabel = #205'ndice'
      DisplayWidth = 50
      FieldName = 'INDI_LIB'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsLibraryPathDESC_LIB: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 600
      FieldName = 'DESC_LIB'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 100
    end
  end
end
