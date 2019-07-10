---
title: "Notes from Task 19"
author: "Joseph Borjon"
date: "June 26, 2018"
---

## Class notes

**Simple Features** is quickly becoming the standard for spatial data. The man behind it, like most people behind nice packages, is getting funding. In his case, from the government.

*Features* as in "map features".

`sf` can do all kinds of spatial aggregations with relative ease.

GDAL can handle all the millions of geospatial projections. IT's in C++, and the R package is called RGDAL.

Spatial data is often not rectangular.

Although plotting averages is not Brother Hathaway's favorite, when plotting on a map, you should probably summarize or find other ways to avoid obfuscating variables.



## [Spatial Data in R](https://byuistats.github.io/M335/spatial_reading.html)

To read spatial data (the example is a built-in shapefile) with the `sf` package, use `read_sf()`, preferably with `quiet = TRUE` and `stringsAsFactors = FALSE`.

```r
library(tidyverse)
library(sf)

# The counties of North Carolina
nc <- read_sf(system.file("shape/nc.shp", package = "sf"), 
  quiet = TRUE,  
  stringsAsFactors = FALSE
)
```

Most spatial data is stored in a shapefile, which is usually more than one file, typically four:

  * `.shp` contains the geometry
  * `.shx` contains the index to the geometry
  * `.dbf` contains metadata about each geometry (columns in the dataframe)
  * `.prf` contains the coordinate system and projection info

`read_sf()` can read a bunch of spatial formats, not just shapefiles. To read spatial objects (not files) created by another package, use `st_as_sf()`.

These functions return dataframes, not tibbles, that contain mostly normal data, except the `geometry` column, which is a list-column (richest and most complex kind of column as they can contain any data structures) and contains **Simple Features** (ISO 19125) representing polygons.

To plot the geometry: `plot(df$geometry)`.

> `st_area()` returns an object with units (i.e. *m*^2^), which is precise, but a little annoying to work with. I [use]  `as.numeric()` to convert to a regular numeric vector.

To plot spatial data correctly, you need to know the reference in the **coordinate reference system**. To check if the reference is latitude and longitude, check with `st_is_longlat()`.

Most countries have their own set of approximations to latitude and longitude, called **geodetic datums**, that work best for their position on an imperfectly shaped Earth.

To get the datum and other metadata, use `st_crs()`. You can use it with the `crs` argument of `coord_sf()` when you plot with `ggplot2`.

### Plotting with `ggplot2`

To plot a polygon, supply an `sf` object to `geom_sf()`, from the development version of `ggplot2`.

```r
library(tidyverse)
library(sf)
library(maps)

nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
states <- sf::st_as_sf(map("state", plot = FALSE, fill = TRUE))

ggplot() +
  geom_sf(data = states) +
  geom_sf(aes(fill = AREA), data = nc, colour = "white") +
  annotate("point", x = -80, y = 35, colour = "red", size = 4)  # puts a dot on the map
```

If you layer different places as in the example, ggplot2 will ensure they have the same coordinate reference system.

`coord_sf(xlim = c(-81, -79), ylim = c(34, 36))` zooms into the map. `coord_sf(crs = st_crs(102003))` specifies a specific projection.



## [USAboundaries library](https://github.com/ropensci/USAboundaries)

Contains "contemporary state, county, and Congressional district boundaries, as well as zip code tabulation area centroids. It also includes historical boundaries from 1629 to 2000 for states and counties....

"Unlike other R packages, this package also contains historical data for use in analyses of the recent or more distant past."

The package contains one function per available boundary type:

  * `us_states()`: if a date is passed (e.g. `us_states("1840-03-12")`), returns boundaries at that date; otherwise, returns contemporary boundaries
  * `us_counties()`: a date can be passed
  * `us_cities()`: a date can be passed
  * `us_congressional()`: returns only contemporary boundaries
  * `us_zipcodes()`: only contemporary boundaries

The `states` argument accepts a character vector of state or territory names or abbreviations to return only the specified ones.

A few functions accept the `resolution` argument (` = "high"`, etc.) to display more or less detailed boundary information.

The normal sequence of functions is `us_*()`, `plot()`, and `title()`:

```r
states_contemporary <- us_states(resolution = "high")
plot(st_geometry(states_contemporary))
title("Contemporary U.S. state boundaries")
```

`state_plane()` returns EPSG codes and PROJ.4 strings for the State Plane Coordinate System that can be used with `st_transform()`:

```r
va <- us_states(states = "VA", resolution = "high")
va_projection <- state_plane("VA")
va <- st_transform(va, va_projection)
plot(st_geometry(va), graticule = TRUE)
```
