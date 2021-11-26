#' Prep data
#'
#' @author Alec Robitaille
#'
#' @return
#' @export
#'
#' @examples
prep_data <- function(DT) {
	# Cast the character column as a POSIXct
	DT[, datetime := as.POSIXct(datetime)]


	# Only grab 2016 data between months 8-12
	DT[data.table::year(datetime) == 2016 &
		 	data.table::between(data.table::month(datetime), 8, 12)]
}
