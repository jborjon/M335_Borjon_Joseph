library(tidyverse)

# Crude suicide rates per 100K population per country in select years
# Source: WHO (http://apps.who.int/gho/data/node.sdg.3-4-data?lang=en)

world_suicides <- read_csv(
    file.path(
      "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
      "data", "Semester_Project", "world-suicides.csv"
    ),
    col_names = FALSE,
    skip = 1
  ) %>%
  .[2:nrow(.), ] %>%
  select(-3, -4, -5)

names(world_suicides) <- c("Country", "Year", "Both Sexes", "Male", "Female")
