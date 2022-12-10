unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, SkinCaption, WinSkinData, ComCtrls, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    BitBtn1: TBitBtn;
    SkinData1: TSkinData;
    SkinCaption1: TSkinCaption;
    StatusBar1: TStatusBar;
    pnlBotoes: TPanel;
    btnSair: TBitBtn;
    btnIP: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnIPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses firstFuncoes;

{$R *.dfm}

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
begin
   ShowMessage(TFirstFuncoes.RetornaUsuarioLogado);
end;

procedure TfrmPrincipal.btnIPClick(Sender: TObject);
begin
   ShowMessage(TFirstFuncoes.RetornaIP);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
   Close;
end;

end.
