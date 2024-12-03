# Using the dput function to generate simplified data for sharing
# dput recreates an R object using a text representation

dput(mtcars[1:10,])

# Assign the output to share in a reprex
DT <- structure(
	list(
		mpg = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19.2),
		cyl = c(6, 6, 4, 6, 8, 6, 8, 4, 4, 6),
		disp = c(160, 160, 108, 258, 360, 225, 360, 146.7, 140.8, 167.6),
		hp = c(110, 110, 93, 110, 175, 105, 245, 62, 95, 123),
		drat = c(3.9, 3.9, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.92),
		wt = c(2.62, 2.875, 2.32, 3.215, 3.44, 3.46, 3.57, 3.19, 3.15, 3.44),
		qsec = c(16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20, 22.9, 18.3),
		vs = c(0, 0, 1, 1, 0, 1, 0, 1, 1, 1),
		am = c(1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
		gear = c(4, 4, 4, 3, 3, 3, 3, 4, 4, 4),
		carb = c(4, 4, 1, 1, 2, 1, 4, 2, 2, 4)
	),
	row.names = c(
		"Mazda RX4",
		"Mazda RX4 Wag",
		"Datsun 710",
		"Hornet 4 Drive",
		"Hornet Sportabout",
		"Valiant",
		"Duster 360",
		"Merc 240D",
		"Merc 230",
		"Merc 280"
	),
	class = "data.frame"
)


DT

