{ Problem: TestRunAndTearDownFails has a leak of some sort. AV occurs outside
  of entire framework at the end of the test. }

{ $Id: UnitTestFramework.pas,v 1.34 2004/04/29 18:52:46 juanco Exp $ }
{: DUnit: An XTreme testing framework for Delphi programs.
   @author  The DUnit Group.
   @version $Revision: 1.34 $
}
(*
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * The Original Code is DUnit.
 *
 * The Initial Developers of the Original Code are Kent Beck, Erich Gamma,
 * and Juancarlo A�ez.
 * Portions created The Initial Developers are Copyright (C) 1999-2000.
 * Portions created by The DUnit Group are Copyright (C) 2000-2003.
 * All rights reserved.
 *
 * Contributor(s):
 * Kent Beck <kentbeck@csi.com>
 * Erich Gamma <Erich_Gamma@oti.com>
 * Juanco A�ez <juanco@users.sourceforge.net>
 * Chris Morris <chrismo@users.sourceforge.net>
 * Jeff Moore <JeffMoore@users.sourceforge.net>
 * Kenneth Semeijn <kennethsem@users.sourceforge.net>
 * The DUnit group at SourceForge <http://dunit.sourceforge.net>
 *
 *)


unit UnitTestFramework;

interface

uses
  {$IFNDEF LINUX}
  {$IFDEF CLR}Borland.Win32.Windows{$ELSE}Windows{$ENDIF},
  {$ENDIF}
  {$IFDEF CLR}Borland.Delphi.SysUtils{$ELSE}SysUtils{$ENDIF},
  TestFramework;

type
  TMonitoredTestCase = class(TTestCase)
  public
    destructor Destroy; override;
    procedure _AddRef;
    procedure _Release;
  end;

	TVerifierTestCase = class(TTestCase)
	protected
		procedure Verify(AResult: TTestResult;
      runCount, failCount, errCount: Integer);
		procedure VerifyError(ATest: ITest; errCount: Integer = 1);
		procedure VerifyFailure(ATest: ITest);
		procedure VerifySuccess(ATest: ITest);
		procedure VerifyLackOfSuccess(ATest: ITest);
	end;

	{ ported from JUnit tests, then refactored a bit }
	TTestTest = class(TVerifierTestCase)
	published
		procedure TestCheck;
    procedure TestCheckEqualsBinHexMessage; // Added KGS
		procedure TestError;
		procedure TestFailure;
		procedure TestRegisterTest;
		procedure TestRunAndTearDownFails;
		procedure TestSetupException;
		procedure TestSuccess;
		procedure TestTearDownAfterError;
		procedure TestTearDownFails;
		procedure TestTearDownSetupFails;
		procedure TestWasNotSuccessful;
		procedure TestWasSuccessful;
		procedure TestWasStopped;
		procedure TestEmptyTestFailure;
		procedure TestBoolToStr;
    procedure TestElapsedTestTime;
  end;

  TTestTestSuite = class(TVerifierTestCase)
  published
    procedure TestSuiteSetupTearDown;
  end;

  { JUnit has no tests for this class }
  TTestTestResult = class(TTestCase)
  published
    procedure TestRun;
    procedure TestElapsedTime;
  end;

  TTestMethodEnumerator = class(TTestCase)
  private
    FMethodEnumerator: TMethodEnumerator;
  published
    procedure TestMethodEnumerator;
  end;

  TTestExceptionChecks = class(TVerifierTestCase)
  protected
    procedure TestIndividualException(Name :string; FailCnt, ErrCnt :Integer);
  published
    procedure TestExpectedException;

    procedure TestChecksAfterException;
    procedure TestDifferentFromExpected;
    procedure TestInheritsFromExpected;
    procedure TestCheckException;
    procedure TestCheckWrongException;
    procedure TestNoExceptionRaised;
    procedure TestCheckAndNoExceptionRaised;
  end;

  TTestStatus = class(TVerifierTestCase)
  published
    procedure testStatus;
  end;

  {: Create our own exception class so users can choose
    to ignore it in the debugger }
  EUnitTestException = class(EAbort)
  end;


implementation

type
// prototype fo CheckEqualsBin/Hex
  TCheckEqualsBinHex = procedure(expected,actual:longword; msg:string = '';
                                    digits:integer=0) of object;

  TRunExceptionCase = class(TMonitoredTestCase)
  published
    procedure Test;
  end;

  TRunExceptionTornDown = class(TRunExceptionCase)
  protected
    procedure TearDown; override;
  public
    TornDown: boolean;
  end;

  TRunAndTearDownException = class(TRunExceptionTornDown)
  protected
    procedure TearDown; override;
  end;

  TRunFalseAssertCase = class(TMonitoredTestCase)
  published
    procedure Test;
  end;

  TSetupException = class(TMonitoredTestCase)
  public
    procedure Setup; override;
  published
    procedure Test;
  end;

  TSetupExceptionTornDown = class(TRunExceptionTornDown)
  public
    procedure Setup; override;
  end;

  TSuccessCase = class(TMonitoredTestCase)
  published
    procedure Test;
  end;

  TTearDownException = class(TSuccessCase)
  protected
    procedure TearDown; override;
  end;

  TTestMethodEnumClass = class(TMonitoredTestCase)
  published
    procedure Method0;
    procedure Method1;
    procedure Method2;
  end;

  TStopTest = class(TMonitoredTestCase)
  private
    procedure DoNothing;
  published
    procedure testOne;
    procedure testTwo;
    procedure doStop;
    procedure notExecutedOne;
    procedure notExecutedTwo;
  end;

  TExpectedTest = class(TMonitoredTestCase)
  protected
    function  RaiseException :Integer;
    procedure RaiseExceptionProc;
    procedure DoNothing;
  published
    procedure testRaised;
    procedure testNotRaised;
    procedure testEnd;
    procedure testStart;
    procedure testChecksAfterException;
    procedure testDifferentFromExpected;
    procedure testInheritsFromExpected;
    procedure testCheckException;
    procedure testCheckWrongException;
    procedure testNoExceptionRaised;
    procedure testCheckAndNoExceptionRaised;
  end;

  TEmptyTest = class(TMonitoredTestCase)
  published
    procedure Test;
  end;

  TTestWithStatusMsgs = class(TMonitoredTestCase)
  published
    procedure Test;
  end;

  TFixtureSuite = class(TTestSuite)
  public
    SetupCalled: boolean;
    TearDownCalled: boolean;

    procedure Setup; override;
    procedure TearDown; override;
  end;

  TMockedTimeCase = class(TTestCase)
  public
    function ElapsedTestTime: Cardinal; override;
  published
    procedure SuccessOne;
    procedure SuccessTwo;    
  end;

  TMockedTimeSuite = class(TTestSuite)
  public
    function ElapsedTestTime: Cardinal; override;
  end;

{ TMonitoredTestCase }

destructor TMonitoredTestCase.Destroy;
begin
  inherited Destroy;
end;

procedure TMonitoredTestCase._AddRef;
begin
  inherited _AddRef;
end;

procedure TMonitoredTestCase._Release;
begin
  inherited _Release;
end;

{ TRunExceptionTornDown }

procedure TRunExceptionTornDown.TearDown;
begin
  TornDown := true;
end;

{ TRunAndTearDownException }

procedure TRunAndTearDownException.TearDown;
begin
  inherited;
  raise EUnitTestException.Create('');
end;

{ TVerifierTestCase }

procedure TVerifierTestCase.Verify(AResult: TTestResult;
  runCount, failCount, errCount: Integer);
begin
  assert(AResult <> nil);
  CheckEquals(runCount,  AResult.runCount,      'wrong RunCount');
  CheckEquals(failCount, AResult.failureCount,  'wrong FailureCount');
  CheckEquals(errCount,  AResult.errorCount,    'wrong ErrorCount');
end;

procedure TVerifierTestCase.VerifyError(ATest: ITest; errCount: Integer);
var
  AResult: TTestResult;
begin
  assert((ATest <> nil) and (errCount >= 1));
  AResult := ATest.run;
  try
    Verify(AResult, 1, 0, errCount);
  finally
    AResult.Free
  end
end;

procedure TVerifierTestCase.VerifyFailure(ATest: ITest);
var
  AResult: TTestResult;
begin
  assert(ATest <> nil);
  // don't let ref counting free the test too early
  AResult := ATest.run;
  try
    Verify(AResult, 1, 1, 0);
  finally
    AResult.Free;
  end
end;

procedure TVerifierTestCase.VerifyLackOfSuccess(ATest: ITest);
var
  AResult: TTestResult;
begin
  assert(ATest <> nil);
  AResult := ATest.run;
  try
    check(AResult.runCount = 1, 'wrong RunCount');
    check((AResult.failureCount + AResult.errorCount) > 0, 'wrong Failures+Errors');
    check(not AResult.wasSuccessful, 'should not have suceeded');
  finally
    AResult.Free;
  end
end;

procedure TVerifierTestCase.VerifySuccess(ATest: ITest);
var
  AResult: TTestResult;
begin
  assert(ATest <> nil);
  AResult := ATest.run;
  try
    Verify(AResult, 1, 0, 0);
    check(AResult.wasSuccessful, 'should have suceeded');
  finally
    AResult.Free;
  end
end;


{ TTestTest }

procedure TTestTest.TestBoolToStr;
begin
	CheckEquals('True', BoolToStr(True), 'BoolToStr(True)');
	CheckEquals('False', BoolToStr(False), 'BoolToStr(False)');
end;



procedure TTestTest.TestCheck;
begin
  Check(true, 'Check');
  CheckEquals(1, 1,                'CheckEquals    Integer');
  CheckNotEquals(1, 2,             'CheckNotEquals Integer');
  CheckEquals(1.0, 1.1, 0.15,      'CheckEquals    Double');
  CheckNotEquals(1.0, 1.16, 0.15,  'CheckNotEquals Double');
  CheckEquals('abc', 'abc',        'CheckEquals    String');
  CheckNotEquals('abc', 'abcd',    'CheckNotEquals String');
  CheckEquals(true, true,          'CheckEquals    Boolean');
  CheckNotEquals(true, false,      'CheckNotEquals Boolean');

  CheckEqualsBin(1, 1,             'CheckEqualsBin  Longword');
  CheckNotEqualsBin(1, 2,          'CheckNotEqualsBin  Longword');
  CheckEqualsHex(1, 1,             'CheckEqualsHex  Longword');
  CheckNotEqualsHex(1, 2,          'CheckNotEqualsHex  Longword');

  CheckNull(TObject(nil),        'CheckNull');
  CheckNotNull(TObject(self),    'CheckNotNull object');
  CheckSame(TObject(self), self, 'CheckSame    object');

  // need the TTestCase(self) cast to work around Delphi typing quirks
  CheckNull(TTEstCase(nil) as ITest,        'CheckNull');
  CheckNotNull(TTestCase(self) as ITest,    'CheckNotNull interface');
  CheckSame(TTestCase(self) as ITest, TTestCase(self) as ITest, 'CheckSame    interface');

  CheckIs(self, TObject, 'self not a TObject');
end;

procedure TTestTest.TestCheckEqualsBinHexMessage;

  function ExpWas(msg, sExp, sAct: string):string;
  begin
    Result:=Format(sExpButWasFmt, [msg, sExp, sAct]);
  end;

  function BothAre(msg, sAct: string):string;
  begin
    Result:=Format(sExpAndActualFmt, [msg, sAct]);
  end;

  procedure CheckFailureMessage(ACheck:TCheckEqualsBinHex; iExp,iAct,dig:longword;
                                msg,ExpectedFailMsg:string);
  begin
    try
      ACheck(iExp,iAct,msg,dig);
      Assert(False,'Expected Failure: '+msg);
    except
      on E:ETestFailure do
      begin
        CheckEquals(ExpectedFailMsg,E.Message);
      end;
    end;
  end;

begin

  // Check the binary string output:
  CheckFailureMessage(CheckEqualsBin,0,1,1,'',ExpWas('','0','1')); // empty msg
  CheckFailureMessage(CheckEqualsBin,0,15,4,'A1',ExpWas('A1, ','0000','1111'));
  CheckFailureMessage(CheckEqualsBin,0,$55AA55AA,32,'B1',
    ExpWas('B1, ','00000000000000000000000000000000',
                  '01010101101010100101010110101010'));
  CheckFailureMessage(CheckNotEqualsBin,3,3,2,'C1',BothAre('C1, ','11'));

  // Check the Hex string output:
  CheckFailureMessage(CheckEqualsHex,0,15,1,'A2',ExpWas('A2, ','0','F'));
  CheckFailureMessage(CheckEqualsHex,0,$55AA55AA,8,'B2',ExpWas('B2, ','00000000','55AA55AA'));
  CheckFailureMessage(CheckNotEqualsHex,999,999,4,'C2',BothAre('C2, ','03E7'));

end;

procedure TTestTest.TestElapsedTestTime;
const
  DELAY = 50;
var
  t, min, max: Cardinal;
begin
  Sleep(DELAY);
  min := (DELAY * 5)  div 10;
  max := (DELAY * 15) div 10;
  t := ElapsedTestTime;
  check((t <= max), Format('Expected elapsed time to be lesser then %d but was %d', [max, t]));
  check((t >= min), Format('Expected elapsed time to be bigger then %d but was %d', [min, t]));
end;

procedure TTestTest.TestEmptyTestFailure;
var
  EmptyTest: TEmptyTest;
begin
  EmptyTest := TEmptyTest.Create('Test');
  VerifyFailure(EmptyTest);
end;

procedure TTestTest.TestError;
var
  ErrorTestCase: TRunExceptionCase;
begin
  ErrorTestCase := TRunExceptionCase.Create('Test');
  VerifyError(ErrorTestCase);
end;

procedure TTestTest.TestFailure;
var
  FailureTestCase: TRunFalseAssertCase;
begin
  FailureTestCase := TRunFalseAssertCase.Create('Test');
  VerifyFailure(FailureTestCase);
end;

procedure TTestTest.TestRegisterTest;
begin
  check(true);
  exit;

  { test needs more work - the below passes, but it's not checking everything }
  { also - test is not rerunnable, because TestFramework.TheSuite needs to
           be torn down. }
  RegisterTest('', TSuccessCase.Suite);
  RegisterTest('Suite', TSuccessCase.Suite);
  RegisterTest('Suite.ChildA', TSuccessCase.Suite);
  RegisterTest('Suite.ChildB', TSuccessCase.Suite);
  check(RegisteredTests.Tests.Count = 2);
  check((RegisteredTests.Tests[0] as ITest).name = 'TSuccessCase');
  check((RegisteredTests.Tests[1] as ITest).name = 'Suite');
end;

procedure TTestTest.TestRunAndTearDownFails;
var
  ATornDown: TRunAndTearDownException;
begin
  ATornDown := TRunAndTearDownException.Create('Test');
  ATornDown._AddRef;
  try
    VerifyError(ATornDown, 2);
    check(ATornDown.TornDown, 'not torn down');
  finally
    ATornDown._Release;
  end
end;

procedure TTestTest.TestSetupException;
var
  ASetupException: TSetupException;
begin
  ASetupException := TSetupException.Create('Test');
  VerifyError(ASetupException);
end;

procedure TTestTest.TestSuccess;
var
  ASuccessCase: TSuccessCase;
begin
  ASuccessCase := TSuccessCase.Create('Test');
  VerifySuccess(ASuccessCase);
end;

procedure TTestTest.TestTearDownAfterError;
var
  ARunExceptionTornDown: TRunExceptionTornDown;
begin
  ARunExceptionTornDown := TRunExceptionTornDown.Create('Test');

  ARunExceptionTornDown._AddRef;
  try
    VerifyError(ARunExceptionTornDown);
    check(ARunExceptionTornDown.TornDown, 'not torn down');
  finally
    ARunExceptionTornDown._Release;
  end;
end;

procedure TTestTest.TestTearDownFails;
var
  ATearDownException: TTearDownException;
begin
  ATearDownException := TTearDownException.Create('Test');
  VerifyError(ATearDownException);
end;

procedure TTestTest.TestTearDownSetupFails;
var
  ASetupExceptionTornDown: TSetupExceptionTornDown;
begin
  ASetupExceptionTornDown := TSetupExceptionTornDown.Create('Test');

  ASetupExceptionTornDown._AddRef;
  try
    VerifyError(ASetupExceptionTornDown);
    check(ASetupExceptionTornDown.TornDown);
  finally
    ASetupExceptionTornDown._Release
  end;
end;

procedure TTestTest.TestWasNotSuccessful;
var
  ARunExceptionCase: TRunExceptionCase;
begin
  ARunExceptionCase := TRunExceptionCase.Create('Test');
  VerifyLackOfSuccess(ARunExceptionCase);
end;

procedure TTestTest.TestWasStopped;
var
  AStopCase :ITest;
  AResult   :TTestResult;
begin
  AStopCase := TStopTest.Suite;
  AResult := AStopCase.run;
  try
    Verify(AResult, 3, 1, 0);
    check(AResult.WasStopped);
  finally
    AResult.Free
  end
end;

procedure TTestTest.TestWasSuccessful;
var
  ASuccessCase: TSuccessCase;
begin
  ASuccessCase := TSuccessCase.Create('Test');
  VerifySuccess(ASuccessCase);
end;

{ TRunExceptionCase }

procedure TRunExceptionCase.Test;
begin
  raise EUnitTestException.Create('');
end;

{ TRunFalseAssertCase }

procedure TRunFalseAssertCase.Test;
begin
  check(false);
end;

{ TSetupException }

procedure TSetupException.Setup;
begin
  raise EUnitTestException.Create('');
end;

procedure TSetupException.Test;
begin
  check(true);
end;

{ TSuccessCase }

procedure TSuccessCase.Test;
begin
  check(true);
end;

{ TTearDownException }

procedure TTearDownException.TearDown;
begin
  raise EUnitTestException.Create('');
end;

{ TSetupExceptionTornDown }

procedure TSetupExceptionTornDown.Setup;
begin
  raise EUnitTestException.Create('');
end;

{ TTestTestResult }

procedure TTestTestResult.TestElapsedTime;
var
  MockTimeSuite: ITest;
  ATestResult: TTestResult;
begin
  MockTimeSuite := TMockedTimeSuite.Create(TMockedTimeCase);
  ATestResult := nil;
  try
    ATestResult := MockTimeSuite.run;
    CheckEquals(3, ATestResult.TotalTime, 'TestResult.TotalTime');
  finally
    ATestResult.Free;
  end;
end;

procedure TTestTestResult.TestRun;
var
  ASuccessCase: ITest;
  ATestResult: TTestResult;
begin
  ASuccessCase := TSuccessCase.Create('Test');
  ATestResult := nil;
  try
    { TTestCase.run calls TTestResult.run. This test checks to ensure an
      AV bug in TTestResult.run is fixed.}
    ATestResult := ASuccessCase.run;
  finally
    ATestResult.Free;
  end;
end;

{ TTestMethodEnumerator }

procedure TTestMethodEnumerator.TestMethodEnumerator;
const
  TotalMethods: integer = 3;
var
  i: integer;
begin
  FMethodEnumerator := TMethodEnumerator.Create(TTestMethodEnumClass);
  try
    check(FMethodEnumerator.MethodCount = TotalMethods);
    for i := 0 to TotalMethods - 1 do
      check(FMethodEnumerator.NameOfMethod[i] = 'Method' + IntToStr(i));
  finally
    FMethodEnumerator.Free;
  end;
end;

{ TTestMethodEnumClass }

procedure TTestMethodEnumClass.Method0;
begin
  // do nothing, just used for TTestMethodEnumerator.TestMethodEnumerator
end;

procedure TTestMethodEnumClass.Method1;
begin
  // do nothing, just used for TTestMethodEnumerator.TestMethodEnumerator
end;

procedure TTestMethodEnumClass.Method2;
begin
  // do nothing, just used for TTestMethodEnumerator.TestMethodEnumerator
end;

{ TStopTest }

procedure TStopTest.DoNothing;
begin
 // Stub so empty tests will not fail
end;

procedure TStopTest.doStop;
begin
  stopTests;
end;

procedure TStopTest.notExecutedOne;
begin
  DoNothing;
end;

procedure TStopTest.notExecutedTwo;
begin
  DoNothing;
end;

procedure TStopTest.testOne;
begin
  DoNothing;
end;

procedure TStopTest.testTwo;
begin
  DoNothing;
end;

{ TExpectedTest }

procedure TExpectedTest.testNotRaised;
begin
  StartExpectingException(EUnitTestException);
  StopExpectingException;
end;

procedure TExpectedTest.testRaised;
begin
  StartExpectingException(EUnitTestException);
  raise EUnitTestException.Create('testStartExpectingException');
end;

procedure TExpectedTest.testStart;
begin
  StopExpectingException;
end;

procedure TExpectedTest.testEnd;
begin
  StartExpectingException(EUnitTestException);
end;


{ TEmptyTest }

{$IFOPT O-}
{$DEFINE UNOPTIMIZED}
{$OPTIMIZATION ON}
{$ENDIF}
procedure TEmptyTest.Test;
begin
// Test left intentionally empty
end;
{$IFDEF UNOPTIMIZED}
{$OPTIMIZATION OFF}
{$ENDIF}

function TExpectedTest.RaiseException: Integer;
begin
  raise EUnitTestException.Create('testing exception');
  Result := 0;
end;

procedure TExpectedTest.RaiseExceptionProc;
begin
  RaiseException;
end;

procedure TExpectedTest.testChecksAfterException;
begin
  StartExpectingException(EUnitTestException);
  CheckEquals(0, RaiseException, 'No error should have been reported');
  CheckEquals(0, RaiseException, 'This code is never reached! No error.');
  CheckEquals(0, 1, 'This code should never be reached!');
end;


procedure TExpectedTest.testDifferentFromExpected;
begin
  StartExpectingException(ERangeError);
  CheckEquals(0, RaiseException, 'No error should have been reported');
end;

procedure TExpectedTest.testInheritsFromExpected;
begin
  StartExpectingException(Exception);
  CheckEquals(0, RaiseException, 'No error should have been reported');
end;

procedure TExpectedTest.testCheckException;
begin
  CheckException(RaiseExceptionProc, EUnitTestException);
end;

procedure TExpectedTest.testCheckWrongException;
begin
  CheckException(RaiseExceptionProc, ERangeError);
end;

procedure TExpectedTest.testNoExceptionRaised;
begin
  StartExpectingException(Exception);
end;

procedure TExpectedTest.DoNothing;
begin
  // nothing
end;

procedure TExpectedTest.testCheckAndNoExceptionRaised;
begin
  CheckException(DoNothing, Exception);
end;

{ TTestExceptionChecks }

procedure TTestExceptionChecks.TestExpectedException;
var
  AExpectedCase :ITest;
  AResult   :TTestResult;
begin
  AExpectedCase := TExpectedTest.Suite;
  AResult := AExpectedCase.run;
  try
    Verify(AResult, AExpectedCase.CountEnabledTestCases, 6, 0);
  finally
    AResult.Free
  end
end;


procedure TTestExceptionChecks.TestIndividualException(Name: string; FailCnt, ErrCnt: Integer);
var
  AExpectedCase :ITest;
  AResult   :TTestResult;
begin
  AExpectedCase := TExpectedTest.Create(Name);
  AResult := AExpectedCase.run;
  try
    Verify(AResult, 1, FailCnt, ErrCnt);
  finally
    AResult.Free
  end;
end;

procedure TTestExceptionChecks.testCheckException;
begin
  TestIndividualException('testCheckException', 0, 0);
end;

procedure TTestExceptionChecks.TestChecksAfterException;
begin
  TestIndividualException('TestChecksAfterException', 0, 0);
end;

procedure TTestExceptionChecks.TestCheckWrongException;
begin
  TestIndividualException('TestCheckWrongException', 1, 0);
end;

procedure TTestExceptionChecks.TestDifferentFromExpected;
begin
  TestIndividualException('TestDifferentFromExpected', 1, 0);
end;

procedure TTestExceptionChecks.TestInheritsFromExpected;
begin
  TestIndividualException('TestInheritsFromExpected', 0, 0);
end;

procedure TTestExceptionChecks.TestNoExceptionRaised;
begin
  TestIndividualException('TestNoExceptionRaised', 1, 0);
end;

procedure TTestExceptionChecks.TestCheckAndNoExceptionRaised;
begin
  TestIndividualException('TestCheckAndNoExceptionRaised', 1, 0);
end;

{ TTestWthStatusMsgs }

procedure TTestWithStatusMsgs.Test;
begin
  Status('Line 1');
  Status('Line 2');
  Status('Line 3');
end;

{ TTestStatus }

procedure TTestStatus.testStatus;
var
  AStatusCase: TTestWithStatusMsgs;
const
{$IFDEF WIN32}
  constLineDelim = #13#10;
{$ENDIF}
{$IFDEF LINUX}
  constLineDelim = #10;
{$ENDIF}
  constStatusTestStr =
      'Line 1' + constLineDelim
      + 'Line 2' + constLineDelim
      + 'Line 3' + constLineDelim;
begin
  AStatusCase := TTestWithStatusMsgs.Create('Test');
  try
    AStatusCase._AddRef;
    VerifySuccess(AStatusCase);

    CheckEquals(AStatusCase.getStatus, constStatusTestStr,
      'Status not correctly validated in test');
  finally
    AStatusCase._Release;
  end;
end;

{ TFixtureSuite }

procedure TFixtureSuite.Setup;
begin
  inherited;
  SetupCalled := true;
end;

procedure TFixtureSuite.TearDown;
begin
  TearDownCalled := true;
  inherited;
end;

{ TTestTestSuite }

procedure TTestTestSuite.TestSuiteSetupTearDown;
var
  AFixtureSuite: TFixtureSuite;
begin
  AFixtureSuite := TFixtureSuite.Create('Fixture Suite');
  AFixtureSuite._AddRef;
  try
    AFixtureSuite.AddTests(TSuccessCase);
    VerifySuccess(AFixtureSuite);
    CheckEquals(true, AFixtureSuite.SetupCalled, 'Suite Setup called');
    CheckEquals(true, AFixtureSuite.TearDownCalled, 'Suite TearDown called');
  finally
    AFixtureSuite._Release;
  end;
end;

{ TMockedTimeCase }

function TMockedTimeCase.ElapsedTestTime: Cardinal;
begin
  Result := 1;
end;

procedure TMockedTimeCase.SuccessOne;
begin
  Check(true);
end;

procedure TMockedTimeCase.SuccessTwo;
begin
  Check(true);
end;

{ TMockedTimeSuite }

function TMockedTimeSuite.ElapsedTestTime: Cardinal;
begin
  Result := 3;
end;

initialization
  RegisterTests('Framework Suites',
                        [ TTestTest.Suite,
                          TTestTestResult.Suite,
                          TTestStatus.Suite,
                          TTestMethodEnumerator.Suite,
                          TTestExceptionChecks.Suite,
                          TTestTestSuite.Suite
                          ]);
end.
