unit UManutLibraryPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, ImgList, AppEvnts, AdvOfficeStatusBar, JvExStdCtrls, JvEdit,
  Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls, Grids, BaseGrid, AdvGrid,
  DBAdvGrid, ActnList, DB, AdvObj, AdvOfficeStatusBarStylers, AdvGlowButton,
  UMasterMnt, AdvSmoothPanel, Registry, JvJCLUtils;

type
  TfrmManutLibraryPath = class(TfrmMasterMnt)
    dtsLibraryPath: TDataSource;
    ImageListLibrary: TImageList;
    pnlOpcoes: TAdvSmoothPanel;
    btnExportar: TAdvGlowButton;
    btnImportar: TAdvGlowButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportarClick(Sender: TObject);
    procedure actAtualizaMasterMntUpdate(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Exportar;
    procedure Importar;
  public
    { Public declarations }
  end;

var
  frmManutLibraryPath: TfrmManutLibraryPath;

implementation

uses DVersoes, ULibraryPath, UMasterCad, DParametros, ALXFuncoes,
  ALXCompilerFuncoesDB, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmManutLibraryPath.actAtualizaMasterMntUpdate(Sender: TObject);
begin
  inherited;

   btnExportar.Enabled := btnAlterarMasterMnt.Enabled;
end;

procedure TfrmManutLibraryPath.btnExportarClick(Sender: TObject);
begin
  inherited;

   Exportar;
end;

procedure TfrmManutLibraryPath.btnImportarClick(Sender: TObject);
begin
  inherited;

   Importar;
end;

procedure TfrmManutLibraryPath.Exportar;
begin
   if not (dmVersoes.cdsLibraryPath.IsEmpty) then
   begin
      if TALXFuncoes.Aviso('Deseja realmente exportar estes registros para o library path do Delphi?',
                           bmSimNao,
                           imPergunta) then
      begin
         TALXFuncoes.AtualizaRegistro(HKEY_CURRENT_USER,
                                      'Software\Borland\BDS\4.0\Library',
                                      'Search Path',
                                      TALXCompilerFuncoesDB.RetornaLibraryPath(dmVersoes.cdsLibraryPath),
                                      False);

         TALXFuncoes.Aviso('Library path atualizado com sucesso!');
      end;
   end
   else
   begin
      TALXFuncoes.Aviso('Não há registros a exportar!')
   end;
end;

procedure TfrmManutLibraryPath.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

   frmManutLibraryPath := nil;
end;

procedure TfrmManutLibraryPath.Importar;
var
   lCountPath,
   lIndex: Integer;
   lRegistroDelphi,
   lSearchPath: string;
   lReg : TRegistry;
begin

   if TALXFuncoes.Aviso('Deseja realmente importar o library path do Delphi?',
                        bmSimNao,
                        imPergunta) then
   begin
      if not dmVersoes.cdsLibraryPath.IsEmpty then
      begin
         if not TALXFuncoes.Aviso('Os registros atuais serão apagados!' + #13 +
                                  'Deseja realmente prosseguir?',
                                  bmSimNao,
                                  imPergunta) then
         begin
            Exit;
         end;

         dmVersoes.cdsLibraryPath.First;

         while not dmVersoes.cdsLibraryPath.IsEmpty do
         begin
            dmVersoes.cdsLibraryPath.Delete;
         end;

      end;

      lReg := TRegistry.Create;

      try

         lReg.RootKey := HKEY_CURRENT_USER;

         lRegistroDelphi := '';

         if dmVersoes.cdsVersoesDELP_VER.AsString = 'D07' then
         begin
            lRegistroDelphi := LIBRARY_PATH_DELPHI_7;
         end
         else if dmVersoes.cdsVersoesDELP_VER.AsString = 'D10' then
         begin
            lRegistroDelphi := LIBRARY_PATH_DELPHI_2006;
         end
         else
         begin
            TALXFuncoes.Aviso('Versão do Delphi inválida para esta operação!');
            Exit;
         end;

         lCountPath := 0;

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

      if lCountPath > 0 then
      begin
         for lIndex := 1 to lCountPath do
         begin
            dmVersoes.cdsLibraryPath.Append;
            dmVersoes.cdsLibraryPathCODI_VER.AsInteger := dmVersoes.cdsVersoesCODI_VER.AsInteger;
            dmVersoes.cdsLibraryPathCODI_USU.AsInteger := CODI_USU;
            dmVersoes.cdsLibraryPathINDI_LIB.AsInteger := lIndex;
            dmVersoes.cdsLibraryPathDESC_LIB.AsString  := ExtractDelimited(lIndex, lSearchPath, [';']);
            dmVersoes.cdsLibraryPath.Post;
         end;

         TALXFuncoes.Aviso('Registros atualizados com sucesso!');
      end
      else
      begin
         TALXFuncoes.Aviso('Library path não encontrado!');
         Exit;
      end;
   end;

end;

end.
