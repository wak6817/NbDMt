#include <stdio.h>

int main(int argc, char const *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "usage: echo <text>\n");
        return 1;
    }

    printf("%s\n", argv[1]);
    return 0;
}
