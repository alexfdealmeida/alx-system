unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvAnimatedImage, JvGIFCtrl, JvExStdCtrls, JvButton,
  JvCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    pnlBotoes: TPanel;
    JvGIFAnimatorProgresso: TJvGIFAnimator;
    btnAtualizar: TBitBtn;
    btnSair: TJvImgBtn;
    procedure btnSairClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FExecutar: Boolean;
  public
    { Public declarations }
    property Executar: Boolean read FExecutar write FExecutar;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses DPrincipal, ALXProcessos, ALXCompilerFuncoesDB, ALXArquivos, ALXFuncoes;

{$R *.dfm}

procedure TfrmPrincipal.btnAtualizarClick(Sender: TObject);
var
   lDirLocal,
   lDirServer,
   lParametros: string;
   lProcessos: TStrings;
begin
   JvGIFAnimatorProgresso.Visible := True;

   btnAtualizar.Enabled := False;

   lDirServer := '';

   lProcessos := TStringList.Create;

   try
      lDirLocal := ExtractFilePath(Application.ExeName);

      TALXProcessos.ListaProcessos(lProcessos);

      if Executar then
      begin
         while lProcessos.IndexOf('ALXCompiler.exe') <> -1 do
         begin
            Application.ProcessMessages;
            TALXProcessos.ListaProcessos(lProcessos);
         end;

         lDirServer :=  TALXCompilerFuncoesDB.DiretorioServidor(StrToInt(ParamStr(2)));

         if (lDirServer <> '') then
         begin
            if Copy(lDirServer, Length(lDirServer), 1) <> '\' then
               Insert('\', lDirServer, Length(lDirServer) + 1);

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'ALXCompiler.exe') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'ALXCompiler.map') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'AdaptadorALXCompiler.exe') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'AdaptadorALXCompiler.map') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'want.exe') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'fde.exe') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'Merlin.exe', True) then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'Peedy.exe', True) then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'Robby.exe', True) then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'Genie.exe', True) then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'MSagent.exe', True) then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'AccessUser.map') then
               Exit;

            if not TALXArquivos.CopiarArquivos(lDirLocal, lDirServer, 'AccessUser.exe') then
               Exit;

         end;

         lParametros := ' "executar" ' + '"' + ParamStr(2) + '" ' + '"' +ParamStr(3) + '" ' + '"' + ParamStr(4) + '" ' + '"' + ParamStr(5) + '" ' + '"' + ParamStr(6) + '"';

         WinExec(PChar(lDirLocal + 'ALXCompiler.exe' + lParametros), SW_SHOWNORMAL);
      end
      else
      begin
         if lProcessos.IndexOf('ALXCompiler.exe') <> -1 then
         begin
            TALXFuncoes.Aviso('O aplicativo "ALXCompiler.exe" está em execução,' + #13 +
                                'finalize-o e tente novamente!',
                                bmOk, imErro);
            Exit;
         end;

         WinExec(PChar(lDirLocal + 'ALXCompiler.exe'), SW_SHOWNORMAL);
      end;

      Close;

   finally
      JvGIFAnimatorProgresso.Visible := false;

      btnAtualizar.Enabled := true;

      FreeAndNil(lProcessos);
   end;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   if Executar then
      btnAtualizarClick(Sender);
end;

end.
