---
title: "Notes from Task 23"
author: "Joseph Borjon"
date: "July 10, 2018"
---

## Class notes

Sometimes, you need to keep more in consideration when you create predictive models than just predictability or viability. There may be ethical considerations.

Sometimes the information available allows you to find out certain information, but it doesn't necessarily mean you should. Sometimes you need to make the call. Zip codes alone can tell you a lot about someone, such as 83440's religious affiliation, but should you use that?

"Applied statistician" is currently another term for "data scientist."

You've been given a gift in these classes that could potentially cause harm to people. Be careful. You may make mistakes, of course, but put in all the work you need to in order to avoid avoidable errors.

Sir Ronald Fisher wasn't a mold mathematician, so he was useful.

Statistics grew and flourished about the same time as the restored Church.

A model's usability and interpretability are what matter, not making the math work.

None of this works without math underpinnings. It is necessary. But there is no need for "mathematistry" (Box).

Employers don't need employees who can solve homework problems. They need people who can be given vague information and can then go figure it out.

Statisticians often don't see themselves as mathematicians. Both disciplines see the world in different ways.

Spatial data gets into big data really quickly. There is a lot of data in spatial data.

Meysa got her states to fill in: https://shiny.byui.edu/connect/#/apps/334/access.

Someone else's: https://shiny.byui.edu/connect/#/apps/328/access.

### Concerns with interactive visualizations

People can alter the data to be false.

It becomes a distracting toy.

Brother Hathaway: they can be like throwing a 5-year-old into the woods to discover stuff. They can find awesome stuff but get lost. There is no audit trail. How did I get here? So you have to decide whether you need a static or interactive visualization.

One day, try this: build an awesome interactive viz for someone and then watch them get excited and learn, but also get lost.



## [R for Data Science, Chapter 19: Functions](http://r4ds.had.co.nz/functions.html)

As in CS, in data science things change and code changes are necessary, so it's important to be able to change them only in one place. Functions are great.

Common function name prefixes are better than suffixes because autocomplete helps you out if you have prefixes.

Functions in R return the last value they computed. Or you can conditionally return early using the `return(value)` function in an `if` statement.

Conditions in `if-else` statements must evaluate to either `TRUE` or `FALSE`. Vectors give warnings and `NA`s give errors. Use `||` and `&&` because `|` and `&`, as in `filter()`, are vectorized.

`==` is also vectorized, so be careful: check that that length `== 1`, collapse vectors with `any()` or `all()`, or use `identical()`, which strictly returns a single `TRUE` or `FALSE` without type coercion (so be careful when comparing integers and doubles; or even better: use `dplyr::near()` instead).

`x == NA` is absolutely useless.


### Multiple conditions

```r
if (this) {
  # do that
} else if (that) {
  # do something else
} else {
  # 
}
```

Or use `switch()`:

```r
function(x, y, op) {
  switch(
    op,
    plus = x + y,
    minus = x - y,
    times = x * y,
    divide = x / y,
    stop("Unknown op!")
  )
}
```


### Function argument types:

  * **Data** (should come first)
  * **Computation details** (should have defaults which most often should be the most common values unless that's unsafe to do)


### Very common short argument names you can use

  * `x`, `y`, `z`: vectors
  * `w`: a vector of weights
  * `df`: a data frame
  * `i`, `j`: numeric indices (typically rows and columns)
  * `n`: length, or number of rows
  * `p`: number of columns


### Checking argument values

Don't go crazy with this because it may take too much time, but you can enforce the validity or arguments passed to a function with `stop()`:

```r
wt_mean <- function(x, w) {
  if (length(x) != length(w)) {
    stop("`x` and `w` must be the same length", call. = FALSE)
  }
  sum(w * x) / sum(w)
}
```

Or use the less-verbose `stopifnot()`, in which you assert the expected truth.

(The text encourages being generic and not too detailed in the error messages and handling to avoid taking too long writing code. I think that costs function users more time down the road. It's a fundamental thought difference with CS people.)


### Dot-dot-dot (`...`)

Catch-all for arguments that can then be passed to other, wrapped functions. You literally pass them as `called_function(...)`.

Problem: misspelled arguments don't raise errors.


### Pipeable functions

Two write a function you can pipe, return something known. If you need to return an object that doesn't get transformed but was simply used in a side-effect, you probably want to return it without printing it out using `invisible(object_to_be_returned)` as the last function line.



## [R for Data Science, Chapter 29: R Markdown Formats](http://r4ds.had.co.nz/r-markdown-formats.html)

To programmatically produce multiple types of output, you can use this insted of the YAML header:

```r
rmarkdown::render("diamond-sizes.Rmd", output_format = "word_document")
```

To render multiple outputs for the YAML header, do, for example:

```yaml
output:
  html_document:
    toc: true
    toc_float: true
  pdf_document: default
```

An `html_notebook` is a variation of the `html_document` meant for collaborating with other data scientists rather than communicating with decision-makers. It embeds the source code that generated it from the `.Rmd` file and you can edit it with RStudio.

To collaborate with `html_notebook`s, git and GitHub are ideal. It's useful to output both of the following in that case:

```yaml
output:
  html_notebook: default
  github_document: default
```

That way you have a local HTML preview and a minimal `.md` file for git.

You can create presentations, with less control that with presentation software but saving huge amounts of time.

> Presentations work by dividing your content into slides, with a new slide beginning at each first (#) or second (##) level header. You can also insert a horizontal rule (***) to create a new slide without a header.

Default R Markdown presentation formats:

  * `ioslides_presentation`: HTML presentation with ioslides
  * `slidy_presentation`: HTML presentation with W3C Slidy
  * `beamer_presentation`: PDF presentation with LaTeX Beamer

`revealjs` and `rmdshower` are packages for 2 other popular formats.

You can also create dashboards with Flexdashboard (and it can do a lot more). Layout:

  * Each level 1 header (#) begins a new page in the dashboard
  * Each level 2 header (##) begins a new column
  * Each level 3 header (###) begins a new row

The YAML:

```yaml
---
title: "Diamonds distribution dashboard"
output: flexdashboard::flex_dashboard
---
```

You can use the `htmlwidgets` package to provide client-side interactivity by transforming to HTML, or `shiny` to use pure R on the server instead. In order to share Shiny apps, you need a Shiny server.

To use Shiny locally:

```yaml
title: "Shiny Web App"
output: html_document
runtime: shiny
```

Then you can add interactive elements to the document:

```r
library(shiny)

textInput("name", "What is your name?")
numericInput("age", "How old are you?", NA, min = 0, max = 150)
```

> You can then refer to the values with input$name and input$age, and the code that uses them will be automatically re-run whenever they change.

You can use a `_site.yml` file in a single directory of `.Rmd` files (the home page called `index.Rmd`) to create a static website. Then execute `rmarkdown::render_site()` to build the site.

The `bookdown` package makes it easy to write books like *R for Data Science*. `prettydoc` and `rticle` are also worth looking at.



## [The Ethical Data Scientist](http://www.slate.com/articles/technology/future_tense/2016/02/how_to_bring_better_ethics_to_data_science.html), from *Slate*

> People have too much trust in numbers to be intrinsically objective, even though it is in fact only as good as the human processes that collected it.

A data point that was relevant in past data may not be relevant in the present or the future, or it may bias results unethically. Race in the US is a prime example.

> For a working data scientist, there's little time for theory.

In general, data scientists are paid to answer narrowly defined questions for narrowly defined goals, not look at the long-term effects of his decisions. But that needs to be considered.

> If the data scientist's goal is to create automated processes that affect people's lives, then he or she should regularly consider ethics in a way that academics in computer science and statistics, generally speaking, do not.

> A data scientist working in finance is usually called a quant, but the job description is the same: use math, computing power, and statistics to predict (and possible to effect) outcomes.

> The ethical data scientist would strive to improve the world, not repeat it. That would mean deploying tools to explicitly construct fair processes. As long as our world is not perfect, and as long as data is being collected on that world, we will not be building models that are improvements on our past unless we specifically set out to do so. At the very least it would require us to build an auditing system for algorithms.
