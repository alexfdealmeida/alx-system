unit UExecutar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, JvExExtCtrls,
  JclFileUtils, ShellAPI, DB, BaseGrid, AdvGrid, DBAdvGrid,
  AdvOfficeStatusBar, UMaster, AppEvnts, ImgList, AdvObj,
  AdvOfficeStatusBarStylers, AdvSmoothPanel, AdvGlowButton;

type
  TfrmExecutar = class(TFMaster)
    edtPesquisa: TEdit;
    dtsModulosExe: TDataSource;
    DBAdvGrid1: TDBAdvGrid;
    pnlBotoes: TAdvSmoothPanel;
    btnCancelar: TAdvGlowButton;
    btnExecutar: TAdvGlowButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExecutarClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function ExisteArquivoCFG(ADirExe: String): Boolean;
  public
    { Public declarations }
  end;

var
  frmExecutar: TfrmExecutar;

implementation

uses UPrincipal, DExecutar, ALXFuncoes, DVersoes, ALXCompilerVariaveis;

{$R *.dfm}

{ TfrmExecutar }

procedure TfrmExecutar.btnCancelarClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmExecutar.btnExecutarClick(Sender: TObject);
var
   lDiretorio,
   lPrograma: String;
begin
   try

      dmExecutar.cdsModulosExe.Filtered := False;
      dmExecutar.cdsModulosExe.FilterOptions := [];
      dmExecutar.cdsModulosExe.Filter   := 'EXECUTAR';
      dmExecutar.cdsModulosExe.Filtered := True;

      dmExecutar.cdsModulosExe.DisableControls;

      if dmExecutar.cdsModulosExe.IsEmpty then
         TALXFuncoes.Aviso('Nenhum módulo selecionado!', bmOk, imInformacao)
      else
      begin
         lDiretorio := dmVersoes.cdsVersoesDEXE_VER.AsString;

         dmExecutar.cdsModulosExe.First;
         while not dmExecutar.cdsModulosExe.Eof do
         begin
            if (dmExecutar.cdsModulosExeALIAS.AsString <> 'login') and
               (dmExecutar.cdsModulosExeALIAS.AsString <> 'login_modular') then
               lPrograma := lDiretorio + '\SAgr' + dmExecutar.cdsModulosExeALIAS.AsString + '.exe'
            else
               lPrograma := lDiretorio + '\' + 'login' + '.exe';

            if TALXFuncoes.ArquivoExiste(lPrograma, False) then
            begin
               if TALXFuncoes.ArquivoExiste(PathExtractPathDepth(lPrograma, PathGetDepth(lPrograma) -1) +  'cfg\siagri.cfg') then
               begin
                  ShellExecute(0, nil, PChar(lPrograma), nil, PChar(ExtractFileDir(lPrograma)), SW_SHOW);
               end
               else
               begin
                  Break;
               end;
            end
            else
            begin
               if dmExecutar.cdsModulosExe.RecordCount <> dmExecutar.cdsModulosExe.RecNo then
               begin
                  if not TALXFuncoes.Aviso(Pchar('Arquivo não encontrado: ' + lPrograma + #13 +
                                                   'Deseja executar os demais módulos?'), bmSimNao, imPergunta) then
                  begin
                     Break;
                  end;
               end
               else
               begin
                  TALXFuncoes.Aviso(Pchar('Arquivo não encontrado: ' + lPrograma), bmOk, imErro);
                  Break;
               end;
            end;

            dmExecutar.cdsModulosExe.Next;
         end;

         Close;
      end;


   finally
      dmExecutar.cdsModulosExe.Filtered := False;
      dmExecutar.cdsModulosExe.Filter   := '';
      dmExecutar.cdsModulosExe.FilterOptions := [];

      dmExecutar.cdsModulosExe.First;

      dmExecutar.cdsModulosExe.EnableControls;
   end;
end;

procedure TfrmExecutar.DBAdvGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_SPACE) then
   begin
      if not dmExecutar.cdsModulosExe.IsEmpty then
      begin
         dmExecutar.cdsModulosExe.Edit;

         if dmExecutar.cdsModulosExeEXECUTAR.AsBoolean then
            dmExecutar.cdsModulosExeEXECUTAR.AsBoolean := false
         else
            dmExecutar.cdsModulosExeEXECUTAR.AsBoolean := true;

         dmExecutar.cdsModulosExe.Post;
      end;
   end
   else
      if (Key = VK_INSERT) then
         Abort;
end;

procedure TfrmExecutar.edtPesquisaChange(Sender: TObject);
begin
   if Trim(edtPesquisa.Text) = '' then
   begin
      dmExecutar.cdsModulosExe.Filtered := False;
      dmExecutar.cdsModulosExe.Filter   := '';
      dmExecutar.cdsModulosExe.FilterOptions := [];
   end
   else
   begin
      dmExecutar.cdsModulosExe.Filtered := False;
      dmExecutar.cdsModulosExe.FilterOptions := [foCaseInsensitive];
      dmExecutar.cdsModulosExe.Filter   := 'DESC_MOD = ' + QuotedStr(edtPesquisa.Text + '*') +
                                           'or ALIAS = ' + QuotedStr(edtPesquisa.Text + '*');
      dmExecutar.cdsModulosExe.Filtered := True;
   end;
end;

function TfrmExecutar.ExisteArquivoCFG(ADirExe: String): Boolean;
begin
   Result := true;

   if not TALXFuncoes.ArquivoExiste(PathExtractPathDepth(ADirExe, PathGetDepth(ADirExe) -1) +  'cfg\siagri.cfg') then
   begin
      Result := False;
   end;
end;

procedure TfrmExecutar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   frmExecutar := nil;
end;

procedure TfrmExecutar.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   dmExecutar.cdsModulosExe.Filtered := False;
   dmExecutar.cdsModulosExe.Filter   := '';
   dmExecutar.cdsModulosExe.FilterOptions := [];
end;

procedure TfrmExecutar.FormCreate(Sender: TObject);
begin
  inherited;

   TALXFuncoes.DefineAlturaTela(Self, ALTURA_TELA_90);
end;

procedure TfrmExecutar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_ESCAPE) then
      btnCancelarClick(Sender)
   else if (key = VK_F11) then
      btnExecutarClick(Sender);
end;

end.
