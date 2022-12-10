unit UMasterPes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, AdvOfficePager, StdCtrls,
  AdvFontCombo, JvExStdCtrls, JvEdit, JvValidateEdit, AdvGlowButton, ImgList,
  Buttons, ExtCtrls, Grids, BaseGrid, AdvGrid, DBAdvGrid, DBClient, DB, AdvObj,
  AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TfrmMasterPes = class(TFMaster)
    pgcFiltro: TAdvOfficePager;
    tabFiltro: TAdvOfficePage;
    cbxPesquisa: TAdvOfficeComboBox;
    edtPesquisa: TJvValidateEdit;
    btnPesquisa: TAdvGlowButton;
    DbGridMasterPes: TDBAdvGrid;
    dtsMasterPes: TDataSource;
    pnlBotoes: TAdvSmoothPanel;
    btnSair: TAdvGlowButton;
    btnConfirmar: TAdvGlowButton;
    procedure btnSairClick(Sender: TObject);
    procedure cbxPesquisaSelect(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTabela: string;
    FClientDataSet: TClientDataSet;
    FCamposPes: array of string;
    FCamposGrid: array of string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ATabela: String;
      AClientDataSet: TClientDataSet;
      ACamposPes, ACamposGrid: array of string); reintroduce; overload;
  end;

var
  frmMasterPes: TfrmMasterPes;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TfrmMasterPes.btnPesquisaClick(Sender: TObject);
begin
  inherited;
   //
end;

procedure TfrmMasterPes.btnSairClick(Sender: TObject);
begin
  inherited;
   Close;
end;

procedure TfrmMasterPes.cbxPesquisaSelect(Sender: TObject);
begin
  inherited;
   edtPesquisa.SetFocus;
end;

constructor TfrmMasterPes.Create(AOwner: TComponent; ATabela: string;
  AClientDataSet: TClientDataSet; ACamposPes, ACamposGrid: array of string);
var
   lIndex: Integer;
begin
   inherited Create(AOwner);

   FClientDataSet := AClientDataSet;

   dtsMasterPes.DataSet := FClientDataSet;

   FTabela := ATabela;

   SetLength(FCamposPes, High(ACamposPes) + 1);

   for lIndex := Low(ACamposPes) to High(ACamposPes) do
      FCamposPes[lIndex] := ACamposPes[lIndex];

   SetLength(FCamposGrid, High(ACamposGrid) + 1);

   for lIndex := Low(ACamposGrid) to High(ACamposGrid) do
      FCamposGrid[lIndex] := ACamposGrid[lIndex];
end;

procedure TfrmMasterPes.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if (Key = VK_RETURN) then
      btnPesquisaClick(Sender);
end;

procedure TfrmMasterPes.FormCreate(Sender: TObject);
begin
  inherited;
   TALXFuncoes.CreateColumnsDBGrid(DbGridMasterPes, dtsMasterPes, FClientDataSet, FCamposGrid);
end;

end.
