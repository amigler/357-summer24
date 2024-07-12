#include <stdio.h>
#include <stdlib.h>


struct dir_entry {
    int inode;
    char *name;
};

int f2(int *i) {
    int j;
    j = *i;
    return j;
}

// create directory entry from inode new_name, name new_name
struct dir_entry *create_dir_entry(int new_inode, char *new_name) {
    struct dir_entry *de_ptr = malloc(sizeof(struct dir_entry));

    de_ptr->inode = new_inode;
    de_ptr->name = new_name;

    return de_ptr;
}

int main()
{
    struct dir_entry *de1;
    
    de1 = create_dir_entry(10, "test_dir");

    printf("inode: %d, name: %s\n", de1->inode, de1->name);

    free(de1);
    
    return 0;
}
