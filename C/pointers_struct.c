
#include <stdio.h>
#include <string.h>

struct Abstract {
    int width, height;
};

int calculate(struct Abstract *x);

int main() {
    struct Abstract square = {20, 20};
    int y = calculate(&square);
    int *c = &y;
    printf("Area of the square is %d\n", y);
    return 0;
}

int calculate(struct Abstract *x) {
    return x->width * x->height;
}
