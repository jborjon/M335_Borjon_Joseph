## @knitr hourly_traffic
library(ggthemes)

ibc_sales %>%
  group_by(`Company name`, `Hour of day`) %>%
  summarise(`Total hourly transactions` = n()) %>%
  filter(`Hour of day` >= 7) %>%  # hard to believe anyone sold anything before 7 a.m.
  ggplot(aes(`Hour of day`, `Company name`)) +
  geom_tile(aes(fill = `Total hourly transactions`)) +  # how to avoid legend number overlap? Or make this an average?
  scale_x_continuous(labels = 7:23, breaks = 7:23) +  # thanks to tingyao1 for this tidbit and a few other elements here
  labs(
    title = "Total transaction counts were generally higher in the late morning to early afternoon",
    subtitle = "However, highest-transaction times across companies are not greatly consistent",
    y = NULL
  ) +
  theme_economist_white()


## @knitr weekly_revenue
ibc_sales %>%
  group_by(`Company name`, Week) %>%
  summarise(`Weekly sales (USD)` = sum(Amount)) %>%
  ggplot(aes(Week, `Weekly sales (USD)`, color = `Company name`)) +
  geom_point() +
  geom_line(size = 1) +
  scale_color_brewer(type = "qual", palette = 3) +
  labs(
    title = "Hot Diggity had the highest weekly revenue almost every week",
    subtitle = "However, their sales had somewhat of a downward trend") +
  theme_economist_white()


## @knitr revenue_comparison
ibc_sales %>%
  group_by(`Company name`) %>%
  summarise(`Revenue (USD)` = sum(Amount)) %>%
  ggplot(aes(reorder(`Company name`, `Revenue (USD)`), `Revenue (USD)`)) +
  geom_bar(stat = "identity", fill = "#132B43") +
  labs(
    title = "Hot Diggity and LeBelle were the highest-grossing companies",
    x = NULL
  ) +
  theme_economist_white()


## @knitr profit_comparison
ibc_transactions %>%
  group_by(`Company name`) %>%
  summarise(`Profit (USD)` = sum(Amount)) %>%
  ggplot(aes(reorder(`Company name`, `Profit (USD)`), `Profit (USD)`)) +
  geom_bar(stat = "identity", fill = "#132B43") +
  labs(
    title = "Subtracting expenses, the companies were profitable proportionally to their revenue",
    x = NULL
  ) +
  theme_economist_white()
