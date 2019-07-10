library(tidyverse)

#dat15 <- read_csv("https://query.data.world/s/uw2hhwji6dwz3637unq3twp7z4chl5")
#dat11 <- read_csv("https://query.data.world/s/4sbxrxxvn5fdf5xd7lmlcla2rmzfub")

# dat15 %>%
#   #filter(!is.na(brthwt_g)) %>%
#   sample_n(100000) %>%
#   ggplot(aes(x = date, y = brthwt_g)) +
#     geom_point()

dat15 %>%
  filter(!is.na(brthwt_g)) %>%
  sample_n(100000) %>%
  ggplot(mapping = aes(x = brthwt_g, bins = 10)) +
  geom_histogram()

ggsave("brazil-data.png", width = 15, units = "in")
