### Prep

## Packages
pkgs <- c('readxl', 'tidyr', 'dplyr', 'janitor')
p <- lapply(pkgs, library, character.only = TRUE)

## Data
# TODO: copy+paste the whole filepath and delete everything to root
DT <- read_excel('data/raw-data/ED visits for Alec.xls')

DT

## Cleanup
# Remove spaces from column names, inconsistent column name formatting
DT <- DT %>%
	clean_names(case = 'upper_camel')

# Fill missing information in all columns except Diagnosis and DiagnosisLongText
DT <- DT %>%
	fill(-Diagnosis, -DiagnosisLongText)



## Processing
DT %>%
	tabyl(Diagnosis, Gender)
