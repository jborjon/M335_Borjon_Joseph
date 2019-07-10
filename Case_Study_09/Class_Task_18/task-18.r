## @knitr plot_kr

library(tidyverse)
library(tidyquant)
library(dygraphs)
library(timetk)
library(lubridate)

tq_get("KR", get = "stock.prices") %>%
  select(date, close) %>%
  tk_xts() %>%
  dygraph(
    main = "Kroger's stock rallied after the Great Recession",
    ylab = "Closing price (USD)"
  ) %>%
  dyOptions(fillGraph = TRUE, gridLineColor = "#dddddd") %>%
  dySeries("close", label = "Closing price") %>%
  dyAxis("y", valueRange = c(0, 45)) %>%
  dyAnnotation("2015-12-29", text = "$42.64", width = 50, height = 20) %>%
  dyAnnotation("2010-06-07", text = "$9.58", width = 50, height = 20) %>%
  dyShading(from = "2009-01-26", to = "2012-07-24", color = "#ffe6e6") %>%
  dyShading(from = "2012-11-29", to = "2017-06-14", color = "#ccebd6")
