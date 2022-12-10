unit UVersoesSintetico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, ActnList, JvComponentBase, JvEnterTab, ImgList,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers, StdCtrls, Buttons,
  AdvSmoothPanel, Mask, DBCtrls, DB, JvBaseDlg, JvSelectDirectory;

type
  TfrmVersoesSinteticos = class(TfrmMasterCad)
    lblVERS_VER: TLabel;
    edtVERS_VER: TDBEdit;
    dtsVersoes: TDataSource;
    lblDEXE_VER: TLabel;
    edtDEXE_VER: TDBEdit;
    btnDEXE_VER: TSpeedButton;
    lblDZIP_VER: TLabel;
    edtDZIP_VER: TDBEdit;
    btnDZIP_VER: TSpeedButton;
    JvSelectDirectory1: TJvSelectDirectory;
    procedure btnGravarClick(Sender: TObject);
    procedure btnDEXE_VERClick(Sender: TObject);
    procedure btnDZIP_VERClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVersoesSinteticos: TfrmVersoesSinteticos;

implementation

uses DVersoes, ALXFuncoes, ALXArquivos, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmVersoesSinteticos.btnDEXE_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDEXE_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoesSinteticos.btnDZIP_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDZIP_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoesSinteticos.btnGravarClick(Sender: TObject);
var
   lDrive: string;
begin
   if TALXFuncoes.Obrigatorio(edtVERS_VER, 'versão do executável') then
   begin
      edtVERS_VER.SetFocus;
      Exit;
   end;

   if not TALXFuncoes.ValidaVersao(edtVERS_VER.Text) then
   begin
      edtVERS_VER.SetFocus;
      Exit;
   end;

   if (Trim(edtDEXE_VER.Text) <> '') then
   begin
      lDrive := Copy(edtDEXE_VER.Text, 1, 1);

      if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdFixo then
      begin
         TALXFuncoes.Aviso('Diretório dos executáveis (local) inválido!');
         edtDEXE_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioValido(edtDEXE_VER.Text, 'diretório dos executáveis (local)', CARACTERES_ESPECIAIS_IGNORADOS)) then
      begin
         edtDEXE_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (local)', edtDEXE_VER.Text)) then
      begin
         edtDEXE_VER.SetFocus;
         Exit;
      end;
   end;

   if (Trim(edtDZIP_VER.Text) <> '') then
   begin
      lDrive := Copy(edtDZIP_VER.Text, 1, 2);

      if lDrive <> '\\' then
      begin
         if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdRede then
         begin
            TALXFuncoes.Aviso('Diretório dos executáveis (remoto) inválido!');
            edtDZIP_VER.SetFocus;
            Exit;
         end;
      end;

      if not (TALXFuncoes.DiretorioValido(edtDZIP_VER.Text, 'diretório dos executáveis (remoto)', CARACTERES_ESPECIAIS_IGNORADOS, False)) then
      begin
         edtDZIP_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (remoto)', edtDZIP_VER.Text)) then
      begin
         edtDZIP_VER.SetFocus;
         Exit;
      end;
   end;

  inherited;
end;

end.
