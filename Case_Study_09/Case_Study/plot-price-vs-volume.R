## @knitr plot_price_vs_volume

library(tidyverse)
library(ggthemes)
library(scales)

stocks_data %>%
  ggplot(aes(volume / 1000000, close)) +
  geom_jitter(color = "#003366") +
  geom_smooth(color = "#994d00") +
  scale_x_log10() +
  scale_y_continuous(labels = dollar_format(prefix = "$")) +
  labs(
    title = "There appears to be a feeble correlation between trading volume and stock price",
    subtitle = "However, if it exists, the correlation is so weak that it wouldn't have any significant impact on strategy",
    x = "Trading volume (millions of shares, log10-adjusted)",
    y = "Closing price (USD)"
  ) +
  facet_wrap(~ symbol, ncol = 2) +
  theme_economist_white() +
  theme(legend.position = "right")
