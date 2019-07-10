## @knitr wrangle_data
library(tidyverse)
library(lubridate)

# Get all valid transactions
# Notes on the data:
# LaBelle had a huge transaction at the very end, which could have been selling off inventory or materials. Keeping it.
# Tacontento, Frozone, and Hot Diggity had one or two big transaction each, which could have been catering. Keeping it.
ibc_transactions <- read_csv("https://byuistats.github.io/M335/data/sales.csv") %>%
  mutate(
    Time = as_datetime(Time, tz = "America/Denver"),
    Time = replace(  # fix a sale on April 20, before companies were formed: assuming entry error in May
      Time,
      Time == as_datetime("2016-04-20 13:01:00", tz = "America/Denver"),
      as_datetime("2016-05-20 13:01:00", tz = "America/Denver")
    ),
    Amount = replace(  # how could Splash and Dash have a single $350 transaction with a ~$30 service? Assuming $35
      Amount,
      Amount == 350,
      35.00
    ),
    `Company name` = case_when(  # use the businesses' real names
      Name == "HotDiggity" ~ "Hot Diggity",
      Name == "ShortStop" ~ "Short Stop",
      Name == "SplashandDash" ~ "Splash 'n Dash",
      TRUE ~ Name
    ),
    Week = ceiling_date(Time, "week"),
    Day = ceiling_date(Time, "day"),
    `Hour of day` = hour(ceiling_date(Time, "hour"))
  ) %>%
  filter(
    Name != "Missing",
    Amount != 0,  # not using $0 transactions but keeping negatives (expenses)
    wday(Time) != 1  # remove Sunday transactions
  )

# Get the sales only
ibc_sales <- ibc_transactions %>%
  filter(Amount > 0)

# Get the expenses only
ibc_expenses <- ibc_transactions %>%
  filter(Amount < 0)

# View(ibc_transactions)
# View(ibc_sales)
# View(ibc_expenses)

# Explore the data
# ibc_transactions %>%
#   group_by(Name) %>%
#   summarise(
#     count = n(),
#     min_value = min(Amount),
#     max_value = max(Amount),
#     total = sum(Amount)
#   ) %>%
#   View()

# Exploratory plot
# ibc_transactions %>%
#   ggplot(aes(Time, Amount)) +
#   geom_jitter() +
#   coord_cartesian(xlim = ) +
#   facet_wrap(~ Name)
