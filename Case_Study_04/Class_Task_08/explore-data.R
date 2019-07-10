## @knitr explore_data

library(tidyverse)

read_csv("NCHS_-_Age-adjusted_Death_Rates_for_Selected_Major_Causes_of_Death.csv") %>%
  ggplot(aes(Year, `Age Adjusted Death Rate`, color = Cause)) +
  geom_line(size = 1)

read_csv("Selected_Trend_Table_from_Health__United_States__2011._Leading_causes_of_death_and_numbers_of_deaths__by_sex__race__and_Hispanic_origin__United_States__1980_and_2009.csv") %>%
  filter(`Cause of death` %in% c("All causes", "Alzheimer's disease", "Diseases of heart", "Suicide")) %>%
  ggplot(aes(Year, Deaths, color = Group)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ `Cause of death`)

read_csv("NCHS_-_Top_Five_Leading_Causes_of_Death__United_States__1990__1950__2000.csv") %>%
  ggplot(aes(Cause, `Number of Deaths` / 1000)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(y = "Number of deaths in thousands") +
  facet_wrap(~ Year)