{-----------------------------------------------------------------------------
 Nome da Unit: UALXProgressBar
 Autor:        Alex Almeida
 Data:         21/10/2008
 Propósito:    <Este formulário é utilizado pela classe TUALXProgressBar.
                Portanto, não deve ser chamado diretamente.>
-----------------------------------------------------------------------------}
unit UALXProgressBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, JvExControls, JvGIFCtrl, ExtCtrls, JvExStdCtrls,
  JvGradient, JvAnimatedImage, AdvGlowButton, DBCtrls, AdvOfficePager, ImgList,
  ALXProgressBar, JvFormAnimatedIcon, JvComponentBase, JvAnimTitle;

type
  TfrmALXProgressBar = class(TForm)
    Timer1: TTimer;
    pgcVersao: TAdvOfficePager;
    tabExecutando: TAdvOfficePage;
    ProgressBarProgressoAuto: TJvGIFAnimator;
    ProgressBarProgressoManual: TProgressBar;
    btnCancelar: TAdvGlowButton;
    ImageList1: TImageList;
    JvAnimTitle1: TJvAnimTitle;
    gifAuxiliar: TJvGIFAnimator;
    procedure Timer1Timer(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FALXProgressBar: TALXProgressBar;
  public
    { Public declarations }
    procedure Atualizar(AIncrementar: Integer; AAcao: String);
    constructor Create(AOwner: TComponent; AALXProgressBar: TALXProgressBar;
      AProgressoAuto: Boolean; AMinimo, AMaximo: Integer; AAcaoAuto: String;
      ADesabilitarProgress: Boolean; AExibirCancel: Boolean); reintroduce; overload;
  end;

var
  frmALXProgressBar: TfrmALXProgressBar;

implementation

{$R *.dfm}

{ TFUALXProgressBar }

{$REGION Create}
{-----------------------------------------------------------------------------
  Método:     TFUALXProgressBar.Create
  Descrição:  <Descrição deste método>
  Parâmetros: AOwner: TComponent; AProgressoAuto: Boolean; AMinimo, AMaximo: Integer ; AAcaoAuto: String
  Histórico : <Alex Almeida 21/10/2008 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
procedure TfrmALXProgressBar.btnCancelarClick(Sender: TObject);
begin
   FALXProgressBar.Cancelar := True;
end;

constructor TfrmALXProgressBar.Create(AOwner: TComponent;
   AALXProgressBar: TALXProgressBar; AProgressoAuto: Boolean; AMinimo, AMaximo: Integer;
   AAcaoAuto: String; ADesabilitarProgress: Boolean; AExibirCancel: Boolean);
begin
  inherited Create(AOwner);

   FALXProgressBar := AALXProgressBar;

   btnCancelar.Visible := AExibirCancel;

   if not AProgressoAuto then
   begin
      ProgressBarProgressoManual.Visible := not ADesabilitarProgress;

      ProgressBarProgressoManual.Min := AMinimo;
      ProgressBarProgressoManual.Max := AMaximo;

      ProgressBarProgressoAuto.Visible   := false;
   end
   else
   begin
      ProgressBarProgressoManual.Visible := false;
      ProgressBarProgressoAuto.Visible   := not ADesabilitarProgress;

      tabExecutando.Caption := AAcaoAuto;
   end;

   gifAuxiliar.Visible := ProgressBarProgressoManual.Visible;
end;

procedure TfrmALXProgressBar.Timer1Timer(Sender: TObject);
begin
   Refresh;
   Application.ProcessMessages;
end;

{$REGION Atualizar}
{-----------------------------------------------------------------------------
  Método:     TFUALXProgressBar.Atualizar
  Descrição:  <Descrição deste método>
  Parâmetros: AIncrementar: Integer; AAcao: String
  Histórico : <Alex Almeida 21/10/2008 Implementação da rotina>
-----------------------------------------------------------------------------}
{$ENDREGION}
procedure TfrmALXProgressBar.Atualizar(AIncrementar: Integer; AAcao: String);
begin
   tabExecutando.Caption := AAcao;
   ProgressBarProgressoManual.StepBy(AIncrementar);
end;

end.

