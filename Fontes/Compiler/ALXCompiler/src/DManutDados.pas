unit DManutDados;

interface

uses
  SysUtils, Classes, DBXpress, WideStrings, DB, SqlExpr, FMTBcd, DBClient,
  Provider;

type
  TdmManutDados = class(TDataModule)
    sqcEmpresa: TSQLConnection;
    sqqConfig: TSQLQuery;
    dspConfig: TDataSetProvider;
    cdsConfig: TClientDataSet;
    sqqDadosReg: TSQLQuery;
    dspDadosReg: TDataSetProvider;
    cdsDadosReg: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmManutDados: TdmManutDados;

implementation

{$R *.dfm}

end.
