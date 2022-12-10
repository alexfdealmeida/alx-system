object dmManutDados: TdmManutDados
  OldCreateOrder = False
  Height = 156
  Width = 253
  object sqcEmpresa: TSQLConnection
    ConnectionName = 'DbSiagri'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      
        'Database=D:\1stONE\Utilit'#225'rios\Projeto Turbo\Compilador Turbo\db' +
        '\COMPILADOR.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet=win1252'
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 40
    Top = 8
  end
  object sqqConfig: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select CFG.*'
      'from CONFIG CFG')
    SQLConnection = sqcEmpresa
    Left = 112
    Top = 8
  end
  object dspConfig: TDataSetProvider
    DataSet = sqqConfig
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 112
    Top = 56
  end
  object cdsConfig: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConfig'
    Left = 112
    Top = 104
  end
  object sqqDadosReg: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select DRG.*'
      'from DADOSREG DRG')
    SQLConnection = sqcEmpresa
    Left = 184
    Top = 8
  end
  object dspDadosReg: TDataSetProvider
    DataSet = sqqDadosReg
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 184
    Top = 56
  end
  object cdsDadosReg: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDadosReg'
    Left = 184
    Top = 104
  end
end
