## -----------------------------------------------------------------------------------------------------
summary(africa_covid_cases_long)


## -----------------------------------------------------------------------------------------------------
names(africa_covid_cases_long)


## -----------------------------------------------------------------------------------------------------
analysis_dataset <- africa_covid_cases_long %>% 
  select(date_format,AFRICAN_REGION, COUNTRY_NAME, cases)


## -----------------------------------------------------------------------------------------------------
head(analysis_dataset)


## -----------------------------------------------------------------------------------------------------
analysis_dataset <- africa_covid_cases_long %>% 
  select(date=date_format,region=AFRICAN_REGION, country=COUNTRY_NAME, cases)


## -----------------------------------------------------------------------------------------------------
head(analysis_dataset)


## -----------------------------------------------------------------------------------------------------
analysis_dataset %>%  # Tell R what dataset we want to use
    summarise(total_covid_cases=sum(cases))  #Tell R what function we want to apply to the data



## -----------------------------------------------------------------------------------------------------
full_dataset <- na.omit(analysis_dataset)


## -----------------------------------------------------------------------------------------------------
total_covid_cases <- analysis_dataset %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE))
total_covid_cases


## -----------------------------------------------------------------------------------------------------
total_covid_cases_region <- analysis_dataset %>% 
  group_by(region) %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE))


## -----------------------------------------------------------------------------------------------------
analysis_dataset %>% 
  group_by(region) %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  arrange(-total_covid_cases)


## -----------------------------------------------------------------------------------------------------
analysis_dataset %>% 
  group_by(region, country) %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  arrange(-total_covid_cases)


## -----------------------------------------------------------------------------------------------------
analysis_dataset %>% 
  group_by(region, country) %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  arrange(-total_covid_cases) %>% 
  filter(region=="Northern Africa")


## -----------------------------------------------------------------------------------------------------
northern_africa <- analysis_dataset %>% 
  filter(region=="Northern Africa")


## -----------------------------------------------------------------------------------------------------
#to convert the calculation to percentage we will need to install an additional package
#install.packages("scales")

northern_africa %>% 
  group_by(country) %>% 
  summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  mutate(percentage=scales::percent(total_covid_cases/sum(total_covid_cases))) %>% 
  #with this mutate command we are telling r to divide the total number of covid cases for each country by the total number of covid cases for all countries in northern africa
  arrange(-total_covid_cases)  



## -----------------------------------------------------------------------------------------------------
northern_africa_cases_country <- northern_africa %>% 
  group_by(country) %>% 
  summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  mutate(percentage=scales::percent(total_covid_cases/sum(total_covid_cases))) %>% 
  #with this mutate command we are telling r to divide the total number of covid cases for each country by the total number of covid cases for all countries in northern africa
  arrange(-total_covid_cases)  


## -----------------------------------------------------------------------------------------------------
first_cases_northern_africa <- northern_africa %>% 
  filter(cases>0) %>% 
  filter(date == min(date, na.rm=TRUE)) 
first_cases_northern_africa


## -----------------------------------------------------------------------------------------------------
first_case_northern_africa_country <- northern_africa %>% 
  group_by(country) %>% 
  filter(cases>0) %>% 
  filter(date == min(date, na.rm=TRUE)) 
first_case_northern_africa_country


## -----------------------------------------------------------------------------------------------------
first_case_northern_africa_country_exclude_tunisia <- northern_africa %>% 
  group_by(country) %>% 
  filter(cases>0) %>% 
  filter(date == min(date, na.rm=TRUE)) %>% 
  #filter(!country=="Tunisia") %>% 
  filter(country!="Tunisia") #both methods for excluding results (in this case excluding results where the value for country is Tunisia) can be used 
first_case_northern_africa_country_exclude_tunisia


## -----------------------------------------------------------------------------------------------------
first_cases_northern_africa_data <- northern_africa %>% 
  group_by(country) %>% 
  mutate(cumulative_cases=cumsum(cases)) %>% 
  filter(cumulative_cases>=100) %>% 
  slice(1) %>% 
  pull(date, country)


## -----------------------------------------------------------------------------------------------------
first_100cases <- northern_africa %>% 
  group_by(country) %>% 
  mutate(cumulative_cases=cumsum(cases)) %>% 
  filter(cumulative_cases>=100) %>% 
  slice(1) %>% 
  pull(date, country)


## ----eval=FALSE, echo=TRUE----------------------------------------------------------------------------
## The first COVID-19 case recorded in Northern Africa was in `r first_cases_northern_africa %>% pull(country)` on `r first_cases_northern_africa %>% pull(date)`.


## -----------------------------------------------------------------------------------------------------
morocco_covid_cases <- northern_africa %>% 
  filter(country=="Morocco")


## -----------------------------------------------------------------------------------------------------
pacman::p_load(zoo)
morocco_covid_cases_mean <- morocco_covid_cases %>% 
  mutate(cases_7day_mean=rollmean(cases,k=7, fill=NA))


## -----------------------------------------------------------------------------------------------------
morocco_covid_cases_mean <- morocco_covid_cases %>% 
  mutate(cases_7day_mean=rollmean(cases,k=7, fill=NA)) %>% 
  mutate(cases_14day_mean=rollmean(cases,k=14,fill=NA))

