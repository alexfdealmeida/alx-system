program AtualizadorALXCompiler;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  DPrincipal in '..\src\DPrincipal.pas' {dmPrincipal: TDataModule},
  ALXCompilerFuncoesDB in '..\..\ALXCompiler\src\ALXCompilerFuncoesDB.pas',
  ALXCompilerVariaveis in '..\..\ALXCompiler\src\ALXCompilerVariaveis.pas',
  ALXProcessos in '..\..\..\Biblioteca\M�todos\ALXProcessos.pas',
  ALXArquivos in '..\..\..\Biblioteca\M�todos\ALXArquivos.pas',
  ALXFuncoes in '..\..\..\Biblioteca\M�todos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\..\Biblioteca\M�todos\ALXOpcoes.pas' {frmOpcoes},
  UMaster in '..\..\..\Biblioteca\Heran�a\UMaster.pas' {FMaster};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Atualizador ALXCompiler';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  if ParamStr(1) = 'executar' then
    frmPrincipal.Executar := true
  else
    frmPrincipal.Executar := false;

  Application.Run;
end.
