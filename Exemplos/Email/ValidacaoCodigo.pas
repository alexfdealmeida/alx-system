unit ValidacaoCodigo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mestre, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, DBCtrls, DB,
  Mask, SqlExpr, DPrincipal, Funcoes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdHTTP, IdUDPBase, IdUDPClient, IdFSP,
  IdAttachmentFile, IdIMAP4, IdMessage;

type
  TFValidacaoCodigo = class(TFMestre)
    pnlManutencao: TPanel;
    pnlOpcoes: TPanel;
    btnConfirma: TBitBtn;
    btnSair: TBitBtn;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dtsValidacao: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    edtCODI_DES: TDBEdit;
    edtNOME_DES: TDBEdit;
    edtEMAI_DES: TDBEdit;
    Label8: TLabel;
    DBMemo1: TDBMemo;
    btnCODI_DES: TSpeedButton;
    DBEdit8: TDBCheckBox;
    DBEdit9: TDBCheckBox;
    DBEdit10: TDBCheckBox;
    DBEdit11: TDBCheckBox;
    cbxSITU_VAL: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    BitBtn1: TBitBtn;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCODI_DESClick(Sender: TObject);
    procedure edtCODI_DESKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCODI_DESExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FResultado: TModalResult;
    procedure ChamaPesquisa(PTabela: Integer);
    function Valida(PCampo: Integer): Boolean;
    function EnviaEmail: Boolean;
    function ValidaDesenvolvedor(pCodigo: Integer; var pDescricao, pEmail: String; pRequerido: Boolean = True): Boolean;
  public
    { Public declarations }
  end;

var
  FValidacaoCodigo: TFValidacaoCodigo;

implementation

uses PadraoPesquisa;

{$R *.dfm}

procedure TFValidacaoCodigo.BitBtn1Click(Sender: TObject);
var
 LTexto: String;
begin
  inherited;

   LTexto := 'Deseja enviar Email ao desenvolvedor '+
             dtsValidacao.DataSet.FieldByName('NOME_DES').AsString +
             ' avisando que sua revision ';

   if cbxSITU_VAL.Field.AsInteger = 0 then
   begin
      LTexto := LTexto + 'foi validado com sucesso?';
   end
   else
   begin
      LTexto := LTexto + 'não foi validado?';
   end;

   if (MessageDlg(LTexto, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
   begin
      if EnviaEmail then
      begin
         if dtsValidacao.DataSet.FieldByName('EMAI_VAL').AsInteger = 1 then
         begin
            dtsValidacao.DataSet.Edit;
            dtsValidacao.DataSet.FieldByName('EMAI_VAL').AsInteger := 0;
            dtsValidacao.DataSet.Post;
         end;
      end;
   end;
end;

procedure TFValidacaoCodigo.btnCODI_DESClick(Sender: TObject);
begin
  inherited;
   ChamaPesquisa(01);
end;

procedure TFValidacaoCodigo.btnConfirmaClick(Sender: TObject);
var
 LTexto: String;
begin
  inherited;

   LTexto := 'Deseja enviar Email ao desenvolvedor '+
             dtsValidacao.DataSet.FieldByName('NOME_DES').AsString +
             ' avisando que sua revision ';

   if cbxSITU_VAL.Field.AsInteger = 0 then
   begin
      LTexto := LTexto + 'foi validado com sucesso?';
   end
   else
   begin
      LTexto := LTexto + 'não foi validado?';
   end;

   if not Valida(01) then
   begin
      Abort;
   end;

   if dtsValidacao.DataSet.FieldByName('EMAI_VAL').AsInteger <> 0 then
   begin
      dtsValidacao.DataSet.FieldByName('EMAI_VAL').AsInteger := 1;
      if (MessageDlg(LTexto, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
         if EnviaEmail then
         begin
            dtsValidacao.DataSet.FieldByName('EMAI_VAL').AsInteger := 0;
         end;
      end;
   end;

   dtsValidacao.DataSet.Post;


   FResultado := mrOk;
   Close;
end;

procedure TFValidacaoCodigo.btnSairClick(Sender: TObject);
begin
  inherited;
   Close;
end;

procedure TFValidacaoCodigo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   if FResultado <> mrOk then
   begin
      dtsValidacao.DataSet.Cancel;
   end;
end;

procedure TFValidacaoCodigo.FormCreate(Sender: TObject);
begin
  inherited;
   FResultado := mrCancel;
end;

procedure TFValidacaoCodigo.ChamaPesquisa(PTabela: Integer);
begin

   case PTabela of
    01:
    begin
       FPadraoPesquisa := TFPadraoPesquisa.Create(Application);
       FPadraoPesquisa.DefineBusca('DESENVOLVEDOR');
       FPadraoPesquisa.ShowModal;

       edtCODI_DES.Text := DmPrincipal.vRetornoPesquisa;
    end;
   end;
end;

procedure TFValidacaoCodigo.edtCODI_DESExit(Sender: TObject);
begin
  inherited;
   if not VerFocus(edtCODI_DES) then
   begin
      Valida(01);
   end;   
end;

procedure TFValidacaoCodigo.edtCODI_DESKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if key = vk_F2 then
   begin
      btnCODI_DESClick(Sender);
   end;
end;

function TFValidacaoCodigo.ValidaDesenvolvedor(pCodigo: Integer; var pDescricao, pEmail: String;
  pRequerido: Boolean = True): Boolean;
var
 LSqlQuery: TSqlQuery;
begin

   Result := True;
   pDescricao := '';
   pEmail := '';

   if (pRequerido) and (pCodigo = 0) then
   begin
      MessageDlg('Informe o código do desenvolvedor!', mtInformation, [mbOK], 0);
      Result := False;
      Exit;
   end

   else
   if pCodigo = 0 then
      Exit;

   LSQLQuery := TSqlQuery.Create(Application);
   try
     LSQLQuery.SQLConnection := DmPrincipal.sqcPrincipal;

     LSQLQuery.Close;
     LSQLQuery.SQL.Clear;
     LSQLQuery.SQL.Add('select * from DESENVOLVEDOR where CODI_DES = '+ IntToStr(pCodigo));
     LSQLQuery.Open;

     if LSQLQuery.IsEmpty then
     begin
        MessageDlg('Código do Desenvolvedor não é válido!', mtInformation, [mbOK], 0);
        Result := False;
        Exit;
     end;

     pDescricao := LSQLQuery.FieldByName('NOME_DES').AsString;
     pEmail     := LSQLQuery.FieldByName('EMAI_DES').AsString;

   finally
     FreeAndNil(LSQLQuery);
   end;
end;

function TFValidacaoCodigo.Valida(PCampo: Integer): Boolean;
var
  LNome, LEmail: String;
begin
   Result := True;
   inherited;

   case PCampo of
    01:
    begin
       if not ValidaDesenvolvedor(edtCODI_DES.Field.AsInteger, LNome, LEmail) then
       begin
          Result := False;
          Exit;
       end;

       edtNOME_DES.Field.AsString := LNome;
       edtEMAI_DES.Field.AsString := LEmail;
    end;
   end;
end;

function TFValidacaoCodigo.EnviaEmail: Boolean;
var
   SMTP     : TIdSMTP;
   Body     : TIdMessage;
   LTexto, LCorpoMensagem : String;
   Index    : Integer;
   FTentativas : Integer;

  function Email: Boolean;
  begin
     Result := True;

     try
        if SMTP.Connected then
           SMTP.Disconnect;

        SMTP.Connect;
        SMTP.Authenticate;
        SMTP.Send(Body);
        SMTP.Disconnect;

     except
     begin
        Result := False;
        exit;
     end;
     end;

  end;

begin

   DmPrincipal.sqqEmailValidacao.Close;
   DmPrincipal.sqqEmailValidacao.Open;


   Result := True;

   SMTP:=TIdSMTP.Create(Self);
   Body:=TIdMessage.Create(Self);

   try

      SMTP.Host := DmPrincipal.sqqEmailValidacaoHOST_EVA.AsString;
      SMTP.Port := 25;
      SMTP.Username := DmPrincipal.sqqEmailValidacaoUSUA_EVA.AsString;
      SMTP.Password := DmPrincipal.sqqEmailValidacaoSENH_EVA.AsString;

      Body.Clear;
      Body.From.Address := DmPrincipal.sqqEmailValidacaoUSUA_EVA.AsString;

      {Destinatário}
      Body.Recipients.EMailAddresses := LowerCase(dtsValidacao.DataSet.FieldByName('EMAI_DES').AsString);

      if Trim(DmPrincipal.sqqEmailValidacaoEMA1_EVA.AsString) <> '' then
      begin
         Body.CCList.Add.Address := DmPrincipal.sqqEmailValidacaoEMA1_EVA.AsString;
      end;

      if Trim(DmPrincipal.sqqEmailValidacaoEMA2_EVA.AsString) <> '' then
      begin
         Body.CCList.Add.Address := DmPrincipal.sqqEmailValidacaoEMA2_EVA.AsString;
      end;

      if Trim(DmPrincipal.sqqEmailValidacaoEMA3_EVA.AsString) <> '' then
      begin
         Body.CCList.Add.Address := DmPrincipal.sqqEmailValidacaoEMA3_EVA.AsString;
      end;

      if Trim(DmPrincipal.sqqEmailValidacaoEMA4_EVA.AsString) <> '' then
      begin
         Body.CCList.Add.Address := DmPrincipal.sqqEmailValidacaoEMA4_EVA.AsString;
      end;

      if dtsValidacao.DataSet.FieldByName('SITU_VAL').AsInteger = 0 then
      begin
         LTexto := 'VALIDADO COM SUCESSO - (GARANTIA QUALIDADE DE SOFTWARE) ';
      end
      else
      begin
         LTexto := 'Verificar possiveis problemas na revision  - (GARANTIA QUALIDADE DE SOFTWARE) ';
      end;

      LCorpoMensagem := 'Ticket nº '+
                        Trim(dtsValidacao.DataSet.FieldByName('CODI_TIC').AsString) + ' ' +
                        'Revision '+
                        Trim(dtsValidacao.DataSet.FieldByName('REVISION').AsString);

      LTexto := LTexto + LCorpoMensagem;

      Body.Subject := LTexto;

      //TIdAttachmentFile.Create(Body.MessageParts, );

      LCorpoMensagem := LCorpoMensagem +#10+#13 +#10+#13 +#10+#13+
                        'A(o) Desenvolvedor(a) '+
                        dtsValidacao.DataSet.FieldByName('NOME_DES').AsString +#10+#13 +#10+#13;

      if dtsValidacao.DataSet.FieldByName('SITU_VAL').AsInteger = 1 then
      begin
         LCorpoMensagem := LCorpoMensagem +
                           '  Favor verificar as informações citadas no email e caso '+
                           'exista alguma sugestão de melhoria, favor realiza-la o mais '+
                           'breve possivel. Lembrando que é de responsabilidade do(a) '+
                           'Desenvolvedor(a), realizar o possivel acerto e enviar um email '+
                           'contendo informações do Ticket e Revision para o grupo '+
                           'GARANTIA QUALIDADE DE SOFTWARE estar validando novamente.';
      end
      else
      begin
         LCorpoMensagem := LCorpoMensagem +
                           '  Ticket validado com sucesso, dentro dos padrões estabelecidos.';
      end;

      if Trim(dtsValidacao.DataSet.FieldByName('DESC_VAL').AsString) <> ''then
      begin
         LCorpoMensagem :=  LCorpoMensagem +#10+#13+ #10+#13+#10+#13+
                            Trim(dtsValidacao.DataSet.FieldByName('DESC_VAL').AsString)+#10+#13+#10+#13;
      end;

      LCorpoMensagem := LCorpoMensagem +#10+#13+
                        'Grupo GARANTIA QUALIDADE DE SOFTWARE'+#10+#13+
                        'Muller Antunes Santos' +#10+#13+
                        'Desenvolvedor de Sistemas';

      Body.Body.Add(LCorpoMensagem);

      SMTP.AuthType := atDefault;

      FTentativas := 0;
      while True do
      begin
         Inc(FTentativas);
         if not Email then
         begin
            if FTentativas > 3 then
            begin
               if (MessageDlg('O sistema realizou 3 tentativas de envio do email, para o email '+
                              Body.Recipients.EMailAddresses +
                              ' sem sucesso!'+ ^M +
                              ' Deseja tentar enviar novamente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
                  FTentativas := 0
               else
               begin
                  Result := False;
                  Break;
               end;
            end;
         end
         else
            Break;
      end;

   finally
      FreeAndNil( Body );
      FreeAndNil( SMTP );
   end;
end;

end.
