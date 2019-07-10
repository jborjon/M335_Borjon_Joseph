INCH_FACTOR <- 2.54
# Load the pertinent libraries
library(tidyverse)
library(downloader)
library(readxl)
library(haven)
library(foreign)

# Tidy the Tubingen University height data by country and birth decade
temp_file <- tempfile()
download("https://byuistats.github.io/M335/data/heights/Height.xlsx", temp_file, mode = "wb")
read_excel(temp_file, range = "A3:GU309") %>%
  rename(country = "Continent, Region, Country") %>%
  filter(
    !is.na(Code),
    Code != 2,
    Code != 5,
    Code != 9,
    Code != 11,
    Code != 13,
    Code != 14,
    Code != 15,
    Code != 17,
    Code != 18,
    Code != 19,
    Code != 21,
    Code != 29,
    Code != 30,
    Code != 34,
    Code != 35,
    Code != 39,
    Code != 54,
    Code != 57,
    Code != 61,
    Code != 142,
    Code != 143,
    Code != 145,
    Code != 150,
    Code != 151,
    Code != 154,
    Code != 155
  ) %>%
  gather(
    `1800`:`2011`,
    key = "year_decade",
    value = "height_cm",
    na.rm = TRUE
  ) %>%
  separate(
    year_decade,
    into = c("century", "year"),
    sep = 2,
    remove = FALSE
  ) %>%
  separate(
    year,
    into = c("decade", "year"),
    sep = 1
  ) %>%
  mutate(height_in = round(height_cm / INCH_FACTOR, 1)) %>%
  transform(height_cm = round(height_cm, 1)) %>%
  write_rds("worldwide-height-estimates.rds")




# Load the German male conscripts data - notice we're reusing temp_file to save memory
temp_file <- tempfile()
download("https://byuistats.github.io/M335/data/heights/germanconscr.dta", temp_file, mode = "wb")
conscript_height <- read_dta(temp_file) %>%
  transmute(
    study_id = "g19",
    birth_year = bdec,
    height_in = round(height / INCH_FACTOR, 0),
    height_cm = round(height, 0)
  )

# Bavarian male consripts height data
temp_file = tempfile()
download("https://byuistats.github.io/M335/data/heights/germanprison.dta", temp_file, mode = "wb")
bavaria_height <- read_dta(temp_file) %>%
  transmute(
    study_id = "b19",
    birth_year = bdec,
    height_in = round(height / INCH_FACTOR, 0),
    height_cm = height
  )

# Heights of southeast and southwest German soldiers born in the 18th century
temp_file <- tempfile()
download("https://byuistats.github.io/M335/data/heights/Heights_south-east.zip", temp_file, mode = "wb")
south_height <- unzip(temp_file, "B6090.DBF") %>%
  read.dbf() %>%
  transmute(
    study_id = "g18",
    birth_year = SJ,
    height_in = round(CMETER / INCH_FACTOR, 0),
    height_cm = round(CMETER, 0)
  )

# Wage and height data from the Bureau of Labor Statistics
temp_file <- tempfile()
download("https://github.com/hadley/r4ds/raw/master/data/heights.csv", temp_file, mode = "wb")
bls_height <- read_csv(temp_file) %>%
  transmute(
    study_id = "us20",
    birth_year = 1950,
    height_in = round(height, 0),
    height_cm = round(height_in * INCH_FACTOR, 0)
  )

# National Survey data from Wisconsin
temp_file <- tempfile()
download("http://www.ssc.wisc.edu/nsfh/wave3/NSFH3%20Apr%202005%20release/main05022005.sav", temp_file, mode = "wb")
national_survey <- read_sav(temp_file) %>%
  filter(
    DOBY >= 1,  # anything entered as a negative number was either unknown or refused
    RT216I >= 0,  # remove heights whose inches are invalid...
    RT216I < 12  # ...or so high that the entry is questionable
  ) %>%
  transmute(
    study_id = "w20",
    birth_year = 1800 + DOBY,
    height_in = RT216F * 12 + RT216I,
    height_cm = round(height_in * INCH_FACTOR, 0)
  )

# We don't need the contents of temp_file anymore, and they're kinda big
unlink(temp_file)

# Combine the previous five datasets into one
bind_rows(conscript_height, bavaria_height, south_height, bls_height, national_survey) %>%
  write_rds("surveys-height-data.rds")
