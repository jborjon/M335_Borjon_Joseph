library(rio)
library(tidyverse)

verse <- read_lines("https://byuistats.github.io/M335/data/2nephi2516.txt")
names <- rio::import("https://byuistats.github.io/M335/data/BoM_SaviorNames.rds") %>%
  arrange(desc(nchar))

names_list <- names$name
verse_breaks <- verse

for (i in seq_along(names_list)) {
  verse_breaks <- verse_breaks %>%
    str_replace_all(names_list[i], str_c("__", i, "__"))

  print(names_list[i])
}

observations <- verse_breaks %>%
  str_split("__[0-9]+__")

names_id <- verse_breaks %>%
  str_match_all("__[0-9]+__")

names_id(observations) <- names[[1]][,1]  # check this - gives an error
