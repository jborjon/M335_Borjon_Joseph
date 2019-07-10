### Retrieve and tidy the data

library(tidyverse)
library(lubridate)
library(riem)
library(hms)
library(ggthemes)

file_name <- "rxe-june-weather.rds"

# rxe_weather_raw <- riem_measures(
#   station = "RXE",
#   date_start = "2015-06-01",
#   date_end = "2017-07-01"
# )
# 
# rxe_june_weather <- rxe_weather_raw %>%
#   mutate(time_stamp = as_datetime(valid, tz = "America/Denver")) %>%
#   transmute(
#     temp_fahrenheit = tmpf,
#     year = year(time_stamp),
#     month = month(time_stamp),
#     day_of_month = mday(time_stamp),
#     day_of_week = wday(time_stamp, label = TRUE, abbr = FALSE),
#     hour_of_day = (as.hms(time_stamp)),
#     date = make_date(year, month, day_of_month),
#   ) %>%
#   filter(!is.na(temp_fahrenheit), month == 6) %>%
#   select(-month) %>%
#   mutate(id = row_number())
# 
# rxe_june_weather %>% write_rds(file_name)



### Plot the data

rxe_june_weather <- read_rds(file_name)

# Question 1: What day of the week had the highest temperature reading?

rxe_june_weather %>%
  group_by(day_of_week) %>%
  summarise(avg_temp = mean(temp_fahrenheit)) %>%
  ggplot(aes(day_of_week, avg_temp)) +
  geom_bar(fill = "#34495e", stat = "identity") +
  labs(
    title = "Average temperatures by days of the week in June 2015, 2016, and 2017 did not vary significantly",
    subtitle = "Mondays and Thursdays had the highest average temperatures",
    x = "Day of the week",
    y = "Average temperature (Fahrenheit)"
  ) +
  theme_economist()

ggsave("avg-temp-june.png", width = 15, units = "in")


max_temp <- rxe_june_weather %>%
  filter(temp_fahrenheit == max(temp_fahrenheit))

rxe_june_weather %>%
  ggplot(aes(id, temp_fahrenheit)) +
  geom_jitter(aes(color = day_of_week)) +
  labs(
    title = "The highest June 2015-2017 temperature was recorded on a Monday",
    x = "Measurement ordinal",
    y = "Temperature (Fahrenheit)",
    color = "Day of the week"
  ) +
  scale_color_brewer(palette = 7) +
  geom_label(aes(label = date), data = max_temp, nudge_y = 2) +
  theme_economist()

ggsave("all-june-temps.png", width = 15, units = "in")

# Question 2: What day of the week had the lowest temperature at 2 pm?
min_temp <- rxe_june_weather %>%
  filter(
    as.hms(hour_of_day) >= as.hms("13:50:00"),
    as.hms(hour_of_day) <= as.hms("14:10:00")
  ) %>%
  filter(temp_fahrenheit == min(temp_fahrenheit))

rxe_june_weather %>%
  filter(
    as.hms(hour_of_day) >= as.hms("13:50:00"),
    as.hms(hour_of_day) <= as.hms("14:10:00")
  ) %>%
  ggplot(aes(id, temp_fahrenheit)) +
  geom_jitter(aes(color = day_of_week)) +
  labs(
    title = "The lowest June 2015-2017 temperature at ~2 p.m. was recorded on a Tuesday",
    x = "Measurement ordinal",
    y = "Temperature (Fahrenheit)",
    color = "Day of the week"
  ) +
  scale_color_brewer(palette = 7) +
  geom_label(aes(label = date), data = min_temp, nudge_y = -3) +
  theme_economist()

ggsave("min-june-temp.png", width = 15, units = "in")
