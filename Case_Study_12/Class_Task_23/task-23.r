library(tidyverse)
library(readr)
library(stringr)

read_first_message <- function(file_path) {
  # Read every 1,700 characters starting with the first one
  quote_file <- read_lines(file_path) %>%
    str_split("", simplify = TRUE)
  
  quote_length <- length(quote_file)
  quote <- c(quote_file[1], quote_file[seq(0, quote_length, by = 1700)]) %>%
    str_c() %>%
    paste(collapse = "") %>%
    str_split("\\.", simplify = TRUE)
  
  # Print the quote
  print(quote[1])
}


read_second_message <- function(file_path1, file_path2) {
  # Discover the numeric hidden message
  numeric_secret <- read_lines(file_path1) %>%
    str_extract_all("\\d{1,2}", simplify = TRUE) %>%
    as.integer()
  
  # Print the deciphered message
  letters[numeric_secret] %>%
    paste(collapse = "") %>%
    print()
  
  # Finally, find the longest vowel sequence in the first file after removing all spaces and periods
  quote_file <- read_lines(file_path2) %>%
    str_extract_all("[^ .]") %>%
    unlist() %>%
    paste(collapse = "") %>%
    str_extract_all("[aeiou]+")
}


main <- function() {
  read_first_message("https://byuistats.github.io/M335/data/randomletters.txt")
  read_second_message(
    "https://byuistats.github.io/M335/data/randomletters_wnumbers.txt",
    "https://byuistats.github.io/M335/data/randomletters.txt"
  )
}


main()