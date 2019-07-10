library(tidyverse)
library(Lahman)
library(blscrapeR)

adjusted_usd_2017 <- inflation_adjust(2017) %>%
  mutate(year = as.integer(year)) %>%
  filter(year >= 1985 & year < 2017) %>%
  select(year, adj_value)

player_names <- Master %>%
  mutate(fullName = paste(nameFirst, nameLast)) %>%
  select(playerID, fullName)

school_ids <- CollegePlaying %>%
  select(playerID, schoolID)

school_names <- Schools %>%
  mutate(school_name = name_full) %>%
  select(schoolID, school_name, state)

players <- Salaries %>%
  left_join(adjusted_usd_2017, by = c("yearID" = "year")) %>%
  mutate(salary_adjusted_2017 = salary / adj_value) %>%
  left_join(player_names, by = "playerID") %>%
  left_join(school_ids, by = "playerID") %>%
  left_join(school_names, by = "schoolID") %>%
  filter(state == "UT")

# Plot this diligently joined data
players %>%
  ggplot(aes(yearID, salary_adjusted_2017, color = fullName)) +
  geom_point() +
  geom_line() +
  labs(
    title = "Salaries of ball players from Utah colleges over the years",
    subtitle = paste("BYU has by far the highest number of players, and many of their salaries",
                     "are among the highest to come from Utah.",
                     sep = "\n"),
    x = NULL,
    y = "Salary (US$, adjusted for 2017)",
    color = "Player"
  ) +
  facet_wrap(~ school_name, ncol = 2) +
  theme_bw()

# Save the picture
ggsave("utah-ball-players.png", width = 15, units = "in")
