unit DTicket;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider, DPrincipal,
  Funcoes;

type
  TDmTicket = class(TDataModule)
    sqqTicket: TSQLQuery;
    sqqTicketCODI_TIC: TIntegerField;
    sqqTicketDESC_TIC: TStringField;
    dspTicket: TDataSetProvider;
    cdsTicket: TClientDataSet;
    cdsTicketCODI_TIC: TIntegerField;
    cdsTicketDESC_TIC: TStringField;
    sqqValidacao: TSQLQuery;
    dtsTicket: TDataSource;
    cdsValidacao: TClientDataSet;
    sqqValidacaoCODI_VAL: TIntegerField;
    sqqValidacaoREVISION: TStringField;
    sqqValidacaoSITU_VAL: TStringField;
    sqqValidacaoCODI_DES: TIntegerField;
    sqqValidacaoCODI_TIC: TIntegerField;
    sqqValidacaoNOME_DES: TStringField;
    sqqValidacaoEMAI_DES: TStringField;
    cdsValidacaoCODI_VAL: TIntegerField;
    cdsValidacaoREVISION: TStringField;
    cdsValidacaoSITU_VAL: TStringField;
    cdsValidacaoCODI_DES: TIntegerField;
    cdsValidacaoCODI_TIC: TIntegerField;
    cdsValidacaoNOME_DES: TStringField;
    cdsValidacaoEMAI_DES: TStringField;
    sqqValidacaoDESC_VAL: TMemoField;
    sqqValidacaoUSUA_VAL: TIntegerField;
    sqqValidacaoCPAD_VAL: TIntegerField;
    sqqValidacaoLOGI_VAL: TIntegerField;
    sqqValidacaoIMPA_VAL: TIntegerField;
    cdsTicketsqqValidacao: TDataSetField;
    cdsValidacaoDESC_VAL: TMemoField;
    cdsValidacaoUSUA_VAL: TIntegerField;
    cdsValidacaoCPAD_VAL: TIntegerField;
    cdsValidacaoLOGI_VAL: TIntegerField;
    cdsValidacaoIMPA_VAL: TIntegerField;
    sqqValidacaoEMAI_VAL: TIntegerField;
    cdsValidacaoEMAI_VAL: TIntegerField;
    sqqValidacaoREDU_VAL: TIntegerField;
    sqqValidacaoFIND_VAL: TIntegerField;
    cdsValidacaoREDU_VAL: TIntegerField;
    cdsValidacaoFIND_VAL: TIntegerField;
    sqqValidacaoEMIS_VAL: TDateField;
    cdsValidacaoEMIS_VAL: TDateField;
    procedure cdsValidacaoNewRecord(DataSet: TDataSet);
    procedure dspTicketBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
  private
    function CodigoValidacao: Integer;
    function GeraProximoCodigo(Tabela: TClientDataSet; Campos: String; CodigoTemporario: Boolean = True): Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmTicket: TDmTicket;

implementation

{$R *.dfm}

function TDmTicket.GeraProximoCodigo(Tabela: TClientDataSet; Campos: String;
  CodigoTemporario: Boolean = True): Integer;
var
 FTab: TClientDataSet;
begin
   Result := 0;
   FTab := TClientDataSet.Create(Self);
   try
     FTab.CloneCursor(Tabela, True);
     FTab.FetchOnDemand := False;
     FTab.IndexFieldNames := Campos;
     FTab.Last;

     if CodigoTemporario then
     begin
        if FTab.FieldByName(Campos).AsInteger >= 999990000 then
           Result := FTab.FieldByName(Campos).AsInteger + 1
        else
           Result := 999990000;
     end
     else
        Result := FTab.FieldByName(Campos).AsInteger + 1;

     FTab.Close;
   finally
     FreeAndNil(FTab);
   end;
end;

procedure TDmTicket.cdsValidacaoNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODI_TIC').AsInteger  := cdsTicketCODI_TIC.AsInteger;
  DataSet.FieldByName('CODI_VAL').AsInteger  := GeraProximoCodigo(TClientDataSet(DataSet), 'CODI_VAL', True);
  DataSet.FieldByName('USUA_VAL').AsInteger  := 0;
  DataSet.FieldByName('CPAD_VAL').AsInteger  := 0;
  DataSet.FieldByName('LOGI_VAL').AsInteger  := 0;
  DataSet.FieldByName('REDU_VAL').AsInteger  := 1;
  DataSet.FieldByName('FIND_VAL').AsInteger  := 1;
  DataSet.FieldByName('IMPA_VAL').AsInteger  := 1;
  DataSet.FieldByName('SITU_VAL').AsInteger  := 1;
  DataSet.FieldByName('EMAI_VAL').AsInteger  := 1;
  DataSet.FieldByName('EMIS_VAL').AsDateTime := Date;
end;

function TDmTicket.CodigoValidacao: Integer;
var
  LSQLQuery: TSQLQuery;
begin

   LSQLQuery := TSQLQuery.Create(Self);
   try
     LSQLQuery.SQLConnection := DmPrincipal.sqcPrincipal;

     LSQLQuery.Close;
     LSQLQuery.SQL.Add('select max(coalesce(CODI_VAL,0)) CODIGO '+
                       'from VALIDACAO '+
                       'where CODI_TIC = '+ cdsTicketCODI_TIC.AsString  );
     LSQLQuery.Open;

     Result := LSQLQuery.FieldByName('CODIGO').AsInteger + 1;
   finally
     FreeAndNil(LSQLQuery);
   end;
end;

procedure TDmTicket.dspTicketBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
   if UpperCase(SourceDS.Name) = 'SQQVALIDACAO' then
   begin
      if UpdateKind = ukInsert then
      begin
         DeltaDs.Edit;
         DeltaDs.FieldByName('CODI_VAL').AsInteger := CodigoValidacao;
         DeltaDs.Post;
      end;
   end;
end;

end.
