# WEEKLYEXERCISE4.R
#Question 4
# install.packages("usethis")   # run once if not installed
library(usethis)

default_branch = git_default_branch()
default_branch

# Default branch comes back as "main"


#Question 6: Olympics Data
=======

library(readr)
library(dplyr)
library(ggplot2)

olym = read_csv("Olympics.csv", show_col_types = FALSE)


#Question 6A: Calculate a new variable, called ‘total.medals’, which is the sum of gold, silver, and bronze, and add it to the Olympic dataset.
olym = olym %>%
  mutate(total.medals = coalesce(gold,0) + coalesce(silver,0) + coalesce(bronze,0))

#Question 6B: For each country, how many gold medals has it won?
gold_by_country = olym %>%
  group_by(country) %>%
  summarise(total_gold = sum(gold, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(total_gold))
head(gold_by_country)

#Question 6C: For each year, how many total medals were given out?
medals_by_year = olym %>%
  group_by(year) %>%
  summarise(total_medals = sum(total.medals, na.rm = TRUE), .groups = "drop") %>%
  arrange(year)
head(medals_by_year)
=======
#Question 7 Go to the main branch and use the same “Olympics.csv” dataset to answer the following questions. Write your code in the previously created “WEEKLYEXERCISE4” R Script.


library(readr)
library(dplyr)
library(ggplot2)

olym = read_csv("Olympics.csv", show_col_types = FALSE)
#Question 7A: Which countries had the largest delegation of athletes in 1992? Create a tibble that contains only the variables country and athletes.

largest_1992 = olym |>
  dplyr::filter(year == 1992) |>
  dplyr::slice_max(order_by = athletes, n = 1, with_ties = TRUE) |>
  dplyr::select(country, athletes)

largest_1992

#Question 7B: For the following five countries, plot the number of gold medals earned over time: United States, France, Germany, Russia, and China.

focus_countries = c("United States","France","Germany","Russia","China")
gold_trend = olym |>
  dplyr::filter(country %in% focus_countries) |>
  dplyr::group_by(country, year) |>
  dplyr::summarise(gold = sum(gold, na.rm = TRUE), .groups = "drop")

ggplot2::ggplot(gold_trend, ggplot2::aes(x = year, y = gold, group = country)) +
  ggplot2::geom_line() +
  ggplot2::geom_point() +
  ggplot2::labs(
    title = "Gold Medals Over Time",
    subtitle = "United States, France, Germany, Russia, China",
    x = "Year", y = "Gold medals"
  )
