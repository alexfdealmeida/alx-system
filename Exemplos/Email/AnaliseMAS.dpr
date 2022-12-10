program AnaliseMAS;

uses
  Forms,
  Principal in 'Principal.pas' {FPrincipal},
  LastKeyPressed in 'LastKeyPressed.pas',
  Ticket in 'Ticket.pas' {FTicket},
  DTicket in 'DTicket.pas' {DmTicket: TDataModule},
  DPrincipal in 'DPrincipal.pas' {dmPrincipal: TDataModule},
  PadraoPesquisa in 'PadraoPesquisa.pas' {FPadraoPesquisa},
  Mestre in 'Mestre.PAS' {FMestre},
  MestreCad in 'MestreCad.pas' {FMestreCad},
  ValidacaoCodigo in 'ValidacaoCodigo.pas' {FValidacaoCodigo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFMestre, FMestre);
  Application.CreateForm(TFMestre, FMestre);
  Application.CreateForm(TFMestreCad, FMestreCad);
  Application.CreateForm(TFValidacaoCodigo, FValidacaoCodigo);
  Application.Run;
end.
