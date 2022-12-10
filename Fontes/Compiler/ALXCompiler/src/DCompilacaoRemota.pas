unit DCompilacaoRemota;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider;

type
  TdmCompilacaoRemota = class(TDataModule)
    cdsRequisicoes: TClientDataSet;
    sqqRequisicoes: TSQLQuery;
    dspRequisicoes: TDataSetProvider;
    sqqRequisicoesCODI_REQ: TIntegerField;
    sqqRequisicoesCODI_USU: TIntegerField;
    sqqRequisicoesBRAN_REQ: TStringField;
    sqqRequisicoesDIRE_REQ: TStringField;
    sqqRequisicoesDATA_REQ: TDateField;
    sqqRequisicoesHORA_REQ: TTimeField;
    cdsRequisicoesCODI_REQ: TIntegerField;
    cdsRequisicoesCODI_USU: TIntegerField;
    cdsRequisicoesBRAN_REQ: TStringField;
    cdsRequisicoesDIRE_REQ: TStringField;
    cdsRequisicoesDATA_REQ: TDateField;
    cdsRequisicoesHORA_REQ: TTimeField;
    sqqRequisicoesSITU_REQ: TStringField;
    sqqRequisicoesSTAT_REQ: TStringField;
    sqqRequisicoesRESP_REQ: TStringField;
    cdsRequisicoesSITU_REQ: TStringField;
    cdsRequisicoesSTAT_REQ: TStringField;
    cdsRequisicoesRESP_REQ: TStringField;
    sqqRequisicoesNOME_USU: TStringField;
    cdsRequisicoesNOME_USU: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCompilacaoRemota: TdmCompilacaoRemota;

implementation

uses DPrincipal;

{$R *.dfm}

end.
