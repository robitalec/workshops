install.packages('units')
library(units)

x <- 0.1
y <- 0.2

x_rad <- as_units(x, 'rad')
y_rad <- as_units(y, 'rad')
pi_rad <- as_units(pi, 'rad')

(x - y) %% pi
(x_rad - y_rad) %% pi_rad

(y - x) %% pi
(y_rad - x_rad) %% pi_rad

# -------------------------------------------------------------------------

rstudioapi::restartSession(clean = TRUE)
remotes::install_github('https://github.com/r-quantities/units/pull/365')

library(units)

x <- 0.1
y <- 0.2

x_rad <- as_units(x, 'rad')
y_rad <- as_units(y, 'rad')
pi_rad <- as_units(pi, 'rad')

(x - y) %% pi
(x_rad - y_rad) %% pi_rad

(y - x) %% pi
(y_rad - x_rad) %% pi_rad
