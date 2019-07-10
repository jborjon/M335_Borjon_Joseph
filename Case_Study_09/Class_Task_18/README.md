---
title: "Notes from Task 18"
author: "Joseph Borjon"
date: "June 20, 2018"
---

## [dygraphs for R](http://rstudio.github.io/dygraphs/index.html)

An R interface to the JavaScript `dygraphs` charting library. Great for time-series plotting. Plots `xts` time series objects automatically.

```r
library(dygraphs)

lungDeaths <- cbind(mdeaths, fdeaths)

dygraph(lungDeaths) %>%
  dySeries("mdeaths", label = "Male") %>%
  dySeries("fdeaths", label = "Female") %>%
  dyOptions(stackedGraph = TRUE) %>%
  dyRangeSelector(height = 20)
```

"Here's an example that illustrates shaded bars, specifying a plot title, suppressing the drawing of the grid for the x axis, and the use of a custom palette for series colors:"

```r
hw <- HoltWinters(ldeaths)
predicted <- predict(hw, n.ahead = 72, prediction.interval = TRUE)

dygraph(predicted, main = "Predicted Lung Deaths (UK)") %>%
  dyAxis("x", drawGrid = FALSE) %>%
  dySeries(c("lwr", "fit", "upr"), label = "Deaths") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set1"))
```



## [DT: An R interface to the DataTables JavaScript library](https://rstudio.github.io/DT)

"R data objects (matrices or data frames) can be displayed as tables on HTML pages, and DataTables provides filtering, pagination, sorting, and many other features in the tables."

`datatable()` is the main function in this package. "It creates an HTML widget to display R data objects with `DataTables`."

```r
datatable(data, options = list(), class = "display",
    callback = JS("return table;"), rownames, colnames, container,
    caption = NULL, filter = c("none", "bottom", "top"), escape = TRUE,
    style = "default", width = NULL, height = NULL, elementId = NULL,
    fillContainer = getOption("DT.fillContainer", NULL),
    autoHideNavigation = getOption("DT.autoHideNavigation", NULL),
    selection = c("multiple", "single", "none"), extensions = list(),
    plugins = NULL, editable = FALSE)
```

The `options` arguments helps you customize the table. When it, keep in mind that JavaScript, unlike R, indexes from 0.

The `class` argument specifies [CSS classes](https://datatables.net/manual/styling/classes) for the table.

You can enable cell editing by double-clicking setting the `editable = TRUE` argument, for both client and server.

You can suppress displaying row names with `rownames = FALSE`, and you can add your own names by giving a character vector to `rownames`. What R does is `cbind(rownames(data), data)` to add a new names columns.

To change all column names, use `datatable(df, colnames = c('Here', 'Are', 'Some', 'New', 'Names'))`.

To change only one or a few column names, use `datatable(df, colnames = c('Better name' = 2))` or `datatable(df, colnames = c('A Better Name' = 'original_name'))`.

You can generate an HTML container yourself like this:

```r
sketch = htmltools::withTags(table(
  class = 'display',
  thead(
    tr(
      th(rowspan = 2, 'Species'),
      th(colspan = 2, 'Sepal'),
      th(colspan = 2, 'Petal')
    ),
    tr(
      lapply(rep(c('Length', 'Width'), 2), th)
    )
  )
))
print(sketch)
```

The above generates:

```r

<table class="display">
  <thead>
    <tr>
      <th rowspan="2">Species</th>
      <th colspan="2">Sepal</th>
      <th colspan="2">Petal</th>
    </tr>
    <tr>
      <th>Length</th>
      <th>Width</th>
      <th>Length</th>
      <th>Width</th>
    </tr>
  </thead>
</table>

```

Then you can specify to use this container with the `container` argument.

`caption` adds a table caption and it can be a character vector.



## [timetk](https://github.com/business-science/timetk)

> A toolkit for working with time series in R

"Tools for inspecting and manipulating the time-based index, expanding the time features for data mining and machine learning, and converting time-based objects to and from the many time series classes."

Key benefits:

  * **Index extraction:** get the time series index from any time series object
  * **Understand time series:** create a signature and summary from a time series index
  * **Build future time series:** create a future time series from an index
  * **Coerce between time-based tibbles (tbl) and the major time series data types `xts`, `zoo`, `zooreg`, and `ts`:** Simplifies coercion and maximizes time-based data retention during coercion to regularized time series (e.g. `ts`)



## [How William Cleveland Turned Data Visualization Into a Science](https://priceonomics.com/how-william-cleveland-turned-data-visualization), from [Priceonomics](https://priceonomics.com)

Cleveland's research is the ultimate reason most data visualizers like bar charts (though not Brother Hathaway) and scatter plots (though I didn't know that, so I came to like them on my own for how transparently they show data), and don't like pie charts and stacked bars.

He was concerned in the 1980s about the unscientific manner in which stastisticians and others were visualizing. Data visualization effectiveness should be backed up by data.

Cleveland and McGill's original accuracy hierarchy:

  1. Position along a common scale (bar chart, dot plots)
  1. Positions along nonaligned, identical scales (small multiples)
  1. Length, direction, angle (pie chart)
  1. Area (treemap)
  1. Volume, curvature (3-D bar charts, area charts)
  1. Shading, color saturation (heat maps, choropleth maps)

Though later refined by them, this hierarchy has proven quite accurate.

Cleveland's *The Elements of Graphing Data* was formatted after Strunk and White's *The Elements of Style*. It's similar in philosohpy, too.

Cleveland's no-frills philosophy is in contrast to Edward Tufte's more aesthetically focused one because Cleveland assumed that the reader was already interested in the data since they were researchers, and catching their attention wasn't a concern.

Some of Cleveland's suggestions:

  * Remove unnecessary non-data elements that don't let the data stand out (Tufte agrees)
  * Keep legends out of the data region
  * Keep tick marks to a minimum
  * Don't let data labels clutter the graph
  * Put data points as close together as possible because people more accurately compare elements that are closer together
