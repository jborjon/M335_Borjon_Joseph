---
title: "Notes from Task 14 Reading"
author: "Joseph Borjon"
date: "June 6, 2018"
---

## Class notes

Always ask yourself in R, "Is there a way to get out of a `for` loop?" In R they are slow and more low-level than R is intended to be.

Ideas for Case Study:

  * x = book, y = distance (boxplot with jitter)
  * 

## [*R for Data Science,* Chapter 21: Iteration](http://r4ds.had.co.nz/iteration.html#the-map-functions)

> `for` loops are not as important in R as they are in other languages because R is a functional programming language: in R, you can wrap `for` loops in a function and call the function instead of using the loop directly.

An R `for` loop has three parts:

  1. **Output:** preallocate a vector to avoid growing every iteration, which is slow. `output <- vector(mode = "double", length(x))` => creates a vector of length `length(x)` with each element being `0`.

  1. **Sequence:** `i in seq_along(df)` => walks through the sequence, assigning `i` to each element in the sequence successively; `seq_along()` does nothing but return the sequence `0:last_item_position` each time.

  1. **Body:** the code that does the work.

```r
output <- vector("double", ncol(df))  # 1. output
for (i in seq_along(df)) {            # 2. sequence
  output[[i]] <- median(df[[i]])      # 3. body
}
```

`ncol(df)` returns the number of columns in a data frame. Useful for iterating over columns.

Using `[[` versus `[` for subsetting in `for` loops is recommended even for atomic vectors, because it's clear you're only working with one element.

Four variations on the basic theme of the `for` loop:

  1. Modifying an existing object instead of creating a new object
  1. Looping over names or values instead of indices
  1. Handling outputs of unknown length
  1. Handling sequences of unknown length

A good solution when the output length is unknown is to save the results in a list and then combine into a single vector after the loop is done:

```r
out <- vector("list", length(means))
for (i in seq_along(means)) {
  n <- sample(100, 1)
  out[[i]] <- rnorm(n, means[[i]])
}
```

Then, if necessary, you can use `unlist()` to flatten a list of vectors into a single vector. Or, for added safety, `purrr::flatten_dbl()`.

In R, you can pass a function to a function, like this:

```r
col_summary <- function(df, fun) {
  out <- vector("double", length(df))
  for (i in seq_along(df)) {
    out[i] <- fun(df[[i]])
  }
  out
}
```

where `fun` is a function you pass as an argument. This is part of what makes R a functional language.

### `while` loops:

You can rewrite any `for` loop as a `while` loop, but you can't rewrite every `while` loop as a `for` loop.

```r
while (condition) {
  # Body
}
```

### `map` functions from the purrr package:

These functions `for`-loop over a vector, work on each element based on the function passed, and return a new vector with the results having the same length and names as the original.

  * `map()` makes a list
  * `map_lgl()` makes a logical vector
  * `map_int()` makes an integer vector
  * `map_dbl()` makes a double vector
  * `map_chr()` makes a character vector

## [*What Charts Say*](https://medium.com/@Elijah_Meeks/what-charts-say-6e31cbba2047), from Medium

Data doesn't have a natural form; it's determined by the person creating the visualization.

Charts may be said to have both an **explicit** and an **implicit** element. The explicit element is the way the data is presented as chosen by the person creating the chart. The implicit element is the unavoidable set of decisions that have to be made when transforming data and styling a chart.

The implicit element (title, framing, etc.) can be more powerful than the explicit, affecting recall, impact, and theme without the reader's realization.

"By their very nature, charts also say something about the systematic quality of the data they express. ... All data is a proxy for the systems that created and measured that data."

### Rules for improving what a chart says:

  * **Explicitly:** Expose data cleanly and clearly.
  * **Implicitly:**  Style should be appropriate and purposeful. Graphical elements should have well-reasoned justifications.
  * **Systematically:** Be careful not to reveal an underlying system that's confidential. If you're trying to make a system understood, represent the system rather than proxy measures for that system.
  * **Descriptively:** Annotate whenever possible. Treat axes as data visualization in styling and labeling.

"All charts say things their creators intend and many say things that were not intended."
