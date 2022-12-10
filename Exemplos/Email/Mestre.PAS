unit Mestre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dbctrls, DbGrids, jpeg, Menus, ComCtrls, Mask, LastKeyPressed,
  JvToolEdit, JvDBControls, JvBaseEdits, DBCGrids, Buttons, DB, dbclient, DateUtils,ExtCtrls, JvDBComboBox,
  JvSpin, JvDBSpinEdit, CheckLst;

type
  TOnExitProcedure = procedure(Sender: TObject) of object;
  TOnNewRecordProcedure = procedure(DataSet: TDataSet) of object;

  TDataVal = record
     ComponenteName : String;
     AProcedure     : TOnExitProcedure;
  end;

  TControlWrap = class(TControl)
  public
    property Color;
  end;


  TFMestre = class(TForm)
    StatusBar1: TStatusBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  VerFocus(ObjetoOrigem : TWincontrol) : Boolean;
    procedure MemoOnEnter(Sender: TObject);
    procedure OnExitMasterDate(Sender: TObject);
  private
    AOnExit : array of TDataVal;
    procedure HintControl(Sender: TObject);
    procedure tbSetCapsLock(State: boolean);
  protected
    function AtivaValorPadraoDataSources: Boolean; virtual;
  public
    RedefineNewRecord: Boolean;
  end;

var
  FMestre: TFMestre;
  DataSetList : TList;

implementation

{$R *.DFM}

procedure TFMestre.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  lSenhaPermiss: TFormClass;
begin
   case Key of
      38 :
      begin // seta pra cima
         if (not (ActiveControl is TDBGrid))           and
            (not (ActiveControl is TMemo))             and
            (not (ActiveControl is TDBCtrlGrid))       and
            (not (ActiveControl is TCustomComboBox))   and
            (not (ActiveControl is TDbLookupComboBox)) and
            (not (ActiveControl is TDbMemo))           and
            (not (ActiveControl is TListView))         and
            (not (ActiveControl is TJvCustomSpinEdit)) and
            (not (ActiveControl is TCustomTreeView))   then
            Perform(Wm_NextDlgCtl, 1, 0);
      end;
   end;
end;

procedure TFMestre.FormKeyPress(Sender: TObject; var Key: Char);
var Origem,
    Destino : TRect;
    DC      : HDc;
    Canv    : TCanvas;
    Bmp     : TBitMap;
    Jpg     : TJPEGImage;
    Arquivo : String;
begin
   TLastKeyPressed.VerificaTecla(Key);

   case Key of
      ^G:
      begin
         Arquivo     := Screen.ActiveForm.Name;
         Arquivo     := Arquivo + '- ' + Screen.ActiveForm.Caption + '.jpeg';
         Bmp         := TBitMap.Create;
         Bmp.Height  := Screen.ActiveForm.Height;
         Bmp.Width   := Screen.ActiveForm.Width;
         DC          := GetWindowDC(Screen.ActiveForm.Handle);
         Canv        := TCanvas.Create;
         Canv.Handle := DC;
         Origem      := Rect(0, 0, Screen.Width, Screen.Height);
         Destino     := Rect(0, 0, Screen.Width, Screen.Height);
         Bmp.Canvas.CopyRect(Destino, Canv, Origem);
         Jpg         := TJPEGImage.Create;
         Jpg.Assign(Bmp);
         ForceDirectories('C:\Jpeg');
         Jpg.SaveToFile('c:\Jpeg\' + Arquivo);
         Application.MessageBox('Tela capturada com sucesso', 'CAPTURA TELA',
                                MB_OK + MB_ICONWARNING);
         Canv.Free;
         Bmp.Free;
         Jpg.Free;
      end;
      #13:
      begin
         if ActiveControl <> nil then
         begin
            if (not (ActiveControl is TDBGrid))                      and
               (not (ActiveControl is TMemo))                           and
               (not ((ActiveControl is TDbLookupComboBox) and
                     (ActiveControl as TDbLookupComboBox).ListVisible)) and
               (not ((ActiveControl is TJvDBCalcEdit) and
                     (ActiveControl as TJvDBCalcEdit).PopupVisible))    and
               (not ((ActiveControl is TJvCustomDateEdit) and
                     (ActiveControl as TJvCustomDateEdit).PopupVisible))    and
               (not (ActiveControl is TDbMemo)) and
               (not (ActiveControl is TBitBtn)) and
               (not (ActiveControl is TDBCtrlGrid))
            then
            begin
               Perform(Wm_NextDlgCtl, 0, 0);
               Key := #0;
            end;
         end;
      end;
   end;
end;

procedure TFMestre.HintControl(Sender: TObject);
var
   i : Integer;
   j : Integer;
   K : TDBRadioGroup;
   
begin
   if Screen.ActiveControl = nil then
      Exit;

   for i :=  0 to Screen.ActiveCustomForm.ComponentCount -1 do
   begin
      if Screen.ActiveCustomForm.Components[i] = nil then
         Continue;

      if Screen.ActiveCustomForm.Components[i] is TCustomEdit then
      begin                                                       
         if (TCustomEdit(Screen.ActiveCustomForm.Components[i]).Focused) and
            (TCustomEdit(Screen.ActiveCustomForm.Components[i]).TabStop) and
            (TCustomEdit(Screen.ActiveCustomForm.Components[i]).Enabled) then
         begin
            if Screen.ActiveCustomForm.Components[i] is TControl then
              TControlWrap(Screen.ActiveCustomForm.Components[i]).Color := clInfoBk;

            if Screen.ActiveCustomForm.Components[i] is TJvCustomDateEdit then
            begin
               TJvDBDateEdit(Screen.ActiveCustomForm.Components[i]).ClickKey      := 113;
               TJvDBDateEdit(Screen.ActiveCustomForm.Components[i]).CalendarStyle := csPopup;
               TJvDBDateEdit(Screen.ActiveCustomForm.Components[i]).DialogTitle   := 'Selecione uma data';
            end
            else if Screen.ActiveCustomForm.Components[i] is TJvCustomCalcEdit then
            begin
               TJvDBCalcEdit(Screen.ActiveCustomForm.Components[i]).ClickKey      := 113;
            end;
         end
         else if (TCustomEdit(Screen.ActiveCustomForm.Components[i]).TabStop) and
                 (TCustomEdit(Screen.ActiveCustomForm.Components[i]).Enabled) then
         begin
            if Screen.ActiveCustomForm.Components[i] is TControl then
              TControlWrap(Screen.ActiveCustomForm.Components[i]).Color := clWindow;
              
            if (Screen.ActiveCustomForm.Components[i] is TMemo) then
            begin
               TMemo(Screen.ActiveCustomForm.Components[i]).OnEnter := MemoOnEnter;
            end
            else if (Screen.ActiveCustomForm.Components[i] is TDBMemo) then
            begin
               TDBMemo(Screen.ActiveCustomForm.Components[i]).OnEnter := MemoOnEnter;
            end;
         end;
      end;

      if Screen.ActiveCustomForm.Components[i] is TDBRadioGroup then
      begin

         K := TDBRadioGroup(Screen.ActiveCustomForm.Components[i]);

         for J := 0 to K.Items.Count -1 do
         begin
            if TDBRadioGroup(K.Controls[J]).Focused then
               TDBRadioGroup(K.Controls[J]).Font.Color := clMaroon
            else
            begin
               TDBRadioGroup(K.Controls[J]).Font.Color := clWindowText;

               if (K.ItemIndex = J) then
                  TDBRadioGroup(K.Controls[J]).Font.Color := clMaroon
               else
                  TDBRadioGroup(K.Controls[J]).Font.Color := clWindowText;
            end;
         end;
      end;
   end;

   if Screen.ActiveControl <> nil then
      if (not Screen.ActiveControl.ShowHint) then
         for I := 0 to Screen.ActiveCustomForm.ComponentCount - 1 do
             if Screen.ActiveCustomForm.Components[I].Name = 'StatusBar1' then
                TStatusBar(Screen.ActiveCustomForm.Components[I]).SimpleText := Screen.ActiveControl.Hint;
end;

procedure TFMestre.FormCreate(Sender: TObject);
var
   i : integer;

   Procedure AddComponente(componente : TJvCustomDateEdit);
   begin
      SetLength(AOnExit,length(AOnExit)+1);

      AOnExit[High(AOnExit)].ComponenteName := componente.Name;
      AOnExit[High(AOnExit)].AProcedure     := TEdit(componente).OnExit;
      TEdit(componente).OnExit              := OnExitMasterDate;
   end;
begin
   Screen.OnActiveControlChange := HintControl;

   SetLength(AOnExit,0);
   RedefineNewRecord := True;

end;

procedure TFMestre.FormShow(Sender: TObject);
var
   NovoCaption : String;

begin

   NovoCaption := Copy((Sender as TFMestre).Name, 2 ,Length((Sender as TFMestre).Name));

   if Pos(NovoCaption, (Sender as TFMestre).Caption) <= 0 then
      (Sender as TFMestre).Caption := NovoCaption + ' - ' +(Sender as TFMestre).Caption;

end;

procedure TFMestre.FormClose(Sender: TObject; var Action: TCloseAction);

begin
   Action := caFree;
end;

// Esta Função vai ser colocada no eveto OnExit dos Objetos para que não
// precise mais colocar o teste de qual objeto esta sendo clicado
function TFMestre.VerFocus(ObjetoOrigem: TWincontrol): Boolean;
var
  I, OrderOrigem, OrderDestino : Integer;
  List: TList;
begin
   Result := False;

   if (Screen.ActiveControl.Name = 'btnCancela')  or
      (Screen.ActiveControl.Name = 'btnCancelar') or
      (Screen.ActiveControl.Name = 'btnSair')     or
      (Screen.ActiveControl.Name = 'btnDesiste')  or
      (Screen.ActiveControl.Name = 'btnExcluiPar') then
   begin
      Result := True;
      Exit;
   end;

   OrderOrigem  := 0;
   OrderDestino := 0;

   List := TList.Create;
   try
      Screen.ActiveCustomForm.GetTabOrderList(List);
      for I := 0 to List.Count -1 do
      begin
         if List[I] = ObjetoOrigem then
            OrderOrigem := I;

         if List[I] = Screen.ActiveControl then
            OrderDestino := I;
      end;

   finally
      List.Free;
   end;

   if (OrderDestino < OrderOrigem) then
   begin
      Result := True;
   end;
end;

procedure TFMestre.MemoOnEnter(Sender: TObject);
begin
   tbSetCapsLock(True);
end;

procedure TFMestre.tbSetCapsLock(State: boolean);
begin

end;

procedure TFMestre.OnExitMasterDate(Sender: TObject);
var
   date_c : TDate;
   ano_atual : integer;
   ano_data  : Integer;
   onexit_anterior : TOnExitProcedure;
   j : Integer;
begin

   if (UpperCase(Screen.ActiveControl.Name) = 'BTNCANCEL') or
      (UpperCase(Screen.ActiveControl.Name) = 'BTNSAIR') or
      (UpperCase(Screen.ActiveControl.Name) = 'BTNCANCELAR') then
      exit;

   onexit_anterior := nil;

   for j := 0 to Length(AOnExit) - 1 do
      if AOnExit[j].ComponenteName = TJvCustomDateEdit(sender).Name then
      begin
         onexit_anterior := AOnExit[j].AProcedure;
         break;
      end;

   if Assigned(onexit_anterior) then
      onexit_anterior(sender);

end;

function TFMestre.AtivaValorPadraoDataSources: Boolean;
begin
  Result := True;
end;
end.

