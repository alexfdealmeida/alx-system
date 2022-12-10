(****************************************************************************
 * WANT - A build management tool.                                          *
 * Copyright (c) 2001-2003 Juancarlo Anez, Caracas, Venezuela.              *
 * All rights reserved.                                                     *
 *                                                                          *
 * This library is free software; you can redistribute it and/or            *
 * modify it under the terms of the GNU Lesser General Public               *
 * License as published by the Free Software Foundation; either             *
 * version 2.1 of the License, or (at your option) any later version.       *
 *                                                                          *
 * This library is distributed in the hope that it will be useful,          *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU        *
 * Lesser General Public License for more details.                          *
 *                                                                          *
 * You should have received a copy of the GNU Lesser General Public         *
 * License along with this library; if not, write to the Free Software      *
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA *
 ****************************************************************************)
{
    @brief 

    @author Juancarlo A�ez
    @author Radim Novotny
}
unit MultipleChoiceInputRequest;

interface

uses
  Classes, InputRequest;

type
  TMultipleChoiceInputRequest = class(TInputRequest)
  private
    FChoices: TStrings;
  public
    constructor Create(APrompt: string; AChoices: TStrings);
    destructor  Destroy; override;

    function isInputValid: boolean;  override;

    property Choices: TStrings read FChoices write FChoices;
  end;

implementation

uses
  SysUtils;
{ TMultipleChoiceInputRequest }

constructor TMultipleChoiceInputRequest.Create(APrompt: string;
  AChoices: TStrings);
begin
  if Assigned(AChoices) then if AChoices.Count = 0 then
      raise Exception.Create('choices must not be null');
  FPrompt  := APrompt;
  FChoices := TStringList.Create;
  FChoices.Assign(aChoices);
end;

destructor TMultipleChoiceInputRequest.Destroy;
begin
  FChoices.Free;
  inherited;
end;

function TMultipleChoiceInputRequest.isInputValid: boolean;
var
  i: integer;
begin
  Result := False;
  // fChoices.IndexOf is case insensitive!!!
  for i := 0 to fChoices.Count - 1 do
  begin
    if CompareStr(FInput, FChoices[i]) = 0 then
    begin
      Result := True;
      break;
    end;
  end;
end;

end.
