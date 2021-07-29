# Session 3

# Load the packages here, readxl and dplyr
library(here)
library(readxl)
library(dplyr)
# Import the dataset covid_data_new
covid_data_new <- read.csv(here('data', 'covid_data_new.csv'))

# Build an analysis dataset called analysis_data containing the columns date_format,AFRICAN_REGION,COUNTRY_NAME and cases
analysis_data <- covid_data_new %>% select(date_format,AFRICAN_REGION, COUNTRY_NAME,cases)

# How many cases of COVID were recorded in Southern Africa?
analysis_data %>% 
  filter(AFRICAN_REGION=="Southern Africa") %>% 
  summarise(total_cases=sum(cases,na.rm=TRUE))

# What was the first country to recored a covid case in Southern Africa?
first_cases_southern_africa <- analysis_data %>% 
  filter(AFRICAN_REGION=="Southern Africa") %>% 
  filter(cases>0) %>% 
  filter(date_format== min(date_format, na.rm=TRUE))
  
first_cases_southern_africa 
  
 