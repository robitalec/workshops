### Prep

## Packages
pkgs <- c('readxl', 'tidyr', 'dplyr')
p <- lapply(pkgs, library, character.only = TRUE)

## Data
# TODO: copy+paste the whole filepath and delete everything to root
DT <- read_excel('data/raw-data/ED visits for Alec.xls')

## Processing


# TODO: take out spaces from column names
DT %>%
	fill(`Chart number`,
			 YTResidenceCode,
			 PatientAge,
			 Gender)


