unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExStdCtrls, JvButton, JvCtrls, StdCtrls, Buttons, JvExControls,
  JvAnimatedImage, JvGIFCtrl, ExtCtrls, ComCtrls, DBXpress, ImgList, ActnList,
  JvExExtCtrls, JvSecretPanel, SqlExpr, Registry, JvJCLUtils;

type
  TTipoBtn = (tbSair, tbCancelar);

  TfrmPrincipal = class(TForm)
    pnlBotoes: TPanel;
    JvGIFAnimatorProgresso: TJvGIFAnimator;
    btnIniciar: TBitBtn;
    btnSair: TJvImgBtn;
    ImageListImagens: TImageList;
    actLstAtualiza: TActionList;
    actAtualiza: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure actAtualizaExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FExecutar: Boolean;
    FCancelar: Boolean;
    FTransaction: TTransactionDesc;
    procedure AjustarEstrutura(AOldVersion: integer);
    procedure AjustarDados(AOldVersion: integer);
    procedure SetarValorPadraoParametros(ACampo, AValor: string); overload;
    procedure SetarValorPadraoParametros(ACampo, AValor, ACODI_USU: string); overload;
    procedure SetarValorPadraoParametros(ACampo: string; AValor: Integer); overload;
    procedure ExecutaComandos(AInstrucao: String);
    procedure AlterarImgBtn(ATipoBtn: TTipoBtn = tbSair);
  public
    { Public declarations }
    property Executar: Boolean read FExecutar write FExecutar;
    property Cancelar: Boolean read FCancelar write FCancelar;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses DPrincipal, ALXCompilerFuncoesDB, ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmPrincipal.actAtualizaExecute(Sender: TObject);
begin
   { Favor não remover este comentário }
end;

procedure TfrmPrincipal.AjustarDados(AOldVersion: integer);
var
   lCountPath,
   lIndex: Integer;
   lSQL,
   lNOME_USU,
   lLOGI_USU,
   lSENH_USU,
   lSearchPath,
   lRegistroDelphi: string;
   lsqqAjustaDados: TSQLQuery;
   lReg : TRegistry;
begin

   lsqqAjustaDados := TSQLQuery.Create(Self);

   try
      lsqqAjustaDados.SQLConnection := dmPrincipal.sqcCompilador;
      //SetarValorPadraoParametros('MULT_CFG', 'N');
      //SetarValorPadraoParametros('EMAC_CFG', 'N');
      //SetarValorPadraoParametros('EXEC_CFG', 'N');
      //SetarValorPadraoParametros('ALLC_CFG', 'S');
      //SetarValorPadraoParametros('ALER_CFG', 'N');
      //SetarValorPadraoParametros('IDEX_CFG', 'N');
      //SetarValorPadraoParametros('GLNK_CFG', 'N');
      SetarValorPadraoParametros('AGMS_CFG', 'NO');
      SetarValorPadraoParametros('CORM_CFG', 15);
      SetarValorPadraoParametros('CORF_CFG', 0);
      //SetarValorPadraoParametros('APAG_CFG', 'S');
      //SetarValorPadraoParametros('UPDG_CFG', 'N');
      //SetarValorPadraoParametros('SWIT_CFG', 'S');
      //SetarValorPadraoParametros('UPDC_CFG', 'N');
      //SetarValorPadraoParametros('TPAR_CFG', 'N');
      SetarValorPadraoParametros('DRLC_CFG', '12/30/1899');
      SetarValorPadraoParametros('DBLC_CFG', '12/30/1899');
      SetarValorPadraoParametros('EXLC_CFG', 0);

      if ParamStr(2) <> '' then
      begin
         SetarValorPadraoParametros('IPRD_CFG', TALXFuncoes.RetornaIP, ParamStr(2));
      end;

      if (AOldVersion < 4002) then
      begin
         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
         lsqqAjustaDados.SQL.Add('select CODI_USU, ' +
                           '       NOME_USU, ' +
                           '       LOGI_USU ' +
                           'from USUARIO ' +
                           'order by CODI_USU');
         lsqqAjustaDados.Open;

         lsqqAjustaDados.First;
         while not lsqqAjustaDados.Eof do
         begin
            ExecutaComandos('update USUARIO ' +
                            'set NOME_USU = ' + QuotedStr(TALXFuncoes.Criptografa(lsqqAjustaDados.FieldByName('NOME_USU').AsString)) + ', ' +
                            '    LOGI_USU = ' + QuotedStr(TALXFuncoes.Criptografa(lsqqAjustaDados.FieldByName('LOGI_USU').AsString)) + ' ' +
                            'where (CODI_USU = ' + lsqqAjustaDados.FieldByName('CODI_USU').AsString + ')');

            lsqqAjustaDados.Next;
         end;

         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
      end;

      if (AOldVersion < 4900) then
      begin
         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
         lsqqAjustaDados.SQL.Add('select CODI_VER, ' +
                           '       CODI_USU, ' +
                           '       SITU_VER ' +
                           'from VERSAO');
         lsqqAjustaDados.Open;

         lsqqAjustaDados.First;
         while not lsqqAjustaDados.Eof do
         begin
            if lsqqAjustaDados.FieldByName('SITU_VER').AsString = 'N' then
            begin
               ExecutaComandos('update VERSAO set SITU_VER = ''S'' where CODI_VER = ' + lsqqAjustaDados.FieldByName('CODI_VER').AsString +
                               ' and CODI_USU = ' + lsqqAjustaDados.FieldByName('CODI_USU').AsString);
            end
            else
            begin
               ExecutaComandos('update VERSAO set SITU_VER = ''N'' where CODI_VER = ' + lsqqAjustaDados.FieldByName('CODI_VER').AsString +
                               ' and CODI_USU = ' + lsqqAjustaDados.FieldByName('CODI_USU').AsString);
            end;

            lsqqAjustaDados.Next;
         end;

         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
      end;

      if (AOldVersion < 6100) then
      begin
         ExecutaComandos('update VERSAO set GVPD_VER = ''SVN'' where (GVPD_VER is null)');
      end;

      if (AOldVersion < 6500) then
      begin
         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
         lsqqAjustaDados.SQL.Add('select CODI_USU, ' +
                           '       NOME_USU, ' +
                           '       LOGI_USU, ' +
                           '       SENH_USU ' +
                           'from USUARIO ' +
                           'order by CODI_USU');
         lsqqAjustaDados.Open;

         lsqqAjustaDados.First;
         while not lsqqAjustaDados.Eof do
         begin
            lNOME_USU := TALXFuncoes.Descriptografa(lsqqAjustaDados.FieldByName('NOME_USU').AsString);
            lLOGI_USU := TALXFuncoes.Descriptografa(lsqqAjustaDados.FieldByName('LOGI_USU').AsString);
            lSENH_USU := TALXFuncoes.Descriptografa(lsqqAjustaDados.FieldByName('SENH_USU').AsString);

            lSQL := '';

            lSQL := lSQL + 'update USUARIO ';
            lSQL := lSQL + 'set NOME_USU = ' + QuotedStr(lNOME_USU) + ', ';
            lSQL := lSQL + '    LOGI_USU = ' + QuotedStr(lLOGI_USU) + ', ';
            lSQL := lSQL + '    SENH_USU = ' + QuotedStr(lSENH_USU) + ' ';
            lSQL := lSQL + 'where (CODI_USU = ' + lsqqAjustaDados.FieldByName('CODI_USU').AsString + ')';

            ExecutaComandos(lSQL);

            lsqqAjustaDados.Next;
         end;

         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
      end;

      if (AOldVersion < 7011) then
      begin
         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
         lsqqAjustaDados.SQL.Add('update VERSAO ' +
                                 'set DELP_VER = ''D10'' ' +
                                 'where (DELP_VER is null)');
         lsqqAjustaDados.ExecSQL(True);

         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
      end;

      //Copiar informações do library path do Delphi

      if ParamStr(2) <> '' then
      begin
         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
         lsqqAjustaDados.SQL.Add('select count(LIB.CODI_LIB) as QTD ' +
                                 'from LIBRARY LIB ' +
                                 'where (LIB.CODI_USU = ' + ParamStr(2) + ')');
         lsqqAjustaDados.Open;

         if (lsqqAjustaDados.FieldByName('QTD').AsInteger = 0) then
         begin
            lsqqAjustaDados.Close;
            lsqqAjustaDados.SQL.Clear;
            lsqqAjustaDados.SQL.Add('select VER.CODI_USU, ' +
                                    '       VER.CODI_VER, ' +
                                    '       VER.DELP_VER ' +
                                    'from VERSAO VER ' +
                                    'where (VER.CODI_USU = ' + ParamStr(2) + ')');
            lsqqAjustaDados.Open;

            lsqqAjustaDados.First;
            while not lsqqAjustaDados.Eof do
            begin
               lCountPath := 0;

               lReg := TRegistry.Create;

               try

                  lReg.RootKey := HKEY_CURRENT_USER;

                  if lsqqAjustaDados.FieldByName('DELP_VER').AsString = 'D07' then
                  begin
                     lRegistroDelphi := LIBRARY_PATH_DELPHI_7;
                  end
                  else if lsqqAjustaDados.FieldByName('DELP_VER').AsString = 'D10' then
                  begin
                     lRegistroDelphi := LIBRARY_PATH_DELPHI_2006;
                  end;

                  if (lReg.OpenKey(lRegistroDelphi, False)) then
                  begin
                     lSearchPath := lReg.ReadString('Search Path');

                     for lIndex := 1 to Length(lSearchPath) do
                     begin
                        if lSearchPath[lIndex] = ';' then
                        begin
                           Inc(lCountPath, 1);
                        end;
                     end;

                     if lCountPath > 0 then
                     begin
                        Inc(lCountPath, 1);
                     end;
                     

                     lReg.CloseKey;
                  end;


               finally
                  lReg.Free;
               end;

               for lIndex := 1 to lCountPath do
               begin
                  ExecutaComandos('insert into LIBRARY (CODI_LIB, CODI_VER, CODI_USU, INDI_LIB, DESC_LIB) ' +
                                  ' values ( ' +
                                  'null' + ', ' +
                                  lsqqAjustaDados.FieldByName('CODI_VER').AsString + ', ' +
                                  lsqqAjustaDados.FieldByName('CODI_USU').AsString + ', ' +
                                  IntToStr(lIndex) + ', ' +
                                  QuotedStr(ExtractDelimited(lIndex, lSearchPath, [';'])) + ')');

               end;

               lsqqAjustaDados.Next;
            end;
         end;

         lsqqAjustaDados.Close;
         lsqqAjustaDados.SQL.Clear;
      end;

   finally
      FreeAndNil(lsqqAjustaDados);
   end;
end;

procedure TfrmPrincipal.AjustarEstrutura(AOldVersion: integer);
begin
   if AOldVersion < 1000 then
   begin
      ExecutaComandos('CREATE DOMAIN D_VARCHAR_4 AS ' +
                      'VARCHAR(4)');

      {ExecutaComandos('CREATE TABLE CONFIG ( ' +
                      'VERS_CFG D_VARCHAR_4)');}

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD DGER_VER D_VARCHAR_100 ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD DREV_VER D_VARCHAR_100 ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');
   end;

   if AOldVersion < 1001  then
   begin
      ExecutaComandos('ALTER TABLE VERSAO ' +
                     'ADD DCFG_VER D_VARCHAR_100 ' +
                     'COLLATE WIN1252');

      ExecutaComandos('CREATE TABLE BASES ( ' +
                      'CODI_BAS D_INTEGER NOT NULL, ' +
                      'TIPO_BAS D_CHAR_02 NOT NULL, ' +
                      'DIRE_BAS D_VARCHAR_100 NOT NULL, ' +
                      'DESC_BAS D_VARCHAR_50 NOT NULL)');

      ExecutaComandos('alter table BASES ' +
                      'add constraint PK_BASES ' +
                      'primary key (CODI_BAS)');

      ExecutaComandos('CREATE GENERATOR GEN_BASES_ID');

      ExecutaComandos('CREATE TRIGGER BASES_BI FOR BASES ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN ' +
                      '  IF (NEW.CODI_BAS IS NULL) THEN ' +
                      '    NEW.CODI_BAS = GEN_ID(GEN_BASES_ID,1); ' +
                      'END');
   end;

   if AOldVersion < 1002 then
   begin
      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''DGER_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''DFON_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');
   end;

   if AOldVersion < 1003 then
   begin
      ExecutaComandos('CREATE DOMAIN D_CHAR_1 AS ' +
                      'CHAR(1) ' +
                      'DEFAULT ''N''');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD IAUT_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 1004) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD UVER_CFG D_VARCHAR_15 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 1005) then
   begin
      {ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD DEXF_VER D_VARCHAR_100 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1006) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD ERES_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}

      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TRES_CFG D_CHAR_02 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1007) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD AERC_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}

      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD GINI_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1009) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD EMAC_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 1100) then
   begin
      ExecutaComandos('CREATE DOMAIN D_DATETIME AS ' +
                      'TIMESTAMP;');

      ExecutaComandos('ALTER TABLE MODULO '+
                      'ADD DATE_MOD D_DATETIME');

      ExecutaComandos('CREATE DOMAIN D_CHARS_1 AS ' +
                      'CHAR(1) ' +
                      'DEFAULT ''S''');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD SITU_VER D_CHARS_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 1101) then
   begin
      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''DEXE_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''DZIP_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');

      {ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''HEAD_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');}

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''DREV_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');
   end;

   if (AOldVersion < 1102) then
   begin
      {ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD SHOS_VER D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD SUSE_VER D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD SPAS_VER D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD SDIR_VER D_VARCHAR_100 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD FHOS_VER D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD FUSE_VER D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD FPAS_VER D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD FDIR_VER D_VARCHAR_100 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1103) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TRAY_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1104) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TUPD_CFG D_CHAR_02 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1105) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD VERS_VER D_VARCHAR_15 ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 1106) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD SERV_CFG D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 1107) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD DEVI_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1108) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD AGEN_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 1109) then
   begin
      ExecutaComandos('ALTER TABLE BASES ' +
                      'ADD SNAM_BAS D_VARCHAR_15 ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE BASES ' +
                      'ADD SERV_BAS D_VARCHAR_15 ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE BASES ' +
                      'ADD PORT_BAS D_INTEGER ' +
                      'NOT NULL');

      ExecutaComandos('ALTER TABLE MODULO ' +
                      'ADD COMP_MOD D_INTEGER');
   end;

   if (AOldVersion < 2000) then
   begin
      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = NULL ' +
                      'where (RDB$FIELD_NAME = ''SNAM_BAS'') and ' +
                      '(RDB$RELATION_NAME = ''BASES'')');
   end;

   if (AOldVersion < 2001) and (AOldVersion >= 1108) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP AGEN_CFG');
   end;

   {if (AOldVersion < 2002) and (AOldVersion >= 1104) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP TUPD_CFG');
   end;}

   if (AOldVersion < 2003) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD AGMS_CFG D_CHAR_02 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 2004) and (AOldVersion >= 1006) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP ERES_CFG');

      ExecutaComandos('ALTER TABLE CONFIG DROP TRES_CFG');
   end;

   if (AOldVersion < 3000) and (AOldVersion >= 1102) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO DROP SHOS_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP SUSE_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP SPAS_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP SDIR_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP FHOS_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP FUSE_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP FPAS_VER');

      ExecutaComandos('ALTER TABLE VERSAO DROP FDIR_VER');
   end;

   if (AOldVersion < 3001) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD PERI_CFG D_INTEGER');}

      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD USVN_CFG D_VARCHAR_50 ' +
                      'COLLATE WIN1252')};
   end;

   if (AOldVersion < 4000) then
   begin
      ExecutaComandos('CREATE TABLE USUARIO ( ' +
                      '    CODI_USU D_INTEGER NOT NULL, ' +
                      '    NOME_USU D_VARCHAR_100 NOT NULL, ' +
                      '    LOGI_USU D_VARCHAR_50 NOT NULL, ' +
                      '    SENH_USU D_VARCHAR_50 NOT NULL)');

      ExecutaComandos('alter table USUARIO ' +
                      'add constraint PK_USUARIO ' +
                      'primary key (CODI_USU)');

      ExecutaComandos('CREATE SEQUENCE GEN_USUARIO_ID');

      ExecutaComandos('CREATE TRIGGER USUARIO_BI FOR USUARIO ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN ' +
                      '  IF (NEW.CODI_USU IS NULL) THEN ' +
                      '    NEW.CODI_USU = GEN_ID(GEN_USUARIO_ID,1); ' +
                      'END');

      ExecutaComandos('ALTER TABLE BASES ' +
                      'ADD CODI_USU D_INTEGER');

      ExecutaComandos('alter table BASES ' +
                      'add constraint FK_BASES_RLC_USUARIO ' +
                      'foreign key (CODI_USU) ' +
                      'references USUARIO(CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_BASES_RLC_USUARIO');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD CODI_USU D_INTEGER');

      ExecutaComandos('alter table CONFIG ' +
                      'add constraint FK_CONFIG_RLC_USUARIO ' +
                      'foreign key (CODI_USU) ' +
                      'references USUARIO(CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_CONFIG_RLC_USUARIO');

      ExecutaComandos('ALTER TABLE MODULO ' +
                      'ADD CODI_USU D_INTEGER');

      ExecutaComandos('alter table MODULO ' +
                      'add constraint FK_MODULO_RLC_USUARIO ' +
                      'foreign key (CODI_USU) ' +
                      'references USUARIO(CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_MODULO_RLC_USUARIO');

      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD CODI_USU D_INTEGER');

      ExecutaComandos('alter table VERSAO ' +
                      'add constraint FK_VERSAO_RLC_USUARIO ' +
                      'foreign key (CODI_USU) ' +
                      'references USUARIO(CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_VERSAO_RLC_USUARIO');
   end;

   if (AOldVersion < 4001) then
   begin
      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = 1 ' +
                      'where (RDB$FIELD_NAME = ''CODI_USU'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('alter table CONFIG ' +
                      'add constraint PK_CONFIG ' +
                      'primary key (CODI_USU) ' +
                      'using index PK_CONFIG');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = 1 ' +
                      'where (RDB$FIELD_NAME = ''CODI_USU'') and ' +
                      '(RDB$RELATION_NAME = ''BASES'')');

      ExecutaComandos('ALTER TABLE BASES DROP CONSTRAINT PK_BASES');

      ExecutaComandos('alter table BASES ' +
                      'add constraint PK_BASES ' +
                      'primary key (CODI_BAS,CODI_USU) ' +
                      'using index PK_BASES');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = 1 ' +
                      'where (RDB$FIELD_NAME = ''CODI_USU'') and ' +
                      '(RDB$RELATION_NAME = ''MODULO'')');

      ExecutaComandos('ALTER TABLE MODULO DROP CONSTRAINT PK_MODULO');

      ExecutaComandos('alter table MODULO ' +
                      'add constraint PK_MODULO ' +
                      'primary key (CODI_MOD,CODI_USU) ' +
                      'using index PK_MODULO');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$NULL_FLAG = 1 ' +
                      'where (RDB$FIELD_NAME = ''CODI_USU'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');

      ExecutaComandos('ALTER TABLE VERSAO DROP CONSTRAINT PK_VERSAO');

      ExecutaComandos('alter table VERSAO ' +
                      'add constraint PK_VERSAO ' +
                      'primary key (CODI_VER,CODI_USU) ' +
                      'using index PK_VERSAO');
   end;

   if (AOldVersion < 4003) and (AOldVersion >= 1007) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP AERC_CFG');
   end;

   if (AOldVersion < 4004) then
   begin
      ExecutaComandos('CREATE TABLE INFODB ( ' +
                      '    VERS_INF D_VARCHAR_4)');
   end;

   if (AOldVersion < 4005) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD CORM_CFG D_INTEGER');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD CORF_CFG D_INTEGER');
   end;

   if (AOldVersion < 4006) then
   begin
      {ExecutaComandos('ALTER TABLE USUARIO ' +
                      'ADD IPRD_USU D_VARCHAR_50 ' +
                      'COLLATE WIN1252 ');}
   end;

   if (AOldVersion < 4007) then
   begin
      {ExecutaComandos('ALTER TABLE USUARIO ' +
                      'ADD APEL_USU D_VARCHAR_50 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 4100) then
   begin
      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_VARCHAR_50'' ' +
                      'where (RDB$FIELD_NAME = ''DESC_VER'') and ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');
   end;

   if (AOldVersion < 4200) then
   begin
      ExecutaComandos('CREATE DOMAIN D_DATE AS ' +
                      'DATE');

      ExecutaComandos('CREATE DOMAIN D_TIME AS ' +
                      'TIME');

      {ExecutaComandos('CREATE TABLE "COMPAUTO" ( ' +
                      '    CODI_AUT D_INTEGER NOT NULL, ' +
                      '    DESC_AUT D_VARCHAR_50 NOT NULL, ' +
                      '    SITU_AUT D_CHARS_1 NOT NULL, ' +
                      '    SEGU_AUT D_CHAR_1, ' +
                      '    TERC_AUT D_CHAR_1, ' +
                      '    QUAR_AUT D_CHAR_1, ' +
                      '    QUIN_AUT D_CHAR_1, ' +
                      '    SEXT_AUT D_CHAR_1, ' +
                      '    SABA_AUT D_CHAR_1, ' +
                      '    DOMI_AUT D_CHAR_1, ' +
                      '    HORA_AUT D_TIME, ' +
                      '    CODI_USU D_INTEGER NOT NULL, ' +
                      '    CODI_VER D_INTEGER NOT NULL)');

      ExecutaComandos('alter table "COMPAUTO" ' +
                      'add constraint PK_COMPAUTO ' +
                      'primary key (CODI_AUT)');

      ExecutaComandos('alter table "COMPAUTO" ' +
                      'add constraint FK_COMPAUTO_RLC_VERSAO ' +
                      'foreign key (CODI_VER,CODI_USU) ' +
                      'references VERSAO(CODI_VER,CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE');

      ExecutaComandos('CREATE GENERATOR GEN_COMPAUTO_ID');

      ExecutaComandos('CREATE TRIGGER COMPAUTO_BI FOR "COMPAUTO" ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN ' +
                      '  IF (NEW.CODI_AUT IS NULL) THEN ' +
                      '    NEW.CODI_AUT = GEN_ID(GEN_COMPAUTO_ID,1); ' +
                      'END');}
   end;

   if (AOldVersion < 4300) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD UPDC_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 4400) then
   begin
      ExecutaComandos('ALTER TABLE MODULO ' +
                      'ADD LAST_MOD D_CHAR_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD EXEC_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD ALER_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 4500) and (AOldVersion >= 1103) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP TRAY_CFG');
   end;

   if (AOldVersion < 4500) and (AOldVersion >= 3001) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP PERI_CFG');

      ExecutaComandos('ALTER TABLE CONFIG DROP USVN_CFG');
   end;

   if (AOldVersion < 4600) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD APAG_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 4700) then
   begin
      ExecutaComandos('CREATE TABLE DIRETIVA ( ' +
                      '    CODI_DTV D_INTEGER NOT NULL, ' +
                      '    CODI_USU D_INTEGER NOT NULL, ' +
                      '    DIRE_DTV D_VARCHAR_50 NOT NULL, ' +
                      '    DESC_DTV D_VARCHAR_100 NOT NULL, ' +
                      '    GLOB_DTV D_CHAR_1, ' +
                      '    SITU_DTV D_CHARS_1)');

      ExecutaComandos('alter table DIRETIVA ' +
                      'add constraint PK_DIRETIVA ' +
                      'primary key (CODI_DTV,CODI_USU) ' +
                      'using index PK_DIRETIVA');

      ExecutaComandos('alter table DIRETIVA ' +
                      'add constraint FK_DIRETIVA_RLC_USUARIO ' +
                      'foreign key (CODI_USU) ' +
                      'references USUARIO(CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_DIRETIVA_RLC_USUARIO');

      ExecutaComandos('CREATE SEQUENCE GEN_DIRETIVA_ID');

      ExecutaComandos('CREATE TRIGGER DIRETIVA_BI FOR DIRETIVA ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN ' +
                      '  IF (NEW.CODI_DTV IS NULL) THEN ' +
                      '    NEW.CODI_DTV = GEN_ID(GEN_DIRETIVA_ID,1); ' +
                      'END');
   end;

   if (AOldVersion < 4800) then
   begin
      ExecutaComandos('CREATE DOMAIN D_CHARN_1 AS ' +
                      'CHAR(1) ' +
                      'DEFAULT ''N'';');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''SITU_DTV'') and ' +
                      '(RDB$RELATION_NAME = ''DIRETIVA'')');
   end;

   if (AOldVersion < 4900) then
   begin
      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''SITU_VER'') and  ' +
                      '(RDB$RELATION_NAME = ''VERSAO'')');
   end;

   if (AOldVersion < 5000) then
   begin
      ExecutaComandos('CREATE ROLE SYSDBA');
   end;

   if (AOldVersion < 5001) and (AOldVersion >= 1005) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO DROP DEXF_VER');
   end;

   if (AOldVersion < 5002) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TSVN_CFG D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 5003) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD GVPD_CFG D_CHAR_02 ' +
                      'COLLATE WIN1252');}

      {ExecutaComandos('ALTER TABLE DIRETIVA ' +
                      'ADD DEXE_DTV D_VARCHAR_100 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE DIRETIVA ' +
                      'ADD DZIP_DTV D_VARCHAR_100 ' +
                      'COLLATE WIN1252');}
   end;

   {if (AOldVersion < '5004') then
   begin
      ExecutaComandos('CREATE TABLE DIRETORIO ( ' +
                      '    CODI_DIR D_INTEGER NOT NULL, ' +
                      '    CODI_VER D_INTEGER NOT NULL, ' +
                      '    CODI_USU D_INTEGER NOT NULL, ' +
                      '    DESC_DIR D_VARCHAR_50 NOT NULL, ' +
                      '    DIRE_DIR D_VARCHAR_100 NOT NULL, ' +
                      '    DZIP_DIR D_CHARN_1)');

      ExecutaComandos('alter table DIRETORIO ' +
                      'add constraint PK_DIRETORIO ' +
                      'primary key (CODI_DIR)');

      ExecutaComandos('CREATE SEQUENCE GEN_DIRETORIO_ID');

      ExecutaComandos('CREATE TRIGGER DIRETORIO_BI FOR DIRETORIO ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN ' +
                      '  IF (NEW.CODI_DIR IS NULL) THEN ' +
                      '    NEW.CODI_DIR = GEN_ID(GEN_DIRETORIO_ID,1); ' +
                      'END');

      ExecutaComandos('alter table DIRETORIO ' +
                      'add constraint FK_DIRETORIO_VERSAO ' +
                      'foreign key (CODI_VER,CODI_USU) ' +
                      'references VERSAO(CODI_VER,CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_DIRETORIO_VERSAO');
   end;}

   if (AOldVersion < 5004) and (AOldVersion >= 5003) then
   begin
      ExecutaComandos('ALTER TABLE DIRETIVA DROP DEXE_DTV');

      ExecutaComandos('ALTER TABLE DIRETIVA DROP DZIP_DTV');
   end;

   if (AOldVersion < 5006) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD MULT_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 5007) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD NLOG_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');}
   end;

   if (AOldVersion < 5008) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD IDEX_CFG D_CHARS_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 5009) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD COMP_VER D_CHARN_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 6000) then
   begin
      ExecutaComandos('ALTER TABLE MODULO ' +
                      'ADD AUTO_MOD D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE DIRETIVA ' +
                      'ADD AUTO_DTV D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('CREATE DOMAIN D_CHAR_03 AS ' +
                      'CHAR(3) CHARACTER SET WIN1252 ' +
                      'COLLATE WIN1252;');
   end;

   if (AOldVersion < 6100) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD GVPD_VER D_CHAR_03 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TGIT_CFG D_VARCHAR_100 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD SGIT_CFG D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 6200) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD UPDG_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD SWIT_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 6200) and (AOldVersion >= 5003) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP GVPD_CFG');
   end;

   if (AOldVersion < 6300) and (AOldVersion >= 1007) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP GINI_CFG');
   end;

   if (AOldVersion < 6400) then
   begin
      ExecutaComandos('CREATE TABLE LIBRARY ( ' +
                      '    CODI_LIB D_INTEGER NOT NULL, ' +
                      '    CODI_VER D_INTEGER NOT NULL, ' +
                      '    CODI_USU D_INTEGER NOT NULL, ' +
                      '    INDI_LIB D_INTEGER NOT NULL, ' +
                      '    DESC_LIB D_VARCHAR_100 NOT NULL)');

      ExecutaComandos('alter table LIBRARY ' +
                      'add constraint PK_LIBRARY ' +
                      'primary key (CODI_LIB)');

      ExecutaComandos('CREATE SEQUENCE GEN_LIBRARY_ID');

      ExecutaComandos('CREATE TRIGGER LIBRARY_BI FOR LIBRARY ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN  ' +
                      '  IF (NEW.CODI_LIB IS NULL) THEN ' +
                      '    NEW.CODI_LIB = GEN_ID(GEN_LIBRARY_ID,1); ' +
                      'END');

      ExecutaComandos('alter table LIBRARY ' +
                      'add constraint FK_LIBRARY_VERSAO ' +
                      'foreign key (CODI_VER,CODI_USU) ' +
                      'references VERSAO(CODI_VER,CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_LIBRARY_VERSAO');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD LIBR_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');

   end;

   if (AOldVersion < 6600) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD GLNK_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD LINK_CFG D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7000) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD DRLC_CFG D_DATE');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD DBLC_CFG D_DATE');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD EXLC_CFG D_INTEGER');

      ExecutaComandos('ALTER TABLE INFODB ' +
                      'ADD EMPR_INF D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7001) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD DTMP_VER D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7002) and (AOldVersion >= 5007) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP NLOG_CFG');
   end;

   if (AOldVersion < 7003) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD "SZIP_CFG" D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7004) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD ALLC_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7005) and (AOldVersion >= 5004) then
   begin
      ExecutaComandos('drop table DIRETORIO');

      ExecutaComandos('drop generator GEN_DIRETORIO_ID');
   end;

   if (AOldVersion < 7005) and (AOldVersion >= 4200) then
   begin
      ExecutaComandos('drop table COMPAUTO');

      ExecutaComandos('drop generator GEN_COMPAUTO_ID');
   end;

   if (AOldVersion < 7005) and (AOldVersion >= 4007) then
   begin
      ExecutaComandos('ALTER TABLE USUARIO DROP APEL_USU');
   end;

   if (AOldVersion < 7005) and (AOldVersion >= 4006) then
   begin
      ExecutaComandos('ALTER TABLE USUARIO DROP IPRD_USU');
   end;

   if (AOldVersion < 7005) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD IPRD_CFG D_VARCHAR_15 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE USUARIO ' +
                      'ADD ONLI_USU D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7006) then
   begin
      ExecutaComandos('ALTER TABLE MODULO ' +
                      'ADD DULT_MOD D_DATETIME');
   end;

   if (AOldVersion < 7007) then
   begin
      ExecutaComandos('ALTER TABLE MODULO ' +
                      'ADD VULT_MOD D_VARCHAR_100 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7008) then
   begin
      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TRSP_CFG D_INTEGER');}

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD TPAR_CFG D_CHAR_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7009) then
   begin
      ExecutaComandos('ALTER DOMAIN D_CHAR_1 ' +
                      'DROP DEFAULT');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''IDEX_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''MULT_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''EMAC_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''EXEC_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARS_1'' ' +
                      'where (RDB$FIELD_NAME = ''ALLC_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''ALER_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      {ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''DEVI_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');}

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARS_1'' ' +
                      'where (RDB$FIELD_NAME = ''APAG_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''UPDG_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARS_1'' ' +
                      'where (RDB$FIELD_NAME = ''SWIT_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''UPDC_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');

      ExecutaComandos('update RDB$RELATION_FIELDS set ' +
                      'RDB$FIELD_SOURCE = ''D_CHARN_1'' ' +
                      'where (RDB$FIELD_NAME = ''TPAR_CFG'') and ' +
                      '(RDB$RELATION_NAME = ''CONFIG'')');      

      ExecutaComandos('CREATE trigger USUARIO_AI0 for USUARIO ' +
                      'active after insert position 0 ' +
                      'AS ' +
                      'begin ' +
                      '  insert into CONFIG (CODI_USU) VALUES (NEW.CODI_USU); ' +
                      'end');

      ExecutaComandos('ALTER TABLE CONFIG DROP AUSU_CFG');
   end;

   if (AOldVersion < 7009) and (AOldVersion >= 1000) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP VERS_CFG');
   end;

   if (AOldVersion < 7009) and (AOldVersion >= 1104) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP TUPD_CFG');
   end;

   if (AOldVersion < 7010) and (AOldVersion >= 1107) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP DEVI_CFG');
   end;

   if (AOldVersion < 7010) and (AOldVersion >= 7008) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP TRSP_CFG');
   end;

   if (AOldVersion < 7011) then
   begin
      ExecutaComandos('ALTER TABLE VERSAO ' +
                      'ADD DELP_VER D_CHAR_03 ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7012) then
   begin
      ExecutaComandos('ALTER TABLE USUARIO ' +
                      'ADD ADMI_USU D_CHARN_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7013) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD HFTP_CFG D_VARCHAR_100 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD UFTP_CFG D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD SFTP_CFG D_VARCHAR_50 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD EFTP_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD CPYL_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD CPYR_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');

      {ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD LFTP_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');}

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD IVER_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD IPAR_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7014) and (AOldVersion >= 7013) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG DROP LFTP_CFG');
   end;

   if (AOldVersion < 7015) then
   begin
      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD AFTP_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');
   end;

   if (AOldVersion < 7025) then
   begin
      ExecutaComandos('CREATE TABLE REQUISICAO ( ' +
                      '    CODI_REQ D_INTEGER NOT NULL, ' +
                      '    CODI_USU D_INTEGER NOT NULL, ' +
                      '    BRAN_REQ D_VARCHAR_50 NOT NULL, ' +
                      '    DIRE_REQ D_VARCHAR_100 NOT NULL, ' +
                      '    DATA_REQ D_DATE NOT NULL, ' +
                      '    HORA_REQ D_TIME NOT NULL)');

      ExecutaComandos('alter table REQUISICAO ' +
                      'add constraint PK_REQUISICAO ' +
                      'primary key (CODI_REQ)');

      ExecutaComandos('ALTER TABLE REQUISICAO ' +
                      'ADD SITU_REQ D_CHAR_02 ' +
                      'DEFAULT ''AG'' ' +
                      'NOT NULL ' +
                      'COLLATE WIN1252');

      ExecutaComandos('COMMENT ON COLUMN REQUISICAO.SITU_REQ IS ' +
                      '''Situação da Requisição: AG (Aguardando), CN (Compilando) ou CD (Concluído)''');

      ExecutaComandos('ALTER TABLE REQUISICAO ' +
                      'ADD STAT_REQ D_CHARN_1 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('ALTER TABLE REQUISICAO ' +
                      'ADD RESP_REQ D_VARCHAR_100 ' +
                      'COLLATE WIN1252');

      ExecutaComandos('CREATE SEQUENCE GEN_REQUISICAO_ID');

      ExecutaComandos('CREATE TRIGGER REQUISICAO_BI FOR REQUISICAO ' +
                      'ACTIVE BEFORE INSERT POSITION 0 ' +
                      'AS ' +
                      'BEGIN ' +
                      '  IF (NEW.CODI_REQ IS NULL) THEN ' +
                      '    NEW.CODI_REQ = GEN_ID(GEN_REQUISICAO_ID,1); ' +
                      'END');

      ExecutaComandos('alter table REQUISICAO ' +
                      'add constraint FK_REQUISICAO_RLC_USUARIO ' +
                      'foreign key (CODI_USU) ' +
                      'references USUARIO(CODI_USU) ' +
                      'on delete CASCADE ' +
                      'on update CASCADE ' +
                      'using index FK_REQUISICAO_RLC_USUARIO');

      ExecutaComandos('ALTER TABLE CONFIG ' +
                      'ADD REQU_CFG D_CHARN_1 ' +
                      'COLLATE WIN1252');
   end;
end;

procedure TfrmPrincipal.AlterarImgBtn(ATipoBtn: TTipoBtn);
begin
   case ATipoBtn of
      tbSair :
      begin
         btnSair.ImageIndex := 1;
         btnSair.Caption    := '&Sair'
      end;
      tbCancelar:
      begin
         btnSair.ImageIndex := 0;
         btnSair.Caption    := '&Cancelar';
      end;
   end;
end;

procedure TfrmPrincipal.btnIniciarClick(Sender: TObject);
var
   lVersion,
   lBuild: string;
   lOldVersion,
   lNewVersion: Integer;
begin

   try      

      Cancelar := false;

      AlterarImgBtn(tbCancelar);

      JvGIFAnimatorProgresso.Visible := true;

      btnIniciar.Enabled := false;

      try
         FTransaction.TransactionID := 1;
         FTransaction.IsolationLevel := xilREADCOMMITTED;

         dmPrincipal.sqcCompilador.StartTransaction(FTransaction);

         //if TALXCompilerFuncoesDB.ExisteRegistroNaTabela('INFODB', 'VERS_INF') then
            lOldVersion := TALXCompilerFuncoesDB.RetornaVersao('INFODB', 'VERS_INF');
         //else
         //   OldVersion := TALXCompilerFuncoesDB.RetornaVersao('CONFIG', 'VERS_CFG');

         AjustarEstrutura(lOldVersion);

         TALXFuncoes.VersaoPrograma(lVersion, lBuild);

         lVersion := lVersion + '.' + lBuild;

         lVersion := StringReplace(lVersion, '.', '', [rfReplaceAll]);

         lNewVersion := StrToInt(TALXFuncoes.RetornaApenasNumero(lVersion));

         dmPrincipal.sqcCompilador.Commit(FTransaction);

         dmPrincipal.sqcCompilador.Close;
         dmPrincipal.sqcCompilador.Open;

         AjustarDados(lOldVersion);

         if TALXCompilerFuncoesDB.ExisteRegistroNaTabela('INFODB', 'VERS_INF') then
         begin
            if (lOldVersion < lNewVersion) then
               ExecutaComandos('update INFODB set VERS_INF = ' + QuotedStr(IntToStr(lNewVersion)));
         end
         else
         begin
            ExecutaComandos('insert into INFODB (VERS_INF) values (' + QuotedStr(IntToStr(lNewVersion)) + ')');
         end;

         JvGIFAnimatorProgresso.Visible := false;

         if (lOldVersion < lNewVersion) then
         begin
            TALXFuncoes.Aviso('Base de dados atualizada com êxito!', bmOk, imInformacao);
         end;         

         Close;

      except
         on E: Exception do
         begin
            TALXFuncoes.Aviso(Pchar('Não foi possível executar o adaptador! Detalhes do erro: ' + #13 +
                                    'Classe: ' + E.ClassName + #13 +
                                    'Mensagem: ' + E.Message), bmOk, imErro);

            if dmPrincipal.sqcCompilador.InTransaction then
               dmPrincipal.sqcCompilador.Rollback(FTransaction);
               
            Abort;
         end;
      end;

   finally
      AlterarImgBtn;
      JvGIFAnimatorProgresso.Visible := false;
      Cancelar := False;
      btnIniciar.Enabled := true;
   end;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
   if btnSair.Caption = '&Sair' then
      Close
   else
      Cancelar := true;
end;

procedure TfrmPrincipal.ExecutaComandos(AInstrucao: String);
begin
   if Cancelar then
      Abort;

   dmPrincipal.sqqAdap.SQL.Clear;

   dmPrincipal.sqqAdap.SQL.Add(AInstrucao);

   dmPrincipal.sqqAdap.ExecSQL(True);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
   if dmPrincipal = nil then
      dmPrincipal := TdmPrincipal.Create(Self);

   AlterarImgBtn;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
   if dmPrincipal <> nil then
      FreeAndNil(dmPrincipal);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   if Executar then
      btnIniciarClick(Sender);
end;

procedure TfrmPrincipal.SetarValorPadraoParametros(ACampo, AValor, ACODI_USU: string);
begin
   ExecutaComandos('update CONFIG ' +
                   'set ' + ACampo + ' = ' + QuotedStr(AValor) + ' ' +
                   'where (CODI_USU = ' + ACODI_USU + ')');
end;

procedure TfrmPrincipal.SetarValorPadraoParametros(ACampo: string;
  AValor: Integer);
begin
   ExecutaComandos('update CONFIG ' +
                   'set ' + ACampo + ' = ' + IntToStr(AValor) + ' ' +
                   'where (' + ACampo + ' is null)');
end;

procedure TfrmPrincipal.SetarValorPadraoParametros(ACampo, AValor: string);
begin
   ExecutaComandos('update CONFIG ' +
                   'set ' + ACampo + ' = ' +  QuotedStr(AValor) + ' ' +
                   'where (' + ACampo + ' is null)');
end;

end.
