library(tidyverse)
library(here)
library(purrr)

nudge <- readRDS(file = here("output", "results", "nudge.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  slice_max(day_abs, n = 10)


full_name <- nudge$full_name

reports <- tibble(
  output_file = stringr::str_c("../output/handouts/", full_name, ".pdf"),
  params = map(full_name, ~list(full_name = .))
)

reports %>%
  pwalk(rmarkdown::render, input = "source/letter3.Rmd")
