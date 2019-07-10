# Activity page: https://byuistats.github.io/M335/parallel.html
# purr is super useful for parallel processing; whenever you have a for
# loop, you should see if you can figure out a way to tweak it and use purr
# Send only what you want to each core, and get back only what you need
# Steps:
#   1. Load package
#   2. Create cluster
#   3. Set up cluster environment
#   4. Process
#   5. Release the cores

library(parallel)

# Calculate the number of cores
num_cores <- detectCores() - 1  # don't take all the cores or you may slow down your computer

# Initiate cluster
cl <- makeCluster(num_cores)

# load libraries
library(tidyverse)
clusterEvalQ(cl, library(tidyverse))

#devtools::install_github("hathawayj/buildings")
library(buildings) # remember that the 'permits' data object is created when the library is loaded.

a <- 4

ff <- function(x){
  for (i in 1:1000) {
    i
  }
  
  ggplot() + geom_point(x = permits[x, "value"])
}

# Export the list of objects
clusterExport(cl, varlist = c("a", "ff", "permits"))

list_object <- as.list(1:7500)

# Some useless test code that takes forever, one single-core and one parallel
system.time(temp1 <- lapply(list_object, ff))
system.time(temp2 <- parLapply(cl, list_object, ff))

# Release the additional cores
stopCluster(cl)
