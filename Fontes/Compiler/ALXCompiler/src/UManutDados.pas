unit UManutDados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, AppEvnts, AdvOfficeStatusBar, AdvGlowButton, AdvOfficePager,
  ImgList, Grids, BaseGrid, AdvGrid, DBAdvGrid, DB, DBClient, DBXpress, AdvObj,
  AdvOfficeStatusBarStylers, AdvSmoothPanel;

type
  TfrmManutDados = class(TFMaster)
    pgcTabelas: TAdvOfficePager;
    tabCONFIG: TAdvOfficePage;
    tabDADOSREG: TAdvOfficePage;
    ImageList1: TImageList;
    DBAdvGrid1: TDBAdvGrid;
    dtsConfig: TDataSource;
    DBAdvGrid2: TDBAdvGrid;
    dtsDadosReg: TDataSource;
    AdvSmoothPanel1: TAdvSmoothPanel;
    btnGravar: TAdvGlowButton;
    btnCancelar: TAdvGlowButton;
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    FTransaction: TTransactionDesc;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AcdsBase: TClientDataSet); reintroduce; overload;
  end;

var
  frmManutDados: TfrmManutDados;

implementation

uses DManutDados, DVersoes, ALXFuncoes;

{$R *.dfm}

procedure TfrmManutDados.btnCancelarClick(Sender: TObject);
begin
  inherited;

   Close;
end;

procedure TfrmManutDados.btnGravarClick(Sender: TObject);
begin
  inherited;

   try

      FTransaction.TransactionID := 1;
      FTransaction.IsolationLevel := xilREADCOMMITTED;

      dmManutDados.sqcEmpresa.StartTransaction(FTransaction);

      if dmManutDados.cdsConfig.ApplyUpdates(-1) > 0 then
      begin
         Application.MessageBox('Não foi possível atualizar os dados da tabela CONFIG!', 'Compilador', MB_OK + MB_ICONERROR);
         dmManutDados.sqcEmpresa.Rollback(FTransaction);
         Exit;
      end;

      if dmManutDados.cdsDadosReg.ApplyUpdates(-1) > 0 then
      begin
         Application.MessageBox('Não foi possível atualizar os dados da tabela DADOSREG!', 'Compilador', MB_OK + MB_ICONERROR);
         dmManutDados.sqcEmpresa.Rollback(FTransaction);
         Exit;
      end;

      dmManutDados.sqcEmpresa.Commit(FTransaction);

   except
      on E: Exception do
      begin
         TALXFuncoes.Aviso(Pchar('Não foi possível atualizar a(s) tabela(s)! Detalhes do erro: ' + #13 +
                                   'Classe: ' + E.ClassName + #13 +
                                   'Mensagem: ' + E.Message), bmOk, imErro);

         if dmManutDados.sqcEmpresa.InTransaction then
            dmManutDados.sqcEmpresa.Rollback(FTransaction);
            
         Abort;
      end;
   end;

   ModalResult := mrOk;
end;

constructor TfrmManutDados.Create(AOwner: TComponent; AcdsBase: TClientDataSet);
begin
   inherited Create(AOwner);

   if dmManutDados = nil then
      dmManutDados := TdmManutDados.Create(Self);

   dmManutDados.sqcEmpresa.Close;

   if AcdsBase.FieldByName('TIPO_BAS').AsString = 'FB' then
   begin
      dmManutDados.sqcEmpresa.DriverName := 'Interbase';
      dmManutDados.sqcEmpresa.GetDriverFunc := 'getSQLDriverINTERBASE';
      dmManutDados.sqcEmpresa.LibraryName := 'dbxint30.dll';
      dmManutDados.sqcEmpresa.VendorLib := 'fbclient.dll';
      dmManutDados.sqcEmpresa.Params.Values['Database'] := AcdsBase.FieldByName('SERV_BAS').AsString + '/' + AcdsBase.FieldByName('PORT_BAS').AsString + ':' + AcdsBase.FieldByName('DIRE_BAS').AsString;
   end
   else if AcdsBase.FieldByName('TIPO_BAS').AsString = 'OC' then
   begin
      dmManutDados.sqcEmpresa.DriverName := 'todbxora';
      dmManutDados.sqcEmpresa.GetDriverFunc := 'getTBOORA';
      dmManutDados.sqcEmpresa.LibraryName := 'tbodbxora.dll';
      dmManutDados.sqcEmpresa.VendorLib := 'tbodbxora.dll';
      dmManutDados.sqcEmpresa.Params.Values['Database'] := '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=' + AcdsBase.FieldByName('SERV_BAS').AsString + ')(PORT=' + AcdsBase.FieldByName('PORT_BAS').AsString + ')))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=' + AcdsBase.FieldByName('SNAM_BAS').AsString + ')))';
      dmManutDados.sqcEmpresa.Params.Values['User_name'] := AcdsBase.FieldByName('DIRE_BAS').AsString;
      dmManutDados.sqcEmpresa.Params.Values['Password']  := 'masterkey';
   end;

   try

      dmManutDados.sqcEmpresa.Open;

   except
      on E: Exception do
      begin
         Application.MessageBox(PChar('Não foi possível estabelecer conexão com o banco de dados: ' + #13 +
                                      'Mensagem do erro: ' + E.Message + #13 +
                                      'Classe do erro: ' + E.ClassName), 'Compilador', MB_OK + MB_ICONERROR);

         Abort;
      end;
   end;

   dmManutDados.cdsConfig.Open;

   dmManutDados.cdsDadosReg.Open;

   pgcTabelas.ActivePage := tabCONFIG;
end;

procedure TfrmManutDados.FormDestroy(Sender: TObject);
begin
   dmManutDados.cdsDadosReg.Close;

   dmManutDados.cdsConfig.Close;

   dmManutDados.sqcEmpresa.Close;

   if dmManutDados <> nil then
      FreeAndNil(dmManutDados);

  inherited;
end;

end.
