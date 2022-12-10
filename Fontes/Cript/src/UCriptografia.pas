unit UCriptografia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, Buttons, ExtCtrls, StdCtrls, ImgList;

type
  TfrmCriptografia = class(TFMaster)
    pnlBotoes: TPanel;
    btnSair: TSpeedButton;
    gbxConverter: TGroupBox;
    mmoConverter: TMemo;
    gbxConvertido: TGroupBox;
    mmoConvertido: TMemo;
    btnDescriptografar: TSpeedButton;
    btnCriptografar: TSpeedButton;
    Splitter1: TSplitter;
    procedure btnSairClick(Sender: TObject);
    procedure btnCriptografarClick(Sender: TObject);
    procedure btnDescriptografarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCriptografia: TfrmCriptografia;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TfrmCriptografia.btnDescriptografarClick(Sender: TObject);
var
   lIndex: Integer;
begin
  inherited;

   mmoConverter.Clear;

   for lIndex := 0 to mmoConvertido.Lines.Count - 1 do
      mmoConverter.Lines.Add(TALXFuncoes.Descriptografa(mmoConvertido.Lines[lIndex]));
end;

procedure TfrmCriptografia.btnCriptografarClick(Sender: TObject);
var
   lIndex: Integer;
begin
  inherited;

   mmoConvertido.Clear;

   for lIndex := 0 to mmoConverter.Lines.Count - 1 do
      mmoConvertido.Lines.Add(TALXFuncoes.Criptografa(mmoConverter.Lines[lIndex]));
end;

procedure TfrmCriptografia.btnSairClick(Sender: TObject);
begin
  inherited;
   Close;
end;

end.
