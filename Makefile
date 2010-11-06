DIST = casual-tunnel-0.01

DESTDIR = ""
install = /usr/bin/install
rm = /bin/rm
tar = /bin/tar

prefix = /usr/local
bindir = $(prefix)/bin
sbindir = $(prefix)/sbin
mandir = $(prefix)/man
man1dir = $(mandir)/man1
man8dir = $(mandir)/man8

all: man

dist: bin/mktunnelkeys sbin/mktunneld man
	$(install) -d -m 0755 $(DIST)/bin $(DIST)/sbin $(DIST)/man
	$(install) -m 0755 bin/mktunnelkeys $(DIST)/bin/mktunnelkeys
	$(install) -m 0755 sbin/mktunneld $(DIST)/sbin/mktunneld
	$(install) -m 644 man/* $(DIST)/man
	$(install) -m 644 README $(DIST)/README
	$(install) -m 644 Makefile.dist $(DIST)/Makefile
	$(install) -m 644 casual-tunnel.spec.dist $(DIST)/$(DIST).spec
	$(tar) cvvf $(DIST).tar.bz2 --use=bzip2 $(DIST)
	$(rm) -rf $(DIST)

install: bin/mktunnelkeys sbin/mktunneld man
	$(install) -d -m 0755 $(DESTDIR)$(bindir) $(DESTDIR)$(sbindir)
	$(install) -d -m 0755 $(DESTDIR)$(man1dir) $(DESTDIR)$(man8dir)
	$(install) -m 0755 bin/mktunnelkeys $(DESTDIR)$(bindir)/mktunnelkeys
	$(install) -m 0755 sbin/mktunneld $(DESTDIR)$(sbindir)/mktunneld
	$(install) -m 644 man/mktunnelkeys.1 $(DESTDIR)$(man1dir)
	$(install) -m 644 man/mktunneld.8 $(DESTDIR)$(man8dir)

man: man/mktunnelkeys.1 man/mktunneld.8

man/mktunnelkeys.1:
	mkdir -p man
	pod2man -c '' -r '' -s 1 pod/mktunnelkeys.pod man/mktunnelkeys.1

man/mktunneld.8:
	mkdir -p man
	pod2man -c '' -r '' -s 8 pod/mktunneld.pod man/mktunneld.8

clean:
	rm -rf man
