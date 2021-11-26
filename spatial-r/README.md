Introduction to spatial R
================
Alec L. Robitaille
2020-05-04

## Setup

**Setup before the workshop - just message me directly if you’re having
trouble installing anything.**

[PROJ, GDAL install help](https://r-spatial.github.io/sf/#installing)

``` r
# First install system dependencies:
# units, GEOS, GDAL, PROJ
# See here: https://github.com/r-spatial/sf#installing

# Then packages
pkgs <- c('mapview', 'rgdal', 'sf',
                    'sp', 'raster', 'rgeos',
                    'ggplot2', 'data.table', 'rasterVis',
                    'units', 'rmarkdown', 'learnr', 'devtools')
install.packages(pkgs)
devtools::install_github("hypertidy/geodist")

# Check
all(pkgs %in% installed.packages())
```
