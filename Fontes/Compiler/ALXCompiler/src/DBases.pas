unit DBases;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmBases = class(TDataModule)
    sqqBases: TSQLQuery;
    dspBases: TDataSetProvider;
    cdsBases: TClientDataSet;
    sqqBasesCODI_BAS: TIntegerField;
    sqqBasesDESC_BAS: TStringField;
    sqqBasesTIPO_BAS: TStringField;
    sqqBasesDIRE_BAS: TStringField;
    cdsBasesCODI_BAS: TIntegerField;
    cdsBasesDESC_BAS: TStringField;
    cdsBasesTIPO_BAS: TStringField;
    cdsBasesDIRE_BAS: TStringField;
    sqqBasesSNAM_BAS: TStringField;
    sqqBasesSERV_BAS: TStringField;
    sqqBasesPORT_BAS: TIntegerField;
    cdsBasesSNAM_BAS: TStringField;
    cdsBasesSERV_BAS: TStringField;
    cdsBasesPORT_BAS: TIntegerField;
    sqqBasesCODI_USU: TIntegerField;
    cdsBasesCODI_USU: TIntegerField;
    procedure cdsBasesTIPO_BASGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsBasesBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmBases: TdmBases;

implementation

uses ALXCompilerVariaveis;

{$R *.dfm}

procedure TdmBases.cdsBasesBeforePost(DataSet: TDataSet);
begin
   cdsBasesCODI_USU.AsInteger := CODI_USU;
end;

procedure TdmBases.cdsBasesTIPO_BASGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
   if Sender.AsString = 'FB' then
      Text := 'Firebird'
   else if Sender.AsString = 'OC' then
      Text := 'Oracle';
end;

end.
