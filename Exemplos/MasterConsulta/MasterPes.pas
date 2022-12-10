unit MasterPes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Master, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, Db, StrUtils,
  DBClient, ComCtrls, Biblio, FMTBcd, Provider, SqlExpr,
  Arquivo, Mask, DBCtrls, JvJCLUtils, JvToolEdit, JvBaseEdits,
  JvEdit, JvDBControls, DBSiagriGrid, Menus, JvExMask, JvExStdCtrls,
  JvValidateEdit;

type
  TCamposPesquisa = record

     Nome : String;
     Tipo : TFieldType;
     Width: Integer;
     Apelido : String;// Este campo é para identificar o apelido da tabela ex: TRANSAC "T.", isto pq existe joins com tabelas
                      // cujo o campo chave é utilizado na clausula where, um exemplo disto é a DefineTransac, lá existe uma
                      // join entre a Tab de CLIENTE C e TRANSAC T pelo campo CODI_TRA e então na clausula WHERE não havia um
                      // identificador de tabela (T.CODI_TRA) e isto causava um erro :
                      // Ambiguous field name between table TRANSAC and table CLIENTE .
  end;

  TCodigoDescricao = record
    Codigo: String;
    Descri: String;
  end;

  TCodigoDescricaoArray = array of TCodigoDescricao;

  TSituacao = (tsAtivo, tsINativo, tsTodos);

  TAfterOpenMasterPes = procedure(DataSet: TDataSet) of object;
  
  TFMasterPes = class(TFMaster)
    cdsPesquisa: TClientDataSet;
    dsPesquisa: TDataSource;
    dspMasterPes: TDataSetProvider;
    sqqPesquisa: TSQLQuery;
    sqqDetalhe: TSQLQuery;
    dspDetalhe: TDataSetProvider;
    cdsDetalhe: TClientDataSet;
    dtsDetalhe: TDataSource;
    pnlPesquisa: TPanel;
    lblCampo: TLabel;
    Label1: TLabel;
    edtString: TEdit;
    btnLocalizar: TBitBtn;
    edtInteger: TJvValidateEdit;
    edtFloat: TJvCalcEdit;
    edtDate: TJvDateEdit;
    rgrOpcoes: TComboBox;
    btnMarcaTodos: TBitBtn;
    dbgPesquisa: TDBSiagriGrid;
    pnlBotoes: TPanel;
    btnFechar: TBitBtn;
    procedure GeraSQL(Tabela, Opcao, Opcao2, Opcao3, Opcao4, Opcao5: String);
    procedure rgrOpcoesClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure DefineParametros(Tabela: String;
                               Retorno: TComponent = nil; Opcao: String = ''; Retorno2: TComponent = nil;
                               Opcao2: String = ''; Opcao3: String = ''; lSituacao: TSituacao = tsTodos;
                               Retorno3 : TComponent = nil; Opcao4: String = ''; Opcao5: String = '');
    procedure IniciarPor(Campo: Integer);
    procedure FormShow(Sender: TObject);
    procedure edtStringKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure SituacaoGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dbgPesquisaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FTabela    : String;
    FOpcao     : String;
    FOpcao2    : String;
    FOpcao3    : String;
    FOpcao4    : String;
    FOpcao5    : String;
    FRetorno   : TComponent;
    FRetorno2  : TComponent;
    FRetorno3  : TComponent;
    FSQL       : String;
    FChave     : String;
    FChave2    : String;
    FChave3    : String;
    TabelaGlob : String;
    TextoPesquisa: String;
    FCampoPesq : array of TCamposPesquisa;
    FWhere     : boolean;
    FSituacao  : TSituacao;
    FMultiSelecao: Boolean;
    FCodigoDescricaoArray: TCodigoDescricaoArray;
    FAfterOpenMasterPes: TAfterOpenMasterPes;
    procedure Carregavetor(Qtde: Integer; Nomes: array of String;
      Tipos: array of TFieldType; Tamanhos: array of Integer; ApelidoTabela : String = '');
    procedure Localizar;
    procedure SetMultiLista(const Value: Boolean);
    procedure SetMultiSelecaoGrid;
    procedure RetornaTodosSelecionados;
    procedure DefineVersao(pOpcao: string = '');
    procedure DefineProduto(pOpcao: string);
  public
    OpcaoQueValidaPermissoesPes : String;
    property ListaSelecionados: TCodigoDescricaoArray read FCodigoDescricaoArray;
    property MultiSelecao: Boolean read FMultiSelecao write SetMultiLista;
    property AfterOpenMasterPes: TAfterOpenMasterPes read FAfterOpenMasterPes write FAfterOpenMasterPes;
    property SQL: string read FSQL;
  end;

var
  FMasterPes: TFMasterPes;
  FlagTitle : Boolean;
  Somente8 : Boolean;

implementation

uses Principal;

{$R *.DFM}

procedure TFMasterPes.SetMultiLista(const Value: Boolean);
begin
  FMultiSelecao := Value;
  SetMultiSelecaoGrid;
end;

procedure TFMasterPes.GeraSQL(Tabela, Opcao, Opcao2, Opcao3, Opcao4, Opcao5: String);
begin
   TabelaGlob  := Tabela;

   if Tabela = 'VERSAO' then
   begin
      DefineVersao(Opcao);
   end
   else if Tabela = 'PRODUTO' then
   begin
      DefineProduto(Opcao);
   end;
end;

procedure TFMasterPes.rgrOpcoesClick(Sender: TObject);
begin
   lblCampo.Caption  := 'Informe: ' + rgrOpcoes.Items.Strings[rgrOpcoes.ItemIndex];
   edtString.Visible := FCampoPesq[rgrOpcoes.ItemIndex].Tipo in [ftString, ftBlob];
   edtDate.Visible := FCampoPesq[rgrOpcoes.ItemIndex].Tipo = ftDate;
   edtInteger.Visible := FCampoPesq[rgrOpcoes.ItemIndex].Tipo = ftInteger;
   edtFloat.Visible := FCampoPesq[rgrOpcoes.ItemIndex].Tipo = ftFloat;
end;

procedure TFMasterPes.btnLocalizarClick(Sender: TObject);
begin
   Localizar;
end;

procedure TFMasterPes.dbgPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

   if Key = VK_RETURN then
   begin
      btnFecharClick(Sender);
   end;
end;

procedure TFMasterPes.btnFecharClick(Sender: TObject);
begin
   inherited;
   if (Not cdsPesquisa.IsEmpty) then
   begin
      if (FRetorno = nil) and (Not MultiSelecao) then
      begin
         SetLength(FCodigoDescricaoArray, 1);
         FCodigoDescricaoArray[0].Codigo := cdsPesquisa.FieldByName(FChave).AsString;
         FCodigoDescricaoArray[0].Descri := cdsPesquisa.FieldByName(FChave2).AsString;
      end;

      if ((FRetorno is TDBEdit          ) and (        TDBEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TJvValidateEdit  ) and (TJvValidateEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TJvDBDateEdit    ) and (  TJvDBDateEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TJvDBCalcEdit    ) and (  TJvDBCalcEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TJvValidateEdit  ) and (TJvValidateEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TMaskEdit        ) and (      TMaskEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TEdit            ) and (          TEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TJvCalcEdit      ) and (    TJvCalcEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TJvValidateEdit  ) and (TJvValidateEdit(FRetorno).ReadOnly)) or
         ((FRetorno is TCustomEdit      ) and (Not TCustomEdit(FRetorno).TabStop )) then
      begin
         ModalResult := mrCancel;
         Exit;
      end;

      if ((FRetorno2 is TDBEdit         ) and (        TDBEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TJvValidateEdit ) and (TJvValidateEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TJvDBDateEdit   ) and (  TJvDBDateEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TJvDBCalcEdit   ) and (  TJvDBCalcEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TJvValidateEdit ) and (TJvValidateEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TMaskEdit       ) and (      TMaskEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TEdit           ) and (          TEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TJvCalcEdit     ) and (    TJvCalcEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TJvValidateEdit ) and (TJvValidateEdit(FRetorno2).ReadOnly)) or
         ((FRetorno2 is TCustomEdit     ) and (Not TCustomEdit(FRetorno2).TabStop )) then
      begin
         ModalResult := mrCancel;
         Exit;
      end;

      if FMultiSelecao then
         RetornaTodosSelecionados
      else
      begin
         if (FRetorno is TDBEdit) then
         begin
            TDBEdit(FRetorno).Field.AsString    := cdsPesquisa.FieldByName(FChave).AsString;
            TDBEdit(FRetorno).Modified          := True;

            if TDBEdit(FRetorno).Visible then
               TDBEdit(FRetorno).SetFocus;
         end  // Quando For Chamado a partir de um Maskedit - Caso do CFOP
         else if (FRetorno is TJvValidateEdit) then
         begin
            TJvValidateEdit(FRetorno).Value     := cdsPesquisa.FieldByName(FChave).AsFloat;
            TJvValidateEdit(FRetorno).Modified  := True;
   
            if TJvValidateEdit(FRetorno).Visible then
               TJvValidateEdit(FRetorno).SetFocus;
         end
         else if (FRetorno) is (TCustomMaskEdit) then
         begin
            TMaskEdit(FRetorno).Text := cdsPesquisa.FieldByName(FChave).AsString;
            TMaskEdit(FRetorno).Modified := True;
            TMaskEdit(FRetorno).SetFocus;
         end
         else if (FRetorno is TJvValidateEdit) then
         begin
            TJvValidateEdit(FRetorno).Value     := cdsPesquisa.FieldByName(FChave).AsInteger;
            TJvValidateEdit(FRetorno).Modified  := True;
            TJvValidateEdit(FRetorno).SetFocus;
         end
         else if (FRetorno is TJvValidateEdit) then
         begin
            TJvValidateEdit(FRetorno).Value     := cdsPesquisa.FieldByName(FChave).AsFloat;
            TJvValidateEdit(FRetorno).Modified  := True;
            TJvValidateEdit(FRetorno).SetFocus;
         end
         else if (FRetorno) is (TCustomEdit) then
         begin
            if (FChave = 'CNPJ') and (Somente8) then
            begin
               TCustomEdit(FRetorno).Text       := Copy(cdsPesquisa.FieldByName(FChave).AsString,1,8);
               TCustomEdit(FRetorno).Modified   := True;
               if TCustomEdit(FRetorno).Visible then
               TCustomEdit(FRetorno).SetFocus;
            end
            else
            begin
               TCustomEdit(FRetorno).Text       := cdsPesquisa.FieldByName(FChave).AsString;
               TCustomEdit(FRetorno).Modified   := True;
               if TCustomEdit(FRetorno).Visible then
                  SetaFoco(TCustomEdit(FRetorno));
            end;
         end
         else if (FRetorno is TField) then
         begin
            TField(FRetorno).Text := cdsPesquisa.FieldByName(FChave).AsString;
            TField(FRetorno).FocusControl;
         end;

         if (FChave2 <> '') and (FRetorno2 <> nil) then
         begin
            if (FRetorno2 is TDBEdit) then
            begin
               TDBEdit(FRetorno2).Field.AsString := cdsPesquisa.FieldByName(FChave2).AsString;
               TDBEdit(FRetorno2).Modified := True;
               TDBEdit(FRetorno2).SetFocus;
            end
            else if FRetorno2 is TJvDateEdit then
            begin
               TJvDateEdit(FRetorno2).Date := cdsPesquisa.FieldByName(FChave2).Value;
               TJvDateEdit(FRetorno2).SetFocus;
            end
            else if (FRetorno2) is (TCustomEdit) then
            begin
               TCustomEdit(FRetorno2).Text := cdsPesquisa.FieldByName(FChave2).AsString;
               TCustomEdit(FRetorno2).Modified := True;

               if TCustomEdit(FRetorno2).Enabled then
                  TCustomEdit(FRetorno2).SetFocus;
            end
            else if (FRetorno2) is (TCustomMaskEdit) then
            begin
               TCustomMaskEdit(FRetorno2).Text := cdsPesquisa.FieldByName(FChave2).AsString;
               TCustomMaskEdit(FRetorno2).Modified := True;
               TCustomMaskEdit(FRetorno2).SetFocus;
            end
            else if FRetorno2 is TField then
            begin
               TField(FRetorno2).Text := cdsPesquisa.FieldByName(FChave2).AsString;
               TField(FRetorno2).FocusControl;
            end;
         end;

         if (FChave3 <> '') and (FRetorno3 <> nil) then
         begin
            if (FRetorno3 is TDBEdit) then
            begin
               TDBEdit(FRetorno3).Field.AsString := cdsPesquisa.FieldByName(FChave3).AsString;
               TDBEdit(FRetorno3).Modified := True;
               SetaFoco(TDBEdit(FRetorno3));
            end
            else if FRetorno3 is TJvDateEdit then
            begin
               TJvDateEdit(FRetorno3).Date := cdsPesquisa.FieldByName(FChave3).Value;
               TJvDateEdit(FRetorno3).SetFocus;
            end
            else if (FRetorno3) is (TCustomEdit) then
            begin
               TCustomEdit(FRetorno3).Text := cdsPesquisa.FieldByName(FChave3).AsString;
               TCustomEdit(FRetorno3).Modified := True;
               TCustomEdit(FRetorno3).SetFocus;
            end
            else if (FRetorno3) is (TCustomMaskEdit) then
            begin
               TCustomMaskEdit(FRetorno3).Text := cdsPesquisa.FieldByName(FChave3).AsString;
               TCustomMaskEdit(FRetorno3).Modified := True;
               TCustomMaskEdit(FRetorno3).SetFocus;
            end
            else if FRetorno3 is TField then
            begin
               TField(FRetorno3).Text := cdsPesquisa.FieldByName(FChave3).AsString;
               TField(FRetorno3).FocusControl;
            end;
         end;
      end;
   end;
   ModalResult := mrOk;
end;

procedure TFMasterPes.IniciarPor(Campo: Integer);
begin
   rgrOpcoes.ItemIndex := Campo;
end;


procedure TFMasterPes.Localizar;
const
   LimiteWidth = 600;
var
   SQL: string;
   Formato: TFormatSettings;
begin
   Formato.DecimalSeparator := '.';

   if ( Pos('WHERE', UpperCase(FSQL)) > 0 ) and( FWhere ) then
   begin
      SQL := FSQL + ' AND '   + FCampoPesq[rgrOpcoes.ItemIndex].Apelido + FCampoPesq[rgrOpcoes.ItemIndex].Nome;
   end
   else
   begin
      SQL := FSQL + ' WHERE ' + FCampoPesq[rgrOpcoes.ItemIndex].Apelido + FCampoPesq[rgrOpcoes.ItemIndex].Nome;
   end;

   case FCampoPesq[rgrOpcoes.ItemIndex].Tipo of
      ftString, ftBlob:
      begin
         if EMPTY(edtString.Text) then
         begin
            Aviso('Informe um valor para a pesquisa.');
            SetaFoco(edtString);
            Exit;
         end
         else
         begin
            SQL := SQL + ' LIKE ' + QuotedStr(edtString.Text + '%');
            if FTabela = 'CTRCOMPRA' then
               SQL := SQL + ')';
         end;
      end;

      ftDate:
      begin
         if EMPTY(edtDate.Text) or (not VDATA(edtDate.Text)) then
         begin
            Aviso('A data informada é inválida. Verifique!');
            SetaFoco(edtDate);
            Exit;
         end else
            SQL := SQL + ' = ' + QuotedStr(FormatDateTime('MM/DD/YYYY', edtDate.Date));
      end;

      ftInteger:
      begin
         if edtInteger.Value = 0 then
         begin
            Aviso('Informe um valor para a pesquisa.');
            SetaFoco(edtInteger);
            Exit;
         end else
            SQL := SQL + ' LIKE ' + QuotedStr(edtInteger.Text + '%');
      end;

      ftFloat:
      begin
         if edtFloat.Value = 0 then
         begin
            Aviso('Informe um valor para a pesquisa.');
            SetaFoco(edtFloat);
            Exit;
         end else
            SQL := SQL + ' = ' + QuotedStr(FormatFloat('0.00', edtFloat.Value, Formato));
      end;
   end;

   with cdsPesquisa do
   begin
      Close;

      if (FCampoPesq[rgrOpcoes.ItemIndex].Tipo = ftBlob) then
         CommandText := SQL + ' ORDER BY cast(' + FCampoPesq[rgrOpcoes.ItemIndex].Apelido + FCampoPesq[rgrOpcoes.ItemIndex].Nome + ' as varchar(100))'
      else
         CommandText := SQL + ' ORDER BY ' + FCampoPesq[rgrOpcoes.ItemIndex].Apelido + FCampoPesq[rgrOpcoes.ItemIndex].Nome;

      cdsPesquisa.CommandText := cdsPesquisa.CommandText;

      if not ABRECDS(cdsPesquisa, TabelaGlob) then
      begin
         Aviso('Erro de Abertura no arquivo de ' + TabelaGlob);
         Abort;
      end
      else
      begin
        if Assigned(FAfterOpenMasterPes) then
        begin
          FAfterOpenMasterPes(cdsPesquisa);
        end;
      end;

      if cdsPesquisa.RecordCount > 0 then
      begin
         SetaFoco(btnLocalizar);
      end;

      btnMarcaTodos.Enabled := btnMarcaTodos.Visible and (cdsPesquisa.RecordCount > 0);
   end;
end;

procedure TFMasterPes.dbgPesquisaDblClick(Sender: TObject);
begin
   inherited;
   if FlagTitle = false then
   begin
      ModalResult := mrOk ;
      btnFecharClick(Sender);
   end;
end;

procedure TFMasterPes.Carregavetor(Qtde: Integer; Nomes: array of String; Tipos: array of TFieldType;
  Tamanhos: array of Integer; ApelidoTabela: String);
var
   i: byte;
begin
   SetLength(FCampoPesq, Qtde);

   for i := Low(FCampoPesq) to High(FCampoPesq) do
   begin
      FCampoPesq[i].Nome    := Nomes[i];
      FCampoPesq[i].Tipo    := Tipos[i];
      FCampoPesq[i].Width   := Tamanhos[i];
      FCampoPesq[i].Apelido := ApelidoTabela;
   end;
end;

procedure TFMasterPes.SetMultiSelecaoGrid();
begin
   if FMultiSelecao then
   begin
      dbgPesquisa.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines,
                              dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit,
                              dgAlwaysShowSelection, dgMultiSelect];

      dbgPesquisa.Hint := '<CTRL> + Clique do mouse seleciona um registro.';
   end
   else
   begin
      dbgPesquisa.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines,
                              dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit,
                              dgAlwaysShowSelection];

      dbgPesquisa.Hint := 'Posicione no registro desejado e pressione o botão fechar';
   end;

   btnMarcaTodos.Visible := FMultiSelecao;
end;

procedure TFMasterPes.FormShow(Sender: TObject);
var
   i: Integer;
begin
   inherited;

   if (edtString.Text <> '') then
   begin
     for i := 0 to High(FCampoPesq) do
       if FCampoPesq[i].Tipo = ftString then
       begin
         rgrOpcoes.ItemIndex := i;
         Break;
       end;
   end;

   if rgrOpcoes.ItemIndex = -1 then
     rgrOpcoes.ItemIndex := 0;

   rgrOpcoesClick(Sender);

   case FCampoPesq[rgrOpcoes.ItemIndex].Tipo of
     ftString, ftBlob:
     begin
       edtString.SetFocus;
       edtString.SelStart := Length(edtString.Text); // Manda o cursor para a última posição
     end;

     ftDate: edtDate.SetFocus;
     ftInteger: edtInteger.SetFocus;
     ftFloat: edtFloat.SetFocus;
   end;

   {Posicionamento do btnLocalizar em cima do edtString}
   if ((edtString.Left + edtString.Width) > btnLocalizar.Left) then
     edtString.Width := btnLocalizar.Left - edtString.Left - 5;
     
end;

procedure TFMasterPes.edtStringKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

  function GetTexto: String;
  begin
     Result := '';
     case FCampoPesq[rgrOpcoes.ItemIndex].Tipo of
       ftString, ftBlob: Result := edtString.Text;
       ftDate:           Result := edtDate.Text;
       ftInteger:        Result := edtInteger.Text;
       ftFloat:          Result := edtDate.Text;
     end;
  end;

var
   TextoAux: String;
begin
   inherited;
   if Key = VK_RETURN then
   begin
      TextoAux := GetTexto;
      if (TextoPesquisa = TextoAux) and (TextoAux <> '') then
         btnFecharClick(Sender)
      else
         TextoPesquisa := TextoAux;

      Localizar;
   end;
   {else
   if Key = VK_UP then
   begin
      if cdsPesquisa.Active then
        cdsPesquisa.Prior;

      if not cdsPesquisa.Active or cdsPesquisa.Bof then
        rgrOpcoes.SetFocus;
   end
   else
   if Key = VK_DOWN then
   begin
      if cdsPesquisa.Active then
        cdsPesquisa.Next;
   end
   else
   if (Key = VK_LEFT) and (ssCtrl in Shift) then
   begin
     dbgPesquisa.SelectedRows.CurrentRowSelected := False;
   end
   else
   if (Key = VK_RIGHT) and (ssCtrl in Shift) then
   begin
     dbgPesquisa.SelectedRows.CurrentRowSelected := True;
   end
   else
   if ((ssCtrl in Shift) and ((Key = VK_END) or (Key = VK_HOME))) or
      (Key = VK_NEXT) or (Key = VK_PRIOR) then
   begin
     dbgPesquisa.Perform(WM_KEYDOWN, Key, 0);
   end;

   if (Key = VK_DOWN) or (Key = VK_UP) then
     Key := 0;}
end;

procedure TFMasterPes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   inherited;
   Action := caFree;
end;

procedure TFMasterPes.dbgPesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
Var
   Retorno : String;
begin
  inherited;
   if Column.Field is TBlobField then
   begin
      dbgPesquisa.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+2, Column.Field.AsString);
   end;
end;

procedure TFMasterPes.FormCreate(Sender: TObject);
begin
  inherited;
   FWhere := True;
   cdsDetalhe.Close;
   FMultiSelecao := False;
   SetLength(FCodigoDescricaoArray, 0);
   FAfterOpenMasterPes := nil;
end;

procedure TFMasterPes.FormDestroy(Sender: TObject);
begin
  SetLength(FCodigoDescricaoArray, 0);
  inherited;
end;

procedure TFMasterPes.SituacaoGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
   if ( Sender.AsString = 'I' ) then
      Text := 'Inativo'
   else
      Text := 'Ativo';
end;

procedure TFMasterPes.dbgPesquisaMouseMove(Sender: TObject;Shift: TShiftState; X, Y: Integer);
var
   pt: TGridcoord;
begin
   inherited;
   pt := dbgPesquisa.MouseCoord(x, y);
   if pt.y = 0 then
      FlagTitle := True
   else
      FlagTitle := False;
end;

procedure TFMasterPes.DefineParametros(Tabela: String; Retorno: TComponent; Opcao: String; Retorno2: TComponent; Opcao2,
  Opcao3: String; lSituacao: TSituacao; Retorno3: TComponent; Opcao4, Opcao5: String);
var
  lOwner: TComponent;
begin
   FTabela   := UpperCase(Tabela);
   FRetorno  := Retorno;
   FRetorno2 := Retorno2;
   FRetorno3 := Retorno3;
   FOpcao    := UpperCase(Opcao);
   FOpcao2   := UpperCase(Opcao2);
   FOpcao3   := UpperCase(Opcao3);
   FOpcao4   := UpperCase(Opcao4);
   FOpcao5   := UpperCase(Opcao5);
   FSituacao := lSituacao;

   FMultiSelecao := False;

   lOwner := nil;
   if (FRetorno <> nil) then
     lOwner := FRetorno.Owner;

   if (lOwner is TForm) then
      MultiSelecao := (TForm(lOwner).FindComponent('lst' + FRetorno.Name) <> nil);

   GeraSQL(FTabela, FOpcao, FOpcao2, FOpcao3, FOpcao4, FOpcao5);
end;

procedure TFMasterPes.DefineVersao(pOpcao: string);
begin
   FSQL := 'select VER.IDVERSAO as "Código", ' +
           '       VER.NOME as "Nome", ' +
           '       VER.DESCRICAO as "Versão", ' +
           '       VER.TIPO as "Tipo", ' +
           '       VER.CONTROLE as "Gerenciador", ' +
           '       VER.INTEGRADA as "Integrada" ' +
           'from VERSAO VER';

   if FSituacao = tsAtivo then
   begin
      FSQL := FSQL + ' where (VER.SITUACAO = ''A'' or VER.SITUACAO is null)';
   end
   else if FSituacao = tsInativo then
   begin
      FSQL := FSQL + ' where VER.SITUACAO = ''I''';
   end;

   rgrOpcoes.Items.Add('Nome');
   rgrOpcoes.Items.Add('Versão');
   rgrOpcoes.Items.Add('Código');
   FChave := 'Código';
   Carregavetor(3, ['VER.NOME', 'VER.DESCRICAO', 'VER.CODI_PES'], [ftString, ftString, ftInteger], [255, 255, 40]);
end;

procedure TFMasterPes.DefineProduto(pOpcao: string);
begin
   FSQL := 'select P.IDPRODUTO as "Código", ' +
           '       P.DESCRICAO as "Descrição" ' +
           'from PRODUTO P';

   if FSituacao = tsAtivo then
   begin
      FSQL := FSQL + ' where (P.SITUACAO = ''A'' or P.SITUACAO is null)';
   end
   else if FSituacao = tsInativo then
   begin
      FSQL := FSQL + ' where P.SITUACAO = ''I''';
   end;

   rgrOpcoes.Items.Add('Descrição');
   rgrOpcoes.Items.Add('Código');
   FChave := 'Código';
   Carregavetor(2, ['P.DESCRICAO', 'P.IDPRODUTO'], [ftString, ftInteger], [255, 40]);
end;

procedure TFMasterPes.RetornaTodosSelecionados;
var
  i: Integer;
  Lista: TStrings;
  ListBox: TListBox;
  lOwner: TComponent;
  lCodiPes: Integer;
begin
   Lista := TStringList.Create;
   try
      lOwner := nil;
      if FRetorno <> nil then
        lOwner := FRetorno.Owner;

      if OpcaoQueValidaPermissoesPes = '' then
         OpcaoQueValidaPermissoesPes := AnsiUpperCase(Copy(TForm(lOwner).Name, 2, Length(TForm(lOwner).Name) -1));

      if (dbgPesquisa.SelectedRows.Count > 0) then
      begin
         with dbgPesquisa.DataSource.DataSet do
         begin
            for i := 0 to dbgPesquisa.SelectedRows.Count-1 do
            begin
               GotoBookmark(pointer(dbgPesquisa.SelectedRows.Items[i]));

               if cdsPesquisa.FindField(rgrOpcoes.Items[0]) <> nil then
               begin
                  if (Lista.IndexOf('[' + cdsPesquisa.FieldByName(FChave).AsString + ']' + ' ' +
                                              cdsPesquisa.FieldByName(rgrOpcoes.Items[0]).AsString) = -1) then
                  begin
                     Lista.Add( '[' + cdsPesquisa.FieldByName(FChave).AsString + ']' + ' ' + cdsPesquisa.FieldByName(rgrOpcoes.Items[0]).AsString  );
                  end;
               end
               else
               begin
                  if (Lista.IndexOf('[' + cdsPesquisa.FieldByName(FChave).AsString + ']') = -1) then
                     Lista.Add( '[' + cdsPesquisa.FieldByName(FChave).AsString + ']');
               end;
            end;
         end;
      end
      else
      begin

         if cdsPesquisa.FindField(rgrOpcoes.Items[0]) <> nil then
         begin
            if (Lista.IndexOf('[' + cdsPesquisa.FieldByName(FChave).AsString + ']' + ' ' +
                                       cdsPesquisa.FieldByName(rgrOpcoes.Items[0]).AsString) = -1) then
            begin
               Lista.Add( '[' + cdsPesquisa.FieldByName(FChave).AsString + ']' + ' ' + cdsPesquisa.FieldByName(rgrOpcoes.Items[0]).AsString  );
            end;
         end
         else
         begin
            if (Lista.IndexOf('[' + cdsPesquisa.FieldByName(FChave).AsString + ']') = -1) then
               Lista.Add( '[' + cdsPesquisa.FieldByName(FChave).AsString + ']');
         end;
      end;

      ListBox := nil;
      if (lOwner is TForm) then
        ListBox := TListBox(TForm(lOwner).FindComponent('lst' + FRetorno.Name));

      if ListBox <> nil then
      begin
         ListBox.Items.AddStrings(Lista);
      end
      else
      begin
         SetLength(FCodigoDescricaoArray, Lista.Count);
         for i := 0 to Lista.Count -1 do
         begin
           FCodigoDescricaoArray[i].Codigo := Copy(Lista[i], 2, Pos(']', Lista[i])-2);
           FCodigoDescricaoArray[i].Descri := Copy(Lista[i], Pos(']', Lista[i])+2, Length(Lista[i]));
         end;
      end;
   finally
     Lista.Free;
   end;
end;

procedure TFMasterPes.btnMarcaTodosClick(Sender: TObject);
var conta : integer;
begin
  inherited;
   if (cdsPesquisa.Active and (cdsPesquisa.RecordCount > 0)) then
   begin
      dbgPesquisa.SelectedRows.Clear;

      cdsPesquisa.First;
      conta := 1;
      while (not cdsPesquisa.Eof) and (conta <= 1499) do
      begin
         dbgPesquisa.SelectedRows.CurrentRowSelected := True;
         cdsPesquisa.Next;
         Inc(conta);
      end;
   end;
end;

procedure TFMasterPes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
