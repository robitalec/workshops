### Plots ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('tidyr', 'dplyr', 'ggplot2')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- readRDS('data/derived-data/1-prep/cleaned-ed-visits.Rds')


### Filter ----
# Select specific diagnoses, e.g. alcohol specific
alcDT <- DT %>%
	filter(grepl('alcohol', DiagnosisLongText))


### Plots ----
ggplot(alcDT) +
	geom_histogram(aes(Diagnosis, group = Gender, fill = Gender), stat = 'count')


ggplot(alcDT) +
	geom_histogram(aes(Diagnosis), stat = 'count') +
	facet_wrap(~Gender)

ggsave('graphics/diagnosis-gender-histo.png')
