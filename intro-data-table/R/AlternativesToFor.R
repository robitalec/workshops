### data.table / alternative to for loops ==== 


# Alec Robitaille
# November 16 2017
# WEEL

libs <- c('ggplot2', 'data.table')
lapply(libs, require, character.only = TRUE)

### Basic data.table -----------------------------------------------------------

## Input data ----
# Read in ggplot2's example data
diamonds <- fread('input/diamonds.csv')

diamonds


## take I ... ----

# Subset diamonds where color is E
diamonds[color == 'E']

# Subset diamonds where carat is less than 0.3
diamonds[carat < 0.3]

# Subset diamonds carat lt 0.3 and price lt 400
diamonds[carat < 0.3 & price < 400]

# Order the data.table on the carat col
diamonds[order(carat)]

# Order the data.table on the color then carat col
diamonds[order(color, carat)]


## Basic data.table column wrangling ----

# Pull out the cut column as a vector
diamonds[, cut]

# Pull out the cut column as a data.table
diamonds[, .(cut)]

# Pull out the cut and clarity column 
diamonds[, .(priceTmes8 = price*8, clarity)]


## Basic j ----
# calc sum of diamonds price
diamonds[, sum(price)]

# again, but return as a data.table
diamonds[, .(sum(price))]

# again, but change the column name from V1
diamonds[, .(sumPrice = sum(price))]

# calculate the mean carat and sum price
# and return as a data.table with a proper name
diamonds[, .(sumPrice = sum(price),
             meanCarat = mean(carat))]

## Add/modify columns (by reference) ----
# Add mean carat as a column
diamonds[, meanCarat := mean(carat)]

# again add the mean carat but also add the max carat (same line)
diamonds[, c('meanCarat', 'maxCarat')  := .(mean(carat), max(carat))]

# now let's remove the mean carat column
diamonds[, meanCarat := NULL]

# and in one line, remove the carat and cut columns
diamonds[, c('carat', 'cut') := NULL]


## data.table's by ----
# calculate the mean carat by color
diamonds[, mean(carat), by = color]

# how do we fix the column name?
diamonds[, .(meanPrice = mean(price)), by = color]


# using color and clarity, write the line above with two different 
# by syntax
diamonds[, mean(price), by = .(color, clarity)]
diamonds[, mean(price), by = c('color', 'clarity')]
diamonds[, mean(price), by = color:clarity]


# Calculate the mean price carat is greater than 2.5
diamonds[, mean(price), by = carat > 2.5]

# Use a character vector to calculate mean price 
# on two columns
cols <- c('color', 'clarity')
diamonds[, mean(price), by = cols]


## .SD  ----
# Using lapply and .SD, calculate the mean carat and depth
diamonds[, lapply(.SD, mean), .SDcols = c('depth', 'carat')]

# Again, but by color grouping
diamonds[, lapply(.SD, mean), 
  .SDcols = c('price', 'carat'), 
  by = color]
  
## .N ----
# how many rows are in the diamonds DT
diamonds[, .N]

# how many in each color and cut group  
diamonds[, .N, by = .(ID,dateimte)][order(-N)]

locs[, Nlocs := .N, by = .(ID, datetime)]

onlythose <- locs[Nlocs > 10]

## .BY ----
# Use the .BY to plot a histogram of price by color
diamonds[order(color), print(qplot(price, main = as.character(.BY))), by = color]
  
diamonds[, {qplot(price, main = as.character(.BY))
            1},
         by = color]


# paste the two columns grouping into one variable 
diamonds[, paste0(.BY[1], .BY[2]),  by = .(carat, color)]
  


## GRP ----
diamonds[, .GRP, by = color]

# assign a group index column using the color group

  

## Advanced ----
# Subset diamonds price is the max price
diamonds[price == max(price)]

# randomly select 5 rows from the diamonds DT
diamonds[sample(.N, 5)]


### data.table Step Length ----
# Set columns
time.col <- 'datetime'
coord.cols <- c('EASTING', 'NORTHING')

# Create lag and dif column names
lag.cols <- paste('lag', coord.cols, sep = '')
difference.cols <- c('difX', 'difY')

lag.time.col <- paste0('lag', time.col)
dif.time.col <- paste0('dif', time.col)

# Use shift  to create lagged cols
locs[order(get(time.col)), (lag.cols) := shift(.SD, 1, NA, 'lag'),
     by = .(ANIMAL_ID, year),
     .SDcols = coord.cols]

# Find the difference squared between all points in each x,y separately
locs[, (difference.cols) := .((get(coord.cols[1]) - get(lag.cols[1])) ^2,
                              (get(coord.cols[2]) - get(lag.cols[2])) ^2)]

# Square root the summed difference for a simple step length
locs[, simpleStep := sqrt(rowSums(.SD)),
     .SDcols = difference.cols]

## Delta Time
locs[order(get(time.col)), (lag.time.col) := shift(.SD, 1, NA, 'lag'), 
     by = .(ANIMAL_ID, year),
     .SDcols = time.col]

# difference in time in hours
locs[, (dif.time.col) := as.numeric(get(time.col) - get(lag.time.col), units = 'hours')]

# Simple step length divided by time difference
locs[, moveRate := simpleStep / (get(dif.time.col))]

## Randomly sample vertices 
# Drop columns leaving only needed
cols <- c('EASTING', 'NORTHING', 'blockByIDYear', 'ANIMAL_ID', 'block', 'HERD')

# and set all locs as observed
observed.locs <- locs[, ..cols][, observed := 1]

# Create identical for random with observed == 0
random.locs <- locs[, ..cols][, observed := 0]

# Generate an equivalent number of random points in vertices as observed (with encamped state)
# (updating the observed locs EASTING, NORTHING columns)
random.locs[, c('EASTING', 'NORTHING') := as.data.table(spsample(vertices.95[vertices.95@data$id == .BY[[1]],],
                                                                 .N, iter = 100, type = "random")@coords),
            by = blockByIDYear]
