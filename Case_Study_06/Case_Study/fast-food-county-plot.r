# @knitr fast_food_county_plot

idaho_food_service %>%
  filter(ServiceType == "Quick service") %>%
  group_by(AreaName, Year) %>%
  summarise(USDSpent = sum(Value1000)) %>%
  ggplot(aes(AreaName, USDSpent, fill = AreaName)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Ada County spent by far the most on fast-food construction both years",
    x = "County",
    y = "Amount spent in thousands (USD)",
    fill = "County"
  ) +
  facet_wrap(~ Year) +
  coord_flip() +
  scale_fill_brewer(palette = "Set2") +
  theme_light()
