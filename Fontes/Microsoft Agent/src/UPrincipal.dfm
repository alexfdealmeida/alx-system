object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Converte Texto para Fala'
  ClientHeight = 564
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Agent1: TAgent
    Left = 264
    Top = 80
    Width = 32
    Height = 32
    ControlData = {030200004F0300004F030000}
  end
  object JvMemo1: TJvMemo
    Left = 0
    Top = 65
    Width = 784
    Height = 458
    AutoSize = False
    MaxLines = 0
    HideCaret = False
    Align = alClient
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 65
    Align = alTop
    TabOrder = 2
    object gbxAgente: TGroupBox
      Left = 8
      Top = 0
      Width = 185
      Height = 53
      Caption = 'Selecione o Agente desejado'
      TabOrder = 0
      object cbxAgente: TJvComboBox
        Left = 24
        Top = 16
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnSelect = cbxAgenteSelect
        Items.Strings = (
          'merlin'
          'peedy'
          'audie'
          'genie'
          'oscar'
          'robby'
          'santa')
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 523
    Width = 784
    Height = 41
    Align = alBottom
    TabOrder = 3
    object BitBtn2: TBitBtn
      Left = 693
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Falar'
      TabOrder = 0
      OnClick = BitBtn2Click
    end
  end
end
