---
title: "Notes from Task 21"
author: "Joseph Borjon"
date: "July 3, 2018"
---

## [Leaflet for R](http://rstudio.github.io/leaflet)

One of the most populat JS libraries for interactive maps, used by the NYT, Washington Post, GitHub, Flickr, etc.

### Basic usage

```r
library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map
```

### Map widget

```r
# Set value for the minZoom and maxZoom settings.
leaflet(df, options = leafletOptions(minZoom = 0, maxZoom = 18))
```

### Basemaps

```r
m <- leaflet() %>% setView(lng = -71.0589, lat = 42.3601, zoom = 12)
m %>% addTiles()
```

### Icon markers

```r
data(quakes)

# Show first 20 rows from the `quakes` dataset
leaflet(data = quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag), label = ~as.character(mag))
```

### Circle markers

```r
# Create a palette that maps factor levels to colors
pal <- colorFactor(c("navy", "red"), domain = c("ship", "pirate"))

leaflet(df) %>% addTiles() %>%
  addCircleMarkers(
    radius = ~ifelse(type == "ship", 6, 10),
    color = ~pal(type),
    stroke = FALSE, fillOpacity = 0.5
  )
```

### Popups

```r
content <- paste(sep = "<br/>",
  "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
  "606 5th Ave. S",
  "Seattle, WA 98138"
)

leaflet() %>% addTiles() %>%
  addPopups(-122.327298, 47.597131, content,
    options = popupOptions(closeButton = FALSE)
  )
Samurai Noodle
606 5th Ave. S
Seattle, WA 98138
```

### Labels

```r
library(htmltools)

df <- read.csv(textConnection(
"Name,Lat,Long
Samurai Noodle,47.597131,-122.327298
Kukai Ramen,47.6154,-122.327157
Tsukushinbo,47.59987,-122.326726"))

leaflet(df) %>% addTiles() %>%
  addMarkers(~Long, ~Lat, label = ~htmlEscape(Name))
```

### Colors

```r
# Apply the function to provide RGB colors to addPolygons
map %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 1,
    color = ~pal(gdp_md_est))
```
