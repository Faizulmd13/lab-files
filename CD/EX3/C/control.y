%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

int syntax_error = 0;
%}

%union {
    char* id;
    int num;
}

%token <id> ID
%token <num> NUMBER
%token FOR WHILE IF ELSE SWITCH CASE DEFAULT BREAK
%token EQ NE LE GE LT GT

%left '+' '-'
%left '*' '/'
%left UMINUS

%%

program:
      stmt_list
;

stmt_list:
      stmt_list stmt
    | /* empty */
;

stmt:
      compound_stmt
    | simple_stmt
;

compound_stmt:
      '{' stmt_list '}'
;

simple_stmt:
      expr_stmt ';'
    | if_stmt
    | for_stmt
    | while_stmt
    | switch_stmt
    | BREAK ';' 
;

expr_stmt:
      assignment
    | expr
;

assignment:
      ID '=' expr
;

expr:
      ID
    | NUMBER
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr EQ expr
    | expr NE expr
    | expr LT expr
    | expr GT expr
    | expr LE expr
    | expr GE expr
    | '(' expr ')'
;

if_stmt:
      IF '(' expr ')' stmt else_part
;

else_part:
      ELSE stmt
    | /* empty */
;

for_stmt:
      FOR '(' for_init ';' for_cond ';' for_inc ')' stmt
;

for_init:
      assignment
    | /* empty */
;

for_cond:
      expr
    | /* empty */
;

for_inc:
      assignment
    | expr
    | /* empty */
;

while_stmt:
      WHILE '(' expr ')' stmt
;

switch_stmt:
      SWITCH '(' expr ')' '{' case_block_list '}'
;

case_block_list:
      case_block_list case_block
    | /* empty */
;

case_block:
      CASE NUMBER ':' stmt_list
    | DEFAULT ':' stmt_list
;

%%

void yyerror(const char *s) {
    fprintf(stderr,"Syntax Error: %s\n", s);
    syntax_error = 1;
}

int main(void) {
    printf("Enter C control statements to check syntax:\n");
    yyparse();
    if(syntax_error) {
        printf("Syntax errors found!\n");
    } else {
        printf("Parsing complete!\n");
    }
    return 0;
}

