unit UDiretivas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, ImgList, ActnList, AppEvnts, StdCtrls, Buttons, ExtCtrls, AdvOfficeStatusBar, JvExControls,
  JvEnterTab, Mask, DBCtrls, DB, JvBaseDlg, JvSelectDirectory,
  AdvOfficeStatusBarStylers, JvComponentBase, AdvSmoothPanel, AdvOfficeButtons,
  DBAdvOfficeButtons;

type
  TfrmDiretivas = class(TfrmMasterCad)
    lblDIRE_DTV: TLabel;
    edtDIRE_DTV: TDBEdit;
    lblDESC_DTV: TLabel;
    edtDESC_DTV: TDBEdit;
    dtsDiretivas: TDataSource;
    chkGLOB_DTV: TDBAdvOfficeCheckBox;
    chkAUTO_DTV: TDBAdvOfficeCheckBox;
    chkInativo: TDBAdvOfficeCheckBox;
    procedure edtDIRE_DTVExit(Sender: TObject);
    procedure edtDESC_DTVExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDiretivas: TfrmDiretivas;

implementation

uses DDiretivas, ALXFuncoes;

{$R *.dfm}

procedure TfrmDiretivas.btnGravarClick(Sender: TObject);
begin
   if TALXFuncoes.Obrigatorio(edtDIRE_DTV, 'nome da diretiva') or
      TALXFuncoes.Obrigatorio(edtDESC_DTV, 'descrição da diretiva') then
   begin
      Exit;
   end;

  inherited;
end;

procedure TfrmDiretivas.edtDESC_DTVExit(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Obrigatorio(edtDESC_DTV, 'descrição da diretiva') then
   begin
      Exit;
   end;
end;

procedure TfrmDiretivas.edtDIRE_DTVExit(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Obrigatorio(edtDIRE_DTV, 'nome da diretiva') then
   begin
      Exit;
   end;
end;

end.
