unit DVersoes;

interface

uses
  SysUtils, Classes, FMTBcd, DBClient, Provider, DB, SqlExpr;

type
  TdmVersoes = class(TDataModule)
    sqqVersoes: TSQLQuery;
    dspVersoes: TDataSetProvider;
    cdsVersoes: TClientDataSet;
    sqqVersoesCODI_VER: TIntegerField;
    sqqVersoesDEXE_VER: TStringField;
    sqqVersoesDZIP_VER: TStringField;
    cdsVersoesCODI_VER: TIntegerField;
    cdsVersoesDEXE_VER: TStringField;
    cdsVersoesDZIP_VER: TStringField;
    sqqVersoesDESC_VER: TStringField;
    cdsVersoesDESC_VER: TStringField;
    sqqVersoesDREV_VER: TStringField;
    cdsVersoesDREV_VER: TStringField;
    sqqVersoesDFON_VER: TStringField;
    sqqVersoesDGER_VER: TStringField;
    sqqVersoesDCFG_VER: TStringField;
    cdsVersoesDFON_VER: TStringField;
    cdsVersoesDGER_VER: TStringField;
    cdsVersoesDCFG_VER: TStringField;
    sqqVersoesSITU_VER: TStringField;
    cdsVersoesSITU_VER: TStringField;
    sqqVersoesVERS_VER: TStringField;
    cdsVersoesVERS_VER: TStringField;
    sqqVersoesCODI_USU: TIntegerField;
    cdsVersoesCODI_USU: TIntegerField;
    dtsLinkVersoes: TDataSource;
    sqqVersoesCOMP_VER: TStringField;
    cdsVersoesCOMP_VER: TStringField;
    sqqVersoesGVPD_VER: TStringField;
    cdsVersoesGVPD_VER: TStringField;
    sqqLibraryPath: TSQLQuery;
    sqqLibraryPathCODI_LIB: TIntegerField;
    sqqLibraryPathCODI_VER: TIntegerField;
    sqqLibraryPathCODI_USU: TIntegerField;
    sqqLibraryPathINDI_LIB: TIntegerField;
    sqqLibraryPathDESC_LIB: TStringField;
    cdsVersoessqqLibraryPath: TDataSetField;
    cdsLibraryPath: TClientDataSet;
    cdsLibraryPathCODI_LIB: TIntegerField;
    cdsLibraryPathCODI_VER: TIntegerField;
    cdsLibraryPathCODI_USU: TIntegerField;
    cdsLibraryPathINDI_LIB: TIntegerField;
    cdsLibraryPathDESC_LIB: TStringField;
    sqqVersoesDTMP_VER: TStringField;
    cdsVersoesDTMP_VER: TStringField;
    sqqVersoesDELP_VER: TStringField;
    cdsVersoesDELP_VER: TStringField;
    procedure cdsVersoesBeforePost(DataSet: TDataSet);
    procedure dspVersoesBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure cdsVersoesNewRecord(DataSet: TDataSet);
    procedure cdsLibraryPathBeforePost(DataSet: TDataSet);
    procedure cdsLibraryPathNewRecord(DataSet: TDataSet);
    procedure cdsVersoesBeforeApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsVersoesDELP_VERGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    FCODI_VER: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmVersoes: TdmVersoes;

const
   NOVO_CODIGO = 999999;

implementation

uses DPrincipal, ALXCompilerVariaveis, ALXCompilerFuncoesDB;

{$R *.dfm}

procedure TdmVersoes.cdsLibraryPathBeforePost(DataSet: TDataSet);
begin
   cdsLibraryPathCODI_VER.AsInteger := cdsVersoesCODI_VER.AsInteger;
   cdsLibraryPathCODI_USU.AsInteger := cdsVersoesCODI_USU.AsInteger;
end;

procedure TdmVersoes.cdsLibraryPathNewRecord(DataSet: TDataSet);
begin
   cdsLibraryPathINDI_LIB.AsInteger := cdsLibraryPath.RecordCount + 1;
   cdsLibraryPathCODI_LIB.AsInteger := NOVO_CODIGO + cdsLibraryPathINDI_LIB.AsInteger;
end;

procedure TdmVersoes.cdsVersoesBeforeApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
   FCODI_VER := 0;
end;

procedure TdmVersoes.cdsVersoesBeforePost(DataSet: TDataSet);
begin
   cdsVersoesCODI_USU.AsInteger := CODI_USU;
end;

procedure TdmVersoes.cdsVersoesDELP_VERGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
   if Sender.AsString = 'D07' then
   begin
      Text := 'Delphi 7';
   end
   else if Sender.AsString = 'D10' then
   begin
      Text := 'Delphi 2006';
   end;
end;

procedure TdmVersoes.cdsVersoesNewRecord(DataSet: TDataSet);
begin
   cdsVersoesCODI_VER.AsInteger := NOVO_CODIGO;
   cdsVersoesDELP_VER.AsString  := 'D10'; 
end;

procedure TdmVersoes.dspVersoesBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
   if SourceDS = sqqVersoes then
   begin
      if (UpdateKind = ukInsert) and (DeltaDS.FieldByName('CODI_VER').AsInteger = NOVO_CODIGO) then
      begin
         DeltaDS.Edit;
         FCODI_VER := TALXCompilerFuncoesDB.RetornaGenerator('GEN_VERSAO_ID');
         DeltaDS.FieldByName('CODI_VER').AsInteger := FCODI_VER;
         DeltaDS.Post;
      end;
   end
   else if SourceDS = sqqLibraryPath then
   begin
      if UpdateKind = ukInsert then
      begin
         DeltaDS.Edit;
         DeltaDS.FieldByName('CODI_LIB').Clear;

         if FCODI_VER <> 0 then
            DeltaDS.FieldByName('CODI_VER').AsInteger := FCODI_VER;
            
         DeltaDS.Post;
      end;
   end;
end;

end.
