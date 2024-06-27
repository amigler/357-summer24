#include <stdio.h>

// read characters one-at-a-time from stdin, print each one out
int main(int argc, char* argv[]) {

    // this declaration is automatically provided in stdio.h
    // FILE *stdin;
    
    int c = getc(stdin);
    printf("the char: %c\n", c);
    
}
