## libraries
library(knitr)
library(rmarkdown)
library(here)
library(tidyverse)
library(purrr)

# data
nudge <- readRDS(file = here("output", "results", "nudge.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  filter(times >= 3 & times <= 17) %>%
  select(last_name, first_name, school, day_abs)

split_nudge <- split(nudge, f = nudge$school) 

names <- names(split_nudge)

walk2(
  .x = split_nudge, 
  .y = names(split_nudge), 
  .f = ~write_csv(.x, file = str_c("output/datafiles/", .y, ".csv"))
)