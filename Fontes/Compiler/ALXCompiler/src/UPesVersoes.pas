unit UPesVersoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterPes, ImgList, AppEvnts, Grids, BaseGrid, AdvGrid, DBAdvGrid,
  Buttons, ExtCtrls, AdvGlowButton, JvExStdCtrls, JvEdit, JvValidateEdit,
  StdCtrls, AdvFontCombo, AdvOfficePager, AdvOfficeStatusBar, DB,
  AdvOfficeStatusBarStylers, AdvSmoothPanel, AdvObj;

type
  TfrmPesVersoes = class(TfrmMasterPes)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesVersoes: TfrmPesVersoes;

implementation

{$R *.dfm}

end.
