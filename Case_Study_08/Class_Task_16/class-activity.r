library(tidyverse)

walmart_openings <- read_csv("https://byuistats.github.io/M335/data/Walmart_store_openings.csv")

walmart_openings %>%
  mutate(open_year = year(mdy(OPENDATE))) %>%
  group_by(open_year, STRSTATE) %>%
  summarise(count = n()) %>%
  mutate(STRSTATE = fct_reorder(STRSTATE, open_year, min))

# To get the colors right
regions <- tibble(state.region, state = state.abb)

dat2 <- walmart_openings %>%
  left_join(regions, by = "state.abb")

walmart_openings %>%
  ggplot(aes(x = open_year), stat = "count") +
  geom_bar() +
  facet_wrap(~ STRSTATE, ncol = 1, strip.position = 1) +
  theme(axis.text.y = element_blank())

ggsave("walmart-openings-by-year.png", width = 8, height = 18, units = "in")
