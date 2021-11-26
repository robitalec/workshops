## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      eval = FALSE)

## ----a201----------------------------------------------------------------
a2015 <- abs(mean(b2015) - b2015)
a2016 <- abs(mean(b2016) - b2016)
a2017 <- abs(mean(b2017) - b2015)
a2018 <- abs(mean(b2018) - b2018)

## ----c201----------------------------------------------------------------
c2015 <- abs(mean(d2015) - d2015)
c2016 <- abs(mean(d2016) - d2016)
c2016 <- abs(mean(d2017) - d2015)
c2018 <- abs(mean(d2018) - d2018)

## ----calc----------------------------------------------------------------
calc <- function(b) {
  abs(mean(b) - b)
}
a2015 <- calc(b2015)
a2016 <- calc(b2016)
# ...

## ----lapplyBees----------------------------------------------------------
bees <- list(b2015, b2016, b2017, b2018)
lapply(bees, calc)

## ----beesDT--------------------------------------------------------------
bDT <- data.table(yr = rep(c('2015', '2016', '2017', '2018'), each = 100),
								 val = c(b2015, b2016, b2017, b2018))
bDT[, calc(val), by = yr]

## ----addFunction, echo = TRUE, eval = TRUE-------------------------------
add <- function(x, y) {
  x + y
}

## ----formals-------------------------------------------------------------
formals(add)

## ---- eval = TRUE, echo = FALSE------------------------------------------
names(formals(add))

## ----body, eval = TRUE---------------------------------------------------
body(add)

## ----env, eval = TRUE----------------------------------------------------
environment(add)

## ----subDT---------------------------------------------------------------
# Take some of the rows
subDT <- DT[1:1000]

# Maybe randomly
subDT <- DT[sample(.N, 1000)]

# Maybe just an individual
subDT <- DT[ID == 'A']

## ----funSnip-------------------------------------------------------------
name <- function(variables) {
  
}

## ----ptsPlot-------------------------------------------------------------
pts_plot <- function(DT, xCol, 
                     yCol, bys) {
  ggplot(DT) +
    geom_point(aes_string(
      x = xCol, y = yCol, col = bys))
}
pts_plot(DT, 'X', 'Y', 'ID')

## ----get-----------------------------------------------------------------
mean_by <- function(DT, xCol, byCol) {
  DT[, mean(get(xCol)), by = byCol]
}
mean_by(DT = DT, 
        xCol = 'X', byCol = 'ID')

## ----SDcols--------------------------------------------------------------
mean_by <- function(DT, xCol, byCol) {
  DT[, lapply(.SD, mean), by = byCol, 
     .SDcols = xCol]
}
mean_by(DT = DT, 
        xCol = 'X', byCol = 'ID')

## ----broken--------------------------------------------------------------
mean_by <- function(DT, xCol, byCol) {
  DT[, mean(get(xCol)), by = byCol]
}
mean_by(DT, xCol = 'datetime', 'ID')

## ----inputTypes----------------------------------------------------------
mean_by <- function(DT, xCol, byCol) {
  if (!is.numeric(DT[[xCol]])) stop('xCol must be numeric')
  DT[, mean(get(xCol)), by = byCol]
}
mean_by(DT, xCol = 'datetime', 'ID')

## ----lapply, eval = FALSE------------------------------------------------
## lapply(list, function)

## ----seqAlong------------------------------------------------------------
lsFiles <- dir('input/', '*.csv', 
							 full.names = TRUE)
names(lsFiles) <- dir('input/', '*.csv')

lapply(seq_along(lsFiles), function(x) {
	fread(lsFiles[x])[, nm := names(lsFiles)[x]]
}) %>% rbindlist()

## ------------------------------------------------------------------------
comb <- unique(DT[, .(ID, yr)])

xy <- mapply(FUN = function(i, y) {
  DT[ID == i & yr == y, .(X, Y)]
  },
  i = comb$ID,
  y = comb$yr,
  SIMPLIFY = FALSE
)

