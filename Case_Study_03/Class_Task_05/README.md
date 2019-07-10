---
title: "Task 5 Notes"
author: "Joseph Borjon"
date: "May 7, 2018"
output: html_document
---

## R for Data Science, Chapter 28: Graphics for communication

You may create graphs for exploratory data analysis, graphs you look at once or twice and throw away. And then you may create graphs to communicate understanding to someone who don't have your background knowledge or investment in the data, so the plots need to be self-explanatory.

Ways to achieve that:

  1. Labels
  2. Annotations
  3. Scale adjustments

The plot title should summarize the main finding. Use labs(title = "", subtitle = "", caption = "", x = "", y = "", color = "", etc.)

Good idea to replace short variable names with more detailed descriptions, including units of measurement.

For axis labels, you can use equations. Use x = quote(math_operations) inside labs().

filter(df, row_number(desc(column_name)) == 1) <- Can be used to select the top item in a column.

geom_text() and geom_label() can be used to write text on the plot. They give no border and border to the text, respectivevly. geom_label() has a nudge_y parameter to move text up slightly, and an alpha parameter for transparency, 1.0 being solid.

geom_text() has hjust and vjust parameters to control alignment.

ggrepel::geom_label_repel(aes(label = model), data = best_in_class) added as a layer can be used to avoid label overlapping.

"Text written here" %>% stringr::str_wrap(width = 40) %>% writeLines() can be used to wrap text (such as labels).

Other annotating geoms: geom_hline(), geom_vline(), geom_rect() to frame areas with a rectangle, and geom_segment() to point using arrows.

If not specified, ggplot2 adds default scales. Defaults are chosen to do a good job for lots of cases, but you may do better.

Default scale naming: scale_[name_of_aesthetic]_[one of continuous, discrete, datetime, or date]

Example of most common use of x and y breaks: scale_y_continuous(breaks = seq(15, 40, by = 5))

scale_y_continuous(labels = NULL) suppresses labels.

The collective name for axes and legends is guides.

Axes are used for x and y aesthetics, while legends are used for everything else.

Adjust scale for a date axis with a format specification to show years: scale_x_date(NULL, breaks = presidential$start, date_labels = "'%y")

Themes can be tweaked with theme(legend.position = "top"), or theme(legend.position = "none") to supress legend.

Control the display of individual legends: guides(colour = guide_legend(nrow = 1, override.aes = list(size = 4)))

scale_x_log10() makes a scale logarithmic.

scale_colour_brewer(palette = "Set1") is a color set for data that is easier to distinguish for colorblind people. Documented at http://colorbrewer2.org. Sequential and diverging palettes are especially useful if categorical values are ordered.

To set colors for data manually: scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))

For continuous color: scale_colour_gradient() or scale_fill_gradient(). For diverging scales: scale_colour_gradient2().

Another option: scale_colour_viridis() is a continuous analog of the categorical ColorBrewer scales, with good perceptual properties.

Three ways to control the plot limits:

  1. Adjusting what data are plotted with filter()
  2. Setting the limits in each scale - good for sharing limits across multiple plots
  3. Setting xlim and ylim in coord_cartesian() - usually the best choice

Layers on a ggplot themselves can be saved as variables, making reuse easier. Useful for scales.

Themes affect the non-data elements of a plot.

Always specify width and height in ggsave for reproducible code.

You should probably always assemble final reports using R Markdown.

Saving as PDF is good because they are vector graphics. But for huge amounts of data points, tha would be slow, so you can use PNG.
