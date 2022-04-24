#include <stdio.h>
#include <stdlib.h>

int main() {
    int* var_i = malloc(1000000000);
    printf("%d", *var_i);
    system("pause");
    return 0;
}