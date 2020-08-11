# Load drake
library(drake)


# The plan
plan <- drake_plan(
  downloaded = download_data(),

  prepared = prep_data(downloaded),


  pts = network_pts(prepared, tempthresh = '5 minutes', spatthresh = 50),


  lines = network_lines(prepared, tempthresh = '1 day', spatthresh = 50,
                        projection = '+init=epsg:32736'),


  summarized_pts = summarize_network(pts),

  summarized_lines = summarize_network(lines),


  plotted = plot_metrics(summarized_pts, summarized_lines),
)

# Note, these are not really functions.. we declare dependencies when
#  using code_to_function by putting different steps of the plan
#  within brackets. But these aren't true inputs.

# Plans can extend in many ways:
# * multiple dependencies
# * non linear dependencies
# * knitr/markdown reports
# * etc etc etc

