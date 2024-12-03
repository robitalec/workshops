library(data.table)
library(spatsoc)

DT <- readRDS('output/03-grouped-locs.Rds')

dput(DT[sample(.N, 100)])

DT[sample(nrow(DT), size = 100, replace = FALSE)]

edges <-
  edge_nn(
    DT = DT,
    id = id,
    coords = coords,
    timegroup = 'timegroup',
    returnDist = TRUE,
    threshold = NULL
  )