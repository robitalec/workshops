# TODO
* host online
* easy install of pkg
* make workshops public?
* install `usethis`
* emphasize learnr tutorials are not really running the same way - the output folder is not visible for example


# Survey results:
Most took a couple courses
Most have done a couple projects
Most have used Arc, half have used R
Most made maps, projected data, raster sampling

Interests:
1. Explore spatial data interactively
2. Working with collar data
3. ~~[tied] Types of spatial data~~
3. [tied] Reading spatial data in R
3. [tied] Sampling rasters
3. [tied] Making maps
3. [tied] Spatial operations
4. Projections

Not really interested:
* where to get data
* subsetting spatial data

Questions:
* where can we get basic landscape maps (e.g for study sites, etc...) ?
* re: where can I get data - I assume that the NL folks probably are all using the same publically available data, but still interested in online sources
*  thyme & olive oil focaccia, it's very tasty with sliced apple
* plotting spatial data
* advantages of different kinds of spatial data, what is a GeoJSON?
* overview of do's and dont's/tips and tricks



# Theory
Raster vs vector


## Reading/writing spatial data in R 



## File types

* Shapefile
	+ widely used and supported
	- multifile format
	- limit to 10 character attribute names, automatic renaming/shortening
	- maximum file size of 2-4GB
	- limited to single geometry types
* GeoPackage
	+ single file
	+ stores vectors and rasters
	+ widely supported (in `sf` for example)
	+ uses a SQLite backend
	- non-streaming format
* GeoJSON
	+ JSON based
	+ good for streaming data
	- not all geometries supported 

```
{
  "type": "Feature",
  "geometry": {
    "type": "Point",
    "coordinates": [125.6, 10.1]
  },
  "properties": {
    "name": "Dinagat Islands"
  }
}
```
	
	
* KML
	 + XML based
	 + popular since it's used in Google Earth
	 - only supports WGS-84




# Questions

# Look up.. 
mapview(raster)


# Day of
use hands for questions / +1 going well / -1 going poorly

screenshots / copy paste to a common g doc
anyone can answer



# Resources
https://keen-swartz-3146c4.netlify.com/
https://mapschool.io/
https://bookdown.org/robinlovelace/geocompr/intro.html
https://keen-swartz-3146c4.netlify.com/
