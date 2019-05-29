### Summary Stats ====
# Alec Robitaille
# Epi Lunch & Learn
# May 29 2019


### Packages ----
pkgs <- c('readxl', 'tidyr', 'dplyr', 'janitor', 'assertr')
p <- lapply(pkgs, library, character.only = TRUE)


### Data ----
DT <- read_excel('data/raw-data/ED visits for Alec.xls')


### Cleanup ----
# Remove spaces from column names, fix inconsistent column name formatting
DT <- DT %>%
	clean_names(case = 'upper_camel')

# Fill missing information in all columns except Diagnosis columns
DT <- DT %>%
	fill(-DiagnosisType, -Diagnosis, -DiagnosisLongText)


### Cast columns ----
tz <- 'Canada/Yukon'
DT <- DT %>%
	mutate(VisitDate = as.Date(VisitDate, tz = tz))


### Data checks ----
expectedResidence <-
	c(
		"Whitehorse",
		"Haines Junction",
		"Carcross",
		"Mayo",
		"Dawson",
		"Faro",
		"Ross River",
		"Watson Lake"
	)

## Use assertr to check the data:
# Chains allow all expressions to run
# Verify takes an expression
# Assert takes a function/predicate
DT %>%
	chain_start %>%
	verify(PatientAge > 0) %>%
	assert(in_set(c('M', 'F')), Gender) %>%
	assert(in_set(expectedResidence), YtResidenceCode) %>%
	chain_end


# Or abstracting all the checks
check_me <- . %>%
	chain_start %>%
	verify(PatientAge > 0) %>%
	assert(in_set(c('M', 'F')), Gender) %>%
	assert(in_set(expectedResidence), YtResidenceCode) %>%
	chain_end

DT %>%
	check_me %>%
	group_by(PatientAge) %>%
	count()


### Export data ----
saveRDS(DT, 'data/derived-data/1-prep/cleaned-ed-visits.Rds')
