
#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "usage: cat <file>\n");
        return 1;
    }

    for (int i = 1; i < argc; i++)
    {
        FILE *file = fopen(argv[i], "r");

        if (file == NULL)
        {
            perror(argv[i]);
            continue;
        }

        int c;

        while ((c = fgetc(file)) != EOF)
        {
            putchar(c);
        }

        fclose(file);
    }

    return 0;
}
