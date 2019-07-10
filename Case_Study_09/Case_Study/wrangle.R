## @knitr wrangle

library(tidyverse)
library(tidyquant)
library(lubridate)

tickers_today <- c("CXW", "F", "GM", "JCP", "KR", "WDC", "NKE","T", "WDAY", "WFC", "WMT")
stocks_data <- tibble()

for (i in seq_along(tickers_today)) {
  stock <- tq_get(
      tickers_today[[i]],
      get = "stock.prices"
    ) %>%
    filter(date >= today() - years(5)) %>%
    mutate(symbol = tickers_today[[i]])

  stocks_data <- rbind(stocks_data, stock)
}
