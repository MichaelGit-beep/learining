#include <stdio.h>

void print_array(int array[], int n);

int main() {
    int N;
    scanf("%d", &N);
    
    
    int m = 0;
    for(int i = 0; i < N; i++) {
        int x;
        scanf("%d", &x);
    }
    printf("%d", m);
    // print_array(A, N);
}


void print_array(int array[], int n) {
    for(int i=0; i < n; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}

