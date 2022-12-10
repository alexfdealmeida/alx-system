unit UParametros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, JvExControls, JvEnterTab, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, Mask, DBCtrls, Registry, ActnList, JvExExtCtrls, JvExStdCtrls,
  JvDBCombobox, DB, JvBaseDlg, JvSelectDirectory, AppEvnts, AdvOfficeStatusBar,
  AdvOfficePager, AdvOfficeButtons, DBAdvOfficeButtons, AdvGroupBox, AdvSpin,
  DBAdvSp, AdvGlowButton, ImgList, JvCombobox, JvComponentBase, JvExMask, JvSpin,
  JvDBSpinEdit, AdvOfficeStatusBarStylers, AdvSmoothPanel, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdFTP;

type
  TfrmParametros = class(TfrmMasterCad)
    dtsParametros: TDataSource;
    JvSelectDirectory1: TJvSelectDirectory;
    pgcConfiguracao: TAdvOfficePager;
    tabGeral: TAdvOfficePage;
    chkIniciar: TDBAdvOfficeCheckBox;
    tabCompilacao: TAdvOfficePage;
    tabInterface: TAdvOfficePage;
    tabBaseDados: TAdvOfficePage;
    DBAdvOfficeCheckBox4: TDBAdvOfficeCheckBox;
    tabControle: TAdvOfficePage;
    OpenDialog1: TOpenDialog;
    DBAdvOfficeCheckBox5: TDBAdvOfficeCheckBox;
    tabGerenciaConfig: TAdvOfficePage;
    gbxSERV_CFG: TAdvGroupBox;
    btnSERV_CFG: TSpeedButton;
    edtSERV_CFG: TDBEdit;
    gbxIPRD_CFG: TAdvGroupBox;
    edtIPRD_CFG: TDBEdit;
    gbxSZIP_CFG: TAdvGroupBox;
    btnSZIP_CFG: TSpeedButton;
    edtSZIP_CFG: TDBEdit;
    GroupBox1: TAdvGroupBox;
    JvDBComboBox1: TJvDBComboBox;
    AdvGroupBox1: TAdvGroupBox;
    lblCorDeFundo: TLabel;
    lblCorDeTexto: TLabel;
    cbxCorDeFundo: TColorBox;
    cbxCorDeTexto: TColorBox;
    gbxLINK_CFG: TAdvGroupBox;
    edtLINK_CFG: TDBEdit;
    pgcVer: TAdvOfficePager;
    tabGIT: TAdvOfficePage;
    gbxTGIT_CFG: TAdvGroupBox;
    btnTGIT_CFG: TSpeedButton;
    edtTGIT_CFG: TDBEdit;
    gbxSGIT_CFG: TAdvGroupBox;
    btnSGIT_CFG: TSpeedButton;
    edtSGIT_CFG: TDBEdit;
    cbxUPDG_CFG: TDBAdvOfficeCheckBox;
    cbxSWIT_CFG: TDBAdvOfficeCheckBox;
    tabSVN: TAdvOfficePage;
    gbxTSVN_CFG: TAdvGroupBox;
    btnTSVN_CFG: TSpeedButton;
    edtTSVN_CFG: TDBEdit;
    DBAdvOfficeCheckBox1: TDBAdvOfficeCheckBox;
    gbxFTP: TAdvGroupBox;
    edtHFTP_CFG: TDBEdit;
    lblHFTP_CFG: TLabel;
    lblUFTP_CFG: TLabel;
    edtUFTP_CFG: TDBEdit;
    lblSFTP_CFG: TLabel;
    edtSFTP_CFG: TDBEdit;
    AdvGroupBox2: TAdvGroupBox;
    AdvGroupBox3: TAdvGroupBox;
    AdvGroupBox4: TAdvGroupBox;
    DBAdvOfficeCheckBox2: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox8: TDBAdvOfficeCheckBox;
    chkExecutar: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox6: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox7: TDBAdvOfficeCheckBox;
    chkGLNK_CFG: TDBAdvOfficeCheckBox;
    chkEFTP_CFG: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox3: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox9: TDBAdvOfficeCheckBox;
    chkCPYR_CFG: TDBAdvOfficeCheckBox;
    chkIVER_CFG: TDBAdvOfficeCheckBox;
    chkIPAR_CFG: TDBAdvOfficeCheckBox;
    btnTestarConexaoFTP: TAdvGlowButton;
    IdFTP1: TIdFTP;
    aclParametros: TActionList;
    actParametros: TAction;
    chkAFTP_CFG: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox10: TDBAdvOfficeCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure btnSERV_CFGClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTSVN_CFGClick(Sender: TObject);
    procedure btnTGIT_CFGClick(Sender: TObject);
    procedure btnSGIT_CFGClick(Sender: TObject);
    procedure btnSZIP_CFGClick(Sender: TObject);
    procedure btnTestarConexaoFTPClick(Sender: TObject);
    procedure actParametrosExecute(Sender: TObject);
    procedure actParametrosUpdate(Sender: TObject);
  private
    { Private declarations }
    function ConectouFTP(AFTP: TIdFTP; AEmitirAviso: Boolean = True): Boolean;
  public
    { Public declarations }
  end;

var
  frmParametros: TfrmParametros;

implementation

uses UPrincipal, DParametros, ALXFuncoes;

{$R *.dfm}

procedure TfrmParametros.actParametrosExecute(Sender: TObject);
begin
  inherited;

   { Favor não remover este comentário }
end;

procedure TfrmParametros.actParametrosUpdate(Sender: TObject);
begin
  inherited;

   btnTestarConexaoFTP.Enabled := (Trim(edtHFTP_CFG.Text) <> '') and
                                  (Trim(edtUFTP_CFG.Text) <> '') and
                                  (Trim(edtSFTP_CFG.Text) <> '');
end;

procedure TfrmParametros.btnGravarClick(Sender: TObject);
var
   Reg : TRegistry;
begin
   if (Trim(edtSERV_CFG.Text) <> '') and not (TALXFuncoes.DiretorioExiste('diretório dos executáveis atualizados', edtSERV_CFG.Text, False)) then
   begin
      pgcConfiguracao.ActivePage := tabGeral;
      edtSERV_CFG.SetFocus;
      Exit;
   end;

   if (Trim(edtSZIP_CFG.Text) <> '') and not (TALXFuncoes.ArquivoExiste(edtSZIP_CFG.Text, True, ' - Aplicativo 7z.exe.')) then
   begin
      pgcConfiguracao.ActivePage := tabCompilacao;
      edtSZIP_CFG.SetFocus;
      Exit;
   end;

   if (Trim(edtTGIT_CFG.Text) <> '') and not (TALXFuncoes.ArquivoExiste(edtTGIT_CFG.Text, True, ' - Aplicativo TortoiseProc.exe (GIT).')) then
   begin
      pgcConfiguracao.ActivePage := tabControle;
      pgcVer.ActivePage := tabGIT;
      edtTGIT_CFG.SetFocus;
      Exit;
   end;

   if (Trim(edtSGIT_CFG.Text) <> '') and not (TALXFuncoes.ArquivoExiste(edtSGIT_CFG.Text, True, ' - Aplicativo sh.exe (GIT).')) then
   begin
      pgcConfiguracao.ActivePage := tabControle;
      pgcVer.ActivePage := tabGIT;
      edtSGIT_CFG.SetFocus;
      Exit;
   end;

   if (Trim(edtTSVN_CFG.Text) <> '') and not (TALXFuncoes.ArquivoExiste(edtTSVN_CFG.Text, True, ' - Aplicativo TortoiseProc.exe (SVN).')) then
   begin
      pgcConfiguracao.ActivePage := tabControle;
      pgcVer.ActivePage := tabSVN;
      edtTSVN_CFG.SetFocus;
      Exit;
   end;

   if (chkEFTP_CFG.Checked) or
      ( (Trim(edtHFTP_CFG.Text) <> '') or (Trim(edtUFTP_CFG.Text) <> '') or (Trim(edtSFTP_CFG.Text) <> '') ) then
   begin
      if (Trim(edtHFTP_CFG.Text) = '') then
      begin
         TALXFuncoes.Aviso('O host do FTP deve ser informado!');
         pgcConfiguracao.ActivePage := tabGerenciaConfig;
         edtHFTP_CFG.SetFocus;
         Exit;
      end;

      if (Trim(edtUFTP_CFG.Text) = '') then
      begin
         TALXFuncoes.Aviso('O usuário do FTP deve ser informado!');
         pgcConfiguracao.ActivePage := tabGerenciaConfig;
         edtUFTP_CFG.SetFocus;
         Exit;
      end;

      if (Trim(edtSFTP_CFG.Text) = '') then
      begin
         TALXFuncoes.Aviso('A senha do FTP deve ser informado!');
         pgcConfiguracao.ActivePage := tabGerenciaConfig;
         edtSFTP_CFG.SetFocus;
         Exit;
      end;

      if ( (dmParametros.cdsParametrosEFTP_CFG.OldValue) <> (dmParametros.cdsParametrosEFTP_CFG.NewValue) ) or
         ( (dmParametros.cdsParametrosHFTP_CFG.OldValue) <> (dmParametros.cdsParametrosHFTP_CFG.NewValue) ) or
         ( (dmParametros.cdsParametrosUFTP_CFG.OldValue) <> (dmParametros.cdsParametrosUFTP_CFG.NewValue) ) or
         ( (dmParametros.cdsParametrosSFTP_CFG.OldValue) <> (dmParametros.cdsParametrosSFTP_CFG.NewValue) ) then
      begin
         if not ConectouFTP(IdFTP1, False) then
         begin
            if not TALXFuncoes.Aviso('Deseja realmente prosseguir?',
                                     bmSimNao,
                                     imPergunta) then
            begin
               pgcConfiguracao.ActivePage := tabGerenciaConfig;
               edtHFTP_CFG.SetFocus;
               Exit;
            end;
         end;
      end;

   end;

   if (dmParametros.cdsParametrosIAUT_CFG.OldValue) <> (dmParametros.cdsParametrosIAUT_CFG.NewValue) then
   begin
      Reg := TRegistry.Create;

      try

         Reg.RootKey := HKEY_CURRENT_USER;


         if (Reg.OpenKey('SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN', True)) then
         begin
            if chkIniciar.Checked then
               Reg.WriteString('ALXCOMPILER', '"' + ExtractFilePath(Application.ExeName) + 'ALXCompiler.exe' + '"')
            else
               Reg.DeleteValue('ALXCOMPILER');

            Reg.CloseKey;
         end;


      finally
         Reg.Free;
      end;
   end;

   dmParametros.cdsParametrosCORM_CFG.AsInteger := cbxCorDeFundo.ItemIndex;
   dmParametros.cdsParametrosCORF_CFG.AsInteger := cbxCorDeTexto.ItemIndex;

   TALXFuncoes.MudarCor(frmPrincipal.mmoLog, dmParametros.cdsParametrosCORM_CFG.AsInteger, dmParametros.cdsParametrosCORF_CFG.AsInteger);

   if (dmParametros.cdsParametrosAGMS_CFG.OldValue <> dmParametros.cdsParametrosAGMS_CFG.NewValue) then
   begin
      Application.MessageBox('Para que as alterações entrem em vigor, é necessário reiniciar o aplicativo!', 'ALXCompiler', MB_ICONINFORMATION + MB_OK);
   end;

  inherited;
end;

procedure TfrmParametros.btnSERV_CFGClick(Sender: TObject);
begin
  inherited;
   if JvSelectDirectory1.Execute then
      edtSERV_CFG.Field.Value := JvSelectDirectory1.Directory;
end;

procedure TfrmParametros.btnTSVN_CFGClick(Sender: TObject);
begin
  inherited;

   if OpenDialog1.Execute then
      edtTSVN_CFG.Field.Value := OpenDialog1.FileName;
end;

function TfrmParametros.ConectouFTP(AFTP: TIdFTP; AEmitirAviso: Boolean = True): Boolean;
begin
   Result := False;

   AFTP.Host     := edtHFTP_CFG.Text;
   AFTP.Username := edtUFTP_CFG.Text;
   AFTP.Password := edtSFTP_CFG.Text;

   try

      AFTP.Connect;

      try

         if AFTP.Connected then
         begin
            Result := True
         end;

         if AEmitirAviso then
         begin
            TALXFuncoes.Aviso('Conexão estabelecida com sucesso!');
         end;

      finally
         AFTP.Disconnect;
      end;

   except
      on E: Exception do
      begin
         TALXFuncoes.Aviso('Não foi possível estabelecer conexão com o FTP! ' + #13 +
                           'Mensagem do erro: ' + E.Message + #13 +
                           'Classe do erro: ' + E.ClassName);
      end;
   end;
end;

procedure TfrmParametros.FormCreate(Sender: TObject);
begin
  inherited;
   pgcConfiguracao.ActivePage := tabGeral;

   pgcVer.ActivePage := tabGIT;

   if dmParametros.cdsParametrosCORM_CFG.AsVariant = null then
   begin
      cbxCorDeFundo.ItemIndex := 15;
      dmParametros.cdsParametrosCORM_CFG.AsVariant := cbxCorDeFundo.ItemIndex;
   end
   else
      cbxCorDeFundo.ItemIndex := dmParametros.cdsParametrosCORM_CFG.AsInteger;

   if dmParametros.cdsParametrosCORF_CFG.AsVariant = null then
   begin
      cbxCorDeTexto.ItemIndex := 0;
      dmParametros.cdsParametrosCORF_CFG.AsVariant := cbxCorDeTexto.ItemIndex;
   end
   else
      cbxCorDeTexto.ItemIndex := dmParametros.cdsParametrosCORF_CFG.AsInteger;
end;

procedure TfrmParametros.btnTestarConexaoFTPClick(Sender: TObject);
begin
  inherited;

   if not ConectouFTP(IdFTP1) then
   begin
      edtHFTP_CFG.SetFocus;
   end;
end;

procedure TfrmParametros.btnTGIT_CFGClick(Sender: TObject);
begin
  inherited;

   if OpenDialog1.Execute then
      edtTGIT_CFG.Field.Value := OpenDialog1.FileName;
end;

procedure TfrmParametros.btnSGIT_CFGClick(Sender: TObject);
begin
  inherited;

   if OpenDialog1.Execute then
      edtSGIT_CFG.Field.Value := OpenDialog1.FileName;
end;

procedure TfrmParametros.btnSZIP_CFGClick(Sender: TObject);
begin
  inherited;

   if OpenDialog1.Execute then
      edtSZIP_CFG.Field.Value := OpenDialog1.FileName;
end;

end.
