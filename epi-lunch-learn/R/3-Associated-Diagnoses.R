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
	group_by(UniqueId) %>%
	mutate(VisitId = group_indices())


# Generate the frequency table of associated diagnoses within visits
freqTab <- get_gbi(data.table(DT),
									 group = 'VisitId',
									 id = 'Diagnosis')

# Generate the network
# TODO: (on your own time/fyinterest) look into SRI/etc and relevance for health data
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


### Stats ----
betweenness(g)
degree(g)
