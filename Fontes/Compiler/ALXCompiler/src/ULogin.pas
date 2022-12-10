unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, StdCtrls, Buttons,
  JvExControls, JvEnterTab, ExtCtrls, Mask, DBCtrls, AdvGlowButton,
  AdvOfficePager, ImgList, SqlExpr, JvComponentBase, AdvSmoothButton,
  AdvGlassButton, JvExStdCtrls, JvEdit, ComCtrls, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TfrmLogin = class(TFMaster)
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    lblLOGI_USU: TLabel;
    edtLOGI_USU: TEdit;
    lblSENH_USU: TLabel;
    edtSENH_USU: TEdit;
    ImageList1: TImageList;
    JvEnterAsTab1: TJvEnterAsTab;
    Panel1: TAdvSmoothPanel;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function DadosCorretos: Boolean;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses DPrincipal, ALXFuncoes, ALXCompilerVariaveis, ALXVariaveis;

{$R *.dfm}

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  inherited;
   ModalResult := mrCancel;
end;

procedure TfrmLogin.btnConfirmarClick(Sender: TObject);
begin
  inherited;

   if (Trim(edtLOGI_USU.Text) = '') then
   begin
      Application.MessageBox('Usuário não informado!', 'Compilador', MB_ICONINFORMATION + MB_OK);
      edtLOGI_USU.SetFocus;
      Exit;
   end;

   if (Trim(edtSENH_USU.Text) = '') then
   begin
      Application.MessageBox('Senha não informada!', 'Compilador', MB_ICONINFORMATION + MB_OK);
      edtSENH_USU.SetFocus;
      Exit;
   end;

   if not DadosCorretos then
   begin
      Exit;
   end;

   ModalResult := mrOk;

end;

function TfrmLogin.DadosCorretos: Boolean;
var
   FSQLQuery: TSQLQuery;
begin
   Result := False;

   FSQLQuery := TSQLQuery.Create(nil);

   try

      FSQLQuery.SQLConnection := dmPrincipal.sqcCompilador;

      FSQLQuery.Close;
      FSQLQuery.SQL.Clear;
      FSQLQuery.SQL.Add('select USU.CODI_USU, ' +
                        '       USU.NOME_USU, ' +
                        '       USU.SENH_USU, ' +
                        '       USU.LOGI_USU ' +
                        'from USUARIO USU ' +
                        'where (USU.LOGI_USU = :LOGI_USU) and ' +
                        '      (USU.SENH_USU = :SENH_USU)');
      FSQLQuery.Params.ParamByName('LOGI_USU').AsString := edtLOGI_USU.Text;
      FSQLQuery.Params.ParamByName('SENH_USU').AsString := edtSENH_USU.Text;
      FSQLQuery.Open;

      CODI_USU := 0;
      NOME_USU := '';
      SENH_USU := '';
      LOGI_USU := '';

      if not FSQLQuery.IsEmpty then
      begin
         CODI_USU := FSQLQuery.FieldByName('CODI_USU').AsInteger;
         NOME_USU := FSQLQuery.FieldByName('NOME_USU').AsString;
         SENH_USU := FSQLQuery.FieldByName('SENH_USU').AsString;
         LOGI_USU := FSQLQuery.FieldByName('LOGI_USU').AsString;
         Result := True;
      end
      else
      begin
         TALXFuncoes.Aviso('Usuário/senha inválido(s)!');
         edtLOGI_USU.SetFocus;
      end;

   finally
      FreeAndNil(FSQLQuery);
   end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
var
   Versao,
   Build: string;
begin
  inherited;

  TALXFuncoes.VersaoPrograma(Versao, Build);

  Versao := Versao + '.' + Build;

  Versao := StringReplace(Versao, '.', '', [rfReplaceAll]);

  VERS_EXE := Versao;
end;

end.
