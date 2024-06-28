#include <stdio.h>


int main(int argc, char *argv[]) {

    int i = 357;
    int *ip = &i;

    void *vp;

    printf("sizeof(i) = %lu\n", sizeof(i));
    
    printf("sizeof(ip) = %lu\n", sizeof(ip));
    printf("sizeof(vp) = %lu\n", sizeof(vp));

    printf("sizeof(*ip) = %lu\n", sizeof(*ip));
    printf("sizeof(*vp) = %lu\n", sizeof(*vp));

    
    printf("i = %i\n", i);
    printf("ip = %p\n", ip);
    printf("*ip = %i\n", *ip);

    printf("*ip++ = %i\n", *ip++);  // display the "current" value at ip address, add sizeof(int) to ip
    printf("ip = %p\n", ip);  
    printf("*ip = %i\n", *ip);

    
}
