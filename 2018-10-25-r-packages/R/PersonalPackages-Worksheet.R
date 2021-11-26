### Personal Packages worksheet ====
# Alec Robitaille
# October 25 2018

### Packages ----
libs <- c('data.table', 'magrittr', 'devtools', 'spatsoc', 'ggplot2')
lapply(libs, require, character.only = TRUE)

### Data ----
# Read example data from spatsoc
DT <- fread(system.file("extdata", "DT.csv", package = "spatsoc"))
DT[, datetime := as.POSIXct(datetime)]
DT[, yr := year(datetime)]


# Generate fake yearly data
b2015 <- DT[sample(.N, 100), X/1e3]
b2016 <- DT[sample(.N, 100), X/1e3]
b2017 <- DT[sample(.N, 100), X/1e3]

# Generate fake CSVs
fwrite(data.table(val = b2015, yr = 2015), 'tests/testdata/b2015.csv')
fwrite(data.table(val = b2016, yr = 2016), 'tests/testdata/b2016.csv')
fwrite(data.table(val = b2017, yr = 2017), 'tests/testdata/b2017.csv')

