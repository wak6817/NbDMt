cmake_minimum_required(VERSION 4.3)
project(NbDMt C)

set(CMAKE_C_STANDARD 11)

add_executable(NbDMt
        src/cli/main.c
        src/cli/cmd/help/help.c
        src/cli/cmd/help/help.h
        src/cli/main.c
        src/cli/main.h
        src/cli/cmd/gen/proj/c/proj.c
        src/cli/cmd/gen/proj/c/proj.h)
