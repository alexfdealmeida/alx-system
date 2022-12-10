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
    @brief Console listener implementation

    @author Juancarlo Añez
}
unit ConsoleListener;

interface
uses
  Windows,
  SysUtils,
  Classes,

  JclStrings,
  WildPaths,

  CRT32,
  WantClasses,
  BuildListeners;

const
  rcs_id :string = '#(@)$Id: ConsoleListener.pas,v 1.22 2003/05/14 22:13:46 hippoman Exp $';

  PrefixColorMap :array[TLogLevel] of WORD = (
    CRT32.LightRed,
    CRT32.Magenta,
    CRT32.Green,
    CRT32.Blue,
    CRT32.DarkGray
   );

  MsgColorMap :array[TLogLevel] of WORD = (
    CRT32.Yellow,
    CRT32.LightMagenta,
    CRT32.White,
    CRT32.DarkGray,
    CRT32.LightGray
  );

  DEFAULT_RIGTH_MARGIN = 76;

type
  TConsoleListener = class(TBasicListener)
  protected
    FUseColor     :boolean;
    FRightMargin  :Word;
    FLock         :TRTLCriticalSection;

    FFragments    :TStrings;

    procedure LogPrefix(ScriptElement: TScriptElement; Level :TLogLevel);  virtual;
    procedure LogMessage(ScriptElement: TScriptElement; Msg :string; Level :TLogLevel);  virtual;

    procedure LogLine(ScriptElement: TScriptElement; Msg: string; Level: TLogLevel = vlNormal); override;

    procedure DeleteTaskPrefix(Task :TTask);
  public
    constructor Create;
    destructor  Destroy; override;

    procedure BuildFileLoaded(Project :TProject; FileName :string); override;

    procedure BuildStarted;                        override;
    procedure BuildFinished;                       override;
    procedure BuildFailed(Project :TProject; Msg :string = '');     override;

    procedure ProjectStarted(Project :TProject);   override;
    procedure ProjectFinished(Project :TProject);  override;

    procedure TargetStarted(Target :TTarget);    override;
    procedure TargetFinished(Target: TTarget);   override;

    procedure TaskStarted(Task :TTask);          override;
    procedure TaskFinished(Task :TTask);         override;
    
    procedure TaskFailed(  Task :TTask; Msg :string);  override;

    property UseColor    :boolean read FUseColor    write FUseColor     default True;
    property RightMargin :wORD    read FRightMargin write FRightMargin  default DEFAULT_RIGTH_MARGIN;
  end;

implementation

{ TConsoleListener }

constructor TConsoleListener.Create;
begin
  inherited Create;
  FUseColor := True;
  FRightMargin := DEFAULT_RIGTH_MARGIN;

  FFragments := TStringList.Create;
  InitializeCriticalSection(FLock);
end;



destructor TConsoleListener.Destroy;
begin
  FFragments.Free;
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

procedure TConsoleListener.LogLine(ScriptElement: TScriptElement; Msg: string; Level: TLogLevel);
var
  n         :Integer;
begin
  EnterCriticalSection(FLock);
  Msg:=StringReplace(Msg,#13,'',[rfReplaceAll]);
  if (Length(Msg) = 0) then
    EXIT;

//  Msg := WrapText(Msg, '@@', [' ',#10,#9], RightMargin - Length(FPrefix));
//  if Pos('@@', Msg) = 0 then
    LogMessage(ScriptElement, Msg, Level);
//  else
//  begin
//    FFragments.Clear;
//    JclStrings.StrToStrings(Msg, '@@', FFragments);
//    for n := 0 to FFragments.Count-1 do
//      LogMessage(FPrefix, FFragments[n], Level);
//    FFragments.Clear;
//  end;
  LeaveCriticalSection(FLock);
end;

procedure TConsoleListener.LogMessage(ScriptElement: TScriptElement; Msg :string; Level: TLogLevel);
begin
  LogPrefix(ScriptElement, Level);
  if UseColor then CRT32.TextColor(MsgColorMap[Level]);
  try
    Write(Msg);
    ClrEOL;
    WriteLn;
  finally
    if UseColor then begin
      CRT32.Restore;
      ClrEOL;
    end;
  end;
end;

procedure TConsoleListener.LogPrefix(ScriptElement: TScriptElement; Level: TLogLevel);
var
  Prefix, Suffix: string;
begin
  if UseColor then CRT32.TextColor(PrefixColorMap[Level]);
  try
    Prefix := 'Build';
    Suffix := '';
    if Assigned(ScriptElement) then
    begin
      Prefix := ScriptElement.Project.Name;

      if Assigned(ScriptElement.Parent) then
        Suffix := TScriptElement(ScriptElement.Parent).Name;
    end;

    Write(Format('%-30s', [Format('[%s.%s]', [Prefix, Suffix])]));
    ClrEOL;
  finally
    if UseColor then
    begin
      CRT32.Restore;
      ClrEOL;
    end;
  end;
end;

procedure TConsoleListener.DeleteTaskPrefix(Task: TTask);
{var
  p :Integer;
  S :string;}
begin
{  S := '[' + Task.TagName + ']';
  p := Pos(S, FPrefix);
  if p <> 0 then
    Delete(FPrefix, p, Length(S));
  if Trim(FPrefix) = '' then
    FPrefix := '';}
end;



procedure TConsoleListener.BuildFileLoaded(Project: TProject; FileName: string);
begin
  inherited BuildFileLoaded(Project, FileName);
  Log(Project, vlNormal, 'buildfile: ' + NormalizePath(FileName));
end;

procedure TConsoleListener.ProjectStarted(Project: TProject);
begin
  inherited ProjectStarted(Project);
  Log(Project, vlNormal, Project.Description);
end;

procedure TConsoleListener.ProjectFinished(Project: TProject);
begin
  inherited ProjectFinished(Project);
end;

procedure TConsoleListener.TargetStarted(Target: TTarget);
begin
  inherited TargetStarted(Target);
  Log(Target, vlNormal, Target.Name + ': ' + Target.Description);
end;

procedure TConsoleListener.TargetFinished(Target: TTarget);
begin
  inherited TargetFinished(Target);
  Log(Target, vlNormal);
end;

procedure TConsoleListener.TaskStarted(Task: TTask);
begin
  inherited TaskStarted(Task);
  if Task.Description <> '' then
    Log(Task, vlNormal, Task.Description);
end;

procedure TConsoleListener.TaskFinished(Task: TTask);
begin
  inherited TaskFinished(Task);
  DeleteTaskPrefix(Task);
end;

procedure TConsoleListener.TaskFailed(Task: TTask; Msg: string);
begin
  inherited TaskFailed(Task, Msg);
  //!!! Log(vlErrors, Msg);
  DeleteTaskPrefix(Task);
end;


procedure TConsoleListener.BuildStarted;
begin

end;

procedure TConsoleListener.BuildFinished;
begin
  inherited BuildFinished;
  if Failures or Errors then
    LogMessage(nil, 'BUILD FAILED', vlErrors)
  else
  begin
    Log(nil, vlNormal);
    Log(nil, vlNormal, 'Build complete.');
  end;
end;

procedure TConsoleListener.BuildFailed(Project: TProject; Msg: string);
begin
  inherited BuildFailed(Project, Msg);
  Log(Project, vlErrors, Msg);
end;

end.
