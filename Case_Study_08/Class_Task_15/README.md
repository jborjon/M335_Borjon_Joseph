---
title: "Notes from Task 15"
author: "Joseph Borjon"
date: "June 12, 2018"
---

## Class notes

The skills of figuring out data, reshaping it, thinking about and arguing the right visualization, are things that won't go away with the advent of new magical tools. You'll spend a lot of time in this area, but it's the lucrative area.

When you have data skewed by outliers, show two plots: one that includes all the data so we can see its shape, and one that zooms in with `coor_cartesian()` so we can see more detail.

`geom_smooth()` uses loess.

Charles Joseph Minard's *Carte Figurative* is considered by Tufte to be the first great data visualization.

One way to represent time progress is to show actual movement (as in a video) to show the spatial displacement.

The lubridate package is one of the most beautiful gifts ever given to R programmers.

## [*R for Data Science,* Chapter 16: Dates and Times](http://r4ds.had.co.nz/dates-and-times.html)

Use the **lubridate** package.

Three types of time data (use the simplest type that meets your needs):

  * `date`
  * `time` within a day
  * `dttm` or **datetime**, which is a combined date and time, usually down to the second (more complicated because of time zones)

`today()` and `now()` get the current date and date-time. Or you can create a date-time object in one of 3 ways:

  * From a string
  * From individual date-time components
  * From an existing date/time object

### From strings

  * `ymd("2017-01-31")`
  * `mdy("January 31st, 2017")`
  * `dmy("31-Jan-2017")`

These can take unquoted numbers: `ymd(20170131)`.

By default, these return `date`s; to return `dttm`s, add an underscore and any necessary `h`, `m`, or `s` to the function name: `mdy_hm("01/31/2017 08:01")`. Or you can supply the `tz` (time zone) attribute: `ymd(20170131, tz = "UTC")`.

### From individual components

Use `make_date()` or `make_datetime()`:

```r
flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))
```

> "When you use date-times in a numeric context (like in a histogram), 1 means 1 second, so a binwidth of 86400 means one day. For dates, 1 means 1 day."

**Aside:** `geom_freqpoly(binwidth = number)` gives a good frequency line, like a histogram but in a line.

### From other types

To switch between dates and date-times, use `as_date(datetime)` and `as_datetime(date)`.

If you have a time as a numeric offset from the Unix Epoch, use `as_datetime()` if the offset is in seconds, and `as_date()` if it's in days.

### Getting date-time components

To get the numeric value (or name with the optional `label` attribute set to `TRUE`) of individual components from a date-time, use one of these:

  * `year(datetime)`
  * `month(datetime [, label = TRUE])`
  * `mday(datetime)` (day of the month)
  * `yday(datetime)` (day of the year)
  * `wday(datetime [, label = TRUE])` (day of the week)
  * `hour(datetime)`
  * `minute(datetime)`
  * `second(datetime)`

You can also use these as setters by using the syntax `year(datetime) <- new_value`. Or you can set multiple values at once with `update(datetime, year = 2020, month = 2, mday = 2, hour = 2)`; values that are too big will roll over.

**Aside:** data that involves human judgment tends to be biased toward round, even values, so consider that in you analysis.

### Rounding

  * `floor_date()`
  * `ceiling_date()`
  * `round_date()`

### Time spans:

Three types of time spans in lubridate:

  * **durations,** which represent an exact number of seconds
  * **periods,** which represent human-made units like weeks and months
  * **intervals,** which represent a starting and ending point

#### Durations

When you subtract two dates in base R, you get a `difftime` object, but lubridate's `duration` is much easier to work with because it's unambiguous: it always represents a number of seconds.

Duration constructors:

  * `dseconds(15)`
  * `dminutes(10)`
  * `dhours(c(12, 24))`
  * `ddays(0:5)`
  * `dweeks(3)`
  * `dyears(1)`

Durations can be added and multiplied; you can also add and multiply durations to and from days.

#### Periods

Periods are time spans that don't have a fixed length in seconds. They work with "human"" times such as days and months, so they are more intuitive. That way you overstep timezone issues.

Constructors:

  * `seconds(15)`
  * `minutes(10)`
  * `hours(c(12, 24))`
  * `days(7)`
  * `months(1:6)`
  * `weeks(3)`
  * `years(1)`

#### Intervals

Itervals have a definite start and end point, a specific date.

```r
next_year <- today() + years(1)
(today() %--% next_year) / ddays(1)
#> [1] 365
```
