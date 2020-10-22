# -*- Makefile -*-
SHELL := /bin/zsh

.DEFAULT_GOAL := build

build:
	mkdocs build
