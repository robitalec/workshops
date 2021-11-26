# Makefile for the Personal R Packages workshop

### Unzip in to alec-r.gitlab.io (exclude R history and Rprojuser)
../../alec-r.gitlab.io/public/workshops/Personal-R-Packages/README.md: ../../core/Workshops/Personal-R-Packages/README.md
	unzip -o ../../alec-r.gitlab.io/public/workshops/Personal-R-Packages.zip -d ../../alec-r.gitlab.io/public/workshops/Personal-R-Packages

### Copy to WEEL/guides
../../core/Workshops/Personal-R-Packages/README.md: ../../alec-r.gitlab.io/public/workshops/Personal-R-Packages.zip
	unzip -o ../../alec-r.gitlab.io/public/workshops/Personal-R-Packages.zip -d ../../core/Workshops/Personal-R-Packages

### Zip to alec-r.gitlab.io (exclude R history and Rprojuser)
../../alec-r.gitlab.io/public/workshops/Personal-R-Packages.zip: presentation/Personal-R-Packages.html R/Chunks-PersonalPackages.R
	zip -r ../../alec-r.gitlab.io/public/workshops/Personal-R-Packages.zip . -x .Rhistory *.Rproj.user*

### Combine the purled into the worksheet
R/Worksheet-PersonalPackages.R: R/Chunks-PersonalPackages.R
	Rscript --vanilla -e "file.copy('R/Setup-PersonalPackages.R', 'R/Worksheet-PersonalPackages.R', overwrite = TRUE); file.append('R/Worksheet-PersonalPackages.R', 'R/Chunks-PersonalPackages.R')"

### Purl the code out to an R script
R/Chunks-PersonalPackages.R: presentation/Personal-R-Packages.Rmd
	Rscript --vanilla -e "library(knitr);purl('presentation/Personal-R-Packages.Rmd', output = 'R/Chunks-PersonalPackages.R')"

### Update the presentation
presentation/Personal-R-Packages.html: presentation/Personal-R-Packages.Rmd
	Rscript --vanilla -e "rmarkdown::render('presentation/Personal-R-Packages.Rmd')"
