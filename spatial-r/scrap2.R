library(sf)
library(mapview)
library(data.table)




data(breweries)


drivers <- st_drivers()

# Explore the drivers to find a couple of the above file formats
# If we convert to a data.table we can filter easily
data.table(drivers)[name == 'GPKG']


data.table(drivers)[name == 'GeoJSON']

dir.create('output')

st_write(breweries, 'output/breweries.gpkg')

st_write(breweries, 'output/breweries.shp')


colnames(breweries)
colnames(st_read('output/breweries.shp', quiet = TRUE))

colnames(st_read('output/breweries.gpkg', quiet = TRUE))

st_write(breweries, 'output/breweries.GeoJSON')


# Reading

# sf object
sf <- sf::st_read('output/breweries.shp')

# sp object
readogr <- rgdal::readOGR('output/breweries.shp')
all.equal(shp, readogr)

# Print

# Plot

# Mapview

# Summarize
summary(shp)

