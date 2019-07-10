library(sf)
library(USAboundaries)
library(maps)
library(tidyverse)

states <- us_states()
idaho <- us_counties(resolution = "high", states = "ID")

projection <- "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
projection <- "+proj=moll +lat_0=45 +lon_0=-115 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
# projection <- 3857  # Mercator
# projection <- 4267  # NAD27
# projection <- 102003

states_transformed <- states %>%
  st_transform(crs = projection)

idaho_transformed <- idaho %>%
  st_transform(crs = projection)

ggplot() +
  #geom_sf(data = states_transformed, inherit.aes = FALSE) +
  geom_sf(data = idaho_transformed, inherit.aes = FALSE)
