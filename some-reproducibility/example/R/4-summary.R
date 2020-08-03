# === Summary -------------------------------------------------------------
# Alec Robitaille ---------------------------------------------------------



# Packages ----------------------------------------------------------------
library(data.table)
library(igraph)

# Input -------------------------------------------------------------------
DT <- readRDS('output/3-group-locs.Rds')
net <- readRDS('output/3-network.Rds')

# Process -----------------------------------------------------------------
## Network metrics
# Generate graph
g <- graph.adjacency(net, 'undirected',
										 diag = FALSE, weighted = TRUE)

# Metrics for all individuals
metrics <- data.table(
	centrality = evcent(g)$vector,
	strength = graph.strength(g),
	degree = degree(g),
	ID = names(degree(g)),
	yr = DT[, unique(year(datetime))]
)

## Group counts
# How many individuals per group?
DT[, .N, by = group][order(-N)]

# Etc

# Output ------------------------------------------------------------------
saveRDS(metrics, 'output/4-metrics.Rds')

