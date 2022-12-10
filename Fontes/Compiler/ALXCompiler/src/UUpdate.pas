unit UUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ShellAPI,
  JvExStdCtrls, JvEdit, JvValidateEdit, DB, ImgList, ToolWin, CategoryButtons,
  JvExExtCtrls, UONEDBGrid;

type
  TFiltroUpdate = (fuTodos, fuAdicionados, fuAtualizados, fuDeletados,
                   fuConflitantes, fuMesclados, fuRestaurado);

  TfrmUpdate = class(TForm)
    pnlPrincipal: TPanel;
    btnSair: TBitBtn;
    pnlVersoes: TPanel;
    gbxQtdArquivos: TGroupBox;
    edtQTDE_ARQ: TJvValidateEdit;
    dtsVersoes: TDataSource;
    dtsArquivos: TDataSource;
    ImageListImagens: TImageList;
    CategoryButtons1: TCategoryButtons;
    DBONEGridUpdate: TONEDBGrid;
    DBONEGridVersoes: TONEDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBONEGridUpdateDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure dtsVersoesDataChange(Sender: TObject; Field: TField);
    procedure dtsArquivosDataChange(Sender: TObject; Field: TField);
    procedure DBONEGridUpdateDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure CategoryButtons1Categories0Items0Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items1Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items2Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items3Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items4Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items5Click(Sender: TObject);
    procedure CategoryButtons1Categories0Items6Click(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaQuantidade;
    procedure SetaFocoCategoryButton(AFiltroUpdate: TFiltroUpdate);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AFiltroUpdate: TFiltroUpdate); reintroduce; overload;
    procedure FiltraUpdate(AFiltroUpdate: TFiltroUpdate);
  end;

var
  frmUpdate: TfrmUpdate;

implementation

uses UPrincipal, DUpdate;

{$R *.dfm}

procedure TfrmUpdate.AtualizaQuantidade;
begin
   if dmUpdate.cdsArquivos.IsEmpty then
      edtQTDE_ARQ.Value := 0
   else
      edtQTDE_ARQ.Value := dmUpdate.cdsArquivos.RecordCount;
end;

procedure TfrmUpdate.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items0Click(Sender: TObject);
begin
   FiltraUpdate(fuTodos);
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items1Click(Sender: TObject);
begin
   FiltraUpdate(fuAdicionados);
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items2Click(Sender: TObject);
begin
   FiltraUpdate(fuAtualizados);
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items3Click(Sender: TObject);
begin
   FiltraUpdate(fuDeletados);
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items4Click(Sender: TObject);
begin
   FiltraUpdate(fuConflitantes);
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items5Click(Sender: TObject);
begin
   FiltraUpdate(fuMesclados);
end;

procedure TfrmUpdate.CategoryButtons1Categories0Items6Click(Sender: TObject);
begin
   FiltraUpdate(fuRestaurado);
end;

constructor TfrmUpdate.Create(AOwner: TComponent; AFiltroUpdate: TFiltroUpdate);
begin
   inherited Create(AOwner);

   FiltraUpdate(AFiltroUpdate);

   SetaFocoCategoryButton(AFiltroUpdate);
end;

procedure TfrmUpdate.DBONEGridUpdateDblClick(Sender: TObject);
begin
   if not dmUpdate.cdsArquivos.IsEmpty then
      ShellExecute(0, nil, PChar(ExtractFileDir(dmUpdate.cdsArquivosARQU_RES.AsString)), nil, nil, SW_SHOW);
end;

procedure TfrmUpdate.DBONEGridUpdateDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (Column.FieldName = 'STAT_RES') then
   begin
      if dmUpdate.cdsArquivosSTAT_RES.AsString = 'A' then
      begin
         DBONEGridUpdate.Canvas.FillRect(Rect);
         ImageListImagens.Draw(DBONEGridUpdate.Canvas,Rect.Left + 1, Rect.Top, 0);
      end
      else if dmUpdate.cdsArquivosSTAT_RES.AsString = 'U' then
      begin
         DBONEGridUpdate.Canvas.FillRect(Rect);
         ImageListImagens.Draw(DBONEGridUpdate.Canvas,Rect.Left + 1, Rect.Top, 1);
      end
      else if dmUpdate.cdsArquivosSTAT_RES.AsString = 'D' then
      begin
         DBONEGridUpdate.Canvas.FillRect(Rect);
         ImageListImagens.Draw(DBONEGridUpdate.Canvas,Rect.Left + 1, Rect.Top, 2);
      end
      else if dmUpdate.cdsArquivosSTAT_RES.AsString = 'C' then
      begin
         DBONEGridUpdate.Canvas.FillRect(Rect);
         ImageListImagens.Draw(DBONEGridUpdate.Canvas,Rect.Left + 1, Rect.Top, 3);
      end
      else if dmUpdate.cdsArquivosSTAT_RES.AsString = 'G' then
      begin
         DBONEGridUpdate.Canvas.FillRect(Rect);
         ImageListImagens.Draw(DBONEGridUpdate.Canvas,Rect.Left + 1, Rect.Top, 4);
      end
      else if dmUpdate.cdsArquivosSTAT_RES.AsString = 'R' then
      begin
         DBONEGridUpdate.Canvas.FillRect(Rect);
         ImageListImagens.Draw(DBONEGridUpdate.Canvas,Rect.Left + 1, Rect.Top, 5);
      end;
   end
   else
      DBONEGridUpdate.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmUpdate.dtsArquivosDataChange(Sender: TObject; Field: TField);
begin
   AtualizaQuantidade;
end;

procedure TfrmUpdate.dtsVersoesDataChange(Sender: TObject; Field: TField);
begin
   AtualizaQuantidade;
end;

procedure TfrmUpdate.FiltraUpdate(AFiltroUpdate: TFiltroUpdate);
begin
   if AFiltroUpdate = fuTodos then
   begin
      dmUpdate.cdsArquivos.Filtered := False;
      dmUpdate.cdsArquivos.Filter   := '';
   end
   else
   begin
      dmUpdate.cdsArquivos.Filtered := False;

      case AFiltroUpdate of
         fuAdicionados  : dmUpdate.cdsArquivos.Filter := 'STAT_RES = ''A''';
         fuAtualizados  : dmUpdate.cdsArquivos.Filter := 'STAT_RES = ''U''';
         fuDeletados    : dmUpdate.cdsArquivos.Filter := 'STAT_RES = ''D''';
         fuConflitantes : dmUpdate.cdsArquivos.Filter := 'STAT_RES = ''C''';
         fuMesclados    : dmUpdate.cdsArquivos.Filter := 'STAT_RES = ''G''';
         fuRestaurado   : dmUpdate.cdsArquivos.Filter := 'STAT_RES = ''R''';
      end;

      dmUpdate.cdsArquivos.Filtered := True;
   end;
end;

procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   frmUpdate := nil;
end;

procedure TfrmUpdate.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_ESCAPE) then
      btnSairClick(Sender);
end;

procedure TfrmUpdate.SetaFocoCategoryButton(AFiltroUpdate: TFiltroUpdate);
begin
   case AFiltroUpdate of
      fuTodos        : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[0];
      fuAdicionados  : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[1];
      fuAtualizados  : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[2];
      fuDeletados    : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[3];
      fuConflitantes : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[4];
      fuMesclados    : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[5];
      fuRestaurado   : CategoryButtons1.SelectedItem := CategoryButtons1.Categories[0].Items[6];
   end;
end;

end.
