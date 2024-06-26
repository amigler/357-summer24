#include <stdio.h>
#include <stdlib.h>

// function declaration
// int power(int base, int n);

// function definition
// power: raise base to n-th power; n >= 0
unsigned int power(unsigned int base, unsigned int n) {
    unsigned int i;
    unsigned int p;
    p = 1;
    for (i = 1; i <= n; ++i) {
        p = p * base;
    }
    return p;
}


int main(int argc, char *argv[]) {
    printf("Computing: %s^%s\n", argv[1], argv[2]);
    unsigned int result = power(atoi(argv[1]), atoi(argv[2]));
    printf("%u\n", result);
    return 0;
}

