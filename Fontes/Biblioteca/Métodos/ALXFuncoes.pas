unit ALXFuncoes;

interface

uses Windows, Classes, SysUtils, Forms, WinSock, Controls, Math, ExtCtrls,
     StdCtrls, JvMemo, DBClient, DB, DBAdvGrid, Registry, StrUtils, DBCtrls,
     JvDBCombobox;

type
  { Tipo que informa quais botões serão utilizados em uma mensagem }
  TBotoesMsg = (bmOk, bmSimNao);

  { Tipo que informa qual o tipo de ícone que será utilizado em uma mensagem }
  TIconeMsg = (imPergunta, imAviso, imErro, imInformacao);

  { Tipo que informa se o foco ficará no botão sim ou no botão não }
  TFocoMsg = (fmSim, fmNao);

  TALXFuncoes = class
    private
      { Private declarations }
    protected
      { Protected declarations }
    public
      { Public declarations }
      class procedure CreateColumnsDBGrid(AGrid: TDBAdvGrid; ADataSource: TDataSource;
         AClientDataSet: TClientDataSet; AColumns: array of string);
      class procedure DefineAlturaLarguraTela(ATela: TForm; AAltura, ALargura: Double);
      class procedure DefineAlturaTela(ATela: TForm; AAltura: Double);
      class procedure DefineLarguraTela(ATela: TForm; ALargura: Double);
      class procedure AtualizaRegistro(
         AChaveRaiz: HKEY; AChaveDiretorio, AChaveCampo, AChaveValor: String;
         APodeCriarChave: Boolean = true);
      class procedure MudarCor(AComponente: TWinControl; ACorFundo: Integer = 16;
         ACorFonte: Integer = 0);
      class procedure VersaoPrograma(var lVersao, lBuild: string);
      class function Aviso(AMsg: String; ABotoesMsg: TBotoesMsg = bmOk;
         AIconeMsg: TIconeMsg = imInformacao; AFocoMsg: TFocoMsg = fmNao) : Boolean;
      //class function Criptografa(Str: string; fChave: string = 'a65w'; Dig: Integer = 3): string;
      //class function Descriptografa(Str: string; fChave: string = 'a65w'; Dig: Integer = 3): string;
      class procedure ConfiguraCDSTemporario(AClientDataSet: TClientDataSet;
         ALogChanges: Boolean = true);
      class function ExisteCaracteresAcentuados(ATexto: string; AComplemento: string = ''; ACaracteresIgnorados: string = ''): Boolean;
      class function ExisteCaracteresEspeciais(ATexto: string; AComplemento: string = ''; ACaracteresIgnorados: string = ''): Boolean;
      class function ExisteCaracteresEmBranco(ATexto: string; AComplemento: string = ''): Boolean;
      class function ExisteBarraFinalTexto(ATexto: string; AComplemento: string = ''): Boolean;
      class function DiretorioValido(ATexto: string; AComplemento: string; ACaracteresIgnorados: string;
         AValidarBranco: Boolean = True): Boolean;
      class function ArquivoExiste(AArquivo: string; AExibirAlerta: Boolean = True;
         AComplemento: string = ''): Boolean;
      class function Criptografa(Str: string; fChave: string = 'alxsystem'; Dig: Integer = 3): string;
      class function Descriptografa(Str: string; fChave: string = 'alxsystem'; Dig: Integer = 3): string;
      class function DiretorioExiste(ADescricao, ADiretorio: String; ACriar: Boolean = true): Boolean;
      class function CriarDiretorio(ADiretorio: String): Boolean;
      class function ExecAndWait(const FileName: string; const CmdShow: Integer): Longword;
      class function ForceForegroundWindow(wnd: THandle): Boolean;
      class function HexToInt(hex: string): Integer;
      class function LeRegistro(
         AChaveRaiz: HKEY; AChaveDiretorio, AChaveCampo: String;
         APodeCriarChave: Boolean = false): String;
      class function NomeDaMaquina: String;
      class function RetornaApenasAlfa(AValor: String): string;
      class function RetornaApenasNumero(AValor: String): string;
      class function RetornaAlfaNumerico(AValor: String): string;
      class function RetornaIP: String;
      class function RetornaUsuarioLogado: String;
      class function SelecionaOpcao(AOpcoes: array of string;
         ATitulo: String = ''): Integer;
      class function Obrigatorio(AComponente: TWinControl; AName: String): Boolean; overload;
      class function Obrigatorio(AValor: string; AName: String): Boolean; overload;
      class function Obrigatorio(AValor: Integer; AName: String): Boolean; overload;
      class function ValidaVersao(AVersao: string): Boolean;
  end;

implementation

uses ALXOpcoes;

{ TALXFuncoes }

class function TALXFuncoes.ArquivoExiste(AArquivo: string; AExibirAlerta: Boolean = True;
   AComplemento: string = ''): Boolean;
begin
   Result := True;

   if not FileExists(AArquivo) then
   begin
      if AExibirAlerta then
      begin
         TALXFuncoes.Aviso('O arquivo ' + AArquivo + ' não existe!' + #13 +
                           AComplemento, bmOk, imErro);
      end;
      Result := False;
   end;
end;

class procedure TALXFuncoes.AtualizaRegistro(AChaveRaiz: HKEY;
  AChaveDiretorio, AChaveCampo, AChaveValor: String;
  APodeCriarChave: Boolean = true);
var
   Reg: TRegistry;
begin
   Reg := TRegistry.Create;

   try

      Reg.RootKey := AChaveRaiz;

      if (Reg.OpenKey(AChaveDiretorio, APodeCriarChave)) then
      begin

         Reg.WriteString(AChaveCampo, AChaveValor);

         Reg.CloseKey;
      end;

   finally
      Reg.Free;
   end;
end;

class function TALXFuncoes.Aviso(AMsg: String; ABotoesMsg: TBotoesMsg;
  AIconeMsg: TIconeMsg; AFocoMsg: TFocoMsg): Boolean;
var
   lFlag: Integer;
begin
   Result := True;

   lFlag := 0;

   case AIconeMsg of
      imErro       : lFlag := lFlag + 16;
      imPergunta   : lFlag := lFlag + 32;
      imAviso      : lFlag := lFlag + 48;
      imInformacao : lFlag := lFlag + 64;
   end;

   case ABotoesMsg of
      bmOk :
      begin
         lFlag := lFlag + 0;
         Application.MessageBox(Pchar(AMsg), 'ALXSystem', lFlag);
      end;
      bmSimNao :
      begin
         lFlag := lFlag + 4;

         case AFocoMsg of
            fmSim: lFlag := lFlag + 0;
            fmNao: lFlag := lFlag + 256;
         end;

         if Application.MessageBox(Pchar(AMsg), 'ALXSystem', lFlag) = IDNO then
            Result := False;
      end;
   end;
end;

class procedure TALXFuncoes.ConfiguraCDSTemporario(
  AClientDataSet: TClientDataSet; ALogChanges: Boolean);
begin
   if (AClientDataSet.Active) then
   begin
      AClientDataSet.EmptyDataSet;
      AClientDataSet.Close;
   end;

   AClientDataSet.CreateDataSet;
   AClientDataSet.LogChanges := ALogChanges;
end;

class procedure TALXFuncoes.CreateColumnsDBGrid(AGrid: TDBAdvGrid;
  ADataSource: TDataSource; AClientDataSet: TClientDataSet;
  AColumns: array of string);
var
   lIndex: Integer;
begin
   AGrid.Columns.Delete(1);

   for lIndex := Low(AColumns) to High(AColumns) do
   begin
      AGrid.Columns.Add;

      AGrid.Columns[lIndex + 1].FieldName := AColumns[lIndex];
      AGrid.Columns[lIndex + 1].Header    := AClientDataSet.FieldByName(AColumns[lIndex]).DisplayLabel;
      AGrid.Columns[lIndex + 1].Width     := AClientDataSet.FieldByName(AColumns[lIndex]).DisplayWidth;

      case AClientDataSet.FieldByName(AColumns[lIndex]).DataType of
         ftString :
         begin
            AGrid.Columns[lIndex + 1].Alignment       := taLeftJustify;
            AGrid.Columns[lIndex + 1].HeaderAlignment := taLeftJustify;
         end;
         ftInteger :
         begin
            AGrid.Columns[lIndex + 1].Alignment       := taRightJustify;
            AGrid.Columns[lIndex + 1].HeaderAlignment := taRightJustify;
         end;
      end;
   end;
end;

class function TALXFuncoes.Criptografa(Str, fChave: string;
  Dig: Integer): string;
var
   iStr, iCh, SumOrd: integer;
begin
   Result := '';

   Str := Trim(Str);

   for iStr := 1 to Length(Str) do
   begin
      iCh := ((iStr mod Length(fChave)) + 1);
      SumOrd := Ord(Str[iStr]) + Ord(fChave[iCh]);
      Result := Result + IntToHex(SumOrd, Dig);
   end;
end;

class procedure TALXFuncoes.DefineAlturaLarguraTela(ATela: TForm; AAltura,
  ALargura: Double);
begin
   ATela.Height := Trunc(Screen.Height * AAltura);
   ATela.Width  := Trunc(Screen.Width * ALargura);
end;

class procedure TALXFuncoes.DefineAlturaTela(ATela: TForm; AAltura: Double);
begin
   ATela.Height := Trunc(Screen.Height * AAltura);
end;

class procedure TALXFuncoes.DefineLarguraTela(ATela: TForm; ALargura: Double);
begin
   ATela.Width  := Trunc(Screen.Width * ALargura);
end;

class function TALXFuncoes.Descriptografa(Str, fChave: string;
  Dig: Integer): string;
var
   iStr, iCh, SubOrd: integer;
   tmpPred: string;
begin
   Result := '';

   Str := Trim(Str);

   if Dig < 2 then
      Dig := 2;

   for iStr := 1 to (Length(Str) div Dig) do
   begin
      tmpPred := Copy(Str, (iStr * Dig - (Dig - 1)), Dig);
      iCh := ((iStr mod Length(fChave)) + 1);
      SubOrd := HexToInt(tmpPred) - Ord(fChave[iCh]);
      Result := Result + Chr(SubOrd);
   end;
end;

class function TALXFuncoes.CriarDiretorio(ADiretorio: String): Boolean;
begin
   Result := True;

   if not DirectoryExists(ADiretorio) then
   begin
      if not ForceDirectories(ADiretorio) then
      begin
         TALXFuncoes.Aviso('Não foi possível criar o diretório: ' + ADiretorio, bmOk, imErro);
         Result := False;
      end;
   end;
end;

class function TALXFuncoes.DiretorioExiste(ADescricao, ADiretorio: String; ACriar: Boolean): Boolean;
begin
   Result := True;

   if not DirectoryExists(ADiretorio) then
   begin
      if ACriar then
      begin
         if TALXFuncoes.Aviso(PChar('O diretório informado em ' + ADescricao + ' não existe!' + #13 +
                                      'Deseja criá-lo agora?'), bmSimNao, imPergunta, fmSim) then
         begin
            if not CriarDiretorio(ADiretorio) then
            begin
               Result := False;
            end;
         end
         else
         begin
            Result := False;
         end;
      end
      else
      begin
         TALXFuncoes.Aviso('O diretório informado em ' + ADescricao + ' não existe!');
         Result := False;
      end;
   end;
end;

class function TALXFuncoes.DiretorioValido(ATexto, AComplemento,
  ACaracteresIgnorados: string; AValidarBranco: Boolean = True): Boolean;
begin
   Result := True;

   if AValidarBranco then
   begin
      if (ExisteCaracteresEmBranco(ATexto, AComplemento)) then
      begin
         Result := False;
         Exit;
      end;
   end;

   if (ExisteCaracteresAcentuados(ATexto, AComplemento)) then
   begin
      Result := False;
      Exit;
   end;

   if (ExisteCaracteresEspeciais(ATexto, AComplemento, ACaracteresIgnorados)) then
   begin
      Result := False;
      Exit;
   end;

   if (ExisteBarraFinalTexto(ATexto, AComplemento)) then
   begin
      Result := False;
      Exit;
   end;
end;

class function TALXFuncoes.ExecAndWait(const FileName: string;
  const CmdShow: Integer): Longword;
var { by Pat Ritchey }
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := CmdShow;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    while WaitForSingleObject(ProcessInfo.hProcess, 0) = WAIT_TIMEOUT do
    begin
      Application.ProcessMessages;
      Sleep(50);
    end;

    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

class function TALXFuncoes.ExisteBarraFinalTexto(ATexto,
  AComplemento: string): Boolean;
begin
   Result := False;

   if (ATexto[Length(ATexto)] = '\') or (ATexto[Length(ATexto)] = '/') then
   begin
      Result := True;
      TALXFuncoes.Aviso('Não é pemitido utilizar barra no final do diretório!' +
                         IfThen(AComplemento <> '', #13 + ' - ' + AComplemento, ''));
   end;
end;

class function TALXFuncoes.ExisteCaracteresAcentuados(ATexto: string; AComplemento: string = '';
   ACaracteresIgnorados: string = ''): Boolean;
const
   CARECTERES_ACENTUADOS = 'âÂàÀãÃéÉêÊèÈíÍîÎìÌôòûùáÁóúñÑÓÔÒõÕÚÛÙýÝ';

var
   I: Integer;
begin
   Result := False;

   for I := 1 to Length(ATexto) do
   begin
      if Pos(ATexto[I], CARECTERES_ACENTUADOS) > 0 then
      begin
         if ACaracteresIgnorados <> '' then
         begin
            if Pos(ATexto[I], ACaracteresIgnorados) > 0 then
            begin
               Continue;
            end;
         end;

         Result := True;
         TALXFuncoes.Aviso('Não é pemitido utilizar caracteres acentuados!' +
                           IfThen(AComplemento <> '', #13 + ' - ' + AComplemento, ''));
         Break;
      end;
   end;
end;

class function TALXFuncoes.ExisteCaracteresEmBranco(ATexto: string; AComplemento: string = ''): Boolean;
var
   I: Integer;
begin
   Result := False;

   for I := 1 to Length(ATexto) do
   begin
      if ATexto[I] = ' ' then
      begin
         Result := True;
         TALXFuncoes.Aviso('Não é pemitido utilizar caracteres em branco!' +
                           IfThen(AComplemento <> '', #13 + ' - ' + AComplemento, ''));
         Break;
      end;
   end;
end;

class function TALXFuncoes.ExisteCaracteresEspeciais(ATexto: string; AComplemento: string = '';
   ACaracteresIgnorados: string = ''): Boolean;
const
   CARECTERES_ESPECIAIS = '<>!@#$%¨&*()_-+={}[]?;:,.|/\*"çÇ~^´`¨æÆø£Øƒªº¿®½¼ßµþ';

var
   I: Integer;
begin
   Result := False;

   for I := 1 to Length(ATexto) do
   begin
      if Pos(ATexto[I], CARECTERES_ESPECIAIS) > 0 then
      begin
         if ACaracteresIgnorados <> '' then
         begin
            if Pos(ATexto[I], ACaracteresIgnorados) > 0 then
            begin
               Continue;
            end;
         end;

         Result := True;
         TALXFuncoes.Aviso('Não é pemitido utilizar caracteres especiais!' +
                           IfThen(AComplemento <> '', #13 + ' - ' + AComplemento, ''));
         Break;
      end;
   end;
end;

class function TALXFuncoes.ForceForegroundWindow(wnd: THandle): Boolean;
const
  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000; 
  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
var
  ForegroundThreadID: DWORD;
  ThisThreadID: DWORD;
  timeout: DWORD;
begin 
  if IsIconic(wnd) then
    ShowWindow(wnd, SW_RESTORE);

  if GetForegroundWindow = wnd then 
    Result := True 
  else
  begin 
    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4)) or
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
      ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and 
      (Win32MinorVersion > 0)))) then 
    begin
      Result := False;
      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow, nil);
      ThisThreadID := GetWindowThreadPRocessId(wnd, nil);
      if AttachThreadInput(ThisThreadID, ForegroundThreadID, True) then
      begin
        BringWindowToTop(wnd);
        SetForegroundWindow(wnd);
        AttachThreadInput(ThisThreadID, ForegroundThreadID, False);
        Result := (GetForegroundWindow = wnd);
      end;
      if not Result then
      begin
        SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0),
          SPIF_SENDCHANGE);
        BringWindowToTop(wnd);
        SetForegroundWindow(Wnd); 
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0,
          TObject(timeout), SPIF_SENDCHANGE); 
      end; 
    end
    else  
    begin 
      BringWindowToTop(wnd);
      SetForegroundWindow(wnd); 
    end;

    Result := (GetForegroundWindow = wnd);
  end;
end; { ForceForegroundWindow }

class function TALXFuncoes.HexToInt(hex: string): Integer;
const
   Simb: string = 'ABCDEF';
   Nume: string = '1234567890';
var
   valor, i: integer;
begin
   Result := 0;

   for i := Length(hex) downto 1 do
   begin
      if Pos(Copy(hex, i, 1), nume) > 0 then
         valor := StrToInt(Copy(hex, i, 1))
      else
         valor := pos(Copy(hex, i, 1), Simb) + 9;
      Result := Result + valor * Trunc(Power(16, (Length(hex) - i)));
   end;
end;

class function TALXFuncoes.LeRegistro(AChaveRaiz: HKEY; AChaveDiretorio, AChaveCampo: String;
  APodeCriarChave: Boolean): String;
var
   Reg: TRegistry;
begin
   Result := '';

   Reg := TRegistry.Create;

   try

      Reg.RootKey := AChaveRaiz;

      if (Reg.OpenKey(AChaveDiretorio, APodeCriarChave)) then
      begin

         Result :=  Reg.ReadString(AChaveCampo);

         Reg.CloseKey;
      end;

   finally
      Reg.Free;
   end;
end;

class procedure TALXFuncoes.MudarCor(AComponente: TWinControl; ACorFundo,
  ACorFonte: Integer);
var
   lCor : TCustomColorBox;
begin
   lCor := TCustomColorBox.Create(nil);

   try

      lCor.Parent := AComponente;

      if AComponente is TJvMemo then
      begin
         TJvMemo(AComponente).Color      := lCor.Colors[ACorFundo];
         TJvMemo(AComponente).Font.Color := lCor.Colors[ACorFonte];
      end
      else if AComponente is TMemo then
      begin
         TMemo(AComponente).Color      := lCor.Colors[ACorFundo];
         TMemo(AComponente).Font.Color := lCor.Colors[ACorFonte];
      end;

   finally
      FreeAndNil(lCor);
   end;
end;

class function TALXFuncoes.NomeDaMaquina: String;
var
   lpBuffer : PChar;
   nSize : DWord;
   const Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
   try
      nSize := Buff_Size;
      lpBuffer := StrAlloc(Buff_Size);
      GetComputerName(lpBuffer,nSize);
      Result := String(lpBuffer);
      StrDispose(lpBuffer);
   except
      Result := '';
   end;
end;

class function TALXFuncoes.Obrigatorio(AValor: Integer; AName: String): Boolean;
begin
   Result := false;

   if AValor = 0 then
   begin
      Aviso('O campo "' + AName + '" deve ser informado!');
      Result := True;
   end;
end;

class function TALXFuncoes.Obrigatorio(AValor: string; AName: String): Boolean;
begin
   Result := false;

   if Trim(AValor) = '' then
   begin
      Aviso('O campo "' + AName + '" deve ser informado!');
      Result := True;
   end;
end;

class function TALXFuncoes.Obrigatorio(AComponente: TWinControl;
  AName: String): Boolean;
begin
   Result := false;

   if (Screen.ActiveControl.Name = 'btnCancelar') or
      (Screen.ActiveControl.Name = 'btnSair') then
   begin
      Exit;
   end;

   if AComponente is TDBEdit then
   begin
      if TDBEdit(AComponente).Text = '' then
      begin
         TALXFuncoes.Aviso(pChar('O campo ' + AName + ' deve ser informado!'), bmOk, imInformacao);
         TDBEdit(AComponente).SetFocus;
         Result := true;
      end;
   end
   else if AComponente is TJvDBComboBox then
   begin
      if TJvDBComboBox(AComponente).Text = '' then
      begin
         TALXFuncoes.Aviso(pChar('O campo ' + AName + ' deve ser informado!'), bmOk, imInformacao);
         TJvDBComboBox(AComponente).SetFocus;
         Result := true;
      end;
   end
   else if AComponente is TEdit then
   begin
      if TEdit(AComponente).Text = '' then
      begin
         TALXFuncoes.Aviso(pChar('O campo ' + AName + ' deve ser informado!'), bmOk, imInformacao);
         TEdit(AComponente).SetFocus;
         Result := true;
      end;
   end
end;

class function TALXFuncoes.RetornaAlfaNumerico(AValor: String): string;
var
   lIndex: Integer;
begin
   Result := '';

   for lIndex := 1 to Length(AValor) do
   begin
      if (AValor[lIndex] in ['0'..'9']) or (AValor[lIndex] in ['a'..'z', 'A'..'Z']) then
      begin
         Result := Result + AValor[lIndex];
      end;
   end;
end;

class function TALXFuncoes.RetornaApenasAlfa(AValor: String): string;
var
   lIndex: Integer;
begin
   Result := '';

   for lIndex := 1 to Length(AValor) do
   begin
      if (AValor[lIndex] in ['a'..'z', 'A'..'Z']) then
      begin
         Result := Result + AValor[lIndex];
      end;
   end;
end;

class function TALXFuncoes.RetornaApenasNumero(AValor: String): string;
var
   lIndex: Integer;
begin
   Result := '';

   for lIndex := 1 to Length(AValor) do
   begin
      if (AValor[lIndex] in ['0'..'9']) then
      begin
         Result := Result + AValor[lIndex];
      end;
   end;
end;

class function TALXFuncoes.RetornaIP: String;
type
   TaPInAddr = array [0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
var
   phe: PHostEnt;
   pptr: PaPInAddr;
   Buffer: array [0..63] of char;
   i: Integer;
   GInitData: TWSADATA;
begin
   WSAStartup($101, GInitData);
   Result := '';
   GetHostName(Buffer, SizeOf(Buffer));
   phe :=GetHostByName(buffer);
   if phe = nil then Exit;
   pptr := PaPInAddr(Phe^.h_addr_list);
   i := 0;
   while pptr^[i] <> nil do
   begin
    result:=StrPas(inet_ntoa(pptr^[i]^));
    Inc(i);
   end;
   WSACleanup;
end;

class function TALXFuncoes.RetornaUsuarioLogado: String;
var
   buffer: array[0..255] of char;
   size: dword;
begin
   size := 256;
   
   if GetUserName(buffer, size) then
      Result := buffer
   else
      Result := ''
end;

{$REGION SelecionaOpcao}
{-----------------------------------------------------------------------------
  Método:     TALXFuncoes.SelecionaOpcao
  Descrição:  <Este método tem a finalidade de exibir uma lista de opções para
               que o usuário selecione a opção desejada >
  Parâmetros: AOpcoes: array of string
  Histórico : <Alex Almeida 27/02/2009 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
class function TALXFuncoes.SelecionaOpcao(AOpcoes: array of string;
   ATitulo: String = ''): Integer;
var
   lFormOpcoes: TfrmOpcoes;
begin
   Result := -1;

   lFormOpcoes := TfrmOpcoes.Create(nil, AOpcoes, ATitulo);

   try

      lFormOpcoes.ShowModal;

      if lFormOpcoes.ModalResult = mrOk then
         Result := lFormOpcoes.opcao;

   finally
      FreeAndNil(lFormOpcoes);
   end;
end;

class function TALXFuncoes.ValidaVersao(AVersao: string): Boolean;
var
  lIndex,
  lQtdPontos: Integer;
begin
   Result := True;

   lQtdPontos := 0;

   for lIndex := 1 to Length(AVersao) do
   begin
      if AVersao[lIndex] = '.' then
      begin
         Inc(lQtdPontos);
      end;
   end;

   if (lQtdPontos < 3) or (Length(RetornaApenasNumero(AVersao)) < 4) then
   begin
      Aviso('Formato de versão inválido! Ex.: 9.9.9.9');
      Result := False;
   end;
end;

class procedure TALXFuncoes.VersaoPrograma(var lVersao, lBuild: string);
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
