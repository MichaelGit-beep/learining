#include <stdio.h>
#define N 6

void print_array(int array[], int n);

int main() {
    int a[N];
    int i, j, k;
     
    for(i = 0; i < N; ++i) {
        scanf("%d", &a[i]);
    }

    k = 0;
    for(i = 0; i < N; ++i) {
        if(a[i] > 100 && a[i] % 5 == 0){
            k++;
        }
    }
    printf("Counter is %d\n", k);
    for(i = 0; i < N; ++i) {
        if(a[i] > 100 && a[i] % 5 == 0){
            a[i] = k;
        }
    }
    print_array(a, N);
}

void print_array(int array[], int n) {
    for(int i=0; i < n; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}