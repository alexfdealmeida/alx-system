unit DPrincipal;

interface

uses
  SysUtils, Classes, DBXpress, WideStrings, DB, SqlExpr, FMTBcd, Provider,
  DBClient, JclFileUtils, Forms;

type
  TdmPrincipal = class(TDataModule)
    sqcCompilador: TSQLConnection;
    cdsGeral: TClientDataSet;
    sqqGeral: TSQLQuery;
    dspGeral: TDataSetProvider;
    sqqExecute: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
   sqcCompilador.LoadParamsFromIniFile( PathExtractPathDepth(Application.ExeName, PathGetDepth(Application.ExeName) -1) +  'cfg\dbxconnections.ini' );

   sqcCompilador.Params.Values['User_Name'] := TALXFuncoes.Descriptografa(sqcCompilador.Params.Values['User_Name']);
   sqcCompilador.Params.Values['Password']  := TALXFuncoes.Descriptografa(sqcCompilador.Params.Values['Password']);
end;

end.
