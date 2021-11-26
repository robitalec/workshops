#' Download data
#'
#' @author Alec Robitaille
#'
#' @return
#' @export
#'
#' @examples
download_data <- function() {
	DT <- data.table::fread(system.file("extdata", "DT.csv", package = "spatsoc"))
	data.table::fwrite(DT, 'input/1-downloaded-data.csv')
	DT
}
