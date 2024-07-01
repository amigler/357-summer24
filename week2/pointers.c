#include <stdio.h>
#include <stdlib.h>  // for EXIT_SUCCESS

int main(int argc, char* argv[]) {
    char vowels[] = { 'a', 'e', 'i', 'o', 'u' };
    char next_str[] = "these are not vowels";

    char *v = &vowels[0];
    char *v_str = vowels;

    printf("Pointer: %p, value: %c\n", v, *v);
    printf("Pointer: %p, value: %c\n", v+1, *(v+1));

    printf("As a string: %s\n", v_str); 
}
