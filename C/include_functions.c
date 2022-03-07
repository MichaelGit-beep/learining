#include "module\func.h"

// void some_func(void);
// int sum(int a, int b);
// void string(char arr[]);


int main() {
    some_func();
    second_func('d');
    third_func();

    int x = sum(5, 6);
    printf("Returned value from func sum is %d\n", x);
    int y = sum(x, 10);
    printf("Returned value from func sum is %d\n", y);

    char one[] = {'H', 'I'};
    char many[] = "Hey!";
    string(many);

    return 0;
}

// void some_func() {
//     printf("First func\n");
// }

// int sum(int a, int b) {
//     int res = a + b;
//     return res;
// }


// void string(char arr[]) {
//     for (int i = 0; i < 13; i++)
//         printf("%c", arr[i]);
//     printf("\n");
// }