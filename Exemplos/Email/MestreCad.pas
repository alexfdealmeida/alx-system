unit MestreCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mestre, Menus, ComCtrls, StdCtrls, Buttons, Mask, ExtCtrls, DB, DBClient, JvExStdCtrls, JvEdit,
  JvValidateEdit;

type
  TFMestreCad = class(TFMestre)
    pnlGeral: TPanel;
    Label1: TLabel;
    btnLocRegistro: TSpeedButton;
    pnlManutencao: TPanel;
    pnlOpcoes: TPanel;
    btnAltera: TBitBtn;
    btnExclui: TBitBtn;
    btnConfirma: TBitBtn;
    btnSair: TBitBtn;
    edtCodigo: TJvValidateEdit;
    dtsTabelaPrincipal: TDataSource;
    procedure btnAlteraClick(Sender: TObject);
    procedure btnExcluiClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocRegistroClick(Sender: TObject);
  private
    { Private declarations }
    FTabPrincipal: TClientDataSet;
    FCodigoInformadoManual: Boolean;
    FReabrirPrincipal: Boolean;
  protected
    function Valida(PCampo: Integer): Boolean; virtual;
    procedure SetaParametros; virtual;
    procedure SetaCadastro(PTabela: TClientDataSet;
      PInformaCodigoManual: Boolean); virtual;
    procedure Botoes; virtual;
  public
    { Public declarations }
    property TabPrincipal: TClientDataSet read FTabPrincipal;
    property ReabrirPrincipal: Boolean read FReabrirPrincipal write FReabrirPrincipal;
  end;

var
  FMestreCad: TFMestreCad;

implementation

{$R *.dfm}

{ TFMestreCad }

procedure TFMestreCad.Botoes;
begin
   btnAltera.Enabled     := (TabPrincipal.Active) and
                            (TabPrincipal.RecordCount > 0) and
                            (not (TabPrincipal.State in [dsInsert, dsEdit]));

   btnConfirma.Enabled   := (TabPrincipal.Active) and
                            (TabPrincipal.State in [dsInsert, dsEdit]);

   btnExclui.Enabled     := btnAltera.Enabled;
   pnlManutencao.Enabled := btnConfirma.Enabled;

   if btnConfirma.Enabled then
   begin
      btnSair.Caption := '&Cancelar';
   end
   else
   begin
      btnSair.Caption := '&Sair';
   end;


end;

procedure TFMestreCad.btnAlteraClick(Sender: TObject);
begin
  inherited;

   TabPrincipal.Edit;

   Botoes;
   FindNextControl(pnlManutencao, True, True, False).SetFocus;
end;

procedure TFMestreCad.btnConfirmaClick(Sender: TObject);
begin
  inherited;

   if FTabPrincipal.ApplyUpdates(0) <> 0 then
   begin
      ShowMessage('Não foi possivel gravar as informações cadastradas. Verifique!');
      Abort;
   end;

   if ReabrirPrincipal then
   begin
      FTabPrincipal.Close;
      FTabPrincipal.Open;
   end;

   Botoes;
end;

procedure TFMestreCad.btnExcluiClick(Sender: TObject);
begin
  inherited;
  

   TabPrincipal.Delete;

   if TabPrincipal.ApplyUpdates(0) <> 0 then
   begin
      ShowMessage('Não foi possivel excluir o registro selecionado. Verifique!');
      TabPrincipal.CancelUpdates;
      Abort;
   end;

   edtCodigo.AsInteger := 0;
   
   if ReabrirPrincipal then
   begin
      FTabPrincipal.Close;
      FTabPrincipal.Open;
   end;

   Botoes;
end;

procedure TFMestreCad.btnLocRegistroClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TFMestreCad.btnSairClick(Sender: TObject);
begin
  inherited;

   if btnSair.Caption = '&Sair' then
   begin
      Close;
   end
   else
   begin
      TabPrincipal.Close;
      Botoes;
      edtCodigo.SetFocus;
   end;
end;

procedure TFMestreCad.edtCodigoExit(Sender: TObject);
begin
  inherited;
   if not VerFocus(edtCodigo) then
   begin

      if (FCodigoInformadoManual) and (edtCodigo.AsInteger <= 0) then
      begin
         ShowMessage('Informe o código!');
         edtCodigo.SetFocus;
         Abort;
      end;

      FTabPrincipal.Close;
      SetaParametros;
      FTabPrincipal.Open;

      if FTabPrincipal.RecordCount > 0 then
      begin
         Botoes;
         btnAltera.SetFocus;
      end
      else
      begin
         FTabPrincipal.Append;
         Botoes;
         FindNextControl(pnlManutencao, True, True, False).SetFocus;
      end;
   end;
end;

procedure TFMestreCad.edtCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if key = vk_F2 then
      btnLocRegistroClick(Sender);
end;

procedure TFMestreCad.SetaCadastro(PTabela: TClientDataSet; PInformaCodigoManual: Boolean);
begin
   FTabPrincipal              := PTabela;
   FCodigoInformadoManual     := PInformaCodigoManual;

   dtsTabelaPrincipal.DataSet := FTabPrincipal;
end;

procedure TFMestreCad.FormCreate(Sender: TObject);
begin
  inherited;
   FCodigoInformadoManual := False;
   FReabrirPrincipal := False;
end;

procedure TFMestreCad.FormShow(Sender: TObject);
begin
  inherited;
   FTabPrincipal.Close;
   Botoes;

   edtCodigo.SetFocus;
end;

procedure TFMestreCad.SetaParametros;
begin
   FTabPrincipal.Params[0].AsInteger := edtCodigo.AsInteger;
end;

function TFMestreCad.Valida(PCampo: Integer): Boolean;
begin
   Result := True;
end;

end.
