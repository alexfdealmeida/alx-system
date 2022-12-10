unit UParametrosSintetico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, ActnList, JvComponentBase, JvEnterTab, ImgList,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers, StdCtrls, Buttons,
  AdvSmoothPanel, AdvOfficeButtons, DBAdvOfficeButtons, AdvGroupBox, DB;

type
  TfrmParametrosSintetico = class(TfrmMasterCad)
    AdvGroupBox2: TAdvGroupBox;
    DBAdvOfficeCheckBox6: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox7: TDBAdvOfficeCheckBox;
    chkIVER_CFG: TDBAdvOfficeCheckBox;
    chkIPAR_CFG: TDBAdvOfficeCheckBox;
    AdvGroupBox3: TAdvGroupBox;
    chkExecutar: TDBAdvOfficeCheckBox;
    chkGLNK_CFG: TDBAdvOfficeCheckBox;
    chkEFTP_CFG: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox9: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox10: TDBAdvOfficeCheckBox;
    AdvGroupBox4: TAdvGroupBox;
    DBAdvOfficeCheckBox2: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox8: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox3: TDBAdvOfficeCheckBox;
    dtsParametros: TDataSource;
    chkAFTP_CFG: TDBAdvOfficeCheckBox;
    DBAdvOfficeCheckBox1: TDBAdvOfficeCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParametrosSintetico: TfrmParametrosSintetico;

implementation

uses DParametros;

{$R *.dfm}

end.
