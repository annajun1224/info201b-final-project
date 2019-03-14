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
  "Ethnicity vs. Obesity & Diabetes",
  div(
    tags$head(
      # Include our custom CSS
      includeCSS("ethnicity.css")
    ),
    fluidRow(
      div(class="ethnicity_input",
          selectInput("stateChoice",
                      label = "Choose a State",
                      choices = "")),
      div(class="ethnicity_input",
        selectInput("countyChoice",
                    label = "Choose a County",
                    choices = ""))
    ),
    div(class="summary",
      htmlOutput("feedback", 
                 align = "center"), 
      htmlOutput("data", 
                 align = "center")), 
    div(class="pie-container",
      fluidRow(
        splitLayout(cellWidths = c("50%", "50%"), 
                    plotlyOutput("distribPie", height = 550),
                    plotlyOutput("racePie", height = 550)
        )
      )
    )
  )
)

tablePanel <- tabPanel("County Obesity Rate Rank",
                       verticalLayout(
                         #plotOutput("crime_type_plot"),
                         #fluidRow(
                         # textOutput("summaryText"),
                         #   br(),
                         p("We found out that population's health does effected by
               fast food restaurant. Here we build a table to show top 
               100 counties which has high obesity rate"),
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
  "ContactInformation",
  htmlOutput("ContactInformation", container = div)
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