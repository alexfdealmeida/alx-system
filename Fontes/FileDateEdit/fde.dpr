program fde;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  StrUtils,
  DateUtils,
  Windows;

   procedure RecebeParametros(var ADataHoraMaxS: string; var ADataHoraMinS: string; var ADiretorio: String);
   begin

      ADataHoraMaxS := ParamStr(1);

      ADiretorio := ParamStr(2);

      if Trim(ADiretorio) = '' then
         ADiretorio := '.';

      ADataHoraMinS := ParamStr(3);

      if Trim(ADataHoraMinS) = '' then
         ADataHoraMinS := ADataHoraMaxS;

   end;

   function ListarArquivos(ADiretorio: string; ASubdiretorios: Boolean;  AFiltro: string = '*.*'): TStrings;
   var
      Fsr: TSearchRec;
      Ret: Integer;
      TempNome: string;

      function TemAtributo(Attr, Val: Integer): Boolean;
      begin
         Result := Attr and Val = Val;
      end;

   begin
      Result := TStringList.Create;

      Result.Clear;

      Ret := FindFirst(ADiretorio + '\' + AFiltro, faAnyFile, Fsr);

      try

         while Ret = 0 do
         begin
            if TemAtributo(Fsr.Attr, faDirectory) then
            begin
               if (Fsr.Name <> '.') And (Fsr.Name <> '..') then
               begin
                  if ASubdiretorios then
                  begin
                     TempNome := ADiretorio + '\' + Fsr.Name;
                     ListarArquivos(TempNome, True);
                  end;
               end;
            end
            else
            begin
               Result.Add(ADiretorio+ '\'+ Fsr.Name);
            end;

            Ret := FindNext(Fsr);
         end;

      finally
         SysUtils.FindClose(Fsr);
      end;
   end;

   function SetFileDateTime(FileName: string; CreateTime, ModifyTime, AcessTime: TDateTime): Boolean;
     function ConvertToFileTime(DateTime :TDateTime) :PFileTime;
     var
       FileTime :TFileTime;
       LFT: TFileTime;
       LST: TSystemTime;
     begin
       Result := nil;
       if DateTime > 0 then
       begin
         DecodeDate(DateTime, LST.wYear, LST.wMonth, LST.wDay);
         DecodeTime(DateTime, LST.wHour, LST.wMinute, LST.wSecond, LST.wMilliSeconds);
         if SystemTimeToFileTime(LST, LFT) then
           if LocalFileTimeToFileTime(LFT, FileTime) then
           begin
             New(Result);
             Result^ := FileTime;
           end;
       end;
     end;
   var
     FileHandle: Integer;
     ftCreateTime,
     ftModifyTime,
     ftAcessTime: PFileTime;
   begin
     Result := False;
     try
       ftCreateTime := ConvertToFileTime(CreateTime);
       ftModifyTime := ConvertToFileTime(ModifyTime);
       ftAcessTime  := ConvertToFileTime(AcessTime);
       try
         FileHandle := FileOpen(FileName, fmOpenReadWrite or fmShareExclusive);
         Result := SetFileTime(FileHandle, ftCreateTime, ftAcessTime, ftModifyTime);
       finally
         FileClose(FileHandle);
       end;
     finally
       Dispose(ftCreateTime);
       Dispose(ftAcessTime);
       Dispose(ftModifyTime);
     end;
   end;

   function ValidaParametros(ADataHoraMaxS: string; var ADataHoraMinS: String; ADiretorio: String): Boolean;
   var
      DataHoraMaxD, DataHoraMinD: TDateTime;
   begin
      Result := True;

      if Trim(ADataHoraMaxS) = '' then
      begin
         Writeln('Data/hora nao informada!');
         Result := False;
         Exit;
      end;

      if not (TryStrToDateTime(ADataHoraMaxS, DataHoraMaxD)) then
      begin
         Writeln('Data/hora invalida!');
         Result := False;
         Exit;
      end;

      if Trim(ADataHoraMinS) = '' then
      begin
         Writeln('Data/hora auxiliar nao informada!');
         Result := False;
         Exit;
      end;

      if not (TryStrToDateTime(ADataHoraMinS, DataHoraMinD)) then
      begin
         Writeln('Data/hora auxiliar invalida!' + ADataHoraMinS);
         Result := False;
         Exit;
      end;

      if (DataHoraMinD = DataHoraMaxD) then
      begin
         DataHoraMinD  := IncHour(DataHoraMinD, -1);
         ADataHoraMinS := DateTimeToStr(DataHoraMinD);
      end;

      if (DataHoraMinD >= DataHoraMaxD) then
      begin
         Writeln('A data auxiliar deve ser menor do que a data!');
         Result := False;
         Exit;
      end;

      if not (DirectoryExists(ADiretorio)) and not (FileExists(ADiretorio)) then
      begin
         Writeln('Diretorio/arquivo invalido ou nao existe!');
         Result := False;
         Exit;
      end;

   end;

   function ExecutarAplicativo(AParametro1: String): Boolean;
   begin
      Result := True;

      if (FileExists(AParametro1)) then
      begin
         Writeln('Data(s) nao alterada(s), pois os parametros não foram informados!');
         Result := False;
      end;
   end;

var
   I: Integer;
   DataHoraMinS, DataHoraMaxS, Diretorio, DataHoraS, ArquivoMAP: string;
   ListaArquivos: TStrings;

begin
  { TODO -oUser -cConsole Main : Insert code here }

   ExitCode := 1;

   RecebeParametros(DataHoraMaxS, DataHoraMinS, Diretorio);

   if not ExecutarAplicativo(DataHoraMaxS) then
   begin
      ExitCode := 0;
      Exit;
   end;   

   if not ValidaParametros(DataHoraMaxS, DataHoraMinS, Diretorio) then
      Exit;

   ListaArquivos := TStringList.Create;

   Writeln('Verificando arquivo(s) que sera(ao) alterado(s)...');
   Writeln('');

   try

      ListaArquivos.Clear;

      if FileExists(Diretorio) then
      begin
         ListaArquivos.Add(Diretorio);
      end
      else
      begin
         ListaArquivos := ListarArquivos(Diretorio, False, '*.exe');
      end;

      if ListaArquivos.Count > 0 then
      begin

         for I := 0 to ListaArquivos.Count - 1 do
         begin
            if (UpperCase(ExtractFileName(ListaArquivos[I])) <> UpperCase('fde.exe')) then
            begin
               DataHoraS := IfThen((UpperCase(ExtractFileName(ListaArquivos[I])) = UpperCase('SAgrAdap.exe')),
                                  DataHoraMaxS,
                                  DataHoraMinS);

               SetFileDateTime(ListaArquivos[I],
                               StrToDateTime(DataHoraS),
                               StrToDateTime(DataHoraS),
                               StrToDateTime(DataHoraS));

               Writeln(' - ' + ListaArquivos[I] + ' -> ' + DataHoraS);

               ArquivoMAP := Copy(ListaArquivos[I], 1, Pos('.exe', ListaArquivos[I]) - 1) + '.map';

               if FileExists(ArquivoMAP) then
               begin
                  SetFileDateTime(ArquivoMAP,
                                  StrToDateTime(DataHoraS),
                                  StrToDateTime(DataHoraS),
                                  StrToDateTime(DataHoraS));

                  Writeln(' - ' + ArquivoMAP + ' -> ' + DataHoraS);
               end;
            end;
         end;

         ExitCode := 0;

         Writeln('');
         Writeln('Data(s) do(s) arquivo(s) alterada(s) com sucesso!');

      end
      else
      begin
         ExitCode := 0;

         Writeln('Nenhum arquivo localizado!');
      end;

   finally
      FreeAndNil(ListaArquivos);
   end;
end.
