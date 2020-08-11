source("R/plan.R")

# Load R files
lapply(dir("./R", full.names = TRUE), source)


drake_config(plan)
