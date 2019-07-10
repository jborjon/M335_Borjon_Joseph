# http://bradleyboehmke.github.io/2015/12/scraping-html-tables.html
library(XML)
library(RCurl)
library(tidyverse)
library(lubridate)
library(ggrepel)
library(downloader)

#url_size <- "https://ldschurchtemples.org/statistics/dimensions/"
#url_time <- "https://ldschurchtemples.org/statistics/timelines/"

url_size <- "https://web.archive.org/web/20180301054455/https://ldschurchtemples.org/statistics/dimensions/"
url_time <- "https://web.archive.org/web/20171104095236/http://ldschurchtemples.org:80/statistics/timelines/"


dimensions <- url_size %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[1]] %>%
  as.tibble() %>%
  rename(Temple = `Temple `) %>%  # the Temple column name has a trailing space
  mutate(Temple = gsub("Temple[†‡]+", "Temple", Temple),
         Temple = iconv(Temple, from="UTF-8", to="LATIN1"))

times_AnGrbr <- url_time %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[3]] %>%
  as.tibble() %>%
  select(-Duration)

times_GrbrDed <- url_time %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[4]] %>%
  as.tibble() %>%
  select(-Duration)

times <- times_AnGrbr %>%
  left_join(times_GrbrDed, by = c("Temple", "Ground Broken"))

temples <- dimensions %>%
  left_join(times, by = "Temple") %>%
  transform(
    Announced = mdy(Announced),
    `Ground Broken` = mdy(`Ground Broken`),
    Dedicated = mdy(Dedicated)
  )

temples %>%
  ggplot(aes(Announced, SquareFootage)) +
  geom_jitter() +
  geom_smooth()
