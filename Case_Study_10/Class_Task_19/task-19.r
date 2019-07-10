library(tidyverse)
library(ggrepel)
library(USAboundaries)
library(sf)

projection <- 102003

contiguous_states <- us_states() %>%
  filter(jurisdiction_type == "state", state_abbr != "HI", state_abbr != "AK") %>%
  st_transform(crs = projection)

top_3_cities_by_state <- us_cities() %>%
  filter(state_abbr %in% contiguous_states$state_abbr) %>%
  group_by(state_abbr) %>%
  top_n(n = 3, wt = population) %>%  # thanks to Henrik at stackoverflow.com/questions/27766054/getting-the-top-values-by-group/27766224
  mutate(
    population = population / 1000,  # thanks to Dallin Webb
    population_ranking = min_rank(desc(population))  # thanks to A5C1D2H2I1M1N2O1R2T1 at stackoverflow.com/questions/26106408/create-a-ranking-variable-with-dplyr
  ) %>%
  st_transform(crs = projection)

largest_city_by_state <- top_3_cities_by_state %>%
  filter(population_ranking == 1)

# Thanks to Dallin Webb for this bit
latitudes <- st_coordinates(largest_city_by_state$geometry)[,1]
longitudes <- st_coordinates(largest_city_by_state$geometry)[,2]

ggplot() +
  geom_sf(data = contiguous_states, fill = NA, inherit.aes = FALSE) +
  geom_sf(
    aes(size = population, color = population_ranking),
    data = top_3_cities_by_state,
    show.legend = "point",  # thanks to Dallin Webb
    inherit.aes = FALSE
  ) +
  geom_label_repel(
    aes(latitudes, longitudes, label = city),
    data = largest_city_by_state,
    color = "#000080",
    size = 3
  ) +
  labs(x = NULL, y = NULL, size = "Population\n(1,000)") +
  guides(color = FALSE) +  # thanks to user3490026 at stackoverflow.com/questions/35618260/remove-legend-ggplot-2-2
  theme_bw()

ggsave("largest-us-cities.png", width = 15, units = "in")
