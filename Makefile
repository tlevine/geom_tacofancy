.PHONY: install docs check

check:
	R CMD check .

install:
	R CMD INSTALL .

docs:
	Rscript -e 'library(knitr); library(geomtacofancy); knit("README.Rmd", quiet = TRUE)'
