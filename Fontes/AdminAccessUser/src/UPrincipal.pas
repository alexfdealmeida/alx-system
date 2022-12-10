unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, JvExControls, JvEnterTab,
  JvComponentBase, Spin, JvExMask, JvSpin, JvToolEdit;

type
  TfrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    pnlBotoes: TPanel;
    btnSair: TBitBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    pnlManutencao: TGroupBox;
    lblDias: TLabel;
    lblPrograma: TLabel;
    cbxPrograma: TComboBox;
    btnGravar: TBitBtn;
    edtDias: TJvSpinEdit;
    mmoLicenca: TMemo;
    lblData: TLabel;
    edtData: TJvDateEdit;
    lblCliente: TLabel;
    cbxCliente: TComboBox;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    function Valida(AIndice: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TfrmPrincipal.btnGravarClick(Sender: TObject);
var
   lChaveValor: string;
   lLista: TStrings;
begin
   if not Valida(1) or not Valida(2) or not Valida(3) or not Valida(4) then
      Exit;

   mmoLicenca.Clear;

   lChaveValor := TALXFuncoes.Criptografa(cbxPrograma.Text + ';' + cbxCliente.Text + ';' + edtData.Text + ';' + edtDias.Text);

   mmoLicenca.Lines.Add(lChaveValor);

   lLista := TStringList.Create;

   try

      lLista.Add(mmoLicenca.Text);

      lLista.SaveToFile(ExtractFilePath(ParamStr(0)) + cbxPrograma.Text + '_' + cbxCliente.Text + '_' + FormatDateTime('ddmmyyyy', edtData.Date) + '_' + edtDias.Text + '.txt');

   finally
      FreeAndNil(lLista);
   end;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
   edtData.Date := Date;
   cbxPrograma.ItemIndex := 0;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      btnSairClick(Sender);
end;

function TfrmPrincipal.Valida(AIndice: Integer): Boolean;
begin
   Result := True;

   case AIndice of
      1:
      begin
         if Trim(cbxPrograma.Text) = '' then
         begin
            TALXFuncoes.Aviso('O campo "Programa" deve ser informado!');
            Result := False;
            cbxPrograma.SetFocus;
         end;
      end;
      2:
      begin
         if Trim(cbxCliente.Text) = '' then
         begin
            TALXFuncoes.Aviso('O campo "Cliente" deve ser informado!');
            Result := False;
            cbxCliente.SetFocus;
         end;
      end;
      3:
      begin
         if edtData.Date = 0 then
         begin
            TALXFuncoes.Aviso('O campo "Data" deve ser informado!');
            Result := False;
            edtData.SetFocus;
         end;
      end;
      4:
      begin
         if edtDias.Value = 0 then
         begin
            TALXFuncoes.Aviso('O campo "Quantidade de dias" deve ser informado!');
            Result := False;
            edtDias.SetFocus;
         end;
      end;
   end;

end;

end.
