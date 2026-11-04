//
// Created by wak6817 on 04/11/2026.
//

#include "main.h"
#include "cmd/help/help.h"

#include <stdio.h>
#include <string.h>

#define MAIN_IN argv[1]

int main(const int argc, char *argv[]) {
    if (argc < 2) {
        printf("usage: nbdmt <action> (err. NO_ARGS)\n");
        return 1;
    }

    return check_command(MAIN_IN);
}

static int check_command(const char command[]) {
    if (strcmp(command, "help") == 0) {
        disp_help();
    } else {
        printf("usage: nbdmt <action> (err. UK_CMD)\n");
    }

    return 0;
}
