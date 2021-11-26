# === Download Data -------------------------------------------------------
# Alec Robitaille ---------------------------------------------------------


# Packages ----------------------------------------------------------------
library(spatsoc)
library(data.table)


# Input -------------------------------------------------------------------
# Read the example data from spatsoc
DT <- fread(system.file("extdata", "DT.csv", package = "spatsoc"))


# This might alternatively be downloading data from the internet,
#   reading in a bunch of local files, etc.


# Output ------------------------------------------------------------------
# Save the data in the input folder
fwrite(DT, 'input/1-downloaded-data.csv')
