unit DUpdate;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TdmUpdate = class(TDataModule)
    cdsArquivos: TClientDataSet;
    cdsArquivosVERS_RES: TStringField;
    cdsArquivosSTAT_RES: TStringField;
    cdsArquivosARQU_RES: TStringField;
    cdsVersoesUpd: TClientDataSet;
    cdsVersoesUpdVERS_RES: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmUpdate: TdmUpdate;

implementation

{$R *.dfm}

end.
