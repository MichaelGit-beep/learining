#include <stdio.h>


int swap(int *x, int *y) {
    int z = *y;
    *y = *x;
    *x = z;
}

int main() {
    int a = 10, b = 20;
    printf("a = %d, b = %d\n", a, b);
    swap(&a, &b);
    printf("a = %d, b = %d\n", a, b);
    return 0; 
}

