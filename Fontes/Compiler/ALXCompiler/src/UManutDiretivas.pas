unit UManutDiretivas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, ImgList, AppEvnts, AdvOfficeStatusBar, Grids, BaseGrid, AdvGrid, DBAdvGrid, JvExStdCtrls, JvEdit,
  Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls, ActnList, DB, AdvObj,
  AdvOfficeStatusBarStylers, UMasterMnt, AdvGlowButton, AdvSmoothPanel;

type
  TfrmManutDiretivas = class(TfrmMasterMnt)
    dtsDiretivas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FSQLDiretivas: string;
  public
    { Public declarations }
  end;

var
  frmManutDiretivas: TfrmManutDiretivas;

implementation

uses DDiretivas, UDiretivas, UMasterCad, DParametros, ALXCompilerFuncoesDB,
  ALXFuncoes, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmManutDiretivas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   dmDiretivas.cdsDiretivas.Close;
   dmDiretivas.sqqDiretivas.SQL.Text := FSQLDiretivas;
   dmDiretivas.cdsDiretivas.Open;

  inherited;
end;

procedure TfrmManutDiretivas.FormCreate(Sender: TObject);
begin
   FSQLDiretivas := dmDiretivas.sqqDiretivas.SQL.Text;

   dmDiretivas.cdsDiretivas.Close;
   dmDiretivas.sqqDiretivas.SQL.Text := Copy(FSQLDiretivas, 1, Pos('/*filtro*/', FSQLDiretivas) - 1);
   dmDiretivas.cdsDiretivas.Open;

  inherited;
end;

end.
