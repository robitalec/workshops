# Load drake
library(drake)

# Code to function (for sequential scripts)
download_data <- code_to_function('scripts/1-download-data.R')
prepare_data <- code_to_function('scripts/2-prep-data.R')
process_pts <- code_to_function('scripts/3-process-pts.R')
process_lines <- code_to_function('scripts/4-process-lines.R')
summarize_data <- code_to_function('scripts/5-summary.R')
plot_data <- code_to_function('scripts/6-plot.R')

# Details: https://books.ropensci.org/drake/scripts.html
# Though drake developer's thoughts: https://books.ropensci.org/drake/scripts.html#final-thoughts


# The plan
plan <- drake_plan(
  downloaded = download_data(),
  prepared = prepare_data(downloaded),
  pts = process_pts(prepared),
  lines = process_lines(prepared),
  summarized = summarize_data(pts, lines),
  plotted = plot_data(summarized),
)

# Note, these are not really functions.. we declare dependencies when
#  using code_to_function by putting different steps of the plan
#  within brackets. But these aren't true inputs.

# Plans can extend in many ways:
# * multiple dependencies
# * non linear dependencies
# * knitr/markdown reports
# * etc etc etc

