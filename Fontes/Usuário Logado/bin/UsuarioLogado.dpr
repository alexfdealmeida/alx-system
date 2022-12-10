program UsuarioLogado;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  firstFuncoes in '..\..\..\1stBiblt\Procedimentos\firstFuncoes.pas',
  firstOpcoes in '..\..\..\1stBiblt\Procedimentos\firstOpcoes.pas' {frmOpcoes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
