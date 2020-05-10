### An Introduction to ggplot2 ==== 
# Alec Robitaille
# November 2 2017
# WEEL

libs <- c('sp', 'rgeos', 'rgdal', 'raster', 
          'adehabitatHR', 'gridExtra',
          'ggplot2', 'broom', 'data.table')
lapply(libs, require, character.only = TRUE)


### Basic ggplot2 -----------------------------------------------------------
## Packages ----
libs <- c('data.table', 'ggplot2')
# lapply(libs, require, character.only = TRUE)


## Input data ----
# Read in ggplot2's example data
diamonds <- fread('input/diamonds.csv')

## First plots ----
# Using the diamonds dataset:

# Plot a histogram of the prices 
# (hint geom_histogram)
ggplot(diamonds) + 
  geom_histogram(aes(price))

# Plot points of carat vs. price
ggplot(diamonds) + 
  geom_point(aes(carat, price))

# Change the color of the points to blue in the above carat vs. price plot
ggplot(diamonds) + 
  geom_point(aes(carat, price), color = 'blue')

# Use the variable cut to color the points in the carat. vs price plot
ggplot(diamonds) + 
  geom_point(aes(carat, price, color = cut))

## Guide
# Let's turn off that legend
ggplot(diamonds) + 
  geom_point(aes(carat, price, color = cut)) +
  guides(color = FALSE)

# Detail settings for guide_legend
ggplot(diamonds) + 
  geom_point(aes(carat, price, color = price)) +
  guides(color = guide_legend(label.position = 'right',
                              title = 'Price $$',
                              keywidth = 3))

# Detail settings for guide_colorbar
ggplot(diamonds) + 
  geom_point(aes(carat, price, color = price)) +
  guides(color = guide_colorbar(label.position = 'right'))

## Axis Labels
# Plot the diamonds dataset carat vs. price and rename the 
#  axis labels to capitalize the words
ggplot(diamonds) + 
  geom_point(aes(carat, price)) +
  labs(x = 'Carat', y = 'Price')

# Using the same plot, add the color by cut and change the 
#  legend title accordingly (don't leave the default)
ggplot(diamonds) + 
  geom_point(aes(carat, price, color = cut)) +
  labs(x = 'Carat', y = 'Price', color = 'Cut')

## Facetting
ggplot(diamonds) + 
  geom_point(aes(carat, price, color = price)) +
  facet_wrap(~cut)

### Spatial ggplot2 ---------------------------------------------------------
## Packages ----
libs <- c('sp', 'rgeos', 'rgdal', 'raster',
          'adehabitatHR')
# lapply(libs, require, character.only = TRUE)

## Input data ----
locs <- fread('input/mock-locs.csv')

## Data prep ----
# Change character fields FIX DATE and FIX TIME to IDates and ITimes
# Easy in this case since FIX DATE is already in ISO 8601 format ('%F')
locs[, idate := as.IDate(FIX_DATE)]
locs[, itime := as.ITime(FIX_TIME)]

# Project the lat lon geographic coordinates to appropriate UTM zone
#  use http://spatialreference.org/ref/epsg/ to find the EPSG code
#  and grab the proj4 string
utm21N <- '+proj=utm +zone=21 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
locs[, c('EASTING', 'NORTHING') := as.data.table(project(cbind(X_COORD, Y_COORD), 
                                                         utm21N))]
## Basic plot ----
ggplot(locs) + 
  geom_point(aes(EASTING, NORTHING))

# Color by individual
ggplot(locs) + 
  geom_point(aes(EASTING, NORTHING, color = COLLAR_ID))

ggplot(locs) + 
  geom_point(aes(EASTING, NORTHING, color = factor(COLLAR_ID)))

ggplot(locs) + 
  geom_point(aes(EASTING, NORTHING, color = factor(COLLAR_ID))) + 
  guides(color = FALSE)

## Plot the trajectories ----
# If the data was not already ordered by datetime, 
#  we'd need to do it with locs[order(idate, itime)]
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING))

# Add grouping of lines since multiple individuals
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID))

# Add some color
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                color = COLLAR_ID))

# Factor that color for categorical variable
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                color = factor(COLLAR_ID)))

# Turn off the legend 
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                color = factor(COLLAR_ID))) + 
  guides(color = FALSE)

## Where to set color/alpha etc of geoms???
# Set the alpha inside aes (wrong)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                alpha = 0.2)) + 
  guides(color = FALSE)

# Set the alpha outside aes (right)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID),
            alpha = 0.2) + 
  guides(color = FALSE)

# Set the alpha inside aes USING DATA (right)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                alpha = factor(COLLAR_ID))) + 
  guides(color = FALSE)

# Set color inside aes (wrong)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                color = 'blue')) + 
  guides(color = FALSE)

# Set color outside aes (right)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID),
            color = 'blue') + 
  guides(color = FALSE)

# Set color outside aes using data (wrong)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID),
            color = COLLAR_ID) + 
  guides(color = FALSE)

# Set color inside aes using data (right)
ggplot(locs) + 
  geom_path(aes(EASTING, NORTHING, group = COLLAR_ID,
                color = COLLAR_ID)) + 
  guides(color = FALSE)

## Plot the 95% MCPs ----
# This is wrapped in spatsoc::BuildPts()
pts <- SpatialPointsDataFrame(locs[, .(EASTING, NORTHING)],
                              proj4string = CRS(utm21N),
                              data = locs[, .(COLLAR_ID)])

# MCP expects the only column to be in your SpPtsDF to be the ID field
mcps <- mcp(pts, 95)

# To plot polygons, we need to piece apart the S4 SpPtsDF into a simple DF
#   for this we use broom::tidy
tidyMCPs <- tidy(mcps)

## Plot them
ggplot(tidyMCPs) + 
  geom_polygon(aes(long, lat))

# Group by group (tidy'ed polygon pieces)
ggplot(tidyMCPs) + 
  geom_polygon(aes(long, lat, group = group),
               color = 'black', fill = NA)

# Fill by ID
ggplot(tidyMCPs) + 
  geom_polygon(aes(long, lat, group = group, 
                   fill = id), 
               alpha = 0.25)

# Multipanel plots --------------------------------------------------------
# The important consideration for multi-layer plots that will take 
#   advantage of ggplot2's facet_wrap or facet_grid is that the field
#   used to wrap must be present in all of the data. 
#   If it isn't, the same data for that layer will be plotted in all
#   subplots. 


# MCP expects the only column in your SpPtsDF to be the ID field
#  To retain year*ID information, we will add a new column which is the 
#  combination of these columns and pass that as the ID
#  The MCP function will then create MCPs for each ID*Year combination. 

locs[, ID_YEAR := paste(COLLAR_ID, year(idate), sep ="_")]

pts <- SpatialPointsDataFrame(locs[, .(EASTING, NORTHING)],
                              proj4string = CRS(utm21N),
                              data = locs[, .(ID_YEAR)])

# MCP expects the only column to be in your SpPtsDF to be the ID field
#  To retain year*ID information, we pasted
mcps <- mcp(pts, 95)

# To plot polygons, we need to piece apart the S4 SpPtsDF into a simple DF
#   for this we use broom::tidy
tidyMCPs <- tidy(mcps)

# This is where we take the tidy'ed mcps, and string split out the previously
#  pasted ID*Years
DT <- data.table(tidyMCPs)[, c('COLLAR_ID', 'YEAR') := tstrsplit(id, '_')]

# Add a matching field in the point data.table, which will allow us to use facet_wrap
locs[, YEAR := year(idate)]

# Multilayer ggplot: polygons from tidy-ed mcps, points from original data.table of locs
ggplot() + 
  geom_polygon(aes(long, lat, group = group, fill = id), alpha = 0.25,
               data = DT) +
  geom_point(aes(EASTING, NORTHING, color = factor(COLLAR_ID)), data = locs) +
  facet_wrap(~YEAR) +
  guides(color = FALSE, fill = FALSE)


# Iterative plotting ------------------------------------------------------

# Anonymous function
locs[, {
  print(ggplot(.SD) + geom_point(aes(EASTING, NORTHING)))
  1}, 
  by = COLLAR_ID]

# Function
PlotXY = function(in.dt, group, xcol, ycol){
  g <- ggplot(in.dt) +
    geom_point(aes(get(xcol), get(ycol))) +
    labs(title = as.character(group))
  print(g) 
  return(1)
}

DT[, PlotXY(.SD, .BY,
            'EASTING', 'NORTHING'),
   by = HERD]

# Why do we need to return 1?


# grid.arrange ------------------------------------------------------------
# lapply -> grid.arrange

# We'll split up the locs data by individual
#   to mimic where one might have a list of data.frames/tables
#   for some grouping

lsDTs <- split(locs, by = 'COLLAR_ID')
lsPlots <- lapply(seq_along(lsDTs), FUN = function(i){
  ID <- names(lsDTs)[i]
  
  g <- ggplot(lsDTs[[i]]) +
    geom_path(aes(EASTING, NORTHING)) + 
    geom_text(aes(max(EASTING), max(NORTHING)), 
                      label = ID, color = 'forestgreen') + 
    theme(axis.text = element_blank()) + 
    labs(x = NULL, y = NULL)
})

do.call(grid.arrange, lsPlots)
# or
# grid.arrange(grobs = lsPlots)

# There are evidently many issues with this figure
#   but this example is simply to highlight the use of grid.arrange