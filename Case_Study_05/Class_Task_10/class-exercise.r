library(tidyverse)
library(downloader)

# Save a local temp file to avoid overloading the server
url_csv <- "https://byuistats.github.io/M335/data/building_utility_values.csv"
data_file <- tempfile()
download(url_csv, data_file, mode = "wb")

# Save the data to an object
utility_data <- read_csv(data_file) %>%
  mutate(
    timestamp = parse_datetime(timestamp, format = "%m%.%d%.%Y %H:%M"),
    startdate = parse_date(startdate, format = "%m%.%d%.%Y"),
    enddate = parse_date(enddate, format = "%m%.%d%.%Y"),
  ) %>%
  select(building_id:month, contains("water")) %>%
  separate(building_id, c("state", "building_id"), sep = 2) %>%
  separate(enddate, c("end_year", "end_month", "end_day"), sep = "-", remove = FALSE)

utility_data %>%
  count(state, building_id) %>%
  count(state) %>%
  rename(`Number of buildings` = nn) %>%
  knitr::kable(caption = "Total buildings in each state")

utility_data %>%
  ggplot() +
  geom_point(aes(x = enddate, y = total_potable_water_gal))

View(utility_data)
