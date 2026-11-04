//
// Created by wak6817 on 04/11/2026.
//

#include "proj.h"

#include <sys/stat.h>
#include <stdio.h>

void gen_proj_c() {
    create_dir("src");
    create_dir("include");
    create_dir("scripts");

    create_file(".clang-format");
    create_file(".clang-tidy");

    create_file("LICENSE");
    create_file("README.md");
    create_file("CONTRIBUTING.md");
    create_file(".gitignore");
}

int create_dir(const char *name) {
    return mkdir(name, 0755);
}

int create_file(const char *name) {
    FILE *file = fopen(name, "w");

    if (file == NULL) {
        return -1;
    }

    fclose(file);
    return 0;
}
