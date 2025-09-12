%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);   
void yyerror(const char *s);
int symbol_type[26];   // store variable type: 0=int, 1=float
%}


%union {
    int type;   // 0=int, 1=float
    char id;
}

%token <id> ID
%token INT FLOAT
%token NUMBER
%type <type> exp type decl

%left '+' '-'
%left '*' '/'
%left UMINUS

%%

program:
      decls exp '\n'   { printf("Expression type: %s\n", $2==1 ? "float" : "int"); }
    ;

decls:
      decls decl
    | /* empty */
    ;

decl:
      type ID '\n' {
            symbol_type[$2 - 'a'] = $1;  // assign type to variable
      }
    ;

type:
      INT   { $$ = 0; }
    | FLOAT { $$ = 1; }
    ;

exp:
      exp '+' exp   { $$ = ($1==1 || $3==1) ? 1 : 0; }
    | exp '-' exp   { $$ = ($1==1 || $3==1) ? 1 : 0; }
    | exp '*' exp   { $$ = ($1==1 || $3==1) ? 1 : 0; }
    | exp '/' exp   { $$ = 1; }   /* division always float */
    | '-' exp %prec UMINUS { $$ = $2; }
    | ID   { $$ = symbol_type[$1 - 'a']; }
    | NUMBER { $$ = 0; }   /* assume number literals are int */
    | '(' exp ')' { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter declarations (int/float x) then expression:\n");
    yyparse();
    return 0;
}

