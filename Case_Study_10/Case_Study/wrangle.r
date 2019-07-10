## @knitr wrangle_data

library(tidyverse)
library(buildings)
library(USAboundaries)

states_fp_numeric <- us_states() %>%
  filter(jurisdiction_type != "territory") %>%
  mutate(state = as.numeric(statefp))

single_fam_permits <- permits %>%
  filter(variable == "Single Family", year >= 2002) %>%
  group_by(state, year) %>%
  summarise(num_permits = sum(value)) %>%
  left_join(states_fp_numeric, by = "state")

idaho_permits <- permits %>%
  filter(StateAbbr == "ID", variable == "Single Family", year >= 1995) %>%
  left_join(states_fp_numeric, by = "state") %>%
  group_by(year) %>%
  summarise(num_permits = sum(value))

# May or may not get used in the geographic US plot
state_boundaries <- us_states() %>%
  filter(name != "Puerto Rico", name != "District of Columbia")
