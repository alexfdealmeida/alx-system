unit UModulos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UMasterCad, JvExControls, JvEnterTab, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, Mask, DBCtrls, DB, JvExExtCtrls, ActnList, AppEvnts,
  AdvOfficeStatusBar, ImgList, JvComponentBase, AdvOfficeStatusBarStylers,
  AdvOfficeButtons, DBAdvOfficeButtons, AdvSmoothPanel;

type
  TfrmModulos = class(TfrmMasterCad)
    lblDESC_MOD: TLabel;
    edtDESC_MOD: TDBEdit;
    lblWANT_MOD: TLabel;
    edtWANT_MOD: TDBEdit;
    dtsModulos: TDataSource;
    chkLAST_MOD: TDBAdvOfficeCheckBox;
    chkAUTO_MOD: TDBAdvOfficeCheckBox;
    procedure edtDESC_MODExit(Sender: TObject);
    procedure edtWANT_MODExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    function ModuloCadastrado: Boolean;
    function JaExisteModuloCompilarUltimo: Boolean;
  public
    { Public declarations }
  end;

var
  frmModulos: TfrmModulos;

implementation

uses DModulos, UPrincipal, ALXCompilerVariaveis, ALXFuncoes;

{$R *.dfm}

procedure TfrmModulos.btnGravarClick(Sender: TObject);
begin
   if TALXFuncoes.Obrigatorio(edtDESC_MOD, 'descrição do módulo') or
      TALXFuncoes.Obrigatorio(edtWANT_MOD, 'descrição para o compilador') then
   begin
      Exit;
   end;

   if ModuloCadastrado then
      Exit;

   if JaExisteModuloCompilarUltimo then
      Exit;

  inherited;
end;

procedure TfrmModulos.edtDESC_MODExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtDESC_MOD, 'descrição do módulo') then
   begin
      Exit;
   end;
end;

procedure TfrmModulos.edtWANT_MODExit(Sender: TObject);
begin
  inherited;
   if TALXFuncoes.Obrigatorio(edtWANT_MOD, 'descrição para o compilador') then
   begin
      Exit;
   end;
end;

function TfrmModulos.JaExisteModuloCompilarUltimo: Boolean;
begin
   Result := False;

   if (dmModulos.cdsModulos.State in [dsInsert]) or
      ( (dmModulos.cdsModulos.State in [dsEdit]) and (dmModulos.cdsModulosLAST_MOD.OldValue <> dmModulos.cdsModulosLAST_MOD.NewValue) ) then
   begin
      if chkLAST_MOD.Checked then
      begin
         dmModulos.cdsAux.Close;
         dmModulos.cdsAux.CommandText := 'select MDL.DESC_MOD ' +
                                         'from MODULO MDL ' +
                                         'where (MDL.LAST_MOD = ''S'') and ' +
                                         '      (MDL.CODI_USU = ' + IntToStr(CODI_USU) + ')';
         dmModulos.cdsAux.Open;

         if not dmModulos.cdsAux.IsEmpty then
         begin
            Application.MessageBox(PChar('O módulo ' + dmModulos.cdsAux.FieldByName('DESC_MOD').AsString + ' já está configurado para ser compilado por último!'), 'Compilador', MB_OK + MB_ICONINFORMATION);
            dmModulos.cdsModulosLAST_MOD.AsString := 'N';
            Result := True;
         end;

         dmModulos.cdsAux.Close;
      end;
   end;
end;

function TfrmModulos.ModuloCadastrado: Boolean;
begin
   Result := False;

   if (dmModulos.cdsModulos.State in [dsInsert]) or
      ( (dmModulos.cdsModulos.State in [dsEdit]) and (dmModulos.cdsModulosWANT_MOD.OldValue <> dmModulos.cdsModulosWANT_MOD.NewValue) ) then
   begin
      dmModulos.cdsAux.Close;
      dmModulos.cdsAux.CommandText := 'select MDL.CODI_MOD ' +
                                      'from MODULO MDL ' +
                                      'where (MDL.WANT_MOD = ' + QuotedStr(edtWANT_MOD.Text) + ') and ' +
                                      '      (MDL.CODI_USU = ' + IntToStr(CODI_USU) + ')';
      dmModulos.cdsAux.Open;

      if not dmModulos.cdsAux.IsEmpty then
      begin
         Application.MessageBox('Este módulo já foi cadastrado!', 'Compilador', MB_OK + MB_ICONINFORMATION);
         Result := True;
      end;

      dmModulos.cdsAux.Close;
   end;
end;

end.
