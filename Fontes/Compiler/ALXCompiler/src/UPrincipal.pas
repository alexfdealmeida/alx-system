unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ActnMan, ActnCtrls, Menus, JvTrayIcon,
  JvComponentBase, JvBalloonHint, ExtCtrls, Buttons, Grids, DBGrids, JvExStdCtrls,
  JvCombobox, JvExControls, JvEnterTab, DB, JvDBCombobox, DBCtrls, ActnList,
  ImgList, JvAnimatedImage, JvGIFCtrl, JvMemo, JvButton, JvCtrls, JvExButtons,
  JvBitBtn, StrUtils, Math, SqlExpr, DBClient, JvExExtCtrls, JvSecretPanel,
  XPMan, JvMenus, AppEvnts, JvEdit, JvValidateEdit,
  OleCtrls, AgentObjects_TLB, JvJCLUtils, DBAdvGrid,
  AdvGlassButton, AdvOfficeButtons, AdvGlowButton, AdvOfficePager,
  AdvMenus, ALXProgressBar, SHDocVw,
  Sockets, Mask, DateUtils, Registry, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, AdvObj, BaseGrid, AdvGrid,
  IniFiles, AdvOfficeStatusBar, AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TTipoBtn = (tbSair, tbCancelar);

  TTipoAcao = (taCompilar, taParametrosCompilacao, taUpdate, taBases, taExecutar, taCommit,
               taStatus, taPrompt, taPull, taPush, taRebase, taMerge, taRefLog,
               taRefBrowse, taSwitch, taGerarLinks, taFTP);

  TTipoExecucao = (teAutomatica, teManual);

  TDiretorioSVN = (dsGeral, dsRevendaWindows);

  TClientDataThread = class(TThread)
  private
  public
    ListBuffer :TStringList;
    TargetList :TStrings;
    procedure synchAddDataToControl;
    constructor Create(CreateSuspended: Boolean);
    procedure Execute; override;
    procedure Terminate;
  end;

  TDBEdit = class(DBCtrls.TDBEdit)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  TfrmPrincipal = class(TForm)
    JvBalloonHint1: TJvBalloonHint;
    JvTrayIcon1: TJvTrayIcon;
    actLstAtualiza: TActionList;
    actAtualiza: TAction;
    ImageListImagens: TImageList;
    dtsModulos: TDataSource;
    dtsUpdate: TDataSource;
    SaveDialogSalvar: TSaveDialog;
    OpenDialogCarregar: TOpenDialog;
    dtsVersoesUpd: TDataSource;
    dtsVersoes: TDataSource;
    Agent1: TAgent;
    ApplicationEvents1: TApplicationEvents;
    AdvMainMenu1: TAdvMainMenu;
    Extras1: TMenuItem;
    ortoise1: TMenuItem;
    Sobre1: TMenuItem;
    AdvMenuStyler1: TAdvMenuStyler;
    Acessarbasededados1: TMenuItem;
    ExecutarMdulos1: TMenuItem;
    Parmetros1: TMenuItem;
    N3: TMenuItem;
    Sobre2: TMenuItem;
    Arquivo1: TMenuItem;
    Compilar1: TMenuItem;
    Sair2: TMenuItem;
    Minimizarparaabandejadowindows1: TMenuItem;
    N9: TMenuItem;
    popLog: TAdvPopupMenu;
    teste11: TMenuItem;
    teste21: TMenuItem;
    popAplicacao: TAdvPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    SalvarLog2: TMenuItem;
    LimparLog1: TMenuItem;
    Sair3: TMenuItem;
    N4: TMenuItem;
    CadastrarUsurios1: TMenuItem;
    N6: TMenuItem;
    rocardeUsurio1: TMenuItem;
    TcpClient1: TTcpClient;
    TcpServer1: TTcpServer;
    Messenger1: TMenuItem;
    ImageListTray: TImageList;
    pnlInfo: TPanel;
    DiretivasCompilacao: TMenuItem;
    dtsDiretivas: TDataSource;
    JvEnterAsTab1: TJvEnterAsTab;
    pgcLog: TAdvOfficePager;
    tabLog: TAdvOfficePage;
    mmoLog: TJvMemo;
    pgcModulos: TAdvOfficePager;
    tabModulos: TAdvOfficePage;
    grdModulos: TDBAdvGrid;
    GIT1: TMenuItem;
    SVN1: TMenuItem;
    Commit2: TMenuItem;
    Update2: TMenuItem;
    VersoSelecionada2: TMenuItem;
    odasasverses2: TMenuItem;
    Versoselecionada3: TMenuItem;
    odasasverses3: TMenuItem;
    N1: TMenuItem;
    Checkformodifications1: TMenuItem;
    Geral3: TMenuItem;
    RevendaWindows3: TMenuItem;
    Commit1: TMenuItem;
    N2: TMenuItem;
    Checkformodifications2: TMenuItem;
    N5: TMenuItem;
    Linhadecomando1: TMenuItem;
    Push1: TMenuItem;
    Pull1: TMenuItem;
    N7: TMenuItem;
    Rebase1: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    Merge1: TMenuItem;
    N11: TMenuItem;
    Reflog1: TMenuItem;
    CheckoutSwitch1: TMenuItem;
    N12: TMenuItem;
    Refbrowse1: TMenuItem;
    IdFTP1: TIdFTP;
    pnlCabecalho: TPanel;
    pgcVersao: TAdvOfficePager;
    tabVersao: TAdvOfficePage;
    cbxVersao: TDBLookupComboBox;
    btnIncluirVer: TAdvGlowButton;
    btnAlterarVer: TAdvGlowButton;
    btnExcluirVer: TAdvGlowButton;
    btnPesquisarVer: TAdvGlowButton;
    edtVersao: TDBEdit;
    pgcDiretivas: TAdvOfficePager;
    tabDiretivas: TAdvOfficePage;
    grdDiretivas: TDBAdvGrid;
    stbInfo: TAdvOfficeStatusBar;
    stbStylerInfo: TAdvOfficeStatusBarOfficeStyler;
    pnlModulosManut: TAdvSmoothPanel;
    btnIncluirMod: TAdvGlowButton;
    btnAlterarMod: TAdvGlowButton;
    btnExcluirMod: TAdvGlowButton;
    pnlModulosAcoes: TAdvSmoothPanel;
    chkMarcarDesmarcar: TAdvOfficeCheckBox;
    edtTotalModulos: TJvValidateEdit;
    btnSelecionarModulos: TAdvGlowButton;
    btnCompilar: TAdvGlowButton;
    edtBaseUtilizada: TJvEdit;
    edtDESC_MOD: TDBEdit;
    btnTeste: TBitBtn;
    edtDELP_VER: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirVerClick(Sender: TObject);
    procedure btnAlterarVerClick(Sender: TObject);
    procedure actAtualizaExecute(Sender: TObject);
    procedure actAtualizaUpdate(Sender: TObject);
    procedure btnExcluirVerClick(Sender: TObject);
    procedure btnIncluirModClick(Sender: TObject);
    procedure btnAlterarModClick(Sender: TObject);
    procedure btnExcluirModClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure JvTrayIcon1DblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dtsModulosDataChange(Sender: TObject; Field: TField);
    procedure btnSelecionarModulosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure grdModulosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdModulosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkMarcarDesmarcarClick(Sender: TObject);
    procedure Acessarbasededados1Click(Sender: TObject);
    procedure ExecutarMdulos1Click(Sender: TObject);
    procedure Parmetros1Click(Sender: TObject);
    procedure Sobre2Click(Sender: TObject);
    procedure Compilar1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure Minimizarparaabandejadowindows1Click(Sender: TObject);
    procedure teste11Click(Sender: TObject);
    procedure SalvarLog2Click(Sender: TObject);
    procedure LimparLog1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure CadastrarUsurios1Click(Sender: TObject);
    procedure btnCompilarClick(Sender: TObject);
    procedure rocardeUsurio1Click(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject; ClientSocket: TCustomIpClient);
    procedure Messenger1Click(Sender: TObject);
    procedure JvTrayIcon1BalloonClick(Sender: TObject);
    procedure btnPesquisarVerClick(Sender: TObject);
    procedure DiretivasCompilacaoClick(Sender: TObject);
    procedure Versoselecionada3Click(Sender: TObject);
    procedure odasasverses3Click(Sender: TObject);
    procedure VersoSelecionada2Click(Sender: TObject);
    procedure odasasverses2Click(Sender: TObject);
    procedure Geral3Click(Sender: TObject);
    procedure RevendaWindows3Click(Sender: TObject);
    procedure Commit1Click(Sender: TObject);
    procedure Checkformodifications2Click(Sender: TObject);
    procedure Linhadecomando1Click(Sender: TObject);
    procedure Push1Click(Sender: TObject);
    procedure Pull1Click(Sender: TObject);
    procedure Rebase1Click(Sender: TObject);
    procedure Merge1Click(Sender: TObject);
    procedure Reflog1Click(Sender: TObject);
    procedure CheckoutSwitch1Click(Sender: TObject);
    procedure Refbrowse1Click(Sender: TObject);
    procedure cbxVersaoCloseUp(Sender: TObject);
    procedure dtsVersoesDataChange(Sender: TObject; Field: TField);
    procedure dtsDiretivasStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtsModulosStateChange(Sender: TObject);
    procedure btnTesteClick(Sender: TObject);
  private
    { Private declarations }
    FErroCompilacao: Boolean;
    FUtilizarAgente: Boolean;
    FNomeAgente: String;
    FAgente: IAgentCtlCharacter;
    procedure AbreClientDataSets;
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QUERYENDSESSION;
    procedure AlteraCorLog;
    procedure ArmazenaModulosCompilados(ATipoExecucao: TTipoExecucao = teAutomatica);
    procedure AtualizarAtualizador;
    procedure AtualizarUltimaVersao;
    procedure AtualizaDadosUltimaCompilacao(ACodigoModulo: Integer;
      ADateTimeMod, ADateTimeUlt: TDateTime; AUltimaVersao: string);
    procedure AtualizaStatusCompilacao(ACodigoVersao: Integer;
      AIniciando: Boolean = True);
    procedure Compilar;
    procedure ControlaMenuVersao;
    procedure CriaDataModules;
    procedure DestroiDataModules;
    procedure ExecutarModulos(ATipoExecucao: TTipoExecucao = teAutomatica);
    procedure GeraWantConfIni(ADataHora, ADataHoraAux: string);
    procedure GeraBackupWantConfIni;
    procedure RestauraBackupWantConfIni;
    procedure GeraArquivoBatZipAll;
    procedure GeraArquivoBatUpdateSVN(ATodasVersoes: Boolean = false);
    procedure GeraArquivoBatSVN(ATipoAcao: TTipoAcao;
      ADiretorioSVN: TDiretorioSVN = dsRevendaWindows);
    procedure GeraArquivoBatGIT(ATipoAcao: TTipoAcao);
    procedure GeraArquivoBatGITPrompt(AExecutarPatchFile: Boolean = False);
    procedure GeraPatchFile;
    procedure CaptureConsoleOutput(DosApp: String; AMemo: TJvMemo;
      AALXProgressBar: TALXProgressBar; ADataHoraComp: String);
    procedure CommitSVN(ADiretorioSVN: TDiretorioSVN = dsRevendaWindows);
    procedure StatusSVN(ADiretorioSVN: TDiretorioSVN = dsRevendaWindows);
    procedure UpdateSVN(ATodasVersoes: Boolean = false);
    procedure PreCompilacaoGIT(AAcao: TTipoAcao);
    procedure HabilitaDesabilitaComponentes(AAtivar: Boolean = true);
    procedure GerarLinks(ARaiz, AVersao, ADiretorio: string; AModulos: TClientDataSet);
    function AtualizarArquivosFTP(AHost, AUsuario, ASenha, ADiretorioRemoto: string;
      AFTP: TIdFTP; AListaArquivosExistentes: TStringList; AModulos: TClientDataSet;
      AMemo: TJvMemo): Boolean;
    procedure RestaurarAplicacao;
    procedure ExecutarAntesDeSair;
    procedure RunDosInMemo(DosApp, ADirDefault: String; AMemo: TJvMemo; AIsDosApp: Boolean = True);
    procedure ExibeBaseUtilizada;
    function RequisitarCompilacaoRemota(ACODI_USU: Integer; ANOME_USU, ABranch, ADiretorio: string): Boolean;
    function RequisicaoPendente(ACODI_USU: Integer; ABranch: string): Boolean;
    function EstabelecerConexaoFTP(AHost, AUsuario, ASenha, ADiretorioRemoto: String; AFTP: TIdFTP; AMemo: TJvMemo;
      AArquivos: TClientDataSet): Boolean;
    function ReConectouFTP(AHost, AUsuario, ASenha: String; AFTP: TIdFTP): Boolean;
    function RetornaDiretivas: string;
    function HaVersaoCadastrada: Boolean;
    function Obrigatorio(AComponente: TWinControl; AName: String): Boolean;
    function CopiarParaDiretorioRemoto: Boolean;
    function CopiarParaDiretorioLocal: Boolean;
    function EnviarArquivosZipSeparadamenteFTP: Boolean;
    function EnviarArquivoZipUnicoFTP: Boolean;
    function AlterarDataHoraExecutaveis: Boolean;
    function AlterarVersaoExecutaveis: Boolean;
    function AlterarParametrosCompilacao: Boolean;
    function GerarLinksParaDownload: Boolean;
    function ExecutarAposCompilar: Boolean;
    function GerarZipSeparado: Boolean;
    function GerarZipUnico: Boolean;
    function Valida(ATipoAcao: TTipoAcao): Boolean;
    function UsuarioPossuiPermissao: Boolean;
    function UsuarioPossuiLicenca: Boolean;
    function Utilizar7Zip: Boolean;
  public
    { Public declarations }
    property ErroCompilacao: Boolean read FErroCompilacao write FErroCompilacao;
    function RetornaBranchAtual(ASemPontoSVN: Boolean = False): string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses DPrincipal, UVersoes, DVersoes, UMasterCad, DModulos, UModulos, DBases,
  UManutBases, DParametros, UParametros, DExecutar, UExecutar,
  USobre, UVersaoBase, DVersaoBase, USelecionaModulos, ALXArquivos,
  ALXProcessos, ALXFuncoes, UUsuarios, DUsuarios,
  UManutUsuarios, DInfoDB, ALXCompilerVariaveis,
  UValidaInicializacao, UMessenger, USelecionaVersoes,
  DDiretivas, UManutDiretivas, UDataHora, ALXCompilerFuncoesDB, ALXVariaveis,
  UBases, UDiretivas, UVersoesSintetico, UParametrosSintetico, UResumo,
  DCompilacaoRemota;

{$R *.dfm}

procedure TfrmPrincipal.AbreClientDataSets;
begin
   dmVersoes.cdsVersoes.Close;
   dmVersoes.cdsVersoes.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
   dmVersoes.cdsVersoes.Open;

   dmModulos.cdsModulos.Close;
   dmModulos.cdsModulos.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
   dmModulos.cdsModulos.Open;

   dmBases.cdsBases.Close;
   dmBases.cdsBases.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
   dmBases.cdsBases.Open;

   dmParametros.cdsParametros.Close;
   dmParametros.cdsParametros.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
   dmParametros.cdsParametros.Open;

   dmUsuarios.cdsUsuarios.Close;
   dmUsuarios.cdsUsuarios.Open;

   dmInfoDB.cdsInfoDB.Close;
   dmInfoDB.cdsInfoDB.Open;

   dmDiretivas.cdsDiretivas.Close;
   dmDiretivas.cdsDiretivas.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
   dmDiretivas.cdsDiretivas.Open;

   dmCompilacaoRemota.cdsRequisicoes.Close;
   dmCompilacaoRemota.cdsRequisicoes.Open;
end;

procedure TfrmPrincipal.Acessarbasededados1Click(Sender: TObject);
var
   lApagarBasesInexistentes: Boolean;
begin
   if not Valida(taBases) then
   begin
      Exit;
   end;

   lApagarBasesInexistentes := dmParametros.cdsParametrosAPAG_CFG.AsString = 'S';

   frmManutBases := TfrmManutBases.Create(Self,
                                          dmBases.cdsBases,
                                          frmBases,
                                          TfrmBases,
                                          'DESC_BAS',
                                          ['DESC_BAS', 'TIPO_BAS', 'SERV_BAS', 'DIRE_BAS', 'PORT_BAS'],
                                          True,
                                          lApagarBasesInexistentes);
   frmManutBases.ShowModal;

   ExibeBaseUtilizada;
end;

procedure TfrmPrincipal.actAtualizaExecute(Sender: TObject);
begin
   { Favor não remover este comentário }
end;

procedure TfrmPrincipal.actAtualizaUpdate(Sender: TObject);
begin
   btnAlterarVer.Enabled := cbxVersao.Text <> '';
   btnExcluirVer.Enabled := btnAlterarVer.Enabled;
   btnPesquisarVer.Enabled := btnAlterarVer.Enabled;

   btnAlterarMod.Enabled := not (dmModulos.cdsModulos.IsEmpty);
   btnExcluirMod.Enabled := btnAlterarMod.Enabled;
end;

procedure TfrmPrincipal.btnPesquisarVerClick(Sender: TObject);
begin
   frmSelecionaVersoes := TfrmSelecionaVersoes.Create(Self);
   frmSelecionaVersoes.ShowModal;
end;

procedure TfrmPrincipal.AlteraCorLog;
var
   lCorFundo,
   lCorFonte: Integer;
   lSQLQuery: TSQLQuery;
begin
   lSQLQuery := TSQLQuery.Create(nil);

   try

      lSQLQuery.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLQuery.Close;
      lSQLQuery.SQL.Clear;
      lSQLQuery.SQL.Add('select coalesce(CFG.CORM_CFG, -1) CORM_CFG, ' +
                        '       coalesce(CFG.CORF_CFG, -1) CORF_CFG ' +
                        'from CONFIG CFG ' +
                        'where (CFG.CODI_USU = ' + IntToStr(CODI_USU) + ')');
      lSQLQuery.Open;

      if lSQLQuery.FieldByName('CORM_CFG').AsInteger > -1 then
         lCorFundo := lSQLQuery.FieldByName('CORM_CFG').AsInteger
      else
         lCorFundo := 15;

      if lSQLQuery.FieldByName('CORF_CFG').AsInteger > -1 then
         lCorFonte := lSQLQuery.FieldByName('CORF_CFG').AsInteger
      else
         lCorFonte := 0;

      TALXFuncoes.MudarCor(mmoLog, lCorFundo, lCorFonte);

   finally
      FreeAndNil(lSQLQuery);
   end;
end;

function TfrmPrincipal.AlterarDataHoraExecutaveis: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosIDEX_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

function TfrmPrincipal.AlterarParametrosCompilacao: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosIPAR_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

function TfrmPrincipal.AlterarVersaoExecutaveis: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosIVER_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

procedure TfrmPrincipal.ApplicationEvents1Minimize(Sender: TObject);
begin
   if FUtilizarAgente then   
      FAgente.Hide(False);
end;

procedure TfrmPrincipal.ArmazenaModulosCompilados(ATipoExecucao: TTipoExecucao);
var
   lPonteiro: TBookmark;
begin
   TALXFuncoes.ConfiguraCDSTemporario(dmExecutar.cdsModulosExe, False);

   dmModulos.cdsModulos.DisableControls;

   lPonteiro := dmModulos.cdsModulos.GetBookmark;

   try
   
      dmModulos.cdsModulos.First;
      while not dmModulos.cdsModulos.Eof do
      begin
         dmExecutar.cdsModulosExe.Append;
         dmExecutar.cdsModulosExeDESC_MOD.AsString := dmModulos.cdsModulosDESC_MOD.AsString;
         dmExecutar.cdsModulosExeALIAS.AsString    := dmModulos.cdsModulosWANT_MOD.AsString;
         dmExecutar.cdsModulosExe.Post;

         dmModulos.cdsModulos.Next;
      end;

   finally
      if (lPonteiro <> nil) and (dmModulos.cdsModulos.BookmarkValid(lPonteiro)) then
      begin
         dmModulos.cdsModulos.GotoBookmark(lPonteiro);
         dmModulos.cdsModulos.FreeBookmark(lPonteiro);
      end;

      dmModulos.cdsModulos.EnableControls;

      dmExecutar.cdsModulosExe.First;
   end;
end;

procedure TfrmPrincipal.AtualizaDadosUltimaCompilacao(ACodigoModulo: Integer;
   ADateTimeMod, ADateTimeUlt: TDateTime; AUltimaVersao: string);
begin
   dmPrincipal.sqqExecute.SQL.Clear;

   dmPrincipal.sqqExecute.SQL.Add('update MODULO ' +
                                  'set DATE_MOD =  ' + QuotedStr(FormatDateTime('mm/dd/yyyy hh:mm:ss', ADateTimeMod)) + ', ' +
                                  '    DULT_MOD =  ' + QuotedStr(FormatDateTime('mm/dd/yyyy hh:mm:ss', ADateTimeUlt)) + ', ' +
                                  '    VULT_MOD =  ' + QuotedStr(AUltimaVersao) + ', ' +
                                  '    COMP_MOD = COMP_MOD + 1 ' +
                                  'where (CODI_MOD = ' + IntToStr(ACodigoModulo) + ') and ' +
                                  '      (CODI_USU = ' + IntToStr(CODI_USU) + ')');

   dmPrincipal.sqqExecute.ExecSQL;
end;

procedure TfrmPrincipal.AtualizarAtualizador;
var
   lDirLocal,
   lDirServer: string;
   AProcessos: TStrings;
begin
   lDirLocal := ExtractFilePath(Application.ExeName);

   lDirServer := TALXCompilerFuncoesDB.DiretorioServidor(CODI_USU);

   AProcessos := TStringList.Create;

   try

      if (lDirServer <> '') then
      begin
         if Copy(lDirServer, Length(lDirServer), 1) <> '\' then
            Insert('\', lDirServer, Length(lDirServer) + 1);

         TALXProcessos.ListaProcessos(AProcessos);

         while AProcessos.IndexOf('AtualizadorALXCompiler.exe') <> -1 do
         begin
            Application.ProcessMessages;
            TALXProcessos.ListaProcessos(AProcessos);
         end;

         if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'AtualizadorALXCompiler.exe') then
            Exit;

         if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'AtualizadorALXCompiler.map') then
            Exit;
      end;

   finally
      FreeAndNil(AProcessos);
   end;
end;

procedure TfrmPrincipal.AtualizaStatusCompilacao(ACodigoVersao: Integer; AIniciando: Boolean = True);
var
   sqqAux: TSQLQuery;
begin
   sqqAux := TSQLQuery.Create(nil);

   try
      sqqAux.SQLConnection := dmPrincipal.sqcCompilador;

      sqqAux.SQL.Clear;
      sqqAux.SQL.Add('update VERSAO ' +
                     'set COMP_VER = ' + QuotedStr(IfThen(AIniciando, 'S', 'N')) + ' ' +
                     'where (CODI_VER = ' + IntToStr(ACodigoVersao) + ') and ' +
                     '      (CODI_USU = ' + IntToStr(CODI_USU) + ')');

      sqqAux.ExecSQL;

   finally
      FreeAndNil(sqqAux);
   end;
end;

procedure TfrmPrincipal.AtualizarUltimaVersao;
var
   sqqAux: TSQLQuery;
begin
   sqqAux := TSQLQuery.Create(nil);

   try
      sqqAux.SQLConnection := dmPrincipal.sqcCompilador;

      sqqAux.SQL.Clear;
      sqqAux.SQL.Add('update CONFIG ' +
                     'set UVER_CFG = ' + QuotedStr(dmVersoes.cdsVersoesCODI_VER.AsString) + ' ' +
                     'where (CODI_USU = ' + IntToStr(CODI_USU) + ')');

      sqqAux.ExecSQL;

   finally
      FreeAndNil(sqqAux);
   end;
end;

procedure TfrmPrincipal.btnTesteClick(Sender: TObject);
begin
   RequisitarCompilacaoRemota(CODI_USU, NOME_USU, 'Branch', 'C:');
end;

procedure TfrmPrincipal.btnAlterarModClick(Sender: TObject);
begin
   frmModulos := TfrmModulos.Create(Self,
                                    dmModulos.cdsModulos,
                                    tmAlterar);
   frmModulos.ShowModal;
end;

procedure TfrmPrincipal.btnAlterarVerClick(Sender: TObject);
begin
   frmVersoes := TfrmVersoes.Create(Self,
                                    dmVersoes.cdsVersoes,
                                    tmAlterar);
   frmVersoes.ShowModal;
end;

procedure TfrmPrincipal.btnCompilarClick(Sender: TObject);
begin
   Compilar;
end;

procedure TfrmPrincipal.btnExcluirModClick(Sender: TObject);
begin
   if Application.MessageBox('Deseja realmente excluir este módulo?', 'Compilador', MB_YESNO + MB_ICONQUESTION) = IDYES then
   begin
      dmModulos.cdsModulos.Delete;

      if dmModulos.cdsModulos.ApplyUpdates(-1) > 0 then
      begin
         if FUtilizarAgente then
         begin
            FAgente.Show(False);
            FAgente.Speak('Não foi possível excluir os dados!', EmptyStr);
            FAgente.Hide(False);
         end;

         Application.MessageBox('Não foi possível excluir os dados!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

         Abort;
      end;

      dmModulos.cdsModulos.Close;
      dmModulos.cdsModulos.Open;
   end;
end;

procedure TfrmPrincipal.btnExcluirVerClick(Sender: TObject);
begin
   if Application.MessageBox(Pchar('Deseja realmente excluir a versão "' + dmVersoes.cdsVersoesDESC_VER.AsString + '"?'), 'Compilador', MB_YESNO + MB_ICONQUESTION) = IDYES then
   begin
      dmVersoes.cdsVersoes.Delete;

      if dmVersoes.cdsVersoes.ApplyUpdates(-1) > 0 then
      begin
         if FUtilizarAgente then
         begin
            FAgente.Show(False);
            FAgente.Speak('Não foi possível excluir os dados!', EmptyStr);
            FAgente.Hide(False);
         end;

         Application.MessageBox('Não foi possível excluir os dados!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

         Abort;
      end;

      dmVersoes.cdsVersoes.Close;
      dmVersoes.cdsVersoes.Open;
   end;
end;

procedure TfrmPrincipal.btnIncluirModClick(Sender: TObject);
begin
   frmModulos := TfrmModulos.Create(Self,
                                    dmModulos.cdsModulos);
   frmModulos.ShowModal;
end;

procedure TfrmPrincipal.btnIncluirVerClick(Sender: TObject);
var
   lResult,
   lCODI_VER_INI,
   lCODI_VER_FIN: Integer;
begin
   lCODI_VER_INI := TALXCompilerFuncoesDB.RetornaChaveUltimoRegistro('VERSAO', 'CODI_VER', CODI_USU);

   if not dmVersoes.cdsVersoes.IsEmpty then
   begin
      lResult := TALXFuncoes.SelecionaOpcao(['Em branco', 'A partir de outra versão'], 'Incluir versão');

      if lResult <> -1 then
      begin
         case lResult of
            00 :
            begin
               frmVersoes := TfrmVersoes.Create(Self,
                                                dmVersoes.cdsVersoes);
               frmVersoes.ShowModal;
            end;
            01 :
            begin
               dmVersaoBase.cdsVersoesTemp.Data := dmVersoes.cdsVersoes.Data;

               frmVersaoBase := TfrmVersaoBase.Create(Self);

               if frmVersaoBase.ShowModal = mrOk then
               begin
                  dmVersaoBase.cdsLibraryPathTemp.Data := dmVersoes.cdsLibraryPath.Data;

                  frmVersoes := TfrmVersoes.Create(Self, dmVersoes.cdsVersoes, dmVersoes.cdsLibraryPath, tmIncluir, True);

                  dmVersaoBase.cdsVersoesTemp.EmptyDataSet;
                  dmVersaoBase.cdsLibraryPathTemp.EmptyDataSet;
               end
               else
                  frmVersoes := TfrmVersoes.Create(Self,
                                                   dmVersoes.cdsVersoes);

               frmVersoes.ShowModal;
            end;
         end;
      end;
   end
   else
   begin
      frmVersoes := TfrmVersoes.Create(Self,
                                       dmVersoes.cdsVersoes);
      frmVersoes.ShowModal;
   end;

   lCODI_VER_FIN := TALXCompilerFuncoesDB.RetornaChaveUltimoRegistro('VERSAO', 'CODI_VER', CODI_USU);

   if lCODI_VER_INI <> lCODI_VER_FIN then
   begin
      if dmVersoes.cdsVersoes.Locate('CODI_VER;CODI_USU', VarArrayOf([lCODI_VER_FIN, CODI_USU]), []) then
      begin
         cbxVersao.KeyValue := dmVersoes.cdsVersoesCODI_VER.AsInteger;
      end;
   end;
end;

procedure TfrmPrincipal.btnSelecionarModulosClick(Sender: TObject);
begin
   frmSelecionaModulos := TfrmSelecionaModulos.Create(Self);
   frmSelecionaModulos.ShowModal;
end;

procedure TfrmPrincipal.CadastrarUsurios1Click(Sender: TObject);
begin
   frmManutUsuarios := TfrmManutUsuarios.Create(Self,
                                                dmUsuarios.cdsUsuarios,
                                                frmUsuarios,
                                                TfrmUsuarios,
                                                'NOME_USU',
                                                ['NOME_USU', 'LOGI_USU'],
                                                True);
   frmManutUsuarios.ShowModal;
end;

procedure TfrmPrincipal.CaptureConsoleOutput(DosApp: String; AMemo: TJvMemo; AALXProgressBar: TALXProgressBar;
   ADataHoraComp: String);
const
  ReadBufferSize = 4096;
var
  Security            : TSecurityAttributes;
  ReadPipe,WritePipe  : THandle;
  start               : TStartUpInfo;
  ProcessInfo         : TProcessInformation;
  Buffer              : Pchar;
  //TotalBytesRead,
  BytesRead           : DWORD;
  Apprunning,
  BytesLeftThisMessage,
  TotalBytesAvail : integer;
  Retorno: cardinal;
begin
  AMemo.Lines.Clear;

  with Security do
  begin
    nlength              := SizeOf(TSecurityAttributes);
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;

  if CreatePipe (ReadPipe, WritePipe, @Security, 0) then
  begin
    // Redirect In- and Output through STARTUPINFO structure

    Buffer  := AllocMem(ReadBufferSize + 1);
    FillChar(Start,Sizeof(Start),#0);
    start.cb          := SizeOf(start);
    start.hStdOutput  := WritePipe;
    start.hStdInput   := ReadPipe;
    start.dwFlags     := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    // Create a Console Child Process with redirected input and output

    if CreateProcess(nil      ,PChar(DosApp),
                     @Security,@Security,
                     true     ,CREATE_NO_WINDOW or NORMAL_PRIORITY_CLASS,
                     nil      ,Pchar(dmVersoes.cdsVersoesDREV_VER.AsString),
                     start    ,ProcessInfo) then
    begin

      repeat
        // wait for end of child process
        Apprunning := WaitForSingleObject(ProcessInfo.hProcess,100);

        //Application.ProcessMessages;

        // it is important to read from time to time the output information
        // so that the pipe is not blocked by an overflow. New information
        // can be written from the console app to the pipe only if there is
        // enough buffer space.

        if not PeekNamedPipe(ReadPipe        ,@Buffer[0],
                             ReadBufferSize  ,@BytesRead,
                             @TotalBytesAvail,@BytesLeftThisMessage) then break
        else if BytesRead > 0 then
          ReadFile(ReadPipe,Buffer[0],ReadBufferSize,BytesRead,nil);

        Buffer[BytesRead]:= #0;
        OemToChar(Buffer,Buffer);

        if Trim(StrPas(Buffer)) <> '' then
        begin
          AMemo.Lines.Add(StrPas(Buffer));
          AMemo.LineScroll(0, AMemo.Lines.Count);
        end;

        Application.ProcessMessages;

        if AALXProgressBar.Cancelar then
        begin
           AMemo.Lines.Add('---------------------------------------------------------');
           AMemo.Lines.Add('COMPILAÇÃO INTERROMPIDA PELO USUÁRIO!');
           AMemo.LineScroll(0, AMemo.Lines.Count);
           TerminateProcess(ProcessInfo.hProcess, 0);
           Abort;
        end;

      until (Apprunning <> WAIT_TIMEOUT);

      Retorno := 0;
      GetExitCodeProcess(ProcessInfo.hProcess, Retorno);

      dmModulos.cdsModulos.Edit;

      if Retorno <> 0 then
      begin
         ErroCompilacao := true;

         dmModulos.cdsModulosSTATUS.AsString := 'F';

         if dmParametros.cdsParametrosALER_CFG.AsString = 'S' then
         begin
            if (dmModulos.cdsModulos.RecNo <> dmModulos.cdsModulos.RecordCount) and
               (Application.MessageBox(Pchar('Não foi possível compilar o módulo ' + dmModulos.cdsModulosDESC_MOD.AsString + '!' + #13 +
                                             'Deseja prosseguir com a compilação dos demais módulos?'), 'Compilador', MB_YESNO + MB_ICONQUESTION) = IDNO) then
            begin
               Abort;
            end;
         end;
      end
      else
      begin
         dmModulos.cdsModulosSTATUS.AsString := 'T';
         dmModulos.cdsModulosDATE_TMP.AsString  := ADataHoraComp;
         dmModulos.cdsModulosDULT_TMP.AsString  := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);

         if dmVersoes.cdsVersoesGVPD_VER.AsString = 'GIT' then
         begin
            dmModulos.cdsModulosVULT_TMP.AsString  := dmVersoes.cdsVersoesDESC_VER.AsString + ' (' + RetornaBranchAtual + ' - ' + dmVersoes.cdsVersoesVERS_VER.AsString + ')';
         end
         else
         begin
            dmModulos.cdsModulosVULT_TMP.AsString  := dmVersoes.cdsVersoesDESC_VER.AsString + ' (' + dmVersoes.cdsVersoesVERS_VER.AsString + ')';
         end;

         dmModulos.cdsModulosCOMP_TMP.AsInteger := dmModulos.cdsModulosCOMP_TMP.AsInteger + 1;

         AtualizaDadosUltimaCompilacao(dmModulos.cdsModulosCODI_MOD.AsInteger,
                                       dmModulos.cdsModulosDATE_TMP.AsDateTime,
                                       dmModulos.cdsModulosDULT_TMP.AsDateTime,
                                       dmModulos.cdsModulosVULT_TMP.AsString);
      end;

      dmModulos.cdsModulos.Post;

    end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
end;

procedure TfrmPrincipal.cbxVersaoCloseUp(Sender: TObject);
begin
   ControlaMenuVersao;
end;

procedure TfrmPrincipal.Checkformodifications2Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taStatus);
end;

procedure TfrmPrincipal.CheckoutSwitch1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taSwitch);
end;

procedure TfrmPrincipal.chkMarcarDesmarcarClick(Sender: TObject);
begin
    TALXCompilerFuncoesDB.MarcarDesmarcarBooleans(dmModulos.cdsModulos, 'SELECIONA', chkMarcarDesmarcar.Checked);
end;

procedure TfrmPrincipal.Commit1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taCommit);
end;

procedure TfrmPrincipal.CommitSVN(ADiretorioSVN: TDiretorioSVN);
begin
   if HaVersaoCadastrada then
   begin
      if Obrigatorio(cbxVersao, 'versão') then
         Exit;

      try
         HabilitaDesabilitaComponentes(False);

         GeraArquivoBatSVN(taCommit, ADiretorioSVN);

      finally
         HabilitaDesabilitaComponentes;
      end;
   end;
end;

procedure TfrmPrincipal.Compilar;
var
   lRecNoUltimaInstrucao,
   lCODI_VER,
   lIndex: Integer;
   lTipoVersao,
   lInstrucao,
   lUltimaInstrucao,
   lDiretivas,
   lDataHora,
   lDataHoraAux,
   lDataHoraComp,
   lDiretorioDestino: string;
   lDataHoraInicio,
   lDataHoraFim: TDateTime;
   lArquivosLocaisCopiados,
   lArquivosRemotosCopiados,
   lPodeApagarArquivosTemp,
   lArquivosTransferidos: Boolean;
   lListaArquivos: TStrings;
   lALXProgressBar: TALXProgressBar;
begin
   lDataHoraInicio := Now;

   if not Valida(taCompilar) then
   begin
      Exit;
   end;

   try

      dmModulos.cdsModulos.DisableControls;

      try

         dmModulos.cdsModulos.First;
         while not dmModulos.cdsModulos.Eof do
         begin
            dmModulos.cdsModulos.Edit;
            dmModulos.cdsModulosSTATUS.AsVariant := null;
            dmModulos.cdsModulos.Post;

            dmModulos.cdsModulos.Next;
         end;

      finally
         dmModulos.cdsModulos.First;
         dmModulos.cdsModulos.EnableControls;
      end;

      dmModulos.cdsModulos.Filtered := false;
      dmModulos.cdsModulos.Filter := 'SELECIONA';
      dmModulos.cdsModulos.Filtered := true;

      if (dmModulos.cdsModulos.IsEmpty) then
      begin
         if FUtilizarAgente then
         begin
            FAgente.Show(False);
            FAgente.Speak('Nenhum módulo selecionado!', EmptyStr);
            FAgente.Hide(False);
         end;

         Application.MessageBox('Nenhum módulo selecionado!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

         Exit;
      end;

      if (dmVersoes.cdsVersoesGVPD_VER.AsString = 'SVN') then
      begin
         if (dmParametros.cdsParametrosUPDC_CFG.AsString = 'S') then
         begin
            UpdateSVN;
         end;
      end
      else if (dmVersoes.cdsVersoesGVPD_VER.AsString = 'GIT') then
      begin
         if (dmParametros.cdsParametrosSWIT_CFG.AsString = 'S') then
         begin
            PreCompilacaoGIT(taSwitch);
         end;

         if (dmParametros.cdsParametrosUPDG_CFG.AsString = 'S') then
         begin
            PreCompilacaoGIT(taPull);
         end;
      end;

      LimparLog1Click(nil);

      HabilitaDesabilitaComponentes(false);

      ErroCompilacao := False;

      if AlterarParametrosCompilacao then
      begin
         frmParametrosSintetico := TfrmParametrosSintetico.Create(Self,
                                                                  dmParametros.cdsParametros,
                                                                  tmAlterar);
         frmParametrosSintetico.ShowModal;

         if frmParametrosSintetico.ModalResult <> mrOk then
         begin
            Exit;
         end;
      end;

      if GerarZipSeparado then
      begin
         lTipoVersao := 'zip_';
      end
      else
      begin
         lTipoVersao := 'sagr';
      end;

      lDiretivas := RetornaDiretivas;

      lUltimaInstrucao := '';

      lRecNoUltimaInstrucao := 0;

      lCODI_VER := dmVersoes.cdsVersoesCODI_VER.AsInteger;

      if AlterarVersaoExecutaveis then
      begin
         frmVersoesSinteticos := TfrmVersoesSinteticos.Create(Self,
                                                              dmVersoes.cdsVersoes,
                                                              tmAlterar);
         frmVersoesSinteticos.ShowModal;

         if frmVersoesSinteticos.ModalResult <> mrOk then
         begin
            Exit;
         end;
      end;

      dmVersoes.cdsVersoes.Close;
      dmVersoes.cdsVersoes.Open;

      if (dmVersoes.cdsVersoes.Locate('CODI_VER', lCODI_VER, [])) then
      begin
         cbxVersao.KeyValue := dmVersoes.cdsVersoesCODI_VER.AsInteger;
      end
      else
      begin
         TALXFuncoes.Aviso('Não foi possível identificar a versão, será necessário informá-la manualmente!');
         Exit;
      end;

      if not AlterarDataHoraExecutaveis then
      begin
         lDataHora    := FormatDateTime('dd/mm/yyyy', Date) + FormatDateTime('hh:mm:ss', IncHour(Time));
         lDataHoraAux := FormatDateTime('dd/mm/yyyy', Date) + FormatDateTime('hh:mm:ss', Time);
      end
      else
      begin
         frmDataHora := TfrmDataHora.Create(Self);

         try

            frmDataHora.ShowModal;

            if frmDataHora.ModalResult = mrOk then
            begin
               lDataHora    := frmDataHora.edtData.Text + frmDataHora.edtHora.Text;
               lDataHoraAux := frmDataHora.edtDataAux.Text + frmDataHora.edtHoraAux.Text;
            end
            else
               Exit;

         finally
            FreeAndNil(frmDataHora);
         end;
      end;

      if dmVersoes.cdsVersoesCOMP_VER.AsString = 'S' then
      begin
         if not TALXFuncoes.Aviso('Esta versão já está sendo compilada por outra instância deste aplicativo!' + #13 +
                                  'Deseja realmente prosseguir?', bmSimNao, imPergunta) then
         begin
            Exit;
         end;
      end;

      if (dmVersoes.cdsVersoesGVPD_VER.AsString = 'GIT') then
      begin
         GeraPatchFile;

         GeraArquivoBatGITPrompt(True);
      end;

      if not Valida(taParametrosCompilacao) then
      begin
         Exit;
      end;

      GeraWantConfIni(lDataHora, lDataHoraAux);

      if (dmParametros.cdsParametrosLIBR_CFG.AsString = 'S') and
         not (dmVersoes.cdsLibraryPath.IsEmpty) then
      begin
         TALXFuncoes.AtualizaRegistro(HKEY_CURRENT_USER,
                                      'Software\Borland\BDS\4.0\Library',
                                      'Search Path',
                                      TALXCompilerFuncoesDB.RetornaLibraryPath(dmVersoes.cdsLibraryPath),
                                      False);
      end;

      AtualizaStatusCompilacao(dmVersoes.cdsVersoesCODI_VER.AsInteger);

      lALXProgressBar := TALXProgressBar.Create(Self,
                                                True,
                                                0,
                                                100,
                                                'Apagando arquivos do diretório (temporário)...');

      try

         if not TALXArquivos.ApagarArquivosViaShellBuffer(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP, '*.*', True, True, False) then
         begin
            Exit;
         end;

      finally
         FreeAndNil(lALXProgressBar);
      end;

      lALXProgressBar := TALXProgressBar.Create(Self,
                                                False,
                                                0,
                                                dmModulos.cdsModulos.RecordCount + 1,
                                                'Compilando módulos...',
                                                False,
                                                True);

      try

         dmModulos.cdsModulos.First;

         while not dmModulos.cdsModulos.Eof do
         begin

            if ( (dmModulos.cdsModulosWANT_MOD.AsString <> 'login') and (dmModulos.cdsModulosWANT_MOD.AsString <> 'login_modular') ) or
               (lTipoVersao = 'zip_') then
               lInstrucao := 'want ' + lTipoVersao + dmModulos.cdsModulosWANT_MOD.AsString + lDiretivas
            else
               lInstrucao := 'want ' + dmModulos.cdsModulosWANT_MOD.AsString + lDiretivas;

            if (dmModulos.cdsModulosLAST_MOD.AsString = 'S') then
            begin
               lUltimaInstrucao := lInstrucao;
               lRecNoUltimaInstrucao := dmModulos.cdsModulos.RecNo;
               dmModulos.cdsModulos.Next;
               Continue;
            end;

            lALXProgressBar.StepBy(1, 'Compilando ' + dmModulos.cdsModulosDESC_MOD.AsString + '...');

            lDataHoraComp := IfThen(dmModulos.cdsModulosWANT_MOD.AsString = 'adap', lDataHora, lDataHoraAux);

            CaptureConsoleOutput(lInstrucao, mmoLog, lALXProgressBar, lDataHoraComp);

            dmModulos.cdsModulos.Next;

         end;

         if lUltimaInstrucao <> '' then
         begin
            dmModulos.cdsModulos.RecNo := lRecNoUltimaInstrucao;

            lDataHoraComp := IfThen(dmModulos.cdsModulosWANT_MOD.AsString = 'adap', lDataHora, lDataHoraAux);

            lALXProgressBar.StepBy(1, 'Compilando ' + dmModulos.cdsModulosDESC_MOD.AsString + '...');

            CaptureConsoleOutput(lUltimaInstrucao, mmoLog, lALXProgressBar, lDataHoraComp);
         end;

      finally
         AtualizaStatusCompilacao(dmVersoes.cdsVersoesCODI_VER.AsInteger, False);
         RestauraBackupWantConfIni;
         FreeAndNil(lALXProgressBar);
      end;

      if GerarLinksParaDownload then
      begin
         if (GerarZipSeparado) or (GerarZipUnico) then
         begin
            GerarLinks(dmParametros.cdsParametrosLINK_CFG.AsString,
                       dmVersoes.cdsVersoesVERS_VER.AsString,
                       dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP,
                       dmModulos.cdsModulos);
         end;
      end;

      if GerarZipUnico then
      begin
         lALXProgressBar := TALXProgressBar.Create(Self,
                                                   True,
                                                   0,
                                                   100,
                                                   'Gerando arquivo único compactado...');

         try

            GeraArquivoBatZipAll;

         finally
            FreeAndNil(lALXProgressBar);
         end;
      end;

      lArquivosLocaisCopiados := False; 

      if (CopiarParaDiretorioLocal) or (ExecutarAposCompilar) then
      begin
      
         lALXProgressBar := TALXProgressBar.Create(Self,
                                                   True,
                                                   0,
                                                   100,
                                                   'Copiando arquivos para o diretório local...');

         try

            lDiretorioDestino := dmVersoes.cdsVersoesDEXE_VER.AsString;

            if TALXFuncoes.CriarDiretorio(lDiretorioDestino) then
            begin
               lArquivosLocaisCopiados := True;

               lListaArquivos := TStringList.Create;

               try

                  lListaArquivos := TALXArquivos.ListarArquivos(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP);

                  for lindex := 0 to lListaArquivos.Count - 1 do
                  begin
                    lArquivosLocaisCopiados := True;

                     while not TALXArquivos.CopiarArquivosViaShellBuffer(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP,
                                                                         lDiretorioDestino,
                                                                         ExtractFileName(lListaArquivos[lIndex]),
                                                                         False) do
                     begin
                        if not TALXFuncoes.Aviso('Deseja tentar copiar novamente?', bmSimNao, imPergunta) then
                        begin
                           TALXFuncoes.Aviso('Não foi possível copiar todos os arquivos para o diretório local!' + #13 +
                                             'Portanto, será necessário realizar a cópia manualmente.');
                           lArquivosLocaisCopiados := False;
                           Exit;
                        end;
                     end;
                  end;

               finally
                  FreeAndNil(lListaArquivos);
               end;

               if GerarZipSeparado then
               begin
                  if (lArquivosLocaisCopiados) and (TALXFuncoes.CriarDiretorio(lDiretorioDestino + ZIP)) then
                  begin
                     lListaArquivos := TStringList.Create;

                     try

                        lListaArquivos := TALXArquivos.ListarArquivos(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP);

                        for lindex := 0 to lListaArquivos.Count - 1 do
                        begin
                           lArquivosLocaisCopiados := True;

                           while not TALXArquivos.CopiarArquivosViaShellBuffer(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP,
                                                                               lDiretorioDestino + ZIP,
                                                                               ExtractFileName(lListaArquivos[lIndex]),
                                                                               False) do
                           begin
                              if not TALXFuncoes.Aviso('Deseja tentar copiar novamente?', bmSimNao, imPergunta) then
                              begin
                                 TALXFuncoes.Aviso('Não foi possível copiar todos os arquivos para o diretório local!' + #13 +
                                                   'Portanto, será necessário realizar a cópia manualmente.');
                                 lArquivosLocaisCopiados := False;
                                 Exit;
                              end;
                           end;
                        end;

                     finally
                        FreeAndNil(lListaArquivos);
                     end;
                  end
                  else
                  begin
                     lArquivosLocaisCopiados := False;
                  end;
               end;
            end;

         finally
            FreeAndNil(lALXProgressBar);
         end;
      end;

      lArquivosRemotosCopiados := False;

      if (CopiarParaDiretorioRemoto) then
      begin

         if (GerarZipUnico) or (GerarZipSeparado) then
         begin
            if RetornaBranchAtual <> '' then
            begin
               lDiretorioDestino := dmVersoes.cdsVersoesDZIP_VER.AsString + '\' + RetornaBranchAtual;
            end
            else
            begin
               lDiretorioDestino := dmVersoes.cdsVersoesDZIP_VER.AsString;
            end;

            lALXProgressBar := TALXProgressBar.Create(Self,
                                                      True,
                                                      0,
                                                      100,
                                                      'Copiando arquivos para o diretório remoto...');

            try

               if  TALXFuncoes.CriarDiretorio(lDiretorioDestino) then
               begin
                  lArquivosRemotosCopiados := True;

                  if (GerarZipSeparado) or (GerarZipUnico) then
                  begin
                     if (lArquivosRemotosCopiados) and (TALXFuncoes.CriarDiretorio(lDiretorioDestino + ZIP + '\' + FormatDateTime('dd-mm-yyyy', lDataHoraInicio))) then
                     begin

                        lListaArquivos := TStringList.Create;

                        try

                           lListaArquivos := TALXArquivos.ListarArquivos(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP);

                           for lindex := 0 to lListaArquivos.Count - 1 do
                           begin
                              lArquivosRemotosCopiados := True;

                              while not TALXArquivos.CopiarArquivosViaShellBuffer(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP,
                                                                                  lDiretorioDestino + ZIP + '\' + FormatDateTime('dd-mm-yyyy', lDataHoraInicio),
                                                                                  ExtractFileName(lListaArquivos[lIndex]),
                                                                                  False) do
                              begin
                                 if not TALXFuncoes.Aviso('Deseja tentar copiar novamente?', bmSimNao, imPergunta) then
                                 begin
                                    TALXFuncoes.Aviso('Não foi possível copiar todos os arquivos para o diretório remoto!' + #13 +
                                                      'Portanto, será necessário realizar a cópia manualmente.');
                                    lArquivosRemotosCopiados := False;
                                    Exit;
                                 end;
                              end;
                           end;

                        finally
                           FreeAndNil(lListaArquivos);
                        end;
                     end
                     else
                     begin
                        lArquivosRemotosCopiados := False;
                     end;
                  end;
               end;

            finally
               FreeAndNil(lALXProgressBar);
            end;
         end
         else
         begin
            lArquivosRemotosCopiados := False;
         end;
      end;

      lArquivosTransferidos := False;

      if (EnviarArquivosZipSeparadamenteFTP) or (EnviarArquivoZipUnicoFTP) then
      begin
         if ( (GerarZipUnico) or (GerarZipSeparado) ) then
         begin
            lArquivosTransferidos := EstabelecerConexaoFTP(dmParametros.cdsParametrosHFTP_CFG.AsString,
                                                           dmParametros.cdsParametrosUFTP_CFG.AsString,
                                                           dmParametros.cdsParametrosSFTP_CFG.AsString,
                                                           dmVersoes.cdsVersoesVERS_VER.AsString,
                                                           IdFTP1,
                                                           mmoLog,
                                                           dmModulos.cdsModulos);
         end;
      end;

      lPodeApagarArquivosTemp := CopiarParaDiretorioLocal or CopiarParaDiretorioRemoto;

      if lPodeApagarArquivosTemp then
      begin
         if CopiarParaDiretorioLocal then
         begin
            lPodeApagarArquivosTemp := (lPodeApagarArquivosTemp) and
                                       (lArquivosLocaisCopiados);
         end;

         if CopiarParaDiretorioRemoto then
         begin
            lPodeApagarArquivosTemp := (lPodeApagarArquivosTemp) and
                                       (lArquivosRemotosCopiados);
         end;
      end;

      if lPodeApagarArquivosTemp then
      begin
         lALXProgressBar := TALXProgressBar.Create(Self,
                                                   True,
                                                   0,
                                                   100,
                                                   'Apagando arquivos do diretório (temporário)...');

         try

            if not TALXArquivos.ApagarArquivosViaShellBuffer(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP, '*.*', True, True, False) then
            begin
               Exit;
            end;

         finally
            FreeAndNil(lALXProgressBar);
         end;
      end;

      lDataHoraFim := Now;

      if FUtilizarAgente then
      begin
         FAgente.Show(False);
         FAgente.Speak(IfThen(ErroCompilacao , 'Compilação concluída com erro(s)!', 'Compilação concluída com sucesso!'), EmptyStr);

         if ErroCompilacao then
            FAgente.Play('sad')
         else
         begin
            FAgente.Play('pleased');
            FAgente.Play('congratulate');
         end;

         FAgente.Hide(False);
      end;

      frmResumo := TfrmResumo.Create(Self,
                                     ErroCompilacao,
                                     lArquivosLocaisCopiados,
                                     lArquivosRemotosCopiados,
                                     lArquivosTransferidos,
                                     lDataHoraInicio,
                                     lDataHoraFim);
      frmResumo.ShowModal;

      if ExecutarAposCompilar then
      begin
         ExecutarModulos;
      end;

   finally
      if FUtilizarAgente then
         FAgente.Hide(False);

      dmModulos.cdsModulos.Filtered := false;
      dmModulos.cdsModulos.Filter := '';

      HabilitaDesabilitaComponentes;
   end;
end;

procedure TfrmPrincipal.Compilar1Click(Sender: TObject);
begin
   Compilar;
end;

function TfrmPrincipal.EstabelecerConexaoFTP(AHost, AUsuario, ASenha, ADiretorioRemoto: String;
   AFTP: TIdFTP; AMemo: TJvMemo; AArquivos: TClientDataSet): Boolean;
var
   lDiretorioExiste: Boolean;
   lIndex: Integer;
   lListaAuxiliar: TStringList;
   lALXProgressBar: TALXProgressBar;
begin

   Result := False;

   lALXProgressBar := TALXProgressBar.Create(Self,
                                             True,
                                             0,
                                             100,
                                             'Transferindo arquivos para o FTP...');

   try

      if ReConectouFTP(AHost, AUsuario, ASenha, AFTP) then
      begin

         ADiretorioRemoto := TALXFuncoes.RetornaAlfaNumerico(ADiretorioRemoto);

         AMemo.Lines.Clear;

         AMemo.Lines.Add('TRANSFERÊNCIA DE ARQUIVOS VIA FTP');
         AMemo.Lines.Add('');
         AMemo.Lines.Add('LISTANDO TODOS OS DIRETÓRIOS');

         lListaAuxiliar := TStringList.Create;

         try

            lDiretorioExiste := False;

            lListaAuxiliar.Clear;

            AFTP.List(lListaAuxiliar, '', False);

            for lindex := 0 to lListaAuxiliar.Count - 1 do
            begin
               if UpperCase(ADiretorioRemoto) = UpperCase(lListaAuxiliar[lIndex]) then
               begin
                  lDiretorioExiste := True;
               end;

               AMemo.Lines.Add(IntToStr(lIndex + 1) + ') ' + lListaAuxiliar[lIndex]);

               Application.ProcessMessages;
            end;

            AMemo.Lines.Add('');

            if  not lDiretorioExiste then
            begin
               AMemo.Lines.Add('CRIANDO O DIRETÓRIO ' + ADiretorioRemoto);
               AMemo.Lines.Add('');

               if not ReConectouFTP(AHost, AUsuario, ASenha, AFTP) then
               begin
                  Result := False;
                  Exit;
               end;

               AFTP.MakeDir(ADiretorioRemoto);
            end;

            AMemo.Lines.Add('ACESSANDO O DIRETÓRIO ' + ADiretorioRemoto);
            AMemo.Lines.Add('');

            if not ReConectouFTP(AHost, AUsuario, ASenha, AFTP) then
            begin
               Result := False;
               Exit;
            end;

            AFTP.ChangeDir(ADiretorioRemoto);

            AMemo.Lines.Add('LISTANDO ARQUIVOS DO DIRETÓRIO ' + ADiretorioRemoto);
            lListaAuxiliar.Clear;
            AFTP.List(lListaAuxiliar, '', False);

            for lindex := 0 to lListaAuxiliar.Count - 1 do
            begin
               AMemo.Lines.Add(IntToStr(lIndex + 1) + ') ' + lListaAuxiliar[lIndex]);

               Application.ProcessMessages;
            end;

            AMemo.Lines.Add('');

            AMemo.Lines.Add('ATUALIZANDO ARQUIVOS DO DIRETÓRIO ' + ADiretorioRemoto);

            if not AtualizarArquivosFTP(AHost,
                                        AUsuario,
                                        ASenha,
                                        ADiretorioRemoto,
                                        AFTP,
                                        lListaAuxiliar,
                                        dmModulos.cdsModulos,
                                        AMemo) then
            begin
               Result := False;
               Exit;
            end;

            AMemo.Lines.Add('');
            AMemo.Lines.Add('LISTANDO ARQUIVOS DO DIRETÓRIO ' + ADiretorioRemoto);
            lListaAuxiliar.Clear;
            AFTP.List(lListaAuxiliar, '', False);

            for lindex := 0 to lListaAuxiliar.Count - 1 do
            begin
               AMemo.Lines.Add(IntToStr(lIndex + 1) + ') ' + lListaAuxiliar[lIndex]);

               Application.ProcessMessages;
            end;

            AMemo.Lines.Add('');

            Result := True;

         finally
            FreeAndNil(lListaAuxiliar);

            AFTP.Disconnect;
         end;
      end;

   finally
      FreeAndNil(lALXProgressBar);
   end;
end;

procedure TfrmPrincipal.ControlaMenuVersao;
begin
   if (dmVersoes.cdsVersoesGVPD_VER.AsString = 'SVN') then
   begin
      GIT1.Enabled := False;
      SVN1.Enabled := True;
   end
   else if (dmVersoes.cdsVersoesGVPD_VER.AsString = 'GIT') then
   begin
      GIT1.Enabled := True;
      SVN1.Enabled := False;
   end
   else
   begin
      GIT1.Enabled := False;
      SVN1.Enabled := False;
   end;
end;

function TfrmPrincipal.CopiarParaDiretorioLocal: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosCPYL_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

function TfrmPrincipal.CopiarParaDiretorioRemoto: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosCPYR_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

procedure TfrmPrincipal.CriaDataModules;
begin
   if dmVersoes = nil then
      dmVersoes := TdmVersoes.Create(Self);

   if dmModulos = nil then
      dmModulos := TdmModulos.Create(Self);

   if dmBases = nil then
      dmBases := TdmBases.Create(Self);

   if dmParametros = nil then
      dmParametros := TdmParametros.Create(Self);

   if dmExecutar = nil then
      dmExecutar := TdmExecutar.Create(Self);

   if dmVersaoBase = nil then
      dmVersaoBase := TdmVersaoBase.Create(Self);

   if dmUsuarios = nil then
      dmUsuarios := TdmUsuarios.Create(Self);

   if dmInfoDB = nil then
      dmInfoDB := TdmInfoDB.Create(Self);

   if dmDiretivas = nil then
      dmDiretivas := TdmDiretivas.Create(Self);

   if dmCompilacaoRemota = nil then
      dmCompilacaoRemota := TdmCompilacaoRemota.Create(Self);
end;

procedure TfrmPrincipal.grdModulosDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
   if (ACol = 1) then
   begin
      if (ARow > 0) then
      begin
         if grdModulos.Cells[ACol, ARow] = 'F' then
         begin
            grdModulos.Canvas.FillRect(Rect);
            ImageListImagens.Draw(grdModulos.Canvas,Rect.Left + 1, Rect.Top, 5);
         end
         else if grdModulos.Cells[ACol, ARow] = 'T' then
         begin
            grdModulos.Canvas.FillRect(Rect);
            ImageListImagens.Draw(grdModulos.Canvas,Rect.Left + 1, Rect.Top, 3);
         end
         else
         begin
            grdModulos.Canvas.FillRect(Rect);
            ImageListImagens.Draw(grdModulos.Canvas,Rect.Left + 1, Rect.Top, 4);
         end;
      end;
   end;
end;

procedure TfrmPrincipal.grdModulosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_SPACE) then
   begin
      if not dmModulos.cdsModulos.IsEmpty then
      begin
         dmModulos.cdsModulos.Edit;

         if dmModulos.cdsModulosSELECIONA.AsBoolean then
            dmModulos.cdsModulosSELECIONA.AsBoolean := false
         else
            dmModulos.cdsModulosSELECIONA.AsBoolean := true;
            
         dmModulos.cdsModulos.Post;
      end;
   end
   else
   if (Key = VK_INSERT) or ( (Key = VK_DOWN) and (dmModulos.cdsModulos.RecNo = dmModulos.cdsModulos.RecordCount) ) then
      Abort;
end;

procedure TfrmPrincipal.DestroiDataModules;
begin
   if dmVersoes <> nil then
      FreeAndNil(dmVersoes);

   if dmModulos <> nil then
      FreeAndNil(dmModulos);

   if dmBases <> nil then
      FreeAndNil(dmBases);

   if dmParametros <> nil then
      FreeAndNil(dmParametros);

   if dmExecutar <> nil then
      FreeAndNil(dmExecutar);

   if dmVersaoBase <> nil then
      FreeAndNil(dmVersaoBase);

   if dmUsuarios <> nil then
      FreeAndNil(dmUsuarios);

   if dmInfoDB <> nil then
      FreeAndNil(dmInfoDB);

   if dmDiretivas <> nil then
      FreeAndNil(dmDiretivas);

   if dmCompilacaoRemota <> nil then
      FreeAndNil(dmCompilacaoRemota);
end;

procedure TfrmPrincipal.DiretivasCompilacaoClick(Sender: TObject);
begin
   frmManutDiretivas := TfrmManutDiretivas.Create(Self,
                                                  dmDiretivas.cdsDiretivas,
                                                  frmDiretivas,
                                                  TfrmDiretivas,
                                                  'DIRE_DTV',
                                                  ['DIRE_DTV', 'DESC_DTV', 'GLOB_DTV', 'SITU_DTV'],
                                                  True);
   frmManutDiretivas.ShowModal;
end;

procedure TfrmPrincipal.dtsDiretivasStateChange(Sender: TObject);
begin
   if dmDiretivas.cdsDiretivas.Active then
   begin
      grdDiretivas.Columns[1].ReadOnly := dmDiretivas.cdsDiretivas.IsEmpty;
   end
   else
   begin
      grdDiretivas.Columns[1].ReadOnly := True;
   end;
end;

procedure TfrmPrincipal.dtsModulosDataChange(Sender: TObject; Field: TField);
begin
   edtTotalModulos.AsInteger := dmModulos.cdsModulos.RecordCount;
end;

procedure TfrmPrincipal.dtsModulosStateChange(Sender: TObject);
begin
   if dmModulos.cdsModulos.Active then
   begin
      grdModulos.Columns[2].ReadOnly := dmModulos.cdsModulos.IsEmpty;
   end
   else
   begin
      grdModulos.Columns[2].ReadOnly := True;
   end;
end;

procedure TfrmPrincipal.dtsVersoesDataChange(Sender: TObject; Field: TField);
begin
   ExibeBaseUtilizada;

   ControlaMenuVersao;
end;

procedure TfrmPrincipal.ExecutarModulos(ATipoExecucao: TTipoExecucao);
var
   lFiltroIni: String;
begin
   if ATipoExecucao = teAutomatica then
   begin
      { Armazena qual o filtro que está sendo utilizado }
      lFiltroIni := dmModulos.cdsModulos.Filter;

      try
         { Filtra apenas os módulos que foram compilados com sucesso }
         dmModulos.cdsModulos.Filtered := false;
         dmModulos.cdsModulos.Filter := 'STATUS = ''T''';
         dmModulos.cdsModulos.Filtered := true;

         { Exibe a tela  de execução dos módulos apenas se algum módulo tiver sido compilado com sucesso }
         if not (dmModulos.cdsModulos.IsEmpty) then
         begin
            ArmazenaModulosCompilados;

            frmExecutar := TfrmExecutar.Create(Self);
            frmExecutar.ShowModal;
         end;

      finally
         { Retorna ao filtro inicial }
         dmModulos.cdsModulos.Filtered := false;
         dmModulos.cdsModulos.Filter   := lFiltroIni;
         dmModulos.cdsModulos.Filtered := true;
      end;
   end
   else
   begin
      ArmazenaModulosCompilados(teManual);

      if not dmExecutar.cdsModulosExe.IsEmpty then
      begin
         frmExecutar := TfrmExecutar.Create(Self);
         frmExecutar.ShowModal;
      end
      else
      begin
         if FUtilizarAgente then
         begin
            FAgente.Show(False);
            FAgente.Speak('Nenhum módulo cadastrado!', EmptyStr);
            FAgente.Hide(False);
         end;

         Application.MessageBox('Nenhum módulo cadastrado!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
      end;
   end;
end;

procedure TfrmPrincipal.ExibeBaseUtilizada;
var
   lFileIni: TIniFile;
begin

   lFileIni := TIniFile.Create(dmVersoes.cdsVersoesDCFG_VER.AsString);

   try

      if lFileIni.ReadString('Geral', 'Banco', '') = 'Oracle' then
      begin
         edtBaseUtilizada.Text := lFileIni.ReadString('Geral', 'Schema', 'Nenhuma base de dados configurada no cadastro de versões...');
      end
      else
      begin
         edtBaseUtilizada.Text := lFileIni.ReadString('DbSiagri', 'DataBase', 'Nenhuma base de dados configurada no cadastro de versões...');
      end;

   finally
      FreeAndNil(lFileIni);
   end;
end;

function TfrmPrincipal.ExecutarAposCompilar: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosEMAC_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

procedure TfrmPrincipal.ExecutarMdulos1Click(Sender: TObject);
begin
   if not Valida(taExecutar) then
      Exit;

   ExecutarModulos(teManual);
end;

procedure TfrmPrincipal.UpdateSVN(ATodasVersoes: Boolean);
begin
   if HaVersaoCadastrada then
   begin
      if not ATodasVersoes then
         if Obrigatorio(cbxVersao, 'versão') then
            Exit;

      try
         HabilitaDesabilitaComponentes(False);

         GeraArquivoBatUpdateSVN(ATodasVersoes);

      finally
         HabilitaDesabilitaComponentes;
      end;
   end;
end;

procedure TfrmPrincipal.GeraBackupWantConfIni;
var
   lArquivo: TStrings;
begin

   lArquivo := TStringList.Create;

   try

      lArquivo.LoadFromFile(dmVersoes.cdsVersoesDREV_VER.AsString + '\wantconf.ini');

      lArquivo.SaveToFile( ExtractFileDir(ParamStr(0)) + '\wantconf.ini~');

   finally
      FreeAndNil(lArquivo);
   end;

end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   ExecutarAntesDeSair;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

   {$IFDEF TESTE}

      ReportMemoryLeaksOnShutdown := true;

      btnTeste.Visible    := True;

   {$ELSE}

      btnTeste.Visible    := False;

   {$ENDIF}

   TALXFuncoes.DefineAlturaLarguraTela(Self, ALTURA_TELA_90, LARGURA_TELA_70);

   CriaDataModules;

   AbreClientDataSets;

   ADMINISTRADOR := TALXCompilerFuncoesDB.RetornaInformacoesUsuario('CODI_USU', 'ADMI_USU', CODI_USU) = 'S';

   if ( Trim(dmParametros.cdsParametrosUVER_CFG.AsString) <> '' ) and
      ( not (dmParametros.cdsParametrosUVER_CFG.IsNull) ) and
      (dmVersoes.cdsVersoes.Locate('CODI_VER', dmParametros.cdsParametrosUVER_CFG.AsString, [])) then
   begin
      cbxVersao.KeyValue := dmVersoes.cdsVersoesCODI_VER.AsInteger;
      ControlaMenuVersao;
   end;

   AtualizarAtualizador;

   if dmParametros.cdsParametrosAGMS_CFG.AsString = 'PD' then
      FNomeAgente := 'peedy'
   else if dmParametros.cdsParametrosAGMS_CFG.AsString = 'ML' then
      FNomeAgente := 'merlin'
   else if dmParametros.cdsParametrosAGMS_CFG.AsString = 'GN' then
      FNomeAgente := 'genie'
   else if dmParametros.cdsParametrosAGMS_CFG.AsString = 'RB' then
      FNomeAgente := 'robby';

   FUtilizarAgente := not(dmParametros.cdsParametrosAGMS_CFG.IsNull) and
                      not(Trim(dmParametros.cdsParametrosAGMS_CFG.AsString) = '') and
                      not(dmParametros.cdsParametrosAGMS_CFG.AsString = 'NO');

   if FUtilizarAgente then
   begin
      if not TALXFuncoes.ArquivoExiste('C:\WINDOWS\msagent\chars' + '\' + FNomeAgente + '.acs',
                                       True,
                                       'Caso deseje utilizar o Agente Microsoft, será necessário instalar o aplicativo "MSAgent.exe".') then
      begin
         FUtilizarAgente := False;
      end;
   end;

   AlteraCorLog;

   TcpServer1.LocalPort := '5000';
   TcpServer1.Active := True;

   frmMessenger := TfrmMessenger.Create(Self);

   JvTrayIcon1.Animated  := False;
   JvTrayIcon1.IconIndex := -1;

   stbInfo.Panels[0].Width := Trunc(Self.Width / 2);
   stbInfo.Panels[0].Alignment := taCenter;
   stbInfo.Panels[1].Width := Trunc(Self.Width / 2);
   stbInfo.Panels[1].Alignment := taCenter;

   stbInfo.Panels[0].Text := dmInfoDB.cdsInfoDBEMPR_INF.AsString;
   stbInfo.Panels[1].Text := NOME_USU;

   grdDiretivas.Columns[0].Width := 20;
   grdDiretivas.Columns[1].Width := 55;
   grdDiretivas.Columns[2].Width := 160;

   grdModulos.Columns[0].Width := 20;
   grdModulos.Columns[1].Width := 20;
   grdModulos.Columns[2].Width := 55;
   grdModulos.Columns[3].Width := 160;
   grdModulos.Columns[4].Width := 55;
   grdModulos.Columns[5].Width := 120;
   grdModulos.Columns[6].Width := 55;
   grdModulos.Columns[7].Width := 120;
   grdModulos.Columns[8].Width := 300;

   ExibeBaseUtilizada;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
   FreeAndNil(frmMessenger);

   DestroiDataModules;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_ESCAPE) then
      Close;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   if (UsuarioPossuiPermissao) and (UsuarioPossuiLicenca) then
   begin
      if FUtilizarAgente then
      begin
         Agent1.Connected := True;

         Agent1.Characters.Load(FNomeAgente, FNomeAgente + '.acs');

         FAgente := Agent1.Characters.Item[FNomeAgente];

         FAgente.Show(false);
         FAgente.MoveTo(800,0,2000);
         FAgente.Play('Announce');
         FAgente.Speak('Bem vindo ao ALXCompiler!', EmptyStr);
         FAgente.MoveTo(0,600,2000);
         FAgente.Speak('Meu nome é ' + FNomeAgente + ', minha função é auxiliá-lo a usufruir de todos os recursos deste aplicativo.', EmptyStr);
         FAgente.MoveTo(0,0,2000);
         FAgente.Speak('Sempre que necessário aparecerei aqui para ajudá-lo...', EmptyStr);
         FAgente.MoveTo(800,0,2000);
         FAgente.Speak('Tchau!!!', EmptyStr);
         FAgente.Play('Wave');
         FAgente.Hide(false)
      end;

      TALXCompilerFuncoesDB.AtualizarSituacaoUsuario(CODI_USU);
   end
   else
   begin
      Close;
   end;
end;

procedure TfrmPrincipal.GeraArquivoBatUpdateSVN(ATodasVersoes: Boolean);
var
   Arquivo: TStringList;
   Ponteiro: TBookmark;
   DiretorioFontes: String;

   procedure AddVersoes;
   begin
      Arquivo.Add('"' + dmParametros.cdsParametrosTSVN_CFG.AsString + '"' + ' /command:update /path:"' + dmVersoes.cdsVersoesDGER_VER.AsString + '" /closeonend:3');
      Arquivo.Add('"' + dmParametros.cdsParametrosTSVN_CFG.AsString + '"' + ' /command:update /path:"' + dmVersoes.cdsVersoesDREV_VER.AsString + '" /closeonend:3');
   end;

begin
   Arquivo := TStringList.Create;

   try
      dmVersoes.cdsVersoes.DisableControls;

      if ATodasVersoes then
      begin
         try
            Ponteiro := dmVersoes.cdsVersoes.GetBookmark;

            { Filtra apenas versões ativas }
            dmVersoes.cdsVersoes.Filtered := False;
            dmVersoes.cdsVersoes.Filter   := '(SITU_VER <> ''S'')';
            dmVersoes.cdsVersoes.Filtered := True;

            if (dmVersoes.cdsVersoes.IsEmpty) then
            begin
               if FUtilizarAgente then
               begin
                  FAgente.Show(False);
                  FAgente.Speak('Nenhuma versão ativa está selecionada!', EmptyStr);
                  FAgente.Hide(False);
               end;

               Application.MessageBox('Nenhuma versão ativa está selecionada!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

               Abort;
            end;

            dmVersoes.cdsVersoes.First;
            while not dmVersoes.cdsVersoes.Eof do
            begin
               if not Valida(taUpdate) then
                  Abort;

               AddVersoes;

               dmVersoes.cdsVersoes.Next;
            end;

            DiretorioFontes := dmVersoes.cdsVersoesDFON_VER.AsString;

         finally
            if (Ponteiro <> nil) and (dmVersoes.cdsVersoes.BookmarkValid(Ponteiro)) then
            begin
               dmVersoes.cdsVersoes.GotoBookmark(Ponteiro);
               dmVersoes.cdsVersoes.FreeBookmark(Ponteiro);
            end;

            dmVersoes.cdsVersoes.Filtered := False;
            dmVersoes.cdsVersoes.Filter   := '';
         end;
      end
      else
      begin
         if not Valida(taUpdate) then
         begin
            Abort;
         end;

         AddVersoes;

         DiretorioFontes := dmVersoes.cdsVersoesDFON_VER.AsString;
      end;

      Arquivo.SaveToFile(ExtractFileDir(Application.ExeName) + '\updateSVN.bat');

      LimparLog1Click(nil);

      RunDosInMemo(ExtractFileDir(Application.ExeName) + '\updateSVN.bat', ExtractFileDrive(DiretorioFontes), mmoLog, False);

   finally
      FreeAndNil(Arquivo);

      dmVersoes.cdsVersoes.EnableControls;
   end;
end;

procedure TfrmPrincipal.GeraArquivoBatZipAll;
var
   Arquivo,
   lListaArquivos: TStrings;
   DiretorioFontes: string;

   procedure AddArquivo;
   begin
      Arquivo.Add(ExtractFileDrive(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP));
      Arquivo.Add('cd ' + dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP);
      Arquivo.Add('"' + dmParametros.cdsParametrosSZIP_CFG.AsString + '" ' +
                  PARAMS_7Z + ' ' +
                  RetornaBranchAtual(True) + '.exe ' + //'_byALXCompiler.exe ' +
                  '"' + dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + '\*.exe" ' +
                  '"' + dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + '\*.map"');
   end;

begin

   Arquivo := TStringList.Create;

   try

      lListaArquivos := TStringList.Create;

      try

         lListaArquivos := TALXArquivos.ListarArquivos(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP);

         if lListaArquivos.Count > 0 then
         begin
            DiretorioFontes := dmVersoes.cdsVersoesDFON_VER.AsString;

            AddArquivo;

            Arquivo.SaveToFile(ExtractFileDir(Application.ExeName) + '\' + 'zip_all.bat');

            LimparLog1Click(nil);

            RunDosInMemo(ExtractFileDir(Application.ExeName) + '\' + 'zip_all.bat', ExtractFileDrive(DiretorioFontes), mmoLog, False);
         end;

      finally
         FreeAndNil(lListaArquivos);
      end;

   finally
      FreeAndNil(Arquivo);
   end;
end;

procedure TfrmPrincipal.GeraArquivoBatGIT(ATipoAcao: TTipoAcao);
var
   Arquivo: TStringList;
   DiretorioFontes,
   ComandoGIT: String;

   procedure AddArquivo;
   begin
      Arquivo.Add('"' + dmParametros.cdsParametrosTGIT_CFG.AsString + '"' + ' /command:' + ComandoGIT + ' /path:"' + DiretorioFontes + '"');
   end;

begin
   if not Valida(ATipoAcao) then
      Abort;

   case ATipoAcao of
      taCommit: ComandoGIT := 'commit';
      taStatus: ComandoGIT := 'diff';
      taPush: ComandoGIT := 'push';
      taPull: ComandoGIT := 'pull';
      taRebase: ComandoGIT := 'rebase';
      taMerge: ComandoGIT := 'merge';
      taRefLog: ComandoGIT := 'reflog';
      taRefBrowse: ComandoGIT := 'refbrowse';
      taSwitch: ComandoGIT := 'switch';
      else
      begin
         Application.MessageBox('Operação não suportada!', 'ALXCompiler', MB_OK + MB_ICONERROR);
         Abort;
      end;
   end;

   Arquivo := TStringList.Create;

   try
      DiretorioFontes := dmVersoes.cdsVersoesDFON_VER.AsString;

      AddArquivo;

      Arquivo.SaveToFile(ExtractFileDir(Application.ExeName) + '\' + ComandoGIT + 'GIT.bat');

      LimparLog1Click(nil);

      RunDosInMemo(ExtractFileDir(Application.ExeName) + '\' + ComandoGIT + 'GIT.bat', ExtractFileDrive(DiretorioFontes), mmoLog, False);

   finally
      FreeAndNil(Arquivo);
   end;
end;

procedure TfrmPrincipal.GeraArquivoBatGITPrompt(AExecutarPatchFile: Boolean = False);
var
   Arquivo: TStringList;
   DiretorioFontes,
   ComandoGIT,
   lNomeArquivo: String;

   procedure AddArquivo;
   var
      lPatchFile: string;
   begin
      lPatchFile := '';

      if AExecutarPatchFile then
      begin
         lPatchFile := '"' + ExtractFileDir(ParamStr(0)) + '\patchfile.txt"';
      end;

      Arquivo.Add(ExtractFileDrive(dmVersoes.cdsVersoesDFON_VER.AsString));
      Arquivo.Add('cd' + Copy(dmVersoes.cdsVersoesDFON_VER.AsString, Pos('\', dmVersoes.cdsVersoesDFON_VER.AsString), Length(dmVersoes.cdsVersoesDFON_VER.AsString)));
      Arquivo.Add('cls');
      Arquivo.Add('cmd.exe /c ""' + dmParametros.cdsParametrosSGIT_CFG.AsString + '" --login -i ' + lPatchFile + '"');
   end;

begin
   if not Valida(taPrompt) then
      Abort;

   Arquivo := TStringList.Create;

   try
      DiretorioFontes := dmVersoes.cdsVersoesDFON_VER.AsString;

      AddArquivo;

      lNomeArquivo := 'PromptGIT.bat';

      if AExecutarPatchFile then
      begin
         lNomeArquivo := 'PromptPatchFileGIT.bat';
      end;

      Arquivo.SaveToFile(ExtractFileDir(Application.ExeName) + '\' + ComandoGIT + lNomeArquivo);

      LimparLog1Click(nil);

      TALXFuncoes.ExecAndWait(PChar(ExtractFileDir(Application.ExeName) + '\' + ComandoGIT + lNomeArquivo), SW_SHOWNORMAL);

   finally
      FreeAndNil(Arquivo);
   end;
end;

procedure TfrmPrincipal.GeraArquivoBatSVN(ATipoAcao: TTipoAcao;
   ADiretorioSVN: TDiretorioSVN);
var
   Arquivo: TStringList;
   DiretorioFontes,
   ComandoSVN: String;

   procedure AddArquivo;
   begin
      Arquivo.Add('"' + dmParametros.cdsParametrosTSVN_CFG.AsString + '"' + ' /command:' + ComandoSVN + ' /path:"' + DiretorioFontes + '"');
   end;

begin
   if not Valida(ATipoAcao) then
      Abort;

   case ATipoAcao of
      taCommit: ComandoSVN := 'commit';
      taStatus: ComandoSVN := 'repostatus';
      else
      begin
         Application.MessageBox('Operação não suportada!', 'ALXCompiler', MB_OK + MB_ICONERROR);
         Abort;
      end;
   end;

   Arquivo := TStringList.Create;

   try
      if ADiretorioSVN = dsRevendaWindows then
         DiretorioFontes := dmVersoes.cdsVersoesDREV_VER.AsString
      else
         DiretorioFontes := dmVersoes.cdsVersoesDGER_VER.AsString;

      AddArquivo;

      Arquivo.SaveToFile(ExtractFileDir(Application.ExeName) + '\' + ComandoSVN + 'SVN.bat');

      LimparLog1Click(nil);

      RunDosInMemo(ExtractFileDir(Application.ExeName) + '\' + ComandoSVN + 'SVN.bat', ExtractFileDrive(DiretorioFontes), mmoLog, False);

   finally
      FreeAndNil(Arquivo);
   end;
end;

procedure TfrmPrincipal.Geral3Click(Sender: TObject);
begin
   StatusSVN(dsGeral);
end;

procedure TfrmPrincipal.GeraPatchFile;
var
   lListaTemp: TStrings;
begin

   lListaTemp := TStringList.Create;

   try

      lListaTemp.Add('git branch |grep ^*|sed "s/* //" > "' + ExtractFileDir(ParamStr(0)) + '\branch_atual.txt"');

      lListaTemp.SaveToFile(ExtractFileDir(ParamStr(0)) + '\patchfile.txt');

   finally
      FreeAndNil(lListaTemp);
   end;
end;

function TfrmPrincipal.GerarZipSeparado: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosEXEC_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

procedure TfrmPrincipal.GerarLinks(ARaiz, AVersao, ADiretorio: string; AModulos: TClientDataSet);
var
   lIndex: Integer;
   lFiltroIni: string;
   lListaLinks,
   lListaAux: TStrings;
   lPosicaoAtual: TBookmark;
begin

   AModulos.DisableControls;

   lPosicaoAtual := AModulos.GetBookmark;

   try

      lFiltroIni := AModulos.Filter;

      AModulos.Filtered := false;
      AModulos.Filter := 'SELECIONA';

      AModulos.Filter := AModulos.Filter + ' and STATUS = ''T''';

      AModulos.Filtered := true;

      if (AModulos.IsEmpty) then
      begin
         Exit;
      end;

      lListaLinks := TStringList.Create;

      try

         lListaAux := TStringList.Create;

         try

            if GerarZipSeparado then
            begin
               AModulos.First;
               while not AModulos.Eof do
               begin
                  if (UpperCase(Copy(AModulos.FieldByName('WANT_MOD').AsString, 1, 5))) <> (UpperCase('login')) then
                  begin
                     lListaLinks.Add(ARaiz +
                                     '/' +
                                     TALXFuncoes.RetornaAlfaNumerico(AVersao) +
                                     '/' +
                                     'sagr' + AModulos.FieldByName('WANT_MOD').AsString +
                                     FormatDateTime('ddmmyyyy', Now) +
                                     '.exe');
                  end
                  else
                  begin
                     lListaAux.Add(AModulos.FieldByName('WANT_MOD').AsString);
                  end;

                  AModulos.Next;
               end;

               for lIndex := 0 to lListaAux.Count - 1 do
               begin
                  lListaLinks.Insert(lindex,
                                     ARaiz +
                                     '/' +
                                     TALXFuncoes.RetornaAlfaNumerico(AVersao) +
                                     '/' +
                                     lListaAux[lIndex] +
                                     FormatDateTime('ddmmyyyy', Now) +
                                     '.exe');
               end;
            end;

            if GerarZipUnico then
            begin
               lListaLinks.Add(ARaiz +
                               '/' +
                               TALXFuncoes.RetornaAlfaNumerico(AVersao) +
                               '/' +
                               RetornaBranchAtual(True) +
                               '.exe');
            end;

            lListaLinks.SaveToFile(ADiretorio +
                                   '\links_' +
                                   FormatDateTime('ddmmyyyy', Now) + '_' +
                                   FormatDateTime('hhmmss', Now) + '.txt');

            finally
               FreeAndNil(lListaAux);
            end;

      finally
         FreeAndNil(lListaLinks);
      end;

   finally

      if (lPosicaoAtual <> nil) and (AModulos.BookmarkValid(lPosicaoAtual)) then
      begin
         AModulos.GotoBookmark(lPosicaoAtual);
         AModulos.FreeBookmark(lPosicaoAtual);
      end;

      AModulos.Filtered := false;
      AModulos.Filter := lFiltroIni;
      AModulos.Filtered := True;

      AModulos.EnableControls;
   end;
end;

function TfrmPrincipal.GerarLinksParaDownload: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosGLNK_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

function TfrmPrincipal.GerarZipUnico: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosALLC_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

procedure TfrmPrincipal.GeraWantConfIni(ADataHora, ADataHoraAux: string);
var
   lDiretorioExe: string;
   lListaArquivo: TStringList;
begin

   lListaArquivo := TStringList.Create;

   try

      GeraBackupWantConfIni;

      lDiretorioExe := dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP;

      lListaArquivo.Add('[dir]');
      lListaArquivo.Add('bin = ' + lDiretorioExe);
      lListaArquivo.Add('zip = ' + lDiretorioExe + ZIP);
      lListaArquivo.Add('');
      lListaArquivo.Add('[date]');
      lListaArquivo.Add('datahora = ' + ADataHora);
      lListaArquivo.Add('datahoraaux = ' + ADataHoraAux);
      lListaArquivo.Add('');
      lListaArquivo.Add('[info]');
      lListaArquivo.Add('versao = ' + dmVersoes.cdsVersoesVERS_VER.AsString);
      lListaArquivo.Add('branch = ' + RetornaBranchAtual(True));

      lListaArquivo.SaveToFile(dmVersoes.cdsVersoesDREV_VER.AsString + '\wantconf.ini');

   finally
      FreeAndNil(lListaArquivo);
   end;
end;

procedure TfrmPrincipal.HabilitaDesabilitaComponentes(AAtivar: Boolean);
begin
   btnIncluirVer.Enabled        := AAtivar;
   btnAlterarVer.Enabled        := AAtivar;
   btnExcluirVer.Enabled        := AAtivar;
   btnPesquisarVer.Enabled      := AAtivar;
   btnIncluirMod.Enabled        := AAtivar;
   btnAlterarMod.Enabled        := AAtivar;
   btnExcluirMod.Enabled        := AAtivar;
   btnSelecionarModulos.Enabled := AAtivar;
   btnCompilar.Enabled          := AAtivar;
   chkMarcarDesmarcar.Enabled   := AAtivar;
   AdvMainMenu1.Items.Enabled   := AAtivar;
   pnlInfo.Enabled              := AAtivar;
end;

function TfrmPrincipal.HaVersaoCadastrada: Boolean;
begin
   Result := true;

   if dmVersoes.cdsVersoes.IsEmpty then
   begin
      if FUtilizarAgente then
      begin
         FAgente.Show(False);
         FAgente.Speak('Nenhuma versão cadastrada!', EmptyStr);
         FAgente.Hide(False);
      end;

      Application.MessageBox('Nenhuma versão cadastrada!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

      Result := false;
   end;
end;

procedure TfrmPrincipal.JvTrayIcon1BalloonClick(Sender: TObject);
begin
   try

      RestaurarAplicacao;

      case JvTrayIcon1.Tag of
         2: { Messenger }
         begin
            frmPrincipal.JvTrayIcon1.Animated  := False;
            frmPrincipal.JvTrayIcon1.IconIndex := -1;

            frmMessenger.Show;
         end;
      end;

   finally
      JvTrayIcon1.Tag := 0;
   end;
end;

procedure TfrmPrincipal.JvTrayIcon1DblClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   RestaurarAplicacao;
end;

procedure TfrmPrincipal.LimparLog1Click(Sender: TObject);
begin
   mmoLog.Clear;
end;

procedure TfrmPrincipal.Linhadecomando1Click(Sender: TObject);
begin
   GeraArquivoBatGITPrompt;
end;

procedure TfrmPrincipal.MenuItem1Click(Sender: TObject);
begin
   RestaurarAplicacao;
end;

procedure TfrmPrincipal.Merge1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taMerge);
end;

procedure TfrmPrincipal.Messenger1Click(Sender: TObject);
begin
   frmMessenger.Show;
end;

procedure TfrmPrincipal.Minimizarparaabandejadowindows1Click(Sender: TObject);
begin
   JvTrayIcon1.HideApplication;

   if FUtilizarAgente then
   begin
      FAgente.Show(False);
      FAgente.Speak('O ALXCompiler ainda está ativo! Caso deseje realmente finalizá-lo, clique no menu "Arquivo", e em seguida em "Sair". Ou, clique com o botão secundário do mouse sobre este ícone, e em seguida em "Sair".', EmptyStr);
      FAgente.Hide(False);
   end;

   JvTrayIcon1.BalloonHint('Compilador', 'O ALXCompiler ainda está ativo! Caso deseje realmente finalizá-lo, clique no menu "Arquivo", e em seguida em "Sair". Ou, clique com o botão secundário do mouse sobre este ícone, e em seguida em "Sair".', btInfo, 6000);
end;

function TfrmPrincipal.Obrigatorio(AComponente: TWinControl;
  AName: String): Boolean;
begin
   Result := false;

   if (Screen.ActiveControl.Name = 'btnCancelar') or
      (Screen.ActiveControl.Name = 'btnSair') then
      Exit;

   if AComponente is TDBLookupComboBox then
   begin
      if TDBLookupComboBox(AComponente).Text = '' then
      begin
         if FUtilizarAgente then
         begin
            FAgente.Show(False);
            FAgente.Speak('O campo ' + AName + ' deve ser informado!', EmptyStr);
            FAgente.Hide(False);
         end;

         Application.MessageBox(PChar('O campo ' + AName + ' deve ser informado!'), 'ALXCompiler', MB_OK + MB_ICONINFORMATION);

         TDBLookupComboBox(AComponente).SetFocus;
         Result := true;
      end;
   end;
end;

procedure TfrmPrincipal.odasasverses2Click(Sender: TObject);
begin
   CommitSVN;
end;

procedure TfrmPrincipal.odasasverses3Click(Sender: TObject);
begin
   UpdateSVN(True);
end;

procedure TfrmPrincipal.Parmetros1Click(Sender: TObject);
begin
   frmParametros := TfrmParametros.Create(Self,
                                          dmParametros.cdsParametros,
                                          tmAlterar);
   frmParametros.ShowModal;
end;

procedure TfrmPrincipal.Pull1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taPull);
end;

procedure TfrmPrincipal.PreCompilacaoGIT(AAcao: TTipoAcao);
begin
   if HaVersaoCadastrada then
   begin
      if Obrigatorio(cbxVersao, 'versão') then
         Exit;

      try

         HabilitaDesabilitaComponentes(False);

         case AAcao of
            taPull:
            begin
               GeraArquivoBatGIT(taPull);
            end;
            taSwitch:
            begin
               GeraArquivoBatGIT(taSwitch);
            end;
         end;

      finally
         HabilitaDesabilitaComponentes;
      end;
   end;
end;

procedure TfrmPrincipal.Push1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taPush);
end;

procedure TfrmPrincipal.Rebase1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taRebase);
end;

function TfrmPrincipal.ReConectouFTP(AHost, AUsuario, ASenha: string;
   AFTP: TIdFTP): Boolean;
begin
   Result := False;

   if AFTP.Connected then
   begin
      AFTP.Disconnect;
   end;

   AFTP.Host     := AHost;
   AFTP.Username := AUsuario;
   AFTP.Password := ASenha;

   try

      AFTP.Connect;

      Result := AFTP.Connected;

   except
      on E: Exception do
      begin
         TALXFuncoes.Aviso('Não foi possível estabelecer conexão com o FTP! ' + #13 +
                           'Mensagem do erro: ' + E.Message + #13 +
                           'Classe do erro: ' + E.ClassName);
      end;
   end;
end;

procedure TfrmPrincipal.Refbrowse1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taRefBrowse);
end;

procedure TfrmPrincipal.Reflog1Click(Sender: TObject);
begin
   GeraArquivoBatGIT(taRefLog);
end;

function TfrmPrincipal.RequisicaoPendente(ACODI_USU: Integer; ABranch: string): Boolean;
var
   lsqqRequisicaoPendente: TSQLQuery;
begin
   Result := False;

   lsqqRequisicaoPendente := TSQLQuery.Create(nil);

   try

      lsqqRequisicaoPendente.SQLConnection := dmPrincipal.sqcCompilador;

      lsqqRequisicaoPendente.Close;
      lsqqRequisicaoPendente.SQL.Clear;
      lsqqRequisicaoPendente.SQL.Add('select count(REQ.CODI_REQ) as QTD ' +
                                     'from REQUISICAO REQ ' +
                                     'where (REQ.CODI_USU = :CODI_USU) and ' +
                                     '      (REQ.BRAN_REQ = :BRAN_REQ)');
      lsqqRequisicaoPendente.Params.ParamByName('CODI_USU').AsInteger := ACODI_USU;
      lsqqRequisicaoPendente.Params.ParamByName('BRAN_REQ').AsString  := ABranch;
      lsqqRequisicaoPendente.Open;

      if lsqqRequisicaoPendente.FieldByName('QTD').AsInteger > 0 then
      begin
         Result := True;
         TALXFuncoes.Aviso('Aguarde, você já requisitou a compilação deste branch!');
      end;

   finally
      FreeAndNil(lsqqRequisicaoPendente);
   end;
end;

function TfrmPrincipal.RequisitarCompilacaoRemota(ACODI_USU: Integer; ANOME_USU, ABranch, ADiretorio: string): Boolean;
begin
   {Result := False;

   TcpClient1.RemoteHost := AIPServidor;
   TcpClient1.RemotePort := PORTA_MESSENGER;

   try

      if TcpClient1.Connect then
      begin
         TcpClient1.Sendln(TAG_COMPILACAO_REMOTA + ';' + ACODI_USU + ';' + ANOME_USU + ';' + ABranch + ';' + ADiretorio);

         Result := True;

         TALXFuncoes.Aviso('Compilação requisitada com sucesso!');
      end
      else
      begin
         TALXFuncoes.Aviso('Não foi possível requisitar a compilação no servidor remoto!');
      end;

   finally
      frmPrincipal.TcpClient1.RemoteHost := '';
      frmPrincipal.TcpClient1.RemotePort := '';
   end;}

   Result := False;

   if not RequisicaoPendente(ACODI_USU, ABranch) then
   begin
      dmCompilacaoRemota.cdsRequisicoes.Append;

      dmCompilacaoRemota.cdsRequisicoesCODI_USU.AsInteger  := ACODI_USU;
      dmCompilacaoRemota.cdsRequisicoesBRAN_REQ.AsString   := ABranch;
      dmCompilacaoRemota.cdsRequisicoesDIRE_REQ.AsString   := ADiretorio;
      dmCompilacaoRemota.cdsRequisicoesDATA_REQ.AsDateTime := Now;
      dmCompilacaoRemota.cdsRequisicoesHORA_REQ.AsDateTime := Now;

      if dmCompilacaoRemota.cdsRequisicoes.ApplyUpdates(-1) > 0 then
      begin
         TALXFuncoes.Aviso('Não foi possível requisitar a compilação!', bmOk, imErro);
      end
      else
      begin
         TALXFuncoes.Aviso('Compilação requisitada com sucesso!');

         Result := True;
      end;
   end;
end;

procedure TfrmPrincipal.RestauraBackupWantConfIni;
var
   lArquivo: TStrings;
begin

   lArquivo := TStringList.Create;

   try

      lArquivo.LoadFromFile(dmVersoes.cdsVersoesDREV_VER.AsString + '\wantconf.ini');

      lArquivo.SaveToFile( ExtractFileDir(ParamStr(0)) + '\wantconf.ini~~');

      lArquivo.LoadFromFile( ExtractFileDir(ParamStr(0)) + '\wantconf.ini~');

      lArquivo.SaveToFile(dmVersoes.cdsVersoesDREV_VER.AsString + '\wantconf.ini');

   finally
      FreeAndNil(lArquivo);
   end;

end;

procedure TfrmPrincipal.RestaurarAplicacao;
begin

   JvTrayIcon1.ShowApplication;

   if not Application.Active then
      TALXFuncoes.ForceForegroundWindow(Application.Handle);

end;

function TfrmPrincipal.RetornaBranchAtual(ASemPontoSVN: Boolean = False): string;
var
   lListaBranchLocal: TStrings;
begin
   Result := '';

   if dmVersoes.cdsVersoesGVPD_VER.AsString = 'GIT' then
   begin
      lListaBranchLocal := TStringList.Create;

      try

         lListaBranchLocal.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\branch_atual.txt');

         Result := lListaBranchLocal[0];

      finally
         FreeAndNil(lListaBranchLocal);
      end;
   end
   else
   begin
      if ASemPontoSVN then
      begin
         Result := TALXFuncoes.RetornaAlfaNumerico(dmVersoes.cdsVersoesVERS_VER.AsString);
      end
      else
      begin
         Result := dmVersoes.cdsVersoesVERS_VER.AsString;
      end;
   end;
end;

function TfrmPrincipal.RetornaDiretivas: string;
var
   lDiretivas: string;
begin
   lDiretivas := '';

   try

      dmDiretivas.cdsDiretivas.First;

      dmDiretivas.cdsDiretivas.DisableControls;

      dmDiretivas.cdsDiretivas.Filtered := false;
      dmDiretivas.cdsDiretivas.Filter := 'SELECIONA';
      dmDiretivas.cdsDiretivas.Filtered := true;

      while not (dmDiretivas.cdsDiretivas.Eof) do
      begin
         lDiretivas := lDiretivas + ' -D' + dmDiretivas.cdsDiretivasDIRE_DTV.AsString + '=1 ';

         dmDiretivas.cdsDiretivas.Next;
      end;

      Result := lDiretivas;

   finally
      dmDiretivas.cdsDiretivas.Filtered := false;
      dmDiretivas.cdsDiretivas.Filter := '';

      dmDiretivas.cdsDiretivas.First;

      dmDiretivas.cdsDiretivas.EnableControls;
   end;
end;

procedure TfrmPrincipal.RevendaWindows3Click(Sender: TObject);
begin
   StatusSVN;
end;

procedure TfrmPrincipal.rocardeUsurio1Click(Sender: TObject);
var
   lValidaInicializao: TValidaInicializacao;
begin
   lValidaInicializao := TValidaInicializacao.Create;

   try

      if lValidaInicializao.Logou then
      begin
         AbreClientDataSets;
      end;

   finally
      FreeAndNil(lValidaInicializao);

      stbInfo.Panels[0].Text := dmInfoDB.cdsInfoDBEMPR_INF.AsString;
      stbInfo.Panels[1].Text := NOME_USU;
   end;
end;

procedure TfrmPrincipal.RunDosInMemo(DosApp, ADirDefault: String; AMemo: TJvMemo; AIsDosApp: Boolean = True);
const
  ReadBufferSize = 4096;
var
  Security            : TSecurityAttributes;
  ReadPipe,WritePipe  : THandle;
  start               : TStartUpInfo;
  ProcessInfo         : TProcessInformation;
  Buffer              : Pchar;
  BytesRead           : DWORD;
  Apprunning,
  BytesLeftThisMessage,
  TotalBytesAvail : integer;
  Retorno: cardinal;
  lMsgErro: string;
begin
  lMsgErro := '';

  with Security do
  begin
    nlength              := SizeOf(TSecurityAttributes);
    binherithandle       := true;
    lpsecuritydescriptor := nil;
  end;

  if CreatePipe (ReadPipe, WritePipe, @Security, 0) then
  begin
    // Redirect In- and Output through STARTUPINFO structure

    Buffer  := AllocMem(ReadBufferSize + 1);
    FillChar(Start,Sizeof(Start),#0);
    start.cb          := SizeOf(start);
    start.hStdOutput  := WritePipe;
    start.hStdInput   := ReadPipe;
    start.dwFlags     := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    // Create a Console Child Process with redirected input and output

    if CreateProcess(nil      ,PChar(DosApp),
                     @Security,@Security,
                     true     ,CREATE_NO_WINDOW or NORMAL_PRIORITY_CLASS,
                     nil      ,Pchar(ADirDefault),
                     start    ,ProcessInfo) then
    begin

      repeat
        // wait for end of child process
        Apprunning := WaitForSingleObject(ProcessInfo.hProcess,100);

        // it is important to read from time to time the output information
        // so that the pipe is not blocked by an overflow. New information
        // can be written from the console app to the pipe only if there is
        // enough buffer space.

        if not PeekNamedPipe(ReadPipe        ,@Buffer[0],
                             ReadBufferSize  ,@BytesRead,
                             @TotalBytesAvail,@BytesLeftThisMessage) then break
        else if BytesRead > 0 then
          ReadFile(ReadPipe,Buffer[0],ReadBufferSize,BytesRead,nil);

        Buffer[BytesRead]:= #0;
        OemToChar(Buffer,Buffer);

        if Trim(StrPas(Buffer)) <> '' then
        begin
          AMemo.Lines.Add(StrPas(Buffer));
          AMemo.LineScroll(0, AMemo.Lines.Count);
        end;

        Application.ProcessMessages;

      until (Apprunning <> WAIT_TIMEOUT);

      Retorno := 0;
      GetExitCodeProcess(ProcessInfo.hProcess, Retorno);

      if (Retorno <> 0) and (AIsDosApp) then
      begin
         lMsgErro := 'Não foi possível executar o comando:' + #13 +  '"' + ADirDefault + '> ' + DosApp + '"' + #13;

         AMemo.Lines.Add(lMsgErro);
         AMemo.LineScroll(0, AMemo.Lines.Count);

         if FUtilizarAgente then
         begin
            FAgente.Show(False);
            FAgente.Speak(lMsgErro, EmptyStr);
            FAgente.Hide(False);
         end;

         if not TALXFuncoes.Aviso(lMsgErro + #13 + 'Deseja realmente prosseguir?', bmSimNao, imPergunta) then
         begin
            Abort;
         end;

      end

    end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
end;

function TfrmPrincipal.EnviarArquivosZipSeparadamenteFTP: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosEFTP_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

function TfrmPrincipal.EnviarArquivoZipUnicoFTP: Boolean;
begin
   Result := False;

   if dmParametros.cdsParametrosAFTP_CFG.AsString = 'S' then
   begin
      Result := True;
   end;
end;

function TfrmPrincipal.AtualizarArquivosFTP(AHost, AUsuario, ASenha, ADiretorioRemoto: string;
   AFTP: TIdFTP; AListaArquivosExistentes: TStringList; AModulos: TClientDataSet;
   AMemo: TJvMemo): Boolean;
var
   lIndex,
   lIndexAux: Integer;
   lFiltroIni,
   lDiretorioLocal,
   lArquivoExistente,
   lArquivoAEnviar: string;
   lArquivosAtualizados: Boolean;
   lListaArquivosAEnviar,
   lListaAux: TStrings;
   lPosicaoAtual: TBookmark;
begin

   Result := False;

   lArquivosAtualizados := False;

   AModulos.DisableControls;

   lPosicaoAtual := AModulos.GetBookmark;

   try

      lFiltroIni := AModulos.Filter;

      AModulos.Filtered := false;
      AModulos.Filter := 'SELECIONA';

      AModulos.Filter := AModulos.Filter + ' and STATUS = ''T''';

      AModulos.Filtered := true;

      if (AModulos.IsEmpty) then
      begin
         Exit;
      end;

      lListaArquivosAEnviar := TStringList.Create;

      try

         lListaAux := TStringList.Create;

         try

            lDiretorioLocal := dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP;

            if EnviarArquivosZipSeparadamenteFTP then
            begin
               AModulos.First;
               while not AModulos.Eof do
               begin
                  if (UpperCase(Copy(AModulos.FieldByName('WANT_MOD').AsString, 1, 5))) <> (UpperCase('login')) then
                  begin
                     lListaArquivosAEnviar.Add(lDiretorioLocal +
                                               '\' +
                                               'sagr' + AModulos.FieldByName('WANT_MOD').AsString +
                                               FormatDateTime('ddmmyyyy', Now) +
                                               '.exe');
                  end
                  else
                  begin
                     lListaAux.Add(AModulos.FieldByName('WANT_MOD').AsString);
                  end;

                  AModulos.Next;
               end;

               for lIndex := 0 to lListaAux.Count - 1 do
               begin
                  lListaArquivosAEnviar.Insert(lindex,
                                               lDiretorioLocal +
                                               '\' +
                                               lListaAux[lIndex] +
                                               FormatDateTime('ddmmyyyy', Now) +
                                               '.exe');
               end;
            end;

            if EnviarArquivoZipUnicoFTP then
            begin
               lListaArquivosAEnviar.Add(lDiretorioLocal +
                                         '\' +
                                         RetornaBranchAtual(True) +
                                         '.exe');
            end;

            for lIndex := 0 to lListaArquivosAEnviar.Count - 1 do
            begin

               lArquivosAtualizados := True;

               for lIndexAux := 0 to AListaArquivosExistentes.Count - 1 do
               begin
                  lArquivoExistente := TALXFuncoes.RetornaApenasAlfa(LowerCase(AListaArquivosExistentes[lIndexAux]));

                  lArquivoAEnviar := TALXFuncoes.RetornaApenasAlfa(LowerCase(ExtractFileName(lListaArquivosAEnviar[lIndex])));

                  if lArquivoExistente = lArquivoAEnviar then
                  begin
                     AMemo.Lines.Add('Removendo: ' + AListaArquivosExistentes[lIndexAux]);

                     while not ReConectouFTP(AHost, AUsuario, ASenha, AFTP) do
                     begin
                        if not TALXFuncoes.Aviso('Não foi possível remover o arquivo: ' + #13 +
                                                 AListaArquivosExistentes[lIndex] + #13 +
                                                 'Deseja tentar novamente?', bmSimNao, imPergunta) then
                        begin
                           TALXFuncoes.Aviso('Não foi possível transferir todos os arquivos para o FTP!' + #13 +
                                             'Portanto, será necessário transferí-los manualmente.');
                           lArquivosAtualizados := False;
                           Exit;
                        end;
                     end;

                     AFTP.ChangeDir(ADiretorioRemoto);

                     AFTP.Delete(AListaArquivosExistentes[lIndexAux]);
                  end;

                  Application.ProcessMessages;
               end;

               AMemo.Lines.Add('Enviando: ' + lListaArquivosAEnviar[lIndex]);

               {if not ReConectouFTP(AHost, AUsuario, ASenha, AFTP) then
               begin
                  Exit;
               end;}

               while not ReConectouFTP(AHost, AUsuario, ASenha, AFTP) do
               begin
                  if not TALXFuncoes.Aviso('Não foi possível enviar o arquivo: ' + #13 +
                                           lListaArquivosAEnviar[lIndex] + #13 +
                                           'Deseja tentar novamente?', bmSimNao, imPergunta) then
                  begin
                     TALXFuncoes.Aviso('Não foi possível transferir todos os arquivos para o FTP!' + #13 +
                                       'Portanto, será necessário transferí-los manualmente.');
                     lArquivosAtualizados := False;
                     Exit;
                  end;
               end;

               AFTP.ChangeDir(ADiretorioRemoto);

               AFTP.Put(lListaArquivosAEnviar[lIndex]);

               Application.ProcessMessages;
            end;

            Result := lArquivosAtualizados;

            finally
               FreeAndNil(lListaAux);
            end;

      finally
         FreeAndNil(lListaArquivosAEnviar);
      end;

   finally

      if (lPosicaoAtual <> nil) and (AModulos.BookmarkValid(lPosicaoAtual)) then
      begin
         AModulos.GotoBookmark(lPosicaoAtual);
         AModulos.FreeBookmark(lPosicaoAtual);
      end;

      AModulos.Filtered := false;
      AModulos.Filter := lFiltroIni;
      AModulos.Filtered := True;

      AModulos.EnableControls;
   end;
end;

procedure TfrmPrincipal.ExecutarAntesDeSair;
begin
   TALXCompilerFuncoesDB.AtualizarSituacaoUsuario(CODI_USU, False);

   AtualizarUltimaVersao;

   if FUtilizarAgente then
   begin
      FAgente.Show(False);
      FAgente.Speak('Obrigado por utilizar o ALXCompiler! Até a próxima...', EmptyStr);
      FAgente.Play('Wave');
      FAgente.Hide(false);

      Agent1.Characters.Unload(FNomeAgente);

      Agent1.Connected := False;
   end;
end;

procedure TfrmPrincipal.Sair2Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmPrincipal.SalvarLog2Click(Sender: TObject);
begin
   if SaveDialogSalvar.Execute then
      mmoLog.Lines.SaveToFile(SaveDialogSalvar.FileName + '.txt');
end;

procedure TfrmPrincipal.Sobre2Click(Sender: TObject);
begin
   frmSobre := TfrmSobre.Create(Self);
   frmSobre.ShowModal;
end;

procedure TfrmPrincipal.StatusSVN(ADiretorioSVN: TDiretorioSVN);
begin
   if HaVersaoCadastrada then
   begin
      if Obrigatorio(cbxVersao, 'versão') then
         Exit;

      try

         HabilitaDesabilitaComponentes(False);

         GeraArquivoBatSVN(taStatus, ADiretorioSVN);

      finally
         HabilitaDesabilitaComponentes;
      end;
   end;
end;

procedure TfrmPrincipal.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
var
  s: string;
  DataThread: TClientDataThread;
  lRemetente: String;
  lCODI_USU: string;
begin
  lCODI_USU := TALXCompilerFuncoesDB.RetornaInformacesConfig('IPRD_CFG', 'CODI_USU', ClientSocket.RemoteHost);

  lRemetente := TALXCompilerFuncoesDB.RetornaInformacoesUsuario('CODI_USU', 'NOME_USU', lCODI_USU);

  // create thread
  DataThread:= TClientDataThread.Create(true);
  // set the TagetList to the gui list that you
  // with to synch with.
  DataThread.TargetList := frmMessenger.mmoLogMessenger.lines;

  // Load the Threads ListBuffer
  //DataThread.ListBuffer.Add('*** Conexão Iniciada ***');
  DataThread.ListBuffer.Add(lRemetente
                            {ClientSocket.LookupHostName(ClientSocket.RemoteHost) +
                            ' (' + ClientSocket.RemoteHost + ')'});
  s := ClientSocket.Receiveln;
  while s <> '' do
  begin
    DataThread.ListBuffer.Add(s);
    s := ClientSocket.Receiveln;
  end;
  DataThread.ListBuffer.Add(DateTimeToStr(Now));
  DataThread.ListBuffer.Add('');

  // Call Resume which will execute and synch the
  // ListBuffer with the TargetList
  DataThread.Resume;

  if not frmMessenger.Active then
  begin
    JvTrayIcon1.Tag := 2;

    JvTrayIcon1.BalloonHint('Compilador - Messenger', 'Você recebeu uma nova mensagem de ' + lRemetente + '!', btInfo, 10000);
    JvTrayIcon1.Animated := True;
  end;

  frmMessenger.mmoLogMessenger.LineScroll(0, frmMessenger.mmoLogMessenger.Lines.Count);
end;

procedure TfrmPrincipal.teste11Click(Sender: TObject);
begin
   if OpenDialogCarregar.Execute then
   begin
      LimparLog1Click(Sender);

      mmoLog.Lines.LoadFromFile(OpenDialogCarregar.FileName);
   end;
end;

function TfrmPrincipal.UsuarioPossuiLicenca: Boolean;
var
   lAccessData,
   lProgramaReg,
   lClienteReg,
   lDataReg,
   lDiasReg,
   lClienteDB,
   lDataDB,
   lDataDBReg: string;
   lDiasDB: Integer;
   lDataAtual: TDateTime;
   lsqqAuxiliar: TSQLQuery;
begin

   Result := False;

   {$IFDEF TESTE}
      Result := True;
      Exit;
   {$ENDIF}

   lAccessData := TALXFuncoes.LeRegistro(HKEY_CURRENT_USER,
                                         'Software\ALXCompiler',
                                         'AccessData');

   if lAccessData = '' then
   begin
      TALXFuncoes.Aviso('Acesso negado: licença do usuário não encontrada!' + #13 +
                        'Para maiores informações entre em contato com o desenvolvedor:' + #13 +
                        'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                        'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                        'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                        'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imErro);

      Exit;
   end;

   lDataAtual := TALXCompilerFuncoesDB.RetornaDataServidor;

   lAccessData := TALXFuncoes.Descriptografa(lAccessData);

   lProgramaReg := TALXFuncoes.Criptografa(ExtractDelimited(1, lAccessData, [';']));
   lClienteReg  := ExtractDelimited(2, lAccessData, [';']);
   lDataReg     := ExtractDelimited(3, lAccessData, [';']);
   lDiasReg     := ExtractDelimited(4, lAccessData, [';']);

   lsqqAuxiliar := TSQLQuery.Create(Self);

   try

      lsqqAuxiliar.SQLConnection := dmPrincipal.sqcCompilador;

      lClienteDB := dmInfoDB.cdsInfoDBEMPR_INF.AsString;

      lDataDBReg := FormatDateTime('dd/mm/yyyy', dmParametros.cdsParametrosDRLC_CFG.AsDateTime);
      lDataDB := FormatDateTime('dd/mm/yyyy', dmParametros.cdsParametrosDBLC_CFG.AsDateTime);
      lDiasDB := dmParametros.cdsParametrosEXLC_CFG.AsInteger;

      if lClienteDB <> lClienteReg then
      begin
         TALXFuncoes.Aviso('Acesso negado: o cliente da licença é diferente do cliente da base de dados!' + #13 +
                           'Para maiores informações entre em contato com o desenvolvedor:' + #13 +
                           'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                           'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                           'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                           'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imErro);

         Exit;
      end;

      if StrToDate(lDataReg) < StrToDate(lDataDBReg) then
      begin
         TALXFuncoes.Aviso('Acesso negado: a data da licença é menor que a data da base de dados!' + #13 +
                           'Para maiores informações entre em contato com o desenvolvedor:' + #13 +
                           'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                           'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                           'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                           'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imErro);

         Exit;
      end;

      if (lDataDBReg = '30/12/1899') or (StrToDate(lDataDBReg) <> StrToDate(lDataReg)) then
      begin
         lsqqAuxiliar.Close;
         lsqqAuxiliar.SQL.Clear;
         lsqqAuxiliar.SQL.Add('update CONFIG ' +
                              'set DRLC_CFG = :DRLC_CFG, ' +
                              '    DBLC_CFG = :DBLC_CFG, ' +
                              '    EXLC_CFG = :EXLC_CFG ' +
                              'where (CODI_USU = :CODI_USU)');
         lsqqAuxiliar.Params.ParamByName('DRLC_CFG').AsDate    := StrToDate(lDataReg);
         lsqqAuxiliar.Params.ParamByName('DBLC_CFG').AsDate    := lDataAtual;
         lsqqAuxiliar.Params.ParamByName('EXLC_CFG').AsInteger := StrToInt(lDiasReg);
         lsqqAuxiliar.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
         lsqqAuxiliar.ExecSQL;

         dmParametros.cdsParametros.Close;
         dmParametros.cdsParametros.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
         dmParametros.cdsParametros.Open;

         lDataDBReg := FormatDateTime('dd/mm/yyyy', dmParametros.cdsParametrosDRLC_CFG.AsDateTime);
         lDataDB := FormatDateTime('dd/mm/yyyy', dmParametros.cdsParametrosDBLC_CFG.AsDateTime);
         lDiasDB := dmParametros.cdsParametrosEXLC_CFG.AsInteger;
      end;

      lsqqAuxiliar.Close;
      lsqqAuxiliar.SQL.Clear;

      if (lDiasDB <= 5) and (lDiasDB > 0) then
      begin
         TALXFuncoes.Aviso('Faltam apenas ' + IntToStr(lDiasDB) + ' dias para sua licença expirar!' + #13 +
                           'Solicite uma nova licença entrando em contato com o desenvolvedor:' + #13 +
                           'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                           'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                           'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                           'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imInformacao);
      end
      else if (lDiasDB <= 0) then
      begin
         TALXFuncoes.Aviso('Acesso negado: licença do usuário expirada!' + #13 +
                           'Para maiores informações entre em contato com o desenvolvedor:' + #13 +
                           'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                           'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                           'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                           'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imErro);

         Exit;
      end;

      if DaysBetween(lDataAtual, StrToDate(lDataDB)) > 0 then
      begin
         lsqqAuxiliar.Close;
         lsqqAuxiliar.SQL.Clear;
         lsqqAuxiliar.SQL.Add('update CONFIG ' +
                              'set DBLC_CFG = :DBLC_CFG, ' +
                              '    EXLC_CFG = :EXLC_CFG ' +
                              'where (CODI_USU = :CODI_USU)');
         lsqqAuxiliar.Params.ParamByName('DBLC_CFG').AsDate    := lDataAtual;
         lsqqAuxiliar.Params.ParamByName('EXLC_CFG').AsInteger := lDiasDB - DaysBetween(lDataAtual, StrToDate(lDataDB));
         lsqqAuxiliar.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
         lsqqAuxiliar.ExecSQL;

         dmParametros.cdsParametros.Close;
         dmParametros.cdsParametros.Params.ParamByName('CODI_USU').AsInteger := CODI_USU;
         dmParametros.cdsParametros.Open;

         lDataDBReg := FormatDateTime('dd/mm/yyyy', dmParametros.cdsParametrosDRLC_CFG.AsDateTime);
         lDataDB := FormatDateTime('dd/mm/yyyy', dmParametros.cdsParametrosDBLC_CFG.AsDateTime);
         lDiasDB := dmParametros.cdsParametrosEXLC_CFG.AsInteger;
      end;

      Result := True;

   finally
      FreeAndNil(lsqqAuxiliar);
   end;
end;

function TfrmPrincipal.UsuarioPossuiPermissao: Boolean;
var
   lAccessUser,
   lUsuario,
   lSenha,
   lPrograma: string;
begin
   Result := False;

   {$IFDEF TESTE}
      Result := True;
      Exit;
   {$ENDIF}

   lAccessUser := TALXFuncoes.LeRegistro(HKEY_CURRENT_USER,
                                           'Software\ALXCompiler',
                                           'AccessUser');

   if lAccessUser = '' then
   begin
      TALXFuncoes.Aviso('Acesso negado: permissão do usuário não encontrada!' + #13 +
                        'Para maiores informações entre em contato com o desenvolvedor:' + #13 +
                        'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                        'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                        'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                        'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imErro);

      Exit;
   end;

   lAccessUser := TALXFuncoes.Descriptografa(lAccessUser);

   lPrograma := TALXFuncoes.Criptografa(ExtractDelimited(1, lAccessUser, [';']));
   lUsuario  := ExtractDelimited(2, lAccessUser, [';']);
   lSenha    := ExtractDelimited(3, lAccessUser, [';']);

   if (lPrograma = PROGRAMA) and
      (lUsuario = LOGI_USU) and
      (lSenha = SENH_USU) then
   begin
      Result := True;
   end
   else
   begin
      TALXFuncoes.Aviso('Acesso negado: permissão do usuário inválida!' + #13 +
                        'Para maiores informações entre em contato com o desenvolvedor:' + #13 +
                        'Fone: ' +  DADOS_PESSOAIS.FONE_CEL + #13 +
                        'E-mail: ' + DADOS_PESSOAIS.EMAIL + #13 +
                        'MSN: ' + DADOS_PESSOAIS.MSN + #13 +
                        'Skype: ' + DADOS_PESSOAIS.SKYPE, bmOk, imErro);
   end;
end;

function TfrmPrincipal.Utilizar7Zip: Boolean;
begin
   Result := False;

   if ( (Trim(dmVersoes.cdsVersoesDZIP_VER.AsString) <> '') and not (dmVersoes.cdsVersoesDZIP_VER.IsNull) ) or
      (GerarZipSeparado) or
      (GerarZipUnico) then
   begin
      Result  := True;
   end;
end;

function TfrmPrincipal.Valida(ATipoAcao: TTipoAcao): Boolean;
var
   lDrive: string;
begin
   Result := true;

   if Obrigatorio(cbxVersao, 'versão') then
   begin
      Result := False;
      Exit;
   end;

   if (dmVersoes.cdsVersoesSITU_VER.AsString = 'S') then
   begin
      TALXFuncoes.Aviso('Não é possível prosseguir, pois esta versão está inativa!');
      Result := False;
      Exit;
   end;

   if (dmVersoes.cdsVersoesVERS_VER.IsNull) or ( Trim(dmVersoes.cdsVersoesVERS_VER.AsString) = '')  then
   begin
      TALXFuncoes.Aviso('Não é possível prosseguir, pois a versão do executável ' + #13 +
                        'não foi informada no cadastro de versões!');
      Result := False;
      Exit;
   end
   else
   begin
      if not TALXFuncoes.ValidaVersao(dmVersoes.cdsVersoesVERS_VER.AsString) then
      begin
         Result := False;
         Exit;
      end;
   end;

   case ATipoAcao of
      taCompilar :
      begin
         if not TALXFuncoes.ArquivoExiste(ExtractFilePath(ParamStr(0)) + 'want.exe') then
         begin
            Result := False;
            Exit;
         end;

         if not TALXFuncoes.ArquivoExiste(ExtractFilePath(ParamStr(0)) + 'fde.exe') then
         begin
            Result := False;
            Exit;
         end;

         if Utilizar7Zip then
         begin
            if not (TALXFuncoes.ArquivoExiste(dmParametros.cdsParametrosSZIP_CFG.AsString, True, 'Aplicativo 7z.exe não informado na configuração dos parâmetros!')) then
            begin
               Result := False;
               Exit;
            end;
         end;

         if (dmVersoes.cdsVersoesDGER_VER.IsNull) or (dmVersoes.cdsVersoesDGER_VER.AsString = '')  then
         begin
            TALXFuncoes.Aviso('Diretório dos fontes (GERAL) não informado no cadastro de versões!');
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDGER_VER.AsString, 'diretório dos fontes (GERAL)', CARACTERES_ESPECIAIS_IGNORADOS)) then
         begin
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.DiretorioExiste('diretório dos fontes (GERAL)', dmVersoes.cdsVersoesDGER_VER.AsString, False)) then
         begin
            Result := False;
            Exit;
         end;

         if (dmVersoes.cdsVersoesDREV_VER.IsNull) or (dmVersoes.cdsVersoesDREV_VER.AsString = '')  then
         begin
            TALXFuncoes.Aviso('Diretório dos fontes (RevendaWindows) não informado no cadastro de versões!');
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDREV_VER.AsString, 'diretório dos fontes (Revenda Windows)', CARACTERES_ESPECIAIS_IGNORADOS)) then
         begin
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.DiretorioExiste('diretório dos fontes (Revenda Windows)', dmVersoes.cdsVersoesDREV_VER.AsString, False)) then
         begin
            Result := False;
            Exit;
         end;

         if (dmVersoes.cdsVersoesDTMP_VER.IsNull) or (dmVersoes.cdsVersoesDTMP_VER.AsString = '')  then
         begin
            TALXFuncoes.Aviso('Diretório dos executáveis (temporário) não informado no cadastro de versões!');
            Result := False;
            Exit;
         end
         else
         begin
            lDrive := Copy(dmVersoes.cdsVersoesDTMP_VER.AsString, 1, 1);

            if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdFixo then
            begin
               TALXFuncoes.Aviso('Diretório dos executáveis (temporário) inválido!');
               Result := False;
               Exit;
            end;

            if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDTMP_VER.AsString, 'diretório dos executáveis (temporário)', CARACTERES_ESPECIAIS_IGNORADOS)) then
            begin
               Result := False;
               Exit;
            end;

            if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (temporário)', dmVersoes.cdsVersoesDTMP_VER.AsString, False)) then
            begin
               Result := False;
               Exit;
            end;

            if not (TALXFuncoes.CriarDiretorio(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP)) then
            begin
               Result := False;
               Exit;
            end;
         end;

         if (Trim(dmVersoes.cdsVersoesDEXE_VER.AsString) <> '') and not (dmVersoes.cdsVersoesDEXE_VER.IsNull) and
            (Trim(dmVersoes.cdsVersoesDTMP_VER.AsString) <> '') and not (dmVersoes.cdsVersoesDTMP_VER.IsNull) then
         begin
            if CopiarParaDiretorioLocal then
            begin
               if LowerCase(Trim(dmVersoes.cdsVersoesDEXE_VER.AsString)) = LowerCase(Trim(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP)) then
               begin
                  TALXFuncoes.Aviso('O diretório dos executáveis (local) não pode ser o mesmo diretório dos executáveis (temporário)!');
                  Exit;
               end;
            end;
         end;

         if ExecutarAposCompilar then
         begin
            if CopiarParaDiretorioLocal then
            begin
               if (dmVersoes.cdsVersoesDEXE_VER.IsNull) or (dmVersoes.cdsVersoesDEXE_VER.AsString = '')  then
               begin
                  TALXFuncoes.Aviso('Diretório dos executáveis (local) não informado no cadastro de versões!');
                  Result := False;
                  Exit;
               end;
            end;
         end
         else if not (dmVersoes.cdsVersoesDEXE_VER.IsNull) and (Trim(dmVersoes.cdsVersoesDEXE_VER.AsString) <> '')  then
         begin
            if CopiarParaDiretorioLocal then
            begin
               lDrive := Copy(dmVersoes.cdsVersoesDEXE_VER.AsString, 1, 1);

               if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdFixo then
               begin
                  TALXFuncoes.Aviso('Diretório dos executáveis (local) inválido!');
                  Result := False;
                  Exit;
               end;

               if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDEXE_VER.AsString, 'diretório dos executáveis (local)', CARACTERES_ESPECIAIS_IGNORADOS)) then
               begin
                  Result := False;
                  Exit;
               end;

               if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (local)', dmVersoes.cdsVersoesDEXE_VER.AsString, False)) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if not (dmVersoes.cdsVersoesDZIP_VER.IsNull) and (Trim(dmVersoes.cdsVersoesDZIP_VER.AsString) <> '')  then
         begin
            if CopiarParaDiretorioRemoto then
            begin
               lDrive := Copy(dmVersoes.cdsVersoesDZIP_VER.AsString, 1, 2);

               if lDrive <> '\\' then
               begin
                  if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdRede then
                  begin
                     TALXFuncoes.Aviso('Diretório dos executáveis (remoto) inválido!');
                     Result := False;
                     Exit;
                  end;
               end;

               if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDZIP_VER.AsString, 'diretório dos executáveis (remoto)', CARACTERES_ESPECIAIS_IGNORADOS, False)) then
               begin
                  Result := False;
                  Exit;
               end;

               if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (remoto)', dmVersoes.cdsVersoesDZIP_VER.AsString, False)) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if not (TALXFuncoes.CriarDiretorio(dmVersoes.cdsVersoesDTMP_VER.AsString + TEMP + ZIP)) then
         begin
            Result := False;
            Exit;
         end;

      end;
      taParametrosCompilacao:
      begin
         if (CopiarParaDiretorioRemoto) then
         begin
            if not (GerarZipUnico) and not (GerarZipSeparado) then
            begin
               if not TALXFuncoes.Aviso('Não será possível copiar para o diretório remoto!' + #13 +
                                        'Para utilizar esta opção, é necessário marcar ' + #13 +
                                        'um dos seguintes parâmetros: ' + #13 +
                                        ' - Compactar os arquivos compilados separadamente' + #13 +
                                        ' - Compactar os arquivos compilados em um único arquivo' + #13 +
                                        #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if ExecutarAposCompilar then
         begin
            if not CopiarParaDiretorioLocal then
            begin
               if not TALXFuncoes.Aviso('Não será possível executar os módulos após compilar! ' + #13 +
                                        'Para utilizar esta opção, é necessário marcar ' + #13 +
                                        'o seguinte parâmetro: ' + #13 +
                                        ' - Copiar os arquivos compilados para o diretório local' + #13 +
                                        #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if GerarLinksParaDownload then
         begin
            if not Valida(taGerarLinks) then
            begin
               if not TALXFuncoes.Aviso('Não será possível gerar os links para download!' + #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;

            if not (GerarZipSeparado) and not (GerarZipUnico) then
            begin
               if not TALXFuncoes.Aviso('Não será possível gerar os links para download!' + #13 +
                                        'Para utilizar esta opção, é necessário marcar ' + #13 +
                                        'pelo menos um dos seguintes parâmetros: ' + #13 +
                                        ' - Compactar os arquivos compilados separadamente' + #13 +
                                        ' - Compactar os arquivos compilados em um único arquivo' + #13 +
                                        #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if EnviarArquivosZipSeparadamenteFTP then
         begin
            if not Valida(taFTP) then
            begin
               if not TALXFuncoes.Aviso('Não será possível enviar os arquivos compactados separadamente para o FTP!' + #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;

            if not (GerarZipSeparado) then
            begin
               if not TALXFuncoes.Aviso('Não será possível enviar os arquivos compactados separadamente para o FTP!' + #13 +
                                        'Para utilizar esta opção, é necessário marcar o ' + #13 +
                                        'seguinte parâmetro: ' + #13 +
                                        ' - Compactar os arquivos compilados separadamente' + #13 +
                                        #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if EnviarArquivoZipUnicoFTP then
         begin
            if not Valida(taFTP) then
            begin
               if not TALXFuncoes.Aviso('Não será possível enviar o arquivo único compactado para o FTP!' + #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;

            if not (GerarZipUnico) then
            begin
               if not TALXFuncoes.Aviso('Não será possível enviar o arquivo único compactado para o FTP!' + #13 +
                                        'Para utilizar esta opção, é necessário marcar o ' + #13 +
                                        'seguinte parâmetro: ' + #13 +
                                        ' - Compactar os arquivos compilados em um único arquivo' + #13 +
                                        #13 +
                                        'Deseja realmente prosseguir?',
                                        bmSimNao,
                                        imPergunta) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;
      end;
      taUpdate, taCommit, taStatus, taPrompt, taPush, taPull, taRebase, taMerge, taRefLog, taRefBrowse, taSwitch:
      begin
         if (dmVersoes.cdsVersoesGVPD_VER.IsNull) or (dmVersoes.cdsVersoesGVPD_VER.AsString = '')  then
         begin
            TALXFuncoes.Aviso('Gerenciador de versão não informado no cadastro de versões!');
            Result := False;
            Exit;
         end;

         case ATipoAcao of
            taPrompt:
            begin
               if (dmParametros.cdsParametrosSGIT_CFG.IsNull) or (dmParametros.cdsParametrosSGIT_CFG.AsString = '')  then
               begin
                  TALXFuncoes.Aviso('Aplicativo sh.exe não informado na configuração de parâmetros!');
                  Result := False;
                  Exit;
               end
               else if not (TALXFuncoes.ArquivoExiste(dmParametros.cdsParametrosSGIT_CFG.AsString, True, ' - Aplicativo sh.exe do GIT [Parâmetros]')) then
               begin
                  Result := False;
                  Exit;
               end;
            end;
         end;

         if (dmVersoes.cdsVersoesDFON_VER.IsNull) or (dmVersoes.cdsVersoesDFON_VER.AsString = '') then
         begin
            TALXFuncoes.Aviso('Diretório dos fontes não informado no cadastro de versões!');
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDFON_VER.AsString, 'diretório dos fontes [Versão]', CARACTERES_ESPECIAIS_IGNORADOS)) then
         begin
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.DiretorioExiste('diretório dos fontes [Versão]', dmVersoes.cdsVersoesDFON_VER.AsString, False)) then
         begin
            Result := False;
            Exit;
         end;

         if dmVersoes.cdsVersoesGVPD_VER.AsString = 'SVN' then
         begin
            if (dmVersoes.cdsVersoesDGER_VER.IsNull) or (dmVersoes.cdsVersoesDGER_VER.AsString = '') then
            begin
               TALXFuncoes.Aviso('Diretório dos fontes (GERAL) não informado no cadastro de versões!');
               Result := False;
               Exit;
            end
            else if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDGER_VER.AsString, 'diretório dos fontes (GERAL) [Versão]', CARACTERES_ESPECIAIS_IGNORADOS)) then
            begin
               Result := False;
               Exit;
            end
            else if not (TALXFuncoes.DiretorioExiste('diretório dos fontes (GERAL) [Versão]', dmVersoes.cdsVersoesDGER_VER.AsString, False)) then
            begin
               Result := False;
               Exit;
            end;

            if (dmVersoes.cdsVersoesDREV_VER.IsNull) or (dmVersoes.cdsVersoesDREV_VER.AsString = '')  then
            begin
               TALXFuncoes.Aviso('Diretório dos fontes (RevendaWindows) não informado no cadastro de versões!');
               Result := False;
               Exit;
            end
            else if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDREV_VER.AsString, 'diretório dos fontes (Revenda Windows) [Versão]', CARACTERES_ESPECIAIS_IGNORADOS)) then
            begin
               Result := False;
               Exit;
            end
            else if not (TALXFuncoes.DiretorioExiste('diretório dos fontes (Revenda Windows) [Versão]', dmVersoes.cdsVersoesDREV_VER.AsString, False)) then
            begin
               Result := False;
               Exit;
            end;

            if (dmParametros.cdsParametrosTSVN_CFG.IsNull) or (dmParametros.cdsParametrosTSVN_CFG.AsString = '')  then
            begin
               TALXFuncoes.Aviso('Aplicativo TortoiseProc.exe (SVN) não informado na configuração de parâmetros!');
               Result := False;
               Exit;
            end
            else if not (TALXFuncoes.ArquivoExiste(dmParametros.cdsParametrosTSVN_CFG.AsString,
                                                   True,
                                                   ' - Aplicativo TortoiseProc.exe do SVN [Parâmetros]')) then
            begin
               Result := False;
               Exit;
            end;
         end
         else if dmVersoes.cdsVersoesGVPD_VER.AsString = 'GIT' then
         begin
            if (dmParametros.cdsParametrosTGIT_CFG.IsNull) or (dmParametros.cdsParametrosTGIT_CFG.AsString = '')  then
            begin
               TALXFuncoes.Aviso('Aplicativo TortoiseProc.exe (GIT) não informado na configuração de parâmetros!');
               Result := False;
               Exit;
            end
            else if not (TALXFuncoes.ArquivoExiste(dmParametros.cdsParametrosTGIT_CFG.AsString, True, ' - Aplicativo TortoiseProc.exe do GIT [Parâmetros]')) then
            begin
               Result := False;
               Exit;
            end;
         end;
      end;
      taBases :
      begin
         if (dmVersoes.cdsVersoesDCFG_VER.IsNull) or (dmVersoes.cdsVersoesDCFG_VER.AsString = '') then
         begin
            TALXFuncoes.Aviso('Arquivo de conexão a base de dados não informado no cadastro de versões!');
            Result := False;
            Exit;
         end
         else if not (TALXFuncoes.ArquivoExiste(dmVersoes.cdsVersoesDCFG_VER.AsString, True, 'Arquivo de conexão a base de dados inválido!')) then
         begin
            Result := False;
            Exit;
         end;
      end;
      taExecutar :
      begin
         if (dmVersoes.cdsVersoesDEXE_VER.IsNull) or (dmVersoes.cdsVersoesDEXE_VER.AsString = '')  then
         begin
            TALXFuncoes.Aviso('Diretório dos executáeis (local) não informado no cadastro de versões!');
            Result := False;
            Exit;
         end
         else
         begin
            lDrive := Copy(dmVersoes.cdsVersoesDEXE_VER.AsString, 1, 1);

            if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdFixo then
            begin
               TALXFuncoes.Aviso('Diretório dos executáveis (local) inválido!');
               Result := False;
               Exit;
            end;

            if not (TALXFuncoes.DiretorioValido(dmVersoes.cdsVersoesDEXE_VER.AsString, 'diretório dos executáveis (local)', CARACTERES_ESPECIAIS_IGNORADOS)) then
            begin
               Result := False;
               Exit;
            end;

            if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (local)', dmVersoes.cdsVersoesDEXE_VER.AsString, False)) then
            begin
               Result := False;
               Exit;
            end;
         end;
      end;
      taGerarLinks :
      begin
         if (dmParametros.cdsParametrosLINK_CFG.IsNull) or ( Trim(dmParametros.cdsParametrosLINK_CFG.AsString) = '')  then
         begin
            TALXFuncoes.Aviso('Diretório base dos links para download não informado na configuração de parâmetros!');
            Result := False;
            Exit;
         end;
      end;
      taFTP :
      begin
         if EnviarArquivosZipSeparadamenteFTP then
         begin
            if (dmParametros.cdsParametrosHFTP_CFG.IsNull) or (dmParametros.cdsParametrosHFTP_CFG.AsString = '')  then
            begin
               TALXFuncoes.Aviso('O Host do FTP não foi informado nos parâmetros do sistema!');
               Result := False;
               Exit;
            end;

            if (dmParametros.cdsParametrosUFTP_CFG.IsNull) or (dmParametros.cdsParametrosUFTP_CFG.AsString = '')  then
            begin
               TALXFuncoes.Aviso('O Usuário do FTP não foi informado nos parâmetros do sistema!');
               Result := False;
               Exit;
            end;

            if (dmParametros.cdsParametrosSFTP_CFG.IsNull) or (dmParametros.cdsParametrosSFTP_CFG.AsString = '')  then
            begin
               TALXFuncoes.Aviso('A senha do FTP não foi informada nos parâmetros do sistema!');
               Result := False;
               Exit;
            end;
         end;
      end;
   end;
end;

procedure TfrmPrincipal.VersoSelecionada2Click(Sender: TObject);
begin
   CommitSVN(dsGeral);
end;

procedure TfrmPrincipal.Versoselecionada3Click(Sender: TObject);
begin
   UpdateSVN;
end;

procedure TfrmPrincipal.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
   ExecutarAntesDeSair;

   Msg.Result := 1;

   {Se qualquer aplicação retornar zero, impedirá o fechamento do Windows}
end;

{ TClientDataThread }

constructor TClientDataThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  
   FreeOnTerminate := true;
   ListBuffer := TStringList.Create;
end;

procedure TClientDataThread.Execute;
begin
   Synchronize(synchAddDataToControl);
end;

procedure TClientDataThread.synchAddDataToControl;
begin
   TargetList.AddStrings(ListBuffer);
end;

procedure TClientDataThread.Terminate;
begin
   FreeAndNil(ListBuffer);
   
  inherited;
end;

{ TDBEdit }

procedure TDBEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;

   if (Name = 'edtVersao') or (Name = 'edtDELP_VER') then
   begin
      Params.Style := Params.Style + ES_CENTER;
   end;
end;

end.
