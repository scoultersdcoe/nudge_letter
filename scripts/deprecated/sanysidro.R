library(tidyverse)
new_nudge <- nudge_san %>% filter(school %in% c(
  "San Ysidro Middle School", "Vista Del Mar")) %>%
  filter(times >= 3 & times <= 17)

split_new_nudge <- split(new_nudge, f = new_nudge$school) 

names <- names(split_new_nudge)

walk2(
  .x = split_new_nudge, 
  .y = names(split_new_nudge), 
  .f = ~write_csv(.x, file = str_c("output/datafiles/sanysidro", .y, ".csv"))
)