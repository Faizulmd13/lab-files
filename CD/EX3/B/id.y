%{
   #include<stdio.h>
   #include<stdlib.h>
   
   int yyerror(const char *msg);
   int yylex(void);
   int valid = 1;
%}

%token digit letter

%%

start : letter s   /* must start with a letter */
      ;

s : letter s       /* followed by letters */
  | digit s        /* or digits */
  |                /* empty */
  ;

%%

int yyerror(const char *msg)
{
    printf("\nIt is not an identifier!\n");
    valid = 0;
    return 0;
}

int main()
{
    printf("\nEnter a name to test for identifier: ");
    yyparse();
    if(valid)
    {
        printf("\nIt is an identifier!\n");
    }
    return 0;
}
