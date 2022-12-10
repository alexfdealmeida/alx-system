unit DDiretivas;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, Provider, DBClient;

type
  TdmDiretivas = class(TDataModule)
    sqqDiretivas: TSQLQuery;
    sqqDiretivasCODI_DTV: TIntegerField;
    sqqDiretivasCODI_USU: TIntegerField;
    sqqDiretivasDIRE_DTV: TStringField;
    sqqDiretivasDESC_DTV: TStringField;
    sqqDiretivasGLOB_DTV: TStringField;
    sqqDiretivasSITU_DTV: TStringField;
    dspDiretivas: TDataSetProvider;
    cdsDiretivas: TClientDataSet;
    cdsDiretivasCODI_DTV: TIntegerField;
    cdsDiretivasCODI_USU: TIntegerField;
    cdsDiretivasDIRE_DTV: TStringField;
    cdsDiretivasDESC_DTV: TStringField;
    cdsDiretivasGLOB_DTV: TStringField;
    cdsDiretivasSITU_DTV: TStringField;
    cdsDiretivasSELECIONA: TBooleanField;
    sqqDiretivasAUTO_DTV: TStringField;
    cdsDiretivasAUTO_DTV: TStringField;
    procedure cdsDiretivasBeforePost(DataSet: TDataSet);
    procedure cdsDiretivasAfterOpen(DataSet: TDataSet);
    procedure cdsDiretivasNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDiretivas: TdmDiretivas;

implementation

uses DPrincipal, ALXCompilerVariaveis;

{$R *.dfm}

procedure TdmDiretivas.cdsDiretivasAfterOpen(DataSet: TDataSet);
var
   lPosicao: TBookmark;
begin

   cdsDiretivas.DisableControls;
   
   lPosicao := cdsDiretivas.GetBookmark;

   try

      cdsDiretivas.First;
      while not cdsDiretivas.Eof do
      begin
         if cdsDiretivasAUTO_DTV.AsString = 'S' then
         begin
            cdsDiretivas.Edit;
            cdsDiretivasSELECIONA.AsBoolean := True;
            cdsDiretivas.Post;
         end;

         cdsDiretivas.Next;
      end;

   finally
      if (lPosicao <> nil) and (cdsDiretivas.BookmarkValid(lPosicao)) then
      begin
         cdsDiretivas.GotoBookmark(lPosicao);
         cdsDiretivas.FreeBookmark(lPosicao);
      end;
      
      cdsDiretivas.EnableControls;
   end;
end;

procedure TdmDiretivas.cdsDiretivasBeforePost(DataSet: TDataSet);
begin
   cdsDiretivasCODI_USU.AsInteger := CODI_USU;
end;

procedure TdmDiretivas.cdsDiretivasNewRecord(DataSet: TDataSet);
begin
   cdsDiretivasGLOB_DTV.AsString := 'N';
   cdsDiretivasAUTO_DTV.AsString := 'N';
end;

end.
