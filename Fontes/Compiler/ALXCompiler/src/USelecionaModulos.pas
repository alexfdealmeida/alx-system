unit USelecionaModulos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB,
  BaseGrid, AdvGrid, DBAdvGrid, AdvOfficeStatusBar, UMaster, AppEvnts, AdvObj,
  AdvOfficeStatusBarStylers, ImgList, AdvSmoothPanel, AdvGlowButton;

type
  TfrmSelecionaModulos = class(TFMaster)
    edtPesquisa: TEdit;
    dtsSelecionaModulos: TDataSource;
    DBAdvGrid1: TDBAdvGrid;
    pnlBotoes: TAdvSmoothPanel;
    btnGravar: TAdvGlowButton;
    btnCancelar: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FEstadoInicial: Integer;
  public
    { Public declarations }
  end;

var
  frmSelecionaModulos: TfrmSelecionaModulos;

implementation

uses UPrincipal, DModulos, ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmSelecionaModulos.btnCancelarClick(Sender: TObject);
begin
   dmModulos.cdsModulos.SavePoint := FEstadoInicial;

   Close;
end;

procedure TfrmSelecionaModulos.btnGravarClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmSelecionaModulos.edtPesquisaChange(Sender: TObject);
begin
   if (Trim(edtPesquisa.Text) = '') and (dmModulos.cdsModulos.IsEmpty) then
   begin
      dmModulos.cdsModulos.Filtered := False;
      dmModulos.cdsModulos.Filter   := '';
      dmModulos.cdsModulos.FilterOptions := [];
   end
   else
   begin
      dmModulos.cdsModulos.Filtered := False;
      dmModulos.cdsModulos.FilterOptions := [foCaseInsensitive];
      dmModulos.cdsModulos.Filter   := 'DESC_MOD = ' + QuotedStr(edtPesquisa.Text + '*') +
                                       ' or WANT_MOD = ' + QuotedStr(edtPesquisa.Text + '*') + 
                                       ' or (SELECIONA)';
      dmModulos.cdsModulos.Filtered := True;
   end;
end;

procedure TfrmSelecionaModulos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  
   frmSelecionaModulos := nil;
end;

procedure TfrmSelecionaModulos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   dmModulos.cdsModulos.Filtered := False;
   dmModulos.cdsModulos.Filter   := '';
   dmModulos.cdsModulos.FilterOptions := [];
end;

procedure TfrmSelecionaModulos.FormCreate(Sender: TObject);
begin
   FEstadoInicial := dmModulos.cdsModulos.SavePoint;

   TALXFuncoes.DefineAlturaTela(Self, ALTURA_TELA_90);
end;

end.
