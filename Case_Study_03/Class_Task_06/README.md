---
title: "Task 6 Notes"
author: "Joseph Borjon"
date: "May 10, 2018"
output: html_document
---

## R for Data Science, Chapter 11: Data Import

CSV files are one of the most common forms of data storage.

Use **readr** package, part of the tidyverse. Reading functions:

* read_csv("file_path") - reads comma-delimited files (or an inline "file" provided by you as the argument)
* read_csv2() - reads semicolon-delimited files
* read_tsv() - reads tab-delimited files
* read_delim() - reads files with any delimiter
* read_fwf() - reads fixed-width files, with fields specified by either width (fwf_widths()) or position (fwf_positions())
* read_table() - reads a common variation of fixed-width files where columns are separated by white space
* read_log - reads Apache-style log files (webreadr provides additional helpful options)

read.csv() from base R works too, but is clunkier to use and way slower. data.table::fread() is ridiculously faster if that's what you need, but it doesn't fit quite so nicely into the tidyverse.

### read_csv()

**Arguments:**

* skip = number_of_lines_to_skip_from_top_of_file
* comment = "#" - drops all lines that start with, say, #
* col_names = FALSE - don't treat the first file line as column names because there aren't column names
* col_names = c("list", "of", "desired", "columns", "names")
* na = "," - specifies what value the file uses for missing data points

## Parsing vectors

parse_<data_type>(vector_to_parse [, na = "."])

You can see all the parsing issues, if any, with problems(), especially if there were a lot of issues.

str() can be used to look at the internal **str**ucture of any object.

### Numbers

parse_double("string") has an optional parameter for different parts of the world: locale = locale(decimal_mark = ",")

parse_number("string") extracts numbers from text. Useful for eliminating percent or dollar signs. locale = locale(grouping_mark = "desired_grouping_mark_such_as_period_or_comma").

### String

readr assumes UTF-8 encoding by default. To change that, use the locale argument in parse_character(string_onject, locale = locale(encoding = "Latin1"))

To find out what a file's encoding is if not documented, try guess_encoding(file_path_or_raw_vector_converted_with_charToRaw())

### Factors

A factor in R is a representation of categorical variables that have a known set of possible values. Using the levels argument will give you a warning when an unknown value is present:

fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "orange"), levels = fruit)

### Dates and times

* parse_datetime(datetime_string) - number of seconds since midnight 1970-01-01
* parse_date(datetime_string) - number of days since 1970-01-01
* parse_time(datetime_string) - number of seconds since midnight

The optional format arguments works if the formats are non-default: format = "format_string"

## Parsing files

You may need to fix stuff in a file. It's highly recommended to supply col_types to read_csv.

You can write files to disk with write_csv(), write_excel_csv(), and write_tsv(). Column type information gets lost when saving, so you can use R's custom RDS format with write_rds() and read_rds(). Or you can use a programming language-agnostic format from the feather library with write_feather() and read_feather().
