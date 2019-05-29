### Summary Stats ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('tidyr', 'dplyr', 'assertr', 'ggplot2')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- readRDS('data/derived-data/1-prep/cleaned-ed-visits.Rds')


### Processing ----
# TODO: multiple drug uses, or shared/common diagnosis often found together
library(igraph)
library(spatsoc)
DT <- DT %>%
	group_by(ChartNumber, VisitDate) %>%
	mutate(VisitId = group_indices())


freqTab <- get_gbi(
	data.table(DT),
	group = 'VisitId',
	id = 'Diagnosis'
)

graph_from_adjacency_matrix(freqTab)



DT %>%
	group_by(ChartNumber, VisitDate) %>%
	select(Diagnosis) %>%
	crossprod(as.matrix(.))

DT %>%
	mutate(n = 1) %>%
	spread(Diagnosis, n, fill=0) %>%
	select(-ChartNumber, -VisitDate) %>%
	{crossprod(as.matrix(.))} %>%
	`diag<-`(0)


## Alcohol specific
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



