# ui.R
library(shiny)
library(plotly)
library(leaflet)
library(DT)
library(lubridate)
introductionTabPanel <- tabPanel(
  "Home",
  htmlOutput("homepage", container = div)
)

mapTabPanel <- tabPanel(
  "Restaurant Map",
  div(class="outer",
      tags$head(
        # Include our custom CSS
        includeCSS("map.css")
      ),
      
      # If not using custom CSS, set height of leafletOutput to a number instead of percent
      leafletOutput("map", width="100%", height="100%"),
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = "auto",
                    h3("Fast Food Restaurants"),
                    selectInput("restaurant_chain", "Fast Food Chain", choices=""),
                    # dataTableOutput("top_restaurant_list")
                    tags$label("Top 5 Fast Food Chains", class="control-label"),
                    tableOutput("top_restaurant_list"),
                    textInput("address_filter", label = tags$label("Addresses", class="control-label"), placeholder = "Enter address...", value = ""),
                    tableOutput("addresses")
      )
  )
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
              ),
                plotOutput("chngPlot", height = 550)
                
    )
  )
)
  


tablePanel <- tabPanel("Overall Data Comparison Table",
                       verticalLayout(
                         #plotOutput("crime_type_plot"),
                         #fluidRow(
                         # textOutput("summaryText"),
                         #   br(),
                         p("This is a comparison chart that places data from the previous graphic tab into a 
                           table for comparison. It includes poverty rates, restaurant count change, and 
                           obesity rates for 2009 and 2014"),
                         #),
                         hr(),
                         dataTableOutput("CountyInfo")
                         )
                       )


QATabPanel <- tabPanel(
  "Q&A",
  htmlOutput("QA", container = div)
)

ContactInfo <- tabPanel(
  "Contact Information",
  htmlOutput("Contact Information", container = div)
)

shinyUI(
  navbarPage(
    "Fast Food Restaurants in the U.S.",
    # Reads the global theme css from the www folder
    theme = "global.css",
    # Create a tab panel for your map
    introductionTabPanel,
    mapTabPanel,
    barChartPanel,
    tablePanel,
    QATabPanel,
    ContactInfo
  ))