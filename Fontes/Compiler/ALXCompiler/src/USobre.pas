unit USobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, JvExExtCtrls,
  JvSecretPanel, JvExControls, JvStarfield, AdvOfficePager, AdvOfficeStatusBar,
  AdvSmoothPanel, AdvGlowButton, JvImage, AdvOfficeStatusBarStylers;

type
  TfrmSobre = class(TForm)
    pgcSobre: TAdvOfficePager;
    tabCreditos: TAdvOfficePage;
    sctCreditos: TJvSecretPanel;
    stbInfo: TAdvOfficeStatusBar;
    tabContato: TAdvOfficePage;
    AdvSmoothPanel1: TAdvSmoothPanel;
    btnFone: TAdvGlowButton;
    btnEmail: TAdvGlowButton;
    btnMSN: TAdvGlowButton;
    btnSkype: TAdvGlowButton;
    JvImage1: TJvImage;
    sctLicenca: TJvSecretPanel;
    stbStylerInfo: TAdvOfficeStatusBarOfficeStyler;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure sctCreditosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

uses UPrincipal, DParametros, DInfoDB, ALXCompilerVariaveis, ALXFuncoes,
  ALXCompilerFuncoesDB, ALXVariaveis;

{$R *.dfm}

procedure TfrmSobre.btnCancelarClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action   := caFree;
   frmSobre := nil;
end;

procedure TfrmSobre.FormCreate(Sender: TObject);
var
   lVersao: string;
begin
   pgcSobre.ActivePage := tabCreditos;

   btnEmail.Caption := btnEmail.Caption + DADOS_PESSOAIS.EMAIL;
   btnFone.Caption  := btnFone.Caption + DADOS_PESSOAIS.FONE_CEL;
   btnMSN.Caption   := btnMSN.Caption + DADOS_PESSOAIS.MSN;
   btnSkype.Caption := btnSkype.Caption + DADOS_PESSOAIS.SKYPE;

   lVersao := dmInfoDB.cdsInfoDBVERS_INF.AsString;

   Insert('.', lVersao, 2);
   Insert('.', lVersao, 4);
   Insert('.', lVersao, 6);

   stbInfo.Panels[0].Text := 'Versão ' + lVersao;

   sctLicenca.Lines.Clear;
   sctLicenca.Lines.Add('Faltam ' + dmParametros.cdsParametrosEXLC_CFG.AsString + ' dias para sua licença expirar!');
end;

procedure TfrmSobre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_Escape) then
      Close;
end;

procedure TfrmSobre.sctCreditosClick(Sender: TObject);
begin
   Close;
end;

end.
