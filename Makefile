# -*- Makefile -*-
SHELL := /bin/zsh

.DEFAULT_GOAL := build

build:
	mkdocs build
	cp -r ./site/. ./docs
	rm -r site
