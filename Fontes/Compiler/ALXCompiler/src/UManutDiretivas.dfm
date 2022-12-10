inherited frmManutDiretivas: TfrmManutDiretivas
  Caption = 'Manuten'#231#227'o nas Diretivas de Compila'#231#227'o'
  ClientHeight = 562
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
  object dtsDiretivas: TDataSource
    DataSet = dmDiretivas.cdsDiretivas
    Left = 160
    Top = 144
  end
end
