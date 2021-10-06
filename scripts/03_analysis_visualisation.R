source("scripts/viewerpane_html.R")
viewerpane_html("docs/03_analysis_visualisation.html")

## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
library(here)
pacman::p_load(here)
africa_covid_cases_long <- read.csv(here('data', 'africa_covid_cases_long.csv'))
summary(africa_covid_cases_long)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
names(africa_covid_cases_long)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse) # this will load the dplyr package along with other core tidyverse packages
library(dplyr) # this will only load the dplyr package
# you don't need to run both lines! Loading a package twice will not have any negative consequences. But it makes your code less efficient to read!
analysis_dataset <- africa_covid_cases_long %>% #use this dataset
  select(date_format,AFRICAN_REGION, COUNTRY_NAME, cases) #select the named columns


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
head(analysis_dataset)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
analysis_dataset <- africa_covid_cases_long %>% 
  select(date_format,region=AFRICAN_REGION, country=COUNTRY_NAME, cases) %>% 
  mutate(date=lubridate::ymd(date_format))


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
head(analysis_dataset)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
analysis_dataset %>%  # Tell R what dataset we want to use
    summarise(total_covid_cases=sum(cases))  #Tell R you want to sum all cases



## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
total_covid_cases <- analysis_dataset %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) #Tell R you want to sum all cases but remove NA values - values with "missing" data
total_covid_cases


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
total_covid_cases_region <- analysis_dataset %>% 
  group_by(region) %>% #use the values in the region column to group the data 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) #for each region, sum the number of cases
total_covid_cases_region


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
total_covid_cases_region_sort <- analysis_dataset %>% 
  group_by(region) %>% #use the values in the region column to group the data 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  arrange(-total_covid_cases)
total_covid_cases_region_sort


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
total_covid_cases_region_country_sort <- analysis_dataset %>% 
  group_by(region, country) %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% #for each region, sum the number of cases
  arrange(-total_covid_cases) #sort the result from highest to lowest number of cases
total_covid_cases_region_country_sort


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
analysis_dataset %>% 
  group_by(region, country) %>% 
    summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  arrange(-total_covid_cases) %>% #sort the result from highest to lowest number of cases
  filter(region=="Northern Africa") #filter the result to only include rows where the region is "Northern Africa"


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
northern_africa <- analysis_dataset %>% 
  filter(region=="Northern Africa")
head(northern_africa)



## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
#to convert the calculation to percentage we will need to install and load an additional package called "scales"
pacman::p_load(scales)

northern_africa_cases_country <- northern_africa %>% 
  group_by(country) %>% 
  summarise(total_covid_cases=sum(cases, na.rm=TRUE)) %>% 
  mutate(percentage=scales::percent(total_covid_cases/sum(total_covid_cases))) %>% 
  #with this mutate command we are telling r to divide the total number of covid cases for each country by the total number of covid cases for all countries in northern africa
  arrange(-total_covid_cases)  
northern_africa_cases_country



## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
library(ggplot2)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases)) +
  geom_line()


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line()


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  labs(x='Date', y='Total cases', color='Country') + #label axes
  theme(legend.position='top') + #place legend at top of graph
  scale_x_date(date_breaks = '2 months', #set x axis to have 2 month breaks
               date_minor_breaks = '1 month', #set x axis to have 1 month breaks
               date_labels = '%b-%y') #change label for x axis



## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  labs(x='Date', y='Total cases') + #label axes
  theme(legend.position='none') + #remove legend by setting position to 'none'
  scale_x_date(date_breaks = '4 months', #set x axis to have 2 month breaks
               date_minor_breaks = '2 months', #set x axis to have 1 month breaks
               date_labels = '%b-%y') + #change label for x axis
  facet_wrap(~country) # this will create a separate graph for each country


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
pacman::p_load(gghighlight)
highlight_country_morocco_gph <- ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  gghighlight::gghighlight(country == "Morocco") + #highlight data reported by Morocco
  labs(x='Date', y='Total cases') + #label axes
  theme(legend.position='none') + #remove legend by setting position to 'none'
  scale_x_date(date_breaks = '4 months', #set x axis to have 2 month breaks
               date_minor_breaks = '2 months', #set x axis to have 1 month breaks
               date_labels = '%b-%y')  #change label for x axis
 highlight_country_morocco_gph


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
highlight_country_facet_gph <- ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  labs(x='Date', y='Total cases') + #label axes
  gghighlight::gghighlight() + #highlight each country independently
  theme(legend.position='none') + #remove legend by setting position to 'none'
  scale_x_date(date_breaks = '4 months', #set x axis to have 2 month breaks
               date_minor_breaks = '2 months', #set x axis to have 1 month breaks
               date_labels = '%b-%y') + #change label for x axis
  facet_wrap(~country) # this will create a separate graph for each country
highlight_country_facet_gph


## ----eval=FALSE, echo=TRUE---------------------------------------------------------------------------------------------------------------------------------------
## pacman::p_load(esquisse)
## esquisse::esquisser()


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
first_cases_northern_africa <- northern_africa %>% # use the northern_africa data
  filter(cases>0) %>% #filter to only include rows with a case value of greater than 0
  filter(date == min(date, na.rm=TRUE))  #keep the row with the minimum (first) date
first_cases_northern_africa


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
first_case_northern_africa_country <- northern_africa %>% 
  group_by(country) %>% 
  filter(cases>0) %>% 
  filter(date == min(date, na.rm=TRUE)) 
first_case_northern_africa_country


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
first_case_northern_africa_country_exclude_tunisia <- northern_africa %>% 
  group_by(country) %>% 
  filter(cases>0) %>% 
  filter(date == min(date, na.rm=TRUE)) %>% 
  #filter(!country=="Tunisia") %>% 
  filter(country!="Tunisia") #both methods for excluding results (in this case excluding results where the value for country is Tunisia) can be used 
first_case_northern_africa_country_exclude_tunisia


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
first_cases_northern_africa_data <- northern_africa %>% 
  group_by(country) %>% 
  mutate(cumulative_cases=cumsum(cases)) %>% 
  filter(cumulative_cases>=100) %>% 
  slice(1) %>% 
  pull(date, country)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
first_100cases <- northern_africa %>% 
  group_by(country) %>% 
  mutate(cumulative_cases=cumsum(cases)) %>% 
  filter(cumulative_cases>=100) %>% 
  slice(1) %>% 
  pull(date, country)


## ----eval=FALSE, echo=TRUE---------------------------------------------------------------------------------------------------------------------------------------
## The first COVID-19 case recorded in Northern Africa was in `r first_cases_northern_africa %>% pull(country)` on `r first_cases_northern_africa %>% pull(date)`.


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
morocco_covid_cases <- northern_africa %>% 
  filter(country=="Morocco")


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
pacman::p_load(slider)

morocco_covid_cases_mean <- morocco_covid_cases %>% 
  mutate(                                # create new columns
    # Using slide_dbl()
    ###################
    reg_7day = slide_dbl(
      cases,                         # calculate on new_cases
      .f = ~mean(.x, na.rm = T),          # function is sum() with missing values removed
      .before = 7))                     # window is the ROW and 6 prior ROWS


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
morocco_covid_cases_mean <- morocco_covid_cases %>% 
    mutate(                                # create new columns
    # Using slide_dbl()
    ###################
    cases_7day_mean = slide_dbl(
      cases,                         # calculate on new_cases
      .f = ~mean(.x, na.rm = T),          # function is sum() with missing values removed
      .before = 7),                  # window is the ROW and 6 prior ROWS
     cases_14day_mean = slide_dbl(
      cases,                         # calculate on new_cases
      .f = ~mean(.x, na.rm = T),          # function is sum() with missing values removed
      .before = 14))                  # window is the ROW and 6 prior ROWS



## ----------------------------------------------------------------------------------------------------------------------------------------------------------------

moroocco_covid_cases_graph <- morocco_covid_cases_mean %>% 
  ggplot() +
  geom_col(aes(x=date, y=cases, color=country)) +
  geom_line(aes(x=date, y=cases_7day_mean)) +
  labs(x='Month-Year', 
       y='Total cases', 
       title='Cases and 7-day average (black line)') +
  theme(legend.position='none') +
  scale_x_date(date_breaks = '4 months', #set x axis to have 2 month breaks
               date_minor_breaks = '2 months', #set x axis to have 1 month breaks
               date_labels = '%b-%y')  #change label for x axis

moroocco_covid_cases_graph


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
pacman::p_load(gt,here,dplyr)


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
northern_africa_cases_country_table <- northern_africa_cases_country %>% 
  gt() %>% 
   tab_header(
    title = md("COVID-19 in Northern Africa")
  ) %>% 
  cols_label(
    country = "Country",
    total_covid_cases = "Count",
    percentage = "% of total cases in Northern Africa"
  ) %>% 
    tab_spanner(
    label = "Confirmed cases",
    columns = c(total_covid_cases,percentage)
  ) %>% 
    fmt_number(
    columns = total_covid_cases,
    decimals=0,
    use_seps = TRUE
  ) %>% 
   cols_align(
    align = "center",
    columns = c(total_covid_cases, percentage)
  ) 
northern_africa_cases_country_table


## ----------------------------------------------------------------------------------------------------------------------------------------------------------------
first_cases_africa <- africa_covid_cases_long %>% 
  select(date=date_format,region=AFRICAN_REGION, country=COUNTRY_NAME, cases) %>% 
  group_by(region,country) %>% 
  filter(cases>0) %>% 
  filter(date == min(date, na.rm=TRUE)) %>% 
  ungroup()

first_cases_africa_table <- first_cases_africa %>% 
  select(region,country,date) %>% 
  group_by(region) %>% 
  arrange(date) %>% 
gt() %>% 
  tab_header(
    title = md("When did countries in Africa record their first case of COVID-19?")
  ) %>% 
  fmt_date(
    columns = date,
    date_style = 4
  ) %>% 
  opt_all_caps() %>% 
  #Use the Chivo font
  #Note the great 'google_font' function in 'gt' that removes the need to pre-load fonts
  opt_table_font(
    font = list(
      google_font("Chivo"),
      default_fonts()
    )
  ) %>%
  cols_label(
    country = "Country",
    date = "Date"
  )  %>% 
  cols_align(
    align = "center",
    columns = c(country, date)
  ) %>% 
  tab_options(
    column_labels.border.top.width = px(3),
    column_labels.border.top.color = "transparent",
    table.border.top.color = "transparent",
    table.border.bottom.color = "transparent",
    data_row.padding = px(3),
    source_notes.font.size = 12,
    heading.align = "left",
    #Adjust grouped rows to make them stand out
    row_group.background.color = "grey") %>% 
  tab_source_note(source_note = "Data: Compiled from national governments and WHO by Humanitarian Emergency Response Africa (HERA)")

first_cases_africa_table

