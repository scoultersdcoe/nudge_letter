## libraries
library(knitr)
library(rmarkdown)
library(here)
library(tidyverse)
library(tinytex)

## Data
nudge <- readRDS(file = here("output", "results", "nudge.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  slice_max(day_abs, n = 10)

render_fun <- function(first_name, last_name, full_name, principal_name, school,
                       full_address, pronoun, day_abs, times){
  rmarkdown::render(
    input = "source/letter3.Rmd",
    params = list(first_name = first_name, last_name = last_name, full_name = full_name,
                  principal_name = principal_name, school = school, full_address = full_address,
                  pronoun = pronoun, day_abs = day_abs, times = times),
    output_file = glue::glue(
      # can change to PDF or whatever you'd like
      "letter-{first_name}-{last_name}.pdf"
      ),
    output_dir = "output/handouts/"
  )
}


tidyr::crossing(
  first_name = nudge$first_name, 
  last_name = nudge$last_name,
  full_name = nudge$full_name,
  principal_name = nudge$principal_name,
  school = nudge$school,
  full_address = nudge$full_address,
  pronoun = nudge$pronoun,
  day_abs = nudge$day_abs,
  times = nudge$times) %>%
  purrr::pwalk(render_fun)
