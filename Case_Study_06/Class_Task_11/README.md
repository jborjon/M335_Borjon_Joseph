---
title: "Notes from Task 11 Reading"
author: "Joseph Borjon"
date: "May 29, 2018"
---

## Class notes

At the end of this class, you'll be a data mover. With a degree, you'll be a data scientist.

`dplyr::left_join()` and all the other join functions are way faster than the base `merge()` function.

For every graph ever, **answer the driving question first,** then provide as much additional insight as will reward the viewer for paying attention without detracting from the main message.

Summary statistics charts, such as bar charts, make it very hard to provide additional insights.

For box plots, Brother Hathaway usually jitters the points on top of them.

Personally, Brother Hathaway almost exclusively uses left joins because he likes them best. But they are not devoid of problems.

Dumb joins are joins in which data is accidentally added. Sometimes there's also data that's removed. So always check your logic when joining; things can go wrong. Count rows before and after you join.

When you present data, be open-minded. Don't seek to reinforce your previously held beliefs or those of your boss or audience.

## [*R for Data Science,* chapter 13: Relational Data](http://r4ds.had.co.nz/relational-data.html)

Multiple data tables are called *relational data* because it's their interrelations that matter, not the individual data sets.

Relations are always defined between a pair of tables, and all other relations are built from those: they are properties of the relations between each pair. So you don't need to understand the whole thing at once, only the chain of relationships between the tables you care about.

Three verb familes to work with relational data:

  * *Mutating joins,* which add new variables to one data frame from matching observations in another
  * *Filtering joins,* which filter observations from one data frame based on whether or not they match an observation in the other table
  * *Set operations,* which treat observations as if they were set elements

*Keys* identify the observation. They can be a single variable or, for more complex data, a set of variables.

Two types of key:

  1. *Primary key* uniquely identifies an observation in its own table
  2. *Foreign key* uniquely identifies an observation in another table

A variable can be both at the same time.

When ther aren't any variables unique to one observation, you can add one with `mutate()` and `row_number()`, then called a *surrogate key*, as opposed to a *natural key*.

"A primary key and the corresponding foreign key in another table form a **relation**." Relations can be 1-to-1, 1-to-many, many-to-many, etc. For example, in the `nycflights13` dataset, plane to flights form a 1-to-many relation (one plane does many flights).

### Mutating joins

*Mutating joins* combine variables from two tables by matching observations by their keys and then copying across tables from one to the other. They are akin to using `mutate()`.

Like `mutate()`, join functions add variables to the right. Joins match based on the key, with the value just carried along for the ride.

Example:

```r
left_join(df1, df2, by = "key")
```

Number of join matches == number of rows in the output.

#### Inner join

Simplest type of join; matches a pair of observations when the keys are equal, keeping observations that appear in both tables. Outputs a new data frame containing the key, the `df1` values, and the `df2` values. Unmatched rows are not included, so inner joins are often not great for data analysis because it's too easy to lose observations.

#### Outer join

Keeps observations that appear in at least one of the tables. There are three types:

  * **Left join:** keeps all observations in `df1` (the "left" data frame). Always should be your default.
  * **Right join:** keeps all observations in `df2` (the "right" data frame).
  * **Full join:** keeps all observations in both data frames.

When there are no matches, the values are filled with `NA`.

When there are duplicate keys in one of the tables, there is probably a one-to-many relationship and the data gets joined as expected. When there are duplicate keys in both tables, there is probably an error and rows get added with all the possible combinations.

By default, `by = NULL` joins by all the variables that appear on both tables in what's called a **natural join.**

You can join by the same variables with different names on both tables using `by = c("keyX" = "keyY")`. The output will retain the variable name `keyX`.

### Filtering joins

Filtering joins affect the observations as opposed to the variables. They don't add any columns, just **keep** or **drop** observations based on match. They are akin to using `filter()` and are useful for diagnosing join mismatches (data entry errors are common).

  * `semi_join(x, y)` keeps all observations in `x` that have a match in `y`.
  * `anti_join(x, y)` drops all observations in `x` that have a match in `y`.

## [*The Truthful Art,*](http://ptgmedia.pearsoncmg.com/images/9780321934079/samplepages/9780321934079.pdf) chapter 4

Getting acquainted with the methods of science will help you avoid getting fooled by your sources, even though you still will, regularly.

A few rules of thumb from the book:

  * compared to what/who/where/when
  * always look for the pieces that are missing in the model
  * increase depth and breadth up to a reasonable point

Testability (of a conjecture) implies falsifiability. If you can't possibly refute a hypothesis, people in the future will never be able to move toward a better one.

And using non-testable conjectures to argue with others is futile. For both sides.

All the elements in a conjecture need to be naturally interrelated so that, if one is changed, the whole conjecture is invalidated.

*Continuous* variables can take on any value in the scale (such as real numbers), while *discrete* variables can only have certain values (such as integers).

A *cross-sectional study* looks at a snapshot in time and is lower-cost but less precise, while a *longitudinal study* tracks things over time and are more expensive but more precise.

"Always be suspicious of studies whose samples have not been randomly chosen." 

Two kinds of extraneous variables, or variables that can affect our results without being part of our conjecture:

  1. *Confounding* variables, which we know about and should control for
  2. *Lurking* variable, which we don't know about, so it may affect our results unbeknownst to us

Data is always noisy and uncertain. *Randomness* is the variation caused by factors we can't possibly be aware of. Nature itself is random.
