
PREFIX ?= /usr/local
MANTASTIC = http://mantastic.herokuapp.com

docs: spot.1
	man ./$<

spot.1: spot.md
	curl -s -F page=@$< $(MANTASTIC) > $@

install:
	cp spot.sh $(PREFIX)/bin/spot
	cp spot.1 $(PREFIX)/share/man/man1/spot.1

uninstall:
	rm -f $(PREFIX)/bin/spot
	rm -f spot.1 $(PREFIX)/share/man/man1/spot.1

.PHONY: docs install uninstall
