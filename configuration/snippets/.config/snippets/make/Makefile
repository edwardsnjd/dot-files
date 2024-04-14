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

.PHONY: error
error:
	@echo "Type make<TAB><TAB> to see the available targets"
