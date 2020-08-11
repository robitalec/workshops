#' Plot Metrics
#'
#' @author Alec Robitaille
#'
#' @return
#' @export
#'
#' @examples
plot_metrics <- function(metricpts, metriclines) {
	metricpts[, type := 'pts']
	metriclines[, type := 'lines']

	combine <- data.table::rbindlist(
		list(metricpts, metriclines)
	)

	ggplot2::ggplot(combine) +
		ggplot2::geom_point(ggplot2::aes(ID, strength, color = type), alpha = 0.8) +
		ggplot2::labs(x = 'Individual', y = 'Strength')
}
