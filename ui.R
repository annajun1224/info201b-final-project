# ui.R
library(shiny)
library(plotly)
source("plot.R")

# County <- selectInput(
#   "CountyChoice",
#   label = "County",
#   choices = county,
#   selected = "county"
# )
# 
# FastFood <- selectInput(
#   "FastFood",
#   label = "Fast food restaurants",
#   choices = Name,
#   selected = "Name"
# )

introductionTabPanel <- tabPanel(
  "Home",
  htmlOutput("homepage", container = div)
)

barChartPanel <- tabPanel(
  "Graphs",
  sidebarLayout(
    sidebarPanel(
      selectInput("stateChoice",
                  label = "State Selection",
                  choices = stateSelection,
                  selected = "NY"),
      selectInput("countyChoice",
                  label = "County Selection",
                  choices = "",
                  selected = "Bronx")),
    mainPanel(htmlOutput("feedback", 
                         align = "center"), 
              htmlOutput("data", 
                         align = "center"), 
              fluidRow(
                splitLayout(cellWidths = c("50%", "50%"), 
                            plotlyOutput("distribPie", height = 550),
                            plotlyOutput("racePie", height = 550)
                           )
             )
    )

  )
)

shinyUI(
  navbarPage(
  "Fast Food Restaurants in the U.S.",
  theme = "style.css",
  # Create a tab panel for your map
  introductionTabPanel,
  barChartPanel
  )
)