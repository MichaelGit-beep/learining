#include <stdio.h>

void print_array(int array[], int n);

int main() {
    int N;
    scanf("%d", &N);
    int A[N];    
    for(int i = 0; i < N; i++) {
        scanf("%d", &A[i]);
    }
    int m = 0;
    for(int i = 0; i < N; i++) {
        for(int j = i+1; j < N; j++) {
            if(A[i] * A[j] % 26 == 0) {
                m++;
            }
        }
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

