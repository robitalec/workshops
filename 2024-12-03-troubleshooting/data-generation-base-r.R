# Generating fake data with base R and stats functions

# Brief description:
# Snowshoe hare capture data

# Columns:
# - Grid
# - Ear tag
# - Hind foot
# - Weight
# - Sex

library(data.table)

n_grids <- 2
n_individuals <- 10

DT <- data.table(
	grid = rep(LETTERS[seq.int(n_grids)], length.out = n_individuals),
	tag = seq.int(10)
)

DT[, hind_foot := rnorm(.N, mean = 130)]
DT[, Weight := rnorm(.N, mean = 1200)]

print(DT)
