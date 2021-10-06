# This function extracts the code from an R Markdown file so that the user can follow along with the demonstration

knitr::purl("01_intro.Rmd", "scripts/01_intro.R")
knitr::purl("02_data_management.Rmd", "scripts/02_data_management.R")
knitr::purl("03_analysis_visualisation.Rmd", "scripts/03_analysis_visualisation.R")

# These are lines of code which need to be added to the start of the files in the scripts folder

#This code runs a function allowing the user to view html files in their RStudio window
source("scripts/viewerpane_html.R")

#This code applies the previous function to a specified html file
viewerpane_html("docs/01_intro.html")
viewerpane_html("docs/02_data_management.html")
viewerpane_html("docs/03_analysis_visualisation.html")

