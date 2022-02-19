#include <stdio.h>

int main() {
    // for loop
    int x = 10;
    for (int i = 0; i < 10; i++) {
        printf("New value of i variable is %d\n", i);
    }

    // while loop
    while(x < 20) {
        printf("x value is %d\n", x);
        x++;
    }

    // do loop
    do {
        x++;
        printf("New value of x is %d\n", x);
    } while(x < 20);

    int arr[] = {100, -20, 300, 999};
    int min = 0, max = 0;
    for(int i = 0; i < 5; i++) {
        if(arr[i] < min) {
            min = arr[i];
        }
        if(arr[i] > max) {
            max = arr[i];
        }
    }
    printf("Maximum value is %d\nMinimum value is %d\n", max, min);
}