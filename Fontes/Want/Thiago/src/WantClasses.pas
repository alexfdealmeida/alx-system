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

    @author Juanco A�ez
}

unit WantClasses;

interface
uses
  Windows,
  SysUtils,
  Classes,
  TypInfo,
  INIFiles,
  {$IFDEF VER140}
  Variants,
  {$ENDIF}
  {$IFDEF VER150}
  Variants,
  {$ENDIF}
  {$IFDEF VER180}
  Variants,
  {$ENDIF}

  JCLStrings,

  JALStrings,
  JalPaths,
  JALOwnedTrees,
  JALExpressions,

  WildPaths,
  WantUtils

  {$IFNDEF VER130}
  , DefaultInputHandler,
  InputHandler
  {$ENDIF VER130}
  ;

{$M+} { TURN ON RTTI (RunTime Type Information) }

const
  AntBuildFileName   = 'build.xml';

  SupportedPropertyTypes = [
     tkInteger,
     tkEnumeration,
     tkString,
     tkLString,
     tkWString,
     tkClass];

  LabeledMsgFormat = '%14s %s';

type
  TLogLevel = ( vlErrors,
                vlWarnings,
                vlNormal,
                vlVerbose,
                vlDebug     );

const
  vlVeryQuiet = vlErrors;
  vlQuiet     = vlWarnings;

type
  TScriptElement = class;
  TScriptElementClass = class of TScriptElement;
  TScriptElementClassArray = array of TScriptElementClass;

  TProject       = class;
  TTarget        = class;
  TTask          = class;
  TTaskClass     = class of TTask;

  EWantException   = class(Exception);
  EWantError       = class(EWantException);
  ETargetException  = class(EWantException);


  ENoDefaultTargetError     = class(ETargetException);
  ETargetNotFoundException  = class(ETargetException);
  ECircularTargetDependency = class(ETargetException);


  ETaskException    = class(EWantException);
  ETaskError        = class(ETaskException);
  ETaskFailure      = class(ETaskException);

  TScriptElementArray = array of TScriptElement;

  TTargetArray = array of TTarget;

  TCreateElementMethod = function: TScriptElement of object;

  TBuildListener = class
  protected
    FLevel        :TLogLevel;
  public
    procedure Log(Element: TScriptElement; Level: TLogLevel; Msg: string = '');              virtual; abstract;
    procedure BuildFileLoaded(Project :TProject; FileName :string); virtual; abstract;

    procedure BuildStarted;                                         virtual; abstract;
    procedure BuildFinished;                                        virtual; abstract;

    procedure ProjectStarted(Project :TProject);                    virtual; abstract;
    procedure ProjectFinished(Project :TProject);                   virtual; abstract;
    procedure BuildFailed(Project :TProject; Msg :string = '');     virtual; abstract;

    procedure TargetStarted(Target :TTarget);                       virtual; abstract;
    procedure TargetFinished(Target :TTarget);                      virtual; abstract;

    procedure TaskStarted( Task :TTask);                            virtual; abstract;
    procedure TaskFinished(Task :TTask);                            virtual; abstract;
    procedure TaskFailed(  Task :TTask; Msg :string);               virtual; abstract;

    property Level :TLogLevel read FLevel write FLevel;
  end;


  TScriptElement = class(TTree)
  protected
    FLine   : Integer;
    FColumn : Integer;

    FName   : string;
    FId     : string;      // element Id

    FProperties:  TStrings;
    FAttributes:  TStrings;

    FDescription:   string;

    FIf     :string;
    FUnless :string;
    FBaseDir:string;

    class function SynthesizeTagName(Suffix :string): string; virtual;

    function  GetChild(i :Integer):TScriptElement;

    function  GetBaseDir: TPath;              virtual;
    procedure SetBaseDir(const Value: TPath); virtual;

    procedure SetID(Value: string); virtual;

    function  GetOwner: TScriptElement; reintroduce;
    function  GetProject: TProject;

    function  GetChildrenTyped(AClass: TScriptElementClass = nil):  TScriptElementArray;

    procedure Log(Msg: string = ''; Level: TLogLevel = vlNormal); overload;
    procedure Log(Level: TLogLevel; Msg: string = '');            overload; virtual;
    function  Log(const Format: string; const Args: array of const; Level: TLogLevel = vlNormal): string; overload;
    function  Log(Level: TLogLevel; const Format: string; const Args: array of const): string; overload;

    procedure WantError(Msg: string = ''; Addr :Pointer = nil); virtual;

    procedure RequireAttribute(Name: string);
    procedure RequireAttributes(Names: array of string);
    procedure AttributeRequiredError(AttName: string);

    procedure Init;   virtual;
    procedure Execute(Parallel: Boolean); virtual;

    function GetNoChanges :boolean; virtual;
  public
    constructor Create(Owner: TScriptElement); reintroduce; overload; virtual;
    destructor Destroy; override;

    class function TagName: string; virtual;

    function  Enabled :boolean; virtual;
    procedure SetUp(Name :string; Atts :TStrings); virtual;
    function  SetupChild(ChildName :string; Atts :TStrings):TScriptElement; virtual;
    procedure Configure(recurse :boolean = true); virtual;

    procedure SetProperty(Name, Value: string; overwrite :boolean = false); virtual;
    function  PropertyDefined(Name: string): boolean;    virtual;
    function  PropertyValue(Name: string): string;       virtual;
    function  EnvironmentValue(Name: string): string;    virtual;
    function  ExpressionValue(Expre: string): string;    virtual;
    function  INIValue(Expre: string): string;           virtual;
    function  PathValue(Expre: string): string;          virtual;
    function  Evaluate(Value: string): string;           virtual;

    procedure SetProperties(Value: TStrings);

    function  HasAttribute(Name :string) : boolean;
    function  SetAttribute(Name, Value: string): boolean; virtual;
    function  GetAttribute(Name :string) : string;        virtual;

    function  GetDelphiProperty(Name :string) :Variant;
    function  SetDelphiProperty(PropName, Value :string) :boolean;
    function  HasDelphiProperty(Name :string):boolean;

    // use this to get the fully qualified base path
    function  GetBasePath: TPath; virtual;
    // use this function in Tasks to let the user specify relative
    // directories that work consistently
    function  ToSystemPath(const Path: TPath; const Base: TPath = ''):string; virtual;
    function  ToWantPath(Path: TSystemPath): TPath; virtual;
    function  ToAbsolutePath(const Path: TPath): TPath; virtual;
    function  ToRelativePath(const Path: TPath; const Base: TPath = ''): TPath; virtual;
    procedure AboutToScratchPath(const Path: TPath);

    property  Project: TProject      read GetProject;
    property  Owner :  TScriptElement read GetOwner;

    property Line   :Integer read FLine   write FLine;
    property Column :Integer read FColumn write FColumn;

    property id     :    string   read FId         write SetId;
    property basedir:    TPath    read GetBaseDir  write SetBaseDir;
    property basepath:   TPath    read GetBasePath;
    property Properties: TStrings read FProperties write SetProperties;
    property Attributes: TStrings read FAttributes;
    property Name:       string   read FName       write FName stored True;

    property Children[i :Integer] :TScriptElement read GetChild;

    property NoChanges :boolean read GetNoChanges;
  published
    property Tag :  string        read TagName stored False;
    property Description: string  read FDescription write FDescription;

    property _if    :string read FIf     write FIf;
    property unless :string read FUnless write FUnless;

    property ifdef  :string read FIf     write FIf;
    property ifndef :string read FUnless write FUnless;
  end;



  TProject = class(TScriptElement)
  protected
    FTargets:       TList;
    FDefaultTarget: string;
    FRootPath:      TPath;  // root for all path calculations
    FRootPathSet:   boolean;
	  {$IFNDEF VER130}
    FInputHandler:  IInputHandler;
  	{$ENDIF VER130}

    FListener :TBuildListener;
    FNoChanges: boolean;

    procedure InsertNotification(Child :TTree); override;
    procedure RemoveNotification(Child :TTree); override;

    function  GetTarget(Index: Integer):TTarget;

    procedure SetRootPath(const Path :TPath);

    procedure BuildSchedule(TargetName: string; Seen, Sched: TList);

    function GetNoChanges :boolean; override;
  public
    constructor Create(Owner: TScriptElement = nil); override;
    destructor  Destroy; override;

    class function TagName: string; override;

    function  FindChild(Id: string; ChildClass: TClass = nil): TScriptElement;

    // use this to get the fully qualified base path
    function  GetBasePath: TPath; override;
    procedure SetBaseDir(const Value: TPath); override;
    // use this function in Tasks to let the user specify relative
    // directories that work consistently

    function  AddTarget(Name: string): TTarget;
    function  TargetCount:  Integer;
    function  Schedule(Target :string): TTargetArray; overload;
    function  Schedule(const Targets: TStringDynArray): TTargetArray; overload;

    function  GetTargetByName(Name: string):TTarget;

    procedure LogListener(ScriptElement: TScriptElement; Level: TLogLevel; Msg: string= '');

    property RootPath: TPath read FRootPath write SetRootPath;

    property Targets[i: Integer]: TTarget             read GetTarget; default;
    property TargetNames[TargetName: string]: TTarget read GetTargetByName;

    property Listener :TBuildListener read FListener write FListener;

    property NoChanges :boolean read GetNoChanges write FNoChanges;
	  {$IFNDEF VER130}
    property InputHandler :IInputHandler read FInputHandler write FInputHandler;
  	{$ENDIF VER130}
  published
    function CreateTarget    : TTarget;

    property basedir;

    property Name stored True;
    property _Default:  string read FDefaultTarget  write FDefaultTarget;
  end;



  TTarget = class(TScriptElement)
  protected
    FTasks:   TList;
    FDepends: string;
    FForEach  :string;
    FProperty :string;
    FParallel: integer;

    procedure InsertNotification(Child :TTree); override;
    procedure RemoveNotification(Child :TTree); override;

    function GetTask(Index: Integer):TTask;
  published
  public
    constructor Create(Owner: TScriptElement); override;
    destructor  Destroy; override;

    class function TagName: string; override;

    function TaskCount: Integer;

    property Tasks[i: Integer]: TTask read GetTask; default;
  published
    property Name stored True;
    property Depends: string read FDepends write FDepends;
    property ForEach :string read FForEach write FForEach;
    property _Property :string read FProperty write FProperty;
    property Parallel: integer read FParallel write FParallel; 
  end;



  TTask = class(TScriptElement)
  protected
    procedure TaskFailure(const Msg: string; Addr :Pointer = nil);
    procedure TaskError(Msg: string = ''; Addr :Pointer = nil);
    procedure WantError(Msg: string = ''; Addr :Pointer = nil); override;

    procedure Execute(Parallel: Boolean); override;
  public
    class function TagName: string; override;

    function  Target: TTarget;

    procedure DoExecute(Parallel: Boolean);

    property Name stored False;
  published
  end;

  TCustomAttributeElement = class(TScriptElement)
  protected
    FValueName   :string;
    FStrValue    :string;
    FAttribName  :string;

    function  ValueName :string; virtual;
  public
    constructor Create(Owner :TScriptElement); override;

    procedure Init; override;
    function  SetAttribute(Name, Value :string) :boolean; override;

    property AttribName :string read FAttribName write FAttribName;
  end;

  TAttributeElement = class(TCustomAttributeElement)
  protected
    FValue :string;

    function  GetPath :TPath;
    procedure SetPath(Value :TPath);

  public
    function  SetAttribute(Name, Value :string) :boolean; override;
    procedure Init; override;
  published
    property value :string read FValue  write FValue;
    property path  :TPath  read GetPath write SetPath;
  end;


function  FindTask(Tag: string): TTaskClass;
procedure RegisterTask(TaskClass: TTaskClass);
procedure RegisterTasks(TaskClasses: array of TTaskClass);

function  FindElement(Tag :string; AppliedTo :TClass = nil) :TScriptElementClass;

procedure RegisterElement(ElementClass :TScriptElementClass);                                            overload;
procedure RegisterElement(AppliesTo, ElementClass :TScriptElementClass);                                 overload;
procedure RegisterElements(ElementClasses:array of TScriptElementClass);                                 overload;
procedure RegisterElements(AppliesTo : TScriptElementClass; ElementClasses:array of TScriptElementClass); overload;

function CallerAddr: Pointer;

implementation

type
  TElementRecord = record
    _TagName      :string;
    _ElementClass :TScriptElementClass;
    _AppliesTo    :TScriptElementClass;
  end;

var
  __ElementRegistry :array of TElementRecord;


function  FindElement(Tag :string; AppliedTo :TClass) :TScriptElementClass;
var
  i :Integer;
begin
  Assert(Tag <> '');

  Tag := LowerCase(Tag);
  Result := nil;
  // going from High to Low lets customizer override existing elements
  for i := High(__ElementRegistry) downto Low(__ElementRegistry) do
    with __ElementRegistry[i] do
    begin
      if (_TagName <> Tag) then
        continue;
      if (AppliedTo = nil)
      or (_AppliesTo = nil)
      or (AppliedTo.InheritsFrom(_AppliesTo))
      then
      begin
          Result := _ElementClass;
          Break;
      end;
    end;
end;

procedure RegisterElement(ElementClass :TScriptElementClass);
begin
  RegisterElement(TScriptElementClass(nil), ElementClass);
end;

procedure RegisterElement(AppliesTo, ElementClass :TScriptElementClass); overload;
var
  pos :Integer;
begin
  Assert(ElementClass <> nil);

  pos := Length(__ElementRegistry);
  SetLength(__ElementRegistry, 1 + pos);

  with __ElementRegistry[pos] do
  begin
    _ElementClass := ElementClass;
    _TagName      := ElementClass.TagName;
    _AppliesTo    := AppliesTo;
  end;
end;

procedure RegisterElements(ElementClasses:array of TScriptElementClass);
begin
  RegisterElements(TScriptElementClass(nil), ElementClasses);
end;

procedure RegisterElements(AppliesTo : TScriptElementClass; ElementClasses:array of TScriptElementClass);
var
  i :Integer;
begin
  for i := Low(ElementClasses) to High(ElementClasses) do
    RegisterElement(AppliesTo, ElementClasses[i]);
end;


function FindTask(Tag: string): TTaskClass;
var
  C :TScriptElementClass;
begin
  C := FindElement(Tag, TTarget);
  if (C = nil) or not C.InheritsFrom(TTask) then
    raise EWantError.Create(Format('Task class <%s> not found', [Tag]) )
  else
    Result := TTaskClass(C);
end;


procedure RegisterTask(TaskClass: TTaskClass);
begin
  RegisterElement(TTarget, TaskClass);
end;

procedure RegisterTasks(TaskClasses: array of TTaskClass);
var
  i: Integer;
begin
  for i := Low(TaskClasses) to High(TaskClasses) do
    RegisterTask(TaskClasses[i]);
end;

function IsBadPointer(P: Pointer):boolean; register;
begin
  try
    Result  := (p = nil)
              or ((Pointer(P^) <> P) and (Pointer(P^) = P));
  except
    Result := false
  end
end;


function CallerAddr: Pointer; assembler;
const
  CallerIP = $4;
asm
   mov   eax, ebp
   call  IsBadPointer
   test  eax,eax
   jne   @@Error

   mov   eax, [ebp].CallerIP
   sub   eax, 5   // 5 bytes for call

   push  eax
   call  IsBadPointer
   test  eax,eax
   pop   eax
   je    @@Finish

@@Error:
   xor eax, eax
@@Finish:
end;

{ TScriptElement }

constructor TScriptElement.Create(Owner: TScriptElement);
begin
  inherited Create(Owner);
  FProperties := TStringList.Create;
  FAttributes := TStringList.Create;
end;

destructor TScriptElement.Destroy;
begin
  FreeAndNil(FAttributes);
  FreeAndNil(FProperties);
  inherited Destroy;
end;

function TScriptElement.GetChild(i: Integer): TScriptElement;
begin
  Result := inherited GetChild(i) as TScriptElement;
end;

function TScriptElement.GetOwner: TScriptElement;
begin
  Result := Parent as TScriptElement;
end;

function TScriptElement.GetProject: TProject;
begin
  if self is TProject then
     Result := TProject(self)
  else if Owner = nil then
    Result := nil
  else
    Result := Owner.Project;
end;

class function TScriptElement.SynthesizeTagName(Suffix: string): string;
begin
  Result := ClassName;
  if StrLeft(Result, 1) = 'T' then
    Delete(Result, 1, 1);
  if StrRight(Result, Length(Suffix)) = Suffix then
    Delete(Result, 1 + Length(Result) - Length(Suffix), Length(Suffix));
  Result := LowerCase(Result);
end;

class function TScriptElement.TagName: string;
begin
  Result := SynthesizeTagName('Element');
end;


procedure TScriptElement.Init;
begin
  // do nothing
end;

procedure TScriptElement.Configure(recurse :boolean);
var
  a       :Integer;
  i       :Integer;
  LastDir :TPath;
  Value   :string;
begin
  LastDir := CurrentDir;
  try
    try
      with Attributes do
      begin
        for a := 0 to Count-1 do
        begin
          Value := Evaluate(Values[Names[a]]);
          Log(vlDebug, '>>>>> set attribute %s.%s="%s"', [TagName, Names[a], Value]);
          if not SetDelphiProperty(Names[a], Value) then
             raise Exception.CreateFmt('%s not a property of this element', [Names[a]]);
        end;
      end;

      ChangeDir(BasePath, false);
      self.Init;
    except
      on e :Exception do
         WantError(Format('(%d:%d) could not configure <%s>: %s',
                          [Line, Column, TagName, e.Message]
                          ));
    end;

    if recurse then
    begin
      for i := 0 to ChildCount-1 do
        Children[i].Configure;
    end;
  finally
    ChangeDir(LastDir, False);
  end;
end;

function TScriptElement.Enabled: boolean;
var
  PropName: string;
begin
  Result := true;

  PropName := GetAttribute('if');
  if PropName = '' then
    PropName := GetAttribute('ifdef');
  PropName := Evaluate(PropName);
  if (PropName <> '')
  and not PropertyDefined(PropName) then
  begin
    Log(vlDebug, 'disabling <%s> because "%s" not defined', [TagName, PropName]);
    Result := False
  end
  else
  begin
    PropName := GetAttribute('unless');

    if PropName = '' then
      PropName := GetAttribute('ifndef');
    PropName := Evaluate(PropName);
    if (PropName <> '')
    and PropertyDefined(PropName) then
    begin
      Log(vlDebug, 'skipping <%s> because "%s" defined', [TagName, PropName]);
      Result := False;
    end;
  end
end;

procedure TScriptElement.SetUp(Name: string; Atts: TStrings);
var
  i        :Integer;
begin
  Log(vlDebug, 'SetUp %s', [Name]);

  (*!!!
  if Name <> Self.TagName then
    WantError(Format('XML tag of class <%s> is <%s> but found <%s>',
                      [ClassName, TagName, Name]
                      ));
  *)

  for i := 0 to Atts.Count-1 do
  begin
     if not Self.SetAttribute(Atts.Names[i], Atts.Values[Atts.Names[i]]) then
       WantError(Format('Unknown attribute <%s>.%s', [TagName, Atts.Names[i]]));
  end;
end;

function TScriptElement.HasAttribute(Name: string): boolean;
begin
  Result := (FAttributes.IndexOfName(Name) >= 0)
             or (GetDelphiProperty(Name) <> '')
end;


function TScriptElement.SetAttribute(Name, Value: string): boolean;
begin
  Log(vlDebug, 'attribute %s="%s"', [Name,Value]);
  if Value <> '' then
     FAttributes.Values[Name] := Value
  else
     FAttributes.Add(Name+'=');
  Result := true;
end;


function TScriptElement.GetAttribute(Name: string): string;
begin
  Result := FAttributes.Values[Name];
  if (Result = '') and HasDelphiProperty(Name) then
    Result := GetDelphiProperty(Name);
end;

function TScriptElement.SetupChild(ChildName: string; Atts: TStrings) :TScriptElement;
var
  MethodName: string;
  Method    : TMethod;
  ElemClass : TScriptElementClass;
begin
  Result := nil;
  // conditionals

  Method.Data  := Self;
  MethodName   := 'Create' + ChildName;
  Method.Code  := MethodAddress(MethodName);

  if Method.Code <> nil then
    Result := TCreateElementMethod(Method)()
  else
  begin
    ElemClass := FindElement(ChildName, Self.ClassType);
    if ElemClass <> nil then
      Result := ElemClass.Create(Self)
    else if HasDelphiProperty(ChildName) then
    begin
      Log(vlDebug, 'found attribute-property "%s"', [ChildName]);
      Result := TAttributeElement.Create(Self);
      (Result as TAttributeElement).AttribName := ChildName;
    end
    else
      WantError(Format('Unknown element <%s><%s>', [TagName, ChildName]));
  end;
end;

function TScriptElement.GetBasePath: TPath;
begin
  Result := FBaseDir;
  if Owner <> nil then
    Result := PathConcat(Owner.BasePath, Result);
end;

function TScriptElement.ToAbsolutePath(const Path: TPath): TPath;
begin
  Result := PathConcat(WildPaths.NormalizePath(BasePath), Path);
end;

function TScriptElement.ToRelativePath(const Path: TPath; const Base: TPath): TPath;
begin
  if Base = '' then
    Result := WildPaths.ToRelativePath(Path, Self.BasePath)
  else
    Result := WildPaths.ToRelativePath(Path, Base);
end;

procedure TScriptElement.AboutToScratchPath(const Path: TPath);
begin
  if  PathExists(Path)
  and (Pos(LowerCase(ToAbsolutePath(BasePath)), LowerCase(ToAbsolutePath(Path))) <> 1)
  then
    WantError(Format('Will not scratch %s outside of %s',
                         [ToSystemPath(Path), ToSystemPath(BasePath)]
                         ));
end;

function TScriptElement.GetChildrenTyped(AClass: TScriptElementClass): TScriptElementArray;
var
  List: TList;
  E   : TScriptElement;
  i   : Integer;
begin
  List := TList.Create;
  try
    for i := 0 to ChildCount-1 do
    begin
      E := Children[i];
      if (AClass = nil) or E.InheritsFrom(AClass) then
        List.Add(E);
    end;
    SetLength(Result, List.Count);
    for i := 0 to List.Count-1 do
      Result[i] := List[i];
  finally
    FreeAndNil(List);
  end;
end;

procedure TScriptElement.Log(Msg: string; Level: TLogLevel);
begin
  Log(Level, Msg);
end;

procedure TScriptElement.Log(Level: TLogLevel; Msg: string);
begin
  Project.LogListener(Self, Level, Msg);
end;

function TScriptElement.Log(const Format: string; const Args: array of const; Level: TLogLevel): string;
begin
  Log(SysUtils.Format(Format, Args), Level);
end;

function TScriptElement.Log(Level: TLogLevel; const Format: string; const Args: array of const): string;
begin
  Log(Format, Args, Level);
end;


function TScriptElement.ToWantPath(Path: TSystemPath): TPath;
begin
  Result := WildPaths.ToPath(Path, BasePath);
end;

function TScriptElement.ToSystemPath(const Path: TPath; const Base: TPath): TSystemPath;
begin
  Result := PathConcat(ToAbsolutePath(Base), Path);
  Result := WildPaths.ToSystemPath(Result);
end;

procedure TScriptElement.AttributeRequiredError(AttName: string);
begin
  WantError(Format('%s attribute is required', [AttName]));
end;

procedure TScriptElement.RequireAttribute(Name: string);
var
  AttributeFound :boolean;
  Names          :TStringDynArray;
  i              :Integer;
begin
  AttributeFound := false;
  Names := StringToArray(Name, '|', ttBoth);
  for i := 0 to High(Names) do
  begin
    if HasAttribute(Names[i]) then
    begin
      AttributeFound := true;
      break;
    end;
  end;
  if not AttributeFound then
      AttributeRequiredError(StringReplace(Name, '|', ' or ', [rfReplaceAll]));
end;

procedure TScriptElement.RequireAttributes(Names: array of string);
var
  i :Integer;
begin
  for i := Low(Names) to High(Names) do
    RequireAttribute(Names[i]);
end;

function TScriptElement.GetBaseDir: TPath;
begin
  Result := FBaseDir;
end;

procedure TScriptElement.SetBaseDir(const Value: TPath);
begin
  FBaseDir := Value;
end;

procedure TScriptElement.SetID(Value: string);
begin
  FId := Value;
end;



procedure TScriptElement.SetProperties(Value: TStrings);
begin
  Assert(Value <> nil);
  FProperties.Assign(Value);
end;

procedure TScriptElement.SetProperty(Name, Value: string; overwrite :boolean);
begin
  if Name = '' then
    WantError('property name missing');
  if Value = '' then
    Value := #0;
  if not PropertyDefined(Name) then
    Properties.Values[Name] := Value
  else if overwrite then
  begin
     if Properties.IndexOfName(Name) >= 0 then
        Properties.Values[Name] := Value
     else if Owner <> nil then
        Owner.SetProperty(Name, Value, true);
  end;
end;

function TScriptElement.PropertyDefined(Name: string): boolean;
begin
  Assert(Name <> '');
  Result :=   (Properties.IndexOfName(Name) >= 0) and (Trim(Properties.Values[Name]) <> '')
           or (Owner <> nil) and (Owner.PropertyDefined(Name));
end;

function TScriptElement.PropertyValue(Name: string): string;
begin
  if Name = '' then
    Result := ''
  else if Properties.IndexOfName(Name) >= 0 then
    Result := TrimRight(Properties.Values[Name])
  else if Owner <> nil then
    Result := Owner.PropertyValue(Name)
  else
    Result := '${' + Name + '}'
end;

function TScriptElement.EnvironmentValue(Name: string): string;
begin
  Assert(Name <> '');
  GetEnvironmentVar(Name, Result, True);
  Result := PChar(Result); // so no nulls sneak in
end;

function TScriptElement.ExpressionValue(Expre: string): string;
begin
  try
    Result := FloatToStr(JALExpressions.evaluate(Expre));
  except
    Result := '#error!';
  end;
end;


function TScriptElement.INIValue(Expre: string): string;
  function StrExtractAfter(Pat :string; var Val :string):string;
  var
    i  :Integer;
  begin
    Result := '';
    i      := StrLastPos(Pat, Val);
    if i > 0 then
    begin
      Result := StrRestOf(Val, i+1);
      Delete(Val, i, Length(Val));
    end;
  end;
var
  FileName,
  Section,
  Key,
  Def       :string;
begin
  Def      := StrExtractAfter('|', Expre);
  Key      := StrExtractAfter(':', Expre);
  Section  := StrExtractAfter(':', Expre);
  FileName := ToAbsolutePath(Expre);

  if not PathExists(FileName) or (Section = '') or (Key = '') then
    Result := Def
  else
    with TIniFile.Create(ToSystemPath(FileName)) do
    try
      Result := ReadString(Section, Key, Def);
    finally
      Free;
    end;
end;

function TScriptElement.PathValue(Expre: string): string;
begin
  Result := ToSystemPath(ToPath(Expre));
end;

function TScriptElement.Evaluate(Value: string): string;
type
  TMacroExpansion = function(Name: string): string of object;

  function Expand(MacroStart :Integer; Val: string; MacroExpansion:  TMacroExpansion): string;
  var
    MacroEnd   : Integer;
    Content    : string;
  begin
    Result := Val;
    Result := Copy(Result, 1, MacroStart-1) + Evaluate(Copy(Result, MacroStart+2, Length(Result)));
    MacroEnd := StrSearch('}', Result, macroStart+1);
    if MacroEnd > 0  then
    begin
      Content := Copy(Result, MacroStart, MacroEnd-MacroStart);
      Delete(Result, MacroStart, 1 + Length(Content));
      Insert(MacroExpansion(Content), Result, MacroStart);
    end;
  end;

var
  MacroStart :Integer;
begin
  Result := Value;
  MacroStart := StrSearch('{', Result, 2)-1;
  while MacroStart > 0 do
  begin
    case Result[MacroStart] of
      '%':
          Result := Expand(MacroStart, Result, EnvironmentValue);
      '$':
          Result := Expand(MacroStart, Result, PropertyValue);
      '=':
          Result := Expand(MacroStart, Result, ExpressionValue);
      '?':
          Result := Expand(MacroStart, Result, INIValue);
      '@':
          Result := Expand(MacroStart, Result, PathValue);
    end;
    MacroStart := StrSearch('{', Result, MacroStart+2)-1;
  end;
end;

function TScriptElement.HasDelphiProperty(Name: string): boolean;
begin
  Result := not VarIsNull(GetDelphiProperty(Name));
end;

function TScriptElement.GetDelphiProperty(Name: string): Variant;
var
  TypeInfo :PTypeInfo;
  PropInfo :PPropInfo;
  O        :TObject;
  I        :IUnknown;
  P        :IPath;
begin
  Result := Null;
  TypeInfo := Self.ClassInfo;
  PropInfo := TypInfo.GetPropInfo(Self.ClassInfo, Name);
  if PropINfo = nil then
    PropInfo := GetPropInfo(TypeInfo, '_' + Name);

  if PropInfo <> nil then
  begin
    with PropInfo^, PropType^^ do
    begin
      if IsStoredProp(Self, PropInfo)
      and (SetProc <> nil)
      and (GetProc <> nil)
      and (Kind in SupportedPropertyTypes)
      then
      begin
        if Kind in [tkString, tkLString, tkWString] then
          Result := GetStrProp(Self, PropInfo)
        else if Kind in [tkInteger] then
          Result := IntToStr(GetOrdProp(Self, PropInfo))
        else if Kind in [tkEnumeration] then
          Result := GetEnumName(PropType^, GetOrdProp(Self, PropInfo))
        else if Kind = tkClass then
        begin
          O := Pointer(GetOrdProp(Self, PropInfo));
          if O is TStrings then
            Result := (O as TStrings).CommaText;
        end
        else if Kind = tkInterface then
        begin
          I := IUnknown(GetOrdProp(Self, PropInfo));
          if I.QueryInterface(IPath, P) = 0 then
            Result := P;
        end
        else
        begin
          // do nothing
        end
      end;
    end;
  end;
end;

function TScriptElement.SetDelphiProperty(PropName, Value: string) :boolean;
var
  TypeInfo: PTypeInfo;
  PropInfo: PPropInfo;
  O       : TObject;
  S       : TStrings;
  P       : IPath;
  EnumVal : Integer;
begin
  Result := True;

  TypeInfo := Self.ClassInfo;
  PropInfo := GetPropInfo(TypeInfo, PropName);
  if PropINfo = nil then
    PropInfo := GetPropInfo(TypeInfo, '_' + PropName);
  if PropInfo = nil then
     Result := False
  else if not IsStoredProp(Self, PropInfo) then
    Result := False
  else
  begin
    with PropInfo^, PropType^^ do
    begin
      if Kind in [tkString, tkLString, tkWString] then
      begin
        (*!!!
        if (Name = 'TPath') then
           Value := ToRelativePath(Value);
        *)
        SetStrProp(Self, PropInfo, Value);
      end
      else if Kind in [tkInteger] then
        SetOrdProp(Self, PropInfo, StrToInt(Value))
      else if Kind in [tkEnumeration] then
      begin
        if Name = 'TLogLevel' then
          Value := 'vl' + Value;

        if Name <> 'Boolean' then
        begin
          EnumVal :=GetEnumValue(PropType^, Value);
          if EnumVal < 0 then
            WantError(Format( '"%s" is not a valid value for property "%s"',
                              [Value, PropName]
                              ));
          SetOrdProp(Self, PropInfo, EnumVal)
        end
        else
        begin
          Value := LowerCase(Value);
          if (Value = 'true') or (Value = 'yes') or (Value = 'on') then
            SetOrdProp(Self, PropInfo, GetEnumValue(PropType^, 'true'))
          else
            SetOrdProp(Self, PropInfo, GetEnumValue(PropType^, 'false'));
        end
      end
      else if Kind = tkClass then
      begin
        O := Pointer(GetOrdProp(Self, PropInfo));
        if O is TStrings then
        begin
          S := O as TStrings;
          S.CommaText := Value;
        end
        else
          Result := False;
      end
      else if Kind = tkInterface then
      begin
        P := NewPath('' + Value);
        SetOrdProp(Self, PropInfo, Longint(P));
        P._AddRef;
      end
      else
        Result := False;
    end;
  end;
end;

procedure TScriptElement.WantError(Msg: string; Addr: Pointer);
begin
   if Addr <> nil then
     Addr := CallerAddr;
   raise EWantError.Create(Msg) at Addr
end;

function TScriptElement.GetNoChanges: boolean;
begin
  Result := (Owner <> nil) and Owner.NoChanges;
end;

procedure TScriptElement.Execute(Parallel: Boolean);
begin

end;

{ TProject }

constructor TProject.Create(Owner: TScriptElement);
begin
  inherited Create(Owner);
  FTargets    := TList.Create;

  FRootPath     := CurrentDir;
  FRootPathSet  := False;
  {$IFNDEF VER130}
  FInputHandler := TDefaultInputHandler.Create;
  {$ENDIF VER130}
end;

destructor TProject.Destroy;
begin
  FTargets.Clear;
  inherited Destroy;
  FreeAndNil(FTargets);
end;

function TProject.CreateTarget: TTarget;
begin
  Result := TTarget.Create(self);
end;

function TProject.AddTarget(Name: string): TTarget;
begin
  Result := CreateTarget;
  Result.Name := Name;
end;

function TProject.GetTarget(Index: Integer): TTarget;
begin
  Result := FTargets[Index];
end;

function TProject.TargetCount: Integer;
begin
  Result := FTargets.Count;
end;

function TProject.FindChild(Id: string; ChildClass: TClass): TScriptElement;
var
  E   : TScriptElement;
  i   : Integer;
begin
  Result := nil;
  for i := 0 to ChildCount-1 do
  begin
    E := Children[i];
    if (E.Id = Id) and ((ChildClass = nil) or E.InheritsFrom(ChildClass)) then
    begin
      Result := E;
      break;
    end;
  end;
  if Result = nil then
    WantError(Format('element id="%s" not found', [Id]));
end;

function TProject.GetTargetByName(Name: string): TTarget;
var
  t: Integer;
begin
  Result := nil;
  for t := 0 to FTargets.Count-1 do
  begin
    if TTarget(FTargets[t]).Name = Name then
    begin
      Result := FTargets[t];
      break;
    end;
  end;
  if Result = nil then
    WantError(Format('Target "%s" not found',[Name]));
end;

procedure TProject.LogListener(ScriptElement: TScriptElement; Level: TLogLevel; Msg: string);
begin
  if Listener <> nil then
    Listener.Log(ScriptElement, Level, Msg);
end;

class function TProject.TagName: string;
begin
  Result := 'project';
end;

function TProject.GetBasePath: TPath;
begin
  Result := PathConcat(RootPath, FBaseDir);
end;
procedure TProject.SetBaseDir(const Value: TPath);
begin
  inherited;
  SetProperty('basedir', BasePath, true);
end;


procedure TProject.SetRootPath(const Path: TPath);
begin
  if not FRootPathSet then
  begin
    Project.Log(vlDebug, 'rootpath="%s"', [ RootPath ]);
    FRootPath := Path;
    FRootPathSet := True;
  end;
end;

procedure TTarget.InsertNotification(Child: TTree);
begin
  inherited InsertNotification(Child);
  if Child is TTask then
      FTasks.Add(Child)
end;

procedure TTarget.RemoveNotification(Child: TTree);
begin
  inherited RemoveNotification(Child);
  if Child is TTask then
      FTasks.Remove(Child)
end;


procedure TProject.BuildSchedule(TargetName: string; Seen, Sched: TList);
var
  Target:  TTarget;
  i     :  Integer;
  Deps  :  TStringArray;
begin
  Deps := nil;
  Target := Project.GetTargetByName(TargetName);
  if Sched.IndexOf(Target) >= 0 then
    EXIT; // done
  if not Target.Enabled then
  begin
    Log(Format('Skipping disabled target "%s"', [Target.TagName]), vlVerbose);
    EXIT;
  end;

  if Seen.IndexOf(Target) >= 0 then
    raise ECircularTargetDependency.CreateFmt('circular dependency with target "%s"', [TargetName]);
  Seen.Add(Target);

  Deps := StringToArray(Target.Depends,',', ttBoth);
  for i := Low(Deps) to High(Deps) do
    BuildSchedule(Deps[i], Seen, Sched);

  if Sched.IndexOf(Target) >= 0 then
    raise ECircularTargetDependency.CreateFmt('circular dependency with target "%s"', [TargetName]);
  Sched.Add(Target);
end;

function  TProject.Schedule(Target :string): TTargetArray;
begin
  Result:=Schedule(StringArray(Target));
end;

function TProject.Schedule(const Targets: TStringDynArray): TTargetArray;
var
  Sched,
  Seen   : TList;
  i    : Integer;
begin
  Sched := TList.Create;
  Seen  := TList.Create;
  try
    for i := 0 to High(Targets) do
    begin
      BuildSchedule(Targets[i], Seen, Sched);
    end;
    SetLength(Result, Sched.Count);
    Log(vlDebug, 'schedule:');
    for i := 0 to Sched.Count-1 do
    begin
      Result[i] := Sched[i];
      Log(vlDebug, Result[i].Name);
    end;
  finally
    FreeAndNil(Sched);
    FreeAndNil(Seen);
  end;
end;


function TProject.GetNoChanges: boolean;
begin
  Result := FNoChanges;
end;

{ TTarget }

constructor TTarget.Create(Owner: TScriptElement);
begin
  inherited Create(Owner);
  FTasks   := TList.Create;
  FProperty := 'each';
  FParallel := 0;
end;

destructor TTarget.Destroy;
begin
  FTasks.Clear;
  inherited Destroy;
  FreeAndNil(FTasks);
end;


class function TTarget.TagName: string;
begin
  Result := 'target';
end;

function TTarget.GetTask(Index: Integer): TTask;
begin
  Result := FTasks[Index];
end;

function TTarget.TaskCount: Integer;
begin
  Result := FTasks.Count;
end;


procedure TProject.InsertNotification(Child: TTree);
begin
  inherited InsertNotification(Child);
  if Child is TTarget then
    FTargets.Add(Child)
end;

procedure TProject.RemoveNotification(Child: TTree);
begin
  inherited RemoveNotification(Child);
  if Child is TTarget then
    FTargets.Remove(Child)
end;

{ TTask }

function TTask.Target: TTarget;
begin
  Result := Owner as TTarget;
end;

class function TTask.TagName: string;
begin
  Result := SynthesizeTagName('Task');
end;


procedure TTask.Execute(Parallel: Boolean);
begin
  if Description <> '' then
    Log(Description);
end;

procedure TTask.TaskFailure(const Msg: string; Addr :Pointer);
begin
  Log(vlWarnings, Msg);
  if Addr = nil then
    Addr := CallerAddr;
  raise ETaskFailure.Create(Msg) at Addr
end;

procedure TTask.TaskError(Msg: string; Addr: Pointer);
begin
  Log(vlErrors, Msg);
   if Addr <> nil then
     Addr := CallerAddr;
   raise ETaskError.Create(Msg) at Addr
end;

procedure TTask.WantError(Msg: string; Addr: Pointer);
begin
  //Log(vlErrors, Msg);
  inherited;
end;

procedure TTask.DoExecute(Parallel: Boolean);
var
  LastDir: TPath;
begin
  LastDir := CurrentDir;
  try
    ChangeDir(BasePath);
    Configure;
    Execute(Parallel);
  finally
    ChangeDir(LastDir);
  end;
end;

{ TCustomAttributeElement }

constructor TCustomAttributeElement.Create(Owner: TScriptElement);
begin
  inherited Create(Owner);
  FAttribName := TagName;
  FValueName := 'value';
end;

procedure TCustomAttributeElement.Init;
var
  Val :string;
begin
  inherited Init;
  if Enabled then
  begin
    RequireAttribute(ValueName);

    Val := Evaluate(FStrValue);
    Log(vlDebug, '%s=%s', [Self.AttribName, Val]);
    if not Owner.SetAttribute(Self.AttribName, Val) then
      WantError(Format('Could not set "%s" property to "%s"', [ AttribName, Val]));
  end;
end;

function TCustomAttributeElement.ValueName: string;
begin
  Result := FValueName;
end;

function TCustomAttributeElement.SetAttribute(Name, Value: string) :boolean;
begin
  Result := inherited SetAttribute(Name, Value);
  if Result and (Name = ValueName) then
  begin
    FStrValue := Value;
    Result := (Owner <> nil) and Owner.HasDelphiProperty(Self.AttribName);
  end;
end;


{ TAttributeElement }

function TAttributeElement.GetPath: TPath;
begin
  Result := ToPath(Value);
end;

procedure TAttributeElement.Init;
begin
  inherited;
  Owner.SetDelphiProperty(AttribName, Value);
end;

function TAttributeElement.SetAttribute(Name, Value: string): boolean;
begin
  if Name = 'path' then
    FVAlueName := Name;
  Result := inherited SetAttribute(Name, Value);
end;

procedure TAttributeElement.SetPath(Value: TPath);
begin
  FValue := Value;
end;

initialization
  __ElementRegistry := nil;
finalization
  __ElementRegistry := nil;
end.


