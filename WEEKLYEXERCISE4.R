# WEEKLYEXERCISE4.R
#Question 4
# install.packages("usethis")   # run once if not installed
library(usethis)

default_branch = git_default_branch()
default_branch

# Default branch comes back as "main"

#Question 6: Olympics Data

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
