# Session 1

# Load the readxl and here packages
library(readxl)
library(here)

# Load the Excel file called africa_cdc_covid_data.xlsx and assign to an object called covid_data
covid_data <- readxl::read_xlsx(here('data', 'africa_cdc_covid_data.xlsx'))

#Describe the dataset. How many rows (observations) and columns (variables) does it have?

# Save the object covid_data as a csv file in the data folder
write.csv(covid_data, here('data', 'covid_data.csv'))

