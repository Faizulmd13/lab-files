%{
#include "y.tab.h"
extern YYSTYPE yylval;
%}

%%
[0-9]       { yylval.symbol = yytext[0]; return NUMBER; }
[a-zA-Z]    { yylval.symbol = yytext[0]; return LETTER; }
[ \t]       ;   // ignore whitespace
.           { return yytext[0]; }
\n          { return 0; }
%%

int yywrap() {
    return 1;
}
