prefix=/usr/local

install: location.sh
	install -m 0755 location.sh $(prefix)/bin
	install -m 0644 location.awk $(prefix)/share/awklib
	install -m 0644 location.1 $(prefix)/share/man/man1

.PHONY: install
