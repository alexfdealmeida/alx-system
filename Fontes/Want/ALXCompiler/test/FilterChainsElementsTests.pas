(*******************************************************************
*  WANT - A build management tool.                                 *
*  Copyright (c) 2001 Juancarlo A�ez, Caracas, Venezuela.          *
*  All rights reserved.                                            *
*                                                                  *
*******************************************************************)

{ $Id: FilterChainsElementsTests.pas,v 1.1 2003/04/27 15:26:58 juanco Exp $ }

unit FilterChainsElementsTests;

interface
uses
  TestFramework,
  WantClasses,
  ScriptParser,
  WantClassesTest,
  RegexpElements;

type
  TFilterChainsTests = class(TProjectBaseCase)
  published
    procedure ExpandPropertiesTest;
    procedure HeadFilterTest;
    procedure LineContainsTest;
    procedure LineContainsRegexpTest;
    procedure PrefixLinesTest;
    procedure ReplaceTokensTest;
    procedure StripLineBreaks;
    procedure StripLineComments;
    procedure TabsToSpaces;
    procedure TailFilterTest;
  end;


implementation

uses
    SysUtils;

const
     SCRIPT_START = ''
  +#10'<project name="test" default="dotest" >'
  +#10'  <target name="dotest">'
  +#10'    <echo'
  +#10'      file="tmpfile1.tmp">'
  +#10'    first'
  +#10'    second'
  +#10'    third'
  +#10'    </echo>'
  +#10'    <loadfile property="modifiedmessage" srcfile="tmpfile1.tmp">'
  +#10'      <filterchain>';

     SCRIPT_END = ''
  +#10'      </filterchain>'
  +#10'    </loadfile>'
  +#10'  </target>'
  +#10'</project>'
  +'';

{ TRegexpTests }

procedure TFilterChainsTests.ExpandPropertiesTest;
const
  build_xml = ''
  +#10'<project name="test" default="dotest" >'
  +#10'  <target name="dotest">'
  +#10'    <echo'
  +#10'      message="All these moments will be lost in time, like teardrops in the ${weather}"'
  +#10'      file="tmpfile1.tmp"'
  +#10'    />'
  +#10'    <property name="weather" value="rain"/>'
  +#10'    <loadfile property="modifiedmessage" srcfile="tmpfile1.tmp">'
  +#10'      <filterchain>'
  +#10'        <expandproperties/>'
  +#10'      </filterchain>'
  +#10'    </loadfile>'
  +#10'  </target>'
  +#10'</project>'
  +'';
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('All these moments will be lost in time, like teardrops in the rain', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.HeadFilterTest;
const
  build_xml = SCRIPT_START
  +#10'        <headfilter lines="1"/>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('first', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.LineContainsRegexpTest;
const
  build_xml = SCRIPT_START
  +#10'        <linecontainsregexp regexp="rd$"/>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('third', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.LineContainsTest;
const
  build_xml = SCRIPT_START
  +#10'        <linecontains>'
  +#10'          <contains value="rst"/>'
  +#10'          <contains value="rd"/>'
  +#10'        </linecontains>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('first'#13#10'third', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.PrefixLinesTest;
const
  build_xml = SCRIPT_START
  +#10'        <prefixlines prefix="The "/>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('The first'#13#10'The second'#13#10'The third', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.ReplaceTokensTest;
const
  build_xml = ''
  +#10'<project name="test" default="dotest" >'
  +#10'  <target name="dotest">'
  +#10'    <echo'
  +#10'      message="All these %WORD$ will be lost in time, like teardrops in the rain"'
  +#10'      file="tmpfile1.tmp"'
  +#10'    />'
  +#10'    <property name="word.property" value="moments"/>'
  +#10'    <loadfile property="modifiedmessage" srcfile="tmpfile1.tmp">'
  +#10'      <filterchain>'
  +#10'        <replacetokens begintoken="%" endtoken="$" token="WORD" value="${word.property}"/>'
  +#10'      </filterchain>'
  +#10'    </loadfile>'
  +#10'  </target>'
  +#10'</project>'
  +'';
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('All these moments will be lost in time, like teardrops in the rain', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.StripLineBreaks;
const
  build_xml = SCRIPT_START
  +#10'        <striplinebreaks/>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('firstsecondthird', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.StripLineComments;
const
  build_xml = SCRIPT_START
  +#10'        <striplinecomments comment="s"/>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  // Word "second" is treated as comment
  CheckEquals('first'#13#10'third', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.TabsToSpaces;
const
  build_xml = ''
  +#10'<project name="test" default="dotest" >'
  +#10'  <target name="dotest">'
  +#10'    <echo'
  +#10'      message="There'#9'are'#9'tabs"'
  +#10'      file="tmpfile1.tmp"'
  +#10'    />'
  +#10'    <loadfile property="modifiedmessage" srcfile="tmpfile1.tmp">'
  +#10'      <filterchain>'
  +#10'        <tabstospaces tablength="3"/>'
  +#10'      </filterchain>'
  +#10'    </loadfile>'
  +#10'  </target>'
  +#10'</project>'
  +'';
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('There   are   tabs', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

procedure TFilterChainsTests.TailFilterTest;
const
  build_xml = SCRIPT_START
  +#10'        <tailfilter lines="2"/>'
  +SCRIPT_END;
begin
  TScriptParser.ParseText(FProject, build_xml);
  RunProject;
  CheckEquals('second'#13#10'third', FProject.Targets[0].PropertyValue('modifiedmessage'));
  DeleteFile('tmpfile1.tmp');
end;

initialization
  RegisterTests('Filter Chains', [TFilterChainsTests.Suite]);
end.
