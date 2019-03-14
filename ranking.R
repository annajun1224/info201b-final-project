library("dplyr")
library("ggplot2")
library("ggmap")
library("plotly")
library("knitr")

data <- read.csv("data/health.csv",  stringsAsFactors = FALSE)

county_impacted <- data %>%
  group_by(County) %>%
  filter(pct_obese == max(pct_obese)) %>%
  arrange(- pct_obese) %>%
  head(50) %>%
  select(State, County, pct_obese)
kable(county_impacted, col.names = c("State", "County", "Obesety Persentage"))

##DT::dataTableOutput("crimeType", width = "100%")   ui code

## filtered_data should be data I put above.
#output$crimeType <- DT::renderDataTable({
#  filtered_data <- large_map_set %>% select(Neighborhood, Occurred.Date, Occurred.Time, 
#                                            Crime.Subcategory, Primary.Offense.Description)
#  DT::datatable(filtered_data, options = list(pageLength = 10, scrollX = TRUE, scrollY = '450px')) %>% formatStyle(names(filtered_data))
#})