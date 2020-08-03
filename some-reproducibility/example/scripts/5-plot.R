# === Plot Metrics --------------------------------------------------------
# Alec Robitaille ---------------------------------------------------------



# Packages ----------------------------------------------------------------
library(ggplot2)


# Input -------------------------------------------------------------------
metrics <- readRDS('output/4-metrics.Rds')


# Plot --------------------------------------------------------------------
(g1 <- ggplot(metrics) +geom_point(aes(ID, strength)) +
 	labs(x = 'Individual', y = 'Strength'))


# Output ------------------------------------------------------------------
ggsave(
	plot = g1,
	filename = 'graphics/5-obs-strength.png',
	width = 7,
	height = 5
)

