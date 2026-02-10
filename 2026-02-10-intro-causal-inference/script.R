# === 2026-02-10 Introduction to causal inference -------------------------
# Alec L. Robitaille
# 2026-02-10



# Packages ----------------------------------------------------------------
# Load packages
source('packages.R')



# Variables ---------------------------------------------------------------
# Set theme
theme_set(theme_dag_blank())




# Example 1 ---------------------------------------------------------------
# Example taken from McElreath 2024 Statistical Rethinking L5
# Estimand: What is the causal effect of treatment (anti-fungal) on plant growth?

# Variables
# H0: height at time 0
# H1: height at time 1
# F: fungus
# T: anti-fungal treatment

# DAG
plant_growth <- dagify(
	H1 ~ H0 + F + T,
	F ~ T,
	exposure = 'T',
	outcome = 'H1'
)



# DAG ---------------------------------------------------------------------
fork <- dagify(
	X ~ Z,
	Y ~ Z + X,
	exposure = 'X',
	outcome = 'Y'
)

dag <- dagify(
	y ~ x + a + b,
	x ~ a + b,
	exposure = "x",
	outcome = "y"
)


Estimand

What is the causal effect of treatment (anti-fungal) on plant growth?
	Scientific model

H0: height at time 0
H1: height at time 1
F: fungus
T: anti-fungal treatment

dagify(
	H1 ~ H0 + F + T,
	F ~ T,
	coords = coords
)



# Analysis ----------------------------------------------------------------
# Plot dag with ggdag
ggdag(dag)

# List conditional independencies with dagitty
impliedConditionalIndependencies(dag, type = 'all')

# List adjustment sets with dagitty for direct and total effect
adjustmentSets(dag, effect = 'direct')
adjustmentSets(dag, effect = 'total')

# Plot all paths between exposure and outcome
ggdag_paths(dag)

# Plot adjustment set for estimating the relationship between exposure and outcome
ggdag_adjustment_set(dag)

# Plot Markov equivalent / DAGs that have same conditional independence relationships
ggdag_equivalent_dags(dag)

