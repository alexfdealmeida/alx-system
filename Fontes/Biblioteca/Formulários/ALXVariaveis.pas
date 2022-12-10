unit ALXVariaveis;

interface

uses Windows, Classes, SysUtils;

var
   DADOS_PESSOAIS: record
      EMAIL: string;
      MSN: string;
      SKYPE: string;
      FONE_FIX: string;
      FONE_CEL: string;
      FONE_COM: string;
   end;

const
   SENH_ADMIN = '0DE0E70E20ED0DE0D90DE';
   NOME_ADMIN = '0AD0BE0B4';

implementation

initialization
   DADOS_PESSOAIS.EMAIL    := 'alexferreiradealmeida@gmail.com';
   DADOS_PESSOAIS.MSN      := 'alexferreiradealmeida@hotmail.com';
   DADOS_PESSOAIS.SKYPE    := 'alexferreiradealmeida';
   DADOS_PESSOAIS.FONE_CEL := '(62) 8132-2810';
   DADOS_PESSOAIS.FONE_FIX := '(62) 3258-2229';
   DADOS_PESSOAIS.FONE_COM := '(62) 3258-2229';
end.
