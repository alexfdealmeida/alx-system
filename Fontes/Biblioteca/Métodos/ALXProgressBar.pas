{-----------------------------------------------------------------------------
 Nome da Unit: ALXProgressBar
 Autor:        Alex Almeida
 Data:         20/10/2008
 Propósito:    <Esta classe tem a finalidade de substituir a utilização do
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
  Método:     TSiagriProgressBar.Create
  Descrição:  <Ao criar a classe, deve ser utilizado este construtor, para que
               seja possível setar os parâmetros, e já criar o formulário com
               o ProgressBar automaticamente>
  Parâmetros: AOwner: TForm - utilize este parâmetro, caso deseja desabilitar o
                      formulário que está realizando a chamada, o mesmo
                      será habilitado, assim que for chamado o destroy
                      desta classe;
                      Obs.: Caso não deseje desabilitar, este parâmetro
                      poderá ser setado com "nil".
              AProgressoAuto: Boolean - setando este parâmetro com "true", o
                              ProgressBar, progredirá automaticamente, apenas
                              exibindo um gif(animação). Entretanto, quando
                              setado com "false", o progresso da ProgressBar,
                              deverá ser controlada manualmente, através do uso
                              do método "StepBy", setando a quantidade que
                              deverá ser incrementada, juntamente com a
                              descrição que será exibida;
                              Obs.: Recomanda-se setar este parâmetro com "true",
                              em situações em que é difícil determinar o tempo
                              que será gasto para execução da rotina, como por
                              exemplo, eo executar uma consulta no banco de dados.
                              Enquanto o "false", é recomando para situações
                              em que seja possível estimar o tempo que será gasto
                              para a execução da rotina, como por exemplo, em
                              estruturas de loop, como o "while" e o "for".
              AMinimo, AMaximo: Integer - Estes parâmetros deverão ser informados,
                                quando o parâmetro AProgressoAuto, for setado
                                como "false". Definindo desta maneira, o intervalo
                                que o ProgressBar será incrementado;
              AAcaoAuto: String - Este parâmetro, deverá (poderá) ser informado,
                         quando o parâmetro AProgressoAuto, for setado como "true".
                         Armzenando desta maneira, o título que será exibido,
                         enquanto o ProgressBar estiver sendo executado.
              ADesabilitarProgress: Boolean - Utilizar este parâmetro quando desejar
                                    manter o ProgressBar invisível.

              Obs.: Lembre-se de utilizar o Destroy, assim q terminar de executar
              a rotina, pois é desta forma que o formulário que contém o ProgressBar
              também é destruído.
  Histórico : <Alex Almeida 20/10/2008 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
constructor TALXProgressBar.Create(AOwner: TForm;
   AProgressoAuto: Boolean; AMinimo, AMaximo: Integer; AAcaoAuto: String;
   ADesabilitarProgress: Boolean; AExibirCancel: Boolean);
begin
  inherited Create;

   Cancelar := False;

   { Armazerna o formulário que está chamando, pois o mesmo será referenciado
     no método destrutor da classe }
   FOwner := AOwner;

   if FOwner <> nil then
   begin
      { Desabilita o formulário que está chamando esta classe }
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
  Método:     TSiagriProgressBar.Destroy
  Descrição:  <Este destrutor, tem a finalidade de destruir e liberar da memória
               o formulário que contém o Progress Bar>
  Parâmetros: None
  Histórico : <Alex Almeida 20/10/2008 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
destructor TALXProgressBar.Destroy;
begin
   { Habilita o formulário que está chamando esta classe }
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
  Método:     TSiagriProgressBar.StepBy
  Descrição:  <Este método deve ser chamado sempre que se desejar incrementar
               o Progress Bar>
  Parâmetros: AIncrementar: Integer; AAcao: String
  Histórico : <Alex Almeida 20/10/2008 Implementação da rotina>
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
