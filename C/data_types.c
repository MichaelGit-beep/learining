#include <stdio.h>
#include <stdbool.h>

int main() {
    int num_first;
    num_first = 1;
    int x = 5, y = 10, res;    

    // short range -32,768 to 32,767
    short s1 = -30100; 

    // unsigned short, without negative values 0 to 65,535
    unsigned short a = 6;
    
    // unsigned int - without negative values 
    unsigned int k = 6;

    // long - Greater than int
    // long long - extended size long
    // unsigned long
    // unsigned long long

    float af = 0.5f;
    af = 0.6f;
    
    const float Af = 0.6f;

    // double - longer float
    // long double - extended size double 

    // single sign in a single quotes
    char ca = 'a';

    bool one = false;

    
    printf("Variable: %d + %d = %d\n", x, y, res);
    printf("float %.2f\n", af);
    printf("%c", ca);
    return 0;
}
