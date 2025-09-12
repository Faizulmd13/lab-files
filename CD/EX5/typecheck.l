%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

[0-9]+              { return NUMBER; }
[a-zA-Z]            { yylval.id = yytext[0]; return ID; }
"int"               { return INT; }
"float"             { return FLOAT; }
\n                  { return '\n'; }          /* send newline to parser */
[\t ]+              ;                         /* ignore spaces and tabs */
.                   { return yytext[0]; }

%%

int yywrap() { return 1; }

