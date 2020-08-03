# Load drake
library(drake)

# Code to function (for sequential scripts)
download_data <- code_to_function('scripts/1-download-data.R')
prepare_data <- code_to_function('scripts/2-prep-data.R')
process_data <- code_to_function('scripts/3-process.R')
summarize_data <- code_to_function('scripts/4-summary.R')
plot_data <- code_to_function('scripts/5-plot.R')

# Details: https://books.ropensci.org/drake/scripts.html
# Though drake developer's thoughts: https://books.ropensci.org/drake/scripts.html#final-thoughts


# The plan
plan <- drake_plan(
  downloaded = download_data(),
  prepared = prep_data(downloaded),
  processed = process_data(prepared),
  summarized = summarize_data(processed),
  plotted = plot_data(summarized),
)

# Plans can extend in many ways:
# * multiple dependencies
# * non linear dependencies
# * knitr/markdown reports
# * etc etc etc

