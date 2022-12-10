object dmInfoDB: TdmInfoDB
  OldCreateOrder = False
  Height = 161
  Width = 215
  object sqqInfoDB: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select INF.VERS_INF,'
      '           INF.EMPR_INF '
      'from INFODB INF')
    SQLConnection = dmPrincipal.sqcCompilador
    Left = 88
    Top = 8
  end
  object dspInfoDB: TDataSetProvider
    DataSet = sqqInfoDB
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 88
    Top = 56
  end
  object cdsInfoDB: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInfoDB'
    Left = 88
    Top = 104
    object cdsInfoDBVERS_INF: TStringField
      FieldName = 'VERS_INF'
      Size = 4
    end
    object cdsInfoDBEMPR_INF: TStringField
      FieldName = 'EMPR_INF'
      Size = 100
    end
  end
end
