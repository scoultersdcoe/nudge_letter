## libraries
library(knitr)
library(rmarkdown)
library(here)
library(tidyverse)

#This is how to merge for the letters. Need to change no maximum and order by last name.
# data
nudge <- readRDS(file = here("output", "results", "nudge_high_average.rds")) %>%
  mutate(full_name = as.factor(full_name)) %>%
  filter(school == "Willow Elementary",
         times >= 3) %>%
  arrange(last_name, first_name)

nudge$first_name <- gsub("(.*)\\s+[A-Z]\\.?$", "\\1", nudge$first_name)

#recipient list
recipients <- data.frame(first_name = nudge$first_name, 
                         last_name = nudge$last_name,
                         full_name = nudge$full_name,
                         principal_name = nudge$principal_name,
                         title = nudge$title,
                         school = nudge$school,
                         full_address = nudge$full_address,
                         pronoun = nudge$pronoun,
                         day_abs = nudge$day_abs,
                         times = nudge$times,
                         stringsAsFactors = FALSE)

# loop
for (i in 1:nrow(recipients)){
  rmarkdown::render("source/letter3_high_average.Rmd", 
                    params = list(
                      first_name = recipients[i, "first_name"], 
                      last_name = recipients[i, "last_name"],
                      full_name = recipients[i, "full_name"],
                      principal_name = recipients[i, "principal_name"],
                      title = recipients[i, "title"],
                      school = recipients[i, "school"],
                      full_address = recipients[i, "full_address"],
                      pronoun = recipients[i, "pronoun"],
                      day_abs = recipients[i, "day_abs"],
                      times = recipients[i, "times"]),
                    output_file = paste("handout_", i, ".pdf", sep=''),
                    output_dir = "output/letters/Willow")
}
