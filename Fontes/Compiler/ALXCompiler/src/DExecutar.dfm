object dmExecutar: TdmExecutar
  OldCreateOrder = False
  Height = 67
  Width = 119
  object cdsModulosExe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 8
    object cdsModulosExeDESC_MOD: TStringField
      FieldName = 'DESC_MOD'
      Size = 50
    end
    object cdsModulosExeALIAS: TStringField
      FieldName = 'ALIAS'
      Size = 15
    end
    object cdsModulosExeEXECUTAR: TBooleanField
      FieldName = 'EXECUTAR'
    end
  end
end
