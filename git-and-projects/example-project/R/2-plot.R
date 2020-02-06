### Car Plots ====
# Alec Robitaille

### Packages ----
p <- c('data.table', 'ggplot2')
pkgs <- lapply(p, library, character.only = TRUE)


### Input ----
smallcarb <- fread('output/small-carb.csv')


### Plot ----
g <- ggplot(smallcarb) +
	geom_point(aes(cyl, mpg))

ggsave('graphics/cyl-mpg.png', width = 3, height = 4)
