### Prep

## Packages
pkgs <- c('readxl', 'tidyr', 'dplyr', 'janitor', 'ggplot2')
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
	fill(-DiagnosisType, -Diagnosis, -DiagnosisLongText)



## Processing
# TODO: Count by DiagnosisType = M and alcohol vs drug etc
# TODO: trends by age, location, day of week etc
# TODO: multiple drug uses, or shared/common diagnosis often found together

# Counts
tally
count
tabyl



## Pretend
selDiag <- c('F100', 'F101')

# OR
alc <- unique(DT$DiagnosisLongText[grepl('alcohol', DT$DiagnosisLongText, ignore.case = TRUE)])
coc <- unique(DT$DiagnosisLongText[grepl('cocaine', DT$DiagnosisLongText, ignore.case = TRUE)])

alcDT <- DT %>%
	filter(DiagnosisLongText %in% alc)

cocDT <- DT %>%
	filter(DiagnosisLongText %in% coc)

### Visualize
ggplot(alcDT) +
	geom_histogram(aes(Diagnosis, group = Gender, fill = Gender), stat = 'count')


ggplot(alcDT) +
	geom_histogram(aes(Diagnosis), stat = 'count') +
	facet_wrap(~Gender)
