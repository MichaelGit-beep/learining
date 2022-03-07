#include <stdio.h>

int main() {
    int arr[] = {0, 1, 2, 3, 4, 5};
    // printf("%d", arr[0]);

    float numbers[3];
    numbers[0] = 4.23f;
    numbers[1] = 5.23f;
    numbers[2] = 6.23f;
    // printf("%.2f\n", numbers[0]);

    char word[] = {'s', 'o', 'm', 'e'};
    
    char words[] = "Hello World!\n";
    printf("%c\n", word[0]);
    printf("%s", words);
     
    int size = 3;
    int second_size = 3;
    int array[3][3] = {
        {1,2,3},
        {4,5,6},
        {7,8,9}
    };
    
    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
            printf("%d\n", array[i][j]);
        }
    }
    
    return 0;
}