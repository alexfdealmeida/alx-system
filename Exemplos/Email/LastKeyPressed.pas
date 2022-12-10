unit LastKeyPressed;

interface

uses Windows, SysUtils, Messages, Forms, Controls, Mask, MaskUtils, DBGrids,
  DB, DBCtrls, JclStrings, JvBaseEdits, JvToolEdit, JvValidateEdit, JvExStdCtrls, JvEdit,
  JvDbControls, StdCtrls;

type

  // Usado para chamar o F2 no agribusiness quando o pressionamento
  // de tecla for inválido no controle ativo do formulário
  TLastKeyPressed = class
  private
    class function TestInputChar(EditText, EditMask: String; NewChar: Char;
      MaskOffset: Integer): Boolean;
  public
    class procedure VerificaTecla(var Key: Char);
    class procedure ChamaPesquisa(Controle: TWinControl; var Key: Char);
  end;

  // Wrap para acessar máscara protegida
  TMyMaskEdit = class(TCustomMaskEdit)
  public
    property EditMask;
  end;

{$J+}
const
  LastKeyAlphaPressed: Char = #0;
{$J-}

implementation

{ TLastKeyPressed }

class function TLastKeyPressed.TestInputChar(EditText, EditMask: String; NewChar: Char; MaskOffset: Integer): Boolean;
var
  Dir: TMaskDirectives;
  Str: string;
  CType: TMaskCharType;

  function IsKatakana(const Chr: Byte): Boolean;
  begin
    Result := (SysLocale.PriLangID = LANG_JAPANESE) and (Chr in [$A1..$DF]);
  end;

  function TestChar(NewChar: Char): Boolean;
  var
    Offset: Integer;
  begin
    Offset := MaskOffsetToOffset(EditMask, MaskOffset);
    Result := not ((MaskOffset < Length(EditMask)) and
               (UpCase(EditMask[MaskOffset]) = UpCase(EditMask[MaskOffset+1]))) or
               (ByteType(EditText, Offset) = mbTrailByte) or
               (ByteType(EditText, Offset+1) = mbLeadByte);
  end;

begin
  Result := True;
  MaskOffset := OffsetToMaskOffset(EditMask, MaskOffset);
  CType := MaskGetCharType(EditMask, MaskOffset);
  if not (CType in [mcLiteral, mcIntlLiteral]) then
  begin
    Dir := MaskGetCurrentDirectives(EditMask, MaskOffset);
    case EditMask[MaskOffset] of
      mMskNumeric, mMskNumericOpt:
        begin
          if not ((NewChar >= '0') and (NewChar <= '9')) then
            Result := False;
        end;
      mMskNumSymOpt:
        begin
          if not (((NewChar >= '0') and (NewChar <= '9')) or
                 (NewChar = ' ') or(NewChar = '+') or(NewChar = '-')) then
            Result := False;
        end;
      mMskAscii, mMskAsciiOpt:
        begin
          if (NewChar in LeadBytes) and TestChar(NewChar) then
          begin
            Result := False;
            Exit;
          end;
          if IsCharAlpha(NewChar) then
          begin
            Str := ' ';
            Str[1] := NewChar;
            if (mdUpperCase in Dir)  then
              Str := AnsiUpperCase(Str)
            else if mdLowerCase in Dir then
              Str := AnsiLowerCase(Str);
          end;
        end;
      mMskAlpha, mMskAlphaOpt, mMskAlphaNum, mMskAlphaNumOpt:
        begin
          if (NewChar in LeadBytes) then
          begin
            if TestChar(NewChar) then
              Result := False;
            Exit;
          end;
          Str := ' ';
          Str[1] := NewChar;
          if IsKatakana(Byte(NewChar)) then
          begin
              Exit;
          end;
          if not IsCharAlpha(NewChar) then
          begin
            Result := False;
            if ((EditMask[MaskOffset] = mMskAlphaNum) or
                (EditMask[MaskOffset] = mMskAlphaNumOpt)) and
                (IsCharAlphaNumeric(NewChar)) then
              Result := True;
          end
          else if mdUpperCase in Dir then
            Str := AnsiUpperCase(Str)
          else if mdLowerCase in Dir then
            Str := AnsiLowerCase(Str);
        end;
    end;
  end;
end;

{$REGION VerificaTecla}
{-----------------------------------------------------------------------------
  Método:     TLastKeyPressed.VerificaTecla
  Descrição:  <Este método tem a finalidade de chamar o MasterPes automaticamente,
               caso seja digitado um caracter alfanumérico>
  Parâmetros: var Key: Char
  Histórico : <Alex Almeida 03/10/2008 Realizado tratamento para que o MasterPes
                                       não seja chamado automaticamente, quando
                                       a propriedade ReadOnly estiver setada como
                                       "true">
-----------------------------------------------------------------------------}
{$ENDREGION}
class procedure TLastKeyPressed.VerificaTecla(var Key: Char);
var
  Controle: TWinControl;
  Chama: Boolean;
  Field: TField;
begin
  Controle := Screen.ActiveControl;
  if (not (Key in [#32..#255, '%'])) or (Controle = nil) then
    Exit;

  if Controle is TCustomEdit then
  begin
     if TCustomEdit(Controle).ReadOnly then
        Exit;
  end;

  Chama := False;
  
  if Controle is TJvCustomDateEdit then
    Exit
  else
  if Controle is TDBEdit then
  begin

    Field := TDBEdit(Controle).Field;
    if Assigned(Field) then
    begin
      if ((Field is TStringField) and (TStringField(Field).EditMask <> '')) and not (TestInputChar('', TStringField(Field).EditMask, Char(Key), TDBEdit(Controle).SelStart)) then
        Chama := True
      else
      if (not Field.IsValidChar(Char(Key))) then
         Chama := True;

    end;

  end
  else
  if (Controle is TJvValidateEdit) then //TODO: Revisar D2006
  begin

     if not (CharIsDigit(Key) or (Key in [',','.','-'])) then
        Chama := True
  end
  else
  if Controle is TCustomMaskEdit then
  begin

     with TMyMaskEdit(Controle) do
     begin
       if (EditMask <> '') and not TestInputChar('', EditMask, Char(Key), SelStart) then
        Chama := True
     end;
  end
  else
  if Controle is TCustomDBGrid then
  begin

    Field := TCustomDBGrid(Controle).SelectedField;
    if Assigned(Field) then
    begin
      if ((Field is TStringField) and (TStringField(Field).EditMask <> '')) and not (TestInputChar('', TStringField(Field).EditMask, Char(Key), TDBEdit(Controle).SelStart)) then
        Chama := True
      else
      if (not Field.IsValidChar(Char(Key))) then
        Chama := True;
        
    end;
  end;

  if Chama then
     ChamaPesquisa(Controle, Key);
end;

class procedure TLastKeyPressed.ChamaPesquisa(Controle: TWinControl; var Key: Char);
begin
  LastKeyAlphaPressed := Char(Key);
  Controle.Perform(WM_KEYDOWN, VK_F2, 0);
  Controle.Perform(WM_KEYUP, VK_F2, 0);
  Key := #0;
end;

end.
