object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 158
  Width = 257
  object sqcCompilador: TSQLConnection
    ConnectionName = 'DbCompilador'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      
        'Database=E:\Meus Arquivos\1stONE\Utilit'#225'rios\Projeto Turbo\Compi' +
        'lador Turbo\db\COMPILADOR.FDB'
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
    Left = 32
    Top = 8
  end
  object sqqAdap: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqcCompilador
    Left = 120
    Top = 8
  end
  object sqqGeral: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqcCompilador
    Left = 208
    Top = 8
  end
  object dspGeral: TDataSetProvider
    DataSet = sqqGeral
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 208
    Top = 56
  end
  object cdsGeral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGeral'
    Left = 208
    Top = 104
  end
end
