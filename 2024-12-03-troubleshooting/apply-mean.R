library(palmerpenguins)

data("penguins")

penguins

apply(penguins, MARGIN = 2, mean)
