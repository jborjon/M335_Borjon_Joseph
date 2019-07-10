library(tidyverse)
library(downloader)
library(haven)
library(readxl)

# Define the URLs
url_rds <- "https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS"
url_csv <- "https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv"
url_dta <- "https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta"
url_sav <- "https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav"
url_xlsx <- "https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx"

# Read in the data
rds_data <- read_rds(gzcon(url(url_rds)))
csv_data <- read_csv(url_csv)
dta_data <- read_dta(url_dta)
sav_data <- read_sav(url_sav)

# Excel files are a little different
xlsx_file <- tempfile()
download(url_xlsx, xlsx_file, mode = "wb")
xlsx_data <- read_excel(xlsx_file)

# Check that all the data sets are equal
all.equal(rds_data, csv_data)
all.equal(rds_data, dta_data)
all.equal(rds_data, sav_data)
all.equal(rds_data, xlsx_data)
all.equal(csv_data, dta_data)
all.equal(csv_data, sav_data)
all.equal(csv_data, xlsx_data)
all.equal(dta_data, sav_data)
all.equal(dta_data, xlsx_data)
all.equal(dta_data, xlsx_data)

# Create the box plot
return_data <- csv_data %>%
  filter(contest_period != "Average")

return_data %>%
  ggplot(aes(variable, value)) +
  geom_boxplot() +
  labs(
    title = "Stock returns by index for all 6-month periods between 1990 and 1998",
    x = "Stock index",
    y = "Return per 6-month period"
  ) +
  theme_light()

ggsave("returns-box-plot.png", width = 15, units = "in")

# Create the jittered scatter plot
return_data %>%
  ggplot(aes(contest_period, value, color = variable)) +
  geom_jitter() +
  labs(
    title = "Stock returns for all 6-month periods between 1990 and 1998",
    color = "Stock index",
    x = "Period",
    y = "Return ($)"
  ) +
  scale_color_brewer(palette = "Set2") +
  theme(axis.text.x = element_blank())

ggsave("returns-jitter-plot.png", width = 15, units = "in")

# Create the average return plot
# Thanks to rub a dub dub at https://stackoverflow.com/questions/30183199/ggplot2-plot-mean-with-geom-bar
# for the bit about plotting an average on the y-axis
return_data %>%
  ggplot(aes(variable, value)) +
  geom_bar(fill = "#008080", stat = "summary", fun.y = "mean") +
  labs(
    title = "Average stock returns by index between 1990 and 1998",
    x = "Stock index",
    y = "Average return"
  ) +
  theme_light()

ggsave("average-return-bar-chart.png", width = 15, units = "in")
