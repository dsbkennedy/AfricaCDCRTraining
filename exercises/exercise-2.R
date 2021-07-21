# Session 2

# Load the data you saved in session 1. The csv file is called covid_data.csv. Assign the data to an object called covid_data
covid_data <- read.csv(here('data', 'covid_data.csv'))

# Show the first 5 rows of the object covid_data
head(covid_data,n=5)

# Load the tidyverse
library(tidyverse)

# Remove the column called "X"
covid_data_new <- covid_data %>% select(-X)

# Remove the object called "covid_data"