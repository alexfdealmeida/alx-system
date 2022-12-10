inherited frmDiretivas: TfrmDiretivas
  ActiveControl = edtDIRE_DTV
  Caption = 'Cadastro de Diretivas de Compila'#231#227'o'
  ClientHeight = 181
  ClientWidth = 690
  ExplicitWidth = 696
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 162
    Width = 690
    ExplicitTop = 162
    ExplicitWidth = 690
  end
  inherited pnlBotoes: TAdvSmoothPanel
    Top = 127
    Width = 690
    ExplicitTop = 127
    ExplicitWidth = 690
    DesignSize = (
      690
      35)
    inherited btnGravar: TBitBtn
      Left = 536
      ExplicitLeft = 536
    end
    inherited btnCancelar: TBitBtn
      Left = 612
      ExplicitLeft = 612
    end
  end
  inherited pnlManutencao: TAdvSmoothPanel
    Width = 690
    Height = 127
    ExplicitWidth = 690
    ExplicitHeight = 127
    DesignSize = (
      690
      127)
    object lblDIRE_DTV: TLabel
      Left = 133
      Top = 12
      Width = 37
      Height = 13
      Caption = 'Diretiva'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDESC_DTV: TLabel
      Left = 124
      Top = 38
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtDIRE_DTV: TDBEdit
      Left = 171
      Top = 9
      Width = 183
      Height = 21
      Hint = 'Informe o nome da diretiva de compila'#231#227'o'
      CharCase = ecUpperCase
      DataField = 'DIRE_DTV'
      DataSource = dtsDiretivas
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnExit = edtDIRE_DTVExit
    end
    object edtDESC_DTV: TDBEdit
      Left = 171
      Top = 35
      Width = 390
      Height = 21
      Hint = 'Informe a descri'#231#227'o da diretiva de compila'#231#227'o'
      DataField = 'DESC_DTV'
      DataSource = dtsDiretivas
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnExit = edtDESC_DTVExit
    end
    object chkGLOB_DTV: TDBAdvOfficeCheckBox
      Left = 171
      Top = 64
      Width = 126
      Height = 17
      Hint = 
        'Marque esta op'#231#227'o caso esta seja uma diretiva global de compila'#231 +
        #227'o'
      ShowHint = True
      TabOrder = 2
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Diretiva global'
      ReturnIsTab = False
      Version = '1.0.0.3'
      DataField = 'GLOB_DTV'
      DataSource = dtsDiretivas
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkAUTO_DTV: TDBAdvOfficeCheckBox
      Left = 171
      Top = 84
      Width = 183
      Height = 16
      Hint = 
        'Marque esta op'#231#227'o caso deseje que o sistema carregue esta direti' +
        'va automaticamente'
      ShowHint = True
      TabOrder = 4
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Carregar automaticamente'
      ReturnIsTab = False
      Version = '1.0.0.3'
      DataField = 'AUTO_DTV'
      DataSource = dtsDiretivas
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkInativo: TDBAdvOfficeCheckBox
      Left = 630
      Top = 101
      Width = 55
      Height = 17
      Hint = 'Marque esta op'#231#227'o caso deseje que esta diretiva se torne inativa'
      Anchors = [akRight, akBottom]
      ShowHint = True
      TabOrder = 3
      TabStop = True
      Alignment = taLeftJustify
      Caption = 'Inativa'
      ReturnIsTab = False
      Version = '1.0.0.3'
      DataField = 'SITU_DTV'
      DataSource = dtsDiretivas
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited ImageListMaster: TImageList
    Left = 456
    Top = 8
  end
  object dtsDiretivas: TDataSource
    DataSet = dmDiretivas.cdsDiretivas
    Left = 400
    Top = 56
  end
end
