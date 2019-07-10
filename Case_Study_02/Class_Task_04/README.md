---
title: "Task 4 Notes"
author: "Joseph Borjon"
date: "May 3, 2018"
output: 
  html_document:
    keep_md: true
---

## HANS ROSLING TALK

Statistic guesses by people don't have a 50/50 chance of being right, like a chimpanzee's would. Preconceived notions can greatly skew responses.

If we don't look at data, we under- or overestimate real life facts.

Linearity between child survival and GDP per capita in a country is very strong.

There is an uncertainty margin with any data, so some people say it doesn't work, but boy, can it show some correlations clearly. The differences shown are much bigger than the weakness of the data.

Most countries tend to use money better than they've done in the past.

Using average data for a whole country, while useful, is dangerous because almost every country has the richest of the rich and the poorest of the poor, and strategies to solve problems for different groups will have to be different. Data has to be highly contextualized.

Gapminder "frees" UN data and makes it public for the world. It aims to mind the gap.


## [QUESTIONING TECHNIQUES](https://www.mindtools.com/pages/article/newTMC_88.htm)

Successful people ask better questions and get better results, said Tony Robbins.

"De-fusing a heated situation: you can calm an angry customer or colleague by using funnel questions to get them to go into more detail about their grievance. This will not only distract them from their emotions, but will often help you to identify a small practical thing that you can do, which is often enough to make them feel that they have "won" something, and no longer need to be angry."

"Persuading people: no one likes to be lectured, but asking a series of open questions will help others to embrace the reasons behind your point of view. 'What do you think about bringing the sales force in for half a day to have their laptops upgraded?'"

## DATA TRANSFORMATION - CHAPTER 5

dplyr is part of the Tidyverse.

When loaded, dplyr overwrites filter() and lag() from R. To use the originals, specify domain: stats::filter() and stats::lag()

To view a nice, neat table of all the data in the data frame, as opposed to just typing the name of the data frame, use View(data_frame_name) in RStudio. What you get is called a tibble, a data frame slightly tweaked to work better in the tidyverse.

Data types

    int - integer
    dbl - double (real number)
    chr - string
    dttm - date + time
    lgl - a vector that contains a Boolean value
    fctr - factor, represent categorical variables with fixed possible values in R
    date

Five key dplyr functions that solve the vast majority of problems, providing the verbs for a language of data manipulation:

    filter(data_frame, condition_for_col_values) - pick observations (rows) by their values; includes rows where condition is true, excludes FALSE and NA values unless you explicitly include NAs
    arrange(data_frame, col_to_sort_by [, another_col ...]) - reorder rows
    select(data_frame, col_to_include [, more_cols ...]) - pick variables (columns) by their names
    mutate(data_frame, new_col1 = math_on_rows [, new_col2 ...]) - create new variables as a function of existing variables, puts them at the end of the dataset, or modify the existing columns
    summarise(data_frame, new_col_name = operation_on_existing_column_values) - collapse a data frame into a single row; turns many rows into one; not greatly useful unless paired with group_by()
    group_by() - bonus, to be used with summarise(); change the scope of each function from operating on the entire data frame to group by group; undome with ungroup()

For all, first argument is a data frame, subsequent are what to do with frame using variable names without quotes; the result is a new data frame. You chain many simple steps together to achieve a complex result.

dplyr functions never modify their parameters.

When comparing equality of numbers, == may return false if used on floating-point numbers because computers can't have infinite precision Use near(num1, num2) instead.

You can use De Morgan for simplifying logic.

Use of the %in% operator, equivalent to month == 11 | month == 12, where the value of month is IN the vector given: nov_dec <- filter(flights, month %in% c(11, 12))

NA is an unknown value.

is.na(variable) checks if a value is unknown.

between(col, min, man) can be used in filter() to select values that are between two values, inclusive.

desc() can be used in arrange() to sort rows by a column in descending order.

select(data_frame, col1:col2) can be used to select all columns that originally appear between col1 and col2, inclusive.

select(data_frame, -(col1:col2)) can be used to select all columns except those between col1 and col2, inclusive.

Helper functions for select() that select variables whose names meet the condition:

    starts_with("blah")
    ends_with("blah")
    contains("blah")
    matches("regular_expression")
    num_range("x", 1:3) - matches x1, x2, and x3

rename(data_frame, old_name = new_name) is a variant of select that lets you rename variables.

select(data_frame, col1, col2, everything()) moves col1 and col2 to the beginning of the data frame without dropping everything else.

transmute(data_frame, [old_cols_to_include, ] new_col1 = expression [, more new cols]) is almost the same as mutate(), but it only keeps the new columns you create and any you specify.

Functions used to create new variables inside mutate() must be vectorized, meaning that they must take a vector as input and return another with the same number of values. Arithmetic and modular arithmetic operators fit that.

Other examples of functions to use with mutate():

    Logical comparisons
    log(), log2(), log10()
    lead() and lag() - they offset vector values by putting NA at the end or the beginning, respectively
    cumsum(), cumprod(), cummin(), cummax() - cumulative and rolling aggregate functions provided by R
    cummean() - cumulative mean, provided by dplyr
    min_rank() - ranks a vector from lowest to highest; to invert order, use desc()

%/% is integer (truncating) division. %% is modulo operation.

Logarithms are useful for dealing with data that ranges across several orders of magnitude. They convert multiplicative relationships to additive. All other things being equal, using log2() is recommended.

Whenever you do aggregation, it's a good idea to use a count with n() or a count of non-missing values with sum(!is.na(x)) so you can make sure not to draw conclusions on very small amount of data. n_distinct(x) returns the number of unique values.

Useful summary functions: mean(x), median(x), sum(x), n(x), sd(x), IQR(x), mad(x), min, quantile(x, 0.25), max(x), first(x), nth(x, 2), last(x)

count(col_name [, wt = weight_value]) is a dplyr helper function that gives you a tibble of unique values in a column.Optional weight parameter sums (weights) the variable you specify and puts it in the tibble instead of putting the number of elements in the group.

## CLASS NOTES

Because it's so common to have the time variable on the x-axis, taking it out of there causes a cognitive load.

log10() scales make 0 values not work, and negative values really not work. In those cases, sqaure root is a good alternative.

There are R packages and CSV files out there for pretty much any kind of data. Read some articles on a subject to figure out where the author got her data from.

Find data that's rich enough to answer your questions. Conversely, make sure your questions you can get data from.

"The simple graph has brought more information to the data analyst's mind than any other device." -John Tukey

Data science is ot so much about math. We need the basics, but what we really want is to solve people's problems.

group_by() doesn't aggregate. It just gives you labels.



## Question feedback

In order to move forward with the semester project and after sifting through many questions, I dediced to work on the following: *"Is there a correlation between quality of education and child suicide rate in a given state?"*

Some people said the answer to the question was "yes," others said it was "no." The ones who understood why I was asking said that there were too many variables affecting the action of committing suicide. Others said that the question wasn't clear enough, pointing out that it doesn't specify whose education is in question (I meant the child's); whether it means attempted suicide or completed suicide (I meant completed); and what "quality" means in terms of education.
