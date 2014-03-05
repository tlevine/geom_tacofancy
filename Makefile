.PHONY: install

check:
	R CMD check .

install:
	R CMD INSTALL .
