## libraries
library(knitr)
library(rmarkdown)
library(here)
library(tidyverse)
library(purrr)

# This is to create the .csv files so the districts have the list of those attending.
# data
nudge <- readRDS(file = here("output", "results", "nudge_high_average.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  filter(times >= 3 & times) %>%
  arrange(last_name, first_name) %>%
  select(last_name, first_name, grade, school, day_abs) %>%
  add_column(sent_letter = NA)

split_nudge <- split(nudge, f = nudge$school) 

names <- names(split_nudge)

walk2(
  .x = split_nudge, 
  .y = names(split_nudge), 
  .f = ~write_csv(.x, file = str_c("output/datafiles/rerun", .y, ".csv"))
)