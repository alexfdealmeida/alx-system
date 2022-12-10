program AccessUser;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  ALXFuncoes in '..\..\Biblioteca\Métodos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\Biblioteca\Métodos\ALXOpcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Access User';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
