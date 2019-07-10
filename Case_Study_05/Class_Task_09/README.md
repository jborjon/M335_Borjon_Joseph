---
title: "Notes from Task 9 Reading"
author: "Joseph Borjon"
date: "May 22, 2018"
---

## [Haven library](http://haven.tidyverse.org) (part of the tidyverse)

Enables R to read read and write a bunch of different data formats used by other statistical packages.

Supported input and output formats:

  * **SAS:** `read_sas()`, `read_xpt()`, and `write_sas()`.
  * **SPSS:** `read_sav()`, `read_por()`, and `write_sav()`.
  * **Stata:** `read_dta()` and `write_dta()`.

The output objects are tibbles. Value lables are translated into the new `labelled()` class, which can be coerced easily. Dates and times are converted to R `datetime`.

## [readxl](http://readxl.tidyverse.org) (part of the tidyverse)

Gets data from Excel into R with no external dependencies (i.e. Java, Perl, etc.) for broad OS compatibility. It supports both `.xls` and `.xlsx`. It re-encodes non-ASCII characters to UTF-8. You can provide `col_names` and `col_types` if necessary.

Even if you load the tidyverse, you still need to run `library(readxl)` explicitly because readxl is not a core tidyverse package.

Comes with several example files. List them with `readxl_example()` or call it with an example filename to get the path.

`read_excel("file_path")` loads an `.xls` or `.xlsx` into R as a tibble.

List worksheet names with `excel_sheets("file_path")`.

Specify a worksheet by name or number: `read_excel("file_path", sheet = "sheet_name")` or `read_excel("file_path", sheet = 3)`.

Ways to control which cells are read:

  * `read_excel(xlsx_example, n_max = 3)`: reads only the first 3 rows.
  * `read_excel(xlsx_example, range = "C1:E4")`: reads the Excel-style range specified.
  * `read_excel(xlsx_example, range = cell_rows(1:4))`: I think this reads the rows specified.
  * `read_excel(xlsx_example, range = cell_cols("B:D"))`: reads the columns specified.
  * `read_excel(xlsx_example, range = "mtcars!B1:D5")`: reads the range specified from the sheet specified.

If NA values are represented by something other than blank cells, use `read_excel(xlsx_example, na = "setosa")`.

## [downloader](https://github.com/wch/downloader)

Allows downlod of files over https.

```r
library(downloader)
download("https://github.com/wch/downloader/zipball/master",
         "downloader.zip", mode = "wb")
```
## Class exercises and notes

Go fetch the data file from the URL, then decompress it, and import the data into R.

```r
url("url_here") %>%
  file %>%
  gzcon() %>%
  read_rds()
```

Packages to work wiith Excel other than readxl (which is an excellent default): openxls, xlconnect.

`read_csv()`: creates a data frame from a file downloaded from the Internet and subsequently parsed.
`read.csv()`: creates a tibble from a file downloaded from the Internet and subsequently parsed.

Data scientists are widely criticized for creating fun graphs but not solving problems. So solve problems.
