unit ALXProcessos;

interface

uses Windows, Classes, SysUtils, TLHelp32, PsAPI;

type
  TALXProcessos = class
    private
    { Private declarations }
    protected
    { Protected declarations }
    public
    { Public declarations }
    class procedure ListaProcessos(ALista: TStrings);
    class function FinalizaProcesso(AProcesso: string): Bool;
  end;

implementation

{ TALXProcessos }

{$REGION FinalizaProcesso}
{-----------------------------------------------------------------------------
  Método:     TALXProcessos.FinalizaProcesso
  Descrição:  <Função destinada a finalizar um processso em execução no Windows>
  Parâmetros: AProcesso: string
  Histórico : <Alex Almeida 11/12/2008 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
class function TALXProcessos.FinalizaProcesso(AProcesso: string): Bool;
var
  verSystem: TOSVersionInfo;
  hdlSnap,hdlProcess: THandle;
  bPath,bLoop: Bool;
  peEntry: TProcessEntry32;
  arrPid: array [0..1023] of DWord;
  iC: DWord;
  k,iCount: Integer;
  arrModul: array [0..299] of Char;
  hdlModul: HMODULE;
begin
   result := false;

   if ExtractFileName(AProcesso)=AProcesso then
      bPath := false
   else
      bPath := true;
   verSystem.dwOSVersionInfoSize:=SizeOf(TOSVersionInfo);

   GetVersionEx(verSystem);

   if verSystem.dwPlatformId=VER_PLATFORM_WIN32_WINDOWS then
   begin
      hdlSnap:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
      peEntry.dwSize:=Sizeof(peEntry);
      bLoop:=Process32First(hdlSnap,peEntry);

      while integer(bLoop)<>0 do
      begin
         if bPath then
         begin
           if CompareText(peEntry.szExeFile,AProcesso)=0 then
           begin
             TerminateProcess(OpenProcess(PROCESS_TERMINATE,false,peEntry.th32ProcessID) ,0);
             result:=true;
           end;
         end
         else
         begin
           if CompareText(ExtractFileName(peEntry.szExeFile),AProcesso)=0 then
           begin
             TerminateProcess(OpenProcess(PROCESS_TERMINATE,false,peEntry.th32ProcessID) ,0);
             result:=true;
           end;
         end;
         bLoop:=Process32Next(hdlSnap,peEntry);
      end;

      CloseHandle(hdlSnap);
   end
   else
      if verSystem.dwPlatformId=VER_PLATFORM_WIN32_NT then
      begin
         EnumProcesses(@arrPid,SizeOf(arrPid),iC);
         iCount:=iC div SizeOf(DWORD);

         for k:=0 to Pred(iCount) do
         begin
           hdlProcess:=OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,false,arrPid [k]);
           if (hdlProcess<>0) then
           begin
             EnumProcessModules(hdlProcess,@hdlModul,SizeOf(hdlModul),iC);
             GetModuleFilenameEx(hdlProcess,hdlModul,arrModul,SizeOf(arrModul));
             if bPath then
             begin
               if CompareText(arrModul,AProcesso)=0 then
               begin
                 TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,False,arrPid [k]), 0);
                 result:=true;
               end;
             end
             else
             begin
               if CompareText(ExtractFileName(arrModul),AProcesso)=0 then
               begin
                 TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION,False,arrPid [k]), 0);
                 result:=true;
               end;
             end;
             CloseHandle(hdlProcess);
           end;
         end;
    end;
end;

{$REGION ListaProcessos}
{-----------------------------------------------------------------------------
  Método:     TALXProcessos.ListaProcessos
  Descrição:  <Este procedimento retorna todos os processos que estão em execução
               no Windows>
  Parâmetros: ALista: TStrings
  Histórico : <Alex Almeida 11/12/2008 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
class procedure TALXProcessos.ListaProcessos(ALista: TStrings);
var
   ProcEntry: TProcessEntry32;
   Hnd: THandle;
   Fnd: Boolean;
begin
   ALista.Clear;

   Hnd := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);

   if Hnd <> -1 then
   begin
      ProcEntry.dwSize := SizeOf(TProcessEntry32);

      Fnd := Process32First(Hnd, ProcEntry);

      while Fnd do
      begin
         ALista.Add(ProcEntry.szExeFile);
         Fnd := Process32Next(Hnd, ProcEntry);
      end;

      CloseHandle(Hnd);
   end;
end;

end.
