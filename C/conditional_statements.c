#include <stdio.h>
#include <stdbool.h>

int main() {

    // if else
    int x = 4;
    if(x == 1) {
        printf("if block - x is 1\n", x);
    }else if (x == 2) {
        printf("else if block - x is 2\n", x);
    }else {
        printf("else block - x is %d\n", x);
    }

    // and && or ||
    bool aCar = false;
    bool aPlain = true;
    if(!aCar) {
        printf("This is a car %d\n", aCar);
    }else {
        printf("This is not a car %d\n", aPlain);
    }


    // Ternary operator
    int a = 30, b = 20;
    int res = a < b ? a + b : a - b;
    printf("Result %d\n", res);

    // switch
    int y = 2;
    switch(y) {
        case 1:
            printf("case 1 - y is 1\n", y);
            break;
        case 2:
            printf("case 2 - y is 1\n", y);
            break;
        default:
            printf("Default");
    }
    return 0;

}