# Customize the following lines if needed

PREFIX=/usr/local

BINDIR=$(PREFIX)/bin
AWKLIB=$(PREFIX)/share/awklib
AWKFILE_DIR=$(PREFIX)/share/location
SHLIB=$(PREFIX)/share/shlib
MANDIR=$(PREFIX)/share/man/man1

# END of custom lines

install:
	sed "s#AWKLIB=.*#AWKLIB=$$\{AWKLIB:-$(AWKLIB)\}#;s#SHLIB=.*#SHLIB=$$\{SHLIB:-$(SHLIB)\}#;s#AWKFILE_DIR=.*#AWKFILE_DIR=$$\{AWKFILE_DIR:-$(AWKFILE_DIR)\}#" < location.sh > location.sh.new
	test -d $(BINDIR) || mkdir -p $(BINDIR)
	install -m 0755 location.sh.new $(BINDIR)/location
	rm location.sh.new
	test -d $(AWKFILE_DIR) || mkdir -p $(AWKFILE_DIR)
	install -m 0644 location.awk $(AWKFILE_DIR)
	sed "s#getxml.awk#$(AWKLIB)/getxml.awk#;s#location.awk#$(AWKFILE_DIR)/location.awk#" < location.1 > location.1.new
	test -d $(MANDIR) || mkdir -p $(MANDIR)
	install -m 0644 location.1.new $(MANDIR)/location.1
	rm location.1.new

clean:
	rm -f location.sh.new location.1.new

.PHONY: install clean
