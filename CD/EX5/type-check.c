#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, i, k, flag = 0;
    char vari[15], typ[15], b[50], c;

    printf("Enter the number of variables: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("Enter the variable[%d]: ", i);
        scanf(" %c", &vari[i]);
        printf("Enter the variable-type[%d] (float-f, int-i): ", i);
        scanf(" %c", &typ[i]);
        if (typ[i] == 'f')
            flag = 1;  // marks that we have float variables
    }

    printf("Enter the Expression (end with $): ");
    i = 0;
    getchar(); // consume leftover newline
    while ((c = getchar()) != '$') {
        b[i] = c;
        i++;
    }
    k = i;

    // check if expression contains division
    for (i = 0; i < k; i++) {
        if (b[i] == '/') {
            flag = 1;
            break;
        }
    }

    for (i = 0; i < n; i++) {
        if (b[0] == vari[i]) {
            if (flag == 1) {
                if (typ[i] == 'f') {
                    printf("\nThe datatype is correctly defined..!\n");
                } else {
                    printf("Identifier %c must be a float type..!\n", vari[i]);
                }
            } else {
                printf("\nThe datatype is correctly defined..!\n");
            }
            break;
        }
    }

    return 0;
}
