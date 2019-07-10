## @knitr word_summaries

library(tidyverse)
library(downloader)
library(stringi)

# Return the scripture_text column from a particular volume as a vector of strings
get_scripture_text_vector <- function(scripture_df, id) {
  scripture_df %>%
    filter(volume_id == id) %>%
    select(scripture_text) %>%
    as_vector()
}

# Return the name of the volume based on the id passed
get_volume_name <- function(id) {
  case_when(
    id == 1 ~ "Old Testament",
    id == 2 ~ "New Testament",
    id == 3 ~ "Book of Mormon",
    id == 4 ~ "Doctrine and Covenants",
    id == 5 ~ "Pearl of Great Price"
  )
}

# Calculate the average number of verses in a volume and print it
# id refers to the volume_id variable, and is an integer as follows:
#   1 - Old Testament
#   2 - New Testament
#   3 - Book of Mormon
#   4 - Doctrine and Covenants
#   5 - Pearl of Great Price
print_mean_words <- function(scripture_df, id) {
  verses_text <- get_scripture_text_vector(scripture_df, id)

  # Iterate through each verse to find its length
  verse_lengths <- vector("integer", length(verses_text))
  for (i in seq_along(verses_text)) {
    verse_lengths[[i]] <- verses_text[[i]] %>%
      stri_stats_latex() %>%
      .[[4]]
  }

  total_words <- verses_text %>%
    stri_stats_latex() %>%
    .[[4]]

  # Identify the volume to print its name appropriately
  volume_name <- get_volume_name(id)

  paste(
    "Average ", volume_name, " verse length (out of ", total_words, " total words): ", mean(verse_lengths),
    sep = ""
  ) %>%
  print()
}

# Get the number of instances of a certain word in a volume
print_instance_num <- function(scripture_df, id, word) {
  verses_text <- get_scripture_text_vector(scripture_df, id)
  num_instances <- str_locate_all(verses_text, word) %>%
    length()

  volume_name <- get_volume_name(id)

  paste(
    "Number of ", volume_name, " instances of the word '", word, "': ", num_instances,
    sep = ""
  ) %>%
  print()
}

# Download the data into a temporary file
temp_file <- tempfile()
download("http://scriptures.nephi.org/downloads/lds-scriptures.csv.zip", temp_file, mode = "wb")

# Read the file data into a tibble
scriptures <- unzip(temp_file, "lds-scriptures.csv") %>%
  read_csv()

# Remove the temporary file contents from memory
unlink(temp_file)

# Calculate the average verse length in the New Testament
print_mean_words(scriptures, 2)
print_mean_words(scriptures, 3)

print_instance_num(scriptures, 2, "Jesus")
print_instance_num(scriptures, 3, "Jesus")
