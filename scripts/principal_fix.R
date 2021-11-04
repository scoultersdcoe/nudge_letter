library(tidyverse)
library(here)
# load data
principal <- readRDS(here("output", "results", "principal.rds"))

# fix issues
principal$adm_f_name[principal$adm_f_name == "Consuelo"] <- "Erika"
principal$adm_l_name[principal$adm_l_name == "Carranza"] <- "Meza"

principal$school[principal$school == "Carlton Hills Elementary"] <- "Carlton Oaks Elementary"  
principal$mail_street[principal$mail_street == "9353 Pike Road"] <- "9353 Wethersfield Road"  
principal$adm_f_name[principal$adm_f_name == "Debra"] <- "Andrew"
principal$adm_l_name[principal$adm_l_name == "Simpson"] <- "Johnson"

 
principal$mail_street[principal$mail_street == "4063 Polk Avenue"] <- "1290 Ebony Avenue"
principal$district[principal$district == "San Diego Unified"] <- "South Bay Union"
principal$mail_zip[principal$mail_zip == "92105-1436"] <- "91932-1000"
principal$adm_f_name[principal$adm_f_name == "Elizabeth"] <- "Paola"
principal$adm_l_name[principal$adm_l_name == "Castillo-Duvall"] <- "Flores"

saveRDS(principal, file = here("output", "results", "principal.rds"))