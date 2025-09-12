#include <stdio.h>
#include <string.h>

struct op {
    char l;       // left-hand side variable
    char r[20];   // right-hand side expression
};

struct op ops[20], pr[20];
int n, pr_count;

// Dead Code Elimination: keep only useful assignments
void removeDeadCode() {
    int i, j, used;
    pr_count = 0;

    for (i = 0; i < n; i++) {
        used = 0;
        for (j = i + 1; j < n; j++) {
            if (strchr(ops[j].r, ops[i].l)) {
                used = 1;
                break;
            }
        }
        // keep if used later OR last assignment to that variable
        if (used || i == n - 1) {
            pr[pr_count++] = ops[i];
        }
    }
}

// Eliminate Common Subexpressions
void eliminateCommonExpression() {
    int i, j;
    for (i = 0; i < pr_count; i++) {
        for (j = i + 1; j < pr_count; j++) {
            if (strcmp(pr[i].r, pr[j].r) == 0) {
                // replace all uses of pr[j].l with pr[i].l
                char old = pr[j].l;
                char newv = pr[i].l;
                pr[j].l = '\0'; // mark redundant
                for (int k = 0; k < pr_count; k++) {
                    for (int m = 0; pr[k].r[m] != '\0'; m++) {
                        if (pr[k].r[m] == old) {
                            pr[k].r[m] = newv;
                        }
                    }
                }
            }
        }
    }
}

// Replace occurrences of variables with their full RHS expressions
void algebraicSubstitution() {
    int i, j;
    char buffer[50];

    for (i = 0; i < pr_count; i++) {
        for (j = 0; j < pr_count; j++) {
            if (i != j && pr[j].l != '\0') {
                char *pos = strchr(pr[i].r, pr[j].l);
                if (pos) {
                    // Build a new string replacing variable with RHS
                    int idx = pos - pr[i].r;
                    buffer[0] = '\0';

                    strncat(buffer, pr[i].r, idx);          // part before match
                    strcat(buffer, pr[j].r);                // substitute full RHS
                    strcat(buffer, pr[i].r + idx + 1);      // rest of string

                    strcpy(pr[i].r, buffer);
                }
            }
        }
    }
}


int main() {
    int i;

    printf("Enter the Number of Values: ");
    scanf("%d", &n);

    for (i = 0; i < n; i++) {
        printf("left: ");
        scanf(" %c", &ops[i].l);
        printf("\tright: ");
        scanf("%s", ops[i].r);
    }

    printf("\nIntermediate Code\n");
    for (i = 0; i < n; i++) {
        printf("%c = %s\n", ops[i].l, ops[i].r);
    }

    removeDeadCode();
    printf("\nAfter Dead Code Elimination\n");
    for (i = 0; i < pr_count; i++) {
        printf("%c = %s\n", pr[i].l, pr[i].r);
    }

    eliminateCommonExpression();
    printf("\nAfter Eliminating Common Expressions\n");
    for (i = 0; i < pr_count; i++) {
        if (pr[i].l != '\0')
            printf("%c = %s\n", pr[i].l, pr[i].r);
    }

    algebraicSubstitution();
    printf("\nAfter Algebraic Substitution\n");
    for (i = 0; i < pr_count; i++) {
        if (pr[i].l != '\0')
            printf("%c = %s\n", pr[i].l, pr[i].r);
    }

    return 0;
}

