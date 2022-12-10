program AtualizadorALXCompiler;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  DPrincipal in '..\src\DPrincipal.pas' {dmPrincipal: TDataModule},
  ALXCompilerFuncoesDB in '..\..\ALXCompiler\src\ALXCompilerFuncoesDB.pas',
  ALXCompilerVariaveis in '..\..\ALXCompiler\src\ALXCompilerVariaveis.pas',
  ALXProcessos in '..\..\..\Biblioteca\Métodos\ALXProcessos.pas',
  ALXArquivos in '..\..\..\Biblioteca\Métodos\ALXArquivos.pas',
  ALXFuncoes in '..\..\..\Biblioteca\Métodos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\..\Biblioteca\Métodos\ALXOpcoes.pas' {frmOpcoes},
  UMaster in '..\..\..\Biblioteca\Herança\UMaster.pas' {FMaster};

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
