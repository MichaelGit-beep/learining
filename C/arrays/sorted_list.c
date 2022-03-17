#include <stdio.h>
#define N 3

int main() {
    
    int a[N] = {250, 100, 300};
    for(int i = 1; i < N; i++) {
        while(a[i] < a[i-1] && i > 0) {
            int tmp = a[i-1];
            a[i-1] = a[i];
            a[i] = tmp;
            i--;            
        }
    }
    for(int i = 0; i < N; i++) {
        printf("%d\n", a[i]);
    }
    return 0;
}