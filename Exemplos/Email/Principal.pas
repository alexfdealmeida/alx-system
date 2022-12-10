unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvPageList, JvNavigationPane, JvExControls, JvButton, JvComponentBase, JvFormTransparent, JvFormAnimatedIcon,
  JvTransparentButton, Ticket;

type
  TFPrincipal = class(TForm)
    JvTransparentButton1: TJvTransparentButton;
    procedure JvTransparentButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.JvTransparentButton1Click(Sender: TObject);
var
  LFormulario: TFTicket;
begin    
   LFormulario := TFTicket.Create(Self);
   LFormulario.Show;
end;

end.
