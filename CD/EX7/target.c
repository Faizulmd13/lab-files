#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char icode[10][30], str[20], opr[10];
    int i = 0;

    printf("\nEnter the set of intermediate code (terminated by exit): \n");

    // Read intermediate code lines
    do {
        scanf("%s", icode[i]);
    } while (strcmp(icode[i++], "exit") != 0);

    printf("\nTarget code generation");
    printf("\n*************************");

    i = 0;
    do {
        strcpy(str, icode[i]);

        // Identify operator
        switch (str[3]) {
            case '+': strcpy(opr, "ADD"); break;
            case '-': strcpy(opr, "SUB"); break;
            case '*': strcpy(opr, "MUL"); break;
            case '/': strcpy(opr, "DIV"); break;
            default: strcpy(opr, "???"); break;
        }

        // Generate assembly-like code
        printf("\n\tMOV R%d, %c", i, str[2]);
        printf("\n\t%s R%d, %c", opr, i, str[4]);
        printf("\n\tMOV %c, R%d", str[0], i);

    } while (strcmp(icode[++i], "exit") != 0);

    return 0;
}
