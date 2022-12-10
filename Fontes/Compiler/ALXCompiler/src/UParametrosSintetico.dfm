inherited frmParametrosSintetico: TfrmParametrosSintetico
  Caption = 'Configura'#231#227'o de Par'#226'metros (Sint'#233'tico)'
  ClientHeight = 313
  ClientWidth = 623
  ExplicitWidth = 629
  ExplicitHeight = 337
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvEnterAsTab1: TJvEnterAsTab
    ExplicitWidth = 28
    ExplicitHeight = 28
  end
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 294
    Width = 623
    ExplicitTop = 294
    ExplicitWidth = 623
  end
  inherited pnlBotoes: TAdvSmoothPanel
    Top = 259
    Width = 623
    ExplicitTop = 259
    ExplicitWidth = 623
    inherited btnGravar: TBitBtn
      Left = 469
      Caption = '&Confirmar'
      ExplicitLeft = 469
    end
    inherited btnCancelar: TBitBtn
      Left = 545
      Caption = 'Ca&ncelar'
      ExplicitLeft = 545
    end
  end
  inherited pnlManutencao: TAdvSmoothPanel
    Width = 623
    Height = 259
    ExplicitWidth = 623
    ExplicitHeight = 259
    object AdvGroupBox2: TAdvGroupBox
      Left = 15
      Top = 14
      Width = 338
      Height = 90
      Caption = 'Antes de compilar'
      ParentCtl3D = True
      TabOrder = 0
      object DBAdvOfficeCheckBox6: TDBAdvOfficeCheckBox
        Left = 15
        Top = 15
        Width = 241
        Height = 20
        Hint = 
          'Marque esta op'#231#227'o caso deseje informar a data/hora dos arquivos ' +
          'que ser'#227'o compilados'
        ShowHint = True
        TabOrder = 0
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Alterar a data e a hora dos execut'#225'veis'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'IDEX_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBAdvOfficeCheckBox7: TDBAdvOfficeCheckBox
        Left = 15
        Top = 69
        Width = 193
        Height = 20
        ShowHint = True
        TabOrder = 3
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Atualizar o library path do Delphi'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'LIBR_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkIVER_CFG: TDBAdvOfficeCheckBox
        Left = 15
        Top = 33
        Width = 241
        Height = 20
        ShowHint = True
        TabOrder = 1
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Alterar a vers'#227'o e os diret'#243'rios de compila'#231#227'o'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'IVER_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkIPAR_CFG: TDBAdvOfficeCheckBox
        Left = 15
        Top = 51
        Width = 211
        Height = 20
        ShowHint = True
        TabOrder = 2
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Alterar os par'#226'metros de compila'#231#227'o'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'IPAR_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object AdvGroupBox3: TAdvGroupBox
      Left = 15
      Top = 108
      Width = 338
      Height = 133
      Caption = 'Ap'#243's compilar'
      ParentCtl3D = True
      TabOrder = 1
      object chkExecutar: TDBAdvOfficeCheckBox
        Left = 15
        Top = 51
        Width = 193
        Height = 20
        Hint = 
          'Marque esta op'#231#227'o caso deseje que o sistema execute os m'#243'dulos a' +
          'p'#243's compilar'
        ShowHint = True
        TabOrder = 2
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'E&xecutar os m'#243'dulos do diret'#243'rio local'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'EMAC_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkGLNK_CFG: TDBAdvOfficeCheckBox
        Left = 15
        Top = 69
        Width = 314
        Height = 20
        ShowHint = True
        TabOrder = 3
        TabStop = True
        Alignment = taLeftJustify
        Caption = '&Gerar os links para download'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'GLNK_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkEFTP_CFG: TDBAdvOfficeCheckBox
        Left = 15
        Top = 86
        Width = 314
        Height = 20
        ShowHint = True
        TabOrder = 4
        TabStop = True
        Alignment = taLeftJustify
        Caption = '&Enviar os arquivos compactados individualmente para o FTP'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'EFTP_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBAdvOfficeCheckBox9: TDBAdvOfficeCheckBox
        Left = 15
        Top = 15
        Width = 314
        Height = 20
        ShowHint = True
        TabOrder = 0
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Copiar os arquivos compilados para o diret'#243'rio local'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'CPYL_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBAdvOfficeCheckBox10: TDBAdvOfficeCheckBox
        Left = 15
        Top = 33
        Width = 305
        Height = 20
        ShowHint = True
        TabOrder = 1
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Copiar os arquivos compactados para o diret'#243'rio remoto'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'CPYR_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkAFTP_CFG: TDBAdvOfficeCheckBox
        Left = 15
        Top = 106
        Width = 320
        Height = 20
        ShowHint = True
        TabOrder = 5
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Enviar o arquivo '#250'nico compactado para o FTP'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'AFTP_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object AdvGroupBox4: TAdvGroupBox
      Left = 364
      Top = 14
      Width = 235
      Height = 60
      Caption = 'Compactar os arquivos compilados'
      ParentCtl3D = True
      TabOrder = 2
      object DBAdvOfficeCheckBox2: TDBAdvOfficeCheckBox
        Left = 15
        Top = 15
        Width = 114
        Height = 20
        Hint = 
          'Marque esta op'#231#227'o caso deseje que o sistema gere os execut'#225'veis ' +
          'compactados com seus respectivos .map'
        ShowHint = True
        TabOrder = 0
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Separadamente'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'EXEC_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBAdvOfficeCheckBox8: TDBAdvOfficeCheckBox
        Left = 15
        Top = 33
        Width = 146
        Height = 20
        ShowHint = True
        TabOrder = 1
        TabStop = True
        Alignment = taLeftJustify
        Caption = 'Em um '#250'nico arquivo'
        ReturnIsTab = False
        Version = '1.0.0.5'
        DataField = 'ALLC_CFG'
        DataSource = dtsParametros
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object DBAdvOfficeCheckBox3: TDBAdvOfficeCheckBox
      Left = 364
      Top = 87
      Width = 229
      Height = 20
      Hint = 
        'Marque esta op'#231#227'o caso deseje que o sistema emita um alerta quan' +
        'do houver algum erro na compila'#231#227'o de algum m'#243'dulo'
      ShowHint = True
      TabOrder = 3
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Alertar sobre &erros durante compila'#231#227'o'
      ReturnIsTab = False
      Version = '1.0.0.5'
      DataField = 'ALER_CFG'
      DataSource = dtsParametros
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBAdvOfficeCheckBox1: TDBAdvOfficeCheckBox
      Left = 364
      Top = 105
      Width = 179
      Height = 20
      Hint = 
        'Marque esta op'#231#227'o caso deseje que a compila'#231#227'o seja realizada no' +
        ' servidor remoto'
      ShowHint = True
      TabOrder = 4
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Compilar no servidor remoto'
      ReturnIsTab = False
      Version = '1.0.0.5'
      DataField = 'REQU_CFG'
      DataSource = dtsParametros
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited ImageListMaster: TImageList
    Left = 256
    Top = 88
  end
  object dtsParametros: TDataSource
    DataSet = dmParametros.cdsParametros
    Left = 320
    Top = 24
  end
end
