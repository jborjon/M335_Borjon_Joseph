## @knitr wrangle

library(tidyverse)

marathons <- read_csv("https://www.dropbox.com/s/wq9e3wqzow500uo/master_marathon.csv?dl=1")


# NY Times plot
marathons %>%
  ggplot() +
  geom_histogram(
    aes(chiptime),
    binwidth = 1,
    fill = "#eeeeee"
  ) +
  labs(
    title = "Distribution of marathon finishing times",
    subtitle = "The small spikes are people making their goals, with not a minute to spare.\nA finishing time of 3:59 is 1.4 times as likely as one of 4:01.",
    x = "Time (minutes)",
    y = "Number of finishing times",
    caption = "Based on data from Eric Allen, USC, Patricia Dechow, U.C. Berkeley, Devin Pope and George Wu, University of Chicago."
  ) +
  coord_cartesian(xlim = c(120, 420)) +
  scale_y_continuous() +
  theme_light() +
  theme(
    text = element_text(
      size = 11,
      family = "Franklin Gothic Book"
    )
  )


# Runner time vs. age
marathons %>%
  ggplot(aes(chiptime, age)) +
  geom_smooth(color = "#f8d568", fill = "#81d8d0") +
  labs(
    title = "As runner age increases, so does finishing time",
    subtitle = "This was originally going to be a scatterplot, which made my machine crash. Twice.",
    x = "Finishing time (minutes)",
    y = "Runner age"
  ) +
  theme_light() +
  theme(
    text = element_text(
      size = 11,
      family = "Franklin Gothic Book"
    )
  )


# Count of males vs females
marathons %>%
  filter(!is.na(gender)) %>%
  ggplot(aes(gender)) +
  geom_bar(fill = "#81d8d0") +
  labs(
    title = "There were about twice the number of males as females in the marathons",
    x = "Gender",
    y = "Count"
  ) +
  theme_light() +
  theme(
    text = element_text(
      size = 11,
      family = "Franklin Gothic Book"
    )
  )
