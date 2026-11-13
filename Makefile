# SPDX-License-Identifier: GPL-3.0-or-later
# Derived from pdp7-unix. See NOTICE at the project root for more informaiton.
# Copyright (c) 2026 Aevom Contributors

include build/os.mk

.PHONY: all build run clean bin

all: build

build:
	cd build && $(MAKE) all

run: build
	cd build && $(MAKE) run

clean:
	cd build && $(MAKE) clean

bin: build
	mkdir -p bin
	cp build/image.fs bin/
	cp build/boot.rim bin/
	cp build/unixv0.simh bin/

