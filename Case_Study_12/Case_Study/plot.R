## @knitr prepare_to_plot

library(tidyverse)
library(usmap)
library(geofacet)
library(ggthemes)
library(scales)
library(extrafont)


# Create the spatial plots
plot_spatial <- function(
  df,
  colname,
  plot_title,
  plot_legend,
  legend_scale = waiver(),
  legend_colors = c("#458b00", "#cd2626"),
  plot_subtitle = NULL
  ) {
  # Ply the data
  df <- df %>%
    select(
      fips = county_5_digit_fips,
      matches(colname)
    )

  # Plot
  plot_usmap(
      data = df,
      values = colname,
      regions = "counties",
      lines = "#555555",
      theme = theme_gray()
    ) +
    labs(
      title = plot_title,
      subtitle = plot_subtitle,
      fill = plot_legend
    ) +
    scale_fill_gradient(
      low = legend_colors[[1]],
      high = legend_colors[[2]],
      labels = legend_scale
    ) +
    theme(
      text = element_text(size = 14, family = "Segoe UI"),
      plot.title = element_text(size = 24, hjust = 0.5),
      plot.subtitle = element_text(hjust = 0.5),
      panel.background = element_blank(),
      axis.title = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      legend.position = "bottom",
      legend.box.spacing = unit(0, "mm"),
      legend.key.width = unit(0.06, "npc")
    )
}


# @knitr plot_education_scatterplot
counties_suicide_all %>%
  select(AvgAdjustedRate, county_5_digit_fips) %>%
  left_join(counties_ed_results, by = "county_5_digit_fips") %>%
  select(mn_avg_ol, AvgAdjustedRate, county_5_digit_fips) %>%
  left_join(
    counties_socioeco %>%
      select(ST, unemp_all, poverty517_all, county_5_digit_fips),
    by = "county_5_digit_fips"
  ) %>%
  
  ggplot(aes(AvgAdjustedRate, mn_avg_ol)) +
  geom_jitter(
    aes(size = unemp_all, color = poverty517_all),
    alpha = 0.7,
    shape = 16
  ) +
  labs(
    title = "Suicide rates vs. school scores for school-aged children, by county",
    subtitle = paste(
      "Bigger and redder points represent less privileged counties",
      "that their smaller and greener counterparts.\n",
      "Larger states generally have more counties, so the number",
      "of points per state is somewhat irrelevant."
    ),
    x = "Suicide rate (age-adjusted)",
    y = "Test results",
    size = "Unemployment\nrate",
    color = "Percentage of\nhouseholds in poverty"
  ) +
  scale_color_gradient(low = "#458b00", high = "#cd2626", labels = scales::percent) +
  facet_geo(~ ST) +
  theme_igray() +
  theme(
    text = element_text(size = 14, family = "Segoe UI"),
    plot.title = element_text(size = 24, hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    legend.key.width = unit(0.05, "npc"),
    legend.position = "bottom",
    legend.box.spacing = unit(0.05, "npc")
  )


## @knitr plot_child_suicides
plot_spatial(
  counties_suicide_all,
  "AvgAdjustedRate",
  "Suicide rate among children 10-19 between 2008 and 2014 (age-adjusted)",
  "Suicides per 100K\nof the age cohort",
  legend_colors = c("#ffecec", "#cd2626"),
  plot_subtitle = "Gray counties have no recorded suicides at that age group in the given years."
)


## @knitr plot_adult_suicides
plot_spatial(
  counties_suicide_20_up,
  "AvgAdjustedRate",
  "Suicide rate among adults 20 and up between 2008 and 2014 (age-adjusted)",
  "Suicides per 100K\nof the age cohort",
  legend_colors = c("#ffecec", "#cd2626")
)


## @knitr plot_education_results
plot_spatial(
  counties_ed_results,
  "mn_avg_ol",
  "Quality of public education by county based on test results from 2008 to 2014",
  "Mean EDFacts Test-Based Achievement,\nPooled Across Subjects (Math & ELA)",
  legend_colors = c("#cd2626", "#458b00")
)


## @knitr plot_household_poverty
plot_spatial(
  counties_socioeco,
  "poverty517_all",
  "Poverty percentages of households with school-age children",
  "Percentage of households\nin poverty with children 5-17",
  scales::percent
)


## @knitr plot_unemployment
plot_spatial(
  counties_socioeco,
  "unemp_all",
  "Unemployment rate across years 2008 to 2015",
  "Unemployed population %",
  scales::percent
)
