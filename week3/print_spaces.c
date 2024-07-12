#include <stdio.h>

int main(int argc, char *argv[]) {

    int count = 10;

    // spaces
    printf("%*s\n", count, "");

    // zeros
    printf("%0*d\n", count, 0);

    return 0;
}
