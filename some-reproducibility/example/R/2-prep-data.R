# === Prep Data -------------------------------------------------------
# Alec Robitaille ---------------------------------------------------------



# Packages ----------------------------------------------------------------
library(data.table)


# Input -------------------------------------------------------------------
DT <- fread('input/1-downloaded-data.csv')

# Process -----------------------------------------------------------------
# Cast the character column as a POSIXct
DT[, datetime := as.POSIXct(datetime)]


# Only grab 2016 data between months 8-12
sub <- DT[year(datetime) == 2016 &
						between(month(datetime), 8, 12)]

# Check counts
sub[, .N, year(datetime)]
sub[, .N, month(datetime)]


# Output ------------------------------------------------------------------
# Save as an Rds to maintain column types
saveRDS(sub, 'output/2-sub-data.Rds')
