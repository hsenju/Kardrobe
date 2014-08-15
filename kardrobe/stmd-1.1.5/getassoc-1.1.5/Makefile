#	$Id: Makefile.in,v 1.209 2011/10/24 09:59:20 nis Exp $

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
LIBS=-ldl -lm 
YACC=bison -y
RANLIB=ranlib
LIBTOOL=$(SHELL) $(top_builddir)/libtool
AR=ar

prefix=/data/lib/geta
includedir=${prefix}/include
datadir=${prefix}/share
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
bindir=${exec_prefix}/bin
libexecdir=${exec_prefix}/libexec
top_builddir=.

include config.mk

LINK=$(LIBTOOL) --mode=link $(CXX) $(CFLAGS) $(LDFLAGS)

ifeq ($(ENABLE_DARWIN_DLSIM),)
SO_EXT=so
DLS_EXT=so
else
SO_EXT=dylib
DLS_EXT=bundle
NWAM_MAJOR=1
NWAM_MINOR=1
NWAM_RELEASE=5
endif

include rules.mk

DATADIRNAME=getassoc
ifneq ($(ENABLE_NEWLAYOUT),)
BIN=$(bindir)
LIBEXEC=$(libexecdir)/getassoc
CFLAGS+='-DLIBEXEC="$(LIBEXEC)"'
CFLAGS+='-DDATADIR="$(datadir)/getassoc"'
else
BIN=${prefix}/wbin
LIBEXEC=${prefix}/wbin
CFLAGS+='-DLIBEXECDIRNAME="wbin"'
CFLAGS+='-DXDATADIRNAME="share/getassoc"'
endif
#### XXX / => directory_delimiter

ifneq ($(ANSI_SOURCE),)
CFLAGS+=-D_BSD_SOURCE
CFLAGS+=-D_POSIX_C_SOURCE=200112L
CFLAGS+=-D_XOPEN_SOURCE=600
CFLAGS+=-D_XOPEN_SOURCE_EXTENDED=1
endif

ifeq ($(ENABLE_GETA),)
ifneq ($(ENABLE_UTF32FSS),)
CFLAGS+=-DFLWD_UTF32=1
CFLAGS+=-DCACHE_PREFETCH=1
endif
ifneq ($(ENABLE_RIGIDSTRCMP),)
CFLAGS+=-DRIGIDSTRCMP=1
endif
ifneq ($(ENABLE_INDEXP),)
CFLAGS+=-DENABLE_INDEXP=1
endif
ifneq ($(ENABLE_NEWLAYOUT),)
CFLAGS+=-DENABLE_NEWLAYOUT=1
endif
ifneq ($(ENABLE_UNIQUIFY),)
CFLAGS+=-DENABLE_UNIQUIFY=1
endif
endif
CFLAGS+=-DENABLE_RAWVECLEN_LIMIT=1

CFLAGS+='-DPREFIX="/data/lib/geta"'
CFLAGS+='-DBIN_PAX="/usr/bin/pax"'
CFLAGS+='-DBIN_MV="/bin/mv"'
CFLAGS+='-DBIN_RM="/bin/rm"'
CFLAGS+='-DBIN_UNCOMPRESS=""'
CFLAGS+='-DBIN_GZIP="/bin/gzip"'
CFLAGS+='-DBIN_BZIP2="/usr/bin/bzip2"'

CFLAGS+=$(shell /usr/bin/icu-config --cflags)
CFLAGS+=$(shell /usr/bin/icu-config --cppflags)

LDFLAGS+=$(shell /usr/bin/icu-config --ldflags-searchpath)
#LDFLAGS+=$(shell /usr/bin/icu-config --ldflags)

ifneq ($(SGETAROOT),)
CFLAGS+='-DSTATIC_GETAROOT="$(SGETAROOT)"'
endif
#CFLAGS+=-DENV_GETAROOT
CFLAGS+='-DSTMDBIN="/usr/local/bin/stmd"'
CFLAGS+='-DSTMDHOST="localhost"'
CFLAGS+='-DSTMDSERV="stmd"'
CFLAGS+='-DSTMDLOCALSOCKET="/tmp/stmd.sock"'
CFLAGS+='-DRN_METADB_URL=""'
CFLAGS+='-DCSTMPATH="/stmd/"'
CFLAGS+='-DCSTMHOST="localhost"'
CFLAGS+='-DCSTMSERV="80"'

ifneq ($(ENABLE_ALLOWERROR),)
CFLAGS+=-DALLOW_ERROR=1000000
endif

CFLAGS+=-I/usr/local/include
CFLAGS+=-I/usr/include

ESHKDIR=

ifneq ($(ESHKDIR),)
CFLAGS+=-I
CFLAGS+=-DHAVE_ESHK_H=1
endif

XFSSNCPU=

ifneq ($(XFSSNCPU),)
CFLAGS+=-DXFSS_NCPU=$(XFSSNCPU)
endif

ifeq ($(ENABLE_GETA),)
LIBS+=-L. -lnwam
else
CFLAGS+=-I${includedir}
LIBS+=-L${libdir} -ldw -ldwut
CFLAGS+=-DENABLE_GETA=1
CFLAGS+=-DMKRI_NCPU=1
endif
LIBS+=$(shell /usr/bin/icu-config --ldflags)
LIBS+=-L/usr/lib -lexpat
LIBS+=-lm

#LIBS+=-lgmp

ifneq ($(XFORK),)
CFLAGS+=-DX_FORK=1
endif

ifneq ($(XPTHREAD),)
CFLAGS+=-DX_PTHREAD=1
endif

RN=
ifneq ($(ENABLE_REN),)
CFLAGS+=-DENABLE_REN=1
RN=rn/rn.js
endif

ifneq ($(ENABLE_PROXY),)
CFLAGS+=-DENABLE_PROXY=1
endif

MKRI=mkri
ITB2FRQ=itb2frq
ifeq ($(ENABLE_GETA),)
LIBNWAM_A=libnwam.a
MKRI=
ITB2FRQ=
SCOMP=
LIBDIR=${prefix}/lib
ifneq ($(ENABLE_SHARED),)
CFLAGS+=-fPIC -fno-common
ifeq ($(ENABLE_DARWIN_DLSIM),)
LIBNWAM_SO=libnwam.$(SO_EXT)
SHLDFLAG=-shared
LDFLAGS+=-L$(LIBDIR) -Wl,--rpath=$(LIBDIR)
else
LIBNWAM_SO=libnwam.$(NWAM_MAJOR).$(NWAM_MINOR).$(NWAM_RELEASE).$(SO_EXT)
LIBNWAM_SO_PLAIN=libnwam.$(SO_EXT)
LIBNWAM_SO_MAJOR=libnwam.$(NWAM_MAJOR).$(SO_EXT)
SHLDFLAG=-dynamiclib -Wl,-install_name,$(LIBDIR)/$(LIBNWAM_SO),-compatibility_version,$(NWAM_MAJOR).$(NWAM_MINOR),-current_version,$(NWAM_MAJOR).$(NWAM_MINOR).$(NWAM_RELEASE),$(LIBS) -lc
LDFLAGS+=-L$(LIBDIR) -Wl,-rpath,$(LIBDIR)
endif
endif
ifneq ($(ENABLE_DLSIM),)
DLSIMDIR=${prefix}/lib
CFLAGS+=-DENABLE_DLSIM=1
CFLAGS+=-fPIC -fno-common
CFLAGS+='-DDLS_DIRNAME="$(DLSIMDIR)"'
CFLAGS+='-DDLS_EXT=".$(DLS_EXT)"'
CFLAGS+='-DDLSFN_PREFIX="DLSIM_FN_"'
SCOMP=simcomp
ifeq ($(ENABLE_DARWIN_DLSIM),)
DLLDFLAG=-shared
else
DLLDFLAG=-Wl,-bundle,-flat_namespace,-undefined,suppress
endif
endif
endif

ifneq ($(ENABLE_LP64),)
CFLAGS+=-DENABLE_LP64=1
endif

ifneq ($(ENABLE_MDBG),)
CFLAGS+=-DENABLE_MDBG=1
endif

ifneq ($(ENABLE_DB),)
CFLAGS+=-DENABLE_DB=1
endif

SP=sp
SP=

all: $(LIBNWAM_A) $(LIBNWAM_SO) getassoc xgetassoc tgetassoc stp $(ITB2FRQ) $(MKRI) dumpri otmi2itb tsv2itb $(RN) $(SP) $(SCOMP) wtouch

COMOBJ=xstem.o cstem.o http.o nnet.o text2vec.o print.o \
	smartaa.o assv.o simdef.o simv.o hd.o \
	mapfile.o readln.o nio.o \
	splitv.o fss.o xstrcmp.o brsearch.o timer.o

ifeq ($(ENABLE_GETA),)
GA_COMOBJ=
NW_COMOBJ=$(COMOBJ)
else
GA_COMOBJ=$(COMOBJ)
NW_COMOBJ=
endif

SORT_PCOMPAR=xsort_pcompar.o tpsort_pcompar.o

GAOBJ=gss3.o sct.o rn.o common.o \
	gorjparse.o cxml.o \
	$(GA_COMOBJ) downsample.o \
	maxrlimit.o nstring.o strip2.o 1342.o

NWOBJ=nwam.o ncs.o xgserv.o \
	$(NW_COMOBJ) ncompar.o \
	nht.o nvmt.o nwdb.o diag.o bx.o bxutil.o priq.o marshal.o nrpc.o \
	mkri.o fsort.o pi.o sigflg.o \
	$(SORT_PCOMPAR)

ifeq ($(ENABLE_GETA),)
$(LIBNWAM_A): $(NWOBJ)
	-rm -f $@
	$(AR) q $@ $^
	$(RANLIB) $@
ifneq ($(ENABLE_SHARED),)
$(LIBNWAM_SO): $(NWOBJ)
	-rm -f $@
	$(CC) -o $@ $^ $(SHLDFLAG)
	mkdir -p $(LIBDIR)
#	$(INSTALL) -c -m 555 $(LIBNWAM_SO) $(LIBDIR)
#ifneq ($(LIBNWAM_SO_MAJOR),)
#	rm -f $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
#	ln -s $(LIBNWAM_SO) $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
#	rm -f $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
#	ln -s $(LIBNWAM_SO) $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
#endif
#ifneq ($(LIBNWAM_SO_PLAIN),)
#	if [ ! -e $(LIBDIR)/$(LIBNWAM_SO_PLAIN) ] ; then ln -s $(LIBNWAM_SO) $(LIBDIR)/$(LIBNWAM_SO_PLAIN); fi
#endif
endif
endif

getassoc: getassoc.o $(GAOBJ) $(LIBNWAM_A) $(LIBNWAM_SO)
	$(LINK) -o $@ getassoc.o $(GAOBJ) $(LDFLAGS) $(LIBS)

xgetassoc: xgetassoc.o $(GAOBJ) $(LIBNWAM_A) $(LIBNWAM_SO)
	$(LINK) -o $@ xgetassoc.o $(GAOBJ) $(LDFLAGS) $(LIBS)

tgetassoc: tgetassoc.o $(GAOBJ) $(LIBNWAM_A) $(LIBNWAM_SO)
	$(LINK) -o $@ tgetassoc.o $(GAOBJ) $(LDFLAGS) $(LIBS)

stp: stp.o cata.o traverse.o archive.o sutil.o systemv.o \
	readln.o maxrlimit.o splitv.o strip2.o diag.o xchar.o timer.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

ifneq ($(ENABLE_GETA),)
itb2frq: itb2frq.o xstem.o nnet.o readln.o nio.o diag.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)
endif

mkri.o: mkri.c timer.o
	$(CC) -c -o $@ mkri.c $(CFLAGS) $(MKRI_OPTS)

mkri: mmkri.o \
	mkri.o fss.o xstrcmp.o brsearch.o \
	mapfile.o maxrlimit.o splitv.o fsort.o diag.o pi.o \
	$(SORT_PCOMPAR) timer.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

dumpri: dumpri.o \
	fss.o xstrcmp.o brsearch.o \
	mapfile.o splitv.o timer.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

otmi2itb: otmi2itb.o nstring.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

tsv2itb: tsv2itb.o readln.o csv.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

wtouch: wtouch.o mapfile.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

gorjparse.c: gorjparse.y
	$(YACC) -o $@ $^

ifeq ($(ENABLE_GETA),)
ifneq ($(ENABLE_DLSIM),)
simcomp: simcomp.o
	$(LINK) -o $@ $^ $(LDFLAGS) $(LIBS)

simcomp.c: simcomp.y
	$(YACC) -o $@ $^

smart.$(DLS_EXT): smart.sim
smartaw.$(DLS_EXT): smartaw.sim
smartwa.$(DLS_EXT): smartwa.sim
tfidf.$(DLS_EXT): tfidf.sim
tf.$(DLS_EXT): tf.sim
hits.$(DLS_EXT): hits.sim

install-dlsim-so: install-dlsim
install-dlsim: smart.$(DLS_EXT) smartaw.$(DLS_EXT) smartwa.$(DLS_EXT) tfidf.$(DLS_EXT) tf.$(DLS_EXT) hits.$(DLS_EXT)
	mkdir -p $(DLSIMDIR)
	$(INSTALL) smart.$(DLS_EXT) $(DLSIMDIR)
	$(INSTALL) smartaw.$(DLS_EXT) $(DLSIMDIR)
	$(INSTALL) smartwa.$(DLS_EXT) $(DLSIMDIR)
	$(INSTALL) tfidf.$(DLS_EXT) $(DLSIMDIR)
	$(INSTALL) tf.$(DLS_EXT) $(DLSIMDIR)
	$(INSTALL) hits.$(DLS_EXT) $(DLSIMDIR)
endif
endif

gss3.c: gss3.q

sct.c: sct.q

mkrootdb: mkrootdb.o splitv.o
	$(LINK) -o $@ $^

ifneq ($(ENABLE_REN),)
rn/rn.js: mkrootdb /dev/null rn/librn.js rn/libgss3.js rn/main.js
	-chmod +w $@
	cat /dev/null | ./mkrootdb rn/librn.js rn/libgss3.js rn/main.js > $@
	-chmod a-w $@
endif

clean:
	rm -f getassoc xgetassoc tgetassoc stp $(ITB2FRQ) $(MKRI) dumpri otmi2itb tsv2itb wtouch
	rm -f *.a *.o *.core gorjparse.c *.gmon
	rm -f $(LIBNWAM_A)
ifeq ($(ENABLE_GETA),)
ifneq ($(ENABLE_SHARED),)
	rm -f $(LIBNWAM_SO)
endif
ifneq ($(ENABLE_DLSIM),)
	rm -f simcomp simcomp.c
	rm -f smart.c smart.o smart.$(DLS_EXT)
	rm -f smartaw.c smartaw.o smartaw.$(DLS_EXT)
	rm -f smartwa.c smartwa.o smartwa.$(DLS_EXT)
	rm -f tfidf.c tfidf.o tfidf.$(DLS_EXT)
	rm -f tf.c tf.o tf.$(DLS_EXT)
	rm -f hits.c hits.o hits.$(DLS_EXT)
endif
endif

distclean: clean
	rm -f nwam.h config.h config.mk libtool config.log tags config.status
	rm -f Makefile rules.mk docs/INSTALL ssetup
	rm -f mkrootdb rn/rn.js

install: all
	mkdir -p $(BIN)
	mkdir -p $(LIBEXEC)
	$(INSTALL) -c -m 555 -s getassoc $(LIBEXEC)
	$(INSTALL) -c -m 555 -s xgetassoc $(LIBEXEC)
	$(INSTALL) -c -m 555 -s tgetassoc $(BIN)
	$(INSTALL) -c -m 555 -s stp $(BIN)
ifneq ($(ENABLE_GETA),)
	$(INSTALL) -c -m 555 -s itb2frq $(LIBEXEC)
	$(INSTALL) -c -m 555 -s mkri $(LIBEXEC)
endif
ifeq ($(ENABLE_GETA),)
	mkdir -p $(libdir)
	$(INSTALL) -c -m 644 $(LIBNWAM_A) $(libdir)
ifneq ($(ENABLE_SHARED),)
	$(INSTALL) -c -m 644 $(LIBNWAM_SO) $(libdir)
ifneq ($(LIBNWAM_SO_MAJOR),)
	rm -f $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
	ln -s $(LIBNWAM_SO) $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
	rm -f $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
	ln -s $(LIBNWAM_SO) $(LIBDIR)/$(LIBNWAM_SO_MAJOR)
endif
ifneq ($(LIBNWAM_SO_PLAIN),)
	if [ ! -e $(LIBDIR)/$(LIBNWAM_SO_PLAIN) ] ; then ln -s $(LIBNWAM_SO) $(LIBDIR)/$(LIBNWAM_SO_PLAIN); fi
endif
endif
ifneq ($(ENABLE_DLSIM),)
	$(INSTALL) -c -m 555 -s simcomp $(BIN)
endif
endif
	$(INSTALL) -c -m 555 -s otmi2itb $(LIBEXEC)
	$(INSTALL) -c -m 555 -s tsv2itb $(LIBEXEC)
	$(INSTALL) -c -m 555 -s wtouch $(BIN)
	mkdir -p $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 sct.js $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 sct_help.html $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 img/search.gif $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 img/geta_1.gif $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 img/geta_2.gif $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 img/geta_3.gif $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 img/geta_4.gif $(datadir)/$(DATADIRNAME)
	$(INSTALL) -c -m 444 img/geta_5.gif $(datadir)/$(DATADIRNAME)
ifneq ($(ENABLE_REN),)
	mkdir -p $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 img/btn_clear.gif $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 img/btn_top_imagine.gif $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 img/top_logo.gif $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 rn/rn.html $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 rn/rn.css $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 rn/rn.js $(datadir)/$(DATADIRNAME)/rn
	$(INSTALL) -c -m 444 rn/sample.txt $(datadir)/$(DATADIRNAME)/rn
endif
	mkdir -p ${includedir}/getassoc
	$(INSTALL) -c -m 444 nwam.h ${includedir}/getassoc/
	$(INSTALL) -c -m 444 simdef.h ${includedir}/getassoc/

ifneq ($(ENABLE_NEWLAYOUT),)
	echo Do not forget to create following directories: etc tmp nwam pwam
else
ifeq ($(ENABLE_GETA),)
	mkdir -p ${prefix}/nwam
	mkdir -p ${prefix}/etc
	mkdir -p ${prefix}/pwam
else
	mkdir -p ${prefix}/dwam
endif
	mkdir -p ${prefix}/tmp
endif
