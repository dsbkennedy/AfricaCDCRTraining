## -----------------------------------------------------------------------------------------------------
pacman::p_load(gt)


## -----------------------------------------------------------------------------------------------------
northern_africa_cases_country_table <- northern_africa_cases_country %>% 
  gt() %>% 
   tab_header(
    title = md("COVID-19 in Northern Africa")
  ) %>% 
  cols_label(
    country = "Country",
    total_covid_cases = "N",
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


## -----------------------------------------------------------------------------------------------------
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


## -----------------------------------------------------------------------------------------------------
library(ggplot2)


## -----------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases)) +
  geom_line()


## -----------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line()


## -----------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  labs(x='Date', y='Total cases', color='Country') + #label axes
  theme(legend.position='top') + #place legend at top of graph
  scale_x_date(date_breaks = '2 months', #set x axis to have 2 month breaks
               date_minor_breaks = '1 month', #set x axis to have 1 month breaks
               date_labels = '%b-%y') #change label for x axis



## -----------------------------------------------------------------------------------------------------
ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  labs(x='Date', y='Total cases') + #label axes
  theme(legend.position='none') + #remove legend by setting position to 'none'
  scale_x_date(date_breaks = '4 months', #set x axis to have 2 month breaks
               date_minor_breaks = '2 months', #set x axis to have 1 month breaks
               date_labels = '%b-%y') + #change label for x axis
  facet_wrap(~country) # this will create a separate graph for each country


## -----------------------------------------------------------------------------------------------------
pacman::p_load(gghighlight)
highlight_country_morocco_gph <- ggplot(northern_africa, aes(x=date,y=cases, color=country)) +
  geom_line() +
  gghighlight::gghighlight(country == "Morocco") + #highlight data reported by Algeria
  labs(x='Date', y='Total cases') + #label axes
  theme(legend.position='none') + #remove legend by setting position to 'none'
  scale_x_date(date_breaks = '4 months', #set x axis to have 2 month breaks
               date_minor_breaks = '2 months', #set x axis to have 1 month breaks
               date_labels = '%b-%y')  #change label for x axis
 highlight_country_morocco_gph


## -----------------------------------------------------------------------------------------------------
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


## ----eval=FALSE, echo=TRUE----------------------------------------------------------------------------
## pacman::p_load(esquisse)
## esquisse::esquisser()


## -----------------------------------------------------------------------------------------------------
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


## -----------------------------------------------------------------------------------------------------
pacman::p_load(patchwork)

