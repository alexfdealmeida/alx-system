unit UValidaInicializacao;

interface

uses
   Windows, Forms, SysUtils, ShellAPI, Controls;

type
  TValidaInicializacao = class
  private
    { private declarations }
    FCODI_USU: Integer;
    procedure VersaoPrograma(var lVersao, lBuild: string);
    function TabelaExiste(ATabela: String): Boolean;
  public
    { public declarations }
    procedure AtualizarExe(ACODI_USU: Integer; ANOME_USU, AVERS_EXE, ASENH_USU, ALOGI_USU: string);
    function AtualizarDB(ACODI_USU: Integer; ANOME_USU, AVERS_EXE, ASENH_USU, ALOGI_USU: string): Boolean;
    function Logou: Boolean;
    function MultiplasInstancias(AQtdAberta, ACODI_USU: Integer): Boolean;
   end;

implementation

uses DPrincipal, ALXFuncoes, ULogin, DB, ALXCompilerFuncoesDB;

{ TValidaInicializacao }

function TValidaInicializacao.AtualizarDB(ACODI_USU: Integer; ANOME_USU, AVERS_EXE, ASENH_USU, ALOGI_USU: string): Boolean;
var
   lOldVersion,
   lNewVersion: Integer;
   lParametros,
   lVersion,
   lBuild: String;
begin
   Result := True;

   lParametros := ' "executar" ' + '"' + IntToStr(ACODI_USU) + '" ' + '"' + ANOME_USU + '" ' + '"' + AVERS_EXE + '" ' + '"' + ASENH_USU + '" ' + '"' + ALOGI_USU + '"';

   //if lOldVersion <> FNewVersion then
   //if lOldVersion <> AVERS_EXE then
   //begin
     if TALXFuncoes.ArquivoExiste(ExtractFilePath(Application.ExeName) + '\AdaptadorALXCompiler.exe') then
     begin
        //TFirstFuncoes.ExecAndWait(ExtractFilePath(Application.ExeName) + '\AdaptadorALXCompiler.exe executar', SW_SHOWNORMAL)
        TALXFuncoes.ExecAndWait(ExtractFilePath(Application.ExeName) + '\AdaptadorALXCompiler.exe' + lParametros, SW_SHOWNORMAL);

        lOldVersion := TALXCompilerFuncoesDB.RetornaVersao('INFODB', 'VERS_INF');

         TALXFuncoes.VersaoPrograma(lVersion, lBuild);

         lVersion := lVersion + '.' + lBuild;

         lVersion := StringReplace(lVersion, '.', '', [rfReplaceAll]);

         lNewVersion := StrToInt(TALXFuncoes.RetornaApenasNumero(lVersion));

         if (lOldVersion > lNewVersion) then
         begin
            TALXFuncoes.Aviso('A versão do programa está desatualizada em relação a base de dados!', bmOk, imErro);
            Result := False;
         end;
     end
     else
     begin
        Result := False;
     end;
   //end;
end;

procedure TValidaInicializacao.AtualizarExe(ACODI_USU: Integer;
   ANOME_USU, AVERS_EXE, ASENH_USU, ALOGI_USU: string);
var
   lPrograma,
   lParametros: string;
begin
   lPrograma := ExtractFilePath(Application.ExeName) + 'AtualizadorALXCompiler.exe';

   lParametros := ' "executar" ' + '"' + IntToStr(ACODI_USU) + '" ' + '"' + ANOME_USU + '" ' + '"' + AVERS_EXE + '" ' + '"' + ASENH_USU + '" ' + '"' + ALOGI_USU + '"';

   if TALXFuncoes.ArquivoExiste(lPrograma) then
   begin
      WinExec(PChar(lPrograma + lParametros), SW_SHOWNORMAL);
      //ShellExecute(0, nil, PChar(lPrograma + ' executar'), nil, PChar(ExtractFileDir(lPrograma)), SW_SHOW)
   end;
end;

function TValidaInicializacao.Logou: Boolean;
begin
   Result := False;

   frmLogin := TfrmLogin.Create(nil);

   try

      frmLogin.ShowModal;

      if frmLogin.ModalResult = mrOk then
         Result := True;

   finally
      FreeAndNil(frmLogin);
   end;
end;

function TValidaInicializacao.MultiplasInstancias(AQtdAberta, ACODI_USU: Integer): Boolean;
begin
   Result := true;

   if (AQtdAberta > 1) and (ACODI_USU > 0) then
   begin
      dmPrincipal.cdsGeral.Close;
      dmPrincipal.cdsGeral.CommandText := 'select CFG.MULT_CFG ' +
                                          'from CONFIG CFG ' +
                                          'where (CFG.CODI_USU = ' + IntToStr(ACODI_USU) + ')';
      dmPrincipal.cdsGeral.Open;

      Result := dmPrincipal.cdsGeral.FieldByName('MULT_CFG').AsString = 'S';

      dmPrincipal.cdsGeral.Close;
   end;
end;

function TValidaInicializacao.TabelaExiste(ATabela: String): Boolean;
begin
   Result := true;

   dmPrincipal.cdsGeral.Close;
   dmPrincipal.cdsGeral.CommandText := 'select count(*) as QTD ' +
                                       'from rdb$relations ' +
                                       'where (rdb$relation_name = ' + QuotedStr(ATabela) + ')';
   dmPrincipal.cdsGeral.Open;

   if dmPrincipal.cdsGeral.FieldByName('QTD').AsInteger = 0 then
      Result := False;

   dmPrincipal.cdsGeral.Close;
end;

procedure TValidaInicializacao.VersaoPrograma(var lVersao, lBuild: string);
var
   Size, Size2: DWord;
   Point, Point2: Pointer;
   prg: string;
begin
   lVersao := '';
   lBuild := '';

   prg := paramstr(0);
   Size := GetFileVersionInfoSize(PChar(prg), Size2);

   if Size > 0 then
   begin
      GetMem(Point, Size);
      try
         if GetFileVersionInfo(PChar(prg), 0, Size, Point) then
         begin
            VerQueryValue(Point, '\', Point2, Size2);

            with TVSFixedFileInfo(Point2^) do
            begin
               lVersao := IntToStr(HiWord(dwFileVersionMS)) + '.' +
                  IntToStr(LoWord(dwFileVersionMS));

               lBuild := IntToStr(HiWord(dwFileVersionLS)) + '.' +
                  IntToStr(LoWord(dwFileVersionLS));
            end;
         end
         else
         begin
            lVersao := 'erro';
            lBuild := 'erro'
         end;
      finally
         FreeMem(Point);
      end;
   end
   else
   begin
      lVersao := 'indefinida';
      lBuild := 'indefinido';
   end;
end;

end.
