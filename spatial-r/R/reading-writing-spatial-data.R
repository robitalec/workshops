### Reading spatial data in R ----
# Packages
library(sf)
library(mapview)
library(data.table)

# Load breweries example data from mapview
data(breweries)


# st_write --
#  obj: the sf or sfc object
#  dsn: data source name (depends on the driver)
#  layer: layer name (depends on the drive). if layer is missing, the basename is used.
#  driver: guesses from the dsn, or passed explicitly here.
#  overwrite: default FALSE.

# Check drivers
drivers <- st_drivers()
data.table(drivers)[name == 'GPKG']

# Write the breweries out
st_write(breweries, 'input/breweries.shp')

# Warning message:
# In abbreviate_shapefile_names(obj) :
# 	Field names abbreviated for ESRI Shapefile driver

colnames(breweries)
colnames(st_read('input/breweries.shp', quiet = TRUE))

# !!! Thankfully we were warned... Otherwise we might be confused by "nmbr_f_" and "nmbr_s_"

# st_read()



## eg. collar data (just a flat file CSV)
# data.table::fread
#


### Writing spatial data in R ----
# sf
st_write

# rgdal
writeOGR

layer
dsn
file


writeShapefile
