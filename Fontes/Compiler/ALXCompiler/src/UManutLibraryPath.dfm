inherited frmManutLibraryPath: TfrmManutLibraryPath
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o no Library path do Delphi'
  ClientHeight = 572
  ClientWidth = 794
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited stbMaster: TAdvOfficeStatusBar
    Top = 553
    Width = 794
    ExplicitTop = 553
    ExplicitWidth = 794
  end
  inherited DbGridMasterMnt: TDBAdvGrid
    Top = 46
    Width = 794
    Height = 484
    ExplicitTop = 46
    ExplicitWidth = 794
    ExplicitHeight = 484
  end
  inherited pnlRodape: TAdvSmoothPanel
    Top = 530
    Width = 794
    ExplicitTop = 530
    ExplicitWidth = 794
    inherited btnSairMasterMnt: TAdvGlowButton
      Left = 719
      ExplicitLeft = 719
    end
  end
  inherited pnlCabecalho: TAdvSmoothPanel
    Width = 794
    ExplicitWidth = 794
    inherited edtRegistroSelecionado: TDBEdit
      Width = 381
      ExplicitWidth = 381
    end
    inherited edtTotalRegistros: TJvEdit
      Left = 654
      ExplicitLeft = 654
    end
    inherited btnIncluirMasterMnt: TAdvGlowButton
      Left = 694
      ExplicitLeft = 694
    end
    inherited btnAlterarMasterMnt: TAdvGlowButton
      Left = 719
      ExplicitLeft = 719
    end
    inherited btnExcluirMasterMnt: TAdvGlowButton
      Left = 744
      ExplicitLeft = 744
    end
    inherited btnExcluirTodosMasterMnt: TAdvGlowButton
      Left = 769
      ExplicitLeft = 769
    end
  end
  object pnlOpcoes: TAdvSmoothPanel [4]
    Left = 0
    Top = 23
    Width = 794
    Height = 23
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
    TabOrder = 5
    object btnExportar: TAdvGlowButton
      Left = 584
      Top = 0
      Width = 210
      Height = 23
      Align = alRight
      Caption = '&Exportar para library path do Delphi'
      ImageIndex = 1
      Images = ImageListLibrary
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Spacing = 4
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnExportarClick
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
    object btnImportar: TAdvGlowButton
      Left = 374
      Top = 0
      Width = 210
      Height = 23
      Align = alRight
      Caption = '&Importar library path do Delphi'
      ImageIndex = 2
      Images = ImageListLibrary
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Spacing = 4
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnImportarClick
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
  object dtsLibraryPath: TDataSource
    DataSet = dmVersoes.cdsLibraryPath
    Left = 240
    Top = 168
  end
  object ImageListLibrary: TImageList
    Left = 456
    Top = 192
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000824B4B004E1E1F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000007078800070788000707880000019100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000824B4B00824B4B00A64B4B00A94D4D004E1E1F0000000000000000000000
      0000000000000000000000000000000000000000000000000000025604000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      8B000707880007078800BBB7B7008480AA000611B4000011D800000191000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00824B
      4B00B64F5000C24F5000C54D4E00B24D4E004E1E1F00824B4B00824B4B00824B
      4B00824B4B00824B4B00824B4B00000000000000000002560400025604000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000707880007078800A19A
      B200BAB7BC007378C000222CC0000004AF0000039E00000DC100000EC6000002
      8F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00D458
      5900CB555600C9545500C9525300B74F52004E1E1F00FE8B8C00FB9A9C00F8AA
      AB00F7B5B600F7B5B600824B4B00000000000000000002590500025905000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000007078800C7BCC600B7B7D500516F
      DD000D2FF6000014FA00000FE6000010CE00000AB600000399000009B100000C
      BD00000191000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00D75C
      5D00D05A5B00CF595A00CF575800BD5356004E1E1F0023B54A0013C1480016BD
      48000CBC4100F7B5B600824B4B00000000000000000004620800096F11000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001B1B8E002075DC00005C
      FF000047BB000036CE000022FF000017EE000011D300000BBF0000049E000004
      A300020BB50008098B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00DD63
      6400D75F6000D55E5F00D55C5D00C2575A004E1E1F002AB44D001CBF4C001EBC
      4C0013BC4500F7B5B600824B4B00000000000000000006680D0018932D000256
      0400000000000000000000000000000000000000000002560400000000000000
      0000000000000000000000000000000000000037B6000079E10000B1FF000074
      A6000074A600035A0500035A05000022FF000017EE000012D500000CBF000005
      A30000039C000107A50008098C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00E368
      6900DD656600DA636400DE666700C6595B004E1E1F0026B1490016BC48001BBB
      490010BB4300F7B5B600824B4B00000000000000000006680D002CB84F00096F
      1100000000000000000000000000000000000000000002560400025604000000
      000000000000000000000000000000000000000000000023BD00007588000074
      A600035A050019982B0013902100035A05000023FF000018F0000012D700000C
      C0000006A4000002960001039600070789000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00EB6D
      6E00E2676800E67E7F00FAD3D400CC6E70004E1E1F00A5D8970050D16F0042C9
      66002DC75800F7B5B600824B4B000000000000000000025905002BB44C0024AA
      4200025604000000000000000000000000000000000002560400078110000256
      04000000000000000000000000000000000000000000000000000023BD00035A
      050023A63E002DC04D0023B13C00128E1F00035A05000023FF000018EF000012
      D800000CC0000006A6000001920001018A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00F273
      7400E96C6D00EB818200FCD1D300CF6E70004E1E1F00FFF2CC00FFFFD700FFFF
      D400E6FCC700F7B5B600824B4B00000000000000000000000000168A280042E2
      76001C9C3300025604000256040002560400025604000256040009981300047D
      0B00025604000000000000000000000000000000000000000000035A050028AD
      46003AD1680033C959002ABC490021AF3700118B1C00035A05000023FF000018
      F0000013D900000DC5000007A900050588000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00F878
      7900F0757600EE727300F0737400D16566004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD700F7B5B600824B4B00000000000000000000000000025604002BB4
      4C003FE06F002BB44C0016982A0013982500169C28000E911C0009981300058F
      0E00047D0B0002560400000000000000000000000000035A050028AD46003DD5
      6C003DD56C0038D0650031C5550028B845001FAC340010891A00035A05000027
      FF000017EA000507910008098C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00FE7F
      8000F77A7B00F6797A00F7777900D76B6B004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD500F7B5B600824B4B00000000000000000000000000000000000256
      040024AA420036D362002ECC540024BD42001BAF320013A325000C981800058F
      0E0006920E00078110000256040000000000035A0500035A0500035A0500035A
      0500138121003DD56C0036CE6000035A0500035A0500035A0500035A0500035A
      050008098C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00FF83
      8400FC7F8000FB7E7F00FE7F8000DA6E6F004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD500F7B5B600824B4B00000000000000000000000000000000000000
      000002560400096F11001FA5390023B43F001BAF320018AA2D000C9818000998
      13000A7F14000256040000000000000000000000000000000000000000000000
      0000035E1C003DD56C003CD36A00035A0500002DC100003ED0000D13A6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00FF88
      8900FF828300FF818200FF828300E07374004E1E1F00FCEFC700FFFFD500FFFF
      D300FFFFD500F7B5B600824B4B00000000000000000000000000000000000000
      000000000000000000000259050002590500046208000256040018AA2D00096F
      1100025604000000000000000000000000000000000000000000000000000000
      0000035A050028AD46003DD56C00035A05000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000824B4B00824B
      4B00E2757600FE818200FF868700E57677004E1E1F00FAEBC500FCFBD100FCFB
      CF00FCFBD100F7B5B600824B4B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000002560400096F11000259
      0500000000000000000000000000000000000000000000000000000000000000
      000000000000035E10003DD56C003DD56C00035A050000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000824B4B009C565700CB6C6D00CF6E6E004E1E1F00824B4B00824B4B00824B
      4B00824B4B00824B4B00824B4B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000002560400025604000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000004670600035A05003DD56C00035A0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000824B4B00824B4B004E1E1F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000002560400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000036E070003650000015D00000056
      140000510A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FE7FFFFFFC3F0000F07FDFFFE01F0000
      C0019FFF800F0000C0019FFF00070000C0019FFF80030000C0018FBF00010000
      C0018F9F80000000C001878FC0000000C001C007C0000000C001C00380010000
      C001E00100070000C001F003F01F0000C001FC07F0FF0000C001FF8FF87F0000
      F001FF9FFC3F0000FC7FFFBFFF070000}
  end
end