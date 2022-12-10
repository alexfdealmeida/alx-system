unit UMasterCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, JvExControls, JvEnterTab,
  DbClient, DBCtrls, JvDBCombobox, JvExExtCtrls, AdvOfficeStatusBar, ActnList,
  AppEvnts, UMaster, ImgList, JvComponentBase, AdvOfficeStatusBarStylers,
  AdvSmoothPanel;

type
   TTipoManutencao = (tmIncluir, tmAlterar);

  TfrmMasterCad = class(TFMaster)
    JvEnterAsTab1: TJvEnterAsTab;
    pnlBotoes: TAdvSmoothPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    pnlManutencao: TAdvSmoothPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actAtualizaMasterCadExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    FComitar: Boolean;
    FClientDataSet: TClientDataSet;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AClientDataSet: TClientDataSet;
      ATipoManutencao: TTipoManutencao = tmIncluir; AComitar: Boolean = True); reintroduce; overload;
  end;

var
  frmMasterCad: TfrmMasterCad;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TfrmMasterCad.actAtualizaMasterCadExecute(Sender: TObject);
begin
   { Favor não remover este comentário }
end;

procedure TfrmMasterCad.btnCancelarClick(Sender: TObject);
begin
   FClientDataSet.Close;
   FClientDataSet.Open;

   ModalResult := mrCancel;
end;

procedure TfrmMasterCad.btnGravarClick(Sender: TObject);
begin

   if FComitar then
   begin
      if FClientDataSet.ApplyUpdates(-1) > 0 then
      begin
         TALXFuncoes.Aviso('Não foi possível gravar os dados!', bmOk, imErro);
         Abort;
      end;

      FClientDataSet.Close;
      FClientDataSet.Open;
   end
   else
   begin
      FClientDataSet.Post;
   end;

   Self.OnCloseQuery := nil;

   ModalResult := mrOk;
end;

constructor TfrmMasterCad.Create(AOwner: TComponent;
   AClientDataSet: TClientDataSet; ATipoManutencao: TTipoManutencao = tmIncluir;
   AComitar: Boolean = True);
begin
   inherited Create(AOwner);

   FClientDataSet := AClientDataSet;

   FComitar := AComitar;

   case ATipoManutencao of
      tmIncluir : FClientDataSet.Append;
      tmAlterar : FClientDataSet.Edit;
   end;

   ModalResult := mrNone;
end;

procedure TfrmMasterCad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if FClientDataSet.ChangeCount > 0 then
   begin
      if not TALXFuncoes.Aviso('As alterações não serão salvas! Deseja realmente cancelar?', bmSimNao, imPergunta) then
      begin
         CanClose := false;

         Exit;
      end;
   end;

   FClientDataSet.Cancel;

   inherited;
end;

procedure TfrmMasterCad.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_F11) then
      btnGravarClick(Sender)
   else if (key = VK_ESCAPE) then
      btnCancelarClick(Sender);
end;

end.
