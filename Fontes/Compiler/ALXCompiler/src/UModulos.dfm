inherited frmModulos: TfrmModulos
  ActiveControl = edtDESC_MOD
  Caption = 'Cadastro de M'#243'dulos'
  ClientHeight = 162
  ClientWidth = 520
  ExplicitWidth = 526
  ExplicitHeight = 186
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 143
    Width = 520
    ExplicitTop = 143
    ExplicitWidth = 520
  end
  inherited pnlBotoes: TAdvSmoothPanel
    Top = 108
    Width = 520
    ExplicitTop = 108
    ExplicitWidth = 520
    DesignSize = (
      520
      35)
    inherited btnGravar: TBitBtn
      Left = 366
      ExplicitLeft = 366
    end
    inherited btnCancelar: TBitBtn
      Left = 442
      ExplicitLeft = 442
    end
  end
  inherited pnlManutencao: TAdvSmoothPanel
    Width = 520
    Height = 108
    ExplicitWidth = 520
    ExplicitHeight = 108
    object lblDESC_MOD: TLabel
      Left = 42
      Top = 12
      Width = 98
      Height = 13
      Caption = 'Descri'#231#227'o do M'#243'dulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblWANT_MOD: TLabel
      Left = 118
      Top = 37
      Width = 22
      Height = 13
      Caption = 'Alias'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtDESC_MOD: TDBEdit
      Left = 143
      Top = 7
      Width = 343
      Height = 21
      Hint = 'Informe a descri'#231#227'o do m'#243'dulo. Ex.: Adaptador'
      DataField = 'DESC_MOD'
      DataSource = dtsModulos
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnExit = edtDESC_MODExit
    end
    object edtWANT_MOD: TDBEdit
      Left = 143
      Top = 34
      Width = 100
      Height = 21
      Hint = 'Informe a descri'#231#227'o para o compilador. Ex.: adap'
      CharCase = ecLowerCase
      DataField = 'WANT_MOD'
      DataSource = dtsModulos
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnExit = edtWANT_MODExit
    end
    object chkLAST_MOD: TDBAdvOfficeCheckBox
      Left = 143
      Top = 59
      Width = 130
      Height = 17
      Hint = 
        'Marque esta op'#231#227'o caso deseje que este m'#243'dulo seja o '#250'ltimo a se' +
        'r compilado'
      ShowHint = True
      TabOrder = 2
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Compilar por '#250'ltimo'
      ReturnIsTab = False
      Version = '1.0.0.3'
      DataField = 'LAST_MOD'
      DataSource = dtsModulos
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkAUTO_MOD: TDBAdvOfficeCheckBox
      Left = 143
      Top = 80
      Width = 170
      Height = 17
      Hint = 
        'Marque esta op'#231#227'o caso deseje que este m'#243'dulo seja carregado aut' +
        'omaticamente'
      ShowHint = True
      TabOrder = 3
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Carregar automaticamente'
      ReturnIsTab = False
      Version = '1.0.0.3'
      DataField = 'AUTO_MOD'
      DataSource = dtsModulos
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited stbStylerMaster: TAdvOfficeStatusBarOfficeStyler
    Left = 336
  end
  inherited ImageListMaster: TImageList
    Left = 264
    Top = 48
  end
  object dtsModulos: TDataSource
    DataSet = dmModulos.cdsModulos
    Left = 312
    Top = 24
  end
end
