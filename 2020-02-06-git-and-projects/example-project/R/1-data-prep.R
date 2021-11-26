### mtcars example script ====
# Alec Robitaille

### Packages ----
p <- c('data.table')
pkgs <- lapply(p, library, character.only = TRUE)


### Input ----
cars <- fread('input/mtcars.csv')


### Subset ----
smallcarb <- cars[carb < 4]


### Output ----
saveRDS(smallcarb, 'output/1-small-carb.Rds')
