program AdminAccessUser;

uses
  Forms,
  Controls,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  ALXFuncoes in '..\..\Biblioteca\Métodos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\Biblioteca\Métodos\ALXOpcoes.pas' {frmOpcoes},
  UPermissao in '..\..\Biblioteca\Formulários\UPermissao.pas',
  UMaster in '..\..\Biblioteca\Herança\UMaster.pas' {FMaster},
  ALXVariaveis in '..\..\Biblioteca\Formulários\ALXVariaveis.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AdminAccessUser';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);

  Application.CreateForm(TfrmPermissao, frmPermissao);
  frmPermissao.ShowModal;

  if frmPermissao.ModalResult = mrOk then
  begin
    Application.Run;
  end
  else
  begin
    Application.Terminate;
  end;

end.
