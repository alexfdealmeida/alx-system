unit DExecutar;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TdmExecutar = class(TDataModule)
    cdsModulosExe: TClientDataSet;
    cdsModulosExeDESC_MOD: TStringField;
    cdsModulosExeALIAS: TStringField;
    cdsModulosExeEXECUTAR: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmExecutar: TdmExecutar;

implementation

{$R *.dfm}

end.
