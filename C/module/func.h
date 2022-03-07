#include <stdio.h>

void third_func() {
    printf("Imported function\n");
}

void second_func(char a) {
    printf("%c\n", a);
}

void some_func() {
    printf("First func\n");
}

int sum(int a, int b) {
    int res = a + b;
    return res;
}


void string(char arr[]) {
    for (int i = 0; i < 13; i++)
        printf("%c", arr[i]);
    printf("\n");
}