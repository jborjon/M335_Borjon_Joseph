# @knitr ada_county_construction_plot
# In Ada County, how did other commercial construction compare?

ada_county_quick_service <- idaho_food_service %>%
  filter(ServiceType == "Quick service" , AreaName == "Ada County") %>%
  select(Year, Address, Zipcode) %>%
  mutate(`Construction type` = "Quick service food")

ada_county_other_construction <- idaho_construction %>%
  filter(AreaName == "Ada County") %>%
  select(Year, Address, Zipcode)

ada_county_all_construction <- ada_county_other_construction %>%
  left_join(ada_county_quick_service, by = c("Year", "Address", "Zipcode")) %>%
  mutate(`Construction type` = ifelse(is.na(`Construction type`), "Other construction", "Quick service food"))

ada_county_all_construction %>%
  group_by(Year, `Construction type`) %>%
  summarise(count = n()) %>%
  ggplot(aes(`Construction type`, count, fill = `Construction type`)) +
  geom_bar(stat = "identity") +
  labs(
    title = "",
    y = "Number of projects"
  ) +
  facet_wrap(~ Year) +
  scale_fill_brewer(palette = "Set2") +
  theme_light()
