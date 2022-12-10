unit UManutUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, Grids, BaseGrid, AdvGrid,
  DBAdvGrid, JvExStdCtrls, JvEdit, Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls,
  ActnList, DB, ImgList, AdvObj, AdvOfficeStatusBarStylers, UMasterMnt,
  AdvGlowButton, AdvSmoothPanel;

type
  TfrmManutUsuarios = class(TfrmMasterMnt)
    dtsUsuarios: TDataSource;
    procedure btnIncluirMasterMntClick(Sender: TObject);
    procedure btnExcluirMasterMntClick(Sender: TObject);
    procedure btnAlterarMasterMntClick(Sender: TObject);
    procedure DbGridMasterMntDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManutUsuarios: TfrmManutUsuarios;

implementation

uses UUsuarios, DUsuarios, UMasterCad, ALXFuncoes,
  UPrincipal, ALXCompilerVariaveis, DParametros, ALXCompilerFuncoesDB,
  ALXVariaveis;

{$R *.dfm}

procedure TfrmManutUsuarios.btnAlterarMasterMntClick(Sender: TObject);
begin
   if (ADMINISTRADOR) or
      (NOME_USU = dmUsuarios.cdsUsuariosNOME_USU.AsString) then
   begin
      inherited;
   end
   else
   begin
      TALXFuncoes.Aviso('Você não possui permissão para alterar os dados deste usuário!');
   end;
end;

procedure TfrmManutUsuarios.btnExcluirMasterMntClick(Sender: TObject);
begin
   if (ADMINISTRADOR) then
   begin
      inherited;
   end;
end;

procedure TfrmManutUsuarios.btnIncluirMasterMntClick(Sender: TObject);
begin
   if (ADMINISTRADOR) then
   begin
      inherited;
   end;
end;

procedure TfrmManutUsuarios.DbGridMasterMntDblClick(Sender: TObject);
begin
   btnAlterarMasterMntClick(Sender);
end;

end.
