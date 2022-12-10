unit DVersaoBase;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TdmVersaoBase = class(TDataModule)
    cdsVersoesTemp: TClientDataSet;
    cdsLibraryPathTemp: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmVersaoBase: TdmVersaoBase;

implementation

{$R *.dfm}

end.
