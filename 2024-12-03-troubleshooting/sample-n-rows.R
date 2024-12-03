library(palmerpenguins)
data(penguins)

# Sample N rows from a data.frame
n_rows <- 30
penguins[sample(nrow(penguins), n_rows, replace = FALSE),]

# Or with data.table
library(data.table)
# Convert to data.table
setDT(penguins)
penguins[sample(.N, n_rows)]
