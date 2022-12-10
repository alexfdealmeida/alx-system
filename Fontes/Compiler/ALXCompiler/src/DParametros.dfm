object dmParametros: TdmParametros
  OldCreateOrder = False
  Height = 170
  Width = 215
  object sqqParametros: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select CFG.IAUT_CFG,'
      '          CFG.UVER_CFG,'
      '          CFG.EMAC_CFG,          '
      '          CFG.SERV_CFG,'
      '          CFG.AGMS_CFG,          '
      '          CFG.CODI_USU,'
      '          CFG.CORM_CFG,'
      '          CFG.CORF_CFG,'
      '          CFG.UPDC_CFG ,'
      '          CFG.EXEC_CFG,'
      '          CFG.ALER_CFG,'
      '          CFG.APAG_CFG,'
      '          CFG.TSVN_CFG,'
      '          CFG.MULT_CFG,'
      '          CFG.IDEX_CFG,'
      '          CFG.TGIT_CFG,'
      '          CFG.SGIT_CFG,'
      '          CFG.UPDG_CFG,'
      '          CFG.SWIT_CFG,'
      '          CFG.LIBR_CFG,'
      '          CFG.GLNK_CFG,'
      '          CFG.LINK_CFG,'
      
        '          coalesce(CFG.DRLC_CFG, cast('#39'30/12/1899'#39' as date)) as ' +
        'DRLC_CFG,'
      
        '          coalesce(CFG.DBLC_CFG, cast('#39'30/12/1899'#39' as date)) as ' +
        'DBLC_CFG,'
      '          coalesce(CFG.EXLC_CFG, 0) as EXLC_CFG,'
      '          CFG.SZIP_CFG,'
      '          CFG.ALLC_CFG,'
      '          CFG.IPRD_CFG,'
      '          CFG.TPAR_CFG,'
      '          CFG.HFTP_CFG,'
      '          CFG.UFTP_CFG,'
      '          CFG.SFTP_CFG,'
      '          CFG.EFTP_CFG,'
      '          CFG.CPYL_CFG,'
      '          CFG.CPYR_CFG,'
      '          CFG.IVER_CFG,'
      '          CFG.IPAR_CFG,'
      '          CFG.AFTP_CFG,'
      '          CFG.REQU_CFG '
      'from CONFIG CFG'
      'where (CFG.CODI_USU = :CODI_USU)')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 88
    Top = 8
    object sqqParametrosCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqqParametrosIAUT_CFG: TStringField
      FieldName = 'IAUT_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosUVER_CFG: TStringField
      FieldName = 'UVER_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object sqqParametrosEMAC_CFG: TStringField
      FieldName = 'EMAC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosSERV_CFG: TStringField
      FieldName = 'SERV_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosAGMS_CFG: TStringField
      FieldName = 'AGMS_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object sqqParametrosCORM_CFG: TIntegerField
      FieldName = 'CORM_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object sqqParametrosCORF_CFG: TIntegerField
      FieldName = 'CORF_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object sqqParametrosUPDC_CFG: TStringField
      FieldName = 'UPDC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosEXEC_CFG: TStringField
      FieldName = 'EXEC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosALER_CFG: TStringField
      FieldName = 'ALER_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosAPAG_CFG: TStringField
      FieldName = 'APAG_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosTSVN_CFG: TStringField
      FieldName = 'TSVN_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosMULT_CFG: TStringField
      FieldName = 'MULT_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosIDEX_CFG: TStringField
      FieldName = 'IDEX_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosTGIT_CFG: TStringField
      FieldName = 'TGIT_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosSGIT_CFG: TStringField
      FieldName = 'SGIT_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosUPDG_CFG: TStringField
      FieldName = 'UPDG_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosSWIT_CFG: TStringField
      FieldName = 'SWIT_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosLIBR_CFG: TStringField
      FieldName = 'LIBR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosGLNK_CFG: TStringField
      FieldName = 'GLNK_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosLINK_CFG: TStringField
      FieldName = 'LINK_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosDRLC_CFG: TDateField
      FieldName = 'DRLC_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object sqqParametrosDBLC_CFG: TDateField
      FieldName = 'DBLC_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object sqqParametrosEXLC_CFG: TIntegerField
      FieldName = 'EXLC_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object sqqParametrosSZIP_CFG: TStringField
      FieldName = 'SZIP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosALLC_CFG: TStringField
      FieldName = 'ALLC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosIPRD_CFG: TStringField
      FieldName = 'IPRD_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object sqqParametrosTPAR_CFG: TStringField
      FieldName = 'TPAR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosHFTP_CFG: TStringField
      FieldName = 'HFTP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object sqqParametrosUFTP_CFG: TStringField
      FieldName = 'UFTP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object sqqParametrosSFTP_CFG: TStringField
      FieldName = 'SFTP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object sqqParametrosEFTP_CFG: TStringField
      FieldName = 'EFTP_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosCPYL_CFG: TStringField
      FieldName = 'CPYL_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosCPYR_CFG: TStringField
      FieldName = 'CPYR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosIVER_CFG: TStringField
      FieldName = 'IVER_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosIPAR_CFG: TStringField
      FieldName = 'IPAR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosAFTP_CFG: TStringField
      FieldName = 'AFTP_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object sqqParametrosREQU_CFG: TStringField
      FieldName = 'REQU_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
  object dspParametros: TDataSetProvider
    DataSet = sqqParametros
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 56
  end
  object cdsParametros: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_USU'
        ParamType = ptInput
      end>
    ProviderName = 'dspParametros'
    AfterInsert = cdsParametrosAfterInsert
    Left = 88
    Top = 104
    object cdsParametrosIAUT_CFG: TStringField
      FieldName = 'IAUT_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosUVER_CFG: TStringField
      FieldName = 'UVER_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object cdsParametrosEMAC_CFG: TStringField
      FieldName = 'EMAC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosSERV_CFG: TStringField
      FieldName = 'SERV_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosAGMS_CFG: TStringField
      FieldName = 'AGMS_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 2
    end
    object cdsParametrosCODI_USU: TIntegerField
      FieldName = 'CODI_USU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsParametrosCORM_CFG: TIntegerField
      FieldName = 'CORM_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsParametrosCORF_CFG: TIntegerField
      FieldName = 'CORF_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsParametrosUPDC_CFG: TStringField
      FieldName = 'UPDC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosEXEC_CFG: TStringField
      FieldName = 'EXEC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosALER_CFG: TStringField
      FieldName = 'ALER_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosAPAG_CFG: TStringField
      FieldName = 'APAG_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosTSVN_CFG: TStringField
      FieldName = 'TSVN_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosMULT_CFG: TStringField
      FieldName = 'MULT_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosIDEX_CFG: TStringField
      FieldName = 'IDEX_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosTGIT_CFG: TStringField
      FieldName = 'TGIT_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosSGIT_CFG: TStringField
      FieldName = 'SGIT_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosUPDG_CFG: TStringField
      FieldName = 'UPDG_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosSWIT_CFG: TStringField
      FieldName = 'SWIT_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosLIBR_CFG: TStringField
      FieldName = 'LIBR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosGLNK_CFG: TStringField
      FieldName = 'GLNK_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosLINK_CFG: TStringField
      FieldName = 'LINK_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosDRLC_CFG: TDateField
      FieldName = 'DRLC_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsParametrosDBLC_CFG: TDateField
      FieldName = 'DBLC_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsParametrosEXLC_CFG: TIntegerField
      FieldName = 'EXLC_CFG'
      ProviderFlags = [pfInUpdate]
    end
    object cdsParametrosSZIP_CFG: TStringField
      FieldName = 'SZIP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosALLC_CFG: TStringField
      FieldName = 'ALLC_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosIPRD_CFG: TStringField
      FieldName = 'IPRD_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object cdsParametrosTPAR_CFG: TStringField
      FieldName = 'TPAR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosHFTP_CFG: TStringField
      FieldName = 'HFTP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsParametrosUFTP_CFG: TStringField
      FieldName = 'UFTP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsParametrosSFTP_CFG: TStringField
      FieldName = 'SFTP_CFG'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsParametrosEFTP_CFG: TStringField
      FieldName = 'EFTP_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosCPYL_CFG: TStringField
      FieldName = 'CPYL_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosCPYR_CFG: TStringField
      FieldName = 'CPYR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosIVER_CFG: TStringField
      FieldName = 'IVER_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosIPAR_CFG: TStringField
      FieldName = 'IPAR_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosAFTP_CFG: TStringField
      FieldName = 'AFTP_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
    object cdsParametrosREQU_CFG: TStringField
      FieldName = 'REQU_CFG'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 1
    end
  end
end
