{ #(@)$Id: UnitTestGUITesting.pas,v 1.46 2003/06/01 20:38:53 neuromancer Exp $ }
{: DUnit: An XTreme testing framework for Delphi programs.
   @author  The DUnit Group.
   @version $Revision: 1.46 $ uberto 08/03/2001
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
 * The Initial Developers of the Original Code are Serge Beaumont
 * and Juancarlo Añez.
 * Portions created The Initial Developers are Copyright (C) 1999-2000.
 * Portions created by The DUnit Group are Copyright (C) 2000-2003.
 * All rights reserved.
 *
 * Contributor(s):
 * Serge Beaumont <beaumose@iquip.nl>
 * Juanco Añez <juanco@users.sourceforge.net>
 * Uberto Barbini <uberto@usa.net>
 * Kris Golko <neuromancer@users.sourceforge.net>
 * Kenneth Semeijn <kennethsem@users.sourceforge.net>
 * Jon Bertrand <jonbsfnet@users.sourceforge.net>
 * The DUnit group at SourceForge <http://dunit.sourceforge.net>
 *
 *)

{$IFDEF LINUX}
{$DEFINE DUNIT_CLX}
{$ENDIF}

unit UnitTestGUITesting;

interface
uses
  TestFramework,
  TestExtensions,
  GUITesting,
{$IFDEF DUNIT_CLX}
  Qt, QGraphics, QForms, QMenus, QStdCtrls, QControls,
  QGUITestRunner,
{$ELSE}
  Windows, Messages, Graphics, Forms, Menus, StdCtrls, Controls,
  GUITestRunner,
{$ENDIF}
  SysUtils,
  Classes {Variants,};

const
  rcs_id: string = '#(@)$Id: UnitTestGUITesting.pas,v 1.46 2003/06/01 20:38:53 neuromancer Exp $';

type
  TDunitDialogCracker = class(TGUITestRunner);

  { This form is used to test some of the methods in TGUITestCase }
  TTestForm = class(TForm)
    xButton: TButton;
    xEdit: TEdit;
    xMemo: TMemo;
    MainMenu1: TMainMenu;
    est11: TMenuItem;
    xAltBackspace: TMenuItem;
    xCtrlA: TMenuItem;
    F21: TMenuItem;
    xButton2: TButton;
    xButton3: TButton;
    procedure xButtonClick(Sender: TObject);
    procedure xEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure xEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure xAltBackspaceClick(Sender: TObject);
    procedure xCtrlAClick(Sender: TObject);
    procedure F8Click(Sender: TObject);
  public
    ButtonClickCount, EditKeyDownCount, EditKeyUpCount,
    FormKeyDownCount, FormKeyUpCount : integer;
    AltBackspaceCount, ControlACount, Function8Count : integer;
    FormKeys : string;
    procedure ResetForm;
  end;

  T_TGUITestCase = class(TGUITestCase)
  protected
    mForm : TTestForm;

    procedure SetUp; override;
  public
    procedure TearDown; override;
  published
    procedure Test_IsFocused;
    procedure Test_Sleep;
    procedure Test_EnterKeyInto;
    procedure Test_EnterKey;
    procedure Test_EnterTextInto;
    procedure Test_Tab;
  end;

  TGUITestRunnerTests = class(TGUITestCase)
    FRunner :TGUITestRunner;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    {$IFDEF LINUX}
    procedure TestStatus;
    {$ENDIF}
  published
    procedure TestTabOrder;
    procedure TestViewResult;
    procedure TestElapsedTime;
    procedure RunEmptySuite;
    procedure RunSuccessSuite;
    procedure RunFailureSuite;
    {$IFDEF WIN32}
    procedure TestStatus;
    {$ENDIF}
    procedure TestRunSelectedTestWithDecorator;
    procedure TestRunSelectedTestWithSetupDecorator;
    {$IFNDEF DUNIT_CLX}
    procedure TestGoToPrevNextSelectedNode;
    {$ENDIF}
  end;

implementation

{$R *.dfm}

type
  TSuccessTestCase = class(TTestCase)
  published
    procedure OneSuccess;
    procedure SecondSuccess;
  end;

  TFailuresTestCase = class(TTestCase)
  private
    procedure DoNothing;
  published
    procedure OneSuccess;
    procedure OneFailure;
    procedure SecondFailure;
    procedure OneError;
  end;

  TTimeTestCase = class(TTestCase)
  published
    procedure TestTime;
  end;

  TStatusTestCase = class(TTestCase)
  published
    procedure OneSuccessWithStatus;
    procedure SecondSuccessWithStatus;
  end;

  TSetupTestCase = class(TTestSetup)
  protected
    FSetupCount : integer;
    FTeardownCount : integer;
    procedure SetUp; override;
    procedure TearDown; override;
  public
    procedure AfterConstruction; override;
  end;

{ TTestForm }

procedure TTestForm.ResetForm;
begin
  ButtonClickCount := 0;
  EditKeyDownCount := 0;
  EditKeyUpCount := 0;
  FormKeyDownCount := 0;
  FormKeyUpCount := 0;
  AltBackspaceCount := 0;
  ControlACount := 0;
  Function8Count := 0;
  xEdit.Text := '';
  FormKeys := '';
end;

procedure TTestForm.FormCreate(Sender: TObject);
begin
  ResetForm;
end;

procedure TTestForm.xButtonClick(Sender: TObject);
begin
  inc(ButtonClickCount);
end;

procedure TTestForm.xEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inc(EditKeyDownCount);
end;

procedure TTestForm.xEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inc(EditKeyUpCount);
end;

procedure TTestForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inc(FormKeyDownCount);
  Assert(FormKeyDownCount > EditKeyDownCount);
end;

procedure TTestForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  FormKeys := FormKeys + Key;
end;

procedure TTestForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inc(FormKeyUpCount);
  Assert(FormKeyUpCount > EditKeyUpCount);
end;

procedure TTestForm.xAltBackspaceClick(Sender: TObject);
begin
  inc(AltBackSpaceCount);
end;

procedure TTestForm.xCtrlAClick(Sender: TObject);
begin
  inc(ControlACount);
end;

procedure TTestForm.F8Click(Sender: TObject);
begin
  inc(Function8Count);
end;

{ T_TGUITestCase }

procedure T_TGUITestCase.SetUp;
begin
  inherited;
  mForm := TTestForm.Create(nil);
  ActionDelay := 10;
  mForm.Show;
  Application.ProcessMessages;
end;

procedure T_TGUITestCase.TearDown;
begin
  mForm.Release;
  Application.ProcessMessages;
  inherited;
end;

procedure T_TGUITestCase.Test_IsFocused;
begin
  SetFocus(mForm.xButton);
  Assert(not IsFocused(mForm.xButton2));
  Assert(IsFocused(mForm.xButton));
end;

procedure T_TGUITestCase.Test_Sleep;
var before, after, diff : TDateTime;
begin
  before := Now;
  Sleep(250);
  after := Now;
  Assert(after > before);
  diff := after - before;
  Assert(diff > 2.0e-6);

  { Sleep is done in EnterKeyInto }
  ActionDelay := 125;
  before := Now;
  EnterKeyInto(mForm, ord('A'), []);
  after := Now;
  Assert(after > before);
  diff := after - before;
  Assert(diff > 2.0e-6);
end;

procedure T_TGUITestCase.Test_EnterKeyInto;
const VK_A = ord('A');
begin
  SetFocus(mForm.xButton);
  { Make sure:
     focus shifts to the correct control
     form key preview works
     control gets the proper key(s)
     works for TEdit, TButton, TMemo
  }

  { Keys pressed: A }
  EnterKeyInto(mForm.xEdit, VK_A, []);
  Assert(mForm.xEdit.Text = 'a');
  Assert(mForm.EditKeyDownCount = 1);
  Assert(mForm.EditKeyUpCount = 1);
  Assert(mForm.FormKeyDownCount = 1);
  Assert(mForm.FormKeyUpCount = 1);
  Assert(mForm.FormKeys = 'a');

  { Keys pressed:  Shift, A }
  mForm.ResetForm;
  EnterKeyInto(mForm.xEdit, VK_A, [ssShift]);
  Assert(mForm.xEdit.Text = 'A');
  Assert(mForm.EditKeyDownCount = 1);
  Assert(mForm.EditKeyUpCount = 1);
  Assert(mForm.FormKeyDownCount = 1);
  Assert(mForm.FormKeyUpCount = 1);
  Assert(mForm.FormKeys = 'A');

  { Keys pressed:  Shift, A }
  mForm.ResetForm;
  EnterKeyInto(mForm.xMemo, VK_A, [ssShift]);
  Assert(mForm.xMemo.Text = 'A');
  Assert(mForm.FormKeyDownCount = 1);
  Assert(mForm.FormKeyUpCount = 1);
  Assert(mForm.FormKeys = 'A');

  { Keys pressed:  Shift, A }
  mForm.ResetForm;
  EnterKeyInto(mForm.xButton, VK_A, [ssShift]);
  Assert(mForm.FormKeyDownCount = 1);
  Assert(mForm.FormKeyUpCount = 1);
  Assert(mForm.FormKeys = 'A');

  { Keys pressed : F8 }
  mForm.ResetForm;
  EnterKeyInto(mForm, VK_F8, []);
  Assert(mForm.Function8Count = 1);
  Assert(mForm.FormKeyDownCount = 0);  { Keydown gets munched ?}
  Assert(mForm.FormKeyUpCount = 1);

  { Keys pressed : Alt, Backspace }
  mForm.ResetForm;
  EnterKeyInto(mForm, VK_BACK, [ssAlt]);
  Assert(mForm.AltBackspaceCount = 1);

  { Keys pressed : Ctrl, A }
  mForm.ResetForm;
  EnterKeyInto(mForm, VK_A, [ssCtrl]);
  Assert(mForm.ControlACount = 1);
end;

procedure T_TGUITestCase.Test_EnterKey;
begin
  EnterKey(VK_F8);
{$IFNDEF DUNIT_CLX}
  Assert(mForm.Function8Count = 1);
{$ENDIF}
  SetFocus(mForm.xMemo);
  EnterKey('M');
  Assert(mForm.xMemo.Text = 'm');
  SetFocus(mForm);
  EnterKey(VK_F8);
{$IFNDEF DUNIT_CLX}
  Assert(mForm.Function8Count = 2);
{$ENDIF}
end;

procedure T_TGUITestCase.Test_EnterTextInto;
const c_text = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ `1234567890-=~!@#$%^&*()_+[]{}\|;'':",./<>?';
begin
  EnterTextInto(mForm.xMemo, c_text);
  Assert(mForm.xMemo.Text = c_text);

  EnterTextInto(mForm.xEdit, c_text);
  Assert(mForm.xEdit.Text = c_text);
end;

procedure T_TGUITestCase.Test_Tab;
begin
  Tab(2);
  Assert(GetFocused = mForm.xButton3);
  Tab(-1);
  Assert(GetFocused = mForm.xButton2);
  Tab(-1);
  Assert(GetFocused = mForm.xButton);
end;

{ TGUITestRunnerTests }

procedure TGUITestRunnerTests.SetUp;
begin
  inherited;
  FRunner := TGUITestRunner.Create(nil);
  FRunner.Color   := clWhite;
  FRunner.Caption := 'This Form is being tested';
  FRunner.Left    :=  FRunner.Left + 200;
  FRunner.Top     := FRunner.Top + 100;
  FRunner.Width   := 300;
  FRunner.Height  := 480;
  FRunner.AutoSaveAction.Checked := False;
  GUI := FRunner;
end;

procedure TGUITestRunnerTests.TearDown;
begin
  GUI := nil;
  FRunner.Free;
  inherited;
end;

procedure TGUITestRunnerTests.TestTabOrder;
begin
  // need to set a test suite, or buttons will be disabled
  FRunner.Suite := TFailuresTestCase.Suite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;
  (*!! Actions are now in Toolbar
  CheckFocused(FRunner.RunButton);
  Tab;
  CheckFocused(FRunner.CloseButton);
  Tab;
  *)
{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}
  CheckFocused(FRunner.TestTree);
  Tab;
  CheckFocused(FRunner.ResultsView);
  Tab;
  CheckFocused(FRunner.FailureListView);
  Tab;
{$IFNDEF DUNIT_CLX}
  CheckFocused(FRunner.ErrorMessageRTF);
  Tab;
{$ENDIF}
  (*
  CheckFocused(FRunner.RunButton);
  Tab;
  CheckTabTo('RunButton');
  *)
end;

procedure TGUITestRunnerTests.RunEmptySuite;
begin
  // no suite
  Show;
{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}

  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,               'progress label');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  EnterKey(vk_F9);
  // nothing happens
  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,               'progress label');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  EnterKey('X', [ssAlt]);

  Check(not FRunner.Visible, 'form closed?');
end;

procedure TGUITestRunnerTests.RunSuccessSuite;
begin
  FRunner.Suite := TSuccessTestCase.Suite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;

{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}
  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,               'progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  EnterKey('R', [ssAlt]);

  CheckEquals( 2,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  EnterKey('X', [ssAlt]);

  Check(not FRunner.Visible, 'form closed?');
end;

procedure TGUITestRunnerTests.RunFailureSuite;
begin
  FRunner.Suite := TFailuresTestCase.Suite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;

{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}

  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,               'progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  EnterKey('R', [ssAlt]);

  CheckEquals( 4,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '25%', FRunner.LbProgress.Caption,             'progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('1', FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 3,  FRunner.FailureListView.Items.Count,        'failure list');


  EnterKey('X', [ssAlt]);

  Check(not FRunner.Visible, 'form closed?');
end;

procedure TGUITestRunnerTests.TestViewResult;
begin
  FRunner.Suite := TFailuresTestCase.Suite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;
{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
{$ENDIF}
  FRunner.TestTree.SetFocus;
  FRunner.TestTree.Items[0].Item[0].Selected := true;
  FRunner.TestTree.Items[0].Item[0].Selected := true;
{$IFNDEF DUNIT_CLX}
  EnterKey('D',[ssAlt]); //to uncheck node
{$ENDIF}
  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,                 'progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');
end;

procedure TGUITestRunnerTests.TestElapsedTime;
var
  ElapTime, MinTime, MaxTime: string;
begin
  FRunner.Suite := TTimeTestCase.Suite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;
{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}
  EnterKey(vk_F9);
  ElapTime := FRunner.ResultsView.Items[0].SubItems[4];
  MinTime := '0:00:00.070';
  MaxTime := '0:00:00.300';
  Check(ElapTime > MinTime, 'elapsed time ('+ElapTime+') should be bigger than ' + MinTime);
  Check(ElapTime < MaxTime, 'elapsed time ('+ElapTime+') should be lesser than ' + MaxTime);
end;

procedure TGUITestRunnerTests.TestStatus;
const
{$IFDEF WIN32}
  constLineDelim = #13#10;
{$ENDIF}
{$IFDEF LINUX}
  constLineDelim = #10;
{$ENDIF}
  constStatusTestStr =
      'SecondSuccessWithStatus:' + constLineDelim
      + 'Line 1' + constLineDelim
      + 'Line 2' + constLineDelim
      + 'Line 3' + constLineDelim;
begin
  FRunner.Suite := TStatusTestCase.Suite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;

{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}
  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,                 'progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');
{$IFNDEF DUNIT_CLX}
  CheckEquals( 0,  FRunner.ErrorMessageRTF.Lines.Count,        'Status in ErrorMessageRTF');
{$ENDIF}

  EnterKey('R', [ssAlt]);

  CheckEquals( 2,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');
{$IFNDEF DUNIT_CLX}
  CheckEquals( constStatusTestStr, FRunner.ErrorMessageRTF.Lines.Text,
      'Statustext in ErrorMessageRTF');
  CheckEquals( 4,  FRunner.ErrorMessageRTF.Lines.Count,        'Status in ErrorMessageRTF');
{$ENDIF}

  EnterKey('X', [ssAlt]);

  Check(not FRunner.Visible, 'form closed?');
end;

procedure TGUITestRunnerTests.TestRunSelectedTestWithDecorator;
var
  TestSuite : ITest;
  SuccessTest : ITest;
begin
  SuccessTest := TSuccessTestCase.Suite;
  TestSuite := TRepeatedTest.Create( SuccessTest , 2);
  FRunner.Suite := TestSuite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;

{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}

  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,                 'progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  CheckEquals(1, FRunner.Suite.Tests.Count, 'Before Suite.Tests.Count');
  CheckEquals(2, (FRunner.Suite.Tests[0] as ITest).Tests.Count, 'Before Suite.Tests[0].Tests.Count');
  CheckEquals(4, FRunner.Suite.CountEnabledTestCases, 'Before CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'Before testcount');

  CheckSame(TestSuite, FRunner.Suite, 'Before testsuite');
  CheckSame(SuccessTest, FRunner.Suite.Tests[0], 'Before SuccesTest');

  FRunner.TestTree.SetFocus;

  CheckFocused(FRunner.TestTree);
  EnterKeyInto(FRunner.TestTree, VK_END);

  EnterKey(VK_F8);

  CheckEquals( 1,  FRunner.ProgressBar.Position,               'After first progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,              'After first progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'After first tests');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[1],   'After first run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'After first failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'After first error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'After first failure list');

  CheckEquals(1, FRunner.Suite.Tests.Count, 'After first Suite.Tests.Count');
  CheckEquals(2, (FRunner.Suite.Tests[0] as ITest).Tests.Count, 'After first Suite.Tests[0].Tests.Count');
  CheckSame(TestSuite, FRunner.Suite, 'After first testsuite');
  CheckSame(SuccessTest, FRunner.Suite.Tests[0], 'After first SuccesTest');
  CheckEquals(4, FRunner.Suite.CountEnabledTestCases, 'After first CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'After first testcount');

  CheckFocused(FRunner.TestTree);

  // Second time could generate an pointer error
  EnterKeyInto(FRunner.TestTree, VK_F8);

  CheckEquals( 1,  FRunner.ProgressBar.Position,               'After second progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'After second progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'After second tests');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[1],   'After second run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'After second failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'After second error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'After second failure list');

  CheckEquals(4, FRunner.Suite.CountEnabledTestCases, 'After second CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'testcount');

  // Normal test after single test. Should run all enabled tests.
  EnterKeyInto(FRunner.TestTree, VK_F9);

  CheckEquals( 4,  FRunner.ProgressBar.Position,               'Normal after progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'Normal after progress label');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[0],   'Normal after tests');
  CheckEquals('4', FRunner.ResultsView.Items[0].SubItems[1],   'Normal after run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'Normal after failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'Normal after error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'Normal after failure list');

  CheckEquals(4, FRunner.Suite.CountEnabledTestCases, 'Normal after CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'Normal after testcount');

  EnterKey('X', [ssAlt]);

  Check(not FRunner.Visible, 'form closed?');
end;

procedure TGUITestRunnerTests.TestRunSelectedTestWithSetupDecorator;
var TestSuite   : TSetupTestCase;
    ITestSuite  : ITest;
    SuccessTest : ITest;
begin
  SuccessTest := TSuccessTestCase.Suite;
  TestSuite := TSetupTestCase.Create( SuccessTest);
  ITestSuite := TestSuite;
  FRunner.Suite := ITestSuite;
  FRunner.AutoSaveAction.Checked := False;
  FRunner.BreakOnFailuresAction.Checked := False;
  Show;

{$IFDEF DUNIT_CLX}
  FRunner.SetFocusedControl(FRunner);
  FRunner.TestTree.SetFocus;
{$ENDIF}

  CheckEquals( 0,  FRunner.ProgressBar.Position,               'progress bar');
  CheckEquals( '', FRunner.LbProgress.Caption,                 'progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'tests');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[1],   'run count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[2],   'failure count');
  CheckEquals('',  FRunner.ResultsView.Items[0].SubItems[3],   'error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'failure list');

  CheckEquals(1, FRunner.Suite.Tests.Count, 'Before Suite.Tests.Count');
  CheckEquals(2, (FRunner.Suite.Tests[0] as ITest).Tests.Count, 'Before Suite.Tests[0].Tests.Count');
  CheckEquals(2, FRunner.Suite.CountEnabledTestCases, 'Before CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'Before testcount');

  CheckEquals(0, TestSuite.FSetupCount, 'Before SetupCount');
  CheckEquals(0, TestSuite.FTeardownCount, 'Before TeardownCount');

  FRunner.TestTree.SetFocus;

  CheckFocused(FRunner.TestTree);
  EnterKeyInto(FRunner.TestTree, VK_END);

  EnterKey(VK_F8);

  CheckEquals( 1,  FRunner.ProgressBar.Position,               'After first progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'After first progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'After first tests');
  CheckEquals('1', FRunner.ResultsView.Items[0].SubItems[1],   'After first run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'After first failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'After first error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'After first failure list');

  CheckEquals(1, FRunner.Suite.Tests.Count, 'After first Suite.Tests.Count');
  CheckEquals(2, (FRunner.Suite.Tests[0] as ITest).Tests.Count, 'After first Suite.Tests[0].Tests.Count');
  CheckEquals(2, FRunner.Suite.CountEnabledTestCases, 'After first CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'After first testcount');

  CheckEquals(1, TestSuite.FSetupCount, 'After first SetupCount');
  CheckEquals(1, TestSuite.FTeardownCount, 'After first TeardownCount');

  CheckFocused(FRunner.TestTree);

  // Second time could generate an pointer error
  EnterKeyInto(FRunner.TestTree, VK_F8);

  CheckEquals( 1,  FRunner.ProgressBar.Position,               'After second progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'After second progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'After second tests');
  CheckEquals('1', FRunner.ResultsView.Items[0].SubItems[1],   'After second run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'After second failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'After second error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'After second failure list');

  CheckEquals(2, FRunner.Suite.CountEnabledTestCases, 'After second CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'testcount');

  CheckEquals(2, TestSuite.FSetupCount, 'After second SetupCount');
  CheckEquals(2, TestSuite.FTeardownCount, 'After second TeardownCount');

  // Normal test after single test. Should run all enabled tests.
  EnterKeyInto(FRunner.TestTree, VK_F9);

  CheckEquals( 2,  FRunner.ProgressBar.Position,               'Normal after progress bar');
  CheckEquals( '100%', FRunner.LbProgress.Caption,             'Normal after progress label');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[0],   'Normal after tests');
  CheckEquals('2', FRunner.ResultsView.Items[0].SubItems[1],   'Normal after run count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[2],   'Normal after failure count');
  CheckEquals('0', FRunner.ResultsView.Items[0].SubItems[3],   'Normal after error count');
  CheckEquals( 0,  FRunner.FailureListView.Items.Count,        'Normal after failure list');

  CheckEquals(2, FRunner.Suite.CountEnabledTestCases, 'Normal after CountEnabledTestCases');
  CheckEquals(4, TDunitDialogCracker(FRunner).FTests.Count, 'Normal after testcount');

  CheckEquals(3, TestSuite.FSetupCount, 'Normal after SetupCount');
  CheckEquals(3, TestSuite.FTeardownCount, 'Normal after TeardownCount');

  EnterKey('X', [ssAlt]);

  Check(not FRunner.Visible, 'form closed?');

  if ITestSuite <> nil then
    ITestSuite := nil;
end;

{$IFNDEF DUNIT_CLX}
procedure TGUITestRunnerTests.TestGoToPrevNextSelectedNode;
begin
  FRunner.Suite := TSuccessTestCase.Suite;
  Show;
  FRunner.TestTree.SetFocus;
  Check(FRunner.TestTree.Selected = FRunner.TestTree.Items[0], 'ensure starting at root node');
  FRunner.GoToNextSelectedTestAction.Execute;
  Check(FRunner.TestTree.Selected = FRunner.TestTree.Items[1], 'testing from non-test to next test node');
  FRunner.GoToNextSelectedTestAction.Execute;
  Check(FRunner.TestTree.Selected = FRunner.TestTree.Items[2], 'testing test node to next test node');
  FRunner.GoToNextSelectedTestAction.Execute;
  Check(FRunner.TestTree.Selected = FRunner.TestTree.Items[2], 'testing the end of the line, next should stay put');
  FRunner.GoToPrevSelectedTestAction.Execute;
  Check(FRunner.TestTree.Selected = FRunner.TestTree.Items[1], 'testing test to prev test');
  FRunner.GoToPrevSelectedTestAction.Execute;
  Check(FRunner.TestTree.Selected = FRunner.TestTree.Items[1], 'beg of the line, prev should stay put');
end;
{$ENDIF}

{ TSuccessTestCase }

procedure TSuccessTestCase.OneSuccess;
begin
  check(true);
end;

procedure TSuccessTestCase.SecondSuccess;
begin
  check(true);
end;

{ TFailuresTestCase }

procedure TFailuresTestCase.OneSuccess;
begin
  DoNothing;
end;

procedure TFailuresTestCase.OneError;
begin
  raise EAbort.Create('One Error');
end;

procedure TFailuresTestCase.OneFailure;
begin
  fail('One failure');
end;

procedure TFailuresTestCase.SecondFailure;
begin
  fail('Second failure');
end;

procedure TFailuresTestCase.DoNothing;
begin
// Do Nothing
end;

{ TTimeTestCase }

procedure TTimeTestCase.TestTime;
const
  DELAY = 100;
begin
  Sleep(DELAY);
  Check( True );
end;

{ TStatusTestCase }

procedure TStatusTestCase.OneSuccessWithStatus;
begin
  Status('Line 1');
  Status('Line 2');
  Status('Line 3');
end;

procedure TStatusTestCase.SecondSuccessWithStatus;
begin
  Status('Line 1');
  Sleep(200);
  Status('Line 2');
  Sleep(200);
  Status('Line 3');
  Sleep(200);
end;

{ TSetupTestCase }

procedure TSetupTestCase.AfterConstruction;
begin
  inherited;

  FSetupCount := 0;
  FTeardownCount := 0;
end;

procedure TSetupTestCase.SetUp;
begin
  inherited;
  inc(FSetupCount)
end;

procedure TSetupTestCase.TearDown;
begin
  inherited;
  inc(FTeardownCount)
end;

initialization
  RegisterTests('', [T_TGUITestCase.Suite]);
  RegisterTests('GUI Tests', [TGUITestRunnerTests.Suite]);
end.
