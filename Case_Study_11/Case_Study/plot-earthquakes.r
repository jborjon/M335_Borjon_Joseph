## @knitr plot_earthquakes

library(tidyverse)
library(USAboundaries)
library(leaflet)
library(sf)

ca_counties_geometry <- us_counties() %>%
  filter(state_name == "California") %>%
  select(geometry)

# Source: https://earthquake.usgs.gov/earthquakes/search
earthquakes <- read_csv("us-earthquakes-30-days.csv")

pal <- colorNumeric(
  palette = c("#b60a0a", "#6d0606"),
  domain = earthquakes$depth
)

# Plot the earthquakes
leaflet(
    ca_counties_geometry
  ) %>%
  addTiles() %>%
  addPolygons(
    color = "#000000",
    opacity = 0.2,
    fillOpacity = 0.06,
    stroke = TRUE,
    weight = 0.5,
    smoothFactor = 0.5
  ) %>%
  addCircleMarkers(
    data = earthquakes,
    radius = ~sqrt(mag) * 3,
    color = ~pal(depth),
    fillOpacity = 1.0,
    stroke = FALSE,
  ) %>%
  addLegend(
    "bottomright",
    pal = pal,
    values = ~earthquakes$depth,
    title = "Earthquake depth (km)",
    opacity = 1.0
  )
