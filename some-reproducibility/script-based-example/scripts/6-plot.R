# === Plot Metrics --------------------------------------------------------
# Alec Robitaille ---------------------------------------------------------



# Packages ----------------------------------------------------------------
library(ggplot2)
library(data.table)

# Input -------------------------------------------------------------------
metricpts <- readRDS('output/5-metrics-pts.Rds')
metriclines <- readRDS('output/5-metrics-lines.Rds')

# Plot --------------------------------------------------------------------
metricpts[, type := 'pts']
metriclines[, type := 'lines']

combine <- rbindlist(
	list(metricpts, metriclines)
)

(g1 <- ggplot(combine) +
		geom_point(aes(ID, strength, color = type), alpha = 0.8) +
		labs(x = 'Individual', y = 'Strength'))


# Output ------------------------------------------------------------------
ggsave(
	plot = g1,
	filename = 'graphics/5-obs-strength.png',
	width = 5,
	height = 8
)

