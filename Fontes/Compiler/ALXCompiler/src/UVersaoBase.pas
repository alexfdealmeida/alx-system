unit UVersaoBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB,
  BaseGrid, AdvGrid, DBAdvGrid, UMaster, AppEvnts, AdvOfficeStatusBar, ImgList,
  AdvObj, AdvOfficeStatusBarStylers, AdvSmoothPanel, AdvGlowButton;

type
  TfrmVersaoBase = class(TFMaster)
    dtsVersaoTemp: TDataSource;
    DBAdvGrid1: TDBAdvGrid;
    pnlBotoes: TAdvSmoothPanel;
    btnGravar: TAdvGlowButton;
    btnCancelar: TAdvGlowButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVersaoBase: TfrmVersaoBase;

implementation

uses UPrincipal, DVersaoBase, DVersoes, ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmVersaoBase.btnCancelarClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfrmVersaoBase.btnGravarClick(Sender: TObject);
begin
   ModalResult := mrOk;
end;

procedure TfrmVersaoBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   frmVersaoBase := nil;
end;

procedure TfrmVersaoBase.FormCreate(Sender: TObject);
begin
  inherited;

   if not dmVersaoBase.cdsVersoesTemp.Locate('CODI_USU;CODI_VER', VarArrayOf([dmVersoes.cdsVersoesCODI_USU.AsString, dmVersoes.cdsVersoesCODI_VER.AsString]), []) then
   begin
      dmVersaoBase.cdsVersoesTemp.First;
   end;

   TALXFuncoes.DefineAlturaTela(Self, ALTURA_TELA_90  * 0.5);
end;

procedure TfrmVersaoBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_ESCAPE) then
      btnCancelarClick(Sender);
end;

end.
