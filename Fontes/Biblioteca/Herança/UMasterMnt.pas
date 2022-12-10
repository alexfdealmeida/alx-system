unit UMasterMnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, Grids, BaseGrid, AdvGrid,
  DBAdvGrid, JvExStdCtrls, JvEdit, Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls,
  ActnList, DBClient, DB, UMasterCad, ImgList, AdvObj, AdvOfficeStatusBarStylers,
  AdvGlowButton, AdvSmoothPanel;

type
  TClassMasterCad = class of TfrmMasterCad;

  TfrmMasterMnt = class(TFMaster)
    actLstAtualizaMasterMnt: TActionList;
    actAtualizaMasterMnt: TAction;
    dtsMasterMnt: TDataSource;
    DbGridMasterMnt: TDBAdvGrid;
    pnlRodape: TAdvSmoothPanel;
    btnSairMasterMnt: TAdvGlowButton;
    pnlCabecalho: TAdvSmoothPanel;
    edtPesquisaMasterMnt: TEdit;
    edtRegistroSelecionado: TDBEdit;
    edtTotalRegistros: TJvEdit;
    btnIncluirMasterMnt: TAdvGlowButton;
    btnAlterarMasterMnt: TAdvGlowButton;
    btnExcluirMasterMnt: TAdvGlowButton;
    btnExcluirTodosMasterMnt: TAdvGlowButton;
    procedure btnSairMasterMntClick(Sender: TObject);
    procedure actAtualizaMasterMntExecute(Sender: TObject);
    procedure actAtualizaMasterMntUpdate(Sender: TObject);
    procedure btnAlterarMasterMntClick(Sender: TObject);
    procedure btnExcluirMasterMntClick(Sender: TObject);
    procedure btnIncluirMasterMntClick(Sender: TObject);
    procedure dtsMasterMntDataChange(Sender: TObject; Field: TField);
    procedure edtPesquisaMasterMntChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirTodosMasterMntClick(Sender: TObject);
    procedure DbGridMasterMntDblClick(Sender: TObject);
  private
    { Private declarations }
    FApply: Boolean;
    FClientDataSet: TClientDataSet;
    FForm: TfrmMasterCad;
    FClassForm: TClassMasterCad;
    FCampos: array of string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      AClientDataSet: TClientDataSet; AForm: TfrmMasterCad; AClassForm: TClassMasterCad;
      ACampoSel: string; ACampos: array of string; AApply: Boolean); reintroduce; overload;
  end;

var
  frmMasterMnt: TfrmMasterMnt;

implementation

uses ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmMasterMnt.actAtualizaMasterMntExecute(Sender: TObject);
begin
  inherited;
   { Favor não remover este comentário }
end;

procedure TfrmMasterMnt.actAtualizaMasterMntUpdate(Sender: TObject);
begin
  inherited;
   btnAlterarMasterMnt.Enabled      := not (FClientDataSet.IsEmpty);
   btnExcluirMasterMnt.Enabled      := btnAlterarMasterMnt.Enabled;
   btnExcluirTodosMasterMnt.Enabled := btnAlterarMasterMnt.Enabled;
end;

procedure TfrmMasterMnt.btnAlterarMasterMntClick(Sender: TObject);
begin
  inherited;
   FForm := FClassForm.Create(Self, FClientDataSet, tmAlterar);
   FForm.ShowModal;
end;

procedure TfrmMasterMnt.btnExcluirMasterMntClick(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Aviso('Deseja realmente excluir este registro?', bmSimNao, imPergunta) then
   begin
      FClientDataSet.Delete;

      if FApply then
      begin
         if FClientDataSet.ApplyUpdates(-1) > 0 then
         begin
            TALXFuncoes.Aviso('Não foi possível excluir os dados!', bmOk, imErro);
            Abort;
         end;

         FClientDataSet.Close;
         FClientDataSet.Open;
      end;
   end;
end;

procedure TfrmMasterMnt.btnExcluirTodosMasterMntClick(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Aviso('Deseja realmente excluir TODOS os registros?', bmSimNao, imPergunta) then
   begin
      while not FClientDataSet.IsEmpty do
      begin
         FClientDataSet.Delete;
      end;

      if FApply then
      begin
         if FClientDataSet.ApplyUpdates(-1) > 0 then
         begin
            TALXFuncoes.Aviso('Não foi possível excluir os dados!', bmOk, imErro);
            Abort;
         end;

         FClientDataSet.Close;
         FClientDataSet.Open;
      end;
   end;
end;

procedure TfrmMasterMnt.btnIncluirMasterMntClick(Sender: TObject);
begin
  inherited;
   FForm := FClassForm.Create(Self, FClientDataSet, tmIncluir);
   FForm.ShowModal;
end;

procedure TfrmMasterMnt.btnSairMasterMntClick(Sender: TObject);
begin
  inherited;
   Close;
end;

constructor TfrmMasterMnt.Create(AOwner: TComponent;
  AClientDataSet: TClientDataSet; AForm: TfrmMasterCad;
  AClassForm: TClassMasterCad; ACampoSel: string; ACampos: array of string;
  AApply: Boolean);
var
   lIndex: Integer;
begin
  inherited Create(AOwner);

   FClientDataSet := AClientDataSet;

   FApply := AApply;

   FForm := AForm;
   FClassForm := AClassForm;

   SetLength(FCampos, High(ACampos) + 1);

   for lIndex := Low(ACampos) to High(ACampos) do
      FCampos[lIndex] := ACampos[lIndex];

   dtsMasterMnt.DataSet := FClientDataSet;

   edtRegistroSelecionado.DataField := ACampoSel;
end;

procedure TfrmMasterMnt.DbGridMasterMntDblClick(Sender: TObject);
begin
  inherited;

   if btnAlterarMasterMnt.Enabled then
   begin
      btnAlterarMasterMntClick(Sender);
   end;
end;

procedure TfrmMasterMnt.dtsMasterMntDataChange(Sender: TObject; Field: TField);
begin
  inherited;
   edtTotalRegistros.Text := IntToStr(FClientDataSet.RecordCount);
end;

procedure TfrmMasterMnt.edtPesquisaMasterMntChange(Sender: TObject);
var
   lFiltro: string;
   //lComplemento: string;
   lIndex: Integer;

const
   OPERADOR_OR = ' or ';
begin
  inherited;
   if Trim(edtPesquisaMasterMnt.Text) = '' then
   begin
      FClientDataSet.Filtered      := False;
      FClientDataSet.Filter        := '';
      FClientDataSet.FilterOptions := [];
   end
   else
   begin
      lFiltro := '';
      //lComplemento := ' ';

      for lIndex := Low(FCampos) to High(FCampos) do
      begin
         case FClientDataSet.FieldByName(FCampos[lIndex]).DataType of
            ftString :
            begin
               lFiltro := lFiltro + FCampos[lIndex] + ' = ' + QuotedStr(edtPesquisaMasterMnt.Text + '*') + OPERADOR_OR;

               //if lIndex <> High(FCampos) then
               //begin
               //   lComplemento := OPERADOR_OR;
               //   lFiltro := lFiltro + lComplemento;
               //end
            end;
         end;

         if lIndex = High(FCampos) then
         begin
            if Trim(Copy(lFiltro, Length(lFiltro) - 3, 4)) = Trim(OPERADOR_OR) then
            begin
               Delete(lFiltro, Length(lFiltro) - 3, 4);
            end;
         end;
      end;

      FClientDataSet.Filtered      := False;
      FClientDataSet.FilterOptions := [foCaseInsensitive];
      FClientDataSet.Filter        := lFiltro;
      FClientDataSet.Filtered      := True;
   end;
end;

procedure TfrmMasterMnt.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
   FClientDataSet.Filtered := False;
   FClientDataSet.Filter   := '';
   FClientDataSet.FilterOptions := [];
end;

procedure TfrmMasterMnt.FormCreate(Sender: TObject);
begin
  inherited;
  
   TALXFuncoes.CreateColumnsDBGrid(DbGridMasterMnt, dtsMasterMnt, FClientDataSet, FCampos);

   TALXFuncoes.DefineAlturaLarguraTela(Self, ALTURA_TELA_90, LARGURA_TELA_70);
end;

procedure TfrmMasterMnt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

   if (key = vk_Escape) then
      btnSairMasterMntClick(Sender);
end;

end.
