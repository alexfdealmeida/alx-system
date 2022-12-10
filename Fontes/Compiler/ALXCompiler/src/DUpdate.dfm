object dmUpdate: TdmUpdate
  OldCreateOrder = False
  Height = 150
  Width = 109
  object cdsArquivos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 80
    object cdsArquivosVERS_RES: TStringField
      FieldName = 'VERS_RES'
      Size = 15
    end
    object cdsArquivosSTAT_RES: TStringField
      FieldName = 'STAT_RES'
      Size = 1
    end
    object cdsArquivosARQU_RES: TStringField
      FieldName = 'ARQU_RES'
      Size = 100
    end
  end
  object cdsVersoesUpd: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 24
    object cdsVersoesUpdVERS_RES: TStringField
      FieldName = 'VERS_RES'
      Size = 15
    end
  end
end
