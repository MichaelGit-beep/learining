#include <stdio.h>

void recursive(int count) {
    if(count > 0) {
        printf("Hello\n");
        recursive(--count);
    } 
}

int sum(int x) {
    if(x == 0 || x == 1) return x;
    return x + sum(x-1);
}

int fac(int x) {
    if(x == 1) {
        return x;
    }
    return x * fac(x-1);
}

int fib(int x) {
    if(x == 1 || x == 0) return x;
    return fib(x-1) + fib(x-2);
}

int main() {
    int z = fib(40);
    printf("%d", z);
    return 0; 
} 

// 0 1 1 2 3 5 8 13