#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {
    char a[100], temp[100];
    char *word;
    char delim[] = ";><{}+)(&%#,= ";
    char variable[10][20], datatype[10][20];
    int k, noofvar = 0;
    void *i;
    FILE *p;

    p = fopen("add.c", "r");   // Open file in read mode
    if (p == NULL) {
        printf("Error opening file.\n");
        return 1;
    }

    fscanf(p, "%s", a);
    strcpy(temp, "Null");

    printf("\nLexeme\tToken\n");
    printf("--------------------------\n");

    while (strcmp(a, "END") != 0) {
        // Check special characters
        for (k = 0; k < strlen(a); k++) {
            if (a[k] == ';' || a[k] == '<' || a[k] == '{' || a[k] == '>' ||
                a[k] == ')' || a[k] == '}' || a[k] == '#' || a[k] == ',' ||
                a[k] == '&' || a[k] == '+' || a[k] == '=' || a[k] == '(') {
                printf("\033[0;37m");
                printf("%c\tSpecial Character\n", a[k]);
            }
        }

        // Break into tokens
        word = strtok(a, delim);
        while (word != NULL) {
            if ((strcmp(word, "scanf") == 0) || (strcmp(word, "printf") == 0) || (strcmp(word, "main") == 0)) {
                printf("\033[0;36m");
                printf("%s\tBUILT-IN FUNCTION\n", word);
            }
            else if ((strcmp(word, "int") == 0) || (strcmp(word, "float") == 0) ||
                     (strcmp(word, "char") == 0) || (strcmp(word, "void") == 0)) {
                printf("\033[0;32m");
                printf("%s\tKEYWORD\n", word);
            }
            else if (strcmp(word, "include") == 0) {
                printf("\033[0;32m");
                printf("%s\tPREPROCESSOR\n", word);
            }
            else if ((strcmp(word, "stdio.h") == 0) || (strcmp(word, "conio.h") == 0)) {
                printf("\033[0;33m");
                printf("%s\tHEADER FILE\n", word);
            }
            else if ((strcmp(temp, "int") == 0) || (strcmp(temp, "float") == 0) || (strcmp(temp, "char") == 0)) {
                printf("\033[0;36m");
                printf("%s\tVARIABLE\n", word);
                strcpy(variable[noofvar], word);
                strcpy(datatype[noofvar], temp);
                noofvar++;
            }
            word = strtok(NULL, delim);
        }

        strcpy(temp, a);
        fscanf(p, "%s", a);
    }
    fclose(p);

    // SYMBOL TABLE
    printf("\n\nSYMBOL TABLE\n");
    printf("------------------------------\n");
    printf("Symbol\tAddress\t\tType\n");

    for (k = 0; k < noofvar; k++) {
        i = malloc(sizeof(int));  // Allocate memory properly
        printf("\033[0;31m");
        printf("%s\t%p\t%s\n", variable[k], i, datatype[k]);
    }

    return 0;
}
