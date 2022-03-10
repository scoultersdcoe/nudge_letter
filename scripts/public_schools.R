## Data Download Public Schools ------------------------------------------------
library(here)
library(purrr)
library(tidyverse)
library(readxl)


download.file("https://www.cde.ca.gov/schooldirectory/report?rid=dl1&tp=txt", 
              "./data/raw/public_schools.txt", mode = "wb")
public_schools <- read_delim("data/raw/public_schools.txt", 
                             "\t", escape_double = FALSE, trim_ws = TRUE)

public_schools_2 <- public_schools %>%
  filter(County == "San Diego")
rm(public_schools)

network <- tibble(
  school = c("Cajon Park Elementary", "Carlton Hills Elementary", "Chet F. Harritt Elementary",
             "Pepper Drive Elementary", "Rio Seco Elementary", "Sycamore Canyon Elementary", "Willow Elementary", 
             "Vista Del Mar", "Smythe Elementary", "La Mirada Elementary",
             "Sunset Elementary", "Ocean View Hills", "San Ysidro Middle", 
             "Mt. Woodson Elementary", "Porter Elementary", "Monarch", 
             "Central Elementary", "Emory Elementary", "Howard Pence Elementary",
             "Montgomery Middle"))


network_merge <- network %>%
  left_join(public_schools_2, by = c("school" = "School")) %>%
  select(school, CDSCode, District, Street, City, Zip, State, MailStreet,
         MailCity, MailZip, MailState, Phone, WebSite, AdmFName, AdmLName, AdmEmail,
         LastUpDate) %>%
  janitor::clean_names()

network_merge <- network_merge[-c(8, 9, 19, 20, 22, 23, 27, 28), ]

saveRDS(network_merge, file = here("output", "results", "principal.rds"))
write.csv(network_merge, file = here("output", "results", "principal.csv"))


  


  