unit UBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, JvExControls, JvEnterTab, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, ActnList, ImgList, JvBaseDlg, JvSelectDirectory, JvExStdCtrls,
  JvButton, JvCtrls, JvDBCombobox, Mask, DBCtrls, JvExExtCtrls, DB, JvExMask,
  JvSpin, JvDBSpinEdit, AppEvnts, DBClient, AdvOfficeStatusBar, JvCombobox,
  JvComponentBase, AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TBancoDados = (bdFirebird, bdOracle);

  TfrmBases = class(TfrmMasterCad)
    ImageListImagens: TImageList;
    lblDESC_VER: TLabel;
    edtDESC_BAS: TDBEdit;
    lblVersaoDelphi: TLabel;
    cbxTIPO_BAS: TJvDBComboBox;
    lblDIRE_BAS: TLabel;
    edtDIRE_BAS: TDBEdit;
    OpenDialogDiretorioBase: TOpenDialog;
    actLstAtualiza: TActionList;
    actAtualiza: TAction;
    btnDIRE_BAS: TSpeedButton;
    dtsBases: TDataSource;
    lblSNAM_BAS: TLabel;
    edtSNAM_BAS: TDBEdit;
    lblSERV_BAS: TLabel;
    edtSERV_BAS: TDBEdit;
    lblPORT_BAS: TLabel;
    edtPORT_BAS: TJvDBSpinEdit;
    procedure btnDIRE_BASClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtDESC_BASExit(Sender: TObject);
    procedure cbxTIPO_BASExit(Sender: TObject);
    procedure actAtualizaExecute(Sender: TObject);
    procedure actAtualizaUpdate(Sender: TObject);
    procedure edtDIRE_BASExit(Sender: TObject);
    procedure edtSNAM_BASExit(Sender: TObject);
    procedure edtSERV_BASExit(Sender: TObject);
    procedure edtPORT_BASExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ABancoDados: TBancoDados;
      AClientDataSet: TClientDataSet;
      ATipoManutencao: TTipoManutencao = tmIncluir); reintroduce; overload;
  end;

var
  frmBases: TfrmBases;

implementation

uses UPrincipal, DBases, DParametros, ALXCompilerFuncoesDB, ALXFuncoes;

{$R *.dfm}

procedure TfrmBases.actAtualizaExecute(Sender: TObject);
begin
  inherited;
   { Favor não remover este comentário }
end;

procedure TfrmBases.actAtualizaUpdate(Sender: TObject);
begin
  inherited;
   case cbxTIPO_BAS.ItemIndex of
      00 :
      begin
         lblDIRE_BAS.Caption := 'Base de Dados';
         lblSNAM_BAS.Visible := False;
         edtSNAM_BAS.Visible := False;
         btnDIRE_BAS.Visible := True;
      end;
      01 : begin
         lblDIRE_BAS.Caption := 'Schema';
         lblSNAM_BAS.Visible := True;
         edtSNAM_BAS.Visible := True;
         btnDIRE_BAS.Visible := False;
      end;
   end;
end;

procedure TfrmBases.btnDIRE_BASClick(Sender: TObject);
begin
  inherited;
   if OpenDialogDiretorioBase.Execute then
      edtDIRE_BAS.Field.Value := OpenDialogDiretorioBase.FileName;
end;

procedure TfrmBases.btnGravarClick(Sender: TObject);
begin
   if TALXFuncoes.Obrigatorio(edtDESC_BAS, 'descrição') or
      TALXFuncoes.Obrigatorio(cbxTIPO_BAS, 'SGBD') or
      TALXFuncoes.Obrigatorio(edtDIRE_BAS, 'base de dados') or
      ((cbxTIPO_BAS.ItemIndex = 1) and (TALXFuncoes.Obrigatorio(edtSNAM_BAS, 'service name'))) or
      TALXFuncoes.Obrigatorio(edtSERV_BAS, 'servidor') or
      TALXFuncoes.Obrigatorio(edtPORT_BAS, 'porta') then
   begin
      Exit;
   end;

  inherited;
end;

procedure TfrmBases.cbxTIPO_BASExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(cbxTIPO_BAS, 'SGBD') then
   begin
      Exit;
   end;
end;

constructor TfrmBases.Create(AOwner: TComponent; ABancoDados: TBancoDados;
   AClientDataSet: TClientDataSet; ATipoManutencao: TTipoManutencao = tmIncluir);
begin
   inherited Create(AOwner,
                    AClientDataSet,
                    ATipoManutencao);

   if ABancoDados = bdFirebird then
   begin
      FClientDataSet.FieldByName('TIPO_BAS').AsString := 'FB';
      FClientDataSet.FieldByName('SERV_BAS').AsString := 'localhost';
      FClientDataSet.FieldByName('PORT_BAS').AsString := '3050';
   end
   else if ABancoDados = bdOracle then
   begin
      FClientDataSet.FieldByName('TIPO_BAS').AsString := 'OC';
      FClientDataSet.FieldByName('SNAM_BAS').AsString := 'ORCL';
      FClientDataSet.FieldByName('SERV_BAS').AsString := '10.0.0.100';
      FClientDataSet.FieldByName('PORT_BAS').AsString := '1521';
   end;
end;

procedure TfrmBases.edtDESC_BASExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtDESC_BAS, 'descrição') then
      Exit;

   if (cbxTIPO_BAS.Text = 'Oracle') and (Trim(edtDIRE_BAS.Text) = '') then
   begin
      edtDIRE_BAS.Field.Value := edtDESC_BAS.Field.Value;
   end;
end;

procedure TfrmBases.edtDIRE_BASExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtDIRE_BAS, 'base de dados') then
   begin
      Exit;
   end;
end;

procedure TfrmBases.edtPORT_BASExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtPORT_BAS, 'porta') then
   begin
      Exit;
   end;
end;

procedure TfrmBases.edtSERV_BASExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtSERV_BAS, 'servidor') then
   begin
      Exit;
   end;
end;

procedure TfrmBases.edtSNAM_BASExit(Sender: TObject);
begin
  inherited;
   if (cbxTIPO_BAS.ItemIndex = 1) and (TALXFuncoes.Obrigatorio(edtSNAM_BAS, 'service name')) then
   begin
      Exit;
   end;
end;

end.
