## @knitr height_across_centuries

library(tidyverse)

surveys_height <- read_rds("surveys-height-data.rds") %>%
  mutate(
    century = case_when(
      birth_year >= 1700 & birth_year < 1800 ~ 18,
      birth_year >= 1800 & birth_year < 1900 ~ 19,
      birth_year >= 1900 & birth_year < 2000 ~ 20
    )
  )

surveys_height %>%
  ggplot(aes(birth_year, height_in)) +
  geom_boxplot(color = "darkgray", fill = "#b2d8d8") +
  facet_wrap(~ study_id, nrow = 2) +
  labs(
    title = "Male height data differ in each study more than they do over time",
    x = "Birth year",
    y = "Height (inches)"
  ) +
  theme_light()

## @knitr bls_height

surveys_height %>%
  filter(study_id == "us20") %>%
  ggplot(aes(birth_year, height_in)) +
  geom_boxplot(color = "darkgray", fill = "#b2d8d8") +
  labs(
    title = "BLS height data, assuming all births were in 1950",
    subtitle = "Birth year axis widened to show details; decimal points are irrelevant",
    x = "Birth year",
    y = "Height (inches)"
  ) +
  theme_light()
