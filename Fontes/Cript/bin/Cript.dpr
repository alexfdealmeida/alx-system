program Cript;

uses
  Forms,
  Controls,
  UCriptografia in '..\src\UCriptografia.pas' {Form1},
  ALXFuncoes in '..\..\Biblioteca\Métodos\ALXFuncoes.pas',
  ALXOpcoes in '..\..\Biblioteca\Métodos\ALXOpcoes.pas' {frmOpcoes},
  UMaster in '..\..\Biblioteca\Herança\UMaster.pas' {FMaster},
  UPermissao in '..\..\Biblioteca\Formulários\UPermissao.pas' {frmPermissao},
  ALXVariaveis in '..\..\Biblioteca\Formulários\ALXVariaveis.pas';

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
