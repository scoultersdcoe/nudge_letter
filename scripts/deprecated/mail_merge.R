## libraries
library(knitr)
library(rmarkdown)
library(here)
library(tidyverse)

## Data
nudge <- readRDS(file = here("output", "results", "nudge.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  slice_max(day_abs, n = 10)

## Vectors
full_name <- data.frame(full_name = nudge$full_name)
first_name <- nudge$first_name 
last_name <- nudge$last_name
full_name <- nudge$full_name
principal_name <- nudge$principal_name
school <- nudge$school
full_address <- nudge$full_address
pronoun <- nudge$pronoun
day_abs <- nudge$day_abs
times <- nudge$times

## Loop
for (full_name in nudge) {
  print(full_name)
  rmarkdown::render(input = "source/letter3.Rmd",
                    output_file = paste("handout_", full_name, ".pdf", sep=''),
                    output_dir = "output/handouts/",
                    params = list(full_name = full_name)
  )
}

for (i in 1:nrow(nudge)) {
  print(full_name)
  rmarkdown::render(input = "source/letter3.Rmd",
                    output_file = paste("handout_", full_name, ".pdf", sep=''),
                    output_dir = "output/handouts/")
}
