#include <stdio.h>

int main() {
    char buffer[255];

    FILE *file;
    file = fopen("opened_hello.txt", "r");

    fgets(buffer, 255, file);
    
    printf("%s", buffer);
    fclose(file);
}