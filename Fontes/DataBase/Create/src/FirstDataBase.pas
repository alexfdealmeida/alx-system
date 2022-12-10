{-----------------------------------------------------------------------------
 Nome da Unit: FirstDataBase
 Autor       : Alex Almeida
 Data        : 02/11/2008
 Prop�sito   : <Esta unit, tem a finalidade de armazenar m�todos, que ser�o
                utilizados, em opera��es que envolvem o banco de dados>
-----------------------------------------------------------------------------}
unit FirstDataBase;

interface

uses SysUtils, IBDataBase;

type
  TFirstDataBase = class
  private
   { Private declarations }
  protected
   { Protected declarations }
  public
   { Public declarations }
   class function CreateDataBase(ADataBaseName: String; AUser: String = 'SYSDBA';
      APassword: String = 'masterkey'; ASQLDialect: Integer = 3;
      APageSize: Integer = 16384; ACharacterSet: String = 'WIN1252'): Boolean;
  end;

implementation

uses firstFuncoes;

{ TFirstDataBase }

{$REGION CreateDataBase}
{-----------------------------------------------------------------------------
  M�todo:     TFirstDataBase.CreateDataBase
  Descri��o:  <Este m�todo tem a finalidade de criar um banco de dados, a partir
               dos par�metros informados>
  Par�metros: ADataBaseName, AUser, APassword: String; ASQLDialect, APageSize: Integer; ACharacterSet: String
  Hist�rico :   <Alex Almeida 02/11/2008 Implementa��o da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
class function TFirstDataBase.CreateDataBase(ADataBaseName, AUser,
  APassword: String; ASQLDialect, APageSize: Integer;
  ACharacterSet: String): Boolean;
var
   lDataBase: TIBDatabase;
begin
   Result := True;

   lDataBase :=  TIBDatabase.Create(nil);

   try

      lDataBase.DatabaseName := ADataBaseName;
      lDataBase.SQLDialect   := ASQLDialect;
      lDataBase.Params.Clear;
      lDataBase.Params.Add('USER ' + QuotedStr(UpperCase(AUser)));
      lDataBase.Params.Add('PASSWORD ' + QuotedStr(APassword));
      lDataBase.Params.Add('PAGE_SIZE ' + IntToStr(APageSize));
      lDataBase.Params.Add('DEFAULT CHARACTER SET ' + UpperCase(ACharacterSet));

      try
         lDataBase.CreateDatabase;

         TFuncao.Aviso('Banco de dados "' + ADataBaseName + '" criado com sucesso!');

      except
         on E: Exception do
         begin
            TFuncao.Aviso('Ocorreu um erro ao tentar criar o banco de dados: ' + #13 +
                          'Mensagem do erro: ' + E.Message + #13 +
                          'Classe do erro:' + E.ClassName,
                          bmOk,
                          imErro);
            Result := False;
         end;
      end;

   finally
      FreeAndNil(lDataBase);
   end;

end;

end.
