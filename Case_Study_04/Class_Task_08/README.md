---
title: "Task 8 Notes"
author: "Joseph Borjon"
date: "May 14, 2018"
---

## [18 places to find data sets for data science projects](https://www.dataquest.io/blog/free-datasets-for-projects/)

Choosing good data sets for visualization projects:

* It shouldn't be messy, because you don't want to spend a lot of time cleaning data.

* It should be nuanced and interesting enough to make charts about.

* Ideally, each column should be well-explained, so the visualization is accurate.

* The data set shouldn't have too many rows or columns, so it's easy to work with.

Data.world has become one of the go-to places for data on the web.

A great data [blog](http://www.thefunctionalart.com).

## R for Data Science, Chapter 18: Pipes

The `%>%` pipe comes from the magrittr package.

`pryr::object_size(object)` returns the size of any object in MB, or the combined size of multiple objects if more than one argument.

The pipe doesn't work with functions that use the current environment unless you explicitly declare the environment:

```r
assign("x", 10)
x
#> [1] 10

"x" %>% assign(100)
x
#> [1] 10
```

The pipe also doesn't work with functions that use lazy evaluation, such as `tryCatch()`.

## R for Data Science, Chapter 20: Vectors

Two types of vectors:

1. Atomic, which have only one type even if the individual values contained are mixed
  + logical
  + numeric
    + integer
    + double
  + character
  + complex (rarely used in data analysis)
  + raw (rarely used in data analysis)

2. List, which can have several values of different types

`NULL` represents the absence of a vector and tends to behave like a vector of length 0, while `NA` represents the absence of a value in a vector.

Two key properties of vectors:

1. Type: get it with `typeof(v)`

2. Length: `length(v)`

Augmented vectors contain metadata attributes. Four types of augmented vector:

* Factors are built on top of integer vectors.
* Dates and date-times are built on top of numeric vectors.
* Data frames and tibbles are built on top of lists.

In R, numbers are doubles by default. To make an integer, place an L after the number: `1.5L`.

To compare doubles, don't use `==` because of approximation error. Use `dplyr::near()` instead, which allows for some numerical tolerance.

Integers have one special value: `NA`, while doubles have four: `NA`, `NaN`, `Inf` and `-Inf`. Avoid using `==` to check for these other special values. Instead use the helper functions `is.finite()`, `is.infinite()`, `is.na()`, and `is.nan()`.

Explicit coercion functions: `as.logical()`, `as.integer()`, `as.double()`, `as.character()`. Rarely used.

`is_[type]` functions from purrr are safer to use than R's built-in `is.[type]`.

You can put expressions in subsetting brackets `[]`.

If x is 2d, `x[1, ]` selects the first row and all the columns, and `x[, -1]` selects all rows and all columns except the first.

`[[` only ever extracts a single element, and always drops names. It's a good idea to use it whenever you want to make it clear that you're extracting a single item, as in a for loop.

`list()` creates a new list.

Unlike atomic vectors, `list()` can contain a mix of objects, and even other lists.

When subsetting lists, `[` extracts a sub-list. The result will always be a list.

You can get and set individual attribute values with `attr()` or see them all at once with `attributes()`.

```r
x <- 1:10
attr(x, "greeting")
#> NULL
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)
#> $greeting
#> [1] "Hi!"
#> 
#> $farewell
#> [1] "Bye!"
```

In this book, we make use of four important augmented vectors:

* Factors
* Dates
* Date-times
* Tibbles

POSIXct's are always easier to work with, so if you find you have a POSIXlt, you should always convert it to a regular data time: `lubridate::as_date_time()`.
