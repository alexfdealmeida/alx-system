unit DModulos;

interface

uses
  SysUtils, Classes, FMTBcd, DB, Provider, SqlExpr, DBClient;

type
  TdmModulos = class(TDataModule)
    sqqModulos: TSQLQuery;
    dspModulos: TDataSetProvider;
    cdsModulos: TClientDataSet;
    sqqModulosCODI_MOD: TIntegerField;
    sqqModulosDESC_MOD: TStringField;
    sqqModulosWANT_MOD: TStringField;
    cdsModulosCODI_MOD: TIntegerField;
    cdsModulosDESC_MOD: TStringField;
    cdsModulosWANT_MOD: TStringField;
    cdsModulosSELECIONA: TBooleanField;
    sqqAux: TSQLQuery;
    dspAux: TDataSetProvider;
    cdsAux: TClientDataSet;
    cdsModulosSTATUS: TStringField;
    sqqModulosDATE_MOD: TSQLTimeStampField;
    cdsModulosDATE_MOD: TSQLTimeStampField;
    cdsModulosDATE_TMP: TSQLTimeStampField;
    sqqModulosCOMP_MOD: TIntegerField;
    cdsModulosCOMP_MOD: TIntegerField;
    cdsModulosCOMP_TMP: TIntegerField;
    sqqModulosCODI_USU: TIntegerField;
    cdsModulosCODI_USU: TIntegerField;
    sqqModulosLAST_MOD: TStringField;
    cdsModulosLAST_MOD: TStringField;
    sqqModulosAUTO_MOD: TStringField;
    cdsModulosAUTO_MOD: TStringField;
    sqqModulosDULT_MOD: TSQLTimeStampField;
    cdsModulosDULT_MOD: TSQLTimeStampField;
    cdsModulosDULT_TMP: TSQLTimeStampField;
    sqqModulosVULT_MOD: TStringField;
    cdsModulosVULT_MOD: TStringField;
    cdsModulosVULT_TMP: TStringField;
    procedure cdsModulosAfterOpen(DataSet: TDataSet);
    procedure cdsModulosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure GetDadosUltimaCompilacao;
  public
    { Public declarations }
  end;

var
  dmModulos: TdmModulos;

implementation

uses ALXCompilerVariaveis;

{$R *.dfm}

procedure TdmModulos.cdsModulosAfterOpen(DataSet: TDataSet);
var
   lPosicao: TBookmark;
begin

   GetDadosUltimaCompilacao;

   cdsModulos.DisableControls;
   lPosicao := cdsModulos.GetBookmark;

   try

      cdsModulos.First;
      while not cdsModulos.Eof do
      begin
         if cdsModulosAUTO_MOD.AsString = 'S' then
         begin
            cdsModulos.Edit;
            cdsModulosSELECIONA.AsBoolean := True;
            cdsModulos.Post;
         end;

         cdsModulos.Next;
      end;

   finally
      if (lPosicao <> nil) and (cdsModulos.BookmarkValid(lPosicao)) then
      begin
         cdsModulos.GotoBookmark(lPosicao);
         cdsModulos.FreeBookmark(lPosicao);
      end;

      cdsModulos.EnableControls;
   end;
end;

procedure TdmModulos.cdsModulosBeforePost(DataSet: TDataSet);
begin
   cdsModulosCODI_USU.AsInteger := CODI_USU;
end;

procedure TdmModulos.GetDadosUltimaCompilacao;
begin
   try
      dmModulos.cdsModulos.DisableControls;

      dmModulos.cdsModulos.First;
      while not dmModulos.cdsModulos.Eof do
      begin
         dmModulos.cdsModulos.Edit;
         dmModulos.cdsModulosDATE_TMP.AsDateTime := dmModulos.cdsModulosDATE_MOD.AsDateTime;
         dmModulos.cdsModulosDULT_TMP.AsDateTime := dmModulos.cdsModulosDULT_MOD.AsDateTime;
         dmModulos.cdsModulosCOMP_TMP.AsInteger  := dmModulos.cdsModulosCOMP_MOD.AsInteger;
         dmModulos.cdsModulosVULT_TMP.AsString   := dmModulos.cdsModulosVULT_MOD.AsString;
         dmModulos.cdsModulos.Post;

         dmModulos.cdsModulos.Next;
      end;

   finally
      dmModulos.cdsModulos.First;
      dmModulos.cdsModulos.EnableControls;
   end;
end;

end.
