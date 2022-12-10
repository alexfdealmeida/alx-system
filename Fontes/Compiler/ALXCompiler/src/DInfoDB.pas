unit DInfoDB;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmInfoDB = class(TDataModule)
    sqqInfoDB: TSQLQuery;
    dspInfoDB: TDataSetProvider;
    cdsInfoDB: TClientDataSet;
    cdsInfoDBVERS_INF: TStringField;
    cdsInfoDBEMPR_INF: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmInfoDB: TdmInfoDB;

implementation

uses DPrincipal;

{$R *.dfm}

end.
