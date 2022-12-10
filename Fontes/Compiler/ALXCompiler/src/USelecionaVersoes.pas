unit USelecionaVersoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, StdCtrls, Buttons, ExtCtrls,
  Grids, BaseGrid, AdvGrid, DBAdvGrid, DB, Mask, DBCtrls, AdvObj,
  AdvOfficeStatusBarStylers, ImgList, AdvSmoothPanel, AdvGlowButton;

type
  TfrmSelecionaVersoes = class(TFMaster)
    DBAdvGrid1: TDBAdvGrid;
    edtPesquisa: TEdit;
    dtsSelecionaVersoes: TDataSource;
    pnlBotoes: TAdvSmoothPanel;
    btnGravar: TAdvGlowButton;
    btnCancelar: TAdvGlowButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FCODI_VER: String;
  public
    { Public declarations }
  end;

var
  frmSelecionaVersoes: TfrmSelecionaVersoes;

implementation

uses UPrincipal, DVersoes, ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmSelecionaVersoes.btnCancelarClick(Sender: TObject);
begin
  inherited;

   ModalResult := mrCancel;
end;

procedure TfrmSelecionaVersoes.btnGravarClick(Sender: TObject);
begin
  inherited;

   FCODI_VER := dmVersoes.cdsVersoesCODI_VER.AsString;

   ModalResult := mrOk;
end;

procedure TfrmSelecionaVersoes.edtPesquisaChange(Sender: TObject);
begin
  inherited;

   if Trim(edtPesquisa.Text) = '' then
   begin
      dmVersoes.cdsVersoes.Filtered := False;
      dmVersoes.cdsVersoes.Filter   := '';
      dmVersoes.cdsVersoes.FilterOptions := [];
   end
   else
   begin
      dmVersoes.cdsVersoes.Filtered := False;
      dmVersoes.cdsVersoes.FilterOptions := [foCaseInsensitive];
      dmVersoes.cdsVersoes.Filter   := 'DESC_VER = ' + QuotedStr(edtPesquisa.Text + '*') +
                                       ' or VERS_VER = ' + QuotedStr(edtPesquisa.Text + '*');
      dmVersoes.cdsVersoes.Filtered := True;
   end;
end;

procedure TfrmSelecionaVersoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

   frmSelecionaVersoes := nil;
end;

procedure TfrmSelecionaVersoes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   dmVersoes.cdsVersoes.Filtered := False;
   dmVersoes.cdsVersoes.Filter   := '';
   dmVersoes.cdsVersoes.FilterOptions := [];

   if  dmVersoes.cdsVersoes.Locate('CODI_VER', FCODI_VER, []) then
      frmPrincipal.cbxVersao.KeyValue := dmVersoes.cdsVersoesCODI_VER.AsInteger;

  inherited;
end;

procedure TfrmSelecionaVersoes.FormCreate(Sender: TObject);
begin
  inherited;

   FCODI_VER := dmVersoes.cdsVersoesCODI_VER.AsString;

   TALXFuncoes.DefineAlturaTela(Self, ALTURA_TELA_90);
end;

procedure TfrmSelecionaVersoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

   if (Key = VK_F11) then
      btnGravarClick(Sender);
end;

end.
