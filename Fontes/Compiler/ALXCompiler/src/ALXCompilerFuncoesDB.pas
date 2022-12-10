unit ALXCompilerFuncoesDB;

interface

uses Windows, Classes, SysUtils, SqlExpr, DBClient, DB, StrUtils;

type

  TALXCompilerFuncoesDB = class
    private
    { Private declarations }
    protected
    { Protected declarations }
    public
    { Public declarations }
    class procedure AtualizaIndicesLibraryPath(AClientDataSet: TClientDataSet; ADelete: Boolean = false);
    class procedure AtualizarSituacaoUsuario(ACODI_USU: Integer; AOnLine: Boolean = True);
    class procedure ExecutaSQL(ASQL: String; ACommitar: Boolean = False);
    class procedure MarcarDesmarcarBooleans(AClientDataSet: TClientDataSet;
      AFieldName: String; AMarcar: Boolean = True);
    class function RetornaGenerator(ANomeGenerator: string): integer;
    class function RetornaDataServidor: TDateTime;
    class function RetornaVersao(ATabela, ACampo: string): Integer;
    class function RetornaPK(ATabela, APK: string): Integer;
    class function RetornaInformacoesUsuario(AChave, ACampo, AValor: string): string; overload;
    class function RetornaInformacoesUsuario(AChave, ACampo: string; AValor: Integer): string; overload;
    class function RetornaInformacesConfig(AChave, Acampo, AValor: string): string; overload;
    class function RetornaInformacesConfig(AChave, Acampo: string; AValor: Integer): string; overload;
    class function RetornaChaveUltimoRegistro(ATabela, AChave: string;
      AUsuario: Integer): Integer;
    class function DiretorioServidor(ACODI_USU: Integer): String;
    class function ExisteRegistroNaTabela(ATabela, ACampo: String): Boolean;
    class function TabelaExiste(ATabela: String): Boolean;
    class function RetornaLibraryPath(AcdsLibraryPath: TClientDataSet;
      ASeparador: string = ';'): string;
  end;

implementation

uses DPrincipal, ALXFuncoes;


{ TALXCompilerFuncoesDB }

class procedure TALXCompilerFuncoesDB.AtualizaIndicesLibraryPath(AClientDataSet: TClientDataSet; ADelete: Boolean = false);
var
   lIndice,
   lChave: Integer;
   lPosicao: TBookmark;
begin
   if ADelete then
      AClientDataSet.Prior; 

   lPosicao := AClientDataSet.GetBookmark;

   try

      lIndice := AClientDataSet.FieldByName('INDI_LIB').AsInteger;

      lChave := AClientDataSet.FieldByName('CODI_LIB').AsInteger;

      try

         AClientDataSet.Filtered := False;
         AClientDataSet.Filter := '(INDI_LIB = ' + IntToStr(lIndice) + ') and (CODI_LIB <> ' + IntToStr(lChave) + ')';
         AClientDataSet.Filtered := True;

         if not (AClientDataSet.IsEmpty) then
         begin
            AClientDataSet.Edit;
            AClientDataSet.FieldByName('INDI_LIB').AsInteger := lIndice + 1;
            AClientDataSet.Post;
         end;

      finally
         AClientDataSet.Filtered := False;
         AClientDataSet.Filter := '';
      end;

      AClientDataSet.Locate('CODI_LIB', lChave, []);

      AClientDataSet.Next;

      while not AClientDataSet.Eof do
      begin
         AClientDataSet.Edit;
         AClientDataSet.FieldByName('INDI_LIB').AsInteger := lIndice + 1;
         AClientDataSet.Post;

         AClientDataSet.Next;

         Inc(lIndice);
      end;


      lIndice := 0;

      AClientDataSet.First;

      while not AClientDataSet.Eof do
      begin
         AClientDataSet.Edit;
         AClientDataSet.FieldByName('INDI_LIB').AsInteger := lIndice + 1;
         AClientDataSet.Post;

         AClientDataSet.Next;

         Inc(lIndice);
      end;

   finally
      if (lPosicao <> nil) and (AClientDataSet.BookmarkValid(lPosicao)) then
      begin
         AClientDataSet.GotoBookmark(lPosicao);
         AClientDataSet.FreeBookmark(lPosicao);
      end;
   end;
end;

class procedure TALXCompilerFuncoesDB.AtualizarSituacaoUsuario(
  ACODI_USU: Integer; AOnLine: Boolean);
var
   sqqSituacaoUsuario: TSQLQuery;
begin
   sqqSituacaoUsuario := TSQLQuery.Create(nil);

   try
      sqqSituacaoUsuario.SQLConnection := dmPrincipal.sqcCompilador;

      sqqSituacaoUsuario.SQL.Clear;
      sqqSituacaoUsuario.SQL.Add('update USUARIO ' +
                                 'set ONLI_USU = ' + QuotedStr(IfThen(AOnLine, 'S', 'N')) + ' ' +
                                 'where (CODI_USU = ' + IntToStr(ACODI_USU) + ')');

      sqqSituacaoUsuario.ExecSQL;

   finally
      FreeAndNil(sqqSituacaoUsuario);
   end;
end;

class function TALXCompilerFuncoesDB.DiretorioServidor(ACODI_USU: Integer): String;
begin
   Result := '';

   //if RetornaVersao('CONFIG', 'VERS_CFG') > '1106' then
   //begin
      dmPrincipal.cdsGeral.Close;
      dmPrincipal.cdsGeral.CommandText := 'select CFG.SERV_CFG ' +
                                          'from CONFIG CFG ' +
                                          'where (CFG.CODI_USU = ' + IntToStr(ACODI_USU) + ')';
      dmPrincipal.cdsGeral.Open;

      if not (dmPrincipal.cdsGeral.FieldByName('SERV_CFG').IsNull) and
         (Trim(dmPrincipal.cdsGeral.FieldByName('SERV_CFG').AsString) <> '') then
         Result := dmPrincipal.cdsGeral.FieldByName('SERV_CFG').AsString;

      dmPrincipal.cdsGeral.Close;
   //end;
end;

class procedure TALXCompilerFuncoesDB.ExecutaSQL(ASQL: String; ACommitar: Boolean = False);
var
   FSQLQuery: TSQLQuery;
begin
   if not ACommitar then
   begin
      FSQLQuery := TSQLQuery.Create(nil);

      try

         FSQLQuery.SQLConnection := dmPrincipal.sqcCompilador;

         FSQLQuery.SQL.Clear;
         FSQLQuery.SQL.Add(ASQL);
         FSQLQuery.ExecSQL;

      finally
         FreeAndNil(FSQLQuery);
      end;
   end
   else
      dmPrincipal.sqcCompilador.ExecuteDirect(ASQL);
end;

class function TALXCompilerFuncoesDB.ExisteRegistroNaTabela(ATabela, ACampo: String): Boolean;
begin
   Result := false;

   if TabelaExiste(ATabela) then
   begin
      dmPrincipal.cdsGeral.Close;
      dmPrincipal.cdsGeral.CommandText := 'select count(' + ACampo + ') as QTD ' +
                                          'from ' + ATabela;
      dmPrincipal.cdsGeral.Open;

      if dmPrincipal.cdsGeral.FieldByName('QTD').AsInteger > 0 then
         Result := true;

      dmPrincipal.cdsGeral.Close;
   end;
end;

class procedure TALXCompilerFuncoesDB.MarcarDesmarcarBooleans(AClientDataSet: TClientDataSet;
  AFieldName: String; AMarcar: Boolean);
var
   lPonteiro: TBookmark;
begin
   AClientDataSet.DisableControls;

   lPonteiro := AClientDataSet.GetBookmark;

   try

      AClientDataSet.First;
      while not AClientDataSet.Eof do
      begin
         AClientDataSet.Edit;
         AClientDataSet.FieldByName(AFieldName).AsBoolean := AMarcar;
         AClientDataSet.Post;

         AClientDataSet.Next;
      end;

   finally
      if (lPonteiro <> nil) and (AClientDataSet.BookmarkValid(lPonteiro)) then
      begin
         AClientDataSet.GotoBookmark(lPonteiro);
         AClientDataSet.FreeBookmark(lPonteiro);
      end;

      AClientDataSet.EnableControls;
   end;
end;

class function TALXCompilerFuncoesDB.RetornaInformacoesUsuario(AChave, ACampo,
  AValor: string): string;
var
   lSQLQuery: TSQLQuery;
begin
   Result := '';

   lSQLQuery := TSQLQuery.Create(nil);

   try

      lSQLQuery.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLQuery.Close;
      lSQLQuery.SQL.Clear;
      lSQLQuery.SQL.Text := ('select USU.' + ACampo + ' ' +
                             'from USUARIO USU ' +
                             'where (USU.' + AChave + ' = ' + QuotedStr(AValor) + ')');
      lSQLQuery.Open;

      if not lSQLQuery.IsEmpty then
         Result := lSQLQuery.FieldByName(ACampo).AsString;

   finally
      FreeAndNil(lSQLQuery);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaChaveUltimoRegistro(ATabela, AChave: string;
   AUsuario: Integer): Integer;
var
   lSQLUltimoReg: TSQLQuery;
begin
   Result := -1;

   lSQLUltimoReg := TSQLQuery.Create(nil);

   try

      lSQLUltimoReg.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLUltimoReg.Close;
      lSQLUltimoReg.SQL.Clear;
      lSQLUltimoReg.SQL.Text := 'select max(' + AChave + ') as ' + AChave + ' ' +
                                'from ' + ATabela + ' ' +
                                'where (CODI_USU  = ' + IntToStr(AUsuario) + ')';
      lSQLUltimoReg.Open;

      Result := lSQLUltimoReg.FieldByName(AChave).AsInteger;

   finally
      FreeAndNil(lSQLUltimoReg);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaDataServidor: TDateTime;
var
   lSQLDataServidor: TSQLQuery;
begin
   Result := 0;

   lSQLDataServidor := TSQLQuery.Create(nil);

   try

      lSQLDataServidor.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLDataServidor.Close;
      lSQLDataServidor.SQL.Clear;
      lSQLDataServidor.SQL.Text := 'select current_date as DATA_BD from RDB$DATABASE';
      lSQLDataServidor.Open;

      if not lSQLDataServidor.IsEmpty then
      begin
         Result := lSQLDataServidor.FieldByName('DATA_BD').AsDateTime;
      end;

   finally
      FreeAndNil(lSQLDataServidor);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaGenerator(ANomeGenerator: string): integer;
var
   lSQLGenerator: TSQLQuery;
begin
   Result := -1;

   lSQLGenerator := TSQLQuery.Create(nil);

   try

      lSQLGenerator.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLGenerator.Close;
      lSQLGenerator.SQL.Clear;
      lSQLGenerator.SQL.Text := 'select GEN_ID(' + ANomeGenerator + ', 1) from RDB$DATABASE';
      lSQLGenerator.Open;

      Result := lSQLGenerator.FieldByName('GEN_ID').AsInteger;

   finally
      FreeAndNil(lSQLGenerator);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaInformacesConfig(AChave, Acampo,
  AValor: string): string;
var
   lSQLQuery: TSQLQuery;
begin
   Result := '';

   lSQLQuery := TSQLQuery.Create(nil);

   try

      lSQLQuery.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLQuery.Close;
      lSQLQuery.SQL.Clear;
      lSQLQuery.SQL.Text := ('select CFG.' + ACampo + ' ' +
                             'from CONFIG CFG ' +
                             'where (CFG.' + AChave + ' = ' + QuotedStr(AValor) + ')');
      lSQLQuery.Open;

      if not lSQLQuery.IsEmpty then
         Result := lSQLQuery.FieldByName(ACampo).AsString;

   finally
      FreeAndNil(lSQLQuery);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaInformacesConfig(AChave,
  Acampo: string; AValor: Integer): string;
var
   lSQLQuery: TSQLQuery;
begin
   Result := '';

   lSQLQuery := TSQLQuery.Create(nil);

   try

      lSQLQuery.SQLConnection := dmPrincipal.sqcCompilador;

      lSQLQuery.Close;
      lSQLQuery.SQL.Clear;
      lSQLQuery.SQL.Text := ('select CFG.' + ACampo + ' ' +
                             'from CONFIG CFG ' +
                             'where (CFG.' + AChave + ' = ' + IntToStr(AValor) + ')');
      lSQLQuery.Open;

      if not lSQLQuery.IsEmpty then
         Result := lSQLQuery.FieldByName(ACampo).AsString;

   finally
      FreeAndNil(lSQLQuery);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaInformacoesUsuario(AChave, ACampo: string;
   AValor: Integer): string;
var
   lsqqInformacoesUsuario: TSQLQuery;
begin
   Result := '';

   lsqqInformacoesUsuario := TSQLQuery.Create(nil);

   try

      lsqqInformacoesUsuario.SQLConnection := dmPrincipal.sqcCompilador;

      lsqqInformacoesUsuario.Close;
      lsqqInformacoesUsuario.SQL.Clear;
      lsqqInformacoesUsuario.SQL.Text := ('select USU.' + ACampo + ' ' +
                                'from USUARIO USU ' +
                                'where (USU.' + AChave + ' = ' + IntToStr(AValor) + ')');
      lsqqInformacoesUsuario.Open;

      if not lsqqInformacoesUsuario.IsEmpty then
         Result := lsqqInformacoesUsuario.FieldByName(ACampo).AsString;

   finally
      FreeAndNil(lsqqInformacoesUsuario);
   end;
end;

class function TALXCompilerFuncoesDB.RetornaLibraryPath(AcdsLibraryPath: TClientDataSet;
  ASeparador: string = ';'): string;
var
   lSeparador: string;
   lPosicaoInicial: TBookmark;
begin
   Result := '';

   if not (AcdsLibraryPath.IsEmpty) then
   begin
      lSeparador := ASeparador;

      lPosicaoInicial := AcdsLibraryPath.GetBookmark;

      AcdsLibraryPath.DisableControls;

      try

         AcdsLibraryPath.First;
         while not AcdsLibraryPath.Eof do
         begin
            if (AcdsLibraryPath.RecordCount = AcdsLibraryPath.RecNo) then
               lSeparador := '';

            Result := Result + AcdsLibraryPath.FieldByName('DESC_LIB').AsString + lSeparador;

            AcdsLibraryPath.Next;
         end;

      finally
         if (lPosicaoInicial <> nil) and (AcdsLibraryPath.BookmarkValid(lPosicaoInicial)) then
         begin
            AcdsLibraryPath.GotoBookmark(lPosicaoInicial);
            AcdsLibraryPath.FreeBookmark(lPosicaoInicial);
         end;

         AcdsLibraryPath.EnableControls;
      end;
   end;
end;

class function TALXCompilerFuncoesDB.RetornaPK(ATabela, APK: string): Integer;
begin
   dmPrincipal.cdsGeral.Close;
   dmPrincipal.cdsGeral.CommandText := 'select coalesce(max(' + APK + '), 0) CODIGO ' +
                                       'from ' + ATabela;
   dmPrincipal.cdsGeral.Open;

   Result := dmPrincipal.cdsGeral.FieldByName('CODIGO').AsInteger;

   dmPrincipal.cdsGeral.Close;
end;

class function TALXCompilerFuncoesDB.RetornaVersao(ATabela, ACampo: string): Integer;
begin
   Result := 0;

   if TabelaExiste(ATabela) then
   begin
      dmPrincipal.cdsGeral.Close;
      dmPrincipal.cdsGeral.CommandText := 'select first 1 ' + ACampo + ' ' +
                                          'from ' + ATabela;
      dmPrincipal.cdsGeral.Open;

      if not (dmPrincipal.cdsGeral.IsEmpty) and not (dmPrincipal.cdsGeral.FieldByName(ACampo).IsNull) and
         (Trim(dmPrincipal.cdsGeral.FieldByName(ACampo).AsString) <> '') then
      begin
         Result := StrToInt(TALXFuncoes.RetornaApenasNumero(dmPrincipal.cdsGeral.FieldByName(ACampo).AsString));
      end;

      dmPrincipal.cdsGeral.Close;
   end;
end;

class function TALXCompilerFuncoesDB.TabelaExiste(ATabela: String): Boolean;
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

end.
