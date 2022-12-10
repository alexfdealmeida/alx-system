inherited frmManutUsuarios: TfrmManutUsuarios
  Caption = 'Manuten'#231#227'o de Usu'#225'rios'
  ClientHeight = 562
  ExplicitWidth = 320
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 543
    ExplicitTop = 543
  end
  inherited DbGridMasterMnt: TDBAdvGrid
    Height = 497
    ExplicitHeight = 497
  end
  inherited pnlRodape: TAdvSmoothPanel
    Top = 520
    ExplicitTop = 520
  end
  object dtsUsuarios: TDataSource
    DataSet = dmUsuarios.cdsUsuarios
    Left = 72
    Top = 136
  end
end
