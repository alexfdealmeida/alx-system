unit UMessenger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, Buttons, ExtCtrls, Grids,
  DBGrids, StdCtrls, JvExStdCtrls, JvMemo, BaseGrid, AdvGrid,
  DBAdvGrid, AdvOfficePager, DB, Menus, AdvMenus, AdvOfficeButtons, ImgList,
  AdvObj, ComCtrls, AdvOfficeStatusBar, AdvOfficeStatusBarStylers;

type
  TfrmMessenger = class(TFMaster)
    pgcLog: TAdvOfficePager;
    mmoLogMessenger: TJvMemo;
    pgcUsuarios: TAdvOfficePager;
    tabUsuarios: TAdvOfficePage;
    gridUsuarios: TDBAdvGrid;
    pnlBotoes: TPanel;
    btnSair: TSpeedButton;
    dtsUsuarios: TDataSource;
    popLog: TAdvPopupMenu;
    teste11: TMenuItem;
    SalvarLog2: TMenuItem;
    teste21: TMenuItem;
    LimparLog1: TMenuItem;
    SaveDialogSalvar: TSaveDialog;
    OpenDialogCarregar: TOpenDialog;
    chkMarcarDesmarcar: TAdvOfficeCheckBox;
    btnLimparHistorico: TSpeedButton;
    btnAtualizar: TSpeedButton;
    pgcMensagens: TAdvOfficePager;
    tabMensagens: TAdvOfficePage;
    btnEnviar: TSpeedButton;
    mmoMensagem: TJvMemo;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure mmoMensagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure teste11Click(Sender: TObject);
    procedure SalvarLog2Click(Sender: TObject);
    procedure LimparLog1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure chkMarcarDesmarcarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLimparHistoricoClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaListaUsuarios;
  public
    { Public declarations }
  end;

var
  frmMessenger: TfrmMessenger;

implementation

uses UPrincipal, DUsuarios, ALXFuncoes, ALXCompilerFuncoesDB, ALXCompilerVariaveis,
  DParametros, DBClient;

{$R *.dfm}

procedure TfrmMessenger.AtualizaListaUsuarios;
var
   lUsuariosSelecionados: TStringList;
   lIndex: Integer;
begin
   lUsuariosSelecionados := TStringList.Create;

   try

      try

         dmUsuarios.cdsUsuarios.DisableControls;

         dmUsuarios.cdsUsuarios.Filtered := False;
         dmUsuarios.cdsUsuarios.Filter   := 'ENVIAR';
         dmUsuarios.cdsUsuarios.Filtered := True;

         dmUsuarios.cdsUsuarios.First;
         while not dmUsuarios.cdsUsuarios.Eof do
         begin
            lUsuariosSelecionados.Add(dmUsuarios.cdsUsuariosCODI_USU.AsString);

            dmUsuarios.cdsUsuarios.Next;
         end;

      finally
         dmUsuarios.cdsUsuarios.Filtered := False;
         dmUsuarios.cdsUsuarios.Filter   := '';

         dmUsuarios.cdsUsuarios.EnableControls;
      end;

      dmUsuarios.cdsUsuarios.Close;
      dmUsuarios.cdsUsuarios.Open;

      dmUsuarios.cdsUsuarios.Filtered := False;
      dmUsuarios.cdsUsuarios.Filter   := 'ONLI_USU = ''S''';
      dmUsuarios.cdsUsuarios.Filtered := True;

      for lIndex := 0 to lUsuariosSelecionados.Count - 1 do
      begin
         if dmUsuarios.cdsUsuarios.Locate('CODI_USU', lUsuariosSelecionados[lIndex], []) then
         begin
            dmUsuarios.cdsUsuarios.Edit;
            dmUsuarios.cdsUsuariosENVIAR.AsBoolean := True;
            dmUsuarios.cdsUsuarios.Post;
         end;
      end;

   finally
      FreeAndNil(lUsuariosSelecionados);
   end;
end;

procedure TfrmMessenger.btnAtualizarClick(Sender: TObject);
begin
  inherited;

   AtualizaListaUsuarios;
end;

procedure TfrmMessenger.btnEnviarClick(Sender: TObject);
var
   I: Integer;
   lIPDestinatario,
   lUsuariosOff,
   lFiltroIni: string;
   lListaUsuariosOff: TStrings;
begin
  inherited;
   try
      if Trim(mmoMensagem.Text) = '' then
         Exit;

      lFiltroIni := dmUsuarios.cdsUsuarios.Filter;

      dmUsuarios.cdsUsuarios.Filtered := False;

      if lFiltroIni <> '' then
      begin
         dmUsuarios.cdsUsuarios.Filter := lFiltroIni + ' and (ENVIAR)';
      end
      else
      begin
         dmUsuarios.cdsUsuarios.Filter := '(ENVIAR)';
      end;

      dmUsuarios.cdsUsuarios.Filtered := True;

      lUsuariosOff := '';

      if not dmUsuarios.cdsUsuarios.IsEmpty then
      begin

         lListaUsuariosOff := TStringList.Create;

         try

            dmUsuarios.cdsUsuarios.First;
            while not dmUsuarios.cdsUsuarios.Eof do
            begin
               lIPDestinatario := '';
               lIPDestinatario := TALXCompilerFuncoesDB.RetornaInformacesConfig('CODI_USU', 'IPRD_CFG', dmUsuarios.cdsUsuariosCODI_USU.AsInteger);

               frmPrincipal.TcpClient1.RemoteHost := lIPDestinatario;
               frmPrincipal.TcpClient1.RemotePort := PORTA_MESSENGER;

               try

                  if frmPrincipal.TcpClient1.Connect then
                  begin
                     if dmUsuarios.cdsUsuarios.RecNo = 1 then
                     begin
                        //mmoLogMessenger.Lines.Add(TALXCompilerFuncoesDB.RetornaInformacoesUsuario('CODI_USU', 'NOME_USU', CODI_USU));
                        mmoLogMessenger.Lines.Add(NOME_USU);
                     end;

                     for I := 0 to mmoMensagem.Lines.Count - 1 do
                     begin
                        frmPrincipal.TcpClient1.Sendln(mmoMensagem.Lines[I]);

                        if dmUsuarios.cdsUsuarios.RecNo = 1 then
                           mmoLogMessenger.Lines.Add(mmoMensagem.Lines[I]);
                     end;

                     if dmUsuarios.cdsUsuarios.RecNo = 1 then
                     begin
                        mmoLogMessenger.Lines.Add(DateTimeToStr(Now));
                        mmoLogMessenger.Lines.Add('');
                     end;
                  end
                  else
                  begin
                     lUsuariosOff := lUsuariosOff + ' - ' + dmUsuarios.cdsUsuariosNOME_USU.AsString + #13;

                     lListaUsuariosOff.Add(dmUsuarios.cdsUsuariosCODI_USU.AsString);
                  end;

               finally
                  frmPrincipal.TcpClient1.RemoteHost := '';
                  frmPrincipal.TcpClient1.RemotePort := '';
               end;

               dmUsuarios.cdsUsuarios.Next;

            end;

            if lUsuariosOff <> '' then
            begin
               Application.MessageBox(Pchar('Não foi possível enviar a mensagem para os seguinte(s) usuário(s), ' + #13 +
                                            'pois o(s) mesmo(s) está(ão) off-line: ' + #13 +
                                            lUsuariosOff), 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

               for I := 0 to lListaUsuariosOff.Count - 1 do
               begin
                  TALXCompilerFuncoesDB.AtualizarSituacaoUsuario(StrToInt(lListaUsuariosOff[I]), False);
               end;

               AtualizaListaUsuarios;

            end;

         finally
            FreeAndNil(lListaUsuariosOff);
         end;

      end
      else
      begin
         Application.MessageBox('Nenhum usuário selecionado!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
      end;

   finally
      if lFiltroIni <> '' then
      begin
         dmUsuarios.cdsUsuarios.Filtered := False;
         dmUsuarios.cdsUsuarios.Filter := lFiltroIni;
         dmUsuarios.cdsUsuarios.Filtered := True;
      end
      else
      begin
         dmUsuarios.cdsUsuarios.Filtered := False;
         dmUsuarios.cdsUsuarios.Filter := '';
      end;

      mmoMensagem.Clear;

      mmoMensagem.SetFocus;
   end;
end;

procedure TfrmMessenger.btnSairClick(Sender: TObject);
begin
  inherited;
   Close;
end;

procedure TfrmMessenger.chkMarcarDesmarcarClick(Sender: TObject);
begin
  inherited;

   TALXCompilerFuncoesDB.MarcarDesmarcarBooleans(dmUsuarios.cdsUsuarios, 'ENVIAR', chkMarcarDesmarcar.Checked);
end;

procedure TfrmMessenger.FormActivate(Sender: TObject);
begin
  inherited;

   frmPrincipal.JvTrayIcon1.Animated  := False;
   frmPrincipal.JvTrayIcon1.IconIndex := -1;
end;

procedure TfrmMessenger.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := False;

   dmUsuarios.cdsUsuarios.Filtered := False;
   dmUsuarios.cdsUsuarios.Filter := '';

   Hide;

  inherited;
end;

procedure TfrmMessenger.FormCreate(Sender: TObject);
begin
  inherited;

   TALXFuncoes.DefineAlturaLarguraTela(Self, ALTURA_TELA_90, LARGURA_TELA_70);
end;

procedure TfrmMessenger.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

   if (Key = VK_F5) then
      AtualizaListaUsuarios;      
end;

procedure TfrmMessenger.FormShow(Sender: TObject);
begin
  inherited;

   frmPrincipal.JvTrayIcon1.Animated  := False;
   frmPrincipal.JvTrayIcon1.IconIndex := -1;

   AtualizaListaUsuarios;
end;

procedure TfrmMessenger.LimparLog1Click(Sender: TObject);
begin
  inherited;
   mmoLogMessenger.Clear;
end;

procedure TfrmMessenger.mmoMensagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if (key = VK_RETURN) and not ( (ssCtrl in Shift) ) then
   begin
      mmoMensagem.WantReturns := False;
      btnEnviarClick(Sender);
   end
   else
      mmoMensagem.WantReturns := True;
end;

procedure TfrmMessenger.SalvarLog2Click(Sender: TObject);
begin
  inherited;
   if SaveDialogSalvar.Execute then
      mmoLogMessenger.Lines.SaveToFile(SaveDialogSalvar.FileName + '.txt');
end;

procedure TfrmMessenger.btnLimparHistoricoClick(Sender: TObject);
begin
  inherited;
   mmoLogMessenger.Clear;
end;

procedure TfrmMessenger.teste11Click(Sender: TObject);
begin
  inherited;
   if OpenDialogCarregar.Execute then
   begin
      LimparLog1Click(Sender);

      mmoLogMessenger.Lines.LoadFromFile(OpenDialogCarregar.FileName);
   end;
end;

end.
