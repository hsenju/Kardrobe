#	$Id: Makefile.in,v 1.54 2011/10/25 02:18:54 nis Exp $

#
# Copyright (c) 2006 Shingo Nishioka.
# All rights reserved.
#



SHELL=/bin/sh
CC=gcc
CXX=g++
CFLAGS+=-I.
CFLAGS+=-g -O2
#CFLAGS+=-ansi -pedantic
CFLAGS+=-Wall -Wno-parentheses -Wdeclaration-after-statement -g -O
LDFLAGS=
INSTALL=/usr/bin/install -c
LIBS=-ldl 
RANLIB=ranlib
LIBTOOL=$(SHELL) $(top_builddir)/libtool
AR=ar

prefix=/usr/local
includedir=${prefix}/include
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
bindir=${exec_prefix}/bin
top_builddir=.
libexecdir=${exec_prefix}/libexec

RCDDIR=/usr/local/share/examples/rc.d

LINK=$(LIBTOOL) --mode=link $(CXX) $(CFLAGS) $(LDFLAGS)

include config.mk

ifneq ($(ANSI_SOURCE),)
CFLAGS+=-D_BSD_SOURCE
CFLAGS+=-D_POSIX_C_SOURCE=200112L
CFLAGS+=-D_XOPEN_SOURCE=600
CFLAGS+=-D_XOPEN_SOURCE_EXTENDED=1
endif

#CFLAGS+=-DDBG=1

CFLAGS+='-DDEFAULT_STEMMER=MECAB'

CFLAGS+='-DSTMD_MYSTEMMER_DIR="$(bindir)"'

CFLAGS+=$(shell /usr/bin/icu-config --cflags)
CFLAGS+=$(shell /usr/bin/icu-config --cppflags)

LDFLAGS+=$(shell /usr/bin/icu-config --ldflags-searchpath)
LDFLAGS+=$(shell /usr/bin/icu-config --ldflags)

ifneq ($(USECHASEN),)
CFLAGS+='-DUSE_CHASEN=1'
CFLAGS+=$(shell /usr/local/bin/chasen-config --cflags)
LDFLAGS+=$(shell /usr/local/bin/chasen-config --libs)
CHAUTIL=chasenutil.o
endif

ifneq ($(USESNOWBALL),)
CFLAGS+='-DUSE_SNOWBALL=1'
CFLAGS+=-I/usr/local/include
SLIBS+=-lstemmer
LDFLAGS+=-L/usr/local/lib
SNOWBALLUTIL=snowballutil.o
endif

ifneq ($(USEMECAB),)
CFLAGS+='-DUSE_MECAB=1'
CFLAGS+='-DMECABKIHONINDEX=6'
CFLAGS+=$(shell /usr/local/bin/mecab-config --cflags)
LDFLAGS+=$(shell /usr/local/bin/mecab-config --libs)
MECABUTIL=mecabutil.o
endif

ifneq ($(USENSTMS),)
CFLAGS+='-DUSE_NSTMS=1'
CFLAGS+=-I/include
CFLAGS+='-DNSTMSXDIR=""'
CFLAGS+='-DNSTMSXBASE=""'
SLIBS+=-lnstms
LDFLAGS+=-L/lib
NSTMSUTIL=nstmsutil.o
endif

ifneq ($(USEEXTS),)
CFLAGS+='-DUSE_EXTS=1'
#SLIBS+=-lpthread
#EXTSUTIL=extsutil.o
EXTSUTIL=extsutil_sel.o chelate.o
EXTSDBG=extsdbg
endif

ifneq ($(USEPOSTAG),)
CFLAGS+='-DUSE_POSTAG=1'
CFLAGS+=-I/include
CFLAGS+='-DINFDIR="/"'
SLIBS+=-lpostag
LDFLAGS+=-L/lib
POSTAGUTIL=postag_stem.o postagutil.o
endif

ifneq ($(KILL3NUMBER),)
CFLAGS+=-DKILL3NUMBER=1
endif

#ifneq ($(UNIDIC),)
#CFLAGS+=-DENABLE_UNIDIC=1
#endif

ifneq ($(ENABLE_MECAB_OPTS),)
CFLAGS+=-DENABLE_MECAB_OPTS=1
endif

all: libystem.a stmd $(EXTSDBG)

STMDOBJ=stmd.o stmc.o sigflg.o nio.o

stmd: $(STMDOBJ) libystem.a
	$(LINK) -o $@ $(STMDOBJ) -L. $(LDFLAGS) -lystem $(SLIBS) -lexpat $(LIBS)

libystem.a: ystem.o normalizer.o ngram.o $(CHAUTIL) $(SNOWBALLUTIL) $(MECABUTIL) $(NSTMSUTIL) $(EXTSUTIL) $(POSTAGUTIL) jutil.o mapline.o
	-rm -f $@
	$(AR) q $@ $^
	$(RANLIB) $@

ifneq ($(USEEXTS),)
#extsdbg: extsdbg.o
extsdbg: extsdbg.o chelate.o
	$(LINK) -o $@ $^ $(LDFLAGS)
#	$(LINK) -o $@ $^ -lpthread $(LDFLAGS)
#extsdbg.o: extsutil.c
extsdbg.o: extsutil_sel.c
	$(CC) $(CFLAGS) -DSTANDALONE -c -o $@ $^
endif

clean:
	rm -f *.o *.a *.core stmd $(EXTSDBG)

distclean: clean
	rm -f config.h config.mk libtool
	rm -f Makefile stmd-exts.sh
	rm -f rc.d/jp.ac.nii.cs.getassoc.stmd.plist rc.d/stmd rc.d/stmd-sl

install:
	$(INSTALL) -c -m 755 -s stmd $(bindir)
	$(INSTALL) -c -m 755 -s stmd $(bindir)/in.stmd
	$(INSTALL) -c -m 755 -s stmd $(bindir)/stmd.cgi
ifneq ($(USEEXTS),)
	$(INSTALL) -c -m 755 stmd-exts.sh $(bindir)
endif
	$(INSTALL) -c -m 644 ystem.h $(includedir)
	if [ -d $(RCDDIR) ]; then $(INSTALL) -c -m 755 rc.d/stmd $(RCDDIR)/stmd; fi
