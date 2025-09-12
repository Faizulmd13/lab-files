%{
#include <stdio.h>
#include<stdlib.h>
   
int yyerror(const char *msg);
int yylex(void);
int flag = 0;
%}

%token NUMBER
%left '+' '-'
%left '*' '/' '%'

%%

ArithmeticExpression:
      E { printf("\nResult = %d\n", $$); return 0; }
      ;

E : E '+' E   { $$ = $1 + $3; }
  | E '-' E   { $$ = $1 - $3; }
  | E '*' E   { $$ = $1 * $3; }
  | E '/' E   { $$ = $1 / $3; }
  | E '%' E   { $$ = $1 % $3; }
  | '(' E ')' { $$ = $2; }
  | NUMBER    { $$ = $1; }
  ;

%%

int yyerror(const char *msg)
{
    printf("\nEntered arithmetic expression is Invalid\n\n");
    flag = 1;
    return 0;
}

int main()
{
    printf("\nEnter Any Arithmetic Expression which can have operations Addition, ");
    printf("Subtraction, Multiplication, Division, Modulus and Round brackets:\n");
    yyparse();
    if (flag == 0)
        printf("\nEntered arithmetic expression is Valid\n\n");
    return 0;
}

