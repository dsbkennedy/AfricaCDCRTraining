# Session 2

#Load the package "here"
library(here)

# Load the data you saved in session 2. The csv file is called africa_covid_cases_long.csv. 
# Assign the data to an object called covid_data
covid_data <- read.csv(here('data', 'africa_covid_cases_long.csv'))

# Show the first 5 rows of the object covid_data
head(covid_data,n=5)

# Load the tidyverse
library(tidyverse)

# Remove the column called "X" and assign the data to a new object called "covid_data_new"
covid_data_new <- covid_data %>% select(-X)

# Remove the object called "covid_data"
rm(covid_data)