unit UMaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvOfficeStatusBar, AppEvnts, ImgList, ComCtrls,
  AdvOfficeStatusBarStylers;

type
  TFMaster = class(TForm)
    stbMaster: TAdvOfficeStatusBar;
    stbStylerMaster: TAdvOfficeStatusBarOfficeStyler;
    ImageListMaster: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMaster: TFMaster;

implementation

uses ALXFuncoes;

{$R *.dfm}

procedure TFMaster.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFMaster.FormCreate(Sender: TObject);
begin
   stbMaster.AutoHint := True;
   stbMaster.ShowHint := True;
   stbMaster.Panels[0].Width := Self.Width;
end;

procedure TFMaster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_ESCAPE) then
      Close;
end;

end.
