# === Summary -------------------------------------------------------------
# Alec Robitaille ---------------------------------------------------------



# Packages ----------------------------------------------------------------
library(data.table)
library(igraph)

# Input -------------------------------------------------------------------
DTpts <- readRDS('output/3-group-pts.Rds')
DTlines <- readRDS('output/4-group-lines.Rds')

netpts <- readRDS('output/3-network-pts.Rds')
netlines <- readRDS('output/4-network-lines.Rds')

# Process -----------------------------------------------------------------
### Pts
## Network metrics
# Generate graph
g <- graph.adjacency(netpts, 'undirected',
										 diag = FALSE, weighted = TRUE)

# Metrics for all individuals
metricpts <- data.table(
	centrality = evcent(g)$vector,
	strength = graph.strength(g),
	degree = degree(g),
	ID = names(degree(g)),
	yr = DTpts[, unique(year(datetime))]
)

## Group counts
# How many individuals per group?
DTpts[, .N, by = group][order(-N)]


### Lines
## Network metrics
# Generate graph
g <- graph.adjacency(netlines, 'undirected',
										 diag = FALSE, weighted = TRUE)

# Metrics for all individuals
metricslines <- data.table(
	centrality = evcent(g)$vector,
	strength = graph.strength(g),
	degree = degree(g),
	ID = names(degree(g)),
	yr = DTlines[, unique(year(datetime))]
)

## Group counts
# How many individuals per group?
DTlines[, .N, by = group][order(-N)]


# Output ------------------------------------------------------------------
saveRDS(metricpts, 'output/5-metrics-pts.Rds')
saveRDS(metricslines, 'output/5-metrics-lines.Rds')
