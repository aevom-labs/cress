# SPDX-License-Identifier: GPL-3.0-or-later
# Derived from pdp7-unix. See NOTICE at the project root for more informaiton.
# Copyright (c) 2026 Aevom Contributors

# Build the kernel, the utilities, the filesystem and run SimH

include os.mk

# tools
AS=../tools/as7
ASARGS=--format=ptr
MKFS=../tools/mkfs7
A7OUT=../tools/a7out 
FSCK=../tools/fsck7
CCARGS=-Wno-multichar -Wno-implicit
PDP7?=pdp7

# source dirs
SYSSRC=../src/sys
CMDSRC=../src/cmd
TESTSRC=../tests

# targets
BINDIR=bin
TESTDIR=tests
BINARIES=../bin

all: cmd a.out boot.rim image.fs

# The run rule has no dependencies so that the system can be booted easily
# and frequently with make run. However, you have to manually make all first!
run:
	$(PDP7) unixv0.simh

dist: all
	mkdir -p $(BINARIES)
	mkdir -p $(BINARIES)/orig
	mkdir -p $(BINARIES)/alt
	cp image.fs $(BINARIES)/orig
	cp boot.rim $(BINARIES)/orig
	cp a.out $(BINARIES)/orig
	cp unixv0.simh $(BINARIES)/orig

# Warm boot Unix kernel: boots into init and a login prompt
SYS=	$(SYSSRC)/sop.s $(SYSSRC)/s1.s $(SYSSRC)/s2.s \
	$(SYSSRC)/s3.s $(SYSSRC)/s4.s $(SYSSRC)/s5.s \
	$(SYSSRC)/s6.s $(SYSSRC)/s7.s $(SYSSRC)/s8.s
a.out:	$(SYS)
	$(AS) -f ptr  -o a.out $(SYSSRC)/sop.s $(SYS)
	$(AS) -n -f list -o a.lst $(SYSSRC)/sop.s $(SYS)

# Phil's bootstrap code
boot.rim: $(SYSSRC)/sop.s $(SYSSRC)/pbboot.s
	$(AS) -f rim -o boot.rim $(SYSSRC)/sop.s $(SYSSRC)/pbboot.s

# Cold boot Unix kernel: attempts to build a minimal filesystem.
# Don't use this one!
COLDBOOT=$(SYS) $(SYSSRC)/s9.s
coldboot.rim: $(COLDBOOT)
	$(AS) -f rim  -o coldboot.rim $(COLDBOOT)
	$(AS) -n -f list -o a.lst $(COLDBOOT)

# Filesystem image
image.fs: cmd a.out chrtbl.out
	$(MKFS) -k a.out -c chrtbl.out proto
	$(FSCK) image.fs

# character table: assemble output of cas.s
chrtbl.out: cas.out $(CMDSRC)/chrtbl.s
	$(AS) -f ptr --no-label-warnings -o chrtbl.out $(CMDSRC)/chrtbl.s cas.out

# run cas.s under a7out: needs local file!
cas.out: bin/cas $(SYSSRC)/cas.in
	rm -f cas.in
	ln -s ../src/sys/cas.in .
	$(A7OUT) bin/cas cas.out cas.in
	rm -f cas.in

clean:
	rm -f boot.rim image.fs a.lst n.out a.out
	rm -f cas cas.in cas.out chrtbl.out
	rm -rf $(BINDIR) $(TESTDIR)
	rm -rf $(BINARIES)

dirs:
	mkdir -p $(BINDIR)

# The commands that came from the original scans
# PLEASE KEEP IN ALPHABETICAL ORDER!
cmd:	dirs \
	$(BINDIR)/adm \
	$(BINDIR)/ald \
	$(BINDIR)/apr \
	$(BINDIR)/as \
	$(BINDIR)/cas \
	$(BINDIR)/cat \
	$(BINDIR)/check \
	$(BINDIR)/chmod \
	$(BINDIR)/chown \
	$(BINDIR)/chrm \
	$(BINDIR)/cp \
	$(BINDIR)/db \
	$(BINDIR)/ds \
	$(BINDIR)/dskres \
	$(BINDIR)/dsksav \
	$(BINDIR)/dsw \
	$(BINDIR)/ed \
	$(BINDIR)/init \
	$(BINDIR)/ln \
	$(BINDIR)/ls \
	$(BINDIR)/nm \
	$(BINDIR)/rm \
	$(BINDIR)/rn \
	$(BINDIR)/roff \
	$(BINDIR)/salv \
	$(BINDIR)/sh \
	$(BINDIR)/stat \
	$(BINDIR)/tm \
	$(BINDIR)/un

$(BINDIR)/adm: $(CMDSRC)/adm.s
	$(AS) $(ASARGS) -o $(BINDIR)/adm $(CMDSRC)/adm.s

$(BINDIR)/ald: $(CMDSRC)/ald.s
	$(AS) $(ASARGS) -o $(BINDIR)/ald $(CMDSRC)/ald.s

$(BINDIR)/apr: $(CMDSRC)/apr.s
	$(AS) $(ASARGS) -o $(BINDIR)/apr $(CMDSRC)/apr.s

$(BINDIR)/as: $(CMDSRC)/as.s
	$(AS) $(ASARGS) -o $(BINDIR)/as $(CMDSRC)/as.s

$(BINDIR)/cat: $(CMDSRC)/cat.s
	$(AS) $(ASARGS) -o $(BINDIR)/cat $(CMDSRC)/cat.s

$(BINDIR)/check: $(CMDSRC)/check.s
	$(AS) $(ASARGS) -o $(BINDIR)/check $(CMDSRC)/check.s

$(BINDIR)/chmod: $(CMDSRC)/chmod.s
	$(AS) $(ASARGS) -o $(BINDIR)/chmod $(CMDSRC)/chmod.s

$(BINDIR)/chown: $(CMDSRC)/chown.s
	$(AS) $(ASARGS) -o $(BINDIR)/chown $(CMDSRC)/chown.s

$(BINDIR)/chrm: $(CMDSRC)/chrm.s
	$(AS) $(ASARGS) -o $(BINDIR)/chrm $(CMDSRC)/chrm.s

$(BINDIR)/cas: $(CMDSRC)/cas.s
	$(AS) $(ASARGS) -o $(BINDIR)/cas $(CMDSRC)/cas.s

$(BINDIR)/cp: $(CMDSRC)/cp.s
	$(AS) $(ASARGS) -o $(BINDIR)/cp $(CMDSRC)/cp.s

$(BINDIR)/db: $(CMDSRC)/db.s
	$(AS) $(ASARGS) -o $(BINDIR)/db $(CMDSRC)/db.s

$(BINDIR)/dmabs: $(CMDSRC)/dmabs.s
	$(AS) $(ASARGS) -o $(BINDIR)/dmabs $(CMDSRC)/dmabs.s

$(BINDIR)/ds: $(CMDSRC)/ds.s
	$(AS) $(ASARGS) -o $(BINDIR)/ds $(CMDSRC)/ds.s

DSKRES=$(CMDSRC)/dskres.s $(CMDSRC)/dskio.s $(SYSSRC)/sop.s
$(BINDIR)/dskres: $(DSKRES)
	$(AS) $(ASARGS) -o $(BINDIR)/dskres $(DSKRES)

DSKSAV=$(CMDSRC)/dsksav.s $(CMDSRC)/dskio.s $(SYSSRC)/sop.s
$(BINDIR)/dsksav: $(DSKSAV)
	$(AS) $(ASARGS) -o $(BINDIR)/dsksav $(DSKSAV)

$(BINDIR)/dsw: $(CMDSRC)/dsw.s
	$(AS) $(ASARGS) -o $(BINDIR)/dsw $(CMDSRC)/dsw.s

ED=$(CMDSRC)/ed1.s $(CMDSRC)/ed2.s
$(BINDIR)/ed: $(ED)
	$(AS) $(ASARGS) -o $(BINDIR)/ed $(ED)

$(BINDIR)/init: $(CMDSRC)/init.s
	$(AS) $(ASARGS) -o $(BINDIR)/init $(CMDSRC)/init.s

$(BINDIR)/ln: $(CMDSRC)/ln.s
	$(AS) $(ASARGS) -o $(BINDIR)/ln $(CMDSRC)/ln.s

$(BINDIR)/ls: $(CMDSRC)/ls.s
	$(AS) $(ASARGS) -o $(BINDIR)/ls $(CMDSRC)/ls.s

$(BINDIR)/nm: $(CMDSRC)/nm.s
	$(AS) $(ASARGS) -o $(BINDIR)/nm $(CMDSRC)/nm.s

$(BINDIR)/rm: $(CMDSRC)/rm.s
	$(AS) $(ASARGS) -o $(BINDIR)/rm $(CMDSRC)/rm.s

$(BINDIR)/rn: $(CMDSRC)/rn.s
	$(AS) $(ASARGS) -o $(BINDIR)/rn $(CMDSRC)/rn.s

$(BINDIR)/pd: $(CMDSRC)/pd.s
	$(AS) $(ASARGS) -o $(BINDIR)/pd $(CMDSRC)/pd.s

$(BINDIR)/roff: $(CMDSRC)/roff.s
	$(AS) $(ASARGS) -o $(BINDIR)/roff $(CMDSRC)/roff.s

$(BINDIR)/salv: $(CMDSRC)/salv.s
	$(AS) $(ASARGS) -o $(BINDIR)/salv $(CMDSRC)/salv.s

$(BINDIR)/sh: $(CMDSRC)/sh.s
	$(AS) $(ASARGS) -o $(BINDIR)/sh $(CMDSRC)/sh.s

$(BINDIR)/stat: $(CMDSRC)/stat.s
	$(AS) $(ASARGS) -o $(BINDIR)/stat $(CMDSRC)/stat.s

$(BINDIR)/tm: $(CMDSRC)/tm.s
	$(AS) $(ASARGS) -o $(BINDIR)/tm $(CMDSRC)/tm.s

$(BINDIR)/un: $(CMDSRC)/un.s
	$(AS) $(ASARGS) -o $(BINDIR)/un $(CMDSRC)/un.s

tests:
	mkdir -p $(TESTDIR)
	$(AS) $(ASARGS) -o $(TESTDIR)/decimal_out  $(TESTSRC)/decimal_out.s	
	$(AS) $(ASARGS) -o $(TESTDIR)/fork_test    $(TESTSRC)/fork_test.s	
	$(AS) $(ASARGS) -o $(TESTDIR)/octal_test   $(TESTSRC)/octal_test.s	
	$(AS) $(ASARGS) -o $(TESTDIR)/testmul      $(TESTSRC)/testmul.s
	$(AS) $(ASARGS) -o $(TESTDIR)/write_test   $(TESTSRC)/write_test.s

runtests: tests
	$(A7OUT) $(TESTDIR)/decimal_out
	$(A7OUT) $(TESTDIR)/fork_test
	$(A7OUT) $(TESTDIR)/octal_test
#	$(A7OUT) $(TESTDIR)/testmul
#	$(A7OUT) $(TESTDIR)/write_test


