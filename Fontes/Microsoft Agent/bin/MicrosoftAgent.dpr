program MicrosoftAgent;

uses
  Forms,
  UPrincipal in '..\src\UPrincipal.pas' {Form1},
  firstFuncoes in '..\..\..\1stBiblt\src\firstFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
