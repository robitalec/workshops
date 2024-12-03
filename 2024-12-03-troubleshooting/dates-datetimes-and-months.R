# Generate sequences of dates and datetimes, get month names
n_rows <- 10

DT <- data.frame(
	dates = seq.Date(as.Date('2010-01-01'),
									 as.Date('2010-01-01'),
									 length.out = n_rows)
)
print(DT)

DT <- data.frame(
	dates = seq.POSIXt(as.POSIXct('2010-01-01 10:00:00'),
										 as.POSIXct('2010-01-01 12:00:00'),
									 length.out = n_rows)
)
print(DT)

# Get months
DT$month <- months(DT$dates)

print(DT)
