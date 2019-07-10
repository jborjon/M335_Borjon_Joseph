# Activity page: https://byuistats.github.io/M335/parallel_furrr.html
# This package doesn't open one R session per core like parallel; it's smarter
# Steps:
#   1. Load furrr
#   2. Create plan
#   3. Process

pacman::p_load(furrr, purrr, tidyverse, tictoc)

# Technically not necessary, but it gives you more control
num_cores <- availableCores() - 1
plan(multiprocess, workers = num_cores)

# load libraries
#devtools::install_github("hathawayj/buildings")
library(buildings) # remember that the 'permits' data object is created when the library is loaded.
a <- 4
ff <- function(x){
  for (i in 1:1000){
    i
  }
  
  ggplot() + geom_point(x = permits[x, "value"])
}
list_object <- as.list(1:7500)

tic()
temp1 <- map(list_object, ff)
toc()
tic()
temp1 <- future_map(list_object, ff)
toc()

# Second example
second_sequence <- rep(5, 8)

tic()
nothingness <- map(second_sequence, ~Sys.sleep(.x))
toc()

plan(sequential)
tic()
nothingness <- future_map(second_sequence, ~Sys.sleep(.x))
toc()

plan(multiprocess)
tic()
nothingness <- future_map(second_sequence, ~Sys.sleep(.x))
toc()

