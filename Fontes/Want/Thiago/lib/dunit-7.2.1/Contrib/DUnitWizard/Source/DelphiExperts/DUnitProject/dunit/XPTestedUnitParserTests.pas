unit XPTestedUnitParserTests;

interface

uses
  TestFrameWork,
  XPTestedUnitParser,
  Classes;          // TStream;

type

  TXPTestedUnitParserTests = class(TTestCase)
  private

    FParser: IXPTestedUnitParser;
    FStream: TStream;

  public

    protected procedure SetUp; override;
    procedure TearDown; override;

  published

    procedure TestParse;
    procedure TestGetError;
    procedure TestExistsMethods;
    procedure TestEmpty;
    procedure TestClassNames;
    procedure TestClassCount;
    procedure TestClassUnitSections;
    procedure TestClassBoundaries;
    procedure TestReParse;
    procedure TestMethodByClassVisibilityCount;
    procedure TestMethodByClassCount;
    procedure TestMethodByVisibilityCount;
  end;

implementation

uses
  XPTestedUnitUtils,
  SysUtils, XPObserver;

const
  UnitSectionStrs: array[TXPUnitSection] of string
    = ('usNone', 'usInterface', 'usImplementation', 'usInitialization',
    'usFinalization');

  ClassVisibilityStrs: array[TXPClassVisibility] of string
    = ( 'cvNone', 'cvPrivate', 'cvProtected', 'cvPublic',
    'cvPublished' );

  TotalSectionCount = 3;

  // Classes in declaration order in example file:

  // INTERFACE

  TSC1_Name = 'TXPStubClass1';

  // Empty stub class
  TSC6_Name = 'TXPStubClass6';

  TSC2_Name = 'TXPStubClass2';

  // IMPLEMENTATION

  TSC3_Name = 'TXPStubClass3';

  // Empty stub classes
  TSC4_Name = 'TXPStubClass4';

  // class implementations

  TSC5_Name = 'TXPStubClass5';

  // INITIALIZATION

// TXPStubClass1
  TSC1_MethodCount = 16;
  TSC1_PrivateMethodCount = 1;
  TSC1_ProtectedMethodCount = 2;
  TSC1_PublicMethodCount = 2;
  TSC1_PublishedMethodCount = 11;
// TXPStubClass2,3
  TSC2_MethodCount = 15;
  TSC2_PrivateMethodCount = 1;
  TSC2_ProtectedMethodCount = 2;
  TSC2_PublicMethodCount = 2;
  TSC2_PublishedMethodCount = 10;

  TotalClassCount = 6;
  TotalPrivateCount = TSC1_PrivateMethodCount + 2 * TSC2_PrivateMethodCount;
  TotalProtectedCount = TSC1_ProtectedMethodCount + 2 * TSC2_ProtectedMethodCount;
  TotalPublicCount = TSC1_PublicMethodCount + 2 * TSC2_PublicMethodCount;
  TotalPublishedCount = TSC1_PublishedMethodCount + 2 * TSC2_PublishedMethodCount;

{ TXPTestedUnitParserTests }

procedure TXPTestedUnitParserTests.SetUp;
begin
  inherited;
  FParser := XPTestedUnitParser.CreateXPTestedUnitParser;
  FStream := TFileStream.Create('Examples\TestedUnitParserTest_1.pas',
    fmOpenRead);
end;

procedure TXPTestedUnitParserTests.TearDown;
begin
  FStream.Free;
  FParser := nil;
  inherited;
end;

procedure TXPTestedUnitParserTests.TestEmpty;
var
  ClassNode: IXPParserNode;

begin
  FParser.ParseTree.Children.Start;
  Check(not FParser.ParseTree.Children.Next(ClassNode));
end;

procedure TXPTestedUnitParserTests.TestExistsMethods;
begin
  Check(FParser.ParseTree.Children <> nil);
end;

procedure TXPTestedUnitParserTests.TestGetError;
var
  Description: string;
  Error: TXPParserError;

begin
  FParser.GetError(Description, Error);
  Check(Error = peNone);
end;

procedure TXPTestedUnitParserTests.TestParse;
begin
  Check(FParser.Parse(FStream));
end;

procedure TXPTestedUnitParserTests.TestClassNames;
var
  SectionNode: IXPParserNode;
  ClassNode: IXPParserNode;
  Names: TStrings;
  ExpectedNames: string;

begin
  ExpectedNames := Format('%s,%s,%s,%s,%s,%s',
    [TSC1_Name, TSC6_Name, TSC2_Name, TSC3_Name, TSC4_Name, TSC5_Name]);
  Names := TStringList.Create;

  try
    FParser.Parse(FStream);
    FParser.ParseTree.Children.Start;

    while FParser.ParseTree.Children.Next(SectionNode) do
    begin
      SectionNode.Children.Start;

      while SectionNode.Children.Next(ClassNode) do
        Names.Add(ClassNode.Name);

    end;

    CheckEquals(ExpectedNames, Names.CommaText, 'ClassNames');
  finally
    Names.Free;
  end;

end;

procedure TXPTestedUnitParserTests.TestClassCount;
var
  SectionNode: IXPParserNode;
  ClassNode: IXPParserNode;
  Count: integer;

begin
  Count := 0;
  FParser.Parse(FStream);
  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
  begin
    SectionNode.Children.Start;

    while SectionNode.Children.Next(ClassNode) do
      System.Inc(Count);

  end;

  CheckEquals(TotalClassCount, Count, 'TotalClassCount');
end;

procedure TXPTestedUnitParserTests.TestMethodByVisibilityCount;
var
  SectionNode: IXPParserNode;
  ClassNode: IXPParserNode;
  VisibilityNode: IXPVisibilityNode;
  PrivateCount: integer;
  ProtectedCount: integer;
  PublicCount: integer;
  PublishedCount: integer;

begin
  PrivateCount := 0;
  ProtectedCount := 0;
  PublicCount := 0;
  PublishedCount := 0;
  FParser.Parse(FStream);
  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
  begin
    SectionNode.Children.Start;

    while SectionNode.Children.Next(ClassNode) do
    begin
      ClassNode.Children.Start;

      while ClassNode.Children.Next(VisibilityNode) do
      begin

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvPrivate then
          System.Inc(PrivateCount,
            (VisibilityNode as IXPVisibilityNode).ChildCount);

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvProtected then
          System.Inc(ProtectedCount,
            (VisibilityNode as IXPVisibilityNode).ChildCount);

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvPublic then
          System.Inc(PublicCount,
            (VisibilityNode as IXPVisibilityNode).ChildCount);

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvPublished then
          System.Inc(PublishedCount,
            (VisibilityNode as IXPVisibilityNode).ChildCount);

      end;

    end;

  end;
  CheckEquals(TotalPrivateCount, PrivateCount, 'TotalPrivateCount');
  CheckEquals(TotalProtectedCount, ProtectedCount, 'TotalProtectedCount');
  CheckEquals(TotalPublicCount, PublicCount, 'TotalPublicCount');
  CheckEquals(TotalPublishedCount, PublishedCount, 'TotalPublishedCount');
end;

procedure TXPTestedUnitParserTests.TestReParse;
var
  SectionNode: IXPParserNode;
  ClassCount: integer;
  SectionCount: integer;
  StreamPos: integer;

begin
  ClassCount := 0;
  StreamPos := FStream.Position;
  FParser.Parse(FStream);
  FStream.Position := StreamPos;
  FParser.Parse(FStream);
  SectionCount := FParser.ParseTree.ChildCount;
  CheckEquals(TotalSectionCount, SectionCount);

  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
      System.Inc(ClassCount, SectionNode.ChildCount);

  CheckEquals(TotalClassCount, ClassCount);
end;

procedure TXPTestedUnitParserTests.TestMethodByClassCount;
var
  SectionNode: IXPParserNode;
  ClassNode: IXPParserNode;
  VisibilityNode: IXPParserNode;
  MethodCount: integer;

begin
  FParser.Parse(FStream);
  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
  begin
    SectionNode.Children.Start;

    while SectionNode.Children.Next(ClassNode) do
    begin
      MethodCount := 0;
      ClassNode.Children.Start;

      while ClassNode.Children.Next(VisibilityNode) do
        System.Inc(MethodCount, VisibilityNode.ChildCount);

      if ClassNode.Name = TSC1_Name then
        CheckEquals(TSC1_MethodCount, MethodCount, Format('%s Count', [TSC1_Name]));

      if ClassNode.Name = TSC2_Name then
        CheckEquals(TSC2_MethodCount, MethodCount, Format('%s Count', [TSC2_Name]));

      if ClassNode.Name = TSC3_Name then
        CheckEquals(TSC2_MethodCount, MethodCount, Format('%s Count', [TSC3_Name]));

      if ClassNode.Name = TSC4_Name then
        CheckEquals(0, MethodCount, Format('%s Count', [TSC4_Name]));

      if ClassNode.Name = TSC5_Name then
        CheckEquals(0, MethodCount, Format('%s Count', [TSC5_Name]));

      if ClassNode.Name = TSC6_Name then
        CheckEquals(0, MethodCount, Format('%s Count', [TSC6_Name]));

    end;

  end;

end;

procedure TXPTestedUnitParserTests.TestMethodByClassVisibilityCount;
var
  SectionNode: IXPParserNode;
  ClassNode: IXPParserNode;
  VisibilityNode: IXPParserNode;
  PrivateCount: integer;
  ProtectedCount: integer;
  PublicCount: integer;
  PublishedCount: integer;

begin
  FParser.Parse(FStream);
  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
  begin
    SectionNode.Children.Start;

    while SectionNode.Children.Next(ClassNode) do
    begin
      ClassNode.Children.Start;
      PrivateCount := 0;
      ProtectedCount := 0;
      PublicCount := 0;
      PublishedCount := 0;

      while ClassNode.Children.Next(VisibilityNode) do
      begin

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvPrivate then
          PrivateCount := (VisibilityNode as IXPVisibilityNode).ChildCount;

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvProtected then
          ProtectedCount := (VisibilityNode as IXPVisibilityNode).ChildCount;

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvPublic then
          PublicCount := (VisibilityNode as IXPVisibilityNode).ChildCount;

        if (VisibilityNode as IXPVisibilityNode).GetVisibility = cvPublished then
          PublishedCount := (VisibilityNode as IXPVisibilityNode).ChildCount;

      end;

      if ClassNode.Name = TSC1_Name then
        CheckEquals(TSC1_PublishedMethodCount, PublishedCount, Format('%s Published Count', [TSC1_Name]));
      if ClassNode.Name = TSC2_Name then
        CheckEquals(TSC2_PublishedMethodCount, PublishedCount, Format('%s Published Count', [TSC2_Name]));
      if ClassNode.Name = TSC3_Name then
        CheckEquals(TSC2_PublishedMethodCount, PublishedCount, Format('%s Published Count', [TSC3_Name]));
      if ClassNode.Name = TSC4_Name then
        CheckEquals(0, PublishedCount, Format('%s Published Count', [TSC4_Name]));
      if ClassNode.Name = TSC5_Name then
        CheckEquals(0, PublishedCount, Format('%s Published Count', [TSC5_Name]));
      if ClassNode.Name = TSC6_Name then
        CheckEquals(0, PublishedCount, Format('%s Published Count', [TSC6_Name]));

      if ClassNode.Name = TSC1_Name then
        CheckEquals(TSC1_PublicMethodCount, PublicCount, Format('%s Public Count', [TSC1_Name]));
      if ClassNode.Name = TSC2_Name then
        CheckEquals(TSC2_PublicMethodCount, PublicCount, Format('%s Public Count', [TSC2_Name]));
      if ClassNode.Name = TSC3_Name then
        CheckEquals(TSC2_PublicMethodCount, PublicCount, Format('%s Public Count', [TSC3_Name]));
      if ClassNode.Name = TSC4_Name then
        CheckEquals(0, PublicCount, Format('%s Public Count', [TSC4_Name]));
      if ClassNode.Name = TSC5_Name then
        CheckEquals(0, PublicCount, Format('%s Public Count', [TSC5_Name]));
      if ClassNode.Name = TSC6_Name then
        CheckEquals(0, PublicCount, Format('%s Public Count', [TSC6_Name]));

      if ClassNode.Name = TSC1_Name then
        CheckEquals(TSC1_ProtectedMethodCount, ProtectedCount, Format('%s Protected Count', [TSC1_Name]));
      if ClassNode.Name = TSC2_Name then
        CheckEquals(TSC2_ProtectedMethodCount, ProtectedCount, Format('%s Protected Count', [TSC2_Name]));
      if ClassNode.Name = TSC3_Name then
        CheckEquals(TSC2_ProtectedMethodCount, ProtectedCount, Format('%s Protected Count', [TSC3_Name]));
      if ClassNode.Name = TSC4_Name then
        CheckEquals(0, ProtectedCount, Format('%s Protected Count', [TSC4_Name]));
      if ClassNode.Name = TSC5_Name then
        CheckEquals(0, ProtectedCount, Format('%s Protected Count', [TSC5_Name]));
      if ClassNode.Name = TSC6_Name then
        CheckEquals(0, ProtectedCount, Format('%s Protected Count', [TSC6_Name]));

      if ClassNode.Name = TSC1_Name then
        CheckEquals(TSC1_PrivateMethodCount, PrivateCount, Format('%s Private Count', [TSC1_Name]));
      if ClassNode.Name = TSC2_Name then
        CheckEquals(TSC2_PrivateMethodCount, PrivateCount, Format('%s Private Count', [TSC2_Name]));
      if ClassNode.Name = TSC3_Name then
        CheckEquals(TSC2_PrivateMethodCount, PrivateCount, Format('%s Private Count', [TSC3_Name]));
      if ClassNode.Name = TSC4_Name then
        CheckEquals(0, PrivateCount, Format('%s Private Count', [TSC4_Name]));
      if ClassNode.Name = TSC5_Name then
        CheckEquals(0, PrivateCount, Format('%s Private Count', [TSC5_Name]));
      if ClassNode.Name = TSC6_Name then
        CheckEquals(0, PrivateCount, Format('%s Private Count', [TSC6_Name]));

    end;

  end;

end;

procedure TXPTestedUnitParserTests.TestClassBoundaries;
var
  ClassNode: IXPParserNode;
  SectionNode: IXPParserNode;
  LastEnd: longint;

begin
  FParser.Parse(FStream);
  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
  begin
    LastEnd := 0;
    SectionNode.Children.Start;

    while SectionNode.Children.Next(ClassNode) do
    begin
      Check((ClassNode as IXPClassNode).ClassEnd 
        > (ClassNode as IXPClassNode).ClassBegin,
        Format('%s: Class length <= 0', [ClassNode.Name]));
      Check((ClassNode as IXPClassNode).ClassBegin > 0,
        Format('%s: Class begin < 0', [ClassNode.Name]));
      Check((ClassNode as IXPClassNode).ClassBegin > LastEnd,
        Format('%s: overlaps with previous class', [ClassNode.Name]));
      LastEnd := (ClassNode as IXPClassNode).ClassEnd;
    end;

  end;

end;

procedure TXPTestedUnitParserTests.TestClassUnitSections;
var
  Node: IXPParserNode;
  ClassNode: IXPClassNode;
  SectionNode: IXPParserNode;

begin
  FParser.Parse(FStream);
  FParser.ParseTree.Children.Start;

  while FParser.ParseTree.Children.Next(SectionNode) do
  begin
    SectionNode.Children.Start;

    while SectionNode.Children.Next(Node) do
    begin
       ClassNode := Node as IXPClassNode;

      if ClassNode.Name = TSC1_Name then
        Check(usInterface = (ClassNode.Parent as IXPSectionNode).GetSection,
          Format('%s %s<>%s', [TSC1_Name,
            UnitSectionStrs[(ClassNode.Parent as IXPSectionNode).GetSection],
            UnitSectionStrs[usInterface]]));
      if ClassNode.Name = TSC2_Name then
        Check(usInterface = (ClassNode.Parent as IXPSectionNode).GetSection,
          Format('%s %s<>%s', [TSC2_Name,
            UnitSectionStrs[(ClassNode.Parent as IXPSectionNode).GetSection],
            UnitSectionStrs[usInterface]]));
      if ClassNode.Name = TSC3_Name then
        Check(usImplementation = (ClassNode.Parent as IXPSectionNode).GetSection,
          Format('%s %s<>%s', [TSC3_Name,
            UnitSectionStrs[(ClassNode.Parent as IXPSectionNode).GetSection],
            UnitSectionStrs[usImplementation]]));
      if ClassNode.Name = TSC4_Name then
        Check(usImplementation = (ClassNode.Parent as IXPSectionNode).GetSection,
          Format('%s %s<>%s', [TSC4_Name,
            UnitSectionStrs[(ClassNode.Parent as IXPSectionNode).GetSection],
            UnitSectionStrs[usImplementation]]));
      if ClassNode.Name = TSC5_Name then
        Check(usImplementation = (ClassNode.Parent as IXPSectionNode).GetSection,
          Format('%s %s<>%s', [TSC5_Name,
            UnitSectionStrs[(ClassNode.Parent as IXPSectionNode).GetSection],
            UnitSectionStrs[usImplementation]]));
      if ClassNode.Name = TSC6_Name then
        Check(usInterface = (ClassNode.Parent as IXPSectionNode).GetSection,
          Format('%s %s<>%s', [TSC6_Name,
            UnitSectionStrs[(ClassNode.Parent as IXPSectionNode).GetSection],
            UnitSectionStrs[usInterface]]));

    end;

  end;

end;

initialization

  TestFramework.RegisterTest('XPTestedUnitParserTests Suite',
    TXPTestedUnitParserTests.Suite);

end.

