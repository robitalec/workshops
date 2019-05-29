### Associated Diagnoses ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('spatsoc', 'dplyr', 'data.table', 'igraph', 'asnipe')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- readRDS('data/derived-data/1-prep/cleaned-ed-visits.Rds')


### Processing ----
# Add a group index (VisitId)
DT <- DT %>%
	group_by(ChartNumber, VisitDate) %>%
	mutate(VisitId = group_indices())


# Generate the frequency table of associated diagnoses within visits
freqTab <- get_gbi(data.table(DT),
									 group = 'VisitId',
									 id = 'Diagnosis')

# Generate the network
net <- get_network(freqTab,
									 data_format = "GBI",
									 association_index = "SRI")

# Generate the graph
g <- graph_from_adjacency_matrix(net,
																 mode = 'undirected',
																 diag = FALSE, weighted = TRUE, )


### Plot ----
plot(
	g,
	vertex.color = NA,
	vertex.shape = 'none',
	layout = layout_with_fr
)


plot(
	g,
	vertex.color = NA,
	vertex.shape = 'none',
	layout = layout_in_circle
)


### Stats ----
betweenness(g)
degree(g)
