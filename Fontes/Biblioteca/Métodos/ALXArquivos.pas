unit ALXArquivos;

interface

uses Windows, Classes, SysUtils, Forms, ShellAPI;

type
  TTipoDrive = (tdIndeterminado, tdNaoExiste, tdRemovivel, tdFixo, tdRede, tdCDRom, tdRAMDisk, tdErro);

  TALXArquivos = class
    private
    { Private declarations }
    protected
    { Protected declarations }
    public
    { Public declarations }
    class function ApagarArquivos(AOrigem, AArquivo: String): Boolean;
    //class function ApagarArquivosViaShell(AOrigem, AArquivo: String;
    //  AExcluirDiretorios: Boolean = False; AExcluirPermanentemente: Boolean = False;
    //  AConfirmarExclusao: Boolean = True): Boolean;
    class function ApagarArquivosViaShellBuffer(AOrigem, AArquivo: String;
      AExcluirDiretorios: Boolean = False; AExcluirPermanentemente: Boolean = False;
      AConfirmarExclusao: Boolean = True): Boolean;
    class function CopiarArquivos(ADirLocal, ADirServer, AArquivo: String;
      AExecutar: Boolean = False): Boolean;
    class function CopiarArquivosViaCopy(AOrigem, ADestino, AArquivo: String): Boolean;
    //class function CopiarArquivosViaShell(AOrigem, ADestino, AArquivo: String;
    //  AConfirmarSobreposicao: Boolean = True): Boolean;
    class function CopiarArquivosViaShellBuffer(AOrigem, ADestino, AArquivo: String;
      AConfirmarSobreposicao: Boolean = True): Boolean;
    class function ListarArquivos(ADiretorio: string; ASubdiretorios: Boolean = true; AFiltro: string = '*.*'): TStrings;
    class function TamanhoArquivo(AArquivo: String): Integer;
    class function DiretorioAplicacao: String;
    class function RetornaDrives: string;
    class function RetornaDriveWindows: Char;
    class function RetornaTipoDrive(ADrive: Char): TTipoDrive;
    class function RetornaTamanhoArquivo(AArquivo: string): Integer;
    class function SetFileDateTime(FileName: string; CreateTime, ModifyTime, AcessTime: TDateTime): Boolean;
    class function SysSystemDir: string;
  end;

implementation

uses ALXFuncoes;

{ TALXArquivos }

class function TALXArquivos.ApagarArquivos(AOrigem, AArquivo: String): Boolean;
var
   SR: TSearchRec;
   I: integer;
begin
   Result := True;

   I := FindFirst(AOrigem + '\' + AArquivo, faAnyFile, SR);

   while I = 0 do
   begin
       if (SR.Attr and faDirectory) <> faDirectory then begin

         if not DeleteFile(PChar(AOrigem + '\' + SR.Name)) then
         begin
            TALXFuncoes.Aviso('Erro ao apagar "' + AOrigem + '\' + AArquivo + '"!', bmOk, imErro);
            Result := False;
         end
       end;

       I := FindNext(SR);
   end;
end;

{class function TALXArquivos.ApagarArquivosViaShell(AOrigem,
  AArquivo: String; AExcluirDiretorios: Boolean = False; AExcluirPermanentemente: Boolean = False;
  AConfirmarExclusao: Boolean = True): Boolean;
var
   Dados: TSHFileOpStruct;
begin
   Result := False;

   FillChar(Dados,SizeOf(Dados), 0);

   with Dados do
   begin

      Wnd   := Application.Handle;
      wFunc := FO_DELETE;
      pFrom := PChar(AOrigem + '\' + AArquivo);

      if not (AExcluirDiretorios) then
      begin
         fFlags := FOF_FILESONLY;
      end;

      if not (AExcluirPermanentemente) then
      begin
         fFlags := fFlags + FOF_ALLOWUNDO;
      end;

      if not (AConfirmarExclusao) then
      begin
         fFlags := fFlags + FOF_NOCONFIRMATION;
      end;
   end;

   if SHFileOperation(Dados) = 0 then
   begin
      Result := True;
   end
   else
   begin
      TALXFuncoes.Aviso('Erro ao apagar "' + AOrigem + '\' + AArquivo + '"!', bmOk, imErro);
   end;
end;}

class function TALXArquivos.ApagarArquivosViaShellBuffer(AOrigem,
  AArquivo: String; AExcluirDiretorios, AExcluirPermanentemente,
  AConfirmarExclusao: Boolean): Boolean;
var
   Dados: TSHFileOpStruct;
   FromBuffer: array[0..128] of Char;
begin
   Result := False;

   FillChar(Dados,SizeOf(Dados), 0);
   FillChar(FromBuffer, SizeOf(FromBuffer), 0);

   StrCopy(FromBuffer, Pchar(AOrigem + '\' + AArquivo));

   with Dados do
   begin

      Wnd   := Application.Handle;
      wFunc := FO_DELETE;
      pFrom := @FromBuffer;

      if not (AExcluirDiretorios) then
      begin
         fFlags := FOF_FILESONLY;
      end;

      if not (AExcluirPermanentemente) then
      begin
         fFlags := fFlags + FOF_ALLOWUNDO;
      end;

      if not (AConfirmarExclusao) then
      begin
         fFlags := fFlags + FOF_NOCONFIRMATION;
      end;
   end;

   if SHFileOperation(Dados) = 0 then
   begin
      Result := True;
   end
   else
   begin
      TALXFuncoes.Aviso('Erro ao apagar "' + AOrigem + '\' + AArquivo + '"!', bmOk, imErro);
   end;
end;

class function TALXArquivos.CopiarArquivos(ADirLocal, ADirServer,
  AArquivo: String; AExecutar: Boolean = False): Boolean;
begin
   Result := True;

   if not TALXFuncoes.ArquivoExiste(ADirServer + AArquivo,
                                    True,
                                    'Lembrando que o mesmo deverá estar localizado no diretório dos executáveis atualizados.') then
   begin
      Result := False;
   end;

   if not ( TALXFuncoes.ArquivoExiste(ADirLocal + AArquivo, False) ) or
      ( FileAge(ADirLocal + AArquivo) < FileAge(ADirServer + AArquivo) ) then
   begin
      if not CopyFile(PChar(ADirServer + AArquivo), PChar(ADirLocal + AArquivo), False) then
      begin
         Application.MessageBox(PChar('Erro ao copiar "' + ADirServer + AArquivo + '" para "' + ADirLocal + AArquivo + '"!'), 'Atualizador', MB_ICONERROR + MB_OK);
         Result := False;
      end
      else if AExecutar then
         TALXFuncoes.ExecAndWait(ADirLocal + AArquivo, SW_SHOWNORMAL)
   end;
end;

class function TALXArquivos.CopiarArquivosViaCopy(AOrigem, ADestino, AArquivo: String): Boolean;
var
   SR: TSearchRec;
   I: integer;
begin
   Result := True;

   I := FindFirst(AOrigem + '\' + AArquivo, faAnyFile, SR);

   while I = 0 do
   begin
       if (SR.Attr and faDirectory) <> faDirectory then begin

         if not CopyFile(PChar(AOrigem + '\' + SR.Name), PChar(ADestino + '\' + SR.Name), true) then
         begin
            Application.MessageBox(PChar('Erro ao copiar "' + AOrigem + '\' + AArquivo + '" para "' + ADestino + '"!'), 'Atualizador', MB_ICONERROR + MB_OK);
            Result := False;
         end
       end;

       I := FindNext(SR);
   end;
end;

{class function TALXArquivos.CopiarArquivosViaShell(
   AOrigem, ADestino, AArquivo: String;
   AConfirmarSobreposicao: Boolean = True): Boolean;
var
   Dados: TSHFileOpStruct;
begin
   Result := False;

   FillChar(Dados,SizeOf(Dados), 0);

   with Dados do
   begin
      Wnd   := Application.Handle;
      wFunc := FO_COPY;
      pFrom := PChar(AOrigem + '\' + AArquivo);
      pTo   := PChar(ADestino);

      if not (AConfirmarSobreposicao) then
      begin
         fFlags := FOF_NOCONFIRMATION;
      end;
   end;

   if SHFileOperation(Dados) = 0 then
   begin
      Result := True;
   end
   else
   begin
      TALXFuncoes.Aviso('Erro ao copiar "' + AOrigem + '\' + AArquivo + '" para "' + ADestino + '"!', bmOk, imErro);
   end;
end;}

class function TALXArquivos.CopiarArquivosViaShellBuffer(AOrigem, ADestino,
  AArquivo: String; AConfirmarSobreposicao: Boolean): Boolean;
var
   Dados: TSHFileOpStruct;
   FromBuffer, ToBuffer: array[0..128] of Char;
begin
   Result := False;

   FillChar(Dados,SizeOf(Dados), 0);
   FillChar(FromBuffer, SizeOf(FromBuffer), 0);
   FillChar(ToBuffer, SizeOf(ToBuffer), 0);

   StrCopy(FromBuffer, Pchar(AOrigem + '\' + AArquivo));
   StrCopy(ToBuffer, Pchar(ADestino));

   with Dados do
   begin
      Wnd   := Application.Handle;
      wFunc := FO_COPY;
      pFrom := @FromBuffer;
      pTo   := @ToBuffer;

      if not (AConfirmarSobreposicao) then
      begin
         fFlags := FOF_NOCONFIRMATION;
      end;
   end;

   if SHFileOperation(Dados) = 0 then
   begin
      Result := True;
   end
   else
   begin
      TALXFuncoes.Aviso('Erro ao copiar "' + AOrigem + '\' + AArquivo + '" para "' + ADestino + '"!', bmOk, imErro);
   end;
end;

class function TALXArquivos.DiretorioAplicacao: String;
begin
   Result := ParamStr(0);
   {Result := copy(ExtractFileDir(Application.ExeName), 1,
                  Pos(UpperCase('1stONE'), UpperCase(ExtractFileDir(Application.ExeName))) + 5);}
end;

class function TALXArquivos.ListarArquivos(ADiretorio: string; ASubdiretorios: Boolean; AFiltro: string): TStrings;
var
   F: TSearchRec;
   Ret: Integer;
   TempNome: string;

   function TemAtributo(Attr, Val: Integer): Boolean;
   begin
      Result := Attr and Val = Val;
   end;

begin
   Result := TStringList.Create;

   Result.Clear;

   Ret := FindFirst(ADiretorio + '\' + AFiltro, faAnyFile, F);

   try

      while Ret = 0 do
      begin
         if TemAtributo(F.Attr, faDirectory) then
         begin
            if (F.Name <> '.') And (F.Name <> '..') then
            begin
               if ASubdiretorios then
               begin
                  TempNome := ADiretorio + '\' + F.Name;
                  ListarArquivos(TempNome, True);
               end;
            end;
         end
         else
         begin
            Result.Add(ADiretorio+ '\'+ F.Name);
         end;

         Ret := FindNext(F);
      end;

   finally
      FindClose(F);
   end;
end;

class function TALXArquivos.RetornaDrives: string;
var
   Drives: DWord;
   I: byte;
begin
   Result := '';

   Drives := GetLogicalDrives;

   if Drives <> 0 then
   begin
      for I := 65 to 90 do
      begin
         if ((Drives shl (31 - (I - 65))) shr 31) = 1 then
         begin
            Result := Result + Char(I);
         end;
      end;
   end;
end;

class function TALXArquivos.RetornaDriveWindows: Char;
var
   S: string;
begin
   SetLength(S, MAX_PATH);

   if GetWindowsDirectory(PChar(S), MAX_PATH) > 0 then
   begin
      Result := string(S)[1];
   end
   else
   begin
      Result := #0;
   end;
end;

class function TALXArquivos.RetornaTamanhoArquivo(AArquivo: string): Integer;
var
   SR: TSearchRec;
   I: integer;
begin
   I := FindFirst(AArquivo, faArchive, SR);

   try

    if I = 0 then
      Result := SR.Size
    else
      Result := -1;

   finally
      FindClose(SR);
   end;
end;

class function TALXArquivos.RetornaTipoDrive(ADrive: Char): TTipoDrive;
var
   lTipo: TTipoDrive;
begin

   case GetDriveType(PChar(UpperCase(ADrive) + ':\')) of
      0:
      begin
         lTipo := tdIndeterminado;
      end;
      1:
      begin
         lTipo := tdNaoExiste;
      end;
      DRIVE_REMOVABLE:
      begin
         lTipo := tdRemovivel;
      end;
      DRIVE_FIXED:
      begin
         lTipo := tdFixo;
      end;
      DRIVE_REMOTE:
      begin
         lTipo := tdRede;
      end;
         DRIVE_CDROM:
      begin
         lTipo := tdCDRom;
      end;
         DRIVE_RAMDISK:
      begin
         lTipo := tdRAMDisk;
      end
   else
      lTipo := tdErro;
   end;

   Result := lTipo;

end;


class function TALXArquivos.SetFileDateTime(FileName: string; CreateTime, ModifyTime, AcessTime: TDateTime): Boolean;
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

class function TALXArquivos.SysSystemDir: string;
begin
   SetLength(Result, MAX_PATH);

    if GetSystemDirectory(PChar(Result), MAX_PATH) > 0 then
      Result := string(PChar(Result))
    else
      Result := '';
end;

class function TALXArquivos.TamanhoArquivo(AArquivo: String): Integer;
var
   SR: TSearchRec;
   I: integer;
begin
   Result := 0;

   I := FindFirst(AArquivo, faArchive, SR);

   try

      if I = 0 then
      begin
         Result := Result + ( SR.Size );
      end;

   finally
      FindClose(SR);
   end;
end;

end.
