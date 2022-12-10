unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, AgentObjects_TLB, StdCtrls, Buttons, dxSkinsCore,
  dxSkinsDefaultPainters, cxGraphics, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxControls, cxContainer, cxEdit, cxGroupBox, JvExStdCtrls, JvCombobox, JvMemo,
  ExtCtrls;

type
  TTipoValidacao = (tvFalar, tvTexto);

  TForm1 = class(TForm)
    Agent1: TAgent;
    JvMemo1: TJvMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    gbxAgente: TGroupBox;
    cbxAgente: TJvComboBox;
    BitBtn2: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure cbxAgenteSelect(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FNomeAgente: String;
    FAgente: IAgentCtlCharacter;
    procedure SetValoresPadroes;
    function GetNomeAgente: String;
    function Valida(ATipoValidacao: TTipoValidacao): Boolean;
  public
    { Public declarations }
  end;

const
   ExtensaoAgente = '.acs';

var
  Form1: TForm1;

implementation

uses firstFuncoes;

{$R *.dfm}

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   if not Valida(tvFalar) and
      not Valida(tvTexto) then
      Exit;

   FAgente.Speak(JvMemo1.Lines.Text, EmptyStr);
end;

procedure TForm1.cbxAgenteSelect(Sender: TObject);
var
   lNomeAgenteAnterior: string;
begin
   lNomeAgenteAnterior := FNomeAgente;

   FNomeAgente := GetNomeAgente;

   if FAgente <> nil then
      Agent1.Characters.Unload(lNomeAgenteAnterior);

   Agent1.Characters.Load(FNomeAgente, FNomeAgente + ExtensaoAgente);

   // Associar o agente à variável Agente
   FAgente := Agent1.Characters[FNomeAgente];
   FAgente.Show(0); // Aparecer 0-lentamente 1-instantaneamente
   FAgente.MoveTo(100, 100, 50);
   FAgente.Play('Greet'); // Cumprimentar
   FAgente.Play('Announce'); // Anunciar
   FAgente.Speak('Olá, tudo bem?', EmptyStr);
   FAgente.Speak('Meu nome é ' + FNomeAgente, EmptyStr);
   FAgente.Speak('Escreva um texto abaixo e clique no botão falar', EmptyStr);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   SetValoresPadroes;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FAgente.Hide(0);
   Agent1.Characters.Unload(FNomeAgente);
end;

function TForm1.GetNomeAgente: String;
begin
   Result := '';

   case cbxAgente.ItemIndex of
      00 : Result := 'merlin';
      01 : Result := 'peedy';
      02 : Result := 'audie';
      03 : Result := 'genie';
      04 : Result := 'oscar';
      05 : Result := 'robby';
      06 : Result := 'santa';
   end;
end;

procedure TForm1.SetValoresPadroes;
begin
   cbxAgente.ItemIndex := -1;

   FNomeAgente := GetNomeAgente;
end;

function TForm1.Valida(ATipoValidacao: TTipoValidacao): Boolean;
begin
   Result := True;

   case ATipoValidacao of
      tvFalar :
      begin
         if FNomeAgente = '' then
         begin
            TFuncao.Aviso('Nenhum agente selecionado!');
            cbxAgente.SetFocus;
            Result := False;
         end;
      end;
      tvTexto :
      begin
         if trim(JvMemo1.Lines.Text) = '' then
         begin
            FAgente.Play('Confused');
            FAgente.Speak('Você não informou nenhum texto.', EmptyStr);
            JvMemo1.SetFocus;
            Result := False;
         end;
      end;
   end;
end;

end.
