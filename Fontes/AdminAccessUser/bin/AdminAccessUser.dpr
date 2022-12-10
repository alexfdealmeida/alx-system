program AdminAccessUser;

uses
  Forms,
  Controls,
  UPrincipal in '..\src\UPrincipal.pas' {frmPrincipal},
  ALXFuncoes in '..\..\Biblioteca\M�todos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\Biblioteca\M�todos\ALXOpcoes.pas' {frmOpcoes},
  UPermissao in '..\..\Biblioteca\Formul�rios\UPermissao.pas',
  UMaster in '..\..\Biblioteca\Heran�a\UMaster.pas' {FMaster},
  ALXVariaveis in '..\..\Biblioteca\Formul�rios\ALXVariaveis.pas';

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
