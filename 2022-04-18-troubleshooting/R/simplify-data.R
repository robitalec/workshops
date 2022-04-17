# Simplify: data ----------------------------------------------------------
# Alec L. Robitaille



# Packages ----------------------------------------------------------------

# (Extras)
library(charlatan)




# Helpers -----------------------------------------------------------------
# Set an consistent number to sample
N <- 10



# UPPERCASE and lowercase letters in A-Z
LETTERS
letters

# Sequence of letters from 1-N
LETTERS[seq.int(N)]
letters[seq.int(N)]

# Sample N letters
sample(LETTERS, N)
sample(letters, N)



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


# Random numbers between min and max
rnorm(N, min = 0, max = 1)

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




