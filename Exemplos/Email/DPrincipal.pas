unit DPrincipal;

interface

uses
   SysUtils, Controls, Classes, DBXpress, DB, SqlExpr, StdCtrls, FMTBcd,
   Provider, DBClient, Forms, Dialogs, ExtCtrls, JvComponent, JvBalloonHint,
  WideStrings, JvComponentBase, ImgList;

type
   TdmPrincipal = class(TDataModule)
      sqcPrincipal: TSQLConnection;
    cdsGeral: TClientDataSet;
    dspGeral: TDataSetProvider;
    sqqGeral: TSQLQuery;
    sqqEmailValidacao: TSQLQuery;
    sqqEmailValidacaoEMA1_EVA: TStringField;
    sqqEmailValidacaoEMA2_EVA: TStringField;
    sqqEmailValidacaoEMA3_EVA: TStringField;
    sqqEmailValidacaoEMA4_EVA: TStringField;
    sqqEmailValidacaoSENH_EVA: TStringField;
    sqqEmailValidacaoUSUA_EVA: TStringField;
    sqqEmailValidacaoHOST_EVA: TStringField;
   private
   public
    vRetornoPesquisa: String;
   end;

var
   dmPrincipal: TdmPrincipal;

implementation

{$R *.dfm}

end.
