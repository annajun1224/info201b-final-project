library("dplyr")
library("lubridate")
library("tidyr")
library("ggmap")
library("leaflet")
library("ggplot2")
library("reshape2")


countyObese <- read.csv("data/joined_data.csv", stringsAsFactors = F)

countyObese_plot <- function(data){
  data %>%
    ggplot(aes(x = County, y = pct_obese)) + 
    geom_bar(stat="identity") +
    geom_line(mapping = aes(x = County, 
                            y = pct_obese, 
                            group = 1), color = "red")+
    labs(x = "County", y = "Obesity rate of the county", 
         title = "Obesity rate over County") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}

restaurantSelections <- countyObese %>%
  select(name) %>%
  unique()

stateSelection <- countyObese %>%
  select(State) %>%
  unique()


restaurantByState <- countyObese %>%
  select(State, name) %>%
  filter

