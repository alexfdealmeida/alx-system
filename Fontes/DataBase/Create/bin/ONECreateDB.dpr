program ONECreateDB;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  TBODbxDynalink,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  FirstDataBase in '..\src\FirstDataBase.pas',
  firstFuncoes in '..\..\..\..\1stBiblt\src\firstFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
