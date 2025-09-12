%{
#include <stdio.h>
#include <stdlib.h>
   
void yyerror(const char* s);
int yylex(void);
struct expr {
    char operand1;
    char operand2;
    char operator;
    char result;
};

struct expr arr[20];
int index1 = 0;
char temp = 'A' - 1;

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(EXIT_FAILURE);
}

int yylex(); // Explicit declaration

char generate_code(char operator, char operand1, char operand2) {
    temp++;
    arr[index1].operand1 = operand1;
    arr[index1].operand2 = operand2;
    arr[index1].operator = operator;
    arr[index1].result = temp;
    index1++;
    return temp;
}
%}

%union {
    char symbol;
}

%token <symbol> LETTER NUMBER
%type <symbol> exp

%left '+' '-'
%left '*' '/'

%%

exp: exp '+' exp   { $$ = generate_code('+', $1, $3); }
   | exp '-' exp   { $$ = generate_code('-', $1, $3); }
   | exp '*' exp   { $$ = generate_code('*', $1, $3); }
   | exp '/' exp   { $$ = generate_code('/', $1, $3); }
   | '(' exp ')'   { $$ = $2; }
   | LETTER        { $$ = $1; }
   | NUMBER        { $$ = $1; }
   ;

%%

int main() {
    printf("Enter the expression: ");
    yyparse();
    printf("\nThree-address code:\n");
    for (int i = 0; i < index1; ++i) {
        printf("%c := %c %c %c\n", arr[i].result, arr[i].operand1, arr[i].operator, arr[i].operand2);
    }
    return 0;
}
