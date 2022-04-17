# === Learn chk -----------------------------------------------------------
# Alec L. Robitaille



# Install -----------------------------------------------------------------
install.packages('chk')



# Packages ----------------------------------------------------------------
library(chk)

# For data, if suitable
library(palmerpenguins)

library(data.table)
library(ggplot2)


# Data --------------------------------------------------------------------
DT <- data.table(penguins)



# Try chk -----------------------------------------------------------------
# chk_numeric()
chk_numeric(DT$body_mass_g)

# vld_numeric()
vld_numeric(DT$body_mass_g)

# chk_* vs vld_*
# chk returns an error if the test fails, while vld returns a boolean TRUE/FALSE

# chk_is(object, class)
chk_is(DT, 'data.table')


# Try using a chk within a custom function
plot_bill_depth_by_species <- function(DT) {
	chk_factor(DT$species)
	chk_numeric(DT$bill_depth_mm)

	ggplot(DT) +
		geom_histogram(aes(bill_depth_mm, fill = species), alpha = 0.7) +
		theme_minimal()
}

plot_bill_depth_by_species(DT)

DT[, species := as.integer(species)]

plot_bill_depth_by_species(DT)

rlang::last_error()
