### Car Plots ====
# Alec Robitaille

### Packages ----
p <- c('data.table', 'ggplot2')
pkgs <- lapply(p, library, character.only = TRUE)


### Input ----
smallcarb <- readRDS('output/1-small-carb.Rds')


### Plot ----
g <- ggplot(smallcarb) +
	geom_point(aes(cyl, mpg))

ggsave('graphics/cyl-mpg.png', width = 3, height = 4)
