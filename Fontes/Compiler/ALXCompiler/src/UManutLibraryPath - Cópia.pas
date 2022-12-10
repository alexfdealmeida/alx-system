unit UManutLibraryPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, ImgList, AppEvnts, AdvOfficeStatusBar, JvExStdCtrls, JvEdit,
  Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls, Grids, BaseGrid, AdvGrid,
  DBAdvGrid, ActnList, DB, AdvObj, AdvOfficeStatusBarStylers, AdvGlowButton;

type
  TfrmManutLibraryPath = class(TFMaster)
    pnlPesquisa: TPanel;
    btnIncluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    edtPesquisa: TEdit;
    edtSelecionada: TDBEdit;
    edtTotal: TJvEdit;
    pnlBotoes: TPanel;
    DBAdvGrid1: TDBAdvGrid;
    actlstAtualiza: TActionList;
    actAtualiza: TAction;
    dtsLibraryPath: TDataSource;
    btnSair: TAdvGlowButton;
    btnSelecionar: TAdvGlowButton;
    ImageListLibrary: TImageList;
    procedure actAtualizaExecute(Sender: TObject);
    procedure actAtualizaUpdate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dtsLibraryPathDataChange(Sender: TObject; Field: TField);
    procedure btnSairClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManutLibraryPath: TfrmManutLibraryPath;

implementation

uses DVersoes, ULibraryPath, UMasterCad, DParametros, ALXFuncoes,
  ALXCompilerFuncoesDB, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmManutLibraryPath.actAtualizaExecute(Sender: TObject);
begin
  inherited;

   {Favor não remover este comentário}
end;

procedure TfrmManutLibraryPath.actAtualizaUpdate(Sender: TObject);
begin
  inherited;

   btnAlterar.Enabled    := not (dmVersoes.cdsLibraryPath.IsEmpty);
   btnExcluir.Enabled    := btnAlterar.Enabled;
end;

procedure TfrmManutLibraryPath.btnAlterarClick(Sender: TObject);
begin
  inherited;

   frmLibraryPath := TfrmLibraryPath.Create(Self,
                                            dmVersoes.cdsLibraryPath,
                                            tmAlterar,
                                            False);
   frmLibraryPath.ShowModal;
end;

procedure TfrmManutLibraryPath.btnExcluirClick(Sender: TObject);
begin
  inherited;

   if Application.MessageBox('Deseja realmente excluir este path?', 'Compilador', MB_YESNO + MB_ICONQUESTION) = IDYES then
   begin
      dmVersoes.cdsLibraryPath.Delete;

      if not dmVersoes.cdsLibraryPath.IsEmpty then
      begin
         TALXCompilerFuncoesDB.AtualizaIndicesLibraryPath(dmVersoes.cdsLibraryPath, True);
      end;
   end;
end;

procedure TfrmManutLibraryPath.btnIncluirClick(Sender: TObject);
begin
  inherited;

   frmLibraryPath := TfrmLibraryPath.Create(Self,
                                            dmVersoes.cdsLibraryPath,
                                            tmIncluir,
                                            False);
   frmLibraryPath.ShowModal;
end;

procedure TfrmManutLibraryPath.btnSairClick(Sender: TObject);
begin
  inherited;

   Close;
end;

procedure TfrmManutLibraryPath.btnSelecionarClick(Sender: TObject);
begin
  inherited;

   if (dmParametros.cdsParametrosLIBR_CFG.AsString = 'S') and
         not (dmVersoes.cdsLibraryPath.IsEmpty) then
      begin
         TALXFuncoes.AtualizaRegistro(HKEY_CURRENT_USER,
                                        'Software\Borland\BDS\4.0\Library',
                                        'Search Path',
                                        TALXCompilerFuncoesDB.RetornaLibraryPath(dmVersoes.cdsLibraryPath),
                                        False);

         TALXFuncoes.Aviso('Library path atualizado com sucesso!');
      end;
end;

procedure TfrmManutLibraryPath.dtsLibraryPathDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

   edtTotal.Text := IntToStr(dmVersoes.cdsLibraryPath.RecordCount);
end;

procedure TfrmManutLibraryPath.edtPesquisaChange(Sender: TObject);
begin
  inherited;

   if Trim(edtPesquisa.Text) = '' then
   begin
      dmVersoes.cdsLibraryPath.Filtered := False;
      dmVersoes.cdsLibraryPath.Filter   := '';
      dmVersoes.cdsLibraryPath.FilterOptions := [];
   end
   else
   begin
      dmVersoes.cdsLibraryPath.Filtered := False;
      dmVersoes.cdsLibraryPath.FilterOptions := [foCaseInsensitive];
      dmVersoes.cdsLibraryPath.Filter   := 'DESC_LIB = ' + QuotedStr(edtPesquisa.Text + '*');
      dmVersoes.cdsLibraryPath.Filtered := True;
   end;
end;

procedure TfrmManutLibraryPath.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

   frmManutLibraryPath := nil;
end;

procedure TfrmManutLibraryPath.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

   {dmVersoes.cdsLibraryPath.Close;
   dmVersoes.cdsLibraryPath.Open;}

   dmVersoes.cdsLibraryPath.Filtered := False;
   dmVersoes.cdsLibraryPath.Filter   := '';
   dmVersoes.cdsLibraryPath.FilterOptions := [];
end;

procedure TfrmManutLibraryPath.FormCreate(Sender: TObject);
begin
  inherited;

   TALXFuncoes.DefineAlturaLarguraTela(Self, ALTURA_TELA, LARGURA_TELA);
end;

procedure TfrmManutLibraryPath.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

   if (key = vk_Escape) then
      btnSairClick(Sender);
end;

end.
