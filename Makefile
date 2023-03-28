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
STUDENT_OBJ = $(BUILD_DIR)/student.o
COURSE_OBJ = $(BUILD_DIR)/course.o
MAIN_OBJ = $(BUILD_DIR)/main.o

# Targets
all: $(BUILD_DIR)/main

$(BUILD_DIR)/main: $(MAIN_OBJ) $(STUDENT_OBJ) $(COURSE_OBJ) | $(DOCS_DIR)
	$(CC) $(CFLAGS) $(MAIN_OBJ) $(STUDENT_OBJ) $(COURSE_OBJ) -o $@

$(MAIN_OBJ): $(SRC_DIR)/main.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(STUDENT_OBJ): $(SRC_DIR)/student.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(COURSE_OBJ): $(SRC_DIR)/course.c | $(BUILD_DIR)
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
