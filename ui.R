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
                  selected = ""),
      selectInput("countyChoice",
        label = "County Selection",
                  choices = "",
                  selected = "")),
    mainPanel(plotOutput("plot"))
  ))

  


# populationMapTabPanel <- tabPanel(
#     "Home",
#     titlePanel("Population by Midwest States"),
#     # Create sidebar layout
#     sidebarLayout(

#       # Side panel for controls
#       sidebarPanel(

#         # Input to select variable to map
#         selectInput(
#           "popmap",
#           label = "Population by States",
#           choices = list(
#             "All Races" = "All Races",
#             "White" = "White",
#             "Black" = "Black",
#             "American Indian" = "American Indian",
#             "Asian" = "Asian",
#             "Other" = "Other"
#           )
#         ),

#         # Radio button group to select highlight colors
#         radioButtons(
#             "colors",
#             "Highlight Color:",
#             list(
#                 "Purple" = "Purples",
#                 "Red" = "Reds",
#                 "Gray" = "Greys"
#             )
#         )
#       ),

#       # Main panel: display plotly map
#       mainPanel(
#         plotlyOutput("map")
#       )
#     )
# )

# stateCountyDemographicsTabPanel <- tabPanel(
#     "State Chart",
#     titlePanel("Demographics by Individual State"),
    
#     # Create sidebar layout
#     sidebarLayout(

#       # Side panel for controls
#       sidebarPanel(

#         # Input to select a state
#         selectInput(
#           "selected_state",
#           label = "Select a State",
#           choices = list()
#         ),  
        
        
#         # Input to select a county
#         selectInput(
#           "selected_county",
#           label = "Select a County",
#           choices = list()
#         )
#       ),

#       # Main panel: display plotly map
#       mainPanel(
#         plotlyOutput("chart")
#       )
#     )
# )

shinyUI(
  navbarPage(
  "Fast Food Restaurants in the U.S.",
  theme = "style.css",
  # Create a tab panel for your map
  introductionTabPanel,
  barChartPanel
  # stateCountyDemographicsTabPanel

  # Create a tabPanel to show your scatter plot
#   tabPanel(
#     "Scatter",
#     # Add a titlePanel to your tab
#     titlePanel("Population v.s. Vote Power"),

#     # Create a sidebar layout for this tab (page)
#     sidebarLayout(

#       # Create a sidebarPanel for your controls
#       sidebarPanel(

#         # Make a textInput widget for searching for a state in your scatter plot
#         textInput("search", label = "Find a State", value = "")
#       ),

#       # Create a main panel, in which you should display your plotly Scatter plot
#       mainPanel(
#         plotlyOutput("scatter")
#       )
#     )
#   )
#     tabPanel("Analysis",
#          sidebarLayout(
#            sidebarPanel(
#              County,
#              FastFood,
#              checkboxInput("smooth", label = strong("Show Trendline"), value = TRUE)
#            ),
#            mainPanel(
#              h1("Number of Fast Food Restaurants in each County"),
#              plotOutput("FastFood_plot"))
#          )
# )




))