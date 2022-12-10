unit ALXOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvOfficeStatusBar, StdCtrls, Buttons, ExtCtrls, AdvOfficePager,
  AdvGlowButton, AppEvnts, AdvGroupBox, AdvOfficeButtons, ImgList,
  AdvSmoothPanel, UMaster;

type
  TfrmOpcoes = class(TFMaster)
    ImageList1: TImageList;
    pnlAcoes: TAdvSmoothPanel;
    btnGravar: TAdvGlowButton;
    btnCancelar: TAdvGlowButton;
    pnlOpcoes: TAdvSmoothPanel;
    rdgOpcoes: TAdvOfficeRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    FOpcao: integer;
    procedure SetOpcao(const Value: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AOpcoes: array of string;
      ATitulo: String); reintroduce; overload;
    property Opcao: integer read FOpcao write SetOpcao;
  end;

var
  frmOpcoes: TfrmOpcoes;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TfrmOpcoes.btnCancelarClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfrmOpcoes.btnGravarClick(Sender: TObject);
begin
   if rdgOpcoes.ItemIndex < 0 then
   begin
      Application.MessageBox('Nenhuma opção selecionada!', 'Opções', MB_ICONINFORMATION + MB_OK);
      Exit;
   end;

   Opcao := rdgOpcoes.ItemIndex;

   ModalResult := mrOk;
end;

constructor TfrmOpcoes.Create(AOwner: TComponent; AOpcoes: array of string;
   ATitulo: String);
var
   I: Integer;
begin
   inherited Create(AOwner);

   rdgOpcoes.Caption := ATitulo;

   for I := Low(AOpcoes) to High(AOpcoes) do
   begin
      rdgOpcoes.Items.Add(AOpcoes[I]);
   end;

   rdgOpcoes.ItemIndex := 0;

   Self.Height := Self.Height + I;
end;

procedure TfrmOpcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

   frmOpcoes := nil;
end;

procedure TfrmOpcoes.SetOpcao(const Value: integer);
begin
  FOpcao := Value;
end;

end.
