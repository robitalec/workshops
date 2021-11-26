#' Summarize Networks
#'
#' @author Alec Robitaille
#'
#' @return
#' @export
#'
#' @examples
summarize_network <- function(network) {
	# Generate graph
	g <- igraph::graph.adjacency(network, 'undirected',
											 diag = FALSE, weighted = TRUE)

	# Metrics for all individuals
	metricpts <- data.table::data.table(
		centrality = igraph::evcent(g)$vector,
		strength = igraph::graph.strength(g),
		degree = igraph::degree(g),
		ID = names(igraph::degree(g))
	)
}

