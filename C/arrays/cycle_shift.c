#include <stdio.h>
#define N 10
void print_array(int array[], int n);

int main() {
    int a[N];
    for(int i=0; i<N; i++) {
        a[i] = i * 100; 
    }
    print_array(a, N);

    // Circular shift 
    // int tmp = a[0];
    // for(int i=0; i < N-1; i++) {
    //     a[i] = a[i+1];
    // }
    // a[N-1] = tmp;

    
    // inverse Circular shift
    int tmp = a[N-1];
    for(int i = 0; i < N-1; i++) {
        a[N-1-i] = a[N-2-i];
        print_array(a, N);
    }
    a[0] = tmp;
    print_array(a, N);
    return 0;
}

void print_array(int array[], int n) {
    for(int i=0; i < n; i++) {
        printf(" %d ", array[i]);
    }
    printf("\n");
}