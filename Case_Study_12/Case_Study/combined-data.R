## @knitr combine_data

library(tidyverse)

# Get the 2-digit state FIPS code as text
get_state_fips <- function(state_fips) {
  if (state_fips < 10) {
    state_fips <- paste("0", state_fips, sep = "")
  } else {
    as.character(state_fips)
  }
}


# Get the 3-digit county FIPS code as text
get_county_fips <- function(county_fips) {
  if (county_fips < 10) {
    county_fips <- paste("00", county_fips, sep = "")
  } else if (county_fips < 100) {
    county_fips <- paste("0", county_fips, sep = "")
  } else {
    as.character(county_fips)
  }
}

# Vectorize the functions above
get_state_fips <- Vectorize(get_state_fips)
get_county_fips <- Vectorize(get_county_fips)


# Read the RDS suicide file
suicide_data_file <- file.path(
  "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
  "data", "Semester_Project", "us-suicide-data.Rds"
)

suicide_data <- read_rds(suicide_data_file)


# Read the subset file of suicides between 10 and 14 years old
suicide_data_file <- file.path(
  "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
  "data", "Semester_Project", "all-suicides-10-14.Rds"
)

all_suicides_10_14 <- read_rds(suicide_data_file)


# County data
us_counties <- all_suicides_10_14 %>%
  select(1:4) %>%
  mutate(
    statefipschar = get_state_fips(StateFIPS),
    countyfipschar = get_county_fips(CountyFIPS),
    county_5_digit_fips = paste(statefipschar, countyfipschar, sep = "")
  )


# Socioeconomic data
counties_socioeco <- us_counties %>%
  left_join(education_covariate, by = c("StateFIPS" = "fips", "CountyFIPS" = "countyid"))


# Suicide data for all races between ages 10 and 19
counties_suicide_all <- suicide_data %>%
  filter(
    AgeStart >= 10,
    AgeEnd <= 19,
    Race == "All",
    Sex == "Both",
    is.na(HispanicOrigin),
    !is.na(U_A_Rate),
    !is.na(U_C_Rate)
  ) %>%
  group_by(StateFIPS, CountyFIPS) %>%
  summarise(
    TotalDeaths = sum(Deaths),
    AvgCrudeRate = mean(U_C_Rate),
    AvgAdjustedRate = mean(U_A_Rate)
  ) %>%
  ungroup() %>%
  left_join(us_counties, by = c("StateFIPS", "CountyFIPS"))


# Suicide data for everyone 20 and up
counties_suicide_20_up <- suicide_data %>%
  filter(
    AgeStart >= 20,
    Race == "All",
    Sex == "Both",
    is.na(HispanicOrigin),
    !is.na(U_A_Rate),
    !is.na(U_C_Rate)
  ) %>%
  group_by(StateFIPS, CountyFIPS) %>%
  summarise(
    TotalDeaths = sum(Deaths),
    AvgCrudeRate = mean(U_C_Rate),
    AvgAdjustedRate = mean(U_A_Rate)
  ) %>%
  ungroup() %>%
  left_join(us_counties, by = c("StateFIPS", "CountyFIPS"))


# Education test results per county
counties_ed_results <- education_results %>%
  left_join(us_counties, by = c("fips" = "StateFIPS", "countyid" = "CountyFIPS"))
