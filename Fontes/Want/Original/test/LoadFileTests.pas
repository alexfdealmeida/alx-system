(*******************************************************************
*  WANT - A build management tool.                                 *
*  Copyright (c) 2001 Juancarlo A�ez, Caracas, Venezuela.          *
*  All rights reserved.                                            *
*                                                                  *
*******************************************************************)

{ $Id: LoadFileTests.pas,v 1.1 2003/04/27 12:18:12 radimnov Exp $ }

{
  Contributors:
    Radim Novotny <radimnov@seznam.cz>
}

unit LoadFileTests;

interface

uses
  TestFramework,
  WantClasses,
  ScriptParser,
  WantClassesTest;

type
  TLoadFileTests = class(TProjectBaseCase)
  published
    procedure LoadFileTest;
  end;

implementation

uses
  SysUtils;

{ TFilterChainsTests }

procedure TLoadFileTests.LoadFileTest;
const
  BUILD_XML = ''
   + #10'<project name="test" default="dotest" >'
   + #10'  <target name="dotest">'
   + #10'    <echo'
   + #10'      message="All these moments will be lost in time, like teardrops in the rain"'
   + #10'      file="tmpfile1.tmp"'
   + #10'    />'
   + #10'    <loadfile property="modifiedmessage" srcfile="tmpfile1.tmp"/>'
   + #10'  </target>'
   + #10'</project>'
   + #10'';
begin
  TScriptParser.ParseText(FProject, BUILD_XML);
  RunProject;
  CheckEquals('All these moments will be lost in time, like teardrops in the rain',
    FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

initialization
  RegisterTests('LoadFile Task', [TLoadFileTests.Suite]);
end.
