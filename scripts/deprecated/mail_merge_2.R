function(first_name, last_name, full_name, principal_name, school, full_address,
         pronoun, day_abs, times) {
  
  outfile <- paste0("output/handouts", full_name, ".pdf")
  
  rmarkdown::render(
    "source/letter3.Rmd",
    output_file = outfile,
    params = list(
      first_name = first_name, 
      last_name = last_name, 
      full_name = full_name,
      principal_name = principal_name, 
      school = school, 
      full_address = full_address,
      pronoun = pronoun, 
      day_abs = day_abs, 
      times = times)
  )
}