inherited frmManutBases: TfrmManutBases
  Caption = 'Manuten'#231#227'o das bases de dados'
  ClientHeight = 562
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 543
    ExplicitTop = 543
  end
  inherited DbGridMasterMnt: TDBAdvGrid
    Top = 47
    Height = 473
    ExplicitTop = 47
    ExplicitHeight = 473
  end
  inherited pnlRodape: TAdvSmoothPanel
    Top = 520
    ExplicitTop = 520
  end
  object pnlBotoes: TAdvSmoothPanel [4]
    Left = 0
    Top = 23
    Width = 784
    Height = 24
    Cursor = crDefault
    Caption.HTMLFont.Charset = DEFAULT_CHARSET
    Caption.HTMLFont.Color = clWindowText
    Caption.HTMLFont.Height = -11
    Caption.HTMLFont.Name = 'Tahoma'
    Caption.HTMLFont.Style = []
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -16
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.ColorStart = 5978398
    Caption.ColorEnd = 5978398
    Caption.LineColor = 5978398
    Fill.Color = 16643823
    Fill.ColorTo = 15784647
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 13087391
    Fill.Rounding = 0
    Fill.RoundingType = rtNone
    Fill.ShadowOffset = 0
    Fill.Glow = gmRadial
    Version = '1.0.9.2'
    Align = alTop
    TabOrder = 0
    object btnSelecionar: TAdvGlowButton
      Left = 394
      Top = 0
      Width = 120
      Height = 24
      Hint = 'Seleciona base de dados a ser utilizada'
      Align = alRight
      Caption = '&Selecionar'
      ImageIndex = 6
      Images = ImageListMaster
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Spacing = 4
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSelecionarClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
    object btnAlterarDados: TAdvGlowButton
      Left = 514
      Top = 0
      Width = 270
      Height = 24
      Align = alRight
      Caption = '&Manuten'#231#227'o nas tabelas da base de dados'
      ImageIndex = 9
      Images = ImageListMaster
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Spacing = 4
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnAlterarDadosClick
      Appearance.ColorChecked = 16111818
      Appearance.ColorCheckedTo = 16367008
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 16111818
      Appearance.ColorDownTo = 16367008
      Appearance.ColorHot = 16117985
      Appearance.ColorHotTo = 16372402
      Appearance.ColorMirrorHot = 16107693
      Appearance.ColorMirrorHotTo = 16775412
      Appearance.ColorMirrorDown = 16102556
      Appearance.ColorMirrorDownTo = 16768988
      Appearance.ColorMirrorChecked = 16102556
      Appearance.ColorMirrorCheckedTo = 16768988
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
    end
  end
  inherited actLstAtualizaMasterMnt: TActionList
    Left = 152
  end
  object dtsBases: TDataSource
    DataSet = dmBases.cdsBases
    Left = 16
    Top = 64
  end
end
