#include <stdio.h>
#include <unistd.h>

#define BUFSIZE 500

void main(void) {

    int pipefd[2];

    // from man 3 pipe:
    // pipefd[0] refers to the read end of the pipe.  pipefd[1] refers to the write end of the pipe.  Data written to the write  end
    // of the pipe is buffered by the kernel until it is read from the read end of the pipe
    pipe(pipefd);

    printf("PID %d, before calling fork()\n", getpid());
    
    pid_t pid = fork();
    if (pid < 0) {
        printf("fork error\n");
    } else if (pid == 0) {
        // in child process, redirect stdout, call exec()
        close(STDOUT_FILENO);
        dup(pipefd[1]);
        close(pipefd[0]);  // close read end of pipe (parent reads, child writes)
        
        //char *my_argv[] = { "ls", "-l", (char*) 0 };
        //execv("/bin/ls", my_argv);

        char *my_argv[] = { "./mypid", (char*) 0 };
        execv("./mypid", my_argv);
        
    } else {
        // in parent process, read from pipe
        close(pipefd[1]);  // close write end of the pipe (parent reads, child writes)
        // parent process, read from pipe, echo output:
        char buf[BUFSIZE+1];
        int bc = 0;
        while ((bc = read(pipefd[0], buf, BUFSIZE)) > 0) {
            buf[bc] = '\0';
            printf("[PID %d read %d bytes from pipe]\n%s\n", getpid(), bc, buf);
        }
    }
    
}
