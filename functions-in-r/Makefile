# Makefile for the Functions in R workshop

### Unzip in to alec-r.gitlab.io (exclude R history and Rprojuser)
../../alec-r.gitlab.io/public/workshops/Functions-In-R/README.md: ../../core/Workshops/Functions-In-R/README.md
	unzip -o ../../alec-r.gitlab.io/public/workshops/Functions-In-R.zip -d ../../alec-r.gitlab.io/public/workshops/Functions-In-R

### Copy to WEEL/guides
../../core/Workshops/Functions-In-R/README.md: ../../alec-r.gitlab.io/public/workshops/Functions-In-R.zip
	unzip -o ../../alec-r.gitlab.io/public/workshops/Functions-In-R.zip -d ../../core/Workshops/Functions-In-R

### Zip to alec-r.gitlab.io (exclude R history and Rprojuser)
../../alec-r.gitlab.io/public/workshops/Functions-In-R.zip: presentation/Functions-In-R.html R/Worksheet-FunctionsInR.R
	zip -r ../../alec-r.gitlab.io/public/workshops/Functions-In-R.zip . -x .Rhistory *.Rproj.user*

### Combine the purled into the worksheet
R/Worksheet-FunctionsInR.R: R/Chunks-FunctionsInR.R
	Rscript --vanilla -e "file.copy('R/Setup-FunctionsInR.R', 'R/Worksheet-FunctionsInR.R', overwrite = TRUE); file.append('R/Worksheet-FunctionsInR.R', 'R/Chunks-FunctionsInR.R')"

### Purl the code out to an R script
R/Chunks-FunctionsInR.R: presentation/Functions-In-R.Rmd
	Rscript --vanilla -e "library(knitr);purl('presentation/Functions-In-R.Rmd', output = 'R/Chunks-FunctionsInR.R')"

### Update the presentation
presentation/Functions-In-R.html: presentation/Functions-In-R.Rmd
	Rscript --vanilla -e "rmarkdown::render('presentation/Functions-In-R.Rmd')"
