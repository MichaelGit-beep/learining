#include <stdio.h>


void insert_sort(int A[], int N);

int main() {
    int N = 5;
    int arr[5] = {250, 300, 100, 20, 0};
    insert_sort(arr, 5);

    for (int i = 0; i < 5; i++) {        
            printf("%d\n", arr[i]);
    }
    
    return 0;
}


void insert_sort(int A[], int N) {
    for(int i = 1; i < N; ++i) {
        int k = i;
        while (k > 0 && A[k-1] > A[k])
        {
            int tmp = A[k-1];
            A[k-1] = A[k];
            A[k] = tmp;
            k -= 1;
        }
    }
}