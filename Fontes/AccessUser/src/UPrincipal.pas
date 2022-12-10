unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, JvExControls, JvEnterTab,
  JvComponentBase, JvLookOut, JvSpin, JvExMask, JvToolEdit, JvJCLUtils;

type
  TfrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    pnlBotoes: TPanel;
    btnConfirmar: TBitBtn;
    btnSair: TBitBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    lkoLiberacao: TJvLookOut;
    lkpUsuario: TJvLookOutPage;
    lkpLicenca: TJvLookOutPage;
    pnlUsuario: TPanel;
    lblLOGI_USU: TLabel;
    edtLOGI_USU: TEdit;
    lblSENH_USU: TLabel;
    edtSENH_USU: TEdit;
    lblPrograma: TLabel;
    cbxPrograma: TComboBox;
    pnlLicenca: TPanel;
    Label3: TLabel;
    edtPrograma: TEdit;
    lblData: TLabel;
    lblDias: TLabel;
    lblLicenca: TLabel;
    edtLicenca: TEdit;
    OpenDialog1: TOpenDialog;
    btnLicenca: TSpeedButton;
    edtData: TEdit;
    edtDias: TEdit;
    lblCliente: TLabel;
    edtCliente: TEdit;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnLicencaClick(Sender: TObject);
    procedure edtLicencaExit(Sender: TObject);
    procedure cbxProgramaExit(Sender: TObject);
    procedure lkpUsuarioClick(Sender: TObject);
    procedure lkpLicencaClick(Sender: TObject);
  private
    { Private declarations }
    procedure ExtrairDadosLicenca;
    procedure InativarLicenca;
    procedure LimparCampos;
    function Valida(AIndice: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TfrmPrincipal.btnConfirmarClick(Sender: TObject);
var
   lChaveValor: string;
begin
   lChaveValor := '';

   if lkoLiberacao.ActivePage = lkpUsuario then
   begin
      if not Valida(1) or not Valida(2) or not Valida(3) then
         Exit;

      lChaveValor := TALXFuncoes.Criptografa(cbxPrograma.Text + ';' + edtLOGI_USU.Text + ';' + edtSENH_USU.Text);

      TALXFuncoes.AtualizaRegistro(HKEY_CURRENT_USER,
                                   'Software\ALXCompiler',
                                   'AccessUser',
                                   lChaveValor);

      TALXFuncoes.Aviso('Liberação de usuário efetuada com êxito!');
   end
   else if lkoLiberacao.ActivePage = lkpLicenca then
   begin
      if not Valida(4) then
         Exit;

      ExtrairDadosLicenca;

      lChaveValor := edtPrograma.Text + ';' + edtCliente.Text + ';' + edtData.Text + ';' + edtDias.Text;

      lChaveValor := TALXFuncoes.Criptografa(lChaveValor);

      TALXFuncoes.AtualizaRegistro(HKEY_CURRENT_USER,
                                   'Software\ALXCompiler',
                                   'AccessData',
                                   lChaveValor);

      InativarLicenca;

      LimparCampos;

      TALXFuncoes.Aviso('Liberação de licença efetuada com êxito!');
   end;
end;

procedure TfrmPrincipal.btnLicencaClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
   begin
      edtLicenca.Text := OpenDialog1.FileName;

      ExtrairDadosLicenca;
   end;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmPrincipal.cbxProgramaExit(Sender: TObject);
begin
   btnConfirmar.SetFocus;
end;

procedure TfrmPrincipal.edtLicencaExit(Sender: TObject);
begin
   if not (btnSair.Focused) and not (edtLOGI_USU.Focused) then
   begin
      if not Valida(4) then
         Exit;

      ExtrairDadosLicenca;
   end;
end;

procedure TfrmPrincipal.ExtrairDadosLicenca;
var
   lLicenca: string;
   lLista: TStrings;
begin
   lLista := TStringList.Create;

   try

      lLista.LoadFromFile(edtLicenca.Text);

      lLicenca := lLista[0];

      lLicenca := TALXFuncoes.Descriptografa(lLicenca);

      if ExtractDelimited(5, lLicenca, [';']) = 'utilizada' then
      begin
         TALXFuncoes.Aviso('Esta licença já foi utilizada!');

         LimparCampos;

         Abort;
      end;

      edtPrograma.Text := ExtractDelimited(1, lLicenca, [';']);
      edtCliente.Text := ExtractDelimited(2, lLicenca, [';']);
      edtData.Text := ExtractDelimited(3, lLicenca, [';']);
      edtDias.Text := ExtractDelimited(4, lLicenca, [';']);

   finally
      FreeAndNil(lLista);
   end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
   cbxPrograma.ItemIndex := 0;

   lkoLiberacao.ActivePage := lkpLicenca;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      btnSairClick(Sender);
end;

procedure TfrmPrincipal.InativarLicenca;
var
   lLicenca: string;
   lLista: TStrings;
begin
   lLista := TStringList.Create;

   try

      lLista.LoadFromFile(edtLicenca.Text);

      lLicenca := lLista[0];

      lLicenca := TALXFuncoes.Descriptografa(lLicenca);

      lLicenca := lLicenca + ';utilizada';

      lLicenca := TALXFuncoes.Criptografa(lLicenca);

      lLista.Clear;

      lLista.Add(lLicenca);

      lLista.SaveToFile(edtLicenca.Text);

   finally
      FreeAndNil(lLista);
   end;
end;

procedure TfrmPrincipal.LimparCampos;
var
  I: Integer;
begin
   for I := 0 to frmPrincipal.ComponentCount - 1 do
   begin
      if frmPrincipal.Components[I] is TCustomEdit then
         TCustomEdit(frmPrincipal.Components[I]).Clear;
   end;
end;

procedure TfrmPrincipal.lkpLicencaClick(Sender: TObject);
begin
   edtLicenca.SetFocus;
end;

procedure TfrmPrincipal.lkpUsuarioClick(Sender: TObject);
begin
   edtLOGI_USU.SetFocus;
end;

function TfrmPrincipal.Valida(AIndice: Integer): Boolean;
begin
   Result := True;

   case AIndice of
      1:
      begin
         if Trim(edtLOGI_USU.Text) = '' then
         begin
            TALXFuncoes.Aviso('O campo "Usuário" deve ser informado!');
            Result := False;
            edtLOGI_USU.SetFocus;
         end;
      end;
      2:
      begin
         if Trim(edtSENH_USU.Text) = '' then
         begin
            TALXFuncoes.Aviso('O campo "Senha" deve ser informado!');
            Result := False;
            edtSENH_USU.SetFocus;
         end;
      end;
      3:
      begin
         if Trim(cbxPrograma.Text) = '' then
         begin
            TALXFuncoes.Aviso('O campo "Programa" deve ser informado!');
            Result := False;
            cbxPrograma.SetFocus;
         end;
      end;
      4:
      begin
         if Trim(edtLicenca.Text) = '' then
         begin
            TALXFuncoes.Aviso('O campo "Licença" deve ser informado!');
            Result := False;
            edtLicenca.SetFocus;
         end
         else
         begin
            if not TALXFuncoes.ArquivoExiste(edtLicenca.Text, True, 'O arquivo informado no campo licença é inválido!') then
            begin
               Result := False;
               edtLicenca.Text;
            end;
         end;
      end;
   end;

end;

end.
