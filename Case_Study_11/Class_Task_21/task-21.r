## @knitr us_map

library(tidyverse)
library(sf)
library(USAboundaries)
library(leaflet)
library(shiny)

# Add custom CSS to make the background white on the Shiny environment
ui <- fluidPage(
  tags$head(
    tags$style(HTML(".leaflet-container { background: #ffffff; }"))
  )
)

# Declare the projection
projection <- leafletCRS(
  crsClass = "L.Proj.CRS",
  code = "EPSG:102003",
  proj4def = "+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs",
  resolutions = 2^(16:8)
)

#Get the US shape data
contiguous_states <- us_states() %>%
  filter(
    jurisdiction_type == "state",
    state_abbr != "AK",
    state_abbr != "HI"
  )

# Get the 3 biggest cities in each state
top_3_cities_by_state <- us_cities() %>%
  filter(state_abbr %in% contiguous_states$state_abbr) %>%
  group_by(state_abbr) %>%
  top_n(n = 3, wt = population) %>%
  mutate(
    population = population / 1000,
    population_ranking = min_rank(desc(population))
  )

# Get the single largest city in each state
largest_city_by_state <- top_3_cities_by_state %>%
  filter(population_ranking == 1)

# Color palette
city_palette <- colorFactor(c("darkblue", "blue", "lightblue"), domain = c(1, 2, 3))

# Create the map
leaflet(
    contiguous_states,
    options = leafletOptions(crs = projection)
  ) %>%
  addPolygons(
    color = "#000000",
    opacity = 1.0,
    fillOpacity = 0.0,
    stroke = TRUE,
    weight = 0.5,
    smoothFactor = 0.5
  ) %>%
  addCircleMarkers(
    data = top_3_cities_by_state,
    lat = ~st_coordinates(geometry)[,2],
    lng = ~st_coordinates(geometry)[,1],
    radius = ~sqrt(population) * 0.12,
    color = ~city_palette(population_ranking),
    weight = 10,
    fillOpacity = 1.0,
    stroke = FALSE,
  ) %>%
  addLabelOnlyMarkers(
    data = largest_city_by_state,
    lat = ~st_coordinates(geometry)[,2],
    lng = ~st_coordinates(geometry)[,1],
    label = ~city,
    labelOptions = labelOptions(
      noHide = TRUE,
      style = list(
        "font-size" = "6pt",
        "padding" = "0.1em"
      )
    )
  )
