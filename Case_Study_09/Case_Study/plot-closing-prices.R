## @knitr plot_closing_prices

library(tidyverse)
library(dygraphs)
library(timetk)
library(htmltools)

dg_plots <- vector("list", length = length(tickers_today))

for (i in seq_along(tickers_today)) {
  # The highest closing price in the dataset plus some padding, to set a common y-scale
  #y_max <- stocks_data$close %>% max() + 10

  # Data only for the stock in this iteration
  this_stock <- stocks_data %>%
    filter(symbol == tickers_today[[i]])

  # Highest 5-year price for the current stock
  high_row <- this_stock %>%
    filter(close == max(close)) %>%
    mutate(close = round(close, digits = 2))

  # Lowest 5-year price for the current stock
  low_row <- this_stock %>%
    filter(close == min(close)) %>%
    mutate(close = round(close, digits = 2))

  # Add to the list of plots
  dg_plots[[i]] <- this_stock %>%
    select(date, close) %>%
    tk_xts() %>%
    dygraph(
      main = paste(tickers_today[[i]], "5-year closing price history"),
      ylab = "Closing price (USD)",
      width = "100%",
      height = "500"
    ) %>%
    #dyAxis("y", valueRange = c(0, y_max)) %>%
    dyOptions(fillGraph = TRUE, gridLineColor = "#dddddd") %>%
    dySeries("close", label = "Closing price") %>%
    dyAnnotation(
      high_row$date,
      text = paste("$", high_row$close, sep = ""),
      width = 55,
      height = 20
    ) %>%
    dyAnnotation(
      low_row$date,
      text = paste("$", low_row$close, sep = ""),
      width = 55,
      height = 20
    )
}

# Display the plots on the page
tagList(dg_plots)
