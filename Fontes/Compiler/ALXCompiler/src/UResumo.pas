unit UResumo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, ImgList, AdvOfficeStatusBar, AdvOfficeStatusBarStylers,
  AdvGlowButton, AdvSmoothPanel, AdvSmoothSlideShow, AdvSmoothLedLabel,
  AdvSmoothLabel, StdCtrls, AdvSmoothEdit, AdvSmoothEditButton,
  AdvSmoothDatePicker, ComCtrls, AdvDateTimePicker, AdvGroupBox, AdvEdit;

type
  TfrmResumo = class(TFMaster)
    pnlBotoes: TAdvSmoothPanel;
    btnSair: TAdvGlowButton;
    pnlPrincipal: TAdvSmoothPanel;
    gbxArquivosCopiados: TAdvGroupBox;
    gbxDiretorioLocal: TAdvGroupBox;
    gbxDiretorioRemoto: TAdvGroupBox;
    gbxFTP: TAdvGroupBox;
    edtDiretorioLocal: TAdvEdit;
    edtDiretorioRemoto: TAdvEdit;
    edtFTP: TAdvEdit;
    AdvGroupBox1: TAdvGroupBox;
    gbxInicio: TAdvGroupBox;
    edtInicio: TAdvDateTimePicker;
    gbxTermino: TAdvGroupBox;
    edtTermino: TAdvDateTimePicker;
    gbxTempo: TAdvGroupBox;
    edtTempo: TAdvDateTimePicker;
    lblMsgCompilacao: TAdvSmoothLabel;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
      AErroCompilacao, ACopiouLocal, ACopiouRemoto, ATransfFTP: Boolean;
      ADataHoraInicio, ADataHoraFim: TDateTime); reintroduce; overload;
  end;

var
  frmResumo: TfrmResumo;

implementation

uses DVersoes, DParametros, UPrincipal, ALXCompilerVariaveis;

{$R *.dfm}

procedure TfrmResumo.btnSairClick(Sender: TObject);
begin
  inherited;

   Close;
end;

constructor TfrmResumo.Create(AOwner: TComponent;
   AErroCompilacao, ACopiouLocal, ACopiouRemoto, ATransfFTP: Boolean;
   ADataHoraInicio, ADataHoraFim: TDateTime);
begin
   inherited Create(AOwner);

   if AErroCompilacao then
   begin
      lblMsgCompilacao.Caption.ColorEnd   := $00000075;
      lblMsgCompilacao.Caption.ColorStart := $000026FF;
      lblMsgCompilacao.Caption.Text := 'Compilação concluída com erro(s)!';
   end
   else
   begin
      lblMsgCompilacao.Caption.ColorEnd   := $00754F00;
      lblMsgCompilacao.Caption.ColorStart := $00FFE09F;
      lblMsgCompilacao.Caption.Text := 'Compilação concluída com sucesso!';
   end;

   edtInicio.DateTime := ADataHoraInicio;

   edtTermino.DateTime := ADataHoraFim;

   edtTempo.DateTime := edtTermino.DateTime - edtInicio.DateTime;

   if ACopiouLocal or ACopiouRemoto or ATransfFTP then
   begin
      gbxArquivosCopiados.Visible := True;

      if ACopiouLocal then
      begin
         gbxDiretorioLocal.Visible := True;

         edtDiretorioLocal.Text := dmVersoes.cdsVersoesDEXE_VER.AsString;
      end
      else
      begin
         gbxDiretorioLocal.Visible := False;
      end;

      if ACopiouRemoto then
      begin
         gbxDiretorioRemoto.Visible := True;

         if frmPrincipal.RetornaBranchAtual <> '' then
         begin
            edtDiretorioRemoto.Text := dmVersoes.cdsVersoesDZIP_VER.AsString + '\' + frmPrincipal.RetornaBranchAtual;
         end
         else
         begin
            edtDiretorioRemoto.Text := dmVersoes.cdsVersoesDZIP_VER.AsString;
         end;

         edtDiretorioRemoto.Text := edtDiretorioRemoto.Text + ZIP + '\' + FormatDateTime('dd-mm-yyyy', ADataHoraInicio);
      end
      else
      begin
         gbxDiretorioRemoto.Visible := False;
      end;

      if ATransfFTP then
      begin
         gbxFTP.Visible := True;

         edtFTP.Text := dmParametros.cdsParametrosHFTP_CFG.AsString;
      end
      else
      begin
         gbxFTP.Visible := False;
      end;
      
   end
   else
   begin
      gbxArquivosCopiados.Visible := False;
   end;
   
end;

end.
