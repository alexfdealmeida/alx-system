unit UUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, ActnList, AppEvnts, StdCtrls, Buttons, ExtCtrls,
  AdvOfficeStatusBar, JvExControls, JvEnterTab, Mask, DBCtrls, DB, ImgList,
  JvComponentBase, AdvOfficeStatusBarStylers, AdvGroupBox, AdvSmoothPanel,
  AdvOfficeButtons, DBAdvOfficeButtons;

type
  TfrmUsuarios = class(TfrmMasterCad)
    dtsUsuarios: TDataSource;
    gbxNOME_USU: TAdvGroupBox;
    edtNOME_USU: TDBEdit;
    gbxLogin: TAdvGroupBox;
    lblLOGI_USU: TLabel;
    lblSENH_USU: TLabel;
    edtLOGI_USU: TDBEdit;
    edtSENH_USU: TDBEdit;
    edtConfirmaSenha: TEdit;
    chkInativo: TDBAdvOfficeCheckBox;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation

uses DUsuarios, ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmUsuarios.btnGravarClick(Sender: TObject);
begin
   if TALXFuncoes.Obrigatorio(edtNOME_USU, 'nome') or
      TALXFuncoes.Obrigatorio(edtLOGI_USU, 'usuário') or
      TALXFuncoes.Obrigatorio(edtSENH_USU, 'senha') then
   begin
      Exit;
   end;

   if (dmUsuarios.cdsUsuariosSENH_USU.NewValue <> dmUsuarios.cdsUsuariosSENH_USU.OldValue) then
   begin
      if TALXFuncoes.Obrigatorio(edtConfirmaSenha, 'senha (confirmação)')  then
      begin
         Exit;
      end;
   end;

   if (dmUsuarios.cdsUsuariosSENH_USU.NewValue <> dmUsuarios.cdsUsuariosSENH_USU.OldValue) and
      (edtSENH_USU.Field.Text <> edtConfirmaSenha.Text) then
   begin
      Application.MessageBox('A senha informada, não confere com a confirmação!', 'Compilador', MB_ICONERROR + MB_OK);
      edtSENH_USU.SetFocus;
      Exit;
   end;

  inherited;
end;

end.
