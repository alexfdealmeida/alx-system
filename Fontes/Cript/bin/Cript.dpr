program Cript;

uses
  Forms,
  Controls,
  UCriptografia in '..\src\UCriptografia.pas' {Form1},
  ALXFuncoes in '..\..\Biblioteca\M�todos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\Biblioteca\M�todos\ALXOpcoes.pas' {frmOpcoes},
  UMaster in '..\..\Biblioteca\Heran�a\UMaster.pas' {FMaster},
  UPermissao in '..\..\Biblioteca\Formul�rios\UPermissao.pas' {frmPermissao},
  ALXVariaveis in '..\..\Biblioteca\Formul�rios\ALXVariaveis.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCriptografia, frmCriptografia);

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
