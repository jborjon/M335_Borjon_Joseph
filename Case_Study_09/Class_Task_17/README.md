---
title: "Notes from Task 17"
author: "Joseph Borjon"
date: "June 18, 2018"
---

## Class notes

One of the struggles of the data scientist is to be able to get a dataset, learn about the domain, figure it out, and move forward. Domain people don't have sympathy for your trying to learn the domain, so you have to learn to ask the right questions and figure out answers (with other people's help, if necessary).

Colors on heatmaps and other charts can be attributed to something based on the user. A green indicator for coal amount may mean it's low because it's not as bad for the earth, but to a coal executive it may mean a lot of coal because it's a go.

"The world's evolving away from work, and you have to own something." So invest in stocks or something.

What separates you as a data scientist from a business analyst is that you dig and dig until you get your questions answered. The good and fascinating data scientist, like the good and fascinating Sunday School teacher, shows you a different perspective that helps you change or improve something.

Most graphics don't provide answers but another set of questions.

## [tidyquant](https://github.com/business-science/tidyquant)

tidyquant gathers data from all kinds of good stock sources and puts it into one package. It even integrates tidyverse.

The developers tout the package as "a one-stop shop for serious financial analysis!"

### Core functions

  * `tq_get()`: gets tidy financial data from the web
  * `tq_transmute()`: adds a column to the data frame
  * `tq_mutate()`: return a new data frame (necessary for periodicity changes)
  * `tq_performance()`: converts investment returns into performance metrics
  * `tq_portfolio()`: aggregates a group (or multiple groups) of asset returns into one or more portfolios
