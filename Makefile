# Makefile for compiling main, student.o, and course.o and generating documentation

# Variables for compiler and flags
CC = gcc
CFLAGS = -Wall -Werror -g

# Directories
BUILD_DIR = build
SCRIPTS_DIR = scripts
DOC_DIR = documentation
DOCS_DIR = $(DOC_DIR)/docs
SRC_DIR = src

# Object files
OBJ_FILES = $(BUILD_DIR)/main.o $(BUILD_DIR)/student.o $(BUILD_DIR)/course.o

# Targets
all: $(BUILD_DIR)/main

$(BUILD_DIR)/main: $(OBJ_FILES) | $(DOCS_DIR)
    $(CC) $(CFLAGS) $(OBJ_FILES) -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
    $(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
    mkdir $(BUILD_DIR)

$(DOC_DIR):
    mkdir $(DOC_DIR)

$(DOCS_DIR): | $(DOC_DIR)
    mkdir $(DOCS_DIR)

doxyfile:
    doxygen -g

.PHONY: docs
docs: $(DOCS_DIR) doxyfile
    doxygen Doxyfile

.PHONY: clean
clean:
    rm -rf $(BUILD_DIR)

.PHONY: generate-doxyfile

generate-doxyfile:
    doxygen -g

# Rules for running scripts
scripts/script1:
    sh scripts/script1.sh

scripts/script2:
    sh scripts/script2.sh

# Default target
.DEFAULT_GOAL := all

# Make docs a prerequisite of build/main
$(BUILD_DIR)/main: docs

# New doc target
.PHONY: doc
doc: docs

# Make generate-doxyfile a separate target
.PHONY: generate-doxyfile
