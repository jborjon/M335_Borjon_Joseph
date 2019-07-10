library(nycflights13)

fl_bp <- flights %>%
  ggplot(aes(x = carrier, y = dep_delay, color = origin)) +
  labs(
    title = "Departure delay per carrier",
    x = "Carrier",
    y = "Departure delay",
    legend = "Done in class, so not likely to be excellent"
  ) +
  coord_cartesian(ylim = c(50, 100)) +
  scale_y_continuous(breaks = seq(50, 100, by = 15)) +
  scale_colour_brewer(palette = "Set1") +

fl_sc <- flights %>%
  filter(dep_time > 800, dep_time < 900) %>%
  ggplot(aes(x = dep_time, y = dep_delay))

fl_bp + geom_boxplot() + theme_bw()
#fl_sc + geom_point() + theme_bw()

