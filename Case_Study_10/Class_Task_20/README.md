---
title: "Notes from Task 20"
author: "Joseph Borjon"
date: "June 29, 2018"
---

## [Reading, Writing and Converting Simple Features](https://r-spatial.github.io/sf/articles/sf2.html)

Or, how Simple Features can be read into R from files and databases and how they can be converted to other formats. It's what `sf` uses to read and write with `st_read()` and `st_write()`.

GDAL == Geospatial Data Abstraction Library, a.k.a. "the swiss army knife for spatial data: it reads and writes vector and raster data from and to practically every file format, or database, of significance." It effectively maps to 200+ data formats.





## [Josh Wills Big Data Snippet](https://www.youtube.com/watch?v=Ewd5PXgLXlU&feature=youtu.be)

Data analyst vs data scientist: Data science is the whole path from question, through data acquisition and manipulation, to answer.

Data analyst: "If my tools and data can't answer the question, then the question doesn't get answered."

Data scientist: "If my tools and data can't answer the question, then I go get better tools and data."

Databases are good at filtering things quickly and aggregating things quickly, not at stepping row by row.

Essence of data science: thinking about the problem, mapping it onto data you have, and thinking about patterns in your data that can help you. Not necessarily advanced stats.



## Video: [How spatial polygons shape our world - Amelia McNamara](https://www.youtube.com/watch?v=wn5larsRHro)

The world is different from its visualization.

Three types of map data representation:

  * Points (where things are)
  * Lines
  * Polygons (closed shapes that describe area)

Small areas can look unimportant in choropleth maps.

Good paper: [All Maps of Parameter Estimation Are Misleading](http://www.stat.columbia.edu/~gelman/research/published/allmaps.pdf)

Almost no spatial polygons (states, counties, and especially zip codes, etc.) are naturally occurring; they are human-made. So it often doesn't make sense to aggregate by these polygons.

Another good paper: [Toward a Talismanic Redistricting Tool: A Computational Method for Identifying Extreme Redistricting Plans](http://cho.pol.illinois.edu/wendy/papers/talismanic.pdf)

Three main problems:

  1. Upscaling (showing aggregated data into polygons accurately)
  1. Downscaling (disaggregating into discrete points)
  1. Sidescaling ()

The `pycno` package ignores artificial boundaries.

Main takeaways:

  * Don't aggregate by polygons if you don't have to
  * If you have to, pay attention to what polygons you use so they have real meaning (probably not zipcodes)
  * Use auxiliary information if you have it
