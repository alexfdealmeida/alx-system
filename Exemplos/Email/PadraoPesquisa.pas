unit PadraoPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, ExtCtrls, Mask,
  FMTBcd, DB, DBClient, Provider, SqlExpr, ActnList,
  Math, StrUtils, DBCtrls, JvExStdCtrls, JvEdit, JvValidateEdit,
  JvExMask, JvToolEdit;

type
  TCampo = record
    DescricaoCampo : String;
    Nome : String;
    Tipo : (Texto, Numero, Data);
  end;

  TFPadraoPesquisa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    gbxConsulta: TGroupBox;
    btnBuscar: TBitBtn;
    btnSair: TBitBtn;
    edtTexto: TEdit;
    sqqBusca: TSQLQuery;
    dspBusca: TDataSetProvider;                                   
    cdsBusca: TClientDataSet;
    dtsBusca: TDataSource;
    cbxBusca: TComboBox;
    ActionList1: TActionList;
    Action1: TAction;
    cbxSinal: TComboBox;
    edtData: TJvDateEdit;
    edtNumero: TJvValidateEdit;
    rdbSituacao: TRadioGroup;
    procedure btnSairClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action1Update(Sender: TObject);
    procedure cbxBuscaExit(Sender: TObject);
    procedure cbxSinalExit(Sender: TObject);
    procedure edtNumeroExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PreencheComboBox;
  private
    { Private declarations }
    FCampo : Array of TCampo;
    FSql, FSituacao, FTab, FCampoRetorno, FOpcao, FOpcao2 : String;
    procedure DefineDesenvolvedor;
    procedure DefineTicket;
  public
    { Public declarations }
    procedure DefineBusca(pTabela : String;
       Opcao: String = ''; CampoRetorno: String = ''; Opcao2: String = '');
  end;

var
  FPadraoPesquisa: TFPadraoPesquisa;

implementation

uses DPrincipal;

{$R *.dfm}

procedure TFPadraoPesquisa.DefineBusca(pTabela : String;
  Opcao: String = ''; CampoRetorno: String = ''; Opcao2: String = '');
begin
   FTab := UpperCase(pTabela);

   FOpcao := Opcao;
   FOpcao2 := Opcao2;
   FCampoRetorno := CampoRetorno;
   FSituacao := '';

   if FTab = 'DESENVOLVEDOR' then
   begin
      DefineDesenvolvedor;
   end
   else
   begin
      if FTab = 'TICKET' then
      begin
         DefineTicket;
      end;

   end;

end;

procedure TFPadraoPesquisa.DefineDesenvolvedor;
begin
   Caption := 'Busca - Desenvolvedor';

   FSql := ' select D.CODI_DES as "Codigo", D.NOME_DES "Nome" ' +
           ' from DESENVOLVEDOR D ';

   SetLength(FCampo, 2);

   FCampo[0].DescricaoCampo := 'Nome';
   FCampo[0].Nome := 'NOME_DES';
   FCampo[0].Tipo := Texto;

   FCampo[1].DescricaoCampo := 'Codigo';
   FCampo[1].Nome := 'CODI_DES';
   FCampo[1].Tipo := Numero;

   FCampoRetorno := 'Codigo';
end;

procedure TFPadraoPesquisa.DefineTicket;
begin
   Caption := 'Busca - Ticket';

   FSql := ' select T.CODI_TIC as "Codigo", T.DESC_TIC "Descricao" ' +
           ' from TICKET T ';

   SetLength(FCampo, 2);

   FCampo[0].DescricaoCampo := 'Descricao';
   FCampo[0].Nome := 'DESC_TIC';
   FCampo[0].Tipo := Texto;

   FCampo[1].DescricaoCampo := 'Codigo';
   FCampo[1].Nome := 'CODI_TIC';
   FCampo[1].Tipo := Numero;

   FCampoRetorno := 'Codigo';
end;

procedure TFPadraoPesquisa.PreencheComboBox;
var FLaco : Integer;
begin
   cbxBusca.Clear;
   for FLaco := low(FCampo) to High(FCampo) do
      cbxBusca.Items.Add(FCampo[FLaco].DescricaoCampo);
end;

procedure TFPadraoPesquisa.btnSairClick(Sender: TObject);
begin
   if cdsBusca.Active then
      DmPrincipal.vRetornoPesquisa := cdsBusca.FieldByName(FCampoRetorno).AsString
   else
      DmPrincipal.vRetornoPesquisa := '';
   Close;
end;

procedure TFPadraoPesquisa.btnBuscarClick(Sender: TObject);
var FSinal : String;
begin

(*   if FTab =  'LANCTOCAIXABANCO' then
   begin
      case rdbSituacao.ItemIndex of
        00: FSituacao := ' and L.LCBSITU in (''1'') ';
        01: FSituacao := ' and L.LCBSITU in (''2'') ';
        else FSituacao := '';
      end;
   end *)

   case cbxSinal.ItemIndex of
     00: FSinal := ' like ';
     01: FSinal := ' = ';
     02: FSinal := ' <= ';
     03: FSinal := ' >= ';
     05: FSinal := ' <> ';
   end;

   if (
       (FCampo[cbxBusca.ItemIndex].Tipo = Numero) or
       (FCampo[cbxBusca.ItemIndex].Tipo = Data)
      ) and
      (cbxSinal.ItemIndex = 0) then
   begin
      ShowMessage('Para este tipo de consulta use o "Maior ou Igual" inves do "Começa" ');
      Abort;
   end;

   cdsBusca.Close;

   if pos('where', FSql) > 0 then
      cdsBusca.CommandText := FSql + FSituacao + ' and '
   else
      cdsBusca.CommandText := FSql + FSituacao + ' where ';

   edtNumero.Visible := FCampo[cbxBusca.ItemIndex].Tipo = Numero;
   edtData.Visible := FCampo[cbxBusca.ItemIndex].Tipo = Data;
   edtTexto.Visible := FCampo[cbxBusca.ItemIndex].Tipo = Texto;

   case FCampo[cbxBusca.ItemIndex].Tipo of
     Numero: cdsBusca.CommandText := cdsBusca.CommandText + FCampo[cbxBusca.ItemIndex].Nome + FSinal + edtNumero.Text + ifthen(cbxSinal.ItemIndex = 0, '%', '');
     Texto:
     begin
        cdsBusca.CommandText := cdsBusca.CommandText + ' ((Upper('+ FCampo[cbxBusca.ItemIndex].Nome +') ' +
                                FSinal +
                                'Upper('+ QuotedStr(ifthen(Trim(edtTexto.text) = '', '%', edtTexto.Text)+
                                ifthen(cbxSinal.ItemIndex = 0, '%', '')) +'))';

        if Trim(edtTexto.Text) = '' then
           cdsBusca.CommandText := cdsBusca.CommandText +' or (Upper('+ FCampo[cbxBusca.ItemIndex].Nome +') is null)) '
        else
           cdsBusca.CommandText := cdsBusca.CommandText +') ';
     end;
     Data:   cdsBusca.CommandText := cdsBusca.CommandText + FCampo[cbxBusca.ItemIndex].Nome + FSinal + 'Upper('+ QuotedStr(FormatDateTime('mm/dd/yyyy', edtData.Date)) +')';
   end;

   cdsBusca.Open;
   DBGrid1.SetFocus;
end;

procedure TFPadraoPesquisa.FormShow(Sender: TObject);
begin
   PreencheComboBox;
   cbxBusca.ItemIndex := 0;

   if edtTexto.Visible then
      edtTexto.SetFocus
   else
   if edtNumero.Visible then
      edtNumero.SetFocus
   else
   if edtData.Visible then
      edtData.SetFocus
   else
      cbxBusca.SetFocus;
end;

procedure TFPadraoPesquisa.Action1Execute(Sender: TObject);
begin
//
end;

procedure TFPadraoPesquisa.Action1Update(Sender: TObject);
begin
   edtNumero.Visible := FCampo[cbxBusca.ItemIndex].Tipo = Numero;
   edtData.Visible := FCampo[cbxBusca.ItemIndex].Tipo = Data;
   edtTexto.Visible := FCampo[cbxBusca.ItemIndex].Tipo = Texto;

   if (
       (FCampo[cbxBusca.ItemIndex].Tipo = Data) or
       (FCampo[cbxBusca.ItemIndex].Tipo = Numero)
      ) and
      (cbxSinal.ItemIndex = 0) then
      cbxSinal.ItemIndex := 3;

end;

procedure TFPadraoPesquisa.cbxBuscaExit(Sender: TObject);
begin
   cbxSinal.SetFocus;
end;

procedure TFPadraoPesquisa.cbxSinalExit(Sender: TObject);
begin
   if edtNumero.Visible then
      edtNumero.SetFocus
   else
   if edtData.Visible then
      edtData.SetFocus
   else
   if edtTexto.Visible then
      edtTexto.SetFocus;
end;

procedure TFPadraoPesquisa.edtNumeroExit(Sender: TObject);
begin
   btnBuscar.SetFocus;
end;

procedure TFPadraoPesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
   begin
      if (not (ActiveControl is TDBGrid)) and
         (not (ActiveControl is TMemo)) and
         (not (ActiveControl is TDbMemo)) and
         (not (ActiveControl is TBitBtn)) then
      begin
         Perform(Wm_NextDlgCtl, 0, 0);
         Key := #0;
      end;
   end;

end;

procedure TFPadraoPesquisa.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
   if key = #13 then
      btnSair.SetFocus;
end;

procedure TFPadraoPesquisa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
end;

end.
