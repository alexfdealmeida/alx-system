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

    @author Juancarlo Añez
}

unit ScriptRunner;

interface

uses
  Windows,
  SysUtils,
  Classes,

  JclFileUtils,

  JALStrings,

  WildPaths,

  WantUtils,
  WantClasses,
  BuildListeners,
  ScriptParser;


type
  TScriptRunner = class
  protected
    FListener    :TBuildListener;
    FListenerCreated :boolean;
    FThreadCount: Integer;

    procedure DoCreateListener;  virtual;
    procedure CreateListener;    virtual;
    procedure SetListener(Value :TBuildListener);

    procedure BuildTarget(Target :TTarget);
    procedure ExecuteTask(Task :TTask; Paralell: Boolean);

    procedure IncThread;
    procedure DecThread;

  public
    constructor Create;
    destructor  Destroy; override;

    procedure LoadProject(Project :TProject; BuildFile: TPath; SearchUp :boolean = false);

    procedure BuildProject(Project :TProject; Target: string = ''; Parallel: Integer = 0);   overload;
    procedure BuildProject(Project :TProject; Targets: TStringArray; Parallel: Integer = 0); overload;

    procedure Build(BuildFile: TPath; Targets :TStringArray; Level :TLogLevel = vlNormal); overload;
    procedure Build(BuildFile: TPath; Target  :string;       Level :TLogLevel = vlNormal); overload;
    procedure Build(BuildFile: TPath; Level   :TLogLevel = vlNormal); overload;

    procedure Log(ScriptElement: TScriptElement; Level: TLogLevel; Msg: string);

    class function DefaultBuildFileName: TPath;
    function FindBuildFile(BuildFile: TPath; SearchUp :boolean = False):TPath; overload;
    function FindBuildFile(SearchUp :boolean= False) :TPath; overload;

    property Listener :TBuildListener read FListener write SetListener;
    property ListenerCreated :boolean read FListenerCreated;
  end;

var
  FSincronizeThreads: TRTLCriticalSection;

implementation



{ TScriptRunner }

constructor TScriptRunner.Create;
begin
  inherited Create;
  DoCreateListener;
  FThreadCount := 0;
end;

destructor TScriptRunner.Destroy;
begin
  if ListenerCreated then
  begin
    FListener.BuildFinished;
    FreeAndNil(FListener);
  end;
  inherited Destroy;
end;

procedure TScriptRunner.LoadProject(Project :TProject; BuildFile: TPath; SearchUp :boolean);
begin
  if not IsLocalPath(BuildFile) then
    BuildFile := ToPath(BuildFile);
  BuildFile := FindBuildFile(BuildFile, SearchUp);

  EnterCriticalSection(FSincronizeThreads);
  try
    TScriptParser.Parse(Project, BuildFile);
    Listener.BuildFileLoaded(Project, WildPaths.ToRelativePath(BuildFile, CurrentDir));
  except
    on e :Exception do
    begin
      Listener.BuildFailed(Project, e.Message);
      raise;
    end;
  end;
  LeaveCriticalSection(FSincronizeThreads);
end;

procedure TScriptRunner.Build( BuildFile: TPath;
                               Targets:    TStringArray;
                               Level:      TLogLevel = vlNormal);
var
  Project :TProject;
begin
  Listener.Level := Level;
  Project := TProject.Create;
  try
    Project.Listener := Listener;
    try
      LoadProject(Project, BuildFile);
      BuildProject(Project, Targets);
    except
      on e :EWantException do
      begin
        Log(Project, vlDebug, e.Message);
        raise;
      end;
      on e :Exception do
      begin
        Log(Project, vlDebug, e.Message);
        Listener.BuildFailed(Project, e.Message);
        raise;
      end;
    end;
  finally
    Project.Free;
  end;
end;


procedure TScriptRunner.DoCreateListener;
begin
  if Listener = nil then
  begin
    CreateListener;
    FListenerCreated := True;
  end;
end;

procedure TScriptRunner.CreateListener;
begin
  FListener := TBasicListener.Create;
end;

procedure TScriptRunner.Build(BuildFile: TPath; Level: TLogLevel);
begin
  Build(BuildFile, nil, Level);
end;

procedure TScriptRunner.Build(BuildFile: TPath; Target: string; Level: TLogLevel);
var
  T :TStringArray;
begin
  SetLength(T, 1);
  T[0] := Target;
  Build(BuildFile, T, Level);
end;


procedure TScriptRunner.BuildProject(Project: TProject; Target: string; Parallel: Integer);
begin
  if Trim(Target) <> '' then
    BuildProject(Project, StringArray(Target), Parallel)
  else
    BuildProject(Project, nil, Parallel);
end;

procedure TScriptRunner.BuildProject(Project: TProject; Targets: TStringArray; Parallel: Integer);
var
  i:       Integer;
  Sched:   TTargetArray;
  LastDir: TPath;
begin
  Sched := nil;
  Listener.ProjectStarted(Project);
  try
    try
      Sched := nil;
      Project.Listener := Listener;

      Project.Configure;
      
      Log(Project, vlDebug, Format('rootdir="%s"',   [Project.RootPath]));
      Log(Project, vlDebug, Format('basedir="%s"',   [Project.BaseDir]));
      Log(Project, vlDebug, Format('basepath="%s"',  [Project.BasePath]));


      if Length(Targets) = 0 then
      begin
        if Project._Default <> '' then
          Targets := StringArray(Project._Default)
        else
          raise ENoDefaultTargetError.Create('No default target');
      end;
    except
      on e :Exception do
      begin
        Log(Project, vlDebug, e.Message);
        if e is ETaskException then
          Listener.BuildFailed(Project)
        else
          Listener.BuildFailed(Project, e.Message);
        raise;
      end;
    end;

    try
      Sched := Project.Schedule(Targets);

      if Length(Sched) = 0 then
        Listener.Log(Project, vlWarnings, 'Nothing to build')
      else
      begin
        LastDir := CurrentDir;
        try
          for i := Low(Sched) to High(Sched) do
          begin
              ChangeDir(Project.BasePath);
              Sched[i].Parallel := Parallel;
              BuildTarget(Sched[i]);
          end;
        finally
          ChangeDir(LastDir);
        end;
      end;
    except
      on e :Exception do
      begin
        Log(Project, vlDebug, e.Message);
        if e is ETaskException then
          Listener.BuildFailed(Project)
        else
          Listener.BuildFailed(Project, e.Message);
        raise;
      end;
    end;
  finally
    Listener.ProjectFinished(Project);
    Project.Listener := nil;
  end;
end;

procedure TScriptRunner.BuildTarget(Target: TTarget);
var
  i :Integer;
  p :Integer;
  LastDir :TPath;
  PathList :TPaths;
begin
  if not Target.Enabled then
    EXIT;

  Listener.TargetStarted(Target);

  Log(Target, vlDebug, Format('basedir="%s"',   [Target.BaseDir]));
  Log(Target, vlDebug, Format('basepath="%s"',  [Target.BasePath]));

  LastDir := CurrentDir;
  try
    Target.Configure(false);
    ChangeDir(Target.BasePath);

    PathList := WildPaths.Wild(Target.ForEach);
    if Length(PathList) = 0 then
    begin
      SetLength(PathList, 1);
      PathList[0] := '';
    end;

    for p := Low(PathList) to High(PathList) do
    begin
      Target.SetProperty(Target._Property, PathList[p], true);
      for i := 0 to Target.TaskCount-1 do
      begin
        repeat
          EnterCriticalSection(FSincronizeThreads);
          try
            if (Target.Parallel = 0) or (FThreadCount < Target.Parallel) then
              Break
          finally
            LeaveCriticalSection(FSincronizeThreads);
          end;
          Sleep(1000);
        until False;
        
        ExecuteTask(Target.Tasks[i], Target.Parallel > 0);
      end;
      Target.SetProperty(Target._Property, '');
    end;

    // wait the threads
    repeat
      EnterCriticalSection(FSincronizeThreads);
      try
        if FThreadCount = 0 then
          Break;
      finally
        LeaveCriticalSection(FSincronizeThreads);
        Sleep(1000);
      end;
    until False;
    
    Listener.TargetFinished(Target);
  finally
    ChangeDir(LastDir)
  end;
end;

type

  TMyThread = class(TThread)
  private
    Listener: TBuildListener;
    Task: TTask;
    ScriptRunner: TScriptRunner;
    Parallel: Boolean;
  protected
    procedure StartTask;
    procedure EndTask;
    procedure Execute; override;
    procedure DoTerminate; override;
  public
    constructor Create(_ScriptRunner: TScriptRunner; _Listener: TBuildListener; _Task: TTask; _Parallel: Boolean);
  end;

{ TMyThread }

procedure TMyThread.StartTask;
begin
  EnterCriticalSection(FSincronizeThreads);

  if not Task.Enabled then
  begin
    Listener.Log(Task, vlVerbose, Format('skipping disabled task <%s>', [Task.TagName]));
    EXIT;
  end;
  Listener.TaskStarted(Task);

  Listener.Log(Task, vlDebug, Format('basedir="%s"',   [Task.BaseDir]));
  Listener.Log(Task, vlDebug, Format('basepath="%s"',  [Task.BasePath]));

  LeaveCriticalSection(FSincronizeThreads);
end;

constructor TMyThread.Create(_ScriptRunner: TScriptRunner; _Listener: TBuildListener; _Task: TTask; _Parallel: Boolean);
begin
  inherited Create(False);
  FreeOnTerminate := Parallel;
  Listener := _Listener;
  Task := _Task;
  Parallel := _Parallel;
  ScriptRunner := _ScriptRunner;
  ScriptRunner.IncThread;
end;

procedure TMyThread.DoTerminate;
begin
  inherited;
  ScriptRunner.DecThread;
end;

procedure TMyThread.EndTask;
begin
  EnterCriticalSection(FSincronizeThreads);
  Listener.TaskFinished(Task);
  LeaveCriticalSection(FSincronizeThreads);
end;

procedure TMyThread.Execute;
begin
  inherited;
  StartTask;
  try
    Task.DoExecute(Parallel);
    EndTask;
  except
    on e: Exception do
    begin
      Listener.Log(Task, vlDebug, 'caught: ' + e.Message);
      if e is EWantException then
      begin
        Listener.TaskFailed(Task, e.Message);
        raise
      end
      else
      begin
        Listener.Log(Task, vlErrors, e.Message);
        Listener.TaskFailed(Task, e.Message);
        raise ETaskError.Create(e.Message);
      end;
    end;
  end;
end;

procedure TScriptRunner.ExecuteTask(Task: TTask; Paralell: Boolean);
var
  Th: TMyThread;
begin

  Th := TMyThread.Create(Self, Listener, Task, Paralell);
  try
    Th.Resume;
    if not Paralell then
      Th.WaitFor;
  finally
    if not Paralell then
      Th.Free;
  end;
end;


procedure TScriptRunner.Log(ScriptElement: TScriptElement; Level: TLogLevel; Msg: string);
begin
  Assert(Listener <> nil);
  Listener.Log(ScriptElement, Level, Msg);
end;

procedure TScriptRunner.SetListener(Value: TBuildListener);
begin
  if FListener <> Value then
  begin
    if FListenerCreated then
    begin
      FListener.Free;
      FListener := nil;
    end;
    FListenerCreated := False;
    FListener := Value;
  end;
end;

procedure TScriptRunner.DecThread;
begin
  EnterCriticalSection(FSincronizeThreads);
  Dec(FThreadCount);
  LeaveCriticalSection(FSincronizeThreads);
end;

class function TScriptRunner.DefaultBuildFileName: TPath;
var
  AppName :string;
begin
  AppName := ExtractFileName(GetModulePath(hInstance));
  Result  := ChangeFileExt(LowerCase(AppName),'.xml');
end;

function TScriptRunner.FindBuildFile(BuildFile: TPath; SearchUp: boolean): TPath;
var
  Dir: TPath;
begin
  if BuildFile = '' then
    Result := FindBuildFile(SearchUp)
  else
  begin
    Log(nil, vlDebug, Format('Finding buildfile %s', [BuildFile]));
    Result := PathConcat(CurrentDir, BuildFile);
    Dir    := SuperPath(Result);

    Log(nil, vlDebug, Format('Looking for "%s in "%s"', [BuildFile, Dir]));
    while not PathIsFile(Result)
    and SearchUp
    and (Dir <> '')
    and (Dir <> SuperPath(Dir))
    do
    begin
      if PathIsDir(Dir) then
      begin
        Result := PathConcat(Dir, BuildFile);
        Dir    := SuperPath(Dir);
        Log(nil, vlDebug, Format('Looking for "%s in "%s"', [BuildFile, Dir]));
      end
      else
        break;
    end;

    if not PathIsFile(Result) then
      Result := BuildFile;
  end;
end;



function TScriptRunner.FindBuildFile(SearchUp: boolean): TPath;
begin
  Result := FindBuildFile(DefaultBuildFileName, SearchUp);
  if not PathIsFile(Result) then
     Result := FindBuildFile(AntBuildFileName, SearchUp);
  if not PathIsFile(Result) then
     Result := DefaultBuildFileName;
end;

procedure TScriptRunner.IncThread;
begin
  EnterCriticalSection(FSincronizeThreads);
  Inc(FThreadCount);
  LeaveCriticalSection(FSincronizeThreads);
end;

initialization
  InitializeCriticalSection(FSincronizeThreads);

finalization
  DeleteCriticalSection(FSincronizeThreads);

end.


