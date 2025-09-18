# WEEKLYEXERCISE4.R
# install.packages("usethis")   # run once if not installed
library(usethis)

default_branch = git_default_branch()
default_branch

# Default branch comes back as "main"

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

