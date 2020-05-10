## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      eval = FALSE)

## ----createPkg-----------------------------------------------------------
usethis::create_package("Local-git/toast")

## tree ../toast -a -L 1 --dirsfirst

## ----dirImporter---------------------------------------------------------
#' @export
dir_importer <- function(paths, named = FALSE) {
	if (named) {
		lapply(seq_along(paths), function(x) {
			fread(paths[x])[, nm := names(paths)[x]]
		}) %>% rbindlist()
	} else {
		lapply(paths, fread) %>% rbindlist()
	}
}

## ----useDirImporter------------------------------------------------------
library(toast)
paths <- dir('tests/testdata', '*.csv', full.names = TRUE)
names(paths) <- dir('tests/testdata', '*.csv')
DT <- dir_importer(paths, named = TRUE)

## ------------------------------------------------------------------------
# usethis::usepackage
use_package('magrittr', 'Imports')
use_package('data.table', 'Depends') #4

## ------------------------------------------------------------------------
devtools::install_git('https://gitlab.com/robit.a/toast.git')

## ------------------------------------------------------------------------
library(toast); library(data.table) #always

paths <- dir('tests/testdata', '*.csv', full.names = TRUE)
names(paths) <- dir('tests/testdata', '*.csv')
DT <- dir_importer(paths, named = TRUE)

if (DT[, unique(nm)] == length(paths)) print('toasted')

## ------------------------------------------------------------------------
#' dir importer
#' Provided a named list or list of files (produced with \code{dir}),
#' returns a combined \code{data.table} of all files.
#' If the list is named, these names are added as a column to the \code{data.table}.
#'
#' @return All files imported and combined into a single \code{data.table}.
#'
#' @param paths the named list or unnamed list representing the paths to CSV files
#' @param named boolean indicating if list is named or not.
#' if named, names from the list will be used to differentiate imported files.
#'
#' @export
#' @importFrom magrittr %>%
#' @examples
#' paths <- dir('tests/testdata', '*.csv', full.names = TRUE)
#' names(paths) <- dir('tests/testdata', '*.csv')
#' dir_importer(paths, named = TRUE)
dir_importer <- function(paths, named = FALSE) {
...
}

## ------------------------------------------------------------------------
if(!is.logical(named)) stop('you are not logical')

## ------------------------------------------------------------------------
library(toast)
context('testing dir_importer')
paths <- dir('tests/testdata', '*.csv', full.names = TRUE)

test_that('named is a boolean', {
  expect_error(dir_importer(paths, named = 10),
               'you are not logical')
})

## ------------------------------------------------------------------------
# Load the package
library(toast)

# Provide the context
context('testing dir_importer')

# Create your data to test on
paths <- dir('tests/testdata', '*.csv', full.names = TRUE)

# Testing that the named parameter has to be a boolean
test_that('named is a boolean', {
	# the 'you are not logical' error is expected if a numeric is provided
  expect_error(dir_importer(paths, named = 10),
               'you are not logical')
	
	# the 'you are not logical' error is expected if a character is provided
  expect_error(dir_importer(paths, named = 'potato'),
               'you are not logical')
})

