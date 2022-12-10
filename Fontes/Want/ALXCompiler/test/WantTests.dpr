(*******************************************************************
*  WANT - A build management tool.                                 *
*  Copyright (c) 2001 Juancarlo A�ez, Caracas, Venezuela.          *
*  All rights reserved.                                            *
*                                                                  *
*******************************************************************)

{ $Id: WantTests.dpr,v 1.10 2004/05/28 17:52:27 juanco Exp $ }
program WantTests;

uses
  GUITestRunner,
  TextTestRunner,
  TestFramework,
  RunnerTests,
  WantClassesTest in 'WantClassesTest.pas',
  FileSetTests in 'FileSetTests.pas',
  ExecTasksTest in 'ExecTasksTest.pas',
  FileTasksTest in 'FileTasksTest.pas',
  DelphiTasksTest in 'DelphiTasksTest.pas',
  WildPathsTest in 'WildPathsTest.pas',
  RegexpElementsTest in 'RegexpElementsTest.pas',
  ExternalTests in 'ExternalTests.pas',
  ConsoleScriptRunner in '..\src\win32\ConsoleScriptRunner.pas',
  StyleTasks in '..\src\tasks\StyleTasks.pas',
  MSXMLEngineImpl in '..\src\win32\MSXMLEngineImpl.pas',
  //!!! CVSTasksTests in 'CVSTasksTests.pas',
  XmlPropertyTests in 'XmlPropertyTests.pas',
  FilterElementsTests in 'FilterElementsTests.pas',
  LoadFileTests in 'LoadFileTests.pas',
  TempFileTests in 'TempFileTests.pas';

{$R *.RES}

begin
  {$IFDEF USE_TEXT_RUNNER}
    TextTestRunner.RunRegisteredTests(rxbHaltOnFailures)
  {$ELSE}
    GUITestRunner.RunRegisteredTests;
  {$ENDIF}
end.

