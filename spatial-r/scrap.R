library(mapview)
library(sf)
library(ggplot2)
library(data.table)

data(breweries)


ggplot(breweries, aes(color = brewery)) +
	geom_sf()


## Convert to data.table for example
# Grab the coordinates from the sf object and cast the matrix as a data.table
xy <- data.table(st_coordinates(breweries))

# Cast the sf object as a data.table
dtbrew <- data.table(breweries)

dtbrew[, somecolumn := 1]
dtbrew[, anothercolumn := 2]

# Soft code coordinate column names (for later)
coordcols <- c('X', 'Y')

# Add the xy to the data.table
dtbrew[, (coordcols) := xy]

dtbrew[, c('X', 'Y') := xy]





library(mapview)

mapview(breweries)


mapview(dtbrew, xcol = 'X', ycol = 'Y',
				crs = st_crs(breweries),
				zcol = 'number.seasonal.beers')





#
library(data.table)

DT <- fread('https://raw.githubusercontent.com/ropensci/spatsoc/master/inst/extdata/DT.csv')


tz <- 'America/Vancouver'

DT[, idate := as.IDate(datetime)]
DT[, itime := as.ITime(datetime)]


DT[, datetime := as.POSIXct(paste(idate, itime, sep = ' '),
														format = '%B',
														tz = tz)]

DT[is.na(datetime)]

DT[, datetime := as.POSIXct(paste(idate, itime, sep = ' '),
														tz = tz)]


DT[is.na(datetime)]


DT[, fwrite(.SD, paste0('input/ID-', .GRP[[1]],
												'.csv')), by = ID]


files <- dir('input/ID-*', full.names = TRUE)

DT <- rbindlist(lapply(files, fread))


st_crs(32632)

projcols <- paste0('proj', coordcols)
dtbrew[, rgdal::project(cbind(X, Y), st_crs(32632))]
dtbrew
