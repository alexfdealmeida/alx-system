unit Ticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MestreCad, DB, DBClient, Menus, StdCtrls, Buttons, Mask, ExtCtrls, ComCtrls,
  DTicket, JvExStdCtrls, JvDBCombobox, DBCtrls, JvEdit, JvValidateEdit, Grids, DBGrids,
  ValidacaoCodigo;

type
  TFTicket = class(TFMestreCad)
    Label3: TLabel;
    memDESC_TIC: TDBMemo;
    DBGrid1: TDBGrid;
    dtsValidacao: TDataSource;
    btnIncluiVal: TBitBtn;
    btnAlteraVal: TBitBtn;
    btnExcluiVal: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnIncluiValClick(Sender: TObject);
    procedure btnAlteraValClick(Sender: TObject);
    procedure btnExcluiValClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLocRegistroClick(Sender: TObject);
    procedure btnExcluiClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  private
    FModulo: TDmTicket;
    procedure ChamaValidacao(PTipo: Integer);
    procedure ChamaPesquisa(PTabela: Integer);
    { Private declarations }
  protected
    procedure Botoes; override;
  public
    { Public declarations }
  end;

var
  FTicket: TFTicket;

implementation

uses PadraoPesquisa, DPrincipal;

{$R *.dfm}

procedure TFTicket.Botoes;
begin
  inherited;
end;

procedure TFTicket.btnAlteraValClick(Sender: TObject);
begin
  inherited;
   ChamaValidacao(02);
end;

procedure TFTicket.btnExcluiClick(Sender: TObject);
begin

   if (MessageDlg('Deseja apagar ticket selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
   begin

      FModulo.cdsValidacao.DisableControls;
      try
        while FModulo.cdsValidacao.RecordCount > 0 do
        begin
           FModulo.cdsValidacao.Delete;
        end;

      finally
         FModulo.cdsValidacao.EnableControls;
      end;
      
      inherited;
   end;

end;

procedure TFTicket.btnExcluiValClick(Sender: TObject);
begin
  inherited;
   if (MessageDlg('Confirma exclusão da validação realizada?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
   begin
      FModulo.cdsValidacao.Delete;
   end;   
end;

procedure TFTicket.btnIncluiValClick(Sender: TObject);
begin
  inherited;
   ChamaValidacao(01);
end;

procedure TFTicket.btnLocRegistroClick(Sender: TObject);
begin
  inherited;
   ChamaPesquisa(01);
end;

procedure TFTicket.ChamaPesquisa(PTabela: Integer);
begin
   case PTabela of
    01:
    begin
       FPadraoPesquisa := TFPadraoPesquisa.Create(Application);
       FPadraoPesquisa.DefineBusca('TICKET');
       FPadraoPesquisa.ShowModal;

       edtCODIGO.Text := DmPrincipal.vRetornoPesquisa;
    end;
   end;
end;

procedure TFTicket.ChamaValidacao(PTipo: Integer);
var
  LFormulario: TFValidacaoCodigo;
begin
  inherited;
   LFormulario := TFValidacaoCodigo.Create(Self);
   LFormulario.dtsValidacao.DataSet := FModulo.cdsValidacao;

   if PTipo = 01 then
   begin
      FModulo.cdsValidacao.Append;
   end
   else
   begin
      FModulo.cdsValidacao.Edit;
   end;

   LFormulario.ShowModal;
end;

procedure TFTicket.edtCodigoExit(Sender: TObject);
begin
  inherited;

   if TabPrincipal.State = dsInsert then
   begin
      TabPrincipal.FieldByName('CODI_TIC').AsInteger := edtCodigo.AsInteger;
   end;

end;

procedure TFTicket.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FreeAndNil(FModulo);
end;

procedure TFTicket.FormCreate(Sender: TObject);
begin
  inherited;
   FModulo := TDmTicket.Create(Self);
   SetaCadastro(FModulo.cdsTicket, True);
   dtsValidacao.DataSet := FModulo.cdsValidacao;
end;

procedure TFTicket.FormShow(Sender: TObject);
begin
  inherited;
   ReabrirPrincipal := True;
end;

end.
