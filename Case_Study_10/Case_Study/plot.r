## @knitr plot_geofacet

library(tidyverse)
library(viridis)
library(geofacet)
library(sf)
library(scales)

single_fam_permits %>%
  ggplot(aes(year, num_permits)) +
  geom_rect(
    aes(xmin = 2008, xmax = 2009, ymin = 0, ymax = Inf),
    fill = "#f08080",
    alpha = 0.05
  ) +
  geom_line(size = 1, color = "#0000a0") +
  scale_x_continuous(labels = function(year) substr(year, 3, 4)) +
  scale_y_continuous(trans = "log10", labels = comma) +
  labs(
    title = "Number of single-family building permits issued per state per year, 2002-2010",
    subtitle = paste(
      "Years at the height of the recession highlighted in red.",
      "Y-axis shown on a logarithmic scale to normalize states; otherwise, the 2007-2008 dropoff would look even more dramatic.",
      sep = "\n"
    ),
    x = "Year",
    y = "Single-family permits issued"
  ) +
  facet_geo(~ state_name, grid = "us_state_grid2") +
  theme_bw()


# @knitr plot_us_evolution

# Do people have ideas on how to get PR off the map and plot a map with a projection?
# And how to show the change across states in a more distinctive way?
ggplot() +
  #geom_sf(data = state_boundaries) +
  geom_sf(
    aes(fill = log10(num_permits) * 40000),
    data = single_fam_permits
  ) +
  scale_fill_viridis("Permits\n(log 10)", option = "cividis") +
  coord_sf(crs = 102003) +
  labs(
    title = "Evolution of single-family building construction over time",
    subtitle = "The map gets darker after 2007."
  ) +
  facet_wrap(~ year, ncol = 3) +
  theme_bw()


## @knitr plot_idaho_permits

idaho_permits %>%
  ggplot(aes(year, num_permits)) +
  geom_line(color = "#0000a0", size = 1) +
  geom_point(color = "#b35900", size = 3) +
  labs(
    title = "In Idaho, the dropoff began in 2005",
    subtitle = "Single-family construction peaked sharply in 2005, came back down, and didn't get a chance to recover.",
    x = NULL,
    y = "Single-family construction permits"
  ) +
  theme_bw()
