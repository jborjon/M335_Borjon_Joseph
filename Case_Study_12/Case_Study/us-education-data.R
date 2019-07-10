## @knitr pull_education_data

library(tidyverse)
library(stringr)
library(tools)
library(USAboundaries)

# Sean F. Reardon, Andrew D. Ho., Benjamin R. Shear, Erin M. Fahle, Demetra Kalogrides,
# & Richard DiSalvo. (2018). Stanford Education Data Archive (Version 2.1).
# http://purl.stanford.edu/db586ns4974.

education_results <- read_csv(
    file.path(
      "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
      "data", "Semester_Project", "SEDA_county_pool_GCS_v21.csv"
    )
  ) %>%
  mutate(
    countyname = countyname %>%
      str_replace(  ## remove all suffixes, which don't appear in the suicides data
        " COUNTY$| BOROUGH$| CENSUS AREA$| CITY$| CITY AND BOROUGH$| MUNICIPALITY$| PARISH$",
        ""
      ) %>%
      tolower() %>%
      toTitleCase(),
    countyid = as.numeric(str_sub(countyid, 3, 5)),
    fips = as.numeric(fips)
  ) %>%
  filter(subgroup == "all")


# Covariate data for the education dataset
education_covariate <- read_csv(
    file.path(
      "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
      "data", "Semester_Project", "SEDA_cov_geodist_pool_v21.csv"
    )
  ) %>%
  mutate(
    countyid = as.numeric(str_sub(countyid, 3, 5)),
    fips = as.numeric(fips)
  ) %>%
  filter(!is.na(countyid)) %>%
  select(countyid, fips, urban:seshsp) %>%
  group_by(fips, countyid) %>%
  summarise_at(vars(urban:seshsp), mean, na.rm = TRUE) %>%
  ungroup()
