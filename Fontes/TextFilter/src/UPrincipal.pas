unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    gbxTSVN_CFG: TGroupBox;
    btnTSVN_CFG: TSpeedButton;
    edtArquivoOrig: TEdit;
    GroupBox1: TGroupBox;
    edtFiltro: TEdit;
    pnlBotoes: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure btnTSVN_CFGClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ProcessaArquivoTexto;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmPrincipal.btnGravarClick(Sender: TObject);
begin
   ProcessaArquivoTexto;
end;

procedure TfrmPrincipal.btnTSVN_CFGClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
      edtArquivoOrig.Text := OpenDialog1.FileName;
end;

procedure TfrmPrincipal.ProcessaArquivoTexto;
var
   Arquivo: TStringList;
   ArquivoFiltrado: TStringList;
   I: Integer;
begin

   Arquivo := TStringList.Create;
   ArquivoFiltrado := TStringList.Create;

   try

      if  (FileExists(edtArquivoOrig.Text)) then
      begin

         Arquivo.Clear;
         ArquivoFiltrado.Clear;

         Arquivo.LoadFromFile(edtArquivoOrig.Text);

         for I := 0 to Arquivo.Count - 1 do
         begin
            if Pos(UpperCase(edtFiltro.Text), UpperCase(Arquivo[I])) > 0 then
               ArquivoFiltrado.Add(Arquivo[I])
         end;

         if ArquivoFiltrado.Count > 0 then
         begin
            ArquivoFiltrado.SaveToFile(ExtractFilePath(edtArquivoOrig.Text) + '/filter ' + ExtractFileName(edtArquivoOrig.Text));

            Application.MessageBox('Arquivo filtrado com sucesso!', 'TextFilter', MB_OK + MB_ICONINFORMATION);
         end
         else
         begin
            Application.MessageBox('O filtro informado não foi localizado!', 'TextFilter', MB_OK + MB_ICONWARNING);
         end;

      end
      else
      begin
         Application.MessageBox('Arquivo inexistente!', 'TextFilter', MB_OK + MB_ICONERROR);
      end;

   finally
      FreeAndNil(Arquivo);
      FreeAndNil(ArquivoFiltrado);
   end;
end;

end.
