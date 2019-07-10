---
title: "Task 7 Notes"
author: "Joseph Borjon"
date: "May 14, 2018"
---

## R for Data Science, Chapter 7: Exploratory Data Analysis

Exploratory data analysis => EDA

EDA is a systematic but non-formal approach to explore data and also a state of mind without so many rules:

1. Generate qustions about the data

2. Search for answers by **visualizing, tranforming, and modeling** the data

3. Use what you learn to refine your questions and generate new ones

Feel free to investigate any and all ideas to develop an understanding of the data. Some will be dead ends, some will turn into the useful data you show others. Rely on both your curiosity and your skepticism (how could this be misleading?).

"Always investigate the quality of your data," even if the questions are given to you by others.

![John Tukey](https://upload.wikimedia.org/wikipedia/en/e/e9/John_Tukey.jpg)

> "Far better an approximate answer to the right question, which is often vague, than an exact answer to the wrong question, which can always be made precise." ---John Tukey

The key to generating a high *quality* of questions is to generate a large *quantity* of them. When you get a new dataset, you don't know what insights are found in it. Follow up each relevant question with more questions.

Two main types of really useful data questions:

* What type of variation is there between variables?

* What type of covariation is there between variables?

**Data point == observation**

We say that tabular data is tidy if it each value is in its proper cell, each variable in its column, and each observation in its row. Most real-life data ain't tidy.

**Variation** is the tendency for a variable's values to change from measurement to measurement, caused by inevitable error and natural differences in data being measured. Variation patterns themselves can reveal something about the variable.

Two types of variables according to their possible values:

* **Categorical variables:** they can only take one of a small set of values. E.g. a diamond's cut, one of only  possibilities. Easily explored with a bar chart.

* **Continuous variables:** they can take any of an infinite set of ordered values. E.g. a diamond's carat value. Easily explored with a histogram.

`diamond %>% count(cut)` counts how many diamonds there are in each predefined cut category.

`diamonds %>% count(cut_width(carat, 0.5))` counts how many diamonds there are in each manually "cut" bin (nothing to do with diamond cuts) of width 0.5; the width is defined in terms of the `x` variable measurement units. That's how a histogram works, with equally spaced bins.

Explore different bin widths, because they may reveal different patterns. Like zooming in and out.

To overlay several histograms on the same chart, use `geom_freqpoly` instead of `geom_hostogram`, because it renders lines instead of bars.

In bar charts and histograms, if you don't specify a y-value on a ggplot2 aesthetic, it will default to a count. You can swap it to a density (the count standardized so that the area under each frequency polygon is 1) by writing `y = ..density..`.

**Outliers** are data points that don't appear to fit a pattern, possibly because of data entry errors, and also they may suggest new science.

`coord_cartesian()` allows you to zoom into the x- and y-axis by specifying the `xlim` and `ylim` arguments. That may help when a histogram has really tall count bars that make the outliers so short that they are hard or impossible to see.

If removing outliers doesn't significantly affect the results of your analysis, you replace them with NA and move on. They could, after all, be entry errors. But if they do affect results, figure out why they are likely to have happened and disclose that you dropped them in your writeup.

To drop values:

```r
diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
```

**Covariation** is the tendency for the values of multiple variables to vary together in a related way.

The space between 25th percentile and the 75th percentile of a distribution is called interquartile range (IQR), and also midspread, middle 50 percent, or H-spread. The box in a boxplot displays that, and in the middle, the median, that is, the 50th percentile.

To create a box plot in ggplot2:

```r
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()
```

To reorder the x-values on a plot:

```r
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))
```

To easily visualize the covariation between categorical variables:

```r
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))
```

Or you can compute it directly:

```r
diamonds %>% 
  count(color, cut)
```

Or you can visualize it with colored tiles:

```r
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
    geom_tile(mapping = aes(fill = n))
```

To visualize covariation between 2 continuous variables, scatterplots are great.

If there are to many points and the scatterplot begins to look like it has big dark areas rather than discrete points, you can use `alpha`:

```r
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)
```

But, really, even that can look terrible, so a better option is to use bins like histograms, but in 2 dimensions, such that they have a polygon shape, using `geom_bin2d()` (squares) or `geom_hex()` (hexagons):

```r
ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))

# install.packages("hexbin")
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))
```

Or you could bin `carat` and then display a boxplot for each group:

```r
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
```

Or display approximately the same number of points in each bin with `cut_number()`:

```r
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))
```

## If you spot a pattern in the data, ask yourself:

* Could this pattern be due to coincidence (i.e. random chance)?

* How can you describe the relationship implied by the pattern?

* How strong is the relationship implied by the pattern?

* What other variables might affect the relationship?

* Does the relationship change if you look at individual subgroups of the data?

Patterns reveal covariation, so they are a very useful data science tool. In a way, you can say that, while variation introduces uncertainty, covariation reduces it; you can use the value of one variable to make better predictions about the value of the other.

If covariation is due to the special case of causal relationship, you can use the value of one variable to control the value of the second one.

**Models** are a tool for extracting patterns out of data. This is an example that separates closely related diamond data to be able to extract remaining subtleties by computing residuals:

```r
library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))
```
