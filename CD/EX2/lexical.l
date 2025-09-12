%{
#include <stdio.h>
%}

%%
int|char|float|return           { printf("\n%s => Keyword", yytext); }
#.*                             { printf("\n%s => Preprocessor Directive", yytext); }
printf|scanf|main               { printf("\n%s => Function", yytext); }
["][a-zA-Z ]+["]                { printf("\n%s => String", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*          { printf("\n%s => Identifier", yytext); }
[0-9]+                          { printf("\n%s => Number", yytext); }
"+"|"-"|"*"|"/"|"%"             { printf("\n%s => Operator", yytext); }
","|";"|"&"|"("|")"|"["|"]"|"{"|"}" { printf("\n%s => Special Character", yytext); }
[ \t\n]+                        { /* Ignore whitespace */ }
.                               { printf("\n%s => Unknown", yytext); }
%%

int main() {
    FILE *fp;
    fp = fopen("input.txt", "r");
    if (!fp) {
        printf("Error: could not open input.txt\n");
        return 1;
    }
    yyin = fp;
    yylex();
    fclose(fp);
    return 0;
}

int yywrap() {
    return 1;
}
