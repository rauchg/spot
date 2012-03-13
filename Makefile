
PREFIX = /usr/local
MANTASTIC = http://mantastic.herokuapp.com

docs: spot.1
	man ./$<

spot.1: spot.md
	curl -s -F page=@$< $(MANTASTIC) > $@

install:
	cp spot.sh $(PREFIX)/bin/spot

uninstall:
	rm -f $(PREFIX)/bin/spot

.PHONY: docs install uninstall