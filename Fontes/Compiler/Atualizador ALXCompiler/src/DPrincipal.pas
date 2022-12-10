unit DPrincipal;

interface

uses
  SysUtils, Classes, DBXpress, WideStrings, FMTBcd, DBClient, Provider, DB,
  SqlExpr, JclFileUtils, Forms;

type
  TdmPrincipal = class(TDataModule)
    sqcCompilador: TSQLConnection;
    sqqGeral: TSQLQuery;
    dspGeral: TDataSetProvider;
    cdsGeral: TClientDataSet;
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
