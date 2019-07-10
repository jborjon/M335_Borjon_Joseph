library(tidyverse)
library(downloader)
library(sf)

# Get the sf data out of the zipped .shp files
get_sf_from_zip <- function(file_path, file_index) {
  temp_file <- tempfile()
  download(file_path, temp_file, mode = "wb")

  sf_data <- unzip(temp_file)[[file_index]] %>%
    read_sf(quiet = TRUE, stringsAsFactors = FALSE)

  # Remove the unneeded temp_file
  unlink(temp_file)

  # Return the data
  sf_data
}


# URLs
counties_url <- "https://byuistats.github.io/M335/data/shp.zip"
wells_url <- "https://research.idwr.idaho.gov/gis/Spatial/Wells/WellConstruction/wells.zip"
dams_url <- "https://research.idwr.idaho.gov/gis/Spatial/DamSafety/dam.zip"
water_url <- "https://research.idwr.idaho.gov/gis/Spatial/Hydrography/streams_lakes/c_250k/hyd250.zip"
projection <- 3857

# Get the Idaho counties data
idaho_counties <- get_sf_from_zip(counties_url, 4) %>%
  filter(StateName == "Idaho")

# Get the wells with over 5,000 gallons in production
wells <- get_sf_from_zip(wells_url, 4) %>%
  filter(Production >= 5000) %>%
  mutate(Production = Production / 1000)

# Get the dams that are larger than 50 acres
dams <- get_sf_from_zip(dams_url, 4) %>%
  filter(SurfaceAre >= 50)

# Get the Snake and Henry's Fork rivers
rivers <- get_sf_from_zip(water_url, 6) %>%
  filter(FEAT_NAME == "Snake River" | FEAT_NAME == "Henrys Fork")


# Plot the data wells and dams and rivers on Idaho
ggplot() +
  geom_sf(
    data = idaho_counties,
    color = "#efefef",
    fill = "#777777"
  ) +
  geom_sf(
    aes(size = Production),
    data = wells,
    color = "#b2dcb2",
    show.legend = "point"
  ) +
  geom_sf(
    data = dams,
    size = 1,
    color = "#f9cccc",
    shape = 2,
  ) +
  geom_sf(
    data = rivers,
    color = "#60aaff"
  ) +
  coord_sf(crs = projection) +
  labs(
    title = "Large oil wells and dams in Idaho",
    subtitle = "Dams are shown in light red",
    size = "Well production\n(1,000s of gallons)"
  ) +
  theme_bw()

ggsave("wells-and-dams.png", width = 15, units = "in")
