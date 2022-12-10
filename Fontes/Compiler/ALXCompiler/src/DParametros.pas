unit DParametros;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmParametros = class(TDataModule)
    sqqParametros: TSQLQuery;
    dspParametros: TDataSetProvider;
    cdsParametros: TClientDataSet;
    sqqParametrosIAUT_CFG: TStringField;
    cdsParametrosIAUT_CFG: TStringField;
    sqqParametrosUVER_CFG: TStringField;
    cdsParametrosUVER_CFG: TStringField;
    sqqParametrosEMAC_CFG: TStringField;
    cdsParametrosEMAC_CFG: TStringField;
    sqqParametrosSERV_CFG: TStringField;
    cdsParametrosSERV_CFG: TStringField;
    sqqParametrosAGMS_CFG: TStringField;
    cdsParametrosAGMS_CFG: TStringField;
    sqqParametrosCODI_USU: TIntegerField;
    cdsParametrosCODI_USU: TIntegerField;
    sqqParametrosCORM_CFG: TIntegerField;
    sqqParametrosCORF_CFG: TIntegerField;
    cdsParametrosCORM_CFG: TIntegerField;
    cdsParametrosCORF_CFG: TIntegerField;
    sqqParametrosUPDC_CFG: TStringField;
    cdsParametrosUPDC_CFG: TStringField;
    sqqParametrosEXEC_CFG: TStringField;
    sqqParametrosALER_CFG: TStringField;
    cdsParametrosEXEC_CFG: TStringField;
    cdsParametrosALER_CFG: TStringField;
    sqqParametrosAPAG_CFG: TStringField;
    cdsParametrosAPAG_CFG: TStringField;
    sqqParametrosTSVN_CFG: TStringField;
    cdsParametrosTSVN_CFG: TStringField;
    sqqParametrosMULT_CFG: TStringField;
    cdsParametrosMULT_CFG: TStringField;
    sqqParametrosIDEX_CFG: TStringField;
    cdsParametrosIDEX_CFG: TStringField;
    sqqParametrosTGIT_CFG: TStringField;
    sqqParametrosSGIT_CFG: TStringField;
    cdsParametrosTGIT_CFG: TStringField;
    cdsParametrosSGIT_CFG: TStringField;
    sqqParametrosUPDG_CFG: TStringField;
    sqqParametrosSWIT_CFG: TStringField;
    cdsParametrosUPDG_CFG: TStringField;
    cdsParametrosSWIT_CFG: TStringField;
    sqqParametrosLIBR_CFG: TStringField;
    cdsParametrosLIBR_CFG: TStringField;
    sqqParametrosGLNK_CFG: TStringField;
    sqqParametrosLINK_CFG: TStringField;
    cdsParametrosGLNK_CFG: TStringField;
    cdsParametrosLINK_CFG: TStringField;
    sqqParametrosDRLC_CFG: TDateField;
    sqqParametrosDBLC_CFG: TDateField;
    sqqParametrosEXLC_CFG: TIntegerField;
    cdsParametrosDRLC_CFG: TDateField;
    cdsParametrosDBLC_CFG: TDateField;
    cdsParametrosEXLC_CFG: TIntegerField;
    sqqParametrosSZIP_CFG: TStringField;
    cdsParametrosSZIP_CFG: TStringField;
    sqqParametrosALLC_CFG: TStringField;
    cdsParametrosALLC_CFG: TStringField;
    sqqParametrosIPRD_CFG: TStringField;
    cdsParametrosIPRD_CFG: TStringField;
    sqqParametrosTPAR_CFG: TStringField;
    cdsParametrosTPAR_CFG: TStringField;
    sqqParametrosHFTP_CFG: TStringField;
    sqqParametrosUFTP_CFG: TStringField;
    sqqParametrosSFTP_CFG: TStringField;
    cdsParametrosHFTP_CFG: TStringField;
    cdsParametrosUFTP_CFG: TStringField;
    cdsParametrosSFTP_CFG: TStringField;
    sqqParametrosEFTP_CFG: TStringField;
    cdsParametrosEFTP_CFG: TStringField;
    sqqParametrosCPYL_CFG: TStringField;
    sqqParametrosCPYR_CFG: TStringField;
    cdsParametrosCPYL_CFG: TStringField;
    cdsParametrosCPYR_CFG: TStringField;
    sqqParametrosIVER_CFG: TStringField;
    sqqParametrosIPAR_CFG: TStringField;
    cdsParametrosIVER_CFG: TStringField;
    cdsParametrosIPAR_CFG: TStringField;
    sqqParametrosAFTP_CFG: TStringField;
    cdsParametrosAFTP_CFG: TStringField;
    sqqParametrosREQU_CFG: TStringField;
    cdsParametrosREQU_CFG: TStringField;
    procedure cdsParametrosAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmParametros: TdmParametros;

implementation

uses ALXCompilerVariaveis;

{$R *.dfm}

procedure TdmParametros.cdsParametrosAfterInsert(DataSet: TDataSet);
begin
   cdsParametrosCODI_USU.AsInteger := CODI_USU;
end;

end.
