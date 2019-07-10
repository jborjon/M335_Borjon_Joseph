## @knitr bofm_word_dist_by_verse

bofm_verses_text <- get_scripture_text_vector(scriptures, 3)

# Get the word length of each verse
bofm_verse_lengths <- vector("integer", length(bofm_verses_text))
for (i in seq_along(bofm_verses_text)) {
  bofm_verse_lengths[[i]] <- bofm_verses_text[[i]] %>%
    stri_stats_latex() %>%
    .[[4]]
}

bofm_verse_lengths %>%
  as_tibble() %>%
  transmute(
    verse_id = row_number(),
    word_count = value
  ) %>%
  ggplot(aes(verse_id, word_count)) +
  geom_point(color = "#d6eaf8") +
  geom_smooth(color = "#E67E22") +
  labs(
    title = "Most verses in the Book of Mormon have fewer than 75 words, although several go well over 100 words",
    x = "Verse ordinal",
    y = "Word count"
  ) +
  theme_bw()
