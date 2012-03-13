
PREFIX = /usr/local

install:
	cp spot.sh $(PREFIX)/bin/spot

uninstall:
	rm -f $(PREFIX)/bin/spot

.PHONY: install uninstall