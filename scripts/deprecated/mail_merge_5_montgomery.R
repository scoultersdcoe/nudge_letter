## libraries
library(knitr)
library(rmarkdown)
library(here)
library(tidyverse)

# data
nudge <- readRDS(file = here("output", "results", "nudge.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  filter(school == "Montgomery Middle School",
         times >= 3 & times <= 17)

nudge$first_name <- gsub("(.*)\\s+[A-Z]\\.?$", "\\1", nudge$first_name)


#recipient list
recipients <- data.frame(first_name = nudge$first_name, 
                         last_name = nudge$last_name,
                         full_name = nudge$full_name,
                         principal_name = nudge$principal_name,
                         school = nudge$school,
                         full_address = nudge$full_address,
                         pronoun = nudge$pronoun,
                         day_abs = nudge$day_abs,
                         times = nudge$times,
                         stringsAsFactors = FALSE)

# loop
for (i in 1:nrow(recipients)){
  rmarkdown::render("source/deprecated/letter3_mont_fix.Rmd", 
                    params = list(
                      first_name = recipients[i, "first_name"], 
                      last_name = recipients[i, "last_name"],
                      full_name = recipients[i, "full_name"],
                      principal_name = recipients[i, "principal_name"],
                      school = recipients[i, "school"],
                      full_address = recipients[i, "full_address"],
                      pronoun = recipients[i, "pronoun"],
                      day_abs = recipients[i, "day_abs"],
                      times = recipients[i, "times"]),
                    output_file = paste("handout_", i, ".pdf", sep=''),
                    output_dir = "output/handouts/Woodson")
}
