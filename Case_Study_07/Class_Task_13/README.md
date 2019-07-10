---
title: "Notes from Task 13 Reading"
author: "Joseph Borjon"
date: "June 5, 2018"
---

## Class notes

Brother Palmer: people such as managers don't mind complex graphics as much if you start with a simple and familiar graph, such as a bar chart, and build up from there, up to the most complex one.

It is our duty and obligation to help people understand the variation in their data, because they don't get it.

Greatness comes by putting insane amounts of hours into something, not by being born a certain way.

When you watch how the data is collected, or even how the thing measured behaves and flows, you can gain important insights that will help you analyze the data.

To rearrange bars on a bar chart, use `complete()`.

**Personal note:** the average of 1 and -1 is 0; likewise, the average of 1,000,000 and -1,000,000 is also 0. How can we expect a mean, then, to be a reliable indication of performance or system behavior, especially if we can't see the variation or distribution symmetry in the data, e.g., by means of a scatter plot?

> I can put my feet in the oven and my head in the freezer and *on average* have a normal body temperature, but that hardly implies that I am comfortable. ---[Rafe M. J. Donahue, Ph.D.](http://biostat.mc.vanderbilt.edu/wiki/pub/Main/RafeDonahue/fscipdpfcbg_currentversion.pdf)

> Investigation of these [atomic-level] peculiarities of the data is perhaps the fundamental component of data analysis. We reveal the anomalies in the data through analysis, the study of the component parts. ---Rafe M. J. Donahue



## [Be the boss of your factors: the `forcats` package](http://stat545.com/block029_factors.html)

Factor: a means to store truly categorical information. Its possible values are called **levels.** E.g. the levels of a `continent` variable may be "Asia", "America", etc. but under the hood, those are stored as integers.

The tidyverse removes a lot of the difficulty of working with factors. `forcats` is a non-core package in the tidyverse. Load it with `library(forcats)`. Its functions use the `fct_` prefix.

`fct_drop(variable_to_operate_on)` drops all unused levels.

Factor levels are ordered alphabetically by default. Use `fct_infreq()` to order by highest to lowest frequency, and `fct_rev()` to reverse that.

Use `fct_reorder(data, variable_to_reorder_by, fun = median, .desc = FALSE)` to reorder levels for plotting or other purposes.

"When a factor is mapped to x or y, it should almost always be reordered by the quantitative variable you are mapping to the other one."

"Use `fct_reorder2()` when you have a line chart of a quantitative x against another quantitative y and your factor provides the color. This way the legend appears in [the same] order as the data!""

`fct_c()` concatenates data frames that contain factors properly, without factor number clashing.



## [R for Data Science, Chapter 15: Factors](http://r4ds.had.co.nz/factors.html)

`forcats` is for **cat**egorical data and is an anagram of *factors*.

Issues of recording categorical data as strings:

  1. Typos can occur
  1. It doesn't sort in a useful way

To create a factor, start with a list of its valid levels, then create the factor:

```r
x1 <- c("Dec", "Apr", "Jan", "Mar")

# Define the levels
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

# Create the factor
y1 <- factor(x1, levels = month_levels)
```

Omitting the levels in `factor(x1)` will make it so they get taken from the data in alphabetical order.

To match the order of the factors to the order of their first appearance in the data, two ways:

```r
# At creation time
f1 <- factor(x1, levels = unique(x1))

# After creation
f2 <- x1 %>%
  factor() %>%
  fct_inorder()
```

`levels(factor)` returns the set of valid levels.

`forcats::gss_cat` is a sample of data from the General Social survey provided by the `forcats` package.

`fct_relevel(factor, "Level name")` takes a specified level and moves it to the front of the line, puts it first.

`fct_recode()` recodes or changes the level value of each level for clarifying labels for publication or collapsing levels for high-level displays.

```r
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
    "Republican, strong"    = "Strong republican",
    "Republican, weak"      = "Not str republican",
    "Independent, near rep" = "Ind,near rep",
    "Independent, near dem" = "Ind,near dem",
    "Democrat, weak"        = "Not str democrat",
    "Democrat, strong"      = "Strong democrat"
  ))
```

"To combine groups, you can assign multiple old levels to the same new level:""

```r
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
    "Republican, strong"    = "Strong republican",
    "Republican, weak"      = "Not str republican",
    "Independent, near rep" = "Ind,near rep",
    "Independent, near dem" = "Ind,near dem",
    "Democrat, weak"        = "Not str democrat",
    "Democrat, strong"      = "Strong democrat",
    "Other"                 = "No answer",
    "Other"                 = "Don't know",
    "Other"                 = "Other party"
  ))
```

"If you want to collapse a lot of levels, `fct_collapse()` is a useful variant:"

```r
gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
    other = c("No answer", "Don't know", "Other party"),
    rep = c("Strong republican", "Not str republican"),
    ind = c("Ind,near rep", "Independent", "Ind,near dem"),
    dem = c("Not str democrat", "Strong democrat")
  ))
```

"Sometimes you just want to lump together all the small groups to make a plot or table simpler. That's the job of `fct_lump()`," using the optional `n` parameter to specify how many groups to keep:

```r
gss_cat %>%
  mutate(relig = fct_lump(relig, n = 10))
```
