#include <stdio.h>
#define N 20

void print_array(int array[], int n);

int main() {

    int a[N];
    for(int i=0; i<N; i++) {
        a[i] = i;
        
    }
    print_array(a, N);
    
    for(int i=0; i < N / 2; i++) {
        int tmp = a[i]; 
        a[i] = a[N - i - 1];
        a[N - i - 1] = tmp;
    }
    print_array(a, N);

    return 0;
}

void print_array(int array[], int n) {
    for(int i=0; i < n; i++) {
        printf(" %d ", array[i]);
    }
    printf("\n");
}