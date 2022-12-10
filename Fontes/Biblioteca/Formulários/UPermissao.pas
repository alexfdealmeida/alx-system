unit UPermissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, StdCtrls, Buttons, ExtCtrls,
  JvExControls, JvEnterTab, ImgList, JvComponentBase, AdvOfficePager,
  AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TfrmPermissao = class(TFMaster)
    JvEnterAsTab: TJvEnterAsTab;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    lblLOGI_USU: TLabel;
    lblSENH_USU: TLabel;
    edtLOGI_USU: TEdit;
    edtSENH_USU: TEdit;
    Panel1: TAdvSmoothPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPermissao: TfrmPermissao;

implementation

uses ALXFuncoes, ALXVariaveis;

{$R *.dfm}

procedure TfrmPermissao.btnCancelarClick(Sender: TObject);
begin
  inherited;
   ModalResult := mrCancel
end;

procedure TfrmPermissao.btnGravarClick(Sender: TObject);
begin
  inherited;

   if (TALXFuncoes.Criptografa(edtLOGI_USU.Text) = NOME_ADMIN) and
      (TALXFuncoes.Criptografa(edtSENH_USU.Text) = SENH_ADMIN) then
   begin
      ModalResult := mrOk;
   end
   else
   begin
      if not TALXFuncoes.Aviso('Usuário/senha inválido(s)!' + #13 +
                               'Deseja tentar novamente?', bmSimNao, imPergunta) then
      begin
         ModalResult := mrCancel;
      end
      else
      begin
         edtLOGI_USU.SetFocus;
      end;
   end;
end;

end.
