### Summary Stats ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('tidyr', 'dplyr', 'ggplot2')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- readRDS('data/derived-data/1-prep/cleaned-ed-visits.Rds')


### Processing ----
# Select specific diagnoses, e.g. alcohol specific
# NOTE: alcohol grepl'ed may not be sufficient to find all diagnoses (typos etc)
#       recommended to use the Diagnosis Code
alcDT <- DT %>%
	filter(grepl('alcohol', DiagnosisLongText))

# Counts
# Number of Alcohol + DiagnosisType = M, by Gender
alcDT %>%
	group_by(DiagnosisType, Gender) %>%
	count()

# Number of Alcohol + YtResidenceCode by Age range "chunks"
alcDT %>%
	group_by(YtResidenceCode, cut_number(PatientAge, n = 3)) %>%
	count()
