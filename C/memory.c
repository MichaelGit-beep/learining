#include <stdio.h>
#include <stdlib.h>

int main() {
    int* var_i;
    for(int i = 0; i < 5; i++) {
        var_i = malloc(1000000000*sizeof(int));
        for(int j = 0; j < 100; j++){
            var_i[j] = j;
            printf("%d\n", var_i[j]);
        }
        printf("%p\n", var_i); 
        free(var_i);
        if(NULL == var_i) {
            printf("Failed to allocate memory\n");
            exit(1);
       }
    }
    system("pause");
    return 0;
}