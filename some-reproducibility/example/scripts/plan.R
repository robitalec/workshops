library(drake)

# Source variables
source('scripts/variables.R')

# Set renv option for auto snapshots
options(renv.config.auto.snapshot = TRUE)


data_prep <- code_to_function('scripts/data-prep.R')
process <- code_to_function('scripts/process.R')

plan <- drake_plan(
  prepared = data_prep(),
  processed = process(prepared),
  report =   rmarkdown::render(
    knitr_in('md/report.Rmd'),
    output_format = 'all',
    quiet = TRUE
  )
)