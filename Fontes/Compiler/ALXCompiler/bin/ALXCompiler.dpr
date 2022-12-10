program ALXCompiler;

{%TogetherDiagram 'ModelSupport_ALXCompiler\default.txaPackage'}

uses
  Forms,
  Windows,
  SysUtils,
  Graphics,
  Classes,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  DPrincipal in '..\src\DPrincipal.pas' {dmPrincipal: TDataModule},
  UVersoes in '..\src\UVersoes.pas' {frmVersoes},
  DVersoes in '..\src\DVersoes.pas' {dmVersoes: TDataModule},
  DModulos in '..\src\DModulos.pas' {dmModulos: TDataModule},
  UModulos in '..\src\UModulos.pas' {frmModulos},
  DBases in '..\src\DBases.pas' {dmBases: TDataModule},
  UBases in '..\src\UBases.pas' {frmBases},
  UManutBases in '..\src\UManutBases.pas' {frmManutBases},
  UParametros in '..\src\UParametros.pas' {frmParametros},
  DParametros in '..\src\DParametros.pas' {dmParametros: TDataModule},
  UValidaInicializacao in '..\src\UValidaInicializacao.pas',
  UExecutar in '..\src\UExecutar.pas' {frmExecutar},
  DExecutar in '..\src\DExecutar.pas' {dmExecutar: TDataModule},
  USobre in '..\src\USobre.pas' {frmSobre},
  UVersaoBase in '..\src\UVersaoBase.pas' {frmVersaoBase},
  DVersaoBase in '..\src\DVersaoBase.pas' {dmVersaoBase: TDataModule},
  USelecionaModulos in '..\src\USelecionaModulos.pas' {frmSelecionaModulos},
  UManutDados in '..\src\UManutDados.pas' {frmManutDados},
  DManutDados in '..\src\DManutDados.pas' {dmManutDados: TDataModule},
  UUsuarios in '..\src\UUsuarios.pas' {frmUsuarios},
  DUsuarios in '..\src\DUsuarios.pas' {dmUsuarios: TDataModule},
  UManutUsuarios in '..\src\UManutUsuarios.pas' {frmManutUsuarios},
  ULogin in '..\src\ULogin.pas' {frmLogin},
  ALXCompilerFuncoesDB in '..\src\ALXCompilerFuncoesDB.pas',
  DInfoDB in '..\src\DInfoDB.pas' {dmInfoDB: TDataModule},
  ALXCompilerVariaveis in '..\src\ALXCompilerVariaveis.pas',
  UMessenger in '..\src\UMessenger.pas' {frmMessenger},
  USelecionaVersoes in '..\src\USelecionaVersoes.pas' {frmSelecionaVersoes},
  UPesVersoes in '..\src\UPesVersoes.pas' {frmPesVersoes},
  UDiretivas in '..\src\UDiretivas.pas' {frmDiretivas},
  DDiretivas in '..\src\DDiretivas.pas' {dmDiretivas: TDataModule},
  UManutDiretivas in '..\src\UManutDiretivas.pas' {frmManutDiretivas},
  UDataHora in '..\src\UDataHora.pas' {frmDataHora},
  ULibraryPath in '..\src\ULibraryPath.pas' {frmLibraryPath},
  UManutLibraryPath in '..\src\UManutLibraryPath.pas' {frmManutLibraryPath},
  ALXProgressBar in '..\..\..\Biblioteca\Métodos\ALXProgressBar.pas' {FALXProgressBar},
  UALXProgressBar in '..\..\..\Biblioteca\Métodos\UALXProgressBar.pas' {frmALXProgressBar},
  ALXFuncoes in '..\..\..\Biblioteca\Métodos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\..\Biblioteca\Métodos\ALXOpcoes.pas' {frmOpcoes},
  ALXProcessos in '..\..\..\Biblioteca\Métodos\ALXProcessos.pas',
  ALXArquivos in '..\..\..\Biblioteca\Métodos\ALXArquivos.pas',
  UMaster in '..\..\..\Biblioteca\Herança\UMaster.pas' {FMaster},
  UMasterCad in '..\..\..\Biblioteca\Herança\UMasterCad.pas' {frmMasterCad},
  UMasterMnt in '..\..\..\Biblioteca\Herança\UMasterMnt.pas' {frmMasterMnt},
  ALXVariaveis in '..\..\..\Biblioteca\Formulários\ALXVariaveis.pas',
  UMasterPes in '..\..\..\Biblioteca\Herança\UMasterPes.pas' {frmMasterPes},
  UVersoesSintetico in '..\src\UVersoesSintetico.pas' {frmVersoesSinteticos},
  UParametrosSintetico in '..\src\UParametrosSintetico.pas' {frmParametrosSintetico},
  UResumo in '..\src\UResumo.pas' {frmResumo},
  UCompilacaoRemota in '..\src\UCompilacaoRemota.pas' {frmCompilacaoRemota},
  DCompilacaoRemota in '..\src\DCompilacaoRemota.pas' {dmCompilacaoRemota: TDataModule};

{$R *.res}

var
   lValidaInicializacao: TValidaInicializacao;
   lProcessos: TStrings;
   lIndex,
   lQtdAberta: Integer;
   lUsuarioLogou,
   lAtualizouDB,
   lMultiplaInstancias: Boolean;

begin

   lMultiplaInstancias := False;

   lAtualizouDB := False;

   lQtdAberta := 0;

   lProcessos := TStringList.Create;

   try

      TALXProcessos.ListaProcessos(lProcessos);

      for lIndex := 0 to lProcessos.Count - 1 do
      begin
       if lProcessos[lIndex] = 'ALXCompiler.exe' then
         Inc(lQtdAberta);

       if lQtdAberta = 2 then
         Break;
      end;

   finally
      FreeAndNil(lProcessos);
   end;

   Application.Initialize;

   Application.CreateForm(TdmPrincipal, dmPrincipal);
  try

      lValidaInicializacao := TValidaInicializacao.Create;

      if ParamStr(1) <> 'executar' then
      begin
         lUsuarioLogou :=  lValidaInicializacao.Logou;
      end
      else
      begin
         { Deve-se setar todas as variáveis utilizadas pelo Login }
         lUsuarioLogou := True;

         CODI_USU := StrToInt(ParamStr(2));
         NOME_USU := ParamStr(3);
         VERS_EXE := ParamStr(4);
         SENH_USU := ParamStr(5);
         LOGI_USU := ParamStr(6);
      end;

      if lUsuarioLogou then
      begin

         lMultiplaInstancias := lValidaInicializacao.MultiplasInstancias(lQtdAberta, CODI_USU);

         if not lMultiplaInstancias then
         begin
            Application.Terminate;
            Exit;
         end;

         {$IFNDEF TESTE}

         if (ParamStr(1) <> 'executar') and (lQtdAberta = 1) then
         begin
           lValidaInicializacao.AtualizarExe(CODI_USU, NOME_USU, VERS_EXE, SENH_USU, LOGI_USU);
           Application.Terminate;
           Exit;
         end;

         {$ENDIF}

         lAtualizouDB := (lValidaInicializacao.AtualizarDB(CODI_USU, NOME_USU, VERS_EXE, SENH_USU, LOGI_USU));

         Application.Title := 'ALXCompiler';

         Application.CreateForm(TfrmPrincipal, frmPrincipal);

      end;

      if (lUsuarioLogou) and (lAtualizouDB) and (lMultiplaInstancias) then
      begin
         Application.Run;
      end
      else
      begin
         Application.Terminate;
      end;

   finally
      FreeAndNil(lValidaInicializacao);
   end;

end.
