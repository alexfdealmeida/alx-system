unit ULibraryPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, ImgList, ActnList, AppEvnts, StdCtrls, Buttons, ExtCtrls,
  AdvOfficeStatusBar, JvExControls, JvEnterTab, Mask, DBCtrls, JvExMask, JvSpin,
  JvDBSpinEdit, DB, DBClient, JvBaseDlg, JvSelectDirectory, JvComponentBase,
  AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TfrmLibraryPath = class(TfrmMasterCad)
    lblINDI_LIB: TLabel;
    lblDESC_LIB: TLabel;
    edtDESC_LIB: TDBEdit;
    edtINDI_LIB: TJvDBSpinEdit;
    dtsLibraryPath: TDataSource;
    JvSelectDirectory1: TJvSelectDirectory;
    btnPath: TSpeedButton;
    procedure btnGravarClick(Sender: TObject);
    procedure edtINDI_LIBExit(Sender: TObject);
    procedure edtDESC_LIBExit(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLibraryPath: TfrmLibraryPath;

implementation

uses DVersoes, ALXCompilerFuncoesDB, ALXFuncoes;

{$R *.dfm}

procedure TfrmLibraryPath.btnGravarClick(Sender: TObject);
begin
   if TALXFuncoes.Obrigatorio(edtINDI_LIB, 'índice') or
      TALXFuncoes.Obrigatorio(edtDESC_LIB, 'path') then
   begin
      Exit;
   end;

  inherited;

   TALXCompilerFuncoesDB.AtualizaIndicesLibraryPath(FClientDataSet);
end;

procedure TfrmLibraryPath.btnPathClick(Sender: TObject);
begin
  inherited;

   if JvSelectDirectory1.Execute then
      edtDESC_LIB.Field.AsString := JvSelectDirectory1.Directory;
end;

procedure TfrmLibraryPath.edtDESC_LIBExit(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Obrigatorio(edtDESC_LIB, 'path') then
   begin
      Exit;
   end;
end;

procedure TfrmLibraryPath.edtINDI_LIBExit(Sender: TObject);
begin
  inherited;

   if TALXFuncoes.Obrigatorio(edtINDI_LIB, 'índice') then
   begin
      Exit;
   end;
end;

end.
