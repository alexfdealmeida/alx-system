inherited FMasterPes: TFMasterPes
  Left = 259
  Top = 230
  BorderIcons = [biSystemMenu]
  Caption = 'Formul'#225'rio Master de Pesquisa'
  ClientHeight = 411
  ClientWidth = 757
  OldCreateOrder = True
  Position = poOwnerFormCenter
  ExplicitWidth = 763
  ExplicitHeight = 441
  PixelsPerInch = 106
  TextHeight = 13
  inherited StatusBar1: TStatusBar
    Top = 392
    Width = 757
    Color = clBtnFace
    SizeGrip = True
    ExplicitTop = 392
    ExplicitWidth = 757
  end
  object pnlPesquisa: TPanel [1]
    Left = 0
    Top = 0
    Width = 757
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      757
      42)
    object lblCampo: TLabel
      Left = 227
      Top = 5
      Width = 96
      Height = 13
      Caption = 'Informe o Campo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 112
      Height = 13
      Caption = 'Procurar no campo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtString: TEdit
      Left = 226
      Top = 19
      Width = 271
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Visible = False
      OnKeyDown = edtStringKeyDown
    end
    object btnLocalizar: TBitBtn
      Left = 678
      Top = 15
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Localizar'
      TabOrder = 5
      OnClick = btnLocalizarClick
      Glyph.Data = {
        36090000424D3609000000000000360000002800000030000000100000000100
        18000000000000090000E54C0000E54C00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF0975A7075C840C6F9DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF76
        76766161616D6D6DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF035A9102416A045486FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0670A43F
        9AB86E533B15212618769FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF7373739898986C6C6C3B3B3B727272FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF02558E28
        82A55339240911140B5B88FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0670A431CDFF50A8BFFFDAA07C5F451B3B4CFF00FF0052
        86005286FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF737373B2B2B2A2
        A2A2CFCFCF727272515151FF00FF616161616161FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF02558E1CBFFF3692ADFFCF8962442D0D2433FF00FF0038
        6C00386CFF00FFFF00FFFF00FFFF00FFFF00FF0670A42FBFF028ACDF59D2FE78
        C9E7E3BB8FD7A8792832391D7BAB0052860052860A587EFF00FFFF00FFFF00FF
        FF00FF707070ADADADA1A1A1ACACACAFAFAFB9B9B9AAAAAA4B4B4B8282826161
        61616161626262FF00FFFF00FFFF00FFFF00FF02558E1BADEB1697D53FC5FE5D
        BAE0DAA976CB925E161D230E609600386C00386C033E64FF00FFFF00FFFF00FF
        0670A443D0FE6CDEFF5CB4DBAEDDF3F1FFFFDEDBD59B88732C5F765FBDE665BF
        E083756117161504557FFF00FFFF00FF737373B0B0B0BEBEBEADADADD0D0D0F8
        F8F8D9D9D99393936F6F6FC0C0C0C0C0C08F8F8F3434345F5F5FFF00FFFF00FF
        02558E2BC2FE51D4FF41A0D099D3EFEDFFFFD4D0C9836E5818445B44ABDE4AAD
        D7695A460A0A09013B650C7BAE2998C877DDFFA3E5FFCFF1FFDBF0F95AA9C8B1
        D8E98BCAE5379AC61AABDA4AD0FF2EB8E7D0BE9D7C5639023B577B7B7B939393
        C2C2C2D1D1D1E7E7E7EAEAEA979797CDCDCDB8B8B88D8D8D989898C2C2C2A5A5
        A5D4D4D47777774A4A4A0460991680B85CD3FF8CDDFFC1EDFFD0EBF74093B89D
        CCE272BBDD2182B60C96CF31C2FF1AA5E0C2AC86623C2300243D086C9F0670A4
        CDEBF9FAFFFFF2FCFFDBF5FF60BDE00697C6008EBC0089B80BA9D534C7FA33CF
        FF7EB8BF8B6B4C014262717171737373E3E3E3FCFCFCF8F8F8EDEDEDA2A2A27D
        7D7D7878787676768E8E8EB5B5B5B7B7B7BCBCBC8888884F4F4F03518802558E
        BFE5F7F8FFFFEEFBFFD0F2FF45ABD7027FB60075AA006FA50493C91FB7F81EC1
        FF64A5AD725033002A470670A4BCDBEA0670A4A1D2E693D9F772DBFF53D6FF33
        C0F1189CCE058CBC00A0CB1FB5E437CBFC23B1E51A6687025F8F737373D6D6D6
        737373CACACACBCBCBC0C0C0B5B5B5AFAFAF9191917E7E7E8383839F9F9FB7B7
        B7A2A2A26E6E6E66666602558EAAD0E302558E8AC5DE7ACEF457D0FF39CAFF1E
        AFED0B84C00173AA0089BC0FA1DC21BCFB129DDD0C4B6D004476FF00FF0670A4
        0670A40670A426A1D226ADE031C2F537C9FB34C4F72AB5E7128DBE0172A10F7B
        AFFF00FFFF00FFFF00FFFF00FF7373737373737373739A9A9AA1A1A1B0B0B0B5
        B5B5B2B2B2A6A6A68686866F6F6F7D7D7DFF00FFFF00FFFF00FFFF00FF02558E
        02558E02558E148AC51498D71CB1F221BAFA1FB4F417A1E00774AC00578A0660
        9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E85B80C7EB213
        93C50B8DC0006C9FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF8181817D7D7D8A8A8A8383836D6D6DFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF056BA504649E08
        7AB50474AF005188FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 3
    end
    object edtInteger: TJvValidateEdit
      Left = 226
      Top = 19
      Width = 127
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      EditText = '0'
      TabOrder = 2
      Visible = False
      ZeroEmpty = True
      OnKeyDown = edtStringKeyDown
    end
    object edtFloat: TJvCalcEdit
      Left = 226
      Top = 19
      Width = 121
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.00##'
      NumGlyphs = 2
      TabOrder = 3
      Visible = False
      DecimalPlacesAlwaysShown = False
      OnKeyDown = edtStringKeyDown
    end
    object edtDate: TJvDateEdit
      Left = 226
      Top = 19
      Width = 111
      Height = 21
      NumGlyphs = 2
      TabOrder = 4
      Visible = False
      OnKeyDown = edtStringKeyDown
    end
    object rgrOpcoes: TComboBox
      Left = 6
      Top = 19
      Width = 212
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnClick = rgrOpcoesClick
    end
    object btnMarcaTodos: TBitBtn
      Left = 572
      Top = 15
      Width = 100
      Height = 25
      Hint = 'Marca todos os itens at'#233' o limite de 1500'
      Anchors = [akTop, akRight]
      Caption = '&Marca Todos'
      Enabled = False
      TabOrder = 6
      OnClick = btnMarcaTodosClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000010000FF00FF00004B
        0000A4262600BA414100BB444400BD4A4A00BF4E4E00C0515100C1545400C55C
        5C00CB6C6C00CF777700D17D7D00098611000A8615000D931A000C9518000C9C
        19000F991C000E9D1D001392240011A0210011A422001CA134001CB1350024BC
        430029B548002EC6520035CA5E0039D46500D483830000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0101000000000000000000000000000113130100000000000000000000000118
        16131601000000000000000000011B1914010F130100000000000000011C1D17
        0100010E130100000000000000011A0107020000010F01000000000000020107
        0607020000010E0100000000020B0A060206060200000001010000020C1E0902
        000204060200000001010000020A020000000002060200000000000000020000
        0000000002040200000000000000000000000000000002020000000000000000
        0000000000000002020000000000000000000000000000000000}
    end
  end
  object dbgPesquisa: TDBSiagriGrid [2]
    Left = 0
    Top = 42
    Width = 757
    Height = 318
    Align = alClient
    DataSource = dsPesquisa
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dbgPesquisaDrawColumnCell
    OnDblClick = dbgPesquisaDblClick
    OnKeyDown = dbgPesquisaKeyDown
    OnMouseMove = dbgPesquisaMouseMove
    OrderColumn = True
    AutoWidth = True
    LocateGrid = True
  end
  object pnlBotoes: TPanel [3]
    Left = 0
    Top = 360
    Width = 757
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      757
      32)
    object btnFechar: TBitBtn
      Left = 682
      Top = 5
      Width = 72
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
      Glyph.Data = {
        36090000424D3609000000000000360000002800000030000000100000000100
        18000000000000090000E54C0000E54C00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF9A6666693334FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF90
        9090808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF824B4B4E1E1FFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A66669A6666B96666BB
        6868693334FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF9494949494948F8F8F919191808080FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF824B4B824B4BA64B4BA9
        4D4D4E1E1FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        9A66669A6666C66A6BD06A6BD26869C368696933349A66669A66669A66669A66
        669A66669A6666FF00FFFF00FFFF00FF9494949494949898989D9D9D9D9D9D95
        9595808080949494949494949494949494949494949494FF00FFFF00FFFF00FF
        824B4B824B4BB64F50C24F50C54D4EB24D4E4E1E1F824B4B824B4B824B4B824B
        4B824B4B824B4BFF00FFFF00FFFF00FF9A6666DE7374D77071D56F70D56D6EC7
        6A6D693334FEA2A3FCAFB0FABCBDF9C5C6F9C5C69A6666FF00FFFF00FFFF00FF
        949494A8A8A8A3A3A3A2A2A2A1A1A1989898808080D0D0D0D5D5D5DBDBDBDFDF
        DFDFDFDF949494FF00FFFF00FFFF00FF824B4BD45859CB5556C95455C95253B7
        4F524E1E1FFE8B8CFB9A9CF8AAABF7B5B6F7B5B6824B4BFF00FFFF00FFFF00FF
        9A6666E07778DB7576DA7475DA7273CC6E7169333439C56525CF6329CC6319CB
        5BF9C5C69A6666FF00FFFF00FFFF00FF949494ABABABA8A8A8A7A7A7A6A6A69D
        9D9D8080808F8F8F8E8E8E8E8E8E868686DFDFDF949494FF00FFFF00FFFF00FF
        824B4BD75C5DD05A5BCF595ACF5758BD53564E1E1F23B54A13C14816BD480CBC
        41F7B5B6824B4BFF00FFFF00FFFF00FF9A6666E57D7EE07A7BDF797ADF7778D0
        727569333442C46830CD6733CB6724CB60F9C5C69A6666FF00FFFF00FFFF00FF
        949494B1B1B1ADADADACACACABABABA1A1A18080809292929292929393938B8B
        8BDFDFDF949494FF00FFFF00FFFF00FF824B4BDD6364D75F60D55E5FD55C5DC2
        575A4E1E1F2AB44D1CBF4C1EBC4C13BC45F7B5B6824B4BFF00FFFF00FFFF00FF
        9A6666EA8283E57F80E37D7EE68081D374766933343DC26429CB632FCA6420CA
        5EF9C5C69A6666FF00FFFF00FFFF00FF949494B6B6B6B2B2B2B0B0B0B3B3B3A3
        A3A38080808F8F8F8E8E8E909090898989DFDFDF949494FF00FFFF00FFFF00FF
        824B4BE36869DD6566DA6364DE6667C6595B4E1E1F26B14916BC481BBB4910BB
        43F7B5B6824B4BFF00FFFF00FFFF00FF9A6666F08788E98182EC9697FBDDDED8
        888A693334B8E1AC6BDC895DD58046D473F9C5C69A6666FF00FFFF00FFFF00FF
        949494BBBBBBB5B5B5C1C1C1ECECECB0B0B0808080DADADAB7B7B7ADADADA1A1
        A1DFDFDF949494FF00FFFF00FFFF00FF824B4BEB6D6EE26768E67E7FFAD3D4CC
        6E704E1E1FA5D89750D16F42C9662DC758F7B5B6824B4BFF00FFFF00FFFF00FF
        9A6666F58C8DEE8687F0999AFDDCDDDA888A693334FFF5D8FFFFE0FFFFDEECFD
        D4F9C5C69A6666FF00FFFF00FFFF00FF949494C0C0C0BABABAC4C4C4ECECECB1
        B1B1808080F1F1F1EFEFEFEEEEEEE8E8E8DFDFDF949494FF00FFFF00FFFF00FF
        824B4BF27374E96C6DEB8182FCD1D3CF6E704E1E1FFFF2CCFFFFD7FFFFD4E6FC
        C7F7B5B6824B4BFF00FFFF00FFFF00FF9A6666FA9192F48E8FF28B8CF48C8DDC
        7F80693334FDF3D4FFFFDFFFFFDDFFFFE0F9C5C69A6666FF00FFFF00FFFF00FF
        949494C5C5C5C1C1C1BEBEBEC0C0C0ADADAD808080EEEEEEEFEFEFEEEEEEEFEF
        EFDFDFDF949494FF00FFFF00FFFF00FF824B4BF87879F07576EE7273F07374D1
        65664E1E1FFCEFC7FFFFD5FFFFD3FFFFD7F7B5B6824B4BFF00FFFF00FFFF00FF
        9A6666FE9798F99394F89293F99092E08585693334FDF3D4FFFFDFFFFFDDFFFF
        DFF9C5C69A6666FF00FFFF00FFFF00FF949494CACACAC6C6C6C5C5C5C4C4C4B2
        B2B2808080EEEEEEEFEFEFEEEEEEEFEFEFDFDFDF949494FF00FFFF00FFFF00FF
        824B4BFE7F80F77A7BF6797AF77779D76B6B4E1E1FFCEFC7FFFFD5FFFFD3FFFF
        D5F7B5B6824B4BFF00FFFF00FFFF00FF9A6666FF9B9CFD9798FC9697FE9798E3
        8889693334FDF3D4FFFFDFFFFFDDFFFFDFF9C5C69A6666FF00FFFF00FFFF00FF
        949494CDCDCDCACACAC9C9C9CACACAB5B5B5808080EEEEEEEFEFEFEEEEEEEFEF
        EFDFDFDF949494FF00FFFF00FFFF00FF824B4BFF8384FC7F80FB7E7FFE7F80DA
        6E6F4E1E1FFCEFC7FFFFD5FFFFD3FFFFD5F7B5B6824B4BFF00FFFF00FFFF00FF
        9A6666FF9FA0FF9A9BFF999AFF9A9BE78C8D693334FDF3D4FFFFDFFFFFDDFFFF
        DFF9C5C69A6666FF00FFFF00FFFF00FF949494CFCFCFCCCCCCCCCCCCCCCCCCB9
        B9B9808080E8E8E8EFEFEFEEEEEEEFEFEFDFDFDF949494FF00FFFF00FFFF00FF
        824B4BFF8889FF8283FF8182FF8283E073744E1E1FFCEFC7FFFFD5FFFFD3FFFF
        D5F7B5B6824B4BFF00FFFF00FFFF00FF9A66669A6666E98E8FFE999AFF9D9EEB
        8F90693334FBF0D2FDFCDCFDFCDAFDFCDCF9C5C69A6666FF00FFFF00FFFF00FF
        949494949494BBBBBBCBCBCBCECECEBDBDBD808080E6E6E6ECECECEBEBEBECEC
        ECDFDFDF949494FF00FFFF00FFFF00FF824B4B824B4BE27576FE8182FF8687E5
        76774E1E1FFAEBC5FCFBD1FCFBCFFCFBD1F7B5B6824B4BFF00FFFF00FFFF00FF
        FF00FFFF00FF9A6666B07172D78687DA88886933349A66669A66669A66669A66
        669A66669A6666FF00FFFF00FFFF00FFFF00FFFF00FF949494A4A4A4AEAEAEB1
        B1B1808080949494949494949494949494949494949494FF00FFFF00FFFF00FF
        FF00FFFF00FF824B4B9C5657CB6C6DCF6E6E4E1E1F824B4B824B4B824B4B824B
        4B824B4B824B4BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A66669A
        6666693334FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF929292909090808080FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF824B4B82
        4B4B4E1E1FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 3
    end
  end
  object cdsPesquisa: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cdsPesquisaField1'
      end>
    IndexDefs = <
      item
        Name = 'cdsPesquisaIndex1'
      end>
    Params = <>
    ProviderName = 'dspMasterPes'
    StoreDefs = True
    Left = 240
    Top = 144
  end
  object dsPesquisa: TDataSource
    DataSet = cdsPesquisa
    Left = 272
    Top = 144
  end
  object dspMasterPes: TDataSetProvider
    DataSet = sqqPesquisa
    Options = [poAllowCommandText]
    Left = 192
    Top = 144
  end
  object sqqPesquisa: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = FPrincipal.sqcPrincipal
    Left = 160
    Top = 144
  end
  object sqqDetalhe: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = FPrincipal.sqcPrincipal
    Left = 32
    Top = 320
  end
  object dspDetalhe: TDataSetProvider
    DataSet = sqqDetalhe
    Options = [poAllowCommandText]
    Left = 64
    Top = 320
  end
  object cdsDetalhe: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'C'#243'digo'
        Attributes = [faRequired]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'Descri'#231#227'o'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <
      item
        Name = 'cdsPesquisaIndex1'
      end>
    Params = <>
    ProviderName = 'dspDetalhe'
    StoreDefs = True
    Left = 96
    Top = 320
  end
  object dtsDetalhe: TDataSource
    DataSet = cdsDetalhe
    Left = 144
    Top = 320
  end
end