program AdaptadorALXCompiler;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  DPrincipal in '..\src\DPrincipal.pas' {dmPrincipal: TDataModule},
  ALXCompilerFuncoesDB in '..\..\ALXCompiler\src\ALXCompilerFuncoesDB.pas',
  ALXOpcoes in '..\..\..\Biblioteca\M�todos\ALXOpcoes.pas' {frmOpcoes},
  ALXFuncoes in '..\..\..\Biblioteca\M�todos\ALXFuncoes.pas',
  ALXCompilerVariaveis in '..\..\ALXCompiler\src\ALXCompilerVariaveis.pas',
  UMaster in '..\..\..\Biblioteca\Heran�a\UMaster.pas' {FMaster};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Adaptador ALXCompiler';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  if ParamStr(1) = 'executar' then
    frmPrincipal.Executar := true
  else
    frmPrincipal.Executar := False;

  Application.Run;
end.
