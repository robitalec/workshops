# === Metadata: Editor ----------------------------------------------------
# Alec Robitaille

# Install
# install.packages(c('dataspice', 'xfun'))

# Load
library(dataspice)
library(data.table)
library(xfun)

source('R/functions.R')

# Pick dataset ------------------------------------------------------------------
datasets <- fread('data/datasets.csv')

View(datasets)

# Select the dataset to use
DT <- datasets[admin == 'MB' &
							 	region == 'RMNP' &
							 	specific == 'Wolf' &
							 	thematic == 'Telemetry']


# Automatic ---------------------------------------------------------------
if(DT[, .N] > 1) stop('select only one row of the datasets.csv file')

paths <- get_paths(DT)
datapath <- paths$datapath
metapath <- paths$metapath
htmlpath <- paths$htmlpath

z <- manual_setup(paths)

# Edit metadata -----------------------------------------------------------
# Prep access
#   only tabular .csv and .tsv or .rds files are supported
#   if your data is some other format, move on
prep_access(
	data_path = datapath,
	access_path = file.path(metapath, 'access.csv')
)

# Prep attributes
#   only tabular .csv and .tsv or .rds files are supported
#   if your data is some other format, move on
#
#   Note: you can choose not to run this and manually input column names
prep_attributes(
	data_path = datapath,
	attributes_path = file.path(metapath, 'attributes.csv')
)


# Fill in contentURL only, leaving other columns as they are
edit_access(metadata_dir = metapath)

# Fill in all attributes
# Note these are not R attribute types,
#  they described how data is stored in the raw file
edit_attributes(metadata_dir = metapath)


# If you are unsure, fill in your information as the metadata author
edit_creators(metadata_dir = metapath)


# Calculate temporal and geographic ranges
# DT <- fread(path)
# DT[, range(datetime)]
# DT[, range(X_COORD)]
# DT[, range(Y_COORD)]

# Fill in temporal, geographic ranges, and other details
edit_biblio(metadata_dir = metapath)


# Finally (always) --------------------------------------------------------
# Write out
write_spice(path = metapath)

# Generate docs
build_site(
	path = file.path(metapath, 'dataspice.json'),
	out_path = htmlpath
)
