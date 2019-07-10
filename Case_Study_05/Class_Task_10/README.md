---
title: "Notes from Task 10 Reading"
author: "Joseph Borjon"
date: "May 24, 2018"
---

## Class notes

If foreign data file doesn't work in Case Study 5, try `foreign::read.spss(..., to.data.frame = TRUE)`.

In CS 5, we are binding rows.

Especially for Windows computers, it is always a good idea to install Rtools so all packages can be used with no problem.

Generally, when doing markdown files, you don't want to save out any images or data files. It should all be self-contained.

Business people using Excel do tend to create better-looking tables, while statisticians tend not to think too much about the way their data is presented in a table.

In R, "merge" means "join," which is, in essence, a column join.

Statisticians couldn't care less about optimizing data structures.

## [R for Data Science, Chapter 12: Tidy Data](http://r4ds.had.co.nz/tidy-data.html)

> "Happy families are all alike; every unhappy family is unhappy in its own way." ---Leo Tolstoy

> "Tidy datasets are all alike, but every messy dataset is messy in its own way." ---Hadley Wickham

To learn more about the theory underlying tidy data, you can read the [*Tidy Data* paper](http://www.jstatsoft.org/v59/i10/paper) by Hadley Wickham.

The three interrelated rules that make a dataset tidy:

  1. Each variable must have its own column
  2. Each observation must have its own row
  3. Each value must have its own cell

Since you can't satisfy only two without satisfying all three, we can distill a simpler set of rules:

  1. Put each dataset in a tibble
  2. Put each variable in a column

Advantages of using tidy data: consistency and friendliness with R's vectorized nature, which will make data transformation feel natural. All tidyverse packages are designed to work with tidy data.

For most analyses, you'll have to tidy the data because most data out there is not tidy, for two main reasons:

  1. Most people aren't familiar with the concept of tidy data
  2. Data is often organized to facilitate uses other than analysis, such as entry

`gather()` and `spread()` are the 2 most important tidyr functions because one variable spread across multiple columns or one observation scattered across multiple rows are common problems with non-tidy data (although usually it's going to be one of the two but not both, unless you're unlucky).

One common problem is column names aren't names of variables, but values. Those need to be **gathered** into one column with the name of the real variable.

When rows contain variable names as values, we need to **spread.**

`separate()` leaves split values the same type as the original. To ask for better types, set `convert = TRUE`.

`complete()` takes a set of columns and finds all unique combinations. It then ensures the original dataset contains all those values, filling in explicit `NA`s where necessary.

`fill()` takes a set of columns where you want missing values to be replaced by the most recent non-missing value (sometimes called last observation carried forward).

tidyr also uses the pipeline a lot, like dplyr.

There are good reasons to use un-tidy data, such as performance, space savings, or uses in other specialized fields. Tidy is a good default if the data fits a rectangular structure, but you may have to use others.

## [openxlsx](https://github.com/awalker89/openxlsx)

Provides a high-level interface for writing, styling, and editing worksheets. No Java dependency.

Requires a zip application for R. For Windows, which doesn't include one by default, install Rtools.

## [tidyr Operations](https://rpubs.com/bradleyboehmke/data_wrangling)

Four fundamental tidyr functions:

  * `gather()`: takes multiple columns and gathers them into key-value pairs, making wide data longer
  * `spread()`: takes key and value columns and spreads them into multiple columns, making long data wider
  * `separate()`: splits a single column into multiple columns
  * `unite()`: combines multiple columns into a single one

### `gather()` function

Complements `spread()`.

When a common attribute of concern is spread across several columns, we call `gather(data, key, value, col1, col1 ...)` to put all those values in one column, with a new column that contains the old columns as keys. For example, if you have separate columns for each quarter but you only care about time, this function puts all 4 quarters in one column and adds another column that indicates which quarter we're talking about. `value` is also a new column that contains the value for each key.

These all produce the same result:

```r
DF %>% gather(Quarter, Revenue, Qtr.1:Qtr.4)
DF %>% gather(Quarter, Revenue, -Group, -Year)
DF %>% gather(Quarter, Revenue, 3:6)
DF %>% gather(Quarter, Revenue, Qtr.1, Qtr.2, Qtr.3, Qtr.4)
```

### `spread()` function

Complements `gather()`.

Spreads a key-value pair into multiple columns, opposite of `gather()`. In the following example, `spread()` gets rid of the `Revenue` column and puts the revenue values into each `Quarter` column:

```r
wide_df <- unite_df %>%
  spread(Quarter, Revenue)
```

### `separate()` function

Complements `unite()`.

Often, a single column captures multiple variables or parts of a variable you don't care about. By default, splits wherever it sees a non-alphanumeric character. Using:

```r
separate_DF <- long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"))
```

we can go from this:

```
##   Group Year Quarter Revenue
## 1     1 2006   Qtr.1      15
## 2     1 2007   Qtr.1      12
## 3     1 2008   Qtr.1      22
## 4     1 2009   Qtr.1      10
## 5     2 2006   Qtr.1      12
## 6     2 2007   Qtr.1      16
```

to this:

```
##    Group Year Time_Interval Interval_ID Revenue
## 1      1 2006           Qtr           1      15
## 2      1 2007           Qtr           1      12
## 3      1 2008           Qtr           1      22
## 4      1 2009           Qtr           1      10
## 5      2 2006           Qtr           1      12
## 6      2 2007           Qtr           1      16
```

### `unite()` function

Complements `separate()`. Not as commonly used as its complement.

Merges two variables into one. Taking the example above, we can do this:

```r
unite_DF <- separate_DF %>% unite(Quarter, Time_Interval, Interval_ID, sep = ".")
```

and get this:

```
##    Group Year Quarter Revenue
## 1      1 2006   Qtr.1      15
## 2      1 2007   Qtr.1      12
## 3      1 2008   Qtr.1      22
## 4      1 2009   Qtr.1      10
## 5      2 2006   Qtr.1      12
## 6      2 2007   Qtr.1      16
```

The `sep` argument is underscore by default. If you don't want that, specify its value.
