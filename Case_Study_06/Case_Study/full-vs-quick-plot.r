# @knitr full_vs_quick_plot

idaho_food_service %>%
  filter(ServiceType == "Full service" | ServiceType == "Quick service") %>%
  group_by(ServiceType, AreaName, Year) %>%
  summarise(count = n()) %>%
  ggplot(aes(Year, count, group = ServiceType, color = ServiceType)) +
  geom_point(size = 3) +
  geom_line(size = 2) +
  labs(
    title = "Idaho counties saw a general decrease in both types of construction from 2008 to 2009",
    x = "Year",
    y = "Number of projects",
    col = "Building type"
  ) +
  facet_wrap(~ AreaName, nrow = 2) +
  scale_color_brewer(palette = "Set2") +
  theme_light()
