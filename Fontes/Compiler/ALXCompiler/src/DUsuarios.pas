unit DUsuarios;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmUsuarios = class(TDataModule)
    sqqUsuarios: TSQLQuery;
    dspUsuarios: TDataSetProvider;
    cdsUsuarios: TClientDataSet;
    sqqUsuariosCODI_USU: TIntegerField;
    sqqUsuariosNOME_USU: TStringField;
    sqqUsuariosLOGI_USU: TStringField;
    sqqUsuariosSENH_USU: TStringField;
    cdsUsuariosCODI_USU: TIntegerField;
    cdsUsuariosNOME_USU: TStringField;
    cdsUsuariosLOGI_USU: TStringField;
    cdsUsuariosSENH_USU: TStringField;
    cdsUsuariosENVIAR: TBooleanField;
    sqqUsuariosONLI_USU: TStringField;
    cdsUsuariosONLI_USU: TStringField;
    sqqUsuariosADMI_USU: TStringField;
    cdsUsuariosADMI_USU: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses DPrincipal, ALXFuncoes, ALXCompilerFuncoesDB;

{$R *.dfm}
end.
