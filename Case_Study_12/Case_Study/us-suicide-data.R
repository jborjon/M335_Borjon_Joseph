## @knitr pull_suicide_data

library(tidyverse)
library(tools)

# Counts and age-adjusted suicide rates in each US county per 100K population from 2008 to 2014.
# No suicides in the data before the age of 10.
# Source: CDC WISQARS (https://wisqars.cdc.gov:8443/cdcMapFramework/mapModuleInterface.jsp)


# Function: Get Suicide Data --------------------------------------------------------

get_suicide_data <- function(
    csv_url,
    age_range,
    race,
    sex,
    is_hispanic = NA
  ) {
  suicides <- read_csv(csv_url) %>%
    .[22:nrow(.), 2:ncol(.)] %>%
    mutate(
      County = toTitleCase(tolower(County)),
      StateFIPS = as.numeric(StateFIPS),
      CountyFIPS = as.numeric(CountyFIPS),
      Deaths = as.numeric(Deaths),
      Population = as.numeric(Population),
      U_A_Rate = as.numeric(U_A_Rate),
      U_C_Rate = as.numeric(U_C_Rate),
      AgeStart = age_range[[1]],
      AgeEnd = age_range[[2]],
      Race = race,
      Sex = sex,
      HispanicOrigin = is_hispanic
    )
}


# Possible string column values to ensure spelling consistency ------------

races = c(
  white = "White",
  black = "Black",
  native = "Native American / Alaskan Native",
  asian = "Asian / Pacific Islander",
  other = "Other (AI/AN and Asian/PI)",
  all = "All"
)

sexes = c(
  m = "Male",
  f = "Female",
  both = "Both"
)


# All suicides ------------------------------------------------------------

all_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m5683781_csv",
  c(10, 14),
  races[["all"]],
  sexes[["both"]]
)

all_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9204357_csv",
  c(15, 19),
  races[["all"]],
  sexes[["both"]]
)

all_suicides_20_24 <-  get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m3293654_csv",
  c(20, 24),
  races[["all"]],
  sexes[["both"]]
)

all_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m1389411_csv",
  c(25, 29),
  races[["all"]],
  sexes[["both"]]
)

# Everyone over 30
all_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9037452_csv",
  c(30, NA),
  races[["all"]],
  sexes[["both"]]
)


# Male suicides -----------------------------------------------------------

male_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m4842006_csv",
  c(10, 14),
  races[["all"]],
  sexes[["m"]]
)

male_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m964818_csv",
  c(15, 19),
  races[["all"]],
  sexes[["m"]]
)

male_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9149167_csv",
  c(20, 24),
  races[["all"]],
  sexes[["m"]]
)

male_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m5674303_csv",
  c(25, 29),
  races[["all"]],
  sexes[["m"]]
)

male_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m3569119_csv",
  c(30, NA),
  races[["all"]],
  sexes[["m"]]
)


# Female suicides ---------------------------------------------------------

female_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m1612841_csv",
  c(10, 14),
  races[["all"]],
  sexes[["f"]]
)

female_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m7126787_csv",
  c(15, 19),
  races[["all"]],
  sexes[["f"]]
)

female_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m514913_csv",
  c(20, 24),
  races[["all"]],
  sexes[["f"]]
)

female_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m551361_csv",
  c(25, 29),
  races[["all"]],
  sexes[["f"]]
)

female_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m3707781_csv",
  c(30, NA),
  races[["all"]],
  sexes[["f"]]
)


# Hispanic suicides -------------------------------------------------------

hispanic_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m5797153_csv",
  c(10, 14),
  races[["all"]],
  sexes[["both"]],
  TRUE
)

hispanic_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9121146_csv",
  c(15, 19),
  races[["all"]],
  sexes[["both"]],
  TRUE
)

hispanic_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m5277547_csv",
  c(20, 24),
  races[["all"]],
  sexes[["both"]],
  TRUE
)

hispanic_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m2925589_csv",
  c(25, 29),
  races[["all"]],
  sexes[["both"]],
  TRUE
)

hispanic_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m6830612_csv",
  c(30, NA),
  races[["all"]],
  sexes[["both"]],
  TRUE
)


# Non-Hispanic suicides ---------------------------------------------------

non_hispanic_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m8975842_csv",
  c(10, 14),
  races[["all"]],
  sexes[["both"]],
  FALSE
)

non_hispanic_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9780303_csv",
  c(15, 19),
  races[["all"]],
  sexes[["both"]],
  FALSE
)

non_hispanic_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m7802646_csv",
  c(20, 24),
  races[["all"]],
  sexes[["both"]],
  FALSE
)

non_hispanic_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m4327782_csv",
  c(25, 29),
  races[["all"]],
  sexes[["both"]],
  FALSE
)

non_hispanic_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9355711_csv",
  c(30, NA),
  races[["all"]],
  sexes[["both"]],
  FALSE
)


# White-race suicides ----------------------------------------------------------

white_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m6729662_csv",
  c(10, 14),
  races[["white"]],
  sexes[["both"]]
)

white_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m5768762_csv",
  c(15, 19),
  races[["white"]],
  sexes[["both"]]
)

white_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m48087_csv",
  c(20, 24),
  races[["white"]],
  sexes[["both"]]
)

white_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m7321827_csv",
  c(25, 29),
  races[["white"]],
  sexes[["both"]]
)

white_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m4221265_csv",
  c(30, NA),
  races[["white"]],
  sexes[["both"]]
)


# Black suicides ----------------------------------------------------------

black_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m6953092_csv",
  c(10, 14),
  races[["black"]],
  sexes[["both"]]
)

black_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m1606719_csv",
  c(15, 19),
  races[["black"]],
  sexes[["both"]]
)

black_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m377666_csv",
  c(20, 24),
  races[["black"]],
  sexes[["both"]]
)

black_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m5673749_csv",
  c(25, 29),
  races[["black"]],
  sexes[["both"]]
)

black_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m2198884_csv",
  c(30, NA),
  races[["black"]],
  sexes[["both"]]
)


# American Indian / Alaskan Native suicides -------------------------------

native_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m8249138_csv",
  c(10, 14),
  races[["native"]],
  sexes[["both"]]
)

native_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m8304996_csv",
  c(15, 19),
  races[["native"]],
  sexes[["both"]]
)

native_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m8947451_csv",
  c(20, 24),
  races[["native"]],
  sexes[["both"]]
)

native_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m9215605_csv",
  c(25, 29),
  races[["native"]],
  sexes[["both"]]
)

native_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m8735155_csv",
  c(30, NA),
  races[["native"]],
  sexes[["both"]]
)


# Asian / Pacific Islander suicides ---------------------------------------

asian_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m2265877_csv",
  c(10, 14),
  races[["asian"]],
  sexes[["both"]]
)

asian_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m4735118_csv",
  c(15, 19),
  races[["asian"]],
  sexes[["both"]]
)

asian_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m3506065_csv",
  c(20, 24),
  races[["asian"]],
  sexes[["both"]]
)

asian_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m779804_csv",
  c(25, 29),
  races[["asian"]],
  sexes[["both"]]
)

asian_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m673656_csv",
  c(30, NA),
  races[["asian"]],
  sexes[["both"]]
)


# Other (AI/AN and Asian/PI) ----------------------------------------------

other_suicides_10_14 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m14314_csv",
  c(10, 14),
  races[["other"]],
  sexes[["both"]]
)

other_suicides_15_19 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m2237184_csv",
  c(15, 19),
  races[["other"]],
  sexes[["both"]]
)

other_suicides_20_24 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m2639994_csv",
  c(20, 24),
  races[["other"]],
  sexes[["both"]]
)

other_suicides_25_29 <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m3656751_csv",
  c(25, 29),
  races[["other"]],
  sexes[["both"]]
)

other_suicides_30_plus <- get_suicide_data(
  "https://wisqars.cdc.gov:8443/cdcMapFramework/ExcelServlet?excelFile=m3176301_csv",
  c(30, NA),
  races[["other"]],
  sexes[["both"]]
)


# The final table to end all tables ---------------------------------------

suicide_data <- rbind(
  all_suicides_10_14,
  all_suicides_15_19,
  all_suicides_20_24,
  all_suicides_25_29,
  all_suicides_30_plus,

  male_suicides_10_14,
  male_suicides_15_19,
  male_suicides_20_24,
  male_suicides_25_29,
  male_suicides_30_plus,

  female_suicides_10_14,
  female_suicides_15_19,
  female_suicides_20_24,
  female_suicides_25_29,
  female_suicides_30_plus,

  hispanic_suicides_10_14,
  hispanic_suicides_15_19,
  hispanic_suicides_20_24,
  hispanic_suicides_25_29,
  hispanic_suicides_30_plus,

  non_hispanic_suicides_10_14,
  non_hispanic_suicides_15_19,
  non_hispanic_suicides_20_24,
  non_hispanic_suicides_25_29,
  non_hispanic_suicides_30_plus,

  white_suicides_10_14,
  white_suicides_15_19,
  white_suicides_20_24,
  white_suicides_25_29,
  white_suicides_30_plus,

  black_suicides_10_14,
  black_suicides_15_19,
  black_suicides_20_24,
  black_suicides_25_29,
  black_suicides_30_plus,

  native_suicides_10_14,
  native_suicides_15_19,
  native_suicides_20_24,
  native_suicides_25_29,
  native_suicides_30_plus,

  asian_suicides_10_14,
  asian_suicides_15_19,
  asian_suicides_20_24,
  asian_suicides_25_29,
  asian_suicides_30_plus,

  other_suicides_10_14,
  other_suicides_15_19,
  other_suicides_20_24,
  other_suicides_25_29,
  other_suicides_30_plus
)


# Save some data
file_path <- file.path(
  "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
  "data", "Semester_Project", "us-suicide-data.Rds"
)

write_rds(suicide_data, file_path, "none")

file_path <- file.path(
  "C:", "Users", "joebo", "Documents", "Math335", "M335_Borjon_Joseph",
  "data", "Semester_Project", "all-suicides-10-14.Rds"
)

write_rds(all_suicides_10_14, file_path, "none")
