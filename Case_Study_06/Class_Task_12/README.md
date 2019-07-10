---
title: "Notes from Task 12 Reading"
author: "Joseph Borjon"
date: "May 31, 2018"
---

## Class notes

Brother Hathaway: I think most data scientists like to know how to use regular expressions instead of memorizing every possible expression. They just go look them up when they need to use them.

## [*R for Data Science,* chapter 14: Strings](http://r4ds.had.co.nz/strings.html)

String manipulation in R relies on the **stringr** package, whose functions all start with `str_` and which is not part of the core tidyverse. Base R manipulation functions are too inconsistent.

`'` and `"` are the same in R, but Hadley Wickham recommends always using double quotes unless the string contains several of them and you don't want to have to escape them.

`writeLines(string)` prints the raw string contents.

Common stringr functions (`string` below can stand in for a vector of strings, since these functions are vectorized):

  * `str_length(string)` returns the number of characters in a string, or the numbers of characters in a vector of strings.
  * `str_c(string1, string 2, ..., sep = ", ", collapse = NULL)` returns the combination of all the strings passed, with an optional specified separator in the returned string (defaults to `""`). Objects of length 0 are silently dropped. Using `collapse = ", "` makes a vector of strings collapse into a single string.
  * `str_replace_na(c("abc", NA))` returns a string with missing values replaced by the string `"NA"` to avoid contagious missing values.
  * `str_sub(string, start_num, end_num)` returns a substring of `string` with the specified stars and end positions, inclusive. You can modify the original string by assigning to the return value, like this: `str_sub(...) <- str_to_lower(...)`
  * `str_to_lower(string)`, `str_to_upper(string)`, and `str_to_title(string)` make a string all-lowercase, all-upercase, or title case. The optional `locale = "en"` parameter can be used to specify the language rules to change case. The ISO 639 language codes can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
  * `str_order(string)` and `str_sort(string)` also take a `locale` argument to sort properly across platforms.

Functions with the `_all` suffix work with all matches, not just a single one.

### Regular expressions

Regular expressions are so powerful, it's easy to want to solve the entire problem using one. But R gives you more toold than one so you can break down the problem if you need to.

Matches never overlap.

Created by writing them into a string. The regular expression itself isn't a string, but has to be represented as such. All the ones that show `\` need to be typed as `\\` in a string.

  * `abc`: matches a string exactly. To match a period, use `"\\."`. To match a slash, use `"\\\\"`.
  * `.`: matches any character except a newline.
  * `^string`anchor: matches only the beginning of a string.
  * `string$` anchor: matches only the end of a string.
    * therefore, `^string$` matches the entire string, with the entire string having to be only `"string"` or no match.
  * `\bword\b`: delimits a word.
  * `\d`: matches any digit.
  * `\s`: matches any whitespace.
  * `[abc]`: matches a, b, or c.
  * `[^abc]`: matches anything except a, b, or c.
  * `abc | xyz`: matches either `abc` or `xyz`. To match "gray" or "grey", you can use `gr(e|a)y`.
  * `string?`: find 0 or 1 matches. To match "color" or "colour", you can use `colou?r`.
  * `string+`: find 1 or more matches.
  * `string*`: find 0 or more matches. You can also specify the number of matches precisely without the last 3 symbols (greedy by default, make them lazy by putting `?` after them):
    * {n}: exactly n
    * {n,}: n or more
    * {,m}: at most m
    * {n,m}: between n and m

To find all fruits that have a repeated pair of letters, you can groups with parens and use *backreferences* such as `\1`, `\2`, etc.: `"(..)\\1"`.

#### Functions

  * `str_view(string, regexp)` and `str_view_all(string, regexp)` take a character vector and a regular expression, and show you how they match.
  * `str_detect(string, regexp)` returns a logical vector the same length as the input.
  * `str_count(string, regexp)` returns a count of matches in the string.
  * `str_extract(string, regexp)` returns the actual text matched.
  * `str_match()` returns a matrix with each individual component of the match.
    * if your data is in a tibble, it's often easier to use `tidyr::extract()`, which requires you to name the matches, which are then placed in new columns
  * `str_replace(string, regexp, replacement_value)` replaces matches with a new string.
  * `str_split(string, regexp)` splits a string up into pieces.
  * `str_locate(string, regexp)` returns the starting and ending positions of the match.

By explicitly wrapping the regular expression in `regex()`, you can use the other parameters to control match details:

  * `ignore_case = TRUE` allows characters to match either their uppercase or lowercase forms.
  * `multiline = TRUE` allows `^` and `$` to match the start and end of each line rather than the start and end of the complete string.
  * `comments = TRUE` allows you to use comments and white space to make complex regular expressions more understandable. Spaces are ignored, as is everything after `#`. To match a literal space, you'll need to escape it: `"\\ "`.
  * `dotall = TRUE` allows `.` to match everything, including `\n`.

There are three other functions you can use instead of `regex()`:

  * `fixed()`: matches exactly the specified sequence of bytes. Use only with English data.
  * `coll()`: compare strings using standard collation rules. This is useful for doing case insensitive matching.
  * `boundary()` to match word boundaries.

## [*What Charts Do*](https://medium.com/@Elijah_Meeks/what-charts-do-48ed96f70a74), from Medium

The most important thing about a chart is its *impact*. That's even more important than the data it shows.

What do charts do when they are crafted well?

  1. **Provide insights**
  1. **Cause change,** if you properly connect its insights to the required or performed action; track it when possible
  1. **Cause visual literacy** by emphasizing different aspects of the data with different types of charts
  1. **Create new charts** by eadding elements to previous types of charts

[Xenographics](https://xeno.graphics) are "Weird but (sometimes) useful charts," as the website linked describes them. They are really visualizations for visualization's sake. They are not generally useful. But they can provide visualization ideas :)

Complex or unfamiliar graphics are OK. How else will the audience ever learn to interpret them?

Sales-oriented people often have more lively-looking and complex charts, so take theirs and learn.

## [*Five Principles for Effective Data Visualizations*](https://www.thoughtworks.com/insights/blog/five-principles-effective-data-visualizations), from ThoughtWorks

  1. **Be open to discovering unexpected insights,** and let that change your direction if appropriate
  1. **Think big but start small**
  1. **Design for your user** so they'll be able to understand
  1. **Prototype to identify needs** by sketching and getting users' opinions
  1. **Get feedback early and often** to uncover needs

"Successful visualizations consider user needs, business needs and the technology platform. It's easy to create visualizations that are interesting but not effective for the users consuming the insights."
