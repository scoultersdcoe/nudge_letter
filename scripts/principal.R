library(readr)
principal2 <- read_csv("output/results/principal2.csv")

saveRDS(principal2, file = here("output", "results", "principal2.rds"))
