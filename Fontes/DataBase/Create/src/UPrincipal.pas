unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, dxSkinsForm,
  ExtCtrls, AdvPanel, AdvOfficePager, cxControls, cxEdit, cxTextEdit, StdCtrls,
  cxGroupBox, cxMaskEdit, cxDropDownEdit, Menus, cxButtons, JvExControls,
  JvEnterTab, JvComponentBase, JvBalloonHint, Buttons, WideStrings, DB, SqlExpr,
  FMTBcd, cxContainer, cxGraphics, cxLookAndFeelPainters;

type
  TfrmPrincipal = class(TForm)
    dxSkinController1: TdxSkinController;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    FileSaveDialog1: TFileSaveDialog;
    gbxDB: TcxGroupBox;
    edtDB: TcxTextEdit;
    gbxUsuario: TcxGroupBox;
    edtUsuario: TcxTextEdit;
    gbxSenha: TcxGroupBox;
    edtSenha: TcxTextEdit;
    gbxPageSize: TcxGroupBox;
    cbxPageSize: TcxComboBox;
    gbxCharset: TcxGroupBox;
    cbxCharset: TcxComboBox;
    gbxSQL: TcxGroupBox;
    cbxSQL: TcxComboBox;
    JvBalloonHint1: TJvBalloonHint;
    JvEnterAsTab1: TJvEnterAsTab;
    btnDB: TSpeedButton;
    btnCriar: TcxButton;
    btnFechar: TcxButton;
    cxEditStyleControllerEdit: TcxEditStyleController;
    procedure btnDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCriarClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetValoresPadroes;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses FirstDataBase, Math;

{$R *.dfm}

procedure TfrmPrincipal.btnCriarClick(Sender: TObject);
begin
   TFirstDataBase.CreateDataBase(edtDB.Text,
                                 edtUsuario.Text,
                                 edtSenha.Text,
                                 IfThen(cbxSQL.ItemIndex = 0, 1, 3),
                                 StrToInt(cbxPageSize.Text),
                                 cbxCharset.Text);
end;

procedure TfrmPrincipal.btnDBClick(Sender: TObject);
begin
   if FileSaveDialog1.Execute then
      edtDB.Text := FileSaveDialog1.FileName;
end;

procedure TfrmPrincipal.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   frmPrincipal := nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
   SetValoresPadroes;
end;

procedure TfrmPrincipal.SetValoresPadroes;
begin
   edtUsuario.Text       := 'SYSDBA';
   edtSenha.Text         := 'masterkey';
   cbxPageSize.ItemIndex := 4;
   cbxCharset.ItemIndex  := 2;
   cbxSQL.ItemIndex      := 1;
end;

end.
