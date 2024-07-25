#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int func(int a, int *ip) {
    *ip = a;

    pid_t pid3;
    pid3 = fork();

    printf("pid3 = %d, getpid() = %ld\n", pid3, (long) getpid());

    pause();
    
    return a * 2;
}

int main(void) {
     pid_t pid1, pid2;
     int a = 3, b = 5, c = 7;
     int *ip = malloc(sizeof(int));
     
     pid1 = fork();

     printf("pid1 = %d, getpid() = %ld\n", pid1, (long) getpid());

     c = 357;

     func(7, ip);
     
     pid2 = fork();

     printf("pid2 = %d, getpid() = %ld\n", pid2, (long) getpid());
     
     pause();
     
     // diagram all running processes as of this point
     
     exit(0);
 }
