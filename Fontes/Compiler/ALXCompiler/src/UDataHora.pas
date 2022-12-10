unit UDataHora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMaster, ImgList, AppEvnts, AdvOfficeStatusBar, StdCtrls, Buttons, JvExControls, JvEnterTab, ExtCtrls,
  AdvOfficePager, Mask, JvExMask, JvToolEdit, JvComponentBase,
  AdvOfficeStatusBarStylers, AdvSmoothPanel, AdvGroupBox;

type
  TfrmDataHora = class(TFMaster)
    JvEnterAsTab1: TJvEnterAsTab;
    pnlBotoes: TAdvSmoothPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    AdvSmoothPanel1: TAdvSmoothPanel;
    grpAdaptador: TAdvGroupBox;
    edtData: TJvDateEdit;
    edtHora: TMaskEdit;
    grpModulos: TAdvGroupBox;
    edtDataAux: TJvDateEdit;
    edtHoraAux: TMaskEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDataExit(Sender: TObject);
  private
    { Private declarations }
    function Valida(AIndice: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmDataHora: TfrmDataHora;

implementation

{$R *.dfm}

procedure TfrmDataHora.btnCancelarClick(Sender: TObject);
begin
  inherited;

   ModalResult := mrCancel;
end;

procedure TfrmDataHora.btnGravarClick(Sender: TObject);
begin
  inherited;

   if not Valida(1) or not Valida(2) or not Valida(3) or not Valida(4) or
      not Valida(5) or not Valida(6) or not Valida(7) or not Valida(8)  then
      Exit;

   ModalResult := mrOk;
end;

procedure TfrmDataHora.edtDataExit(Sender: TObject);
begin
  inherited;

   edtDataAux.Text := edtData.Text;
end;

procedure TfrmDataHora.FormCreate(Sender: TObject);
begin
  inherited;

   edtData.Text    := FormatDateTime('dd/mm/yyyy', Date);
   edtHora.Text    := FormatDateTime('hh:mm:ss', EncodeTime(23, 0, 0, 0));
   edtDataAux.Text := edtData.Text;
   edtHoraAux.Text := FormatDateTime('hh:mm:ss', EncodeTime(20, 0, 0, 0));
end;

function TfrmDataHora.Valida(AIndice: Integer): Boolean;
var
   lDataHora: TDateTime;
begin
   Result := True;

   case AIndice of
      1 :
      begin
         if edtData.Text = '  /  /    ' then
         begin
            Application.MessageBox('A data (Adaptador) dever ser informada!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtData.SetFocus;
         end;
      end;
      2 :
      begin
         if not TryStrToDate(edtData.Text, lDataHora) then
         begin
            Application.MessageBox('A data (Adaptador) informada é inválida!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtData.SetFocus;
         end;
      end;
      3 :
      begin
         if edtHora.Text = '  :  :  ' then
         begin
            Application.MessageBox('A hora (Adaptador) dever ser informada!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtHora.SetFocus;
         end;
      end;
      4 :
      begin
         if not TryStrToTime(edtHora.Text, lDataHora) then
         begin
            Application.MessageBox('A hora (Adaptador) informada é inválida!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtHora.SetFocus;
         end;
      end;
      5 :
      begin
         if edtDataAux.Text = '  /  /    ' then
         begin
            Application.MessageBox('A data (Demais módulos) dever ser informada!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtDataAux.SetFocus;
         end;
      end;
      6 :
      begin
         if not TryStrToDate(edtDataAux.Text, lDataHora) then
         begin
            Application.MessageBox('A data (Demais módulos) informada é inválida!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtDataAux.SetFocus;
         end;
      end;
      7 :
      begin
         if edtHoraAux.Text = '  :  :  ' then
         begin
            Application.MessageBox('A hora (Demais módulos) dever ser informada!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtHoraAux.SetFocus;
         end;
      end;
      8 :
      begin
         if not TryStrToTime(edtHoraAux.Text, lDataHora) then
         begin
            Application.MessageBox('A hora (Demais módulos) informada é inválida!', 'ALXCompiler', MB_OK + MB_ICONINFORMATION);
            Result := False;
            edtHoraAux.SetFocus;
         end;
      end;
   end;
end;

end.
