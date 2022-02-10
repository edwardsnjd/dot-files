# Sanity
# From: https://tech.davis-hansson.com/p/make/

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Paths

FOO_DIR := import

FOOS := $(shell find $(FOO_DIR) -type f -name "*.csv" | sort)

# Convenience targets

.PHONY : all help clean touch list

all: reports

help:
	@echo "Targets:"
	@echo "- all (default) = generate all journals and reports"
	@echo "- reports = generate all reports"
	@echo "- clean = delete generated files"
