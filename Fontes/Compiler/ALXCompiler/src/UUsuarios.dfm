inherited frmUsuarios: TfrmUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 230
  ClientWidth = 441
  ExplicitWidth = 447
  ExplicitHeight = 254
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 211
    Width = 441
    ExplicitTop = 211
    ExplicitWidth = 441
  end
  inherited pnlBotoes: TAdvSmoothPanel
    Top = 176
    Width = 441
    ExplicitTop = 176
    ExplicitWidth = 441
    DesignSize = (
      441
      35)
    inherited btnGravar: TBitBtn
      Left = 287
      ExplicitLeft = 287
    end
    inherited btnCancelar: TBitBtn
      Left = 363
      ExplicitLeft = 363
    end
  end
  inherited pnlManutencao: TAdvSmoothPanel
    Width = 441
    Height = 176
    ExplicitWidth = 441
    ExplicitHeight = 176
    object gbxNOME_USU: TAdvGroupBox
      Left = 8
      Top = 8
      Width = 423
      Height = 49
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = True
      ParentFont = False
      TabOrder = 0
      object edtNOME_USU: TDBEdit
        Left = 6
        Top = 19
        Width = 409
        Height = 21
        CharCase = ecUpperCase
        DataField = 'NOME_USU'
        DataSource = dtsUsuarios
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object gbxLogin: TAdvGroupBox
      Left = 8
      Top = 63
      Width = 423
      Height = 82
      Caption = 'Login'
      ParentCtl3D = True
      TabOrder = 1
      object lblLOGI_USU: TLabel
        Left = 6
        Top = 24
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object lblSENH_USU: TLabel
        Left = 12
        Top = 51
        Width = 30
        Height = 13
        Caption = 'Senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object edtLOGI_USU: TDBEdit
        Left = 44
        Top = 21
        Width = 371
        Height = 21
        CharCase = ecUpperCase
        DataField = 'LOGI_USU'
        DataSource = dtsUsuarios
        TabOrder = 0
      end
      object edtSENH_USU: TDBEdit
        Left = 44
        Top = 49
        Width = 184
        Height = 21
        DataField = 'SENH_USU'
        DataSource = dtsUsuarios
        PasswordChar = '*'
        TabOrder = 1
      end
      object edtConfirmaSenha: TEdit
        Left = 231
        Top = 49
        Width = 184
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
      end
    end
    object chkInativo: TDBAdvOfficeCheckBox
      Left = 8
      Top = 150
      Width = 185
      Height = 17
      ShowHint = True
      TabOrder = 2
      Alignment = taLeftJustify
      Caption = 'Administrador do Sistema'
      ReturnIsTab = False
      Version = '1.0.0.3'
      DataField = 'ADMI_USU'
      DataSource = dtsUsuarios
      ReadOnly = True
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object dtsUsuarios: TDataSource
    DataSet = dmUsuarios.cdsUsuarios
    Left = 200
    Top = 8
  end
end
