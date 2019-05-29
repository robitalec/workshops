### Associated Diagnoses ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('spatsoc', 'dplyr', 'data.table', 'igraph', 'asnipe')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- readRDS('data/derived-data/1-prep/cleaned-ed-visits.Rds')

# TODO: multiple drug uses, or shared/common diagnosis often found together
library(igraph)
library(spatsoc)
library(data.table)
DT <- DT %>%
	group_by(ChartNumber, VisitDate) %>%
	mutate(VisitId = group_indices())


freqTab <- get_gbi(
	data.table(DT),
	group = 'VisitId',
	id = 'Diagnosis'
)

net <-
	asnipe::get_network(freqTab,
											data_format = "GBI",
											association_index = "SRI")


g <- igraph::graph_from_adjacency_matrix(net,
																				 diag = FALSE, weighted = TRUE)

plot(g)
