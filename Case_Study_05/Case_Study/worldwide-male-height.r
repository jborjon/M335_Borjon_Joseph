## @knitr worldwide_male_height

library(tidyverse)

world_height <- read_rds("worldwide-height-estimates.rds")

# Summarize the data from all the countries that are considered Germany today, averaging their heights
germany_height <- world_height %>%
  filter(grepl("Germany", country)) %>%
  group_by(year_decade) %>%
  summarise(mean_height = mean(height_in))

# Plot the world's male height throughout the last couple of centuries, with Germany highlighted
world_height %>%
  ggplot() +
  geom_boxplot(aes(year_decade, height_in), color = "darkgray", fill = "#b2d8d8") +
  geom_point(data = germany_height, aes(year_decade, mean_height), color = "red") +
  labs(
    title = "German males have generally increased in height at a faster pace than most of the world",
    subtitle = "German heights are highlighted in red",
    x = "Decade",
    y = "Height estimate by country (in)"
  ) +
  theme_light()
