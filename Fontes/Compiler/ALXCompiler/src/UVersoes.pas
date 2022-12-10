unit UVersoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, JvExControls, JvEnterTab, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, Mask, DBCtrls, JvBaseDlg, JvSelectDirectory, ImgList, ActnList,
  JvExButtons, JvBitBtn, JvExStdCtrls, JvButton, JvCtrls, JvDBCombobox,
  JvExMask, JvToolEdit, JvExExtCtrls, DBClient, DB, AppEvnts, JvCombobox,
  JvComponentBase, AdvOfficeStatusBar, AdvOfficeStatusBarStylers, AdvSmoothPanel,
  AdvGlowButton, AdvOfficeButtons, DBAdvOfficeButtons;

type
  TfrmVersoes = class(TfrmMasterCad)
    lblDESC_VER: TLabel;
    lblDFON_VER: TLabel;
    lblDEXE_VER: TLabel;
    lblDZIP_VER: TLabel;
    edtDESC_VER: TDBEdit;
    edtDEXE_VER: TDBEdit;
    edtDZIP_VER: TDBEdit;
    JvSelectDirectory1: TJvSelectDirectory;
    edtDFON_VER: TDBEdit;
    lblDGER_VER: TLabel;
    edtDGER_VER: TDBEdit;
    lblDREV_VER: TLabel;
    edtDREV_VER: TDBEdit;
    lblDCFG_VER: TLabel;
    edtDCFG_VER: TDBEdit;
    btnDFON_VER: TSpeedButton;
    btnDEXE_VER: TSpeedButton;
    btnDZIP_VER: TSpeedButton;
    btnDGER_VER: TSpeedButton;
    btnDREV_VER: TSpeedButton;
    btnDCFG_VER: TSpeedButton;
    lblVERS_VER: TLabel;
    edtVERS_VER: TDBEdit;
    dtsVersoes: TDataSource;
    lblGVPD_VER: TLabel;
    lblDTMP_VER: TLabel;
    edtDTMP_VER: TDBEdit;
    btnDTMP_VER: TSpeedButton;
    OpenDialog1: TOpenDialog;
    cbxDELP_VER: TJvDBComboBox;
    lblDELP_VER: TLabel;
    cbxGVPD_VER: TJvDBComboBox;
    chkInativo: TDBAdvOfficeCheckBox;
    ImageListVersao: TImageList;
    Panel1: TAdvSmoothPanel;
    BitBtn1: TAdvGlowButton;
    procedure btnDFON_VERClick(Sender: TObject);
    procedure btnDEXE_VERClick(Sender: TObject);
    procedure btnDZIP_VERClick(Sender: TObject);
    procedure edtDESC_VERExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnDGER_VERClick(Sender: TObject);
    procedure btnDREV_VERClick(Sender: TObject);
    procedure btnDCFG_VERClick(Sender: TObject);
    procedure edtVERS_VERExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnDTMP_VERClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      AcdsVersoes, AcdsLibraryPath: TClientDataSet;
      ATipoManutencao: TTipoManutencao = tmIncluir;
      AIncluirAuto: Boolean = false); reintroduce; overload;
  end;

var
  frmVersoes: TfrmVersoes;

implementation

uses UPrincipal, DVersaoBase, DVersoes, UManutLibraryPath,
     ALXFuncoes, ALXArquivos, DParametros, ALXCompilerFuncoesDB,
     ALXCompilerVariaveis, ULibraryPath;

{$R *.dfm}

procedure TfrmVersoes.BitBtn1Click(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Obrigatorio(edtDESC_VER, 'descrição') or
      TALXFuncoes.Obrigatorio(edtVERS_VER, 'versão do executável') or
      TALXFuncoes.Obrigatorio(edtVERS_VER, 'versão do delphi') then
   begin
      Exit;
   end;

   {frmManutLibraryPath := TfrmManutLibraryPath.Create(Self);
   frmManutLibraryPath.ShowModal;}

   frmManutLibraryPath := TfrmManutLibraryPath.Create(Self,
                                                      dmVersoes.cdsLibraryPath,
                                                      frmLibraryPath,
                                                      TfrmLibraryPath,
                                                      'DESC_LIB',
                                                      ['INDI_LIB', 'DESC_LIB'],
                                                      False);
   frmManutLibraryPath.ShowModal;
end;

procedure TfrmVersoes.btnDCFG_VERClick(Sender: TObject);
begin
  inherited;

   if OpenDialog1.Execute then
      edtDCFG_VER.Field.AsString := OpenDialog1.FileName;
end;

procedure TfrmVersoes.btnDEXE_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDEXE_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoes.btnDFON_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDFON_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoes.btnDGER_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDGER_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoes.btnDREV_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDREV_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoes.btnDTMP_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDTMP_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoes.btnDZIP_VERClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDZIP_VER.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmVersoes.btnGravarClick(Sender: TObject);
var
   lDrive: string;
begin
   if TALXFuncoes.Obrigatorio(edtDESC_VER, 'descrição') or
      TALXFuncoes.Obrigatorio(edtVERS_VER, 'versão do executável') or
      TALXFuncoes.Obrigatorio(edtVERS_VER, 'versão do delphi') then
   begin
      edtDESC_VER.SetFocus;
      Exit;
   end;

   if not TALXFuncoes.ValidaVersao(edtVERS_VER.Text) then
   begin
      edtVERS_VER.SetFocus;
      Exit;
   end;

   if (Trim(edtDFON_VER.Text) <> '') then
   begin
      if not (TALXFuncoes.DiretorioValido(edtDFON_VER.Text, 'diretório dos fontes', CARACTERES_ESPECIAIS_IGNORADOS)) then
      begin
         edtDFON_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioExiste('diretório dos fontes', edtDFON_VER.Text)) then
      begin
         edtDFON_VER.SetFocus;
         Exit;
      end;
   end;

   if (Trim(edtDGER_VER.Text) <> '') then
   begin
      if not (TALXFuncoes.DiretorioValido(edtDGER_VER.Text, 'diretório dos fontes (GERAL)', CARACTERES_ESPECIAIS_IGNORADOS)) then
      begin
         edtDGER_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioExiste('diretório dos fontes (GERAL)', edtDGER_VER.Text)) then
      begin
         edtDGER_VER.SetFocus;
         Exit;
      end;
   end;

   if (Trim(edtDREV_VER.Text) <> '') then
   begin
      if not (TALXFuncoes.DiretorioValido(edtDREV_VER.Text, 'diretório dos fontes (Revenda Windows)', CARACTERES_ESPECIAIS_IGNORADOS)) then
      begin
         edtDREV_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioExiste('diretório dos fontes (Revenda Windows)', edtDREV_VER.Text)) then
      begin
         edtDREV_VER.SetFocus;
         Exit;
      end;
   end;

   if (Trim(edtDTMP_VER.Text) <> '') then
   begin
      lDrive := Copy(edtDTMP_VER.Text, 1, 1);

      if TALXArquivos.RetornaTipoDrive(lDrive[1]) <> tdFixo then
      begin
         TALXFuncoes.Aviso('Diretório dos executáveis (temporário) inválido!');
         edtDTMP_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioValido(edtDTMP_VER.Text, 'diretório dos executáveis (temporário)', CARACTERES_ESPECIAIS_IGNORADOS)) then
      begin
         edtDTMP_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.DiretorioExiste('diretório dos executáveis (temporário)', edtDTMP_VER.Text)) then
      begin
         edtDTMP_VER.SetFocus;
         Exit;
      end;

      if not (TALXFuncoes.CriarDiretorio(edtDTMP_VER.Text + TEMP)) then
      begin
         edtDTMP_VER.SetFocus;
         Exit;
      end;
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

   if (Trim(edtDEXE_VER.Text) <> '') and (Trim(edtDTMP_VER.Text) <> '') then
   begin
      if LowerCase(Trim(edtDEXE_VER.Text)) = LowerCase(Trim(edtDTMP_VER.Text + TEMP)) then
      begin
         TALXFuncoes.Aviso('O diretório dos executáveis (local) não pode ser o mesmo diretório dos executáveis (temporário)!');
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

   if (Trim(edtDCFG_VER.Text) <> '') then
   begin
      if not (TALXFuncoes.ArquivoExiste(edtDCFG_VER.Text, True, 'Arquivo de conexão a base de dados inválido!')) then
      begin
         Exit;
      end;
   end;

  inherited;
end;

constructor TfrmVersoes.Create(AOwner: TComponent; AcdsVersoes,
   AcdsLibraryPath: TClientDataSet;
   ATipoManutencao: TTipoManutencao; AIncluirAuto: Boolean);
begin
   inherited Create(AOwner,
                    AcdsVersoes,
                    ATipoManutencao);

   if AIncluirAuto then
   begin
      FClientDataSet.FieldByName('DESC_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DESC_VER').AsString + ' Copy ';
      FClientDataSet.FieldByName('VERS_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('VERS_VER').AsString;
      FClientDataSet.FieldByName('DELP_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DELP_VER').AsString;
      FClientDataSet.FieldByName('DFON_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DFON_VER').AsString;
      FClientDataSet.FieldByName('DGER_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DGER_VER').AsString;
      FClientDataSet.FieldByName('DREV_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DREV_VER').AsString;
      FClientDataSet.FieldByName('DTMP_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DTMP_VER').AsString;
      FClientDataSet.FieldByName('DEXE_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DEXE_VER').AsString;
      FClientDataSet.FieldByName('DZIP_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DZIP_VER').AsString;
      FClientDataSet.FieldByName('DCFG_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('DCFG_VER').AsString;
      FClientDataSet.FieldByName('SITU_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('SITU_VER').AsString;
      FClientDataSet.FieldByName('CODI_USU').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('CODI_USU').AsString;
      FClientDataSet.FieldByName('GVPD_VER').AsString := dmVersaoBase.cdsVersoesTemp.FieldByName('GVPD_VER').AsString;

      FClientDataSet.Post;

      {Filtra apenas os library paths da versão selecionada como base}
      dmVersaoBase.cdsLibraryPathTemp.Filtered := False;
      dmVersaoBase.cdsLibraryPathTemp.Filter := '(CODI_USU = ' + dmVersaoBase.cdsVersoesTemp.FieldByName('CODI_USU').AsString + ') and ' +
                                                '(CODI_VER = ' + dmVersaoBase.cdsVersoesTemp.FieldByName('CODI_VER').AsString + ')';
      dmVersaoBase.cdsLibraryPathTemp.Filtered := True;

      dmVersaoBase.cdsLibraryPathTemp.First;
      while not dmVersaoBase.cdsLibraryPathTemp.Eof do
      begin
         AcdsLibraryPath.Append;
         AcdsLibraryPath.FieldByName('CODI_LIB').AsInteger := dmVersaoBase.cdsLibraryPathTemp.FieldByName('CODI_LIB').AsInteger;
         AcdsLibraryPath.FieldByName('CODI_VER').AsInteger := FClientDataSet.FieldByName('CODI_VER').AsInteger;
         AcdsLibraryPath.FieldByName('CODI_USU').AsInteger := FClientDataSet.FieldByName('CODI_USU').AsInteger;
         AcdsLibraryPath.FieldByName('INDI_LIB').AsString  := dmVersaoBase.cdsLibraryPathTemp.FieldByName('INDI_LIB').AsString;
         AcdsLibraryPath.FieldByName('DESC_LIB').AsString  := dmVersaoBase.cdsLibraryPathTemp.FieldByName('DESC_LIB').AsString;
         AcdsLibraryPath.Post;

         dmVersaoBase.cdsLibraryPathTemp.Next;
      end;

      dmVersaoBase.cdsLibraryPathTemp.Filtered := False;
      dmVersaoBase.cdsLibraryPathTemp.Filter := '';
   end;
end;

procedure TfrmVersoes.edtDESC_VERExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtDESC_VER, 'descrição') then
   begin
      Exit;
   end;
end;

procedure TfrmVersoes.edtVERS_VERExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtVERS_VER, 'versão') then
   begin
      Exit;
   end;
end;

end.
