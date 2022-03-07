#include <stdio.h>
#include <string.h>

struct Car {
    int speed;
    char name[50];
    char model[2];
    float weight;
};

int main() {
    struct Car bmw;
    bmw.speed = 250;
    strcpy(bmw.name, "MyCar");
    strcpy(bmw.model, "M5");
    bmw.weight = 2500.00f;

    struct Car audi = {300, "Audi", "A8", 800.00f};
    printf("Car #1 name: %s\nSpeed: %d\n\n", bmw.name, bmw.speed);
    printf("Car #2 name: %s\nSpeed: %d\n", audi.name, audi.speed);
    return 0;
}