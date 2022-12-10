object dmPrincipal: TdmPrincipal
  OldCreateOrder = True
  Height = 277
  Width = 357
  object sqcPrincipal: TSQLConnection
    ConnectionName = 'ANALISEMAS'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=D:\Analise\Sistema\ANALISE.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 43
    Top = 8
  end
  object cdsGeral: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_PES'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SIST_OPC'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CODI_OPC'
        ParamType = ptInput
      end>
    ProviderName = 'dspGeral'
    Left = 174
    Top = 83
  end
  object dspGeral: TDataSetProvider
    DataSet = sqqGeral
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 101
    Top = 83
  end
  object sqqGeral: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      '')
    SQLConnection = sqcPrincipal
    Left = 35
    Top = 83
  end
  object sqqEmailValidacao: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select *'
      'from EMAILSVALIDACAO')
    SQLConnection = sqcPrincipal
    Left = 35
    Top = 163
    object sqqEmailValidacaoEMA1_EVA: TStringField
      FieldName = 'EMA1_EVA'
      Size = 60
    end
    object sqqEmailValidacaoEMA2_EVA: TStringField
      FieldName = 'EMA2_EVA'
      Size = 60
    end
    object sqqEmailValidacaoEMA3_EVA: TStringField
      FieldName = 'EMA3_EVA'
      Size = 60
    end
    object sqqEmailValidacaoEMA4_EVA: TStringField
      FieldName = 'EMA4_EVA'
      Size = 60
    end
    object sqqEmailValidacaoSENH_EVA: TStringField
      FieldName = 'SENH_EVA'
      Size = 25
    end
    object sqqEmailValidacaoUSUA_EVA: TStringField
      FieldName = 'USUA_EVA'
      Size = 60
    end
    object sqqEmailValidacaoHOST_EVA: TStringField
      FieldName = 'HOST_EVA'
      Size = 60
    end
  end
end
