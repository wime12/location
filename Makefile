# Customize the following lines if needed

PREFIX=/usr/local

BINDIR=$(PREFIX)/bin
AWKLIB=$(PREFIX)/share/awklib
AWKFILE_DIR=$(PREFIX)/share/location
SHLIB=$(PREFIX)/share/shlib
MANDIR=$(PREFIX)/share/man/man1

# END of custom lines

install:
	sed "s#AWKLIB=.*#AWKLIB=$$\{AWKLIB:-$(AWKLIB)\}#;s#SHLIB=.*#SHLIB=$$\{SHLIB:-$(SHLIB)\}#;s#AWKFILE_DIR=.*#AWKFILE_DIR=$$\{AWKFILE:-$(AWKFILE_DIR)\}#" < location.sh > location.sh.new
	test -d $(BINDIR) || mkdir -p $(BINDIR)
	install -m 0755 location.sh.new $(BINDIR)/location
	rm location.sh.new
	test -d $(AWKFILE_DIR) || mkdir -p $(AWKFILE_DIR)
	install -m 0644 location.awk $(AWKFILE_DIR)
	test -d $(MANDIR) || mkdir -p $(MANDIR)
	install -m 0644 location.1 $(MANDIR)

clean:
	rm -f location.sh.new

.PHONY: install clean
