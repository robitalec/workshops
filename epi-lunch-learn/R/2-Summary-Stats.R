### Summary Stats ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('tidyr', 'dplyr', 'assertr')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- readRDS('data/derived-data/1-prep/cleaned-ed-visits.Rds')


### Processing ----
# TODO: Count by DiagnosisType = M and alcohol vs drug etc
# TODO: trends by age, location, day of week etc
# TODO: multiple drug uses, or shared/common diagnosis often found together

alc <- unique(DT$DiagnosisLongText[grepl('alcohol', DT$DiagnosisLongText, ignore.case = TRUE)])

alcDT <- DT %>%
	filter(DiagnosisLongText %in% alc)



alcDT
