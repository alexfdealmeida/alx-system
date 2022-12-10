unit ALXCompilerVariaveis;

interface

uses Windows, Classes, SysUtils;

var
   ADMINISTRADOR: Boolean;
   CODI_USU: integer;
   NOME_USU: string;
   VERS_EXE: string;
   SENH_USU: string;
   LOGI_USU: string;

const
   PROGRAMA = '0AD0C40CB0BC0E20E10D50D60CD0D10EA';
   ZIP = '\zip';
   TEMP = '\ALXCompiler\Temp';
   PARAMS_7Z = 'a -t7z -sfx7z.sfx -m0=lzma';
   ALTURA_TELA_90 = 0.9;
   LARGURA_TELA_50 = 0.5;
   LARGURA_TELA_70 = 0.7;
   PORTA_MESSENGER = '5000';
   TAG_COMPILACAO_REMOTA = 'req_compilacao_remota';
   CARACTERES_ESPECIAIS_IGNORADOS = '\:_.()-';
   LIBRARY_PATH_DELPHI_2006 = 'Software\Borland\BDS\4.0\Library';
   LIBRARY_PATH_DELPHI_7    = 'Software\Borland\Delphi\7.0\Library';

implementation

initialization

   ADMINISTRADOR := False;
   CODI_USU := 0;
   NOME_USU := '';
   VERS_EXE := '';
   SENH_USU := '';
   LOGI_USU := '';

end.
