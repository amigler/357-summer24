#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {

    FILE *fp = fopen("file.txt", "r");

    //        char *fgets(char *s, int size, FILE *stream);

    char buf[100]; // 100 bytes
    
    // read through the file, print the length of each line
    while (fgets(buf, 100, fp) != NULL) {
        printf("%lu\n", strlen(buf));
    }

    return 0;
}
