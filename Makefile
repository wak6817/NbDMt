CC = cc
CFLAGS = -Wall -Wextra -O2
CPPFLAGS =

SRC_DIR = src/cli/tools
OUT_DIR = dist/tools
SOURCES = $(wildcard $(SRC_DIR)/*.c)
BINS = $(patsubst $(SRC_DIR)/%.c,$(OUT_DIR)/%,$(SOURCES))
DEPS =

.PHONY: all clean
.DEFAULT_GOAL := all

all: $(BINS)

$(OUT_DIR)/%: $(SRC_DIR)/%.c
	mkdir -p $(OUT_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) $< -o $@

clean:
	rm -rf $(OUT_DIR)
