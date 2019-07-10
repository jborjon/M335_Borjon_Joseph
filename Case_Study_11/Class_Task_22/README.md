---
title: "Notes from Task 22"
author: "Joseph Borjon"
date: "July 6, 2018"
---

## [What Is Hadoop?](https://www.youtube.com/watch?v=4DgTLaFNQq0&feature=youtu.be) (2013 video)

"Infrastructure software for storing and processing large datasets. It's an open-source project under Apache and it's enormously popular."

HDFS is "Hadoop Distributed File System." It allows storage of many files or huge files.

Being and FS, Hadoop can store structured or unstructured data.

MapReduce is the way Hadoop processes (search, aggregation, etc.) the data on the file system. Because moving large data sets over a network is ridiculously slow, MapReduce moves the software to where the data is instead (mapping). Then, when it gets the answer (reducing), it brings the answer back.

Apache's Pig and Hive are two of the open-source projects related to Hadoop that add functionality to it.

Hadoop requires some heavy Java programming to set up.

"Hadoop is fundamentally a batch-processing environment," which means it's great for large data sets but not necessarily great at processing ad-hoc queries.



## [Spark 101: What Is It, What It Does, and Why It Matters](https://mapr.com/blog/spark-101-what-it-what-it-does-and-why-it-matters)

Some see Apache Spark as a more powerful replacement for Hadoop, while others see it as a complement to it. In reality, it depends on the needs of your organization.

"Spark is a general-purpose data processing engine ... Application developers and data scientists incorporate Spark into their applications to rapidly query, analyze, and transform data at scale. [Frequently used for] interactive queries across large data sets, processing of streaming data from sensors or financial systems, and machine learning tasks."

Started in 2009 in APMLab at UC Berkeley. Databricks (founded by Spark's creating team), IBM, and Huawei are financial backers and project contributors. Novartis is also a heavy user.

Optimized to run in memory, faster even than Hadoop MapReduce (some claim 10 to 100 times faster). But MapReduce is meant to batch-process, where it still shines.

Can handle several petabytes of distributed data at a time. Supports Java, Python, R, Scala, etc. Flexible, lots of use cases. Can integrate with data storage subsystems such as Hadoop (obviously), HBase, Cassandra, MapR-DB, MongoDB and Amazon’s S3.

### Typical use cases

  * **Streaming and processing:** e.g. log files and sensor data; data that arrives in steady streams, often from several simultaneous sources, processing and acting on the data as it arrives, such as when detecting fraudulent transactions.

  * **Machine learning:** now becoming more accurate, you can train the software on well-understood datasets before unleashing it on new datasets. Spark is fast and so is good for training. Its speed allows one to run different algorithms to find the most effective one.

  * **Interactive streaming analytics:** business analysts and data scientists don't want to create static dashboards but to explore data by asking questions and digging deeper, which requires a system that can respond and adapt quickly.

  * **Data integration:** ETL (*Extract, Transform, and Load*) processes pull data from different systems in the organization, then clean and standardize it, and finally load it into a separate system for analysis, because the data produced by different systems in a organization is rarely clean or consistent enough. Spark and Hadoop reduce the cost and time it takes.

### Why Spark?

  * **Simplicity**
  * **Speed**
  * **Support**



## [Learn to crunch big data with R](https://www.infoworld.com/article/2880360/big-data/learn-to-crunch-big-data-with-r.html)

They chose R to do a complex statistical subsystem to leverage "the wide variety of statistical (linear and nonlinear modeling, classical statistical tests, time-series analysis, classification, clustering) and graphical techniques implemented in the R system."

CRAN == "Comprehensive R Archive Network." I never knew that. The other two big archives are Omegahat and Bioconductor, and there are additional packages in R-Forge.

You can see [Available CRAN Packages By Name](https://cran.r-project.org/web/packages/available_packages_by_name.html).

To R programmers, "big data" usually means datasets too big to be analyzed in memory.

"Top management wants monthly reports, and middle management wants to play with the data without knowing anything about what’s under the covers." That's where Shiny and R Markdown are great.

"You can use Shiny to build interactive and “reactive” Web apps, with widgets that correspond to HTML control elements such as input fields. By “reactive,” RStudio means that when a value changes, all values with dependencies on the changed value are recalculated, as you’d expect from a spreadsheet program," which is useful for interactive visualizations.

You can publish Shiny apps to the [shinyapps.io](http://www.shinyapps.io) server.
