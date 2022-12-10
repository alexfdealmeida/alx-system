{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}
{                                              }
{   \\\                                        }
{  -(j)-                                       }
{    /juanca (R)                               }
{    ~                                         }
{     Copyright (C) 1995,2001 Juancarlo A�ez   }
{     All rights reserved.                     }
{            http://www.suigeneris.org/juanca  }
{%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}

{#(@)$Id: WantTestLib.dpr,v 1.10 2004/05/08 16:15:25 juanco Exp $}

library WantTestLib;

uses
  ShareMem,
  TestFramework,
  Win32Implementations in '..\src\win32\Win32Implementations.pas',
  WantClassesTest in 'WantClassesTest.pas',
  FileSetTests in 'FileSetTests.pas',
  ExecTasksTest in 'ExecTasksTest.pas',
  FileTasksTest in 'FileTasksTest.pas',
  DelphiTasksTest in 'DelphiTasksTest.pas',
  WildPathsTest in 'WildPathsTest.pas',
  {!!! these tests need a better implementation
  CVSTasksTests in 'CVSTasksTests.pas',
  }
  RegexpElementsTest in 'RegexpElementsTest.pas',
  WantStandardTasks in '..\src\tasks\WantStandardTasks.pas',
  StandardTasks in '..\src\tasks\StandardTasks.pas',
  TempFileTests in 'TempFileTests.pas',
  XmlPropertyTests in 'XmlPropertyTests.pas',
  FilterElementsTests in 'FilterElementsTests.pas',
  LoadFileTests in 'LoadFileTests.pas';

{$R *.RES}

exports
  RegisteredTests name 'Test';
end.

