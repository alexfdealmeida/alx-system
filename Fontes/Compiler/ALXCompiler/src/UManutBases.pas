unit UManutBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, JvExStdCtrls, JvButton, JvCtrls, StdCtrls,
  Buttons, Grids, DBGrids, ActnList, Mask, DBCtrls, IniFiles, JvExExtCtrls,
  DB, AdvOfficeStatusBar, BaseGrid, AdvGrid, DBAdvGrid, JvEdit,
  JvValidateEdit, UMaster, AppEvnts, ImgList, AdvObj, AdvOfficeStatusBarStylers,
  UMasterMnt, AdvGlowButton, AdvSmoothPanel, DBClient, UMasterCad;

type
  TfrmManutBases = class(TfrmMasterMnt)
    dtsBases: TDataSource;
    pnlBotoes: TAdvSmoothPanel;
    btnSelecionar: TAdvGlowButton;
    btnAlterarDados: TAdvGlowButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarDadosClick(Sender: TObject);
    procedure btnIncluirMasterMntClick(Sender: TObject);
    procedure actAtualizaMasterMntUpdate(Sender: TObject);
  private
    { Private declarations }
    FApagarInativas: Boolean;
    procedure ApagarInativas;
    procedure GeraArquivoCfg;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      AClientDataSet: TClientDataSet; AForm: TfrmMasterCad; AClassForm: TClassMasterCad;
      ACampoSel: string; ACampos: array of string; AApply: Boolean;
      AApagarInativas: Boolean); reintroduce; overload;
  end;

var
  frmManutBases: TfrmManutBases;

implementation

uses UPrincipal, DBases, UBases, DVersoes, ALXFuncoes,
  UManutDados, DParametros, ALXCompilerFuncoesDB,
  ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmManutBases.actAtualizaMasterMntUpdate(Sender: TObject);
begin
  inherited;

   btnSelecionar.Enabled := btnAlterarMasterMnt.Enabled;
   btnAlterarDados.Enabled := btnAlterarMasterMnt.Enabled;
end;

procedure TfrmManutBases.ApagarInativas;
var
   lIndex: Integer;
   lListaInativas: TStrings;
begin
   if FApagarInativas then
   begin

      try
         lListaInativas := TStringList.Create;

         dmBases.cdsBases.First;

         while not (dmBases.cdsBases.Eof) do
         begin

            //Apenas bases de dados firebird locais
            if (dmBases.cdsBasesTIPO_BAS.AsString = 'FB') and (UpperCase(dmBases.cdsBasesSERV_BAS.AsString) = UpperCase('localhost')) then
            begin
               if not TALXFuncoes.ArquivoExiste(dmBases.cdsBasesDIRE_BAS.AsString, False) then
               begin
                  lListaInativas.Add(dmBases.cdsBasesCODI_BAS.AsString);
               end;

            end;

            dmBases.cdsBases.Next;
         end;

         for lIndex := 0 to lListaInativas.Count - 1 do
         begin

            try

               dmBases.cdsBases.Filtered := False;
               dmBases.cdsBases.Filter := '(CODI_BAS = ' + lListaInativas[lIndex] + ')';
               dmBases.cdsBases.Filtered := True;

               if not (dmBases.cdsBases.IsEmpty) then
                  dmBases.cdsBases.Delete;

            finally
               dmBases.cdsBases.Filtered := False;
               dmBases.cdsBases.Filter := '';
            end;
         end;


         if dmBases.cdsBases.ApplyUpdates(-1) > 0 then
         begin
            Application.MessageBox('Não foi possível excluir as bases inativas!', 'Compilador', MB_OK + MB_ICONERROR);
            Abort;
         end;

         dmBases.cdsBases.Close;
         dmBases.cdsBases.Open;


      finally
         dmBases.cdsBases.First;
         FreeAndNil(lListaInativas);
      end;

   end;
end;

procedure TfrmManutBases.btnIncluirMasterMntClick(Sender: TObject);
var
   lBancoDados: TBancoDados;
   lbd: Integer;
begin
   lbd := TALXFuncoes.SelecionaOpcao(['Firebird', 'Oracle'], 'Banco de Dados');

   if lbd <> -1 then
   begin
      case lbd  of
         00 : lBancoDados := bdFirebird;
         01 : lBancoDados := bdOracle;
      end;

      frmBases := TfrmBases.Create(Self, lBancoDados, dmBases.cdsBases);
      frmBases.ShowModal;
   end;
end;

procedure TfrmManutBases.btnAlterarDadosClick(Sender: TObject);
begin
  inherited;

   if not TALXFuncoes.Obrigatorio(dmBases.cdsBasesDESC_BAS.AsString, 'Descrição') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesTIPO_BAS.AsString, 'SGBD') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesSERV_BAS.AsString, 'Servidor') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesDIRE_BAS.AsString, 'Diretório/Schema') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesPORT_BAS.AsInteger, 'Porta') then
   begin
      frmManutDados := TfrmManutDados.Create(Self, dmBases.cdsBases);
      frmManutDados.ShowModal;
   end;
end;

procedure TfrmManutBases.btnSelecionarClick(Sender: TObject);
begin
  inherited;

   if not TALXFuncoes.Obrigatorio(dmBases.cdsBasesDESC_BAS.AsString, 'Descrição') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesTIPO_BAS.AsString, 'SGBD') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesSERV_BAS.AsString, 'Servidor') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesDIRE_BAS.AsString, 'Diretório/Schema') and
      not TALXFuncoes.Obrigatorio(dmBases.cdsBasesPORT_BAS.AsInteger, 'Porta') then
   begin
      GeraArquivoCfg;

      Close;
   end;
end;

constructor TfrmManutBases.Create(AOwner: TComponent;
  AClientDataSet: TClientDataSet; AForm: TfrmMasterCad;
  AClassForm: TClassMasterCad; ACampoSel: string; ACampos: array of string;
  AApply, AApagarInativas: Boolean);
begin
  inherited Create(AOwner,
                   AClientDataSet,
                   AForm,
                   AClassForm,
                   ACampoSel,
                   ACampos,
                   AApply);

   FApagarInativas := AApagarInativas;
      
end;

procedure TfrmManutBases.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   
   frmManutBases := nil;
end;

procedure TfrmManutBases.FormCreate(Sender: TObject);
begin
  inherited;

   ApagarInativas;
end;

procedure TfrmManutBases.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

   if (key = vk_F11) then
      btnSelecionarClick(Sender);
end;

procedure TfrmManutBases.GeraArquivoCfg;
var
   Arquivo: TStringList;
begin
   Arquivo := TStringList.Create;

   try

      if not (TALXFuncoes.ArquivoExiste(dmVersoes.cdsVersoesDCFG_VER.AsString + '~', False)) and
             (TALXFuncoes.ArquivoExiste(dmVersoes.cdsVersoesDCFG_VER.AsString, False)) then
      begin
         Arquivo.LoadFromFile(dmVersoes.cdsVersoesDCFG_VER.AsString);
         Arquivo.SaveToFile(dmVersoes.cdsVersoesDCFG_VER.AsString + '~');
         Arquivo.Clear;
      end;

      if dmBases.cdsBasesTIPO_BAS.AsString = 'FB' then
      begin
         Arquivo.Add('[Geral]');
         Arquivo.Add('Balanca=Saturno');
         Arquivo.Add('FabricanteECF=Bematech');
         Arquivo.Add('CaminhoArquivoPeso=C:\PesoBalança.txt');
         Arquivo.Add('Servidor=localhost');
         Arquivo.Add('AtuDadosURL=http://www.siagri.inf.br/cgi-bin/AtuDados/wsdl/IAtuDados');
         Arquivo.Add('DayTimeServer=10.0.0.1');
         Arquivo.Add('');
         Arquivo.Add('[DbSiagri]');
         Arquivo.Add('DriverName=Interbase');
         Arquivo.Add('Database=' + dmBases.cdsBasesSERV_BAS.AsString + '/' + dmBases.cdsBasesPORT_BAS.AsString + ':' + dmBases.cdsBasesDIRE_BAS.AsString);
         Arquivo.Add('SQLDialect=3');
         Arquivo.Add('BlobSize=-1');
         Arquivo.Add('CommitRetain=False');
         Arquivo.Add('WaitOnLocks=True');
         Arquivo.Add('Interbase TransIsolation=ReadCommited');
         Arquivo.Add('UserName = SYSDBA');
         Arquivo.Add('Password = masterkey');
      end
      else if dmBases.cdsBasesTIPO_BAS.AsString = 'OC' then
      begin
         Arquivo.Add('[Geral]');
         Arquivo.Add('Balanca=Saturno');
         Arquivo.Add('FabricanteECF=Bematech');
         Arquivo.Add('CaminhoArquivoPeso=C:\PesoBalança.txt');
         Arquivo.Add('Servidor=10.0.0.3');
         Arquivo.Add('AtuDadosURL=http://www.siagri.inf.br/cgi-bin/AtuDados/wsdl/IAtuDados');
         Arquivo.Add('DayTimeServer=10.0.0.3');
         Arquivo.Add('Banco=Oracle');
         Arquivo.Add('Schema=' + dmBases.cdsBasesDIRE_BAS.AsString);
         Arquivo.Add('');
         Arquivo.Add('[DbSiagri]');
         Arquivo.Add('Database=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + dmBases.cdsBasesSERV_BAS.AsString + ')(PORT=' + dmBases.cdsBasesPORT_BAS.AsString + ')))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=' + dmBases.cdsBasesSNAM_BAS.AsString + ')))');
         Arquivo.Add('Trim Char=False');
         Arquivo.Add('DriverName=tbodbxora');
         Arquivo.Add('getDriverFunc=getTBOORA');
         Arquivo.Add('LibraryName=tbodbxora.dll');
         Arquivo.Add('VendorLib=tbodbxora.dll');
      end;

      Arquivo.SaveToFile(dmVersoes.cdsVersoesDCFG_VER.AsString);

   finally
      FreeAndNil(Arquivo);
   end;
end;

end.
