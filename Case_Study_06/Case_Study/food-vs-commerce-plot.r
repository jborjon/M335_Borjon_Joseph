# @knitr food_vs_commerce_plot

idaho_construction %>%
  mutate(`Business type` = ifelse(
    Type == "Food_Beverage_Service",
    "Food and beverage",
    "All others"
  )) %>%
  group_by(`Business type`, Year) %>%
  summarise(count = n()) %>%
  ggplot(aes(`Business type`, count, fill = `Business type`)) +
  geom_bar(stat = "identity") +
  labs(
    title = "F&B construction projects plummeted right along with all other types of commercial construction",
    x = "Business type",
    y = "Number of projects"
  ) +
  facet_wrap(~ Year) +
  scale_fill_brewer(palette = "Set2") +
  theme_light()
