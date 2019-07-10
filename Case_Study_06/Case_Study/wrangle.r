## @knitr wrangle_data
# Merge datasets and assign each construction project to a specific type

library(tidyverse)
library(stringr)

#devtools::install_github("hathawayj/buildings")
library(buildings)

# This function will save us lots of typing in the project type assignment
# Returns a vector whose elements are either TRUE or FALSE depending on col_values matching project_type
match_types <- function(col_values, project_type) {
  project_type_regex <- project_type %>%
    str_trim() %>%
    str_to_lower() %>%
    str_c(collapse = "|")

  str_detect(col_values, project_type_regex)
}

# These assignments came straight from the master, J. Hathaway
not_restaurants <- c("development","Food preparation center", "Food Services center","bakery","Grocery","concession","Cafeteria", "lunchroom", "lunch room", "school","facility"," hall ")
standalone_retail <- c("Wine","Spirits","Liquor","Convenience","drugstore","Flying J", "Rite Aid ","walgreens ","Love's Travel ")
full_service_type <- c("Ristorante","mexican","pizza ","steakhouse"," grill ","buffet","tavern"," bar ","waffle","italian","steak house")
quick_service_type <- c("coffee"," java "," Donut ","Doughnut"," burger ","Ice Cream ","custard ","sandwich ","fast food "," bagel ")
quick_service_names <- restaurants$Restaurant[restaurants$Type %in% c("coffee","Ice Cream","Fast Food")]
full_service_names <- restaurants$Restaurant[restaurants$Type %in% c("Pizza","Casual Dining","Fast Casual")]

# Create the commercial construction and food service construction datasets for Idaho
idaho_construction <- buildings0809 %>%
  left_join(climate_zone_fips, by = c("FIPS.state", "FIPS.county")) %>%
  as_tibble()

# Austin Halvorsen's ideas really helped me out with the two mutate()s
idaho_food_service <- idaho_construction %>%
  filter(Type == "Food_Beverage_Service") %>%
  mutate(ProjectTitle = str_trim(str_to_lower(ProjectTitle))) %>%
  mutate(ServiceType = case_when(
    match_types(ProjectTitle, not_restaurants) ~ "Other",
    match_types(ProjectTitle, standalone_retail) ~ "Standalone retail",
    match_types(ProjectTitle, full_service_type) | match_types(ProjectTitle, full_service_names) | (SqFt >= 4000 & match_types(ProjectTitle, "(new)")) ~ "Full service",
    match_types(ProjectTitle, quick_service_type) | match_types(ProjectTitle, quick_service_names) | (SqFt < 4000 & match_types(ProjectTitle, "(new)")) ~ "Quick service",
    TRUE ~ "Unknown"
  ))
