object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 159
  Width = 269
  object sqcCompilador: TSQLConnection
    ConnectionName = 'DbCompilador'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxint30.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=D:\ALXSystem\db\COMPILADOR.FDB'
      'RoleName=RoleName'
      'User_Name=AFA'
      'Password=rootkey'
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
  object cdsGeral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspGeral'
    Left = 208
    Top = 104
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
  object sqqExecute: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = sqcCompilador
    Left = 120
    Top = 8
  end
end
