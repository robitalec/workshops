# Simplify: data ----------------------------------------------------------
# Alec L. Robitaille



# Packages ----------------------------------------------------------------
library(data.table)
library(ggplot2)

# (Extras)
library(charlatan)
library(mapview)
library(sf)


# Helpers -----------------------------------------------------------------
# Set an consistent number to sample
N <- 100



# UPPERCASE and lowercase letters in A-Z
LETTERS
letters

# Sequence of letters from 1-N
LETTERS[seq.int(N)]
letters[seq.int(N)]

# Sample N letters (careful about replace = TRUE since sample is larger than set)
sample(LETTERS, N, replace = TRUE)
sample(letters, N, replace = TRUE)



# Dates (Date) and datetimes (POSIXct)
start_date <- as.Date('2015-01-01')
end_date <- as.Date('2015-01-31')
start_datetime <- as.POSIXct('2015-01-01 9:00')
end_datetime <- as.POSIXct('2015-01-01 17:00')

# Sequence of dates, by day/week/month/... or with fixed length out (N)
seq.Date(start_date, end_date, by = 'day')
seq.Date(start_date, end_date, length.out = N)

# Sequence of datetimes, by sec/minute/hour/day/... or with fixed length out (N)
seq.POSIXt(start_datetime, end_datetime, by = 'hour')
seq.POSIXt(start_datetime, end_datetime, length.out = N)


# Random numbers with mean and sd
rnorm(N, mean = 0, sd = 1)

# Uniform numbers between min and max
runif(N, min = 0, max = 1)


# Fake (simple) walks
# Modified from: https://stackoverflow.com/a/21991340/3481674
fake_walk <- function(N) {
	x <- seq.int(N)
	y <- cumsum(sample(rnorm(N), N, TRUE))

	data.frame(x = scale(x, center = FALSE),
						 y = scale(y, center = FALSE))
}

plot(fake_walk(1e3))

# See below for a UTM version



# Extras (with charlatan) -------------------------------------------------
# Taxonomies
ch_taxonomic_species(N)
ch_taxonomic_genus(N)
ch_taxonomic_epithet(N)


# Colors
ch_color_name(N)

# Date times
ch_date_time(N)

# Lon, lat
ch_lon(N)
ch_lat(N)




# Extras (spatial) --------------------------------------------------------
# UTM fake (simple) walks
fake_utm_walk <- function(N) {
	x <- seq.int(N)
	y <- cumsum(sample(rnorm(N), N, TRUE))

	y_mid <- sample(runif(1e3, 1e4, 9e6), 1);y_mid
	data.frame(x_utm = scales::rescale(x, to = c(4e5, 6e5)),
						 y_utm = scales::rescale(y, to = c(y_mid - 0.5e5, y_mid + 0.5e5)))
}

plot(fake_utm_walk(1e3))

# (Use any UTM zone you'd like)
fake_utm_walk_sf <- st_as_sf(
	fake_utm_walk(1e3),
	coords = c('x_utm', 'y_utm'),
	crs = st_crs(32614)
)
mapview(fake_utm_walk_sf)


# Fake landscapes with NLMR
# See: https://ropensci.github.io/NLMR/

# Random points in bbox
poly_bbox <- st_as_sfc(st_bbox(fake_utm_walk_sf))
random_pts <- st_sample(poly_bbox, N)

mapview(poly_bbox) + random_pts + fake_utm_walk_sf


# Function ----------------------------------------------------------------
# Combine relevant helpers and other things into a function
#   to make a fake dataset relevant to your analysis
make_fake_data <- function(N_id, N) {
	N_by_id <- N / N_id
	DT <- data.table(id = rep(sample(LETTERS, N_id), each = N_by_id))

	DT[, c('x', 'y') := fake_walk(N_by_id),
		 by = id]

	start_datetime <- as.POSIXct('2015-01-01 9:00')
	end_datetime <- as.POSIXct('2015-01-31 9:00')

	DT[, datetime := seq.POSIXt(start_datetime, end_datetime, length.out = N_by_id),
		 by = id]

}

N <- 1e3
DT <- make_fake_data(5, N)[]

ggplot(DT) +
	geom_path(aes(x, y, color = id)) +
	theme_minimal()


