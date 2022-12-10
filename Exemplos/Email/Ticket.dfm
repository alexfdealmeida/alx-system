inherited FTicket: TFTicket
  Caption = 'Cadastro de Ticket'
  ClientHeight = 490
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 471
    ExplicitTop = 471
  end
  inherited pnlGeral: TPanel
    Height = 438
    ExplicitHeight = 438
    inherited pnlManutencao: TPanel
      Height = 397
      ExplicitHeight = 397
      object Label3: TLabel
        Left = 11
        Top = 16
        Width = 48
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object memDESC_TIC: TDBMemo
        Left = 76
        Top = 13
        Width = 555
        Height = 124
        DataField = 'DESC_TIC'
        DataSource = dtsTabelaPrincipal
        TabOrder = 0
      end
      object DBGrid1: TDBGrid
        Left = 77
        Top = 143
        Width = 554
        Height = 242
        DataSource = dtsValidacao
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Color = clMoneyGreen
            Expanded = False
            FieldName = 'CODI_VAL'
            Title.Caption = 'Seq.'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REVISION'
            Title.Caption = 'Revision'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_DES'
            Title.Caption = 'Desenvolvedor'
            Width = 295
            Visible = True
          end>
      end
      object btnIncluiVal: TBitBtn
        Tag = 1
        Left = 7
        Top = 144
        Width = 67
        Height = 23
        Caption = '&1-Incluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnIncluiValClick
        NumGlyphs = 3
      end
      object btnAlteraVal: TBitBtn
        Tag = 1
        Left = 7
        Top = 171
        Width = 67
        Height = 23
        Caption = '&2-Alterar'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnAlteraValClick
        NumGlyphs = 3
      end
      object btnExcluiVal: TBitBtn
        Tag = 1
        Left = 7
        Top = 198
        Width = 67
        Height = 23
        Caption = '&3-Excluir'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = btnExcluiValClick
        NumGlyphs = 3
      end
    end
  end
  inherited pnlOpcoes: TPanel
    Top = 438
    ExplicitTop = 438
  end
  object dtsValidacao: TDataSource
    Left = 472
    Top = 8
  end
end
