program AccessUser;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  ALXFuncoes in '..\..\Biblioteca\M�todos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\Biblioteca\M�todos\ALXOpcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Access User';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
