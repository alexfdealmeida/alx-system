{-----------------------------------------------------------------------------
 Nome da Unit: ALXProgressBar
 Autor:        Alex Almeida
 Data:         20/10/2008
 Prop�sito:    <Esta classe tem a finalidade de substituir a utiliza��o do
                componente JvProgressDiolog, devido a alguns erros ocasionados
                ao destruir o mesmo, quando criado dinamicamente>
-----------------------------------------------------------------------------}
unit ALXProgressBar;

interface

uses
   Windows, Classes, ComCtrls, Forms, Controls, SysUtils;

type
  TALXProgressBar = class(TObject)
  private
    FOwner: TForm;
    FProgressBar: TForm;
    FCancelar: Boolean;
    procedure SetCancelar(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TForm; AProgressoAuto: Boolean = True;
      AMinimo: Integer = 0; AMaximo: Integer = 100;
      AAcaoAuto: String = 'Executando...';
      ADesabilitarProgress: Boolean = False;
      AExibirCancel: Boolean = False); reintroduce; overload;
    destructor Destroy; override;
    procedure StepBy(AIncrementar: Integer = 1; AAcao: String = 'Executando...');
    property Cancelar: Boolean read FCancelar write SetCancelar;
  end;

implementation

uses UALXProgressBar;

{ TSiagriProgressBar }

{$REGION Create}
{-----------------------------------------------------------------------------
  M�todo:     TSiagriProgressBar.Create
  Descri��o:  <Ao criar a classe, deve ser utilizado este construtor, para que
               seja poss�vel setar os par�metros, e j� criar o formul�rio com
               o ProgressBar automaticamente>
  Par�metros: AOwner: TForm - utilize este par�metro, caso deseja desabilitar o
                      formul�rio que est� realizando a chamada, o mesmo
                      ser� habilitado, assim que for chamado o destroy
                      desta classe;
                      Obs.: Caso n�o deseje desabilitar, este par�metro
                      poder� ser setado com "nil".
              AProgressoAuto: Boolean - setando este par�metro com "true", o
                              ProgressBar, progredir� automaticamente, apenas
                              exibindo um gif(anima��o). Entretanto, quando
                              setado com "false", o progresso da ProgressBar,
                              dever� ser controlada manualmente, atrav�s do uso
                              do m�todo "StepBy", setando a quantidade que
                              dever� ser incrementada, juntamente com a
                              descri��o que ser� exibida;
                              Obs.: Recomanda-se setar este par�metro com "true",
                              em situa��es em que � dif�cil determinar o tempo
                              que ser� gasto para execu��o da rotina, como por
                              exemplo, eo executar uma consulta no banco de dados.
                              Enquanto o "false", � recomando para situa��es
                              em que seja poss�vel estimar o tempo que ser� gasto
                              para a execu��o da rotina, como por exemplo, em
                              estruturas de loop, como o "while" e o "for".
              AMinimo, AMaximo: Integer - Estes par�metros dever�o ser informados,
                                quando o par�metro AProgressoAuto, for setado
                                como "false". Definindo desta maneira, o intervalo
                                que o ProgressBar ser� incrementado;
              AAcaoAuto: String - Este par�metro, dever� (poder�) ser informado,
                         quando o par�metro AProgressoAuto, for setado como "true".
                         Armzenando desta maneira, o t�tulo que ser� exibido,
                         enquanto o ProgressBar estiver sendo executado.
              ADesabilitarProgress: Boolean - Utilizar este par�metro quando desejar
                                    manter o ProgressBar invis�vel.

              Obs.: Lembre-se de utilizar o Destroy, assim q terminar de executar
              a rotina, pois � desta forma que o formul�rio que cont�m o ProgressBar
              tamb�m � destru�do.
  Hist�rico : <Alex Almeida 20/10/2008 Implementa��o da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
constructor TALXProgressBar.Create(AOwner: TForm;
   AProgressoAuto: Boolean; AMinimo, AMaximo: Integer; AAcaoAuto: String;
   ADesabilitarProgress: Boolean; AExibirCancel: Boolean);
begin
  inherited Create;

   Cancelar := False;

   { Armazerna o formul�rio que est� chamando, pois o mesmo ser� referenciado
     no m�todo destrutor da classe }
   FOwner := AOwner;

   if FOwner <> nil then
   begin
      { Desabilita o formul�rio que est� chamando esta classe }
      FOwner.Enabled := False;

      FProgressBar      := TfrmALXProgressBar.Create(FOwner,
                                                     Self,
                                                     AProgressoAuto,
                                                     AMinimo,
                                                     AMaximo,
                                                     AAcaoAuto,
                                                     ADesabilitarProgress,
                                                     AExibirCancel);
   end
   else
   begin
      FProgressBar      := TfrmALXProgressBar.Create(Application,
                                                     Self,
                                                     AProgressoAuto,
                                                     AMinimo,
                                                     AMaximo,
                                                     AAcaoAuto,
                                                     ADesabilitarProgress,
                                                     AExibirCancel);
   end;




   FProgressBar.Show;
end;

{$REGION Destroy}
{-----------------------------------------------------------------------------
  M�todo:     TSiagriProgressBar.Destroy
  Descri��o:  <Este destrutor, tem a finalidade de destruir e liberar da mem�ria
               o formul�rio que cont�m o Progress Bar>
  Par�metros: None
  Hist�rico : <Alex Almeida 20/10/2008 Implementa��o da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
destructor TALXProgressBar.Destroy;
begin
   { Habilita o formul�rio que est� chamando esta classe }
   if FOwner <> nil then
      FOwner.Enabled := True;

   FProgressBar.Close;

   {if FProgressBar <> nil then
   begin
      FreeAndNil(FProgressBar);
   end;}

  inherited;
end;

{$REGION StepBy}
{-----------------------------------------------------------------------------
  M�todo:     TSiagriProgressBar.StepBy
  Descri��o:  <Este m�todo deve ser chamado sempre que se desejar incrementar
               o Progress Bar>
  Par�metros: AIncrementar: Integer; AAcao: String
  Hist�rico : <Alex Almeida 20/10/2008 Implementa��o da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
procedure TALXProgressBar.SetCancelar(const Value: Boolean);
begin
  FCancelar := Value;
end;

procedure TALXProgressBar.StepBy(AIncrementar: Integer; AAcao: String);
begin
   TfrmALXProgressBar(FProgressBar).Atualizar(AIncrementar, AAcao);
end;

end.
