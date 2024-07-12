#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int  main(void) {
     pid_t pid1, pid2, pid3;
     
     pid1 = fork();

     printf("pid1 = %d, getpid() = %ld\n", pid1, (long) getpid());
     
     pid2 = fork();

     printf("pid2 = %d, getpid() = %ld\n", pid2, (long) getpid());
     
     pid3 = fork();

     printf("pid3 = %d, getpid() = %ld\n", pid3, (long) getpid());
     
     exit(0);
 }
